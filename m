Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A729A6C0362
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCSRLz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCSRLy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 13:11:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD651B311
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 10:11:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e194so10516905ybf.1
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679245912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PAi/w3ss1qVbRaJGhuTQqDbxg8fy617phCvyp7UwzKo=;
        b=brbS6bz3ta9i/thtf6uPkY3j952cWe3MEAM/qNocuZOyH/kPVT6mF8SuDtCLp3nm6B
         CDEFLMM4Q+xnWhrImbULqvCJTkdvP7Z/RQlrqKFNIUZd3uUXc5Do9NXiBwd+VfFEMxsg
         5fB6faQbpC7cIlVTk9jepzf3GywEyGHDCPqGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679245912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAi/w3ss1qVbRaJGhuTQqDbxg8fy617phCvyp7UwzKo=;
        b=3lVW/Pxx9Aak7EUu2cbZP/G+zGPppN6v+lwoLqMYKfV/aEQHRA5sOJvZxA8SpYEzeV
         titOWlOSSNlYxlzXqOJW20h7qV3MM3rz3/Ga/JCuVYq3VJCUeUpiTZm8APDYVzJKDdhi
         Blr7RTmusSMSboDKrDF+fvE2JwSD6FxnG6RakOY6vOwYezv5s135O2ZD39POgn9/8anI
         eXU1KrqOJbSSRtmPeYHHizdQCqjWcC/g5/lupBjGlnLbvITwTFhzbVrrSeqdUzx+IpOq
         5kIyC07X8+M5oZWuhOyiUryaqeDpp8w/AoELKJ0BMFIungFKwAor/Ob28aVfoSqw4ARV
         UCdw==
X-Gm-Message-State: AO0yUKVpej9EITybdlXY5EYNYYEvUh7doF3GrOlagdczsNCVfBL2E3AF
        97Nc+2doomuradUZoLQ92fojljmuRtNBIjwlymuv3Q==
X-Google-Smtp-Source: AK7set/EIzoOil+n/stbTYrlwlJHvfKo516r2lhED+ZppDUdOhk1i2OyGx3Jx7XZ6LPMzS7QPCw7AWOScctC8t3aJl4=
X-Received: by 2002:a25:9786:0:b0:98e:6280:74ca with SMTP id
 i6-20020a259786000000b0098e628074camr3740222ybo.1.1679245912158; Sun, 19 Mar
 2023 10:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
 <2b1e2cd5-4843-b1d9-5ac0-60eefc57d26e@huawei.com> <CA+sbYW1TnOwr9EBWfWH76p=KQ6T2naGCYwufoU4j7yfNu9pY2w@mail.gmail.com>
 <0ce9c4fc-c6c7-28e3-7742-cf58782ff7fd@huawei.com> <CA+sbYW3tr_NT8daJ6qyLS-7=_2TXDo69HNtbOpzqg=jhvFczCw@mail.gmail.com>
 <20230319120215.GD36557@unreal>
