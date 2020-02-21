
## Perform php-unit tests
function tests() {
    local COMMAND
    local COVERAGE
    local FILTER
    local MEMORY_LIMIT='false'
    local PHPUNIT
    local SIMPLE_PHPUNIT='false'
    local STOP_ON_FAILURE='false'
    local TEST_SUITE

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :c:t:f:lsSvh OPTION; do
            case "${OPTION}" in
                c) COVERAGE="${OPTARG}";;
                t) TEST_SUITE=$(echo "${OPTARG}"|tr '[:upper:]' '[:lower:]');;
                f) FILTER="${OPTARG}";;
                l) MEMORY_LIMIT='true';;
                s) STOP_ON_FAILURE='true';;
                S) SIMPLE_PHPUNIT='true';;
                h) echo_label 'description'; echo_primary 'run phpunit tests'
                    echo_label 'usage';      echo_primary 'phpunit [test_file] [-t test_suite] [-f filter] [-c coverage-html] -s (stop on failure) -S (simple-phpunit) -l (memory limit) -h (help)'
                    return 0;;
                :) echo_error "\"${OPTARG}\" requires value"
                    return 1;;
                \?) echo_error "invalid option \"${OPTARG}\""
                    return 1;;
            esac
        done
        if [ "${OPTIND}" -gt 1 ]; then
            shift $(( OPTIND-1 ))
        fi
        if [ "${OPTIND}" -eq 1 ]; then
            ARGUMENTS+=("${1}")
            shift
        fi
    done

    if [ "${#}" -gt 1 ]; then
        echo_error "too many arguments ($#)"
        echo_label 'usage'; echo_primary 'phpunit [test_file] [-t test_suite] [-f filter] [-c coverage-html] -s (stop on failure) -S (simple-phpunit) -l (memory limit) -h (help)'
        return 1
    fi

    # get phpunit executable
    if [ -f ./bin/phpunit ]; then
        # symfony 4
        PHPUNIT='./bin/phpunit'
    elif [ -f ./vendor/bin/phpunit ]; then
        # symfony 3.4 & 2.8
        PHPUNIT='./vendor/bin/phpunit'
    fi

    if [ "${SIMPLE_PHPUNIT}" = 'true' ] || [ -z "${PHPUNIT}" ]; then
        if [ -f ./vendor/bin/simple-phpunit ]; then
            PHPUNIT='./vendor/bin/simple-phpunit'
        # get simple-phpunit executable from phpunit-bridge
        elif [ -f ./vendor/symfony/phpunit-bridge/bin/simple-phpunit ]; then
            PHPUNIT='./vendor/symfony/phpunit-bridge/bin/simple-phpunit'
        fi
    fi

    # executable not found
    if [ -z "${PHPUNIT}" ]; then
        if [ "${SIMPLE_PHPUNIT}" = 'true' ]; then
            echo_error 'simple-phpunit executable not found'
        else
            echo_error 'phpunit executable not found'
        fi
        if [ ! -d ./vendor ]; then
            echo_error 'could not find ./vendor folder. did you forget composer install ?'
        fi
        return 1
    fi

    COMMAND='php'

    if [ "${MEMORY_LIMIT}" = false ]; then
        COMMAND+=' -d memory-limit=-1'
    fi

    # reset COMMAND on windows machine
    if [ "${OSTYPE}" = 'msys' ]; then
        COMMAND="${PHPUNIT}"
    else
        COMMAND+=" ${PHPUNIT}"
    fi

    if [ -n "${ARGUMENTS[${LBOUND}]}" ]; then
        COMMAND+=" ${ARGUMENTS[${LBOUND}]}"
    fi

    if [ -n "$TEST_SUITE" ]; then
        COMMAND+=" --testsuite=$TEST_SUITE"
    fi

    if [ -n "${FILTER}" ]; then
        COMMAND+=" --filter=${FILTER}"
    fi

    if [ "${STOP_ON_FAILURE}" = 'true' ]; then
        COMMAND+=' --stop-on-failure'
    fi

    if [ -n "${COVERAGE}" ]; then
        COMMAND+=" --coverage-html ${COVERAGE}"
    fi

    echo_info "${COMMAND}"
    bash -c "${COMMAND}"
}
