Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF9338E2C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 14:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhCLNDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 08:03:05 -0500
Received: from mail-eopbgr750045.outbound.protection.outlook.com ([40.107.75.45]:15342
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229968AbhCLNCr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 08:02:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3yslDUr9dNUSy4LVLjtMT2L99OlB+dMx8ayaKujbuWi9q/uzQMraiMakufDK6c+3hFG7OgccAnZAzovPaRhMS7t94Vs18l9mSQ7DYJkrpGRPaWEEE5RvYtQjat67yM7TA67qQs6ForituNQds6JOxIi5X2HBtjNQ8ZAOdpa0ZIIUdqh6ilMNiXn3DBi6IeredboQ4xMlLldrvGEPo8/rWuEJXdFKSjeO+9oKtfexirJQTi09a89jTaGPfJQfXhjsPsznZv5IYKLolkDwp974oVLRG8D++hy8EkojmiDai+t7q2lAAdja47c0sdNbBJSWWlhAl/29iUDmlteNR7jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dt+qMv9VDoJULTHdF47CxqLILOgjSN13MVz+FQJNUc=;
 b=SWvUc77Yd6W42M+72wk+VeabHdCW4zV3Z12KDMLcTTmspQtJgmep95d/4jjlYMzCrzihP/ZjLRai0QKBjZf2MLEE+lggH0Dp975FFaXgBnMcbGyej94qXpvYsdwiNNOn3LnP/hfotsZnY5o9KmhAGWY1mQxuyeQqIOHyUEqgdMVOuQZUOg4M7eAO7d30JhIQa7TBz4UaHd6WFX+46wydV6BuxVcyE0ZLHRuql4/f9F5hU6rVefFL1HwpYj5r3oVtwUDo2DSHHd6WmQrwmjs1wDq97fXSQpaP1wduzjZSQ/9Jsx67ob4n4eOBGDh/G9GbKm+dg7S7i2srXCf49qPNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dt+qMv9VDoJULTHdF47CxqLILOgjSN13MVz+FQJNUc=;
 b=C8e89JZSkKwYlv8G4DqwFp3RoBaj7tKq18g6vERrKLRD9xjHMgiFSJahGGlDjWO+9gOz41CgrfH54mtY7i9nEsn8vRgmWZrM5SsnHLJFpFQFtDSNLJeZNgxfTlAZki0KakImwFOBeHRxzLi5CoJcN/yMYOq0D4TwU6/+f8jTfflmLqU5iRtoQhurENhPKk5sQp8JhIHer1cBkI+mqa6BPtmT2kDo/HGqD0toPOCt1+r9Lnxrib9bL5xXv/yItwvOvdKZ8JWxiO3sJXMoBVbDGWcjFdLVali9oa4QCypPDNdA/TPNwsjQT8uG2sYv3JlUWYG9fq2pxs7tOxMmzjc2Ig==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Fri, 12 Mar
 2021 13:02:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 13:02:45 +0000
Date:   Fri, 12 Mar 2021 09:02:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210312130243.GU2356281@nvidia.com>
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
 <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal>
 <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com>
 <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com>
 <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:91::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Fri, 12 Mar 2021 13:02:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKhRD-00Btal-MV; Fri, 12 Mar 2021 09:02:43 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89b3e0f-8674-4214-e133-08d8e55720df
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3515B97F99D7EAF910FF9C8BC26F9@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnXe+Jza/kI4BIgeIOsHhFJrpYvORv9caI6i1WmC4jPUWUADiO6azNFlq7MLZ+n9dAyM7mier1nA1eWBAl3GoV91AXjl304/ws1j6Kn1F0GRLdrktZCByKKjus3xXDoMydr2Aytv+BXjnxWEWYBlMPeEj/sZAhb8fAcZgfaOocGNEtU+8C69Wkfevz7yuuiysbm0zWvY5XcIJelJZS24m8NqurVqLMpwAeeKNXNfSPCeL7Q5FcCvBpDx12l6bJ/ibR7VDTMktTJg3XNPhvY2cziKA1zNYSunIgfKymZNaPtotgMtktPwhf/IhLqG8tW41v8Uged/G83b81hyShPJEHnf4mlFyZagc7NMhONgJd3h2T5G/4WWnh7GFhI+GNczRZi76NgOtlFg5Ykvzhj7CjGT79y9DKsC+ABWjEDJzJhAvzde892YIZ7DZf9Jb1vrOZ4BNxwLTx/ZticlZ6Qtg2EzdqZkKQxvO/M1dowXSHUF0KAA2N0+n3mrDX9n0cr+MyN5wHOpGaIoulKsM1wycA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(86362001)(4326008)(186003)(26005)(316002)(8676002)(2616005)(8936002)(66946007)(66556008)(478600001)(36756003)(5660300002)(33656002)(9786002)(107886003)(1076003)(53546011)(66476007)(54906003)(426003)(6916009)(2906002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+MSEXxktFpMJHgSt3uPS1i+8bAjMt1HFabRX2CjbjbztAAosixK/bNelDbrR?=
 =?us-ascii?Q?9qxldzXe/g5IBiCUzEm9xrYQwe+7tfE2lQQkf8jIppJOxqzqDiqaX2lPOvoJ?=
 =?us-ascii?Q?a9pIV0FfLAMTggC3mIGelIxvZorV0m1b3q1kULgQGSE+r4hph+9wU2a0qtzX?=
 =?us-ascii?Q?nL2eT4S5NW5aAQtuzdIstctiDUSo7udzlbljaxSNHJ+p4u+bIQM7BGZi1p2S?=
 =?us-ascii?Q?NjU1PidmK+ihEmxje5JE9p7tDTTZp9nk/Lx0RUWrGwW+Upaamdc0zA8gGJHK?=
 =?us-ascii?Q?e9LajX6J4fA2XZRQdIagBGByv6l4yYhyOnHrqa1y/IKmdtTMMxOFrsiJPcjS?=
 =?us-ascii?Q?duwvcPFll3Nxp+8eDBMgbKk268jXUaDDK7KZY+Bww9BYQ70n2/KZmV5WA9/9?=
 =?us-ascii?Q?Hqe+pzeMBm93SndoKu9Z5+f1bKZMli0kTlm5L5u04oSxrkE5nOwnmtRxtsYL?=
 =?us-ascii?Q?vypg7iPoJHv9UNX6xmN9xg6ISKfRnuF2S2O62hLMcm5cC8CMlBn3g73jiOfU?=
 =?us-ascii?Q?kOrVYRHgrNNRg1nh9xv6VXOxeLctoboDGChvXy0FgsqPydzzayKSpGqoLGgb?=
 =?us-ascii?Q?IigVItrVihoGWisZKWQGP0afrXhaARrvIfWZPaVxz3Bkd0flM+xIhRZKVgHF?=
 =?us-ascii?Q?SmnpPUuV+hMo03v4mbtDpXq3zPuX7VO2tjk3Ps8UkNGdfEJximfBLolRhv9N?=
 =?us-ascii?Q?svc3w20/fdVv7qNldcnQboD9vl4YScPhyPkKTk2PUIw8CeCf68DRgeaIoRSZ?=
 =?us-ascii?Q?b44e7NLxaRbhq21Sp46hx2czd8Lkuhia32+Ui+NHnASD8GabQaBIEXaw/YCB?=
 =?us-ascii?Q?03MONgAhgXoiZAzTGTsTZ4AZDX3tehxuwn/P7S8GuDF2yJ4RknlY1QSSo3Mn?=
 =?us-ascii?Q?wPjLZymwrAQlrHUNuOv76G+MN2y5MgsQySXfBRX9TDcELx659y+JOH6jDJF6?=
 =?us-ascii?Q?1tXCetAWNtJIFOMC0kWWb40fOVmtFGFKHvKdPBCQ1hgNY8+FpYmcpVOYK4yU?=
 =?us-ascii?Q?xGHXqN5qV84GbcOrvXkC4mTrsscEw8cv5hd4zr7mkGr+2rsyAr3CavHH3Fx2?=
 =?us-ascii?Q?05D0iwlh4cx+mk2XppJy/dOGyYAwT/syp0+gfNk/nAA5vXbGty4WlHGQd0M3?=
 =?us-ascii?Q?eRErcs0oI7bULWpygOeWhWXwHq52h/7r0LinsVhu6XMf9LSdVd3uUWL81CxK?=
 =?us-ascii?Q?WcLcZyC3ioj7D0kI8WUY3XdGHMISOWwwV9SThw7xClcv246nqNiB8R7l6rD5?=
 =?us-ascii?Q?x9+tFjGIAWKAbp+31olYNL9uHhTYcd9P98bZZrmFt6sDw2H/pYD6GLavlhlo?=
 =?us-ascii?Q?rMyohomMWUuYJPmNwrJh12kDHo/NDdazII++8ycth+HWjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b3e0f-8674-4214-e133-08d8e55720df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 13:02:45.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hplQ74Hz/RlK0sHvoiHfCEBS18waBxGdoNo9RtQsAOKwikvKowgE8bC9r2tseg4e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 04:04:35PM +0800, Zhu Yanjun wrote:
> On Fri, Mar 12, 2021 at 8:25 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Mar 11, 2021 at 06:41:43PM +0800, Zhu Yanjun wrote:
> > > On Mon, Mar 8, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:
> > > >
> > > > > And I delved into the source code of __sg_alloc_table_from_pages. I
> > > > > found that this function is related with ib_dma_max_seg_size. So
> > > > > when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> > > > > 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> > > > > address is 2M now.
> > > >
> > > > That seems like a bug, you should fix it
> > >
> > > Hi, Jason && Leon
> > >
> > > I compared the function __sg_alloc_table_from_pages with ib_umem_add_sg_table.
> > > In __sg_alloc_table_from_pages:
> > >
> > > "
> > >  449         if (prv) {
> > >  450                 unsigned long paddr = (page_to_pfn(sg_page(prv))
> > > * PAGE_SIZE +
> > >  451                                        prv->offset + prv->length) /
> > >  452                                       PAGE_SIZE;
> > >  453
> > >  454                 if (WARN_ON(offset))
> > >  455                         return ERR_PTR(-EINVAL);
> > >  456
> > >  457                 /* Merge contiguous pages into the last SG */
> > >  458                 prv_len = prv->length;
> > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > >  460                         if (prv->length + PAGE_SIZE > max_segment)
> > >  461                                 break;
> > >  462                         prv->length += PAGE_SIZE;
> > >  463                         paddr++;
> > >  464                         pages++;
> > >  465                         n_pages--;
> > >  466                 }
> > >  467                 if (!n_pages)
> > >  468                         goto out;
> > >  469         }
> > >
> > > "
> > > if prv->length + PAGE_SIZE > max_segment, then set another sg.
> > > In the commit "RDMA/umem: Move to allocate SG table from pages",
> > > max_segment is dma_get_max_seg_size.
> > > Normally it is UINT_MAX. So in my host, prv->length + PAGE_SIZE is
> > > usually less than max_segment
> > > since length is unsigned int.
> >
> > I don't understand what you are trying to say
> >
> >   460                         if (prv->length + PAGE_SIZE > max_segment)
> >
> > max_segment should be a very big number and "prv->length + PAGE_SIZE" should
> > always be < max_segment so it should always be increasing the size of
> > prv->length and 'rpv' here is the sgl.
> 
> Sure.
> 
> When max_segment is UINT_MAX, prv->length is UINT_MAX - PAGE_SIZE.
> It is big. That is, segment size is UINT_MAX - PAGE_SIZE.
> 
> But from the function ib_umem_add_sg_table, the prv->length is SZ_2M.
> That is, segment size if SZ_2M.
> 
> It is the difference between the 2 functions.

I still have no idea what you are trying to say. Why would prv->length
be 'UINT - PAGE_SIZE'? That sounds like max_segment

Jason
