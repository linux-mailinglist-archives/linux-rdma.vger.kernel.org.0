Return-Path: <linux-rdma+bounces-4638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3696493A
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 16:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACA11C22D34
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC91B1507;
	Thu, 29 Aug 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PLFdfkAN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8281B14F0
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943311; cv=none; b=H46aoRXYHjzTqbWysceLehqD/aZu64V9ZBUAgRRH5WEiLFhwVIXJD6Nw3YbtE48Si0wjga6vg6qFR1FNVZDLm5w2QkmzJq/lhbyKE43ty9ot1WYGuHcZgAhxcd+54EG3Qf3455n6hK7D+qjdv1/eLsEcCFE7gSors9HLl+Tnmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943311; c=relaxed/simple;
	bh=V0JVQPKD4J1q6pen/aVkzMjA6jWGhzrEnEeCWsTkL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEZrRSjICkmYyMDjmtrFl+Q+BfDnmLD6Pe7Vi/Yr1sHYugs/kZcgSVE8PAaS5px9Rh6PD2nwIPi7Q9Xyxaw+D36iYGk1oWiCafUYrIngKTa1Cq8J9wmrjJj3BwWNLaHEMccpBMsfAs4jfyBWdviksaeO/uy5av5xqyjmdYbQl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PLFdfkAN; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e13e11b23faso768697276.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724943308; x=1725548108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GR94lMQ+RlQsOppW/t0TRRuGhi0LHMYEjo/FxsFpwX8=;
        b=PLFdfkANYPFCppj0+RLNDrxAc5tZWMqdBmV94LOwRBRMHsyImPQaVSfOmd3JfLBwDH
         clIH4nniguW9gmrMuBxRrorPZ285bI4BndJV4p+iaEscbVGzdPni6lR33oUqXnTtAIXs
         F6c4aoUBHmFvDxfgIhbDukicernxzY05UHRa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943308; x=1725548108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GR94lMQ+RlQsOppW/t0TRRuGhi0LHMYEjo/FxsFpwX8=;
        b=FjDeAZ8q1vNtbngijFYzUCegQ+0Q4GhmWofEzipnOQaTg61L+bqfe5mhV2zzKQpW5t
         GkruGbG5NlNU1aDUD+vQtQQDPNYizcYYoWwg+4v7K+8KMt8rB8469eTqsHgFLl9mhj34
         AGXs1/J9EMvnpIC2SoEdhM4V0ynm7GWk7+0L8BJkfI9m3ZLt25fKLEypw/ZLoKAJBPUD
         ZXnrpm1cY9YkTziRcjXvNBGssTH60LW5fHjQ99NvRP1JNEnxj05/F3bUrlBPMaYvfsbd
         lTlIuQFqLAd4l6fplJWHBVol41xDb0xPA4Fv+cs2KNBANi76iEr3L/0aRHLqrFOi92TL
         20Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUDDM6J6HWouCcVottjkNuJ4zcDNxj0eyKmJKQPg5kc2CMfQJ9UaX0c/z+YGOU/hq8Q6AqfQ/0aJvM4@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPkeczFCV5XZUv5H8T6BtOCn36X29tWoQoXuVLVNsX5/PyaqI
	teiyEkQ+dSeW0reiP8J9G1MN+9lXCiXoA9Baw7RsB8wW7KqJtW/+7FFamEaJR20U0dIVRWSgdYv
	NUv3s6MKmu9MVmF82Ycg8qjsqEZPztD4GOiY0
X-Google-Smtp-Source: AGHT+IF85DX1MBZjGQjHemrwxN76gLTRFBtnLrjuvcuQ/zQ3qaDyNeJlz7NCFKxj03/09Im0mFXK7xXju3PGFm/7Vos=
X-Received: by 2002:a05:6902:91b:b0:e11:7b7d:bd3a with SMTP id
 3f1490d57ef6-e1a5af0dc99mr3108043276.36.1724943307773; Thu, 29 Aug 2024
 07:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
 <1724834832-10600-4-git-send-email-selvin.xavier@broadcom.com> <20240829110303.GF26654@unreal>
