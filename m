Return-Path: <linux-rdma+bounces-17477-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA5sIiZTqGnUtAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17477-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 16:43:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 365332030CD
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48F24300B441
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175A34D4F8;
	Wed,  4 Mar 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQt7u53D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661234D4D2
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638632; cv=none; b=U1Y1G/N4xEzVQw+Ba5kGkm+au5ZtkxhGD9h8vPizsgcNZHUwt46oxyvk34NH4xEJnHutm3A65zLpyuV2LsHIXjROsKpQgEQ0Sk1odaJpn8TO1AS/TdrV/O223AaFbm0weofr0GHg6tcXqr0rwHvCiji8DQj0yuL2WYLpPSSLn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638632; c=relaxed/simple;
	bh=JaL1LXUolh6vVQLKBWURsM2rhGauuM32RM8WqNOYyhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIMDpUhU9p8EFUsvuqiTkYaPU/7JnJ1JCgKzCt01aQSYDNGg42Zdrm+1i8JUuh0Ckpw0alox797O0nz/sRsWuqOO2jRQsvcLlQK7QouGe5p+V3jSiCi7ShKcBn0SklwuwcwdA8SG9rWQXgSs1iOhLFZQYUHkyt9k15JIgkFjO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQt7u53D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DEFC4CEF7;
	Wed,  4 Mar 2026 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638632;
	bh=JaL1LXUolh6vVQLKBWURsM2rhGauuM32RM8WqNOYyhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQt7u53Dvku96gS+8FJ9gCo0v3Kr9e6F5n9gYMiIwFcmzjEJXqmStFg6n/f2PhLWm
	 RGINh4EcIIi7/eroyyuyAQl3o9q8wRZOO0UwZ43fcmeGt4fri3mjT2eDT1zE3TVqdf
	 ElFfmdqvThN553hfyB+gP56HLlDenUZmzcLhPi+140p/67YOup+DPSSH6ajWsuOxXS
	 cPUQAJqR+af4tC4UCIPc4lUe4dA7lO7ATNxe6YRZkwpQarM+nswlYn7g0k5p2dLSt/
	 j2Gs6bgpl4yg4VjWBJ0u7vrEy2fhvyM0lF7Y7Z1Sb6w90PKoGuBtfORtWzKapjH8L9
	 77019RfsZfCzA==
Date: Wed, 4 Mar 2026 17:37:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/bng_re: Fix silent failure in HWRM version
 query
Message-ID: <20260304153707.GG12611@unreal>
References: <20260303043645.425724-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303043645.425724-1-kheib@redhat.com>
X-Rspamd-Queue-Id: 365332030CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17477-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:36:45PM -0500, Kamal Heib wrote:
> If the firmware version query fails, the driver currently ignores the
> error and continues initializing. This leaves the device in a bad state.

Can you please elaborate what will it cause?

Thanks

> 
> Fix this by making bng_re_query_hwrm_version() return the error code and
> update the driver to check for this error and stop the setup process
> safely if it happens.
> 
> Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bnge driver")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/hw/bng_re/bng_dev.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
> index d34b5f88cd40..17147175a9b0 100644
> --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> @@ -210,7 +210,7 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
>  	return rc;
>  }
>  
> -static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
> +static int bng_re_query_hwrm_version(struct bng_re_dev *rdev)
>  {
>  	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
>  	struct hwrm_ver_get_output ver_get_resp = {};
> @@ -230,7 +230,7 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
>  	if (rc) {
>  		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
>  			  rc);
> -		return;
> +		return rc;
>  	}
>  
>  	cctx = rdev->chip_ctx;
> @@ -244,6 +244,8 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
>  
>  	if (!cctx->hwrm_cmd_max_timeout)
>  		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
> +
> +	return 0;
>  }
>  
>  static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> @@ -306,7 +308,9 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  		goto msix_ctx_fail;
>  	}
>  
> -	bng_re_query_hwrm_version(rdev);
> +	rc = bng_re_query_hwrm_version(rdev);
> +	if (rc)
> +		goto query_hwrm_ver_fail;
>  
>  	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
>  	if (rc) {
> @@ -392,6 +396,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  nq_alloc_fail:
>  	bng_re_free_rcfw_channel(&rdev->rcfw);
>  alloc_fw_chl_fail:
> +query_hwrm_ver_fail:
>  	bng_re_destroy_chip_ctx(rdev);
>  msix_ctx_fail:
>  	bnge_unregister_dev(rdev->aux_dev);
> -- 
> 2.52.0
> 

