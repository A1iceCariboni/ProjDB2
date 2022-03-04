package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.Service;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.entities.ValidityPeriod;
import it.polimi.telcoserviceejb.exceptions.ServiceException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class ServicePackageService {
    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public ServicePackageService() {
    }

    public void createServicePackage(String name, List<Integer> valPerIds, List<Integer> opProdIds, List<Integer> servIds) throws ServiceException {
        List<ValidityPeriod> validityPeriods = new ArrayList<>();
        ValidityPeriod vp;
        for(int i : valPerIds){
            try {
                vp = em.find(ValidityPeriod.class, i);
            }catch(PersistenceException e){
                throw new ServiceException("Couldn't fetch validity period");
            }
            validityPeriods.add(vp);
        }
        List<OptionalProduct> optionalProducts = new ArrayList<>();
        OptionalProduct op;
        for(int i : opProdIds){
            try {
                op = em.find(OptionalProduct.class, i);
            }catch(PersistenceException e){
                throw new ServiceException("Couldn't fetch optional product");
            }
            optionalProducts.add(op);
        }
        List<Service> services = new ArrayList<>();
        Service s;
        for(int i : servIds){
            try {
                s = em.find(Service.class, i);
            }catch(PersistenceException e){
                throw new ServiceException("Couldn't fetch service");
            }
            services.add(s);
        }
        ServicePackage sp = new ServicePackage(name, validityPeriods, optionalProducts, services);
        em.persist(sp);
    }

    public List<ServicePackage> getAllServicePackage() throws ServiceException {
        List<ServicePackage> sp = null;
        try {
            sp = em.createNamedQuery("ServicePackage.findAll", ServicePackage.class).getResultList();
        } catch (PersistenceException e) {
            throw new ServiceException("Cannot load service packages");
        }

        return sp;
    }

    public ServicePackage getServicePackageById(Integer id_service_package) throws ServiceException {
        ServicePackage sp = null;
        try {
            sp = em.createNamedQuery("ServicePackage.findById", ServicePackage.class).setParameter(1, id_service_package)
                    .getResultList().get(0);
        } catch (PersistenceException | IndexOutOfBoundsException e) {
            throw new ServiceException("Cannot load service packages");
        }

        return sp;
    }
}
