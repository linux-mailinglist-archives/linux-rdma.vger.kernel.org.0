Return-Path: <linux-rdma+bounces-16727-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONiIFmxli2kMUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16727-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:05:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BA11D87F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4DA301D323
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33788326958;
	Tue, 10 Feb 2026 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CDsuXVrC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86090325702
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743127; cv=pass; b=a0yvkY+pMPf+t0UuZqhyQts2OCQ8BliKDmo5uVnbCTrxzyTxWCxzPsnENTbrBvF6SyFDVT2raRmcULpIQU3lagY599T2ZHKTWp+rcI/AaDy3Gfg2R0layLJni9MWJJAWxyFM7gDCDz9kOgPYmdibMrcstG65qe2oTR4GBT4oEdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743127; c=relaxed/simple;
	bh=SJ0GwOplBLSx5+WcE5Atyi9ktd3sJmXbd+9zmDKZxr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcSOxrzj16sBM/Mh+cw+ecMb7JaO4Ee6Yq586i4kKIDwmHkMgSTsWnKVlaI/x3Gu2FjnVSTOcSSHCM0tI7FNsMBtTBGun2/SVb7BVlB2WAKCpiN+tqoINQbgg4F/g7kpkSOKYySA0RZ8RgPL2pIyKYXEVNgTMkzewxYtKfOe0vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CDsuXVrC; arc=pass smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-502a789834fso52521031cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743124; x=1771347924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJcywdF4oZ0v4OgwE5MNvUs4KBqoSR/sY+GXt/vrbGE=;
        b=Lx3YYhQasV+9tNae2FBIVwnZCSzocUw96akA4Whyy7YrXAjPEz8a/AIl985+Qr2g64
         7yO7KkxOZPzOf/7Iy21fK7BhIUbGMnbM6S8ljQtf5vu74OJjmWkgJdVXKjzMr6ymjwSQ
         aOIUbN+LK8w8BQpffMUfyEfursNo1kHh9sDIjMD8cukuYixQq4nNBlqd/9NCwqb3kkIb
         TyjXRukvVmEZsaOGh7akYITKELQbF8mRY7BMQBflI7gJHxocBSXF8ms2JoMiiyB5kk9z
         hO07pSd61JiH/m26TQgOoND3XR05K4+VtaqWGmn14xJjFITrgM72ibUMh9XULtWvtmik
         Fi/g==
X-Forwarded-Encrypted: i=2; AJvYcCUUtwcz+/tGnjrijJtKSg2IzzQD1+jOOrqv2un2cvflcwi0SH+ZJWtdLTYI8A2lCQ1MlJovUbkmeQBd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wXYET1bSezFdKNj6M+Cp7Q6Yp8Nf6HlZJ9Scoay5IoDZh9u8
	qLBttgjg2XOpJfNUGD/Rzt4xQfpB4QZvG7Y4ZHTD8YOuyQX6+79PUPRgVASxC2r1g2KKtN8uxNx
	st3s9bNzdPlTrs6ZzuHYZLV9FfzGTeHt6zlOU0Yf2OprNyOCvg9RU11/MjxGVHA6lCnqmhzd6eu
	YYHVXeoU3oS1Rky8QT2dQxrkXlhGzlU3o8gUv7F+Ng7no9sU6XdF+bxWScTRNGkoPzVqxhqnkQj
	VCnSwufwqL5eHwCjipUATCFtE2A
X-Gm-Gg: AZuq6aJT1rcIChVMBMPJ9GXworT2vu90R0yoLV/GlGORe3sv8N+LHg/m+VZwPvxHw2h
	6I81ocoB4TcI4gWedE0i4Ww42i7h70xF63hmAr4RCoXPAedq5HvbiXUysmVA/V3R0DH1fFUCrNT
	uclFayS/1/l5h8JKM7aX8KBlVfjHfO0zTVzuzxJYjhRnJX7jGmW0liofqGkVaRuxYhx6zA4AU6W
	Hspih1t5kFR3BFz5owQ7iZ6it0pDLNrSDBxhzWSraoQcuVtRbTBUe4NLLcwhyttJMpHjs7U0Mlu
	JeLiGPIHI1Z6ywy6MGRcW+a23bLXlT1fA1p94UXj4eFcFLFnek4ZIORs8vDi5DlQ1inyHqAFQQ1
	0+pGc2LRHIVBcBqsmgA2sD0kOPMvZzXUv2cNy/9ZIVwZ7t0Mucdx3376BcvWHJhJdYxa86jznJX
	13tO1ufXeK9iGC5CSWNk+pxgbXXv1nFF+Zeely5kJ2aQjLxItgcpWJ44aA/8AxtwWskDuFadU=
