package nl.rondjewelzijn;

import nl.rondjewelzijn.modelsRace.RaceThread;
import nl.rondjewelzijn.modelsReeterandLock.RelockThread;

import java.util.Scanner;

public class Menu {

    private final RaceThread raceThread;
    private final RelockThread relockThread;

    public Menu(RaceThread raceThread, RelockThread relockThread) {
        this.raceThread = raceThread;
        this.relockThread = relockThread;
    }

    public void showMenu() {

        System.out.println("Select option");
        System.out.println("[1] Race");
        System.out.println("[2] ReentrantLock");

        Scanner scanner = new Scanner(System.in);
        int optionN = Integer.parseInt(scanner.nextLine());

        if (optionN == 1) {
            raceThread.startTreads();
        } else if (optionN == 2) {
            relockThread.startTreads();
        } else {
            System.exit(0);
        }
    }
}
