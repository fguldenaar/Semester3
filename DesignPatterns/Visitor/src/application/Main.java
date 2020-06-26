package application;

import model.Bioscoop;
import model.Kapsalon;
import model.School;
import visitors.IVisitor;
import visitors.JSONVisitor;
import visitors.XMLVisitor;

public class Main {
    public static void main(String[] args) {

        Kapsalon kapsalon = new Kapsalon();
        Bioscoop bioscoop = new Bioscoop();
        School school = new School();

        IVisitor jsonVisitor = new JSONVisitor();
        IVisitor xmlVisitor = new XMLVisitor();

        System.out.println("\n ---JSON---");
        kapsalon.accepteren(jsonVisitor);
        System.out.println("\n ---XML---");
        kapsalon.accepteren(xmlVisitor);
        bioscoop.accepteren(xmlVisitor);
        school.accepteren(xmlVisitor);

    }
}

