package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.*;
import it.polimi.telcoserviceejb.exceptions.ProductException;
import it.polimi.telcoserviceejb.exceptions.ServiceException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Stateless
public class OrderService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public OrderService() {
    }

    public void createOrder(String status, Integer id_user, Integer id_service_package, Integer id_validity_period, List<Integer> optionalProducts, Date start_date_subscription) throws ServiceException {
        Order o = new Order();

        o.setStatus(status);

        // linking user
        try {
            o.setUser(em.find(User.class, id_user));
        } catch (PersistenceException e) {
            throw new ServiceException("Couldn't fetch User");
        }

        // linking service package
        try {
            o.setServicePackage(em.find(ServicePackage.class, id_service_package));
        } catch (PersistenceException e) {
            throw new ServiceException("Couldn't fetch Service Package");
        }

        // linking validity period
        try {
            o.setValidityPeriod(em.find(ValidityPeriod.class, id_validity_period));
        } catch (PersistenceException e) {
            throw new ServiceException("Couldn't fetch Validity Period");
        }

        // linking starting subscription date
        o.setStartDateSub(new Timestamp(start_date_subscription.getTime()));

        /*// linking optional products
        try {
            if(optionalProducts.isEmpty()){
                o.setOptionalProducts(new ArrayList<>());
            } else {
                List<OptionalProduct> l = new ArrayList<>();
                for(int id : optionalProducts){
                    l.add(em.find(OptionalProduct.class, id));
                }
                o.setOptionalProducts(l);
            }
        } catch (PersistenceException e) {
            throw new ServiceException("Couldn't fetch Optional Products");
        }*/

        em.persist(o);
    }

    public List<OptionalProduct> getAllOptionalProduct() throws ProductException {
        List<OptionalProduct> ops = null;
        try {
            ops = em.createNamedQuery("OptionalProduct.findAll", OptionalProduct.class).getResultList();
        } catch (PersistenceException e) {
            throw new ProductException("Cannot load optional products");
        }

        return ops;
    }

    public List<Order> getSuspended(){
        List<Order> orders = null;
        try{
            orders = em.createNamedQuery("Order.getSuspended", Order.class).getResultList();
        }catch (PersistenceException ignored){
        }
        return orders;
    }

}
