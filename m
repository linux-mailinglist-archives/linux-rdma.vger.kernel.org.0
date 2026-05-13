Return-Path: <linux-rdma+bounces-20594-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLjEAxa3BGqKNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20594-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:38:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85450538257
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB9F13008094
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C784DBD62;
	Wed, 13 May 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG+DyU10"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C9368D6F
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693899; cv=none; b=oFaHQxjMwy1OFfQB63Jts0vwMcteraBf2feLv+5CVhzhz5EOyo7g1I4zmR/UzqSDw2a6hbf39citX+d9iTJiS8IBfoEut6AmbE1B+ApGoiyon879jUgfDTU8pWYvvndf/+aW3wh3cNTFgKIoGqbFL/ZegPEDXfSZ17z6mdlfV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693899; c=relaxed/simple;
	bh=EIummNQ7UEoIxXq1wGpqKcisyX0jKWzAmoBzJKkz8BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp5ib2OD+9zKJtWEc2937nsVTJNhBnY9HiIiEHWH3qsfGEqwhQ0axs4mIg2I4sNKPuU80EwhpdTLlnVaW0UQY6eyutnAWj0jCiY4ixuxAsT8u9BkNXjIydO0EG64TqpKs1Q+axs4IBI71rM/rnmcZHVm5tzeujiECgBmCNFiiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG+DyU10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E98C19425;
	Wed, 13 May 2026 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778693898;
	bh=EIummNQ7UEoIxXq1wGpqKcisyX0jKWzAmoBzJKkz8BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aG+DyU10RyXPd7C7oDkojM/l642JOP5RckIWfHRyWvgyx9w9zWt4dYcfEOS03CtNR
	 l68Q4qby/1oK8e3gyOI4h5YMeuXOdSifW/aCJaqcpfUFvPdA1e9WTokB9b6jnzb8os
	 hZLnZ/wrblIwyX5+d51VbWTmfRnVI78a5bdtM5/LnqFAsxIiN9rRKir/yNAIeSEnbL
	 kT9p8WmFLFKcgHqRJPzlPtAaHgSP5jDNb2fLcInb0ghQi5t9wNsfz08igXMnWtbntG
	 zddTSxY5jAfoac4mGwuT7gy84RKMHIetAEsQZIMWFER4j/06A7OTxGtU4RQdHqNx1X
	 DXTHU/ORQjzIg==
Date: Wed, 13 May 2026 20:38:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Validate SQ depth based on WQE size
Message-ID: <20260513173812.GH15586@unreal>
References: <20260507112110.869212-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507112110.869212-1-ynachum@amazon.com>
X-Rspamd-Queue-Id: 85450538257
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20594-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 11:21:10AM +0000, Yonatan Nachum wrote:
> From: Michael Margolin <mrgolin@amazon.com>
> 
> Change the SQ depth validation to take into account the SQ WQE size.
> This is needed since when using 128-byte WQE the max SQ depth is cut in
> half. On create QP command, userspace provides SQ ring size which is SQ
> depth X WQE size so we can calculate the requested WQE size in the
> kernel.
> 
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)

Please add Fixes line.

Thanks

> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 7bd0838ebc99..eb95ed4e25f7 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -612,14 +612,27 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
>  	return -ENOMEM;
>  }
>  
> +static int efa_calc_sq_wqe_size(u32 sq_ring_size, u32 max_send_wr)
> +{
> +	return max_send_wr == 0 ? 0 : sq_ring_size / max_send_wr;
> +}
> +
> +static u32 efa_calc_sq_max_depth(struct efa_dev *dev, u32 sq_wqe_size)
> +{
> +	return sq_wqe_size == 0 ? 0 :
> +		rounddown_pow_of_two(dev->dev_attr.max_llq_size / sq_wqe_size);
> +}
> +
>  static int efa_qp_validate_cap(struct efa_dev *dev,
> -			       struct ib_qp_init_attr *init_attr)
> +			       struct ib_qp_init_attr *init_attr,
> +			       u32 sq_wqe_size)
>  {
> -	if (init_attr->cap.max_send_wr > dev->dev_attr.max_sq_depth) {
> +	u32 sq_max_depth = efa_calc_sq_max_depth(dev, sq_wqe_size);
> +
> +	if (init_attr->cap.max_send_wr > sq_max_depth) {
>  		ibdev_dbg(&dev->ibdev,
>  			  "qp: requested send wr[%u] exceeds the max[%u]\n",
> -			  init_attr->cap.max_send_wr,
> -			  dev->dev_attr.max_sq_depth);
> +			  init_attr->cap.max_send_wr, sq_max_depth);
>  		return -EINVAL;
>  	}
>  	if (init_attr->cap.max_recv_wr > dev->dev_attr.max_rq_depth) {
> @@ -686,19 +699,12 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
>  	struct efa_qp *qp = to_eqp(ibqp);
>  	struct efa_ucontext *ucontext;
>  	u16 supported_efa_flags = 0;
> +	u32 sq_wqe_size;
>  	int err;
>  
>  	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
>  					     ibucontext);
>  
> -	err = efa_qp_validate_cap(dev, init_attr);
> -	if (err)
> -		goto err_out;
> -
> -	err = efa_qp_validate_attr(dev, init_attr);
> -	if (err)
> -		goto err_out;
> -
>  	err = ib_copy_validate_udata_in_cm(udata, cmd, driver_qp_type, 0);
>  	if (err)
>  		goto err_out;
> @@ -720,6 +726,15 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
>  		goto err_out;
>  	}
>  
> +	sq_wqe_size = efa_calc_sq_wqe_size(cmd.sq_ring_size, init_attr->cap.max_send_wr);
> +	err = efa_qp_validate_cap(dev, init_attr, sq_wqe_size);
> +	if (err)
> +		goto err_out;
> +
> +	err = efa_qp_validate_attr(dev, init_attr);
> +	if (err)
> +		goto err_out;
> +
>  	create_qp_params.uarn = ucontext->uarn;
>  	create_qp_params.pd = to_epd(ibqp->pd)->pdn;
>  
> -- 
> 2.50.1
> 
> 

