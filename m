Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2F281200
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBMHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 08:07:08 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11276 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMHH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 08:07:07 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7717830000>; Fri, 02 Oct 2020 05:05:23 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 12:02:39 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 12:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSq8+lw4/X0XhraV5PBsEZew8qDPAwH3d9+DuPISCOsQGSFiS1+l0N8WFgMb5oEDL+7Ag1MlXQ0x++XvejtGACcLg2Lyn2Sxu6vxWM9rL4/1DKUWeO3V9girGU1ZrTjJV2uRYmriepgO2dXZ+0fsiOUXe4BvUlzExBKKerSxQzkwWvFY0adgzNUal2RZvTjyalyAYxiFTbYmwTEXj9Jj4Hs/qura+1qKSVYg1W+8D1OvHXTlrKC/REfZ6p/A6UD3lmkGyCp35wRP097Mh54tL8aJ37Mub86Dvo3Nb6e7YF8CuhbCnrCAZg1PqIx50/T+tcvEqU48VkWpjPl1fdwxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwOna/ptcQ1fsSdXueMKnkEEDTNOy6II/i1TixQ+dX8=;
 b=WfRdhZdwMEEDfGlUgtKTvkS9Q+UABihAm60XeXRtw9yeq1WveBW6OdxkKO1TX9CcVKeRgTETK2rsO1gkEMsfnwdMidypbloKu31NqKIjVC+MkLE4qPm/1vTP3Us72nc9syofYqqnC3Vwo/uqCD5Wh7nmvzeuVdSlMWLvVGCd/4OHTBES1dFn7PEu3DYW8fXTFEbGFZz8cL8850g883fFk1dMCNyuwxHRVguraqeRQE6TqLLTJ0obsdHxef7hgYZjlmx5CKY8bZZTj6u3ztc8xB7WOVHbeXEmm3OTODDtc86QGFDh0bkMowWwHPJ+7dCkl4u9X11DnBX+lNk1o2R1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Fri, 2 Oct
 2020 12:02:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 12:02:38 +0000
Date:   Fri, 2 Oct 2020 09:02:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/ipoib: Set rtnl_link_ops for ipoib
 interfaces
Message-ID: <20201002120236.GA1327974@nvidia.com>
References: <20200930094013.156839-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930094013.156839-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:208:e8::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Fri, 2 Oct 2020 12:02:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOJlk-005ZUZ-SW; Fri, 02 Oct 2020 09:02:36 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601640323; bh=KwOna/ptcQ1fsSdXueMKnkEEDTNOy6II/i1TixQ+dX8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=aBS/qSpQia5zvs8XPCj6nyWhrHm8t2oxwdaSem/vweRHs1UWtD6WvAjgHwJN6Gd36
         dGFGg7Bp1iCJAAGC68AEVZeYa5gcr4FjiHSTdyYmSWp9QjrNIlx0tY6WpdxWgvmDz5
         DWNRl1MU3ru06f37C0uir+Ei8/X/J8QjdOiBJr8IiSKf4TbmA0PNp8DWpZtwY9BWpn
         7n1WcHKQoBphTOqaIvVqvWZbo30VESSkGXMtFGNKuZJalDA43FJV2a7Clj1yu99c5t
         4xKqevcKh6iTb/pTnPPhJNVgh82Qk1zjKU8byVHVbF/G/bV6rH591ikEkw3JVhdQLs
         /b5gkdTeQ8nLQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 12:40:13PM +0300, Kamal Heib wrote:
> To avoid inconsistent user experience for PKey interfaces that are
> created via netlink vs PKey interfaces that are created via sysfs and the
> base interface, make sure to set the rtnl_link_ops for all ipoib network
> devices, so the ipoib attributes will be reported/modified via iproute2
> for all ipoib interfaces regardless of how they are created.
> 
> Also, after setting the rtnl_link_ops for the base interface, implement
> the dellink() callback to block users from trying to remove it.
> 
> Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> v2: Update commit message.
>  drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
>  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
>  drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index ab75b7f745d4..96b6be5d507d 100644
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -2477,6 +2477,8 @@ static struct net_device *ipoib_add_port(const char *format,
>  	/* call event handler to ensure pkey in sync */
>  	queue_work(ipoib_workqueue, &priv->flush_heavy);
>  
> +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> +
>  	result = register_netdev(ndev);

Why do we need this one? I understand fixing the sysfs but not this part.

>  	if (result) {
>  		pr_warn("%s: couldn't register ipoib port %d; error %d\n",
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> index 38c984d16996..d5a90a66b45c 100644
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> @@ -144,6 +144,16 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
>  	return 0;
>  }
>  
> +static void ipoib_del_child_link(struct net_device *dev, struct list_head *head)
> +{
> +	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> +
> +	if (!priv->parent)
> +		return;
> +
> +	unregister_netdevice_queue(dev, head);
> +}

The above is why this hunk was added right?

>  static size_t ipoib_get_size(const struct net_device *dev)
>  {
>  	return nla_total_size(2) +	/* IFLA_IPOIB_PKEY   */
> @@ -158,6 +168,7 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
>  	.priv_size	= sizeof(struct ipoib_dev_priv),
>  	.setup		= ipoib_setup_common,
>  	.newlink	= ipoib_new_child_link,
> +	.dellink	= ipoib_del_child_link,
>  	.changelink	= ipoib_changelink,
>  	.get_size	= ipoib_get_size,
>  	.fill_info	= ipoib_fill_info,
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> index 30865605e098..c60db9f3f5ac 100644
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> @@ -129,6 +129,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
>  		goto out_early;
>  	}
>  
> +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> +

If this is only for the sysfs case why isn't it in ipoib_vlan_add()
which is the sysfs only flow?

Jason
