Return-Path: <linux-rdma+bounces-10243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC919AB2212
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FD718973B5
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2931E5202;
	Sat, 10 May 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMwd5N5L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5840C03;
	Sat, 10 May 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746864268; cv=none; b=OE+/NS/oMjOJhrbCdF0yMYZ4Daf9B8Em1iZr0x+pat8g2XyOgC/SzFwUDFdsYr4ThIfaZz9syUN/HH7UovN/4FajJzH+GrGaB3LM0HsUJ3nNJIZkmVAQnPNRwt3j3isuc7ctZU6t/ASaJnmWdUZiN14SepbixjmpzBs5anoDsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746864268; c=relaxed/simple;
	bh=NS2J0l9nITmHR8VYe7raHoZbpTph6XlYXE48AWOCqZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGOsP0VUn6YgdpoSmkM61sH9y1vRGZ4VclZ+YHWDHDIw2Tht+rJ+ne9HzpTymmizlH1cLHAAvKYwlTslVAYHiGdfu28W27TsknJZr2SHpOqu5Wpch8VDeVJN3LDuAOWbojpmfq+ZN72vpb97r39N2es/oWBxpEXWp30dZ+J04uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMwd5N5L; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2d060c62b61so3004447fac.0;
        Sat, 10 May 2025 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746864265; x=1747469065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG3Rvk+zkbupohXVIwtL9ONUTrTSnn9/n0L07AiGCLo=;
        b=jMwd5N5LurNjvUcGLx4ggs8UXWwCVXM9HtKToDIWLeQAnNZYQ1Zwt4beqmbNciDrjX
         LxYEOMlzlKzY3SwwDwhN0hvcGsYoYF0S1oAj/Mhd/tUrRqgCnV9gU+bSki55LjSDziWk
         ogW3NZ39nNeE1sfK9++wANrmsU/ycqaPHu3jIn0zpfpwXkAn7xeDArUAwkJTsrx/Eb2j
         2i+LuH1xkzL9QxrjkTa3uZSw7LXYwrV1sEqcCiUtENklLsP/4oKqc9P+5BJyCDqAIbZu
         htnaMJgd+iB3OBQKkVhoHpXoOGL9ph7IouGXmxHFPRt8yKlebSYHPrMne4fgUj/zrvIf
         37Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746864265; x=1747469065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG3Rvk+zkbupohXVIwtL9ONUTrTSnn9/n0L07AiGCLo=;
        b=srARraN81fn5fpxYuv2pOcMPQKSbsz6017dr+xDcduhcB4RA2uin3vqCkOEd4nYWTX
         H84VwKUHc49mJ8trjkry54lM5rTDeT3NE77gfoYSmnJ0aeirh1aVZOrmLfORVb0fLJ/i
         Ztzjq9OrKTR77YYBW4wjggzW1Z/2JqpjC3UhO6lgj2j36GXoSYGHAFGCGl0mXGBL3nX7
         Dx+RjQS1u/jK+B9U80i+heh0zRgvAIMklisJfLxRIrQp4vr8On/vQyVBiZM6hi5yJcDI
         9B9RlqI9X5PV02NdH/Fb29SBW4m5E/YyXxmXp+OaDJUwlsM3qwCRIN4OBPiEj/HOvWlz
         Y4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfCjCHJSlP/xOmaZCWH0GG2a28aDEKLgZGwlxqGnlnjbaENoENIEAk2u8QzSJsIXbwy69bz44arOyqPMk=@vger.kernel.org, AJvYcCXjC1snQvrBZFVaySDJcKSQ1qpDc22x2dBXvsM8RQzmGlOPHOtbeDJpmcz9Hwzy65txV+5gR/UIpikIDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeG32m/n7ehYSN+zl9F9GoE/LB7c7zqZ+KTJ17zQIdyuSfV9yI
	RJ3c+RJV5I1Ijy85rCKxzxfyFOu2lJsTd6QKyQX8wpImF6rmEy6+M2XJYJfI7s7vhZET9khT/bw
	MIcKNGAfCslqmkU6XJXVUv6WXPnM=
X-Gm-Gg: ASbGncuFYJCRC/UailTYGt+iFGOB/HQGF57X7TRY883ylg0GJfmnjz+YDs18aPWSTPq
	9u6KBv/O8tYl6S9AG9npE3A4KNa1wcCVjs7qLi50rI68L3XChbRVABi+P02PO+TvjAux9htJ32R
	BkrCr4U5I5FrSiF107RXdIsb6A8Pg9RJyZ
