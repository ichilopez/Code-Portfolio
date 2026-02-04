import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
public class Disco {
	 public static void main(String[] args) throws FileNotFoundException {
	        Scanner sc = new Scanner(System.in);
	        // Solicitar el primer número
	        System.out.print("Enter the path of your textfile which contains the following information:");
	        System.out.print("The first line must have the capacity of the disco.");
	        System.out.print("The second line must have the number of clients that will be created (M).");
	        System.out.println("The following M lines will take the values 1 or 0 indicating wether that client is vip (1) or not(0)");
	        String path =sc.nextLine();
	        Scanner scanner = new Scanner(new File(path));
	        int N= scanner.nextInt();//capacity of the disco
	        int M = scanner.nextInt();//number of clients that the program will have to create
	        Client.N=N;//we update the capacity of the disco
	        for(int i=0;i<M;i++) {//we create M thread (clients)
	        	Client c= new Client(scanner.nextInt()==1,i+1);
	        	c.start();
	        }
	        sc.close();
	        scanner.close();
	    }
}
