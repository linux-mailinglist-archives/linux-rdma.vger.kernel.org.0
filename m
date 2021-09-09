Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE04047FE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhIIJq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhIIJq7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 05:46:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC7C061575
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 02:45:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z19so1808182edi.9
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdu/RZ/M0AjBXPrfbbgOuwzAAuo2DtSE3QbKPHjsg4c=;
        b=SSKL0mfJeeA8Sx430dOcXjbUSv6RJ5P5eGliYxNeC1viEyyHKiXMIG4et3UUUhRAZv
         Uffuil1izdajfOyfKQ7VYVJsNwLaEH4nXjxkWJsFPzYEyMcSZuExjqInC9XO3Cio0Cbd
         +BV23IxHN1OcYt4wR0Ot04PoaA/waZnDCwXaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdu/RZ/M0AjBXPrfbbgOuwzAAuo2DtSE3QbKPHjsg4c=;
        b=6C/3sqJO1vBfS3LS7IXvULGx6icMIBz8O178jxYznQ4O8V9/glawcxs/ITgmxg+RLw
         0XddFufKNQ0IcHtSZnu0esGdhk463PXBJvbxxwGdWN8hUB1K5mhtYgO1FJ5Ao6W3q+X9
         VhhxwaeRRrGrTfP9X2Y1TGuB/peRY+DgAQ9vAzc2mW8LCQzo3Vp5rgj93rJ6ZvBplAA6
         ZATBff3E9J43+zjYXTtBzRmHw2wIb13jp3BNnRcoEj6Htn29jGlC/gp8GwmwyEjrZRkt
         xk6LNB3oalft1vARAxpwCwpappzctc/MzfQhDoqt4T75KE0hdy++MvJgv2NaZaTIz9T4
         ZL0g==
X-Gm-Message-State: AOAM530lgNTQb2R5/HAw5peBdYAl66UILEKV36ANybmhrvA8CYKUFUc2
        rRVDv0Ef6VmCErZOY12KIpXA0HkAXBv9GYcZX93RSQ==
X-Google-Smtp-Source: ABdhPJyVD9WuIHFcbibk6a+qBlVjShExtlOsLaYIc6fIp5xazOjR4LkmAeQHLTTBH4rvVu7WUSM3ykrwB6AM/ecmhYw=
X-Received: by 2002:aa7:c884:: with SMTP id p4mr2175075eds.203.1631180747738;
 Thu, 09 Sep 2021 02:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210908155145.GA867184@bjorn-Precision-5520> <978872c2-f2c7-dcc3-14d5-799755cf0726@amd.com>
 <DM6PR12MB5534AE1A9B6EF22D44F651BDF4D49@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB5534AE1A9B6EF22D44F651BDF4D49@DM6PR12MB5534.namprd12.prod.outlook.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 9 Sep 2021 15:15:36 +0530
Message-ID: <CA+sbYW0JaQhs545BNXTTDPS5CB8+NSvUVY-heG0P+oZY2Caomg@mail.gmail.com>
Subject: Re: crash observed with pci_enable_atomic_ops_to_root on VF devices.
To:     "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "Cornwall, Jay" <Jay.Cornwall@amd.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000f52a605cb8cdd41"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000000f52a605cb8cdd41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 8, 2021 at 11:27 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Yes , according to  the spec the  AtomicOpsCtl bit is reserved in VF whic=
h means driver shouldn't touch it .  The thing confused us is PF value appl=
ies to all associate VFs. we actually did some experiment try to read it in
> VF and want to use it to check whether the atomicOps is enabled ,we found=
 that read the AtomicOpsCtl will always return 0 in Vf  although  PF alread=
