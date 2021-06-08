Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0EB3A07C1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 01:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhFHX1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 19:27:22 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:25953
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232208AbhFHX1T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 19:27:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR0xPV8ZHbldI/SIYaxSi2BtHzuGlJbS5Jp63Mw++4pLAP9ETaTJWtlkvePJ43fs3QISp+EU9Pdc8gyQnL8nAHOnhNByJxMGMyDkhqIm0CU0egaqwdaY7J4EsnIMvCO/FsmN07MycFuQAnXLmmjDxkEVTduADrl5euwg9z7GLub4WTXXvns/4duHIltJPcGuCGuhDr25OdG8QJ8fv6srDeXIBYxuSbs4fdDZywPuGkI9YC8lFUADl++aUvb821c8kYl8DYxGpJWWzsw6n2EcR59DDogyLmMGeYEPn7RNnaWI9fI20M77HrdSXFCsFGnWzNM4wUTZK5t8+GSSRfmNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+gaWBuoQOYqNcRnwqu6XPHjzv+L3CZaAtGcJOuyF3c=;
 b=DrvirzGKRhzPWig2R4mBea1ljqz+Ydawx4ZtRA4aTm6ZfcxkoS4fJN2xhtSuOlVCiIoKLrvp+qkzJredl+M9hlDOd2eE8nHkAwdUjRMMO8ji1Y7HDvE7hCBi3F7Cm3xDrbSo5S8V4gz+DlM4qkXARxMN5V1px+0YqscyUUEEy7wr9FlkxEHKvy9EZro5XXT/NTXIT8P5RteasD3Jm2QrYoWS6Ul4LZyG1ZnaTFchuA2ut5vrPQe9xufirqHIhAuPbqCQWrUpSKwGxfqYw3PiKFRv+Aux9pHwQ55QZRJm7tnlQMhkQMCJCcwCYSbEP0CN/tTGi//LglKeTvIjqSrFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+gaWBuoQOYqNcRnwqu6XPHjzv+L3CZaAtGcJOuyF3c=;
 b=PfwSYlOorwYTP4dHw/Nn7VYsI7BbUv78MVBhNcdFm8jPRKpFRirNT2zxcsrmKz5nz+K7tUNBRtmoDGCfysbsLZY125fT+8qgHB3/mKpJCcWbGmSilQIPQ3cL5Y01eRKvgXTPhYh3wHpdzQqDrSLYI+GlxI25bpvOT2g0w8y/bh7FHy3NtawY+jj/WjKKgFTeCdkNP4/qjGLr/SgM2Wyioy2waxUsPA6uR6s3K88Nn0wf6BD8k4GAKV2tP8A/0pkOqBXhi8PT704Fk7+SK7GWT2xJM3YzBSFSx9EVz7mOu9pyxye7EMtuK0GjBGDq+MJ6RA4ltsfszgnbXAbIbgt3Zw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 23:25:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 23:25:23 +0000
Date:   Tue, 8 Jun 2021 20:25:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
Message-ID: <20210608232523.GU1002214@nvidia.com>
References: <20210608211415.680-1-shiraz.saleem@intel.com>
 <20210608230448.GS1002214@nvidia.com>
 <8d892696e01c47998b104579f489da25@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d892696e01c47998b104579f489da25@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Tue, 8 Jun 2021 23:25:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lql63-004JnV-0m; Tue, 08 Jun 2021 20:25:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34df91ab-7eb5-492b-be61-08d92ad4b0cb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:
