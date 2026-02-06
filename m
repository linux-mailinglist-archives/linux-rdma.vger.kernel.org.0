Return-Path: <linux-rdma+bounces-16651-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDFWAQT6hWmKIwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16651-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:26:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A04FEE1A
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DAC9307A941
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61373EFD23;
	Fri,  6 Feb 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KzOn7/pL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40193EF0A4
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387806; cv=none; b=VyBLwk8T6ZKrZIuZnutKqIf9b5suFegKXVLu8Jwt1JoaQNFT3M3OAbUwMu7boupya1tYdnhSb71UHqCh/Nudsqkp9YjU2/wmAY6HBGpyKJppr/r460qVSfmOBls2tp5v3rpRDS8AZCJ6UdLnYtmNUHDWD+7U8c+jr5LNuMACIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387806; c=relaxed/simple;
	bh=mZ1j5qUw9XAq6PT23voZVNNPriV5mPhtvvbKbrJITvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQoz066lQZRkO+Ff8a3unaqDaGpxG1whOCfZBlt0IrP6j2nX6fX1uC8P2H04cH+T67d/12Wo9U4t/ZZ9LuOX2yjkP7qZdvnrIqadUG8fskhQYV+t6PknWGnpXuN171zbnyTQ8d+BYTyaAgfIce02zUjGksHDHBve628XV42oN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KzOn7/pL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6a0702b86so190151585a.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770387804; x=1770992604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LWQ9Hw+BNzAIkXxoC9idV8B4VbBjy3BI3mINfKIhus=;
        b=KzOn7/pLGYbcUVuYWED2uyIjrXjdkdFeDSVYDIbIdyr9ACUF5nsSD+JgzhW620lfB0
         ygwYQF50GE3AlYlleaBoJ9w37Qve4GqHBshwmiq+7FoQZjrGrQ/tR3P777lH0/+Xsoug
         vPONo0RzzntpIjmYZ26XfPHCJGptGTGxDuvapD6OGs5wRt+aIEwQvji4kjfg503BCquc
         HTErtlcy0w0vB3zaA9G0p9NL1UHyykWohIzISrYGFzCOv8ko/T2HKSs7YBzjrAHOom7B
         8UFWlGI/kbUv4uPVkMlM3jGrkl9qiEp9lGbKLFRScw/8cXiomHpDXafxVtpp+rcsKg/a
         5OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770387804; x=1770992604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LWQ9Hw+BNzAIkXxoC9idV8B4VbBjy3BI3mINfKIhus=;
        b=tfWndpdW0Wp+BBfIQgFx1/oQ7rFrJsRgHxdKexEvFUNe93usIoTSSW9B7beKvI24P6
         0D8VZl/svoBnaaeLckJt4OQJXAhS+/ojZLFLENFXM/WT4hocc+KjRKyDB331ahyEdIS+
         kSrUM+AOH6kz5h++ZwcwsaKOi4DsWxRkIAeWuF65orIlyaZ5Jm5CQPLxH+fxmT8Ecsfn
         i72iSWqpts88pigmr+eQqpSJwuHFJZAa9ULER035/HiHh75hkWT7E3u2B0g42ZH+Vo5r
         7LB9SaTml0S2MTvUaLWrDagp6nxx68bjG+4GIqhP5nX01Jfd9YT4EtWbTNLoSus1I2Xe
         2wQA==
X-Forwarded-Encrypted: i=1; AJvYcCXrkG/0ilvBPzK0LIzZG+YiHiICfuVzDaxpUBvg9wdWU2uGeSuiq/X3FVHVKCiXO4v3SKlyG58xhm38@vger.kernel.org
X-Gm-Message-State: AOJu0YxmSRputDYNbyqJVN11GBKufBTT4eBh0N2u07KnsfIo8LJmvtSL
	p37fyxo2qYJbMIK+fz9BYkD2ONU3tmHcIeisGEx4Cj9ivHyocPuorfytojcm7Rd1rIY=
X-Gm-Gg: AZuq6aLanHFp5KvbMgk9HfTXdblmbR9llS7F00GQC7jiaGSSxaFZrFPvhRSXkDamH/y
	oPthlr99LcZdId4PsN3UImneyWmaMU7uEzXj5uT8gAcsbJhlFMpPa33HTOPeicZDmSCfjD9p+tr
	jSfptncdyjCnT2GwUAjOdvoOLGAfbEYc7/oDnYgQDLOYd7lzgmsR6Lybr2G4/ue9pVRgP0xELQJ
	U6kTJatfT5+SJMB4qwl7eLZ+pIQvhSuD1bge/zdq9/+4iJ3u5dst5tUQZzrQut2J3+PEXCmZBCZ
	Wdb7xTpZexZTp9kYfAU+Bif8fW6431qxHzib6IYvLxi9fK+eL4wh4H6aIIpuGppWlTrXgaOnR8a
	S9BlCpuoa/9aLxPPTdSuPPTxTSVV4TreAe/4KElnrveNVX5PmLY92alSMIIGKbuX+szyVV/uege
	EZf870ZSe07tixcgxgqXiZ4IePhK3PDKRc16psrTElNzNe1WYPe/+z0a/RyD1XcgzP4rRpt+nwf
	Q6kVQ==