X-Google-Smtp-Source: AGHT+IES67AYMbfNUQ6RX7BkGmbn5YkJv4XXFPuofKoShJ5NJ14HSztH5+ztfneBhf0kFQYlP2IYw4r/6PRSwmRcBl0=
X-Received: by 2002:a05:6870:2007:b0:29e:74a0:e03f with SMTP id
 586e51a60fabf-2dba44c620cmr3525356fac.24.1746864265309; Sat, 10 May 2025
 01:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503134224.4867-1-dskmtsd@gmail.com> <20250503134224.4867-2-dskmtsd@gmail.com>
 <cdea578b-5570-4a8d-98cc-61081a281a84@linux.dev> <b5560914-e613-499d-88c8-82f5255a1dd1@gmail.com>
 <093ee42f-4dd5-4f52-b7a5-ba5e22b18bdc@linux.dev> <e07e0ad8-32da-452e-809a-f3dfeb8b56f3@gmail.com>
In-Reply-To: <e07e0ad8-32da-452e-809a-f3dfeb8b56f3@gmail.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Sat, 10 May 2025 16:04:12 +0800
X-Gm-Features: AX0GCFtQh2B07-CPbuX69PIm2Lav2H8oAlf_FXgb7nozCu78Q1lN3S6gz8I-0q8
Message-ID: <CAEz=LcutW6BZKB-Def3HmV=WrzjKjmAt_WnxPw3Yu45CoV0+Hw@mail.gmail.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/rxe: Implement synchronous prefetch
 for ODP MRs
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca, 
	zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 3:19=E2=80=AFPM Daisuke Matsuda <dskmtsd@gmail.com>=
 wrote:
>
> On 2025/05/10 13:43, Zhu Yanjun wrote:
> >
> > =E5=9C=A8 2025/5/10 4:46, Daisuke Matsuda =E5=86=99=E9=81=93:
> >> On 2025/05/10 0:19, Zhu Yanjun wrote:
> >>> On 03.05.25 15:42, Daisuke Matsuda wrote:
> >>>> Minimal implementation of ibv_advise_mr(3) requires synchronous call=
s being
> >>>> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requ=
ests,
> >>>> which are best-effort, will be added subsequently.
> >>>>
> >>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> >>>> ---
> >>>>   drivers/infiniband/sw/rxe/rxe.c     |  7 +++
> >>>>   drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
> >>>>   drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++=
++++
> >>>>   3 files changed, 103 insertions(+)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw=
/rxe/rxe.c
> >>>> index 3a77d6db1720..e891199cbdef 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
> >>>> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
> >>>>       mutex_destroy(&rxe->usdev_lock);
> >>>>   }
> >>>> +static const struct ib_device_ops rxe_ib_dev_odp_ops =3D {
> >>>> +    .advise_mr =3D rxe_ib_advise_mr,
> >>>> +};
> >>>> +
> >>>>   /* initialize rxe device parameters */
> >>>>   static void rxe_init_device_param(struct rxe_dev *rxe, struct net_=
device *ndev)
> >>>>   {
> >>>> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev=
 *rxe, struct net_device *ndev)
> >>>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_=
ODP_SUPPORT_SRQ_RECV;
> >>>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_=
ODP_SUPPORT_FLUSH;
> >>>>           rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_=
ODP_SUPPORT_ATOMIC_WRITE;
> >>>> +
> >>>> +        /* set handler for ODP prefetching API - ibv_advise_mr(3) *=
/
> >>>> +        ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
> >>>>       }
> >>>>   }
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniban=
d/sw/rxe/rxe_loc.h
> >>>> index f7dbb9cddd12..21b070f3dbb8 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> >>>> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr=
 *mr, u64 iova, int opcode,
> >>>>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
> >>>>                   unsigned int length);
> >>>>   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 io=
va, u64 value);
> >>>> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_adv=
ice advice,
> >>>> +             u32 flags, struct ib_sge *sg_list, u32 num_sge,
> >>>> +             struct uverbs_attr_bundle *attrs);
> >>>>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
> >>>>   static inline int
> >>>>   rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u=
64 iova,
> >>>> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomi=
c_write(struct rxe_mr *mr,
> >>>>   {
> >>>>       return RESPST_ERR_UNSUPPORTED_OPCODE;
> >>>>   }
> >>>> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs=
_advise_mr_advice advice,
> >>>> +                   u32 flags, struct ib_sge *sg_list, u32 num_sge,
> >>>> +                   struct uverbs_attr_bundle *attrs)
> >>>> +{
> >>>> +    return -EOPNOTSUPP;
> >>>> +}
> >>>> +
> >>>>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
> >>>>   #endif /* RXE_LOC_H */
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniban=
d/sw/rxe/rxe_odp.c
> >>>> index 6149d9ffe7f7..e5c60b061d7e 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> >>>> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct=
 rxe_mr *mr, u64 iova, u64 value)
