Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52F6CD675
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjC2Jbg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2Jbf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 05:31:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57352211D
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 02:31:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r187so18496024ybr.6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1680082293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cSAPP/dbB+4VEp7p5c9Uuk7ea2Ok4d+SrSN5MWBKkY4=;
        b=NzXXlAxgT4mMNlm9z35iVSf93BjWOHdT4+reuEZBylbqY/IcRxps0t2NQjoRr1ALGM
         plhwgFWZ/Bf7gSZf+ATHbyEVDVBR2u1i5NIn7fSyIJSW5umQ7HechPKGhbyy9sqarvw2
         rZsibCzZfuCfnwWuBZHFa2Y5OpU3HZIsdbhMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSAPP/dbB+4VEp7p5c9Uuk7ea2Ok4d+SrSN5MWBKkY4=;
        b=O2Pyx/+5FMR1Bw7PUa7WppYmy6qZpF/NzcNPGv2qAn+BuXPo4iwS09xRaQy73g321z
         4Y5gHOkFpz75GPlFPxhmOEiVt2QYqhDy11d0ury6OnMPCYxy1K8+W7g2IZOQ9BbaNdsH
         hQVcDeScY+i2a+wHtRg38R6VJK6GouUI4/VO7pRlmrfQ0wmxvcmUEXPB+aWXNLje5K+Q
         ttqIaDqLHLubUb3X1DXRouKDeuUGIUShjrpFOxwLkSkkrIaxFxrMk0bPFVjm6NBSVzeA
         zfUgqnp0dt6HXwnZDQ9EGOMmL/rZESe74aCfmAFVEF118VI60gJDcSARQanXCi8VvqIA
         bFZg==
X-Gm-Message-State: AAQBX9dg6e7YDrw29TYkNC1AJFNaNhg68UP+LVLFVWV0EI+fM97zbTU2
        iI1wj7ND9WW9QBzRSPnzEd3rzd6qmEI2a5qUMtVwCCdAkdCwCVkK
X-Google-Smtp-Source: AKy350ZKmOL8lORlOkIxxdJ3LFYbagFETmOEIXTvNQpeAfisx8rtfoEiFG5PHmMloyLkSd4FXRMEh1GK34Zh0O7/oj8=
X-Received: by 2002:a05:6902:1586:b0:b33:531b:3dd4 with SMTP id
 k6-20020a056902158600b00b33531b3dd4mr9536497ybu.1.1680082293508; Wed, 29 Mar
 2023 02:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
 <1679562739-24472-8-git-send-email-selvin.xavier@broadcom.com> <20230329072339.GD831478@unreal>
In-Reply-To: <20230329072339.GD831478@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 29 Mar 2023 15:01:21 +0530
Message-ID: <CA+sbYW39qf_kpgR9f4tT_f6OFjPS-q053Q7ySse7dOJGZWZbpw@mail.gmail.com>
Subject: Re: [PATCH for-next 7/7] RDMA/bnxt_re: Enable congestion control by default
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000050e76705f806a4b1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000050e76705f806a4b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 12:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Thu, Mar 23, 2023 at 02:12:19AM -0700, Selvin Xavier wrote:
> > Enable Congesion control by default. Issue FW command
> > enable the CC during driver load and disable it during
> > unload.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c       |  24 ++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  15 ++--
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  20 ++++--
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 109 +++++++++++++++++++++=
++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h   |  67 ++++++++++++++++++
> >  5 files changed, 222 insertions(+), 13 deletions(-)
>
> <...>
>
> > index 06979f7..73f936c 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > @@ -96,7 +96,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcf=
w,
> >       u32 sw_prod, cmdq_prod;
> >       struct pci_dev *pdev;
> >       unsigned long flags;
> > -     u32 size, opcode;
> > +     u32 bsize, opcode;
> >       u16 cookie, cbit;
> >       u8 *preq;
>
> <...>
>
> >       memset(msg->resp, 0, sizeof(*msg->resp));
> >       crsqe->resp =3D (struct creq_qp_event *)msg->resp;
> > -     crsqe->resp->cookie =3D msg->req->cookie;
> > +     crsqe->resp->cookie =3D cookie;
>
> I see that you didn't change cookie type in this patch, but it is better
> to fix smatch/sparse warnings while you are changing the code.
>
> I don't want to see any warnings generated by new patches even for old co=
de.
>
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:155:29: warning: incorrect typ=
e in assignment (different base types)
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:155:29:    expected restricted=
 __le16 [usertype] cookie
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:155:29:    got unsigned short =
[assigned] [usertype] cookie
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.h:96:13: warning: restricted __l=
e16 degrades to integer
Will post v3. thanks
>
> Thanks

--00000000000050e76705f806a4b1
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN3xydgqu+bF
RtjENJ2rF9LRVIlHcmALg0+pHvn0db14MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMyOTA5MzEzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC1e35p+ubIw6p82uTmKZe4hYTAUrBv
zK7BQ9h1xOPQlkkJ49gTHOnKjx52NkFWD/BvN5/CGzC9GqwcU8Nrigj4YLnJe+c86gSHq31Y5Fmn
eKZvYOylnjC31MVx/lp1bgMql0NFoY49TDfRTwI2zjCWTj1wWOgJabxKih1Evmb+XOjIoADoqHwM
cwlXbEwfY6gEZnzzRjf3neQc8QAIi14uSo87DAAbHrBlODO8/2OZz/3HNHg7nf50wVblKIAubSe4
Ua2kRbb4Y2egHv9FEsnFfN/2N5JsS8Cou+aOsM3YXpjJEs2NS9jjWpOYdgClDkJCn2uVD1c54R2R
OEv/q9EX
--00000000000050e76705f806a4b1--
