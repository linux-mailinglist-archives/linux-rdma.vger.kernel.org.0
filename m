Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9683B199A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFWMM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 08:12:26 -0400
Received: from mail-bn1nam07on2059.outbound.protection.outlook.com ([40.107.212.59]:4925
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230157AbhFWMMZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 08:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8WwBtpHysfIibCvOrHaPO5cfj+wgs96xonhw4b5yxnuyHZtD/TT0awVxF2nxPQTqzTPFpcJNbLUlKY1h3J5N5ghOJXxd7xbbBRgO0XmcF7XB+99K4hp2D5z+yTZfO5cqIZU1lQymxyqFk+a13/fC8gks/RAS1kNrtmSDJPT9upu4lpre4FjKbIef5H4e5+6SH/VNVIIDFsvFreO9hSdOZznYiCtl5SoAdJ/KoAr3sYXjHVgEovjsYXDrV42d2D3xc93nzMPPsHDG4A39BjDGfW7cYJhU1zl0B70tgpKYo3tYFFsG/c+1d7jAc7f6uimIxpveUBOMQ8euOrmtBF7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJRmMZsx4BKUFvsNrjYy2Lt0fCQ2/JQJSqIDEjfJERw=;
 b=Lbr1RWxM4sFGdNzhY+p865rQDPQHvE8eDEC2vcYIawkGIM88/hh7+vflpcWM3yo2RHFTf4OhZhsUeTwpX2oPV/+YI3klgQ+8W3Uie6623daJMyMgW84m3mpNKzvor8YPjtAU9PXr7bRzPpR5GlUqp0RMXaqtxRWRol5ObBgFpg6bJ9M0bbaw1v6TI88xv4hblXZYC5wxEKtco1wV3ewD7AgX4rdasPqlLmyEtcNalw8s6Ap7trcWskTSTJnYpR/pMZZsSqAH8IpPJN5aaAn+wJDJWpPk4K74PGzim4+JtfEpuL6wAsM+OaSOVVsCGtBAyr/SsOIJNaaaN61Np1g2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJRmMZsx4BKUFvsNrjYy2Lt0fCQ2/JQJSqIDEjfJERw=;
 b=bFrA7STJV0Vve3tmWFOZ0e3sORpSgXoXT5i0vqCBpt9H/+B2qxurzpBcilRj2+y5tmuY/x4HRXjPoZQ0zuA1LiVz+Y+flq2owIx0/cygF9N6cft3p2we+sbD//dMKWLF/sVm6r3zVdtusi/Ne1Mqfvcvkqjg5ZIdvZ8uInxKNeq9AcYXkxCghssdb12LEvVNHq9GfvGj1RDXKCLGLfU9YoJPsQWS42bLeOk8gyDIxTu+HDGRejOnC5TXZHEusCST9HVaKl2MpvHV3hzpPSNZI8sY5DV0tigXkyvLiQeHPH460/UWTRNxWHtzzeK3Q7+wx/nKX+sA0kX44Vfx8qQkwA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 12:10:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 12:10:07 +0000
Date:   Wed, 23 Jun 2021 09:10:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA: Use dma_map_sgtable for map umem
 pages
Message-ID: <20210623121005.GK2371267@nvidia.com>
References: <cover.1624361199.git.leonro@nvidia.com>
 <29b80ff0c32675351c0a1b2f34e0181f463beb3d.1624361199.git.leonro@nvidia.com>
 <20210622131816.GA2371267@nvidia.com>
 <YNLFRa75KQ+BO4rB@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLFRa75KQ+BO4rB@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:208:236::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:208:236::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Wed, 23 Jun 2021 12:10:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lw1hl-00BTe8-Rt; Wed, 23 Jun 2021 09:10:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 283253d5-3cef-48f2-4cd2-08d9363fd6f3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB502972FF35062037AF811645C2089@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imTTm/032uWVsOwJgRu3eLvJ578qaVdfO7Z0in9z5M6vSSwFE8DIeuB8pdxUh+1vsoo6FG7olOF83TGXVdFwDaWW5FzzSoELhyqESMTsSrkJV69fEtD5VetzgUDsC0bMRgTVpVBHUvSu9LizOt68Z4RGhMcqiaWFgvh8Hm87SlH6WbcxU3qmoasZvJZGS+5twh0tHYWVAQFpmRAB2+ctRB3DZAMSXVRKE0jwmJzW3dPz56l3ppA9zrtVfkPfNzO1/+LWr7tV0I029HNpTZCKS9YVdrM4VtyqZXm4hd4bYKd9KiFIlEqtnTQQ8rbn79hfTdkqSIff3wCVny4zm0WcB80smpsAXs+ANLD5JGt36qazMxiNUfpjK2LpEHvvQ2E4RsjWvdsHQPpHAUP/GyB+oikSv2V1cVJ6FcdxDqXAMTZTqgkn823GbcGwoh5Qu/ErL0on6JAK25/S6ejQcCFkSlvO4CB+DCWqg6+8nAcOSeEokaiur7KvoEeCR2DzyXtJMEhEEtOGFk2QkDvBo04SCDhc5QGshGxGP3Yxs1wmv7eZEuT4Q/UpF/EGSEibhAd3oXOKzK4rlPzmqZZzxuOnFNuajhi5WcNd7Mht/NxRiUVIzHJjjFB4F2l//xpvY4aJpLMKxyOElvJi5Z81U4G6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(366004)(316002)(66556008)(1076003)(66476007)(83380400001)(478600001)(8676002)(9786002)(33656002)(9746002)(426003)(8936002)(66946007)(5660300002)(2616005)(26005)(36756003)(186003)(86362001)(38100700002)(6916009)(2906002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhxV7sDy+cbfu6nzFNhIz9IOgaTEkoZhLo8+D1ER0xFRPDQkbTtVpQAZcbhH?=
 =?us-ascii?Q?q7y8VsPGeO7e9UlKCxh4boPgUmLszefaIBvad93JWw/yhfCUp0cJeXg88vn/?=
 =?us-ascii?Q?qpxK4xuAsjc6miCgVJf0N4gMRd97QH1VUFq/yuwoLjTJ60ZhiRjESdgUopNN?=
 =?us-ascii?Q?Caxw4xatSXp+2sHapcchay7PH7KWFWxeOmklFYL6xcAJOK7Kdj4qmOsictjQ?=
 =?us-ascii?Q?Re4jfoHFA4BPt81jSegfhOmMvgbPYfwlURJr8GwXvJPGXEw2JjnKysp9xLWA?=
 =?us-ascii?Q?sb19E/x7+FBjrVtymHIG/TD35rvDbTj9YU5oAg2Hc0hmz9omItPdYRbnUkm0?=
 =?us-ascii?Q?KX0lV5QoC5ltpeqvRGvEgBZ3mB50JgZmoIiQ9kgt1WFfW2r3piQ2XrB88eCn?=
 =?us-ascii?Q?gw32HP8IriMtHqFKEdAz/t3RuN4GfFwzjXu/ELUO9XkW1fIB0VEdrYERd4yq?=
 =?us-ascii?Q?LdGpc5CTbg/S3av9DUIezHm3743N/Lf8Jv3erm4YYnwZ+cGfwKHmfJg0jLy4?=
 =?us-ascii?Q?B41k6NzhO03V3jSSkaHi8mSyCGCoMqGmar2uaO7raPvVi7Ophus2ltIkmVzz?=
 =?us-ascii?Q?m1DwS2RJ2rg0uKtDAcnUIIbRZJUFqp3Hio2Tfye7mMyeFtcV3pRCmr3tadVG?=
 =?us-ascii?Q?vYiH/WFgv/pehPMl1xawl+QZqPUPL1Va+jWjgP5wqINzrLaBKZHUNHWUkX5C?=
 =?us-ascii?Q?Sl4lpAeXUqzIQ4Je6TlEukQBMqsg9qSucT6Z5GXbb364LsTb/9BPXg8fofhS?=
 =?us-ascii?Q?1xjzdo+OIms0+SnFLQnKcItY+lFODPXOHscYbXI8AVNlMnveYSeDilBiNj1d?=
 =?us-ascii?Q?aM+HGYH1mjpVsVeZsy/V5g+ykh471MgozUBdZSUwNnppF3s8PEjLcMWtob4y?=
 =?us-ascii?Q?RFP6QzyUqIS4/D+e0S1ZAL6HtLZ7QarvDgMWoS+6b8JHePQtcefg1q75lDVk?=
 =?us-ascii?Q?MkCUTf/2AcEaIu73uDKpUyVdIty9FTlryGy9K1MazSIwO8inKo342upnYFy9?=
 =?us-ascii?Q?Kb6VOiCAkGP+c7xbRts0vS5cTRPBjbYgh6hUCeG79WWUKEz1G/5KI/xrp2HJ?=
 =?us-ascii?Q?2ToEdkNzLfRaKFvBTkA1kOGQ9tagsnPzhdUV8LyU1Q1a1uWAaAckYRvrKBz7?=
 =?us-ascii?Q?oDlFGI5Z81wqPw3nbOoqwPE/kn6kvJLYi0BIiH8we/vyDKKtMf8/v7wyax3l?=
 =?us-ascii?Q?xuleQQDxfHW/PdGow5FjtaJH2UtJ8yo8fQOpUZdo8PUHLrCBQrb/Z591GMEX?=
 =?us-ascii?Q?Y9tfI/UEbkBRDUkm8lFM9PVsfr5jZDbPY+YE0hpUDgb19jOb/I5nH1sSw9MU?=
 =?us-ascii?Q?+NOZfqTSvfTkoVPdu7tON3RU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283253d5-3cef-48f2-4cd2-08d9363fd6f3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 12:10:06.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUZTEqfLB5ZaK3MBZQACkY71pIVdxDk6JATsUQPICxMy6jXhbkyvjwWApHVIo4CG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 08:23:17AM +0300, Leon Romanovsky wrote:
> On Tue, Jun 22, 2021 at 10:18:16AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 22, 2021 at 02:39:42PM +0300, Leon Romanovsky wrote:
> > 
> > > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > > index 0eb40025075f..a76ef6a6bac5 100644
> > > +++ b/drivers/infiniband/core/umem.c
> > > @@ -51,11 +51,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
> > >  	struct scatterlist *sg;
> > >  	unsigned int i;
> > >  
> > > -	if (umem->nmap > 0)
> > > -		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
> > > -				DMA_BIDIRECTIONAL);
> > > +	if (dirty)
> > > +		ib_dma_unmap_sgtable_attrs(dev, &umem->sg_head,
> > > +					   DMA_BIDIRECTIONAL, 0);
> > >  
> > > -	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
> > > +	for_each_sgtable_dma_sg(&umem->sg_head, sg, i)
> > >  		unpin_user_page_range_dirty_lock(sg_page(sg),
> > >  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> > 
> > This isn't right, can't mix sg_page with a _dma_ API
> 
> Jason, why is that?
> 
> We use same pages that were passed to __sg_alloc_table_from_pages() in __ib_umem_get().

A sgl has two lists inside it a 'dma' list and a 'page' list, they are
not the same length and not interchangable.

If you use for_each_sgtable_dma_sg() then you iterate over the 'dma'
list and have to use 'dma' accessors

If you use for_each_sgtable_sg() then you iterate over the 'page' list
and have to use 'page' acessors

Mixing dma iteration with page accessors or vice-versa, like above, is
always a bug.

You can see it alos because the old code used umem->sg_nents which is
the CPU list length while this new code is using the dma list length.

Jason
