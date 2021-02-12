Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A331A37B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBLRWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 12:22:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12237 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBLRWH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 12:22:07 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6026b9160000>; Fri, 12 Feb 2021 09:21:26 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 17:21:25 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 17:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le4fbKF/pZyjVkiELZtcJ3NPO9Nd8lQI0SP9mBCcsUrdag9Wm34gZP9CCjVM0DxHrmVBn9ipdiVtyYkTXnzw7eqB42oXquZmpEBrnZBMJnf0NMy+u7dWhRqrSsqSeJwEhA/G6OrBgQoC1Y1Na+qmdpLrGmUz9MX+NRXZX9BrLMw1Om9VVuc8l+p4p1Kvjy2b0vdtrdxItTVGYPqCnXQIny2MpBn1IU7FSB1nytOprDPOjXrKjwjlRVkhxLMWpeyxgxjggYcgZ2S0tS/TUOge25c3A+i1FNb3km8Y5cREOedDK+rSxCH+OR8s0WdWhY4rhNHM2T0dDdIRE/S4icEWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FwxostJP/pDaSnqyFbfoAaavk026JodsBFmD5lZRWQ=;
 b=gIK3u0ktd0o2AMsg1D922BMfuZVCyJIIcuBUSLAYxTedM4xfa5vz97nU/sGgKknL+V+4LcFWvxvSM36189vFOrFVxkOMi1pzbx/qBA/qPfNqtdvoJP4Qx4grKaX0conNIcsayKx+IT/H/GCJfriXdiucOZFV2PnOf9ph5rQLfG2LOGWD9CjSgp9qzWH9gxaAJpTGQ3in/zCnCWPV31OwWPAR5Wjon3puqabxkVNGsfjUS5wfbwDB6AeJJv6QDO6SVsEI8zd0cJZ+UPjKkoGfs0SJygOUqmCUokyjcCavC3RkEgdysnaf2oilYMxh971Cj/de8hjxY5YYOL3WkfysWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 12 Feb
 2021 17:21:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 17:21:24 +0000
Date:   Fri, 12 Feb 2021 13:21:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        <g@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        <bart.vanassche@wdc.com>
Subject: Re: [PATCH] RDMA/srp: Fix support for unpopulated and unbalanced
 NUMA nodes
Message-ID: <20210212172122.GA1722574@nvidia.com>
References: <9cb4d9d3-30ad-2276-7eff-e85f7ddfb411@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9cb4d9d3-30ad-2276-7eff-e85f7ddfb411@suse.com>
X-ClientProxiedBy: BL1PR13CA0439.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0439.namprd13.prod.outlook.com (2603:10b6:208:2c3::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend Transport; Fri, 12 Feb 2021 17:21:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lAc8A-007E8c-AR; Fri, 12 Feb 2021 13:21:22 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613150486; bh=/FwxostJP/pDaSnqyFbfoAaavk026JodsBFmD5lZRWQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=PZogU4YgHve+CpqSgEXdHnd+63jgc2PRdWlKquCyxC7A+4dNflPBqzq0W45S5LM69
         dlP4wsrtFClR/WWDr5L2xlfJ5hCC//IixxOxIN+VY4p0F0nDaBWulNm/I2TkTVxOq/
         mp7FMAEQrzBARxVt9AWgqJUMAuys9s8zVTX0x4YclyGKajht/tBxl2lGSowo/uB7Vv
         pfZMiGQKTYWm+9X9jwFayBJ9YZEeOcJdkw3piykBpI7GlZrTR8ZPyrwl7ddaH8+ere
         GfbTX8HjwTbTWpFzP3rHtrZpOsZoWiVHNxjcfNpiXBugdd9TX4rC7l0/m1bXwbt8oR
         lS9fPz/eeyCIQ==
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
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 110 ++++++++++++----------------
>  1 file changed, 45 insertions(+), 65 deletions(-)

Bart?

Jason
