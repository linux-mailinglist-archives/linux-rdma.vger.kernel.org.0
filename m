Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BF23D19E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgHEUDZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 16:03:25 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:65096
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbgHEQhp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Aug 2020 12:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KREiv9Cge5hQAiFzvDa49f62o59BfXUu1r6ulRIhY+RBq3TLWH9pjaK4kU2GCJLiK+Rnxd0X1KHfTIDWjapJQCFKv4boJvwQk1ItDJFYBjDoWr91t3lKrum6fffo2DJ5AgmBT2DfZ8MK37oDX/gm4UcrPlS8sIioSBDgZYXXuoI6dSICOAob3ut9MlAKIbVgNTDO6bZXr16dCpHxyA41PLsYPJLgYK60wKvq3rABR25UXSCIwIofTD3Wcd2s4Fh4oasXc/j0kpy7h9DGVBLC5WCBM1cxGFKg9z9nVECE5yog99xKaTVrcIySLCwVZSh2s7iUCIySF2kHuhg6zzGVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1RTfqZ+JLecbKaaCssu126NIUlEvjEbYJzC1gmHhGU=;
 b=Ggqix+FsJiFbLYvvSivNQM4YFpcHYpSbJXxrqHTAvQwd4LiDQLzO4DLuwZgTE3YcLxmrC8lolgTPt4J2uXtIMFilrUyfRDos55e5oKwn4ugiTBoSCjjvb3O/Asaj3YEnpoQKEY5V9qJcl4D9TRbt7jTGoUID0EnyVyzaf+2gPj8aJOMdxwvY22CQzfqeHIpSMaFLS4LZHTYjjczK0MBRH41xJ03htEDCHWYClWvhhxqkgnpC9eYx73/miYNuk5cIA3xzVBPwO5LuhaJlj9X81bDiYlZz5tWhrplAKAVCAvbWKy6QojzjCzXKc1O7XSgxrcSuiVFNJPLzRFb4ZYZNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1RTfqZ+JLecbKaaCssu126NIUlEvjEbYJzC1gmHhGU=;
 b=jecRdBuTFNZ7HQilEKWNYfGDiMcJ3fW216CW/YxebZQD4Bpk1+lDcPx2GwwSfE0+4nkycXjcOkmpBxpBbCy60WXmG3AvyDBbKC22q3YiLjp2R5u1NCenuMtZDphE7M8NzDF4GaxxSKxBVTGVx4DiAm+POcprwXITW8A/94BPR9c=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM5PR0502MB2883.eurprd05.prod.outlook.com (2603:10a6:203:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 16:37:42 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 16:37:42 +0000
Date:   Wed, 5 Aug 2020 19:37:38 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, oren@mellanox.com
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
Message-ID: <20200805163738.GM4432@unreal>
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
 <20200805160601.GL4432@unreal>
 <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
X-ClientProxiedBy: AM0PR03CA0043.eurprd03.prod.outlook.com (2603:10a6:208::20)
 To AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR03CA0043.eurprd03.prod.outlook.com (2603:10a6:208::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 16:37:42 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e45c9fcb-8ee7-4489-2373-08d8395ddfc7
X-MS-TrafficTypeDiagnostic: AM5PR0502MB2883:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0502MB2883DC32CB7274FDF5057270B04B0@AM5PR0502MB2883.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNQl3sJARlJItUCzCLGIRJ/u8qUqlXpFWnP21NKdBsOxupSo/lfDcPpQXXU7NT9xRazqdBnUfU4ShQ3HI+sN7yhNTfnKw+0WH9TLIZOT2Cl4AnFowKq1H4XBdh6HXW7GkX7QhCWCTNBZnxLHgHBp3+mCqZsDap0MggGuR49fX6NWrVUGDsvY8J4SBJys+2wr1y/1ZMevDxD5dxHsxvELcUse2YKPv8ykZgzefZmXjsWFkldDGySgxegNVSYIdc/SvRRuiMkGhLNyLmojzZnsCELTnI3uarWGeBuRtlTA4AZCgLoPjYK4fTwqJP/YMLKIJkzDoT09HbVk9teMZRsyqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(6862004)(83380400001)(6666004)(8676002)(1076003)(4326008)(26005)(186003)(9686003)(16526019)(8936002)(316002)(33656002)(478600001)(33716001)(86362001)(53546011)(2906002)(6486002)(6496006)(107886003)(5660300002)(6636002)(66476007)(66946007)(52116002)(956004)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Nzv747SLnyCa2u2/snvZyVjyGbHOUBJd3JWyfudauFmTgl5H3RppYqzcq3clxB9YTIJRwQQWbVEE4IULh8aQpy87d1OdzUv4P09Re/8cHXXLHzx45U3Tnb/MOAXE0PDiB8izDZqOor1Ftqgffl118QrEPlUtgOoqsNjRsKkN9qj7pBqylpZ0fYgyAO+8LGiRi6+5A9jeTobVqbTTU2Y+Rc1FUq77sn3gJTf7/yQQMVujQmu/0TZsJ5EQLOtT5j2KErKl+gaUsSompNP+tnuMBjokoDPvXBrce/tpVDbbuM1n1HNUaGEF7WbWsy9px3CVGyZnB042ha0dkmwUslOoeANN3io29B83ZCruTxGdMdUDN7rS24ol41XenukQZ1qI4HE0HVV7wJwrysLddoSh7xvbY4T1ZmnG2GAGz6o+6OT+iZFWyqriyTDDi64Cb4jX6yAzogOWgy2Ip1MflbggTXUkK7nL1rE0nPSmhTEssOw7a+gishBK7tu8jALwZNfeIu2i8P8yyvQJlayei83S+lOFaV/cddYCQELlAmgsnqiVZjNNaGuBK3Uy0frgdIMM6y/lOjdGylIEmF/XXm0Ob5dQnh7P0obPZP3Lp7Y8vE5shw6uB1yln0OjEIOSr2Baz6J4vYFSL6/DUAWrCj+iJw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45c9fcb-8ee7-4489-2373-08d8395ddfc7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 16:37:42.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr1SxjQB/kBxdREFaZmKM0lZFZYnTAZHp4HLjtSNg3pfIfx/yFu72zcmZr/XxKMEsxM0PLXiUnnanKKF6CX2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB2883
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 07:28:50PM +0300, Max Gurtovoy wrote:
>
> On 8/5/2020 7:06 PM, Leon Romanovsky wrote:
> > On Wed, Aug 05, 2020 at 06:14:16PM +0300, Max Gurtovoy wrote:
> > > On 8/5/2020 4:16 PM, Leon Romanovsky wrote:
> > > > On Wed, Aug 05, 2020 at 03:12:30PM +0300, Max Gurtovoy wrote:
> > > > > Add performance optimization that might slightly improve small IO sizes
> > > > > benchmarks.
> > > > >
> > > > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > > > ---
> > > > >    drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
> > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > I find the expectation from "unlikely/likely" keywords to be overrated.
> > > >
> > > > When we introduced dissagregate post send verbs in rdma-core, we
> > > > benchmarked likely/unlikely and didn't find any significant difference
> > > > for code with and without such keywords.
> > > >
> > > > Thanks
> > > Leon,
> > >
> > > We are using these small optimizations in all our ULPs and we saw benefit in
> > > large scale and high loads (we did the same in NVMf/RDMA).
> > >
> > > These kind of optimizations might not be seen immediately but are
> > > accumulated.
> > >
> > > I don't know why do you compare user-space benchmarks to storage drivers.
> > Why not? It produces same asm code and both have same performance
> > characteristic.
> >
> > > Can you please review the code ?
> > There is nothing to review here, the patch is straightforward, I just
> > don't believe in it.
>
> Its ok.
>
> Just ignore it if you don't want to review it.

OK, just because you asked.

I reviewed this patch and didn't find any justification for performance
claim, can you please provide us numbers before/after so we will be able
to decide based on reliable data? It will help us to review our drivers
and improve them even more.

>
> The maintainers of iser target will review and decide if they believe in it
> or not.

Sure, I don't care who will provide numbers.

Thanks

>
>
> > > Sagi,
> > >
> > > Can you send your comments as well ?
> > >
> > >
