package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.exceptions.ReportException;
import it.polimi.telcoserviceejb.exceptions.ServiceException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

@Stateless
public class SalesReportService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public SalesReportService(){}

    public Long getTotalPurchasePerPackage(Integer id) throws ReportException {
        ServicePackage sp = null;
        try {
            sp = em.find(ServicePackage.class, id);
        }catch(PersistenceException e){
            throw new ReportException("Couldn't fetch service package");
        }
        Long i = null;
        try{
           i = em.createNamedQuery("SalesReport.getTotalNumberPerPackage", Long.class).setParameter(1, sp).getSingleResult();
        }catch (PersistenceException e){
            throw new ReportException("Cannot find service package");
        }

        return i != null ? i : 0;
    }


}
