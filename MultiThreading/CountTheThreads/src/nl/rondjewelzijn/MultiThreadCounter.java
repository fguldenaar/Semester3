package nl.rondjewelzijn;

import java.util.concurrent.locks.ReentrantLock;

public class MultiThreadCounter implements Runnable{
    private int counter = 1;
    ReentrantLock reentrantLock = new ReentrantLock(false);
    //True: Fastest thread enters the lock(); first. Threads have an equal chance.
    //False: Faster throughput of threads. Possible thread starvation(Thread is unable to gain regular access).

    //Threads share the same lock. Threads cannot run at the same time.
    //static ReentrantLock lockCount = new ReentrantLock(true);

    public MultiThreadCounter() {

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
        long runTime = endTime - startTime;
        System.out.println("Done: " + runTime + "ms");

    }
}
