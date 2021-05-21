Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8438C718
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhEUMwt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhEUMwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 08:52:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A22C06138B
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 05:51:13 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f18so19532038qko.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YfQDLXkaDwh6cSlMdDiJOsm8edC8NDa9W7Ju9LW/6A=;
        b=JIwpvg/3CfRIbhT6AQXVYZJgoC8EMYs5hBPyz+ogqDhANBPNFfK/FYASsfWaF0nSoW
         /tgPZ/SAjt3nYFwKSvJkQXAgHTcsNpWb6iHXWIfgRPSQdlPPXgOgSyTiY5DkgfC80IPS
         4OnmNON5FgVayUFBm9IO6kOAbNJ0qXqbqqeHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YfQDLXkaDwh6cSlMdDiJOsm8edC8NDa9W7Ju9LW/6A=;
        b=Vdb2VYivZ0knbllGB+Lqxzr19NWTfj2SPDwUKu7eFhh2oApqfR8xZCjcgBuQ2ioGxC
         rVi5rsFd/AJZycFxQIgXuweD633l7/L8MjIGzzg9hz4xN4RfU5pc/EGSY+L/5/ezDRlA
         TQVvdEeYmZgorwhR6cNhd7gmS1r/GXgMt4lOuQfdDk3BosE2+Z82P/S/s2792ropOEwS
         CAaBgXoyVPCkGxkyO/SS0lZue+6boA//ZBTS+VNMXzP6ZycBac2xadKYuHZ8aHrhS4pO
         qPWGHGc9rQMT6qeqjrZCwIaNTPZxHeD+bi8NFnWOw8/+cZnVu7uQswq6QbrWYJvcyrfp
         aWlA==
X-Gm-Message-State: AOAM5301vLY2MWUZaW01hxptMMh6CFaCczKZ9rkDAQQDKkjYgwt4oP6E
        uSQ8u4ZmXPHireuiphnUPD1C0TgJOOrSy8ziz7fA/A==
X-Google-Smtp-Source: ABdhPJzbj3r1kQgaA2maUtvHuwsUmdjBmAiDo6F+1JYre1mYrYJnDTT1JKHMgLLR0fJPKda9bAvR/Vl/6iYvjaZ6LxM=
X-Received: by 2002:a37:b585:: with SMTP id e127mr12608097qkf.405.1621601471709;
 Fri, 21 May 2021 05:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210517132522.774762-1-devesh.sharma@broadcom.com>
 <20210517132522.774762-2-devesh.sharma@broadcom.com> <YKYUyPOfeER2FVGD@unreal>
In-Reply-To: <YKYUyPOfeER2FVGD@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Fri, 21 May 2021 18:20:35 +0530
Message-ID: <CANjDDBh+GOvpLMEDHToZqVf3OfKOTqjg8bDW5vvVs1_dc5bgvg@mail.gmail.com>
Subject: Re: [for-next 1/2] RDMA/bnxt_re: Enable global atomic ops if platform supports
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bdc60a05c2d683fc"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000bdc60a05c2d683fc
Content-Type: text/plain; charset="UTF-8"

On Thu, May 20, 2021 at 1:20 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 17, 2021 at 06:55:21PM +0530, Devesh Sharma wrote:
> > Enabling Atomic operations for Gen P5 devices if the underlying
> > platform supports global atomic ops.
> >
> > Fixes:7ff662b76167 ("Disable atomic capability on bnxt_re adapters")
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++++
> >  drivers/infiniband/hw/bnxt_re/main.c      |  4 ++++
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 15 +++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 13 ++++++++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 --
> >  6 files changed, 36 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index 2efaa80bfbd2..8194ac52a484 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -163,6 +163,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
> >       ib_attr->max_qp_init_rd_atom = dev_attr->max_qp_init_rd_atom;
> >       ib_attr->atomic_cap = IB_ATOMIC_NONE;
> >       ib_attr->masked_atomic_cap = IB_ATOMIC_NONE;
> > +     if (dev_attr->is_atomic) {
> > +             ib_attr->atomic_cap = IB_ATOMIC_GLOB;
> > +             ib_attr->masked_atomic_cap = IB_ATOMIC_GLOB;
> > +     }
> >
> >       ib_attr->max_ee_rd_atom = 0;
> >       ib_attr->max_res_rd_atom = 0;
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > index 8bfbf0231a9e..e91e987b7861 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -128,6 +128,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
> >       rdev->rcfw.res = &rdev->qplib_res;
> >
> >       bnxt_re_set_drv_mode(rdev, wqe_mode);
> > +     if (bnxt_qplib_enable_atomic_ops_to_root(en_dev->pdev))
> > +             ibdev_info(&rdev->ibdev,
> > +                        "platform doesn't support global atomics.");
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > index 3ca47004b752..d2efb295e0f6 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > @@ -959,3 +959,18 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
> >       bnxt_qplib_free_res(res);
> >       return rc;
> >  }
> > +
> > +bool bnxt_qplib_enable_atomic_ops_to_root(struct pci_dev *dev)
>
> Why do you need open-coded variant of pci_enable_atomic_ops_to_root()?
That function is trying to write on the device after determination. I
can rename to something else to avoid partial namespace collision, not
a problem
>
> Thanks



-- 
-Regards
Devesh

--000000000000bdc60a05c2d683fc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICAGE6ZYPNyiR5TPts+KJTvV88wl
o8IaJJ/SK5YsdD6RMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUyMTEyNTExMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB0bRpBAd31zKlB/Xp3CmRoOJnWaV0dS6TixiJL57slfFG5
qpuLUYoDrhvo6sTqhz30+aqWKm6SdDEKOXMC1b6HV1wQXFVn0X6crw0C4AL8yMAxeGLAS09kroIq
jvCmH4chBEW8zCGCN3Q7DhrLhP132nhoudssIPcaW4ZRFeEWOrD8xcqQ10DbhEZx4UTWTbJK0Pbj
npHVcHQrqKJtVeXN+l14Ce74ZIR+cIYhwORqQXcMyzka7LRWnu7DZ9rlFD+ojUw84d9c2BbG0R18
4eaQTOKnZrShke1z+OwdFHEEciBWQ/rD+lS2u6/0QkHGd9SA8o1pNIBZ6n/vExVTi5wX
--000000000000bdc60a05c2d683fc--