In-Reply-To: <20240829110303.GF26654@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 29 Aug 2024 20:24:56 +0530
Message-ID: <CA+sbYW09eAjmi1xrN1jnCDDau6uB0htF-i+bpyeO=XaAHQ34xg@mail.gmail.com>
Subject: Re: [PATCH for-next 3/3] RDMA/bnxt_re: Share a page to expose per SRQ
 info with userspace
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	chandramohan.akula@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002660cd0620d3a9ce"

--0000000000002660cd0620d3a9ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:33=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Aug 28, 2024 at 01:47:12AM -0700, Selvin Xavier wrote:
> > From: Chandramohan Akula <chandramohan.akula@broadcom.com>
> >
> > Gen P7 adapters needs to share a toggle bits information received
> > in kernel driver with the user space. User space needs this
> > info to arm the SRQ.
> >
> > User space application can get this page using the
> > UAPI routines. Library will mmap this page and get the
> > toggle bits to be used in the next ARM Doorbell.
> >
> > Uses a hash list to map the SRQ structure from the SRQ ID.
> > SRQ structure is retrieved from the hash list while the
> > library calls the UAPI routine to get the toggle page
> > mapping. Currently the full page is mapped per SRQ. This
> > can be optimized to enable multiple SRQs from the same
> > application share the same page and different offsets
> > in the page
> >
> > Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 ++++++++++++++++++++++++=
+++++++-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
> >  drivers/infiniband/hw/bnxt_re/main.c     |  6 +++++-
> >  include/uapi/rdma/bnxt_re-abi.h          |  5 +++++
> >  5 files changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniba=
nd/hw/bnxt_re/bnxt_re.h
> > index 0912d2f..2be9a62 100644
> > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -141,6 +141,7 @@ struct bnxt_re_pacing {
> >  #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
> >
> >  #define MAX_CQ_HASH_BITS             (16)
> > +#define MAX_SRQ_HASH_BITS            (16)
> >  struct bnxt_re_dev {
> >       struct ib_device                ibdev;
> >       struct list_head                list;
> > @@ -196,6 +197,7 @@ struct bnxt_re_dev {
> >       struct work_struct dbq_fifo_check_work;
> >       struct delayed_work dbq_pacing_work;
> >       DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
> > +     DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
> >  };
> >
> >  #define to_bnxt_re_dev(ptr, member)  \
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index 1e76093..0219c8a 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -1685,6 +1685,10 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, s=
truct ib_udata *udata)
> >
> >       if (qplib_srq->cq)
> >               nq =3D qplib_srq->cq->nq;
> > +     if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT=
) {
> > +             free_page((unsigned long)srq->uctx_srq_page);
> > +             hash_del(&srq->hash_entry);
> > +     }
> >       bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
> >       ib_umem_release(srq->umem);
> >       atomic_dec(&rdev->stats.res.srq_count);
> > @@ -1789,9 +1793,18 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
> >       }
> >
> >       if (udata) {
> > -             struct bnxt_re_srq_resp resp;
> > +             struct bnxt_re_srq_resp resp =3D {};
> >
> >               resp.srqid =3D srq->qplib_srq.id;
> > +             if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TO=
GGLE_BIT) {
> > +                     hash_add(rdev->srq_hash, &srq->hash_entry, srq->q=
plib_srq.id);
> > +                     srq->uctx_srq_page =3D (void *)get_zeroed_page(GF=
P_KERNEL);
> > +                     if (!srq->uctx_srq_page) {
> > +                             rc =3D -ENOMEM;
> > +                             goto fail;
> > +                     }
> > +                     resp.comp_mask |=3D BNXT_RE_SRQ_TOGGLE_PAGE_SUPPO=
RT;
> > +             }
> >               rc =3D ib_copy_to_udata(udata, &resp, sizeof(resp));
> >               if (rc) {
> >                       ibdev_err(&rdev->ibdev, "SRQ copy to udata failed=
!");
> > @@ -4266,6 +4279,19 @@ static struct bnxt_re_cq *bnxt_re_search_for_cq(=
struct bnxt_re_dev *rdev, u32 cq
> >       return cq;
> >  }
> >
> > +static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *=
rdev, u32 srq_id)
> > +{
> > +     struct bnxt_re_srq *srq =3D NULL, *tmp_srq;
> > +
> > +     hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_i=
d) {
> > +             if (tmp_srq->qplib_srq.id =3D=3D srq_id) {
> > +                     srq =3D tmp_srq;
> > +                     break;
> > +             }
> > +     }
> > +     return srq;
> > +}
> > +
> >  /* Helper function to mmap the virtual memory from user app */
> >  int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *v=
ma)
> >  {
> > @@ -4494,6 +4520,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGG=
LE_MEM)(struct uverbs_attr_bund
> >       struct bnxt_re_ucontext *uctx;
> >       struct ib_ucontext *ib_uctx;
> >       struct bnxt_re_dev *rdev;
> > +     struct bnxt_re_srq *srq;
> >       u32 length =3D PAGE_SIZE;
> >       struct bnxt_re_cq *cq;
> >       u64 mem_offset;
> > @@ -4525,6 +4552,11 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOG=
GLE_MEM)(struct uverbs_attr_bund
> >               addr =3D (u64)cq->uctx_cq_page;
> >               break;
> >       case BNXT_RE_SRQ_TOGGLE_MEM:
> > +             srq =3D bnxt_re_search_for_srq(rdev, res_id);
> > +             if (!srq)
> > +                     return -EINVAL;
> > +
> > +             addr =3D (u64)srq->uctx_srq_page;
> >               break;
> >
> >       default:
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.h
> > index 4e113b9..9c74dfe 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> > @@ -78,6 +78,7 @@ struct bnxt_re_srq {
> >       struct ib_umem          *umem;
> >       spinlock_t              lock;           /* protect srq */
> >       void                    *uctx_srq_page;
> > +     struct hlist_node       hash_entry;
> >  };
> >
> >  struct bnxt_re_qp {
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index 9714b9a..1211fe5 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -139,8 +139,10 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_de=
v *rdev, u8 mode)
> >       if (bnxt_re_hwrm_qcaps(rdev))
> >               dev_err(rdev_to_dev(rdev),
> >                       "Failed to query hwrm qcaps\n");
> > -     if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx))
> > +     if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx)) {
> >               cctx->modes.toggle_bits |=3D BNXT_QPLIB_CQ_TOGGLE_BIT;
> > +             cctx->modes.toggle_bits |=3D BNXT_QPLIB_SRQ_TOGGLE_BIT;
> > +     }
> >  }
> >
> >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> > @@ -1771,6 +1773,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *r=
dev, u8 wqe_mode)
> >               bnxt_re_vf_res_config(rdev);
> >       }
> >       hash_init(rdev->cq_hash);
> > +     if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT=
)
> > +             hash_init(rdev->srq_hash);
> >
> >       return 0;
> >  free_sctx:
> > diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_r=
e-abi.h
> > index e61104f..84917a9 100644
> > --- a/include/uapi/rdma/bnxt_re-abi.h
> > +++ b/include/uapi/rdma/bnxt_re-abi.h
> > @@ -134,8 +134,13 @@ struct bnxt_re_srq_req {
> >       __aligned_u64 srq_handle;
> >  };
> >
> > +enum bnxt_re_srq_mask {
> > +     BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT =3D 0x1,
> > +};
> > +
> >  struct bnxt_re_srq_resp {
> >       __u32 srqid;
>
> I think that you should add __u32 reserved field here to align the
> struct.
Sure. will post a v2 soon.

Thanks,
>
> > +     __aligned_u64 comp_mask;
> >  };
> >
> >  enum bnxt_re_shpg_offt {
> > --
> > 2.5.5
> >

--0000000000002660cd0620d3a9ce
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ04lWoi6U2H
ADGT7dg19DE4NTGhQQGth0o3s21zpxBgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDgyOTE0NTUwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCjl2eIOgK+9xSRtg7oBsdsOHCbB+Co
rwZ5tUcZs8c+gu+dkSXqJm7zkxQk1j3euM3FQ7UkIF0D2BOwuK231qkiMxvy06JXbCJDqSuNKZCH
ZnM2T8R4/NQKdsmUm+LkLfa4l08XsafZuSCr81RePdHw+9mBKx2ul9V/qEBXWNR2xzMcKrxWBy6J
vCW3W648G1paG7Zv2+8uTXxr97QPzEYuGoe1uJvmswAypZQZOydW1IUplRGo8XPdhP86enBQC4Vc
4tOGgA+Euk4X90GiirBxCOyoSFr7CkrJtB6Bf53PHjGpIBQw16oE8CRSe6dCZIXsBertHkfCTWEp
w+jrNI8w
--0000000000002660cd0620d3a9ce--

