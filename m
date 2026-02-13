Return-Path: <linux-rdma+bounces-16865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG4mK1QIj2ltHQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:17:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D1135A38
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C9D301A91E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657B34DB5F;
	Fri, 13 Feb 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyYGOz5b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7618EFD1
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981182; cv=none; b=J2DLLmy7hP6MY17hyOhLFzs7HnRz4RGEdL+TR0h0/cWqIXbKZxBjI+OcZ4FaXSsIU21jnfqKmuBfkfJcUOvYBg/bPdOBPyIvUMHGFcHYDeDo2OaxU5t0LYpJ7V/AI+z0dIGQ9NnYRl6RAzY/WPVIZG2oOTJNyVFTfUs5IuOM+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981182; c=relaxed/simple;
	bh=MfOuLm3bXR5/Cp0E/TRZcbIOG/usJKx90zkGHTwU3Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/NiHWMf7tZG48lX/FtbDmiqjlWflW90GxCfp+8+Q6ZOEJYfFQI6W4Q6Yq9i3VRNl6kf0dapRVfU8EFgUnzLty0ut43k5UxbGoVVmLVHFrobKyCIs8OYT/1wNJ6/B0sV4G1shRC7beRqJHf6+hly1rxYvt7hswCtYq1DcZac5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyYGOz5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83E9C116C6;
	Fri, 13 Feb 2026 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770981181;
	bh=MfOuLm3bXR5/Cp0E/TRZcbIOG/usJKx90zkGHTwU3Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyYGOz5bQa6fYQLb2HDn25Ul3V4YS4RzqEPJ2kLDImm3gqzvEwDVEKCsTTa8rCu9+
	 JyWRdj98Jm+AfEaGl6ClfCvEbZpDBbAHXPT155JDL0oVKXEAzRXEC6h4gwV5KYrgPx
	 xdcO7cJz6j3Scao5+qhRWH5czFxcUS6tSznWP3rzK8ykosgOQUdeMG14qNCsjvzNLS
	 NLDLkZvXW0PkxcyA+aWa589/E5aBGxeSZxIC0ME4Fd2svCI3IZowsmbzhpbbFcoSE8
	 1bCPoz7pSPAzIn2wqjVpZcb04zGPa5psVaj0JbHkOI7ZfY2eUYyD0wfxpcmnNUwMGr
	 V5bEiQm1iLuAA==
Date: Fri, 13 Feb 2026 13:12:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v12 5/6] RDMA/bnxt_re: Support dmabuf for CQ
 rings
Message-ID: <20260213111256.GO12887@unreal>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
 <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16865-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 068D1135A38
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 06:19:26PM +0530, Sriharsha Basavapatna wrote:
> For CQs, kernel already supports pinning dmabuf based application
> memory, specified through provider attributes. Register a new devop
> for create_cq_umem() and process the umem argument. Refactor the
> existing create_cq() handler so that code is shared across both
> handlers.
> 
> Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 30 +++++++++++++++++-------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
>  drivers/infiniband/hw/bnxt_re/main.c     |  1 +
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 9fa89f330c5a..30aefbd0112e 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3368,8 +3368,8 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
>  	return 0;
>  }
>  
> -int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> -		      struct uverbs_attr_bundle *attrs)
> +int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
>  {
>  	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
>  	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
> @@ -3406,13 +3406,18 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  		if (rc)
>  			goto fail;
>  
> -		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
> -				       entries * sizeof(struct cq_base),
> -				       IB_ACCESS_LOCAL_WRITE);
> -		if (IS_ERR(cq->umem)) {
> -			rc = PTR_ERR(cq->umem);
> -			goto fail;
> +		if (umem) {
> +			cq->umem = umem;
> +		} else {
> +			cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
> +					       entries * sizeof(struct cq_base),
> +					       IB_ACCESS_LOCAL_WRITE);
> +			if (IS_ERR(cq->umem)) {
> +				rc = PTR_ERR(cq->umem);
> +				goto fail;
> +			}
>  		}
> +
>  		rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
>  		if (rc)
>  			goto fail;
> @@ -3480,12 +3485,19 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  free_mem:
>  	free_page((unsigned long)cq->uctx_cq_page);
>  c2fail:
> -	ib_umem_release(cq->umem);
> +	if (!umem)
> +		ib_umem_release(cq->umem);
>  fail:
>  	kfree(cq->cql);
>  	return rc;
>  }
>  
> +int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +		      struct uverbs_attr_bundle *attrs)
> +{
> +	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
> +}

Please don't mix create_cq and create_cq_umem.
https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-15-f3be85847922@nvidia.com/T/#u

Thanks

> +
>  static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
>  {
>  	struct bnxt_re_dev *rdev = cq->rdev;
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index 33e0f66b39eb..27cbe9a1c7e1 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -254,6 +254,8 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
>  		      const struct ib_recv_wr **bad_recv_wr);
>  int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  		      struct uverbs_attr_bundle *attrs);
> +int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
>  int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
>  int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
>  int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 73003ad25ee8..401a481afecc 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1334,6 +1334,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
>  	.alloc_ucontext = bnxt_re_alloc_ucontext,
>  	.create_ah = bnxt_re_create_ah,
>  	.create_cq = bnxt_re_create_cq,
> +	.create_cq_umem = bnxt_re_create_cq_umem,
>  	.create_qp = bnxt_re_create_qp,
>  	.create_srq = bnxt_re_create_srq,
>  	.create_user_ah = bnxt_re_create_ah,
> -- 
> 2.51.2.636.ga99f379adf
> 

