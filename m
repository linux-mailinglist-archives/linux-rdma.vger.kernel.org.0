Return-Path: <linux-rdma+bounces-3539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6591A33B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9865B23629
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385B13BC1B;
	Thu, 27 Jun 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4/p8Alt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9913B285;
	Thu, 27 Jun 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482231; cv=none; b=eDLXeQj7WTnb34qU+B8pS7m3hFBAVW4jb0fHtVAaTTWTqqokRztUOTuOXnlN7P3wihGTdVTGCzZjPw6IFauc59WeWBbs3CW1qlpkGOyz5Xs3tqTeV09X1TqXr3rmQtl4vt7wR3YDqRIyuP2/HsO2dnuSG95bjQfVWXmeRfDuA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482231; c=relaxed/simple;
	bh=klZF4oL5BFPuJFiCCyzgvkVr2598ZjJmTgNRxIRIx2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIvaAyTCbgRbTg1YgYzBlvkIyTff+1NwLQjuVdo1wwjoA/UOiuBUs4GBs9wspWfBZhnDMwYNK/rtRmkQNjonNVNglpjs43OrnW0rh7Q6uZ6wTk9yHbu4RsHRyw+nV7xHr8XqVt8RG37mE/nGNZPys/XqVaRqT0BZ2Nc4J+dwrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4/p8Alt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F17C2BBFC;
	Thu, 27 Jun 2024 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482230;
	bh=klZF4oL5BFPuJFiCCyzgvkVr2598ZjJmTgNRxIRIx2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4/p8Altdrr29omLIwjLTn3DIAJ64IJw4ocLYHzkBppjVmyEaEjq/5+rCC852X4Yn
	 YDl2DMUQoOUI7goHUYhXCIbftRMHgJEVjCNHfBkXzywtoSLdPNF5V5FJL5QbJ+bTYl
	 of3iOdwlkrt48zoLExrff+7nT57dOQ5Z713aCqHo65ZEv+Z+SVxEdFkcjGp9ziMKhs
	 RscETQgYMbW+78aVAWRNU3Esn57n1xYYBnIXNh62xs0ZDUilJdfvEMiGh63N5QdLjN
	 nlUGnXDYoHig5RrahEqem/SJbf/JsUPnlXXqrbop631jzlPwmQRWpvFaI12TZTbmoi
	 TS9j+YHzq07PA==
Date: Thu, 27 Jun 2024 12:57:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240627095705.GS29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <20240626082731.70d064bb@hermes.local>
 <20240626153354.GQ29266@unreal>
 <20240626091028.1948b223@hermes.local>
 <PAXPR83MB05592AE537E11C9026E268F7B4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <DM6PR21MB14819FB76960139B7027D1EECAD62@DM6PR21MB1481.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR21MB14819FB76960139B7027D1EECAD62@DM6PR21MB1481.namprd21.prod.outlook.com>

On Wed, Jun 26, 2024 at 06:29:02PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> > Sent: Wednesday, June 26, 2024 2:20 PM
> > To: Stephen Hemminger <stephen@networkplumber.org>; Leon Romanovsky
> > <leon@kernel.org>; Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>; Wei Hu
> > <weh@microsoft.com>; sharmaajay@microsoft.com; Long Li
> > <longli@microsoft.com>; jgg@ziepe.ca; linux-rdma@vger.kernel.org; linux-
> > netdev <netdev@vger.kernel.org>
> > Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into
> > ib
> > 
> > > > > > On Wed, Jun 26, 2024 at 09:05:05AM +0000, Konstantin Taranov
> > wrote:
> > > > > > > > > When mc->ports[0] is not slave, use it in the set_netdev.
> > > > > > > > > When mana is used in netvsc, the stored net devices in mana
> > > > > > > > > are slaves and GIDs should be taken from their master
> > devices.
> > > > > > > > > In the baremetal case, the mc->ports devices will not be
> > slaves.
> > > > > > > >
> > > > > > > > I wonder, why do you have "... | IFF_SLAVE" in
> > > > > > > > __netvsc_vf_setup() in a first place? Isn't IFF_SLAVE is
> > supposed to
> > > be set by bond driver?
> > > > > > > >
> > > > > > >
> > > > > > > I guess it is just a valid use of the IFF_SLAVE bit. In the
> > bond
> > > > > > > case it is also set as a BOND netdev. The IFF_SLAVE helps to
> > show
> > > users that another master
> > > > > > > netdev should be used for networking. But I am not an expert in
> > > netvsc.
> > > > > >
> > > > > > The thing is that netvsc is virtual device like many others, but
> > > > > > it is the only one who uses IFF_SLAVE bit. The comment around
> > that
> > > > > > bit says "slave of a load balancer.", which is not the case
> > > > > > according to the Hyper-V documentation.
> > > > > >
> > > > > > You will need to get Ack from netdev maintainers to rely on
> > > > > > IFF_SLAVE bit in the way you are relying on it now.
> > > > >
> > > > > This is used to tell userspace tools to not interact directly with
> > the device.
> > > > > For example, it is used when VF is connected to netvsc device.
> > > > > It prevents things like IPv6 local address, and Network Manager
> > won't
> > > modify device.
> > > >
> > > > You described how hyper-v uses it, but I'm interested to get
> > > > acknowledgment that it is a valid use case for IFF_SLAVE, despite
> > sentence
> > > written in the comment.
> > >
> > > There is no documented semantics around any of the IF flags, only
> > historical
> > > precedent used by bond, team and bridge drivers. Initially Hyper-V VF
> > used
> > > bonding but it was impossibly difficult to make this work across all
> > versions of
> > > Linux, so transparent VF support was added instead. Ideally, the VF
> > device
> > > could be hidden from userspace but that required more kernel
> > modifications
> > > than would be accepted.
> > 
> > Thanks Stephen for the explanation!
> > 
> > I am also CCing Haiyang, who maintains Hyper-V netvsc.
> > 
> 
> Yes, netvsc sets the IFF_SLAVE on VF for the bonding.
> 
> Acked-by: Haiyang Zhang <haiyangz@microsoft.com>

Konstantin.

I don't want to be first and only one driver that uses this flag
outside of netdev. So please add new function to netdev part of mana
driver to return right ndev.

Something like that:
struct net_device *mana__get_netdev(struct mana_context *mc)
{
	struct net_device *ndev;

	if (mana_ndev_is_slave(mc->ports[0]))
		ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
	else
		ndev = mc->ports[0];

	return ndev;
}

And get Acks from netdev maintainers (Jakub, David, Eric, Paolo).

