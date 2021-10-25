Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1716439DAA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJYRiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 13:38:16 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:54177
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231760AbhJYRiP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 13:38:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enkwa/YDiGOIg7DIm7q+haNVUY3zVibM8v0L6NYlAKv4/JUKj4cA8TW5wJDCJRQkuQ0oQcao1jxF0sjXwbZRDbD77m9Mn9GEQTkqGQSTdgUVlPbEhR2A5yytd4qbxvymFeOJtPg1lwURmA5wYt4foke8qChT8UaRnfCG25JmCkQfkqR56khl3JXM0+NJ+rN525HSmoYvXIZcx73XQJQXnmeerHSHjKbC3uh9ix6YfFWkXsor4gTtOj4oPjonmEc734+MOA9jW3nzVAlc5MaGWKc50vh5NpajSX8bSSrCbJjXbC/mXRygFG6Q7ceaJJ4MdG6lcc5m80jMMHQjQHGY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vna5ZrGY66FNgXsIiifcCjaN8Ebs1hLAo0UvPfo/Ufs=;
 b=mAry7oig5Jeytbv+b9g5MwpPZw15fUSbIZ0D3jUHqRCT3aiTVIIrXfCPmjkYu7QgaboUJ6V2jb5YBLitJrf1vLGTUykGOjVnD5E6mrsdJzCHI4qpIg3kjT9N+20s43s/R53oatfmeYMXl4CBgNszI/F1ZlLmdVmi+fE+Uqbvvbi8xfnFA19SfBcZuYSSNVikKOAC5SaduDVNfVEJyzEu+XqG1wvHyzswGsJlaUddwhlrC0TB4mHaxJqiRt9b6C2oOWpsQwJNGACAnhFQzrkpts3O9igN8rdInPKTsdw79v/ZuNvBPrU5W1+RZ6RXGFCOkEQJ3QYLMZfYiq5lEEmnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vna5ZrGY66FNgXsIiifcCjaN8Ebs1hLAo0UvPfo/Ufs=;
 b=drND/l2gAYvv6R+eFuQBjodQl9NNK3cASuS1DSJLOEgkgoBlVOvRv6NFKLVuDtB91UJ4lFA/qLMNnZ2/38Aaupewn9yZ56jzfHBnubVA3HdiZddSyAmfDWzUNOfkHpYBeNVXG5Oh5fiCmykb7qBu3Dm9lUQlG2dsOt1aUUsO0PcD9CeQP7B4fzfAeYSHUe6ROT3EbmbBVKSuZ8bqk+e9V7JVmrvfOHycbvTiRcSSiIEqmj+MUTBgt8eT2D/fDNjqsX0DWPCInt8jL8HU/goIVRnGY3odIwt5FjqaZeNE0OGnu0mWInNYWA1b0Jll7uZ5hQRi+eSuopQFJ0EL4F5eyA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:35:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:35:51 +0000
Date:   Mon, 25 Oct 2021 14:35:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Doug Ledford <dledford@redhat.com>,
        Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] RDMA/mlx5: fix build error with
 INFINIBAND_USER_ACCESS=n
