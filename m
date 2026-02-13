Return-Path: <linux-rdma+bounces-16812-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmAJDX+jmmOGwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16812-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:34:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBD61351E6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160CA303A5EC
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4333067C;
	Fri, 13 Feb 2026 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQL5kDs6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3230DEB7;
	Fri, 13 Feb 2026 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978866; cv=none; b=NexyitgA7esprE+JyKc200sC4GjMXuNo01Zo9HgvM2oJp7y/9+qTic6XExJJoqtaWoO7xvg26R1ySRAY4rTYu5AYBXqG0csQXCBX09oNFoOvG1OkIQ6OGdzpXgT8jnZY5tS/tn9041V9be+zEv7GEA4HABE28Sm26k0J3e8dfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978866; c=relaxed/simple;
	bh=drw1NggqkxfG+ItJs1EAffffebTh032rdM6CGxcIbLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5vLoN0kliMboD3kI9fWBOpeEEEa1VnPy8HhIHWzU2X6EI2dXsJHJHLIGbBzRHWJ0R5P7Jcdvah23prJRgx6w2fqX4UgYOY1wpmxK2LDvFre8AYb59yimn4q2ymJbz0GNfwZN5JKWcZQjxuBEN28qU/zWZIHgS0mKZmUdm/WZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQL5kDs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E572C116C6;
	Fri, 13 Feb 2026 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770978865;
	bh=drw1NggqkxfG+ItJs1EAffffebTh032rdM6CGxcIbLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQL5kDs6bkq5hVKkR7zs0mbRvF8HSP8giEDtTTvW27Dw88q1JpQ+NcCSTL0UiWweD
	 xqNeM69mz/aLGStgz9l34BQ723BIEd5ubgO+1isfvSWNQmnuOsL953TkVTuSp8r4uo
	 lRr/AuDE3y4Uim7DL9kIWJUtXvcukr91toGUbHXxS5y8qHITwMSqEl1bd5ehA7tXAN
	 3rzjUpE08AQGRTy4gPwVP41aRuF32lMqpd8qCvQZSpnD2r+a8E11lczIkIbdt2sE6+
	 VF3X+nNhgn3Ps4DTvSdFWI9PEIQD49f6dQ5GFPyGg8idE9pXekO0Muz/LVZSGwG1Xw
	 VrC+z9fbB2fQQ==
Date: Fri, 13 Feb 2026 12:34:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 07/10] RDMA/bnxt_re: Add compatibility checks to the uapi
 path for no data
Message-ID: <20260213103421.GM12887@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <7-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16812-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: DBBD61351E6
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:45:41PM -0400, Jason Gunthorpe wrote:
> If drivers ever want to go from an empty drvdata to something with them
> they need to have called ib_is_udata_in_empty(). Add the missing calls to
> all the system calls that don't have req structures.

This is also a good candidate for an AI review prompt.  
It is easy to overlook the need for `ib_is_udata_in_empty()`.

Thanks

> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 39 ++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 2942ff44f6a547..485785fad1df63 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -187,6 +187,9 @@ int bnxt_re_query_device(struct ib_device *ibdev,
>  	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
>  	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	memset(ib_attr, 0, sizeof(*ib_attr));
>  	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
>  	       min(sizeof(dev_attr->fw_ver),
> @@ -676,6 +679,9 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
>  	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
>  	struct bnxt_re_dev *rdev = pd->rdev;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	if (udata) {
>  		rdma_user_mmap_entry_remove(pd->pd_db_mmap);
>  		pd->pd_db_mmap = NULL;
> @@ -703,6 +709,9 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>  	u32 active_pds;
>  	int rc = 0;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	pd->rdev = rdev;
>  	if (bnxt_qplib_alloc_pd(&rdev->qplib_res, &pd->qplib_pd)) {
>  		ibdev_err(&rdev->ibdev, "Failed to allocate HW PD");
> @@ -817,6 +826,9 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
>  	u8 nw_type;
>  	int rc;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	if (!(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH)) {
>  		ibdev_err(&rdev->ibdev, "Failed to alloc AH: GRH not set");
>  		return -EINVAL;
> @@ -978,6 +990,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  	unsigned int flags;
>  	int rc;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	bnxt_re_debug_rem_qpinfo(rdev, qp);
>  
>  	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
> @@ -1828,6 +1843,9 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
>  	struct bnxt_re_dev *rdev = srq->rdev;
>  	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
>  		free_page((unsigned long)srq->uctx_srq_page);
>  		hash_del(&srq->hash_entry);
> @@ -1977,6 +1995,9 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
>  					       ib_srq);
>  	struct bnxt_re_dev *rdev = srq->rdev;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	switch (srq_attr_mask) {
>  	case IB_SRQ_MAX_WR:
>  		/* SRQ resize is not supported */
> @@ -2093,6 +2114,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
>  	unsigned int flags;
>  	u8 nw_type;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
>  		return -EOPNOTSUPP;
>  
> @@ -3111,6 +3135,9 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
>  	nq = cq->qplib_cq.nq;
>  	cctx = rdev->chip_ctx;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
>  		free_page((unsigned long)cq->uctx_cq_page);
>  		hash_del(&cq->hash_entry);
> @@ -4058,6 +4085,9 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
>  	struct bnxt_re_dev *rdev = mr->rdev;
>  	int rc;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return -EOPNOTSUPP;
> +
>  	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
>  	if (rc) {
>  		ibdev_err(&rdev->ibdev, "Dereg MR failed: %#x\n", rc);
> @@ -4166,6 +4196,9 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
>  	u32 active_mws;
>  	int rc;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	mw = kzalloc(sizeof(*mw), GFP_KERNEL);
>  	if (!mw)
>  		return ERR_PTR(-ENOMEM);
> @@ -4294,6 +4327,9 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
>  	struct ib_umem *umem;
>  	struct ib_mr *ib_mr;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	if (dmah)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> @@ -4474,6 +4510,9 @@ struct ib_flow *bnxt_re_create_flow(struct ib_qp *ib_qp,
>  	struct bnxt_re_flow *flow;
>  	int rc;
>  
> +	if (!ib_is_udata_in_empty(udata))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	if (attr->type != IB_FLOW_ATTR_SNIFFER ||
>  	    !rdev->rcfw.roce_mirror)
>  		return ERR_PTR(-EOPNOTSUPP);
> -- 
> 2.43.0
> 
> 

