
/*
DELETE FROM "data";
DELETE FROM numerical_data;
DELETE FROM environmental_condition;
DELETE FROM constants_of_substance;
DELETE FROM substance;
DELETE FROM uncertainty;
DELETE FROM data_source;
DELETE FROM property_state;
DELETE FROM property;
DELETE FROM dimension;
DELETE FROM state_state;
DELETE FROM state;
*/
CREATE OR REPLACE FUNCTION do_work_plpgsql() RETURNS pg_catalog.void AS $$
DECLARE
    gas_id bigint;
    idgas_id bigint;
    data_source_1_id bigint;
    data_source_2_id bigint;
    dimension_kj_mol_id bigint;
    dimension_j_mol_k_id bigint;
    dimension_k_id bigint;
    dimension_atm_id bigint;
    dimension_ev_id bigint;
    dimension_empty_id bigint;
    property_dhf0_id bigint;
    property_dhf298_id bigint;
    property_z_id bigint;
    property_i_id bigint;
    property_cp_id bigint;
    property_f_id bigint;
    property_s_id bigint;
    property_h_id bigint;
    property_h298_id bigint;
    property_t_id bigint;
    property_p_id bigint;
    uncertainty_precision_class_1_id bigint;
    uncertainty_precision_class_1_a_id bigint;
    uncertainty_precision_class_3_c_id bigint;
    uncertainty_precision_class_1_b_id bigint;
    uncertainty_precision_class_1_c_id bigint;
    uncertainty_precision_class_4_c_id bigint;
    uncertainty_precision_class_4_d_id bigint;
    uncertainty_standard_uncertainty_id bigint;
    current_state_id bigint;
    current_substance_id bigint;
    current_environmental_condition_id bigint;
BEGIN
/* States */
INSERT INTO state(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'gas')
	RETURNING id INTO gas_id;
INSERT INTO state(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'idgas')
	RETURNING id INTO idgas_id;
--INSERT INTO state_state(state_following_id, state_id) VALUES (idgas_id, gas_id);

/* Dimensions */
INSERT INTO dimension(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'kJ/mol')
	RETURNING id INTO dimension_kj_mol_id;
INSERT INTO dimension(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'J/mol*K')
	RETURNING id INTO dimension_j_mol_k_id;
INSERT INTO dimension(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'K')
	RETURNING id INTO dimension_k_id;
INSERT INTO dimension(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'atm')
	RETURNING id INTO dimension_atm_id;
INSERT INTO dimension(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'eV')
	RETURNING id INTO dimension_ev_id;
INSERT INTO dimension(id, version, name) VALUES (nextval('hibernate_sequence'), 1, '')
	RETURNING id INTO dimension_empty_id;

/* Properties */
INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_kj_mol_id, 'Энтальпия образования при 0К', 'DHF(0)')
	RETURNING id INTO property_dhf0_id;
INSERT INTO property_state(property_id, state_id)
VALUES (property_dhf0_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_kj_mol_id, 'Энтальпия образования при 298.15К', 'DHF(298)')
	RETURNING id INTO property_dhf298_id;
INSERT INTO property_state(property_id, state_id)
VALUES (property_dhf298_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_empty_id, 'Заряд иона', 'Z')
	RETURNING id INTO property_z_id;
INSERT INTO property_state(property_id, state_id)
VALUES (property_z_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_ev_id, 'Потенциал ионизации', 'I')
	RETURNING id INTO property_i_id;
INSERT INTO property_state(property_id, state_id)
VALUES (property_i_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_j_mol_k_id, 'Тепломкость изобарная', 'Cp')
	RETURNING id INTO property_cp_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_cp_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_j_mol_k_id, 'Приведенный изобарно-изотермический потенциал', 'F')
	RETURNING id INTO property_f_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_f_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_j_mol_k_id, 'Энтропия стандартная', 'S')
	RETURNING id INTO property_s_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_s_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_kj_mol_id, 'Изменение энтальпии по отношению к T=0 K', 'H')
	RETURNING id INTO property_h_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_h_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_kj_mol_id, 'Изменение энтальпии по отношению к T=298 K', 'H298')
	RETURNING id INTO property_h298_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_h298_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_k_id, 'Температура', 'T')
	RETURNING id INTO property_t_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_t_id, idgas_id);

