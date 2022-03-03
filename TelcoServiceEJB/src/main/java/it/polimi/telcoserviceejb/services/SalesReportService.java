package it.polimi.telcoserviceejb.services;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.entities.ValidityPeriod;
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

    public Integer getTotalPurchasePerPackageAndVP(Integer idP, Integer idVP) throws ReportException {
        ServicePackage sp = null;
        ValidityPeriod vp = null;
        try {
            sp = em.find(ServicePackage.class, idP);
            vp = em.find(ValidityPeriod.class, idVP);
        }catch(PersistenceException e){
            throw new ReportException("Couldn't fetch service package");
        }
        if(!sp.getValidityPeriods().contains(vp)){
            throw new ReportException("Validity period not in service package");
        }

        Integer i = null;
        try{
            i = em.createNamedQuery("SalesReport.getTotalNumberPerPackageAndVP", Integer.class).setParameter(1, sp).setParameter(2, vp).getSingleResult();
        }catch (PersistenceException e){
            throw new ReportException("Cannot find service package");
        }

        return i != null ? i : 0;
    }

    public Double getValueNoOptionalProducts(Integer id) throws ReportException {
        ServicePackage sp = null;
        try {
            sp = em.find(ServicePackage.class, id);
        }catch(PersistenceException e){
            throw new ReportException("Couldn't fetch service package");
        }
        Double i = null;
        try{
            i = em.createNamedQuery("SalesReport.valueNoOptProducts", Double.class).setParameter(1, sp).getSingleResult();
        }catch (PersistenceException e){
            throw new ReportException("Cannot find service package");
        }

        return i != null ? i : 0;
    }

    public Double getValueWithOptionalProducts(Integer id) throws ReportException {
        Double j = getValueNoOptionalProducts(id);
        ServicePackage sp = null;
        try {
            sp = em.find(ServicePackage.class, id);
        }catch(PersistenceException e){
            throw new ReportException("Couldn't fetch service package");
        }
        Double i = null;
        try{
            i = em.createNamedQuery("SalesReport.valueWithOptProducts", Double.class).setParameter(1, sp).getSingleResult();
        }catch (PersistenceException e){
            throw new ReportException("Cannot find service package");
        }
        if(i == null) i = (double) 0;
        if(j == null) j = (double) 0;
        return  i + j;
    }

    public Double getAvgOptProduct(Integer id) throws ReportException {
        ServicePackage sp = null;
        try {
            sp = em.find(ServicePackage.class, id);
        }catch(PersistenceException e){
            throw new ReportException("Couldn't fetch service package");
        }
        Double i = null;
        try{
            i = em.createNamedQuery("SalesReport.avgNumberOfOpt", Double.class).setParameter(1, sp).getSingleResult();
        }catch (PersistenceException e){
            throw new ReportException("Cannot find service package");
        }

        return i;
    }
}
