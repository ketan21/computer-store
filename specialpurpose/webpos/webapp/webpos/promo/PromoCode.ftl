<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<div id="panel">
    <form method="post" action="<@ofbizUrl>PromoCode</@ofbizUrl>" name="PromoCodeForm">
        <table border="0">
            <tr>
                <td colspan="2"">&nbsp;</td>
            </tr>
            <tr>
                <td><b>${uiLabelMap.WebPosPromoCode}</b></td>
                <td><input type="text" name="promoCode" id="promoCode"/></td>
            </tr>
            <tr>
                <td colspan="2"">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="${uiLabelMap.CommonConfirm}" name="confirm"/>
                    <input type="submit" value="${uiLabelMap.CommonCancel}"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<script language="javascript" type="text/javascript">
    document.PromoCodeForm.promoCode.focus();
</script>