INSERT INTO property(id, version, dimension_id, name, prop_designation)
VALUES (nextval('hibernate_sequence'), 1, dimension_atm_id, 'Давление', 'P')
	RETURNING id INTO property_p_id;
INSERT INTO property_state(property_id,state_id)
VALUES (property_p_id, idgas_id);

/* Uncertainities */
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 1')
	RETURNING id INTO uncertainty_precision_class_1_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 1-A')
	RETURNING id INTO uncertainty_precision_class_1_a_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 1-B')
	RETURNING id INTO uncertainty_precision_class_1_b_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 1-C')
	RETURNING id INTO uncertainty_precision_class_1_c_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 3-C')
	RETURNING id INTO uncertainty_precision_class_3_c_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 4-C')
	RETURNING id INTO uncertainty_precision_class_4_c_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Precision class 4-D')
	RETURNING id INTO uncertainty_precision_class_4_d_id;
INSERT INTO uncertainty(id, version, name) VALUES (nextval('hibernate_sequence'), 1, 'Standard uncertainty')
	RETURNING id INTO uncertainty_standard_uncertainty_id;

/* 1.xls */
INSERT INTO data_source(id, version, name) VALUES (nextval('hibernate_sequence'), 1, E'ИСТОЧНИК\n'
'Гурвич Л.В., Вейц И.В., Медведев В.А. и др.\n'
'Термодинамические свойства индивидуальных веществ.\n'
'Том 1, книга 1 и 2.\n'
'Москва, Наука, 1978')
	RETURNING id INTO data_source_1_id;

/* Substance Oxygen */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Oxygen', 'O')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_1_id, 0, 246.795);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_1_id, 0, 249.17999);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_1_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.911);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 138.393);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 160.949);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 6.725);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.900);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 138.533);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 161.085);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 6.766);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.270);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 149.952);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 172.092);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 11.070);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.035);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 157.353);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 179.206);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 15.297);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.932);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 162.820);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 184.479);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 19.493);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.890);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 167.152);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 188.674);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 23.674);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.873);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 170.739);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 192.163);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 27.850);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.854);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 173.800);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 195.148);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 32.023);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.854);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 173.800);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 195.148);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 32.023);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.830);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 176.468);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 197.757);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 36.191);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.816);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 178.833);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 200.073);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 40.356);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.815);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 180.957);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 202.156);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 44.519);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.825);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 182.884);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 204.050);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 48.682);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.846);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 184.647);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 205.787);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 52.849);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.879);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 186.273);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 207.393);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 57.022);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.921);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 187.782);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 208.886);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 61.201);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 20.973);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 189.189);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 210.283);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 65.391);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.034);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 190.508);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 211.596);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 69.591);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.103);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 191.749);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 212.836);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 73.805);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.179);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 192.920);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 214.010);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 78.033);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.262);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 194.031);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 215.128);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 82.277);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.349);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 195.086);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 216.193);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 86.538);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.441);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 196.092);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 217.212);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 90.817);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.537);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 197.052);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 218.189);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 95.115);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.635);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 197.972);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 219.128);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 99.432);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.736);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 198.854);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 220.031);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 103.769);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.837);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 199.702);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 220.903);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 108.126);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 21.938);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 200.518);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 221.745);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 112.504);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 22.038);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 201.304);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 222.559);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 116.902);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 22.137);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 202.064);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 223.348);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 121.319);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 22.233);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 202.799);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 224.113);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 125.756);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_id, 0, 22.279);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_id, 0, 203.157);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_id, 0, 224.487);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_id, 0, 127.982);
/* End of substance Oxygen */

