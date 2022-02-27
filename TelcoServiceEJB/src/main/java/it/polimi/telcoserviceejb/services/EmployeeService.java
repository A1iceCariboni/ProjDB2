package it.polimi.telcoserviceejb.services;


import it.polimi.telcoserviceejb.entities.Employee;
import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.exceptions.CredentialsException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.List;

@Stateless
public class EmployeeService {

    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public EmployeeService(){
    }

    public Employee checkCredentials(String usrn, String pwd) throws CredentialsException, NonUniqueResultException {
        List<Employee> eList = null;
        try {
            eList = em.createNamedQuery("Employee.checkCredentials", Employee.class).setParameter(1, usrn).setParameter(2, pwd)
                    .getResultList();
        } catch (PersistenceException e) {
            throw new CredentialsException("Could not verify credentals");
        }
        if (eList.isEmpty())
            return null;
        else if (eList.size() == 1)
            return eList.get(0);
        throw new NonUniqueResultException("More than one user registered with same credentials");

    }
}
