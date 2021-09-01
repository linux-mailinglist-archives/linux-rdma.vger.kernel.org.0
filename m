Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E73FDD13
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhIANNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhIANM7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 09:12:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0614C061575
        for <linux-rdma@vger.kernel.org>; Wed,  1 Sep 2021 06:12:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id me10so6477344ejb.11
        for <linux-rdma@vger.kernel.org>; Wed, 01 Sep 2021 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WEjxg5dLfxaBKIKQAIb/FlHjM6B0aUBLlKHRSn1CClQ=;
        b=R06EDLF9dyl06Tuf2chVnZcdF6W0ZcAuPJZLRkRpLXPMpze12Gdeac7K8vBMZemtXj
         SyeaD/pYe1i9/8szp6lBwrf5n8j7Ble/yVD2pb1uVjjV+pNLV1WFOjdbeF+NuVWPZMB3
         bKzbwOUSM9RF8YblLGjj/B+jZveclw0IvDgTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WEjxg5dLfxaBKIKQAIb/FlHjM6B0aUBLlKHRSn1CClQ=;
        b=MDlL8iBG+OWN7TZ1nALyZ6I2zKgZMHVlqdsKumDxZyXu+xo2wZ1gkC69XJAChpTZQi
         FSQzVte4WfuqePKJPIHEQWkhQaCm2RImz09pLp2NaVOLG6hvtWwhWhhTWU1mPhm5x7AF
         Rg8TGs59VryclsD6lFiEjbEzYb3pzvIuSbwWV3d5caGjrRrmzion3JcLxFMZ0mA4eTQM
         1g8b7Hbs8lUiQlqA2bZ1lIiGuKOubSq1CV0KBaUKfibBIZsLD2LFb1XvhlKFOfMDNVqt
         +EkV9wJoQD6q4ReJdJQdyH1Wf/mXGMu76lZLWtxGc3Q1qyI8qudx0KMjNmAp7j1qCYuT
         ykJQ==
X-Gm-Message-State: AOAM5331aX+v/sa96RiK1psMcJE+h1LecZFODHg51tF+Z6ZfeIZ0OvQO
        D540/ah1DBq6VlS9ytbyUxaFu3nI9dcUTNSx0BVduCjwG49jvQ==
X-Google-Smtp-Source: ABdhPJzkqXjf1vN90JlN3WmG2abyueQeQNTS8iwOkIkLabmy/9SIdFTn7NgCDUki/hBR2gOfrb2+1LZ/+ZF8kjolJv4=
X-Received: by 2002:a17:906:1146:: with SMTP id i6mr35866759eja.12.1630501921179;
 Wed, 01 Sep 2021 06:12:01 -0700 (PDT)
MIME-Version: 1.0
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 1 Sep 2021 18:41:50 +0530
Message-ID: <CA+sbYW1hjkCkOOKynC+fGCk+Qo4xHMkxakw21sPEtV27k9T+MA@mail.gmail.com>
Subject: crash observed with pci_enable_atomic_ops_to_root on VF devices.
To:     linux-pci@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d6e8e505caeecf8e"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000d6e8e505caeecf8e
Content-Type: text/plain; charset="UTF-8"

Hi all,

A recent patch merged to 5.14 in the Broadcom RDMA driver  to call
pci_enable_atomic_ops_to_root crashes the host while creating VFs. The
crash is seen when pci_enable_atomic_ops_to_root is called with
a VF pci device.  pdev->bus->self is NULL.  Is this expected for VF?

Here is the stack trace for your reference.
crash> bt
PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
 #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
 #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
 #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
 #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
 #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
 #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
 #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
    [exception RIP: pcie_capability_read_dword+28]
    RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
    RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
    RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
    RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
    R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
    R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
 #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at
ffffffffc08c1a33 [bnxt_re]
 #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
