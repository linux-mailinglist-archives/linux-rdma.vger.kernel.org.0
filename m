Return-Path: <linux-rdma+bounces-4751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3E96C27A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A041C216FC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9F1DFE0B;
	Wed,  4 Sep 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NtaMtliC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B51DFE05
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463885; cv=fail; b=mIVw8tcvFnTIFWuVFLFjK27eTjMGjMEtrhsr5uqI8rY+q8hD1fxkIz1iHocXSYOhVD/WD8yR7HcVAyRJKCZztTt5eBWkr5e3ydfI3F7n94A0X1jOs0uyU4BJLholcl5QhOMrflT5UltuxsuWQKYiEBqFgBq+t1HX+9wDkmFkLB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463885; c=relaxed/simple;
	bh=l8iaeG1WhCbfvR3zZonOKfUTavfdbYsLCzJvn5eoc4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/DlpBNb8BTUIPgTWOZvK5pl5qpAHgftqY2USYW7biTprGO9tTBls48Q1rEgvns8/ezoYT2Cap+o59l8PQvTxn4Zk7Jg6BUEfVRWSVoa84P4CzanhmoEa7B8Izgc/Vvvy9GkgTHhtIy7feH+fsh3GbhcPtwPysOku70p9YjTqEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NtaMtliC; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVrl2z9avk0FI3XKrjP6IN0FKd/jfGqvOdYkjVZqT8AKk9kkTyTBb2KE1e3LLRqGk3YYJRpsJHJdJQ4jHxiTlWEuec+N4j8L5GjOCRzcLtd/hA2qsy7NQQcYrCAPuoxXIjKnwwAUgBoHI/0kNOOD2T4eukQIp+CBa4AcHvpd9lgTc7jrVNLLyEEu/P8wbuhUkp3v8J5YmnDE/YLnwCSWrxnu1GdEOTuOsusbf7fqjKY77WLA1m3kdyz6fCN03FiQZbxgsP7rz7+mjH2j9NvpoOELRUIpsVfa+ShPzAPwNea9BEno7YFzaTEkel6QaPAfDuI1KZHQ/9UAE61/IpdLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgCDuzsAuTAc3ap6+H2PXvjqsgR07GVCqCY0pgV2TVA=;
 b=QvZHY3B/dzUukwFFahCPGYAulA/fYEZbjdZRTEN+4pVsd/i/732QroG0S57udWgh6B1XaT0IzwMS55Oeknw7OwECag0HSby/f8X9fqn5RRS+aQqyM8dr96Ii0NNSxThTzCwRLWC3HP3ecgg5WUHeZrk84OV7fC7t6iXbqFWcH6H3oTC56Tsz2/JIGaiAHBwzdgD5MjqHQmvGsewmmg/2BFiLht885mSRh5mGXwZuEzpb6e+7o2S7Ondi48Pozw6IX3InBfmIU6psPsiizsMT/ThgXnCSoH0CLMdYLXQpey7KNjwxSoDiWCL7Xj5B9D+KiBUAQgI5WaiLbCw//shUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgCDuzsAuTAc3ap6+H2PXvjqsgR07GVCqCY0pgV2TVA=;
 b=NtaMtliCs94L/xaxCJQZ6vAvcWTPPN5khZOXaga3zQ0j5NWDCwXMRDblEph7zuMlRvVAMujBDFL7pKDIt9RyEzy52/NBMNEMOgdZH6wB6OtAZ3qj96uLflqH6XRNSPrdeKEGCgAtQYF4ThCkJuNtWQqjMwXnQlcPVefdpzvrT5oDBlI1uHcy7EWPTbYmQnFV3PdN+BSJL3tOni+g4oJbY2xcMndxzvapOkrG0hmnF/2MT547lgGW8gcqHH/rLtGBN96jq7l/uzWxrCg4N9oUonOHtb6O2IHGDpTxAx0+qsQxn5Ss9IjjhoL4dgD5NUzcFmlPJZvxLd8Vb5DjJujXPQ==
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 15:31:15 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::ae) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:57 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:56 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 7/8] RDMA/mlx5: Add implicit MR handling to ODP memory scheme
Date: Wed, 4 Sep 2024 18:30:37 +0300
Message-ID: <20240904153038.23054-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240904153038.23054-1-michaelgur@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 489cea98-a527-43db-7426-08dcccf69d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZY4MezGwNVr/DB4bPn0hch8+E/HOpOpxYTBxcf8E7vX566ODWX2eSGe7X6el?=
 =?us-ascii?Q?lyAUmH84YgqsqNHd2E4v3DTkEbsk+g3JdJXUbq4vJMFF7cG/Gs7Cb7Te/ri5?=
 =?us-ascii?Q?w9XyOR8dMGtm4j/39EQ88LsVIxx40l+2Ke0Jp+tJFlidMknU8cqg9GDqbKFS?=
 =?us-ascii?Q?VQFkWULLdzVnVgdxJzqKkwcG/iwCE+oq+vZV9/41hfDPxYLHCgt6ufgg9R7c?=
 =?us-ascii?Q?qOen1Vg7dTCqLDnfw9zez5r6BlCzddSPJgEmFzH8wpZXnwxyhbt6ejlwcHj+?=
 =?us-ascii?Q?FOGIzo2XKZyKCkZNZR/RRB2NYKyFKO4gSMbAqWQDwDgy+/Bf4xltbWoTZk31?=
 =?us-ascii?Q?oMMY+ZsIg8hfeYS1EZ9+Nuv9tcj2sDXa1GDZkQTZn1/AaX44YUBuTnq1ZmDt?=
 =?us-ascii?Q?15fJU7oh0k5+Dw9RPCD+Ml34+g1KqocGk9VvOsXFmdl5+6rDhIKLo8Yof9iv?=
 =?us-ascii?Q?h+c7kQ+VA1mCnrRkx7h4IWhcpfb6Swa45PfD1U+RUB6xda0ZkBDEd2xhsaYz?=
 =?us-ascii?Q?hEzWRt94bfA15E8qYwisp/uhaidlLZ1i+Y7Hnm0DKL5YZwze3jMassQOG0fj?=
 =?us-ascii?Q?rFWEoPreVal+S0SavF9UlMmijs6Z1Z4gz8qqSRfSfnCaFa6DhMB1lkEWfJqG?=
 =?us-ascii?Q?5Got3EeGwcySuQ1Ay2AsWubV0RyKyYuNRzi/O2pJOhoBQnZJVfCrT6UL7783?=
 =?us-ascii?Q?iV3LXkAo79kKSJAAnwroZ7ICe9PbMeoudo2G6bCXYHY5c8MCxnYVOxvOAIeI?=
 =?us-ascii?Q?owpcH/YZKyO0uK2X8LVGRAkELIs8fRYD2H6fEsdsZBY/cr16Df6sR0N32/A3?=
 =?us-ascii?Q?eRoC+TS9b8PnTGov1w0erKtAqSS+Za0Xy+B7TMkh3vLcBB0GauC92daK2bbw?=
 =?us-ascii?Q?QGaxC49IYUVgNEErqjF1TGYxlxzhN4aU6WALwu2MfjGxLcOigUAqb/kheqVx?=
 =?us-ascii?Q?k+SUmtIA+eQ0Vs9QUGuKKG9UZT9oRqu01hbAD/iZoqDeF6goR5XYgfqkK4BP?=
 =?us-ascii?Q?G0UDs42HiWBVfDuNQJnN80qmB97YY7NBjCuRiU/otfCq6aVlcVpj3enNXx3j?=
 =?us-ascii?Q?60agkGoO6GHR9gGa2BbpttiCRyVM+P1RAYsMA8w5iudgAoh2yqV9pyaDOhIB?=
 =?us-ascii?Q?R/ROOBl8ShwYyh4iwtdgi+TZNzxpxWcbWG+Nm8IBEuQ16M6MGzJc9q0zrQVx?=
 =?us-ascii?Q?7WURf5GolCc4ftHAp2EyAXC6JyyjQZCml0+M6j/bNsLtI5dUQg5kksXekF+A?=
 =?us-ascii?Q?auSNJpsbUpEPewjBAOeaBepVMOyqWvVEpYtAcDD6v+ag22lyDWfeC0hjBP4K?=
 =?us-ascii?Q?H8ZCf0jUoDiFB4K+i3ExaC5ymzyz+UOSX06tYMuNdnJnbo2aDM33ABPpNCKf?=
 =?us-ascii?Q?MvXdLpwrEcadqmBLiy2m6lojQxBmfRaZ/UHvi4ksHlneUwumQ5pYwPBwexvK?=
 =?us-ascii?Q?OOfIPZqv+BK6qn4QfQuIxkRaq3YZyylN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:15.4017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 489cea98-a527-43db-7426-08dcccf69d63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

