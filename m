Return-Path: <linux-rdma+bounces-18794-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMEzOLKpymkG/AUAu9opvQ
	(envelope-from <linux-rdma+bounces-18794-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 18:49:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F135F0A3
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60C573012A96
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0213DBD47;
	Mon, 30 Mar 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUY3Lnn8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151238F954;
	Mon, 30 Mar 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889348; cv=none; b=JUjdJc8pLBPTqitRss0cjChZ4aQFfDmdCvLjgc/73OPUczqbq2/Y98IaJzt3cnU5SwfRSk7PlOI7VbJkJut3fstD1nhlJaj+JO1YAl0+BEqA+Eilry/q+Y0QWT6xUhuR7mChCvw9Xlfl6U94EN7ijmtmIfe0dKSzFsjbT8qFH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889348; c=relaxed/simple;
	bh=SK9i7mqg/8dE6xiF6EF//eDfj1oB7TxRof8X0+8hqiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwfyvZUCZhFclrd1KqMogoFGWsI9GZ+aF3EabtB74NXjZln0T0/whwJXNzFpxLuwufVV0soZckC6d5xGan26k2oNU++EKGALlsnOKi3DodBk72XIWJwYY1UNoaZg6s9QywsHcfhfCfnWIoxCqNQZDKfaH8nRsaXPIv9zxn65FZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUY3Lnn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D30EC19423;
	Mon, 30 Mar 2026 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774889348;
	bh=SK9i7mqg/8dE6xiF6EF//eDfj1oB7TxRof8X0+8hqiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUY3Lnn89tL+nhhMM8+RaWd+5SzKROFBfAPVom13WjZ1juwseG6yzmimNaMKPxar6
	 TzldklXfJ+4xrZ7tiwdgIOVEI3km+BT6VeVXcJu39lHiH9nrzTQR6Sdke2C+xLoSCP
	 LZh6FfdXNDZK2dfyoYdEmsZJqw4N6YT5GQWW79pkuYoR/BY2BTEhlQz3H74X9ddVwi
	 1PWoaTcfUNFlRhiyKHLHQy3Qj6XxILiPvuZyjIgGdRpWA0DCXEM5JpYw/QXV9OVHRg
	 aYXt6nfrNyAIDWxcLv+IWob5hCbpcL4qoS52rcATT7EGfJ2pv2a7fTF5o/ZyniPZB+
	 rkRh9utkxmTsw==
Date: Mon, 30 Mar 2026 19:49:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net/mlx5e: Add null check for flow namespace in
 mlx5e_tc_nic_create_miss_table
Message-ID: <20260330164902.GW814676@unreal>
References: <20260326205824.11749-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326205824.11749-1-rayfraytech@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18794-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D75F135F0A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 09:58:22PM +0100, Oskar Ray-Frayssinet wrote:
> mlx5_get_flow_namespace() can return NULL if the namespace is not
> available. Add a null check to prevent potential null pointer
> dereference when accessing ns->node.

MLX5_FLOW_NAMESPACE_KERNEL and MLX5_FLOW_NAMESPACE_FDB flow namespaces are always available.
The driver and device cannot operate without them.

Thanks

> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 1434b65d4746..503c9cc96a02 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>  	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>  	ft_attr.prio = 0;
>  	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> +	if (!ns) {
> +		netdev_err(priv->netdev, "failed to get flow namespace\n");
> +		return -EOPNOTSUPP;
> +	}
>  
>  	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>  	if (IS_ERR(*ft)) {
> -- 
> 2.43.0
> 

