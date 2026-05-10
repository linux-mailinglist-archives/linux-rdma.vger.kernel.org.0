Return-Path: <linux-rdma+bounces-20303-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPp7HFVkAGr5IQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20303-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:56:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2807503AF5
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F97300CBEF
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7A35E958;
	Sun, 10 May 2026 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKFsq8mu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D11E5702;
	Sun, 10 May 2026 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778410576; cv=none; b=eKG7jX729+Gn8wcwq0ByqWqIMcjBQMxqdhG4Tpsz8xGr7/tf4jvZqJg1hnBHbn4LIVlWx2NqPOVGLTA6GMF3ri6j3lLwm4Y90scx6ZvSfNxkRlY0lK9upP5I27lNy6jGQatTLcD6BmhK/mnMwF0RFTT6QXMd2ZiD1hiQm2agdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778410576; c=relaxed/simple;
	bh=61H0Wt2jF9FMwCEYn+OqqvSm9V80Z8gHHYskzeZZ0CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ll8/PZhR3RzUcJMaF75+BJQOv+zAFfzmd6jzt8VIqkmP+/WbRnsLF9RZ0JYxQdZfapWIiO7ovs1eSTJcBN282rpeBnZklxQ2JVcR+fhLM+lx3f+sVr2wYclf4fw/itmW6MwfER/smo7QKHfkzocelZcFGlvfwKEue8gSMzZBU0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKFsq8mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C37C2BCB8;
	Sun, 10 May 2026 10:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778410576;
	bh=61H0Wt2jF9FMwCEYn+OqqvSm9V80Z8gHHYskzeZZ0CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKFsq8mukGkxY1K5didgWf2KKkPkqSXbHfaQ/q/aAuCotXFiQvxuZKy4otgVr+a3U
	 qLm+3LXaBbhIZ2goJ+8jZU5RR621X6jmF5PL2qTK8dar2D48BVcxB6Kyo2ZairKz9u
	 GkgEh8hizcHRcxv1MNrQKs2zHm/Pgbhs1d8EByCMcrLOWw41w2+o3s6fN8XyHhkLDI
	 g2YrIy4VnpkbHyEeRNnCqsiCQ0d6W3F9E9wyTfuX2EBhM/oBKQIryNhaNthD4GLqrk
	 J2NmVdP84xEFk0RtW3uJE7YqWjBEiil1CFUJDtbg27rVyePJHqNXJ/8ChdcbIp0h+N
	 6KgyZDP1JjV8g==
Date: Sun, 10 May 2026 13:56:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, dledford@redhat.com,
	haggaie@mellanox.com
Subject: Re: [PATCH v9 1/2] IB/mlx5: Fix transport-domain rollback and
 initialize lb mutex earlier
Message-ID: <20260510105609.GE15586@unreal>
References: <20260410005219.5197-1-prathameshdeshpande7@gmail.com>
 <20260410005219.5197-2-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410005219.5197-2-prathameshdeshpande7@gmail.com>
X-Rspamd-Queue-Id: E2807503AF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20303-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, Apr 10, 2026 at 01:52:17AM +0100, Prathamesh Deshpande wrote:
> mlx5_ib_alloc_transport_domain() allocates a transport domain and then
> may fail in mlx5_ib_enable_lb(). In that case, the allocated TD is leaked.
> 
> Fix this by deallocating the TD when mlx5_ib_enable_lb() returns an
> error. Also return 0 explicitly in the no-loopback-capability success
> branch, and move dev->lb.mutex initialization to mlx5_ib_stage_init_init().
> 
> Fixes: 146d2f1af324 ("IB/mlx5: Allocate a Transport Domain for each ucontext")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index e02bfb1479f5..6be198c0651c 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2068,9 +2068,13 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
>  	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
>  	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
>  	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
> -		return err;
> +		return 0;
> +
> +	err = mlx5_ib_enable_lb(dev, true, false);
> +	if (err)
> +		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
>  
> -	return mlx5_ib_enable_lb(dev, true, false);
> +	return err;
>  }
>  
>  static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
> @@ -4513,6 +4517,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
>  
>  	mutex_init(&dev->cap_mask_mutex);
>  	mutex_init(&dev->data_direct_lock);
> +	mutex_init(&dev->lb.mutex);

There is also a need to call mutex_destroy() to ensure proper resource cleanup.

Thanks

>  	INIT_LIST_HEAD(&dev->qp_list);
>  	spin_lock_init(&dev->reset_flow_resource_lock);
>  	xa_init(&dev->odp_mkeys);
> @@ -4786,11 +4791,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
>  	if (err)
>  		return err;
>  
> -	if ((MLX5_CAP_GEN(dev->mdev, port_type) == MLX5_CAP_PORT_TYPE_ETH) &&
> -	    (MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) ||
> -	     MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
> -		mutex_init(&dev->lb.mutex);
> -
>  	if (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
>  			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
>  		err = mlx5_ib_init_var_region(dev);
> -- 
> 2.43.0
> 