X-Microsoft-Antispam-PRVS: <BL1PR12MB522301F8E654E1A82DF81E7FC2379@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2oO5HGXubB7C+HaQBU7RS680u8fu48ff6gU4pDhEdL2dK9aA8NXV5ExowEFURV0LdOqF2VE45AbFKIZTDWUmRoVeEBPubRbDilPZc2C6i4POFFnC0LQpIT+iPtCBnZ8cbqb/XQN6QkWcy1fmkbowqMLfXeGAlvp2yv45Vak3pUoioHPaNUqvfLuE5c/zoJYIeSc5nu1GTNO7aUn8X5xyS3FCtscXjDcZNMl9j0V2fkE9qNLXzBU8i1jSEh9VFTgtCjcupaCawPRuI20wLwEjR9/xY/GqxL05hej+21Q0rZTHxvan2cX2J05nGUWT1YICyn6wP0JB5H2/mttt/mp0wvDjTxgb7+Bn9g2bPU8SUqA2y8rMAqLwg7xfbi2u816p7m4TQBihfi/6/QBy1s94BlB5/p0NO3z2mDZsy4JSlfc0bfNiy3x53NpuJjWbv5oNzYoxksUMMvpGCKpNrmw+MihYg8Gsp/sj/jtKLCIR2X43ZQxSoKtjTYuWsZCA84kpRSglo4DTmFIAoSXlY+WRIApLIPYTbq/VDchcmAbaCKECWbUzs3ZKH3ybRI4LMU2rW+56eGBOicU7mvpwigKEHAKSHashpPRIlKShM4psbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(86362001)(316002)(54906003)(5660300002)(33656002)(8676002)(38100700002)(1076003)(66556008)(66476007)(83380400001)(66946007)(186003)(8936002)(36756003)(426003)(478600001)(2616005)(9746002)(4326008)(9786002)(6916009)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/5wzoX+NJvEzKmvbW75vFzbxYFRQHev3PDNZfniCthq0nfkcdThQ3xrgaLT?=
 =?us-ascii?Q?X1XN2h/wNFJmn1b+bL4vozbIhDDTc7FAplglY/oCCvyn8Tj4V6WbWqf1LUVt?=
 =?us-ascii?Q?UNXjEfR0D9KZFtf3aTuF1ZH0QWvXdLIzlV7QFMnxYC8u0FfbCAdhtyLF1Njw?=
 =?us-ascii?Q?82ZzGfwtmHuog5Oe+HAptKOwXtMQt2elWzB0jojckjgptWvgsRZgUHnm9HcC?=
 =?us-ascii?Q?8398xotCo9DVYvie9M3bLOMYM7XdCSeV9zVbIhYmSbvKS+9aJuGNEXWACQ8/?=
 =?us-ascii?Q?/Ekj4X/xoZ/OKwjadGaeBq0E3BgVvAHZSOF7mhdqMAMBefM4XpYE0dSyJ7x0?=
 =?us-ascii?Q?m9BC79AqBUqGbOAA+jkkkRjhhbwKiq+8xNZZugLuqq4Byg9+0fUEsgkTbDdP?=
 =?us-ascii?Q?FHkTryKoVNgeFn3/s91R2ol+jTpHCsy0omfbzeYPr+o8p1wtJasWkd1EW05u?=
 =?us-ascii?Q?jT2zV2uYb5qYgzMZxknke7yt0cY55My+R6hZrikPftOHdbQfeazbh48BxbLA?=
 =?us-ascii?Q?e4+OqL2/8DFI1911uFKzwVGky9RYUFXFhoWHVrfxofoI9P6HYvTew7JaC/TO?=
 =?us-ascii?Q?J/cg/wBEL8mxulJLIEVKCCshM8ppk2XSVHlIzWgYl2y1wphNNrDbCQJxgw9f?=
 =?us-ascii?Q?jUomuoek/VAB2T7jh+1Wz7BVlZoHOmYQJmdc3sshd30apzHMQvTxl5s68GlL?=
 =?us-ascii?Q?aJ9pKThZfGmpJgxZO09/GE+3uZWi5/CGzLiJCXmpC2PIdn2e4gP4MQFzzwgo?=
 =?us-ascii?Q?RERqXuOYp7dogREMZQ35lExq9ylUvh/jfDYNv1AzPAkSxQJ5bT/1h/A6JkIz?=
 =?us-ascii?Q?nsDGii06dyMx2/sjNH3hiZBHV2XQaLguLXypHnp8z7mtXP93yRLXdpwWdtT5?=
 =?us-ascii?Q?VWwKWDnrxDYqpjDBLvE9K6aErEiC1EjjpnrV66Wd36tD3O+DCrs7QB4mMmV+?=
 =?us-ascii?Q?y/AzUZGFejxzbB6smyyr6B3lartSn6Cksqu9AxkLJMkDU6FP9SL22ldXr7c1?=
 =?us-ascii?Q?R4R/Td8To3x2SSPhi4kvNTjMD0n1BjSlXP52Qzq9ZNHGaxx3tJ2q3CEbs2Fn?=
 =?us-ascii?Q?XEeRbDjksDDLVNPX3Hqoo/g272Hhq8T3j6nUOToPXA/UlMV/RdvPyUIFmks3?=
 =?us-ascii?Q?3slnwQw+pjzAs56LUGcgWQLLn8ZVPE8NtHwGXlnrE4J3QOXqpn836Vn+BJTR?=
 =?us-ascii?Q?ZgSmiF5k/S9se66Dy6n+Yjy2bvVkIUyTlTohRcMPWbjD583ELcJyPQyE5LDa?=
 =?us-ascii?Q?KXVPJxp6kK53sguErTfLBGrwL+6zHGNFe6/15aPDSr6laPTWsfMxBoBUvCL3?=
 =?us-ascii?Q?1VgQuX6/jfyix9mq8HBDdvNz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34df91ab-7eb5-492b-be61-08d92ad4b0cb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 23:25:23.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4jp2defZ0CqnMBO5hZl/Zh+qSZQkhZU2ndMsgfmGF3Ek8dOe9vjBIt/nDW63nj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 11:19:58PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
> > 
> > On Tue, Jun 08, 2021 at 04:14:16PM -0500, Shiraz Saleem wrote:
> > > Use list_last_entry and list_first_entry instead of using prev and
> > > next pointers.
> > >
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > v0->v1: create patch on more recent git version
> > >
> > >  drivers/infiniband/hw/irdma/puda.c  | 2 +-
> > > drivers/infiniband/hw/irdma/utils.c | 4 ++--
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > This still doesn't apply to the rdma tree.. You need to use the exact rdma tree, not
> > wherever this came from.
> > 
> > Anyhow I fixed it up by hand.
> > 
> 
> I am not really sure what is going on. This applies cleanly for me
> to the tip of for-next.

It is git magic because you have the right blobs and I don't

> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index 8f04347be52c..b4b91cb81cca 100644
        ^^^^^^^^^^^^

This is the right blob, but the v1 from before had this:

index 8ce3535cdc21..81e590fb77b1 100644

And I don't have 8ce3535cdc21 at all. So git gives up if things aren't
a perfect match.

You have 8ce3535cdc21 so when you tried to apply your own patch it
would have done a 3 way merge and fixed it.

This is why it is important to actually generate diffs against common
commits that other people have because it allows git magic to work
properly. Even if the diffs are nearly identical having the blob be
correct covers alot of sins.

What I tell other people to do is publish everything they send in a
branch in a git repo and I then just keep a local copy of it up to
date and get the needed stuff from there.

Jason
