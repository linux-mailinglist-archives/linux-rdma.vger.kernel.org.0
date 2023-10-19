Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9340C7D00FB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjJSRxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjJSRxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 13:53:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BA1114
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 10:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f908naztD4B/MbSQ6lrJxV1DD/EIMSqhKnHiEZ+CRT81CnF22a5dKrFnCRLWoGJSnn8v1lRfW+9+TctU/88Z4gs7Tm3Qpb4nPburi2CHc1l8uhn60uz3YQ06A6KdY/0RsEUoh3SXKe4BU4MaIm7+uKzTEcnM801h1dixISRBVAsZUW2EOp0cW2tOkBqrb7NoG0wEPWjfYor/dh7EPmJu3IwY0F94QcLDSJEoOG2z+hNK6Tq7sVHStCP23DkO/QiQX5vZH8el5nRaFrangWKWhNgu2nypVQG8GGC3zabjI8Oi/bzhbfQbqtSIJhCpg5MKJflvbXgVxZRrSB9gMNhJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/Lo6PKaZAi5CyBGdTwpGsUU/MgyO9/VRaolcqdNbGM=;
 b=LacPEJZIREQ+lX2Xvh59RiQjKTbR2rvNEyNHIOpueEwTK6hd6APHVDfwUbIyCjSVq4ihTg5XrfrqejhqoQN+3pDdueTjGZuD9eReGw2J3O8iieAiDIC9l+dXXo5dyYJfK4G8DO4stXaINnOcJVHsFr0FWSmFZzj1HP3TsZGYNyQKcmBsP5CvgVlRpzF5Fmh1T1b3rAMdebcnOkmyXYNnBE6mBug7md6TX4Xr7GZEmLYu4uE/4OCucUxD0X4FrcVmkysoePKbR9O33XfVmznRGhLaNlvkA3DORMlQECHoY991MhJ1e1Lyq9VMmnbmAX3DwQ2S3/+a6mC0xYK0uHetjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Lo6PKaZAi5CyBGdTwpGsUU/MgyO9/VRaolcqdNbGM=;
 b=r12voj0r4FzaSNoyb7jR2aPa9dv0eTseqKJ8jw130c8xnB4y9WknIhpfvrQRRLS55aNo4+HeZ7pD3CoWsV0P3e9GJIEk/ayyGJBaerr14CFbR3P+qZJllDiD2L2uAYVqEFD2/+wCSOyE1cPQHCUcuLRCvu50YniK1UgIw6HZX98ZWdzsSJiCcQbSgX+/AApu/vIocwVWNifIBYBFl/I+oR3RGCNyTyEhJ3nu4zdyfbDsNP9tG8+DSq+OqtWYTomopteaCsIVnEp0SxR9BdzONXXB9wITmQrE2v4Fun8rDgm+NiUGk4+BqAIl9NmKe7RfA9/lCoMCKVhoCghdSCy/DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 17:53:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 17:53:13 +0000
