package visitors;

import model.Bioscoop;
import model.Kapsalon;
import model.School;

public interface IVisitor {
    void visitKapsalon(Kapsalon kapsalon);

    void visitBioscoop(Bioscoop bioscoop);

    void visitSchool(School school);
}