X-Received: by 2002:a05:622a:2c9:b0:4e8:b446:c023 with SMTP id d75a77b69052e-50673d53f2amr30487851cf.49.1770743123510;
        Tue, 10 Feb 2026 09:05:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8953bf39a88sm21371736d6.13.2026.02.10.09.05.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:05:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4831192e66aso52394255e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770743121; cv=none;
        d=google.com; s=arc-20240605;
        b=D2aaSK0zuPCZyayazKFj+HdPDXlJaExpFNNmOn+/GTVgWrhikAkLy7mMvwKaKsdVIh
         iCx9lwbOUmR7IeqzMEPNjlYmus5APBMi0uxNbmk//+L5NO7kymSATXRVWgf6zM496aE6
         mqjtxMTqUxbtusqSJDTk7kr9dTUsEuiONwiXeQjReDIBmzXBPuu6XE9ouE6SYc77Rsjp
         LGefr1Ki5u7CPZVjMAkFaaVyCXakcXiRiTSaoJ998MG/HfRHMUErEo5EaJpOi81lBoWg
         3aNyu/wYQmCZqUhJFaBcL1ae9rK8Z/VBCZVfEd5tFBcKTBcV7wfFyoJABllgGYUqXTyI
         5z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NJcywdF4oZ0v4OgwE5MNvUs4KBqoSR/sY+GXt/vrbGE=;
        fh=H55jHsNg7YVe4fo6BrUws72pKkMG7o7yAnqdp8XfFsI=;
        b=epIlfeeGWPUqEFNq3BonHfcykqQ1fdXaCiNP+NHuAXqElkRKBtVKpr9l7hcQEEL3d6
         rPza2FiUExtUpoC3ysqg/lfbqHhbZlSYW6P/8zk9Z0SGfnPEfbXGRVE2L5TxyJlhF6ro
         5/FI25pjwj1OK7eMUC8N2PJCRJPwavK+9uJSSgF5yJUGZ280UvR5B9TPwsvoS2oSXTfP
         XReqTJc+3/A2mjgwJkqvA5hGbbAUWCnlDyPgw2aO/lEtJcmopAnReKZc5ZObAOqm/mlS
         Dxa549UrgUVRt1iHnggZ4172w7fQNweyP0UD7KVStd0Zc7MBv/1xDzZ5AFxGRFEDdFUc
         DYOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770743121; x=1771347921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJcywdF4oZ0v4OgwE5MNvUs4KBqoSR/sY+GXt/vrbGE=;
        b=CDsuXVrCKeUEiyFY77V4+BQ3972ZA/kQuaZk2pSCFq9vYLLJcRDrz2mTyR0brhlpbx
         CYGUbCTh2fq96edfcY9oQUQwqoF1i9hrg9BSR94luLYrA2hFBXyjUG21JvzmlU2nbsiy
         i57ltzbj1Ol5EYNcj0GAPyNdSlhT3c/88kleU=
X-Forwarded-Encrypted: i=1; AJvYcCULtrDjMwbjU5MU58Nw3m+IVMDLkUNdKSuxwki9gPklLqeTrdDMwNTSC2whNVxF3mcobdZ13mQHwhOI@vger.kernel.org
X-Received: by 2002:a05:600c:34cc:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-483507f2aebmr40526925e9.15.1770743120939;
        Tue, 10 Feb 2026 09:05:20 -0800 (PST)
X-Received: by 2002:a05:600c:34cc:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483507f2aebmr40526485e9.15.1770743120461; Tue, 10 Feb 2026
 09:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com> <20260206142322.GF943673@ziepe.ca>
In-Reply-To: <20260206142322.GF943673@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 10 Feb 2026 22:35:06 +0530
X-Gm-Features: AZwV_Qjm4Dj7oJM4xeKGFP21IpVJ4d9_kWzLEamm_2TX2NwZDw_slFj65wzSCS4
Message-ID: <CAHHeUGVH6vfLz5JM7VGEve4FiEyERdARNai5E5nAfMgzx=A6rA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bcfc8b064a7b42e5"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16727-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0BA11D87F
X-Rspamd-Action: no action

