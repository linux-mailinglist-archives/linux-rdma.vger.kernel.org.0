Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5131DACB
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Feb 2021 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhBQNiq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Feb 2021 08:38:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17039 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhBQNiZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Feb 2021 08:38:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602d1c270004>; Wed, 17 Feb 2021 05:37:43 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 13:37:43 +0000
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 17 Feb 2021 13:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHFW+VRVdIud5S1ZVc0f7HxjGRzZY59IQRP6IYt/7e5K3n7pBECAQwUQxB7TeEBIFneiViJJ5C6hIEWHiFl3soRebG3E0uHd0xC0ltNnVkezhL3fnMbmOp0999sYiOcNVVpon/JujDVaRuh2tnGlPRkSPBcrPKkEeBeK7DHnKYzW43ddAobpziJDpCt+X34JCKyFBpE06e+wN9rUZ2DcdBQMZbu1jICSRZudNlzE2mX7aoSW0KvcZD8lrnDLM4o5PpeLzSOTZEAMVuPDagHe+dh03xouLKDO7/Hcf0nwm4o5oB+B2kSjUXYZSbVPBss/JiiHLeZ6Tnmz/v+ktIkXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye5Dji+SHUpluPYF9PTquJlmPptl+/bZRX1DTXg1oh0=;
 b=dDbVgxDM2oFcrl1VIawQP8imEfLRmSr8QdXdhoU+HQoT+IxbOPXtCEadJtYOjuLRPu4/+F9HFQbKenqBoe1qdwz6E9Azed9DddMSn87P/U2wqrZvYnt/R9YhBYpJmW2Zon4o+XA3WyVM28B/bT1zgfHNRZ3z54oeVav5++qI8cOXuB5F0MBLCyOe3EK3XUvgsHEA4TI14OmTP1XBqYZ7KjifgzEBWQnHS3vuPYNyNsszCFDVprr/tGYDRBXi+Kx4kTv9cKtqtjRO2i/fWlzmOKUo/uW+4pXrwu+1QXNg7fZGy3lPDGI+vD+WhEk4vaOT7LX8KEPQx4bLbZA4sAW65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 17 Feb
 2021 13:37:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 13:37:42 +0000
Date:   Wed, 17 Feb 2021 09:37:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        <bart.vanassche@wdc.com>
Subject: Re: [PATCH] RDMA/srp: Fix support for unpopulated and unbalanced
 NUMA nodes
Message-ID: <20210217133740.GA2296847@nvidia.com>
References: <9cb4d9d3-30ad-2276-7eff-e85f7ddfb411@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9cb4d9d3-30ad-2276-7eff-e85f7ddfb411@suse.com>
X-ClientProxiedBy: MN2PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:208:134::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:208:134::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 13:37:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lCN1Q-009dWk-Pu; Wed, 17 Feb 2021 09:37:40 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613569063; bh=Ye5Dji+SHUpluPYF9PTquJlmPptl+/bZRX1DTXg1oh0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=do9DhLLR61zT0UwZwQLKKBEi2XAcCt9u3jezjl5yx8OL19EwsCjxfl/3vtD7+pf3U
         DJrOFdGdAgXhdyNGtFGLnhQtsz55GSY8x1REZJUGPVTX2CXfOINptyM1vS4ber+Vk3
         SK+otN6i+FOH8+NI3XNiqh0GLEP6TqIBdAgTWQ1O5UDrLth6VqUM1y/sjL0UeaMyza
         PD89VNOB8mAsM8tEy2LfxPPJRaOy6dFapLkULfhmf59nlCSZnnvHI4uY1IobkwLckR
         Oog9eI/pNg10hH+7zbk6gn2GawLs9/y+NVO5vd9IgAd5iT/ga4amtaPCfLnKzmGf0E
         nCp0RYQzoqc7Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 09:14:28AM +0100, Nicolas Morey-Chaisemartin wrote:
> The current code computes a number of channels per SRP target and spreads
> them equally across all online NUMA nodes.
> Each channel is then assigned a CPU within this node.
> 
> In the case of unbalanced, or even unpopulated nodes, some channels
> do not get a CPU associated and thus do not get connected.
> This causes the SRP connection to fail.
> 
> This patch solves the issue by rewriting channel computation and allocation:
> - Drop channel to node/CPU association as it had
>   no real effect on locality but added unnecessary complexity.
> - Tweak the number of channels allocated to reduce CPU contention when possible:
>   - Up to one channel per CPU (instead of up to 4 by node)
>   - At least 4 channels per node, unless ch_count module parameter is used.
> 
> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 110 ++++++++++++----------------
>  1 file changed, 45 insertions(+), 65 deletions(-)

Applied to for-next, thanks

Jason
