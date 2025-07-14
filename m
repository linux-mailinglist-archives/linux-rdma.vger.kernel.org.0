Return-Path: <linux-rdma+bounces-12111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D15DB03765
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 08:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47E71678DA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD54226D10;
	Mon, 14 Jul 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJhHypb/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0A218827;
	Mon, 14 Jul 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475840; cv=none; b=c5p8F0lmCgQrNR3VGKmhNa4o+iUYN0erRDykX31fymf14STuonNOmmIaNQQrB+G5Tpr1SjAFm7FBRKX12ZFyMBP7gnQMe4/JVB7ho0SRYeuS2vmS+sm2NdsO2IgxkM0cAYf0k+QdLT2EQN+XM2KoYxk8ZaGUL3368Bw4C2ZiWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475840; c=relaxed/simple;
	bh=K4mc5x/W9JtBv/fhS4Ws9JbTJwyveuJyLnrexcFHoMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVSncizkF3nfd1vKlOSaEY35VNGfE1PX9RJUMxzTDodhWWIv8OaIVY9DbUG+7AG5seLOK7KzKWp/oBwD8svggWLqelvQPMjmd9xnO8cXjwhkO70Z5fxQyvWizJH+K0eDIlG1TzWXYBKxJwloBMZmiMrKmPGJRSH0RXrrIkB4800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJhHypb/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752475838; x=1784011838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4mc5x/W9JtBv/fhS4Ws9JbTJwyveuJyLnrexcFHoMY=;
  b=SJhHypb/wpAaC2gpC5StgdZ4//JCKPlRxyqIxzOh+TmFOUKuENsjgEoP
   Oh/sfQD4PM5RSARpUIhd6bWNSoNGiwOTVn8rstQSOkmbNXLKPvmdV2WMU
   RnwGVNYNSLf6wg+U3E/2BRuFXqv0u4IrmtGi6/yCSDnyvlc6MXQH5VBBh
   5mirWh5fM8dTcpz2wExSvt42P3xjpj0WBIwwqnicnLCEKC9dbNuRHxGc0
   yXR5V66QFTaqnArDrh2ZKrBrTW/kyDHn5+HsbTgMyoSewHfpH7WNJu5yr
   dfNDYtvK5UJVbdqqyuh2x2WyIkYDesJ+riOuT2lPqKgkGXUQ0nEAaqU95
   Q==;
X-CSE-ConnectionGUID: BNx1ffXiQpuQnUxXRw5liw==
X-CSE-MsgGUID: JGlkgn+MSWCS+0jlv2EbMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58319973"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="58319973"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 23:50:38 -0700
X-CSE-ConnectionGUID: Mr8VClpdTVmoWQpu7FNLHQ==
X-CSE-MsgGUID: HCV3t0icRR++xmWnzTOKkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="157596729"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 23:50:34 -0700
Date: Mon, 14 Jul 2025 08:49:29 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 3/6] net/mlx5e: Properly access RCU protected
 qdisc_sleeping variable
Message-ID: <aHSocHfM6IRFHneZ@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752471585-18053-4-git-send-email-tariqt@nvidia.com>

On Mon, Jul 14, 2025 at 08:39:42AM +0300, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> qdisc_sleeping variable is declared as "struct Qdisc __rcu" and
> as such needs proper annotation while accessing it.
> 
> Without rtnl_dereference(), the following error is generated by sparse:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40: warning:
>   incorrect type in initializer (different address spaces)
> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    expected
>   struct Qdisc *qdisc
> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    got struct
>   Qdisc [noderef] __rcu *qdisc_sleeping
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/qos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
> index f0744a45db92..4e461cb03b83 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
> @@ -374,7 +374,7 @@ void mlx5e_reactivate_qos_sq(struct mlx5e_priv *priv, u16 qid, struct netdev_que
>  void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
>  {
>  	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
> -	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
> +	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
>  
>  	if (!qdisc)
>  		return;

Good catch, other acesses to the qdisc_sleeping are fine.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.40.1