/* Substance Oxygen positive ion */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Oxygen positive ion', 'O+')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_1_a_id, 0, 1560.73804);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_1_a_id, 0, 1568.79199);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_z_id, current_substance_id, uncertainty_precision_class_1_a_id, 0, 1);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_1_a_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 134.064);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 154.849);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 6.197);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 134.193);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 154.978);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 6.235);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 144.810);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 165.596);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 10.393);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 151.804);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 172.590);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 14.550);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 157.028);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 177.813);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 18.707);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 161.199);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 181.984);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 22.864);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 164.671);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 185.457);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 27.021);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 167.646);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 188.431);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 31.179);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 170.247);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 191.033);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 35.336);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 172.559);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 193.345);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 39.493);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 174.639);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 195.425);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 43.650);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 176.530);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 197.316);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 47.807);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 178.264);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 199.049);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 51.965);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.786);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 178.264);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 199.049);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 51.965);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.783);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 179.863);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 200.649);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 56.122);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.778);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 181.349);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 202.134);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 60.278);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.776);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 182.735);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 203.520);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 64.433);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.783);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 184.034);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 204.819);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 68.589);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.800);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 185.257);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 206.042);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 72.747);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.830);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 186.412);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 207.199);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 76.910);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.873);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 187.507);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 208.296);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 81.080);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 20.930);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 188.546);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 209.341);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 85.260);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.002);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 189.537);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 210.340);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 89.453);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.090);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 190.483);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 211.297);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 93.662);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.193);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 191.388);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 212.216);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 97.890);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.312);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 192.257);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 213.102);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 102.140);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.447);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 193.091);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 213.957);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 106.416);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.596);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 193.894);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 214.785);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 110.720);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.761);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 194.668);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 215.587);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 115.055);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 21.942);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 195.416);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 216.368);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 119.425);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 22.136);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 196.139);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 217.128);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 123.833);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_a_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_a_id, 0, 22.239);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_a_id, 0, 196.492);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_a_id, 0, 217.501);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_a_id, 0, 126.052);
/* End of substance Oxygen positive ion */

/* Substance Oxygen negative ion */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Oxygen negative ion', 'O-')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_3_c_id, 0, 105.595);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_3_c_id, 0, 101.629);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_z_id, current_substance_id, uncertainty_precision_class_3_c_id, 0, -1);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_3_c_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 21.685);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 135.646);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 157.685);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 6.571);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 21.676);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 135.782);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 157.819);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 6.611);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 21.183);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 146.977);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 168.751);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 10.887);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 21.004);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 154.270);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 175.846);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 15.103);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.920);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 159.675);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 181.113);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 19.295);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.878);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 163.967);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 185.307);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 23.474);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.857);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 167.525);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 188.792);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 27.647);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.840);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 170.565);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 191.776);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 31.817);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.840);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 170.565);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 191.776);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 31.817);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.824);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 173.217);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 194.383);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 35.983);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.816);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 175.569);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 196.699);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 40.147);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.810);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 177.682);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 198.782);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 44.310);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.807);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 179.600);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 200.675);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 48.471);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.805);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 181.357);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 202.410);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 52.633);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.803);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 182.976);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 204.011);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 56.793);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.802);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 184.479);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 205.497);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 60.954);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.801);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 185.880);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 206.885);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 65.114);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.800);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 187.193);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 208.185);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 69.275);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.799);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 188.428);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 209.409);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 73.434);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.797);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 189.593);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 210.565);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 77.594);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.796);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 190.697);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 211.660);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 81.753);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.795);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 191.745);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 212.700);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 85.912);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.793);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 192.743);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 213.690);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 90.071);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.792);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 193.695);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 214.635);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 94.230);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.790);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 194.606);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 215.539);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 98.388);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.789);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 195.478);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 216.406);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 102.546);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.788);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 196.315);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 217.237);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 106.703);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.787);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 197.120);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 218.037);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 110.861);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.787);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 197.894);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 218.807);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 115.018);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.787);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 198.641);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 219.549);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 119.176);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.788);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 199.362);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 220.266);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 123.333);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_3_c_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_3_c_id, 0, 20.789);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_3_c_id, 0, 199.714);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_3_c_id, 0, 220.616);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_3_c_id, 0, 125.412);
/* End of substance Oxygen negative ion */

