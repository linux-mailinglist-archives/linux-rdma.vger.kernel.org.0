Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC73ACA86
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhFRMEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 08:04:12 -0400
Received: from mail-mw2nam08on2079.outbound.protection.outlook.com ([40.107.101.79]:54624
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233570AbhFRMEL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 08:04:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOz3tpD89HhPhWEuCQdsiiwNIO23jukkiqFmxEe9WKe8+WLa+HlEuI9JdQB1XGXBvfmXJPB4CFlDLCwkj7QAPqAFCSpEQwsWSnf6sDsM/nBrIk6+8UNjjiiyz2GcOg06CYMvMdGrxj3XzHRtWDyeTFHeUG2YCT0jF2hIaHF1qfWMP/OJr7bMCSNmF3l03803uZZXJS43n7gKgRyapJsBautKa0nt0wHI5As8sUlPZX7QjmEbopjUtqEWHPFT6gqH02EyhhrBK0rteKG9DN2QbFjqX9TUu0NiYrfAiAjl+LlcVrr0VrsheOWM6XNNpNO7t++R8QajK5DpbIEu4LIZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QxlvtRHr1dmTm063dDgDopxXBCaHc4nhdZ6sUDk+y0=;
 b=JPdcgPOpjOO2Xt0NOy4YwxfgT4w/IRmnM6nSQ5VX8Siec1tTaeEeSeCiBMH7EzRIobq9I9XNk5qkWfe95acltCqvQOP4zaPdFqu93pOLVsajiFZsiJkbS+GrtfxG8dUTiqJkn3YJoJ2aI9Ovq+bKENBjpuzBQ0S7eQvgSk5lXwty+LyAZErs+NrtZzq8tbgZ3bUh5LNuuZzjocHA7efUbIY47JRSuHmBaEtCqOPFuDjfSepJnrMywD5mngdqQBJrRQGXWiTGkvLTTqCDCBl+qcPlEntnvPWbJ6FAqHBVIkjFGdsBnX4DLJWHhn6OpQzp8/9AJSqTQzm4BrB3pFkUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QxlvtRHr1dmTm063dDgDopxXBCaHc4nhdZ6sUDk+y0=;
 b=ROE9gJUQ3MAuUXzDz5dwD230ogmtxF3FKmRUSFMBNkc8KO77xelAo1bTFCiEIBpFacLVYeTBsdIdWkiK13z4X/bdvXKrIUapWmY7totiJ0qACaELXmxi+BfrzV8nu5LSA415iGaVC+/nzb6SPO1H2s8NFp/7RQ+cf+z4XkMucPcJjZ1yBS5SylDjdXl5t2vbuuZZLwsKneB2O8gU8Q9My560zWhgxmIFqywAqbOx5blABq1/LLyQgm2IzE3qOOcEXC6xgszlQEHYtdiuwnarpb6iQu5RJzSya1JbFoyEo1H8ATaW648apRLAlOJnsGGbuwlkN+zK2VeHuNdIy4imLw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 18 Jun
 2021 12:02:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:02:01 +0000
Date:   Fri, 18 Jun 2021 09:01:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 1/8] RDMA/hns: Fix sparse warnings about
 hr_reg_write()
