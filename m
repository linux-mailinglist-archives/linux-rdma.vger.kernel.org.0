Return-Path: <linux-rdma+bounces-5946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2409C5B2A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 16:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924051F230A6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400A20102D;
	Tue, 12 Nov 2024 14:57:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B831FEFD1
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423456; cv=none; b=BNwRI7K1rvDGcJfooI/2D9lhwR+GW7c2SW+yMla7Rnu3pusuSJO5dce71/Nhw9G/rokvvdoPwEdN8Ce35BcsaJV1MPG9RuF7YjfJBYUGKyUqKTeBrcF6BoVaOHjLSxknnBDPWzz1LdDTaEkddgnSNevI3KLWB6AWfJGrbezmwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423456; c=relaxed/simple;
	bh=GkPqEdWZYeHWROjUE/+dkcO8iEACrgOjNpaX513jJ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1TlY4lA5r8pFEWZR4p299xGR5V1Sek+qPQEnXmJ6BVcXPUrTElwV+h9QLXtvDxvN7WPm8mgtZcb5LE1Iozj0mfLT/Al3j54kQZg8p7mAgUPJ6pUS7gI4SCFedCCE036G7HdEN2sBESKWZYS1Wnh4GK2AnlfJ2v10pRVUlIpGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (anumula.asicdesigners.com [10.193.191.65])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 4ACE4dIl007684;
	Tue, 12 Nov 2024 06:04:39 -0800
Date: Tue, 12 Nov 2024 09:04:38 -0500
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc v3] RDMA/core: Fix ENODEV error for iWARP test
 over vlan
Message-ID: <ZzNgdrjo1kSCGbRz@chelsio.com>
References: <20241008114334.146702-1-anumula@chelsio.com>
 <20241110130746.GA48891@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110130746.GA48891@unreal>

On Sunday, November 11/10/24, 2024 at 18:37:46 +0530, Leon Romanovsky wrote:
> On Tue, Oct 08, 2024 at 05:13:34PM +0530, Anumula Murali Mohan Reddy wrote:
> > If traffic is over vlan, cma_validate_port() fails to match vlan
> > net_device ifindex with bound_if_index and results in ENODEV error.
> > It is because rdma_copy_src_l2_addr() always assigns bound_if_index with
> > real net_device ifindex.
> > This patch fixes the issue by assigning bound_if_index with vlan
> > net_device index if traffic is over vlan.
> > 
> > Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
> > Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > ---
> > Changes since v2:
> > Addressed previous review comments
> > ---
> >  drivers/infiniband/core/addr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> This patch causes to udaddy regression. It doesn't work over VLANs
> anymore.
> 
> # Client:
> ifconfig eth2 1.1.1.1
> ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
> ip link set dev p0.3597 up
> ip addr add 2.2.2.2/16 dev p0.3597
> udaddy -S 847 -C 220 -c 2 -t 0 -s 2.2.2.3 -b 2.2.2.2
> 
> # Server:
> ifconfig eth2 1.1.1.3
> ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
> ip link set dev p0.3597 up
> ip addr add 2.2.2.3/16 dev p0.3597
> udaddy -S 847 -C 220 -c 2 -t 0 -b 2.2.2.3
> 
> Thanks
> 
> > 
> > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> > index be0743dac3ff..c4cf26f1d149 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -269,6 +269,8 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
> >  		break;
> >  #endif
> >  	}
> > +	if (!ret && dev && is_vlan_dev(dev))
> > +		dev = vlan_dev_real_dev(dev);
> >  	return ret ? ERR_PTR(ret) : dev;
> >  }
> >  
> > -- 
> > 2.39.3
> >
i am able to reproduce the issue with udaddy, i am working on a new patch.
for now you can proceed with reverting this change

