Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1BD72B7D1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 07:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjFLFvG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 01:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjFLFvF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 01:51:05 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE9109
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 22:51:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso4405241276.0
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686549060; x=1689141060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TLcMy4VEFNgmW4y5UgG9I1FD48a4bxr/gV7UnPwpIoY=;
        b=fUfRL6ejJutWHQdYbdeVF/tHAtI/metk75WzJD3BYWXuUCFTKfbfaCxSJ6jmmyV2Iy
         6K3o4Jvtj8H657x8tEu6tkKXFfqJjficLo+DJIx4L+ez4Vthf7/TCk9bBd0RofUgvPH9
         qMt7mImgVLB4yfyDx0zsHmz9gx1fpkQZgyacU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686549060; x=1689141060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLcMy4VEFNgmW4y5UgG9I1FD48a4bxr/gV7UnPwpIoY=;
        b=CKEgnIOCENebeU6HMy9BSdmGpvZIngifUthKD+NMvLB9OQb2iQL/B3eE6Ze7SSa2HV
         UgI1VEIjCiYGVsxOGia+8DCiryux28GZatiB6l9L5f6xVEJDcdSbBQwxsww9bYUTsu3z
         taLnzP3MU2tPHtQumB+loMq25XZ/6UCpbIMvJgqEF78yg2OtQzYddEHSuQa6YjBtYyoP
         EHthe97oly6iosZA3rdiWWmKdOvsv7TlhSTn2wyXE2avB10uBBekrujZ/MgZqP8WGmq2
         wgu/KN6c0di5xSuKVLKMqLzO6PlsxZCC8MNxFMEKup6AtV3UwlTLVqgpt3NkIooLVnz9
         UQIQ==
X-Gm-Message-State: AC+VfDzXLa7KhTiCy95GkJ/mimySXEB8RNCEJispRgQnwvIVvyWYtk3e
        DNvmCMz6H++CwSy4mUClvg5N2RFRUN/CmUm+O7sSbA==
X-Google-Smtp-Source: ACHHUZ5Sq01L51DCD1w7dFKb8fXZ9wfhvCwUPfg0nVClZ7IzGbkdhEZjCOkASOu0lIWl5SlG3sFugXd0+/5FasYhnoE=
X-Received: by 2002:a81:6cd7:0:b0:56d:65b:11e6 with SMTP id
 h206-20020a816cd7000000b0056d065b11e6mr4869998ywc.8.1686549059575; Sun, 11
 Jun 2023 22:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <1685617837-15725-1-git-send-email-selvin.xavier@broadcom.com>
 <1685617837-15725-4-git-send-email-selvin.xavier@broadcom.com> <20230611130420.GD12152@unreal>
In-Reply-To: <20230611130420.GD12152@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 12 Jun 2023 11:20:47 +0530
Message-ID: <CA+sbYW3M0NT0vk-Xep4v-HRS_JUGfmEnpu=AiQB=KmO7q-Gyjw@mail.gmail.com>
Subject: Re: [PATCH v4 for-next 3/6] RDMA/bnxt_re: Query function capabilities
 from firmware
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009dddd905fde84dce"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000009dddd905fde84dce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 6:34=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Jun 01, 2023 at 04:10:34AM -0700, Selvin Xavier wrote:
> > Query Function capabilities to enable advanced features.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index 9cc652e..da99f69 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -83,6 +83,7 @@ static int bnxt_re_netdev_event(struct notifier_block=
 *notifier,
> >                               unsigned long event, void *ptr);
> >  static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netd=
ev);
> >  static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev);
> > +static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
> >
> >  static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
> >  {
> > @@ -91,6 +92,9 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *=
rdev, u8 mode)
> >       cctx =3D rdev->chip_ctx;
> >       cctx->modes.wqe_mode =3D bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx=
) ?
> >                              mode : BNXT_QPLIB_WQE_MODE_STATIC;
> > +     if (bnxt_re_hwrm_qcaps(rdev))
> > +             dev_err(rdev_to_dev(rdev),
> > +                     "Failed to query hwrm qcaps\n");
> >  }
> >
> >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> > @@ -340,6 +344,25 @@ static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg=
 *fw_msg, void *msg,
> >       fw_msg->timeout =3D timeout;
> >  }
> >
> > +/* Query function capabilities using common hwrm */
> > +int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
> > +{
> > +     struct bnxt_en_dev *en_dev =3D rdev->en_dev;
> > +     struct hwrm_func_qcaps_output resp =3D {0};
> > +     struct hwrm_func_qcaps_input req =3D {0};
>
> There is no need in 0 here, just use {}
>
> > +     struct bnxt_qplib_chip_ctx *cctx;
> > +     struct bnxt_fw_msg fw_msg;
>
> Initialize it to zero from the beginning and remove memset()
There are other functions that also uses bnxt_re_init_hwrm_hdr which uses
the extra memset. I will add a separate patch to this series which removes
the memset code and the extra parameters to  bnxt_re_init_hwrm_hdr
and prepare this patch on top of that.

Will post a v5 soon.
>
> > +
> > +     cctx =3D rdev->chip_ctx;
> > +     memset(&fw_msg, 0, sizeof(fw_msg));
> > +     bnxt_re_init_hwrm_hdr(rdev, (void *)&req,
> > +                           HWRM_FUNC_QCAPS, -1, -1);
>
> All callers to bnxt_re_init_hwrm_hdr() provide "-1, -1" and rdev is not
> used at all.
-1
>
> > +     req.fid =3D cpu_to_le16(0xffff);
> > +     bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&=
resp,
> > +                         sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> > +     return bnxt_send_msg(en_dev, &fw_msg);
> > +}
> > +
> >  static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
> >                                u16 fw_ring_id, int type)
> >  {
> > --
> > 2.5.5
> >
>
>

--0000000000009dddd905fde84dce
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC4trSQbGnP8
dhst4kAUv/eKlq88xMn3++SBkz+bysCuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYxMjA1NTA1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAt7zz5ZzqDQm6xAwWIxbZBWsWG85Ma
07hC0krrBuTxh8ESwRtOLvMn9tiWyV7lWnlgWSuGDTOwc+0GGCQZfW1qWq5UNJ/ZfggFpTyhYDOk
r28IXUouZh+fIOb4+ik1T+Fs38us0A+Rni9kTbmgwZ4dnsQved+BMOu5H063jxlymYunRFXDV6oV
7eUS21VlrOPdFAClm1L4wiZgWfUso9Zig32WKlZd8abD9YibOALi0ALsCoOQMtWDJpt8MRO017JI
HePsdMx9RTi9EVMpm3d3eH4BUKCJEqOuV1HfBiCj85Uq7Dk6Sezu9v4sOdIyeadzwReZXWNlrX7g
XKnoVIF+
--0000000000009dddd905fde84dce--
