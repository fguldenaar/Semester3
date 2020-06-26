package nl.rondjewelzijn.modelsReeterandLock;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.locks.ReentrantLock;

public class RelockCounter implements Runnable{

    private static Logger logger = LoggerFactory.getLogger(RelockCounter.class);
    private int counter = 1;
    ReentrantLock reentrantLock = new ReentrantLock(true);
    //True: Fastest thread enters the lock(); first. Threads have an equal chance.
    //False: Faster throughput of threads. Possible thread starvation(Thread is unable to gain regular access).

    //Threads share the same lock. Threads cannot run at the same time.
    //static ReentrantLock lockCount = new ReentrantLock(true);

    public RelockCounter() {

    }

    public void startMultiThreadCounter(){
        reentrantLock.lock();

        try{
            System.out.println(Thread.currentThread().getName() + ": " + counter);
            counter++;

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            reentrantLock.unlock();
        }
    }

    @Override
    public void run() {
        long startTime = System.currentTimeMillis();
        while (counter <101){
            startMultiThreadCounter();
        }

        long endTime = System.currentTimeMillis();
        logger.info(Thread.currentThread().getName() + " ended in {} ms", endTime - startTime);

    }
}
