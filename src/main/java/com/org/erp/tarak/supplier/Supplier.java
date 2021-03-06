package org.erp.tarak.supplier;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.erp.tarak.address.Address;
import org.erp.tarak.bankaccount.BankAccount;
import org.erp.tarak.contactperson.ContactPerson;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "Supplier")
public class Supplier implements Serializable {

	private static final long serialVersionUID = -723583058586873479L;

	@Id
	@SequenceGenerator(name="my_seq", sequenceName="supplierSequence",initialValue=1,allocationSize=1)
	@GeneratedValue(strategy = GenerationType.AUTO ,generator="my_seq")
	private long supplierId;
	private String supplierType;
	@Column(name = "Supplier_Name")
	private String supplierName;
	@Column(name = "Company_Name")
	private String companyName;
	@Column(name = "Company_Branch")
	private String companyBranch;
	@Column(name = "Company_Telephone1")
	private long companyTelephone1;
	@Column(name = "Company_Telephone2")
	private long companyTelephone2;
	@Column(name = "Company_Mobile1")
	private long companyMobile1;
	@Column(name = "Company_Mobile2")
	private long companyMobile2;
	@Column(name = "Company_Email")
	private String companyEmail;
	@Column(name = "Company_TIN_No")
	private String companyTinNo;
	@Column(name = "Company_CST_No")
	private String companyCstNo;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Address_Id")
	private Address companyAddress = new Address();

	@OneToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@Fetch(value=FetchMode.SELECT)
	private List<BankAccount> supplierAccounts;
	
	@OneToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@Fetch(value=FetchMode.SELECT)
	private List<ContactPerson> contactPersons;
	
	private double openingBalance;

	public long getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(long supplierId) {
		this.supplierId = supplierId;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyBranch() {
		return companyBranch;
	}

	public void setCompanyBranch(String companyBranch) {
		this.companyBranch = companyBranch;
	}

	public long getCompanyTelephone1() {
		return companyTelephone1;
	}

	public void setCompanyTelephone1(long companyTelephone1) {
		this.companyTelephone1 = companyTelephone1;
	}

	public long getCompanyTelephone2() {
		return companyTelephone2;
	}

	public void setCompanyTelephone2(long companyTelephone2) {
		this.companyTelephone2 = companyTelephone2;
	}

	public long getCompanyMobile1() {
		return companyMobile1;
	}

	public void setCompanyMobile1(long companyMobile1) {
		this.companyMobile1 = companyMobile1;
	}

	public long getCompanyMobile2() {
		return companyMobile2;
	}

	public void setCompanyMobile2(long companyMobile2) {
		this.companyMobile2 = companyMobile2;
	}

	public String getCompanyEmail() {
		return companyEmail;
	}

	public void setCompanyEmail(String companyEmail) {
		this.companyEmail = companyEmail;
	}

	public String getCompanyCstNo() {
		return companyCstNo;
	}

	public void setCompanyCstNo(String companyCstNo) {
		this.companyCstNo = companyCstNo;
	}

	public Address getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(Address companyAddress) {
		this.companyAddress = companyAddress;
	}

	public String getCompanyTinNo() {
		return companyTinNo;
	}

	public void setCompanyTinNo(String companyTinNo) {
		this.companyTinNo = companyTinNo;
	}

	public List<BankAccount> getSupplierAccounts() {
		return supplierAccounts;
	}

	public void setSupplierAccounts(List<BankAccount> supplierAccounts) {
		this.supplierAccounts = supplierAccounts;
	}

	public String getSupplierType() {
		return supplierType;
	}

	public void setSupplierType(String supplierType) {
		this.supplierType = supplierType;
	}

	public List<ContactPerson> getContactPersons() {
		return contactPersons;
	}

	public void setContactPersons(List<ContactPerson> contactPersons) {
		this.contactPersons = contactPersons;
	}

	public double getOpeningBalance() {
		return openingBalance;
	}

	public void setOpeningBalance(double openingBalance) {
		this.openingBalance = openingBalance;
	}

	/*
	 * public List<BankAccount> getSupplierAccounts() { return supplierAccounts; }
	 * 
	 * public void setSupplierAccounts(List<BankAccount> supplierAccounts) {
	 * this.supplierAccounts = supplierAccounts; }
	 */
}
