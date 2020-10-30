Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F132A0CC5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJ3Rri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 13:47:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1300 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3Rrh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 13:47:37 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c51be0006>; Fri, 30 Oct 2020 10:47:42 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 17:47:37 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 17:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq5mG255eUhM2mul8jzl1gCVW7+XURsaszp7ieEMbN9Vnb38gW4ZD82B/jy1mfLUWTe7rGdZJbTS3OaXwiCZVZu7F4XXmj+v/LM9FWAqg7Tn9XjQ8/q3b5Jo/cyuQLmzkP9t2Rf6OAlhzjJRGhp5wA8C11ruX3fmQUKD3ZpPjswmBLGdr7CHRanQqJerb5r6oBXQpMrMt3/VIp/0dVqbyAAjbMssB+BZv8Xtp8r0j1UbNXIeFY6scS0QBzu7PR6KaVVJtUNvZC7mkTE+WW5IZXhS2noh8Otfz9LRSoyWh/hnmPGFOqOVOeD05DmAf/+LxTlMZ0htCCCa4ysYTUQoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXtfuHIdlmjnjdG0TwFUUIjXOSwlXnrW4C5lSCtqiqE=;
 b=EAX7FZZi+RP4LDTyMcMLJ3AFXETIVeOPscCacAVfBPyBznJZVPp0GfDPX7GfRYenjJ+Fm/Iv1fLLK15cr5Fz7X3rYUhracQsN5zu66R78i+s8WaxUDboXgSskBeoOisYY1TKMTRAmrnlprTw5sTXLD1yed6bVxOpGCOeJhKKHuUW/6S8sqvbqcMSEAA593BQrBVd5718wWP8PZ6m+Fu030+lz7FXBcvSi2ErcXhXaoJ5ZAfOUVJUloJQJZrboifPmQbVqpU+lSkX9Md1iV0IkURTRlZixLxGbYNmD9uo/MopJgAevkqCbP/Dc12pvmAAU1IBgteXnnTlsjOtlUbtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 17:47:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 17:47:36 +0000
Date:   Fri, 30 Oct 2020 14:47:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: fix regression caused by recent
 patch
Message-ID: <20201030174734.GH2620339@nvidia.com>
References: <20201030171106.4191-1-rpearson@hpe.com>
 <20201030173615.GG2620339@nvidia.com>
 <73f63f73-d422-db8c-db9f-7780b1f3c3b1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73f63f73-d422-db8c-db9f-7780b1f3c3b1@gmail.com>
X-ClientProxiedBy: MN2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:208:a8::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 17:47:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYYUw-00DYjO-Og; Fri, 30 Oct 2020 14:47:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604080062; bh=PXtfuHIdlmjnjdG0TwFUUIjXOSwlXnrW4C5lSCtqiqE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ovRMBimyKsk6B9ww62tb1EyNLIRROOnEpWiQnR9X3MzVn2x+MmzA10j1RzNeQlhYd
         wg8Zy+6KYpCx+xlEoF/hgsxVPrhsMoFgMsw4exA1Vs9t4JaS4ajGFdiQ75syqazZLV
         rULg4UcXQNY5j1D+p9oALNNWl7NfpuqTbNFxiH6vubUvvlrqIADHVpQcrE4kliJiO+
         YfgaBhixTZdgGlfaeEOPLkxaM1EBICJw/0MSGCbIUsccUwl0YQdhTZknJAlEGBEsYL
         qoGuNUZL94ntejrO9JBRhFeu4l1bELbU7RcsKrkbJLUB/ypGzgnCvwQ3Dv05HZi3Mo
         pkYvRc10RX/6g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 12:45:54PM -0500, Bob Pearson wrote:
> >> +
> >> +	/* rdma_rxe never does real DMA but does rely on
> >> +	 * pinning user memory in MRs to avoid page faults
> >> +	 * in responder and completer tasklets. This code
> >> +	 * supplies a valid dma_mask from the underlying
> >> +	 * network device. It is never used but is checked.
> >> +	 */
> >> +	dev->dev.parent = rxe_dma_device(rxe);
> > 
> > Oh! This is another bug, the parent of an ib_device should never be
> > set to a net_device!! This is probably why we get all those mysterious
> > syzkaller faults :| Just leave it NULL
> > 
> >> +	dma_mask = *(dev->dev.parent->dma_mask);
> >> +	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
> > 
> > Why not use Parav's logic?
> > 
> > Jason
> 
> It's not the network device. It is the parent of the network device.
> On 64 bit machines it gives 0xffffffffffffffff as dma_mask.

No, it is some weird thing because network devices don't always have
physical device parents.

There is no relation between the netdevice RXE is running on and the
DMA mask to use for the dummy dma ops, AFAICT

> that should work on any architecture. If there is no reason to set
> dev.parent I can get rid of rxe_dma_device.

Please, that arrangement is causing bugs.

Jason