Message-ID: <20211025173549.GA427940@nvidia.com>
References: <20211019061602.3062196-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019061602.3062196-1-arnd@kernel.org>
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 17:35:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf3sz-001nL1-4S; Mon, 25 Oct 2021 14:35:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67cb33c-980c-489c-0b62-08d997dde3c5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53367CCAACBCE8463CEA6640C2839@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LionPNE1RUYjs5lfK4IrqkF7UqMnGhSCJzNnTv3oat8OUcc4Mloa51S06o7yZjnZQBBIE3UzBwGL3LN6vA0ZHHAQwUwwpk1oWny3cWOHMJQ+JYYuZER4+fYCgBfpImY8DB3omCn0stF20gc3jDtt26h8PMEn+w1XreqbHvyFHZdrg2H0mP8WOVH0deNvVWJDcD9Kwr1s+gMqJXkR/h2nudVwQL5bXo6rExLy5E3/rpgGvtjmcNU7L3tIDclsrC7HUpm/sMHPWXamZRHwDhOiU8ORdVZbfvFLMoZyIIX8z83pcJo7/ghedE0TdyOBr/w8IE00KOIDTA3g4d6kaAscvn5mr6gA8/lhgsGaLq+C9dmuJrPQlmgh6lmg9Hc4ZfCTbsLk1CAka5dwHDhKpLOzr31xFLMbevuzUsH/CXUOgyVN4eYv5x3BAeA6B5k7QaY/G/OWUMBF2P25dx1dBan3se1it1wP6U0fiqcBMSAYE/DJbbMuRhkzkUPpPu3k4toi8iXmCqHGnxqa/4lyGhvmY+1zb+gfdVGpQ8zYR9al3iYrx1scxTYpU1aGZm+5JAqChdnQom7PdaZA92DjQUO11hoW7Fy1jKBHU9bm8AzpEzaZXU6UXKVY614WyGIFGCjHsYZM0iXDCXDQ4SwXt17Pfxd/pRN1LxBUjcUZ5Qfsmbbam+r1zx/XT0t7MO7mNcGw2HeOJ4q2nWrZPoToLRO3SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(83380400001)(66946007)(66476007)(2616005)(8936002)(86362001)(66556008)(4326008)(4744005)(426003)(6916009)(26005)(38100700002)(33656002)(9746002)(8676002)(5660300002)(54906003)(1076003)(2906002)(9786002)(508600001)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVZ31BS4W6+2muJJpA9oWkcAwXfg2cviL0DmtLsFvN3DAVt1Zf4xXxAgmbmV?=
 =?us-ascii?Q?4QHLkQbFpWIKtBszEKhTcvJKk8XLxcJDqg9jq1VDu28HQZWli/GrdAMjgMRs?=
 =?us-ascii?Q?50jmRC84OlXJNeMbdAIZqDEHfkdEg4Xpuho7cLJLBoGTe1cXzQSETqB0jc3n?=
 =?us-ascii?Q?/ILr8eya9R/WUCffbgj8TLgkt95ydtVZCM98NqwnolX36O9GVg5qrc8JcCOp?=
 =?us-ascii?Q?DS6X6JPBxWO6WKhMcljF01OEcE4OK7EMCKK6Ic1L9NFXC1sKGvu+hxiPlvyF?=
 =?us-ascii?Q?TWX335i2Qt6ZOCgxbwK4n74Sc8HOMxmhEoaHrXL5PyV8DJcYAMmiclocdW+T?=
 =?us-ascii?Q?27AfFoWAz4ZLbrPN4iLEbm5gQwgeqzcdKrsiv+SxMAdHZZU/2RYzTiyW9SXN?=
 =?us-ascii?Q?3ahSbRFPaQUwMe8nksEx1+X8uSR7IqwQVNpF3EjyCclk66E+P66+/sBuW1Mh?=
 =?us-ascii?Q?Z5F91TNENORpBtGRXtPRD/ptwIX+SL0jTgBVk9td5vRR2keu/KEJSBQlqvGQ?=
 =?us-ascii?Q?Y8O30Ox27NW+olcKRTJ90N4tp+5gAb30lbjX0kP/4cFD1BKTMz4UvBFAx2J6?=
 =?us-ascii?Q?tkOEUh6MJoD6ymZjyRB3l4CTRuqVhRv4VfNu1NDN+zmi/FOwynoR/pFFL413?=
 =?us-ascii?Q?wut5iUWL9X649Kp4j6X0FEv4tu3VfZA4Y0Ssb9Pjy1XuXlAw3btmBH2jJBth?=
 =?us-ascii?Q?V1vHYiijqXpXeSs278dtdyLBdIydv+CN86lPjWOsstfpGSMkZfWhvcHeD5n5?=
 =?us-ascii?Q?nS9YL8eUgRHvf+yxbIR02zcOYnnIXIAOOsG0BvnaX7wx3Ao7FMUhges4c37P?=
 =?us-ascii?Q?mWdOIENRmbqOZD3dEs6p/74Uawn3xs2EWdfFUFLY/eXKIxm1Oh67C1B20edW?=
 =?us-ascii?Q?zNEVcEhEaRPPO+cBAM7bPJU6fcbR6os/CZAriToC391IW1Rt4g7jPx7Ax30D?=
 =?us-ascii?Q?hvtVTQur+hWt97CQMo2WxjDf2hWJ1uM92+oH8Q2ZDbgMGJbT3vfV7RLeweDi?=
 =?us-ascii?Q?VJz+ApH/NE+w6IlcaHYLGqhXF9cz3NOHVkhsX/OAF6+D5q7p5oCigaSf9Oue?=
 =?us-ascii?Q?NMwNzztGwD5+QxNztqUYg7U7zHQeMdge0Jwu2QIw2djswzzGs+R45SHDm95R?=
 =?us-ascii?Q?zFzgjFmDKMV6sHS4d8GluQRg2RYklfloyhXo4aluOnW9NO6iYBOk15p2M5M3?=
 =?us-ascii?Q?E0ITTiAc1pNXAP1WlUhC4BAabyB9BegAknFj2bmmsM0UjiXQOhfxz2Zb7aMf?=
 =?us-ascii?Q?pibT/rUBzwccQifMmS5tayDUNsL9Hg+18af9ipukkP8cEcM/3vCC/Mn46NAy?=
 =?us-ascii?Q?kpd2I4gEWgm0x3voLcjsu2uOQRM0JCAqD8SqvKwQ1lsLoN8NEKPRezmZG/UK?=
 =?us-ascii?Q?PPfPCZQXULsUUV4bIsxrZTxq1ZaYoRiC3lGJM9PjDnmDjJ8Xoo5m+6FHu9fv?=
 =?us-ascii?Q?ItaPiaXbdS24Taj5opyaUHi4oExCLBVWYLWUODqqs27Et/G2ZvODB46hwSe8?=
 =?us-ascii?Q?+ht7KDrhSA4zVEtwI19aQcLgW44rhG4m77LtrC7OGSq47CaFvU/D/IsVheOq?=
 =?us-ascii?Q?6zSvk/mRSEWMxG4ewR0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67cb33c-980c-489c-0b62-08d997dde3c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:35:51.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhSOPARlP90+MxXmHlmvLR0WUjopXnfkb+X7HE0JvTrp9900XbkFfpC5LrwTB8cv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 08:15:45AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mlx5_ib_fs_add_op_fc/mlx5_ib_fs_remove_op_fc functions are
> only available when user access is enabled, without that we
> run into a link error:
> 
> ERROR: modpost: "mlx5_ib_fs_add_op_fc" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> ERROR: modpost: "mlx5_ib_fs_remove_op_fc" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> Conditionally compiling the newly added code section makes
> it build, though this is probably not a correct fix.
> 
> Fixes: a29b934ceb4c ("RDMA/mlx5: Add modify_op_stat() support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/counters.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
