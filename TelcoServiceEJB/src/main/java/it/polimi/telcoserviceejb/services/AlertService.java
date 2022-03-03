package it.polimi.telcoserviceejb.services;


import it.polimi.telcoserviceejb.entities.Alert;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.text.ParseException;
import java.util.List;

@Stateless
public class AlertService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public AlertService(){}

    public List<Alert> getAllAlerts() throws Exception {
        List<Alert> alerts = null;
        try{
            alerts = em.createNamedQuery("Alert.findAll", Alert.class).getResultList();
        }catch(PersistenceException e){
            throw new Exception("Couldn't load data");
        }
        return alerts;
    }


}
