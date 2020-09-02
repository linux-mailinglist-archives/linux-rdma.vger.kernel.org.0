Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44A25B1C4
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBQeS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 12:34:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:27381 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIBQeQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 12:34:16 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fc9850000>; Thu, 03 Sep 2020 00:34:13 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 09:34:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 02 Sep 2020 09:34:13 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 16:34:11 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 16:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iut73DjzhN14W30XzJ+6J2+SOdZTiQIr+GisKW3fRnNI2bmnSjZplSsCLo6R2KEeVgcrHsGByowYdTr9MT/kh3pW6k2doXCpKPnYSkz1z7Z/2eJzHDwTFc9+RpygAcYuRSWl5LmGU1+j5bf5cTPyOrH0/z0z3/P4KU8VtrGKHiGkUv9cICUT9Wn5g4545M9/oglheu+6EQaGVxMq8zkyIz0xpYX1VTqazdQLGC94221QZ52t6BPnpEBdj8W0D/pylKdTT4E3LSsrBrwG2DYIbQhhCVbVArVrNq4yCZ+Q2zSZS7TkGT0FwjRFlQB5IfwkGd8UUUpqA/qD86fJC/fLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rst51mxlxaSZsr7KXCLMpOR4XQt0IThPmV5TwI8lvFY=;
 b=NN56++pBhSm74MnXq8NBwaN/b9VhtoG+AtR4OTVqFXI8XbDh/5XoUtf/uAbPNKI0W7FZxJzYy8hWuHUZt7xBQUWhZMkYyPS7NHI002H/43CrbrDtmOCxRj1vm1p/UKCU+9ALQgbBiI2Y3DM76MFfwlNkAiSnHGw661a8qR1iuKXB90M3R+sFDwjKIDGMZ2nlt8Ny36UDwUPKdDtzoIvlEV+bpgTtjOs83GM7/YfUPQ6yoK+o0hzAA6NkouX2hThMIougr8ClDaAIf9G5AWLS6KQt0ZoioOGd4CMAonB9bP0cIjPF0yGRnq2YloxDkG5HVSGXQ5JO9nXuENcq+o79sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 16:34:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 16:34:08 +0000
Date:   Wed, 2 Sep 2020 13:34:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>
Subject: Re: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned
 by ib_umem_find_best_pgsz()
Message-ID: <20200902163407.GU1152540@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <20200902115119.GH59010@unreal> <20200902115912.GQ1152540@nvidia.com>
 <20200902120540.GI59010@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902120540.GI59010@unreal>
