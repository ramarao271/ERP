package org.erp.tarak.salesreturn;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class SalesReturnBeanValidator implements Validator {


	@Override
	public boolean supports(Class<?> arg0) {
		return SalesReturnBean.class.isAssignableFrom(arg0);
	}

	@Override
	public void validate(Object arg0, Errors errors) {/*
		SalesReturnBean salesReturnBean = (SalesReturnBean) arg0;
		String mandatoryFields[] = { "salesReturnName", "companyName",
				"companyMobile1" };
		List<String> fieldsList = Arrays.asList(mandatoryFields);
		for (String field : fieldsList) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, field, field);
		}
		String numberFields[] = { "companyTelephone1", "companyTelephone2",
				"companyMobile1", "companyMobile2" };
		for (String field : numberFields) {
			try {
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	*/}
	}