#10 [ffff9a9481713a78] bnxt_re_netdev_event at ffffffffc08bab8f [bnxt_re]
#11 [ffff9a9481713aa8] raw_notifier_call_chain at ffffffffb9102cbe
#12 [ffff9a9481713ad0] register_netdevice at ffffffffb9803ff3
#13 [ffff9a9481713b08] register_netdev at ffffffffb980410a
#14 [ffff9a9481713b18] bnxt_init_one at ffffffffc0349572 [bnxt_en]
#15 [ffff9a9481713b70] local_pci_probe at ffffffffb953b92f
#16 [ffff9a9481713ba0] pci_device_probe at ffffffffb953cf8f
#17 [ffff9a9481713be8] really_probe at ffffffffb9659619
#18 [ffff9a9481713c08] __driver_probe_device at ffffffffb96598fb
#19 [ffff9a9481713c28] driver_probe_device at ffffffffb965998f
#20 [ffff9a9481713c48] __device_attach_driver at ffffffffb9659cd2
#21 [ffff9a9481713c70] bus_for_each_drv at ffffffffb9657307
#22 [ffff9a9481713ca8] __device_attach at ffffffffb96593e0
#23 [ffff9a9481713ce8] pci_bus_add_device at ffffffffb9530b7a
#24 [ffff9a9481713d00] pci_iov_add_virtfn at ffffffffb955b1ca
#25 [ffff9a9481713d40] sriov_enable at ffffffffb955b54b
#26 [ffff9a9481713d90] bnxt_sriov_configure at ffffffffc034d913 [bnxt_en]
#27 [ffff9a9481713dd8] sriov_numvfs_store at ffffffffb955acb4
#28 [ffff9a9481713e10] kernfs_fop_write_iter at ffffffffb93f09ad
#29 [ffff9a9481713e48] new_sync_write at ffffffffb933b82c
#30 [ffff9a9481713ed0] vfs_write at ffffffffb933db64
#31 [ffff9a9481713f00] ksys_write at ffffffffb933dd99
#32 [ffff9a9481713f38] do_syscall_64 at ffffffffb9a07897
#33 [ffff9a9481713f50] entry_SYSCALL_64_after_hwframe at ffffffffb9c0007c
    RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
    RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
    RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
    R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
    R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

Please suggest a fix for solving this issue. Is adding a NULL check
for bus->self sounds okay?

Thanks,
Selvin

--000000000000d6e8e505caeecf8e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfAYJKoZIhvcNAQcCoIIQbTCCEGkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDF5r4Y1hK+0xlnInPDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxNDE4MjNaFw0yMjA5MjIxNDUxNDZaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxUvDzFRYD8BTJrAMQdCDuIfwWINjz4kZW2bdRd3xs/PuwwulZFR9
IqmPAgBjM5dcqFtbSHi+/g+LZBMw6k/LfLLK02KsorxgMOZVCIOVCuM4Nj0vrIwtMJ+fNnaa6Dvu
a85G89a0sBrN3Y6hDnOfpbimSOgwA82EFWkGY4VggzfB7w1rhwu515LAm0sN0WOsrGP7QI8ZJr8g
od7PzGNQ3SgTYKl5XslMq+gpy+K8+egxMxo3D07c8snwyfU7Y7NQ8I1M986gsj9RUcp3oo0N+T1W
rwVchQXTGD/Hwqc11XBU1H3JKSRkn7cTa9bMFnp0Asr3Y4/kB+4t6PhYi50ORwIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU6uPX
5eOTTGwUwIAAoXKF4qVZLfgwDQYJKoZIhvcNAQELBQADggEBAKAn7gHcWCrqvZPX7lw4FJEOMJ2s
cPoLqoiJLhVttehI3r8nFmNe5WanBDnClSbn1WMa5fHtttEjxZkHOFZqWLHYRI/hnXtVBjF9YV/1
Hs3HTO02pYpYyHue4CSXgBtj45ZVZ0FjQNxgoLFvJOq3iSsy/tS2uVH5Pe1AW495cxp8+p5b3VGe
HRzGet524jE0vZx0A/6qrYo6C7z4Djrt/QU2MZDbPb+kwkkomwcn0Nvr91KWSrbhhHtZ/EfXi08L
x3R3oHtWjbmIW1nYkwVk4pQZoaLkRWkfTSGpwDwilhrd2F+d5rhCbAbfACk4Oly51GV4SI7jUm0D
VbZWyuIx85gxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxea+GNYSvtMZZyJzwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMTBfRksFG3b
KJxmslG9mcn9xE8uTP8iRFGlR61foWSvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDkwMTEzMTIwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCugtDXnF1WouLbPVAH5ksUrfUen7LA
WEPZNGdojqdh5C780tbAOgVoIxoitAToG1am9ilbAqPKYxRhXo3ls6wl+iXb7qwnNbXq4wngs1xX
Yd7cNIXlDVzeiNVOm5d5U2bDL8eZQNCSFrOZfZaiy+ivQ/CskrzRdJ7E3nHDdZQcwaClojNbDQ/J
SEG3V0/i/utVhhVmRG2l1LTzsTsSCjTlYv82T3inIDD67mVByBvBXIktfR9H10w5cqpbSFzlsNL1
N7JO+Pm09MwKfMTdRKgkWFL5fnqk756A7U8RI0hIfQpUByjQBBf2ANlaqIKCeFiPqWXxkhpqFCV/
aVfOTWaw
--000000000000d6e8e505caeecf8e--
