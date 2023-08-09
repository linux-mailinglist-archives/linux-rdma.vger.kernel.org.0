Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B157755E7
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHIIyi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 04:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIIyh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 04:54:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F31BD9
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 01:54:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583ae4818c8so70805117b3.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Aug 2023 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691571275; x=1692176075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15gFlitr2y5Ds9zrJ86G2I9hYxpp4pGtivpKmd7Yyik=;
        b=DeetNo8Oj/zc+dtSEX6lM8zWA+l9p22hPZmF4k5hum9aIK2yq4SLTl8FMuDKNkwP0N
         vsVDwrQQScx4Ar3YIdHjPxV9P+3BTXPlnV9dZErgjFL2vs/l3+6sePIGM0LfbV19TDq5
         yNoybBLIjVaW9XiG4BRiIydljNxZkFLcjLFys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571275; x=1692176075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15gFlitr2y5Ds9zrJ86G2I9hYxpp4pGtivpKmd7Yyik=;
        b=abk3z/L+W3Sh5FnN4/IwKQLXiavu43s2mtiQMUxGey+SYUNOEDQLULXj/nTLtjeidk
         dBoQ7pLgybo3JC7H9He5HWB6bWrHI3l6cxMUw//b2ZvCEKHKN57PuzuzpLMJpn0cFh9J
         X66mBo3Xp2LMNE6PZC2gcEVj4tKThCmEaTiXE8LUYIlfsJdJkC7BysHEfECBMR0F48ip
         XJF3ob87/Q+fEcmODWXipxJHa4gVsONMA0DYN+udSelTSUZokElb9PQXw9gA47pA0zYf
         QPMohabYsRaqJPg5ONOfL12ZVwTzSJ9ZE1MFe58w0ivV+Jbd9pu8V9Fx4WyUVfBzYtzx
         Llog==
X-Gm-Message-State: AOJu0YwTOJYws16xVFW4soxjkXRVXXI0QXVb+qMOnjNhagXXuYUpJ3FB
        wVKeIe0ZWcmd598b4PhBZkuJjy+CTFEhIXah8lDeog==
X-Google-Smtp-Source: AGHT+IEbcouKKFM+wYPrgJ0ZeCPCikstElwt6FXL8b9tkkYmvOjC+PIr7msvAYx4WBW7snKU383wy1XjGaS57+HTipg=
X-Received: by 2002:a81:81c5:0:b0:583:42d3:8a18 with SMTP id
 r188-20020a8181c5000000b0058342d38a18mr1602794ywf.52.1691571275093; Wed, 09
 Aug 2023 01:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
 <20230803175842.GF53714@unreal> <CA+sbYW14vED8cHzvqO-=06yJegqBZqVd76uDma=w+d-Y+T+PsQ@mail.gmail.com>
 <20230807135250.GB7100@unreal>
