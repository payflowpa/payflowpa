SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;
SET role '__TAG_MYPIVOT_DB_USERNAME__';

-- SET search_path = public, pg_catalog;
SET search_path = '__TAG_MYPIVOT_DB_SCHEMA__';


CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese AS 
   SELECT 
    subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    sum(subq.num_pag) AS num_pag,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
   FROM ( 
    -- PAGATI
      SELECT 
        mygov_flusso_export.mygov_ente_id,
        date_part('years'::text, mygov_flusso_export.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
        date_part('month'::text, mygov_flusso_export.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
        count(*) AS num_pag,
        sum(mygov_flusso_export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato) AS imp_pag,
        0 AS imp_rend,
        0 AS imp_inc
          FROM 
        mygov_flusso_export
          GROUP BY 
        mygov_ente_id, anno, mese
        UNION
    -- RENDICONTATI
          SELECT 
        mygov_import_export_rendicontazione_tesoreria_completa.mygov_ente_id,
        date_part('years'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_regolamento_r)::int AS anno,
        date_part('month'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_regolamento_r)::int AS mese,
        0 AS num_pag,
        0 AS imp_pag,
        sum(mygov_import_export_rendicontazione_tesoreria_completa.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato_e) AS imp_rend,
        0 AS imp_inc
          FROM 
        mygov_import_export_rendicontazione_tesoreria_completa
          WHERE 
        mygov_import_export_rendicontazione_tesoreria_completa.classificazione_completezza::text = 'RT_IUF'::text
          GROUP BY 
        mygov_ente_id, anno, mese
        UNION
    -- INCASSATI
          SELECT 
        mygov_import_export_rendicontazione_tesoreria_completa.mygov_ente_id,
        date_part('years'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_valuta_t)::int AS anno,
        date_part('month'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_valuta_t)::int AS mese,
        0 AS num_pag,
        0 AS imp_pag,
        0 AS imp_rend,
        sum(mygov_import_export_rendicontazione_tesoreria_completa.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato_e) AS imp_inc
          FROM 
        mygov_import_export_rendicontazione_tesoreria_completa
          WHERE 
        mygov_import_export_rendicontazione_tesoreria_completa.classificazione_completezza::text = 'RT_IUF_TES'::text OR 
        mygov_import_export_rendicontazione_tesoreria_completa.classificazione_completezza::text = 'RT_TES'::text
          GROUP BY 
        mygov_ente_id, anno, mese
  ) subq
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese
WITH NO DATA;

-- Materialized View: vm_statistica_ente_anno_mese_giorno

CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_giorno AS 
   SELECT 
    subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.giorno,
    sum(subq.num_pag) AS num_pag,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
   FROM ( 
    -- PAGATI
      SELECT 
        mygov_flusso_export.mygov_ente_id,
        date_part('years'::text, mygov_flusso_export.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
        date_part('month'::text, mygov_flusso_export.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
        date_part('day'::text, dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS giorno,
        count(*) AS num_pag,
        sum(mygov_flusso_export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato) AS imp_pag,
        0 AS imp_rend,
        0 AS imp_inc
          FROM 
        mygov_flusso_export
          GROUP BY 
        mygov_ente_id, anno, mese, giorno
        UNION
    -- RENDICONTATI
          SELECT 
        mygov_import_export_rendicontazione_tesoreria_completa.mygov_ente_id,
        date_part('years'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_regolamento_r)::int AS anno,
        date_part('month'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_regolamento_r)::int AS mese,
        date_part('day'::text, dt_data_regolamento_r)::int AS giorno,
        0 AS num_pag,
        0 AS imp_pag,
        sum(mygov_import_export_rendicontazione_tesoreria_completa.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato_e) AS imp_rend,
        0 AS imp_inc
          FROM 
        mygov_import_export_rendicontazione_tesoreria_completa
          WHERE 
        mygov_import_export_rendicontazione_tesoreria_completa.classificazione_completezza::text = 'RT_IUF'::text
          GROUP BY 
        mygov_ente_id, anno, mese, giorno
        UNION
    -- INCASSATI
          SELECT 
        mygov_import_export_rendicontazione_tesoreria_completa.mygov_ente_id,
        date_part('years'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_valuta_t)::int AS anno,
        date_part('month'::text, mygov_import_export_rendicontazione_tesoreria_completa.dt_data_valuta_t)::int AS mese,
        date_part('day'::text, dt_data_valuta_t)::int AS giorno,
        0 AS num_pag,
        0 AS imp_pag,
        0 AS imp_rend,
        sum(mygov_import_export_rendicontazione_tesoreria_completa.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato_e) AS imp_inc
          FROM 
        mygov_import_export_rendicontazione_tesoreria_completa
          WHERE 
        mygov_import_export_rendicontazione_tesoreria_completa.classificazione_completezza::text = 'RT_IUF_TES'::text OR 
        mygov_import_export_rendicontazione_tesoreria_completa.classificazione_completezza::text = 'RT_TES'::text
          GROUP BY 
        mygov_ente_id, anno, mese, giorno
  ) subq
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno
WITH NO DATA;

-- Materialized View: vm_statistica_ente_anno_mese_giorno_uff_td
 
CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_giorno_uff_td AS 
  SELECT 
        subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.giorno,
    subq.cod_uff,
        uff.de_ufficio AS de_uff,
    subq.cod_td,
        td.de_tipo AS de_td,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
FROM
     (
      -- PAGATI
    SELECT 
          p.mygov_ente_id,
          date_part('years'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
          date_part('month'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
          date_part('day'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS giorno,
          ad.cod_ufficio AS cod_uff,    
          ad.cod_tipo_dovuto AS cod_td,
          sum(ad.num_importo) AS imp_pag,
          0 AS imp_rend,
          0 AS imp_inc
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id   
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO'
         GROUP BY 
        p.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td
        
      UNION
    
      -- RENDICONTATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_regolamento_r)::int AS anno,
          date_part('month'::text, r.dt_data_regolamento_r)::int AS mese,
          date_part('day'::text, r.dt_data_regolamento_r)::int AS giorno,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          0 AS imp_pag,
          sum(ad.num_importo) AS imp_rend,
          0 AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND r.classificazione_completezza = 'RT_IUF' 
    GROUP BY 
         r.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td
     
      UNION 
     
      -- INCASSATI 
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_valuta_t)::int AS anno,
          date_part('month'::text, r.dt_data_valuta_t)::int AS mese,
          date_part('day'::text, r.dt_data_valuta_t)::int AS giorno,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          0 AS imp_pag,
          0 AS imp_rend,
          sum(ad.num_importo) AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES')
    GROUP BY 
        r.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td
    
     ) as subq

     INNER JOIN mygov_ente_tipo_dovuto AS td ON td.mygov_ente_id = subq.mygov_ente_id AND td.cod_tipo = subq.cod_td

     LEFT JOIN mygov_anagrafica_uff_cap_acc AS uff ON 
            uff.mygov_ente_id = subq.mygov_ente_id AND uff.cod_tipo_dovuto = subq.cod_td AND uff.cod_ufficio = subq.cod_uff
        
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno, subq.cod_uff, de_uff, subq.cod_td, de_td
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno, subq.cod_uff, de_uff, subq.cod_td, de_td
WITH NO DATA;

-- Materialized View: vm_statistica_ente_anno_mese_uff_td

CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_uff_td AS 
  SELECT 
        subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.cod_uff,
        uff.de_ufficio AS de_uff,
    subq.cod_td,
        td.de_tipo AS de_td,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
FROM
     (
      -- PAGATI
    SELECT 
          p.mygov_ente_id,
          date_part('years'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
          date_part('month'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
          ad.cod_ufficio AS cod_uff,    
          ad.cod_tipo_dovuto AS cod_td,
          sum(ad.num_importo) AS imp_pag,
          0 AS imp_rend,
          0 AS imp_inc
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id   
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO'
         GROUP BY 
        p.mygov_ente_id, anno, mese, cod_uff, cod_td
        
      UNION
    
      -- RENDICONTATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_regolamento_r)::int AS anno,
          date_part('month'::text, r.dt_data_regolamento_r)::int AS mese,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          0 AS imp_pag,
          sum(ad.num_importo) AS imp_rend,
          0 AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND r.classificazione_completezza = 'RT_IUF' 
    GROUP BY 
         r.mygov_ente_id, anno, mese, cod_uff, cod_td
     
      UNION 
     
      -- INCASSATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_valuta_t)::int AS anno,
          date_part('month'::text, r.dt_data_valuta_t)::int AS mese,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          0 AS imp_pag,
          0 AS imp_rend,
          sum(ad.num_importo) AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES')
    GROUP BY 
        r.mygov_ente_id, anno, mese, cod_uff, cod_td
    
     ) as subq

     INNER JOIN mygov_ente_tipo_dovuto AS td ON td.mygov_ente_id = subq.mygov_ente_id AND td.cod_tipo = subq.cod_td

     LEFT JOIN mygov_anagrafica_uff_cap_acc AS uff ON 
        uff.mygov_ente_id = subq.mygov_ente_id AND uff.cod_tipo_dovuto = subq.cod_td AND uff.cod_ufficio = subq.cod_uff
        
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.cod_uff, de_uff, subq.cod_td, de_td
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.cod_uff, de_uff, subq.cod_td, de_td
WITH NO DATA;


-- Materialized View: vm_statistica_ente_anno_mese_giorno_uff_td_cap
 
CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_giorno_uff_td_cap AS 
  SELECT 
        subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.giorno,
    subq.cod_uff,
        uff.de_ufficio AS de_uff,
    subq.cod_td,
        td.de_tipo AS de_td,
        subq.cod_cap,
        uff.de_capitolo AS de_cap,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
FROM
     (
      -- PAGATI
    SELECT 
          p.mygov_ente_id,
          date_part('years'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
          date_part('month'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
          date_part('day'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS giorno,
          ad.cod_ufficio AS cod_uff,    
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          sum(ad.num_importo) AS imp_pag,
          0 AS imp_rend,
          0 AS imp_inc
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id 
              
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO'
        GROUP BY 
         p.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td, cod_cap
        
      UNION
    
      -- RENDICONTATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_regolamento_r)::int AS anno,
          date_part('month'::text, r.dt_data_regolamento_r)::int AS mese,
          date_part('day'::text, r.dt_data_regolamento_r)::int AS giorno,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          0 AS imp_pag,
          sum(ad.num_importo) AS imp_rend,
          0 AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND r.classificazione_completezza = 'RT_IUF' 
    GROUP BY 
         r.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td, cod_cap
     
      UNION 
     
      -- INCASSATI 
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_valuta_t)::int AS anno,
          date_part('month'::text, r.dt_data_valuta_t)::int AS mese,
          date_part('day'::text, r.dt_data_valuta_t)::int AS giorno,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          0 AS imp_pag,
          0 AS imp_rend,
          sum(ad.num_importo) AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES')
    GROUP BY 
        r.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td, cod_cap
    
     ) as subq

     INNER JOIN mygov_ente_tipo_dovuto AS td ON td.mygov_ente_id = subq.mygov_ente_id AND td.cod_tipo = subq.cod_td

     LEFT JOIN mygov_anagrafica_uff_cap_acc AS uff ON 
         uff.mygov_ente_id = subq.mygov_ente_id AND uff.cod_ufficio = subq.cod_uff AND uff.cod_tipo_dovuto = subq.cod_td AND 
         uff.cod_capitolo = subq.cod_cap
        
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap
WITH NO DATA;

-- Materialized View: vm_statistica_ente_anno_mese_uff_td_cap
 
CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_uff_td_cap AS 
  SELECT 
        subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.cod_uff,
        uff.de_ufficio AS de_uff,
    subq.cod_td,
        td.de_tipo AS de_td,
        subq.cod_cap,
        uff.de_capitolo AS de_cap,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
FROM
     (
      -- PAGATI
    SELECT 
          p.mygov_ente_id,
          date_part('years'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
          date_part('month'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
          ad.cod_ufficio AS cod_uff,    
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          sum(ad.num_importo) AS imp_pag,
          0 AS imp_rend,
          0 AS imp_inc
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id 
              
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO'
        GROUP BY 
         p.mygov_ente_id, anno, mese, cod_uff, cod_td, cod_cap
        
      UNION
    
      -- RENDICONTATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_regolamento_r)::int AS anno,
          date_part('month'::text, r.dt_data_regolamento_r)::int AS mese,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          0 AS imp_pag,
          sum(ad.num_importo) AS imp_rend,
          0 AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND r.classificazione_completezza = 'RT_IUF' 
    GROUP BY 
         r.mygov_ente_id, anno, mese, cod_uff, cod_td, cod_cap
     
      UNION 
     
      -- INCASSATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_valuta_t)::int AS anno,
          date_part('month'::text, r.dt_data_valuta_t)::int AS mese,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          0 AS imp_pag,
          0 AS imp_rend,
          sum(ad.num_importo) AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES')
    GROUP BY 
        r.mygov_ente_id, anno, mese, cod_uff, cod_td, cod_cap
    
     ) as subq

     INNER JOIN mygov_ente_tipo_dovuto AS td ON td.mygov_ente_id = subq.mygov_ente_id AND td.cod_tipo = subq.cod_td

     LEFT JOIN mygov_anagrafica_uff_cap_acc AS uff ON 
         uff.mygov_ente_id = subq.mygov_ente_id AND uff.cod_tipo_dovuto = subq.cod_td AND uff.cod_ufficio = subq.cod_uff AND 
         uff.cod_capitolo = subq.cod_cap
        
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap
WITH NO DATA;

-- Materialized View: vm_statistica_ente_anno_mese_giorno_uff_td_cap_acc 

CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_giorno_uff_td_cap_acc AS 
  SELECT 
        subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.giorno,
    subq.cod_uff,
        uff.de_ufficio AS de_uff,
    subq.cod_td,
        td.de_tipo AS de_td,
        subq.cod_cap,
        uff.de_capitolo AS de_cap,
        subq.cod_acc,
        uff.de_accertamento AS de_acc,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
FROM
     (
      -- PAGATI
    SELECT 
          p.mygov_ente_id,
          date_part('years'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
          date_part('month'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
          date_part('day'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS giorno,
          ad.cod_ufficio AS cod_uff,    
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          ad.cod_accertamento AS cod_acc,
          sum(ad.num_importo) AS imp_pag,
          0 AS imp_rend,
          0 AS imp_inc
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id 
              
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND ad.cod_accertamento <> 'n/a'
        GROUP BY 
         p.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td, cod_cap, cod_acc
        
      UNION
    
      -- RENDICONTATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_regolamento_r)::int AS anno,
          date_part('month'::text, r.dt_data_regolamento_r)::int AS mese,
          date_part('day'::text, r.dt_data_regolamento_r)::int AS giorno,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          ad.cod_accertamento AS cod_acc,
          0 AS imp_pag,
          sum(ad.num_importo) AS imp_rend,
          0 AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND ad.cod_accertamento <> 'n/a' AND 
         r.classificazione_completezza = 'RT_IUF' 
    GROUP BY 
         r.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td, cod_cap, cod_acc
     
      UNION 
     
      -- INCASSATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_valuta_t)::int AS anno,
          date_part('month'::text, r.dt_data_valuta_t)::int AS mese,
          date_part('day'::text, r.dt_data_valuta_t)::int AS giorno,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          ad.cod_accertamento AS cod_acc,
          0 AS imp_pag,
          0 AS imp_rend,
          sum(ad.num_importo) AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND ad.cod_accertamento <> 'n/a' AND 
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES')
    GROUP BY 
        r.mygov_ente_id, anno, mese, giorno, cod_uff, cod_td, cod_cap, cod_acc
    
     ) as subq

     INNER JOIN mygov_ente_tipo_dovuto AS td ON td.mygov_ente_id = subq.mygov_ente_id AND td.cod_tipo = subq.cod_td

     LEFT JOIN mygov_anagrafica_uff_cap_acc AS uff ON 
         uff.mygov_ente_id = subq.mygov_ente_id AND uff.cod_tipo_dovuto = subq.cod_td AND
         uff.cod_ufficio = subq.cod_uff AND uff.cod_capitolo = subq.cod_cap AND uff.cod_accertamento = subq.cod_acc
        
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap, subq.cod_acc, de_acc
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.giorno, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap, subq.cod_acc, de_acc
WITH NO DATA;

-- Materialized View: vm_statistica_ente_anno_mese_uff_td_cap_acc

CREATE MATERIALIZED VIEW vm_statistica_ente_anno_mese_uff_td_cap_acc AS 
  SELECT 
        subq.mygov_ente_id,
    subq.anno,
    subq.mese,
    subq.cod_uff,
        uff.de_ufficio AS de_uff,
    subq.cod_td,
        td.de_tipo AS de_td,
        subq.cod_cap,
        uff.de_capitolo AS de_cap,
        subq.cod_acc,
        uff.de_accertamento AS de_acc,
    sum(subq.imp_pag) AS imp_pag,
    sum(subq.imp_rend) AS imp_rend,
    sum(subq.imp_inc) AS imp_inc
FROM
     (
      -- PAGATI
    SELECT 
          p.mygov_ente_id,
          date_part('years'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS anno,
          date_part('month'::text, p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::int AS mese,
          ad.cod_ufficio AS cod_uff,    
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          ad.cod_accertamento AS cod_acc,
          sum(ad.num_importo) AS imp_pag,
          0 AS imp_rend,
          0 AS imp_inc
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id 
              
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND ad.cod_accertamento <> 'n/a'
        GROUP BY 
         p.mygov_ente_id, anno, mese, cod_uff, cod_td, cod_cap, cod_acc
        
      UNION
    
      -- RENDICONTATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_regolamento_r)::int AS anno,
          date_part('month'::text, r.dt_data_regolamento_r)::int AS mese,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          ad.cod_accertamento AS cod_acc,
          0 AS imp_pag,
          sum(ad.num_importo) AS imp_rend,
          0 AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND ad.cod_accertamento <> 'n/a' AND 
         r.classificazione_completezza = 'RT_IUF' 
    GROUP BY 
         r.mygov_ente_id, anno, mese, cod_uff, cod_td, cod_cap, cod_acc
     
      UNION 
     
      -- INCASSATI
    SELECT 
          r.mygov_ente_id,
          date_part('years'::text, r.dt_data_valuta_t)::int AS anno,
          date_part('month'::text, r.dt_data_valuta_t)::int AS mese,
          ad.cod_ufficio AS cod_uff,
          ad.cod_tipo_dovuto AS cod_td,
          ad.cod_capitolo AS cod_cap,
          ad.cod_accertamento AS cod_acc,
          0 AS imp_pag,
          0 AS imp_rend,
          sum(ad.num_importo) AS imp_inc
    FROM
          mygov_import_export_rendicontazione_tesoreria_completa AS r 

          INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
          INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

          INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
          INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND ad.cod_accertamento <> 'n/a' AND 
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES')
    GROUP BY 
        r.mygov_ente_id, anno, mese, cod_uff, cod_td, cod_cap, cod_acc
    
     ) as subq

     INNER JOIN mygov_ente_tipo_dovuto AS td ON td.mygov_ente_id = subq.mygov_ente_id AND td.cod_tipo = subq.cod_td

     LEFT JOIN mygov_anagrafica_uff_cap_acc AS uff ON 
         uff.mygov_ente_id = subq.mygov_ente_id AND uff.cod_tipo_dovuto = subq.cod_td AND
         uff.cod_ufficio = subq.cod_uff AND uff.cod_capitolo = subq.cod_cap AND
         uff.cod_accertamento = subq.cod_acc
        
  GROUP BY subq.mygov_ente_id, subq.anno, subq.mese, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap, subq.cod_acc, de_acc
  ORDER BY subq.mygov_ente_id, subq.anno, subq.mese, subq.cod_uff, de_uff, subq.cod_td, de_td, subq.cod_cap, de_cap, subq.cod_acc, de_acc
WITH NO DATA;


-- Function: get_dettaglio_pagamenti_cruscotto

CREATE OR REPLACE FUNCTION get_dettaglio_pagamenti_cruscotto(_anno integer, _mese integer, _giorno integer, _cod_ufficio character varying, _cod_dovuto character varying, _cod_capitolo character varying, _ente_id bigint, _cod_accertamento character varying)
  RETURNS SETOF character varying AS
$BODY$

SELECT DISTINCT(iud) as iud      
FROM
     (
       -- PAGATI
    SELECT 
         DISTINCT(p.cod_iud) as iud
    FROM 
        mygov_flusso_export AS p 
        
        INNER JOIN mygov_accertamento_dettaglio AS ad ON p.cod_iud = ad.cod_iud AND p.cod_tipo_dovuto = ad.cod_tipo_dovuto

        INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

        INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
        INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND p.mygov_ente_id = e.mygov_ente_id
    WHERE 
         /* ACCERTAMENTI CHIUSI */
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 

         /* ANNO */
         CASE WHEN ($1 IS NOT NULL) THEN EXTRACT(YEAR FROM p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::integer = $1 ELSE true END AND  

         /* MESE */
         CASE WHEN ($2 IS NOT NULL) THEN EXTRACT(MONTH FROM p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::integer = $2 ELSE true END AND 

         /* GIORNO */
         CASE WHEN ($3 IS NOT NULL) THEN EXTRACT(DAY FROM p.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento)::integer = $3 ELSE true END AND   
          
         /* CODICE UFFICIO */
         CASE WHEN ($4 IS NOT NULL) THEN ad.cod_ufficio = $4 ELSE true END AND
         
         /* CODICE DOVUTO */
         CASE WHEN ($5 IS NOT NULL) THEN p.cod_tipo_dovuto = $5 AND ad.cod_tipo_dovuto = $5 ELSE true END AND

         /* CODICE CAPITOLO */
         CASE WHEN ($6 IS NOT NULL) THEN ad.cod_capitolo = $6 ELSE true END AND
         
         /* ENTE ID */
         CASE WHEN ($7 IS NOT NULL) THEN p.mygov_ente_id = $7 AND e.mygov_ente_id = $7 ELSE true END AND

         /* CODICE ACCERTAMENTO */
         CASE WHEN ($8 IS NOT NULL) THEN ad.cod_accertamento = $8 ELSE true END 
        
      UNION
    
      -- RENDICONTATI
    SELECT 
         DISTINCT(r.cod_iud_e) AS iud
    FROM
         mygov_import_export_rendicontazione_tesoreria_completa AS r 

         INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto

         INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id 

         INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id 

         INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
         /* ACCERTAMENTI CHIUSI */
         st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 
         
         /* CLASSIFICAZIONE */
         r.classificazione_completezza = 'RT_IUF' AND
         
         /* ANNO */
         CASE WHEN ($1 IS NOT NULL) THEN EXTRACT(YEAR FROM r.dt_data_regolamento_r)::integer = $1 ELSE true END AND 

         /* MESE */
         CASE WHEN ($2 IS NOT NULL) THEN EXTRACT(MONTH FROM r.dt_data_regolamento_r)::integer = $2 ELSE true END AND    

         /* GIORNO */
         CASE WHEN ($3 IS NOT NULL) THEN EXTRACT(DAY FROM r.dt_data_regolamento_r)::integer = $3 ELSE true END AND  
          
         /* CODICE UFFICIO */
         CASE WHEN ($4 IS NOT NULL) THEN ad.cod_ufficio = $4 ELSE true END AND
         
         /* CODICE DOVUTO */
         CASE WHEN ($5 IS NOT NULL) THEN r.cod_tipo_dovuto_e = $5 AND ad.cod_tipo_dovuto = $5 ELSE true END AND

         /* CODICE CAPITOLO */
         CASE WHEN ($6 IS NOT NULL) THEN ad.cod_capitolo = $6 ELSE true END AND
         
         /* ENTE ID */
         CASE WHEN ($7 IS NOT NULL) THEN e.mygov_ente_id = $7 AND e.mygov_ente_id = $7 ELSE true END AND

         /* CODICE ACCERTAMENTO */
         CASE WHEN ($8 IS NOT NULL) THEN ad.cod_accertamento = $8 ELSE true END 
      UNION 
     
      -- INCASSATI 
    SELECT 
          DISTINCT(r.cod_iud_e) AS iud
    FROM
         mygov_import_export_rendicontazione_tesoreria_completa AS r 

         INNER JOIN mygov_accertamento_dettaglio AS ad ON r.cod_iud_e = ad.cod_iud AND r.cod_tipo_dovuto_e = ad.cod_tipo_dovuto
        
         INNER JOIN mygov_accertamento AS a ON a.mygov_accertamento_id = ad.mygov_accertamento_id

         INNER JOIN mygov_anagrafica_stato AS st ON st.mygov_anagrafica_stato_id = a.mygov_anagrafica_stato_id
        
         INNER JOIN mygov_ente e ON e.cod_ipa_ente = ad.cod_ipa_ente AND r.mygov_ente_id = e.mygov_ente_id 
    WHERE 
        /* ACCERTAMENTI CHIUSI */
        st.de_tipo_stato = 'ACCERTAMENTO' AND st.cod_stato = 'CHIUSO' AND 

        /* CLASSSIFICAZIONE */
        (r.classificazione_completezza = 'RT_IUF_TES' OR r.classificazione_completezza = 'RT_TES') AND

        /* ANNO */
        CASE WHEN ($1 IS NOT NULL) THEN EXTRACT(YEAR FROM r.dt_data_valuta_t)::integer = $1 ELSE true END AND   

        /* MESE */
        CASE WHEN ($2 IS NOT NULL) THEN EXTRACT(MONTH FROM r.dt_data_valuta_t)::integer = $2 ELSE true END AND  

        /* GIORNO */
        CASE WHEN ($3 IS NOT NULL) THEN EXTRACT(DAY FROM r.dt_data_valuta_t)::integer = $3 ELSE true END AND    
          
        /* CODICE UFFICIO */
        CASE WHEN ($4 IS NOT NULL) THEN ad.cod_ufficio = $4 ELSE true END AND
         
        /* CODICE DOVUTO */
        CASE WHEN ($5 IS NOT NULL) THEN r.cod_tipo_dovuto_e = $5 AND ad.cod_tipo_dovuto = $5 ELSE true END AND

        /* CODICE CAPITOLO */
        CASE WHEN ($6 IS NOT NULL) THEN ad.cod_capitolo = $6 ELSE true END AND
         
        /* ENTE ID */
        CASE WHEN ($7 IS NOT NULL) THEN r.mygov_ente_id = $7 AND e.mygov_ente_id = $7 ELSE true END AND

        /* CODICE ACCERTAMENTO */
        CASE WHEN ($8 IS NOT NULL) THEN ad.cod_accertamento = $8 ELSE true END 
         
     ) as subq
 ORDER BY subq.iud   
   
$BODY$
  LANGUAGE sql STABLE
  COST 100
  ROWS 1000;

DROP VIEW v_mygov_import_export_rendicontazione_tesoreria_completa;

ALTER TABLE mygov_flusso_tesoreria ALTER COLUMN de_anno_bolletta TYPE CHARACTER VARYING(4);
ALTER TABLE mygov_flusso_tesoreria ALTER COLUMN cod_bolletta TYPE CHARACTER VARYING(7);

CREATE OR REPLACE VIEW v_mygov_import_export_rendicontazione_tesoreria_completa AS 
 SELECT COALESCE(import.mygov_ente_id, export.mygov_ente_id, rendicontazione.mygov_ente_id, tesoreria_iuf.mygov_ente_id, tesoreria_iuv.mygov_ente_id, tesoreria_f2k_iuf.mygov_ente_id, tesoreria_f2k_iuv.mygov_ente_id, tesoreria_f2k.mygov_ente_id) AS mygov_ente_id,
    COALESCE(import.cod_rp_silinviarp_id_univoco_versamento, export.cod_rp_silinviarp_id_univoco_versamento, rendicontazione.cod_dati_sing_pagam_identificativo_univoco_versamento, tesoreria_iuv.cod_id_univoco_versamento, tesoreria_f2k_iuv.cod_id_univoco_versamento, 'n/a'::character varying)::character varying(35) AS codice_iuv,
    COALESCE(export.cod_e_dati_pag_dati_sing_pag_id_univoco_riscoss, rendicontazione.cod_dati_sing_pagam_identificativo_univoco_riscossione, 'n/a'::character varying)::character varying(35) AS identificativo_univoco_riscossione,
    COALESCE(rendicontazione.cod_identificativo_flusso, tesoreria_iuf.cod_id_univoco_flusso, tesoreria_f2k_iuf.cod_id_univoco_flusso, 'n/a'::character varying)::character varying(35) AS identificativo_flusso_rendicontazione,
    import.mygov_ente_id AS mygov_ente_id_i,
    import.mygov_manage_flusso_id AS mygov_manage_flusso_id_i,
    import.cod_iud AS cod_iud_i,
    import.cod_rp_silinviarp_id_univoco_versamento AS cod_rp_silinviarp_id_univoco_versamento_i,
    import.cod_rp_sogg_pag_id_univ_pag_tipo_id_univoco AS cod_rp_sogg_pag_id_univ_pag_tipo_id_univoco_i,
    import.cod_rp_sogg_pag_id_univ_pag_codice_id_univoco AS cod_rp_sogg_pag_id_univ_pag_codice_id_univoco_i,
    import.de_rp_sogg_pag_anagrafica_pagatore AS de_rp_sogg_pag_anagrafica_pagatore_i,
    import.de_rp_sogg_pag_indirizzo_pagatore AS de_rp_sogg_pag_indirizzo_pagatore_i,
    import.de_rp_sogg_pag_civico_pagatore AS de_rp_sogg_pag_civico_pagatore_i,
    import.cod_rp_sogg_pag_cap_pagatore AS cod_rp_sogg_pag_cap_pagatore_i,
    import.de_rp_sogg_pag_localita_pagatore AS de_rp_sogg_pag_localita_pagatore_i,
    import.de_rp_sogg_pag_provincia_pagatore AS de_rp_sogg_pag_provincia_pagatore_i,
    import.cod_rp_sogg_pag_nazione_pagatore AS cod_rp_sogg_pag_nazione_pagatore_i,
    import.de_rp_sogg_pag_email_pagatore AS de_rp_sogg_pag_email_pagatore_i,
    import.dt_rp_dati_vers_data_esecuzione_pagamento AS dt_rp_dati_vers_data_esecuzione_pagamento_i,
    import.cod_rp_dati_vers_tipo_versamento AS cod_rp_dati_vers_tipo_versamento_i,
    import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento AS num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento_i,
    import.num_rp_dati_vers_dati_sing_vers_commissione_carico_pa AS num_rp_dati_vers_dati_sing_vers_commissione_carico_pa_i,
    import.de_rp_dati_vers_dati_sing_vers_causale_versamento AS de_rp_dati_vers_dati_sing_vers_causale_versamento_i,
    import.de_rp_dati_vers_dati_sing_vers_dati_specifici_riscossione AS de_rp_dati_vers_dati_sing_vers_dati_specifici_riscossione_i,
    import.cod_tipo_dovuto AS cod_tipo_dovuto_i,
    import.bilancio AS bilancio_i,
    import.dt_acquisizione AS dt_acquisizione_i,
    export.mygov_ente_id AS mygov_ente_id_e,
    export.mygov_manage_flusso_id AS mygov_manage_flusso_id_e,
    export.de_nome_flusso AS de_nome_flusso_e,
    export.num_riga_flusso AS num_riga_flusso_e,
    export.cod_iud AS cod_iud_e,
    export.cod_rp_silinviarp_id_univoco_versamento AS cod_rp_silinviarp_id_univoco_versamento_e,
    export.de_e_versione_oggetto AS de_e_versione_oggetto_e,
    export.cod_e_dom_id_dominio AS cod_e_dom_id_dominio_e,
    export.cod_e_dom_id_stazione_richiedente AS cod_e_dom_id_stazione_richiedente_e,
    export.cod_e_id_messaggio_ricevuta AS cod_e_id_messaggio_ricevuta_e,
    export.dt_e_data_ora_messaggio_ricevuta AS dt_e_data_ora_messaggio_ricevuta_e,
    export.cod_e_riferimento_messaggio_richiesta AS cod_e_riferimento_messaggio_richiesta_e,
    export.dt_e_riferimento_data_richiesta AS dt_e_riferimento_data_richiesta_e,
    export.cod_e_istit_att_id_univ_att_tipo_id_univoco AS cod_e_istit_att_id_univ_att_tipo_id_univoco_e,
    export.cod_e_istit_att_id_univ_att_codice_id_univoco AS cod_e_istit_att_id_univ_att_codice_id_univoco_e,
    export.de_e_istit_att_denominazione_attestante AS de_e_istit_att_denominazione_attestante_e,
    export.cod_e_istit_att_codice_unit_oper_attestante AS cod_e_istit_att_codice_unit_oper_attestante_e,
    export.de_e_istit_att_denom_unit_oper_attestante AS de_e_istit_att_denom_unit_oper_attestante_e,
    export.de_e_istit_att_indirizzo_attestante AS de_e_istit_att_indirizzo_attestante_e,
    export.de_e_istit_att_civico_attestante AS de_e_istit_att_civico_attestante_e,
    export.cod_e_istit_att_cap_attestante AS cod_e_istit_att_cap_attestante_e,
    export.de_e_istit_att_localita_attestante AS de_e_istit_att_localita_attestante_e,
    export.de_e_istit_att_provincia_attestante AS de_e_istit_att_provincia_attestante_e,
    export.cod_e_istit_att_nazione_attestante AS cod_e_istit_att_nazione_attestante_e,
    export.cod_e_ente_benef_id_univ_benef_tipo_id_univoco AS cod_e_ente_benef_id_univ_benef_tipo_id_univoco_e,
    export.cod_e_ente_benef_id_univ_benef_codice_id_univoco AS cod_e_ente_benef_id_univ_benef_codice_id_univoco_e,
    export.de_e_ente_benef_denominazione_beneficiario AS de_e_ente_benef_denominazione_beneficiario_e,
    export.cod_e_ente_benef_codice_unit_oper_beneficiario AS cod_e_ente_benef_codice_unit_oper_beneficiario_e,
    export.de_e_ente_benef_denom_unit_oper_beneficiario AS de_e_ente_benef_denom_unit_oper_beneficiario_e,
    export.de_e_ente_benef_indirizzo_beneficiario AS de_e_ente_benef_indirizzo_beneficiario_e,
    export.de_e_ente_benef_civico_beneficiario AS de_e_ente_benef_civico_beneficiario_e,
    export.cod_e_ente_benef_cap_beneficiario AS cod_e_ente_benef_cap_beneficiario_e,
    export.de_e_ente_benef_localita_beneficiario AS de_e_ente_benef_localita_beneficiario_e,
    export.de_e_ente_benef_provincia_beneficiario AS de_e_ente_benef_provincia_beneficiario_e,
    export.cod_e_ente_benef_nazione_beneficiario AS cod_e_ente_benef_nazione_beneficiario_e,
    export.cod_e_sogg_vers_id_univ_vers_tipo_id_univoco AS cod_e_sogg_vers_id_univ_vers_tipo_id_univoco_e,
    export.cod_e_sogg_vers_id_univ_vers_codice_id_univoco AS cod_e_sogg_vers_id_univ_vers_codice_id_univoco_e,
    export.cod_e_sogg_vers_anagrafica_versante AS cod_e_sogg_vers_anagrafica_versante_e,
    export.de_e_sogg_vers_indirizzo_versante AS de_e_sogg_vers_indirizzo_versante_e,
    export.de_e_sogg_vers_civico_versante AS de_e_sogg_vers_civico_versante_e,
    export.cod_e_sogg_vers_cap_versante AS cod_e_sogg_vers_cap_versante_e,
    export.de_e_sogg_vers_localita_versante AS de_e_sogg_vers_localita_versante_e,
    export.de_e_sogg_vers_provincia_versante AS de_e_sogg_vers_provincia_versante_e,
    export.cod_e_sogg_vers_nazione_versante AS cod_e_sogg_vers_nazione_versante_e,
    export.de_e_sogg_vers_email_versante AS de_e_sogg_vers_email_versante_e,
    export.cod_e_sogg_pag_id_univ_pag_tipo_id_univoco AS cod_e_sogg_pag_id_univ_pag_tipo_id_univoco_e,
    export.cod_e_sogg_pag_id_univ_pag_codice_id_univoco AS cod_e_sogg_pag_id_univ_pag_codice_id_univoco_e,
    export.cod_e_sogg_pag_anagrafica_pagatore AS cod_e_sogg_pag_anagrafica_pagatore_e,
    export.de_e_sogg_pag_indirizzo_pagatore AS de_e_sogg_pag_indirizzo_pagatore_e,
    export.de_e_sogg_pag_civico_pagatore AS de_e_sogg_pag_civico_pagatore_e,
    export.cod_e_sogg_pag_cap_pagatore AS cod_e_sogg_pag_cap_pagatore_e,
    export.de_e_sogg_pag_localita_pagatore AS de_e_sogg_pag_localita_pagatore_e,
    export.de_e_sogg_pag_provincia_pagatore AS de_e_sogg_pag_provincia_pagatore_e,
    export.cod_e_sogg_pag_nazione_pagatore AS cod_e_sogg_pag_nazione_pagatore_e,
    export.de_e_sogg_pag_email_pagatore AS de_e_sogg_pag_email_pagatore_e,
    export.cod_e_dati_pag_codice_esito_pagamento AS cod_e_dati_pag_codice_esito_pagamento_e,
    export.num_e_dati_pag_importo_totale_pagato AS num_e_dati_pag_importo_totale_pagato_e,
    export.cod_e_dati_pag_id_univoco_versamento AS cod_e_dati_pag_id_univoco_versamento_e,
    export.cod_e_dati_pag_codice_contesto_pagamento AS cod_e_dati_pag_codice_contesto_pagamento_e,
    export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato AS num_e_dati_pag_dati_sing_pag_singolo_importo_pagato_e,
    export.de_e_dati_pag_dati_sing_pag_esito_singolo_pagamento AS de_e_dati_pag_dati_sing_pag_esito_singolo_pagamento_e,
    export.dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento AS dt_e_dati_pag_dati_sing_pag_data_esito_singolo_pagamento_e,
    export.cod_e_dati_pag_dati_sing_pag_id_univoco_riscoss AS cod_e_dati_pag_dati_sing_pag_id_univoco_riscoss_e,
    export.de_e_dati_pag_dati_sing_pag_causale_versamento AS de_e_dati_pag_dati_sing_pag_causale_versamento_e,
    export.de_e_dati_pag_dati_sing_pag_dati_specifici_riscossione AS de_e_dati_pag_dati_sing_pag_dati_specifici_riscossione_e,
    export.cod_tipo_dovuto AS cod_tipo_dovuto_e,
    export.dt_acquisizione AS dt_acquisizione_e,
    export.indice_dati_singolo_pagamento AS indice_dati_singolo_pagamento_e,
    export.bilancio AS bilancio_e,
    rendicontazione.mygov_ente_id AS mygov_ente_id_r,
    rendicontazione.mygov_manage_flusso_id AS mygov_manage_flusso_id_r,
    rendicontazione.versione_oggetto AS versione_oggetto_r,
    rendicontazione.cod_identificativo_flusso AS cod_identificativo_flusso_r,
    rendicontazione.dt_data_ora_flusso AS dt_data_ora_flusso_r,
    rendicontazione.cod_identificativo_univoco_regolamento AS cod_identificativo_univoco_regolamento_r,
    rendicontazione.dt_data_regolamento AS dt_data_regolamento_r,
    rendicontazione.cod_ist_mitt_id_univ_mitt_tipo_identificativo_univoco AS cod_ist_mitt_id_univ_mitt_tipo_identificativo_univoco_r,
    rendicontazione.cod_ist_mitt_id_univ_mitt_codice_identificativo_univoco AS cod_ist_mitt_id_univ_mitt_codice_identificativo_univoco_r,
    rendicontazione.de_ist_mitt_denominazione_mittente AS de_ist_mitt_denominazione_mittente_r,
    rendicontazione.cod_ist_ricev_id_univ_ricev_tipo_identificativo_univoco AS cod_ist_ricev_id_univ_ricev_tipo_identificativo_univoco_r,
    rendicontazione.cod_ist_ricev_id_univ_ricev_codice_identificativo_univoco AS cod_ist_ricev_id_univ_ricev_codice_identificativo_univoco_r,
    rendicontazione.de_ist_ricev_denominazione_ricevente AS de_ist_ricev_denominazione_ricevente_r,
    rendicontazione.num_numero_totale_pagamenti AS num_numero_totale_pagamenti_r,
    rendicontazione.num_importo_totale_pagamenti AS num_importo_totale_pagamenti_r,
    rendicontazione.cod_dati_sing_pagam_identificativo_univoco_versamento AS cod_dati_sing_pagam_identificativo_univoco_versamento_r,
    rendicontazione.cod_dati_sing_pagam_identificativo_univoco_riscossione AS cod_dati_sing_pagam_identificativo_univoco_riscossione_r,
    rendicontazione.num_dati_sing_pagam_singolo_importo_pagato AS num_dati_sing_pagam_singolo_importo_pagato_r,
    rendicontazione.cod_dati_sing_pagam_codice_esito_singolo_pagamento AS cod_dati_sing_pagam_codice_esito_singolo_pagamento_r,
    rendicontazione.dt_dati_sing_pagam_data_esito_singolo_pagamento AS dt_dati_sing_pagam_data_esito_singolo_pagamento_r,
    rendicontazione.dt_acquisizione AS dt_acquisizione_r,
    rendicontazione.indice_dati_singolo_pagamento AS indice_dati_singolo_pagamento_r,
    COALESCE(tesoreria_iuf.mygov_ente_id, tesoreria_iuv.mygov_ente_id, tesoreria_f2k_iuf.mygov_ente_id, tesoreria_f2k_iuv.mygov_ente_id, tesoreria_f2k.mygov_ente_id) AS mygov_ente_id_t,
    COALESCE(tesoreria_iuf.mygov_manage_flusso_id, tesoreria_iuv.mygov_manage_flusso_id) AS mygov_manage_flusso_id_t,
    COALESCE(tesoreria_iuf.cod_abi, tesoreria_iuv.cod_abi, tesoreria_f2k_iuf.cod_abi, tesoreria_f2k_iuv.cod_abi, tesoreria_f2k.cod_abi) AS cod_abi_t,
    COALESCE(tesoreria_iuf.cod_cab, tesoreria_iuv.cod_cab, tesoreria_f2k_iuf.cod_cab, tesoreria_f2k_iuv.cod_cab, tesoreria_f2k.cod_cab) AS cod_cab_t,
    COALESCE(tesoreria_iuf.cod_conto, tesoreria_iuv.cod_conto, tesoreria_f2k_iuf.cod_conto, tesoreria_f2k_iuv.cod_conto, tesoreria_f2k.cod_conto) AS cod_conto_t,
    COALESCE(tesoreria_iuf.cod_divisa, tesoreria_iuv.cod_divisa) AS cod_divisa_t,
    COALESCE(tesoreria_iuf.dt_data_contabile, tesoreria_iuv.dt_data_contabile, tesoreria_f2k_iuf.dt_bolletta, tesoreria_f2k_iuv.dt_bolletta, tesoreria_f2k.dt_bolletta) AS dt_data_contabile_t,
    COALESCE(tesoreria_iuf.dt_data_valuta, tesoreria_iuv.dt_data_valuta, tesoreria_f2k_iuf.dt_data_valuta_regione, tesoreria_f2k_iuv.dt_data_valuta_regione, tesoreria_f2k.dt_data_valuta_regione) AS dt_data_valuta_t,
    COALESCE(tesoreria_iuf.num_importo, tesoreria_iuv.num_importo, tesoreria_f2k_iuf.num_ip_bolletta, tesoreria_f2k_iuv.num_ip_bolletta, tesoreria_f2k.num_ip_bolletta) AS num_importo_t,
    COALESCE(tesoreria_iuf.cod_segno, tesoreria_iuv.cod_segno) AS cod_segno_t,
    COALESCE(tesoreria_iuf.de_causale, tesoreria_iuv.de_causale, tesoreria_f2k_iuf.de_causale::text, tesoreria_f2k_iuv.de_causale::text, tesoreria_f2k.de_causale::text) AS de_causale_t,
    COALESCE(tesoreria_iuf.cod_numero_assegno, tesoreria_iuv.cod_numero_assegno) AS cod_numero_assegno_t,
    COALESCE(tesoreria_iuf.cod_riferimento_banca, tesoreria_iuv.cod_riferimento_banca) AS cod_riferimento_banca_t,
    COALESCE(tesoreria_iuf.cod_riferimento_cliente, tesoreria_iuv.cod_riferimento_cliente) AS cod_riferimento_cliente_t,
    COALESCE(tesoreria_iuf.dt_data_ordine, tesoreria_iuv.dt_data_ordine) AS dt_data_ordine_t,
    COALESCE(tesoreria_iuf.de_descrizione_ordinante, tesoreria_iuv.de_descrizione_ordinante, tesoreria_f2k_iuf.de_cognome::text, tesoreria_f2k_iuv.de_cognome::text, tesoreria_f2k.de_cognome::text) AS de_descrizione_ordinante_t,
    COALESCE(tesoreria_iuf.cod_bi2, tesoreria_iuv.cod_bi2) AS cod_bi2_t,
    COALESCE(tesoreria_iuf.cod_be1, tesoreria_iuv.cod_be1) AS cod_be1_t,
    COALESCE(tesoreria_iuf.cod_ib1, tesoreria_iuv.cod_ib1) AS cod_ib1_t,
    COALESCE(tesoreria_iuf.cod_ib2, tesoreria_iuv.cod_ib2) AS cod_ib2_t,
    COALESCE(tesoreria_iuf.cod_ib4, tesoreria_iuv.cod_ib4) AS cod_ib4_t,
    COALESCE(tesoreria_iuf.cod_tid, tesoreria_iuv.cod_tid) AS cod_tid_t,
    COALESCE(tesoreria_iuf.cod_dte, tesoreria_iuv.cod_dte) AS cod_dte_t,
    COALESCE(tesoreria_iuf.cod_dtn, tesoreria_iuv.cod_dtn) AS cod_dtn_t,
    COALESCE(tesoreria_iuf.cod_eri, tesoreria_iuv.cod_eri) AS cod_eri_t,
    COALESCE(tesoreria_iuf.cod_im2, tesoreria_iuv.cod_im2) AS cod_im2_t,
    COALESCE(tesoreria_iuf.cod_ma2, tesoreria_iuv.cod_ma2) AS cod_ma2_t,
    COALESCE(tesoreria_iuf.cod_ri3, tesoreria_iuv.cod_ri3) AS cod_ri3_t,
    COALESCE(tesoreria_iuf.cod_or1, tesoreria_iuv.cod_or1, tesoreria_f2k_iuf.de_cognome::text, tesoreria_f2k_iuv.de_cognome::text, tesoreria_f2k.de_cognome::text) AS cod_or1_t,
    COALESCE(tesoreria_iuf.cod_sc2, tesoreria_iuv.cod_sc2) AS cod_sc2_t,
    COALESCE(tesoreria_iuf.cod_tr1, tesoreria_iuv.cod_tr1) AS cod_tr1_t,
    COALESCE(tesoreria_iuf.cod_sec, tesoreria_iuv.cod_sec) AS cod_sec_t,
    COALESCE(tesoreria_iuf.cod_ior, tesoreria_iuv.cod_ior) AS cod_ior_t,
    COALESCE(tesoreria_iuf.cod_id_univoco_flusso, tesoreria_f2k_iuf.cod_id_univoco_flusso, tesoreria_f2k_iuv.cod_id_univoco_flusso, tesoreria_f2k.cod_id_univoco_flusso) AS cod_id_univoco_flusso_t,
    COALESCE(tesoreria_iuv.cod_id_univoco_versamento, tesoreria_f2k_iuf.cod_id_univoco_versamento, tesoreria_f2k_iuv.cod_id_univoco_versamento, tesoreria_f2k.cod_id_univoco_versamento) AS cod_id_univoco_versamento_t,
    COALESCE(tesoreria_iuf.dt_acquisizione::timestamp without time zone, tesoreria_iuv.dt_acquisizione::timestamp without time zone, tesoreria_f2k_iuf.dt_ultima_modifica, tesoreria_f2k_iuv.dt_ultima_modifica, tesoreria_f2k.dt_ultima_modifica) AS dt_acquisizione_t,
    COALESCE(tesoreria_f2k_iuf.de_anno_bolletta, tesoreria_f2k_iuv.de_anno_bolletta, tesoreria_f2k.de_anno_bolletta) AS de_anno_bolletta_t,
    COALESCE(tesoreria_f2k_iuf.cod_bolletta, tesoreria_f2k_iuv.cod_bolletta, tesoreria_f2k.cod_bolletta) AS cod_bolletta_t,
    COALESCE(tesoreria_f2k_iuf.cod_id_dominio, tesoreria_f2k_iuv.cod_id_dominio, tesoreria_f2k.cod_id_dominio) AS cod_id_dominio_t,
    COALESCE(tesoreria_f2k_iuf.dt_ricezione, tesoreria_f2k_iuv.dt_ricezione, tesoreria_f2k.dt_ricezione) AS dt_ricezione_t,
    COALESCE(tesoreria_f2k_iuf.de_anno_documento, tesoreria_f2k_iuv.de_anno_documento, tesoreria_f2k.de_anno_documento) AS de_anno_documento_t,
    COALESCE(tesoreria_f2k_iuf.cod_documento, tesoreria_f2k_iuv.cod_documento, tesoreria_f2k.cod_documento) AS cod_documento_t,
    COALESCE(tesoreria_f2k_iuf.de_ae_provvisorio, tesoreria_f2k_iuv.de_ae_provvisorio, tesoreria_f2k.de_ae_provvisorio) AS de_anno_provvisorio_t,
    COALESCE(tesoreria_f2k_iuf.cod_provvisorio, tesoreria_f2k_iuv.cod_provvisorio, tesoreria_f2k.cod_provvisorio) AS cod_provvisorio_t,
    classificazione.mygov_classificazione_codice AS classificazione_completezza,
    GREATEST(import.dt_acquisizione::timestamp without time zone, export.dt_acquisizione::timestamp without time zone, rendicontazione.dt_acquisizione::timestamp without time zone, COALESCE(tesoreria_iuf.dt_acquisizione::timestamp without time zone, tesoreria_iuv.dt_acquisizione::timestamp without time zone, tesoreria_f2k_iuf.dt_ultima_modifica, tesoreria_f2k_iuv.dt_ultima_modifica, tesoreria_f2k.dt_ultima_modifica)) AS dt_data_ultimo_aggiornamento
   FROM mygov_flusso_import import
     FULL JOIN mygov_flusso_export export ON import.mygov_ente_id = export.mygov_ente_id AND import.cod_iud::text = export.cod_iud::text
     FULL JOIN ( SELECT mygov_flusso_rendicontazione.version,
            mygov_flusso_rendicontazione.dt_creazione,
            mygov_flusso_rendicontazione.dt_ultima_modifica,
            mygov_flusso_rendicontazione.mygov_ente_id,
            mygov_flusso_rendicontazione.mygov_manage_flusso_id,
            mygov_flusso_rendicontazione.identificativo_psp,
            mygov_flusso_rendicontazione.versione_oggetto,
            mygov_flusso_rendicontazione.cod_identificativo_flusso,
            mygov_flusso_rendicontazione.dt_data_ora_flusso,
            mygov_flusso_rendicontazione.cod_identificativo_univoco_regolamento,
            mygov_flusso_rendicontazione.dt_data_regolamento,
            mygov_flusso_rendicontazione.cod_ist_mitt_id_univ_mitt_tipo_identificativo_univoco,
            mygov_flusso_rendicontazione.cod_ist_mitt_id_univ_mitt_codice_identificativo_univoco,
            mygov_flusso_rendicontazione.de_ist_mitt_denominazione_mittente,
            mygov_flusso_rendicontazione.cod_ist_ricev_id_univ_ricev_tipo_identificativo_univoco,
            mygov_flusso_rendicontazione.cod_ist_ricev_id_univ_ricev_codice_identificativo_univoco,
            mygov_flusso_rendicontazione.de_ist_ricev_denominazione_ricevente,
            mygov_flusso_rendicontazione.num_numero_totale_pagamenti,
            mygov_flusso_rendicontazione.num_importo_totale_pagamenti,
            mygov_flusso_rendicontazione.cod_dati_sing_pagam_identificativo_univoco_versamento,
            mygov_flusso_rendicontazione.cod_dati_sing_pagam_identificativo_univoco_riscossione,
            mygov_flusso_rendicontazione.num_dati_sing_pagam_singolo_importo_pagato,
            mygov_flusso_rendicontazione.cod_dati_sing_pagam_codice_esito_singolo_pagamento,
            mygov_flusso_rendicontazione.dt_dati_sing_pagam_data_esito_singolo_pagamento,
            mygov_flusso_rendicontazione.dt_acquisizione,
            mygov_flusso_rendicontazione.indice_dati_singolo_pagamento,
            mygov_flusso_rendicontazione.codice_bic_banca_di_riversamento
           FROM mygov_flusso_rendicontazione
          WHERE mygov_flusso_rendicontazione.cod_dati_sing_pagam_codice_esito_singolo_pagamento::text <> '3'::text) rendicontazione ON export.mygov_ente_id = rendicontazione.mygov_ente_id AND export.cod_rp_silinviarp_id_univoco_versamento::text = rendicontazione.cod_dati_sing_pagam_identificativo_univoco_versamento::text AND export.cod_e_dati_pag_dati_sing_pag_id_univoco_riscoss::text = rendicontazione.cod_dati_sing_pagam_identificativo_univoco_riscossione::text AND export.indice_dati_singolo_pagamento = rendicontazione.indice_dati_singolo_pagamento
     FULL JOIN ( SELECT mygov_flusso_tesoreria_iuf.mygov_ente_id,
            mygov_flusso_tesoreria_iuf.mygov_manage_flusso_id,
            mygov_flusso_tesoreria_iuf.cod_abi,
            mygov_flusso_tesoreria_iuf.cod_cab,
            mygov_flusso_tesoreria_iuf.cod_conto,
            mygov_flusso_tesoreria_iuf.cod_divisa,
            mygov_flusso_tesoreria_iuf.dt_data_contabile,
            mygov_flusso_tesoreria_iuf.dt_data_valuta,
            mygov_flusso_tesoreria_iuf.num_importo,
            mygov_flusso_tesoreria_iuf.cod_segno,
            mygov_flusso_tesoreria_iuf.de_causale,
            mygov_flusso_tesoreria_iuf.cod_numero_assegno,
            mygov_flusso_tesoreria_iuf.cod_riferimento_banca,
            mygov_flusso_tesoreria_iuf.cod_riferimento_cliente,
            mygov_flusso_tesoreria_iuf.dt_data_ordine,
            mygov_flusso_tesoreria_iuf.de_descrizione_ordinante,
            mygov_flusso_tesoreria_iuf.cod_bi2,
            mygov_flusso_tesoreria_iuf.cod_be1,
            mygov_flusso_tesoreria_iuf.cod_ib1,
            mygov_flusso_tesoreria_iuf.cod_ib2,
            mygov_flusso_tesoreria_iuf.cod_ib4,
            mygov_flusso_tesoreria_iuf.cod_tid,
            mygov_flusso_tesoreria_iuf.cod_dte,
            mygov_flusso_tesoreria_iuf.cod_dtn,
            mygov_flusso_tesoreria_iuf.cod_eri,
            mygov_flusso_tesoreria_iuf.cod_im2,
            mygov_flusso_tesoreria_iuf.cod_ma2,
            mygov_flusso_tesoreria_iuf.cod_ri3,
            mygov_flusso_tesoreria_iuf.cod_or1,
            mygov_flusso_tesoreria_iuf.cod_sc2,
            mygov_flusso_tesoreria_iuf.cod_tr1,
            mygov_flusso_tesoreria_iuf.cod_sec,
            mygov_flusso_tesoreria_iuf.cod_ior,
            mygov_flusso_tesoreria_iuf.cod_id_univoco_flusso,
            NULL::character varying AS cod_id_univoco_versamento,
            mygov_flusso_tesoreria_iuf.dt_acquisizione
           FROM mygov_flusso_tesoreria_iuf) tesoreria_iuf ON tesoreria_iuf.cod_id_univoco_flusso::text = rendicontazione.cod_identificativo_flusso::text
     FULL JOIN ( SELECT mygov_flusso_tesoreria_iuv.mygov_ente_id,
            mygov_flusso_tesoreria_iuv.mygov_manage_flusso_id,
            mygov_flusso_tesoreria_iuv.cod_abi,
            mygov_flusso_tesoreria_iuv.cod_cab,
            mygov_flusso_tesoreria_iuv.cod_conto,
            mygov_flusso_tesoreria_iuv.cod_divisa,
            mygov_flusso_tesoreria_iuv.dt_data_contabile,
            mygov_flusso_tesoreria_iuv.dt_data_valuta,
            mygov_flusso_tesoreria_iuv.num_importo,
            mygov_flusso_tesoreria_iuv.cod_segno,
            mygov_flusso_tesoreria_iuv.de_causale,
            mygov_flusso_tesoreria_iuv.cod_numero_assegno,
            mygov_flusso_tesoreria_iuv.cod_riferimento_banca,
            mygov_flusso_tesoreria_iuv.cod_riferimento_cliente,
            mygov_flusso_tesoreria_iuv.dt_data_ordine,
            mygov_flusso_tesoreria_iuv.de_descrizione_ordinante,
            mygov_flusso_tesoreria_iuv.cod_bi2,
            mygov_flusso_tesoreria_iuv.cod_be1,
            mygov_flusso_tesoreria_iuv.cod_ib1,
            mygov_flusso_tesoreria_iuv.cod_ib2,
            mygov_flusso_tesoreria_iuv.cod_ib4,
            mygov_flusso_tesoreria_iuv.cod_tid,
            mygov_flusso_tesoreria_iuv.cod_dte,
            mygov_flusso_tesoreria_iuv.cod_dtn,
            mygov_flusso_tesoreria_iuv.cod_eri,
            mygov_flusso_tesoreria_iuv.cod_im2,
            mygov_flusso_tesoreria_iuv.cod_ma2,
            mygov_flusso_tesoreria_iuv.cod_ri3,
            mygov_flusso_tesoreria_iuv.cod_or1,
            mygov_flusso_tesoreria_iuv.cod_sc2,
            mygov_flusso_tesoreria_iuv.cod_tr1,
            mygov_flusso_tesoreria_iuv.cod_sec,
            mygov_flusso_tesoreria_iuv.cod_ior,
            NULL::character varying AS cod_id_univoco_flusso,
            mygov_flusso_tesoreria_iuv.cod_id_univoco_versamento,
            mygov_flusso_tesoreria_iuv.dt_acquisizione
           FROM mygov_flusso_tesoreria_iuv) tesoreria_iuv ON COALESCE(export.mygov_ente_id, rendicontazione.mygov_ente_id) = tesoreria_iuv.mygov_ente_id AND COALESCE(export.cod_rp_silinviarp_id_univoco_versamento, rendicontazione.cod_dati_sing_pagam_identificativo_univoco_versamento)::text = tesoreria_iuv.cod_id_univoco_versamento::text
     FULL JOIN ( SELECT mygov_flusso_tesoreria.de_anno_bolletta,
            mygov_flusso_tesoreria.cod_bolletta,
            mygov_flusso_tesoreria.cod_conto,
            mygov_flusso_tesoreria.cod_id_dominio,
            mygov_flusso_tesoreria.de_causale,
            mygov_flusso_tesoreria.num_ip_bolletta,
            mygov_flusso_tesoreria.dt_bolletta,
            mygov_flusso_tesoreria.dt_ricezione,
            mygov_flusso_tesoreria.de_anno_documento,
            mygov_flusso_tesoreria.cod_documento,
            mygov_flusso_tesoreria.de_cognome,
            mygov_flusso_tesoreria.cod_abi,
            mygov_flusso_tesoreria.cod_cab,
            mygov_flusso_tesoreria.de_ae_provvisorio,
            mygov_flusso_tesoreria.cod_provvisorio,
            mygov_flusso_tesoreria.dt_data_valuta_regione,
            mygov_flusso_tesoreria.mygov_ente_id,
            mygov_flusso_tesoreria.cod_id_univoco_flusso,
            mygov_flusso_tesoreria.cod_id_univoco_versamento,
            mygov_flusso_tesoreria.dt_creazione,
            mygov_flusso_tesoreria.dt_ultima_modifica
           FROM mygov_flusso_tesoreria
          WHERE mygov_flusso_tesoreria.cod_id_univoco_flusso IS NOT NULL AND mygov_flusso_tesoreria.cod_id_univoco_versamento IS NULL) tesoreria_f2k_iuf ON COALESCE(export.mygov_ente_id, rendicontazione.mygov_ente_id) = tesoreria_f2k_iuf.mygov_ente_id AND rendicontazione.cod_identificativo_flusso::text = tesoreria_f2k_iuf.cod_id_univoco_flusso::text
     FULL JOIN ( SELECT mygov_flusso_tesoreria.de_anno_bolletta,
            mygov_flusso_tesoreria.cod_bolletta,
            mygov_flusso_tesoreria.cod_conto,
            mygov_flusso_tesoreria.cod_id_dominio,
            mygov_flusso_tesoreria.de_causale,
            mygov_flusso_tesoreria.num_ip_bolletta,
            mygov_flusso_tesoreria.dt_bolletta,
            mygov_flusso_tesoreria.dt_ricezione,
            mygov_flusso_tesoreria.de_anno_documento,
            mygov_flusso_tesoreria.cod_documento,
            mygov_flusso_tesoreria.de_cognome,
            mygov_flusso_tesoreria.cod_abi,
            mygov_flusso_tesoreria.cod_cab,
            mygov_flusso_tesoreria.de_ae_provvisorio,
            mygov_flusso_tesoreria.cod_provvisorio,
            mygov_flusso_tesoreria.dt_data_valuta_regione,
            mygov_flusso_tesoreria.mygov_ente_id,
            mygov_flusso_tesoreria.cod_id_univoco_flusso,
            mygov_flusso_tesoreria.cod_id_univoco_versamento,
            mygov_flusso_tesoreria.dt_creazione,
            mygov_flusso_tesoreria.dt_ultima_modifica
           FROM mygov_flusso_tesoreria
          WHERE mygov_flusso_tesoreria.cod_id_univoco_flusso IS NULL AND mygov_flusso_tesoreria.cod_id_univoco_versamento IS NOT NULL) tesoreria_f2k_iuv ON COALESCE(export.mygov_ente_id, rendicontazione.mygov_ente_id) = tesoreria_f2k_iuv.mygov_ente_id AND COALESCE(export.cod_rp_silinviarp_id_univoco_versamento, rendicontazione.cod_dati_sing_pagam_identificativo_univoco_versamento)::text = tesoreria_f2k_iuv.cod_id_univoco_versamento::text
     FULL JOIN ( SELECT mygov_flusso_tesoreria.de_anno_bolletta,
            mygov_flusso_tesoreria.cod_bolletta,
            mygov_flusso_tesoreria.cod_conto,
            mygov_flusso_tesoreria.cod_id_dominio,
            mygov_flusso_tesoreria.de_causale,
            mygov_flusso_tesoreria.num_ip_bolletta,
            mygov_flusso_tesoreria.dt_bolletta,
            mygov_flusso_tesoreria.dt_ricezione,
            mygov_flusso_tesoreria.de_anno_documento,
            mygov_flusso_tesoreria.cod_documento,
            mygov_flusso_tesoreria.de_cognome,
            mygov_flusso_tesoreria.cod_abi,
            mygov_flusso_tesoreria.cod_cab,
            mygov_flusso_tesoreria.de_ae_provvisorio,
            mygov_flusso_tesoreria.cod_provvisorio,
            mygov_flusso_tesoreria.dt_data_valuta_regione,
            mygov_flusso_tesoreria.mygov_ente_id,
            mygov_flusso_tesoreria.cod_id_univoco_flusso,
            mygov_flusso_tesoreria.cod_id_univoco_versamento,
            mygov_flusso_tesoreria.dt_creazione,
            mygov_flusso_tesoreria.dt_ultima_modifica
           FROM mygov_flusso_tesoreria
          WHERE mygov_flusso_tesoreria.cod_id_univoco_flusso IS NULL AND mygov_flusso_tesoreria.cod_id_univoco_versamento IS NULL) tesoreria_f2k ON 1 = 0
     LEFT JOIN mygov_classificazione_completezza classificazione ON classificazione.mygov_classificazione_codice::text = 'IUD_RT_IUF_TES'::text AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento = export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato AND (rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato = rendicontazione.num_dati_sing_pagam_singolo_importo_pagato AND rendicontazione.num_importo_totale_pagamenti IS NOT NULL AND (tesoreria_iuf.num_importo IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti = tesoreria_iuf.num_importo OR tesoreria_f2k_iuf.num_ip_bolletta IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti = tesoreria_f2k_iuf.num_ip_bolletta) OR tesoreria_iuv.num_importo IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato = tesoreria_iuv.num_importo OR tesoreria_f2k_iuv.num_ip_bolletta IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato = tesoreria_f2k_iuv.num_ip_bolletta) OR classificazione.mygov_classificazione_codice::text = 'IUD_RT_IUF'::text AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento = export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato AND rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato = rendicontazione.num_dati_sing_pagam_singolo_importo_pagato OR classificazione.mygov_classificazione_codice::text = 'RT_IUF_TES'::text AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato = rendicontazione.num_dati_sing_pagam_singolo_importo_pagato AND rendicontazione.num_importo_totale_pagamenti IS NOT NULL AND (tesoreria_iuf.num_importo IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti = tesoreria_iuf.num_importo OR tesoreria_f2k_iuf.num_ip_bolletta IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti = tesoreria_f2k_iuf.num_ip_bolletta) OR classificazione.mygov_classificazione_codice::text = 'RT_IUF'::text AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato = rendicontazione.num_dati_sing_pagam_singolo_importo_pagato OR classificazione.mygov_classificazione_codice::text = 'RT_NO_IUF'::text AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND NOT (tesoreria_iuv.num_importo IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato = tesoreria_iuv.num_importo OR tesoreria_f2k_iuv.num_ip_bolletta IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato = tesoreria_f2k_iuv.num_ip_bolletta OR tesoreria_iuv.num_importo IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato <> tesoreria_iuv.num_importo OR tesoreria_f2k_iuv.num_ip_bolletta IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato <> tesoreria_f2k_iuv.num_ip_bolletta) AND (rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NULL OR rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NOT NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato <> rendicontazione.num_dati_sing_pagam_singolo_importo_pagato) OR classificazione.mygov_classificazione_codice::text = 'IUF_NO_TES'::text AND rendicontazione.num_importo_totale_pagamenti IS NOT NULL AND tesoreria_iuf.num_importo IS NULL AND tesoreria_iuv.num_importo IS NULL AND tesoreria_f2k_iuf.num_ip_bolletta IS NULL AND tesoreria_f2k_iuv.num_ip_bolletta IS NULL OR classificazione.mygov_classificazione_codice::text = 'IUF_TES_DIV_IMP'::text AND rendicontazione.num_importo_totale_pagamenti IS NOT NULL AND (tesoreria_iuf.num_importo IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti <> tesoreria_iuf.num_importo OR tesoreria_iuv.num_importo IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti <> tesoreria_iuv.num_importo OR tesoreria_f2k_iuf.num_ip_bolletta IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti <> tesoreria_f2k_iuf.num_ip_bolletta OR tesoreria_f2k_iuv.num_ip_bolletta IS NOT NULL AND rendicontazione.num_importo_totale_pagamenti <> tesoreria_f2k_iuv.num_ip_bolletta) OR classificazione.mygov_classificazione_codice::text = 'TES_NO_IUF_OR_IUV'::text AND (tesoreria_iuf.num_importo IS NOT NULL OR tesoreria_iuv.num_importo IS NOT NULL OR tesoreria_f2k_iuf.num_ip_bolletta IS NOT NULL AND tesoreria_f2k_iuf.cod_id_univoco_flusso IS NOT NULL AND tesoreria_f2k_iuf.cod_id_univoco_versamento IS NULL OR tesoreria_f2k_iuv.num_ip_bolletta IS NOT NULL AND tesoreria_f2k_iuv.cod_id_univoco_flusso IS NULL AND tesoreria_f2k_iuv.cod_id_univoco_versamento IS NOT NULL) AND rendicontazione.num_importo_totale_pagamenti IS NULL AND export.num_e_dati_pag_importo_totale_pagato IS NULL AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento IS NULL OR classificazione.mygov_classificazione_codice::text = 'IUV_NO_RT'::text AND rendicontazione.num_importo_totale_pagamenti IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato IS NULL OR classificazione.mygov_classificazione_codice::text = 'IUD_NO_RT'::text AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento IS NOT NULL AND (export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NULL OR export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento <> export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato) OR classificazione.mygov_classificazione_codice::text = 'RT_NO_IUD'::text AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NOT NULL AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento IS NULL OR classificazione.mygov_classificazione_codice::text = 'TES_NO_MATCH'::text AND import.num_rp_dati_vers_dati_sing_vers_importo_singolo_versamento IS NULL AND export.num_e_dati_pag_dati_sing_pag_singolo_importo_pagato IS NULL AND rendicontazione.num_importo_totale_pagamenti IS NULL AND tesoreria_iuf.num_importo IS NULL AND tesoreria_iuv.num_importo IS NULL AND tesoreria_f2k_iuf.cod_id_univoco_flusso IS NULL AND tesoreria_f2k_iuf.cod_id_univoco_versamento IS NULL AND tesoreria_f2k_iuv.cod_id_univoco_flusso IS NULL AND tesoreria_f2k_iuv.cod_id_univoco_versamento IS NULL AND tesoreria_f2k.cod_id_univoco_flusso IS NULL AND tesoreria_f2k.cod_id_univoco_versamento IS NULL OR classificazione.mygov_classificazione_codice::text = 'RT_TES'::text AND export.num_e_dati_pag_importo_totale_pagato IS NOT NULL AND rendicontazione.num_dati_sing_pagam_singolo_importo_pagato IS NULL AND rendicontazione.num_importo_totale_pagamenti IS NULL AND (tesoreria_iuv.num_importo IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato = tesoreria_iuv.num_importo OR tesoreria_f2k_iuv.num_ip_bolletta IS NOT NULL AND export.num_e_dati_pag_importo_totale_pagato = tesoreria_f2k_iuv.num_ip_bolletta);
