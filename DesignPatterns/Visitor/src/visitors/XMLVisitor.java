package visitors;

import model.Bioscoop;
import model.Kapsalon;
import model.School;

public class XMLVisitor implements IVisitor {
    @Override
    public void visitKapsalon(Kapsalon kapsalon) {
        System.out.println(String.format("<kapsalon>\n" +
                "   <naam>%s</naam>\n" +
                "   <aantalBezoekers>%o</aantalBezoekers>\n" +
                "</kapsalon>\n", kapsalon.pakNaam(), kapsalon.getAantalBezoekers()));
    }

    @Override
    public void visitBioscoop(Bioscoop bioscoop) {
        System.out.println(String.format("<bioscoop>\n" +
                "   <naam>%s</naam>\n" +
                "   <isOpen>%b</isOpen>\n" +
                "</bioscoop>\n", bioscoop.pakNaam(), bioscoop.getIsOpen()));

    }

    @Override
    public void visitSchool(School school) {
        System.out.println(String.format("<school>\n" +
                "   <naam>%s</naam>\n" +
                "   <maxAge>%o</maxAge>\n" +
                "</school>\n", school.pakNaam(), school.getMaxAge()));

    }
}
