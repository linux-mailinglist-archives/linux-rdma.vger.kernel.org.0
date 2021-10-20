Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54A9435642
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhJTXFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 19:05:39 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:7841
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230361AbhJTXFi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 19:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjnAHw/KVEeZVnAFdhirDcnZR1kgIb6LtsESCEfA0ABFK3OZ6U09Rk8yaAq0IDvkdDnrP//vaAsEVKeTCC+xNiTrlFmCgKFO+ph0/BGp6kqoq2ksgQRxG8NY+CnXf/v6Dls3NAlxM3FZvq3hvSC8mUhpdZCyRnZLSrkkc6fZ3Pi5TSWnyp5BHtNYJA4+w/PLxkURFciyTCNiZNjn/44WrkUJjdHGdwyjJi+k1IdnS0D7lGYqem86HdW8G4ColYFlPRNssuYUAo6+chgQgslhLvqoO4FTNHZkK2hw25EVB8z7Fl4QHPg030Wek2GtKbSB41nuJGuxMASL1K9Vcs4ZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGFKYttP8VOHeUqo48jPKdESeVSN9ou3O/mygJoL5XM=;
 b=kbuIVAaC0YbgtWOWfLYFFnbfjqLR3ZRd09Xzrfwa2ZsY4d1h5sPS83E2R3KHyZ/9Mq/JK94Un6e/zZra9Cg9JsAWlRiFCDWmWZMcG++rd1nKdXvMBD+KeyH/ittZe1ZUadio12r6wyyixG9N4+6WX1dAS5TL3xVV6SzvL7bRImGM2n8C15wUWstEOLHKjMfhU/odAVPhmxFzZccpff3nbzyNogm+mKHQwlDB+yoApKJhbmOdgemqmNGknXVqfRes8c0iIFrNCnGB/3cEO6i+2kkcIQvyOqfb6aq75ZqC8axlgskLuU52pFGrKpnl1ahHOsyL9twTxf4X0EvENpuRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGFKYttP8VOHeUqo48jPKdESeVSN9ou3O/mygJoL5XM=;
 b=fkDzEaii3AVwqUKr4vM7QLsrhCwiMHgEyurNUbkjBIQkV/uOnvdpCqLoZdI4Sn2NKAH5Ay/8KEn0zAzxWhiQDw640uUi6aAuunnTFVis0q7EO29U6W2g5uxKC3sz4pmTeZUjWp0J10ZPZyJWc0c+OZdRz3Alfbx8lw4g10XTTSr9Aq4NwMu3OXcr5CLEFKzIt597hopt+T+inFjWHBtJKTyfone/fGeN7/3s3dAtevREVE+InRX/OYmK5rf6C06ipPc2bOaEHWSa2ZIpPFLEZr158OprdsIv9sJFWH99jdvpEdmPfgllrQOT1S8E0oNucRXd3MfbyTHWBsTh2LUe0g==
Authentication-Results: e16-tech.com; dkim=none (message not signed)
 header.d=none;e16-tech.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 23:03:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 23:03:22 +0000
Date:   Wed, 20 Oct 2021 20:03:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     wangyugui <wangyugui@e16-tech.com>
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        eddie.wai@broadcom.com
Subject: Re: [PATCH] infiniband: change some kmalloc to kvmalloc to support
 CONFIG_PROVE_LOCKING=y
