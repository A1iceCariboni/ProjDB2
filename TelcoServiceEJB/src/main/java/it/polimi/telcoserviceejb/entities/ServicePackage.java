package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "service_package")
public class ServicePackage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_service_package", nullable = false)
    private Integer id;

    @Column(name = "name", length = 45)
    private String name;

    @ManyToMany
    @JoinTable(name = "service_package-validity_period",
            joinColumns = @JoinColumn(name = "id_service_package"),
            inverseJoinColumns = @JoinColumn(name = "id_validity_period"))
    private List<ValidityPeriod> validityPeriods;

    @ManyToMany
    @JoinTable(name = "optional_product-service_package",
            joinColumns = @JoinColumn(name = "id_service_package"),
            inverseJoinColumns = @JoinColumn(name = "id_optional_product"))
    private List<OptionalProduct> optionalProducts ;

    @ManyToMany
    @JoinTable(name = "service-service_package",
            joinColumns = @JoinColumn(name = "id_service_package"),
            inverseJoinColumns = @JoinColumn(name = "id_service"))
    private List<Service> services;

    public ServicePackage(String name, List<ValidityPeriod> validityPeriods, List<OptionalProduct> optionalProducts, List<Service> services) {
        this.name = name;
        this.validityPeriods = validityPeriods;
        this.optionalProducts = optionalProducts;
        this.services = services;
    }

    public ServicePackage() {

    }

    public List<Service> getServices() {
        return services;
    }

    public void setServices(List<Service> services) {
        this.services = services;
    }

    public List<OptionalProduct> getOptionalProducts() {
        return optionalProducts;
    }

    public void setOptionalProducts(List<OptionalProduct> optionalProducts) {
        this.optionalProducts = optionalProducts;
    }

    public List<ValidityPeriod> getValidityPeriods() {
        return validityPeriods;
    }

    public void setValidityPeriods(List<ValidityPeriod> validityPeriods) {
        this.validityPeriods = validityPeriods;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

}