/* 2.xls */
/* Substance Dioxygen */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Dioxygen', 'O2')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_1_b_id, 0, 0);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_1_b_id, 0, 0);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_1_b_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 29.378);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 175.925);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 205.038);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 8.680);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 29.384);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 176.105);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 205.220);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 8.734);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 30.113);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 184.498);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 213.759);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 11.705);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 31.110);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 191.054);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 220.585);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 14.765);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 600.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 32.090);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 196.468);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 226.345);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 17.926);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 32.970);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 201.102);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 231.359);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 21.180);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 800.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 33.728);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 205.168);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 235.812);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 24.516);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 34.366);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 208.799);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 239.823);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 27.921);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 34.895);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 212.087);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 243.472);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 31.385);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 35.332);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 215.094);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 246.819);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 34.897);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 35.695);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 217.868);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 249.909);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 38.449);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 36.005);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 220.445);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 252.779);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 42.035);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 36.282);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 222.851);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 255.457);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 45.649);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 36.548);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 225.109);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 257.970);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 49.291);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 36.548);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 225.109);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 257.970);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 49.291);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1600.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 36.812);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 227.238);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 260.337);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 52.959);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 37.068);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 229.251);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 262.576);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 56.653);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1800.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 37.317);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 231.162);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 264.702);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 60.372);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 37.560);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 232.981);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 266.726);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 64.116);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 37.798);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 234.717);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 268.659);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 67.884);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 38.032);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 236.378);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 270.509);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 71.675);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 38.262);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 237.970);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 272.283);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 75.490);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 38.488);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 239.499);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 273.989);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 79.328);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 38.710);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 240.970);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 275.632);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 83.188);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 38.929);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 242.389);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 277.217);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 87.070);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2600.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 39.143);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 243.758);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 278.748);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 90.973);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 39.354);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 245.081);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 280.229);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 94.898);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2800.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 39.562);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 246.362);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 281.664);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 98.844);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 39.765);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 247.604);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 283.056);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 102.810);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 39.965);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 248.808);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 284.407);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 106.797);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 40.160);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 249.978);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 285.721);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 110.803);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 40.352);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 251.115);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 286.999);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 114.829);
/* line 33 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 40.539);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 252.221);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 288.244);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 118.874);
/* line 34 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 40.722);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 253.299);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 289.457);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 122.937);
/* line 35 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 40.901);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 254.349);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 290.640);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 127.018);
/* line 36 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3600.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 41.075);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 255.373);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 291.794);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 131.117);
/* line 37 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 41.244);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 256.373);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 292.922);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 135.233);
/* line 38 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3800.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 41.408);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 257.349);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 294.024);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 139.365);
/* line 39 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 41.567);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 258.303);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 295.102);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 143.514);
/* line 40 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 41.721);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 259.236);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 296.156);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 147.679);
/* line 41 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 41.870);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 260.149);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 297.188);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 151.858);
/* line 42 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.012);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 261.043);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 298.199);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 156.052);
/* line 43 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.149);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 261.919);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 299.189);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 160.261);
/* line 44 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.281);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 262.777);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 300.159);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 164.482);
/* line 45 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.406);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 263.618);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 301.111);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 168.716);
/* line 46 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4600.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.525);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 264.444);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 302.044);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 172.963);
/* line 47 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.637);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 265.254);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 302.960);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 177.221);
/* line 48 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.637);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 265.254);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 302.960);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 177.221);
/* line 49 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4800.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.748);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 266.048);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 303.859);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 181.490);
/* line 50 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.860);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 266.829);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 304.742);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 185.771);
/* line 51 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 42.974);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 267.596);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 305.609);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 190.062);
/* line 52 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.088);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 268.350);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 306.461);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 194.366);
/* line 53 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.200);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 269.091);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 307.298);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 198.680);
/* line 54 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.309);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 269.819);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 308.122);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 203.005);
/* line 55 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.416);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 270.536);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 308.933);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 207.342);
/* line 56 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.519);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 271.242);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 309.731);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 211.688);
/* line 57 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5600.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.618);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 271.936);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 310.516);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 216.045);
/* line 58 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.712);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 272.620);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 311.288);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 220.412);
/* line 59 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5800.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.800);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 273.293);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 312.049);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 224.788);
/* line 60 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.883);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 273.956);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 312.799);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 229.172);
/* line 61 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_b_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_b_id, 0, 43.960);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_b_id, 0, 274.610);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_b_id, 0, 313.537);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_b_id, 0, 233.564);
/* End of substance Dioxygen */

