package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;
import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "`order`")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_order", nullable = false)
    private Integer id;

    @Column(name = "total_value")
    private Double totalValue;

    @Column(name = "status", length = 45)
    private String status;

    @Column(name = "number_of_failed_payment")
    private Integer numberOfFailedPayment;

    @Column(name = "start_date_sub")
    private Instant startDateSub;

    @Column(name = "creation_date")
    private Instant creationDate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_user")
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_service_package")
    private ServicePackage servicePackage;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_val_period")
    private ValidityPeriod validityPeriod;

    @ManyToMany
    @JoinTable(name = "optional_product-order",
            joinColumns = @JoinColumn(name = "id_order"),
            inverseJoinColumns = @JoinColumn(name = "id_optional_product"))
    private List<OptionalProduct> optionalProducts;

    public Order(Double totalValue, String status, Integer numberOfFailedPayment, Instant startDateSub, Instant creationDate, User user, ServicePackage servicePackage, ValidityPeriod validityPeriod, List<OptionalProduct> optionalProducts) {
        this.totalValue = totalValue;
        this.status = status;
        this.numberOfFailedPayment = numberOfFailedPayment;
        this.startDateSub = startDateSub;
        this.creationDate = creationDate;
        this.user = user;
        this.servicePackage = servicePackage;
        this.validityPeriod = validityPeriod;
        this.optionalProducts = optionalProducts;
    }

    public Order() {

    }

    public List<OptionalProduct> getOptionalProducts() {
        return optionalProducts;
    }

    public void setOptionalProducts(List<OptionalProduct> optionalProducts) {
        this.optionalProducts = optionalProducts;
    }

    public ValidityPeriod getValidityPeriod() {
        return validityPeriod;
    }

    public void setValidityPeriod(ValidityPeriod validityPeriod) {
        this.validityPeriod = validityPeriod;
    }

    public ServicePackage getServicePackage() {
        return servicePackage;
    }

    public void setServicePackage(ServicePackage servicePackage) {
        this.servicePackage = servicePackage;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Instant getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Instant creationDate) {
        this.creationDate = creationDate;
    }

    public Instant getStartDateSub() {
        return startDateSub;
    }

    public void setStartDateSub(Instant startDateSub) {
        this.startDateSub = startDateSub;
    }

    public Integer getNumberOfFailedPayment() {
        return numberOfFailedPayment;
    }

    public void setNumberOfFailedPayment(Integer numberOfFailedPayment) {
        this.numberOfFailedPayment = numberOfFailedPayment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Double getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(Double totalValue) {
        this.totalValue = totalValue;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}