> >>>>       return RESPST_NONE;
> >>>>   }
> >>>> +
> >>>> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
> >>>> +                   enum ib_uverbs_advise_mr_advice advice,
> >>>> +                   u32 pf_flags, struct ib_sge *sg_list,
> >>>> +                   u32 num_sge)
> >>>> +{
> >>>> +    struct rxe_pd *pd =3D container_of(ibpd, struct rxe_pd, ibpd);
> >>>> +    unsigned int i;
> >>>> +    int ret =3D 0;
> >>>> +
> >>>> +    for (i =3D 0; i < num_sge; ++i) {
> >>>> +        struct rxe_mr *mr;
> >>>> +        struct ib_umem_odp *umem_odp;
> >>>> +
> >>>> +        mr =3D lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
> >>>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
> >>>> +
> >>>> +        if (IS_ERR(mr)) {
> >>>> +            rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i=
].lkey);
> >>>> +            return PTR_ERR(mr);
> >>>> +        }
> >>>> +
> >>>> +        if (advice =3D=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE=
 &&
> >>>> +            !mr->umem->writable) {
> >>>> +            rxe_dbg_mr(mr, "missing write permission\n");
> >>>> +            rxe_put(mr);
> >>>> +            return -EPERM;
> >>>> +        }
> >>>> +
> >>>> +        ret =3D rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
> >>>> +                            sg_list[i].length, pf_flags);
> >>>> +        if (ret < 0) {
> >>>> +            if (sg_list[i].length =3D=3D 0)
> >>>> +                continue;
> >>>> +
> >>>> +            rxe_dbg_mr(mr, "failed to prefetch the mr\n");
> >>>> +            rxe_put(mr);
> >>>> +            return ret;
> >>>> +        }
> >>>> +
> >>>> +        umem_odp =3D to_ib_umem_odp(mr->umem);
> >>>> +        mutex_unlock(&umem_odp->umem_mutex);
> >>>> +
> >>>> +        rxe_put(mr);
> >>>> +    }
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
> >>>> +                     enum ib_uverbs_advise_mr_advice advice,
> >>>> +                     u32 flags, struct ib_sge *sg_list, u32 num_sge=
)
> >>>> +{
> >>>> +    u32 pf_flags =3D RXE_PAGEFAULT_DEFAULT;
> >>>> +
> >>>> +    if (advice =3D=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
> >>>> +        pf_flags |=3D RXE_PAGEFAULT_RDONLY;
> >>>> +
> >>>> +    if (advice =3D=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
> >>>> +        pf_flags |=3D RXE_PAGEFAULT_SNAPSHOT;
> >>>> +
> >>>> +    /* Synchronous call */
> >>>> +    if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
> >>>> +        return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_l=
ist,
> >>>> +                           num_sge);
> >>>> +
> >>>> +    /* Asynchronous call is "best-effort" */
> >>>
> >>> Asynchronous call is not implemented now, why does this comment appea=
r?
> >>
> >> Even without the 2nd patch, async calls are reported as successful.
> >
> >
> > Async call is not implemented. How to call "async calls are reported as=
 successful"?
>
> Please see the manual.
> cf. https://manpages.debian.org/testing/libibverbs-dev/ibv_advise_mr.3.en=
.html
>
> If IBV_ADVISE_MR_FLAG_FLUSH is not given to 'flags' parameter,
> then this function 'rxe_ib_advise_mr_prefetch()' simply returns 0.
> Consequently, ibv_advise_mr(3) and underlying ioctl(2) get no error.
> This behaviour is allowd in the spec as I quoted in the last reply.

The functionality wasn't implemented, you added the comments first.
You're still weaseling when people point this out.

>
> It might be nice to return -EOPNOTSUPP just below the comment instead,
> but not doing so is acceptable according to the spec. Additionally,
> such change will be overwritten in the next patch after all.

Move comments to the next patch. In this patch, return -EOPNOTSUPP.

--G--

>
> Thanks,
> Daisuke
>
> >
> >
> > Zhu Yanjun
> >
> >> The comment is inserted to show the reason, which is based on the
> >> description from 'man 3 ibv_advise_mr' as follows:
> >> =3D=3D=3D
> >> An application may pre-fetch any address range within an ODP MR when u=
sing the IBV_ADVISE_MR_ADVICE_PREFETCH or IBV_ADVISE_MR_ADVICE_PREFETCH_WRI=
TE advice. Semantically, this operation is best-effort. That means the kern=
el does not guarantee that underlying pages are updated in the HCA or the p=
re-fetched pages would remain resident.
> >> =3D=3D=3D
> >>
> >> Thanks,
> >> Daisuke
> >>
> >>>
> >>> Zhu Yanjun
> >>>
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
> >>>> +             enum ib_uverbs_advise_mr_advice advice,
> >>>> +             u32 flags,
> >>>> +             struct ib_sge *sg_list,
> >>>> +             u32 num_sge,
> >>>> +             struct uverbs_attr_bundle *attrs)
> >>>> +{
> >>>> +    if (advice !=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
> >>>> +        advice !=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> >>>> +        advice !=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
> >>>> +        return -EOPNOTSUPP;
> >>>> +
> >>>> +    return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
> >>>> +                     sg_list, num_sge);
> >>>> +}
> >>>
> >>
>
>

