Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7724F2C1656
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgKWUP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 15:15:58 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18454 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbgKWUP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 15:15:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc187f0001>; Mon, 23 Nov 2020 12:15:59 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:15:57 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 20:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3Sb6lQKKRe8Ur8fDSFF7ck7n67eJUARsdZ241YppPwk51T29jnS0zdFzbA7FRr6dAc7J3mRxwS0I8CRBhXzwsLmfflcwdnTa3FtYnGZLHOF2E4bAalOHNo3P4JH996NovDJ+3ffbgb7XVVr8m4SjTrN2F+rp+P53atv9WH63QDgbRzOyqgMx6teb+2Ml4dKVgeay5nvRkXNECV2Gv1EBCYDjiQBZHHahFIR9J3WqglVFR0gHTEZSJc0XGTNyqx4N8aIJiiFg7IrjYj7QyL7OloAunDLuB3Oi999bvnLx9gAjioC9r/s1+qic0EVyaF02X+3c0uemNdcEDaW0jilnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkv4wkBngWd0JbVHnelCOqmopt3j20rq3d8uo28ftuQ=;
 b=TZ4G+UvHkWRwLPDafGg20JFBwWozJ5OkV5vz2C0Pi9i+IMnI1zKTJ3rdpLibwx9yTPq8gjqz/BvE+DMkCizdnOT4LEyiHRgpcfTEGJXBUx2uoQTyBg1oiNaeFMQZYa0x57LbFTwLIb29wSLHDlzCRKWy+I10zE2NTzsR9b4n4QxpO2zYfx8FGBq/Fu42IuvJqDwCi9Fm1l3iBdGWDLEKvlfeSiipI/9Y8kvXop04pcpvh2NhMDJBwaMmWcPCMPJz9Q2vdJ5ywPmPtWS/rlXujBOjB2aKJobrfuj2TAMYWBtjcujT1Um0RbETU+yWv3OxP9QRg23WoFtStiXcfNFymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 23 Nov
 2020 20:15:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 20:15:50 +0000
Date:   Mon, 23 Nov 2020 16:15:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Zhu Yanjun <yanjunz@nvidia.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>
Subject: Re: [PATCH] RDMA/siw,rxe: Make emulated devices virtual in the
 device tree
Message-ID: <20201123201548.GA43190@nvidia.com>
References: <0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:2d::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:2d::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 20:15:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khIFY-000BFE-PA; Mon, 23 Nov 2020 16:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162559; bh=xkv4wkBngWd0JbVHnelCOqmopt3j20rq3d8uo28ftuQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rJ2WfyH4cQA5zfyM6nDEe4gdtud4jcnBC9k+0lT3NPruX0Nef4EIGfnlCjhryXB4F
         nzj7/CsozCsDKfAhXdZRyyApHQJaozRU1MYeGS+GP5pVkgRCDbuKQaMYojyhxI7tnv
         6stBdw0shOMfGaRP7SLJjhDU1U5cD4hptpS8ohLkCJ3X/JAk30yRNY6CdF3DVQw5DS
         2Se/p/A6WvNYlTGcOWAHekuJTarAlUYBgQFM20nRnaHWO5rzQY54xzh1RQhapDZWLb
         rRnZKO25UKT9pkXQUxlBuHvdYOpIdZkOfleF4DiD958H6z58m3N4KARknYHLSYds9p
         EMjJ2ijsZLUUg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:49AM -0400, Jason Gunthorpe wrote:
> This moves siw and rxe to be virtual devices in the device tree:
> 
> lrwxrwxrwx 1 root root 0 Nov  6 13:55 /sys/class/infiniband/rxe0 -> ../../devices/virtual/infiniband/rxe0/
> 
> Previously they were trying to parent themselves to the physical device of
> their attached netdev, which doesn't make alot of sense.
> 
> My hope is this will solve some weird syzkaller hits related to sysfs as
> it could be possible that the parent of a netdev is another netdev, eg
> under bonding or some other syzkaller found netdev configuration.
> 
> Nesting a ib_device under anything but a physical device is going to cause
> inconsistencies in sysfs during destructions.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c   | 12 ------------
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
>  drivers/infiniband/sw/siw/siw_main.c  | 19 +------------------
>  3 files changed, 1 insertion(+), 31 deletions(-)

Applied to for-next

Jason
