Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79807763961
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGZOkX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGZOkW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 10:40:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03819BE
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 07:40:18 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so7479826276.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690382418; x=1690987218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmzr6WuK9l4UiJUyu4TwrFf4WxNP/E3zsB64Xn/1FBA=;
        b=MXWzUIi0+u4gAw4eh3fe0fCvnm9xstbJINQ81kELxLH/7nx9VtiW07iG+PgKs4B6O/
         vFQg4juFFUTGl6LLqp4mJwzLbDlANuyLhq5uqEOIoqCM6imlAjJT7E4Nps1eZQiolBiz
         8qz8e5DT3+1NZ68ZS4Mvx+/Et/1CdoFrJs270=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382418; x=1690987218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nmzr6WuK9l4UiJUyu4TwrFf4WxNP/E3zsB64Xn/1FBA=;
        b=e9ILzM4xdsqnA//GsGafwxiybjPfe561O1BCInZPvfrR3mhisWUxBYXMY0m8VYmC6y
         x/92razDfYjKzXUM8/UfG0oTT4/rvWvY0lPXh2NJONTnHjECUzRc4oJpoQd3GGsamsXU
         qboorWjuF6y1Dwg2s1cDraZ7pp1R0yJxA3e06z48Gk2Nktl/G81l58ag+nORpGd9U3/a
         5HieDzl7USJO6Xpw6mh4QbRMTmE9DAkWO6ocwZp/Z+HTnXkjrNEGhraqZY0G+vLC3yUd
         nUUrrzDL53xblL34PgTkjf7seQ+WLKdyjxdh8Sb5SfaCYucyxSIKZQZw0kxqpy3BMTuX
         WbZg==
X-Gm-Message-State: ABy/qLYglbEtPuBDFLDlKGSNTd+mIELyGlwZQ52WWQ9eQPsd0scrvykx
        OV7b7mRl2CeQj9AUv8kdS0QFGSomtHqKkP3iA5Xg+Q==
X-Google-Smtp-Source: APBJJlGXG6SKerQrdipN5LjlLEKJ1wmSiAV253KQdQ5WElHrO+Pg3qEn2tPADWt62H8vmTz9K4jmgd9FdjLiWvUdts8=
X-Received: by 2002:a25:8b12:0:b0:d08:2101:562d with SMTP id
 i18-20020a258b12000000b00d082101562dmr1780613ybl.34.1690382417931; Wed, 26
 Jul 2023 07:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <1690360493-8428-1-git-send-email-selvin.xavier@broadcom.com> <20230726130726.GW11388@unreal>
In-Reply-To: <20230726130726.GW11388@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 26 Jul 2023 20:10:03 +0530
Message-ID: <CA+sbYW1cqdUr2_vwPy5BnLFsAqxATP++BR6QfADoe3P_UfEYWA@mail.gmail.com>
Subject: Re: [PATCH] IB/core: Add more speed parsing in ib_get_eth_speed()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009330eb060164d3a0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000009330eb060164d3a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 6:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Jul 26, 2023 at 01:34:53AM -0700, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > The function ib_get_eth_speed() does not take consideration
> > of 50G, 56G, 100G and 200G speeds. Added these speeds parsing.
> > We are not considering the lane width now. This can be enhanced
> > later.
> >
> > Also, refactored the code to use switch case instead of if-else.
> >
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/core/verbs.c | 34 ++++++++++++++++++++++++++++-----=
-
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/=
verbs.c
> > index b99b3cc..ebd389a 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -1908,22 +1908,44 @@ int ib_get_eth_speed(struct ib_device *dev, u32=
 port_num, u16 *speed, u8 *width)
> >                       netdev_speed);
> >       }
> >
> > -     if (netdev_speed <=3D SPEED_1000) {
> > +     switch (netdev_speed) {
> > +     case SPEED_1000:
> >               *width =3D IB_WIDTH_1X;
> >               *speed =3D IB_SPEED_SDR;
> > -     } else if (netdev_speed <=3D SPEED_10000) {
> > +             break;
> > +     case SPEED_10000:
>
> This conversion is not equal to code before. We have more speeds between
> SPEED_1000 and SPEED_10000.
>
> include/uapi/linux/ethtool.h
> ...
>   1889 #define SPEED_1000              1000
>   1890 #define SPEED_2500              2500
>   1891 #define SPEED_5000              5000
>   1892 #define SPEED_10000             10000
Sure. We will handle the two cases that are missing and spin a v2 patch.
>
>
> Thanks
>
>
>
> >               *width =3D IB_WIDTH_1X;
> >               *speed =3D IB_SPEED_FDR10;
> > -     } else if (netdev_speed <=3D SPEED_20000) {
> > +             break;
> > +     case SPEED_20000:
> >               *width =3D IB_WIDTH_4X;
> >               *speed =3D IB_SPEED_DDR;
> > -     } else if (netdev_speed <=3D SPEED_25000) {
> > +             break;
> > +     case SPEED_25000:
> >               *width =3D IB_WIDTH_1X;
> >               *speed =3D IB_SPEED_EDR;
> > -     } else if (netdev_speed <=3D SPEED_40000) {
> > +             break;
> > +     case SPEED_40000:
> >               *width =3D IB_WIDTH_4X;
> >               *speed =3D IB_SPEED_FDR10;
> > -     } else {
> > +             break;
> > +     case SPEED_50000:
> > +             *width =3D IB_WIDTH_2X;
> > +             *speed =3D IB_SPEED_EDR;
> > +             break;
> > +     case SPEED_56000:
> > +             *width =3D IB_WIDTH_4X;
> > +             *speed =3D IB_SPEED_FDR;
> > +             break;
> > +     case SPEED_100000:
> > +             *width =3D IB_WIDTH_4X;
> > +             *speed =3D IB_SPEED_EDR;
> > +             break;
> > +     case SPEED_200000:
> > +             *width =3D IB_WIDTH_4X;
> > +             *speed =3D IB_SPEED_HDR;
> > +             break;
> > +     default:
> >               *width =3D IB_WIDTH_4X;
> >               *speed =3D IB_SPEED_EDR;
> >       }
> > --
> > 2.5.5
> >
>
>

--0000000000009330eb060164d3a0
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAzNgLIgO+4r
Cnmz01X5le3KVPESz2OCp38qHcDzbvpAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcyNjE0NDAxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC7WziB9mcl8oN3pMQ7dKQxEKiHQ/xI
9jHfyOHUcM0ICJYUhS8N7SacV1kblOhCN8BL0CSD0o2rw6u8k7NpytKpZBJ7jnkOUHDlIojEEgUY
ieNuNYF1DEE0obVBNF//GqQpZIHb9mcpgIoCXM6vGcfbqTfTHJl6mc64TzOIBc+LygyStZQLLiFA
pYRaJFoaJqhKLdsG5mot9hs76nF8r0xERwFo/+gH8a9NKjFwVKK279XWxpA0uNpZxfEPzfXKfJo3
1HOogN/SPWEi6EQgatEpPqvRLM0txw1iYM5Os+v3d/Yvuga2I/LsBGbaarvhwEqMI6aQnzWNf3Jp
QtaUdBkf
--0000000000009330eb060164d3a0--
