package nl.rondjewelzijn.modelsRace;

import nl.rondjewelzijn.interfaces.IThread;

public class RaceThread implements IThread {

    public void startTreads() {
        this.threads();
    }

    @Override
    public void threads() {

        for (int runnableNumber = 1; runnableNumber <=5; runnableNumber++) {
            Runnable r = new RaceCounter();

            //Create number of threads
            for (int threadNumber = 1; threadNumber <=5; threadNumber++) {
                Thread t = new Thread(r);
                System.out.println("Started: " + t.getName());
                t.start();
            }
        }
    }
}