Date:   Thu, 19 Oct 2023 14:53:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
        iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Message-ID: <20231019175310.GU3952@nvidia.com>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
 <3f5d24f0-5e06-42d5-8e73-d874dd5ffa3d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5d24f0-5e06-42d5-8e73-d874dd5ffa3d@arm.com>
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7d0bc2-40ef-4ec8-e1e5-08dbd0cc43ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xihyvNOSjeOgs9HAEYwRc0dG9ap1jycO+7qbuMdfkw2i707atQP5Zadjgru8UTsNU579YddNT3dMpNX6gA/h2fL83t1634YrSFH17RJNvUDvLR6U8SWwPAWblRFPjJ2QNFqQqraFFvTMourX6KvAwhcyKGsylagfAYgPhvALv1wYN+oeaiM5gH4XE29wTiyozuq9qdXVJCYbCGnSX61WDcAYcaa9tlXg2wgNIAcNTu1KDHMxI+BAT3PEo3UAo8z5vbbVgcCDsKLNoCYCC21U9LaI073wRqjuFcdYPVKrJtkcNqHnBoG4WsJ4efv9Uxo+Ob5lgWqvVG+kb4DU8F6FAirjvwqNuUI4c8h5eSUaIjmpeHIQLqT1BDL2YKGsYosQ2NrIVX1G6wHo5zT7bxehFiAx4NLsA26bLKpByXaXuLR9W05z1XzTNOnPJCf4uvghweayx8ql3JDdbn0k6dSGmbKzDnAa/jJCHrnCM8LUfdsb3PUvd+PCe6jWOnZyDd1jkVTYdtExySJePvUPMpG3kDMyFZJM2A2FGh99aIe2WYu4THXeQI56nrBDQwXR1WD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(7416002)(33656002)(86362001)(4326008)(8676002)(5660300002)(8936002)(2906002)(41300700001)(36756003)(6486002)(478600001)(2616005)(26005)(54906003)(1076003)(53546011)(6916009)(6512007)(83380400001)(316002)(6506007)(66476007)(66946007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZACtE7RA2NacJBplBZDt3RJZIRS5ygh4pF+T38m5kATThromWjhHwOE9eSA?=
 =?us-ascii?Q?8YQKw0++EX9cQ09+EteaWwaqjxMKrtcGuv02z5DbBSg5kLEJH0B63m79YJXX?=
 =?us-ascii?Q?9m1WeWB57+CRyitx7gJP8gGZsZdUEyOUwrLYYMW1eljmKKwfZ5GsvATFOvS1?=
 =?us-ascii?Q?nt/N5Al6Fm1ZHI6ibfbbUkwp4eah9RQh2ffZtrmVEXlFNBnLSNd4xcJbTvPN?=
 =?us-ascii?Q?JIQAbqSaCsZ99w8cJVn5f1R+eGes8YNhGVt7LhFd9yWyAy2ywnG2xYUtqRWa?=
 =?us-ascii?Q?RgYljLPK2c4gM6jvtne85BbIBUTNt3Mv4+AZB5UHlVSoNAcFOEWVhz8V7wZ5?=
 =?us-ascii?Q?NDyhNlkjc0xyT31xCTx4BGnNDl/vxOHm0S03tb+UJhPA05551Y8vYDZp0BQN?=
 =?us-ascii?Q?R2+LZrgCt1L+htu9nJSnX76AK2eR08sTXhHcDNkS9yXdNWmyuVSlwoN6a/W6?=
 =?us-ascii?Q?TqPbzdL5jNeAIpkZvxqO6BPJIpHAxdcORQ/RL2CRTyvM26zX8nmyZCQrgYbb?=
 =?us-ascii?Q?gEhzSQ/TxnZHMB8MNs68Wmikdp+GkvuXMII91JuzAI26H0yk6YLPwtRACcN7?=
 =?us-ascii?Q?sJVSii1P52wuy1DZiDRZIfeyKQn++frK0efr2EurfMXmLxi/rL88mtXKRdWu?=
 =?us-ascii?Q?XHV9pzaRNBcm++12Md/utoaeL7ixxx9MID05Fs0egp+AIKFGx+LRfOIFVFB2?=
 =?us-ascii?Q?bp4u/rXWpy2rJarjgbYd6J10gq/AgCmQEXD69TTR89lYkZ9FL+EptSn0H/Dl?=
 =?us-ascii?Q?IM1nx/baPUbSl9+bYj4L9VJFQ3uQn6cNkhLJooknJ5pLvFf45KRjkjbIlRSY?=
 =?us-ascii?Q?HRhHcjgA1U8GuXQ3x21LhZClgyl2hHajb0grt+pv/5hE2TC/EKCHZVpgpSE7?=
 =?us-ascii?Q?w3W9BvsMoKLxuiOC4Piu2pGoTg3nXd5cbLYTIDhWbyPUaZNOjIIBtlDUc35x?=
 =?us-ascii?Q?hHE2qSJSjjzDTsfIS9s/EKsJpTgYRCJ50uAzChyx6lxXEv+6vgpTxQoiVjol?=
 =?us-ascii?Q?OOVtHD8DeovbkI3Nlt5HFeLPfnF689F8rIrW/3HEUmDyIMLGHmIxAgFxc1iZ?=
 =?us-ascii?Q?gcVBYdhWnhv4uWeW5IfBuGewsbBmXRC7OTGNllW4pOoCGSCd1aAd6sjaEPAH?=
 =?us-ascii?Q?EsqHMVD68OG6SoP86+zHUGy1JZfKqhWXQ2tFd8/5giVAWegsWAvuSbLgfODx?=
 =?us-ascii?Q?bjlQE3/1LqXx5px1MLv9Cw3NA9jwPY/7PWuN5sqFLkGd8N3qrqErYd3dHzZe?=
 =?us-ascii?Q?3XZaeI2GvMAdurwGpkgb71FTB6cY9qcRWnKZIDoULGZcEnc8pqSadVMvcMbi?=
 =?us-ascii?Q?PrSAGfpTprMerzjm6uKIvlL1XwiIAxQQ7LevKIfLkrl6l4tLj/i9heBpps2o?=
 =?us-ascii?Q?Q7jjZNjxEdNo1Uno5Y+OLr+aiug453fejWWKtcsIVFaA5d9pIXgf3jkvt6XL?=
 =?us-ascii?Q?qpusJgamRlwCwchOIp371B3EP1ta9rFxcd583vfuFL8yknPic04flBPX/PCv?=
 =?us-ascii?Q?axyKlOKqU1zT7VLtisXn5MLIcoeK5nkCXSJMyRCSQXOiwWQ/nAKe14eIWoM1?=
 =?us-ascii?Q?Q3OJ5X6OIDaZsCncMY/D2p4xy35SayraKE3Gh4g9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7d0bc2-40ef-4ec8-e1e5-08dbd0cc43ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 17:53:13.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ERGeSDoqO/rUv64Xau28oDM7Qn6ZuLUOZHVijPol2BJCVlk5Yv4xPJzMer/0TfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 19, 2023 at 05:43:11PM +0100, Robin Murphy wrote:
> On 19/10/2023 4:25 pm, Chuck Lever wrote:
> > The SunRPC stack manages pages (and eventually, folios) via an
> > array of struct biovec items within struct xdr_buf. We have not
> > fully committed to replacing the struct page array in xdr_buf
> > because, although the socket API supports biovec arrays, the RDMA
> > stack uses struct scatterlist rather than struct biovec.
> > 
> > This (incomplete) series explores what it might look like if the
> > RDMA core API could support struct biovec array arguments. The
> > series compiles on x86, but I haven't tested it further. I'm posting
> > early in hopes of starting further discussion.
> > 
> > Are there other upper layer API consumers, besides SunRPC, who might
> > prefer the use of biovec over scatterlist?
> > 
> > Besides handling folios as well as single pages in bv_page, what
> > other work might be needed in the DMA layer?
> 
> Eww, please no. It's already well established that the scatterlist design is
> horrible and we want to move to something sane and actually suitable for
> modern DMA scenarios. Something where callers can pass a set of
> pages/physical address ranges in, and get a (separate) set of DMA ranges
> out. Without any bonkers packing of different-length lists into the same
> list structure. IIRC Jason did a bit of prototyping a while back, but it may
> be looking for someone else to pick up the idea and give it some more
> attention.

I put it aside for the moment as the direction changed after the
conference somewhat.

> What we definitely don't what at this point is a copy-paste of the same bad
> design with all the same problems. I would have to NAK patch 8 on principle,
> because the existing iommu_dma_map_sg() stuff has always been utterly mad,
> but it had to be to work around the limitations of the existing scatterlist
> design while bridging between two other established APIs; there's no good
> excuse for having *two* copies of all that to maintain if one doesn't have
> an existing precedent to fit into.

The idea from HCH I've been going toward was to allow each subsystem
to do what made sense for it. The dma api would provide some more
generic interfaces that could be used to implement a map_sg without
having to be tightly coupled to the DMA subsystem itself.

The concept would be to allow something like NVMe to go directly from
current BIO into its native HW format, without having to do a round
trip into an intermediate storage array.

How this formulates to RDMA work requests I haven't thought about,
this is a large enough thing that I need some mlx5 driver support to
do the first step and that was supposed to be this month but a war has
caused some delay :(

RDMA has a complicated historical relationship to the dma_api, sadly.

This plan also wants the significant archs to all use the common
dma-iommu - now that S390 is migrated only power remains...

Jason
