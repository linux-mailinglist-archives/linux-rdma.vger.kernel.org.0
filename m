Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17E241B4B4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbhI1RK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 13:10:29 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:54753
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241937AbhI1RK2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 13:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLfoDIsyg3rXKiYNJOtQ9xIWbc2B6zXugmYDcvJKhPjzzXFzserJhkNUubJY2ESO8/+qmMW8eKRPtA87eRGytSztGmOcOIEUfr1e1A4reSxdVEMnx7oYshR58u8XLDJY4NZAN2Zv9mKAsVqtxIADQGn7pjKCywou4aBDeT24zjAQm8YV+gMwF152+1A4pMVefze/7bb3TWWs41v0HJk88bOROZge4fZAEqo7dwn5iJrPIHNEskyfChQ+VkQnpPoWlqgxIxFIEEorQj74gp9fo7IwmE0C9qksSnOPo7Hq66FLe43eKzi+96e2r07UvQyrUBFYHlwRH97TOxs/00wwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2MBJTWO65KosJkakIxsQWGSRWuVZvrjUPsgfmNmzZ44=;
 b=Y6jt1qaspkXvNSHQh/sG9Dzh43pJ5+y0ZUf4jLad65X6Qqpjh0dd6i5xTmr0ywzs/kHbvaFHc8ACYKL924l97Kb1frpG0ymapvKzZFhNjIoRArPq8Ef8XweGIumhnqFizG6u2v7BR8pg2G6Lg8AJL+OrGbmEE9jrfPpeJ+25f3fRjNikw6JUr8kRcVuD4P7n4HXgYSt+hyFOYhzBEJU/86DmD1bUUhzLkDOUU9mcn2/ZNHW0OTt5ZtiZIgE8tRe7YCLSEiPKQbdEdyJkLjx4Guq4HHMzq4W5kkKpfVvia6px/8+l11vo6wKKR4X6Nq9JxFQc7QwoCM0X9SlIUWKJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MBJTWO65KosJkakIxsQWGSRWuVZvrjUPsgfmNmzZ44=;
 b=Yh5u1qk0NKL6EXh12vNEvAaI5oCtTBbKqCEzA78t03IZxbqafSfdBRr7GWnHrit+i223JaqmJOQ85Atv+WoNw8F75trYXxHBAM7JM+BkyzyAo2E4jzbcEAR3DwbY0u/M95iCgGw3EDY78F0/llZ2TGeTdAT8LdYnhMIFSUW7+a3lad00ANkTENrT6wPmZeXaf8Vko9jvMw784h1Ga3/XgsTFCre75t0CkreyFqJ/KQsExxlCeKR5UkZ2mx8dpvR3TaTWD8R5tKli3G2tfIAKSrvwpFtUZ0z5iIsiAXLtz0Pr1zsiNPjC1QLPa9uaAtGIb/PTsqAUz3m+CJRknuyOMQ==
