Return-Path: <linux-rdma+bounces-12410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ADCB0EB03
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439371AA8001
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3E23E355;
	Wed, 23 Jul 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmbkbPrR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B41DF725;
	Wed, 23 Jul 2025 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253604; cv=none; b=FnmS7Ig0OZ+qeS+wMXuJPu3MMlB9AT4des9TjTCmqBwJHd1EUEC6AT4D+/zKckT8ieRUx9DhAJTGjmGg2VWyeRSWmL4VT29zpQUnSkRhSBxvUN+/yI0pwQbFXE2bToN8ipuin3YhglQVO0zgBVxyEwN8yIxxtee1n4TImS7+dWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253604; c=relaxed/simple;
	bh=vz2E0FW4xCQTolD++PHtUgPfw65t6dNIfiDrgAyBAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBORWolHicQXBRm55rIi0a2oi5kOTbWwqbGg3JPu62XzP/Lj0qs+KDD8xodIDdHBQpW7hIMPlDOUhxC354Oq21G+ZQe10HEByWd06IKTX4Vmzn1uymaV3BdcYLX8xkVRy3L9NoX3rBMRLQXW+R5sFZJ76qfyO6zkTJpjyoMCgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmbkbPrR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253602; x=1784789602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vz2E0FW4xCQTolD++PHtUgPfw65t6dNIfiDrgAyBAxo=;
  b=OmbkbPrR7ckTvu+smN9QnnmJM2hnzvPn78FcfFfJ1P/UYl7LeOyf5qgF
   Bpaaeyw/N9FlTj6rsNu9exwV67DDE2U5SpZ6w5u9oiZEjHyhDhsbza45k
   y79l0hmmwSJHuN0edB6FY/9j8rrCpwCWvGchdTJ0d0tvFNzih9l5Is8Tl
   ktMJQotbk6AnEyY4F84osV+DT8J+yFeys4oC8C6AaZkDTppAs4zeW12Wd
   N3Xh16NzVTKWs6DCwkqCJnkNGF2bzTUDbVoYs3mINmGF678fD2MkrcZUP
   QhrBYjtLdaxw8Sw8mz5ZJt/Hq91HBV4F+O2MI48WRo/ornNnbmxBl4Lng
   A==;
X-CSE-ConnectionGUID: wyJJ1DBbRnifsn5aPgKy1g==
X-CSE-MsgGUID: AyXEwjdtS1KFjkz17qhbIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54743418"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="54743418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:53:21 -0700
X-CSE-ConnectionGUID: H6/jiKkESpi07lLwQV0Bsw==
X-CSE-MsgGUID: z6kjFawRQXCD54aSDerS8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="196439786"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:53:18 -0700
Date: Wed, 23 Jul 2025 08:52:09 +0200
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
	linux-kernel@vger.kernel.org,
	Alexandre Cassen <acassen@corp.free.fr>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next V2 1/2] net/mlx5e: Support routed networks
 during IPsec MACs initialization
Message-ID: <aICGmVC06H+WTy6s@mev-dev.igk.intel.com>
References: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
 <1753194228-333722-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753194228-333722-2-git-send-email-tariqt@nvidia.com>

