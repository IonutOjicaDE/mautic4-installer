#!/bin/bash
. $(dirname "$(readlink -f "$0")")'/mautic.sh'
#set -x

# <style>.cke{visibility:hidden;}</style>

console_doctrine="${MAUTIC_FOLDER}bin/console doctrine:query:sql"

echo "emails:*n                                   <style>.cke{visibility:hidden;}</style>     *"
php "${console_doctrine}" "UPDATE \`emails\` SET \`custom_html\` = REPLACE(\`custom_html\`, '\n                                   <style>.cke{visibility:hidden;}</style>     ', '') WHERE \`custom_html\` LIKE '%<style>.cke{visibility:hidden;}</style>%';"

echo "email_copies:*n                                   <style>.cke{visibility:hidden;}</style>     *"
php "${console_doctrine}" "UPDATE \`email_copies\` SET \`body\` = REPLACE(\`body\`, '\n                                   <style>.cke{visibility:hidden;}</style>     ', '') WHERE \`body\` LIKE '%<style>.cke{visibility:hidden;}</style>%';"

echo "email_copies:*<style>.cke{visibility:hidden;}</style>*"
php "${console_doctrine}" "UPDATE \`emails\` SET \`custom_html\` = REPLACE(\`custom_html\`, '<style>.cke{visibility:hidden;}</style>', '') WHERE \`custom_html\` LIKE '%<style>.cke{visibility:hidden;}</style>%';"

echo "emails:*<style>.cke{visibility:hidden;}</style>*"
php "${console_doctrine}" "UPDATE \`email_copies\` SET \`body\` = REPLACE(\`body\`, '<style>.cke{visibility:hidden;}</style>', '') WHERE \`body\` LIKE '%<style>.cke{visibility:hidden;}</style>%';"

echo "emails:*n                                        *"
php "${console_doctrine}" "UPDATE \`emails\` SET \`custom_html\` = REPLACE(\`custom_html\`, '\n                                        ', '') WHERE \`custom_html\` LIKE '%                                        %';"

echo "email_copies:*n                                        *"
php "${console_doctrine}" "UPDATE \`email_copies\` SET \`body\` = REPLACE(\`body\`, '\n                                        ', '') WHERE \`body\` LIKE '%                                        %';"

# <div data-empty="true"><br></div>

echo "emails:*<div data-empty=\"true\"><br /></div><div data-empty=\"true\"><br /></div><div data-empty=\"true\"><br /></div>*"
php "${console_doctrine}" "UPDATE \`emails\` SET \`custom_html\` = REPLACE(\`custom_html\`, '<div data-empty=\"true\"><br /></div><div data-empty=\"true\"><br /></div><div data-empty=\"true\"><br /></div>', '<br /><br /><br />') WHERE \`custom_html\` LIKE '%<div data-empty=\"true\">%';"
echo "emails:*<div data-empty=\"true\"><br /></div><div data-empty=\"true\"><br /></div>*"
php "${console_doctrine}" "UPDATE \`emails\` SET \`custom_html\` = REPLACE(\`custom_html\`, '<div data-empty=\"true\"><br /></div><div data-empty=\"true\"><br /></div>', '<br /><br />') WHERE \`custom_html\` LIKE '%<div data-empty=\"true\">%';"
echo "emails:*<div data-empty=\"true\"><br /></div>*"
php "${console_doctrine}" "UPDATE \`emails\` SET \`custom_html\` = REPLACE(\`custom_html\`, '<div data-empty=\"true\"><br /></div>', '<br /><br />') WHERE \`custom_html\` LIKE '%<div data-empty=\"true\">%';"

# <span class="atwho-query" data-fr-verified="true">
# <span data-fr-verified="true">{contactf</span>ield=firstname},

#set +x
