package com.istiaq.daycare.dto;

import java.util.Date;

public class CircularDTO {

    private Long id;
    private String title;
    private String description;
    private Double salary;
    private String jobType;
    private Date postedDate;

    // Parent info
    private Long parentId;
    private String parentName;
    private String contactPerson;
    private String email;
    private String phone;
    private String childName;
    private String photo;

    private LocationDTO locationDTO;


    public CircularDTO() {
    }

    public CircularDTO(Long id, String title, String description, Double salary, String jobType, Date postedDate, Long parentId, String parentName, String contactPerson, String email, String phone, String childName, String photo, LocationDTO locationDTO) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.salary = salary;
        this.jobType = jobType;
        this.postedDate = postedDate;
        this.parentId = parentId;
        this.parentName = parentName;
        this.contactPerson = contactPerson;
        this.email = email;
        this.phone = phone;
        this.childName = childName;
        this.photo = photo;
        this.locationDTO = locationDTO;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getSalary() {
        return salary;
    }

    public void setSalary(Double salary) {
        this.salary = salary;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getChildName() {
        return childName;
    }

    public void setChildName(String childName) {
        this.childName = childName;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public LocationDTO getLocationDTO() {
        return locationDTO;
    }

    public void setLocationDTO(LocationDTO locationDTO) {
        this.locationDTO = locationDTO;
    }


}