/* 3.xls */
/* Substance Dioxygen positive ion */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Dioxygen positive ion', 'O2+')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_1_c_id, 0, 1165);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_1_c_id, 0, 1171.828);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_1_c_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 30.670);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 174.052);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 205.281);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 9.311);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 30.652);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 174.245);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 205.471);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 9.368);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 30.893);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 190.113);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 221.066);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 15.476);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 32.240);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 200.546);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 231.670);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 21.787);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 33.522);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 208.413);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 239.931);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 28.367);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 34.566);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 214.782);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 246.763);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 35.180);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 34.994);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 217.575);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 249.790);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 38.658);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 34.994);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 217.575);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 249.790);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 38.658);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 35.357);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 220.162);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 252.606);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 42.176);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 35.920);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 224.835);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 257.707);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 49.307);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 36.337);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 228.974);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 262.229);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 56.535);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 36.658);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 232.692);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 266.289);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 63.836);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 36.911);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 236.069);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 269.971);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 71.193);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.116);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 239.166);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 273.338);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 78.597);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.287);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 242.025);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 276.440);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 86.038);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.432);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 244.682);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 279.316);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 93.510);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.560);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 247.164);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 281.995);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 101.009);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.679);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 249.493);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 284.504);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 108.533);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.793);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 251.687);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 286.863);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 116.080);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 37.909);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 253.762);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 289.090);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 123.650);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 38.032);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 255.729);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 291.200);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 131.244);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 38.167);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 257.600);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 293.206);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 138.864);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 38.319);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 259.384);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 295.118);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 146.512);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 38.492);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 261.089);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 296.947);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 154.193);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 38.691);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 262.722);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 298.702);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 161.911);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 38.920);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 264.289);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 300.389);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 169.672);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 39.185);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 265.796);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 302.016);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 177.481);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 39.488);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 267.247);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 303.590);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 185.348);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 39.836);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 268.647);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 305.115);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 193.280);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 40.231);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 270.001);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 306.598);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 201.286);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 40.679);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 271.310);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 308.043);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 209.376);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 41.183);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 272.579);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 309.454);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 217.561);
/* line 33 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_1_c_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_1_c_id, 0, 41.458);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_1_c_id, 0, 273.200);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_1_c_id, 0, 310.148);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_1_c_id, 0, 221.693);
/* End of substance Dioxygen positive ion */