X-Received: by 2002:a05:620a:1aa0:b0:8ca:305b:748e with SMTP id af79cd13be357-8caf0c457dbmr390929785a.57.1770387804414;
        Fri, 06 Feb 2026 06:23:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6c16sm161258285a.10.2026.02.06.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:23:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voMjy-00000008M9f-3WtI;
	Fri, 06 Feb 2026 10:23:22 -0400
Date: Fri, 6 Feb 2026 10:23:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ
 verbs
Message-ID: <20260206142322.GF943673@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16651-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64A04FEE1A
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:30:48AM +0530, Sriharsha Basavapatna wrote:
> The following Direct Verbs have been implemented, by enhancing the
> driver specific udata in existing verbs.

Same comment about direct verbs.

This patch has turned into nonsense after all the refactoring. Please
just start from scratch.

1 patch to fixup the umem pgsz stuff. Today it looks like
  bnxt_qplib_alloc_init_hwq() always works with
  hwq_attr->sginfo->pgsize == PAGE_SIZE so there is no issue.

  However when adding DMABUF umems it is possible that the DMABUF umem
  will not have PAGE_SIZE alignment, so it has to be checked:

@@ -211,6 +211,10 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
                        return -EINVAL;
                hwq_attr->sginfo->npages = npages;
        } else {
+               if (!ib_umem_find_best_pgsz(hwq_attr->sginfo->umem,
+                                           pgsize, 0))
+                       return -EINVAL;
+
                npages = ib_umem_num_dma_blocks(hwq_attr->sginfo->umem,
                                                hwq_attr->sginfo->pgsize);
                hwq->is_user = true;

  But this isn't great, what you should be doing is using
  ib_umem_find_best_pgsz() to compute hwq_attr->sginfo->pgsize based
  on what page sizes the physical HW actually supports. If it only
  supports 4K then all those assignments from PAGE_SIZE are wrong, it
  should be SZ_4K.

  So fix this stuff up before adding dmabuf.

2 Patch to add bnxt_re_create_cq_umem() which works for *all* CQ
  types.

3 Patch to add the ncqe or whatever, see below.

Stop calling things DV in the kernel.

> @@ -101,10 +102,13 @@ struct bnxt_re_pd_resp {
>  struct bnxt_re_cq_req {
>  	__aligned_u64 cq_va;
>  	__aligned_u64 cq_handle;
> +	__aligned_u64 comp_mask;
> +	__u32 ncqe;
>  };

Which I didn't quickly figure out *why* this is needed, please explain
it in detail in the commit message for the patch adding it.

AFAICT it does this:

	u32 cqe = req->ncqe;

	qplcq->max_wqe = cqe;

But the normal CQ path does:

	int cqe = attr->cqe;

	entries = bnxt_re_init_depth(cqe + 1, uctx);
	cq->qplib_cq.max_wqe = entries;

So explain why does the driver need both attrs->cqe and a new ncqe and
justify what ncqe is supposed to do differently.

It looks to me like your "DV CQ" probably just needs something like:

	if (req->comp_mask & POW2_DISABLED)
		entries = attr->cqe + 1;
	else
		entries = bnxt_re_init_depth(cqe + 1, uctx);

Which is alot smaller and saner than this whole adventure to make a
parallel "dv cq", don't do that at all please.

Below is my draft to add create_cq_umem, see how simple it is supposed
to be?

Jason

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f19b55c13d5809..a708d9691b5733 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3121,8 +3121,10 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	return 0;
 }
 
-int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3161,13 +3163,18 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			goto fail;
 		}
 
-		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-				       entries * sizeof(struct cq_base),
-				       IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(cq->umem)) {
-			rc = PTR_ERR(cq->umem);
-			goto fail;
+		if (umem) {
+			cq->umem = umem;
+		} else {
+			cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+					       entries * sizeof(struct cq_base),
+					       IB_ACCESS_LOCAL_WRITE);
+			if (IS_ERR(cq->umem)) {
+				rc = PTR_ERR(cq->umem);
+				goto fail;
+			}
 		}
+
 		cq->qplib_cq.sg_info.umem = cq->umem;
 		cq->qplib_cq.dpi = &uctx->dpi;
 	} else {
@@ -3230,12 +3237,19 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
 c2fail:
-	ib_umem_release(cq->umem);
+	if (!umem)
+		ib_umem_release(cq->umem);
 fail:
 	kfree(cq->cql);
 	return rc;
 }
 
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
+}
+
 static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 {
 	struct bnxt_re_dev *rdev = cq->rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 76ba9ab04d5ce4..5c793d7eac9cba 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -245,6 +245,10 @@ int bnxt_re_post_send(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 		      const struct ib_send_wr **bad_send_wr);
 int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem,
+			   struct uverbs_attr_bundle *attrs);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee836..d55e5edf2368a3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1333,6 +1333,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.alloc_pd = bnxt_re_alloc_pd,
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
 	.create_ah = bnxt_re_create_ah,
+	.create_cq_umem = bnxt_re_create_cq_umem,
 	.create_cq = bnxt_re_create_cq,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,

