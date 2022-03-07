package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;

@Entity
@Table(name = "service")
@NamedQueries({@NamedQuery(name = "Service.findAll", query = "SELECT s FROM Service s")})
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_service", nullable = false)
    private Integer id;

    @Column(name = "type", length = 45)
    private String type;

    @Column(name = "number_minutes")
    private Integer numberMinutes;

    @Column(name = "fee_minutes")
    private Float feeMinutes;

    @Column(name = "number_SMS")
    private Integer numberSms;

    @Column(name = "fee_SMS")
    private Float feeSms;

    @Column(name = "number_giga")
    private Integer numberGiga;

    @Column(name = "fee_giga")
    private Float feeGiga;

    public Service(String type, Integer numberMinutes, Float feeMinutes, Integer numberSms, Float feeSms, Integer numberGiga, Float feeGiga) {
        this.type = type;
        this.numberMinutes = numberMinutes;
        this.feeMinutes = feeMinutes;
        this.numberSms = numberSms;
        this.feeSms = feeSms;
        this.numberGiga = numberGiga;
        this.feeGiga = feeGiga;
    }

    public Service() {

    }

    public Float getFeeGiga() {
        return feeGiga;
    }

    public void setFeeGiga(Float feeGiga) {
        this.feeGiga = feeGiga;
    }

    public Integer getNumberGiga() {
        return numberGiga;
    }

    public void setNumberGiga(Integer numberGiga) {
        this.numberGiga = numberGiga;
    }

    public Float getFeeSms() {
        return feeSms;
    }

    public void setFeeSms(Float feeSms) {
        this.feeSms = feeSms;
    }

    public Integer getNumberSms() {
        return numberSms;
    }

    public void setNumberSms(Integer numberSms) {
        this.numberSms = numberSms;
    }

    public Float getFeeMinutes() {
        return feeMinutes;
    }

    public void setFeeMinutes(Float feeMinutes) {
        this.feeMinutes = feeMinutes;
    }

    public Integer getNumberMinutes() {
        return numberMinutes;
    }

    public void setNumberMinutes(Integer numberMinutes) {
        this.numberMinutes = numberMinutes;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}