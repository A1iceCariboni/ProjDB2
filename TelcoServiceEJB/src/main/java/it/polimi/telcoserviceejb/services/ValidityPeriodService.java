package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.ValidityPeriod;
import it.polimi.telcoserviceejb.exceptions.ServiceException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.List;

@Stateless
public class ValidityPeriodService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;


    public ValidityPeriodService() {
    }

    public List<ValidityPeriod> getAllValidityPeriod() throws ServiceException {
        List<ValidityPeriod> vp = null;
        try {
            vp = em.createNamedQuery("ValidityPeriod.findAll", ValidityPeriod.class).getResultList();
        } catch (PersistenceException e) {
            throw new ServiceException("Cannot load validityPeriods");
        }

        return vp;
    }

    public ValidityPeriod getValidityPeriodById(Integer id_validity_period) throws ServiceException {
        ValidityPeriod vp = null;
        try {
            vp = em.createNamedQuery("ValidityPeriod.findById", ValidityPeriod.class)
                    .setParameter(1, id_validity_period).getResultList().get(0);
        } catch (PersistenceException e) {
            throw new ServiceException("Cannot load validityPeriod");
        }

        return vp;
    }
}