Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3F21B707
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJNsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 09:48:37 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:58880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbgGJNsh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 09:48:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRAmcn4fAugr8rFQFozG4YPCi2+sk8bEd3+Q3DLdmqgLPSI2LjiDpT5j4E0u5sM0h2r5t1FRMd/E1eRlA0hjjc0Z+AdIpUvx9jg3UiCcB6y+ynuiVdSdHBc9gpG3U46h2DmysyqR1bqwnBWJPP3A5HHnqSSovWAdYw2je09FkmD26IuKVRXLdXCtFB2k8BNWZLnquXmFAak5AxMbr/FqI/SaNdu37mFGOhOCBlzmbc8VI7oCoNt0iOHIpiW50WJsKrPr9xwSiXdTq6cOfeh9oOxWCGNq4lT1bOoXsICzZo+FBMPsPXoiv4iLxraiYppQBUqsaF2uk9idDLsYKwzrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em9GCfPc3Bhl6JX25VZ+Xquk7PsFs1BYXjOVmaCss3E=;
 b=f3MYU/LuVCIP3RgFhOoPo5CWKDhDx/ln5AjYzuby7yz9mXQ6D54bTpEHrboflAkB3NGvigNDRLNFx2eILH5PgGugyiXs4msAXAd3t6i5250Wvp15FcSPgkDVmuNF512UPtH4D/cB7399xN7M/pnZUPzLdga6jxtapBT/c47Tz+I0Na+SXmnLtS3Mz+BtZ4oPA0zkWo2i/tO05Nj1Zbia0mgPd23nFjDRsGodgzJTC+NGdG0+UCYqS7dO+dx+qZO28hnpW9GQWesZzqHPZGMX+KkzqXripsYEkmBYY1zZuleIB3N7G9udRyImCcXhQB2F5UD1tAtne71n2bmH9DM8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em9GCfPc3Bhl6JX25VZ+Xquk7PsFs1BYXjOVmaCss3E=;
 b=s+k5G4GJ2ik0VcgrCETSHsZsYksTNfhGgtfRBIx/m9tpprGynyLJa//4SaOkSvO7/5IC7X8HJ6EEF9BJEQvgULB2xNqiYiDwPbnunmcEwCD0LMeD3v7b9kWZTVEP2SeeXPMza8weQuxXbRCGeautX0hLKN85a/WIwJmqKEgDGgU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3341.eurprd05.prod.outlook.com (2603:10a6:802:1c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 10 Jul
 2020 13:48:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 13:48:31 +0000
Date:   Fri, 10 Jul 2020 10:48:26 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        kernel test robot <lkp@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 02/25] dma-fence: prime lockdep annotations
Message-ID: <20200710134826.GD23821@mellanox.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch>
 <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com>
 <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
 <20200710125453.GC23821@mellanox.com>
 <4f4a2cf7-f505-8494-1461-bd467870481e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f4a2cf7-f505-8494-1461-bd467870481e@amd.com>