Authentication-Results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 17:08:48 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 17:08:47 +0000
Date:   Tue, 28 Sep 2021 14:08:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: unify return value to ENOENT
Message-ID: <20210928170846.GA1721590@nvidia.com>
References: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 17:08:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVGb0-007DuV-Gp; Tue, 28 Sep 2021 14:08:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6430bed2-bb8f-4263-883e-08d982a2a2c2
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55490A9CBDD2F0B3826178E2C2A89@DM6PR12MB5549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:240;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0d6EKRUOj9PkB/tZWmC7x94J0cSmhUSLKd+eTd5CJxzfG3vdjBQ5FntbjuDGcphUyCczRaYpknAYblOck1XldJRFZ8DCuGnWaO+VFaIbEFtjPIwXxBA8Ja5TweyFRtM61jMSQeSgE73VyaJEgK8K/zOyDMlAVADVNlQcec1NnRAn/J4PFxBaRrsEF60vxvaPo3w0/Ta7NT7HELzcbmxdMTQyjMnM/4C5YBc4N8JD1kmgyR8D11T+2zDl26oo5pITyIkRke5B3vY013FAWHy3WJOqAPW7Ma9UfxlvN1BgEgrV+Fj4nlEHzkDiECd7AwLC56u9THH/yb51uixI1qEGmvpQbqETnQSo01z14q+Fqy1AdlKzdfvaGBKcNIB4jvoDtIp+wC7Y327lpGUpI3ezuB/50apGI6beLOub7NxC9DTuYdi9ajowqrd4q7Z3ERG20VIsnZ1mnGPq/4g1ZtI7r8Ngt9g2nYMX0hlv16t3FTcflLu/Ko0L6lK3e5V0RhFN4JWU4bkAqkoh3yRdYFUF2cmtHgGgsslQ7vzGn47HSlgydQoa4x9vr4t4no09tWcpKDEXtAj96zZvXT+YHX0p7osflKeR5yEfyRXLd7QpyKZ8jpPiv6HQ49soMgkcAz+MECYb/yGJpIAoQd/1w99ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(53546011)(26005)(186003)(1076003)(8936002)(33656002)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(2616005)(426003)(508600001)(2906002)(9746002)(9786002)(5660300002)(86362001)(38100700002)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GhYYechsoeMxOT9Y+nPf8HFCw4xyfqdDH9S37D4GKcYqKzVp2P+jdDbc4g2?=
 =?us-ascii?Q?CtKHl61osL8P8uqnm44aan6n8dbVf5N8+Pwc0AhsMt+zrU004y2yo2ipbhKU?=
 =?us-ascii?Q?EKh1wL8Anvn2TAw3lE2tgXJhTGrlnRKBCmvYuBlsPPv6NznPxZeNPb+SxulJ?=
 =?us-ascii?Q?fGos7NfhyhBzEU6X41C5alv+hiTkQfq5UTap0NYSR9DYH1JHCUWnaLdCVWKD?=
 =?us-ascii?Q?D3MAbgO1zesJb2EvMnCpdZw4r7+cuFyfpBJ3ade7jlxHl4vemy20xcY38Vp/?=
 =?us-ascii?Q?r6/f6lOKTMxo6Q2fc68m30rDJg6KIj8s0w8NkAQjeQg30PhFSm7q5tlNq3Hy?=
 =?us-ascii?Q?nRymqpRyPZMq+0fp5WkVCuT9vH3NPgBu4oUis707oFUfL668Mgf7mC1m25hp?=
 =?us-ascii?Q?NHT8Z/MD3WGBw1/mkXZFDHfYT26rObKN492hVcZiCRyEU6Z7475oWtaGQ/EQ?=
 =?us-ascii?Q?W8sL5YOOZiYKUmTIDx2qgXZQ1ILPGdIC9TGVc/Rwo9NRTzj2FiLbwblKRR7h?=
 =?us-ascii?Q?6LmOXOYwh45Rr93JlgDe7v3dvikNmXhYXDbU0NKAzdzSxJ3xlwGrPe43WWhL?=
 =?us-ascii?Q?liWJUohd7s0hZdJvkHMsxQa9nnKYzTfpbKtE3YcPm1rHAqJz4dQtL/hWDnH7?=
 =?us-ascii?Q?eD2EnVVDckUqBBzbQVB7EcABHIWG/ICvEcU9w4+fOkHFk5eeGe9q4vKPIbG8?=
 =?us-ascii?Q?/uX1QlGM1sCBjzZvXIosuTz+wjG86ZxnV/JE27goz2d6uHjtFnvfEj9eZrge?=
 =?us-ascii?Q?W2Hucf9MasTYVIgXeGHxNvSHPCkjqKeGK0HCRAXWbNyzegjGlGbzjIebhEaZ?=
 =?us-ascii?Q?qcSyFrxOYEQ9tbQV+WkGEDFiLMsL4TaNRMoSWhnd9y4Y5f6U6wOAYDR2FX8/?=
 =?us-ascii?Q?6ErBr8mzy/yWeeSe8u4rqX2KItlkxIck1bC8DKq0k2sm0+Bq0tLXz0izBDss?=
 =?us-ascii?Q?5dbsakq0Zkko1cQKbSAnWXTbKw+GZwYTafSXFe2t7RjUEhklGxqK2z2ByAMx?=
 =?us-ascii?Q?A/s3MZj9rNzLyxFeNImQhOvvyk14ECkohRue3MEaC5SChyPxB5dlfpXMC8vs?=
 =?us-ascii?Q?Q7rK+HNua9Yc63hxcRGkbNuXMMnYeP7UhAAJ8MBN+tNHVNVk+bdIEgCm7mkk?=
 =?us-ascii?Q?lCZMVeBjmZXtPJdBeEOikxfVJwInrsBwVpgWMOVj7sYbBJWL8WP6b5Oq/RYj?=
 =?us-ascii?Q?B/II0UYQTht4ZeqH0DiVmdM/AxgnlbptV48iqXDN3fXaRqkDNW4hIzS7BwZ7?=
 =?us-ascii?Q?qkeouVoG4ZdGCpzS6OGHqbj76uor9Jx7S1XxKXEoicPeZJSNHtQ5zys/iet3?=
 =?us-ascii?Q?ndY2whQ5o4EVXSfiK3QlNBY8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6430bed2-bb8f-4263-883e-08d982a2a2c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 17:08:47.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc2nMETrPm+Sm0yuit1EymOElXuD78Vfa9khmLFaANVcDxT5+aDrmo15/4o1LJnq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5549
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 03, 2021 at 04:48:15PM +0800, Li Zhijian wrote:
> Previously, ENOENT or EINVAL will be returned by ibv_advise_mr() although
> the errors all occur at get_prefetchable_mr().

