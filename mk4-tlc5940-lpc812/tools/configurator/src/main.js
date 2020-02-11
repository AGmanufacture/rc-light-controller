'use strict';

/*global emitter, symbols, CodeMirror, ui, gamma, disassembler,
    intel_hex, parser, default_firmware_image_mk4,
    default_light_program, FileReader, Blob, saveAs, preprocessor_configuration,
    hardware_test_configuration, chrome, logger */



var app = (function () {
    var el = {};  // Cache of document.getElementById

    var SYSTICK_IN_MS = 20;

    var firmware;
    var config;
    var config_version;
    var local_leds;
    var slave_leds;
    var gamma_object;
    var light_programs;

    var default_firmware_version;

    var MAX_LIGHT_PROGRAMS = 25;
    // var MAX_LIGHT_PROGRAM_VARIABLES = 100;

    var light_switch_positions;

    var SECTION_CONFIG = 'Configuration';
    var SECTION_GAMMA = 'Gamma table';
    var SECTION_LIGHT_PROGRAMS = 'Light programs';
    var SECTION_LOCAL_LEDS = 'Local LEDs';
    var SECTION_SLAVE_LEDS = 'Slave LEDs';

    var SECTIONS = {
        0x01: SECTION_CONFIG,
        0x02: SECTION_GAMMA,
        0x10: SECTION_LOCAL_LEDS,
        0x20: SECTION_SLAVE_LEDS,
        0x30: SECTION_LIGHT_PROGRAMS,

        SECTION_CONFIG: 0x01,
        SECTION_GAMMA: 0x02,
        SECTION_LOCAL_LEDS: 0x10,
        SECTION_SLAVE_LEDS: 0x20,
        SECTION_LIGHT_PROGRAMS: 0x30
    };


    var MASTER_WITH_SERVO_READER = 'Master, servo inputs';
    var MASTER_WITH_UART_READER = 'Master, pre-processor input';
    var MASTER_WITH_UART_READER_5CH = 'Master, 5ch pre-processor input';
    var MASTER_WITH_CPPM_READER = 'Master, CPPM input';
    var SLAVE = 'Slave';
    var STAND_ALONE = 'Stand alone';
    var TEST = 'Hardware test';
    var PREPROCESSOR = 'Pre-processor';
    var PREPROCESSOR_5CH = 'Pre-processor 5ch';

    var MODE = {
        0: MASTER_WITH_SERVO_READER,
        1: MASTER_WITH_UART_READER,
        2: MASTER_WITH_CPPM_READER,
        3: SLAVE,
        4: STAND_ALONE,
        96: PREPROCESSOR_5CH,
        97: PREPROCESSOR,
        98: MASTER_WITH_UART_READER_5CH,
        99: TEST,

        MASTER_WITH_CPPM_READER: 2,
        MASTER_WITH_SERVO_READER: 0,
        MASTER_WITH_UART_READER: 1,
        MASTER_WITH_UART_READER_5CH: 98,
        PREPROCESSOR: 97,
        PREPROCESSOR_5CH: 96,
        SLAVE: 3,
        STAND_ALONE: 4,
        TEST: 99
    };

    var BAUDRATES = {
        0: 38400,
        1: 115200,

        38400: 0,
        115200: 1
    };

    var AUX_TYPE_TWO_POSITION = 'Two-position switch';
    var AUX_TYPE_TWO_POSITION_UP_DOWN = 'Two-position switch with up/down button';
    var AUX_TYPE_MOMENTARY = 'Momentary push button';
    var AUX_TYPE_THREE_POSITION = 'Three-position switch';
    var AUX_TYPE_ANALOG = 'Analog control';

    var AUX_TYPE = {
        0: AUX_TYPE_TWO_POSITION,
        1: AUX_TYPE_TWO_POSITION_UP_DOWN,
        2: AUX_TYPE_MOMENTARY,
        3: AUX_TYPE_THREE_POSITION,
        4: AUX_TYPE_ANALOG,

        AUX_TYPE_TWO_POSITION: 0,
        AUX_TYPE_TWO_POSITION_UP_DOWN: 1,
        AUX_TYPE_MOMENTARY: 2,
        AUX_TYPE_THREE_POSITION: 3,
        AUX_TYPE_ANALOG: 4
    };

    var AUX_FUNCTION_NOT_USED = 'Not used';
    var AUX_FUNCTION_MULTI_FUNCTION = 'Multi-function';
    var AUX_FUNCTION_GEARBOX = 'Gearbox';
    var AUX_FUNCTION_WINCH = 'Winch';
    var AUX_FUNCTION_SERVO = 'Servo control';
    var AUX_FUNCTION_INDICATORS = 'Indicators';
    var AUX_FUNCTION_HAZARD = 'Hazard';
    var AUX_FUNCTION_LIGHT_SWITCH = 'Light switch';
    var AUX_FUNCTION_DISABLE_OUTPUTS = 'Disable outputs';

    var AUX_FUNCTION = {
        0: AUX_FUNCTION_NOT_USED,
        1: AUX_FUNCTION_MULTI_FUNCTION,
        2: AUX_FUNCTION_GEARBOX,
        3: AUX_FUNCTION_WINCH,
        4: AUX_FUNCTION_SERVO,
        5: AUX_FUNCTION_INDICATORS,
        6: AUX_FUNCTION_HAZARD,
        7: AUX_FUNCTION_LIGHT_SWITCH,
        8: AUX_FUNCTION_DISABLE_OUTPUTS,

        AUX_FUNCTION_NOT_USED: 0,
        AUX_FUNCTION_MULTI_FUNCTION: 1,
        AUX_FUNCTION_GEARBOX: 2,
        AUX_FUNCTION_WINCH: 3,
        AUX_FUNCTION_SERVO: 4,
        AUX_FUNCTION_INDICATORS: 5,
        AUX_FUNCTION_HAZARD: 6,
        AUX_FUNCTION_LIGHT_SWITCH: 7,
        AUX_FUNCTION_DISABLE_OUTPUTS: 8
    };

    // var ESC_FORWARD_BRAKE_REVERSE_TIMEOUT = 'Forward/Brake/Reverse with timeout';
    // var ESC_FORWARD_BRAKE_REVERSE = 'Forward/Brake/Reverse no timeout';
    // var ESC_FORWARD_REVERSE = 'Forward/Reverse';
    // var ESC_FORWARD_BRAKE = 'Forward/Brake';

    // var ESC_MODE = {
    //     0: ESC_FORWARD_BRAKE_REVERSE_TIMEOUT,
    //     1: ESC_FORWARD_BRAKE_REVERSE,
    //     2: ESC_FORWARD_REVERSE,
    //     3: ESC_FORWARD_BRAKE,

    //     ESC_FORWARD_BRAKE_REVERSE_TIMEOUT: 0,
    //     ESC_FORWARD_BRAKE_REVERSE: 1,
    //     ESC_FORWARD_REVERSE: 2,
    //     ESC_FORWARD_BRAKE: 3
    // };




    var has_uart = (typeof chrome !== 'undefined'  &&  chrome.serial);
    var has_webusb = (typeof navigator.usb !== 'undefined');
    var serial_ports = {'dummy': 'dummy'};
    var number_of_serial_ports = 0;
    var usb_devices = [];
    // var preprocessor_simulator;
    // var preprocessor_simulator_disabled = true;

    var log = console;
    // let log = {
    //     log: () => {},
    //     info: () => {},
    //     warn: () => {},
    //     error: () => {},
    //     dir: () => {}
    // };



    // *************************************************************************
    var get_uint16 = function (data, offset) {
        return (data[offset + 1] * 256) + data[offset];
    };


    // *************************************************************************
    var get_uint32 = function (data, offset) {
        return (data[offset + 3] * 256 * 256 * 256) +
            (data[offset + 2] * 65536) +
            (data[offset + 1] * 256) + data[offset];
    };


    // *************************************************************************
    var set_uint8 = function (data, offset, value) {
        value = parseInt(value, 10);
        if (isNaN(value)) {
            log.log('ERROR in set_uint8 when setting offset ' + offset +
                ': value="' + value + '"');
            value = 0;
        }

        data[offset] = value % 256;
    };

    // *************************************************************************
    var set_int8 = function (data, offset, value) {
        value = parseInt(value, 10);
        if (isNaN(value)) {
            log.log('ERROR in set_int8 when setting offset ' + offset +
                ': value="' + value + '"');
            value = 0;
        }

        if (value < 0) {
            data[offset] = (256 + value) % 256;
        }
        else {
            data[offset] = value % 128;
        }
    };


    // *************************************************************************
    var set_uint16 = function (data, offset, value) {
        value = parseInt(value, 10);
        if (isNaN(value)) {
            log.log('ERROR in set_uint16 when setting offset ' + offset +
                ': value="' + value + '"');
            value = 0;
        }

        data[offset] = value % 256;

        // Note: the funny (a/b>>0) is to force integer math in JavaScipt
        // See http://stackoverflow.com/questions/4228356/integer-division-in-javascript
        data[offset + 1] = (value / 256 >> 0) % 256;
    };


    // *************************************************************************
    var set_uint32 = function (data, offset, value) {
        value = parseInt(value, 10);
        if (isNaN(value)) {
            log.log('ERROR in set_uint32 when setting offset ' + offset +
                ': value="' + value + '"');
            value = 0;
        }

        data[offset] = value % 256;
        data[offset + 1] = (value / 256 >> 0) % 256;
        data[offset + 2] = (value / 65536 >> 0) % 256;
        data[offset + 3] = (value / (65536 * 256) >> 0) % 256;
    };


    // *************************************************************************
    var uint8_array_to_uint32 = function (uint8_array) {
        var uint32_array = [];
        var i = 0;

        while ((i + 4) <=  uint8_array.length) {
            uint32_array.push(get_uint32(uint8_array, i));
            i += 4;
        }
        return uint32_array;
    };


    // *************************************************************************
    var parse_leds = function (section) {
        var data = firmware.data;
        var offset = firmware.offset[section];
        var result = {};
        var i;

        var led_count = data[offset];
        result.led_count = led_count;

        var car_lights_offset = get_uint32(data, offset + 4);

        function parse_led(data, offset) {
            var led = {};

            led.max_change_per_systick = data[offset];
            led.reduction_percent = data[offset + 1];

            var flags = get_uint16(data, offset + 2);

            function get_flag(bit_mask) {
                return Boolean(flags & bit_mask);
            }

            led.weak_light_switch_position0 = get_flag(0x0001);
            led.weak_light_switch_position1 = get_flag(0x0002);
            led.weak_light_switch_position2 = get_flag(0x0004);
            led.weak_light_switch_position3 = get_flag(0x0008);
            led.weak_light_switch_position4 = get_flag(0x0010);
            led.weak_light_switch_position5 = get_flag(0x0020);
            led.weak_light_switch_position6 = get_flag(0x0040);
            led.weak_light_switch_position7 = get_flag(0x0080);
            led.weak_light_switch_position8 = get_flag(0x0100);
            led.weak_tail_light = get_flag(0x0200);
            led.weak_brake_light = get_flag(0x0400);
            led.weak_reversing_light = get_flag(0x0800);
            led.weak_indicator_left = get_flag(0x1000);
            led.weak_indicator_right = get_flag(0x2000);

            led.always_on = data[offset + 4];
            led.light_switch_position0 = data[offset + 5];
            led.light_switch_position1 = data[offset + 6];
            led.light_switch_position2 = data[offset + 7];
            led.light_switch_position3 = data[offset + 8];
            led.light_switch_position4 = data[offset + 9];
            led.light_switch_position5 = data[offset + 10];
            led.light_switch_position6 = data[offset + 11];
            led.light_switch_position7 = data[offset + 12];
            led.light_switch_position8 = data[offset + 13];
            led.tail_light = data[offset + 14];
            led.brake_light = data[offset + 15];
            led.reversing_light = data[offset + 16];
            led.indicator_left = data[offset + 17];
            led.indicator_right = data[offset + 18];

            return led;
        }

        for (i = 0; i < led_count; i += 1) {
            result[i] = parse_led(data, car_lights_offset + (i * 20));
        }

        return result;
    };


    // *************************************************************************
    var parse_gamma = function () {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_GAMMA];

        var gamma = {};

        gamma.gamma_value = String.fromCharCode(data[offset]) +
            String.fromCharCode(data[offset + 1]) +
            String.fromCharCode(data[offset + 2]);

        return gamma;
    };


    // *************************************************************************
    // Parse the configuration out of the firmware image
    // Note that this function is not used when loading a saved configuration,
    // in that case the function load_configuration_from_disk() is used.
    var parse_configuration = function () {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_CONFIG];

        var new_config = {};

        new_config.firmware_version = data[offset];

        new_config.mode = data[offset + 1];
        new_config.esc_mode = data[offset + 2];

        var flags = get_uint32(data, offset + 4);
        var flags2 = get_uint16(data, offset + 64);

        function get_flag(bit_mask) {
            return Boolean(flags & bit_mask);
        }

        function get_flag2(bit_mask) {
            return Boolean(flags2 & bit_mask);
        }

        new_config.slave_output = get_flag(0x0001);
        new_config.preprocessor_output = get_flag(0x0002);
        new_config.winch_output = get_flag(0x0004);
        new_config.steering_wheel_servo_output = get_flag(0x0008);
        new_config.gearbox_servo_output = get_flag(0x0010);
        // reserved = get_flag(0x0020);
        new_config.ch3_is_local_switch = get_flag(0x0040);
        new_config.ch3_is_momentary = get_flag(0x0080);
        new_config.auto_brake_lights_forward_enabled = get_flag(0x0100);
        new_config.auto_brake_lights_reverse_enabled = get_flag(0x0200);
        new_config.ch3_is_two_button = get_flag(0x0400);

        new_config.auto_brake_counter_value_forward_min =
            get_uint16(data, offset + 8);
        new_config.auto_brake_counter_value_forward_max =
            get_uint16(data, offset + 10);
        new_config.auto_brake_counter_value_reverse_min =
            get_uint16(data, offset + 12);
        new_config.auto_brake_counter_value_reverse_max =
            get_uint16(data, offset + 14);
        new_config.auto_reverse_counter_value_min =
            get_uint16(data, offset + 16);
        new_config.auto_reverse_counter_value_max =
            get_uint16(data, offset + 18);
        new_config.brake_disarm_counter_value = get_uint16(data, offset + 20);
        new_config.blink_counter_value = get_uint16(data, offset + 22);
        new_config.indicator_idle_time_value = get_uint16(data, offset + 24);
        new_config.indicator_off_timeout_value = get_uint16(data, offset + 26);

        new_config.centre_threshold_low = get_uint16(data, offset + 28);
        new_config.centre_threshold_high = get_uint16(data, offset + 30);
        new_config.blink_threshold = get_uint16(data, offset + 32);
        new_config.light_switch_positions = get_uint16(data, offset + 34);
        new_config.initial_light_switch_position = get_uint16(data, offset + 36);
        new_config.initial_endpoint_delta = get_uint16(data, offset + 38);
        new_config.ch3_multi_click_timeout = get_uint16(data, offset + 40);
        new_config.winch_command_repeat_time = get_uint16(data, offset + 42);

        new_config.baudrate = get_uint32(data, offset + 44);
        new_config.no_signal_timeout = get_uint16(data, offset + 48);
        new_config.number_of_gears = get_uint16(data, offset + 50);
        new_config.gearbox_servo_active_time = get_uint16(data, offset + 52);
        new_config.gearbox_servo_idle_time = get_uint16(data, offset + 54);

        new_config.servo_pulse_min = get_uint16(data, offset + 56);
        new_config.servo_pulse_max = get_uint16(data, offset + 58);
        new_config.startup_time = get_uint16(data, offset + 60);

        log.log('config.mode: ' + new_config.mode);
        log.log('config.multi_aux: ' + new_config.multi_aux);
        log.log('config_version: ' + config_version);
        log.log('config.firmware_version: ' + new_config.firmware_version);

        if (new_config.firmware_version >= 20) {
            // config_version 2 settings
            new_config.multi_aux = get_flag2(0x0001);
            new_config.shelf_queen_mode = get_flag2(0x0002);
            new_config.us_style_combined_lights = get_flag2(0x0004);
            new_config.gearbox_light_program_control = get_flag2(0x0008);
            new_config.light_program_servo_output = get_flag2(0x0010);

            new_config.blink_counter_value_dark = get_uint16(data, offset + 68);

            new_config.aux_type = data[offset + 70];
            new_config.aux_function = data[offset + 71];
            new_config.aux2_type = data[offset + 72];
            new_config.aux2_function = data[offset + 73];
            new_config.aux3_type = data[offset + 74];
            new_config.aux3_function = data[offset + 75];
        }
        else {
            // Set some defaults
            new_config.multi_aux = false;
            new_config.shelf_queen_mode = true;
            new_config.us_style_combined_lights = true;

            new_config.blink_counter_value_dark = new_config.blink_counter_value;

            new_config.aux_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
            new_config.aux_function = AUX_FUNCTION.AUX_FUNCTION_MULTI_FUNCTION;
            new_config.aux2_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
            new_config.aux2_function = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
            new_config.aux3_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
            new_config.aux3_function = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
        }

        return new_config;
    };


    // *************************************************************************
    var disassemble_light_programs = function () {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_LIGHT_PROGRAMS];
        var first_program_offset = offset + 4 + (4 * MAX_LIGHT_PROGRAMS);

        //var number_of_programs = get_uint32(data, offset);

        var instructions =
            uint8_array_to_uint32(data.slice(first_program_offset));

        return disassembler.disassemble(instructions);
    };


    // *************************************************************************
    var find_magic_markers = function (image_data) {
        // LBrc (LANE Boys RC) in little endian
        var ROM_MAGIC = [0x4c, 0x42, 0x72, 0x63];
        var ROM_MAGIC_LENGTH = 4;
        var i;
        var result = {};
        var section_id;
        var section;

        for (i = 0; i < image_data.length; i += 1) {
            if (image_data.slice(i, i + ROM_MAGIC_LENGTH).join() ===
                    ROM_MAGIC.join()) {

                section_id = (image_data[i + 5] * 256) + image_data[i + 4];
                config_version = (image_data[i + 7] * 256) + image_data[i + 6];

                if (SECTIONS[section_id] === undefined) {
                    log.log('Warning: unknown section ' + i);
                } else {
                    if (config_version > 2) {
                        throw new Error('Unknown configuration version ' +
                            config_version);
                    }

                    section = SECTIONS[section_id];
                    result[section] = i + 8;
                }
            }
        }

        return result;
    };


    // *************************************************************************
    var update_led_fields = function () {
        function set_led_field(prefix, led_number, field_number, value) {
            var cell = document.getElementById(prefix + led_number +
                'field' + field_number
            );

            while (cell.firstChild) {
                cell.removeChild(cell.firstChild);
            }

            value = Math.round(value * 100 / 255);

            if (value !== 0) {
                var textNode = document.createTextNode(value);
                cell.appendChild(textNode);
            }
        }

        function set_led_feature(prefix, led_number, field_suffix, value) {
            var cell = document.getElementById(prefix + led_number +
                field_suffix
            );

            if (cell.type === 'checkbox') {
                cell.checked = Boolean(value);
            } else {
                cell.value = value;
            }
        }

        function set_led_fields(led_source, prefix) {
            var i;
            var led;

            for (i = 0; i < led_source.led_count; i += 1) {
                led = led_source[i];

                set_led_field(prefix, i, 0, led.always_on);
                set_led_field(prefix, i, 1, led.light_switch_position0);
                set_led_field(prefix, i, 2, led.light_switch_position1);
                set_led_field(prefix, i, 3, led.light_switch_position2);
                set_led_field(prefix, i, 4, led.light_switch_position3);
                set_led_field(prefix, i, 5, led.light_switch_position4);
                set_led_field(prefix, i, 6, led.light_switch_position5);
                set_led_field(prefix, i, 7, led.light_switch_position6);
                set_led_field(prefix, i, 8, led.light_switch_position7);
                set_led_field(prefix, i, 9, led.light_switch_position8);
                set_led_field(prefix, i, 10, led.tail_light);
                set_led_field(prefix, i, 11, led.brake_light);
                set_led_field(prefix, i, 12, led.reversing_light);
                set_led_field(prefix, i, 13, led.indicator_left);
                set_led_field(prefix, i, 14, led.indicator_right);

                set_led_feature(prefix, i, 'incandescent',
                    Math.round(led.max_change_per_systick * 100 / 255));
                set_led_feature(prefix, i, 'weak_ground', led.reduction_percent);
                set_led_feature(prefix, i, 'checkbox0', led.weak_light_switch_position0);
                set_led_feature(prefix, i, 'checkbox1', led.weak_light_switch_position1);
                set_led_feature(prefix, i, 'checkbox2', led.weak_light_switch_position2);
                set_led_feature(prefix, i, 'checkbox3', led.weak_light_switch_position3);
                set_led_feature(prefix, i, 'checkbox4', led.weak_light_switch_position4);
                set_led_feature(prefix, i, 'checkbox5', led.weak_light_switch_position5);
                set_led_feature(prefix, i, 'checkbox6', led.weak_light_switch_position6);
                set_led_feature(prefix, i, 'checkbox7', led.weak_light_switch_position7);
                set_led_feature(prefix, i, 'checkbox8', led.weak_light_switch_position8);
                set_led_feature(prefix, i, 'checkbox9', led.weak_tail_light);
                set_led_feature(prefix, i, 'checkbox10', led.weak_brake_light);
                set_led_feature(prefix, i, 'checkbox11', led.weak_reversing_light);
                set_led_feature(prefix, i, 'checkbox12', led.weak_indicator_left);
                set_led_feature(prefix, i, 'checkbox13', led.weak_indicator_right);
            }
        }

        set_led_fields(local_leds, 'master');
        set_led_fields(slave_leds, 'slave');
    };


    // *************************************************************************
    var aux_type_changed_handler = function () {
        var new_type = parseInt(this.type.value, 10);
        var current_function = parseInt(this.fn.value, 10);

        switch (new_type) {
        case AUX_TYPE.AUX_TYPE_MOMENTARY:
            this.fn.querySelector('.function_multi_function').disabled = false;
            this.fn.querySelector('.function_indicators').disabled = true;
            this.fn.querySelector('.function_light_switch').disabled = true;

            if (current_function === AUX_FUNCTION.AUX_FUNCTION_LIGHT_SWITCH ||
                current_function === AUX_FUNCTION.AUX_FUNCTION_INDICATORS) {
                this.fn.value = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
            }
            break;

        case AUX_TYPE.AUX_TYPE_TWO_POSITION:
        case AUX_TYPE.AUX_TYPE_TWO_POSITION_UP_DOWN:
            this.fn.querySelector('.function_multi_function').disabled = false;
            this.fn.querySelector('.function_indicators').disabled = true;
            this.fn.querySelector('.function_light_switch').disabled = false;
            if (current_function === AUX_FUNCTION.AUX_FUNCTION_INDICATORS) {
                this.fn.value = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
            }
            break;

        case AUX_TYPE.AUX_TYPE_THREE_POSITION:
        case AUX_TYPE.AUX_TYPE_ANALOG:
            this.fn.querySelector('.function_multi_function').disabled = true;
            this.fn.querySelector('.function_indicators').disabled = false;
            this.fn.querySelector('.function_light_switch').disabled = false;

            if (current_function === AUX_FUNCTION.AUX_FUNCTION_MULTI_FUNCTION) {
                this.fn.value = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
            }
            break;
        }
    };


    // *************************************************************************
    var mode_changed_handler = function () {

        // We set the multi_aux flag only when the appropriate configuration is
        // set, otherwise clear it.
        // This is done deliberately here and not in update_section_visibility()
        // because we want to allow for the use-case that a configuration is loaded
        // where SERVO_READER is active and multi_aux as well.
        // Such configuration can not be set directly in the configurator but
        // could be useful to someone making custom hardware with 5 servo inputs.

        var new_mode = parseInt(el.mode.value, 10);

        switch (new_mode) {
        case MODE.MASTER_WITH_CPPM_READER:
        case MODE.MASTER_WITH_SERVO_READER:
        case MODE.MASTER_WITH_UART_READER:
        case MODE.STAND_ALONE:
            config.multi_aux = false;
            config.mode = new_mode;
            break;

        case MODE.MASTER_WITH_UART_READER_5CH:
            config.multi_aux = true;
            config.mode = MODE.MASTER_WITH_UART_READER;
            break;

        case MODE.TEST:
        case MODE.SLAVE:
        case MODE.PREPROCESSOR:
        case MODE.PREPROCESSOR_5CH:
        default:
            break;
        }

        update_section_visibility();
    };


    // *************************************************************************
    var update_section_visibility = function () {
        function set_name(elements, name) {
            var i;
            for (i = 0; i < elements.length; i += 1) {
                elements[i].name = name;
            }
        }

        function show_mode_info(element) {
            var all_info_paragraphs = [el.mode_master_uart, el.mode_master_uart_5ch,
                el.mode_master_cppm, el.mode_slave, el.mode_stand_alone, el.mode_test,
                el.mode_preprocessor_5ch, el.mode_preprocessor, el.mode_master_servo];
            var i;
            for (i = 0; i < all_info_paragraphs.length; i += 1) {
                if (all_info_paragraphs[i] === element) {
                    all_info_paragraphs[i].classList.remove('hidden');
                }
                else {
                    all_info_paragraphs[i].classList.add('hidden');
                }
            }
        }

        function show(elements) {
            var i;
            for (i = 0; i < elements.length; i += 1) {
                elements[i].classList.remove('hidden');
            }
        }

        function hide(elements) {
            var i;
            for (i = 0; i < elements.length; i += 1) {
                elements[i].classList.add('hidden');
            }
        }

        function ensure_one_is_checked(name) {
            var i;
            var elements = document.getElementsByName(name);
            for (i = 0; i < elements.length; i += 1) {
                if (elements[i].checked) {
                    return;
                }
            }
            elements[0].checked = true;
        }

        function update_menu_visibility(enabled_menu_items) {
            for (var j = 0; j < el.menu_buttons.length; j += 1) {
                var button = el.menu_buttons[j];
                var page_name = button.getAttribute('data');

                button.disabled = true;

                for (var i = 0; i < enabled_menu_items.length; i += 1) {
                    var menu_item = enabled_menu_items[i];

                    if (menu_item == page_name) {
                        // if (page_name != 'testing' || !preprocessor_simulator_disabled) {
                        button.disabled = false;
                        // }
                        break;
                    }
                }
            }
        }

        var items;
        var i;
        if (config_version === 2) {
            items = document.getElementsByClassName('v2_show');
            for (i = 0; i < items.length; i++) {
                items[i].classList.remove('hidden');
            }

            items = document.getElementsByClassName('v2_hide');
            for (i = 0; i < items.length; i++) {
                items[i].classList.add('hidden');
            }
        }
        else {
            items = document.getElementsByClassName('v2_show');
            for (i = 0; i < items.length; i++) {
                items[i].classList.add('hidden');
            }

            items = document.getElementsByClassName('v2_hide');
            for (i = 0; i < items.length; i++) {
                items[i].classList.remove('hidden');
            }
        }


        var new_mode = parseInt(el.mode.value, 10);
        switch (new_mode) {
        case MODE.MASTER_WITH_SERVO_READER:
            show_mode_info(el.mode_master_servo);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
                'config_esc',
                'config_ch3',
                'config_output',
                'config_leds',
                'config_light_programs',
                'config_advanced',
                'testing',
                'info',
            ]);

            show(el.single_output);
            hide(el.dual_output);
            show([el.aux_3ch]);
            hide([el.multi_aux]);
            set_name(el.dual_output_th, 'output_out');
            break;

        case MODE.MASTER_WITH_UART_READER:
            show_mode_info(el.mode_master_uart);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
                'config_esc',
                'config_ch3',
                'config_output',
                'config_leds',
                'config_light_programs',
                'config_advanced',
                'testing',
                'info',
            ]);

            hide(el.single_output);
            show(el.dual_output);
            show([el.aux_3ch]);
            hide([el.multi_aux]);
            set_name(el.dual_output_th, 'output_th');
            break;

        case MODE.MASTER_WITH_UART_READER_5CH:
            show_mode_info(el.mode_master_uart_5ch);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
                'config_esc',
                'config_ch3',
                'config_output',
                'config_leds',
                'config_light_programs',
                'config_advanced',
                'testing',
                'info',
            ]);

            hide(el.single_output);
            show(el.dual_output);
            hide([el.aux_3ch]);
            show([el.multi_aux]);
            set_name(el.dual_output_th, 'output_th');
            break;

        case MODE.MASTER_WITH_CPPM_READER:
            show_mode_info(el.mode_master_cppm);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
                'config_esc',
                'config_ch3',
                'config_output',
                'config_leds',
                'config_light_programs',
                'config_advanced',
                'testing',
                'info',
            ]);

            hide(el.single_output);
            show(el.dual_output);
            show([el.aux_3ch]);
            hide([el.multi_aux]);
            set_name(el.dual_output_th, 'output_th');
            break;

        case MODE.SLAVE:
            show_mode_info(el.mode_slave);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
                'config_output',
                'testing',
                'info',
            ]);
            break;

        case MODE.STAND_ALONE:
            show_mode_info(el.mode_stand_alone);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
                'config_leds',
                'config_light_programs',
                'testing',
                'info',
            ]);

            hide(el.single_output);
            show(el.dual_output);
            show([el.aux_3ch]);
            hide([el.multi_aux]);
            set_name(el.dual_output_th, 'output_th');
            break;

        case MODE.PREPROCESSOR:
            show_mode_info(el.mode_preprocessor);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
            ]);
            break;

        case MODE.PREPROCESSOR_5CH:
            show_mode_info(el.mode_preprocessor_5ch);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
            ]);
            break;

        case MODE.TEST:
            show_mode_info(el.mode_test);

            update_menu_visibility([
                'config_hardware',
                'config_mode',
            ]);
            break;
        }

        ensure_one_is_checked('output_out');
        ensure_one_is_checked('output_th');

        if (el.preprocessor_output.checked || el.slave_output.checked) {
            el.winch_output.classList.add('hidden');
            el.winch_enable.classList.remove('hidden');
        }
        else {
            el.winch_output.classList.remove('hidden');
            el.winch_enable.classList.add('hidden');
        }

        if (el.slave_output.checked) {
            el.leds_slave.classList.remove('hidden');
        }
        else {
            el.leds_slave.classList.add('hidden');
        }
    };


    // *************************************************************************
    var update_led_feature_usage = function () {
        function set_feature_active(led_div_id, prefix) {
            var i;
            var c;
            var advanced_feature_used;
            var incandescent;
            var weak_ground;
            var any_checkbox_ticked;
            var checkboxes;
            var spanner;
            var led_div = document.getElementById(led_div_id);
            var led_config_rows = led_div.getElementsByClassName('led_config');

            for (i = 0; i < 16; i += 1) {
                advanced_feature_used = false;

                incandescent = parseInt(document.getElementById(prefix + i + 'incandescent').value, 10);

                weak_ground = parseInt(document.getElementById(prefix + i + 'weak_ground').value, 10);

                any_checkbox_ticked = false;
                checkboxes = document.getElementsByClassName(prefix + i + 'checkbox');

                for (c = 0; c < checkboxes.length; c += 1) {
                    if (checkboxes[c].checked) {
                        any_checkbox_ticked = true;
                        break;
                    }
                }

                if (incandescent > 0  && incandescent < 100) {
                    advanced_feature_used = true;
                }

                if (weak_ground > 0  &&  any_checkbox_ticked) {
                    advanced_feature_used = true;
                }


                spanner = led_config_rows[i].getElementsByClassName('spanner')[0];

                if (advanced_feature_used) {
                    spanner.classList.add('led_feature_active');
                } else {
                    spanner.classList.remove('led_feature_active');
                }
            }
        }

        set_feature_active('leds_master', 'master');
        set_feature_active('leds_slave', 'slave');
    };


    // *************************************************************************
    var update_ui = function () {
        // Master/Slave/...
        if (config.multi_aux && config.mode === MODE.MASTER_WITH_UART_READER) {
            el.mode.value = MODE.MASTER_WITH_UART_READER_5CH;
        }
        else {
            el.mode.value = config.mode;
        }

        // Firmware version
        el.firmware_version.textContent = config_version + '.' + config.firmware_version;

        // ESC type
        el.esc[config.esc_mode].checked = true;

        // Output functions
        el.winch_output.checked = Boolean(config.winch_output);
        el.winch_enable.checked = Boolean(config.winch_output);
        el.gearbox_servo_output.checked = Boolean(config.gearbox_servo_output);
        el.steering_wheel_servo_output.checked = Boolean(config.steering_wheel_servo_output);
        el.preprocessor_output.checked = Boolean(config.preprocessor_output);
        el.slave_output.checked = Boolean(config.slave_output);
        el.gearbox_light_program_control.checked = Boolean(config.gearbox_light_program_control);
        el.light_program_servo_output.checked = Boolean(config.light_program_servo_output);

        // CH3/AUX type
        el.ch3[0].checked = true;
        if (config.ch3_is_local_switch) {
            el.ch3[3].checked = true;
        } else if (config.ch3_is_momentary) {
            el.ch3[2].checked = true;
        } else if (config.ch3_is_two_button) {
            el.ch3[1].checked = true;
        }

        // Baudrate
        el.baudrate.selectedIndex = BAUDRATES[config.baudrate];

        // LEDs
        update_led_fields();

        // Update advanced settings
        el.auto_brake_lights_forward_enabled.checked =
            Boolean(config.auto_brake_lights_forward_enabled);
        el.auto_brake_counter_value_forward_min.value =
            config.auto_brake_counter_value_forward_min * SYSTICK_IN_MS;
        el.auto_brake_counter_value_forward_max.value =
            config.auto_brake_counter_value_forward_max * SYSTICK_IN_MS;

        el.auto_brake_lights_reverse_enabled.checked =
            Boolean(config.auto_brake_lights_reverse_enabled);
        el.auto_brake_counter_value_reverse_min.value =
            config.auto_brake_counter_value_reverse_min * SYSTICK_IN_MS;
        el.auto_brake_counter_value_reverse_max.value =
            config.auto_brake_counter_value_reverse_max * SYSTICK_IN_MS;

        el.brake_disarm_counter_value.value =
            config.brake_disarm_counter_value * SYSTICK_IN_MS;

        el.auto_reverse_counter_value_min.value =
            config.auto_reverse_counter_value_min * SYSTICK_IN_MS;
        el.auto_reverse_counter_value_max.value =
            config.auto_reverse_counter_value_max * SYSTICK_IN_MS;

        el.blink_counter_value.value =
            config.blink_counter_value * SYSTICK_IN_MS;
        el.indicator_idle_time_value.value =
            config.indicator_idle_time_value * SYSTICK_IN_MS;
        el.indicator_off_timeout_value.value =
            config.indicator_off_timeout_value * SYSTICK_IN_MS;
        el.blink_threshold.value = config.blink_threshold;

        el.centre_threshold_low.value = config.centre_threshold_low;
        el.centre_threshold_high.value = config.centre_threshold_high;
        el.initial_endpoint_delta.value = config.initial_endpoint_delta;

        el.ch3_multi_click_timeout.value =
            config.ch3_multi_click_timeout * SYSTICK_IN_MS;
        el.winch_command_repeat_time.value =
            config.winch_command_repeat_time * SYSTICK_IN_MS;
        el.no_signal_timeout.value =
            config.no_signal_timeout * SYSTICK_IN_MS;

        el.number_of_gears.value = config.number_of_gears;
        el.gearbox_servo_active_time.value =
            config.gearbox_servo_active_time * SYSTICK_IN_MS;
        el.gearbox_servo_idle_time.value =
            config.gearbox_servo_idle_time * SYSTICK_IN_MS;

        el.initial_light_switch_position.value =
            config.initial_light_switch_position;

        el.servo_pulse_min.value = config.servo_pulse_min;
        el.servo_pulse_max.value = config.servo_pulse_max;
        el.startup_time.value = config.startup_time * SYSTICK_IN_MS;


        el.gamma_value.value = gamma_object.gamma_value;


        el.blink_counter_value_dark.value = config.blink_counter_value_dark * SYSTICK_IN_MS;
        el.us_style_combined_lights.checked = Boolean(config.us_style_combined_lights);
        el.shelf_queen_mode.checked = Boolean(config.shelf_queen_mode);

        el.aux_type.value = config.aux_type;
        el.aux_function.value = config.aux_function;
        el.aux2_type.value = config.aux2_type;
        el.aux2_function.value = config.aux2_function;
        el.aux3_type.value = config.aux3_type;
        el.aux3_function.value = config.aux3_function;

        // Ensure proper enabling/disabling of allowed AUX functions based on AUX type
        (aux_type_changed_handler.bind({'type': el.aux_type, 'fn': el.aux_function}))();
        (aux_type_changed_handler.bind({'type': el.aux2_type, 'fn': el.aux2_function}))();
        (aux_type_changed_handler.bind({'type': el.aux3_type, 'fn': el.aux3_function}))();

        // Show/hide various sections depending on the current settings
        update_section_visibility();

        // Highlight the spanner icon if incandescent of weak ground simulation
        // is active for a LED
        update_led_feature_usage();
    };


    // *************************************************************************
    var hex_to_bin = function (intel_hex_data) {
        return intel_hex.parse(intel_hex_data).data;
    };


    // *************************************************************************
    var parse_firmware_structure = function (firmware_image) {
        var offset_list = find_magic_markers(firmware_image);

        return {
            data: firmware_image,
            offset: offset_list,
        };
    };


    // *************************************************************************
    var parse_firmware = function (firmware_image) {
        firmware = undefined;
        config = undefined;
        local_leds = undefined;
        slave_leds = undefined;
        gamma_object = undefined;
        light_programs = '';

        el.light_programs.value = '';
        el.light_programs_errors.classList.add('hidden');

        try {
            firmware = parse_firmware_structure(firmware_image);
            parse_firmware_binary();
        } catch (e) {
            window.alert(
                'Unable to load Intel-hex formatted firmware image:\n' + e
            );
        }
    };

    // *************************************************************************
    var parse_firmware_binary = function () {
        config = parse_configuration();
        local_leds = parse_leds(SECTION_LOCAL_LEDS);
        slave_leds = parse_leds(SECTION_SLAVE_LEDS);
        light_programs = disassemble_light_programs();
        gamma_object = parse_gamma();

        update_ui();

        el.light_programs.value = light_programs;
        ui.update_editor();
    };

    // *************************************************************************
    var parse_light_program_code = function (light_programs) {
        el.light_programs_errors.classList.add('hidden');
        el.light_programs_ok.classList.add('hidden');

        // If we run multiple times, we need to reset the modules inbetween,
        // especially if there was an error before.
        symbols.reset();
        emitter.reset();

        ui.update_errors([]);

        try {
            var machine_code = parser.parse(light_programs);
            el.light_programs_ok.classList.remove('hidden');
            return machine_code;
        } catch (e) {
            var msg = 'Errors occured while assembling light programs\n';
            var errors = emitter.get_errors();
            var cm_error;
            var cm_errors = [];
            var i;
            var loc;

            if (errors.length > 0) {
                msg += '\n';
                for (i = 0; i < errors.length; i += 1) {
                    msg += errors[i].str + '\n\n';

                    if (errors[i].hash  &&  errors[i].hash.loc) {
                        loc = errors[i].hash.loc;
                        cm_error = {
                            message: errors[i].str,
                            from: CodeMirror.Pos(loc.first_line - 1, loc.first_column),
                            to: CodeMirror.Pos(loc.last_line - 1, loc.last_column),
                        };
                        cm_errors.push(cm_error);
                    }
                }
            }

            el.light_programs_errors.textContent = msg;
            el.light_programs_errors.classList.remove('hidden');

            ui.update_errors(cm_errors);

            throw new Error('Errors occured while assembling light programs');
        }
    };


    // *************************************************************************
    var assemble_gamma = function (gamma_object) {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_GAMMA];
        var i;
        var gamma_table;

        set_uint8(data, offset, gamma_object.gamma_value.charCodeAt(0));
        set_uint8(data, offset + 1, gamma_object.gamma_value.charCodeAt(1));
        set_uint8(data, offset + 2, gamma_object.gamma_value.charCodeAt(2));

        gamma_table = gamma.make_table(gamma_object.gamma_value);
        for (i = 0; i < gamma_table.length; i += 1) {
            set_uint8(data, offset + 4 + i, gamma_table[i]);
        }
    };


    // *************************************************************************
    var assemble_leds = function (section, led_object) {
        var data = firmware.data;
        var offset = firmware.offset[section];
        var car_lights_offset = get_uint32(data, offset + 4);
        var i;

        function assemble_led(data, offset, led_object) {
            set_uint8(data, offset, led_object.max_change_per_systick);
            set_uint8(data, offset + 1, led_object.reduction_percent);

            var flags = 0;
            var positions = 0;

            flags |= led_object.weak_light_switch_position0 << 0;
            flags |= led_object.weak_light_switch_position1 << 1;
            flags |= led_object.weak_light_switch_position2 << 2;
            flags |= led_object.weak_light_switch_position3 << 3;
            flags |= led_object.weak_light_switch_position4 << 4;
            flags |= led_object.weak_light_switch_position5 << 5;
            flags |= led_object.weak_light_switch_position6 << 6;
            flags |= led_object.weak_light_switch_position7 << 7;
            flags |= led_object.weak_light_switch_position8 << 8;
            flags |= led_object.weak_tail_light << 9;
            flags |= led_object.weak_brake_light << 10;
            flags |= led_object.weak_reversing_light << 11;
            flags |= led_object.weak_indicator_left << 12;
            flags |= led_object.weak_indicator_right << 13;

            set_uint16(data, offset + 2, flags);

            set_uint8(data, offset + 4, led_object.always_on);
            set_uint8(data, offset + 5, led_object.light_switch_position0);
            set_uint8(data, offset + 6, led_object.light_switch_position1);
            set_uint8(data, offset + 7, led_object.light_switch_position2);
            set_uint8(data, offset + 8, led_object.light_switch_position3);
            set_uint8(data, offset + 9, led_object.light_switch_position4);
            set_uint8(data, offset + 10, led_object.light_switch_position5);
            set_uint8(data, offset + 11, led_object.light_switch_position6);
            set_uint8(data, offset + 12, led_object.light_switch_position7);
            set_uint8(data, offset + 13, led_object.light_switch_position8);
            set_uint8(data, offset + 14, led_object.tail_light);
            set_uint8(data, offset + 15, led_object.brake_light);
            set_uint8(data, offset + 16, led_object.reversing_light);
            set_uint8(data, offset + 17, led_object.indicator_left);
            set_uint8(data, offset + 18, led_object.indicator_right);

            if (led_object.light_switch_position0) { positions = 1; }
            if (led_object.light_switch_position1) { positions = 2; }
            if (led_object.light_switch_position2) { positions = 3; }
            if (led_object.light_switch_position3) { positions = 4; }
            if (led_object.light_switch_position4) { positions = 5; }
            if (led_object.light_switch_position5) { positions = 6; }
            if (led_object.light_switch_position6) { positions = 7; }
            if (led_object.light_switch_position7) { positions = 8; }
            if (led_object.light_switch_position8) { positions = 9; }

            if (positions > light_switch_positions) {
                light_switch_positions = positions;
            }
        }

        set_uint8(data, offset, led_object.led_count);

        for (i = 0; i < led_object.led_count; i += 1) {
            assemble_led(data, car_lights_offset + (i * 20), led_object[i]);
        }
    };


    // *************************************************************************
    var assemble_configuration = function (config) {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_CONFIG];
        var i;
        var spacing;

        log.log('config.mode: ' + config.mode);
        log.log('config_version: ' + config_version);
        log.log('config.firmware_version: ' + config.firmware_version);

        config.light_switch_positions = light_switch_positions;

        set_uint8(data, offset, config.firmware_version);
        set_uint8(data, offset + 1, config.mode);
        set_uint8(data, offset + 2, config.esc_mode);

        var flags = 0;
        flags |= (config.slave_output << 0);
        flags |= (config.preprocessor_output << 1);
        flags |= (config.winch_output << 2);
        flags |= (config.steering_wheel_servo_output << 3);
        flags |= (config.gearbox_servo_output << 4);
        // flags |= (reserved << 5);
        flags |= (config.ch3_is_local_switch << 6);
        flags |= (config.ch3_is_momentary << 7);
        flags |= (config.auto_brake_lights_forward_enabled << 8);
        flags |= (config.auto_brake_lights_reverse_enabled << 9);
        flags |= (config.ch3_is_two_button << 10);
        set_uint32(data, offset + 4, flags);

        set_uint16(data, offset + 8,  config.auto_brake_counter_value_forward_min);
        set_uint16(data, offset + 10, config.auto_brake_counter_value_forward_max);
        set_uint16(data, offset + 12, config.auto_brake_counter_value_reverse_min);
        set_uint16(data, offset + 14, config.auto_brake_counter_value_reverse_max);
        set_uint16(data, offset + 16, config.auto_reverse_counter_value_min);
        set_uint16(data, offset + 18, config.auto_reverse_counter_value_max);

        set_uint16(data, offset + 20, config.brake_disarm_counter_value);
        set_uint16(data, offset + 22, config.blink_counter_value);
        set_uint16(data, offset + 24, config.indicator_idle_time_value);
        set_uint16(data, offset + 26, config.indicator_off_timeout_value);

        set_uint16(data, offset + 28, config.centre_threshold_low);
        set_uint16(data, offset + 30, config.centre_threshold_high);
        set_uint16(data, offset + 32, config.blink_threshold);
        set_uint16(data, offset + 34, config.light_switch_positions);
        set_uint16(data, offset + 36, config.initial_light_switch_position);
        set_uint16(data, offset + 38, config.initial_endpoint_delta);
        set_uint16(data, offset + 40, config.ch3_multi_click_timeout);
        set_uint16(data, offset + 42, config.winch_command_repeat_time);

        set_uint32(data, offset + 44, config.baudrate);
        set_uint16(data, offset + 48, config.no_signal_timeout);
        set_uint16(data, offset + 50, config.number_of_gears);
        set_uint16(data, offset + 52, config.gearbox_servo_active_time);
        set_uint16(data, offset + 54, config.gearbox_servo_idle_time);

        set_uint16(data, offset + 56, config.servo_pulse_min);
        set_uint16(data, offset + 58, config.servo_pulse_max);

        set_uint16(data, offset + 60, config.startup_time);

        // Handle firmware supporting config_version 2 and above
        if (config.firmware_version >= 20) {
            var flags2 = 0;
            flags2 |= (config.multi_aux << 0);
            flags2 |= (config.shelf_queen_mode << 1);
            flags2 |= (config.us_style_combined_lights << 2);
            flags2 |= (config.gearbox_light_program_control << 3);
            flags2 |= (config.light_program_servo_output << 4);
            set_uint16(data, offset + 64, flags2);

            set_uint16(data, offset + 68, config.blink_counter_value_dark);

            set_uint8(data, offset + 70, config.aux_type);
            set_uint8(data, offset + 71, config.aux_function);
            set_uint8(data, offset + 72, config.aux2_type);
            set_uint8(data, offset + 73, config.aux2_function);
            set_uint8(data, offset + 74, config.aux3_type);
            set_uint8(data, offset + 75, config.aux3_function);

            // Pre-calculate AUX function for light switch handling hysteresis
            // and center values
            spacing = (200 / light_switch_positions);
            console.log("light_switch_positions=" + light_switch_positions)
            console.log("spacing=" + spacing)
            config.light_switch_hysteresis = Math.round(spacing / 4);
            console.log("light_switch_hysteresis=" + config.light_switch_hysteresis)

            set_uint8(data, offset + 85, config.light_switch_hysteresis);

            config.light_switch_centers = [];
            for (i = 0; i < 9; i++) {
                if (i >= light_switch_positions) {
                    config.light_switch_centers.push(0);
                }
                else {
                    config.light_switch_centers.push(
                        Math.round(-100 + (spacing / 2) + (i * spacing)));
                }
                console.log("light_switch_centers["+i+"] = "+config.light_switch_centers[i])
                set_int8(data, offset + 76 + i, config.light_switch_centers[i]);
            }
        }
    };


    // *************************************************************************
    var assemble_light_programs = function (light_programs) {
        var machine_code = parse_light_program_code(light_programs);
        var i;
        var offset;
        var data;

        if (machine_code.light_switch_positions > light_switch_positions) {
            light_switch_positions = machine_code.light_switch_positions;
        }

        var first_program_offset = 4 + (4 * MAX_LIGHT_PROGRAMS);

        var code_size = 4 + (4 * MAX_LIGHT_PROGRAMS) +
            (4 * machine_code.instructions.length);

        // Create an array with length code_size. We could use
        // 'new Array(code_size)', but JSLint doesn't like that as Array could
        // have been redefined.
        var code = [];
        for (i = 0; i < code_size; i += 1) {
            code.push(0);
        }

        set_uint32(code, 0, machine_code.number_of_programs);
        for (i = 0; i < MAX_LIGHT_PROGRAMS; i += 1) {
            offset = 0;
            if (i < machine_code.number_of_programs) {
                offset = first_program_offset;
                offset += firmware.offset[SECTION_LIGHT_PROGRAMS];
                offset += machine_code.start_offset[i] * 4;
            }
            set_uint32(code, 4 + (4 * i), offset);
        }

        for (i = 0; i < machine_code.instructions.length; i += 1) {
            set_uint32(code, first_program_offset + (4 * i),
                machine_code.instructions[i]);
        }

        data = firmware.data;
        offset = firmware.offset[SECTION_LIGHT_PROGRAMS];

        firmware.data = data.slice(0, offset).concat(code);
    };


    // *************************************************************************
    var assemble_firmware = function (configuration) {
        light_switch_positions = 1;

        assemble_leds(SECTION_LOCAL_LEDS, configuration.local_leds);
        assemble_leds(SECTION_SLAVE_LEDS, configuration.slave_leds);
        assemble_light_programs(configuration.light_programs);

        assemble_gamma(configuration.gamma);

        // This has to be last so we can do light_switch_positions
        assemble_configuration(configuration.config);
    };


    // *************************************************************************
    var load_default_configuration = function () {
        default_firmware_version = config.firmware_version;

        // Instead of using the disassebled source code, we use the original
        // sourcecode with comments and original variable names.
        // This is achieved by running 'make defaul_firmware_image' in
        // the firmware/tlc5940-lpc812 directory.
        light_programs = default_light_program;

        el.light_programs.value = light_programs;
        ui.update_editor();
    };


    // *************************************************************************
    var load_file_from_disk = function () {
        if (this.files.length < 1) {
            return;
        }

        var intelHex = /^:[0-9a-fA-F][0-9a-fA-F]/;
        var json = /^\s*{/;

        var reader = new FileReader();
        reader.onload = function (e) {
            var contents = e.target.result;

            let contentsString = String.fromCharCode.apply(null, new Uint8Array(contents));

            if (contentsString.match(json)) {
                load_configuration_from_disk(contentsString);
            }
            else if (contentsString.match(intelHex)) {
                contents = hex_to_bin(contentsString);
                load_firmware(contents);
            }
            else {
                let data = new Uint8Array(8192 + contents.byteLength);
                data.fill(0xff);
                data.set(new Uint8Array(contents), 8192);
                load_firmware(data);
            }
        };
        reader.readAsArrayBuffer(this.files[0]);
    };


    // *************************************************************************
    var load_configuration_from_disk = function (contents) {
        var data;
        try {
            data = JSON.parse(contents);

            config = data.config;
            local_leds = data.local_leds;
            slave_leds = data.slave_leds;
            light_programs = data.light_programs;
            gamma_object = data.gamma;

            // Extend the configuration generated for config_version 1
            // Since config_version is not saved in the JSON we use the
            // firmware_version to check. firmware_version <20 means
            // config_version 1
            if (config.firmware_version < 20) {
                config.multi_aux = false;
                config.shelf_queen_mode = true;
                config.us_style_combined_lights = true;

                config.blink_counter_value_dark = config.blink_counter_value;

                config.aux_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
                config.aux_function = AUX_FUNCTION.AUX_FUNCTION_MULTI_FUNCTION;
                config.aux2_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
                config.aux2_function = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
                config.aux3_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
                config.aux3_function = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
            }

            if (config.aux_type == null ||
                    config.aux2_type == null ||
                    config.aux3_type == null ||
                    config.aux_function == null ||
                    config.aux2_function == null ||
                    config.aux3_function == null) {

                console.log('WARNING: fixing corrupt configuration regarding aux_type and aux_function');
                config.aux_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
                config.aux_function = AUX_FUNCTION.AUX_FUNCTION_MULTI_FUNCTION;
                config.aux2_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
                config.aux2_function = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
                config.aux3_type = AUX_TYPE.AUX_TYPE_TWO_POSITION;
                config.aux3_function = AUX_FUNCTION.AUX_FUNCTION_NOT_USED;
            }


            // Use the current firmware when loading a configuration file
            firmware = parse_firmware_structure(hex_to_bin(default_firmware_image_mk4));
            config.firmware_version = default_firmware_version;
        } catch (err) {
            window.alert(
                'Failed to load configuration.\n' +
                    'File may not be a light controller configuration file (JSON format)'
            );
        }

        update_ui();

        el.light_programs.value = light_programs;
        ui.update_editor();
    };


    // *************************************************************************
    var load_firmware = function (firmware_image) {
        parse_firmware(firmware_image);

        // Change hardware to Mk4/Mk5 according to firmware
        // We do that by looking at the top most byte of the stackpointer (first
        // word in the firmware) which points to the RAM.
        // The LPC RAM starts at 0x10000000, the SAMD21 at 0x20000000
        if (firmware.data[3] == 0x10) {
            el.hardware.value = 'mk4';
        }

        // update_visibility_from_ports();

        if (default_firmware_version > config.firmware_version) {
            let msg = 'A new firmware version is available.\n';
            msg += 'Click OK to update the firmware, keeping your settings.\n';
            msg += 'Click Cancel to keep the original firmware.\n';
            if (window.confirm(msg)) {
                let bin;
                if (el.hardware.value == 'mk4') {
                    bin = hex_to_bin(default_firmware_image_mk4);
                }

                firmware = parse_firmware_structure(bin);
                config.firmware_version = default_firmware_version;
                update_ui();
            }
        }
    };


    // *************************************************************************
    var hardware_changed = function () {
        let firmware_hex;

        switch(el.hardware.value) {
        case 'mk4':
            firmware_hex = default_firmware_image_mk4;
            break;
        }

        let bin = hex_to_bin(firmware_hex);
        firmware = parse_firmware_structure(bin);

        // Change the firmware version to the default we've just loaded
        config.firmware_version = default_firmware_version;
        update_ui();

        // update_visibility_from_ports();
    };


    // *************************************************************************
    var update_led_config = function () {
        function get_led_field(prefix, led_number, field_number) {
            var cell = document.getElementById(prefix + led_number + 'field' +
                field_number
            );

            var value = cell.textContent;
            if (value === '') {
                return 0;
            }

            return Math.round(parseInt(value, 10) * 255 / 100);
        }

        function get_led_feature(prefix, led_number, field_suffix) {
            var cell = document.getElementById(prefix + led_number +
                field_suffix
            );

            if (cell.type === 'checkbox') {
                return Boolean(cell.checked);
            }
            return parseInt(cell.value, 10);
        }

        function get_led_fields(led_source, prefix) {
            var i;
            var led;

            for (i = 0; i < led_source.led_count; i += 1) {
                led = led_source[i];

                led.always_on = get_led_field(prefix, i, 0);
                led.light_switch_position0 = get_led_field(prefix, i, 1);
                led.light_switch_position1 = get_led_field(prefix, i, 2);
                led.light_switch_position2 = get_led_field(prefix, i, 3);
                led.light_switch_position3 = get_led_field(prefix, i, 4);
                led.light_switch_position4 = get_led_field(prefix, i, 5);
                led.light_switch_position5 = get_led_field(prefix, i, 6);
                led.light_switch_position6 = get_led_field(prefix, i, 7);
                led.light_switch_position7 = get_led_field(prefix, i, 8);
                led.light_switch_position8 = get_led_field(prefix, i, 9);
                led.tail_light = get_led_field(prefix, i, 10);
                led.brake_light = get_led_field(prefix, i, 11);
                led.reversing_light = get_led_field(prefix, i, 12);
                led.indicator_left = get_led_field(prefix, i, 13);
                led.indicator_right = get_led_field(prefix, i, 14);

                led.max_change_per_systick = Math.round(
                    get_led_feature(prefix, i, 'incandescent') * 255 / 100
                );
                led.reduction_percent = get_led_feature(prefix, i, 'weak_ground');
                led.weak_light_switch_position0 = get_led_feature(prefix, i, 'checkbox0');
                led.weak_light_switch_position1 = get_led_feature(prefix, i, 'checkbox1');
                led.weak_light_switch_position2 = get_led_feature(prefix, i, 'checkbox2');
                led.weak_light_switch_position3 = get_led_feature(prefix, i, 'checkbox3');
                led.weak_light_switch_position4 = get_led_feature(prefix, i, 'checkbox4');
                led.weak_light_switch_position5 = get_led_feature(prefix, i, 'checkbox5');
                led.weak_light_switch_position6 = get_led_feature(prefix, i, 'checkbox6');
                led.weak_light_switch_position7 = get_led_feature(prefix, i, 'checkbox7');
                led.weak_light_switch_position8 = get_led_feature(prefix, i, 'checkbox8');
                led.weak_tail_light = get_led_feature(prefix, i, 'checkbox9');
                led.weak_brake_light = get_led_feature(prefix, i, 'checkbox10');
                led.weak_reversing_light = get_led_feature(prefix, i, 'checkbox11');
                led.weak_indicator_left = get_led_feature(prefix, i, 'checkbox12');
                led.weak_indicator_right = get_led_feature(prefix, i, 'checkbox13');
            }
        }

        get_led_fields(local_leds, 'master');
        get_led_fields(slave_leds, 'slave');
    };


    // *************************************************************************
    var get_config = function () {
        var i;

        function update_int(key) {
            config[key] = parseInt(el[key].value, 10);
        }

        function update_boolean(key) {
            config[key] = Boolean(el[key].checked);
        }

        function update_time(key) {
            config[key] = Math.round(el[key].value / SYSTICK_IN_MS);
        }

        function update_gamma(key) {
            var g = parseFloat(el[key].value);

            if (isNaN(g)) {
                gamma_object[key] = '2.2';
                return;
            }

            if (g < 0.1) {
                gamma_object[key] = '0.1';
                return;
            }
            if (g > 9.9) {
                gamma_object[key] = '9.9';
                return;
            }

            g = g.toString();
            if (g.length < 3) {
                // Append .0 if we are dealing with an integer value
                g += '.0';
            }

            gamma_object[key] = g;
        }


        log.log('config.mode: ' + config.mode);
        log.log('config_version: ' + config_version);
        log.log('config.firmware_version: ' + config.firmware_version);


        // Baudrate
        update_int('baudrate');


        // If the test firmware is requested return the special configuration
        // that is stored as part of this tool.
        if (parseInt(el.mode.value, 10) === MODE.TEST) {
            // Patch firmware version
            hardware_test_configuration.config.firmware_version = config.firmware_version;
            hardware_test_configuration.config.baudrate = config.baudrate;
            return hardware_test_configuration;
        }
        else if (parseInt(el.mode.value, 10) === MODE.PREPROCESSOR) {
            preprocessor_configuration.config.firmware_version = config.firmware_version;
            preprocessor_configuration.config.baudrate = config.baudrate;
            preprocessor_configuration.config.multi_aux = false;
            return preprocessor_configuration;
        }
        else if (parseInt(el.mode.value, 10) === MODE.PREPROCESSOR_5CH) {
            preprocessor_configuration.config.firmware_version = config.firmware_version;
            preprocessor_configuration.config.baudrate = config.baudrate;
            preprocessor_configuration.config.multi_aux = true;
            return preprocessor_configuration;
        }


        // ESC mode
        for (i = 0; i <  el.esc.length; i += 1) {
            if (el.esc[i].checked) {
                config.esc_mode = parseInt(el.esc[i].value, 10);
                break;
            }
        }


        // Output functions
        if (config.mode === MODE.SLAVE) {
            // Force all output functions to OFF in slave mode
            config.preprocessor_output = false;
            config.slave_output = false;
            config.steering_wheel_servo_output = false;
            config.gearbox_servo_output = false;
            config.gearbox_light_program_control = false;
            config.light_program_servo_output = false;
            config.winch_output = false;
        } else {
            update_boolean('preprocessor_output');
            update_boolean('slave_output');
            update_boolean('steering_wheel_servo_output');
            update_boolean('gearbox_servo_output');
            update_boolean('gearbox_light_program_control');
            update_boolean('light_program_servo_output');
            if (el.preprocessor_output.checked || el.slave_output.checked) {
                config.winch_output = Boolean(el.winch_enable.checked);
            }
            else {
                update_boolean('winch_output');
            }
        }

        // CH3/AUX type
        config.ch3_is_momentary = false;
        config.ch3_is_local_switch = false;
        config.ch3_is_two_button = false;
        if (el.ch3[2].checked) {
            config.ch3_is_momentary = true;
        } else if (el.ch3[3].checked) {
            config.ch3_is_local_switch = true;
        } else if (el.ch3[1].checked) {
            config.ch3_is_two_button = true;
        }


        // LEDs
        update_led_config();


        // Update advanced settings
        update_boolean('auto_brake_lights_forward_enabled');
        update_time('auto_brake_counter_value_forward_min');
        update_time('auto_brake_counter_value_forward_max');

        update_boolean('auto_brake_lights_reverse_enabled');
        update_time('auto_brake_counter_value_reverse_min');
        update_time('auto_brake_counter_value_reverse_max');

        update_time('brake_disarm_counter_value');

        update_time('auto_reverse_counter_value_min');
        update_time('auto_reverse_counter_value_max');

        update_time('blink_counter_value');
        update_time('indicator_idle_time_value');
        update_time('indicator_off_timeout_value');
        update_int('blink_threshold');

        update_int('centre_threshold_low');
        update_int('centre_threshold_high');
        update_int('initial_endpoint_delta');

        update_time('ch3_multi_click_timeout');
        update_time('winch_command_repeat_time');
        update_time('no_signal_timeout');
        update_int('number_of_gears');
        update_time('gearbox_servo_active_time');
        update_time('gearbox_servo_idle_time');

        update_int('initial_light_switch_position');

        update_int('servo_pulse_min');
        update_int('servo_pulse_max');
        update_time('startup_time');

        update_time('blink_counter_value_dark');
        update_boolean('us_style_combined_lights');
        update_boolean('shelf_queen_mode');

        update_int('aux_type');
        update_int('aux_function');
        update_int('aux2_type');
        update_int('aux2_function');
        update_int('aux3_type');
        update_int('aux3_function');


        if (config.mode === MODE.SLAVE) {
            // Force gamma to 1.0 in slave mode as the gamma correction is
            // already handled in the master
            gamma_object.gamma_value = '1.0';
        }
        else {
            update_gamma('gamma_value');
        }


        light_programs = ui.get_editor_content();

        var data = {};
        data.config = config;
        data.local_leds = local_leds;
        data.slave_leds = slave_leds;
        data.gamma = gamma_object;
        data.light_programs = light_programs;

        return data;
    };


    // *************************************************************************
    var save_firmware = function () {
        var default_filename;
        var blob;

        // Update data based on UI
        var data = get_config();

        // Set ch3_is_local_switch always when UART input active
        if (config_version !== 1) {
            if (data.config.mode === MODE.MASTER_WITH_UART_READER || data.config.mode === MODE.STAND_ALONE) {
                data.config.ch3_is_local_switch = true;
            }
        }

        try {
            assemble_firmware(data);
        } catch (e) {
            window.alert(
                'Failed to assemble the firmware. Reason:\n\n' + e.message
            );
            return;
        }

        if (el.hardware.value == 'mk4') {
            let hex = intel_hex.fromArray(firmware.data);
            blob = new Blob([hex], {type: 'text/plain;charset=utf-8'});
            default_filename = 'light_controller.hex';
        }

        // Don't show prompt on nw.js where we have a proper file-save dialog
        let filename = default_filename;
        if (typeof nw === 'undefined') {
            filename = window.prompt('Filename for the firmware image:', default_filename);
        }

        if (filename !== null  &&  filename !== '') {
            saveAs(blob, filename);
        }
    };


    // *************************************************************************
    var save_configuration = function () {
        // Retrieve the settings based on the UI
        var data = get_config();

        var configuration_string = JSON.stringify(data, null, 2);

        var blob = new Blob([configuration_string], {
            type: 'text/plain;charset=utf-8'
        });

        // Don't show prompt on nw.js where we have a proper file-save dialog
        let default_filename = 'light_controller.config.txt';
        let filename = default_filename;
        if (typeof nw === 'undefined') {
            filename = window.prompt('Filename for the firmware image:', default_filename);
        }

        if (filename !== null  &&  filename !== '') {
            saveAs(blob, filename);
        }
    };


    // *************************************************************************
    var clear_leds = function () {
        // Clear LED master and slave configuration to allow starting with a
        // clear slate

        function clear_leds() {

            var result = {};
            var led_count = 16;
            var i;

            result.led_count = led_count;

            function clear_led() {
                var led = {};

                led.max_change_per_systick = 0;
                led.reduction_percent = 0;

                led.weak_light_switch_position0 = false;
                led.weak_light_switch_position1 = false;
                led.weak_light_switch_position2 = false;
                led.weak_light_switch_position3 = false;
                led.weak_light_switch_position4 = false;
                led.weak_light_switch_position5 = false;
                led.weak_light_switch_position6 = false;
                led.weak_light_switch_position7 = false;
                led.weak_light_switch_position8 = false;
                led.weak_tail_light = false;
                led.weak_brake_light = false;
                led.weak_reversing_light = false;
                led.weak_indicator_left = false;
                led.weak_indicator_right = false;

                led.always_on = 0;
                led.light_switch_position0 = 0;
                led.light_switch_position1 = 0;
                led.light_switch_position2 = 0;
                led.light_switch_position3 = 0;
                led.light_switch_position4 = 0;
                led.light_switch_position5 = 0;
                led.light_switch_position6 = 0;
                led.light_switch_position7 = 0;
                led.light_switch_position8 = 0;
                led.tail_light = 0;
                led.brake_light = 0;
                led.reversing_light = 0;
                led.indicator_left = 0;
                led.indicator_right = 0;

                return led;
            }

            for (i = 0; i < led_count; i += 1) {
                result[i] = clear_led();
            }
            return result;
        }

        local_leds = clear_leds();
        slave_leds = clear_leds();
        update_ui();
    };

    // *************************************************************************
    var select_page = function (selected_page) {
        for (var index = 0; index < el.menu_buttons.length; index += 1) {
            var button = el.menu_buttons[index];
            var page_name = button.getAttribute('data');
            var page = document.querySelector('#' + page_name);
            if (page) {
                if (page_name == selected_page) {
                    page.classList.remove('hidden');
                    button.classList.add('selected');
                }
                else {
                    page.classList.add('hidden');
                    button.classList.remove('selected');
                }
            }
        }

        ui.refresh_editor();

        // if (selected_page == 'testing') {
        //     if (el.hardware.value == 'mk4') {
        //         preprocessor_simulator.init(el.flash_serial_port.value, parseInt(el.baudrate.value, 10));
        //     }
        // }
        // else {
        //     preprocessor_simulator.disconnect();
        // }
    };

    // *************************************************************************
    var init_assembler = function () {
        parser.yy = {
            symbols: symbols,
            emitter: emitter,
            logger: logger
        };

        logger.set_log_level('ERROR');

        emitter.set_parser(parser);
        symbols.set_parser(parser);

        el.light_programs_ok.classList.add('hidden');
    };

    // // *************************************************************************
    // var update_visibility_from_ports = function () {
    //     if (el.hardware.value == 'mk4') {
    //         el.hardware_webusb.classList.add('hidden');

    //         if (has_uart) {
    //             el.hardware_uart.classList.remove('hidden');

    //             if (number_of_serial_ports > 0) {
    //                 el.flash.disabled = false;
    //                 el.read.disabled = false;
    //                 preprocessor_simulator_disabled = false;
    //             }
    //             else {
    //                 el.flash.disabled = true;
    //                 el.read.disabled = true;
    //                 preprocessor_simulator_disabled = true;
    //             }
    //         }
    //         else {
    //             el.hardware_uart.classList.add('hidden');
    //             el.flash.disabled = false;
    //             el.read.disabled = false;
    //             preprocessor_simulator_disabled = false;
    //         }
    //     }

    //     update_section_visibility();
    // };

    // // *************************************************************************
    // var discover_serial_ports = function () {
    //     if (!has_uart) {
    //         return;
    //     }

    //     chrome.serial.getDevices((ports) => {
    //         let current_ports = {};
    //         ports.forEach(port => {
    //             current_ports[port.path] = port.displayName;
    //         });

    //         let changed = false;
    //         // Check whether ports were added
    //         for (let dev in current_ports) {
    //             if (!serial_ports.hasOwnProperty(dev)) {
    //                 changed = true;
    //             }
    //         }

    //         // Check whether ports were removed
    //         for (let dev in serial_ports) {
    //             if (!current_ports.hasOwnProperty(dev)) {
    //                 changed = true;
    //             }
    //         }

    //         if (changed) {
    //             serial_ports = current_ports;
    //             let current_value = el.flash_serial_port.value;

    //             // Clear the current options
    //             while (el.flash_serial_port.options.length) {
    //                 el.flash_serial_port.remove(0);
    //             }

    //             Object.keys(serial_ports).sort().forEach(path => {
    //                 let name = serial_ports[path];
    //                 let label = path + ' (' + name + ')';
    //                 el.flash_serial_port.add(new Option(label, path));
    //             });

    //             number_of_serial_ports = el.flash_serial_port.options.length;

    //             if (!number_of_serial_ports) {
    //                 el.flash_serial_port.add(new Option('(no serial port found)', '0'));
    //             }

    //             if (serial_ports.hasOwnProperty(current_value)) {
    //                 el.flash_serial_port.value = current_value;
    //             }
    //             else {
    //                 el.flash_serial_port.selectedIndex = 0;
    //             }

    //             update_visibility_from_ports();
    //         }

    //         setTimeout(discover_serial_ports, 3000);
    //     });
    // };


    // // *************************************************************************
    // var update_usb_device_list = function () {
    //     let current_value = el.flash_usb_device.value;
    //     let previous_device_still_exists = false;

    //     // Clear the current options
    //     while (el.flash_usb_device.options.length) {
    //         el.flash_usb_device.remove(0);
    //     }

    //     usb_devices.forEach(usb_device => {
    //         let name = usb_device.device_.serialNumber;
    //         let label = usb_device.device_.serialNumber;
    //         el.flash_usb_device.add(new Option(label, name));

    //         if (label == current_value) {
    //             previous_device_still_exists = true;
    //         }
    //     });

    //     let number_of_usb_devices = el.flash_usb_device.options.length;

    //     if (!number_of_usb_devices) {
    //         el.flash_usb_device.add(new Option('(press pair button to add a light controller)', '0'));
    //     }

    //     if (previous_device_still_exists) {
    //         el.flash_usb_device.value = current_value;
    //     }
    //     else {
    //         el.flash_usb_device.selectedIndex = 0;
    //     }

    //     update_visibility_from_ports();
    // };


    // // *************************************************************************
    // var usb_device_connected = function (event) {
    //     let device = event.device;

    //     // log.log('usb_device_connected', device);

    //     if (device.vendorId == 0x6666) {
    //         if (device.productId == 0xcab1) {
    //             let interfaces = dfu.findDeviceDfuInterfaces(device);
    //             if (interfaces.length == 0) {
    //                 return;
    //             }
    //             let dfu_device = new dfu.Device(device, interfaces[0]);
    //             usb_devices.push(dfu_device);
    //         }
    //     }

    //     update_usb_device_list();
    // };


    // // *************************************************************************
    // var usb_device_disconnected = function (event) {
    //     let device = event.device;

    //     // log.log('usb_device_disconnected', device);

    //     if (device.vendorId == 0x6666) {
    //         if (device.productId == 0xcab1) {
    //             for (let i = 0; i < usb_devices.length; i++) {
    //                 let known_device = usb_devices[i];

    //                 if (known_device.device_.serialNumber == device.serialNumber) {
    //                     usb_devices.splice(i, 1);
    //                 }
    //             }
    //         }
    //     }

    //     update_usb_device_list();
    // };


    // // *************************************************************************
    // var discover_usb_devices = async function () {
    //     if (!has_webusb) {
    //         return;
    //     }

    //     el.hardware_webusb.classList.remove('hidden');

    //     usb_devices = [];

    //     let dfu_devices = await dfu.findAllDfuInterfaces();
    //     if (dfu_devices.length) {
    //         for (let dfu_device of dfu_devices) {
    //             if (dfu_device.device_.vendorId == 0x6666) {
    //                 if (dfu_device.device_.productId == 0xcab1) {
    //                     usb_devices.push(dfu_device);
    //                 }
    //             }
    //         }
    //     }

    //     update_usb_device_list();

    //     navigator.usb.addEventListener('connect', usb_device_connected);
    //     navigator.usb.addEventListener('disconnect', usb_device_disconnected);
    // };


    // // *************************************************************************
    // var get_usb_device_by_serial_number = function (serial_number) {
    //     for (let i = 0; i < usb_devices.length; i++) {
    //         if (usb_devices[i].device_.serialNumber == serial_number) {
    //             return usb_devices[i];
    //         }
    //     }

    //     return null;
    // };


    // // *************************************************************************
    // var pair_usb_device = async function () {
    //     const filters = [{ 'vendorId': 0x6666, 'productId': 0xcab1 }];

    //     let usb_device;
    //     try {
    //         usb_device = await navigator.usb.requestDevice({ 'filters': filters });
    //     }
    //     catch (error) {
    //         log.log(error);
    //         return;
    //     }

    //     let interfaces = dfu.findDeviceDfuInterfaces(usb_device);
    //     if (interfaces.length == 0) {
    //         log.log('The selected device does not have any USB DFU interfaces.');
    //         return;
    //     }

    //     let dfu_device = new dfu.Device(usb_device, interfaces[0]);

    //     // Only add device if we don't have it already
    //     if (!get_usb_device_by_serial_number(dfu_device.device_.serialNumber)) {
    //         usb_devices.push(dfu_device);
    //         update_usb_device_list();
    //     }
    // };


    // // *************************************************************************
    // var flash = async function () {
    //     let programmer;
    //     let device;

    //     let config = get_config();
    //     assemble_firmware(config);

    //     switch (el.hardware.value) {
    //     case 'mk4':
    //         programmer = new flash_lpc8xx(new chrome_uart());
    //         device = el.flash_serial_port.value;
    //         break;
    //     }


    //     el.flash_progress.value = 0;
    //     el.flash_heading.textContent = 'Flashing ...';
    //     el.flash_button.textContent = 'Cancel';
    //     el.flash_button.disabled = false;
    //     el.flash_message.textContent = '';
    //     el.flash_message.classList.remove('error');
    //     el.flash_dialog.classList.remove('hidden');
    //     el.flash_progress.classList.remove('hidden');


    //     programmer.onMessageCallback = function (message) {
    //         el.flash_message.textContent = message;
    //     };

    //     programmer.onProgressCallback = function (progress) {
    //         el.flash_progress.value = progress;
    //     };

    //     programmer.setCancelButtonEnabled = function (enabled) {
    //         el.flash_button.disabled = enabled;
    //     };

    //     function button_pressed() {
    //         programmer.cancel();
    //         el.flash_dialog.classList.add('hidden');
    //         el.flash_button.removeEventListener('click', button_pressed);
    //     }

    //     el.flash_button.addEventListener('click', button_pressed);

    //     if (await programmer.flash(device, firmware.data)) {
    //         el.flash_dialog.classList.add('hidden');
    //         el.flash_button.removeEventListener('click', button_pressed);
    //     }
    //     else {
    //         el.flash_button.textContent = 'Close';
    //         el.flash_button.disabled = false;
    //         el.flash_message.classList.add('error');
    //     }
    // };


    // // *************************************************************************
    // var read_firmware_from_flash = async function () {
    //     el.flash_progress.value = 0;
    //     el.flash_heading.textContent = 'Reading firmware ...';
    //     el.flash_button.textContent = 'Cancel';
    //     el.flash_button.disabled = false;
    //     el.flash_message.textContent = '';
    //     el.flash_message.classList.remove('error');
    //     el.flash_dialog.classList.remove('hidden');
    //     el.flash_progress.classList.add('hidden');

    //     let mk4_isp = new flash_lpc8xx(new chrome_uart());

    //     mk4_isp.onMessageCallback = function (message) {
    //         el.flash_message.textContent = message;
    //     };

    //     function button_pressed() {
    //         mk4_isp.cancel();
    //         el.flash_dialog.classList.add('hidden');
    //         el.flash_button.removeEventListener('click', button_pressed);
    //     }

    //     el.flash_button.addEventListener('click', button_pressed);

    //     let bin = await mk4_isp.read_flash(el.flash_serial_port.value);
    //     if (bin.length) {
    //         el.flash_dialog.classList.add('hidden');
    //         el.flash_button.removeEventListener('click', button_pressed);

    //         load_firmware(bin);
    //     }
    //     else {
    //         el.flash_button.textContent = 'Close';
    //         el.flash_button.disabled = false;
    //         el.flash_message.classList.add('error');
    //     }
    // };


    // *************************************************************************
    var init = function () {

        function set_led_feature_handler(led_id) {
            var i;
            var row;
            var input_elements;
            var led_section = document.getElementById(led_id);
            var feature_rows =
                led_section.getElementsByClassName('led_features');

            for (row = 0; row < feature_rows.length; row += 1) {
                input_elements =
                    feature_rows[row].getElementsByTagName('input');

                for (i = 0; i < input_elements.length; i += 1) {
                    input_elements[i].addEventListener('change',
                        update_led_feature_usage, true
                    );
                }
            }
        }


        [
            'firmware_version',

            'load', 'load_input', 'save_config', 'save_firmware', 'flash', 'read',

            'hardware', 'hardwawre_image',
            'hardware_uart', 'flash_serial_port',
            'hardware_webusb', 'flash_usb_device', 'webusb_pair',

            'mode',
            'mode_master_servo',
            'mode_master_uart',
            'mode_master_uart_5ch',
            'mode_master_cppm',
            'mode_slave',
            'mode_stand_alone',
            'mode_preprocessor',
            'mode_preprocessor_5ch',
            'mode_test',

            'config_baudrate', 'baudrate',
            'config_leds', 'leds_master', 'leds_slave',
            'config_esc',
            'config_ch3',
            'config_output',

            'aux_3ch', 'multi_aux',

            'slave_output', 'preprocessor_output', 'steering_wheel_servo_output',
            'gearbox_servo_output', 'winch_output', 'winch_enable',
            'light_program_servo_output', 'gearbox_light_program_control',

            'leds_clear',

            'config_light_programs', 'light_programs', 'light_programs_errors',
            'light_programs_assembler', 'light_programs_ok',

            'config_advanced',

            'auto_brake_lights_forward_enabled',
            'auto_brake_counter_value_forward_min',
            'auto_brake_counter_value_forward_max',

            'auto_brake_lights_reverse_enabled',
            'auto_brake_counter_value_reverse_min',
            'auto_brake_counter_value_reverse_max',

            'brake_disarm_timeout_enabled', 'brake_disarm_counter_value',
            'auto_reverse_counter_value_min', 'auto_reverse_counter_value_max',

            'blink_counter_value', 'blink_counter_value_dark',
            'indicator_idle_time_value', 'indicator_off_timeout_value',
            'blink_threshold',

            'centre_threshold_low', 'centre_threshold_high',
            'initial_endpoint_delta', 'ch3_multi_click_timeout',
            'winch_command_repeat_time','no_signal_timeout', 'shelf_queen_mode',

            'number_of_gears','gearbox_servo_active_time','gearbox_servo_idle_time',

            'initial_light_switch_position',

            'servo_pulse_min', 'servo_pulse_max',

            'startup_time', 'us_style_combined_lights', 'gamma_value',

            'aux_type', 'aux_function',
            'aux2_type', 'aux2_function',
            'aux3_type', 'aux3_function',

        ].forEach(function (name) {
            el[name] = document.getElementById(name);
        });

        el.menu_buttons = document.querySelectorAll('nav button');

        el.esc = document.getElementsByName('esc');
        el.ch3 = document.getElementsByName('ch3');

        el.output_out = document.getElementsByName('output_out');
        el.single_output = document.getElementsByClassName('single_output');
        el.dual_output = document.getElementsByClassName('dual_output');
        el.dual_output_th = document.getElementsByClassName('dual_output_th');

        el.flash_dialog = document.querySelector('#flash_dialog');
        el.flash_heading = el.flash_dialog.querySelector('.heading');
        el.flash_progress = el.flash_dialog.querySelector('progress');
        el.flash_message = el.flash_dialog.querySelector('#programming_message');
        el.flash_button = el.flash_dialog.querySelector('button');


        set_led_feature_handler('leds_master', 'master');
        set_led_feature_handler('leds_slave', 'slave');

        el.mode.addEventListener('change', mode_changed_handler, false);

        el.config_output.addEventListener('change', update_section_visibility, false);

        el.load.addEventListener('click', function () {
            el.load_input.click();
        }, false);

        el.load_input.addEventListener('change', load_file_from_disk, false);
        el.save_config.addEventListener('click', save_configuration, false);
        el.save_firmware.addEventListener('click', save_firmware, false);

        // el.flash.addEventListener('click', flash);
        // el.read.addEventListener('click', read_firmware_from_flash);

        el.hardware.addEventListener('change', hardware_changed, false);

        el.leds_clear.addEventListener('click', function () {
            if (window.confirm('Clear all LED configurations? This can not be undone.')) {
                clear_leds();
            }
        }, false);

        el.light_programs_assembler.addEventListener('click', function () {
            parse_light_program_code(ui.get_editor_content());
        }, false);

        for (var index = 0; index < el.menu_buttons.length; index += 1) {
            var button = el.menu_buttons[index];
            button.addEventListener('click', function (event) {
                var selected_page = event.currentTarget.getAttribute('data');
                select_page(selected_page);
            });
        }

        el.aux_type.addEventListener('change',
            aux_type_changed_handler.bind({'type': el.aux_type, 'fn': el.aux_function})
        );
        el.aux2_type.addEventListener('change',
            aux_type_changed_handler.bind({'type': el.aux2_type, 'fn': el.aux2_function})
        );
        el.aux3_type.addEventListener('change',
            aux_type_changed_handler.bind({'type': el.aux3_type, 'fn': el.aux3_function})
        );

        // el.webusb_pair.addEventListener('click', pair_usb_device);

        // preprocessor_simulator = new preprocessor();

        // discover_serial_ports();
        // discover_usb_devices();

        init_assembler();

        let contents = hex_to_bin(default_firmware_image_mk4);
        load_firmware(contents);
        load_default_configuration();
        hardware_changed();

        select_page('config_hardware');
    };


    // *************************************************************************
    return {
        load: load_firmware,
        init: init
    };
}());


// *****************************************************************************
document.addEventListener('DOMContentLoaded', function () {
    ui.init();
    app.init();
}, false);


