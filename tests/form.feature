Background:
  Given a form
    """
      <FormSection name='Section 1'>
        <Text name='birthday' rules={[date]} />
        <Select name='isCompany' rules={[mandatory]}
            options={[
              {label='Yes' value='yes'},
              {label='No' value='no'},
            ]}
          />
      </FormSection name='Company details'>
      <ShowIf field={isCompany} is={yes}>
        <FormSection>
          <Text name='companyName' rules={[mandatory]} />
          <Text name='companyCity' />
        </FormSection>
      </ShowIf>
    """

Scenario: Open a new form
   When I load the form into an editor
   Then the SectionNavigator shows
      | section   | todo |
      | Section 1 | 0    |
    And the following fields are visible in the form:
      | fieldname | value | errors |
      | birthday  |       |        |
      | isCompany |       |        |
    And the SubmitButton is disabled
    And the ChangesIndicator says nothing

Scenario: Type an invalid value into a field
   When I type '3' into the 'birthday' field
   Then the SectionNavigator shows
      | section   | todo |
      | Section 1 | 2    |
    And the following fields are visible in the form:
      | fieldname | value | errors                                        |
      | birthday  | 3     | Must be a valid date in the format dd/mm/yyyy |
      | isCompany |       | Please complete                               |
    And the SubmitButton is disabled
    And the ChangesIndicator says there are unsaved changes

Scenario: Type a valid value into a field
  Given I have typed '31/01/201' into the 'birthday' field
   When I type '3' into the 'birthday' field
   Then the SectionNavigator shows
      | section   | todo |
      | Section 1 | 1    |
    And the following fields are visible in the form:
      | fieldname | value      | errors          |
      | birthday  | 31/03/2013 |                 |
      | isCompany |            | Please complete |
    And the SubmitButton is disabled
    And the ChangesIndicator says there are unsaved changes
