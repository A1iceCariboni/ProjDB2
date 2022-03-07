package it.polimi.telcoserviceejb.entities;
import java.sql.Timestamp;
import javax.persistence.*;
import java.time.Instant;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "`order`")
@NamedQueries({@NamedQuery(name = "Order.getSuspended", query = "SELECT o FROM Order o WHERE o.status = 'rejected' OR o.status = 'waiting'"),
        @NamedQuery(name = "Order.getSuspendedByUser", query = "SELECT o FROM Order o WHERE (o.status = 'rejected' OR o.status = 'waiting') AND o.user.id_user = ?1 "),
        @NamedQuery(name = "Order.getOrderById", query = "SELECT o FROM Order o WHERE o.id = ?1"),
        @NamedQuery(name = "Order.getOrdersPerUser", query = "SELECT o FROM Order o WHERE o.user.id_user = ?1")})
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_order", nullable = false)
    private Integer id;

    @Column(name = "total_value")
    private Float totalValue;

    @Column(name = "status", length = 45)
    private String status;

    @Column(name = "time_last_rejection")
    private Date timeLastRejection;

    @Column(name = "number_of_failed_payments")
    private Integer numberOfFailedPayment;

    @Column(name = "start_date_sub")
    private Date startDateSub;

    @Column(name = "creation_date")
    private Timestamp creationDate;

    @ManyToOne(fetch = FetchType.LAZY,
            cascade = {CascadeType.REFRESH})
    @JoinColumn(name = "id_user")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY,
            cascade = {CascadeType.REFRESH})
    @JoinColumn(name = "id_service_package")
    private ServicePackage servicePackage;

    @ManyToOne(fetch = FetchType.LAZY,
            cascade = {CascadeType.REFRESH})
    @JoinColumn(name = "id_validity_period")
    private ValidityPeriod validityPeriod;

    @ManyToMany(fetch = FetchType.LAZY,
            cascade = {CascadeType.REFRESH})
    @JoinTable(name = "optional_product__order",
            joinColumns = @JoinColumn(name = "id_order"),
            inverseJoinColumns = @JoinColumn(name = "id_optional_product"))
    private List<OptionalProduct> optionalProducts;

    public Order(Float totalValue, String status,Date timeLastRejection, Integer numberOfFailedPayment, Date startDateSub, Timestamp creationDate, User user, ServicePackage servicePackage, ValidityPeriod validityPeriod, List<OptionalProduct> optionalProducts) {
        this.totalValue = totalValue;
        this.status = status;
        this.timeLastRejection = timeLastRejection;
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

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public Date getStartDateSub() {
        return startDateSub;
    }

    public void setStartDateSub(Date startDateSub) {
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

    public Float getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(Float totalValue) {
        this.totalValue = totalValue;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", totalValue=" + totalValue +
                ", status='" + status + '\'' +
                ", numberOfFailedPayment=" + numberOfFailedPayment +
                ", startDateSub=" + startDateSub +
                ", creationDate=" + creationDate +
                ", user=" + user +
                ", servicePackage=" + servicePackage +
                ", validityPeriod=" + validityPeriod +
                ", optionalProducts=" + optionalProducts +
                '}';
    }

    public Date getTimeLastRejection() {
        return timeLastRejection;
    }

    public void setTimeLastRejection(Date timeLastRejection) {
        this.timeLastRejection = timeLastRejection;
    }
}