Message-ID: <20211020230321.GA27337@nvidia.com>
References: <20211019002656.17745-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019002656.17745-1-wangyugui@e16-tech.com>
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 23:03:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mdKcD-00078U-JI; Wed, 20 Oct 2021 20:03:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e03aa409-cbda-423a-afbb-08d9941dd089
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5363D2021ECD4BC65BD657DDC2BE9@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMIW4OD+Ot8hzDy3B+L8XBSc565GiF5Ph/+u6mvFZsNDnGzmvgZ5bp/OzD9ZEYjoxRD28yJ1qPiI4pG02pK+UJuR104ISglGJbMO5KkPZZpvZzL2NK+Utisr5LIVraxphfkrutxx+2o5HxUYfwO+cTWi0kf761dnxrPekGmNYsfrpXrkWUOu5zQYH+ldap0+2ex1IZIUl+Qk9kttZtA8wKWr2AGcxRs9+RtEo6mS23vfNreVvjnONBw54yex/QAc4SD5RQBjCjljEZWheh/V+wPeMlTwTGar8E8yjSWhvYPq8uX76kIGcR/Ysoo0HcBGXZS/Fl7XopQVQPQUZUbtyoq4Qxz1OA8awcX157dSM/FtR+NyrJfUN+CUgHmQMWuvgsm1LE4s+imkjS05MiKbi1XPD2xIkWi9FqZ4h+f47cHRaoD05wNme1hZchfhay3tt67DTrivF0Jk60cSb4FZgYp/5XFGEtCJ4o3Z/uwSRxtIMYLX+YjDYPf8XBjwa7Fa8RFoHv2tbD9cbPP/ncWEmeBk8YFFkmWtH784VevdoAVS1/E+ML1x3uQi7QKKOTxes1VMjM6b15cwDj1XrE0+5lazGQhAF3jYcEUl+xJl8UtWOpyKA+tJmsj/jf8Zs0fzcbumZ0cqtqa9LYHtz4O2hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(83380400001)(38100700002)(2906002)(2616005)(1076003)(86362001)(426003)(316002)(8936002)(4744005)(36756003)(186003)(26005)(508600001)(33656002)(66476007)(4326008)(66946007)(5660300002)(6916009)(9786002)(9746002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSSTbfS9t/iXhIePX/JbTv4FRKsGQdBYz2K1/4lWGo4buCRwy3k9+4tdVx6J?=
 =?us-ascii?Q?34gRSY4qjrGLndBwJ2Mblewt/AxQnjHGHnQcSLhQ4xV/gah1VZNZZpLIsnPC?=
 =?us-ascii?Q?hTiSzPW5DAh0bkFZmo3a1Wwu2Wz/JCGMCV19NObivGlWJieHxTXRlB9ISXS2?=
 =?us-ascii?Q?FCw8RDECSw0/cldMJtCU5V8VAtG6DlyVMGHHIweOOkMrKOSIGXjx7wL63Dg+?=
 =?us-ascii?Q?ZgSAwxPkRxAOua5bUivnkoe3J7b7R+53tqDlQ5WryMBikGO8805KYE9smIMd?=
 =?us-ascii?Q?8GBcGn6+WwtJ+vmDApsmXB7T45kj6t5LpXH+AplIxxZtzCunKUyG8gb1J6Q2?=
 =?us-ascii?Q?N4lVz7b9otqO83i0NZ4TUcMbFoJZbKFgVxby49LBWORPObMFgTmUQB1ACGQq?=
 =?us-ascii?Q?xkiVLTg5iKipTKfgVooVmATU69AqP0XJu96o46tCuHzWUX7aHesZJ4+GiSYi?=
 =?us-ascii?Q?K/xAfTprQ8K/kfVxR74ibfUjtqDyzUyc/ACKMhsjswrCgXelHN4HTtewXQma?=
 =?us-ascii?Q?4bln1plG3Fz3AfDohw9zibguODThQi4S7VHrLrf6bqA3thW+h2AgQ8/cIm/7?=
 =?us-ascii?Q?v7hQqBsC9fCz8qe+aLA0UnVXlOWoLg3MSHGjq2glaiD+zCKEvUWj5sBbYfcg?=
 =?us-ascii?Q?ZekPESBD8Z/Lcjkr7P8g/aitykUAIFn38MN+2G4ZWhEu20kSqP7PiocHfXxo?=
 =?us-ascii?Q?/2YBvSRkoIr1kh5D+LVWXXsvnQwjy4vshL+Xe7z+XAD/aI/3vzqZfRxxqCrR?=
 =?us-ascii?Q?2uUutREfV1j++VbpcV6n5BcCsbkYtAQY8NVXVyILT9c7tQ/CRqKJUR1iiyHZ?=
 =?us-ascii?Q?YpluVCfVf2dmwqBMLrKzRedk2wbM6bRXnq3PcYvORb3NTnHlTJ4S+UUexOqC?=
 =?us-ascii?Q?7D6TGLoFRQsdid66+UWLxy3QY3R5bvjUA10Zyu8SLbKoazdYHjR3q/cZJfha?=
 =?us-ascii?Q?SIMMl0ys/Xa7eB/W4rM1VEcnZtvygpsEA9Nv7yy1PL+TB238l+TLoLKDl0ut?=
 =?us-ascii?Q?JgOLuO5kZ10iRZHFV3dcVpKOKcsLflLATHXL3O+L+bztcD+0+KwwELdIuo0v?=
 =?us-ascii?Q?eljrM29d3Qeahwpik2PsFlOSe04UdIo550LfuSfOkHtLVzrABwghjis41WzT?=
 =?us-ascii?Q?Hj+okPwMKkIu5aR1/urYayTrQ2mo5Z774ERX1o1kSfdSD9Y17cUNDJYjTQrB?=
 =?us-ascii?Q?luWkgBI3DCWJPTlkvffEvqGhHzmDD2w1YZNZMF1/XgNbFSeo934FPBM7pVxG?=
 =?us-ascii?Q?0+kqTfpzFsgTqX01PP8JuiZsh7N393tjqMg9hq1OzOaQQ1ho+gj7f9bKq9lJ?=
 =?us-ascii?Q?K62NAkpyKjn1YL9qZ7exdpWtqvR5BVLAQj0nyGcGKTi0EnZGizBp4WEyQzrd?=
 =?us-ascii?Q?nAIVwAsUELQBEUF06Ei1008uDir62fXo7gbtwkNokaJe18RDNcIGTHFZtURv?=
 =?us-ascii?Q?i9adqo8qgYA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03aa409-cbda-423a-afbb-08d9941dd089
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 23:03:22.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 08:26:56AM +0800, wangyugui wrote:
> When CONFIG_PROVE_LOCKING=y, one kmalloc of infiniband hit the max alloc size limitation.
> 
> WARNING: CPU: 36 PID: 8 at mm/page_alloc.c:5350 __alloc_pages+0x27e/0x3e0
>  Call Trace:
>   kmalloc_order+0x2a/0xb0
>   kmalloc_order_trace+0x19/0xf0
>   __kmalloc+0x231/0x270
>   ib_setup_port_attrs+0xd8/0x870 [ib_core]
>   ib_register_device+0x419/0x4e0 [ib_core]
>   bnxt_re_task+0x208/0x2d0 [bnxt_re]
> 
> change this kmalloc to kvmalloc to support CONFIG_PROVE_LOCKING=y
> 
> Signed-off-by: wangyugui <wangyugui@e16-tech.com>
> ---
>  drivers/infiniband/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
