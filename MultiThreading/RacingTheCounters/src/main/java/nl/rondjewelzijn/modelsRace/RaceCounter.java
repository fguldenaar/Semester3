package nl.rondjewelzijn.modelsRace;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RaceCounter implements Runnable{

    private static Logger logger = LoggerFactory.getLogger(RaceCounter.class);
    private int count = 1;


    public void startRaceCounter(){
        System.out.println(Thread.currentThread().getName() + ": "+ count);
        count++;
    }

    @Override
    public synchronized void run() {
        long startTime = System.currentTimeMillis();
        while (count < 101){
            startRaceCounter();
        }

        long endTime = System.currentTimeMillis();
        logger.info(Thread.currentThread().getName() + " ended in {} ms", endTime - startTime);

    }
}