Implicit MRs in ODP memory scheme require allocating a private null mkey
and assigning the mkey and va differently in the KSM mkey.
The page faults are received on the null mkey so we also add storing the
null mkey in the odp_mkey xarray.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 +
 drivers/infiniband/hw/mlx5/odp.c     | 116 +++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 89c2ab728577..b973568d406a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -643,6 +643,8 @@ enum mlx5_mkey_type {
 	MLX5_MKEY_MR = 1,
 	MLX5_MKEY_MW,
 	MLX5_MKEY_INDIRECT_DEVX,
+	MLX5_MKEY_NULL,
+	MLX5_MKEY_IMPLICIT_CHILD,
 };
 
 struct mlx5r_cache_rb_key {
@@ -728,6 +730,7 @@ struct mlx5_ib_mr {
 			struct mlx5_ib_mr *dd_crossed_mr;
 			struct list_head dd_node;
 			u8 revoked :1;
+			struct mlx5_ib_mkey null_mmkey;
 		};
 	};
 };
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 841725557f2a..4b37446758fd 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -107,13 +107,20 @@ static u64 mlx5_imr_ksm_entries;
 static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 			struct mlx5_ib_mr *imr, int flags)
 {
+	struct mlx5_core_dev *dev = mr_to_mdev(imr)->mdev;
 	struct mlx5_klm *end = pklm + nentries;
+	int step = MLX5_CAP_ODP(dev, mem_page_fault) ? MLX5_IMR_MTT_SIZE : 0;
+	__be32 key = MLX5_CAP_ODP(dev, mem_page_fault) ?
+			     cpu_to_be32(imr->null_mmkey.key) :
+			     mr_to_mdev(imr)->mkeys.null_mkey;
+	u64 va =
+		MLX5_CAP_ODP(dev, mem_page_fault) ? idx * MLX5_IMR_MTT_SIZE : 0;
 
 	if (flags & MLX5_IB_UPD_XLT_ZAP) {
-		for (; pklm != end; pklm++, idx++) {
+		for (; pklm != end; pklm++, idx++, va += step) {
 			pklm->bcount = cpu_to_be32(MLX5_IMR_MTT_SIZE);
-			pklm->key = mr_to_mdev(imr)->mkeys.null_mkey;
-			pklm->va = 0;
+			pklm->key = key;
+			pklm->va = cpu_to_be64(va);
 		}
 		return;
 	}
@@ -137,7 +144,7 @@ static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 	 */
 	lockdep_assert_held(&to_ib_umem_odp(imr->umem)->umem_mutex);
 
-	for (; pklm != end; pklm++, idx++) {
+	for (; pklm != end; pklm++, idx++, va += step) {
 		struct mlx5_ib_mr *mtt = xa_load(&imr->implicit_children, idx);
 
 		pklm->bcount = cpu_to_be32(MLX5_IMR_MTT_SIZE);
@@ -145,8 +152,8 @@ static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 			pklm->key = cpu_to_be32(mtt->ibmr.lkey);
 			pklm->va = cpu_to_be64(idx * MLX5_IMR_MTT_SIZE);
 		} else {
-			pklm->key = mr_to_mdev(imr)->mkeys.null_mkey;
-			pklm->va = 0;
+			pklm->key = key;
+			pklm->va = cpu_to_be64(va);
 		}
 	}
 }
@@ -225,6 +232,9 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 		return;
 
 	xa_erase(&imr->implicit_children, idx);
+	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
+		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			 mlx5_base_mkey(mr->mmkey.key));
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
@@ -492,6 +502,16 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	}
 	xa_unlock(&imr->implicit_children);
 
+	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
+		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			       &mr->mmkey, GFP_KERNEL);
+		if (xa_is_err(ret)) {
+			ret = ERR_PTR(xa_err(ret));
+			xa_erase(&imr->implicit_children, idx);
+			goto out_mr;
+		}
+		mr->mmkey.type = MLX5_MKEY_IMPLICIT_CHILD;
+	}
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
@@ -502,6 +522,57 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	return ret;
 }
 
+/*
+ * When using memory scheme ODP, implicit MRs can't use the reserved null mkey
+ * and each implicit MR needs to assign a private null mkey to get the page
+ * faults on.
+ * The null mkey is created with the properties to enable getting the page
+ * fault for every time it is accessed and having all relevant access flags.
+ */
+static int alloc_implicit_mr_null_mkey(struct mlx5_ib_dev *dev,
+				       struct mlx5_ib_mr *imr,
+				       struct mlx5_ib_pd *pd)
+{
+	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + 64;
+	void *mkc;
+	u32 *in;
+	int err;
+
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, 4);
+	MLX5_SET(create_mkey_in, in, pg_access, 1);
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	MLX5_SET(mkc, mkc, a, 1);
+	MLX5_SET(mkc, mkc, rw, 1);
+	MLX5_SET(mkc, mkc, rr, 1);
+	MLX5_SET(mkc, mkc, lw, 1);
+	MLX5_SET(mkc, mkc, lr, 1);
+	MLX5_SET(mkc, mkc, free, 0);
+	MLX5_SET(mkc, mkc, umr_en, 0);
+	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
+
+	MLX5_SET(mkc, mkc, translations_octword_size, 4);
+	MLX5_SET(mkc, mkc, log_page_size, 61);
+	MLX5_SET(mkc, mkc, length64, 1);
+	MLX5_SET(mkc, mkc, pd, pd->pdn);
+	MLX5_SET64(mkc, mkc, start_addr, 0);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+
+	err = mlx5_core_create_mkey(dev->mdev, &imr->null_mmkey.key, in, inlen);
+	if (err)
+		goto free_in;
+
+	imr->null_mmkey.type = MLX5_MKEY_NULL;
+
+free_in:
+	kfree(in);
+	return err;
+}
+
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags)
 {
@@ -534,6 +605,16 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	imr->is_odp_implicit = true;
 	xa_init(&imr->implicit_children);
 
+	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
+		err = alloc_implicit_mr_null_mkey(dev, imr, pd);
+		if (err)
+			goto out_mr;
+
+		err = mlx5r_store_odp_mkey(dev, &imr->null_mmkey);
+		if (err)
+			goto out_mr;
+	}
+
 	err = mlx5r_umr_update_xlt(imr, 0,
 				   mlx5_imr_ksm_entries,
 				   MLX5_KSM_PAGE_SHIFT,
@@ -568,6 +649,14 @@ void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr)
 		xa_erase(&mr->implicit_children, idx);
 		mlx5_ib_dereg_mr(&mtt->ibmr, NULL);
 	}
+
+	if (mr->null_mmkey.key) {
+		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			 mlx5_base_mkey(mr->null_mmkey.key));
+
+		mlx5_core_destroy_mkey(mr_to_mdev(mr)->mdev,
+				       mr->null_mmkey.key);
+	}
 }
 
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
@@ -1410,14 +1499,25 @@ static void mlx5_ib_mr_memory_pfault_handler(struct mlx5_ib_dev *dev,
 			       pfault->memory.fault_byte_count +
 			       pfault->memory.prefetch_after_byte_count;
 	struct mlx5_ib_mkey *mmkey;
-	struct mlx5_ib_mr *mr;
+	struct mlx5_ib_mr *mr, *child_mr;
 	int ret = 0;
 
 	mmkey = find_odp_mkey(dev, pfault->memory.mkey);
 	if (IS_ERR(mmkey))
 		goto err;
 
-	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+	switch (mmkey->type) {
+	case MLX5_MKEY_IMPLICIT_CHILD:
+		child_mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+		mr = child_mr->parent;
+		break;
+	case MLX5_MKEY_NULL:
+		mr = container_of(mmkey, struct mlx5_ib_mr, null_mmkey);
+		break;
+	default:
+		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+		break;
+	}
 
 	/* If prefetch fails, handle only demanded page fault */
 	ret = pagefault_mr(mr, prefetch_va, prefetch_size, NULL, 0, true);
-- 
2.17.2


