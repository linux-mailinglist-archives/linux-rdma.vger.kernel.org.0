Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63792FF31C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAUS0T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:26:19 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6625 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389491AbhAUSRn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 13:17:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6009c4f70000>; Thu, 21 Jan 2021 10:16:23 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 18:16:22 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 18:16:20 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Jan 2021 18:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz+dw9HbO87Em1MiGkJizMGcJNFLpe0b5dl5gWYvwY+skc1wu0PBDy+o3zMK54KYLrCOVqKnws3z5dl6v591QKbVnUlZSB7ldxCg6SQY5SM2B+ZiUGkvXYH7r8mubNADefNCINhYsOEQVflzvSQ0xYunQJbc6IdiqJghxaNyC+rt5FnxcmB1JYf1YC4Mm/aEaqKRBbrdGWpZ4b3fOGGwuCgRYSCMy1BgD4okdv5tEMqZZv/cDWg50a21xxIk6CoTJlkQrLa6jCKV8ZBpr/bSbC7Y9/uBmBhF1zYfLRqbvkgAbCNeNq6Sd1ycgE4ukkQzknXH/YnBoKVoRmiiXkasyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNssNcLT1WJGIY5EAWd/Ag8rXNjN3VAe26VFF/7F6h0=;
 b=Ohxa79Zk2KGqQNjavLoOTGDvMjHf9g88FwuQdaR9wquYLDOjTAgegNfmkNQqG7djmoUHJPjTC+aNGY5ImF6tPPGUgFJeHnJsMN25v6SY8V96TD1qYNRWwMCDV1YG6K+Ej16ddL3LMlpviH2qviUDzBQ/dvgIO+Z2JYXWjryWCR/SmJQqW982KCFnoJJx2qVL2w/GFVx7UXhf53Uk11SP/OyOyPB1jz/mF0xcBeNWNRLYImaTpdxp219JBqailCAS77BwHq5Vc3Ux7VtWt4v1xUvdkAEeRAn1aabmThyQU1d5cRTvd0ZFW0mJGHnRF7BQMOMjPzsJSk8nToF3JQbynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 18:16:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 18:16:17 +0000
Date:   Thu, 21 Jan 2021 14:16:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Manjunath Patil <manjunath.b.patil@oracle.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <valentinef@mellanox.com>, <gustavoars@kernel.org>,
        <haakon.bugge@oracle.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] IB/ipoib: improve latency in ipoib/cm connection
 formation
Message-ID: <20210121181615.GA1224360@nvidia.com>
References: <1611251403-12810-1-git-send-email-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1611251403-12810-1-git-send-email-manjunath.b.patil@oracle.com>
X-ClientProxiedBy: BL1PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Thu, 21 Jan 2021 18:16:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2eVD-0058Wq-Ot; Thu, 21 Jan 2021 14:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611252983; bh=wNssNcLT1WJGIY5EAWd/Ag8rXNjN3VAe26VFF/7F6h0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Xa/04mJxA3XAW8QeP/b6zmuI1g/IsUGeIsrpzLqlTFxtBfdLqFrrZrzkfhI3UQkhT
         ZXUGmW1SMruIarEhRBD45rXo+/i/8iEiC7hwtYPLdUCu7+N8qAg2AE90qVbkoWYv02
         3es9GCanmlpUHuZ7v6PBlYneTusJwM9SKm1+DTiOyMB4reEf6M6E9j665aiVkzhU2T
         V3jnP0JjCCniWWpuCsMsb9F5aBR9GZJcbskCVA91l6Wt1Lq+inme+wmFb4kHS7gI3B
         yc7jKPu6QPFRSwzlHbxIqRVJ+TtG2ugBzEbkAV/QTdpYSW7s2mTXtBeEDWP8NzY6tq
         0PV9vp3crHgpg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 09:50:03AM -0800, Manjunath Patil wrote:
> ipoib connected mode presently queries the device[HCA] to get P_Key
> table entry during connection formation. This will increase the time
> taken to form the connection, especially when limited P_Keys are in use.
> This gets worse when multiple connection attempts are done in parallel.
> Improve this by using the cached version of ib_find_pkey().
> 
> This improved the latency from 500ms to 3ms on an internal setup.
> 
> Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> index 8f0b598..013a1d8 100644
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> @@ -40,6 +40,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
> +#include <rdma/ib_cache.h>
>  
>  #include "ipoib.h"
>  
> @@ -1122,7 +1123,8 @@ static int ipoib_cm_modify_tx_init(struct net_device *dev,
>  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
>  	struct ib_qp_attr qp_attr;
>  	int qp_attr_mask, ret;
> -	ret = ib_find_pkey(priv->ca, priv->port, priv->pkey, &qp_attr.pkey_index);
> +	ret = ib_find_cached_pkey(priv->ca, priv->port, priv->pkey,
> +						&qp_attr.pkey_index);

ipoib interfaces are locked to a single pkey, you should be able to
get the pkey index that was determined at link up time and use it here
instead of searching anything

Jason
