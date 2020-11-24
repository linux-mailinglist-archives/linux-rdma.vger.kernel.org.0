Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D72C26AB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 14:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbgKXM62 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 07:58:28 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17722 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387752AbgKXM62 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 07:58:28 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbd03730000>; Tue, 24 Nov 2020 20:58:27 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 12:58:26 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 24 Nov 2020 12:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgGNqV5sELR6CfL2pTRhXI01026A4w9Ki0nLWmXeLYGOS+wLC7K29GKLUkVZFPYKLQNEGwuZIxaRC1oibArVK5FxgudtS4MHKjRkdHFk0D03ZVMdamvmMrWgenNIS9Q9it5k5yv4gCwYf9XWJgAPZOjBwtHuHM6B5aEwk1nRMVUrVt2pFfwAmZ4H0eaSOCxsoArfIuCS6/+upgtN3jnaCqwp8pwCvN2bv32HoSEQQvqAacGuTp6NPEAy7yIxAD4BsNXYI6R63of2V1T+fTetyGHbjHJ7sxQidsgKGjJjXjDhFQnSS1eRtkcHdOerAOqFrj5urKbPCmONPwRE6VCg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeWPscVr8LMmvlT5GuDD2T7j3+wG9XhGa77WtojiPp0=;
 b=aLMQ+2pVLCDmGGj1LuXj3jktW+UYUnFoFJanTPsfHXRmqXhYCcdQBVZ0Xev7CSkrdEhx1Vk2OG9XQaMKHyVWHIFUD+7VeQtaW48WX/Btc7LWElbVx9ugN829X8+Bl56tuR1SbEst4Bdm6bhad6iR6Zk99/OQL+L7ch2fq4LggBXUPwLFUgdc3Qh/nmUvEPMuj5WUqIdfB2nNCdrkK9ozSz+BX81KA3vPmvdiFYR/HQ/AmEGjJC6YUK/Qx4LnVGDm24n48hhvmPjkikh+FWvxIRUpr2JwOgvZSYWxorHFnGkf1fXJ8SBVH5nQ6WkqC+ho5lQwXEl8nBJprt3fHOj2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 12:58:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 12:58:24 +0000
Date:   Tue, 24 Nov 2020 08:58:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Parav Pandit <parav@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Message-ID: <20201124125822.GA4800@nvidia.com>
References: <20201123082400.351371-1-leon@kernel.org>
 <20201123135931.GM917484@nvidia.com>
 <BY5PR12MB43226D6014DAABFD08BFBEABDCFB0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201124052032.GE3159@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201124052032.GE3159@unreal>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 12:58:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khXtm-000jlS-TK; Tue, 24 Nov 2020 08:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606222707; bh=GeWPscVr8LMmvlT5GuDD2T7j3+wG9XhGa77WtojiPp0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Pp/o8HZaj/IDu0KZHKNSH0Dl45/ugQCIiFPBdAdq/AvpFFsq0ESbRADSJuTC9oDiS
         8j+5gf2WJfkZe6eYLA9UpSLEEVk7CsF+yWC9so7DRJjecLgw6QDeri+v4/uS/Kmz5j
         3wihNGZMg7Cz0aOCZfm9O+ws25F1lyyQqRHVpMtMeUlzd2XXsXSxrbXytXDe7pjlI+
         qS68OdoLQMglueINImmPnCPRVOoVOqS+hpyv7gRjBxc5qfdva2dooWEy28qojIP3d6
         48s+eFZWrAPtfU32hxsicyWkHYjIxC/O4k1jh0V0MB9Kam+PpRWixUe/Nhe2Bk7eWN
         BeKCTeN1Y4B3g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 07:20:32AM +0200, Leon Romanovsky wrote:
> On Tue, Nov 24, 2020 at 03:34:56AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, November 23, 2020 7:30 PM
> > >
> > > On Mon, Nov 23, 2020 at 10:24:00AM +0200, Leon Romanovsky wrote:
> > > > From: Parav Pandit <parav@nvidia.com>
> > > >
> > > > DMA operation of the IB device is done using ib_device->dma_device.
> > > > This is well abstracted using ib_dma APIs.
> > > >
> > > > Hence, instead of doing open access to parent device, use IB core
> > > > provided dma mapping APIs.
> > >
> > > Why?
> > >
> > > The ib DMA APIs are for people using verbs, they are only needed to pack things
> > > into the ib_sge
> > >
> > > If you are inside a driver, not using the verbs API, or not using ib_sge, then you
> > > should not be using the ib_dma API
> > >
> > Thanks for clarifying this. Using ib_dma apis make the code clear for dma device access clear and explicit.
> >
> > > It is an abberation, we should minimize its use.
> > Alright. In that case will use the pci_dev as mlx5 driver internally has the knowledge of it and avoid using ib_dma APIs.
> 
> Yeah, let's do v2, although I don't understand the purpose of ib_dma
> helpers if ib drivers can't use it.

They are for ULPs, not drivers. Drivers are supposed to know how they
are doing dma mapping already

Jason