On Tue, Jul 22, 2025 at 05:23:47PM +0300, Tariq Toukan wrote:
> From: Alexandre Cassen <acassen@corp.free.fr>
> 
> Remote IPsec tunnel endpoint may refer to a network segment that is
> not directly connected to the host. In such a case, IPsec tunnel
> endpoints are connected to a router and reachable via a routing path.
> In IPsec packet offload mode, HW is initialized with the MAC address
> of both IPsec tunnel endpoints.
> 
> Extend the current IPsec init MACs procedure to resolve nexthop for
> routed networks. Direct neighbour lookup and probe is still used
> for directly connected networks and as a fallback mechanism if fib
> lookup fails.
> 
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/ipsec.c       | 82 ++++++++++++++++++-
>  1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index 77f61cd28a79..00e77c71e201 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -36,6 +36,7 @@
>  #include <linux/inetdevice.h>
>  #include <linux/netdevice.h>
>  #include <net/netevent.h>
> +#include <net/ipv6_stubs.h>
>  
>  #include "en.h"
>  #include "eswitch.h"
> @@ -259,9 +260,15 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
>  				  struct mlx5_accel_esp_xfrm_attrs *attrs)
>  {
>  	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
> +	struct mlx5e_ipsec_addr *addrs = &attrs->addrs;
>  	struct net_device *netdev = sa_entry->dev;
> +	struct xfrm_state *x = sa_entry->x;
> +	struct dst_entry *rt_dst_entry;
> +	struct flowi4 fl4 = {};
> +	struct flowi6 fl6 = {};
>  	struct neighbour *n;
>  	u8 addr[ETH_ALEN];
> +	struct rtable *rt;
>  	const void *pkey;
>  	u8 *dst, *src;
>  
> @@ -274,18 +281,89 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
>  	case XFRM_DEV_OFFLOAD_IN:
>  		src = attrs->dmac;
>  		dst = attrs->smac;
> -		pkey = &attrs->addrs.saddr.a4;
> +
> +		switch (addrs->family) {
> +		case AF_INET:
> +			fl4.flowi4_proto = x->sel.proto;
> +			fl4.daddr = addrs->saddr.a4;
> +			fl4.saddr = addrs->daddr.a4;
> +			pkey = &addrs->saddr.a4;
> +			break;
> +		case AF_INET6:
> +			fl6.flowi6_proto = x->sel.proto;
> +			memcpy(fl6.daddr.s6_addr32, addrs->saddr.a6, 16);
> +			memcpy(fl6.saddr.s6_addr32, addrs->daddr.a6, 16);
> +			pkey = &addrs->saddr.a6;
> +			break;
> +		default:
> +			return;
> +		}
>  		break;
>  	case XFRM_DEV_OFFLOAD_OUT:
>  		src = attrs->smac;
>  		dst = attrs->dmac;
> -		pkey = &attrs->addrs.daddr.a4;

Isn't it worth to move getting pkey to separate function? The switch is
the same with OFFLOAD_IN and OFFLOAD_OUT.

> +		switch (addrs->family) {
> +		case AF_INET:
> +			fl4.flowi4_proto = x->sel.proto;
> +			fl4.daddr = addrs->daddr.a4;
> +			fl4.saddr = addrs->saddr.a4;
> +			pkey = &addrs->daddr.a4;
> +			break;
> +		case AF_INET6:
> +			fl6.flowi6_proto = x->sel.proto;
> +			memcpy(fl6.daddr.s6_addr32, addrs->daddr.a6, 16);
> +			memcpy(fl6.saddr.s6_addr32, addrs->saddr.a6, 16);
> +			pkey = &addrs->daddr.a6;
> +			break;
> +		default:
> +			return;
> +		}
>  		break;
>  	default:
>  		return;
>  	}
>  
>  	ether_addr_copy(src, addr);
> +
> +	/* Destination can refer to a routed network, so perform FIB lookup
> +	 * to resolve nexthop and get its MAC. Neighbour resolution is used as
> +	 * fallback.
> +	 */
> +	switch (addrs->family) {
> +	case AF_INET:
> +		rt = ip_route_output_key(dev_net(netdev), &fl4);
> +		if (IS_ERR(rt))
> +			goto neigh;
> +
> +		if (rt->rt_type != RTN_UNICAST) {
> +			ip_rt_put(rt);
> +			goto neigh;
> +		}
> +		rt_dst_entry = &rt->dst;
> +		break;
> +	case AF_INET6:
> +		rt_dst_entry = ipv6_stub->ipv6_dst_lookup_flow(
> +			dev_net(netdev), NULL, &fl6, NULL);
> +		if (IS_ERR(rt_dst_entry))
> +			goto neigh;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	n = dst_neigh_lookup(rt_dst_entry, pkey);
> +	if (!n) {
> +		dst_release(rt_dst_entry);
> +		goto neigh;
> +	}
> +
> +	neigh_ha_snapshot(addr, n, netdev);
> +	ether_addr_copy(dst, addr);
> +	dst_release(rt_dst_entry);
> +	neigh_release(n);
> +	return;
> +
> +neigh:
>  	n = neigh_lookup(&arp_tbl, pkey, netdev);
>  	if (!n) {
>  		n = neigh_create(&arp_tbl, pkey, netdev);

Code looks fine,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

