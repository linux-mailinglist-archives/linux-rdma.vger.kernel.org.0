Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E104A765689
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjG0O4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjG0O4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:56:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CAF2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:56:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so914734276.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690469767; x=1691074567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ex3g4Ji+Yp5w7LfYLXaYRtbWwRop6HtdJdQNuV/vUcA=;
        b=NtEpqau/CxvDHmcOqDYCe3tChTRyqlNIyQKkCARmCF/MWrUMqHA53X+LY3Z6P/aBiy
         7+IcEh5DsOMPLpl4DGCCaLB2hvePKoodB8Bs5A7wKdLWxDjQFLI5e4e9BxKb3oc6PoSL
         CdcCzj8zbU/y2sVhrluYcu0tf+KAeUZVtIvcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469767; x=1691074567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ex3g4Ji+Yp5w7LfYLXaYRtbWwRop6HtdJdQNuV/vUcA=;
        b=kHE9QE3KiFstnIzpaP4w96Jy/Cml/F8X3PLmM4g5hOfOB4ykNh1XCJiJOzlAVoibsl
         4HMeARl+EW0Dw/RvxhlnlhYVxWxsrcA7/aeb2G1eomXJ/I36Gdf/80MB3xApwj25EKmC
         e524vCuqL0yrABlXhvYt5MaRdXMl1oIFZ279UWXUs2dDo69qO+6D3rQLfEhyckggSIuX
         lVmGJR42wdYztUYW/HWjL8MK/BhsTA97+6IYCkCTMN76AcJjNwOBHc97u/XSdzSXcK4+
         qn2+RgfpGtcouyyBKDThllJzCeDywb1W0qG30zmFah7Hm1AAMPkqIMWsZRfzt29fUdPe
         XXPQ==
X-Gm-Message-State: ABy/qLblR/fg06l3euqF0zrlU6nPlLA5j6Tm1uIxLsGKdQdK2OxMi14t
        uCDdfvOPzGPuaNd1uZFcEPVKHTO5UDafsRb5vBfIbw==
X-Google-Smtp-Source: APBJJlFWV0oXOA86dQY8clQ3v1ynL4jDbCxEiVfQmJW0cAaMXEsV1hyx48TERF9OTWPSBMyB0lOKQGNuEPnc6zOIiow=
X-Received: by 2002:a05:6902:603:b0:d12:94bd:3355 with SMTP id
 d3-20020a056902060300b00d1294bd3355mr4676667ybt.65.1690469767392; Thu, 27 Jul
 2023 07:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <1690468194-6185-1-git-send-email-selvin.xavier@broadcom.com>
 <1690468194-6185-2-git-send-email-selvin.xavier@broadcom.com> <ZMKC2vmcCPs9umv2@ziepe.ca>
In-Reply-To: <ZMKC2vmcCPs9umv2@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 27 Jul 2023 20:25:54 +0530
Message-ID: <CA+sbYW06cuSGyagiNVVmcXj=TF=AV53Pt9L_9nqiYThAn0Z+_Q@mail.gmail.com>
Subject: Re: [PATCH for-next 1/1] RDMA/bnxt_re: Add support for dmabuf pinned
 memory regions
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000002722a0601792a9c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000002722a0601792a9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 8:14=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Jul 27, 2023 at 07:29:54AM -0700, Selvin Xavier wrote:
> > From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> >
> > Support the new verb which indicates dmabuf support.
> > bnxt doesn't support ODP. So use the pinned version of the
> > dmabuf APIs to enable bnxt_re devices to work as dmabuf importer.
> >
> > Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 48 ++++++++++++++++++++++++=
++------
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 +++
> >  drivers/infiniband/hw/bnxt_re/main.c     |  1 +
> >  3 files changed, 44 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index 2b2505a..3c3459d 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -3981,17 +3981,19 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
> >       return rc;
> >  }
> >
> > -/* uverbs */
> > -struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 =
length,
> > -                               u64 virt_addr, int mr_access_flags,
> > -                               struct ib_udata *udata)
> > +static struct ib_mr *__bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 st=
art,
> > +                                        u64 length, u64 virt_addr, int=
 fd,