What do you think about this instead?

From b739920ed4869decb02a0dbc58256e6c72ec7061 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 3 Sep 2021 16:48:15 +0800
Subject: [PATCH] IB/mlx5: Flow through a more detailed return code from
 get_prefetchable_mr()

The error returns for various cases detected by get_prefetchable_mr() get
confused as it flows back to userspace. Properly label each error path and
flow the error code properly back to the system call.

Suggested-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 40 ++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d0d98e584ebcc3..77890a85fc2dd3 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1708,20 +1708,26 @@ get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
 
 	xa_lock(&dev->odp_mkeys);
 	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(lkey));
-	if (!mmkey || mmkey->key != lkey || mmkey->type != MLX5_MKEY_MR)
+	if (!mmkey || mmkey->key != lkey) {
+		mr = ERR_PTR(-ENOENT);
 		goto end;
+	}
+	if (mmkey->type != MLX5_MKEY_MR) {
+		mr = ERR_PTR(-EINVAL);
+		goto end;
+	}
 
 	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
 	if (mr->ibmr.pd != pd) {
-		mr = NULL;
+		mr = ERR_PTR(-EPERM);
 		goto end;
 	}
 
 	/* prefetch with write-access must be supported by the MR */
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
 	    !mr->umem->writable) {
-		mr = NULL;
+		mr = ERR_PTR(-EPERM);
 		goto end;
 	}
 
@@ -1753,7 +1759,7 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 	destroy_prefetch_work(work);
 }
 
-static bool init_prefetch_work(struct ib_pd *pd,
+static int init_prefetch_work(struct ib_pd *pd,
 			       enum ib_uverbs_advise_mr_advice advice,
 			       u32 pf_flags, struct prefetch_mr_work *work,
 			       struct ib_sge *sg_list, u32 num_sge)
@@ -1764,17 +1770,19 @@ static bool init_prefetch_work(struct ib_pd *pd,
 	work->pf_flags = pf_flags;
 
 	for (i = 0; i < num_sge; ++i) {
+		struct mlx5_ib_mr *mr;
+
+		mr = get_prefetchable_mr(pd, advice, sg_list[i].lkey);
+		if (IS_ERR(mr)) {
+			work->num_sge = i;
+			return PTR_ERR(mr);
+		}
 		work->frags[i].io_virt = sg_list[i].addr;
 		work->frags[i].length = sg_list[i].length;
-		work->frags[i].mr =
-			get_prefetchable_mr(pd, advice, sg_list[i].lkey);
-		if (!work->frags[i].mr) {
-			work->num_sge = i;
-			return false;
-		}
+		work->frags[i].mr = mr;
 	}
 	work->num_sge = num_sge;
-	return true;
+	return 0;
 }
 
 static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
@@ -1790,8 +1798,8 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 		struct mlx5_ib_mr *mr;
 
 		mr = get_prefetchable_mr(pd, advice, sg_list[i].lkey);
-		if (!mr)
-			return -ENOENT;
+		if (IS_ERR(mr))
+			return PTR_ERR(mr);
 		ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
 				   &bytes_mapped, pf_flags);
 		if (ret < 0) {
@@ -1811,6 +1819,7 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 {
 	u32 pf_flags = 0;
 	struct prefetch_mr_work *work;
+	int rc;
 
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= MLX5_PF_FLAGS_DOWNGRADE;
@@ -1826,9 +1835,10 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 	if (!work)
 		return -ENOMEM;
 
-	if (!init_prefetch_work(pd, advice, pf_flags, work, sg_list, num_sge)) {
+	rc = init_prefetch_work(pd, advice, pf_flags, work, sg_list, num_sge);
+	if (rc) {
 		destroy_prefetch_work(work);
-		return -EINVAL;
+		return rc;
 	}
 	queue_work(system_unbound_wq, &work->work);
 	return 0;
-- 
2.33.0

