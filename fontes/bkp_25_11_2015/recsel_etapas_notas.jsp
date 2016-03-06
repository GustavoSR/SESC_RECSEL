<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %>
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="application/vnd.ms-excel;charset=ISO-8859-1" %> 
<!--
<rw:report id="report">
<rw:objects id="objects"> <?xml version="1.0" encoding="ISO-8859-1" ?>
<report name="recsel_etapas_notas" DTDVersion="9.0.2.0.10">
  <xmlSettings xmlTag="RECSEL_ETAPAS_NOTAS" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <reportHtmlEscapes>
    <beforePageHtmlEscape>
    <![CDATA[#NULL#]]>
    </beforePageHtmlEscape>
  </reportHtmlEscapes>
  <data>
    <userParameter name="P_SEL_ID" datatype="number" defaultWidth="0"
     defaultHeight="0"/>
    <userParameter name="P_MOSTRA_NASC" datatype="character" width="1"
     precision="10" initialValue="S" defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_MOSTRA_FONE_RES" datatype="character" width="1"
     precision="10" initialValue="S" defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_MOSTRA_FONE_CEL" datatype="character" width="1"
     precision="10" initialValue="S" defaultWidth="0" defaultHeight="0"/>
    <dataSource name="Q_1">
      <select canParse="no">
      <![CDATA[SELECT a.*,
              (max(a.count_ord) over() + 3) AS qtd_cols,
              ( max(a.count_ord) over() ) AS qtd_lines
  FROM (SELECT ec.sel_etapa_num_cand AS numero,
               initcap(glb_extenso.nome_abreviado(c.candidato_nome,50)) AS nome,
               nvl(ec.sel_etapa_cand_nota,0) AS nota,
               e.etapasel_nome AS nome_etapa,
               s.etapasel_ordem AS dt_ord,
               nvl(
                     SUM(ec.sel_etapa_cand_nota * NVL(s.etapasel_peso,1)) OVER(PARTITION BY ec.sel_etapa_num_cand) /
                     SUM(NVL(s.etapasel_peso,1)) OVER(PARTITION BY ec.sel_etapa_num_cand), 0 )   AS media,
               count(*) over(PARTITION BY ec.sel_etapa_num_cand) as count_ord,
              (SELECT cur.curriculo_valor
		  FROM recsel_curlabel l,
		       recsel_curriculo cur
		 WHERE l.curlabel_id = 94
		   AND l.curlabel_id = cur.curlabel_id
		   AND cur.candidato_cpf = ec.candidato_cpf) AS data_nascimento,
               (SELECT cur.curriculo_valor
		  FROM recsel_curlabel l,
		       recsel_curriculo cur
		 WHERE l.curlabel_id = 62
		   AND l.curlabel_id = cur.curlabel_id
		   AND cur.candidato_cpf = ec.candidato_cpf) AS telefone_residencial,
               (SELECT cur.curriculo_valor
		  FROM recsel_curlabel l,
		       recsel_curriculo cur
		 WHERE l.curlabel_id = 63
		   AND l.curlabel_id = cur.curlabel_id
		   AND cur.candidato_cpf = ec.candidato_cpf) AS telefone_celular	    
  FROM recsel_sel_etapa_candidato ec,
             recsel_candidato c,
             recsel_etapasel_selecao s,
             recsel_etapasel e
 WHERE ec.candidato_cpf = c.candidato_cpf
   AND ec.selecao_id = s.selecao_id
   AND ec.etapasel_id = s.etapasel_id
   AND e.etapasel_id = s.etapasel_id
   AND ec.selecao_id = :p_sel_id) a
 ORDER BY count_ord desc, media desc, numero, dt_ord, nota desc]]>
      </select>
      <displayInfo x="0.80627" y="0.05200" width="0.69995" height="0.19995"/>
      <group name="G_media">
        <displayInfo x="0.49695" y="1.09534" width="1.31873" height="1.28516"
        />
        <dataItem name="count_ord" oracleDatatype="number" columnOrder="21"
         width="22" defaultWidth="90000" defaultHeight="10000" columnFlags="3"
         defaultLabel="Count Ord" breakOrder="descending">
          <dataDescriptor expression="COUNT_ORD"
           descriptiveExpression="COUNT_ORD" order="7" oracleDatatype="number"
           width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="media" oracleDatatype="number" columnOrder="20"
         width="22" defaultWidth="90000" defaultHeight="10000" columnFlags="3"
         defaultLabel="Media" breakOrder="descending">
          <dataDescriptor expression="MEDIA" descriptiveExpression="MEDIA"
           order="6" oracleDatatype="number" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="QTD_COLS" oracleDatatype="number" columnOrder="25"
         width="22" defaultWidth="90000" defaultHeight="10000" columnFlags="0"
         defaultLabel="Qtd Cols" breakOrder="none">
          <dataDescriptor expression="QTD_COLS"
           descriptiveExpression="QTD_COLS" order="11" oracleDatatype="number"
           width="22" precision="38"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="QTD_LINES" oracleDatatype="number" columnOrder="26"
         width="22" defaultWidth="90000" defaultHeight="10000" columnFlags="0"
         defaultLabel="Qtd Lines" breakOrder="none">
          <dataDescriptor expression="QTD_LINES"
           descriptiveExpression="QTD_LINES" order="12"
           oracleDatatype="number" width="22" precision="38"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="numero" oracleDatatype="number" columnOrder="15"
         width="22" defaultWidth="20000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Número">
          <dataDescriptor expression="NUMERO" descriptiveExpression="NUMERO"
           order="1" oracleDatatype="number" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="nome" datatype="vchar2" columnOrder="16" width="4000"
         defaultWidth="100000" defaultHeight="10000" columnFlags="0"
         defaultLabel="Nome" breakOrder="none">
          <dataDescriptor expression="NOME" descriptiveExpression="NOME"
           order="2" width="4000"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
      <group name="G_nome_etapa">
        <displayInfo x="0.46069" y="2.61548" width="1.39197" height="0.60156"
        />
        <dataItem name="dt_ord" oracleDatatype="number" columnOrder="19"
         width="22" defaultWidth="20000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Dt Ord">
          <dataDescriptor expression="DT_ORD" descriptiveExpression="DT_ORD"
           order="5" oracleDatatype="number" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="nome_etapa" datatype="vchar2" columnOrder="18"
         width="100" defaultWidth="100000" defaultHeight="10000"
         columnFlags="32" defaultLabel="Nome Etapa" breakOrder="none">
          <dataDescriptor expression="NOME_ETAPA"
           descriptiveExpression="NOME_ETAPA" order="4" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
      <group name="G_nota">
        <displayInfo x="0.26392" y="3.59265" width="1.77905" height="0.94336"
        />
        <dataItem name="DATA_NASCIMENTO" datatype="vchar2" columnOrder="22"
         width="1000" defaultWidth="100000" defaultHeight="10000"
         columnFlags="1" defaultLabel="Data Nascimento">
          <dataDescriptor expression="DATA_NASCIMENTO"
           descriptiveExpression="DATA_NASCIMENTO" order="8" width="1000"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="TELEFONE_RESIDENCIAL" datatype="vchar2"
         columnOrder="23" width="1000" defaultWidth="100000"
         defaultHeight="10000" columnFlags="1"
         defaultLabel="Telefone Residencial">
          <dataDescriptor expression="TELEFONE_RESIDENCIAL"
           descriptiveExpression="TELEFONE_RESIDENCIAL" order="9" width="1000"
          />
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="TELEFONE_CELULAR" datatype="vchar2" columnOrder="24"
         width="1000" defaultWidth="100000" defaultHeight="10000"
         columnFlags="1" defaultLabel="Telefone Celular">
          <dataDescriptor expression="TELEFONE_CELULAR"
           descriptiveExpression="TELEFONE_CELULAR" order="10" width="1000"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="nota" oracleDatatype="number" columnOrder="17"
         width="22" defaultWidth="90000" defaultHeight="10000"
         columnFlags="32" defaultLabel="Nota" breakOrder="none">
          <dataDescriptor expression="NOTA" descriptiveExpression="NOTA"
           order="3" oracleDatatype="number" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
    </dataSource>
    <crossProduct name="G_Cross">
      <displayInfo x="0.16040" y="0.70203" width="1.99182" height="2.65234"/>
      <dimension>
        <group name="G_media"/>
      </dimension>
      <dimension>
        <group name="G_nome_etapa"/>
      </dimension>
    </crossProduct>
  </data>
  <reportPrivate defaultReportType="matrix" versionFlags2="0"
   templateName="rwbeige"/>
  <reportWebSettings>
  <![CDATA[#NULL#]]>
  </reportWebSettings>
</report>
</rw:objects>
-->
<% 
   int countLinesPartial = 0;
   int countLinesFinal = 0;
   int countColsFinal = 0;
   String foneCelFinal = "";
   String foneResFinal = "";
   String nascFinal = "";
   String hostName = request.getServerName();
%>

<rw:getValue id="mostraFoneCel" src="P_MOSTRA_FONE_CEL"/>
<rw:getValue id="mostraFoneRes" src="P_MOSTRA_FONE_RES"/>
<rw:getValue id="mostraNasc" src="P_MOSTRA_NASC"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>

<HEAD>
  <TITLE> SESCSP - Notas dos Candidatos por Etapa </TITLE>
  <rw:style id="rwbeige226">
     <link rel="StyleSheet" type="text/css" href='http://<%=hostName%>:7779/reports/css/rwbeige.css'>
  </rw:style>
  <META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</HEAD>

<BODY bgColor="#ffffff" link="#000000" vLink="#000000">

<rw:dataArea id="MGCrossGRPFR127">

<rw:foreach id="RGmedia127456" src="G_media">
  <rw:getValue id="countCols" src="QTD_COLS"/>
  <rw:getValue id="countLines" src="QTD_LINES"/>
  <% countColsFinal = Integer.parseInt(countCols);
     countLinesFinal = Integer.parseInt(countLines); %>
</rw:foreach>

<% if ( mostraFoneCel.equals("S") ) countColsFinal += 1;   
   if ( mostraFoneRes.equals("S") ) countColsFinal += 1; 
   if ( mostraNasc.equals("S") ) countColsFinal += 1; %>

<table border="1" class="OraTable">
  <THEAD>
    <tr><th colspan=<%=countColsFinal%> class="OraRowHeader"><font size="5">Notas dos candidatos por etapas</font></th></tr>
    <tr><th colspan=<%=countColsFinal%>>&nbsp;</th></tr>
    <tr><th colspan=<%=countColsFinal%>>&nbsp;</th></tr>
    <tr>   
      <th <rw:id id="HBnumero127" asArray="no"/> class="OraRowHeader"> Número </th>
      <th <rw:id id="HBnome127" asArray="no"/> class="OraRowHeader"> Nome </th>
      <rw:foreach id="RGnomeetapa1271" src="G_nome_etapa">
        <th <rw:id id="HFnomeetapa127" asArray="no"/> class="OraColumnHeader">
           <rw:field id="Fnomeetapa127" src="nome_etapa" breakLevel="RGnomeetapa1271" breakValue="&nbsp;"> F_nome_etapa </rw:field>
        </th>
      </rw:foreach>
      <th <rw:id id="HBmedia127" asArray="no"/> class="OraRowHeader"> Média </th>
      <% if ( mostraNasc.equals("S") ) { %>
             <th <rw:id id="HBnascimento127" asArray="no"/> class="OraRowHeader"> Data Nascimento </th>
      <% } %>   
      <% if ( mostraFoneCel.equals("S") ) { %>
             <th <rw:id id="HBcelular127" asArray="no"/> class="OraRowHeader"> Celular </th>
      <% } %>
      <% if ( mostraFoneRes.equals("S") ) { %>
             <th <rw:id id="HBresidencial127" asArray="no"/> class="OraRowHeader"> Fone residencial </th>
      <% } %>  
    </tr>
  </THEAD>
  <TBODY> 
  <rw:foreach id="RGmedia1274" src="G_media">  
    <tr>      
      <td <rw:id id="HFnumero127" breakLevel="RGmedia1274" asArray="yes"/> class="OraCellNumber"><rw:field id="Fnumero127" src="numero" breakLevel="RGmedia1274" breakValue="&nbsp;" formatMask="NNNGNN0"> F_numero </rw:field></td>
      <td <rw:id id="HFnome127" breakLevel="RGmedia1274" asArray="yes"/> class="OraCellText"><rw:field id="Fnome127" src="nome" breakLevel="RGmedia1274" breakValue="&nbsp;"> F_nome </rw:field></td>      
      <rw:foreach id="RGnomeetapa1275" src="G_nome_etapa">
         <rw:foreach id="RGnota1275" src="G_nota">
            <td <rw:id id="HFnota1275" breakLevel="RGnota1275" asArray="yes"/> class="OraCellNumber"><rw:field id="Fnota1275" src="nota" breakLevel="RGnota1275" nullValue="&nbsp;" formatMask="NNNGNN0D00"> F_nota </rw:field></td>
            <rw:getValue id="foneCel" src="TELEFONE_CELULAR"/>
            <rw:getValue id="foneRes" src="TELEFONE_RESIDENCIAL"/>
            <rw:getValue id="nasc" src="DATA_NASCIMENTO"/>
            <% foneCelFinal = foneCel;
               foneResFinal = foneRes;
               nascFinal = nasc;
               countLinesPartial += 1; %>
         </rw:foreach>
      </rw:foreach>
      <% if ( countLinesPartial < countLinesFinal ) { 
            for (int i=countLinesPartial; i<countLinesFinal; i++) { %>
             <td <rw:id id=""/> class="OraCellNumber">&nbsp;</td>
      <%    } 
         }
         countLinesPartial = 0; %>
      <td <rw:id id="HFmedia127" breakLevel="RGmedia1274" asArray="yes"/> class="OraCellNumber"><rw:field id="Fmedia127" src="media" breakLevel="RGmedia1274" breakValue="&nbsp;" formatMask="NNNGNN0D00"> F_media </rw:field></td>
      <% if ( mostraNasc.equals("S") ) { %>
             <td class="OraCellText"><%=nascFinal%></td>
      <% } %>   
      <% if ( mostraFoneCel.equals("S") ) { %>
             <td class="OraCellNumber"><%=foneCelFinal%></td>
      <% } %>
      <% if ( mostraFoneRes.equals("S") ) { %>
             <td class="OraCellNumber"><%=foneResFinal%></td>
      <% } %>
    </tr>  
  </rw:foreach>
  </TBODY>
</table>

</rw:dataArea>

</BODY>

</HTML>

<!--
</rw:report>
-->
