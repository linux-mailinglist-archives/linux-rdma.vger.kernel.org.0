Return-Path: <linux-rdma+bounces-4823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E979714CD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A711C22DFC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF91B3F1E;
	Mon,  9 Sep 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WI2rW2cU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21241B3F32
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876332; cv=fail; b=bdKrvSyVI/AFOVHwvFBawt1cjYmPkmzlN4DBKdaNrbCRcQdO+dTd6fVTQCls4n3oZBHIeJH5LJ6wfk/69XuD6rG1oV+/qKhFm+Z/XBDc2gMxO64x/9SIyaQvCP9IDTunOk6reY9mIY5mqp1NejP9TI3vOlTVJ1BJ592ALimw4pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876332; c=relaxed/simple;
	bh=udtOONpfnz7kqLOsQgZy4dXS2FqgNLoCyozCvWdqiPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZU66GBZ2GsHxbmiJiolYUdEbp0WhwLMN9WCaQn17kL5Oz34/CuikZlaThY9WTiRKQ2nxjX39HtuSQmnoJifQJ8jsKQrD+gBP9SKyRlNYzVBK/FyD6OO/VQGC1u9qgkjTij2fXHGmqj2fNUBOtMZctoyNRA97qMqMzXzr1C9PLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WI2rW2cU; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiyxEPB8DhEXTjx/5qLqGdtY6bB7bIkqFCLcm7MlnLaqfeXwiu6DRrKAyCEi5RGxMKFcEaXJlGWj6Q4VgI+HP7Ib8YkxMPx5M9G2lwbGLPxwYFS5kN4j0bBN/9sOX31wlba2qswPACyyKWSio7IVTLhAVRjCEzap6OY66Nhgb1syS2H4EC0L8PsLTgSlxJqQcPIo7JffA1RLcgcjO8Dno4U89vPBGB+GO99A01lwLxcNpGDjUYqDvupBKa11RjIsX8YtAczP554MhqggLwwjjPMcIt49vjewp8ibpQ2VDQTcdKs5jUEZQ/8wh1N5KtqS9b6HpkR21Gv5h4a+HiYQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VVsmCBsTbmoNEDvOisP0DU0vksXfNKdqLnxNPQrtAo=;
 b=B/jGpAoRDdl9wCqlG2YhI9WYWqKhPyHlg8fWisJMe/itY0hoPnvpA+wViEDYDsJDGWDMaX2IPltA40zg+/pLkVIrMOSbYXJVhm5BwWcSAwS9O40GR8QQIVvZuVZi3g9wQEDoD/qee/DnkselwNp3E7d4551dcokd0wONI1Ijg2Fbo5u38seOVHi9GnR9JbQAdvaoQ72u3wptW28sfWlI0jrXjdcZwC98FvwJdfhIgYPMdPqw/mPMxH8Ksby0IS3/StJ6BtJEAtFnHXe4Bm93Aj5y21Pghyu2akRHmonDcbAJdRpIOR1xs1KS3MDpZH3sAF7fHbbozp/+SmMmyP17rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VVsmCBsTbmoNEDvOisP0DU0vksXfNKdqLnxNPQrtAo=;
 b=WI2rW2cUZMVqfHJN5H0wRImk4TsgIWxz4XSXZI21nXsgHecdrXFHda1C351W419arDi+W3dwKY30Eo+OWEOYScqcM790lajPBPQ2wb36CT3Bw0TBRM3t8mYyNt+oEtsXLQOfXKO6F21rA5sN5CBDHA1Lu7xZduec3+5a/0iKnol8ngi3s8gnSDgJORowkF5JZ4Q6CLtNNJ68xjzIeHVrAK3dWJEozNsnE3LKEMPe+xYaHCwXqCFf+/YUGojYw4qYJrAOW/C1gUC4TSDA6pYTNjjksc2eMRpeH/XhKJ0dFVgyUsbMOCF28sNGs+WWQ8JK7bV7WZ9ywz2rJridtViRGA==
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 10:05:27 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::2d) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:15 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:14 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:13 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 3/8] RDMA/mlx5: Add new ODP memory scheme eqe format
Date: Mon, 9 Sep 2024 13:04:59 +0300
Message-ID: <20240909100504.29797-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909100504.29797-1-michaelgur@nvidia.com>
References: <20240909100504.29797-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba65c99-1742-4c0a-92c0-08dcd0b6eda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwR1pyG0ldJ+jd/2XwKpHSZQBArbdwDQxpFzJtDApMn0h6ic4Qb6vCyFCZRJ?=
 =?us-ascii?Q?M7N12OZzCs+PacFoZXlGSF7vXHXYXY8pX46g98rzYdnaEz4GJowu3mSQgUCw?=
 =?us-ascii?Q?fpXlwzg9LRgj8zsiZsWKtGUlqKmJiB+824gqwMZNdXpjB3IXg1Sk2qZ4vg1Q?=
 =?us-ascii?Q?ZQA4M7oryT3hQpVAngMi5VglHqA0B/X5GRaJ5bAku47nRbXsyf8jLnMCOFue?=
 =?us-ascii?Q?KQMf7af30nz1RBNeljR9XLrlP9cg24+EeAJyeToODpTNtMIutF2YY0i7+pww?=
 =?us-ascii?Q?smI0CnvsID31IW/d2b4PoLVtZ6HS9jO8Dx329P6jYnmmlSkpB0dC3KZym16/?=
 =?us-ascii?Q?zBQP5S6Qfsxlmf0PPnSTr62aFJQnGFTjIVzohyUFtquufee4orM0/VL0y9fI?=
 =?us-ascii?Q?8a4KMKKZ4PSOo8FZfgE3pOrGKj/j6XFu3EOiMkgn/GfQDQLlBWigY87SSs2N?=
 =?us-ascii?Q?5tTvyKMr0Ko2WRGPgvV1G51Zm7ayMmg5c9ARXUK1p5oWgS3bEj2rKBJ4baW2?=
 =?us-ascii?Q?GA1AcI4mzXA/YeY8PU28vZGn3zZswD8eYUq3HRUI0yn3OW5/NsoIJdL9DMgD?=
 =?us-ascii?Q?aUosqaITXa/u4eEH7+vgVjEbvjXIC/8YBaahrA+17WETZD4w18Ce6B9dsc9R?=
 =?us-ascii?Q?B3hqBbXxSbgioUKGd2LfcvM0s8hdkqgEYa5O6BhewhTdefIZoEKu5XdRSzKF?=
 =?us-ascii?Q?5QuIwq+1P2iUt9StT9ZtTKRzn6fcpLCD6iUeGLzuCE/EAQfV4mwc+IJeSCrJ?=
 =?us-ascii?Q?2/oTCw1daPTuBf7mShv+rqJM6S6d5dJglmXM0CH8qqV4HKd4etGNBuOOmZCb?=
 =?us-ascii?Q?dl3OZ+im3Z0XE+aQEX3KjzQgDpnOdELOUKOFzXaaeKON8YFHPKKVEQdvAdpv?=
 =?us-ascii?Q?0+MPfuxH/TrS9WMdIBdO/QLdLfsI1PEdbA8ehcEdYAnh7hWteR3N5EvHscnw?=
 =?us-ascii?Q?oDnMMXuY8+B7n3J6TN/TQt+XSeCFqx+4Qzs8WHWwDJM4ojQF1kgF2TxpbPwe?=
 =?us-ascii?Q?NOhZi5i2tC+1fVFpedqd1OUUH17mzSjwHouY+EQ7jqRz7UUF1SD+8vg/Pr1C?=
 =?us-ascii?Q?3n1UtEK0WaBDCtYBwHuER6J1iVClKwltBEyUanXNILA/aay86NFidc1MS5D/?=
 =?us-ascii?Q?OTdX6OmwMXk1CcpugS5K0/Fz0x9ahz5SbcBF1XtHh5oHOK3+yIOCDhqN3yIg?=
 =?us-ascii?Q?qnqSzU/8JjkOPLl5+jOFH6iel8i+ytU7drZ9c+1x3L8S6cc7Y22DNlVK72Pc?=
 =?us-ascii?Q?A0rvadETE+91zLbnkyYo7I/DWGBtxla0F2ElQaQ7eg9hXqQI140jwil4aNhI?=
 =?us-ascii?Q?1VCaFixTyXlW8fVChD+VmkCRtxCbjEiqiTeeJTEtXP/oyRj5gaBNrvAHjEKN?=
 =?us-ascii?Q?fbuC28kOaD49NEHiEPz4QV8Ftg0lSytlAdd4UEXzjd9b33t6aRqYUhA5hdoL?=
 =?us-ascii?Q?QK1xJ4UmsJ9oU4fZOXXZ6Bp3+azWWid3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:26.7725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba65c99-1742-4c0a-92c0-08dcd0b6eda5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074

