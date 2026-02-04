
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.Condition;
import java.util.Random;

public class Client extends Thread{
	private boolean vip;//it indicates if it is vip(1) or not(0)
	private int id;// identificator of the client that corrersponds with the order of creation
	public static int N;//capacity of the disco
	private static int num_per=0;//number of persons in the disco
	private static int num_vips_q=0;//number of persons in the queue of vips
	private static Lock mutex= new ReentrantLock();//will protect the variables 'num_per' and 'num_vips' 
	private static Condition q_vips=mutex.newCondition();// this conditional variable will be use for controlling the queue of vips clients
	private static Condition  q_clients=mutex.newCondition();// this conditional variable will be used for controlling the queue of normal clients.
	
	public Client (boolean vip, int id) {
		this.vip=vip;
		this.id=id;
	}
	public void enter_normal_client() throws InterruptedException {
		mutex.lock();
		System.out.println("The client " +id + " is waiting for getting in the disco");
		while(num_per== N || num_vips_q>0) q_clients.await();//if the disco has full capacity or if there are some vips in the queue we have to wait
		System.out.println("The client " +id + " has just entered in the disco");
		num_per++;//we increase the number of persons in the disco
		mutex.unlock();
	}
	public void enter_vip_client() throws InterruptedException {
		mutex.lock();
		System.out.println("The vip client " +id + " is waiting for getting in the disco");
		num_vips_q++;//we increase the number of persons in the queue of vips
		while(num_per== N) q_vips.await();//if the disco has reached his capacity we wait
		num_per++;//we increase the number of persons in the disco
		num_vips_q--;//we dicrease the number of persons in the queue of vips
		if(num_vips_q==0 && num_per<N)q_clients.signal();//if there are not more vips left in this moment the normal clients may be able to enter so we wake them up
		mutex.unlock();
		System.out.println("The vip client " +id + " has just entered in the disco");
	}
	public void dance() throws InterruptedException {
		System.out.println("The client "+ id + " is dancing in the disco ");
		int m_seconds=new Random().nextInt(3) + 1;// we will put into sleep the thread one random number of seconds between 1 and 3 seconds
		m_seconds=m_seconds*1000;//we convert second in miliseconds
		Thread.sleep(m_seconds);// we put the thread into sleep
	}
	
	public void exit_client() {
		mutex.lock();
		System.out.println("The client " +id + " got out of  the disco");
		num_per--;// we decrease the number of persons
		if(num_vips_q>0)q_vips.signal();// if there are vips in the queue we notify them
		else q_clients.signal();
		mutex.unlock();
	}
	@Override
	public void run() {
		try{
		if(vip)enter_vip_client();
		else enter_normal_client();
		dance();
		exit_client();
		}catch(InterruptedException e) {}
	}
	

}
