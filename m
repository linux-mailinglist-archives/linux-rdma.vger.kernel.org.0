Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0A600DAA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Oct 2022 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJQLY3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Oct 2022 07:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJQLY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Oct 2022 07:24:28 -0400
Received: from usm.uni-muenchen.de (mxusm4.usm.uni-muenchen.de [IPv6:2001:4ca0:4101:0:81:bb:cc:cd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4CB4F
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 04:24:23 -0700 (PDT)
Received: from auth (localhost [127.0.0.1]) by usm.uni-muenchen.de (8.16.1/8.16.0.21) with ESMTPSA id 29HBO8vr008824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Oct 2022 13:24:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=usm.lmu.de;
        s=default; t=1666005848;
        bh=Oh9piXvRbe5KXv8VERHico6h7A8WyFJg9Kitv2UEI4I=;
        h=From:Subject:Date:References:Cc:In-Reply-To:To;
        b=mkQ5qCWIlf9Tw8PKw2qGtrVo9B36CLIufuyY6sXD7PE+i50PPJ0+WMJDfZfs3MNeO
         H1QFAdqJfFL3sLiLSGo2ZTwPNBkXnZ0M1/PRqUmA7jHzbJqu6SkUZQiqjcVcFs4nx7
         XAfTK2xie4psbk37m+UywanpFq8WbastvYKLkU5g=
Content-Type: multipart/signed; boundary=Apple-Mail-8FD3FA5E-9D28-473C-9D8B-7674EEA8B303; protocol="application/pkcs7-signature"; micalg=sha-256
Content-Transfer-Encoding: 7bit
From:   Rudolf Gabler <rug@usm.lmu.de>
Mime-Version: 1.0 (1.0)
Subject: Re: Infiniband crash
Date:   Mon, 17 Oct 2022 13:24:05 +0200
Message-Id: <453E1C28-5722-46E1-8392-3B8D94197FAC@usm.lmu.de>
References: <303b612-34ba-7ca2-f49e-c2a7dae7c6b@gentwo.de>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <303b612-34ba-7ca2-f49e-c2a7dae7c6b@gentwo.de>
To:     Christoph Lameter <cl@gentwo.de>
X-Mailer: iPhone Mail (20A380)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (usm.uni-muenchen.de [IPv6:2001:4ca0:4101:0:81:bb:cc:49]); Mon, 17 Oct 2022 13:24:08 +0200 (MEST)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--Apple-Mail-8FD3FA5E-9D28-473C-9D8B-7674EEA8B303
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

It isn=E2=80=99t that obscure. A HPE C7000 rack with 8 x BL860c Ithanium sev=
er and Infinband module. Half of the server still running a rhel4 like singl=
e system image cluster (but totally outdated) but at least with 20 GBit HBAs=
 (Mellanox) for a fast cluster file system. Ideal for the most kind of syste=
m services (mail =E2=80=A6) because of the intrinsic loadbalance of the clus=
ter. Here the Infiniband still works with ofed 1.4

On the other hand my attempt to replace it with a up to day system (gentoo).=
 I have corosync and pacemaker (and crmsh) to cluster it and the Infiniband p=
roblem is the only thing missing.


Regards Rudi

Von meinem iPhone gesendet

> Am 17.10.2022 um 12:13 schrieb Christoph Lameter <cl@gentwo.de>:
>=20
> =EF=BB=BFOn Fri, 14 Oct 2022, Jason Gunthorpe wrote:
>=20
>>> On Fri, Oct 14, 2022 at 06:16:51PM +0000, rug@usm.lmu.de wrote:
>>> Hi to whom it may concern,
>>>=20
>>> We are getting on a 6.0.0 (and also on 5.10 up) the following Mellanox
>>> infiniband problem (see below).
>>> Can you please help (this is on a running ia64 cluster).
>>=20
>> The fastest/simplest way to get help on something so obscure would be
>> to bisection search to the problematic commit
>>=20
>> You might be the only user left in the world of this combination :)
>=20
> And CC the linux-ia64 mailing list? Gentoo on ia64.. Wow.
>=20
>=20

--Apple-Mail-8FD3FA5E-9D28-473C-9D8B-7674EEA8B303
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFzcw
ggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYTAkRFMSsw
KQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYDVQQLDBZULVN5
c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFsUm9vdCBDbGFzcyAy
MB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNVBAYTAkRFMUUwQwYDVQQK
EzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMg
ZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlv
biBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMtg1/9moUHN0vqH
l4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZsFVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8F
XRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0peQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+Ba
L2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qL
NupOkSk9s1FcragMvp0049ENF4N1xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz
9AkH4wKGMUZrAcUQDBHHWekCAwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU
k+PYMiba1fFKpZFK4OpL4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYD
VR0TAQH/BAgwBgEB/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGC
LB4wCAYGZ4EMAQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUv
cmwvVGVsZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYB
BQUHMAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5jZXIw
DQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4eTizDnS6
dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/MOaZ/SLick0+
hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3SPXez7vTXTf/D6OWS
T1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc22CzeIs2LgtjZeOJVEqM7
h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bPZYoaorVyGTkwggWsMIIElKAD
AgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYDVQQGEwJERTFFMEMGA1UEChM8VmVy
ZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYu
MRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRERk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcNMzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUx
RTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5n
c25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9i
YWwgSXNzdWluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp
1xCeOdfZojDbchwFfylfS2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6W
LkDh0YNMZj0cZGnlm6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mI
TQ5HjUhfZZkQ0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUk
P7agCwf9TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22M
ZD08WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAdBgNV
HQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK4OpL4qIM
z+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9v
dC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYBBQUHAQEEgdAwgc0wMwYI
KwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBKBggrBgEF
BQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/
DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCN
T1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7Ln8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+
lgQCXISoKTlslPwQkgZ7nu7YRrQbtQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v
9NsH1VuEGMGpuEvObJAaguS5Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7
EUkp2KgtdRXYShjqFu9VNCIaE40GMIIFwzCCBKugAwIBAgIMInXz/An98rT9jV6+MA0GCSqGSIb3
DQEBCwUAMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIwMDIyNjEzNDUxN1oXDTIz
MDIyNTEzNDUxN1owZjELMAkGA1UEBhMCREUxMTAvBgNVBAoMKEx1ZHdpZy1NYXhpbWlsaWFucy1V
bml2ZXJzaXRhZXQgTXVlbmNoZW4xDDAKBgNVBAsMA1VTTTEWMBQGA1UEAwwNUnVkb2xmIEdhYmxl
cjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK99BPR5nAMnf2UgI+QhsBSI2lacXrD9
qB4q3Z9a+3iLmh+8DG0ZmsWGcrJDPVsNdvMhs/EBFmFFU1FL17VFsibR+3DXkZfBWVzr75cczHon
IN6SRs7pBaQdvgPvLGtE8GydJhuAZdnFUmjbApJHrvLwq0/bJwVw/4guT+lItPLjtqyDXQaku/2Y
e2rccYIcOnIwBtQP80/SrV0XxosHuhgC6CCykEMitZdeu0X6gReFVdFzgJwhnCNL8EsMys2iHL+D
2vjdFddAF2b91yuMY7ybCYswnDLY7IPT6zJxhF+sBVmo/kKLD8T/2kRYKnR6YNcn4LOrWbBcvREw
YOgCjBUCAwEAAaOCAkcwggJDMD4GA1UdIAQ3MDUwDwYNKwYBBAGBrSGCLAEBBDAQBg4rBgEEAYGt
IYIsAQEEBTAQBg4rBgEEAYGtIYIsAgEEBTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFEa59KxDEHRXAGRLcI7DzmlDdogh
MB8GA1UdIwQYMBaAFGs6mIv58lOJ2uCtsjIeCR/oqjt0MBkGA1UdEQQSMBCBDnJ1Z0B1c20ubG11
LmRlMIGNBgNVHR8EgYUwgYIwP6A9oDuGOWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWds
b2JhbC1nMi9wdWIvY3JsL2NhY3JsLmNybDA/oD2gO4Y5aHR0cDovL2NkcDIucGNhLmRmbi5kZS9k
Zm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMIHbBggrBgEFBQcBAQSBzjCByzAzBggr
BgEFBQcwAYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEkGCCsGAQUF
BzAChj1odHRwOi8vY2RwMS5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NhY2VydC9j
YWNlcnQuY3J0MEkGCCsGAQUFBzAChj1odHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9i
YWwtZzIvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCc7OSkL9/E32VM
NQ60QTb+1E7L0KDF+lxXr4eCgoQqTH0LYiX382Bx/Hz2EAkAmNod9boKUnuiZOcKpOJUW84Jy60f
nZ9X+bjR2j7t33/d/y45ibpDSB4NcukqoQ+rbvyFW0YBo+BNTwUY5bNiTZNyO7T2ULBCGNRLZEpA
mHG5AiyimQk0q+T1v9/0njYn2Z1996C2aZagzxY61mRAnI/4z+abNWSAYKZBGd+q5qMA2qHzOZoR
31sf8vxBCetx4Z73pVsLEcDmSHY94r4T+BBiH5Hx3x3PCKH5Og0bRxNSyIyiafnc98lkZeHTlaA8
Q+wGK6MZo3YJKXUUQ3JeNp0EMIIGpjCCBI6gAwIBAgIQSBX4CiaK2bIZr8RRu1BMEjANBgkqhkiG
9w0BAQwFADBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UE
AxMTR0VBTlQgUGVyc29uYWwgQ0EgNDAeFw0yMjA1MjAwMDAwMDBaFw0yMzA1MjAyMzU5NTlaMIHD
MQ4wDAYDVQQREwU4MDUzOTExMC8GA1UEChMoTHVkd2lnLU1heGltaWxpYW5zLVVuaXZlcnNpdGFl
dCBNdWVuY2hlbjEjMCEGA1UECRMaR2VzY2h3aXN0ZXItU2Nob2xsLVBsYXR6IDExDzANBgNVBAgT
BkJheWVybjELMAkGA1UEBhMCREUxFjAUBgNVBAMTDVJ1ZG9sZiBHYWJsZXIxIzAhBgkqhkiG9w0B
CQEWFHJ1ZG9sZi5nYWJsZXJAbG11LmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
sTmcL/XSH05srUroIanqIAh6ykuMs7ZwRXMXfV0aa/hDq6fgmvhkFwavCCzap45MzQC/4dKeI6lk
imjfMNfd4iBVTpHKX+9wwG6skg7jaEcOMMWXUmPTTSXtEfN4vjixWpRhr/FbfLiaxYB+MJSjOT29
sd/zh3TDgpKTl3QNOuUyYlIkYK/kCKLw2rH0r5ZJ8GKMcryBfljtdMVsI/8IlS+1WYVn03AOUVFz
zGNIUL+piHtqP2Cpvxgmso+D/RffZ9/XHmt0Ndg0+J7DFelolcLv6IWbLaA41BSJiilELlMOODt4
AmAF3AMJA+acM3gdCbwtDgMVtZlraDbuc3eNywIDAQABo4ICEDCCAgwwHwYDVR0jBBgwFoAUaQCh
xyFY+ODFGyCwCt2nUb8T2eQwHQYDVR0OBBYEFCVOfkJyQTCQJF1g6hQOP99FDjFxMA4GA1UdDwEB
/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjA/BgNV
HSAEODA2MDQGCysGAQQBsjEBAgJPMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20v
Q1BTMEIGA1UdHwQ7MDkwN6A1oDOGMWh0dHA6Ly9HRUFOVC5jcmwuc2VjdGlnby5jb20vR0VBTlRQ
ZXJzb25hbENBNC5jcmwweAYIKwYBBQUHAQEEbDBqMD0GCCsGAQUFBzAChjFodHRwOi8vR0VBTlQu
Y3J0LnNlY3RpZ28uY29tL0dFQU5UUGVyc29uYWxDQTQuY3J0MCkGCCsGAQUFBzABhh1odHRwOi8v
R0VBTlQub2NzcC5zZWN0aWdvLmNvbTCBjQYDVR0RBIGFMIGCgRdydWdAdXNtLnVuaS1tdWVuY2hl
bi5kZYEbUnVkb2xmLkdhYmxlckBwaHlzaWsubG11LmRlgQ5ydWdAdXNtLmxtdS5kZYEkUnVkb2xm
LkdhYmxlckBwaHlzaWsudW5pLW11ZW5jaGVuLmRlgRRydWRvbGYuZ2FibGVyQGxtdS5kZTANBgkq
hkiG9w0BAQwFAAOCAgEAgaby0SqRUgxttiaafjOGhflQE9cBifpRuEpnGwPtNPRjQVIrmxulBJwR
1lQ73wdeSGCpQp6sgWkVb7PtxlWBMp3/2rul89T9n+Ha1+uQU5c3EsY/vsq7IMGQk/UHoSBOk44m
w6sZZjEcWOHWd1mKTjdmuT/weqW/DYOgHdHstHs7hZzKUegFiRafsgI4piyryW+1DLJ3G5gFc0QE
tp1tLjaRDDZifh7Atwci+9maq3hS2k/Fl925IDBaBpe0Oeq+dIqaZXwkv4qps4HAzzyYuFVdrMEV
MUPL6DVmdp5pvwTNT2JeRsjzAm2vrXjgS08ZmDOGkGFcxeqzMPEIsbRNqR0QoEPrOdFrLrcZRWRy
h5r8KUtmzXsv0gf3rGmBLohEBPGiMChyB0vDJ4BfbhYhgAHIFmz7Jlv9TI72+kKv7KDT1nslwpkp
h/wqwF3DftIL6WAHtwQOGt+FonslRS+8FmHL2oKvks9KR9UIdlyVaUaSqq9bIGDObHcU0M9D+akV
Sc+lobfBj4mAnG/bECyjPU0k5XkXr1Jf5OA4XwHkDNJqn2N5xyhizp2cs0Llm2eygUXEcYr5KJHT
r24jaVYn3jYkdMpa4B0R7mSOv48S3dASPPnkhA2ptgb4cuzwnCE7EnlegsUmWOUjORtK5pvrIOgV
3j1s7QqPJnsYHhvfpOMxggMPMIIDCwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZl
cmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBW
LjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBD
QQIMInXz/An98rT9jV6+MA0GCWCGSAFlAwQCAQUAoIIBQTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMjEwMTcxMTI0MDVaMC8GCSqGSIb3DQEJBDEiBCAOma8Z8b1P
C9Qh6VVf8yFQIJ3D6FrGgnEoOfB8sWAzkDBpBgkrBgEEAYI3EAQxXDBaMEYxCzAJBgNVBAYTAk5M
MRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0
AhBIFfgKJorZshmvxFG7UEwSMGsGCyqGSIb3DQEJEAILMVygWjBGMQswCQYDVQQGEwJOTDEZMBcG
A1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNAIQSBX4
CiaK2bIZr8RRu1BMEjANBgkqhkiG9w0BAQsFAASCAQCuB9Fb/FOL/d0wMT368QvF6jwuY5GBw9Ki
1BTEAh9bemshLccKXOge5M8xPtjxVIoJ42craiQB0CRZBjwG2ds7YGwBbcVCmraF4N4HT1/r4u8Z
CxoK1qtyOayhkohZOXJntmMvbY4t8Mk3mqRyZhKI4ukc2iMTUxTfcAlz6OLkkQGTig8UHW1rW+ie
AQApgsui1gtzeTJrGkQzRj0hNa6XxIjMZ37NaSZAJM9y3kL8ck8XubYJRWAqASU5aZWjZAZNE3kD
GFUj/xq1hib1SdtL+bbi1AQhPmWKGCJZifrSrPVJv5p6lkIVVOoEukNRwytBK6/CHPRDGDG1POrJ
2rfkAAAAAAAA
--Apple-Mail-8FD3FA5E-9D28-473C-9D8B-7674EEA8B303--
