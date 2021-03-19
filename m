Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F4341EBC
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 14:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSNtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 09:49:02 -0400
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:14657
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229926AbhCSNst (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 09:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyuy2HkY1+LJbp6/+Cps20/v7RqLax3xSff/gKYrh/BhO8kgStp6OxycFGVZWzvh9X0ikmEee59WZ2pUlGcIlpgtG12HhpxpSvtbQ0Oynxd5U0/fN1PkLMAMtN2RWrnXo9p91Vs2XGCV2GA0MEiKm1+hJ9gpvytjk/58FXL44Ec+7bTr9ig54a7fvHZPTxyGKOZ/94PA+Dn0mIWIfjo9z1jPxc/McwIqRJsS03jSfXElzYR5yQpTSfel5payFo3/Il0IC0t3wfuN4hrebZjqw4dO9qGcOFDiyjrTCrxkmyB73cJtfsW3tntLhMLUO5pumxaaZ7yLr13RsByZFaaOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgEWaVek5NM9/CSm4hQCUJeraD5Wkt7+wUq+Q9qT1FU=;
 b=Rez2VrbJnKOjZj8LyWOo24b5/G+SzDgStmjeU8qVEWrgv+6FRuqfidV7Auz1iK8FZbPYtI2Mx//xZowuLm7tIVb5dQn020jcbEif5osKxdu6lQwd4nrRqn7KZF9eMXw3IoXg7rsgVse1zR5OzR4RjdAtnJVhN6w7ZOGxOGONPYyKmWhucMmDeVzDnyLJZ5PjQ7NWnxs+t+f5FRn39K/BD9av+de6VPmhvUZyh5fHpam5fX9pZCNlbcTTahnLvhufWqV1fbiM9YekuN+0kcR4Y7J4uXarlyI9OTQ3lXEXH9QALi4a5gV2J2epJBn/29FRfVTg0aTdpcLcMnTC+coX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgEWaVek5NM9/CSm4hQCUJeraD5Wkt7+wUq+Q9qT1FU=;
 b=LIHb0qYzTNtOyV/X3k1v0WQtc+LflofwfkwV7GYybIgtLK+psHUYU1zZPgLI13lppMcnYo5luzqLZErk5yp0BNFZFOBgiGbZO4ak2AMxyZVkX4Er+LZnwTB2fHJ1qvSbH5JJigCz4BVb2EsF0YNhjuRLfeOGDutc3stLP5GyVI2NT+6RCOiw/D6AfFVu+mfNZOcHVn7RjH/6re+yoSk3oY3mjAd0/KBzZP0YN259UO6PmMkHnyOrV6hd5Buik55ss+6TPXhKcuT9HXPeU7DOV9ydlx6I+l1Wf5PNXTlLVMY15NGWCZn+OVDZ3zrl9dN2H32J8fKp7bs9oQzUkY/oJA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 13:48:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 13:48:47 +0000
Date:   Fri, 19 Mar 2021 10:48:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210319134845.GR2356281@nvidia.com>
References: <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com>
 <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com>
 <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com>
 <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com>
 <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 13:48:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNFUb-00HCnj-Jy; Fri, 19 Mar 2021 10:48:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f2fb45-3a67-45eb-7123-08d8eaddb7f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4578A49197063B17A83C2B58C2689@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +okvhDQKFYuy4vEYluXLLf4Q/la19pgyG6RvD55NJqRDGMqiTwLIwdFT6GRXXwNKsSZJCXbTfVJZ+GtBPe4j8Id5YrK4Sjkan065LzZkv3agJR93Dl+8gWq02z713Vu3GCqKQ05cz2tk/v4HhWA378JsVOQTthFoEAA0q0mNIVwAEGglrzS+mcEBszLo90WMgKo64qnzXRRRgYyjqUJ4XB8sFC6QsCUVG0Ew3MRYG4KEFssgdAjDZt6RbAfS17XUN1Ps4izOTUIGvc2aqh0U5k4xZooiDbKzI4zoCA6aivPCEnCWVwwWbApBhfjSkM28Rk/SckEY+s/XYxbWXHkPxy0iWfmjKnvUVMCZXGCy+dmnMkW+lD7a1dPobY5uTex1CSTVvJYlUAJIivFhBcRWTcP1FbBSLFpZWJNUwYzCcrjn3x7LUrMQq5rwtHqWMgduOHcqaHHtSma5tshL3Fh8S6pNpbU62/SIMwFBSno9nSlNfdm0KLyDnORj4FMfy+YGUx42amcZ8Oo06ExUMUjqoAho9b1no7++SPcxdqvsmUjCWrQzoUpcLfrWG+vns1KddWzUSzaAyTNuP2ZjHToFCT0wqsb2Dh5azRTuc3wXMEGKqVM8hJWAj+/Oli6ymP7MazXiLU3FxeHoR3PAcrkajiW1RT4V8u+kFWQA+Z9tL2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(107886003)(83380400001)(26005)(1076003)(66556008)(53546011)(66476007)(8936002)(4326008)(66946007)(478600001)(5660300002)(33656002)(6916009)(36756003)(9786002)(2616005)(86362001)(8676002)(38100700001)(426003)(2906002)(186003)(54906003)(316002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wTgbfooKK6Gzr7eWdIGGEBl1pzFBoHXt6cqUZ3vFop4Diig9XBm/tJVXOuV3?=
 =?us-ascii?Q?kAvs61qlMT6C6UaHlfu7GzT0UQ5aLPZagEVKJ28Wc/+VIoP/a20huVODUwLE?=
 =?us-ascii?Q?Lcnb/x5rbMgVUyk4Ol0wU/j9dM+tFPsTU82ZZQ/P2FsRmia3qyFAjk/qg0tI?=
 =?us-ascii?Q?VhBmMvE4b8FcB/vbgH/8IBDacEv56A20Z74oMfkevEn3qrvURoQBAhxx6Fa8?=
 =?us-ascii?Q?WvOfox5yu830yK7+Yp5rAWew4dGA9Ypm+5Nlhny6u9uXMX4VytRcigd8Bv1p?=
 =?us-ascii?Q?sA2hKYUcIY/tCYyAxpSwEW+VaMUTkr+2PtUBKosDF6RmjggTnSvElOn1O/0J?=
 =?us-ascii?Q?/GswVoHYTVpnvflQ9LoKoU2Ww27E35FDh16ir09iIxYjJ4ZNCQtvX/BrHXJg?=
 =?us-ascii?Q?p54m4LxUqcrINmdRwosMvfn3VyoYwF1OXvGcxYLs11ixdYZoc1cofBhcOcYf?=
 =?us-ascii?Q?gk9CtmKw6Yc/6w0o0DX2k7OrZkilfpM1AyGBIxH1PPUOTjYDW+FP3scosmVB?=
 =?us-ascii?Q?56wLCBuJY6ZcqIimL5y0XYh+t34zKfGtj+8ETc2Gk5o/t6OeEJTfsI+MpBNT?=
 =?us-ascii?Q?odFao+seyAGlNtFVLCpaMoPmT9QW6z5hW9j46jnsIZ6zYN2vgGbOKxIBnR5x?=
 =?us-ascii?Q?H5THPXtmm4eHkdvyGntzLiany7A8NIJ4AnDKyYIVA+OUCcEp0Mqh8F8Swpa1?=
 =?us-ascii?Q?1Q4Q+24e8Nlqg1EO96Z19tnNIyIx7mBb5tnfrL023kHa74BCocNjOOfc+3s7?=
 =?us-ascii?Q?HrvBltWluFqGUV+n+PtuGD5b1QT0dDBgyKN6/LsT6c03jR9zEL/yLpY9pJ7p?=
 =?us-ascii?Q?dSq26um7JQ7JiVhCt/iErhZIpwMqn1zXKcCZxy7O/Cxbvj6xt9pFZR0JwUB/?=
 =?us-ascii?Q?GoCA2cKHymddXY0QSGAxh/Kmrazss1oPZv9ico9785Wu+44Ux+EdXJr41A+H?=
 =?us-ascii?Q?CzlhXuRKDFFzji3CE1qZKNlF0B/KUXdsqBpf68Xnl5hTbCARFBIjW8/0/s6X?=
 =?us-ascii?Q?+UI372nHFypgNAzCMiWv4nvENCRDFuQO7OOBfp0YzO/Rjz7SJ833nutmOOBY?=
 =?us-ascii?Q?Q5iTHEec3RVgU2c1U1CyBZchyqcHrQMBlDcjTvIzJrscERgpjvi78dUw6eyD?=
 =?us-ascii?Q?s7Um8sBeNVrTeUo5GA9U8DgmlAeALDwQLqGRAH7FpsA6nXudVyux5NJg3Bdd?=
 =?us-ascii?Q?EvrXw5I1M7Gvx4MM/R5KolKEkaexhilJcGl2NbBe82MM7YS7MDwhfH5espJ+?=
 =?us-ascii?Q?qfVZlL/hdu9x5mUvY51bsC+m8muf1Xv1hBrc2yC+dXuiXfGqia9u0a5R1FjW?=
 =?us-ascii?Q?wDLz3A/EpsYxOqEt0vA3S+5U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f2fb45-3a67-45eb-7123-08d8eaddb7f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 13:48:47.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzfWn1oCPCQceybM3sisXF2Bl1NFyIo1149q47KkPahzUJoMJYPFc+YYJGKYGRxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 09:33:13PM +0800, Zhu Yanjun wrote:
> On Fri, Mar 19, 2021 at 9:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> > > On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > > > from the sg list from ib_umem_add_sg_table.
> > > >
> > > > I don't care about different. Tell me what is wrong with what we have
> > > > today.
> > > >
> > > > I thought your first message said the sgl's were too small, but now
> > > > you seem to say they are too big?
> > >
> > > Sure.
> > >
> > > The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> > > And the dma address is like the followings:
> > >
> > > "
> > > sg_dma_address(sg):0x4b3c1ce000
> > > sg_dma_address(sg):0x4c3c1cd000
> > > sg_dma_address(sg):0x4d3c1cc000
> > > sg_dma_address(sg):0x4e3c1cb000
> > > "
> >
> > Ok, so how does too big a dma segment side cause
> > __sg_alloc_table_from_pages() to return sg elements that are too
> > small?
> >
> > I assume there is some kind of maths overflow here?
> Please check this function __sg_alloc_table_from_pages
> "
> ...
>  457                 /* Merge contiguous pages into the last SG */
>  458                 prv_len = prv->length;
>  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
>  460                         if (prv->length + PAGE_SIZE >
> max_segment)    <--max_segment is too big. So n_pages will be 0. Then
> the function will goto out to exit.

You already said this. 

You are reporting 4k pages, if max_segment is larger than 4k there is
no such thing as "too big"

I assume it is "too small" because of some maths overflow.

You should add some prints and find out what is going on.

Jason
