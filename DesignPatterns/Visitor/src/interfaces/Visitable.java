package interfaces;

import visitors.IVisitor;

public interface Visitable {
    String pakNaam();
    void accepteren(IVisitor visitor);
}
