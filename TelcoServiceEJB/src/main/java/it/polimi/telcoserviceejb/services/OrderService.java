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

    public Integer createOrder(String status, Integer id_user, Integer id_service_package, Integer id_validity_period, List<Integer> optionalProducts, Date start_date_subscription) throws ServiceException {
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

        // linking optional products
        try {
            if (optionalProducts == null || optionalProducts.isEmpty()) {
                o.setOptionalProducts(new ArrayList<>());
            } else {
                List<OptionalProduct> l = new ArrayList<>();
                for (int id : optionalProducts) {
                    l.add(em.find(OptionalProduct.class, id));
                }
                o.setOptionalProducts(l);
            }
        } catch (PersistenceException e) {
            throw new ServiceException("Couldn't fetch Optional Products");
        }

        em.persist(o);
        em.flush();
        em.refresh(o);
        return o.getId();
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

    public List<Order> getSuspended() throws Exception {
        List<Order> orders = null;
        try {
            orders = em.createNamedQuery("Order.getSuspended", Order.class).getResultList();
        } catch (PersistenceException e) {
            throw new Exception("Couldn't load data");
        }
        return orders;
    }

    public List<Order> getSuspendedByUser(Integer id) throws Exception {
        List<Order> orders = null;
        try {
            orders = em.createNamedQuery("Order.getSuspendedByUser", Order.class).setParameter(1, id).getResultList();
        } catch (PersistenceException e) {
            throw new Exception("Couldn't load data");
        }
        return orders;
    }

    public Order getOrderById(int id_order) throws PersistenceException, IndexOutOfBoundsException {
        try {
            Order order = em.createNamedQuery("Order.getOrderById", Order.class).setParameter(1, id_order)
                    .getResultList().get(0);
            System.out.println(order);
            em.refresh(order);
            return order;
        } catch (PersistenceException | IndexOutOfBoundsException e) {
            throw new PersistenceException("Couldn't load data");
        }
    }

    public void changeStatus(int id_order, String status_payment, int id_user) throws PersistenceException, ServiceException {
        Order order = getOrderById(id_order);
        if(order.getUser().getId() != id_user){
            throw new ServiceException("You can't update an order that doesn't belong to you");
        }

        if(order.getStatus().equals("approved")){
            throw new PersistenceException("Incoherent data to be sent");
        } else {
            if(status_payment.equals("approved")){
                order.setStatus(status_payment);
            } else if(status_payment.equals("rejected")) {
                order.setTimeLastRejection(new Date(System.currentTimeMillis()));
            } else {
                throw new PersistenceException("Wrong status update");
            }
        }
    }

    public List<Order> getOrdersPerUser(Integer id_user) throws PersistenceException{
        List<Order> orders = null;
        try {
            orders = em.createNamedQuery("Order.getOrdersPerUser", Order.class).setParameter(1, id_user)
                    .getResultList();
        } catch (PersistenceException e) {
            throw new PersistenceException("Couldn't load data");
        }
        return orders;
    }
}
