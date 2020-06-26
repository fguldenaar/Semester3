package visitors;

import model.Bioscoop;
import model.Kapsalon;
import model.School;

public class JSONVisitor implements IVisitor {

    @Override
    public void visitKapsalon(Kapsalon kapsalon) {
        System.out.println(String.format("{ \n" +
                "   naam: \"%s\",\n" +
                "   aantalBezoekers: %o\n" +
                "}", kapsalon.pakNaam(), kapsalon.getAantalBezoekers()));
    }

    @Override
    public void visitBioscoop(Bioscoop bioscoop) {
        System.out.println(String.format("{ \n" +
                "   naam: \"%s\",\n" +
                "   isOpen: %b\n" +
                "}", bioscoop.pakNaam(), bioscoop.getIsOpen()));


    }

    @Override
    public void visitSchool(School school) {
        System.out.println(String.format("{ \n" +
                "   naam: \"%s\",\n" +
                "   leeftijd: %o\n" +
                "}", school.pakNaam(), school.getMaxAge()));

    }
}
