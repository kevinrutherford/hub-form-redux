Background:
  Given a form
    """
      <FormSection name='Section 1'>
        <Text name='birthday' rules={[date]} />
        <Select name='isCompany'
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
    | sections  |
    | Section 1 |
  And the following fields are visible in the form:
    | fieldname | value | errors |
    | birthday  |       |        |
    | isCompany |       |        |
  And the SubmitButton is disabled
  And the ChangesIndicator says ''
  And the SectionTodoList is empty