/* Substance Dioxygen negative ion */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Dioxygen negative ion', 'O2-')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_4_c_id, 0, -42.5);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_4_c_id, 0, -48.053);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_4_c_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 31.418);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 177.954);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 209.227);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 9.324);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 31.434);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 178.148);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 209.421);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 9.382);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 33.516);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 194.209);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 225.961);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 15.876);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 35.124);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 205.011);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 237.513);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 22.752);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 36.086);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 213.266);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 246.468);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 29.882);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 36.677);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 219.987);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 253.770);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 37.161);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 36.677);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 219.987);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 253.770);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 37.161);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 37.104);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 225.671);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 259.934);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 44.542);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 37.415);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 230.602);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 265.266);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 51.995);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 37.665);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 234.962);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 269.965);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 59.504);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 37.885);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 238.872);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 274.166);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 67.059);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 38.087);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 242.417);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 277.968);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 74.657);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 38.281);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 245.662);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 281.441);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 82.294);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 38.472);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 248.654);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 284.641);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 89.969);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 38.661);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 251.431);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 287.609);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 97.682);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 38.850);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 254.022);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 290.379);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 105.433);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 39.041);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 256.452);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 292.976);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 113.222);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 39.232);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 258.741);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 295.423);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 121.050);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 39.424);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 260.904);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 297.737);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 128.915);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 39.617);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 262.954);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 299.933);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 136.819);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 39.808);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 264.905);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 302.023);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 144.762);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 39.999);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 266.765);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 304.019);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 152.743);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.188);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 268.542);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 305.928);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 160.761);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.373);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 270.245);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 307.760);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 168.818);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.373);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 270.245);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 307.760);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 168.818);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.541);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 271.879);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 309.519);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 176.909);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.675);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 273.450);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 311.211);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 185.032);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.773);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 274.963);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 312.841);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 193.177);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.833);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 276.422);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 314.410);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 201.338);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.856);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 277.831);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 315.923);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 209.508);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.840);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 279.193);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 317.382);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 217.678);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.787);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 280.512);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 318.790);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 225.841);
/* line 33 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_c_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_c_id, 0, 40.746);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_c_id, 0, 281.156);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_c_id, 0, 319.475);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_c_id, 0, 229.918);
/* End of substance Dioxygen negative ion */

/* 4.xls */
/* Substance Dioxygen negative ion */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Ozone', 'O3')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf0_id, current_substance_id, uncertainty_precision_class_4_d_id, 0, 144.454);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, property_dhf298_id, current_substance_id, uncertainty_precision_class_4_d_id, 0, 141.8);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_precision_class_4_d_id, 0, 1);

/* line 1 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 298.15);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 39.374);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 204.128);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 238.896);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 10.366);
/* line 2 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 39.465);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 204.343);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 239.140);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 10.439);
/* line 3 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 47.502);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 222.939);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 261.329);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 19.195);
/* line 4 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 52.358);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 236.407);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 278.159);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 29.226);
/* line 5 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 55.042);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 247.238);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 291.675);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 39.993);
/* line 6 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 56.679);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 256.366);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 302.887);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 51.173);
/* line 7 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 57.462);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 260.452);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 307.851);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 56.880);
/* line 8 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1200.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 57.462);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 260.452);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 307.851);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 56.880);
/* line 9 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 58.189);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 264.278);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 312.481);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 62.664);
/* line 10 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 59.626);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 271.277);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 320.902);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 74.437);
/* line 11 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 61.937);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 277.569);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 328.495);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 86.574);
/* line 12 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 1900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 65.580);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 283.305);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 335.569);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 99.302);
/* line 13 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 70.656);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 288.608);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 342.371);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 112.902);
/* line 14 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 77.083);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 293.575);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 349.077);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 127.655);
/* line 15 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 80.751);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 295.957);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 352.434);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 135.544);
/* line 16 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 80.751);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 295.957);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 352.434);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 135.544);
/* line 17 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 84.664);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 298.284);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 355.809);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 143.813);
/* line 18 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 92.494);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 302.797);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 362.625);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 161.537);
/* line 19 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 2900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 99.332);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 307.160);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 369.485);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 180.743);
/* line 20 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 3100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 104.511);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 311.401);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 376.290);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 201.159);
/* line 21 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 3300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 107.776);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 315.536);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 382.936);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 222.420);
/* line 22 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 3500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 109.147);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 319.571);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 389.326);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 244.142);
/* line 23 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 3700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 108.831);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 323.507);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 395.390);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 265.966);
/* line 24 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 3900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 107.170);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 327.341);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 401.081);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 287.585);
/* line 25 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 104.597);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 331.069);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 406.379);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 308.773);
/* line 26 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 101.616);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 334.687);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 411.291);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 329.396);
/* line 27 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 100.144);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 336.455);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 413.610);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 339.484);
/* line 28 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4400.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 100.144);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 336.455);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 413.610);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 339.484);
/* line 29 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 98.734);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 338.195);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 415.845);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 349.427);
/* line 30 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 96.047);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 341.590);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 420.080);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 368.902);
/* line 31 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 4900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 93.561);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 344.875);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 424.030);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 387.859);
/* line 32 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 5100.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 91.304);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 348.053);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 427.727);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 406.342);
/* line 33 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 5300.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 89.306);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 351.125);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 431.201);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 424.398);
/* line 34 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 5500.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 87.595);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 354.097);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 434.476);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 442.083);
/* line 35 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 5700.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 86.199);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 356.973);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 437.579);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 459.457);
/* line 36 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 5900.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 85.146);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 359.755);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 440.533);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 476.586);
/* line 37 */
INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState No')    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_t_id, uncertainty_precision_class_4_d_id, 0, 6000.00);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_cp_id, uncertainty_precision_class_4_d_id, 0, 84.756);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_f_id, uncertainty_precision_class_4_d_id, 0, 361.114);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_s_id, uncertainty_precision_class_4_d_id, 0, 441.960);
INSERT INTO data(id, version, data_source_id, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_1_id, current_environmental_condition_id, property_h_id, uncertainty_precision_class_4_d_id, 0, 485.080);
/* End of substance Ozone */

