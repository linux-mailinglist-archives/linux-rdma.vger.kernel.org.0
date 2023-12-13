Return-Path: <linux-rdma+bounces-406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBA0810C92
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 09:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030CA281C0E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EAA1CF94;
	Wed, 13 Dec 2023 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G93RghRX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB1A5
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 00:38:47 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3758fdd2eso65271867b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 00:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702456726; x=1703061526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0HH/yYB9vz6DbZSIrxN+9CE4LKS/XF+Fo9VxqcXnS0=;
        b=G93RghRXKbm83tkbcGJcmk3rKaw4vb3or9dGOAHQW7cfxRpFErIgEn2boDi5ASrCPZ
         F1dZGk483iHH4Xpcy4Gfu1zWJuGUNNDdsNQnMrt5Va3m4m/hHZnT4eg+cxmwObGeDj/o
         /ReqdKB5vXWoc/AQFKUka7a/4cv0MLz40aA9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702456726; x=1703061526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0HH/yYB9vz6DbZSIrxN+9CE4LKS/XF+Fo9VxqcXnS0=;
        b=r6Tc0jUUg5lUEq/1GSwARP7yotQhMP6OJW5mxiSGYK24yOLtNYnbq7YY4hw+NNTMNk
         b6yeviOO3e+5wj1t2an8sLqQ9nJRsKEwfMEU4gwMxEIrfSJVV9XrmUrUOmptFiMlx7rY
         EwbDth2BNSUHszpCwbLLAeqq3s3whWXg/LSAW8deSKbSGv4KOh/I5pV5L5IOWVEYbdjl
         3y1/o7BVgiBh/ss1gGWzhODuRfrnn4PiLH7aenlI7ABJbO7YjCmX3nPMD4KglzATWrl+
         oBZTp7790sooIMe6h2Tlan/041BGPSnkZf8146g88psOAxdojZv/fKd4zhhcGuhb7NNp
         dhVw==
X-Gm-Message-State: AOJu0Ywjv4Qlc43uxusf+UpO1ixCAIiZaIjemSmJEW+JjuHsQmLppWS2
	yciBqwyTnCAQ1qh5U+anboSwRW7u5pBm4LRv7unfNw==
X-Google-Smtp-Source: AGHT+IEoRvhUNKAHhWiS2YQm0NmiqGtycISIcbAI8oCJ+d/wAzNImS1Pd0NunY6fvyuW+FEquG7xF+/gPp8YrH14rew=
X-Received: by 2002:a81:df03:0:b0:5d6:1183:d786 with SMTP id
 c3-20020a81df03000000b005d61183d786mr5577315ywn.14.1702456726153; Wed, 13 Dec
 2023 00:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702438411-23530-1-git-send-email-selvin.xavier@broadcom.com>
 <1702438411-23530-3-git-send-email-selvin.xavier@broadcom.com> <20231213082007.GN4870@unreal>
In-Reply-To: <20231213082007.GN4870@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 13 Dec 2023 14:08:34 +0530
Message-ID: <CA+sbYW0Vkp3+=00fh_zDiR7K5F3DOo4pyD_U-pSKfcRacnVLcg@mail.gmail.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Share a page to expose per CQ
 info with userspace
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006e4b10060c6018b6"

