Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1308B283E09
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJESKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 14:10:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:64685 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJESKl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 14:10:41 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b619f0000>; Tue, 06 Oct 2020 02:10:39 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 18:10:38 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 5 Oct 2020 18:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0GwoBsvRQpKgPJHb7WMzdf7BXCe2UehyTifq3ALhhJlU25Vyub786bstQcZuop3qVGb2L6CkLmXdsDR0/37nAdMnQ0T5xNHiZh4LQXfeue73k/A8HjZFcHFonwYFzQHj0069NnRJ/YAOuZBxku1WHjjuI1YQdgKBafmoUpkwNRHGZYLjjkdb2b1feob4LGEtmuP/2aEYrzl54FQmFV91yP0VPSy+bRFG3PwLv7NEks2gkjy6tqe3Vh8+UEQEp0gGrRaldJ0sOdsAsptl+pPDvOvC5oRvQ4C9aNAn/LGzhVXu4S0/NMvvQKw8QyRCJmRVOosAniZRlLp3SC4nUzA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VOXdOjNX2k93c6x1AzUifFv6c1RypCRmY3oCXIDDzY=;
 b=BdPuglyf+R3WZj3MkzfwReuBBpTBUN5YHeXMdQ/NlVnEV08CiVKnvVXNShrdUp9EgcXTyXst+w8d7fcrfk+mQ+lmxrK15UIxd8KovjY4/7vEJ+ryTSq991HVVr3tbs6iyONPhYVWCBYiiI3f0fbvjd1Za+OVNMdBFQ/Jz75xx7gLV2MDs+HRenFIJgXkWGj1yi+sZ0gXxP6VvR0dHTq3CkRl/nJjV4Tu23mJCvap26K5uBnWgPzDx3Vb5Ht2+iltcwwjI9fz84f//frpyPLLY4hm9/7DVqsDA5bTI/ey+Qd8hiBymjXPxcGfoEwl1KnaFuTB3V7dTHD6D3fCsVtHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 18:10:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 18:10:37 +0000
Date:   Mon, 5 Oct 2020 15:10:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v3] RDMA/ipoib: Set rtnl_link_ops for ipoib
 interfaces
Message-ID: <20201005181034.GA31303@nvidia.com>
References: <20201004132948.26669-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201004132948.26669-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:208:238::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 18:10:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPUwU-00089k-RB; Mon, 05 Oct 2020 15:10:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601921439; bh=1VOXdOjNX2k93c6x1AzUifFv6c1RypCRmY3oCXIDDzY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rA8TJhInbC/ZUIbHVIEHiZI7McrQPiLUr2bqn2jqFohO8wCl23jEtJDv0lofNSoYI
         Z8zRnG273nSSm5gfpn0zZn5j2erSN4zv7XGDn/lyiub8EvaRGy38htlLHczEzDI4Lo
         0khfguc+fe7kLPOUfdhudO1ChXscXfY14PWjIwTlOIxbCYyvi8jL5zXC8GSKpASf9v
         ziExHN+2C8HX9iTfhtZASmQwOBjAvjO2azzvyizwMkpWXfWXdNudYkQPa9aBhu+Vn4
         zIhAlRc7zOziusJOIDa9Jrknrvj5/Hph0bWNdnORXmAxC4wk7yobKuu8dvtjZd7j44
         76MplkX20bmNw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 04:29:48PM +0300, Kamal Heib wrote:
> To avoid inconsistent user experience for PKey interfaces that are
> created via netlink VS PKey interfaces that are created via sysfs and
> parent interfaces, make sure to set the rtnl_link_ops for all ipoib
> network devices (PKeys and parent interfaces), so the ipoib attributes
> will be reported/modified via iproute2 for all ipoib interfaces
> regardless of how they are created.
> 
> Also, after setting the rtnl_link_ops for the parent interface, implement
> the dellink() callback to block users from trying to remove it.
> 
> Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
> v3: Move the setting of rtnl_link_ops to ipoib_vlan_add() and update
>     the commit message.
> v2: Update commit message.
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
>  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
>  drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
>  3 files changed, 15 insertions(+)

Applied to for-next, thanks

Jason
