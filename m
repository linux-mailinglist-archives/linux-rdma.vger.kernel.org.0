Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA740DD8E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhIPPHP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhIPPHO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 11:07:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE09C061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:05:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c22so18002795edn.12
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJnCavhowP/p+nS5hk4Q9AneZDB9AlGoWFI+WBn67HM=;
        b=OK83LxVZGWztRHJ+SNAKqI+r5S+mFyDqzqwf1le6OT/7czngU1WHnwYtUNhyqFJ1D8
         0BRDyDOPC2nLbrCFXz5imPZFT91cw0r1di9FcFw6/JtylU/0DSYXCY98NN/l4vyacneM
         5s0O/LSe5LWx89R5i3v8BB7VumDrkKzzbSniE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJnCavhowP/p+nS5hk4Q9AneZDB9AlGoWFI+WBn67HM=;
        b=xvpdPRBgeMTM9H5V/orvMiDYOzAsLxmb3rZj7z5whmwC9ZgCsBjJipVnNkluvJS1nH
         HCF2uhnk4hG34FfYVLZ4jUpyRrgjyIe9Iq61JCPTyi8ChSqYHbc36gOUm4J4W5DYBP82
         Jdc/jk8upaHABaILyjLZkgAAylciOUBNljCAX9hLzmgSCJ7rDFs/kF5lsLgkA+RXXMch
         sBF3OlZX2YIlLLXkGmdJWCPGav/yNj1UZi51sZ8Agf95RDQQf/nUa7xgOELvWMUiXDRx
         VxrzTmwprXbH+bIfnJdSm666nKkoubiD1YvOnztU5yHj3dK1lY1+GDwQNPGeHSwsQGYZ
         tdIA==
X-Gm-Message-State: AOAM530REksDYGBW50O8EbiqmktgpWQFXCHtVAX2fykjtFnTlwitS4/j
        WXcLB56ydQDQ6BxCrKvf41n/dcf3pb69PQYCvLLvyQ==
X-Google-Smtp-Source: ABdhPJz3c9rbAVjJhKISaxx/2mVMdvUlaNvNYR12/4xqkCP96AeQ9P7G3hIW1yDgxLFhJFViD6bkWeVkDT0Pf95HBgA=
X-Received: by 2002:a17:907:77d0:: with SMTP id kz16mr6898375ejc.334.1631804748247;
 Thu, 16 Sep 2021 08:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <1630037738-20276-1-git-send-email-selvin.xavier@broadcom.com>
 <20210827123146.GH1200268@ziepe.ca> <CA+sbYW1GoGu_U1c_zKEbXyqgK-t+Mwe1aaFY1vsH1T0QCj6KAA@mail.gmail.com>
 <20210901115016.GQ1200268@ziepe.ca>
In-Reply-To: <20210901115016.GQ1200268@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 16 Sep 2021 20:35:37 +0530
Message-ID: <CA+sbYW1uhvNFjwK27UarY-KPA=tLSMVeGXzcD4i8aWnqeGsUiQ@mail.gmail.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Disable atomic support on VFs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000062e02605cc1e26fc"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000062e02605cc1e26fc
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 1, 2021 at 5:20 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Aug 31, 2021 at 09:27:14PM +0530, Selvin Xavier wrote:
> > On Fri, Aug 27, 2021 at 6:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Aug 26, 2021 at 09:15:38PM -0700, Selvin Xavier wrote:
> > > > Following Host crash is observed when pci_enable_atomic_ops_to_root
> > > > is called with VF PCI device.
> > > >
> > > > PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
> > > >  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
> > > >  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
> > > >  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
> > > >  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
> > > >  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
> > > >  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
> > > >  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
> > > >     [exception RIP: pcie_capability_read_dword+28]
> > > >     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
> > > >     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
> > > >     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
> > > >     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
> > > >     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
> > > >     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
> > > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > > >  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
> > > >  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at ffffffffc08c1a33 [bnxt_re]
> > > >  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
> > > >     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
> > > >     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
> > > >     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
> > > >     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
> > > >     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
> > > >     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
> > > >     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> > >
> > Apologies for the delay in my response.  I was exploring internally to
> > see if it is a specific issue
> > with the adapter/host. I see the problem in multiple systems.
> >
> > > This feels like a bug in pci_enable_atomic_ops_to_root()? I assume it
> > > hit a case where bus->self == NULL?
> > yes. This crashes because of bus->self is NULL. Is it expected for VF?
>
> I'm not sure, you should ask the PCI lists
>
> > > Why not fix it there?
> > Since its a functional breakage in 5.14, I posted a quick fix for
> > 5.14. Also, we haven't done any testing on VF for this
> > feature. So I wanted to avoid claiming support for VF anyway.
> >
> > I see that other drivers also use pci_enable_atomic_ops_to_root
> > without vf/pf check. Anyone seeing this issue?
>
> Which is why I suspect the core code should be fixed not the driver..
Hi Jason,
A patch that avoids the crash is merged to the linux-pci tree.
https://lore.kernel.org/linux-pci/20210914201606.GA1452219@bjorn-Precision-5520/T/
With the pci patch, the host will not crash. But driver will get
following error message when called for VF
""platform doesn't support global atomics."

we want to prevent calling pci_enable_atomic_ops_to_root for VF
anyway. Can you please pull this patch in bnxt_re?

Thanks
Selvin

>
> Jason

--00000000000062e02605cc1e26fc
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
Agxea+GNYSvtMZZyJzwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGsGxtikCcZl
CvVQ7eQVVObGLiJ8flwbVB6nWItYL0pEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDkxNjE1MDU0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCtK5KU4Otqkqnr21O+egN0S6HSv5U4
25yNncdZgBpNcnPNAJXkUEqY5i0iHkkdTn0j2GV+qajA75ATErKFImjB7SFL8WG1K+EnMI4kfEGo
DGzCRWAdnYkrkbHKQpv/dpNoyAnrVfYzYfgvywR9uezmTFxfPCCZrJOcQq5oTo9Gticiwq1jDG6u
bjN0c6GdMXRUNwBlLjfu7F6G1d/4UiZxzZ6zKo/NCFUH5CoDFQvOiGDN7OPHG1IID3mpQlgxXuCH
nKkWmhNk1l6ye9jsrnhtViBohveCBG3hCQDFKgkpUR5WS8T1J/0wgOSEKDKtTsk8duz29HHfTNFf
6YBsx/Tb
--00000000000062e02605cc1e26fc--
