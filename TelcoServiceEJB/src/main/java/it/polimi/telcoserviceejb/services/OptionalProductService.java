package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.exceptions.ProductException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.List;

@Stateless
public class OptionalProductService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public OptionalProductService() {
    }

    public void createOptionalProduct(String name, Integer monthlyfee){
        OptionalProduct op = new OptionalProduct(name, monthlyfee);
        em.persist(op);
    }

    public List<OptionalProduct> getAllOptionalProduct() throws ProductException{
        List<OptionalProduct> ops = null;
        try{
            ops = em.createNamedQuery("OptionalProduct.findAll", OptionalProduct.class).getResultList();
        }catch (PersistenceException e){
            throw new ProductException("Cannot load optional products");
        }

        return ops;
    }

}