y set it.  We also verified the KFDTest.atomic test passed in VF when the  =
PF enabled the atomicOps.  So we  think the VF already applied the setting =
but the valuer can't be read .
>
> I'm preparing a change that for SRIOV setup, the guest driver will not tr=
y to enable the atomicOps, it will try to get the enable information from h=
ost  either through private communication channel or  data exchange region =
between  host and guest.  Host driver (for  the PF) will try to enable the =
atomicOps with the pci_enable_atomic_ops_to_root  on KVM or implement the s=
imilar functionality if the host OS doesn't support this.
>
> Regards
> shaoyun.liu
>
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Wednesday, September 8, 2021 12:03 PM
> To: Bjorn Helgaas <helgaas@kernel.org>; Selvin Xavier <selvin.xavier@broa=
dcom.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: linux-pci@vger.kernel.org; linux-rdma@vger.kernel.org; Jason Gunthorp=
e <jgg@ziepe.ca>; Doug Ledford <dledford@redhat.com>; Andrew Gospodarek <an=
drew.gospodarek@broadcom.com>; Michael Chan <michael.chan@broadcom.com>; De=
vesh Sharma <devesh.sharma@broadcom.com>; Cornwall, Jay <Jay.Cornwall@amd.c=
om>
> Subject: Re: crash observed with pci_enable_atomic_ops_to_root on VF devi=
ces.
>
> Am 2021-09-08 um 11:51 a.m. schrieb Bjorn Helgaas:
> > [+cc Devesh, Jay, Felix]
> >
> > On Wed, Sep 01, 2021 at 06:41:50PM +0530, Selvin Xavier wrote:
> >> Hi all,
> >>
> >> A recent patch merged to 5.14 in the Broadcom RDMA driver  to call
> >> pci_enable_atomic_ops_to_root crashes the host while creating VFs.
> >> The crash is seen when pci_enable_atomic_ops_to_root is called with a
> >> VF pci device.  pdev->bus->self is NULL.  Is this expected for VF?
> > Sorry I missed this before.  I think you're referring to 35f5ace5dea4
> > ("RDMA/bnxt_re: Enable global atomic ops if platform supports") [1],
> > so I cc'd Devesh (the author).
yes.. this is the patch that exposed this issue. Devesh's mail id is
not valid now. so removing it from cc.
> >
> > It *is* expected that virtual buses added for SR-IOV have
> > bus->self =3D=3D NULL, but I don't think adding a check for that is
> > sufficient.
> >
> > The AtomicOp Requester Enable bit is in the Device Control 2 register,
> > and per PCIe r5.0, sec 9.3.5.10, it is reserved in VFs and the PF
> > value applies to all associated VFs.
> >
> > pci_enable_atomic_ops_to_root() does not appear to take that into
> > account, so I also cc'd Jay and Felix, the authors of 430a23689dea
> > ("PCI: Add pci_enable_atomic_ops_to_root()") [2].
> >
> > It looks like we need to enable AtomicOps in the *PF*, not in the VF.
> > Maybe that means pci_enable_atomic_ops_to_root() should return failure
> > when called on a VF, and it should be up to the driver to call it on
> > the PF instead?  I'm not an expert on how VFs are used, but I don't
> > like the idea of device B reaching out to change the configuration of
> > device A, especially when the change also affects devices C, D, E, ...
>
> Interesting timing. [+Shaoyun] is just working on SR-IOV problems with at=
omic operations these days.
>
> I think it makes sense for pci_enable_atomic_ops_to_root to fail on VFs.
> The guest driver either has to work without atomic ops, or it has to rely=
 on side-band information from the host (PF) driver to know whether atomic =
ops are available.
>
> Regards,
>   Felix
>
>
> >
> > Bjorn

Thank you all for the response and confirmation. So the conclusion is
to have a patch which fails pci_enable_atomic_ops_to_root for VFs. Let
me post a patch. Let me know if anyone is  working on the same patch.

