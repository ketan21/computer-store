<div class="screenlet">
  <div class="screenlet-title-bar">
    <ul>
      <li class="h3">Create Tax</li>
    </ul>
  </div>
  <div class="screenlet-body">
    <form action="<@ofbizUrl>createTax</@ofbizUrl>" method="post" class="simpleForm" name="createTax">
      <fieldset class="fieldgroup-body">
      <div>
          <label>Tax Name</label>
          <input type="text" name="categoryName" value="" />
      </div>
      <div>
          <label>Tax Percentage</label>
          <input type="text" name="taxPercentage" value="" />
      </div>
      <div>
          <input type="submit" name="Create" value="${uiLabelMap.CommonSubmit}"/>
      </div>
      </fieldset>
    </form>
  </div>
</div>
