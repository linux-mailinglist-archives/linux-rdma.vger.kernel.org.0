Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F483C3CD5
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jul 2021 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhGKNcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jul 2021 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhGKNcU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jul 2021 09:32:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5A6C0613DD
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 06:29:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id he13so27712975ejc.11
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hV8frZ7bqJyixxK27P2f5pMWYs4oyXk9Z+FvTBSjWHM=;
        b=A4I5c8H/8H06zVdx0YWuH+VEzLBYzjSLq+ofsJvAUHthUqgPzRpR0F8XsZmLKcSD8h
         AF9/liMtxamRem5qe27PvZpcP3YQe5+R+hQCrqHa2+4Zw/Sm+7VhADXl6vWF7apOsw2x
         oo+EeNF3NHN59F9XdVSprEk3pJfAxfA4Ko+n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hV8frZ7bqJyixxK27P2f5pMWYs4oyXk9Z+FvTBSjWHM=;
        b=ti8HBOqA0mPIHsNTkV/l1YjettvRhS3vLIuwYT6uUquhnletCdreiIPGqIu+oiSac8
         hbkWkkRzrRxvhHBm/hkaNrTuP2LcKgybQOd44SogYB2hIK8+CbLjm0ePjN63lSUy/F7l
         vMXGjINKsjnzABp/bBcsN5XxBt53UN65QP2puESr8XZ6m0upAHMhgXeqAt8aCZdM0/Pq
         9BB9ArDq4mvmmX5Ktb1MLsBVYkTypJnY233ftfEGuxjil6P6MNKfVgLbqSStf2fI4OYu
         cvWlaadDvI3ztP5MKX8NDv4tAKzX5Bjiypzawn+xcKtCbvXlPJyTvjCg1cOiSvMJ1Yb8
         /6Nw==
X-Gm-Message-State: AOAM533nARvJqta/jnQ+tCLMABVNlJ5Z4tpqRPmG+OdDeW21lMtnP6aB
        ZmAsaQ7bpnw9wXZ1m/OPj5zAeI/EP3JDWsqS1LuZPA==
X-Google-Smtp-Source: ABdhPJxFANveLv8v0pr4MjZeCIBKddiy+cr+SWFprY/n7Li+Wo388J1fOmW9uHEJQp1Wka2+NkU9LDTBQ3a5cO+zwEM=
X-Received: by 2002:a17:906:351b:: with SMTP id r27mr4623703eja.100.1626010172226;
 Sun, 11 Jul 2021 06:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <1625992490-5127-1-git-send-email-selvin.xavier@broadcom.com> <YOrdYGyJu/n6yWJ2@unreal>
