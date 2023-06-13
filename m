Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EA72D90A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 07:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjFMFX0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 01:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjFMFXZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 01:23:25 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849DE78
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 22:23:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565aa2cc428so44802627b3.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686633803; x=1689225803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+p7H5SO9x91jwpKdt5l3hVEqZVEGw5u+QmwbgK+hH4=;
        b=eMwKWVQRI3/6KCcV52k/JRzVW0odHUrw2rqDmz62XCBekqhm6To/Qmh5gmhthG8o1z
         Z1zmuME9pcxaNZq0417CoS9+Vnwe0qJBIPqVriUjV2URtzrz5k8kFErNge5OJ6Kt9M8X
         tB6uY+bWJPrF4pZUcTIjRbwCIqU+johUzN6ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686633803; x=1689225803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+p7H5SO9x91jwpKdt5l3hVEqZVEGw5u+QmwbgK+hH4=;
        b=GYpc9xMsjnHZaSjcOE9/1zBJal89xUionDiaXGxsd6iZ20UjnP2WixprfVZjltOGj0
         hU/npGSkEYfG10kjj67saOQtkpRhf0Qn5gxeO92ashM36X49ThGltItiPNd1IJ9lg0+V
         hYh2+9gW6MlV+x4WSf7EeBtJeKf/tM1pFZ51A6+BaUVolRLzwfPKxE8GLSmXDu4kdVC7
         PFEwZ0K8IGojJvpnmcYMyEKMxEvTroJxLBpyNrJ8x4nUVUs3Gfk3f/PJmVeUi630pHw3
         cpj2ZWtnBjH27/2+BgttXGE1SuOE1u/9bGyLh38IVO0hTbA5ZNwiD+oGU5dTABagUcBD
         0A4Q==
X-Gm-Message-State: AC+VfDxF/qCIYGHA0S+Ot1Cy9bE8c8mns0mjg3azowcFv6F2mjAiPdqV
        9B9I1NGxmZ144y7sQrAVzcDTUwWrwqpBjBRpoJeeiQ==
X-Google-Smtp-Source: ACHHUZ4OWtT0/P4VUcduG5wAWOml3ivKJODpnSvmOIz9KX5rjRaB5YXL/lzmWW7aIZcuR2O7qcerHuJQm2IKLRHQo4U=
X-Received: by 2002:a25:8d87:0:b0:bca:cbc8:9608 with SMTP id
 o7-20020a258d87000000b00bcacbc89608mr629868ybl.15.1686633803099; Mon, 12 Jun
 2023 22:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
 <1686563342-15233-8-git-send-email-selvin.xavier@broadcom.com> <ZIdhunLGPLg6h5ID@nvidia.com>
In-Reply-To: <ZIdhunLGPLg6h5ID@nvidia.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 13 Jun 2023 10:53:11 +0530
Message-ID: <CA+sbYW0GD351sTnGaQp5omKj00kmVQPKE0KbWTSuHt6E8M+Jyg@mail.gmail.com>
Subject: Re: [PATCH v5 for-next 7/7] RDMA/bnxt_re: Enable low latency push
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b9963905fdfc08ae"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000b9963905fdfc08ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 11:49=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Mon, Jun 12, 2023 at 02:49:02AM -0700, Selvin Xavier wrote:
>
> > +static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_att=
r_bundle *attrs)
> > +{
> > +     struct ib_uobject *uobj =3D uverbs_attr_get_uobject(attrs, BNXT_R=
E_ALLOC_PAGE_HANDLE);
> > +     enum bnxt_re_alloc_page_type alloc_type;
> > +     struct bnxt_re_user_mmap_entry *entry;
> > +     enum bnxt_re_mmap_flag mmap_flag;
> > +     struct bnxt_qplib_chip_ctx *cctx;
> > +     struct bnxt_re_ucontext *uctx;
> > +     struct bnxt_re_dev *rdev;
> > +     u64 mmap_offset;
> > +     u32 length;
> > +     u32 dpi;
> > +     u64 dbr;
> > +     int err;
> > +
> > +     uctx =3D container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_=
re_ucontext, ib_uctx);
> > +     if (IS_ERR(uctx))
> > +             return PTR_ERR(uctx);
> > +
> > +     err =3D uverbs_get_const(&alloc_type, attrs, BNXT_RE_ALLOC_PAGE_T=
YPE);
> > +     if (err)
> > +             return err;
> > +
> > +     rdev =3D uctx->rdev;
> > +     cctx =3D rdev->chip_ctx;
> > +
> > +     switch (alloc_type) {
> > +     case BNXT_RE_ALLOC_WC_PAGE:
> > +             if (cctx->modes.db_push)  {
> > +                     if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx-=
>wcdpi,
> > +                                              uctx, BNXT_QPLIB_DPI_TYP=
E_WC))
> > +                             return -ENOMEM;
> > +                     length =3D PAGE_SIZE;
> > +                     dpi =3D uctx->wcdpi.dpi;
> > +                     dbr =3D (u64)uctx->wcdpi.umdbr;
> > +                     mmap_flag =3D BNXT_RE_MMAP_WC_DB;
> > +             } else {
> > +                     return -EINVAL;
> > +             }
> > +
> > +             break;
> > +
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     entry =3D bnxt_re_mmap_entry_insert(uctx, dbr, mmap_flag, &mmap_o=
ffset);
> > +     if (IS_ERR(entry))
> > +             return PTR_ERR(entry);
> > +
> > +     uobj->object =3D entry;
> > +     uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
>
> uverbs_finalize_uobj_create() is supposed to be called once the
> function cannot fail anymore
>
> > +     err =3D uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
> > +                          &mmap_offset, sizeof(mmap_offset));
> > +     if (err)
> > +             return err;
>
> Because there is no way to undo it on error.
>
> So the error handling here needs adjusting

Hi Jason,

uverbs_finalize_uobj_create is the last step before uverbs_copy_to.
All the error checking
after this is for uverbs_copy_to.  Can you please clarify what needs
to be changed?
 I took the reference of other modules that call
uverbs_finalize_uobj_create for this implementation
and was not able to find the issue you mentioned.
Thanks,
Selvin

>
> Jason

--000000000000b9963905fdfc08ae
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ5AEtmevvAn
6mznPn0AggT7nyEI4lAmj0Om4xUgpAS7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYxMzA1MjMyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbkdW8gOejWJXp3r6vr70SyiNBT4Z0
NyNDYKHOgT82hBdaNrUNYxOjXoJWTQcuDiccXqFdot/VOIo1rrP1Yspa56F2xm60IJip/9jLQAEC
GqWK1SHWGiwE6ECrvq4vAWqXRv0bEjcBco4de8iSF4/Jvcl+0W/zLocsOQV+/2r+4wNcuryLKF1X
JDUxIHUEii9id0AHNaAvr40xJp6wMz0XC8SeDQCz4FfdEU7D0VjRkoGr617QAQV67r3x0mXJ6T6W
jMuG5Ms+OZQteO/rAlgjtwWvT22Zc00f4tQHZIAm/SJiFd1lQV5Y8J+lNGid+PHeKa/WnSBeYPl8
1hfD2cRG
--000000000000b9963905fdfc08ae--
