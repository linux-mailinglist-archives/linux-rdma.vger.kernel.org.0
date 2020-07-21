Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2550F2286AC
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgGURDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 13:03:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16683 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgGUQ7u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 12:59:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f171eae0000>; Tue, 21 Jul 2020 09:58:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jul 2020 09:59:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jul 2020 09:59:24 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jul
 2020 16:59:16 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 21 Jul 2020 16:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8HnjMslH/BwACHN51GLf0yE31T/wRpQVq4SJhB8AiUv565rxFd0wLJYwCKyCICQCvU64KmFe9M4bnNVYXzZgZgT7NWkgUaLKSAvDuNORlmbHUdMgll0xiw+Qh7Iwm7hx05iYzUwTmOoBOX3OI3LTi1WTkT1Q9a2Dt+6hTOsDiqxZCSpSsAkbPqOJbi47HvdYUgG0bOvCR/3mupmX/oESTC0/BHB9lol93YqVv1G9vthFgUi1l8nLbTri2n/bSsA8BnrAqrELb4dHAA346L1xyPmB4MXdPz9d6yJ5PNmOWAoYq1rDWA9YvsdfpBp+p918ERS3soSjzuHE5N/jXmi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvuJtgyV2YSvmMk6YoZmcja9vkPBUJLVOBpHWa6nxek=;
 b=GD23tI1iW4GMRPQPNdeQ0s9GybwVuI6/62CSw/ogJ4Ds1IMf0RDI3ZVVBA6nXDC+uUr0HS827marVsekuIppucfTXo7RmJQs+FEfcak5GoAjdUGP/G0Y8CYlnAJz8HC19DP00G6oTrvjw04IKTPSff8LS7ZXNUaF7oBxqJGm8Ra0fmP07D+GNxtCk1X/j4TivdkL3dfWdj8GzazjoDgNJ6VjwErYrGEC8ZuoeeF37aMgmlNQ6QZlc9Rq/upsF+xCdO55xya0NpQqqsplK3cIJ0TQ4Jk7pZTR+NX2yw0mVdFUTSBVlzdb1c9332pLQdm8jc0+7O6VmUbfXkWAdFKGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.26; Tue, 21 Jul
 2020 16:59:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 16:59:15 +0000
Date:   Tue, 21 Jul 2020 13:59:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Prevent prefetch from racing with
 implicit destruction
Message-ID: <20200721165913.GA3171161@nvidia.com>
References: <20200719065435.130722-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200719065435.130722-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 16:59:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jxvbl-00DIyU-RY; Tue, 21 Jul 2020 13:59:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27d1913c-225b-439d-784f-08d82d976628
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29371D392E02DBA43EB7272EC2780@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9QJbE/wLEk5L1FBUYPJgy34o2eaAeGMA4NHp8/p2GDx8+diheauA90R5WulD04HG74s8m+0NCvlhJn7YmcerC4H84IrYAaNZzSXvTVlElh3bCCbTExLyUFShH6tIMqF05X+GBcedO6EKdI3mUuOdqmgC9KlKosP3lGtCf7wrQSuP7nLARfZiGprxK2D0GUoqqOa5RvOb4VeuPPpdLJT8WMWKkh2ufrGRI2FjW4OHYg5f63MBs/MpeL131IyTvGU5cIbrUe9ybKr6isazL467p8fNJb9UJxg9eVm7g+2vu0BoSkMVGyFxPvWyJete9YDECGKK0GRKxElvK8rrRlBjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(478600001)(6916009)(36756003)(8676002)(186003)(66556008)(66476007)(66946007)(83380400001)(33656002)(9786002)(26005)(54906003)(1076003)(426003)(9746002)(8936002)(5660300002)(4326008)(2906002)(86362001)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XtLeRlCFDKOyhCj7OY9AJEb4AAyM3w02Hb0siabwWmh8CP7FDrrDNdwXtdq+E6hCTgUJVgNYFNay9m5k6va9UHCzQCG1wgRnMVKF+v3PaSWXcSnNMCgIMJWEVigc/3Eu4eGerNwL2uQYx4DCzfrw16JjT7BTiK0n4g6wgXyWTWNhbu9EImNmQ1Wyfs3BTMmOoGIjhKcsd9Coer33xJHjLEY7hAZgxBmMZH/EzRgfCsPM/OnlkARq6V19azn7ap1mG9c2o4lExfcnBCOH482fb81FSK+Jba0ZG2yZgjgvUEmAMuXp4K1LH7lC9n9cWW3oi40nia4xs+BvhgkxbcWcCN8Pd8DqkvKlDbxnLByBebTZV7h/1M44BP1YcADXiMUqwis3xcYYIRjydjQK+vL4wx20Wo3oQytkTxEXpFePTwEoNSkdXEgfx6XXZ49lxJo2rw59KhyphMhepYjlD9PxAjDFYnLc0rl+41qdoGQL0aI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d1913c-225b-439d-784f-08d82d976628
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 16:59:15.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+ZtVS47W8XKEIHQaRA6QEThB6AXCMf8st14oSLItXx15FvXSnU0jUkCUM4qvrfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595350702; bh=lvuJtgyV2YSvmMk6YoZmcja9vkPBUJLVOBpHWa6nxek=;
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
        b=j6h0Y40wgqttGkMKYskJV1hdXXFVH8DNbk4VDUiMHlioA7TXk3qSOvmCmWRkaViSy
         OAVlV9C/gX7h++1S9+rtgsl/8apLKHOBHakPOvmoZSDk4cT+M3RUUjasqIrDBZ8U/w
         W+oANhgtMWkrumGJGzygjxR58sdsmKWDmZlgtJpJ98PKogOMmMC+yeRwl4bdUTxNge
         YWJOQb6vzTZYCQ//QY6k/fXn+qKYGIDhRK/hy43DJ7YNdcsxb9A4V1xmuiU+siw7wx
         m3wb07l66YzLStTOeCPlG4e90Dj+HUZjaeDJZvng6ddi6E3F/z0omBw0L8NjrR/b4j
         OT0CYnjPVOwnA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 09:54:35AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Prefetch work in mlx5_ib_prefetch_mr_work can be queued and able to run
> concurrently with destruction of the implicit MR. The num_deferred_work
> was intended to serialize this, but there is a race:
> 
>        CPU0                                          CPU1
> 
>     mlx5_ib_free_implicit_mr()
>       xa_erase(odp_mkeys)
>       synchronize_srcu()
>       __xa_erase(implicit_children)
>                                       mlx5_ib_prefetch_mr_work()
>                                         pagefault_mr()
>                                          pagefault_implicit_mr()
>                                           implicit_get_child_mr()
>                                            xa_cmpxchg()
>                                         atomic_dec_and_test(num_deferred_mr)
>       wait_event(imr->q_deferred_work)
>       ib_umem_odp_release(odp_imr)
>         kfree(odp_imr)
> 
> At this point in mlx5_ib_free_implicit_mr() the implicit_children list is
> supposed to be empty forever so that destroy_unused_implicit_child_mr()
> and related are not and will not be running.
> 
> Since it is not empty the destroy_unused_implicit_child_mr() flow ends up
> touching deallocated memory as mlx5_ib_free_implicit_mr() already tore down the
> imr parent.
> 
> The solution is to flush out the prefetch wq by driving num_deferred_work
> to zero after creation of new prefetch work is blocked.
> 
> Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