--000000000000bcfc8b064a7b42e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:53=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Feb 03, 2026 at 10:30:48AM +0530, Sriharsha Basavapatna wrote:
> > The following Direct Verbs have been implemented, by enhancing the
> > driver specific udata in existing verbs.
>
> Same comment about direct verbs.
>
> This patch has turned into nonsense after all the refactoring. Please
> just start from scratch.
>
> 1 patch to fixup the umem pgsz stuff. Today it looks like
>   bnxt_qplib_alloc_init_hwq() always works with
>   hwq_attr->sginfo->pgsize =3D=3D PAGE_SIZE so there is no issue.
>
>   However when adding DMABUF umems it is possible that the DMABUF umem
>   will not have PAGE_SIZE alignment, so it has to be checked:
>
> @@ -211,6 +211,10 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq =
*hwq,
>                         return -EINVAL;
>                 hwq_attr->sginfo->npages =3D npages;
>         } else {
> +               if (!ib_umem_find_best_pgsz(hwq_attr->sginfo->umem,
> +                                           pgsize, 0))
> +                       return -EINVAL;
> +
>                 npages =3D ib_umem_num_dma_blocks(hwq_attr->sginfo->umem,
>                                                 hwq_attr->sginfo->pgsize)=
;
>                 hwq->is_user =3D true;
>
>   But this isn't great, what you should be doing is using
>   ib_umem_find_best_pgsz() to compute hwq_attr->sginfo->pgsize based
>   on what page sizes the physical HW actually supports. If it only
>   supports 4K then all those assignments from PAGE_SIZE are wrong, it
>   should be SZ_4K.
Ack, this will be handled in create_cq() to make sure page size is set
correctly.
>
>   So fix this stuff up before adding dmabuf.
>
> 2 Patch to add bnxt_re_create_cq_umem() which works for *all* CQ
>   types.
Ack.
>
> 3 Patch to add the ncqe or whatever, see below.
>
> Stop calling things DV in the kernel.
>
> > @@ -101,10 +102,13 @@ struct bnxt_re_pd_resp {
> >  struct bnxt_re_cq_req {
> >       __aligned_u64 cq_va;
> >       __aligned_u64 cq_handle;
> > +     __aligned_u64 comp_mask;
> > +     __u32 ncqe;
> >  };
>
> Which I didn't quickly figure out *why* this is needed, please explain
> it in detail in the commit message for the patch adding it.
>
> AFAICT it does this:
>
>         u32 cqe =3D req->ncqe;
>
>         qplcq->max_wqe =3D cqe;
>
> But the normal CQ path does:
>
>         int cqe =3D attr->cqe;
>
>         entries =3D bnxt_re_init_depth(cqe + 1, uctx);
>         cq->qplib_cq.max_wqe =3D entries;
>
> So explain why does the driver need both attrs->cqe and a new ncqe and
> justify what ncqe is supposed to do differently.
>
> It looks to me like your "DV CQ" probably just needs something like:
>
>         if (req->comp_mask & POW2_DISABLED)
>                 entries =3D attr->cqe + 1;
>         else
>                 entries =3D bnxt_re_init_depth(cqe + 1, uctx);
>
> Which is alot smaller and saner than this whole adventure to make a
> parallel "dv cq", don't do that at all please.
Ack; ncqe is not needed anymore; commit message will be updated on how
cqe is used with the new uapi.
>
> Below is my draft to add create_cq_umem, see how simple it is supposed
> to be?
>
> Jason
Thanks,
-Harsha

>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index f19b55c13d5809..a708d9691b5733 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3121,8 +3121,10 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct=
 ib_udata *udata)
>         return 0;
>  }
>
> -int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *=
attr,
> -                     struct uverbs_attr_bundle *attrs)
> +int bnxt_re_create_cq_umem(struct ib_cq *ibcq,
> +                          const struct ib_cq_init_attr *attr,
> +                          struct ib_umem *umem,
> +                          struct uverbs_attr_bundle *attrs)
>  {
>         struct bnxt_re_cq *cq =3D container_of(ibcq, struct bnxt_re_cq, i=
b_cq);
>         struct bnxt_re_dev *rdev =3D to_bnxt_re_dev(ibcq->device, ibdev);
> @@ -3161,13 +3163,18 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const s=
truct ib_cq_init_attr *attr,
>                         goto fail;
>                 }
>
> -               cq->umem =3D ib_umem_get(&rdev->ibdev, req.cq_va,
> -                                      entries * sizeof(struct cq_base),
> -                                      IB_ACCESS_LOCAL_WRITE);
> -               if (IS_ERR(cq->umem)) {
> -                       rc =3D PTR_ERR(cq->umem);
> -                       goto fail;
> +               if (umem) {
> +                       cq->umem =3D umem;
> +               } else {
> +                       cq->umem =3D ib_umem_get(&rdev->ibdev, req.cq_va,
> +                                              entries * sizeof(struct cq=
_base),
> +                                              IB_ACCESS_LOCAL_WRITE);
> +                       if (IS_ERR(cq->umem)) {
> +                               rc =3D PTR_ERR(cq->umem);
> +                               goto fail;
> +                       }
>                 }
> +
>                 cq->qplib_cq.sg_info.umem =3D cq->umem;
>                 cq->qplib_cq.dpi =3D &uctx->dpi;
>         } else {
> @@ -3230,12 +3237,19 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const s=
truct ib_cq_init_attr *attr,
>  free_mem:
>         free_page((unsigned long)cq->uctx_cq_page);
>  c2fail:
> -       ib_umem_release(cq->umem);
> +       if (!umem)
> +               ib_umem_release(cq->umem);
>  fail:
>         kfree(cq->cql);
>         return rc;
>  }
>
> +int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *=
attr,
> +                     struct uverbs_attr_bundle *attrs)
> +{
> +       return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
> +}
> +
>  static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
>  {
>         struct bnxt_re_dev *rdev =3D cq->rdev;
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.h
> index 76ba9ab04d5ce4..5c793d7eac9cba 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -245,6 +245,10 @@ int bnxt_re_post_send(struct ib_qp *qp, const struct=
 ib_send_wr *send_wr,
>                       const struct ib_send_wr **bad_send_wr);
>  int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr=
,
>                       const struct ib_recv_wr **bad_recv_wr);
> +int bnxt_re_create_cq_umem(struct ib_cq *ibcq,
> +                          const struct ib_cq_init_attr *attr,
> +                          struct ib_umem *umem,
> +                          struct uverbs_attr_bundle *attrs);
>  int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *=
attr,
>                       struct uverbs_attr_bundle *attrs);
>  int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udat=
a);
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw=
/bnxt_re/main.c
> index 73003ad25ee836..d55e5edf2368a3 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1333,6 +1333,7 @@ static const struct ib_device_ops bnxt_re_dev_ops =
=3D {
>         .alloc_pd =3D bnxt_re_alloc_pd,
>         .alloc_ucontext =3D bnxt_re_alloc_ucontext,
>         .create_ah =3D bnxt_re_create_ah,
> +       .create_cq_umem =3D bnxt_re_create_cq_umem,
>         .create_cq =3D bnxt_re_create_cq,
>         .create_qp =3D bnxt_re_create_qp,
>         .create_srq =3D bnxt_re_create_srq,

--000000000000bcfc8b064a7b42e5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBa1um/XrsGynahhR+z2Xwcm//jF/Wse0QG
2SakmxaVrjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMTAx
NzA1MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAEzbows3V22U1S+Juj5A4e1g7zx1DwYtUy/IQyeM7TRZOllmWKcErEw/Q+h9TrpuxHGKFk
BSb64OfLDu2FjAwTkIMhVIGJY7ZImMuSdnPbRD9SEGeUJFofadfzt4WwuD//ozVnavD9WTOUUMCu
kMusmJTChzZdCR8zw51I7c0VG9VFSjP76BqC+mMLo6lYqqysYNzQV/LzccNFgSpowNZB6OD+zR4D
7iCKDhtk0Hysz43FO65v4NVNiI7MaEVKRpLbwG6D7y4N3IzkCNFwZKXwlYGWugzNzxL6NxkT43xd
/ZMWlXYopjvhkCLhlR5yGO3Ta14p1XY/WJgMwWXQbtmP
--000000000000bcfc8b064a7b42e5--