/* 5.xls */
INSERT INTO data_source(id, version, name) VALUES (nextval('hibernate_sequence'), 1, E'ИСТОЧНИК\n'
'"База данных «Термические свойства веществ». ОИВТ РАН, Хим. фак-т МГУ."\n'
'http://www.chem.msu.ru/cgi-bin/tkv.pl?show=welcome.html/welcome.html')
	RETURNING id INTO data_source_2_id;

/* Substance Oxygen positive ion O[3+] */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Oxygen positive ion O[3+]', 'O[3+]')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_2_id, property_dhf0_id, current_substance_id, uncertainty_standard_uncertainty_id, 1.631, 10246.155);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_2_id, property_z_id, current_substance_id, uncertainty_standard_uncertainty_id, 0, 3);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_2_id, property_i_id, current_substance_id, uncertainty_standard_uncertainty_id, 0.01, 77.413);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_standard_uncertainty_id, 0, 1);

/* End of substance Oxygen positive ion O[3+] */
/* Substance Ozone positive ion */
INSERT INTO substance(id, version, name, subst_formula) VALUES (nextval('hibernate_sequence'), 1, 'Ozone positive ion', 'O3+')
	RETURNING id INTO current_substance_id;

current_state_id := idgas_id;

INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_2_id, property_dhf0_id, current_substance_id, uncertainty_standard_uncertainty_id, 10.041, 1379.883);
INSERT INTO constants_of_substance(id, version, data_source_id, property_id, substance_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, data_source_2_id, property_z_id, current_substance_id, uncertainty_standard_uncertainty_id, 0, 1);

INSERT INTO environmental_condition(id, version, state_id, substance_id, text_description)
VALUES (nextval('hibernate_sequence'), 1, current_state_id, current_substance_id, 'DefState Yes')
    RETURNING id INTO current_environmental_condition_id;
INSERT INTO numerical_data(id, version, environmentalcondition_id, property_id, uncertainty_id, uncertainty_value, value)
VALUES (nextval('hibernate_sequence'), 1, current_environmental_condition_id, property_p_id, uncertainty_standard_uncertainty_id, 0, 1);



/* End of substance Ozone positive ion */

--delete from lod_datasource;
insert into lod_datasource (id, name) values(45253,'ChemSpider');
--delete from predicates;
insert into predicates  (id, name) values(4392340,'http://www.w3.org/2002/07/owl#sameAs');

END
$$ LANGUAGE plpgsql;
SELECT do_work_plpgsql();