X-ClientProxiedBy: MN2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:208:a8::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:208:a8::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 13:48:30 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jttO6-0088nX-PV; Fri, 10 Jul 2020 10:48:26 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1079218b-4c9e-4621-75d7-08d824d7ee4e
X-MS-TrafficTypeDiagnostic: VI1PR05MB3341:
X-Microsoft-Antispam-PRVS: <VI1PR05MB334116D18115F3E3CEC3F202CF650@VI1PR05MB3341.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFcgn1ydcEHhSz0+CCy2fjDkK2bLF6z96HDaXcAemHtsFZaRD1P6Bkl6Lf4sQDJ179Dj5+yiBvx8W03b6zomX4c+0Aas850u+VEb2JyqcfQLuHUcM9j7fkoxPhcxJnUC5+qiK5T/QFiPsFr7W0EZP5dHQWBr92bBhVjVMcwwAxt9azTFIf/9/viPoEdulANqJTCYx6IvfyIABN6Nf8BSCCPF/WbndfXoQvhj7FerTXgSlrGbPOohMqgoIZuLynxs1v9euWtw+NKEGbp6xz0SMJeCQ6xOJL1/DaFalHI5+gwJlyNkIOyVCXkJzjcEtlx6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(9786002)(8676002)(2616005)(2906002)(26005)(4326008)(66574015)(426003)(8936002)(478600001)(186003)(33656002)(66476007)(66556008)(5660300002)(54906003)(9746002)(66946007)(6916009)(316002)(1076003)(7416002)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mCS9wS9QeKkaqEbOX6nWRQVjGpk009DZ+9L4MMYCuwizDkRfwcVGl2Ifz/M/2qJBamVMTYjQdiX9BDntxbzIBzZo9pIe3Z7k0ed2b4XN7k79+eoblcipgLb0B23mOpoAXYzxV0r+OgIA4HeLkJCQIRIO4FbIvOZUt310fUHt6ORCb17kIge3hgp2U5G54kHt8FqwmTtq7RpQ366QEtaaAlwaRHwmfC7YF1yJmJ9H4WS05GYHXIf98c9K0D2iFv6bYWSL+Y+DBhUQrEoZCcpU3EGf7qelTzYqGCCPEYcZGtjZaBKc8BRJNmaZN6oJH7WG7v+sjfq7/VikEARYWuzBoHylswNBgoe1g77BHg2Pb+uFQuUxSrDA9+DwnD45K6SpvI3t8C1W5bgL/bTWAqklQ0IUhQUjmDiB/OdeGDTvc1Jvxt+EYGzdRJFw/WX9pZ1EPZfJ/ehQ7nnWPGHH0eEaC1cS0xCdbcKacIznULoPwaE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1079218b-4c9e-4621-75d7-08d824d7ee4e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:48:30.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN1oo7fZeG14NNr4HLKjPR1Q1Vi2ci48IOOg+CuIA2svEhrRbTLSAvTFlJSuNBkb9dnKcGyrpYAHuwbZnVD/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3341
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 03:01:10PM +0200, Christian König wrote:
> Am 10.07.20 um 14:54 schrieb Jason Gunthorpe:
> > On Fri, Jul 10, 2020 at 02:48:16PM +0200, Christian König wrote:
> > > Am 10.07.20 um 14:43 schrieb Jason Gunthorpe:
> > > > On Thu, Jul 09, 2020 at 10:09:11AM +0200, Daniel Vetter wrote:
> > > > > Hi Jason,
> > > > > 
> > > > > Below the paragraph I've added after our discussions around dma-fences
> > > > > outside of drivers/gpu. Good enough for an ack on this, or want something
> > > > > changed?
> > > > > 
> > > > > Thanks, Daniel
> > > > > 
> > > > > > + * Note that only GPU drivers have a reasonable excuse for both requiring
> > > > > > + * &mmu_interval_notifier and &shrinker callbacks at the same time as having to
> > > > > > + * track asynchronous compute work using &dma_fence. No driver outside of
> > > > > > + * drivers/gpu should ever call dma_fence_wait() in such contexts.
> > > > I was hoping we'd get to 'no driver outside GPU should even use
> > > > dma_fence()'
> > > My last status was that V4L could come use dma_fences as well.
> > I'm sure lots of places *could* use it, but I think I understood that
> > it is a bad idea unless you have to fit into the DRM uAPI?
> 
> It would be a bit questionable if you use the container objects we came up
> with in the DRM subsystem outside of it.
> 
> But using the dma_fence itself makes sense for everything which could do
> async DMA in general.

dma_fence only possibly makes some sense if you intend to expose the
completion outside a single driver. 

The prefered kernel design pattern for this is to connect things with
a function callback.

So the actual use case of dma_fence is quite narrow and tightly linked
to DRM.

I don't think we should spread this beyond DRM, I can't see a reason.

> > You are better to do something contained in the single driver where
> > locking can be analyzed.
> > 
> > > I'm not 100% sure, but wouldn't MMU notifier + dma_fence be a valid use case
> > > for things like custom FPGA interfaces as well?
> > I don't think we should expand the list of drivers that use this
> > technique.
> > Drivers that can't suspend should pin memory, not use blocked
> > notifiers to created pinned memory.
> 
> Agreed totally, it's a complete pain to maintain even for the GPU drivers.
> 
> Unfortunately that doesn't change users from requesting it. So I'm pretty
> sure we are going to see more of this.

Kernel maintainers need to say no.

The proper way to do DMA on no-faulting hardware is page pinning.

Trying to improve performance of limited HW by using sketchy
techniques at the cost of general system stability should be a NAK.

Jason
