package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;

@Entity
@Table(name = "optional_products_report")
@NamedQueries({@NamedQuery(name = "OptionalProductReport.findMax", query = "SELECT op FROM OptionalProductsReport op WHERE op.totalRevenue >= (SELECT MAX(o.totalRevenue) FROM OptionalProductsReport o)")})
public class OptionalProductsReport {
    @Id
    @Column(name = "id_optional_product", nullable = false)
    private Integer id;

    @MapsId
    @OneToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "id_optional_product", nullable = false)
    private OptionalProduct optionalProduct;

    @Column(name = "total_revenue", nullable = false)
    private Double totalRevenue;

    public Double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(Double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public OptionalProduct getOptionalProduct() {
        return optionalProduct;
    }

    public void setOptionalProduct(OptionalProduct optionalProduct) {
        this.optionalProduct = optionalProduct;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}