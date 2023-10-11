Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E087C4F86
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjJKKEg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjJKKEf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 06:04:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C03292
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 03:04:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7b91faf40so25643127b3.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697018672; x=1697623472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YB3f9PIpLIO8QrZq/J5R1XOR9Y+Peshh17cYJjzlhM=;
        b=QCGtLES+EOpbUML+Wf9twU7IwC8xBbrhxA7fDl5OAfp1oYc04u9lKEGU6HjW0X7MSg
         DPjbVDl66jTgiY4mGiuQabv6y6QGAOJ5eBaCJHeZIAI3EpYLsdKMHccDJgeUkqW5DmJ3
         wrW63PkKfrG2xiPvH/Mw2LHXDePMLSXNa8Mgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697018672; x=1697623472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YB3f9PIpLIO8QrZq/J5R1XOR9Y+Peshh17cYJjzlhM=;
        b=cqKKgoxFDP2O92QNaTMZC6JNeIRXMCd8loBx6ERFDVOVeL0SJz/II9IXq8t/g21Jxn
         qCx8r8JR6/Zdcer5Qmkwl0B9BqfiEkl4xaukDf3Cdb08srfNKnRC4Z1umH1Yis5uT4s0
         MvW/LftSghIaOfCS8uQQEOCCJzJAIKI/+KlYHhvy9p1mDq8C08SWC016csEOgXxf7GaG
         xs/fOQgaDPrHwUDz7/v+2t4XvwPZ9pyGcQ6KnD4Z3SQNe8k7By5+p71kG8col/FNnc7O
         7Bu2x2UJk9AjsTejanaJz7llQoqJiQWdPVxTq6l3Qv+Na3JmadlBJhr24o/0W8GJe0aC
         v1oA==
X-Gm-Message-State: AOJu0Yzx5fadSQJ+9u/KChhjA9oVJ87BXDO/VeWVFF2ZXOITJ3+ytaSz
        2bKubGESocPvsrf4Dl4f3gxiIUt2TG4wWI0nwP4Nyg==
X-Google-Smtp-Source: AGHT+IEDRv4w1zf9HW/C4aN/Pjh3bFyjDmpNUIgROlQJgx66kHln/BI5TKR822JnPD4Puu9JDdXzzbvgfxi7DWVdUnQ=
X-Received: by 2002:a25:641:0:b0:d86:74e5:9469 with SMTP id
 62-20020a250641000000b00d8674e59469mr17010779ybg.16.1697018672484; Wed, 11
 Oct 2023 03:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <1696483889-17427-1-git-send-email-selvin.xavier@broadcom.com>
 <1696483889-17427-2-git-send-email-selvin.xavier@broadcom.com> <20231009060915.GA5042@unreal>
In-Reply-To: <20231009060915.GA5042@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed, 11 Oct 2023 15:34:19 +0530
Message-ID: <CA+sbYW2MW5Sy8E4nZWRnyppNwJ5B7BzO-vVk3_wVmDV9+H=mZw@mail.gmail.com>
Subject: Re: [PATCH for-next 1/3] RDMA/bnxt_re: Update HW interface headers
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002bc13b06076df3c9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000002bc13b06076df3c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 9, 2023 at 11:39=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Oct 04, 2023 at 10:31:27PM -0700, Selvin Xavier wrote:
> > From: Chandramohan Akula <chandramohan.akula@broadcom.com>
> >
> > Updating the HW structures for the affiliated event and error
> > reporting. Newly added interface structures will be used in the
> > followup patch.
> >
> > Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/roce_hsi.h | 62 ++++++++++++++++++++++++=
++++++++
> >  1 file changed, 62 insertions(+)
>
> <...>
>
> > +     #define CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_LAST \
> > +                     CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_R=
EQ_RETX_SETUP_ERROR
> >       __le32  xid;
>
> <...>
>
> > +     #define CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_LAST \
> > +                     CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_R=
ES_PSN_NOT_FOUND
>
> These defines are not used.
These defines are from an autogenerated file and it indicates the LAST
define from this set. It won't be used. I will remove it from this
patch
Thanks
>
> Thanks
>
> >       __le16  sq_cons_idx;
> >       __le16  rq_cons_idx;
> >  };
> > --
> > 2.5.5
> >
>
>

--0000000000002bc13b06076df3c9
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIICzQiu9ZpbK
m9a5/tPSIX4tovczScts149CyJz22jBFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTAxMTEwMDQzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCxuZ/V8zFNKpz/JeXrOpEb1CCld15D
XnIIHZiGgfGzAaCrC83s0MdTJgEzkJpzNmqM0TYqLYOTeIUnhGzdoWwzSZipgqrqNCyUMZzoMrmK
uGZVlZXlZnJbilXX6zRen3oxd/WJ2IMHAbHJdfc1f8CHC/bVtznSUJHGkEiDp/oftBG6G37kbzkF
zLMe7l4EV+HR6eazIw+dsqAlA/w5vpfBsHv5gcv9da4xm6eMMhd9gD/MlwJTzT2tk8KnTIczeTdp
gtLq2o1vvNpV0o4izdMda4PdzBDdATut4dke0CvxjYGlwr/vhbMBu41Tjsbk3yhz82bu7t93AXNI
o9Lm3hrZ
--0000000000002bc13b06076df3c9--