X-ClientProxiedBy: BL0PR02CA0115.namprd02.prod.outlook.com
 (2603:10b6:208:35::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0115.namprd02.prod.outlook.com (2603:10b6:208:35::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 16:34:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDVi3-005heF-13; Wed, 02 Sep 2020 13:34:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9726ad2a-1a0e-486f-aeb7-08d84f5e03c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042DEE854D6AA0384D5D1AAC22F0@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+1KPoiu90bLjNYaCG37RgSpzmbd4M1o1+Sje0o/QpmTVyvNY9/jDMnodEG8qnl7Tmht5+wjveY2xOWM5ClCUuvGoflQH5wh0VQNnVs7YUcKeUfQOm6wTPqj47vRJD7FbISrhvoOo1VvnxNc7nKqNPcz934kVJ3rCImD9LV7ycWOLnna/ZYJ+lUChZV7wo2k45nehysSLWSuEMMtDjkc1a9+TiJiWxYzXaEKA4k+5fwTSnw1mV5yqDgYHcGOXmZ27rb3WQHmkkgy5pkm/5nAj2RzSs/YRceRTK1o5wtBGNctfS9E547RFPF5kRQsbPaKHScFOW5ziij+2di2gIsBKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(2906002)(66476007)(8676002)(36756003)(5660300002)(4326008)(9746002)(316002)(9786002)(6916009)(186003)(54906003)(66946007)(86362001)(83380400001)(2616005)(8936002)(66556008)(26005)(478600001)(33656002)(1076003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: H7gL+ilreBC7eeLgN9sosc4M/JoJowXa1PUxz7VJjfVhZeyEp9Yp4aCaBdAhAlJKwxyiDPsdZk9hEwteUeMlWqqviBcyZqd64f0HdgXqrFOfpEWxAxJ94oonImdaMF9/9MtPxjXj70IdYZH2nbka9SGDDgyqtVz5t6wvGeyTp4eLFyfFjAPd+8DUOI/Ao8L43H0on2ADGHgohnnisghTp/XWQxksoiedBZ3g8TkDWUj0/Rv5D1+HsQ8U9bNNd02pUjpeDfcqQ+7F9QkwHNJr7p6JyZWOWzDZX6joKUdMlm90k7En3AyPfaoJLDp3U9dJt5lykic07LW0vgV+JuQ89LHtrWY0IhbfcEY/49ZsAXVoxVa4vz98ryozArg2XrD6pt3N/SUA4F9PxiEtX8waOpqe3+lg534ar4JI340f+hV4kyTirp7/5wfpXUhSPF+QxKrIJkCyTEOrTYK9veWP8n1ND0SbDPZDFJNue5rix2wZ9mfSAQUNtzeK8VsXBCQfVOIYhfKRF/IrfUdFpW8BH2BcE10/zJowmx6UQey0yDFu6CHgVnBPlT2bXJXQn9l5ar58Da8uk4jH7b1/LVAeHpKEP1wyVjjgZ5HgDLlw1oNX6RBDgydZ2I2misPA7+24ueGGy612ZLeIE7W0bdCnOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9726ad2a-1a0e-486f-aeb7-08d84f5e03c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 16:34:08.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH+rXgS5DmcMUwkQqjw1LgonqHNa5K//CviSqtLsCDy4ob3YxwzcAugM9B54Skgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599064453; bh=Rst51mxlxaSZsr7KXCLMpOR4XQt0IThPmV5TwI8lvFY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=LoJMi8RU1Fg6r/Xn+7ajP7kjBdYfxZTOQidRYQbJ95phFOew9+2tkeC9oXJoekx5P
         3V7fRNDOLcLk/y+uaCrRgmgHTm8RaMARnsq3MHbTHX+LQV6gmTTE8qdgN+L7kYO+L1
         qMdZ+8PhmNfcXGu47qan6sP91vVaKg2xI9OktRu3jVWWF+OZe2pn8tRr1ssEPxUQkJ
         z7eTON7pYRMjOH6uO1/CiF6ugZTqJpUF7jWJ+05PLAy94O/NM0ETw//LdEzARCuBGj
         kxtejnNkPeAvkFhQ+sYKfcPe52bgSb85uISfW2dIuPZEQF7rBc9Zk4JHvFA6DjDby2
         TabgfraJ3/L+w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 03:05:40PM +0300, Leon Romanovsky wrote:
> On Wed, Sep 02, 2020 at 08:59:12AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 02, 2020 at 02:51:19PM +0300, Leon Romanovsky wrote:
> > > On Tue, Sep 01, 2020 at 09:43:30PM -0300, Jason Gunthorpe wrote:
> > > > rdma_for_each_block() makes assumptions about how the SGL is constructed
> > > > that don't work if the block size is below the page size used to to build
> > > > the SGL.
> > > >
> > > > The rules for umem SGL construction require that the SG's all be PAGE_SIZE
> > > > aligned and we don't encode the actual byte offset of the VA range inside
> > > > the SGL using offset and length. So rdma_for_each_block() has no idea
> > > > where the actual starting/ending point is to compute the first/last block
> > > > boundary if the starting address should be within a SGL.
> > > >
> > > > Fixing the SGL construction turns out to be really hard, and will be the
> > > > subject of other patches. For now block smaller pages.
> > > >
> > > > Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > >  drivers/infiniband/core/umem.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > > > index 120e98403c345d..7b5bc969e55630 100644
> > > > +++ b/drivers/infiniband/core/umem.c
> > > > @@ -151,6 +151,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
> > > >  	dma_addr_t mask;
> > > >  	int i;
> > > >
> > > > +	/* rdma_for_each_block() has a bug if the page size is smaller than the
> > > > +	 * page size used to build the umem. For now prevent smaller page sizes
> > > > +	 * from being returned.
> > > > +	 */
> > > > +	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
> > > > +
> > >
> > > Why do we care about such case? Why can't we leave this check forever?
> >
> > If HW supports only, say 4k page size, and runs on a 64k page size
> > architecture it should be able to fragment into the native HW page
> > size.
> >
> > The whole point of these APIs is to decouple the system and HW page
> > sizes.
> 
> Right now you are preventing such combinations, but is this real concern
> for existing drivers?

No, I didn't prevent anything, I've left those drivers just hardwired
to use PAGE_SHIFT/PAGE_SIZE.

Maybe they are broken and malfunction on 64k page size systems, maybe
the HW supports other pages sizes and they should call
ib_umem_find_best_pgsz(), I don't really know.

The fix is fairly trivial, but it can't be done until the drivers stop
touching umem->sgl - as it requires changing how the sgl is
constructed to match standard kernel expectations, which also breaks
all the drivers.

Jason