Message-ID: <20210618120159.GC1002214@nvidia.com>
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
 <1624010765-1029-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624010765-1029-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Fri, 18 Jun 2021 12:02:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luDCB-008VW4-Hi; Fri, 18 Jun 2021 09:01:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ad0a9d-476f-4805-19ca-08d93250e123
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5377FE4453BF2E2E91F38B9FC20D9@BL1PR12MB5377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgJxpv+f8Z2PqXj5qoYCE8pWEloHJh64F4GSGsKZZJF1y/pKLuPHNVBA120oOGBcrK7A1YN2A5QMZ8RrWYVo0i6TlrBk1Rrpzdt7Ci8oYUooxE91Gu0qDxSN6r8uZTFq1Nojt07lAV2zVRZrKOjM9ZDuFugeywuw8wzCuYiKfGrMkiTEgRsJqlky0CouHRJIL9tQTjVou0pEEQ06KSJ8TXCt0MHTNVg3Gnd5yotWLZgKOLm7nyPbXmjary1OYUa/rtSKz01aSt0LFDiSzZgTdWQGHbwrrn7R/vEFiPN7/OZVvYhJZaA8Iob0Kc1Cu8TmFIy5xYAEF6Is6pBczT0LPI8moSeDK5Mc7uPsGuc4VfJCChv0OqMFMlaR/XXWg2EKcXz8fRkEWADGnlwVmXahws5rkAsbubRmIkTOcXEA5rL09NOOLq84UZXzRIk7B6V8fxa5pj5KoS3kOe3rJW96g+iqwAGzvPibJMIDZ8PQvH9L1L/Lvz0GFWULNWW55LpFagnYBEhJ/QrFi3gGz2w8X9Yecxye1lsfaRmMUYBgEEqGX7F0W8wPSUcWYIwivnElAvDv1FR3SYW4GTtoISs13HxLXx8/5F1dGoXC/NuGWdlYmgYJwbbAbfm4C2oC7yl1TUx5oyGJHGCBnNgn1jqvIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(2906002)(6916009)(316002)(426003)(33656002)(26005)(9786002)(8676002)(66556008)(36756003)(38100700002)(2616005)(83380400001)(4326008)(66476007)(5660300002)(66946007)(9746002)(8936002)(478600001)(186003)(1076003)(86362001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tY3/aqVTTrA4BAxL/6JakNMxZcK/NbD+r/qlZjb6+6xzfl2Ub7M9UG+n6Gx?=
 =?us-ascii?Q?oOBQNSykMLdPeTBJPf7CVLDo0dIz28CxfpxsSrs3YkUU7jFhehvIAsF/Ebae?=
 =?us-ascii?Q?ftvRx2TRnqPFHKLMYAhPQ+xwzSWCGvbpRsPbVEGxB4DFTL0haaykxZn5eK4u?=
 =?us-ascii?Q?PFZDWuQtHKweqaaulYwwfJPXEMY7ko3a5jLW1ODQnm5u0wWjaKmtZKCiSorL?=
 =?us-ascii?Q?IaGW6jwGeOT2QCRbFa7eSz62f12yX8VGpWEw2NkUfh8fjjV5ivx0o3EA7XCI?=
 =?us-ascii?Q?vXVo0ABoRhr7w8GUklxMBc+Qk5c+X5x+UlMdLyCIwjVkcFyAuNrJOm0Ch/pg?=
 =?us-ascii?Q?PXlAHRHwt4WT7tJUSGz2lBaGf8cCX7VL6yo0Rn9AmNpMb8qNMhRZNKWgDH5z?=
 =?us-ascii?Q?TMJukQzXhQ/dKMpaCTgVP/0BMEijsGvij4g+ueXSecUEaiRh7ZjlgoAqYG1o?=
 =?us-ascii?Q?N4pTDe96OAAoriipQVNGdgwonLk4G+cg3TnAaOAgH2PXXFewWnvcwQuYtqrd?=
 =?us-ascii?Q?+6jLLBD0p3o8UCiosdwzk8IYy8uTKvQcIBE1uMkxKpS9BjO7a1veW0TRUu78?=
 =?us-ascii?Q?0DFEcXf4GD3dlSkoBNqZDr6sA6U9vynrLl7GXSLpFVVaOh/2MtachBODUem3?=
 =?us-ascii?Q?O2p7a/O3u3CVr751WbiURzMRmOL6OOgk2jeeY69aSFMgYwSvCC8p2STkBZJS?=
 =?us-ascii?Q?QCv+HW1pYMwHPGnyFJr9KiwV4R+fTj2/xev6GQjCnzpqAAhAE0dwJq2yctGN?=
 =?us-ascii?Q?Qfh1NF9RSFpd4/bGc3fEpDf3hPFlb8tgz5oQJVDswkXAwVhv17TO4RSOpCOH?=
 =?us-ascii?Q?d9N8N3eZbzzo/gM8Ne89ZbLJV8yqkRg40ZUnU28umj4DSDCXitOEhklYUrEE?=
 =?us-ascii?Q?gssRDus7dAQUd+tY4nvE1fWZR90ahQs2tSoHstooRJk0Dn+dqpBaNSnw05gL?=
 =?us-ascii?Q?7jIJwX3nzS8bkV1TSy3DGdOqMkaoISPQ3NCuxdbc7LH52g8gsa4lcShQ+pJr?=
 =?us-ascii?Q?YqBbUpkmDVphxSfrObINN8qJTGGB89iA+ExmIgHYnFBZ8YER0GMJ1FGK42+L?=
 =?us-ascii?Q?eYHPTcVnkCKbU/hHGu5yAjt9EnJZR4qwsmtkGK7FVwJnDo0qUzyrjP8k4H53?=
 =?us-ascii?Q?P+sFeIWugggyU16WoqwAdUHZT/En5G1vU2yIS5fphBxofnrqSHIVW4pMTNFd?=
 =?us-ascii?Q?eYXWy+YsopQ0YphbTGOLgWEu2zJuhWy8bb88wYrQmiiBITTzn2/3Lj3lq0Iy?=
 =?us-ascii?Q?36ctFuQa8nS8Mrb6VAy9xSzqnYEy00JcztAU7gdRkdReXqCesRn0ypTuy6Ey?=
 =?us-ascii?Q?RI2ZjACF5x4NTxWjOvbeJ6jj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ad0a9d-476f-4805-19ca-08d93250e123
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:02:00.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EmcqhOC2J7l5XOG7zZM6CV3Zoi5m9YfaliqPYHfOO3/n4dhgMY65kx7kQGY2Bif
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 06:05:58PM +0800, Weihang Li wrote:
> Fix complains from sparse about "dubious: x & !y" when calling
> hr_reg_write(ctx, field, !!val) by using "val ? 1 : 0" instead of "!!val".
> 
> Fixes: dc504774408b ("RDMA/hns: Use new interface to set MPT related fields")
> Fixes: 495c24808ce7 ("RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC")
> Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index fbc45b9..6452ccc 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -3013,15 +3013,15 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
>  	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
>  
>  	hr_reg_write(mpt_entry, MPT_BIND_EN,
> -		     !!(mr->access & IB_ACCESS_MW_BIND));
> +		     mr->access & IB_ACCESS_MW_BIND ? 1 : 0);

Err, I'm still confused where the sparse warning is coming from

A hr_reg_write_bool() would be cleaner?

Jason
