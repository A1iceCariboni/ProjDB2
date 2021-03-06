package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.Service;
import it.polimi.telcoserviceejb.exceptions.ProductException;
import it.polimi.telcoserviceejb.exceptions.ServiceException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.List;

@Stateless
public class ServiceService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;


    public ServiceService() {
    }

    public List<Service> getAllServices() throws ServiceException {
        List<Service> s = null;
        try{
            s = em.createNamedQuery("Service.findAll", Service.class).getResultList();
        }catch (PersistenceException e){
            throw new ServiceException("Cannot load services");
        }

        return s;
    }
}