Thanks,
Selvin
> >
> > [1] https://git.kernel.org/linus/35f5ace5dea4
> > [2] https://git.kernel.org/linus/430a23689dea
> >
> >> Here is the stack trace for your reference.
> >> crash> bt
> >> PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
> >>  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
> >>  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
> >>  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
> >>  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
> >>  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
> >>  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
> >>  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
> >>     [exception RIP: pcie_capability_read_dword+28]
> >>     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
> >>     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 000000000000000=
0
> >>     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 000000000000000=
0
> >>     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f=
8
> >>     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab00=
0
> >>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c=
8
> >>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >>  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at
> >> ffffffffb95359a6
> >>  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at
> >> ffffffffc08c1a33 [bnxt_re]
> >>  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
> >> #10 [ffff9a9481713a78] bnxt_re_netdev_event at ffffffffc08bab8f
> >> [bnxt_re]
> >> #11 [ffff9a9481713aa8] raw_notifier_call_chain at ffffffffb9102cbe
> >> #12 [ffff9a9481713ad0] register_netdevice at ffffffffb9803ff3
> >> #13 [ffff9a9481713b08] register_netdev at ffffffffb980410a
> >> #14 [ffff9a9481713b18] bnxt_init_one at ffffffffc0349572 [bnxt_en]
> >> #15 [ffff9a9481713b70] local_pci_probe at ffffffffb953b92f
> >> #16 [ffff9a9481713ba0] pci_device_probe at ffffffffb953cf8f
> >> #17 [ffff9a9481713be8] really_probe at ffffffffb9659619
> >> #18 [ffff9a9481713c08] __driver_probe_device at ffffffffb96598fb
> >> #19 [ffff9a9481713c28] driver_probe_device at ffffffffb965998f
> >> #20 [ffff9a9481713c48] __device_attach_driver at ffffffffb9659cd2
> >> #21 [ffff9a9481713c70] bus_for_each_drv at ffffffffb9657307
> >> #22 [ffff9a9481713ca8] __device_attach at ffffffffb96593e0
> >> #23 [ffff9a9481713ce8] pci_bus_add_device at ffffffffb9530b7a
> >> #24 [ffff9a9481713d00] pci_iov_add_virtfn at ffffffffb955b1ca
> >> #25 [ffff9a9481713d40] sriov_enable at ffffffffb955b54b
> >> #26 [ffff9a9481713d90] bnxt_sriov_configure at ffffffffc034d913
> >> [bnxt_en]
> >> #27 [ffff9a9481713dd8] sriov_numvfs_store at ffffffffb955acb4
> >> #28 [ffff9a9481713e10] kernfs_fop_write_iter at ffffffffb93f09ad
> >> #29 [ffff9a9481713e48] new_sync_write at ffffffffb933b82c
> >> #30 [ffff9a9481713ed0] vfs_write at ffffffffb933db64
> >> #31 [ffff9a9481713f00] ksys_write at ffffffffb933dd99
> >> #32 [ffff9a9481713f38] do_syscall_64 at ffffffffb9a07897
> >> #33 [ffff9a9481713f50] entry_SYSCALL_64_after_hwframe at ffffffffb9c00=
07c
> >>     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
> >>     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f64=
8
> >>     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 000000000000000=
1
> >>     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c258=
0
> >>     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e=
0
> >>     R13: 0000000000000002  R14: 00007f45062fd880  R15: 000000000000000=
2
> >>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> >>
> >> Please suggest a fix for solving this issue. Is adding a NULL check
> >> for bus->self sounds okay?
> >>
> >> Thanks,
> >> Selvin

--0000000000000f52a605cb8cdd41
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
Agxea+GNYSvtMZZyJzwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFaI2h/J0JRb
4JrlC0AKgsrnBkgMzS5yay/g576Zejt4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDkwOTA5NDU0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAc/iOrK1H4nXgCt3607CL9T13t9kKY
6VjvMOJxYfn4G1YCvoCsrLJwsHgaNvn0c0w7qU8r0AmGWE6qts1gj9vApXxmn8GMGeh5E2gMU61x
J9H5oYSoN1FL1+2Nrrtw0OFEMPS9ubKex/KGOmn9W9h9PK8mBTW9m8W8lQph6GMu268ALkLMAEkM
ISZZjxOnsRC7OGgT0c59yFQD6aR8jV8vo+YKV8UpC9q0lVk8N021RvT0z1qhvEKe6Kl4k5woyD9Z
bXxLMTswvKuwSL09cAJYyLR+3NNKDizzsKDoWv4i5Ra7NTLFkJ80V96dU5GaUHaaMAIaugXo2u9d
Wv0F1Uod
--0000000000000f52a605cb8cdd41--
