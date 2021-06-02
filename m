Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D9398D48
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhFBOln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 10:41:43 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:34656 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBOlm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 10:41:42 -0400
Received: by mail-qk1-f169.google.com with SMTP id k11so919577qkk.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Jun 2021 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wh6K/Mn0WGC+J5bbAh1+sP6JHZj6xyy49SIGSkJqwGc=;
        b=F0fhnAG61v1+jM7hSbyo5r0acmocnri6zgOi9PPWnX8X4EnekANeDValYBgkHmf3EQ
         uPJA0KH41gSn12g6NXOypa60NR7QFUCqTuninuVVMKXg6LUpX+0H93NAMC1ef1+XZuPn
         uQ3rx4BdL80TLMcgXL+Fyw4lU3olNQR9R3e1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wh6K/Mn0WGC+J5bbAh1+sP6JHZj6xyy49SIGSkJqwGc=;
        b=NNGQ5gui9FLXJmFRL0N/XcWJ6CHhjAdMaORyusllo0/4FwEw/uDY/4eBtLxmvMCMlS
         U83NkNpno0Af2IIRcIfllTleB3fA7JxDQn5DPG7gytuB/FBPeSnOIl42NXMIWg5ZYhFj
         wem25pLPO5ZNsRZLd3bjMiyHCa8+1FpnodXYPzhZ1DJYWiMXOs5i2ZJBN94TMsqXt63P
         x6q32EY/AR7UucjoDpkk5lxvfuhGFXbHzc6YjqiAznMw/xmpNd++g6AA2eZA1bjBB+AA
         0QMk273/6hLUGPFRiwPHbqu/W6ieEzlf0ttvgHaUbkv1wyiFBb1YB0f6cIdqLu5SQmA5
         fLBQ==
X-Gm-Message-State: AOAM5314Y/IioV6nGLi4Noc2jExoovyH7xCzpZa/oVzJ8mHMsRvCXjDa
        MZ8dBAVi5QJG0dhqMuJjurpjYxCSCChSIqrIGjPOC/82vws=
X-Google-Smtp-Source: ABdhPJzzJVGdEuopn474e6iSgznMbqEo1JBZe3IOFSkLycJd010aHo1asqchrfO/LFpm7lsA4XLG7cilmJCW1DXsT7w=
X-Received: by 2002:a05:620a:139a:: with SMTP id k26mr16995943qki.169.1622644738871;
 Wed, 02 Jun 2021 07:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210602042839.968833-1-devesh.sharma@broadcom.com>
 <20210602042839.968833-2-devesh.sharma@broadcom.com> <YLd+AzGd2NhnVas6@unreal>