In-Reply-To: <YOrdYGyJu/n6yWJ2@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Sun, 11 Jul 2021 18:59:20 +0530
Message-ID: <CA+sbYW3edsQO=UHfaXxeqhsxCLMLwNQLQZaZjUePqxBS8QqmWA@mail.gmail.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Fix stats counters
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bca52405c6d8fe7b"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000bca52405c6d8fe7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 11, 2021 at 5:30 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Jul 11, 2021 at 01:34:50AM -0700, Selvin Xavier wrote:
> > From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> >
> > Stats counters are not incrementing in some adapter versions
> > with newer FW. This is due to the stats context length mismatch
> > between FW and driver. Since L2 driver updates the length correctly,
> > use the stats length from L2 driver while allocating the DMA'able
> > memory and creating the stats context.
> >
> > Fixes:9d6b648c311(bnxt_en: Update firmware interface spec to 1.10.1.65)
>
> This is wrong fixes line.
>
> I recommend to add the line below to your gitaliases file
>         fixes =3D "!git --no-pager log --abbrev=3D12 -1 --format=3D'Fixes=
: %h (\"%s\")'"
>
> and it will give you nice git fixes command with ready to copy string:
> =E2=9E=9C  kernel git:(rdma-next) git fixes 9d6b648c311
> Fixes: 9d6b648c3112 ("bnxt_en: Update firmware interface spec to 1.10.1.6=
5.")
>
Posting a v2. thanks

>
> > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c      |  4 +++-
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 10 ++++------
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
> >  3 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index 04621ba..1fadca8 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -119,6 +119,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_de=
v *rdev, u8 wqe_mode)
> >       if (!chip_ctx)
> >               return -ENOMEM;
> >       chip_ctx->chip_num =3D bp->chip_num;
> > +     chip_ctx->hw_stats_size =3D bp->hw_ring_stats_size;
> >
> >       rdev->chip_ctx =3D chip_ctx;
> >       /* rest members to follow eventually */
> > @@ -507,6 +508,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_=
re_dev *rdev,
> >                                      dma_addr_t dma_map,
> >                                      u32 *fw_stats_ctx_id)
> >  {
> > +     struct bnxt_qplib_chip_ctx *chip_ctx =3D rdev->chip_ctx;
> >       struct hwrm_stat_ctx_alloc_output resp =3D {0};
> >       struct hwrm_stat_ctx_alloc_input req =3D {0};
> >       struct bnxt_en_dev *en_dev =3D rdev->en_dev;
> > @@ -523,7 +525,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_=
re_dev *rdev,
> >       bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_ALLOC, -1=
, -1);
> >       req.update_period_ms =3D cpu_to_le32(1000);
> >       req.stats_dma_addr =3D cpu_to_le64(dma_map);
> > -     req.stats_dma_length =3D cpu_to_le16(sizeof(struct ctx_hw_stats_e=
xt));
> > +     req.stats_dma_length =3D cpu_to_le16(chip_ctx->hw_stats_size);
> >       req.stat_ctx_flags =3D STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
> >       bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&=
resp,
> >                           sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infini=
band/hw/bnxt_re/qplib_res.c
> > index fa78783..72be4fb 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > @@ -56,6 +56,7 @@
> >  static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
> >                                     struct bnxt_qplib_stats *stats);
> >  static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
> > +                                   struct bnxt_qplib_chip_ctx *cctx,
> >                                     struct bnxt_qplib_stats *stats);
> >
> >  /* PBL */
> > @@ -559,7 +560,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res=
,
> >               goto fail;
> >  stats_alloc:
> >       /* Stats */
> > -     rc =3D bnxt_qplib_alloc_stats_ctx(res->pdev, &ctx->stats);
> > +     rc =3D bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &ctx->sta=
ts);
> >       if (rc)
> >               goto fail;
> >
> > @@ -888,15 +889,12 @@ static void bnxt_qplib_free_stats_ctx(struct pci_=
dev *pdev,
> >  }
> >
> >  static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
> > +                                   struct bnxt_qplib_chip_ctx *cctx,
> >                                     struct bnxt_qplib_stats *stats)
> >  {
> >       memset(stats, 0, sizeof(*stats));
> >       stats->fw_id =3D -1;
> > -     /* 128 byte aligned context memory is required only for 57500.
> > -      * However making this unconditional, it does not harm previous
> > -      * generation.
> > -      */
> > -     stats->size =3D ALIGN(sizeof(struct ctx_hw_stats), 128);
> > +     stats->size =3D cctx->hw_stats_size;
> >       stats->dma =3D dma_alloc_coherent(&pdev->dev, stats->size,
> >                                       &stats->dma_map, GFP_KERNEL);
> >       if (!stats->dma) {
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infini=
band/hw/bnxt_re/qplib_res.h
> > index 7a1ab38..58bad6f 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > @@ -60,6 +60,7 @@ struct bnxt_qplib_chip_ctx {
> >       u16     chip_num;
> >       u8      chip_rev;
> >       u8      chip_metal;
> > +     u16     hw_stats_size;
> >       struct bnxt_qplib_drv_modes modes;
> >  };
> >
> > --
> > 2.5.5
> >

--000000000000bca52405c6d8fe7b
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
Agxea+GNYSvtMZZyJzwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDhq9dnFje5r
d87Fjq4Odh7gd40XO6bwGTULOohJLlRdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDcxMTEzMjkzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBupQetKBfAY7bjbiqFljlmZoogEIf+
tz75jW+efIpibwDsFvZiujSWoR+QG1OsM/iqhYRt6MUmOaQtNA1xScygTLu4uM5XnGMO33mjMMH1
+O7A+oVpN2jh2rAJ1nzePobdTOX2CPRtdVNRsmg9gE+zeP+7QfI92gKspTyBAxxQ4++VYwucNmA5
xkSnG7MFdCMFRwJM8VrvvhgOBqElDfF26dCI6yQixYAx/GI27WCyEQKinWXoNNCI27MVf2D1nfCX
2Dvvb14AlksVrrwZhORbJ0O0n8+369cWsAorscoizMd1Vjc863q++/c0d2At8Zu+r/Mm8owh8iHC
oim2+iU2
--000000000000bca52405c6d8fe7b--
