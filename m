Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B19282AD0
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgJDNFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 09:05:01 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10894 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJDNFB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 09:05:01 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f79c87a0000>; Sun, 04 Oct 2020 21:04:58 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 4 Oct
 2020 13:04:58 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 4 Oct 2020 13:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpFRkuFm8AJJw0pyZWhHuKfbl+0KNrYCQtOvaPbXII7JWQhFcouezoMKjrmfrMoSgqMomJoatZMD5AElBNk3gD8PRNHBq8VriXlhzeP/rMSWe5h91PDnsABhsUzRy3T7bXaWsXloRVR8t+m5jwt92joWX5B4U5w01/gZE9a6MOjMQ36q1tauQFFC9FeTGzF90wVpsJUQ8XBnyr0W0gT+qDuL7EpmSIz5vNb9C+y67C2NG0aDefJ1FyaDOduB3yXTY3S3X5acXKez8tGU8Vo93FwJYZop1/lSofIrZZJ5uYYWKqVgy6YZPD05Iy3fXC0s+3aJ70WDJolt0kv/DalCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWJK6FmWFDFDRM6UHQCwVWahh3PLhlWoCe4o3s8baZE=;
 b=ZqaPeJfK3/JMyiPACi9T3/FzsIGJkSBUIHXveeFf53yRvoSfgrrEFOpFAd88q87GnrkRlNUTUEq1NpWsfxqCQuny4/OhK9zmvpo0pRAkgq2hz+78ISnb3IIA95MwvwraB85y/tWxmMMYSYbcIwZbe/rlmYSxagMb37jTy1bM/YKpgsTvtDlsedqntcBRB5aU+zOHXoI/hS5nDIiFdzzPfApv8FaV0pp82OfrS7jnB3cDjqj6dSWaqciMtjmg8JleXYkTDF3SBCdF0rfvlh6l5rSiBz6zDbF5K5yjBjfzJH0igCYYA3n6j2Z03lwhanI1uCUJ3hUp8sXRs6zOcBlIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 13:04:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sun, 4 Oct 2020
 13:04:55 +0000
Date:   Sun, 4 Oct 2020 10:04:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/ipoib: Set rtnl_link_ops for ipoib
 interfaces
Message-ID: <20201004130454.GS816047@nvidia.com>
References: <20200930094013.156839-1-kamalheib1@gmail.com>
 <20201002120236.GA1327974@nvidia.com>
 <20201004125107.GA5480@kheib-workstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201004125107.GA5480@kheib-workstation>
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend Transport; Sun, 4 Oct 2020 13:04:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kP3h8-007HRq-EI; Sun, 04 Oct 2020 10:04:54 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601816698; bh=zWJK6FmWFDFDRM6UHQCwVWahh3PLhlWoCe4o3s8baZE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WewCCTawMkMHstJV/7ApfmdYE3GFAdWuofhV3K45Mehe+HSTP/prwIjh1CsRIe7gD
         ViJUC7zYEFK7OgWFu2f4MuyYJZAX09lXS+gkrCVfCgmIX6Evfow4RIiIuZbWkC7KVW
         0svIiUyQJjADWZm/GB6zpEsHk8jBtNW0ESiIZZq93ONh3mfd1Mx02f0NKEF3BnM2Jb
         03cyYwozwlRn3FpstwLSystM+Z20xhGNuiPlWgTG/KEmCvkeAToT617N+qeluqs0c9
         36jpaeHtAK5JczkvlIZySmAe8Tdlhsjg76BElQxCkReRmAotR5upeRSK4yE1C3aVvl
         WWLypwUmc95TQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 03:51:07PM +0300, Kamal Heib wrote:
> On Fri, Oct 02, 2020 at 09:02:36AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 30, 2020 at 12:40:13PM +0300, Kamal Heib wrote:
> > > To avoid inconsistent user experience for PKey interfaces that are
> > > created via netlink vs PKey interfaces that are created via sysfs and the
> > > base interface, make sure to set the rtnl_link_ops for all ipoib network
> > > devices, so the ipoib attributes will be reported/modified via iproute2
> > > for all ipoib interfaces regardless of how they are created.
> > > 
> > > Also, after setting the rtnl_link_ops for the base interface, implement
> > > the dellink() callback to block users from trying to remove it.
> > > 
> > > Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > v2: Update commit message.
> > >  drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
> > >  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
> > >  drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
> > >  3 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > > index ab75b7f745d4..96b6be5d507d 100644
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > > @@ -2477,6 +2477,8 @@ static struct net_device *ipoib_add_port(const char *format,
> > >  	/* call event handler to ensure pkey in sync */
> > >  	queue_work(ipoib_workqueue, &priv->flush_heavy);
> > >  
> > > +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> > > +
> > >  	result = register_netdev(ndev);
> > 
> > Why do we need this one? I understand fixing the sysfs but not this part.
> 
> We need this one to report/modify the ipoib attributes for the parent
> interface (please take a look at pkey, mode, and umcast after applying
> this patch):
> 
> $ ip -d link show dev mlx5_ib0
> 29: mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
>     link/infiniband 00:00:1f:e4:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520
>     ipoib pkey  0xffff mode  datagram umcast  0000 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535

So this is what you mean by "base interface" ? Hmm OK. Highlight this
a bit more in the commit message since this is something everyone
will see

> > >  static size_t ipoib_get_size(const struct net_device *dev)
> > >  {
> > >  	return nla_total_size(2) +	/* IFLA_IPOIB_PKEY   */
> > > @@ -158,6 +168,7 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
> > >  	.priv_size	= sizeof(struct ipoib_dev_priv),
> > >  	.setup		= ipoib_setup_common,
> > >  	.newlink	= ipoib_new_child_link,
> > > +	.dellink	= ipoib_del_child_link,
> > >  	.changelink	= ipoib_changelink,
> > >  	.get_size	= ipoib_get_size,
> > >  	.fill_info	= ipoib_fill_info,
> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> > > index 30865605e098..c60db9f3f5ac 100644
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> > > @@ -129,6 +129,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
> > >  		goto out_early;
> > >  	}
> > >  
> > > +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> > > +
> > 
> > If this is only for the sysfs case why isn't it in ipoib_vlan_add()
> > which is the sysfs only flow?
> >
> 
> Basically, I was making sure set the rtnl_link_ops before calling
> register_netdevice(), but you are right this can be moved to the
> ipoib_vlan_add() as the setting of the rtnl_link_ops for pkey that is
> created via netlink is done before calling newlink callback, I'll send a
> v3 that move it to ipoib_vlan_add().

Please

Jason
