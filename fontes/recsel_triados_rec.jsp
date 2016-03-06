<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
<?xml version="1.0" encoding="ISO-8859-1" ?>
<report name="recsel_triados_rec" DTDVersion="9.0.2.0.10"
 afterParameterFormTrigger="afterpform">
  <xmlSettings xmlTag="RECSEL_TRIADOS_REC" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <reportHtmlEscapes>
    <beforePageHtmlEscape>
    <![CDATA[#NULL#]]>
    </beforePageHtmlEscape>
  </reportHtmlEscapes>
  <data>
    <userParameter name="P_RECRUTAMENTO_ID" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_STATUS" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_ETAPAREC_ID" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_CPF" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_Title" datatype="character" width="5000"
     precision="10" defaultWidth="0" defaultHeight="0"/>
    <dataSource name="Q_1">
      <select>
      <![CDATA[select c.candidato_cpf   as CPF,
          UPPER(c.candidato_nome)  as nome,
          c.candidato_email as email,
          trunc(months_between(sysdate,to_date(cr.curriculo_valor,'dd/mm/rrrr'))/12) as idade,
          decode(se.sts_etapa_sigla,'TRI','TRIADO','N TRI','NÃO TRIADO','N AVAL','NÃO AVALIADO','DES','DESISTENTE','ALT','ALTERADO') as status,
          ec.etaparec_id,
          er.etaparec_nome,
          trim(to_char(sum(decode(se.sts_etapa_sigla,'TRI',1,0))    over(partition by ec.recrutamento_id,ec.etaparec_id),'999g999g999g990')) || '  Triados'  as count_tri,
          trim(to_char(sum(decode(se.sts_etapa_sigla,'N TRI',1,0))  over(partition by ec.recrutamento_id,ec.etaparec_id),'999g999g999g990')) || '  Não triados' as count_n_tri,
          trim(to_char(sum(decode(se.sts_etapa_sigla,'N AVAL',1,0)) over(partition by ec.recrutamento_id,ec.etaparec_id),'999g999g999g990')) || '  Não avaliados' as count_n_aval,
          trim(to_char(sum(decode(se.sts_etapa_sigla,'DES',1,0))    over(partition by ec.recrutamento_id,ec.etaparec_id),'999g999g999g990')) || '  Desistentes' as count_des,
          trim(to_char(sum(decode(se.sts_etapa_sigla,'ALT',1,0))    over(partition by ec.recrutamento_id,ec.etaparec_id),'999g999g999g990')) || '  Alterados' as count_alt
  from recsel_candidato               c,
       recsel_recrutamento_candidato rc,
	   recsel_rec_etapa_candidato    ec,
	   recsel_sts_etapa              se,
	   recsel_etaparec               er,
	   recsel_curr_rec               cr,
	   recsel_curlabel               rl
 where c.candidato_cpf = rc.candidato_cpf
   and rc.candidato_cpf = ec.candidato_cpf
   and rc.recrutamento_id = ec.recrutamento_id
   and ec.sts_etapa_id = se.sts_etapa_id
   and ec.etaparec_id = er.etaparec_id
   and c.candidato_cpf = cr.candidato_cpf
   and rc.recrutamento_id = cr.recrutamento_id
   and rl.curlabel_id = cr.curlabel_id
   and upper(rl.curlabel_nome) = 'DATA DE NASCIMENTO'
   and rc.recrutamento_id = :P_RECRUTAMENTO_ID
   and (se.sts_etapa_sigla = :P_STATUS or :P_STATUS IS NULL)
   and (ec.etaparec_id = :P_ETAPAREC_ID or :P_ETAPAREC_ID IS NULL)
   and (c.candidato_cpf = :P_CPF or :P_CPF IS NULL)]]>
      </select>
      <displayInfo x="0.58960" y="0.15625" width="0.69995" height="0.19995"/>
      <group name="G_etaparec_nome">
        <displayInfo x="0.24365" y="0.69092" width="1.40186" height="1.45605"
        />
        <dataItem name="etaparec_id" oracleDatatype="number" columnOrder="19"
         width="22" defaultWidth="20000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Etaparec Id">
          <dataDescriptor expression="ec.etaparec_id"
           descriptiveExpression="ETAPAREC_ID" order="6"
           oracleDatatype="number" width="22" scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="etaparec_nome" datatype="vchar2" columnOrder="20"
         width="100" defaultWidth="100000" defaultHeight="10000"
         columnFlags="1" defaultLabel="Nome da Etapa">
          <dataDescriptor expression="er.etaparec_nome"
           descriptiveExpression="ETAPAREC_NOME" order="7" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="count_tri" datatype="vchar2" columnOrder="22"
         width="25" defaultWidth="90000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Count Tri">
          <dataDescriptor
           expression="trim ( to_char ( sum ( decode ( se.sts_etapa_sigla , &apos;TRI&apos; , 1 , 0 ) ) over ( partition by ec.recrutamento_id , ec.etaparec_id ) , &apos;999g999g999g990&apos; ) ) || &apos;  Triados&apos;"
           descriptiveExpression="COUNT_TRI" order="8" width="25"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="count_n_tri" datatype="vchar2" columnOrder="23"
         width="29" defaultWidth="90000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Count N Tri">
          <dataDescriptor
           expression="trim ( to_char ( sum ( decode ( se.sts_etapa_sigla , &apos;N TRI&apos; , 1 , 0 ) ) over ( partition by ec.recrutamento_id , ec.etaparec_id ) , &apos;999g999g999g990&apos; ) ) || &apos;  Não triados&apos;"
           descriptiveExpression="COUNT_N_TRI" order="9" width="29"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="count_des" datatype="vchar2" columnOrder="25"
         width="29" defaultWidth="90000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Count Des" valueIfNull="0">
          <dataDescriptor
           expression="trim ( to_char ( sum ( decode ( se.sts_etapa_sigla , &apos;DES&apos; , 1 , 0 ) ) over ( partition by ec.recrutamento_id , ec.etaparec_id ) , &apos;999g999g999g990&apos; ) ) || &apos;  Desistentes&apos;"
           descriptiveExpression="COUNT_DES" order="11" width="29"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="count_n_aval" datatype="vchar2" columnOrder="24"
         width="31" defaultWidth="90000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Count N Aval" valueIfNull="0">
          <dataDescriptor
           expression="trim ( to_char ( sum ( decode ( se.sts_etapa_sigla , &apos;N AVAL&apos; , 1 , 0 ) ) over ( partition by ec.recrutamento_id , ec.etaparec_id ) , &apos;999g999g999g990&apos; ) ) || &apos;  Não avaliados&apos;"
           descriptiveExpression="COUNT_N_AVAL" order="10" width="31"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="count_alt" datatype="vchar2" columnOrder="26"
         width="27" defaultWidth="90000" defaultHeight="10000" columnFlags="1"
         defaultLabel="Count Alt" valueIfNull="0">
          <dataDescriptor
           expression="trim ( to_char ( sum ( decode ( se.sts_etapa_sigla , &apos;ALT&apos; , 1 , 0 ) ) over ( partition by ec.recrutamento_id , ec.etaparec_id ) , &apos;999g999g999g990&apos; ) ) || &apos;  Alterados&apos;"
           descriptiveExpression="COUNT_ALT" order="12" width="27"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
      <group name="G_CPF">
        <displayInfo x="0.45959" y="2.58264" width="0.96655" height="1.11426"
        />
        <dataItem name="CPF" oracleDatatype="number" columnOrder="14"
         width="22" defaultWidth="90000" defaultHeight="10000"
         columnFlags="32" defaultLabel="CPF" breakOrder="none">
          <dataDescriptor expression="c.candidato_cpf"
           descriptiveExpression="CPF" order="1" oracleDatatype="number"
           width="22" precision="11"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="nome" datatype="vchar2" columnOrder="15" width="100"
         defaultWidth="100000" defaultHeight="10000" columnFlags="33"
         defaultLabel="Nome">
          <dataDescriptor expression="UPPER ( c.candidato_nome )"
           descriptiveExpression="NOME" order="2" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="email" datatype="vchar2" columnOrder="16" width="100"
         defaultWidth="100000" defaultHeight="10000" columnFlags="32"
         defaultLabel="e-mail" breakOrder="none">
          <dataDescriptor expression="c.candidato_email"
           descriptiveExpression="EMAIL" order="3" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="idade" oracleDatatype="number" columnOrder="17"
         width="22" defaultWidth="90000" defaultHeight="10000"
         columnFlags="32" defaultLabel="Idade" breakOrder="none">
          <dataDescriptor
           expression="trunc ( months_between ( sysdate , to_date ( cr.curriculo_valor , &apos;dd/mm/rrrr&apos; ) ) / 12 )"
           descriptiveExpression="IDADE" order="4" oracleDatatype="number"
           width="22" precision="38"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="status" datatype="vchar2" columnOrder="18" width="12"
         defaultWidth="100000" defaultHeight="10000" columnFlags="32"
         defaultLabel="Status" breakOrder="none">
          <dataDescriptor
           expression="decode ( se.sts_etapa_sigla , &apos;TRI&apos; , &apos;TRIADO&apos; , &apos;N TRI&apos; , &apos;NÃO TRIADO&apos; , &apos;N AVAL&apos; , &apos;NÃO AVALIADO&apos; , &apos;DES&apos; , &apos;DESISTENTE&apos; , &apos;ALT&apos; , &apos;ALTERADO&apos; )"
           descriptiveExpression="STATUS" order="5" width="12"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
    </dataSource>
  </data>
  <layout>
  <section name="main">
    <body width="7.75000" height="10.14587">
      <location x="0.36462" y="0.79163"/>
      <frame name="M_G_etaparec_nome_GRPFR">
        <geometryInfo x="0.00000" y="0.00000" width="7.75000" height="5.25000"
        />
        <generalLayout verticalElasticity="variable"/>
        <repeatingFrame name="R_G_etaparec_nome" source="G_etaparec_nome"
         printDirection="down" maxRecordsPerPage="1" minWidowRecords="1"
         columnMode="no">
          <geometryInfo x="0.00000" y="0.04163" width="7.75000"
           height="4.96777"/>
          <generalLayout verticalElasticity="variable"/>
          <field name="F_etaparec_nome" source="etaparec_nome"
           minWidowLines="1" spacing="0" alignment="start">
            <font face="Arial" size="12"/>
            <geometryInfo x="1.37500" y="0.12451" width="4.00000"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <frame name="M_G_CPF_GRPFR">
            <geometryInfo x="0.00000" y="0.44690" width="7.75000"
             height="3.12598"/>
            <generalLayout verticalElasticity="variable"/>
            <repeatingFrame name="R_G_CPF" source="G_CPF"
             printDirection="down" minWidowRecords="1" columnMode="no">
              <geometryInfo x="0.00000" y="0.69788" width="7.75000"
               height="0.23865"/>
              <generalLayout verticalElasticity="expand"/>
              <field name="F_CPF" source="CPF" minWidowLines="1" spacing="0"
               alignment="start">
                <font face="Arial" size="10"/>
                <geometryInfo x="0.00000" y="0.72900" width="1.18750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_nome" source="nome" minWidowLines="1" spacing="0"
               alignment="start">
                <font face="Arial" size="10"/>
                <geometryInfo x="1.18750" y="0.72900" width="4.56250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_idade" source="idade" minWidowLines="1"
               spacing="0" alignment="center">
                <font face="Arial" size="10"/>
                <geometryInfo x="5.75000" y="0.72900" width="0.50000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_status" source="status" minWidowLines="1"
               spacing="0" alignment="end">
                <font face="Arial" size="10"/>
                <geometryInfo x="6.25000" y="0.72900" width="1.50000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
            </repeatingFrame>
            <frame name="M_G_CPF_FTR">
              <geometryInfo x="0.00000" y="1.04321" width="7.75000"
               height="0.58337"/>
              <advancedLayout printObjectOnPage="lastPage"
               basePrintingOn="anchoringObject"/>
              <visualSettings linePattern="solid"/>
              <field name="Count_ALT" source="count_alt" minWidowLines="1"
               spacing="0" alignment="end">
                <font face="Arial" size="10" bold="yes"/>
                <geometryInfo x="4.67798" y="1.29224" width="1.46790"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="Count_DES" source="count_des" minWidowLines="1"
               spacing="0" alignment="end">
                <font face="Arial" size="10" bold="yes"/>
                <geometryInfo x="6.21960" y="1.29236" width="1.47461"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="Count_n_aval" source="count_n_aval"
               minWidowLines="1" spacing="0" alignment="end">
                <font face="Arial" size="10" bold="yes"/>
                <geometryInfo x="3.12524" y="1.29236" width="1.47461"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="Count_n_tri" source="count_n_tri" minWidowLines="1"
               spacing="0" alignment="end">
                <font face="Arial" size="10" bold="yes"/>
                <geometryInfo x="1.57239" y="1.29224" width="1.47461"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="Count_tri" source="count_tri" minWidowLines="1"
               spacing="0" alignment="end">
                <font face="Arial" size="10" bold="yes"/>
                <geometryInfo x="0.04187" y="1.29260" width="1.47461"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <text name="B_1" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.09399" y="1.06262" width="1.11462"
                 height="0.16663"/>
                <textSegment>
                  <font face="Arial" size="10" bold="yes"/>
                  <string>
                  <![CDATA[Totais por etapa:]]>
                  </string>
                </textSegment>
              </text>
            </frame>
            <frame name="M_G_CPF_HDR">
              <geometryInfo x="0.00000" y="0.44690" width="7.75000"
               height="0.25098"/>
              <advancedLayout printObjectOnPage="allPage"
               basePrintingOn="enclosingObject"/>
              <visualSettings fillPattern="transparent"
               fillBackgroundColor="gray8"/>
              <text name="B_CPF" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.06250" y="0.48962" width="0.81250"
                 height="0.18750"/>
                <textSegment>
                  <font face="Arial" size="10" bold="yes"/>
                  <string>
                  <![CDATA[CPF]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_nome" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="1.18750" y="0.48962" width="0.87500"
                 height="0.18750"/>
                <textSegment>
                  <font face="Arial" size="10" bold="yes"/>
                  <string>
                  <![CDATA[Nome]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_idade" minWidowLines="1">
                <textSettings justify="center" spacing="0"/>
                <geometryInfo x="5.75000" y="0.48962" width="0.50000"
                 height="0.18750"/>
                <textSegment>
                  <font face="Arial" size="10" bold="yes"/>
                  <string>
                  <![CDATA[Idade]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_status" minWidowLines="1">
                <textSettings justify="end" spacing="0"/>
                <geometryInfo x="6.31250" y="0.48962" width="1.37500"
                 height="0.18750"/>
                <textSegment>
                  <font face="Arial" size="10" bold="yes"/>
                  <string>
                  <![CDATA[Status]]>
                  </string>
                </textSegment>
              </text>
              <line name="B_2" arrow="none">
                <geometryInfo x="0.00000" y="0.44690" width="7.75000"
                 height="0.00000"/>
                <visualSettings linePattern="solid"/>
                <points>
                  <point x="0.00000" y="0.44690"/>
                  <point x="7.75000" y="0.44690"/>
                </points>
              </line>
              <line name="B_3" arrow="none">
                <geometryInfo x="0.00000" y="0.69788" width="7.75000"
                 height="0.00000"/>
                <visualSettings linePattern="solid"/>
                <points>
                  <point x="0.00000" y="0.69788"/>
                  <point x="7.75000" y="0.69788"/>
                </points>
              </line>
            </frame>
          </frame>
          <text name="B_etaparec_nome" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="0.00000" y="0.12451" width="1.43750"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Arial" size="12" bold="yes"/>
              <string>
              <![CDATA[Nome da Etapa:]]>
              </string>
            </textSegment>
          </text>
        </repeatingFrame>
      </frame>
    </body>
    <margin>
      <rectangle name="B_5">
        <geometryInfo x="0.36438" y="0.03198" width="7.75024" height="0.77014"
        />
        <visualSettings linePattern="solid"/>
        <points>
          <point x="0.36438" y="0.03198"/>
          <point x="7.75024" y="0.77014"/>
        </points>
      </rectangle>
      <image name="B_4">
        <geometryInfo x="0.43774" y="0.19824" width="1.33337" height="0.40637"
        />
        <visualSettings fillPattern="transparent" fillBackgroundColor="black"
         linePattern="transparent" lineBackgroundColor="black"/>
        <points>
          <point x="0.00000" y="0.00000"/>
          <point x="1.33337" y="0.40637"/>
          <point x="0.43774" y="0.19824"/>
          <point x="1.33337" y="0.40637"/>
        </points>
        <binaryData encoding="hexidecimal" dataId="image.B_4">
          
74946483 93165E00 62007F00 00F1A171 F1B17102 C18112C1 8112D1A1 22D1A132
E1B142F1 C15202D1 6212E172 22F18232 02924212 A25222A2 6232B272 42C28252
D28252E2 9262F2A2 7203B282 13C29223 D2A233E2 C243F2D2 5303E263 13F27323
03833313 93432393 5333A363 43B37353 C38363D3 9373E3A3 83F3B393 04C3A314
D3B324E3 C334F3D3 3404E344 14F35424 04642414 74341474 44248454 34946444
A46454A4 7454B484 64C49474 C49484D4 A494E4B4 A4F4C4A4 05D4B415 E4C415E4
D425F4E4 3505F445 15F45525 05652515 65352575 45358555 35955545 956555A5
7565B585 65C58575 C59585D5 A595E5B5 95E5C5A5 F5C5B506 D5C516E5 D516F5D5
26F5E536 06F53616 F5462606 56261656 36266646 26764636 86665696 76569676
66A68676 B69686C6 A696D6B6 A6E6C6B6 F6D6C607 E6D607E6 E617F6E6 2707F627
07073717 07472717 47372757 37376747 37775747 77675787 67679777 67978777
A78787B7 9787B7A7 97C7B7A7 D7B7A7D7 C7B7E7D7 C7F7D7D7 F7E7D708 F7E71808
F72808F7 28180838 28184828 28483828 58483868 58487868 58887868 88787898
8878A898 88B89898 B8A8A8C8 B8A8D8C8 B8E8D8C8 E8D8D8F8 E8D809F8 E81909F8
19090929 19093929 19392929 49393959 49396959 49695959 79696989 79799989
79A99989 A99999B9 A9A9C9B9 B9D9C9B9 E9D9C9E9 D9D9F9E9 E90AF9F9 1A0AF91A
1A0A2A1A 1A3A2A2A 4A3A3A5A 4A3A6A5A 4A7A6A5A 7A7A6A8A 7A7A9A8A 8AAA9A9A
BAAAAACA BAAADACA BADADACA EADADAFA EAEA0BFA FA1B0BFA 1B1B0B2B 2B1B4B3B
2B4B4B3B 6B5B4B6B 6B5B8B7B 6B8B8B7B 9B9B8BAB AB9BBBBB ABCBCBBB DBDBCBEB
EBDBFBFB EB0CFBFB 0C0CFB1C 0C0C2C1C 1C3C2C2C 4C4C3C5C 5C4C6C6C 5C7C7C6C
8C8C7C9C 9C8CACAC 9CBCBCAC DCCCCCDC DCDCFCEC EC0DFCFC 1D0D0D2D 1D1D3D2D
2D3D3D3D 5D4D4D6D 6D5D8D7D 7D9D8D8D ADAD9DBD BDBDDDCD CDEDEDDD FDFDFD1E
0E0E2E1E 1E3E3E2E 4E4E4E6E 5E5E7E6E 6E8E8E7E 9E9E9EBE AEAECECE BEDEDEDE
FEEEEE0F 0FFE1F1F 1F2F2F2F 4F4F3F5F 5F5F6F6F 6F8F7F7F 9F9F9FAF AFAFBFBF
BFDFDFCF DFDFDFEF EFEFFFFF FF129F40 00000000 00C20000 00005E00 62000080
FF00FF90 C1840B0A 1C388031 A2C58C0B 1A3C7801 32A4C984 1B2A5CB8 8133A6CD
8C1B3A7C F80234A8 C1942142 EB673E2B 93B368C0 9D2396DD AC5CBD75 2D2AE387
5E8B14B4 6D23914B D64ECD1E BA9A1FED B327ED6B 55BA6BDA B983674F AF115B8C
EC710A42 72A28201 000ABA7D 20C023CB 8B2390A5 D3582C01 13A5BC6B DABD7B07
F11BB482 F89D32A2 D2030302 0E5DB218 506105C2 9142CED1 5CE78E89 1AA34C6C
B479E2F5 6D402B41 B8959BB7 21BF5839 5288C04E 23270F0F 1E377AEC A103095E
07A86765 169BF4E9 26BCE9D4 BB6BCE05 3B899A37 8BC4B458 00D7DB20 F0E00683
0811480D 124236CB F6371E4C B8707D67 0BB9C9E0 1DF977D6 E810D063 88BDC09D
FF080EC3 B33821C5 655AB680 F6456903 A969593A 7CF01AF3 C7CEEA5B 29345809
8B480A49 14B8C240 61860E18 80218FA0 82F78611 68E2AFCF 321E4831 69345875
10468A1E 68C1E68E 5550C90F 3FF8F341 EA100478 826A8D12 00504734 1EF34F4E
1A0068A2 AA8D5910 57CC3F2E E8FF843F 4810436D 81C150C6 093C3E48 1BC21594
93746393 1AC33B84 1B80E332 EB80ACD2 E4669B36 F3CD4E17 5873C365 3B147553
699A1675 2605952E 98666B90 C5B8416B 3C3099E6 AD8000E0 AE4394F4 D1C71B95
7E9900C4 07A0F8CF 8F186CA3 A5A698FC 4295CB3B 32821B42 A29E480D 411ECCB8
AE080E7E F9926759 7CB86227 A242C921 6E3B4C6A 2AEA8F38 D3C36A3A 30D99A20
FFA38098 21298E80 023962A6 B861A6E4 8096EA39 29374819 316D1008 00246076
6675CCCA 91B2A8C2 AB821AB2 8AEA8ACE 2B39CE8E E8C05DE3 BD5D6255 EF37DC51
BF00BA52 320E258F BA9B98E0 3B6C481E 070DD668 D555033C F0E3CA0F 00CAD963
14BEF31A 24B1DD0C 1CD63212 F3FAA09D 04B0E38F 023850CF 24BD18C3 412F375C
1B9CE5B6 3A2060B4 877C1395 AB3DC4F2 CB013ED4 E3A5EC3F 483AEB64 AD42F303
7CC22A4A EF4712E8 48390205 3210090B 333BE36E 072510AA 4C5207EC 48103780
08202546 1E4F3D05 74DE4361 A589321A A311CCB0 C5814E0A CFFCE3DE 0E29201D
4C103416 D2A5F075 1C217701 227831A1 44CA4B61 21ED3A54 D3D4AF37 A841E785
FF279032 860515B8 6929CE2A EABCB3AF 30906106 C71E8F71 06481160 A1F60224
CE190ACA 221E718C 67AC149B B3E33500 17600303 1C60424B 08D02DDD 200A10ED
CEA48DD0 F5D92000 6EE8BE86 A1C110A0 84081C80 620C231E D3B286D7 C2F18ECB
8FEC6233 67EB2230 C42A3468 397EC211 12588E48 138EF3CF 4E33F0B3 7EC734D0
33FB0B1C 7C1E74EE 3557C3CE 7BFBE4A3 5E0834B8 31C23F8B C01221E6 1EC3A820
4E19CF3A E78A4C92 4715C886 873AC1BE 8870E36F 1DF8F783 07D01088 0A405289
1887830F 2881CC0A 60D18DD0 EBC40F38 00072473 A1891C06 4E14211A 8A5C03C9
1BD0270A 30E17F0D 7090FF13 C000C707 2863465C 60D187B8 B1280551 FF0270B1
FF678E04 A7451851 FE8C0ED3 09086023 081CB0C5 0030A18D 0C7044C4 24418D0C
0282261B 3CD7091C E144470E D1C9144C A60F1C18 080308F0 17821812 4E1A414C
8E64B30F 116CD0A9 8C78000D 0CD3AE85 7C27C20C 68B640E0 20C60C60 E44F20B1
AE8A70F1 33877C53 200AE057 46201CAB 2768F78A 32C0EF80 32B3E019 58038F1C
31BB8A64 A32C1ED0 674D34F1 99CA3E61 BB8958F6 CA3E590B C75E93EB 15B0828B
38883D83 3EF30914 E9046403 83608A00 A0E80C68 94CD2AA1 8E0A3211 B1902C50
4718C026 886A437A 93D40308 34984200 46023834 0090C80E 70260540 C2E914E0
54EE03F1 5C374650 6D157CC5 09027084 8B20912F 0A88B48A 24712C0F 6CF30F1A
FF50970F 11F15E08 60D2621A 7023C71E C0724854 33CC133C D0EA2738 EF804841
FC041DA8 2A10D0B6 0544932C 8DB09483 01F1340D 6AF25281 D9008300 50860664
34F28CC4 01E423A3 BC0D0ED1 44A325DE 47561012 0C20E20C 891C474F 21F8C50E
32F32F1B 84F30036 19A14B78 A32B1FB8 058022C0 958B48A3 678F054A A55D1838
816C5058 1D59A9AF 2383648C 6860B5AE 55C32008 91A14278 4086A565 C1A75650
EB0706A2 FA1C5174 E72EAA57 CE645188 A87DD06A 3841C400 5CA4FF15 5DEB6D15
E1050F7E F3CF1EF0 E3475BDA BD400030 E51C846B 246F7976 DD0EC2E1 B7953BAF
16F171C2 6856F79D B03C2115 210803DE 605E1E70 43893F28 5855DE60 3011A8C0
FFEE3011 3AB1DE56 D680B0C0 295B3B3C 14BE60B6 1310EC20 794A008C 3C50771A
B500C134 6BA14E70 028D0CE0 8E260341 560D7861 9B86D5D0 6628C0AD 5D0A43A9
07080EC1 79B2E08B 6E3057BD 6DEA8077 3824C5B6 F5E8B3C1 D5830971 DC5C5477
3383B062 0422C19A 48EA02A6 B0B5EEEE 7FF1BD02 34D187AB 34F68620 A0328704
F9ABA3FD A92000D0 C2D8CA97 B4AD5989 6811D1AA 0F2CA062 09B5B1A9 7D2CF28D
3233EBA9 98303603 E18A8E28 61201DA0 66492BE1 106BA6C3 0A061470 6C6F28EF
07789368 C44E2231 9BC13E8D 6413231F 4C26855F E18E8B68 03251788 33C11060
D1070817 EBAA105C EF618301 0F4CA26C C46E23B9 9351CEC5 46E38D1B D0368B2E
FF11F687 20D00402 1821F753 005D8F78 73ACBE8C A20F15C1 5A0E5423 0B12E847
8209F1C7 C4741304 128873C3 13C0C681 4C62C61E C8374623 7CA1CCA6 18778DF8
B28618C0 0AE05B8A 34D86093 8120611E 8EEEE34E 18E0A609 2E806C50 1A104F9F
F8F27E17 F8E2E036 F38E1BE8 D6CC2EB0 F7CFA6F6 3E19181D 2004207E 8A32B1CB
22005044 04306289 1C016A00 90BAEE3A D1FD8668 D2E31088 F2861A4B 16C95CD5
D7C606BD 6818E19B 6706F34F 18F0970B 3EC12E8C 6433E69B 1CB44375 0095CA5B
5610051C 30BF36F1 8F0A78B3 2D13E8E6 8336C1B3 436420A9 B3A07022 1A9B5942
2E736F56 3DEACA1E F1CF065F 83CB17D0 66403471 EA0F4C42 611188A3 4F81382E
FF0E2803 83A5D627 7715C0A8 5BEEF1C1 D458220E 0A50428D 0450E108 00EA8C1A
1CE14C3E 104DB6B6 D0CB6D0B 8D063881 EA0740D1 0C0C40D1 0B004041 0C71C102
A5389F0C EC63761E 0C150B71 00E70603 ACB50000 1083233B 4D0D1481 6D0278C3
C02421E9 0358C208 19C0964D 1A5CA14A 54BC7782 B005C6A7 38BF089F E7F40F2D
EA810C11 AE8003F3 0C129CD6 6FB5FD87 4500518B 049FACB5 EF2F59FC 2CB14196
C82C7754 C01E00DA C55D1978 6E2004A1 E046704C EBAF20E4 022BD19E 886C0265
FBD4D101 59B111F0 32D32C05 7016083A C12E896C 62A90807 22E22E71 F77D060E
36E0DD65 40BFBA00 0A04E00B 0F5882CC 0810F577 24A2FBC5 17FC350C F9FE826B
FF587102 3892C71E A0A30A0C 7DB30137 840B7783 20080450 8C31B679 A657F975
8426D17F 14C034CB 16A89707 A0DE0FF0 40850860 8CF09508 E05080A0 1B060860
8BF02602 F0E08318 4185187F 05400001 00A18B18 C18B181D 1D180280 00BB0508
62202862 87286280 00B10218 FF0E8582 8C18F18F 28000080 6086F0FA 2200F28F
C19380C1 F60EF050 8C906905 18248348 6088C0C6 0FF0E38F F0C08518 018C2844
8F484084 D0B07B38 458B18C5 1B40AF04 28558B58 A28C28DE 09D4B585 58000E10
CE0E085E 05209181 68828918 2506F060 84F0F403 D0058378 4080F0A4 00E0608B
48418D48 4780581B 03A3A682 38D209E0 60852818 8B68B285 088D05C6 78872800
FF0010DC 04186E0D 30D51D88 E1800046 05F03180 E0340BC0 D78448BE 03508B0E
08A78318 C78F9844 85C09D49 68D88E51 250AE0E0 8688698D 18D58608 1E0040E5
13B8D51D 205D0848 4186F0C8 04F7CA82 68D51F10 EA094831 84E05502 804888A8
6089F05B 0840DB03 180A03B0 518DF011 8EC84481 F0390868 D71B381C 1400A308
B0DF0318 560E978E 8E51410E 48408AF0 1B073031 65982381 C1720A90 4F0F485E
0380BA81 C14B8CF8 D20A90FE 04489F0A A0350970 6C0EE0F9 85F0BD0B 90550770
7E0418C9 0C90EE03 19419319 AE0850CE 8AD85185 F07C0C70 A3081004 2F25100D
00320B40 2907D05E 84181A07 40050D29 E29F2903 9139239D 40260A98 6A87D0F8
FE0740D1 0B07587A 00C10040 080BC0E6 84785F0D C0A80940 320F001F 8E514000
10520050 3905D09F 04787F06 C0E70950 060F701A 0AB0DC05 D0CD0DD0 0697D02D
0AC07B01 A0380860 A508608A 0A085181 C0050260 16017927 9160E508 608F0A19
378EF0FE 0DD05C02 B0B90F80 78078068 0A80390E 902B02C0 5D07E034 9879C892
483F02E0 CC07B00A 02908801 89880290 A90CA0EB 01D03E03 F0D896F0 8E0AD09C
0FB08B01 B08B0FB0 BC0BD08E 07F0879A F06E0DC0 1B069068 0C70F605 B9F60970
180A80A9 01B09C01 E07F8348 8C8D892C 93C94C95 C96C97C9 8C99C9AC 9BC9CC9D
C9EC9FC9 0D91D92D 93D94D95 D9248101 00B30000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
        </binaryData>
      </image>
      <line name="B_6" arrow="none">
        <geometryInfo x="1.83362" y="0.03198" width="0.00000" height="0.77014"
        />
        <visualSettings linePattern="solid"/>
        <points>
          <point x="1.83362" y="0.03198"/>
          <point x="1.83362" y="0.80212"/>
        </points>
      </line>
      <line name="B_7" arrow="none">
        <geometryInfo x="6.73035" y="0.03198" width="0.00000" height="0.77014"
        />
        <visualSettings linePattern="solid"/>
        <points>
          <point x="6.73035" y="0.03198"/>
          <point x="6.73035" y="0.80212"/>
        </points>
      </line>
      <field name="F_page_num" source="PageNumber" minWidowLines="1"
       formatMask="900" spacing="0" alignment="start">
        <font face="Arial" size="8"/>
        <geometryInfo x="7.07288" y="0.07361" width="1.00964" height="0.15625"
        />
        <pageNumbering header="yes" main="yes" trailer="yes" startAt="1"
         incrementBy="1" resetAt="report"/>
      </field>
      <text name="B_8" minWidowLines="1">
        <textSettings spacing="0"/>
        <geometryInfo x="6.77112" y="0.08398" width="0.32288" height="0.14587"
        />
        <textSegment>
          <font face="Arial" size="8"/>
          <string>
          <![CDATA[Pág.:]]>
          </string>
        </textSegment>
      </text>
      <line name="B_9" arrow="none">
        <geometryInfo x="6.72913" y="0.29236" width="1.38550" height="0.00000"
        />
        <visualSettings linePattern="solid"/>
        <points>
          <point x="6.72913" y="0.29236"/>
          <point x="8.11462" y="0.29236"/>
        </points>
      </line>
      <text name="B_10" minWidowLines="1">
        <textSettings spacing="0"/>
        <geometryInfo x="6.77161" y="0.35425" width="0.32288" height="0.14587"
        />
        <textSegment>
          <font face="Arial" size="8"/>
          <string>
          <![CDATA[Data:]]>
          </string>
        </textSegment>
      </text>
      <field name="F_data" source="CurrentDate" minWidowLines="1"
       formatMask="dd/mm/rrrr hh24:mi" spacing="0" alignment="start">
        <font face="Arial" size="8"/>
        <geometryInfo x="7.07336" y="0.34387" width="1.00964" height="0.15625"
        />
      </field>
      <line name="B_11" arrow="none">
        <geometryInfo x="6.72961" y="0.57300" width="1.38550" height="0.00000"
        />
        <visualSettings linePattern="solid"/>
        <points>
          <point x="6.72961" y="0.57300"/>
          <point x="8.11511" y="0.57300"/>
        </points>
      </line>
      <text name="B_12" minWidowLines="1">
        <textSettings justify="center" spacing="0"/>
        <geometryInfo x="6.72913" y="0.60461" width="1.38550" height="0.14587"
        />
        <textSegment>
          <font face="Arial" size="8"/>
          <string>
          <![CDATA[recsel_triados_rec.rep]]>
          </string>
        </textSegment>
      </text>
      <field name="F_title" source="P_Title" minWidowLines="1" spacing="0"
       alignment="center">
        <font face="Arial" size="12" bold="yes"/>
        <geometryInfo x="1.85413" y="0.12500" width="4.85413" height="0.62500"
        />
        <generalLayout verticalElasticity="expand"/>
      </field>
    </margin>
  </section>
  </layout>
  <programUnits>
    <function name="afterpform">
      <textSource>
      <![CDATA[function AfterPForm return boolean 
is
  cursor c_rec is
	select 'Recrutamento '||
				 recrutamento_numero||' / '||
         recrutamento_ano||' - '||
	       recrutamento_descricao 
    from recsel_recrutamento
   where recrutamento_id = :p_recrutamento_id;
begin
  open c_rec;
  fetch c_rec into :p_title;
  close c_rec;
  
  :p_title := case :p_status
                when 'TRI' then 'Candidatos Triados'
                when 'N TRI' then 'Candidatos Não Triados'
                when 'DES' then 'Candidatos Desistentes'
                when 'N AVAL' then 'Candidatos Não Avaliados'
                when 'ALT' then 'Candidatos com Alterações de Currículo'
                else 'Todos os Candidatos'
              end||chr(13)||chr(10)||
              :p_title;  
  
  return (TRUE);
end;]]>
      </textSource>
    </function>
  </programUnits>
  <reportPrivate defaultReportType="masterDetail" versionFlags2="0"
   templateName=""/>
  <reportWebSettings>
  <![CDATA[#NULL#]]>
  </reportWebSettings>
</report>
</rw:objects>
-->

<html>

<head>
<meta name="GENERATOR" content="Oracle 10gR2 Reports Developer"/>
<title> Your Title </title>



</head>


<body>

<!-- Data Area Generated by Reports Developer -->
<rw:dataArea id="MGetaparecnomeGRPFR64">
<rw:foreach id="RGetaparecnome641" src="G_etaparec_nome">
<!-- Start GetGroupHeader/n --> <table>
 <caption>  <br>Nome da Etapa <rw:field id="F_etaparec_nome" src="etaparec_nome" breakLevel="RGetaparecnome641" breakValue="&nbsp;"> F_etaparec_nome </rw:field><br>
 </caption>
<!-- End GetGroupHeader/n -->   <tr>
    <td valign="top">
    <table summary="">
     <!-- Header -->
     <thead>
      <tr>
       <th <rw:id id="HBCPF64" asArray="no"/>> CPF </th>
       <th <rw:id id="HBnome64" asArray="no"/>> Nome </th>
       <th <rw:id id="HBemail64" asArray="no"/>> e-mail </th>
       <th <rw:id id="HBidade64" asArray="no"/>> Idade </th>
       <th <rw:id id="HBstatus64" asArray="no"/>> Status </th>
      </tr>
     </thead>
     <!-- Body -->
     <tbody>
      <rw:foreach id="RGCPF641" src="G_CPF">
       <tr>
        <td <rw:headers id="HFCPF64" src="HBCPF64"/>><rw:field id="FCPF64" src="CPF" nullValue="&nbsp;"> F_CPF </rw:field></td>
        <td <rw:headers id="HFnome64" src="HBnome64"/>><rw:field id="Fnome64" src="nome" nullValue="&nbsp;"> F_nome </rw:field></td>
        <td <rw:headers id="HFemail64" src="HBemail64"/>><rw:field id="Femail64" src="email" nullValue="&nbsp;"> F_email </rw:field></td>
        <td <rw:headers id="HFidade64" src="HBidade64"/>><rw:field id="Fidade64" src="idade" nullValue="&nbsp;"> F_idade </rw:field></td>
        <td <rw:headers id="HFstatus64" src="HBstatus64"/>><rw:field id="Fstatus64" src="status" nullValue="&nbsp;"> F_status </rw:field></td>
       </tr>
      </rw:foreach>
     </tbody>
     <tr>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <td <rw:headers id="HFCountstatusPeretaparecnome64" src="HBstatus64"/>>Count: <rw:field id="FCountstatusPeretaparecnome64" src="CountstatusPeretaparec_nome" nullValue="&nbsp;"> F_CountstatusPeretaparec_nome </rw:field></td>
     </tr>
     <tr>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</rw:foreach>
<table summary="">
 <tr>
  <th> Count: <rw:field id="F_CountstatusPerReport" src="CountstatusPerReport" nullValue="&nbsp;"> F_CountstatusPerReport </rw:field></th>
 </tr>
</table>
</rw:dataArea> <!-- id="MGetaparecnomeGRPFR64" -->
<!-- End of Data Area Generated by Reports Developer -->




</body>
</html>

<!--
</rw:report> 
-->