Add new fields to support the new memory scheme page fault and extend
the token field to u64 as in the new scheme the token is 48 bit.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 48 +++++++++++++++++++-------------
 include/linux/mlx5/device.h      | 22 ++++++++++++++-
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 300504bf79d7..f01026d507a3 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -45,7 +45,7 @@
 /* Contains the details of a pagefault. */
 struct mlx5_pagefault {
 	u32			bytes_committed;
-	u32			token;
+	u64			token;
 	u8			event_subtype;
 	u8			type;
 	union {
@@ -74,6 +74,14 @@ struct mlx5_pagefault {
 			u32	rdma_op_len;
 			u64	rdma_va;
 		} rdma;
+		struct {
+			u64	va;
+			u32	mkey;
+			u32	fault_byte_count;
+			u32     prefetch_before_byte_count;
+			u32     prefetch_after_byte_count;
+			u8	flags;
+		} memory;
 	};
 
 	struct mlx5_ib_pf_eq	*eq;
@@ -1273,7 +1281,7 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 	if (ret)
 		mlx5_ib_err(
 			dev,
-			"Failed reading a WQE following page fault, error %d, wqe_index %x, qpn %x\n",
+			"Failed reading a WQE following page fault, error %d, wqe_index %x, qpn %llx\n",
 			ret, wqe_index, pfault->token);
 
 resolve_page_fault:
@@ -1332,13 +1340,13 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 	} else if (ret < 0 || pages_in_range(address, length) > ret) {
 		mlx5_ib_page_fault_resume(dev, pfault, 1);
 		if (ret != -ENOENT)
-			mlx5_ib_dbg(dev, "PAGE FAULT error %d. QP 0x%x, type: 0x%x\n",
+			mlx5_ib_dbg(dev, "PAGE FAULT error %d. QP 0x%llx, type: 0x%x\n",
 				    ret, pfault->token, pfault->type);
 		return;
 	}
 
 	mlx5_ib_page_fault_resume(dev, pfault, 0);
-	mlx5_ib_dbg(dev, "PAGE FAULT completed. QP 0x%x, type: 0x%x, prefetch_activated: %d\n",
+	mlx5_ib_dbg(dev, "PAGE FAULT completed. QP 0x%llx, type: 0x%x, prefetch_activated: %d\n",
 		    pfault->token, pfault->type,
 		    prefetch_activated);
 
@@ -1354,7 +1362,7 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 						    prefetch_len,
 						    &bytes_committed, NULL);
 		if (ret < 0 && ret != -EAGAIN) {
-			mlx5_ib_dbg(dev, "Prefetch failed. ret: %d, QP 0x%x, address: 0x%.16llx, length = 0x%.16x\n",
+			mlx5_ib_dbg(dev, "Prefetch failed. ret: %d, QP 0x%llx, address: 0x%.16llx, length = 0x%.16x\n",
 				    ret, pfault->token, address, prefetch_len);
 		}
 	}
@@ -1405,15 +1413,12 @@ static void mlx5_ib_eq_pf_process(struct mlx5_ib_pf_eq *eq)
 
 		pf_eqe = &eqe->data.page_fault;
 		pfault->event_subtype = eqe->sub_type;
-		pfault->bytes_committed = be32_to_cpu(pf_eqe->bytes_committed);
-
-		mlx5_ib_dbg(eq->dev,
-			    "PAGE_FAULT: subtype: 0x%02x, bytes_committed: 0x%06x\n",
-			    eqe->sub_type, pfault->bytes_committed);
 
 		switch (eqe->sub_type) {
 		case MLX5_PFAULT_SUBTYPE_RDMA:
 			/* RDMA based event */
+			pfault->bytes_committed =
+				be32_to_cpu(pf_eqe->rdma.bytes_committed);
 			pfault->type =
 				be32_to_cpu(pf_eqe->rdma.pftype_token) >> 24;
 			pfault->token =
@@ -1427,10 +1432,12 @@ static void mlx5_ib_eq_pf_process(struct mlx5_ib_pf_eq *eq)
 				be32_to_cpu(pf_eqe->rdma.rdma_op_len);
 			pfault->rdma.rdma_va =
 				be64_to_cpu(pf_eqe->rdma.rdma_va);
-			mlx5_ib_dbg(eq->dev,
-				    "PAGE_FAULT: type:0x%x, token: 0x%06x, r_key: 0x%08x\n",
-				    pfault->type, pfault->token,
-				    pfault->rdma.r_key);
+			mlx5_ib_dbg(
+				eq->dev,
+				"PAGE_FAULT: subtype: 0x%02x, bytes_committed: 0x%06x, type:0x%x, token: 0x%06llx, r_key: 0x%08x\n",
+				eqe->sub_type, pfault->bytes_committed,
+				pfault->type, pfault->token,
+				pfault->rdma.r_key);
 			mlx5_ib_dbg(eq->dev,
 				    "PAGE_FAULT: rdma_op_len: 0x%08x, rdma_va: 0x%016llx\n",
 				    pfault->rdma.rdma_op_len,
@@ -1439,6 +1446,8 @@ static void mlx5_ib_eq_pf_process(struct mlx5_ib_pf_eq *eq)
 
 		case MLX5_PFAULT_SUBTYPE_WQE:
 			/* WQE based event */
+			pfault->bytes_committed =
+				be32_to_cpu(pf_eqe->wqe.bytes_committed);
 			pfault->type =
 				(be32_to_cpu(pf_eqe->wqe.pftype_wq) >> 24) & 0x7;
 			pfault->token =
@@ -1450,11 +1459,12 @@ static void mlx5_ib_eq_pf_process(struct mlx5_ib_pf_eq *eq)
 				be16_to_cpu(pf_eqe->wqe.wqe_index);
 			pfault->wqe.packet_size =
 				be16_to_cpu(pf_eqe->wqe.packet_length);
-			mlx5_ib_dbg(eq->dev,
-				    "PAGE_FAULT: type:0x%x, token: 0x%06x, wq_num: 0x%06x, wqe_index: 0x%04x\n",
-				    pfault->type, pfault->token,
-				    pfault->wqe.wq_num,
-				    pfault->wqe.wqe_index);
+			mlx5_ib_dbg(
+				eq->dev,
+				"PAGE_FAULT: subtype: 0x%02x, bytes_committed: 0x%06x, type:0x%x, token: 0x%06llx, wq_num: 0x%06x, wqe_index: 0x%04x\n",
+				eqe->sub_type, pfault->bytes_committed,
+				pfault->type, pfault->token, pfault->wqe.wq_num,
+				pfault->wqe.wqe_index);
 			break;
 
 		default:
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index bd081f276654..154095256d0d 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -211,6 +211,7 @@ enum {
 enum {
 	MLX5_PFAULT_SUBTYPE_WQE = 0,
 	MLX5_PFAULT_SUBTYPE_RDMA = 1,
+	MLX5_PFAULT_SUBTYPE_MEMORY = 2,
 };
 
 enum wqe_page_fault_type {
@@ -646,10 +647,11 @@ struct mlx5_eqe_page_req {
 	__be32		rsvd1[5];
 };
 
+#define MEMORY_SCHEME_PAGE_FAULT_GRANULARITY 4096
 struct mlx5_eqe_page_fault {
-	__be32 bytes_committed;
 	union {
 		struct {
+			__be32  bytes_committed;
 			u16     reserved1;
 			__be16  wqe_index;
 			u16	reserved2;
@@ -659,6 +661,7 @@ struct mlx5_eqe_page_fault {
 			__be32  pftype_wq;
 		} __packed wqe;
 		struct {
+			__be32  bytes_committed;
 			__be32  r_key;
 			u16	reserved1;
 			__be16  packet_length;
@@ -666,6 +669,23 @@ struct mlx5_eqe_page_fault {
 			__be64  rdma_va;
 			__be32  pftype_token;
 		} __packed rdma;
+		struct {
+			u8      flags;
+			u8      reserved1;
+			__be16  post_demand_fault_pages;
+			__be16  pre_demand_fault_pages;
+			__be16  token47_32;
+			__be32  token31_0;
+			/*
+			 * FW changed from specifying the fault size in byte
+			 * count to 4k pages granularity. The size specified
+			 * in pages uses bits 31:12, to keep backward
+			 * compatibility.
+			 */
+			__be32 demand_fault_pages;
+			__be32  mkey;
+			__be64  va;
+		} __packed memory;
 	} __packed;
 } __packed;
 
-- 
2.17.2


