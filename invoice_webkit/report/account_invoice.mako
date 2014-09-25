# -*- coding: utf-8 -*-
<html>
<head>
    <style type="text/css">
        ${css}

.list_invoice_table {
    border:thin solid #E3E4EA;
    text-align:center;
    border-collapse: collapse;
}
.list_invoice_table th {
    background-color: #EEEEEE;
    border: thin solid #000000;
    text-align:center;
    font-size:12;
    font-weight:bold;
    padding-right:3px;
    padding-left:3px;
}
.list_main_table td {
    border-top : thin solid #EEEEEE;
    text-align:left;
    font-size:12;
    padding-right:3px;
    padding-left:3px;
    padding-top:3px;
    padding-bottom:3px;
}
.list_main_table thead {
    display:table-header-group;
}

div.formatted_note {
    text-align:left;
    padding-left:10px;
    font-size:11;
    padding-right:3px;
    padding-left:3px;
}
.list_invoice_table td {
    border-top : thin solid #EEEEEE;
    text-align:left;
    font-size:12;
    padding-right:3px;
    padding-left:3px;
    padding-top:3px;
    padding-bottom:3px;
}
.list_invoice_table thead {
    display:table-header-group;
}


.list_bank_table {
    text-align:center;
    border-collapse: collapse;
}
.list_bank_table th {
    background-color: #EEEEEE;
    text-align:left;
    font-size:12;
    font-weight:bold;
    padding-right:3px;
    padding-left:3px;
}
.list_bank_table td {
    text-align:left;
    font-size:12;
    padding-right:3px;
    padding-left:3px;
    padding-top:3px;
    padding-bottom:3px;
}


.list_tax_table {
}
.list_tax_table td {
    text-align:left;
    font-size:12;
}
.list_tax_table th {
}
.list_tax_table thead {
    display:table-header-group;
}


.list_total_table {
    border:thin solid #E3E4EA;
    text-align:center;
    border-collapse: collapse;
}

.list_total_table td {
    border: thin solid #EEEEEE;
    text-align:left;
    font-size:12;
    padding-right:3px;
    padding-left:3px;
    padding-top:3px;
    padding-bottom:3px;
}
.list_total_table th {
    border: thin solid #EEEEEE;
    text-align:center;
    font-size:12;
    padding-right:3px
    padding-left:3px
}
.list_total_table thead {
    display:table-header-group;
}


.no_bloc {
    border-top: thin solid  #ffffff ;
}

.right_table {
    right: 4cm;
    width:"100%";
}

.std_text {
    font-size:12;
}

td.amount
    white-space: nowrap;
    text-align: right;
}

tfoot.totals tr:first-child td{
    padding-top: 15px;
}

th.date {
    width: 90px;
}

td.amount, th.amount {
    text-align: right;
    white-space: nowrap;
}
.header_table {
    text-align: center;
    border: 1px solid lightGrey;
    border-collapse: collapse;
}
.header_table th {
    font-size: 12px;
    border: 1px solid lightGrey;
}
.header_table td {
    font-size: 12px;
    border: 1px solid lightGrey;
}

td.date {
    white-space: nowrap;
    width: 90px;
}

td.vat {
    white-space: nowrap;
}

.nobreak {
     page-break-inside: avoid;
 }

.align_top {
     vertical-align:text-top;
 }

    </style>
