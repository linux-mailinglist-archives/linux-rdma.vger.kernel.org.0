Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3151B2A0C97
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 18:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3RgU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 13:36:20 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24754 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgJ3RgU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 13:36:20 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c4f130000>; Sat, 31 Oct 2020 01:36:19 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 17:36:19 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.54) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 17:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y83jYz6s/aPAXYZpQwwrHzMyrcskt+b8t5Dv3MBg5YC2MAv4LzwrKA0uObewCbKa4g3JgS1okgMOxpKFFdV54mOAeDk8ktkOmXxj8Dwxt/2GXHcBIl+GGD2Pb0z3ENQvQlz+MZOY7HjQm8/2rXSLxKqofq8jIJWpEkrnixaZOmguSMshG9r6/sT+fsq5LtHeaOAJvv/P/BHdVpfYlA7hgNvZrgN8tq+lr7ayIR0Z9tRmk4JU/M+C38GptOmycx07QI559/HB6Ql+BiqXHINnATX9HNxz1NvGIQstvhH8JaRc02Ic0kkv3xF5vNBfENZ4LbUd9aK+/p2vDhhq98siQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdekYiSFfvfh90iOsI7zy7QXfyXTXSw9F7sWq0a3nVk=;
 b=kwPf6utkVAvGVL55ObEvWJf7ChSJWh8G8X/kLbe2Op51uTeuU90R30F8adwRVJUimTA73TxEORBR0h5Cw0kcYhvdC9I/q5NsfWXoK5IJUqqASdASlOZLgYkolbpooqFs/ITQMC6QOqm008gFR383Si7GWu5RRwydmtZSHktSDWnE3gHuWq8o5BBnAyMtpwDTa2kyJePndf7s4biT5XaPtRFszBV51yWZivhN7cRsQfERL4EIjlXNduSC2KWb166HEv90xjdLtd7u/P2bjOEHCiZiN4FnlT7RnZP/d0nuu/AeKrqkdWbYjYa9H/H/YcTLOaDwjsT5xRYnnHQ8hGCCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 30 Oct
 2020 17:36:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 17:36:16 +0000
Date:   Fri, 30 Oct 2020 14:36:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: fix regression caused by recent
 patch
Message-ID: <20201030173615.GG2620339@nvidia.com>
References: <20201030171106.4191-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201030171106.4191-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0002.namprd10.prod.outlook.com (2603:10b6:208:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 17:36:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYYJz-00DTMm-60; Fri, 30 Oct 2020 14:36:15 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604079379; bh=ZdekYiSFfvfh90iOsI7zy7QXfyXTXSw9F7sWq0a3nVk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=o/82SJ/BHQJGy3nJAtZx4CLH2G05aqG6Kq7qlevZGMfKRdErTnCzN+3EeiP3M95Os
         ejsqBwQy4o9/GYN+1XssrrG0pBmV9scvIg1NuD+zF2p3KO9bZYb1arv9LMlggcPRrp
         G0zEVHwHAz0oQrw4zcjnFMrIzL1UepZ3HX3W2D7pc4Q8omuiZLFhtnt3754y/sP13B
         znoLFYv4iEvtYCDSqzvn6SjIZbM7to/0aNsYwXb1K2qKDWqfWb5BYk/Gydp40Xkc9c
         ldT+bbE+hsHxDufEPUDiA5H+fzNPDt/2dP0peckw5nu516HqCKLRNo0Ed79LhQt8+3
         En76XaLw/trYA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 12:11:07PM -0500, Bob Pearson wrote:
> The commit referenced below performs additional checking on
> devices used for DMA. Specifically it checks that
> 
> device->dma_mask != NULL
> 
> Rdma_rxe uses this device when pinning MR memory but did not
> set the value of dma_mask. In fact rdma_rxe does not perform
> any DMA operations so the value is never used but is checked.
> 
> This patch gives dma_mask a valid value extracted from the device
> backing the ndev used by rxe.
> 
> Without this patch rdma_rxe does not function.
> 
> N.B. This patch needs to be applied before the recent fix to add back
> IB_USER_VERBS_CMD_POST_SEND to uverbs_cmd_mask.
> 
> Dennis Dallesandro reported that Parav's similar patch did not apply
> cleanly to rxe. This one does to for-next head of tree as of yesterday.
> 
> Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7652d53af2c1..c857e83323ed 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1128,19 +1128,32 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  	int err;
>  	struct ib_device *dev = &rxe->ib_dev;
>  	struct crypto_shash *tfm;
> +	u64 dma_mask;
>  
>  	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
>  
>  	dev->node_type = RDMA_NODE_IB_CA;
>  	dev->phys_port_cnt = 1;
>  	dev->num_comp_vectors = num_possible_cpus();
> -	dev->dev.parent = rxe_dma_device(rxe);
>  	dev->local_dma_lkey = 0;
>  	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
>  			    rxe->ndev->dev_addr);
>  	dev->dev.dma_parms = &rxe->dma_parms;
>  	dma_set_max_seg_size(&dev->dev, UINT_MAX);
> -	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
> +
> +	/* rdma_rxe never does real DMA but does rely on
> +	 * pinning user memory in MRs to avoid page faults
> +	 * in responder and completer tasklets. This code
> +	 * supplies a valid dma_mask from the underlying
> +	 * network device. It is never used but is checked.
> +	 */
> +	dev->dev.parent = rxe_dma_device(rxe);

Oh! This is another bug, the parent of an ib_device should never be
set to a net_device!! This is probably why we get all those mysterious
syzkaller faults :| Just leave it NULL

> +	dma_mask = *(dev->dev.parent->dma_mask);
> +	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);

Why not use Parav's logic?

Jason
