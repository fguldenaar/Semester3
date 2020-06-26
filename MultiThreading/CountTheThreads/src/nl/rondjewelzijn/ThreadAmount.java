package nl.rondjewelzijn;

public class ThreadAmount {

    public void startTreads(){
        // Amount Threads
        for(int threadNumber = 0; threadNumber < 5; threadNumber++){
            Thread t = new Thread(new MultiThreadCounter());
            System.out.println("Started: " + t.getName());
            t.start();
        }
    }
}
