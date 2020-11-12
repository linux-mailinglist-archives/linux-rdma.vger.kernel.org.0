Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9C2B0A02
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLQcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:32:35 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2609 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLQce (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 11:32:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad63a90002>; Thu, 12 Nov 2020 08:32:41 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:32:33 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlbM9TXJESzUIcCZw1CG9Xsw8r1jdfdeXb3+IfXZ8HlbMz5E0n4zc3/9TB8xaiPZvtVklbSNjZreWu5Hd0t9h5mkUFoPbUYWhANr/lFzzVj2youPYtrJsHibCJikTs/jqvwmVDnbUh7EJSzIFl1Ki/rowGBuQDFBurI3Wi0Ke+WWiqRNUbxAI72lxyPG3cR5QoyZSKe8+jSpTJoqJnuIEDet0CbJ781PPF9sThr+yeNlJYKPqKmxuyxZecnQ4JOvgE5WESsxXGLTALioX1f7UPE3Z/bmwOKyOcMiUrAYi0PBJCuRCpl3jq9nKKw4tflJgG7GeByDMa6n/hxdVY5nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRe1SMsnU9eSCa26p0C2lPRBmY3V63gsIkuX+MhEDLY=;
 b=Bq1Ywf9tmkH2XWU4AIGJYAcjyGWMfokSeK/NvX7HxIgZ7vtgNS/Jw2SEldGp127K4wnVPVWTopKV2fXcEQo3uvgXzmlSpzL2HN1JQFdu2bPR2HHehL5aclUPzUe3MQgwRii4K7fTO/nijN46vzuuy8EUCEfa1mA48DGBBNzbA+SWpDlIGRZLzTWw5JTfd1Dzdrg/0cm/z7OfP9WAGJ60Adgs9WUy2ccHYJiLBtBVD0VySP78PA80DOtYBFh0iRJl5jO1c6XbhKP7DpmK88dSWh3YFDLDjNzCi75QCSNeGjXCIrJLN2nhUiETWPfBn1CNHctU0Y9Qw1lY2L8WXlyNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 16:32:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:32:32 +0000
Date:   Thu, 12 Nov 2020 12:32:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] RDMA/cm: Make the local_id_table xarray non-irq
Message-ID: <20201112163230.GA904052@nvidia.com>
References: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:208:e8::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:208:e8::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 16:32:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdFWQ-003nC8-RR; Thu, 12 Nov 2020 12:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605198761; bh=GRe1SMsnU9eSCa26p0C2lPRBmY3V63gsIkuX+MhEDLY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=mTmfN1ZfiiomWwZFtLDQdz+sh1eMvJ3ooAwo0pQrYS6PZKewfH+NmIWZJcZ4QCN66
         s4uCfNpnojrIJkHXeBzqOwS0+sFMLkdSfrLA/h+yHnF5mL4wkIZbWEPXU/Ze80bQnI
         9iSXyYHkmfxmFitOTzeNA1F+KzqJVFdnNRXZ5s+ogbyo1vXO5JrYkucGDndluhRPsR
         /kOEEDg/EYLM4m8DpCYBC0Ku/oY0WuIFJOJ89mqBz7ZsR9JVwe0gGyAdWY4F/P3ls9
         4/E/z62PcApm0iYEPS5bRpgq7Quzm7w7xF2r3/7cuDS6O5EUIL3oo9O/RZI63oG7c0
         LOFvTD9a1vDIw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 05:40:59PM -0400, Jason Gunthorpe wrote:
> The xarray is never mutated from an IRQ handler, only from work queues
> under a spinlock_irq. Thus there is no reason for it be an IRQ type
> xarray.
> 
> This was copied over from the original IDR code, but the recent rework put
> the xarray inside another spinlock_irq which will unbalance the unlocking.
> 
> Fixes: c206f8bad15d ("RDMA/cm: Make it clearer how concurrency works in cm_req_handler()")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to for-rc, thanks

Jason
