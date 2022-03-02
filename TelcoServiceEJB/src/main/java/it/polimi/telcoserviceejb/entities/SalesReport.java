package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;

@Entity
@Table(name = "sales_report")
@NamedQueries({@NamedQuery(name = "SalesReport.getTotalNumberPerPackage", query = "SELECT SUM(sr.numberOfPurchases) FROM SalesReport sr WHERE sr.idServicePackage = ?1 "),
                @NamedQuery(name = "SalesReport.getTotalNumberPerPackageAndVP", query = "SELECT sr.numberOfPurchases FROM SalesReport sr WHERE sr.idServicePackage = ?1 AND sr.idValidityPeriod = ?2 "),
                @NamedQuery(name="SalesReport.valueNoOptProducts", query = "SELECT SUM(sr.valueNoOptProducts) FROM SalesReport sr WHERE sr.idServicePackage = ?1 "),
                @NamedQuery(name="SalesReport.valueWithOptProducts", query = "SELECT SUM(sr.valueOfOptProducts) FROM SalesReport sr WHERE sr.idServicePackage = ?1 "),
}
)
public class SalesReport {
    @EmbeddedId
    private SalesReportId id;

    @MapsId("idServicePackage")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_service_package", nullable = false)
    private ServicePackage idServicePackage;

    @MapsId("idValidityPeriod")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_validity_period", nullable = false)
    private ValidityPeriod idValidityPeriod;

    @Column(name = "number_of_purchases")
    private Integer numberOfPurchases;

    @Column(name = "value_no_opt_products")
    private Double valueNoOptProducts;

    @Column(name = "number_opt_products")
    private Integer numberOptProducts;

    @Column(name = "value_of_opt_products")
    private Double valueOfOptProducts;

    public Double getValueOfOptProducts() {
        return valueOfOptProducts;
    }

    public void setValueOfOptProducts(Double valueOfOptProducts) {
        this.valueOfOptProducts = valueOfOptProducts;
    }

    public Integer getNumberOptProducts() {
        return numberOptProducts;
    }

    public void setNumberOptProducts(Integer numberOptProducts) {
        this.numberOptProducts = numberOptProducts;
    }

    public Double getValueNoOptProducts() {
        return valueNoOptProducts;
    }

    public void setValueNoOptProducts(Double valueNoOptProducts) {
        this.valueNoOptProducts = valueNoOptProducts;
    }

    public Integer getNumberOfPurchases() {
        return numberOfPurchases;
    }

    public void setNumberOfPurchases(Integer numberOfPurchases) {
        this.numberOfPurchases = numberOfPurchases;
    }

    public ValidityPeriod getIdValidityPeriod() {
        return idValidityPeriod;
    }

    public void setIdValidityPeriod(ValidityPeriod idValidityPeriod) {
        this.idValidityPeriod = idValidityPeriod;
    }

    public ServicePackage getIdServicePackage() {
        return idServicePackage;
    }

    public void setIdServicePackage(ServicePackage idServicePackage) {
        this.idServicePackage = idServicePackage;
    }

    public SalesReportId getId() {
        return id;
    }

    public void setId(SalesReportId id) {
        this.id = id;
    }
}