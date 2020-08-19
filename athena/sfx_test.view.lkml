view: sfx_test {
 derived_table: {
   create_process: {
      # step 1 - Add new partition
     sql_step: msck repair table looker_test.orders ;;
      # step 2: clean deat names
      sql_step:
          INSERT into sampledb.deal_clean
          SELECT
           bid_cancelled
          ,bid_done
          ,bid_fail_currency
          ,bid_failed
          ,bid_failed_parsing
          ,bid_filtered
          ,bid_filtered_ad_approval
          ,bid_filtered_blockrule
          ,bid_filtered_circuit_breaker
          ,bid_filtered_duration
          ,bid_filtered_floor_price
          ,bid_filtered_mrm
          ,bid_filtered_multiroll
          ,bid_price_advertiser
          ,bid_price_publisher
          ,bid_request
          ,bid_selected
          ,bid_selected_price_advertiser
          ,bid_selected_price_publisher
          ,bid_timeout
          ,click
          ,cost
          ,custom_inventory
          ,custom_skip_button_display
          ,custom_skip_tracking

          ,deal.deal

          ,impression
          ,non_viewable_impression
          ,offered
          ,rejection_count_ad_compatibility
          ,rejection_count_creative
          ,rejection_count_non_secured_ad
          ,request
          ,request_coppa_blocking
          ,request_country
          ,request_country_zone_capping_blocking
          ,request_domain_blocking
          ,request_location_blocking
          ,request_player_size_blocking
          ,request_vpaid_adapter_blocking
          ,request_with_ads
          ,request_zone_capping_blocking
          ,revenue
          ,revenue_dsp
          ,user_match
          ,vast_error_all
          ,viewable_impression
          ,vtr100
          ,advertiser_name
          ,brand_name
          ,buyer_name
          ,dsp_name
          ,declared_device
          ,publisher_name
          ,site_name
          ,site
          ,zone
          ,zone_device
          ,px_name
          ,campaign_name
          ,px_country
          ,selling_px_name
          ,selling_px_country
          ,selling_px_billing_country
          ,px_billing_country

          ,deal_names_clean.deal_name

          ,case
             when deal_names_clean.deal_name like '%^_SA^_%' escape '^' then 'Single Advertiser'
             when deal_names_clean.deal_name like '%^_MA^_%' escape '^' then 'Multi Advertiser'
             else 'N/A'
             end as single_multi_advertiser

          ,case
             when px_billing_country = 'US' then 1.0
             when px_billing_country = 'FR' then fx_rates.rate
             else fx_rates.rate
             end as fx

          ,deal.dt
          -- add account executive
          ,case
              when deal_names_clean.deal_name like '%ATD_BR%' then 'Brett Richardson'
              when deal_names_clean.deal_name like '%ATD_CK%' then 'Clay Kilgo'
              when deal_names_clean.deal_name like '%ATD_JF%' then 'Justin Federico'
              when deal_names_clean.deal_name like '%ATD_LH%' then 'Leilani Herzog'
              when deal_names_clean.deal_name like '%ATD_AS%' then 'Austin Scott'
              when deal_names_clean.deal_name like '%ATD_FB%' then 'Faith Bentzel'
              when deal_names_clean.deal_name like '%ATD_GJ%' then 'Gregory Joseph'
              when deal_names_clean.deal_name like '%ATD_MG%' then 'Michael Goodman'
              when deal_names_clean.deal_name like '%ATD_KM%' then 'Katie McGregor'
              when deal_names_clean.deal_name like '%ATD_AM%' then 'Andrea Morawski'
              when deal_names_clean.deal_name like '%ATD_GG%' then 'Gena Grossberg'
              when deal_names_clean.deal_name like '%ATD_AB%' then 'Adam Bliss'
              when deal_names_clean.deal_name like '%ATD_MH%' then 'Matt Hyman'
              when deal_names_clean.deal_name like '%ATD_RN%' then 'Ryan Nystrom'
              when deal_names_clean.deal_name like '%ATD_RF%' then 'Robert French'
              when deal_names_clean.deal_name like '%DSP_BR%' then 'Brett Richardson'
              when deal_names_clean.deal_name like '%DSP_CK%' then 'Clay Kilgo'
              when deal_names_clean.deal_name like '%DSP_JF%' then 'Justin Federico'
              when deal_names_clean.deal_name like '%DSP_LH%' then 'Leilani Herzog'
              when deal_names_clean.deal_name like '%DSP_AS%' then 'Austin Scott'
              when deal_names_clean.deal_name like '%DSP_FB%' then 'Faith Bentzel'
              when deal_names_clean.deal_name like '%DSP_GJ%' then 'Gregory Joseph'
              when deal_names_clean.deal_name like '%DSP_MG%' then 'Michael Goodman'
              when deal_names_clean.deal_name like '%DSP_KM%' then 'Katie McGregor'
              when deal_names_clean.deal_name like '%DSP_AM%' then 'Andrea Morawski'
              when deal_names_clean.deal_name like '%DSP_GG%' then 'Gena Grossberg'
              when deal_names_clean.deal_name like '%DSP_AB%' then 'Adam Bliss'
              when deal_names_clean.deal_name like '%DSP_MH%' then 'Matt Hyman'
              when deal_names_clean.deal_name like '%DSP_RN%' then 'Ryan Nystrom'
              when deal_names_clean.deal_name like '%DSP_RF%' then 'Robert French'
              when deal_names_clean.deal_name like '%ATD_DR%' then 'David Raleigh'
              when deal_names_clean.deal_name like '%ATD_CF%' then 'Chris Finnerty'
              when deal_names_clean.deal_name like '%ATD_EM%' then 'Elliott McNeil'
              when deal_names_clean.deal_name like '%DSP_GB%' then 'Greg Bel'
              when deal_names_clean.deal_name like '%DSP SO_RF%' then 'Robert French'
              when deal_names_clean.deal_name like '%DSP_RF%' then 'Robert French'
              when deal_names_clean.deal_name like '%DSP_FR%' then 'Robert French'
              when deal_names_clean.deal_name like '%DSP_KO%' then 'Kachi Okezie'
              when deal_names_clean.deal_name like '%USD_DSP__DSP Direct_Amobee___Video_US_Multipub_CTV_LDA%' then 'Faith Bentzel'
              when deal_names_clean.deal_name like '%USD_DSP__DSP Direct_TTD___Video_US_Multipub_CTV_LDA%' then 'Faith Bentzel'
              when deal_names_clean.deal_name like '%DSP Direct_RF%' then 'Robert French'
              when deal_names_clean.deal_name like '%DSP_EU_GJ%' then 'Gregory Joseph'
              when deal_names_clean.deal_name like '%FB_DSP%' then 'Faith Bentzel'
              when deal_names_clean.deal_name like '%ATD_BV%' then 'Brianna Vogelzang'
              else 'Unassigned'
            end as account_executive
        from sampledb.deal as deal
        left join
        ( SELECT  distinct
          case
            when deal_name = 'USD_DSP_KM_DSP Direct_OpenX___Video_US_Multipub_CTV' then 'OX-MPO-Pc0EE1'
            else deal
            end as deal
          ,case
            when deal = 'AET-USD-00011' then 'USD_ATD_BR_Accuen Media_DBM_Nissan__Video_US_AETN_EPB_CTV_1'
            when deal = 'AET-USD-00012' then 'USD_ATD_BR_Accuen Media_DBM_Nissan__Video_US_AETN_EPB_CTV_2'
            when deal = 'AET-USD-00009' then 'USD_ATD_BR_Accuen Media_DBM_Nissan__Video_US_AETN_EPB_Mobile APP_1'
            when deal = 'AET-USD-00010' then 'USD_ATD_BR_Accuen Media_DBM_Nissan__Video_US_AETN_EPB_Mobile APP_2'
            when deal = 'STI-USD-01189' then 'USD_ATD_BV_SEL_Cadreon_TTD_Spotify__FEP_US_Multipub_Desktop_1'
            when deal = 'STI-USD-01190' then 'USD_ATD_BV_SEL_Cadreon_TTD_Spotify__FEP_US_Multipub_Desktop_2'
            when deal = 'STI-USD-00688' then 'USD_ATD_CK_PMSI_TTD___FEP_US_Multipub No Discovery_CTV'
            when deal = 'STI-USD-00719' then 'USD_ATD_CK_SEL_PMSI_TTD___FEP_US_Multipub_CTV'
            when deal = 'STI-USD-00746' then 'USD_ATD_CK_PMSI_TTD___FEP_US_Multipub No Fox_CTV'
            when deal = 'STI-USD-00689' then 'USD_ATD_CK_PMSI_TTD___FEP_US_Multipub No Discovery_Mobile APP'
            when deal = 'STI-USD-00720' then 'USD_ATD_CK_SEL_PMSI_TTD___FEP_US_Multipub_Mobile APP'
            when deal = 'STI-USD-00747' then 'USD_ATD_CK_PMSI_TTD___FEP_US_Multipub No Fox_Mobile APP'
            when deal = 'STI-USD-00876' then 'USD_ATD_CK_The Richards Group_Market 58_Amobee_GoRVing__Pre-roll_US_MultiPub_Mobile APP_Inactive'
            when deal = 'STI-USD-00938' then 'USD_ATD_CK_SEL_The Richards Group_Market 58_Amobee_GoRVing__Pre-roll_US_MultiPub_Mobile APP'
            when deal = 'PLU-HEB-00001' then 'USD_ATD_EM__Goodway Group_TTD___Video_Texas_Pluto_EPB_All Devices_1'
            when deal = 'PLU-MDA-00001' then 'USD_ATD_EM__Goodway Group_TTD___Video_Texas_Pluto_EPB_All Devices_2'
            when deal = 'STI-USD-00792' then 'USD_ATD_JF_NCC Media_Amobee_Lexus__Video_US_Multipub_All Devices_$15+_Inactive'
            when deal = 'STI-USD-00860' then 'USD_ATD_JF_SEL_NCC Media_Amobee_Lexus__Video_US_FOX_Mobile APP_$15+'
            when deal = 'STI-USD-00821' then 'USD_ATD_JF_NCC Media_Amobee_Lexus__Video_US_Multipub_CTV_$15+_Sports'
            when deal = 'STI-USD-00858' then 'USD_ATD_JF_SEL_NCC Media_Amobee_Lexus__Video_US_Multipub_CTV_$15+'
            when deal = 'STI-USD-00822' then 'USD_ATD_JF_NCC Media_Amobee_Lexus__Video_US_Multipub_CTV_<$15_Sports'
            when deal = 'STI-USD-00859' then 'USD_ATD_JF_SEL_NCC Media_Amobee_Lexus__Video_US_Multipub_CTV_<$15'
            when deal = 'STI-USD-00793' then 'USD_ATD_JF_SEL_NCC Media_Amobee_Lexus__Video_US_Multipub_Mobile APP_<$15_1'
            when deal = 'STI-USD-00861' then 'USD_ATD_JF_SEL_NCC Media_Amobee_Lexus__Video_US_Multipub_Mobile APP_<$15_2'
            when deal = 'STI-USD-00405' then 'USD_DSP_GJ_SEL_DSP Direct_Appnexus_Townsquare___Sports_Video_US_Multipub_CTV_1'
            when deal = 'STI-USD-00408' then 'USD_DSP_GJ_SEL_DSP Direct_Appnexus_Townsquare___Sports_Video_US_Multipub_CTV_2'
            when deal = 'OX-TEO-CBRMQI' then 'USD_DSP_KM_SEL_DSP Direct_OpenX___FEP_US_Multipub_CTV_RON_1'
            when deal = 'STI-USD-01330' then 'USD_DSP_KM_SEL_DSP Direct_OpenX___FEP_US_Multipub_CTV_RON_2'
            when deal = 'STI-USD-00357' then 'USD_DSP_RF_Comcast Spotlight_Beeswax___RON_US_MultiPub_Mobile APP'
            when deal = 'STI-USD-00353' then 'USD_DSP_RF_Comcast Spotlight_Beeswax___RON_US_MultiPub_CTV'
            when deal = 'NEW-USD-00002' then 'USD_ATD_CK_PMX_TTD___Video _US_MA_Newsy_EPB_CTV'
            when deal = 'AMC-HS--00001' then 'USD_ATD_LH_Hearts & Science_TTD_Amgen__FEP_US_SA_AMC_EPB_CTV'
            when deal = 'DIS-USD-00020' then 'USD_ATD_AM_PHD_DBM_Hormel Foods__Video_Los Angeles_SA_DISCO_EPB_CTV'
            when deal = 'DIS-USD-00017' then 'USD_ATD_LH_Accuen_DBM_Kerry Gold_Dgo_Travel_FEP_US_SA_Discovery_EPB_Mobile Web_Mobile APP'
            when deal = 'DIS-USD-00018' then 'USD_ATD_LH_Accuen_DBM_Kerry Gold_Cooking_Food_FEP_US_SA_Scripps_EPB_Mobile Web_Mobile APP'
            when deal = 'DIS-USD-00021' then 'USD_ATD_AM_PHD_DV360_Chili__FEP_US_SA_Discovery_All Devices'
            when deal = 'PHI-USD-00001' then 'USD_ATD_CK_PMX_TTD___Video_US_MA_Philo_EPB_CTV'
            when deal = 'STI-AMC-00001' then 'USD_DSP_FB_SEL_DSP Direct_TTD___Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00660' then 'USD_DSP_RF_SEL_DSP Direct_DataXu___Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00717' then 'USD_ATD_CK_SEL_PMX_TTD_Video_US_MA_PremiumBundle_CTV'
            when deal = 'STI-USD-00562' then 'USD_ATD_JF_SEL_NCC_Amobee__$0-$18 Floor_Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00354' then 'USD_DSP_RF_Comcast Spotlight_Beeswax___Video_US_MA_MultiPub_Desktop_Mobile Web'
            when deal = 'STI-USD-00452' then 'USD_DSP_KM_SEL_DSP Direct_VideoAmp_Jaguar/Landrover__FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00522' then 'USD_FB_DSP Direct_Amobee_MultiDSP_Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00623' then 'USD_ATD_CK_Cadreon_TTD_Fortnite__FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00706' then 'USD_DSP_FB_DSP Direct_Amobee_MultiDSP_Video_US_MA_Multipub_CTV'
            when deal = 'STI-ALW-00003' then 'USD_DSP_FB_DSP Direct_TTD___Video_US_MA_Corus_CTV'
            when deal = 'STI-USD-00925' then 'USD_ATD_CK_SEL_Cadreon_TTD_BMW__FEP_US_SA_MultiPub_CTV_Tier 2 CXE SSE_$35 CPM_Freewheel'
            when deal = 'STI-USD-00302' then 'USD_DSP_RF_SEL_DSP Direct_DataXu___Video _US_MA_Multipub_CTV_LDA'
            when deal = 'STI-USD-00808' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath_SeaWorld Entertainment_O&O__Video_Florida_MA_Multipub_CTV'
            when deal = 'STI-USD-01073' then 'USD_DSP_RF_SEL_Publicis_RUN_Starbucks__Video_US_MA_MultiPub_CTV'
            when deal = 'STI-USD-00835' then 'USD_ATD_CK_SEL_Triad_Appnexus_Just. Walmart__FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00797' then 'USD_ATD_CK_SEL_Cadreon_TTD_Spotify Mature Brand_Video_US_SA_Multipub_CTV'
            when deal = 'STI-USD-01104' then 'USD_ATD_JF_SEL_SparkFoundry_TTD_Comcast__FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00851' then 'USD_DSP_AS_SEL_DSP Direct_Beeswax_Comcast Spotlight__FEP_US_MA_MultiPub_CTV'
            when deal = 'STI-TTD-00198' then 'USD_DSP_FB_DSP Direct_TTD___FEP_US_MA_MultiPub_Mobile APP'
            when deal = 'STI-TUR-00016' then 'USD_DSP_FB_DSP Direct_Amobee_Legacy_Video_US_MA_MultiPub_CTV'
            when deal = 'STI-USD-00505' then 'USD_DSP_AS_SEL_DSP Direct_Simpli.fi___Video_Premium_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00796' then 'USD_ATD_LH_SEL_Accuen_TTD_Audi_RON_FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00306' then 'USD_ATD_LH_Stream Companies_Videology___Video_US_MA_Multipub_CTV_Sports_Tier 1'
            when deal = 'STI-USD-00805' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath_SeaWorld Entertainment__Video_Flordia_MA_Multipub_CTV'
            when deal = 'STI-USD-00363' then 'USD_DSP_AS_SEL_DSP Direct_Adelphic___Video_US_MA_Multipub_CTV'
            when deal = 'STI-TTD-00200' then 'USD_DSP_FB_SEL_DSP Direct_TTD___Pre-roll_US_MA_MultiPub__Desktop'
            when deal = 'STI-USD-00669' then 'USD_ATD_CK_SEL_Publicis Media_DBM_GSK_Nutrition & Digestive_FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00772' then 'USD_ATD_JF_SEL_NCC_TTD___FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00932' then 'USD_DSP_FB_DSP Direct_Amobee___FEP_US_MA__Desktop_Mobile Web'
            when deal = 'STI-USD-00887' then 'USD_DSP_KM_SEL_DSP Direct_Zypmedia___Video_US_MA_MultiPub_CTV_Sports'
            when deal = 'STI-USD-01251' then 'USD_ATD_CK_SEL_Cadreon_TTD_BMW__FEP_US_SA_MultiPub_CTV_Tier 2 CXE SSE_$35 CPM_Central_BMW CPO'
            when deal = 'STI-USD-00723' then 'USD_ATD_CK_SEL_Cadreon_TTD_ExxonMobil__Video_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00310' then 'USD_ATD_LH_SEL_Stream Companies_Videology___Video_US_MA_Multipub_CTV_FEP'
            when deal = 'STI-USD-00902' then 'USD_ATD_JF_SEL_Spark_TTD_Dole__Video_US_SA_MultiPub_CTV_Food_Family & Parenting_Lifestyle'
            when deal = 'STI-USD-00521' then 'USD_DSP_FB_SEL_DSP Direct_Amobee_Saatchi_FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00201' then 'USD_DSP_KM _DSP Direct_DBM___Video_US_MA_MultiPub _All Devices'
            when deal = 'STI-USD-01121' then 'USD_ATD_EM_SEL_Stream Companies_Videology___FEP_US_MA_Multipub_CTV_OTT/Pureplay'
            when deal = 'STI-USD-00919' then 'USD_ATD_JF_SEL_Publicis_TTD_GSK__FEP_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-00578' then 'USD_ATD_CK_SEL_The Richards Group_Amobee_Sewell Dealerships_Video_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00506' then 'USD_DSP_AS_SEL_DSP Direct_Simpli.fi___Video_Premium_US_MA_Multipub_Mobile APP_CTV'
            when deal = 'STI-USD-00561' then 'USD_ATD_CK_SEL_The Richards Group_Amobee_HEB_Market58__Video_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00832' then 'USD_ATD_JF_SEL_NCC Media_Amobee_Lexus__Video_US_MA_Multipub_Desktop_Mobile Web_<$15'
            when deal = 'STI-USD-00852' then 'USD_ATD_CK_SEL_Starcom_Amobee_Kraft__Video_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-00122' then 'USD_ATD_CK_SEL_Saatchi & Saatchi LA_Amobee_Toyota__Video_US_SA_MultiPub_Desktop'
            when deal = 'STI-TTD-00197' then 'USD_DSP_FB_SEL_DSP Direct_TTD___FEP_US_MA_MultiPub__Desktop'
            when deal = 'STI-USD-00587' then 'USD_ATD_CK_Cadreon_TTD_Spotify__FEP_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-00490' then 'USD_DSP_FB_DSP Direct_Amobee_Toyota__FEP_US_SA_Multipub_Desktop'
            when deal = 'STI-USD-00838' then 'USD_ATD_CK_SEL_Publicis Media_TTD_GSK_Parodontax_FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-00119' then 'USD_ATD_LH_Ntooitive_TTD___Video_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-00599' then 'USD_ATD_CK_SEL_Cadreon_TTD_Fitbit__FEP_US_SA_Multipub_CTV FEP'
            when deal = 'STI-USD-00573' then 'USD_DSP_FB_SEL__MultiDSP___Video_US_MA_Multipub_CTV_Sports'
            when deal = 'STI-USD-00998' then 'USD_DSP_RF_DSP Direct_MediaMath_Zyn__FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00913' then 'USD_ATD_LH_SEL_PHD_MultiDSP___FEP_US_MA_MultiPub_CTV_Tier 2 2'
            when deal = 'STI-USD-01065' then 'USD_ATD_LH_SEL_PHD_TTD_VW Tier 2__Video_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-01051' then 'USD_DSP_RF_DSP Direct_MediaMath_FireHouse Subs__FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00126' then 'USD_ATD_LH_Saatchi & Saatchi LA_Amobee_Toyota __Video_US_SA_Multipub_Mobile Web'
            when deal = 'STI-USD-01109' then 'USD_ATD_CF_MullenLowe Mediahub_TTD_Royal Caribbean International__Video_US_SA_Multipub_CTV_$15-20CPM'
            when deal = 'STI-USD-00809' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath_SeaWorld Entertainment_O&O__Video_Texas_MA_Multipub_CTV'
            when deal = 'STI-USD-00759' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath___Video_US_MA_Xumo_CTV'
            when deal = 'STI-USD-00705' then 'USD_DSP_FB_SEL_DSP Direct_Amobee_MultiDSP_FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00283' then 'USD_ATD_CK_SEL_PMX_TTD___Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00357' then 'USD_DSP_RF_Comcast Spotlight_Beeswax___Video_US_MA_MultiPub_Mobile APP'
            when deal = 'STI-USD-01013' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath_Prudential__Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00834' then 'USD_ATD_CK_SEL_Digitas_TTD_HPE__FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-01108' then 'USD_ATD_CF_MullenLowe Mediahub_TTD_Royal Caribbean International__Video_US_SA_Multipub_CTV_$20CPM'
            when deal = 'STI-USD-01043' then 'USD_DSP_RF_SEL_DSP Direct_RUN___Video_US_MA_MultiPub_CTV'
            when deal = 'STI-USD-00329' then 'USD_DSP_AS_DSP Direct_Eyeview___Video_US_MA_MultiPub_All Devices'
            when deal = 'STI-GAM-00010' then 'USD_ATD_LH_SEL_Gamut_TTD___FEP_US_MA_MultiPub_All Devices Devices'
            when deal = 'STI-USD-00605' then 'USD_DSP_GJ_Xaxis_APN___Video_US_MA_Multipub_Desktop_Mobile Web_$10'
            when deal = 'STI-USD-00566' then 'USD_ATD_JF_SEL_NCC_Amobee___FEP_US_MA_Multipub_Mobile APP'
            when deal = 'STI-USD-00825' then 'USD_DSP_GJ_EMX_Appnexus___Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00676' then 'USD_DSP_KM_SEL_DSP Direct_VideoAmp___Video_US_MA_Spot.IM_Desktop_Mobile Web'
            when deal = 'STI-USD-01292' then 'USD_DSP_GJ_SEL_DSP Direct_Adobe___Video_US_MA_Multipub_CTV_High VTR'
            when deal = 'STI-USD-00804' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath_SeaWorld Entertainment__Video_US_MA_Multipub_CTV'
            when deal = 'STI-USD-01086' then 'USD_DSP_GJ_DSP Direct_Eyeview___Video_US_MA_Non-SSAI_MultiPub_CTV'
            when deal = 'STI-USD-00564' then 'USD_ATD_JF_SEL_NCC_Amobee__$0-$12 Floor_Video_US_MA_Multipub_Desktop_Mobile Web'
            when deal = 'STI-USD-00849' then 'USD_DSP_GJ_Exact Drive_Appnexus___Video_US_MA_MultiPub_CTV_Broadcaster'
            when deal = 'STI-USD-01299' then 'USD_ATD_CK_SEL_Cadreon_TTD_AMZ__Video_US_SA_Multipub_CTV'
            when deal = 'PLU-HEB-00001' then 'USD_ATD_EM__Goodway Group_TTD___Video_Texas_MA_Pluto_EPB_All Devices_1'
            when deal = 'STI-USD-01299' then 'USD_ATD_CK_SEL_Cadreon_TTD_AMZ__Video_US_SA_Multipub_CTV'
            when deal = 'STI-USD-01337' then 'USD_ATD_EM_SEL_Hearts & Science_TTD_Aimovig__Video_US_SA_Multipub_CTV_News'
            when deal = 'STI-USD-01276' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US_SA_Multipub_Mobile APP_$15-$20'
            when deal = 'STI-USD-01286' then 'USD_ATD_JF_SEL_Digitas_TTD_GSK__Video_US_SA_Multipub_CTV_$25&below'
            when deal = 'STI-USD-00565' then 'USD_ATD_JF_SEL_NCC_Amobee___FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00565' then 'USD_ATD_JF_SEL_NCC_TTD___FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-01301' then 'USD_ATD_GG_SEL_Mediacom_TTD_Playstation__Video_US_SA_Multipub_Mobile APP_CTV_Pure Play'
            when deal = 'STI-USD-00910' then 'USD_ATD_LH_SEL_PHD_MultiDSP___FEP_US_SA_MultiPub_Desktop_Tier 2'
            when deal = 'STI-USD-01429' then 'USD_ATD_JF_SEL_Ampersand _Amobee___Video_US_MA_MultiPub_CTV_RON'
            when deal = 'STI-USD-00796' then 'USD_ATD_LH_SEL_Accuen_TTD_Audi_RON_FEP_US_SA_Multipub_CTV'
            when deal = 'STI-USD-01357' then 'USD_ATD_LH__MediaStorm_TTD_Ethan Allen__Video_US_SA_MultiPub_CTV_DigitalPurePlay'
            when deal = 'STI-USD-01273' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US_SA_Multipub_CTV_$15-$20'
            when deal = 'DIS-USD-00023' then 'USD_ATD_AM_PHD_DBM_Hormel Foods__Video_Chicago_DISCO_EPB_CTV'
            when deal = 'DIS-USD-00022' then 'USD_ATD_AM_PHD_DBM_Hormel Foods__Video_Dallas_DISCO_EPB_CTV'
            when deal = 'STI-USD-01105' then 'USD_ATD_JF_SEL_Publicis_TTD_Marriot__Video_US_SA_Multipub_CTV'
            when deal = 'STI-ACC-00069' then 'USD_ATD_LH_SEL_Accuen Media_MultiDSP___Video_US_MA_MultiPub__CTV'
            when deal = 'STI-USD-01274' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US_SA_Multipub_CTV_$20+'
            when deal = 'STI-USD-01207' then 'USD_ATD_EM_SEL_Hearts & Science_TTD_Aimovig__Video_US_SA_Multipub_CTV_News $15-$20'
            when deal = 'STI-USD-01194' then 'USD_ATD_GG_Client Direct_TTD_Squarespace__Video_US_SA_Multipub_CTV'
            when deal = 'STI-USD-01287' then 'USD_ATD_GG__Client Direct_DBM_Health Partners__Video_US_SA_Multipub_CTV'
            when deal = 'STI-DSP-00182' then 'USD_DSP_RF_SEL_DSP Direct_AdGear_Samsung_Samsung_Video_US_MA_MultiPub__CTV'
            when deal = 'STI-USD-00489' then 'USD_DSP_RF_DSP Direct_DataXu___Video_US_MA_Multipub_CTV RON'
            when deal = 'STI-USD-00857' then 'USD_DSP_GJ_SEL_DSP Direct_Simpli.fi___Video_US_MA_MultiPub_All Devices_STRM SERV'
            when deal = 'STI-USD-00574' then 'USD_DSP_FB_SEL__MultiDSP___Video_US_MA_Multipub_CTV_News'
            when deal = 'STI-USD-00353' then 'USD_DSP_RF_Comcast Spotlight_Beeswax___Video_US_MA_MultiPub_CTV'
            when deal = 'STI-USD-01354' then 'USD_DSP_FB__DSP Direct_Adelphic___Video_US_MA_MultiPub_Desktop_Mobile Web_90s_CTV'
            when deal = 'STI-USD-01379' then 'USD_DSP_FB_SEL_DSP Direct_Videology___Video_US_MA_MultiPub_CTV_FEP'
            when deal = 'STI-USD-01293' then 'USD_DSP_GJ_SEL_DSP Direct_Adobe___Video_US_MA_Multipub_CTV_LDA'
            when deal = 'STI-USD-01289' then 'USD_DSP_GJ_SEL_DSP Direct_Adobe___FEP_US_MA_Multipub_CTV'
            when deal = 'STI-USD-00467' then 'USD_DSP_RF_SEL_DSP Direct_MediaMath___US_MA_Multipub_CTV'
            when deal = 'STI-USD-01474' then 'USD_ATD_AM__Rise Interactive_TTD___FEP_US_MultiPub_Mobile APP_CTV'
            when deal = 'STI-USD-01475' then 'USD_ATD_AM__Rise Interactive_TTD___FEP_US_MultiPub_Desktop_Mobile Web'
            when deal = 'STI-USD-01603' then 'USD_ATD_CK_SEL_Canvas Worldwide_TTD_Hyundai__FEP_US_SA_Multipub_Desktop_Mobile Web_VPAID'
            when deal = 'STI-USD-01578' then 'USD_ATD_CK__Cadreon_TTD_Amazon POLV__Video_US__MultiPub_Desktop'
            when deal = 'STI-USD-00121' then 'USD_ATD_EM_SEL_Ntooitive_TTD___Video_US_MultiPub_CTV Broadcasters'
            when deal = 'STI-USD-00917' then 'USD_ATD_EM_SEL_PHD_MultiDSP___FEP_US_MultiPub_CTV_Tier 3'
            when deal = 'STI-USD-01022' then 'USD_ATD_EM_AdForm_AdForm_Columbia__FEP_US_Multipub_Desktop'
            when deal = 'STI-USD-01024' then 'USD_ATD_EM_AdForm_AdForm_Columbia__FEP_US_Multipub_Mobile Web'
            when deal = 'STI-USD-01035' then 'USD_ATD_GG_SEL_Cadreon_TTD_Exxon Mobile__FEP_US_Multipub_Desktop_Mobile Web'
            when deal = 'STI-USD-01036' then 'USD_ATD_GG_SEL_Cadreon_TTD_Exxon Mobile__FEP_US_Multipub_Mobile APP'
            when deal = 'STI-USD-01037' then 'USD_ATD_GG_SEL_Cadreon_TTD_Exxon Mobile__FEP_US_Multipub_CTV'
            when deal = 'STI-USD-01141' then 'USD_ATD_EM_SEL_Zimmerman Adv_DBM_Walk-On√¢‚Ç¨‚Ñ¢s Bistreaux & Bar__Video_US_MultiPub_CTV_Sports'
            when deal = 'STI-USD-01142' then 'USD_ATD_EM_SEL_Zimmerman Adv_DBM_Walk-On√¢‚Ç¨‚Ñ¢s Bistreaux & Bar__Video_US_MultiPub_CTV_Live Sports'
            when deal = 'STI-USD-01188' then 'USD_ATD_GG_SEL_Cadreon_TTD_BMW__FEP_US_MultiPub_CTV_Tier 2 CXE DelVal X7_Freewheel'
            when deal = 'STI-USD-01356' then 'USD_ATD_EM__MediaStorm_TTD_Ethan Allen__Video_US_MultiPub_CTV_Broadcasters'
            when deal = 'STI-USD-01511' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Digital Pureplays_US_MA_MultiPub_CTV_Mobile APP'
            when deal = 'STI-USD-01553' then 'USD_ATD_EM__Converge Direct_TTD_Great Wolf Lodge__FEP_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-01554' then 'USD_ATD_EM__Converge Direct_TTD_Great Wolf Lodge__FEP_US_SA_MultiPub_Mobile APP'
            when deal = 'STI-USD-01555' then 'USD_ATD_EM__Converge Direct_TTD_Great Wolf Lodge__FEP_US_SA_MultiPub_Desktop_Mobile Web'
            when deal = 'STI-USD-01579' then 'USD_ATD_CK__Cadreon_TTD_Amazon POLV__Video_US__MultiPub_Mobile App_Mobile Web'
            when deal = 'STI-USD-01580' then 'USD_ATD_CK__Cadreon_TTD_Amazon POLV__Video_US__MultiPub_CTV'
            when deal = 'STI-USD-01601' then 'USD_ATD_JF__Spark Foundry_TTD_Delta Faucets__Video_US__MultiPub_CTV'
            when deal = 'STI-USD-01602' then 'USD_ATD_EM_SEL_PHD Media_TTD_MailChimp__Video_US__MultiPub_CTV'
            when deal = 'STI-USD-01618' then 'USD_ATD_EM_SEL_PHD_TTD_VW__Video_US_SA_MultiPub_Desktop_Mobile Web_VW Tier 2'
            when deal = 'STI-USD-01619' then 'USD_ATD_EM_SEL_PHD_TTD_VW__Video_US_SA_MultiPub_Mobile APP_VW Tier 2'
            when deal = 'STI-USD-01661' then 'USD_ATD_EM_SEL_Media IQ_Xandr_Maine Momentum__Video_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-01680' then 'USD_ATD_EM__MediaStorm_TTD_The Walking Dead RON__FEP_US__MultiPub_CTV'
            when deal = 'STI-USD-01681' then 'USD_ATD_EM__MediaStorm_TTD_The Walking Dead Contextual __FEP_US__MultiPub_CTV'
            when deal = 'STI-USD-01691' then 'USD_ATD_EM_SEL_PHD_TTD_VW Tier 2__Video_US_SA_MultiPub_CTV_2020'
            when deal = 'STI-USD-01706' then 'USD_ATD_JF__National Media_DV360___Video_US__MultiPub_All Devices'
            when deal = 'STI-USD-01510' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Digital Pureplays_US_MA_MultiPub_Desktop_MWeb_DNU'
            when deal = 'STI-USD-01574' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Digital Pureplays_US_MA_MultiPub_Desktop_Mobile Web'
            when deal = 'STI-USD-01571' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Premium Broadcasters_US_MA_MultiPub_CTV_Mobile APP'
            when deal = 'STI-USD-01509' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Premium Broadcasters_US_MA_MultiPub_Desktop_MWeb_DNU'
            when deal = 'STI-USD-01572' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Premium Broadcasters_US_MA_MultiPub_Desktop_Mobile Web'
            when deal = 'STI-USD-01764' then 'USD_ATD_EM__Hearts & Science_DV360_Warner Bros US__Video_US_SA_MultiPub_Desktop_Mobile Web_Tier2'
            when deal = 'STI-USD-01766' then 'USD_ATD_EM__Hearts & Science_DV360_Warner Bros US__Video_US_SA_MultiPub_Desktop_Mobile Web_Tier1'
            when deal = 'STI-USD-01765' then 'USD_ATD_EM__Hearts & Science_DV360_Warner Bros US__Video_US_SA_MultiPub_Desktop_Mweb_Mapp_Tier2'
            when deal = 'STI-USD-01767' then 'USD_ATD_EM__Hearts & Science_DV360_Warner Bros US__Video_US_SA_MultiPub_Desktop_Mweb_Mapp_Tier1'
            when deal = 'STI-USD-01742' then 'USD_ATD_EM_SEL_ Publicis Health_TTD_Novo Nordisk__Video_US__Multipub_CTV_Tier1'
            when deal = 'STI-USD-01743' then 'USD_ATD_EM_SEL_ Publicis Health_TTD_Novo Nordisk__Video_US__Multipub_CTV_Tier2'
            when deal = 'STI-USD-01747' then 'USD_ATD_EM_SEL_ Publicis Health_TTD_Novo Nordisk__Video_US__Multipub_CTV_Tier3'
            when deal = 'FOU-USD-00010' then 'USD_DSP_RF_SEL_DSP Direct_DataXu___Video_FF Hub_US_MultiPub_Mobile APP'
            when deal = 'STI-USD-00661' then 'USD_DSP_RF_SEL_DSP Direct_DataXu___Video_US_Multipub_Mobile APP'
            when deal = 'FOU-USD-00009' then 'USD_DSP_RF_SEL_DSP Direct_DataXu___Video_FF Hub_US_MultiPub_Desktop_Mobile Web'
            when deal = 'FOU-USD-00011' then 'USD_DSP_RF_SEL_DSP Direct_DataXu___Video_FF Hub_US_MultiPub_CTV'
            when deal = 'STI-ACC-00070' then 'USD_ATD_EM_Accuen Media_MultiDSP___Video_US_MultiPub__Desktop_Mobile Web'
            when deal = 'STI-ACC-00071' then 'USD_ATD_EM_Accuen Media_MultiDSP___Video_US_MultiPub__Desktop_Mobile Web_Mobile App'
            when deal = 'STI-USD-01551' then 'USD_ATD_AM_SEL_Spark Foundry_TTD_Dairy Queen__Video_US_SA_MultiPub_Desktop_Mobile Web'
            when deal = 'STI-USD-01744' then 'USD_ATD_CK_SEL_The Richards Group_Amobee_Natures Own__FEP_US__Multipub_CTV'
            when deal = 'STI-USD-01745' then 'USD_ATD_CK_SEL_The Richards Group_Amobee_Wonder__FEP_US__Multipub_CTV'
            when deal = 'STI-USD-01508' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Premium Broadcasters_US_MA_MultiPub_CTV_Mobile APP V1'
            when deal = 'STI-USD-01571' then 'USD_ATD_AM__Launch Media (Bounteous US)_DV360_Premium Broadcasters_US_MA_MultiPub_CTV_Mobile APP V2'
            when deal = 'STI-USD-01783' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US__MultiPub_CTV V1'
            when deal = 'STI-USD-01784' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US__MultiPub_CTV V2'
            when deal = 'STI-USD-01785' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US__MultiPub_Desktop_Mobile App_Mobile Web V1'
            when deal = 'STI-USD-01786' then 'USD_ATD_JF_SEL_Redfuse_TTD_Colgate__Video_US__MultiPub_Desktop_Mobile App_Mobile Web V2'
            when deal = 'STI-USD-01427' then 'USD_ATD_JF_SEL_Blueprint_TTD___Video_US_MultiPub_All Devices'
            when deal = 'STI-USD-01867' then 'USD_ATD_GG_SEL_Cadreon_TTD_CVS_US_SA_MultiPub_CTV'
            when deal = 'STI-USD-01427' then 'USD_ATD_JF_SEL_Blueprint_TTD___Video_US_MultiPub_All Devices'
            when deal = 'STI-USD-01877' then 'USD_DSP_ZR_SEL_Roku_Progressive Corperation_DataXu__Custom_US_CTV'
            when deal = 'STI-USD-01878' then 'USD_ATD_EM__Keynes Digital__TTD__Custom_US_CrossDevice'
            when deal = 'STI-USD-01881' then 'USD_FWM_NMC__DecisionMakers_RON Cross Device'
            when deal = 'STI-USD-01946' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Project Riveter_TTD_RON 30s__US_CTV'
            when deal = 'STI-USD-01947' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Project Riveter_TTD_RON longform 60s__US_CTV'
            when deal = 'STI-USD-01948' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Project Riveter_TTD_RON 30s Non-Skip_US_Mobile'
            when deal = 'STI-USD-01949' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Project Riveter_TTD_RON longform 60s Non-Skip__US_Mobile'
            when deal = 'STI-USD-01950' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Project Riveter_TTD_RON 30s Non-Skip__US_Desktop'
            when deal = 'STI-USD-01951' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Project Riveter_TTD_RON longform 60s Non-Skip__US_Desktop'
            when deal = 'STI-USD-01952' then 'USD_ATD_GG_SEL_MatterKind_BODYARMOR_TTD_NMC_Active Adults_RON_US_CTV'
            when deal = 'STI-USD-01953' then 'USD_ATD_GG_SEL_MatterKind_BODYARMOR_TTD_NMC_Gatekeepers_RON_US_CTV'
            when deal = 'STI-USD-01954' then 'USD_ATD_GG_SEL_MatterKind_BODYARMOR_TTD_NMC_Young Athletes_RON_US_CTV'
            when deal = 'STI-USD-01955' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Power Elites_TTD_News 30s_US_CTV'
            when deal = 'STI-USD-01956' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Power Elites_TTD_News Longform 60s_US_CTV'
            when deal = 'STI-USD-01957' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Power Elites_TTD_News 30s Non-Skip_US_Mobile'
            when deal = 'STI-USD-01958' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Power Elites_TTD_News Longform 60s Non-Skip_US_Mobile'
            when deal = 'STI-USD-01959' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Power Elites_TTD_News 30s Non-Skip_US_Desktop'
            when deal = 'STI-USD-01960' then 'USD_ATD_DK_SEL_Matterkind_Amazon - Power Elites_TTD_News Longform 60s Non-Skip_US_Desktop'
            when deal = 'STI-USD-02016' then 'USD_ATD_GG_SEL_Xaxis__TTD__Custom_US_Crossdevice_Spotlight'
            when deal = 'STI-USD-01585' then 'USD_ATD_GG_SEL_Cadreon_TTD_Spotify__Video_US__MultiPub_CTV1'
            when deal = 'STI-USD-01853' then 'USD_ATD_GG_SEL_Cadreon_TTD_Spotify__Video_US__MultiPub_CTV2'
          else deal_name
          end as deal_name
        from sampledb.deal) as deal_names_clean
           on deal.deal = deal_names_clean.deal
        left join sampledb.fx_rates as fx_rates
           on fx_rates.day = day(deal.dt)
           and fx_rates.month = month(deal.dt)
           and fx_rates.year = year(deal.dt)
        WHERE deal.dt > (SELECT MAX(dt) FROM sampledb.deal_clean)
        ;;

   }
   datagroup_trigger: sfx_refresh
 }

}
