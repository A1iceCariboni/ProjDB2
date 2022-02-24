package it.polimi.telcoserviceejb.services;
import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.exceptions.CredentialsException;
import it.polimi.telcoserviceejb.exceptions.RegistrationException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.List;

@Stateless
public class UserService {
    @PersistenceContext(unitName = "TelcoServiceEJB")
    private EntityManager em;

    public UserService(){
    }

    public User findUserByUsername(String username){
        User user = em.find(User.class, username);
        return user;
    }

    public void createUser(String username, String email, String password) throws RegistrationException {
         List<User> users = em.createNamedQuery("User.getUserByUsername", User.class).setParameter(1, username).getResultList();
         if(users.isEmpty()) {
             User user = new User(username, email, password);
             em.persist(user);
         }else{
             throw new RegistrationException("A user with this username already exists");
         }
    }

    public User checkCredentials(String usrn, String pwd) throws CredentialsException, NonUniqueResultException {
        List<User> uList = null;
        try {
            uList = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, usrn).setParameter(2, pwd)
                    .getResultList();
        } catch (PersistenceException e) {
            throw new CredentialsException("Could not verify credentals");
        }
        if (uList.isEmpty())
            return null;
        else if (uList.size() == 1)
            return uList.get(0);
        throw new NonUniqueResultException("More than one user registered with same credentials");

    }
}