</head>
<body>
    <%page expression_filter="entity"/>
    <%
    def carriage_returns(text):
        return text.replace('\n', '<br />')
    %>

    %for inv in objects:
    <% setLang(inv.partner_id.lang) %>
    <br />
    <div class="address">
        <table class="recipient">
	    %if inv.partner_id.parent_id:
	    <tr><td class="name">${inv.partner_id.parent_id and inv.partner_id.parent_id.name or ''}</td></tr>
	    %endif
            <tr><td class="name">${inv.partner_id.title and inv.partner_id.title.name or ''} ${inv.partner_id.name }</td></tr>
            <tr><td>${inv.partner_id.street or ''}</td></tr>
            <tr><td>${inv.partner_id.street2 or ''}</td></tr>
            <tr><td>${inv.partner_id.zip or ''} ${inv.partner_id.city or ''}</td></tr>
            %if inv.partner_id.country_id:
            <tr><td>${inv.partner_id.country_id.name or ''} </td></tr>
            %endif
	    %if inv.partner_id.vat:
            <tr><td>${inv.partner_id.lang=='fr_FR' and u"N° TVA :" or "VAT number:"} ${inv.partner_id.vat or ''}</td></tr>
            %endif
        </table>
    </div>
    <div>

    	%if inv.note1 :
        <p class="std_text"> ${inv.note1 | carriage_returns} </p>
	%endif
    </div>
    <h1 style="clear: both; padding-top: 20px; font-size: 22px">
        %if inv.type == 'out_invoice' and inv.state == 'proforma2':
            ${_("PRO-FORMA")}
        %elif inv.type == 'out_invoice' and inv.state == 'draft':
            ${_("Draft Invoice")}
        %elif inv.type == 'out_invoice' and inv.state == 'cancel':
            ${_("Cancelled Invoice")} ${inv.number or ''}
        %elif inv.type == 'out_invoice':
            ${_("Invoice")} ${inv.number or ''}
        %elif inv.type == 'in_invoice':
            ${_("Supplier Invoice")} ${inv.number or ''}
        %elif inv.type == 'out_refund':
            ${_("Refund")} ${inv.number or ''}
        %elif inv.type == 'in_refund':
            ${_("Supplier Refund")} ${inv.number or ''}
        %endif
    </h1>

    <table class="basic_table" width="100%" style="margin-top: 20px; align: center">
        <tr>
            <th class="date">${inv.partner_id.lang=='fr_FR' and u"Date de facture" or "Invoice Date"}</td>
            <th class="date">${inv.partner_id.lang=='fr_FR' and u"Conditions de paiement" or "Payment Term"}</td>
	    <th class="date">${inv.partner_id.lang=='fr_FR' and u"Date d'échéance" or "Due Date"}</td>
	    <th class="date">${inv.partner_id.lang=='fr_FR' and u"Réf. commande client" or "Customer PO ref."}</td>
        </tr>
        <tr>
            <td class="date">${formatLang(inv.date_invoice, date=True)}</td>
            <td class="date">${inv.payment_term.name or ''}</td>
            <td class="date">${formatLang(inv.date_due, date=True)}</td>
            <td class="date">${inv.origin or ''}</td>
        </tr>
    </table>

   <%
   has_discount = False
   for line in inv.invoice_line:
      if line.discount > 0:
          has_discount = True
   %>

    <table class="list_invoice_table" width="100%" style="margin-top: 20px;align: center">
        <thead>
            <tr>
                <th>${_("Description")}</th>
                <th>${inv.partner_id.lang=='fr_FR' and u"Qté" or "Qty"}</th>
                <th>${inv.partner_id.lang=='fr_FR' and u"Unité" or "Unit"}</th>
                <th>${_("Unit Price")}</th>
            %if has_discount:
                <th>${inv.partner_id.lang=='fr_FR' and u"Remise" or "Discount"}</th>
            %endif
                <th>${_("Net Sub Total")}</th>
            </tr>
        </thead>
        <tbody>
        %for line in inv.invoice_line :
            <tr >
                <td>${line.name | carriage_returns}</td>
                <td class="amount">${formatLang(line.quantity or 0.0,digits=get_digits(dp='Account'))}</td>
                <td class="amount" style="text-align: center">${line.uos_id and line.uos_id.name or ''}</td>
                <td class="amount">${formatLang(line.price_unit)}</td>
		%if has_discount:
                <td class="amount" width="10%">${line.discount and formatLang(line.discount, digits=get_digits(dp='Account')) or ''} ${line.discount and '%' or ''}</td>
		%endif
                <td class="amount" width="13%">${formatLang(line.price_subtotal, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}</td>
            </tr>
        %endfor
        </tbody>
    <!-- Move the totals in a separate table, to avoid issues caused by the dynamic discount col. Alexis de Lattre 13/5/2013
        <tfoot class="totals">
            <tr>
                <td colspan="5" style="text-align:right;border-right: thin solid  #ffffff ;border-left: thin solid  #ffffff ;">
                    <b>${_("Net Total:")}</b>
                </td>
                <td class="amount" style="border-right: thin solid  #ffffff ;border-left: thin solid  #ffffff ;">
                    ${formatLang(inv.amount_untaxed, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}
                </td>
            </tr>
            <tr class="no_bloc">
                <td colspan="5" style="text-align:right; border-top: thin solid  #ffffff ; border-right: thin solid  #ffffff ;border-left: thin solid  #ffffff ;">
                    <b>${_("Taxes :")}</b>
                </td>
                <td class="amount" style="border-right: thin solid  #ffffff ;border-top: thin solid  #ffffff ;border-left: thin solid  #ffffff ;">
                        ${formatLang(inv.amount_tax, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}
                </td>
            </tr>
            <tr>
                <td colspan="5" style="border-right: thin solid  #ffffff ;border-top: thin solid  #ffffff ;border-left: thin solid  #ffffff ;border-bottom: thin solid  #ffffff ;text-align:right;">
                    <b>${_("Total:")}</b>
                </td>
                <td class="amount" style="border-right: thin solid  #ffffff ;border-top: thin solid  #ffffff ;border-left: thin solid  #ffffff ;border-bottom: thin solid  #ffffff ;">
                        <b>${formatLang(inv.amount_total, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}</b>
                </td>
            </tr>
        </tfoot>
    -->
    </table>

    <table class="list_invoice_table" width="25%" align="right" style="margin-top: 10px; border-style: thin solid  #ffffff">
        <tfoot class="totals">
	    <tr>
                <td style="text-align: right"><b>${inv.partner_id.lang=='fr_FR' and u"Total HT :" or "Net Total:"}</b></td>
                <td class="amount" style="">
                    <b>${formatLang(inv.amount_untaxed, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}</b>
                 </td>
             </tr>
             <tr>
                 <td style="text-align: right">${inv.partner_id.lang=='fr_FR' and u"Taxes :" or "Taxes:"}</td>
                 <td class="amount" style="">
                    ${formatLang(inv.amount_tax, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}
                 </td>
              </tr>
              <tr>
                  <td style="text-align: right"><b>${inv.partner_id.lang=='fr_FR' and u"Total TTC :" or "Total:"}</b></td>
                  <td class="amount">
                     <b>${formatLang(inv.amount_total, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}</b>
                  </td>
              </tr>
              %if inv.amount_total - inv.residual != 0.0:
              <tr>
                  <td style="text-align: right">${inv.partner_id.lang=='fr_FR' and u"Déjà payé:" or "Paid:"}</td>
                  <td class="amount">
                    ${formatLang(inv.amount_total - inv.residual, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}
                  </td>
              <tr>
                  <td style="text-align: right"><b>${inv.partner_id.lang=='fr_FR' and u"Reste à payer:" or "To Paid:"}</b></td>
                  <td class="amount">
                     <b>${formatLang(inv.residual, digits=get_digits(dp='Account'))} ${inv.currency_id.symbol}</b> 
                 </td>
              </tr>
              %endif
            </tfoot>
       </table>

        <br/>
    	%if inv.tax_line :
        <table class="list_total_table" style="margin-top: 30px;" width="55%" >
            <tr>
                <th>${inv.partner_id.lang=='fr_FR' and u"Nom de la taxe" or u"Tax name"}</th>
                <th>${_("Base")}</th>
                <th>${_("Tax")}</th>
            </tr>
            %for t in inv.tax_line :
                <tr>
                    <td style="text-align:left;">${ t.name } </td>
                    <td class="amount">${ formatLang(t.base, digits=get_digits(dp='Account')) }</td>
                    <td class="amount">${ formatLang(t.amount, digits=get_digits(dp='Account')) }</td>
                </tr>
            %endfor
        </table>
    	%endif
        <br/>
    	%if inv.company_id.id in (4,5,10) :
        <br/>
        <h4>
                ${_("(*) VAT not applicable, art. 293 B of the General Tax Code - Member of a micro-enterprise tax regime")}
        </h4>
        <br/>
    	%endif
    <%
      inv_bank = inv.partner_bank_id
      bank_institution = inv_bank and inv_bank.bank
    %>
    <p style="margin-top: 20px;">
    ${inv.partner_id.lang=='fr_FR' and u"Le paiement doit être effectué sur le compte bancaire suivant :" or u"The payment must be made to the following bank account:"}
    </p>
        <table class="basic_table" width="50%" >
    	%if inv_bank.state == 'rib' and inv.partner_id.lang in ['fr_FR', False]:
            <tr>
		<th>${("RIB")}</th>
		<td>${inv_bank.bank_code} - ${inv_bank.office} - ${inv_bank.rib_acc_number} - ${inv_bank.key}</td>
	    </tr>
        %endif
	    <tr>
		<th>${("IBAN")}</th>
                <td>${inv_bank.acc_number}</td>
            </tr>
            <tr>
                <th>${("BIC / SWIFT")}</th>
                <td>${inv_bank.bank_bic}</td>
            </tr>
          </table>
    <br/>
        %if inv.comment :
        <p class="std_text">${inv.comment | carriage_returns}</p>
        %endif
        %if inv.note2 :
        <p class="std_text">${inv.note2 | carriage_returns}</p>
        %endif
    <!--<p style="page-break-after:always"></p>-->
    %endfor
</body>
</html>
