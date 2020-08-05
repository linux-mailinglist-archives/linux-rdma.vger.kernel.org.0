Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3816623D2A8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHEUOp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 16:14:45 -0400
Received: from mail-vi1eur05on2079.outbound.protection.outlook.com ([40.107.21.79]:13952
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbgHEQVK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Aug 2020 12:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV+cCk1OFGn2gefPLsrT2PvwKQaKpiUSGety5vZs1xqQgVxKFwscnoQ0KEk8aJMZzr8CcHNHMWMyCwTUu6VK8jwSLE+bAUJ4NYeAmoKVSsAJJlUrfzc7CkFC4mKtA3QxMzURo8ahRG7e0D0wCMG7Uxz8oAKI+SunYEzSa+Xm/7OLLturRbl26CD52iSrqmeC6rH/aDYfoVdacE77Qsd6EhF/ON6oEgZSj/iRcLz7qhSyFz2VlcfbGsF8n/PP4lwSscCAguTmUqCLEJJqIQM1dLpiV8Enmv8tDljBrNpHNi2v5HHpVSLw6hz2qWp217XffnzNFzZEpbAYD9wv9avrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeBVFk9mrG5IbM0VbIWZeC4bLqK3WPjHxBskwoA9dLw=;
 b=bm++8uuYxhvBDtPUP7kn4mtfyL4SktwHnkk3GHXGhe96l0MUyh5y+jzXKK6VeYtOkzLaJGDrRVJl7trXw733HXHbyL50bfcVdAQ0LeH24KLG6dLWfsL+lMOjR9Jc+wBl795OybJx31USCa0TRmG1BJhLFxUMiCBFotGK4JPWr/lQZS7KdlDvTiP0qbf4bVRPFcE8cAp63FM2iE0aOPnMCd1afNJZfqT0nHr2qP1n9m0Mhj4D2va8KmZfKRN0bCxQnDWfIl7+NTKELHf/fOFkBcMwHCxTUxj7v0ESzwQQ6ocIGMrE+ZoDLZ8FatZM7eBvquVXVIutsJciJ897mB6Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeBVFk9mrG5IbM0VbIWZeC4bLqK3WPjHxBskwoA9dLw=;
 b=PWBxyWJGAnC0IFGcqFS9LHb5Zb+Fm/iRjQbyHabfhcimcGniHubXiAA7cJAocY7wZVBTNdv3BP+0PgcvfQ4JTBfBW85C1JLy/eXXtB15FRCKdMkkGKnGLQOtbWaHuu7h3zx5i0VfU2hJpqeC2c4GU0J7Kx2DS+WqwPLe83kLLM0=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR0502MB3622.eurprd05.prod.outlook.com (2603:10a6:209:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 16:06:04 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 16:06:04 +0000
Date:   Wed, 5 Aug 2020 19:06:01 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, oren@mellanox.com
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
Message-ID: <20200805160601.GL4432@unreal>
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
X-ClientProxiedBy: AM0PR05CA0085.eurprd05.prod.outlook.com
 (2603:10a6:208:136::25) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR05CA0085.eurprd05.prod.outlook.com (2603:10a6:208:136::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 16:06:03 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e61626a-d680-450e-eeb1-08d839597471
X-MS-TrafficTypeDiagnostic: AM6PR0502MB3622:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0502MB36226E5BDB51885426697967B04B0@AM6PR0502MB3622.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MY5fzHz9onR/bc0aPN22nxVbSqCTMKSLOE1YKGfC2QliL6q3ziDuInReuJZ5u6c7ttkhW4gA0sZaJfoSEmOquzbxu4+lOpVYq62aKDgjHjZ8n0UwpLgfNIs7ml8YPWhawtcnk2ZN/euk6BUNqEBEYKuMmUxsG0XVeQlfq+OtsIiFNv/StxfiDjtpQv1S8wfbyKgaC05PRqDB4ABFfmU14wNUvN/QQLyu/rBAPhhiUtpoJ3mzTF897H2nYZW8vAuJjHgObcSUBXQwzmu48i3TgjiuTjlUpCTDeSGTPZ9zhP++AwdpvynBXOzcXUnx9KXUD57/NQqaQrhVkAzwAFWc8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(83380400001)(6862004)(8676002)(4326008)(1076003)(26005)(186003)(8936002)(16526019)(9686003)(316002)(33656002)(478600001)(86362001)(53546011)(33716001)(2906002)(6486002)(107886003)(5660300002)(6636002)(66476007)(66946007)(52116002)(956004)(6496006)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +nyubj1upRjuQTEZaCx+0tWBYDjFUJ7ylZg+7VDTmRJHd4Rb5jYGHRjsPMWpzJ2kNuEhOI8WkcgtMpnuT/tf1BFCNM+AqKVvuvg9u3AactDKG6d6pzWGEiiv5GONqqGgGezohwISygPf8jGew2wJp8OynjybtX6gRvAOlUydj+ylQLBmLMKVE3hqoh5968LheumMs8tL7aAv3A/zLLfdfe2FmVuuPfW5XYO+CibqN5J3wunUalVnXSGU4HnaN+4MPbSNLInvNKNsU2IFvkLAnll5/OLfCoNQ8TsTM556atI7Kba0KczfVCqWenB+woMWnjHTU8SNPMHa6m4CCo8pgG5NbNzoKsz8guKnFkci6HG9zUHfm1M4kGJMMdY/sTGcqoQ90GlJlA6oCJhp1JsHJnGudKYnrKrOMqcaBX+CrSkmgLbn2+6jyJ2DZGbAtNQZEeXv7bkrakn8N69LQXdqcmmuH5KbYAsFdC3pV5D1APipNOOg95YoSVtospiGz8xUJS+0EMVMVuBs0Bef/4IzI8psgQwc7a+sFvT6sJkRDvwbOHqzZa5uPhxlkN07NEOEoAzSy2U4ngaRkFCWk3oylJ6yzA9bitd9yXXHyxPcVGte8KtyNL/V/pG5zVuCMgIDW7K1x1Br/Jr8IfQlF5xzTA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e61626a-d680-450e-eeb1-08d839597471
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 16:06:04.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8qez58oX21SQluRJ3erFNgX0YcchkPltNHoymEs9tTrz6XjRWlaApD4I+GBHgHD2tOqumQSE0cYuBFPZcbPew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3622
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 06:14:16PM +0300, Max Gurtovoy wrote:
>
> On 8/5/2020 4:16 PM, Leon Romanovsky wrote:
> > On Wed, Aug 05, 2020 at 03:12:30PM +0300, Max Gurtovoy wrote:
> > > Add performance optimization that might slightly improve small IO sizes
> > > benchmarks.
> > >
> > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > ---
> > >   drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > I find the expectation from "unlikely/likely" keywords to be overrated.
> >
> > When we introduced dissagregate post send verbs in rdma-core, we
> > benchmarked likely/unlikely and didn't find any significant difference
> > for code with and without such keywords.
> >
> > Thanks
>
> Leon,
>
> We are using these small optimizations in all our ULPs and we saw benefit in
> large scale and high loads (we did the same in NVMf/RDMA).
>
> These kind of optimizations might not be seen immediately but are
> accumulated.
>
> I don't know why do you compare user-space benchmarks to storage drivers.

Why not? It produces same asm code and both have same performance
characteristic.

>
> Can you please review the code ?

There is nothing to review here, the patch is straightforward, I just
don't believe in it.

>
> Sagi,
>
> Can you send your comments as well ?
>
>