In-Reply-To: <YLd+AzGd2NhnVas6@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 2 Jun 2021 20:08:22 +0530
Message-ID: <CANjDDBjXhd_9u_ihaSaxSWsLRgmCLiwMbV9FOxyNHXQm8bVe5g@mail.gmail.com>
Subject: Re: [PATCH V4 for-next 1/3] RDMA/bnxt_re: Enable global atomic ops if
 platform supports
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004c75e005c3c96b0b"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000004c75e005c3c96b0b
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 2, 2021 at 6:18 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jun 02, 2021 at 09:58:37AM +0530, Devesh Sharma wrote:
> > Enabling Atomic operations for Gen P5 devices if the underlying
> > platform supports global atomic ops.
> >
> > Fixes:7ff662b76167 ("Disable atomic capability on bnxt_re adapters")
>        ^^^ space here
Oh! rev.
>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++++
> >  drivers/infiniband/hw/bnxt_re/main.c      |  3 +++
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 +++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 13 ++++++++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 --
> >  6 files changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index 537471ffaa79..a113d8d9e9ed 100644
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
> > index b090dfa4f4cb..0de4e22f9750 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -128,6 +128,9 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
> >       rdev->rcfw.res = &rdev->qplib_res;
> >
> >       bnxt_re_set_drv_mode(rdev, wqe_mode);
> > +     if (bnxt_qplib_determine_atomics(en_dev->pdev))
> > +             ibdev_info(&rdev->ibdev,
> > +                        "platform doesn't support global atomics.");
> >       return 0;
> >  }
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > index 3ca47004b752..d722ca5cd464 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > @@ -959,3 +959,20 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
> >       bnxt_qplib_free_res(res);
> >       return rc;
> >  }
> > +
> > +bool bnxt_qplib_determine_atomics(struct pci_dev *dev)
> > +{
> > +     int comp;
> > +     u16 ctl2;
> > +
> > +     comp = pci_enable_atomic_ops_to_root(dev,
> > +                                          PCI_EXP_DEVCAP2_ATOMIC_COMP32);
> > +     if (comp)
> > +             return -ENOTSUPP;
> > +     comp = pci_enable_atomic_ops_to_root(dev,
> > +                                          PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> > +     if (comp)
> > +             return -ENOTSUPP;
> > +     pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctl2);
> > +     return !(ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
> > +}
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > index 7a1ab38b95da..fb7fde4fed56 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > @@ -373,6 +373,7 @@ void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
> >  int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
> >                        struct bnxt_qplib_ctx *ctx,
> >                        bool virt_fn, bool is_p5);
> > +bool bnxt_qplib_determine_atomics(struct pci_dev *dev);
> >
> >  static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_hwq *hwq, u32 cnt)
> >  {
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > index 049b3576302b..57407be16f27 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > @@ -54,6 +54,17 @@ const struct bnxt_qplib_gid bnxt_qplib_gid_zero = {{ 0, 0, 0, 0, 0, 0, 0, 0,
> >
> >  /* Device */
> >
> > +static u8 bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
> > +{
> > +     u16 pcie_ctl2 = 0;
> > +
> > +     if (!bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
> > +             return false;
> > +
> > +     pcie_capability_read_word(rcfw->pdev, PCI_EXP_DEVCTL2, &pcie_ctl2);
> > +     return (pcie_ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
> > +}
> > +
> >  static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
> >                                    char *fw_ver)
> >  {
> > @@ -162,7 +173,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
> >               attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
> >       }
> >
> > -     attr->is_atomic = false;
> > +     attr->is_atomic = bnxt_qplib_is_atomic_cap(rcfw);
> >  bail:
> >       bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
> >       return rc;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > index bc228340684f..260104783691 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > @@ -42,8 +42,6 @@
> >
> >  #define BNXT_QPLIB_RESERVED_QP_WRS   128
> >
> > -#define PCI_EXP_DEVCTL2_ATOMIC_REQ      0x0040
> > -
> >  struct bnxt_qplib_dev_attr {
> >  #define FW_VER_ARR_LEN                       4
> >       u8                              fw_ver[FW_VER_ARR_LEN];
> > --
> > 2.25.1
> >
>
>


-- 
-Regards
Devesh

--0000000000004c75e005c3c96b0b
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ2E31khLVXAnbSIde2hVYcUclkF
0HsYMUCbXub+EKBoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYwMjE0Mzg1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAB3QmwGQxgE0ExR3qslqI1CGDdMCzZix5QiBRGTPVXnHLo
r3mm5ExK4xuKdyQOD4F8oqYn+Dc+sBRP/jkjVxj9irCPv348rMm2/DrEOixpzyQf8Y9KEk7ss1ti
Tq84EPbOPfD1Jo10HfJa8VlUYV/JQ4uZZmMj+txgx6A7QcT/MDP3xrS4itvGcHiHJtbb7VRHVF2l
pP5Cy/Bf4JgwlRykvIX/wgHs6GqMAQ9ozafEI/4EyP9XDmzvwzNMsdVRTtG2xByTYNHZTkVs+Egd
BJoWXD9UzM32ooj7TEQj3vziXANpDJzu9We/RE0wmFl07N2E2G3cICmvuaErHrRp7BUS
--0000000000004c75e005c3c96b0b--