In-Reply-To: <20230319120215.GD36557@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Sun, 19 Mar 2023 22:41:41 +0530
Message-ID: <CA+sbYW1hSiE+VyAoEUs_BadyqPn1Shroc8u-Z-WDkgPBoZ1T6A@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Add resize_cq support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001b342605f743e88b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000001b342605f743e88b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 19, 2023 at 5:32=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Mar 19, 2023 at 07:37:45AM +0530, Selvin Xavier wrote:
> > On Fri, Mar 17, 2023 at 5:53=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> > >
> > > On 2023/3/17 18:17, Selvin Xavier wrote:
> > > > On Fri, Mar 17, 2023 at 2:40=E2=80=AFPM Yunsheng Lin <linyunsheng@h=
uawei.com> wrote:
> > > >>
> > > >> On 2023/3/15 16:16, Selvin Xavier wrote:
> > > >>> Add resize_cq verb support for user space CQs. Resize operation f=
or
> > > >>> kernel CQs are not supported now.
> > > >>>
> > > >>> Driver should free the current CQ only after user library polls
> > > >>> for all the completions and switch to new CQ. So after the resize=
_cq
> > > >>> is returned from the driver, user libray polls for existing compl=
etions
> > > >>
> > > >> libray -> library
> > > >>
> > > >>> and store it as temporary data. Once library reaps all completion=
s in the
> > > >>> current CQ, it invokes the ibv_cmd_poll_cq to inform the driver a=
bout
> > > >>> the resize_cq completion. Adding a check for user CQs in driver's
> > > >>> poll_cq and complete the resize operation for user CQs.
> > > >>> Updating uverbs_cmd_mask with poll_cq to support this.
> > > >>>
> > > >>> User library changes are available in this pull request.
> > > >>> https://github.com/linux-rdma/rdma-core/pull/1315
> > > >>>
> > > >>> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > >>> ---
> > > >>>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 109 +++++++++++++++++=
++++++++++++++
> > > >>>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
> > > >>>  drivers/infiniband/hw/bnxt_re/main.c     |   2 +
> > > >>>  drivers/infiniband/hw/bnxt_re/qplib_fp.c |  44 +++++++++++++
> > > >>>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |   5 ++
> > > >>>  include/uapi/rdma/bnxt_re-abi.h          |   4 ++
> > > >>>  6 files changed, 167 insertions(+)
> > > >>>
> > > >>> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/i=
nfiniband/hw/bnxt_re/ib_verbs.c
> > > >>> index 989edc7..e86afec 100644
> > > >>> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > >>> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > >>> @@ -2912,6 +2912,106 @@ int bnxt_re_create_cq(struct ib_cq *ibcq,=
 const struct ib_cq_init_attr *attr,
> > > >>>       return rc;
> > > >>>  }
> > > >>>
> > > >>> +static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> > > >>> +{
> > > >>> +     struct bnxt_re_dev *rdev =3D cq->rdev;
> > > >>> +
> > > >>> +     bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_=
cq);
> > > >>> +
> > > >>> +     cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> > > >>> +     if (cq->resize_umem) {
> > > >>> +             ib_umem_release(cq->umem);
> > > >>> +             cq->umem =3D cq->resize_umem;
> > > >>> +             cq->resize_umem =3D NULL;
> > > >>> +             cq->resize_cqe =3D 0;
> > > >>> +     }
> > > >>> +}
> > > >>> +
> > > >>> +int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_uda=
ta *udata)
> > > >>> +{
> > > >>> +     struct bnxt_qplib_sg_info sg_info =3D {};
> > > >>> +     struct bnxt_qplib_dpi *orig_dpi =3D NULL;
> > > >>> +     struct bnxt_qplib_dev_attr *dev_attr;
> > > >>> +     struct bnxt_re_ucontext *uctx =3D NULL;
> > > >>> +     struct bnxt_re_resize_cq_req req;
> > > >>> +     struct bnxt_re_dev *rdev;
> > > >>> +     struct bnxt_re_cq *cq;
> > > >>> +     int rc, entries;
> > > >>> +
> > > >>> +     cq =3D  container_of(ibcq, struct bnxt_re_cq, ib_cq);
> > > >>> +     rdev =3D cq->rdev;
> > > >>> +     dev_attr =3D &rdev->dev_attr;
> > > >>> +     if (!ibcq->uobject) {
> > > >>> +             ibdev_err(&rdev->ibdev, "Kernel CQ Resize not suppo=
rted");
> > > >>> +             return -EOPNOTSUPP;
> > > >>> +     }
> > > >>> +
> > > >>> +     if (cq->resize_umem) {
> > > >>> +             ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - Bus=
y",
> > > >>> +                       cq->qplib_cq.id);
> > > >>> +             return -EBUSY;
> > > >>> +     }
> > > >>
> > > >> Does above cq->resize_umem checking has any conconcurrent protecti=
on
> > > >> again the bnxt_re_resize_cq_complete() called by bnxt_re_poll_cq()=
?
> > > >>
> > > >> bnxt_re_resize_cq() seems like a control path operation, while
> > > >> bnxt_re_poll_cq() seems like a data path operation, I am not sure
> > > >> there is any conconcurrent protection between them.
> > > >>
> > > > The previous check is to prevent simultaneous  resize_cq context fr=
om
> > > > the user application.
> > > >
> > > >  if you see the library implementation (PR
> > > > https://github.com/linux-rdma/rdma-core/pull/1315), entire operatio=
n
> > > > is done in the single resize_cq context from application
> > > > i.e.
> > > > bnxt_re_resize_cq
> > > >  -> ibv_cmd_resize_cq
> > > >                   call driver bnxt_re_resize_cq and return
> > > >   -> poll out the current completions and store it in a user lib li=
st
> > > >   -> issue an ibv_cmd_poll_cq.
> > > >         This will invoke bnxt_re_poll_cq in the kernel driver. We f=
ree
> > > > the previous cq resources.
> > > >
> > > > So the synchronization between resize_cq and poll_cq is happening i=
n
> > > > the user lib. We can free the old CQ  only after user land sees the
> > > > final Completion on the previous CQ. So we return from the driver's
> > > > bnxt_re_resize_cq and then poll for all completions and then use
> > > > ibv_cmd_poll_cq as a hook to reach the kernel driver and free the o=
ld
> > > > CQ's resource.
> > > >
> > > > Summarize, driver's bnxt_re_poll_cq for user space CQs will be call=
ed
> > > > only from resize_cq context and no concurrent protection required i=
n
> > > > the driver.
> > >
> > > Is it acceptable to depend on the user space code to ensure the corre=
ct
> > > order in the kernel space?
> > > Isn't that may utilized by some malicious user to crash the kernel?
> > >
> > The user space code I mentioned is implemented in the provider/bnxt_re
> > user library just
> > like any other verb interface. Apps shall always go through this
> > library to send request
> > to the provider driver.
>
> And if I use my own version of provider/bnxt_re, will kernel crash?
No.. it will not. It can cause a memory leak if the provider/bnxt_re
doesn't call ibv_cmd_poll_cq after the ibv_cmd_resize_cq.
As per the HW design, freeing the old CQ resources can happen only
after the HW generates a cut off completion entry
on the CQ which is getting resized.  This needs to be polled by the
user library. Once the user lib sees the cut off completion, we
issue an ibv_cmd_poll_cq from the library to invoke the driver and
free the old CQ resource.
>
> Thanks

--0000000000001b342605f743e88b
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEi7Qz2LeU0Q
2F4QVW4w88C6CYU8r3l2jmza33EETro3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMxOTE3MTE1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDBUzT2MN3+3n6LYvsXf3EZj4pkaaGG
qmXSLbfjBYbjt/P7DaPmVVBDv3cRQN6jMdUdpwGKUhPJdwYzCcfkLeJp0c6RYuby2SZYTG6W6VYl
iqIb6tAyDu0jQIfdZ+I8k8O2WMKwNikOEy9DsM93OI2pznifdChVHJkoJXP+2LHQO3WPSeZAB1Q0
Y2YMYNPKbUAtk/K7Ugtwgy3mX4vabNWFXRvfuTBO4HRCk466H61IR8sK3iP+dB+v75UEuoA2Z/u7
CBhKMItbsa7KmL5Gz7mdCOaS3wl1PwvFj870iyMSM5/FEfv16Gh/pUHxdN9cCdyO/U1SJKYm3c9M
ack8/+3z
--0000000000001b342605f743e88b--
