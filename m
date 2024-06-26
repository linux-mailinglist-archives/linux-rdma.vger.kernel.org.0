Return-Path: <linux-rdma+bounces-3522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61309180B1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C8F1F2137A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCC181305;
	Wed, 26 Jun 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpETkwFa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AF17BB19;
	Wed, 26 Jun 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403885; cv=none; b=IqwPviWXDahGTaLqOxdGd9segeO8mwCYrPYFiXsU9OqHEkpqS5IGfegeOcKVWSYWcb+9o3Rc6VZxaXw7X3J5suzTrFW8tQ5M7pJ61/AvscMGqtpKcIr3yuWE9FUxFIGA4N5OPQAyRQem+To6EiNPk8t4Ua9vmxtMqqvWp9PdZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403885; c=relaxed/simple;
	bh=NaxH0blfUI2QdjaA7JXSydGnaLqL//LasxB2gq37NH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT+eMRALwNvxHJFiaGRRDQ7CyEeW2G1bNuHk/23+3E598//kJOYnogrtqjVdleRPqvrIqyZGUE5ZGHcYtUY6ZvkxL7z+iDeaAO6p6XZMpvpYqI47TIPjqB3bsFoDro4oBttIYw4DgpJ0OWMqqRcH9EszfOuqWYzmZBkLumXfr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpETkwFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68649C2BD10;
	Wed, 26 Jun 2024 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719403883;
	bh=NaxH0blfUI2QdjaA7JXSydGnaLqL//LasxB2gq37NH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpETkwFaNfSKFWcD+Ba4ZhItQLKB+qNlkPrz25d1w5QZGOJ1TbAvf+eOu+XfAufds
	 k0PXetTR9rz+4w/EB0B5v8c0D6lKQJdi6h0wgOlNVwHRvmRv6Eiy53c4mTWc/PJpTz
	 eEnMzE6AQQUci2gbAumgG3UDYBGhqZgjYtk83E2CBGfB2GZXdwHXgnEZ551TmqOa59
	 jbPososf+6Hn2+UthW2pB6Rx96TVjo206pTUwZ1GQC6vZXPvXokAtSvTx5JnMA/RrN
	 puXNh5P7zb9lCiKxe59g8wCeyJl5VniwS1SDzzLki+N1JtQNkW6AqIH7m+GfaZJUjT
	 Inv1F7rNwthCQ==
Date: Wed, 26 Jun 2024 15:11:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240626121118.GP29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Wed, Jun 26, 2024 at 09:05:05AM +0000, Konstantin Taranov wrote:
> > > When mc->ports[0] is not slave, use it in the set_netdev.
> > > When mana is used in netvsc, the stored net devices in mana are slaves
> > > and GIDs should be taken from their master devices.
> > > In the baremetal case, the mc->ports devices will not be slaves.
> > 
> > I wonder, why do you have "... | IFF_SLAVE" in __netvsc_vf_setup() in a first
> > place? Isn't IFF_SLAVE is supposed to be set by bond driver?
> > 
> 
> I guess it is just a valid use of the IFF_SLAVE bit. In the bond case it is also set
> as a BOND netdev. The IFF_SLAVE helps to show users that another master
> netdev should be used for networking. But I am not an expert in netvsc.

The thing is that netvsc is virtual device like many others, but it is
the only one who uses IFF_SLAVE bit. The comment around that bit says
"slave of a load balancer.", which is not the case according to the
Hyper-V documentation.
https://learn.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v

You will need to get Ack from netdev maintainers to rely on IFF_SLAVE
bit in the way you are relying on it now.

> 
> Actually, another alternative solution for mana_ib is always set the slave device,
> but in the GID mgmt code we need the following patch. The problem is that it may require 
> testing/confirmation from other ib providers as in the worst case some GIDs will not be listed.

is_eth_active_slave_of_bonding_rcu() is for bonding.

> 
> diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
> index d5131b3ba8ab..0f20b4e2d1c2 100644
> --- a/drivers/infiniband/core/roce_gid_mgmt.c
> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> @@ -141,6 +141,8 @@ static enum bonding_slave_state is_eth_active_slave_of_bonding_rcu(struct net_de
>         return BONDING_SLAVE_STATE_NA;
>  }
> 
> +#define netdev_is_slave(dev)   (((dev)->flags & IFF_SLAVE) == IFF_SLAVE)
> +
>  #define REQUIRED_BOND_STATES           (BONDING_SLAVE_STATE_ACTIVE |   \
>                                          BONDING_SLAVE_STATE_NA)
>  static bool
> @@ -157,11 +159,14 @@ is_eth_port_of_netdev_filter(struct ib_device *ib_dev, u32 port,
>         real_dev = rdma_vlan_dev_real_dev(cookie);
>         if (!real_dev)
>                 real_dev = cookie;
> -
> +       /*
> +        * When rdma netdevice is used in netvsc, the master netdevice should
> +        * be considered for GIDs. Therefore, ignore slave rdma netdevices.
> +        */
>         res = ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
>                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_dev) &
>                 REQUIRED_BOND_STATES)) ||
> -              real_dev == rdma_ndev);
> +              (real_dev == rdma_ndev && !netdev_is_slave(real_dev)));
> 
>         rcu_read_unlock();
>         return res;
> @@ -211,12 +216,14 @@ is_ndev_for_default_gid_filter(struct ib_device *ib_dev, u32 port,
> 
>         /*
>          * When rdma netdevice is used in bonding, bonding master netdevice
> -        * should be considered for default GIDs. Therefore, ignore slave rdma
> -        * netdevices when bonding is considered.
> +        * should be considered for default GIDs.
> +        * When rdma netdevice is used in netvsc, the master netdevice should
> +        * be considered for defauld GIDs. Therefore, ignore slave rdma
> +        * netdevices.
>          * Additionally when event(cookie) netdevice is bond master device,
>          * make sure that it the upper netdevice of rdma netdevice.
>          */
> -       res = ((cookie_ndev == rdma_ndev && !netif_is_bond_slave(rdma_ndev)) ||
> +       res = ((cookie_ndev == rdma_ndev && !netdev_is_slave(rdma_ndev)) ||
>                (netif_is_bond_master(cookie_ndev) &&
>                 rdma_is_upper_dev_rcu(rdma_ndev, cookie_ndev)));
> 
> > > +#define mana_ndev_is_slave(dev)   (((dev)->flags & IFF_SLAVE) ==
> > IFF_SLAVE)
> > 
> > There is no need in macro for one line of code and there is no need in "==",
> > as the result will be boolean.
> > 
> 
> Sure, can address in v2. I just saw a similar macro in another kernel file.

I grepped too and this is why it caused me to wonder why it is not used
except small number of places.

Thanks

> 
> 

