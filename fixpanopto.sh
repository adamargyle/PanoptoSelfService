#!/bin/bash
# Created by Alexander Kaltsas - @macdude22 on the MacAdmins Slack

echo "BEGIN FIX PANOPTO SCRIPT"

if [ $(echo $EUID) -ne 0 ]; then
echo "Must run as root. Please re-run with sudo"
exit 1
fi

echo "testing directory"
if [ ! -d /var/panopto ]; then
sudo mkdir /var/panopto
fi

echo "testing UserShell"
if ! dscl . -read /Users/panopto_upload UserShell | grep nologin; then
sudo dscl . -create /Users/panopto_upload UserShell /sbin/nologin
fi

echo "testing UniqueID"
if dscl . -read /Users/panopto_upload UniqueID 2>&1 >/dev/null | grep "No such key"; then
echo "creating UniqueID"
dscl . -create /Users/panopto_upload UniqueID 401
fi

echo "testing PrimaryGroupID"
if dscl . -read /Users/panopto_upload PrimaryGroupID 2>&1 >/dev/null | grep "No such key" ; then
echo "creating PrimaryGroupID"
dscl . -create /Users/panopto_upload PrimaryGroupID 1
fi

echo "testing NFSHomeDirectory"
if ! dscl . -read /Users/panopto_upload NFSHomeDirectory | grep panopto; then
echo "creating NFSHomeDirectory"
dscl . -create /Users/panopto_upload NFSHomeDirectory /var/panopto
fi

echo "testing AuthenticationAuthority"
if ! dscl . -read /Users/panopto_upload AuthenticationAuthority 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload AuthenticationAuthority
fi

echo "testing HeimdalSRPKey"
if ! dscl . -read /Users/panopto_upload dsAttrTypeNative:HeimdalSRPKey 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload dsAttrTypeNative:HeimdalSRPKey
fi

echo "testing _writers_passwd"
if ! dscl . -read /Users/panopto_upload dsAttrTypeNative:_writers_passwd 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload dsAttrTypeNative:_writers_passwd
fi

echo "testing accountPolicyData"
if ! dscl . -read /Users/panopto_upload dsAttrTypeNative:accountPolicyData 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload dsAttrTypeNative:accountPolicyData
fi

echo "testing ShadowHashData"
if ! dscl . -read /Users/panopto_upload dsAttrTypeNative:ShadowHashData 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload dsAttrTypeNative:ShadowHashData
fi

echo "testing KerberosKeys"
if ! dscl . -read /Users/panopto_upload dsAttrTypeNative:KerberosKeys 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload dsAttrTypeNative:KerberosKeys
fi

echo "testing record_daemon_version"
if ! dscl . -read /Users/panopto_upload dsAttrTypeNative:record_daemon_version 2>&1 >/dev/null | grep "No such key"; then
dscl . -delete /Users/panopto_upload dsAttrTypeNative:record_daemon_version
fi

echo "chowning /var/panopto"
sudo chown panopto_upload /var/panopto

echo "END FIX PANOPTO SCRIPT"