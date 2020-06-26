package nl.rondjewelzijn;


import nl.rondjewelzijn.modelsRace.RaceThread;
import nl.rondjewelzijn.modelsReeterandLock.RelockThread;

public class Main {

    public static void main(String[] args) {
        RaceThread raceThread = new RaceThread();

        new Menu(raceThread, new RelockThread()).showMenu();

        }
    }

