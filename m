Return-Path: <linux-rdma+bounces-16679-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ4DIB3kiGmtyAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16679-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 20:29:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D166D10A005
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C4AC300B05E
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CF303C88;
	Sun,  8 Feb 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kqVizE69"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF672F6937
	for <linux-rdma@vger.kernel.org>; Sun,  8 Feb 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770578968; cv=none; b=R3sKFL8VhidSjf0/flZiRUiZD1PdxLb0EYIFlFOY7yI0Z0B1+mmhZzhufK5aLV7p4IaQUKoalr3h9R1D5N+Br+EacOu4rr0po7e1Y7PFbfoP94RvyaXbKkaPfMosWgVA29FNKWXb+YCA2qBHGT6PrC8AQyi5sNlzn8wPGJieXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770578968; c=relaxed/simple;
	bh=uJk/HTTQjHpgXXPF2B5GOFPeJOXoDW3E8CeIFbCNL1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZj6DzSoGOGSqkEe9xxBRVHam3IH1Six4oAiu5bSLz87rmB/cMW/kxBhbqZjAuLIv4qwfzdt2vhWoroI/5hCYyL6+4xUwYmrgfd8l9kURZ8v9cHjzsIf+RZ8yJSBiJ2EAAnjU5HXBxwdkzMPT+IPIfTRKF9t7e6I6hNKZBo0cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kqVizE69; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2768471c-4b50-4b34-a87a-35fbc49019b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770578956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gnfwf6iR8d8srvLc5E+dFDSiCa06IAOvwSZx90D2AH8=;
	b=kqVizE69r608iPYE1KmoDKJ7c7ucoy6BWv3swvgR7YhIB9Uvd29QfV+DPK9JribauojKRu
	O9/RdmGNraSHQsop42/ehz+tYZDNj0APU6oILJ3ylm6R16nT0qyjBm5/dWLxBdiA7ykrLX
	8KKKKpaMOvXyt0U9ROoA//uW+50DF98=
Date: Sun, 8 Feb 2026 11:29:12 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 06/10] RDMA/bnxt_re: Add compatibility checks to the uapi
 path
To: Jason Gunthorpe <jgg@nvidia.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
References: <6-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16679-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D166D10A005
X-Rspamd-Action: no action

在 2026/2/5 17:45, Jason Gunthorpe 写道:
> Check that the driver data is properly sized and properly zeroed by
> calling ib_copy_validate_udata_in().
> 
> Use git history to find the commit introducing each req struct and use
> that to select the end member.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c | 29 +++++++++++++-----------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index f19b55c13d5809..2942ff44f6a547 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -1655,9 +1655,11 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
>   	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
>   
>   	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
> -	if (udata)
> -		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
> -			return -EFAULT;
> +	if (udata) {
> +		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
> +		if (rc)
> +			return rc;
> +	}
>   
>   	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
>   	if (!rc) {
> @@ -1847,9 +1849,11 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
>   	int bytes = 0;
>   	struct bnxt_re_ucontext *cntx = rdma_udata_to_drv_context(
>   		udata, struct bnxt_re_ucontext, ib_uctx);
> +	int rc;
>   
> -	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
> -		return -EFAULT;
> +	rc = ib_copy_validate_udata_in(udata, ureq, srq_handle);
> +	if (rc)
> +		return rc;
>   
>   	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
>   	bytes = PAGE_ALIGN(bytes);
> @@ -3156,10 +3160,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
>   	if (udata) {
>   		struct bnxt_re_cq_req req;
> -		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
> -			rc = -EFAULT;
> +
> +		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
> +		if (rc)
>   			goto fail;
> -		}
>   
>   		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
>   				       entries * sizeof(struct cq_base),
> @@ -3289,10 +3293,9 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
>   		entries = dev_attr->max_cq_wqes + 1;
>   
>   	/* uverbs consumer */
> -	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
> -		rc = -EFAULT;
> +	rc = ib_copy_validate_udata_in(udata, req, cq_va);
> +	if (rc)
>   		goto fail;
> -	}
>   
>   	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
>   				      entries * sizeof(struct cq_base),
> @@ -4391,8 +4394,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
>   	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
>   		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED;
>   
> -	if (udata->inlen >= sizeof(ureq)) {
> -		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
> +	if (udata->inlen) {
> +		rc = ib_copy_validate_udata_in(udata, ureq, comp_mask);
>   		if (rc)
>   			goto cfail;
>   		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {


