Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9947CFC7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 11:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhLVKOQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Dec 2021 05:14:16 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:44800
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234441AbhLVKOP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Dec 2021 05:14:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGYA0ELo1E7Jta9xzhkY8GDOGQ6LyVpwBUXGx+nkXnZ6APeeJb/jiOj65r0PUQWI2EH12bwoPmn9swBIU84yFQVmlZf2Uzn+tVGHikLszBR+6E0oI4kQKNpWzSDZmIzseR+5E1lqKSw1X1qjIU8FSqcVDieDEpapMmkrJFDYHwHsQ4M/HeCFQYcaRjJVsmyL7eFI+8tqBRQ30HgIMWaO64seZpKGXiyzn2iX7Y0qMlxmi6jrGed+eRwHxjs+Et8fwqF1H+AxGuq2qowhnhSyQ6nFATno2F+gQgZeNHHPsdcNTNz1hBjSG3g7NMKZ5aUq4FqEfKDif4CYVbNVNJX1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuM3mR5/5GOgUnAllgxZfIwi92abGZQToskkugOXdOc=;
 b=iML3+BSjDJFUVG4zFYiqXaRNGgSA7BmpkQbVOEKTvTtB+FaTgK75cm8FgrHssJkO6YF+EKnFJIb3zq4NXjWyBxh1UCeFnydhkD0MOzn49VZrgT5QP4/ZFEYN1S3j18MUQ+w3dwAN3xyiFS7mLImLIidODL2n0vVTlOETbNPL/OQYzYSlLwz/j5QLfazoRI2b5JC9554O6HSYp4bWCxcW0o7J05ibSsvoU0TA7HWhroo0/KBaSw6HvoYvSOymtAN/QpvwLk4wathUZ5FEu4UTpJMen2duLA6HUc4GDBusou2xFvxmCyLfjxP41GzbyA4RmpqD6Tbd0ayaDtrpvUlksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuM3mR5/5GOgUnAllgxZfIwi92abGZQToskkugOXdOc=;
 b=HohhYQvU4x2z0jr5ddBPnCEx6wsJSshH1yq1084fJX1cVhWTPY8DRW2hgukkrhgmwN4ce0J5TauQDAIRcYPWR+6sbusEkzBDmyso7EwaTiInS1taaHi0tXMjqD8E624OWwYWv0xLAdGjRMgmXL3xsvupdyMlngHVY6fhVqNNAipm2Hed+/LW6rPvc5sI9PQ0lrX78TuEsPlJTCli/24nTy+ocaqCzPLEk3OcKEGYJfr5PVczWSdz645mmIoyIwwcphpvqGtQ+bWbhyURD1Tes+xB6F1gR2wRPERKEN0LaBfnPFKqD56pO6oIFj4pHA03CGhEgOHglqb4ZagLsLJXFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Wed, 22 Dec
 2021 10:14:14 +0000
Received: from DM4PR12MB5296.namprd12.prod.outlook.com
 ([fe80::8515:d530:cd95:53dc]) by DM4PR12MB5296.namprd12.prod.outlook.com
 ([fe80::8515:d530:cd95:53dc%4]) with mapi id 15.20.4801.014; Wed, 22 Dec 2021
 10:14:14 +0000
From:   Maor Gottlieb <maorg@nvidia.com>
To:     jgg@nvidia.com
Cc:     alaa@nvidia.com, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, leon@kernel.org
Subject: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow"
Date:   Wed, 22 Dec 2021 12:13:12 +0200
Message-Id: <20211222101312.1358616-1-maorg@nvidia.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0094.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::35) To DM4PR12MB5296.namprd12.prod.outlook.com
 (2603:10b6:5:39d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aba2732-3f21-4983-5280-08d9c533cdfd
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB551841A3C06C34146E8C4E74DE7D9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waIBZi0pPmbo4sniQdaG4Wt4MTAnKUQ4ICF5D/cBXyOpRa8DSNO9kETtKytLU0O9HUqlpxjuZS+wFOZz4nmnIhnLXEaBnofz/sQsPdkmGUa6SGTJg/Kx2LJi7GZac0RuHgcqibHiXhzL5n3Nl76fuSMWuX83Dt9bHr1k47HC/XAnf87nkOOhuxqIdgEV9SD1vPuz8ETUWHuiGyj5tx8scK+kCBp7ybulg0rxKOmmKjNent9IEJ9B4NgFgNvy1lsWbH5QpS08xHxkvPPDtzEapeLtMYnnAL63QFQ3Am3Q96Vf/PGyU2V+mJCjF/z1xEiFYWfcsNx2u3QhHyOF0WDrQPYx5FJ8wf9NH4zT5n28PAKGkBah094GRUd/hrWs00jyZIuVos1CNEV3Q1sMonUry2pHj8m/DSUNrUXsCmeTyQEriccDXs+bvrJVHYy6Mx+KA481VLfqBEOg8WSDDOdGl8ZN3m02g8ZXRIrWfzNMW93Wl/CS1rP0oeJnfWm5KsGZrIkQu/A34t2AaUVhc34eMBuBCqsbXoraYKEhC8j64RyVP0y13eZ++1wvLQG6NxClAMVwvDz6GAtBH/yvhzVCSBiVVuXDAJtHNVOrtvxGnE3n5mdTeemEoFIBLRo+z8gU3hvBJGaDRe1JJ0jfi+58Q9X9Gp/q9BjuA0YuGpVKn5naAtuS5pNbd/Z7aRKytdwWbHbui3sBNjjmwOGQYePgJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5296.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(2906002)(316002)(2616005)(508600001)(34206002)(4326008)(6512007)(8936002)(66476007)(8676002)(5660300002)(6486002)(1076003)(6636002)(66556008)(6506007)(38350700002)(52116002)(38100700002)(37006003)(36756003)(186003)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQdUZ39jOGbE5EFUpoCSReCQZSJYwTsB9gAJnRv6MwptJpbtV6NjUribARvU?=
 =?us-ascii?Q?kDJDyij8gHBk04ZRluC5nTabvQt8QcwOPtbHa3T6GF8zOCyXtpvQsxqTA/r4?=
 =?us-ascii?Q?9P3RcS6WSSdRcmKhY5MlkcUiIa7gWpHB0v331gbIUe4c68p+O9gwEZowNNgs?=
 =?us-ascii?Q?Uh6RsSRrNPCe/iSzykh2tMOyyMFG/rYHiUn21X10xd3kW+j4hcSqvTalhUpm?=
 =?us-ascii?Q?lK3WcXpb+VOKRF+jGD/z35pe/0d6BA1eL+Tx/bU6tEYsqKiB9rJqdUuQptXz?=
 =?us-ascii?Q?tapgBaYmVImhHFOn2JL0UzipmEP7EdTyNuKYg1qXG4fknRS7/HdYd4e4gg5H?=
 =?us-ascii?Q?fsT3u89SJtaCUSrT1Ou3ObQwW27ZuH4h9AJXducugeo107/ikB/iDYEzDrJJ?=
 =?us-ascii?Q?hLChkWr0vAjgPmAiLhFxJ4ZIW7j0BOJcpTQyupgItCdCHK+jHYTdByNQZR+4?=
 =?us-ascii?Q?XNNuwIZx6iriETCulx6KjATFJmwNtkUqmCPrOLl66XMo0yVJ4Q00/sczxKEv?=
 =?us-ascii?Q?iLzYSSZrwvqZumVETuPYaq6rdIDKoywljgbUa5v8+ztmsKEcNVkKDvq6GuYO?=
 =?us-ascii?Q?WA76Kr7fCu71wYBAOWEYGHeInZ65bRFwVhHbwbEPQiyJuVByqmWpPeGZ63sQ?=
 =?us-ascii?Q?+l6cK194uVWb7Mpvjocs4wgW6pCpK57UQM3BhB3j+rZ4coZp9sUsz1wL3mf5?=
 =?us-ascii?Q?9yrHBA+ehIbZpKTF4wOOY/J+RnG//HHV2Y2KGvGw4Ks0kSCp7LBXW7KlLS44?=
 =?us-ascii?Q?zKfujyn7e3MTO5bfvo5FLkDjtZ/vrVFUE4dFH3uUYrZDOqcF0TeKlg4N4ksW?=
 =?us-ascii?Q?kmp6cIaEjq6/kZHhF+o/ElivuJkxVdHkgN/8WMYOlIKzD68WDgwshBqW3oLK?=
 =?us-ascii?Q?3x8s7Ot6IKzs/7F75STOot+HymFs0OFAG17qzi+8ukh1ERuUmjn7sD0SJfJ8?=
 =?us-ascii?Q?Le7hHbemprxwcKJrXloeWor2Y+XN3iQ/Ad/nSdKDAiOcE5NCzA2RExJWwKAU?=
 =?us-ascii?Q?9k3ifvP//pS2VXy9Qaxxw3fMHzJxxqoyGvxtrYbA0mlk5NWgPdjchYiYIoji?=
 =?us-ascii?Q?nueTPqahL9vHfcLWGLiok4BHZfHfHC73zXG7qD1shwld1rpQzoVUzvKoTTCg?=
 =?us-ascii?Q?yff2NZKv0EnenPgl4qTlsyjUu8lMyEbldcBj2WlUxXL5IG/eFNX0wVDciYij?=
 =?us-ascii?Q?H0HwNiz4KVbUC5Gb4yXCFSqkPYOVMWcvgXAOYKMebq/6AOTpTk0qXqMDQ0V4?=
 =?us-ascii?Q?y1vsHBhSuMKA2tJ8QOZSynC8gJrqASBYuOY1Xtoos0CFBegNG7oZbqzC6FG1?=
 =?us-ascii?Q?tLZ96nOctJKnrgBSRPkjAdHagHuA9WzFF735nnewDQvCPjbpw06C2r3wIt0Z?=
 =?us-ascii?Q?mwaEAVnIRjQb5spzNoQdnsrRW3uIPyRmIZ+ly3bsLNzwsaHfPYavWCDyfwCU?=
 =?us-ascii?Q?W+zUv7L4bHiw5uS4WMDvAODlUo5PbIWVP8bJJKg+2CDrpLCuxxmDMuSRGvUO?=
 =?us-ascii?Q?zMHlqOMMCH4KzAagDbN2nWvCm471XCzN5VHTxsI7Fmzzfe1MQ5Lce+/c/cqw?=
 =?us-ascii?Q?FdQ4Du5B7wueviaWs4s972SjEuuQQJtppQR70DmipkfOBYskVzyjhUJRNgZp?=
 =?us-ascii?Q?l0DqEMbyKG+/JXGbQHOdBTA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aba2732-3f21-4983-5280-08d9c533cdfd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5296.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 10:14:14.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkhq5ylhtp9203eg0zdPXv3qjROfwolu0uFgmMEkd4CgBPA0MTK3FFx/VTLgy8+8SJHKdzY7SlG7DUF4dBQvgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch is not the full fix and still causes to call traces
during mlx5_ib_dereg_mr().

This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.

Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
 drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++++------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4a7a56ed740b..e636e954f6bf 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -664,6 +664,7 @@ struct mlx5_ib_mr {
 
 	/* User MR data */
 	struct mlx5_cache_ent *cache_ent;
+	struct ib_umem *umem;
 
 	/* This is zero'd when the MR is allocated */
 	union {
@@ -675,7 +676,7 @@ struct mlx5_ib_mr {
 			struct list_head list;
 		};
 
-		/* Used only by kernel MRs */
+		/* Used only by kernel MRs (umem == NULL) */
 		struct {
 			void *descs;
 			void *descs_alloc;
@@ -696,9 +697,8 @@ struct mlx5_ib_mr {
 			int data_length;
 		};
 
-		/* Used only by User MRs */
+		/* Used only by User MRs (umem != NULL) */
 		struct {
-			struct ib_umem *umem;
 			unsigned int page_shift;
 			/* Current access_flags */
 			int access_flags;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 63e2129f1142..157d862fb864 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1904,18 +1904,19 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 	return ret;
 }
 
-static void mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
+static void
+mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 {
-	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
-	int size = mr->max_descs * mr->desc_size;
-
-	if (!mr->descs)
-		return;
+	if (!mr->umem && mr->descs) {
+		struct ib_device *device = mr->ibmr.device;
+		int size = mr->max_descs * mr->desc_size;
+		struct mlx5_ib_dev *dev = to_mdev(device);
 
-	dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
-			 DMA_TO_DEVICE);
-	kfree(mr->descs_alloc);
-	mr->descs = NULL;
+		dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
+				 DMA_TO_DEVICE);
+		kfree(mr->descs_alloc);
+		mr->descs = NULL;
+	}
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
@@ -1991,8 +1992,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (mr->cache_ent) {
 		mlx5_mr_cache_free(dev, mr);
 	} else {
-		if (!udata)
-			mlx5_free_priv_descs(mr);
+		mlx5_free_priv_descs(mr);
 		kfree(mr);
 	}
 	return 0;
@@ -2079,6 +2079,7 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	if (err)
 		goto err_free_in;
 
+	mr->umem = NULL;
 	kfree(in);
 
 	return mr;
@@ -2205,6 +2206,7 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 	}
 
 	mr->ibmr.device = pd->device;
+	mr->umem = NULL;
 
 	switch (mr_type) {
 	case IB_MR_TYPE_MEM_REG:
-- 
2.25.4

