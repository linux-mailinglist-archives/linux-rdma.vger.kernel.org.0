Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96F15649B
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2020 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHNy5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Feb 2020 08:54:57 -0500
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:3617
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbgBHNy4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Feb 2020 08:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/wwAlcTnlhLGLSc2cOzCo+gQ6D3thUysZPLNCm5JOZ+jCfdhgxXvHcR/rMqTSMebY9SVUY3g329ObS7MkLrlAX68TcQxX8PcXO0o25ROn3+iY3VchZ6MALUoiEZKgvaa4peLZTI9kEp+bRrr7Rv6WL+nINMax3CIL1BDg9zCcze0RedrVu4nG6ncqoXNYu9494swgDYjoBJebSmw+5TgMJkmVLT/yifG8DSD3o2L/wfRL9CxeYoGUrHoaH4mvBuOsF3lK5GbuWucxfp+HWDWJC22RSSUj8Y6RO/U8+unxwBoUNY3P5dkxI4ll2PDgMZdDYpLf3wV0XmIuMzA9T+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1Tbv4YooFle1QdGsL/4jJutNNP641e3EZCzxGCHXbg=;
 b=SqDGTq2085CaY4/vhFZYC3P1ljqip1yS9gjLCCEI7kaW2LAO+SnOZNW25nfdzhpp8ddx7oav2isFJohPOJPG+b8OKxp1Qjh0B/s3iSKvGfoYFSk/GUd3C34iYVh2r8odybDOKBsCzsQ32/VOqG/BMVRP6d//C3fxosSNeQriVNoiBG6mqMrUfhZz5dwm3ti+O88bfReKgmf4yx8ZUK4Hg6Q5i6udRb575yiFPsQRzGqya7OlZ7Zal63mAbLHnNDY778LxQ/CV8k1ko1VzXFFBUi4aiqrfc2MW3uaGx9m7Ix0nw/Fq41dGf5leXuX8fIgqc9ffASE0z14Mw1QyorzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1Tbv4YooFle1QdGsL/4jJutNNP641e3EZCzxGCHXbg=;
 b=qIv9hVnLk2eubq+OIv/pUk9p/D1gtIX/wbEmwzcAEp2JD1aaqjQl3XIc4sKjV2HHeNsewFoWqRRvkFw5ybZ2cLa1DTiR/F86Je9Flm926Z247IU/HR6jWzRWyDZvPV5uQF12tZwDmlPIzngX5VqkwvqZe4DAphoV3Dxzj9z4Vy8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5856.eurprd05.prod.outlook.com (20.178.125.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Sat, 8 Feb 2020 13:54:11 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2707.027; Sat, 8 Feb 2020
 13:54:11 +0000
Date:   Sat, 8 Feb 2020 09:54:05 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200208135405.GO23346@mellanox.com>
References: <20200207182457.GM23346@mellanox.com>
 <20e3149e-4240-13e7-d16e-3975cfbe4d38@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20e3149e-4240-13e7-d16e-3975cfbe4d38@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Sat, 8 Feb 2020 13:54:11 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j0QYf-0002Ik-Fi; Sat, 08 Feb 2020 09:54:05 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce571bda-3214-48c0-2a68-08d7ac9e6007
X-MS-TrafficTypeDiagnostic: VI1PR05MB5856:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5856CB4C504A6CEBDCE27296CF1F0@VI1PR05MB5856.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(39830400003)(376002)(189003)(199004)(52116002)(54906003)(36756003)(316002)(66946007)(66574012)(1076003)(66556008)(66476007)(2616005)(5660300002)(26005)(7416002)(86362001)(4326008)(186003)(33656002)(478600001)(8936002)(8676002)(9746002)(9786002)(81156014)(81166006)(2906002)(6916009)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5856;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ToQYTF2m0fdVVvJLPtoGa9K008a9YXKTj7OTW9EUe8l4a1s3Ixebo+s3P16BVqDKkl6mczSLWQxXO6XN+qLKqcdlULE3neqpcSOhdGao3FgNz85aiW7r5V39NENo+WscsRf+x+v9pDbI18te3A+jL+Sii1rPv16+rwokwNqATDxlKSUMX79YUiCgKwOcH0PnX5zD+c2DmrkmhWX5N+rr3eZq1sO4fXaxzDck9n5rmo0yiM5uAFyuotuMJlrWzmp3Gn+7X+LOEWOE9++eWcz3voI+1/I90eKuULDWsbmKeld4m0ljVRnuVdY2BLJzZbh0AmXBZlm5Gd8vHjRSqxwR0Eb6LizV+LDt5qBNzlIKnRMCv5G58fxbxaqloBYA1sR3VrRRj75SCeTKJyXuCeG0VJQ+EGiuRANw36Zoa3gxQVc3wRcNFLyf27HveKXgSp4O6Y3HsR4zE8y36NO2t8icgmCgm3Yn/+ZNt1QPXRNrRW3oB0q+HF0bVDOREDTaQLu
X-MS-Exchange-AntiSpam-MessageData: BGGo/FYTa60xLQm07bEoFDMxpy9dZpzu+Juf+eg573+gyPU/IfdzMMwq+NZ972qpdngKPHjpJZVf2CeRjorGQ9/TjmfDTk8C/02vaKEaxl9N1rRwHRb37/obIHgMpfi2u5JWM/NVLevf7DS4N2Wrhw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce571bda-3214-48c0-2a68-08d7ac9e6007
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 13:54:11.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3nX8lkyFGvG01LycdL78h4fN7egdScDo9P90NTSbeLpK1SydXYaDOljdH3v5P/voHA0+X8IsZwCU+IQZFB5iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5856
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 08, 2020 at 02:10:59PM +0100, Christian König wrote:
> > For patch sets, we've seen a number of attempts so far, but little has
> > been merged yet. Common elements of past discussions have been:
> >   - Building struct page for BAR memory
> >   - Stuffing BAR memory into scatter/gather lists, bios and skbs
> >   - DMA mapping BAR memory
> >   - Referencing BAR memory without a struct page
> >   - Managing lifetime of BAR memory across multiple drivers
> 
> I can only repeat Jérôme that this most likely will never work correctly
> with get_user_pages().

I suppose I'm using 'get_user_pages()' as something of a placeholder
here to refer to the existing family of kernel DMA consumers that call
get_user_pages to work on VMA backed process visible memory.

We have to have something like get_user_pages() because the kernel
call-sites are fundamentally only dealing with userspace VA. That is
how their uAPIs are designed, and we want to keep them working.

So, if something doesn't fit into get_user_pages(), ie because it
doesn't have a VMA in the first place, then that is some other
discussion. DMA buf seems like a pretty good answer.

> E.g. you have memory which is not even CPU addressable, but can be shared
> between GPUs using XGMI, NVLink, SLI etc....

For this kind of memory if it is mapped into a VMA with
DEVICE_PRIVATE, as Jerome has imagined, then it would be part of this
discussion.

> So we need to figure out how express DMA addresses outside of the CPU
> address space first before we can even think about something like extending
> get_user_pages() for P2P in an HMM scenario.

Why? This is discussion is not exclusively for GPU. We have many use
cases that do not have CPU invisible memory to worry about, and I
don't think defining how DMA mapping works for cpu-invisible
interconnect overlaps with figuring out how to make get_user_pages
work with existing ZONE_DEVICE memory types.

ie the challenge here is how to deliver the required information to
the p2pdma subsystem so a get_user_pages() call site can do a DMA map.

Improving the p2pdma subsystem to handle more complex cases like CPU
invisible memory and interconnect is a different topic, I think :)

Regards,
Jason