In-Reply-To: <20230807135250.GB7100@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 9 Aug 2023 14:24:22 +0530
Message-ID: <CA+sbYW0nF3OqMVUyLkq68+R_beDyXuN0-PbhEru31Y+gMA3WaQ@mail.gmail.com>
Subject: Re: [PATCH for-next v2] IB/core: Add more speed parsing in ib_get_width_and_speed()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fc9750060279a03b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000fc9750060279a03b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 7, 2023 at 7:22=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Fri, Aug 04, 2023 at 09:43:28AM +0530, Selvin Xavier wrote:
> > On Thu, Aug 3, 2023 at 11:28=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Wed, Aug 02, 2023 at 02:00:23AM -0700, Selvin Xavier wrote:
> > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > >
> > > > When the Ethernet driver does not provide the number of lanes
> > > > in the __ethtool_get_link_ksettings() response, the function
> > > > ib_get_width_and_speed() does not take consideration of 50G,
> > > > 100G and 200G speeds while calculating the IB width and speed.
> > > > Update the width and speed for the above netdev speeds.
> > > >
> > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > > v1 - v2:
> > > >     - Rebased the patch based on the latest changes in ib_get_width=
_and_speed
> > > >     - removed the switch case and use the existing else if check
> > > > ---
> > > >  drivers/infiniband/core/verbs.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/c=
ore/verbs.c
> > > > index 25367bd..41ff559 100644
> > > > --- a/drivers/infiniband/core/verbs.c
> > > > +++ b/drivers/infiniband/core/verbs.c
> > > > @@ -1899,9 +1899,18 @@ static void ib_get_width_and_speed(u32 netde=
v_speed, u32 lanes,
> > > >               } else if (netdev_speed <=3D SPEED_40000) {
> > > >                       *width =3D IB_WIDTH_4X;
> > > >                       *speed =3D IB_SPEED_FDR10;
> > > > -             } else {
> > > > +             } else if (netdev_speed <=3D SPEED_50000) {
> > > > +                     *width =3D IB_WIDTH_2X;
> > > > +                     *speed =3D IB_SPEED_EDR;
> > > > +             } else if (netdev_speed <=3D SPEED_100000) {
> > > >                       *width =3D IB_WIDTH_4X;
> > > >                       *speed =3D IB_SPEED_EDR;
> > > > +             } else if (netdev_speed <=3D SPEED_200000) {
> > > > +                     *width =3D IB_WIDTH_4X;
> > > > +                     *speed =3D IB_SPEED_HDR;
> > >
> > >
> > > SPEED_50000, SPEED_100000 and SPEED_200000 depends on
> > > ClassPortInfo:CapabilityMask2.is* values.
> > >
> > > For example, SPEED_50000 can b IB_WIDTH_2X/IB_SPEED_EDR and IB_WIDTH_=
1X/IB_SPEED_HDR.
> > Agree with that.
> > This reporting can be achieved by the existing code, but the L2 driver
> > needs to report non zero values for lanes in
> > ethtool_ops->get_link_ksettings.
> > Caller of this modified function gets the speed and number of lanes
> > from ethtool_ops->get_link_ksettings.
> >
> > In this patch we are trying to handle the case where ethtool ops
> > doesn't provide the lanes.
>
> Almost all drivers don't support lanes reporting.
Agreed. But this patch will at least correct the overall speed
reporting. So it's an improvement from the current behavior.
If you still feel that this is not needed, you can drop the patch. We
will have to modify the L2 drivers to report the lanes in that case.

>
> > We can  default to some value so that we
> > dont report wrong total link speed (width * speed) for any speed more
> > than 40G.
> > >
> > > Thanks
> > >
> > > > +             } else {
> > > > +                     *width =3D IB_WIDTH_4X;
> > > > +                     *speed =3D IB_SPEED_NDR;
> > > >               }
> > > >
> > > >               return;
> > > > --
> > > > 2.5.5
> > > >
> > >
> > >
>
>

--000000000000fc9750060279a03b
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILbECS1ecpVe
kMoG1QA8aqyNOIUhWP7d8tERJDWnufZOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDgwOTA4NTQzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBRbpRhEWGE2TLCqS426pwfDj1D7xTX
nX1HDym3cOyaTkNTmYYVSbn7sYd5UxF7BIn6e5y2diHQkSeuthlLyn/nAosj4mQJBxItY79yQESw
vcB9J21WxFS1roe1LbSQg8Je4RXIXlr3C8jNsb+2iRfZJl4+S1/ZeR6Z8pJYhG4mI+GJiKbz0/ZP
Hg0C4DXevSEsXOX711+O9f++UBmRRRhc7leXRHCO/IIXQq8KpNaFdRoNRXUU0iD27Gk7bqqwhKR5
jfkExoyGCiOjnA5sN2HiOx8QPa777S8uZ6kNfDwSNuM+sDet3IHJ3zMM9POafjPQLXZb5DLbc9Zq
IV06G3Wi
--000000000000fc9750060279a03b--