> > +                                        int mr_access_flags,
> > +                                        struct ib_udata *udata,
> > +                                        bool dmabuf)
> >  {
> >       struct bnxt_re_pd *pd =3D container_of(ib_pd, struct bnxt_re_pd, =
ib_pd);
> >       struct bnxt_re_dev *rdev =3D pd->rdev;
> > +     struct ib_umem_dmabuf *umem_dmabuf;
> > +     unsigned long page_size;
> >       struct bnxt_re_mr *mr;
> >       struct ib_umem *umem;
> > -     unsigned long page_size;
> > -     int umem_pgs, rc;
> > +     int umem_pgs, rc =3D 0;
> >       u32 active_mrs;
> >
> >       if (length > BNXT_RE_MAX_MR_SIZE) {
> > @@ -4017,9 +4019,21 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *=
ib_pd, u64 start, u64 length,
> >       /* The fixed portion of the rkey is the same as the lkey */
> >       mr->ib_mr.rkey =3D mr->qplib_mr.rkey;
> >
> > -     umem =3D ib_umem_get(&rdev->ibdev, start, length, mr_access_flags=
);
> > -     if (IS_ERR(umem)) {
> > -             ibdev_err(&rdev->ibdev, "Failed to get umem");
> > +     if (!dmabuf) {
> > +             umem =3D ib_umem_get(&rdev->ibdev, start, length, mr_acce=
ss_flags);
> > +             if (IS_ERR(umem))
> > +                     rc =3D PTR_ERR(umem);
> > +     } else {
> > +             umem_dmabuf =3D ib_umem_dmabuf_get_pinned(&rdev->ibdev, s=
tart, length,
> > +                                                     fd, mr_access_fla=
gs);
> > +             if (IS_ERR(umem_dmabuf))
> > +                     rc =3D PTR_ERR(umem_dmabuf);
> > +             else
> > +                     umem =3D &umem_dmabuf->umem;
> > +     }
>
> This is pretty ugly, why can't you pass in the umem from the two stubs:
My intention was to re-use the function  bnxt_re_reg_user_mr without
much change.
I got your point. let me split the support function and post a v2.
>
> > +struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 =
length,
> > +                               u64 virt_addr, int mr_access_flags,
> > +                               struct ib_udata *udata)
> > +{
> > +     return __bnxt_re_reg_user_mr(ib_pd, start, length, virt_addr, 0,
> > +                                  mr_access_flags, udata, false);
> > +}
> > +
> > +struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 star=
t,
> > +                                      u64 length, u64 virt_addr, int f=
d,
> > +                                      int mr_access_flags, struct ib_u=
data *udata)
> > +{
> > +     return __bnxt_re_reg_user_mr(ib_pd, start, length, virt_addr, fd,
> > +                                  mr_access_flags, udata, true);
> > +}
>
> ?
>
> Jason
>

--00000000000002722a0601792a9c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKNwXCCFWXJx
ySJ23y/yV1EscOb2tLaHR32C5sYfNXgOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcyNzE0NTYwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQANAMidEB12VBh+GXPysBBfeaH6u5mT
NjGAUufniTtZsz+H30HJlC1+6g3BXr4LnEZflq4tdI8PmBiCxTkskSHpfbhDgpgvumLGUdvvk6vp
nQMRMMMCieL4OAPcNDHYi8IuoMr5bSp6NKgp7TQDOrTFpWgLBKtD1dP1CFGJ9qQiPcILaNULcj29
R3cUTelISQH09+sgu6MLV7jQa4G0bPMg4Y5x3Ir3LCBsRXwdu0KKSQ/uznKLoj/0YpWN2HYOFOuS
3HvJ020nUtyqHVrR2jnppCtsuakEMDWNQO140WgqeLqyHVKkedjEGPo8ioNVNJ0uXBrum2TGJHjW
PFIT1Fu9
--00000000000002722a0601792a9c--