--0000000000006e4b10060c6018b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:50=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Dec 12, 2023 at 07:33:31PM -0800, Selvin Xavier wrote:
> > Gen P7 adapters needs to share a toggle bits information received
> > in kernel driver with the user space. User space needs this
> > info during the request notify call back to arm the CQ.
> >
> > User space application can get this page using the
> > UAPI routines. Library will mmap this page and get the
> > toggle bits to be used in the next ARM Doorbell.
> >
> > Uses a hash list to map the CQ structure from the CQ ID.
> > CQ structure is retrieved from the hash list while the
> > library calls the UAPI routine to get the toggle page
> > mapping. Currently the full page is mapped per CQ. This
> > can be optimized to enable multiple CQs from the same
> > application share the same page and different offsets
> > in the page.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  3 ++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 59 +++++++++++++++++++++++=
++++----
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  2 ++
> >  drivers/infiniband/hw/bnxt_re/main.c      | 10 +++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
> >  include/uapi/rdma/bnxt_re-abi.h           |  5 +++
> >  6 files changed, 77 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniba=
nd/hw/bnxt_re/bnxt_re.h
> > index 9fd9849..9dca451 100644
> > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -41,6 +41,7 @@
> >  #define __BNXT_RE_H__
> >  #include <rdma/uverbs_ioctl.h>
> >  #include "hw_counters.h"
> > +#include <linux/hashtable.h>
> >  #define ROCE_DRV_MODULE_NAME         "bnxt_re"
> >
> >  #define BNXT_RE_DESC "Broadcom NetXtreme-C/E RoCE Driver"
> > @@ -135,6 +136,7 @@ struct bnxt_re_pacing {
> >  #define BNXT_RE_DB_FIFO_ROOM_SHIFT 15
> >  #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
> >
> > +#define MAX_CQ_HASH_BITS             (16)
> >  struct bnxt_re_dev {
> >       struct ib_device                ibdev;
> >       struct list_head                list;
> > @@ -189,6 +191,7 @@ struct bnxt_re_dev {
> >       struct bnxt_re_pacing pacing;
> >       struct work_struct dbq_fifo_check_work;
> >       struct delayed_work dbq_pacing_work;
> > +     DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
> >  };
> >
> >  #define to_bnxt_re_dev(ptr, member)  \
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index 76cea30..de3d404 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -50,6 +50,7 @@
> >  #include <rdma/ib_mad.h>
> >  #include <rdma/ib_cache.h>
> >  #include <rdma/uverbs_ioctl.h>
> > +#include <linux/hashtable.h>
> >
> >  #include "bnxt_ulp.h"
> >
> > @@ -2910,14 +2911,20 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, cons=
t struct ib_recv_wr *wr,
> >  /* Completion Queues */
> >  int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
> >  {
> > -     struct bnxt_re_cq *cq;
> > +     struct bnxt_qplib_chip_ctx *cctx;
> >       struct bnxt_qplib_nq *nq;
> >       struct bnxt_re_dev *rdev;
> > +     struct bnxt_re_cq *cq;
> >
> >       cq =3D container_of(ib_cq, struct bnxt_re_cq, ib_cq);
> >       rdev =3D cq->rdev;
> >       nq =3D cq->qplib_cq.nq;
> > +     cctx =3D rdev->chip_ctx;
> >
> > +     if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
> > +             free_page((unsigned long)cq->uctx_cq_page);
> > +             hash_del(&cq->hash_entry);
> > +     }
> >       bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
> >       ib_umem_release(cq->umem);
> >
> > @@ -2935,10 +2942,11 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const=
 struct ib_cq_init_attr *attr,
> >       struct bnxt_re_ucontext *uctx =3D
> >               rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,=
 ib_uctx);
> >       struct bnxt_qplib_dev_attr *dev_attr =3D &rdev->dev_attr;
> > -     int rc, entries;
> > -     int cqe =3D attr->cqe;
> > +     struct bnxt_qplib_chip_ctx *cctx;
> >       struct bnxt_qplib_nq *nq =3D NULL;
> >       unsigned int nq_alloc_cnt;
> > +     int rc =3D -1, entries;
>
> Why -1 and not some -EXXX value?
Sure.  I will update it to an error value.
>
> > +     int cqe =3D attr->cqe;
> >       u32 active_cqs;
> >
> >       if (attr->flags)
> > @@ -2951,6 +2959,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const s=
truct ib_cq_init_attr *attr,
> >       }
> >
> >       cq->rdev =3D rdev;
> > +     cctx =3D rdev->chip_ctx;
> >       cq->qplib_cq.cq_handle =3D (u64)(unsigned long)(&cq->qplib_cq);
> >
> >       entries =3D bnxt_re_init_depth(cqe + 1, uctx);
> > @@ -3012,8 +3021,16 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const =
struct ib_cq_init_attr *attr,
> >       spin_lock_init(&cq->cq_lock);
> >
> >       if (udata) {
> > -             struct bnxt_re_cq_resp resp;
> > -
> > +             struct bnxt_re_cq_resp resp =3D {};
> > +
> > +             if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
>
> This bit is set for all gen_p7 cards, but bnxt_re_cq_resp doesn't have
> comp_mask field in old rdma-core and it will cause to ib_copy_to_udata()
> fail, isn't it?
Yes. I should have used min of (resp_size and outlen) like below. Will
change it.
 rc =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
>
> > +                     hash_add(rdev->cq_hash, &cq->hash_entry, cq->qpli=
b_cq.id);
> > +                     /* Allocate a page */
> > +                     cq->uctx_cq_page =3D (void *)get_zeroed_page(GFP_=
KERNEL);
> > +                     if (!cq->uctx_cq_page)
> > +                             goto c2fail;
> > +                     resp.comp_mask |=3D BNXT_RE_CQ_TOGGLE_PAGE_SUPPOR=
T;
> > +             }
>
> Thanks

--0000000000006e4b10060c6018b6
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHkVEcsgVqmK
1YNIW35RPkgCo7FVn9vgCbYAx5hm5cuSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIxMzA4Mzg0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMogEqtPvfIhGm3qRvp7HxENSqLk2Y
XkDpxbw8V4k0Sq0pY0Qb9wjYAVZ0u2dyth+RkuD/UukOfe799DefRcr3dgkk63oAoVNlXvu6JkmP
TfiYIMMHOfJAtkIUs8xAcA3QmIIWZdboRMHra+v1yBhGmYLsQg0g9beF5dL55i30wIxtCvWGKf/w
gka3Yq9ogj8vBrXyHhTwT8xUYL7nnuZK31RdBCffNLIIFxzXhXBOJdLUebbSnUbN9hKRi+Ge8h36
qNjWER1bfs9P3B/TNuJfRm5EO7QPmHowWy0tqce+2Z5+4jhJOIZpHmbInU8SPIzZhwIdykjnjD8q
AI1qEaxP
--0000000000006e4b10060c6018b6--

