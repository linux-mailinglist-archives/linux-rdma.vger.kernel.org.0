Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBA21B57D
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJMzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 08:55:02 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:24498
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbgGJMzB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 08:55:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIJcsai6v7B9AdjTiwsgjm/Ek2c9OJkfqkhF4nWPE1O82Hur7xdhRoRAUqd0h378zLi07A5CgqKpk1FsWOn4SDirFiJabxy8qf6a3eX3BbFaojdRfCUA54+nFsmAQlmgybuAkZMdGnqYfZrXLedB3hUNQDGmKu4zMPexY9SSwjWsOYk0xHPIpuF4F2utA2jSRGAygVptDKLkBxJZ8K9di0rTd9JnDyS0RkIbEcnixg2uSRpviRCgQJpiPQ7cgGoorMWTn7CCbixtiMXZJmq9fTmFxkVXnLNFz1SdXq+RQqDHdNjJlCIT3QVyNvuCZPaK0veUx1VXsfh9CNB7qmNh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ch8zA0yuTfSbvl+1lBIGR6rCDTXaFa+NX74MClc074=;
 b=RDNuo5GIC94HZMUbXLnPBqCibqssiDx7c08VBuuETraBwLcjTf/5q0xLVf3GABuS4jVTFWBo6aX5h9k0GeDDN/mghGiEyNr0KUEJ3uF1SIqDiQ8BRBLYVisLP2LTlRQN8n6TtLr8mz5/lXWjlHei3VDTEv4IhMiG2BAAcY8UyY5qFfQMgXoZhhvUa7BddgWWKW+2/ZvrpwyeFT4hoE7eqWeS0NkvrVvbpd5G7j9Iv4AqjLEvVu6WetIWxucMqDkXa1uOtLburzxF7ZgO5UIoi8VF9AzWrczLkU8LUEbq6kI6HDBT+yLd7VnRxe+JSY9CnLsfbjWHWxVRGZdq7Ob2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ch8zA0yuTfSbvl+1lBIGR6rCDTXaFa+NX74MClc074=;
 b=APHiDp0UgPBmf7wwG7m5YpnyMcZ56meTx1jaB4UnwQM4avdhuCYzPsU11oBx542ucWzy18ou4GDt2SPnJe6x+Br3Jf+LxGex4Sz87QGrgETEwW46L1cZt6YEWNrNN3AshLLnSvfkiKG2PR0eh0rHcOaPtZRGmdGW9yMq5n0JVrQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3229.eurprd05.prod.outlook.com (2603:10a6:802:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 12:54:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 12:54:56 +0000
Date:   Fri, 10 Jul 2020 09:54:53 -0300
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
Message-ID: <20200710125453.GC23821@mellanox.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch>
 <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com>
 <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0133.namprd02.prod.outlook.com (2603:10b6:208:35::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 12:54:56 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jtsYH-0087rq-HA; Fri, 10 Jul 2020 09:54:53 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6238e3c-1b9d-4d98-f86c-08d824d0725f
X-MS-TrafficTypeDiagnostic: VI1PR05MB3229:
X-Microsoft-Antispam-PRVS: <VI1PR05MB32293F12B27A0CA97A86C3C8CF650@VI1PR05MB3229.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 006ZVbwkYBD5Gp3eq7KDNFnNkLZWr56nPCUN0JWxTxRRCcS28614UpATD6v85cjrkg6aeKfSYUnAXfvHUdT9blGRuDQ/eFaE3SCqPS+8RG7N8Yt1TCoZYg1+Qz6zL2bS2cF263YtYxWV1gxOe8a6UxR+FhudkSjmczoB2ib7E3xoSFR95Rj/SVkjUokpR6GpXFn1xHUa4rV0Z5+neiW0GprFx8TwJDlf75rjXNp7jNKhMESd92XbP2OdLL+1OhWw9uKk6jmE/PMHs/mWyDR4/g/GX/XNQrtOT47ACACHll0bXKok3Bq1Rl9uMQbttQvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(316002)(2616005)(36756003)(66574015)(9746002)(9786002)(4326008)(86362001)(8936002)(8676002)(66556008)(2906002)(83380400001)(33656002)(66476007)(26005)(186003)(5660300002)(7416002)(426003)(54906003)(1076003)(66946007)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: x/VQeRd+7Cp0juXJJrqziJsMY/7/JYcPyIGcbF19z8FfXhEwQz3JnK9hfLetuPwARoo7VcnXvhF9Em1ckBci4Bne8+xpSSNtlUGwOhaUBMZj466AmLLbyw0kfgaple6lGhjcwbHt+cIRXYh475GaTyG17Iw1z0H729a0D+yflMJZUPLy+iVyJl9KQbBjRucLs2gK9kK6mLc9Oqd777LDIXqUyKAQ0ROBPXxs4TjErnQYRQZ4QoS0limmwj80JQnyrmDPxqJWo3y/ToRHwB4ldnRIBvK8Lxtcs6kKxyBXR2EjRnmd3+CcH9qR1Y+hm1ktOyS3dUeybhLKMqpgdV8hlAPcOhKJWAek6oo3nHOeHJcmMhfkpmyeGH1CCVx/9gWj0eS7TCeC/fwM50OQMKFJKoQ1kOrv2BnRWUcVPui3Ben3hKeWfTv++TDPCZkp3hUVlvp86DwYkpgr8w9gJnpx8Wn49XXtRuRT9Vv0Oy1ymqw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6238e3c-1b9d-4d98-f86c-08d824d0725f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 12:54:56.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK3J3M1s4NF/OY07BRyHQMYi1GoYqPubjJpYwdDJMlykRrCyVk+DwafBpSfZssYfpNMyMfRb7zk+fV0xvoz8cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3229
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 02:48:16PM +0200, Christian König wrote:
> Am 10.07.20 um 14:43 schrieb Jason Gunthorpe:
> > On Thu, Jul 09, 2020 at 10:09:11AM +0200, Daniel Vetter wrote:
> > > Hi Jason,
> > > 
> > > Below the paragraph I've added after our discussions around dma-fences
> > > outside of drivers/gpu. Good enough for an ack on this, or want something
> > > changed?
> > > 
> > > Thanks, Daniel
> > > 
> > > > + * Note that only GPU drivers have a reasonable excuse for both requiring
> > > > + * &mmu_interval_notifier and &shrinker callbacks at the same time as having to
> > > > + * track asynchronous compute work using &dma_fence. No driver outside of
> > > > + * drivers/gpu should ever call dma_fence_wait() in such contexts.
> > I was hoping we'd get to 'no driver outside GPU should even use
> > dma_fence()'
> 
> My last status was that V4L could come use dma_fences as well.

I'm sure lots of places *could* use it, but I think I understood that
it is a bad idea unless you have to fit into the DRM uAPI?

You are better to do something contained in the single driver where
locking can be analyzed.

> I'm not 100% sure, but wouldn't MMU notifier + dma_fence be a valid use case
> for things like custom FPGA interfaces as well?

I don't think we should expand the list of drivers that use this
technique. 

Drivers that can't suspend should pin memory, not use blocked
notifiers to created pinned memory.

Jason
