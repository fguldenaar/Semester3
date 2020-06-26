package nl.rondjewelzijn.modelsReeterandLock;

import nl.rondjewelzijn.interfaces.IThread;

public class RelockThread implements IThread {

    public void startTreads() {
        this.threads();
    }

    @Override
    public void threads() {
        //Create number of threads
        for (int threadNumber = 0; threadNumber < 5; threadNumber++) {
            Thread t = new Thread(new RelockCounter());
            System.out.println("Started: " + t.getName());
            t.start();
        }
    }
}
