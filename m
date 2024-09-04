Return-Path: <linux-rdma+bounces-4745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9A96C275
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922671F26399
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485621DC754;
	Wed,  4 Sep 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQqGP49d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01E1DEFCD
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463870; cv=fail; b=pRMJdI3hmiiZw7YDLeKXn05mgst0+Tb964Z4uEjM+em/jNCbiJeM2vW+0c2a1Z9RFKRPjJmRUsW+2i9BTuvUEO5N3ew29QEopsqW1MjihVGBcXpa+nDmpnc9PGtAx5PqhtyOKUVpX/DKzHRYco4cjFaLxgvd4FZ4UTEPrYevjpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463870; c=relaxed/simple;
	bh=udtOONpfnz7kqLOsQgZy4dXS2FqgNLoCyozCvWdqiPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6TSOp16PyLaKCYP3/1O9iEcHaYktIFMOPf7HvQhC2WfzWPr1XNkF3bCReEw4BsjyPkb2iRllRofHVALjOTZFbYhWXyPVJUqJ/nCLiaCJt69Be0xyckJzzEGS1Dk71rIzwSZFJMWT4i9vG+NG5HnMO8vAFBcu4kbh7iuPSVHVBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQqGP49d; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR8hdPqsCYkX5JoMFL8HZZxNGyEj28ToFdKZZHYFAaZjo8HxPB70h8oqYgz+E74lK69aoiILGT/Ur+tWs21NHzDuYT4p77RfGLJnF65XJC9RDzv5f6ExtHdOR8VcvkDXfoyoU0CJr32RO/IXr07cZvKcmrl8OJvcD8OgTxPGG+jzhquJ0D5kYBEUEsc6JZ5SbIKVDDuPpdAZDd6L5gwII3ef7YsJKnHx2dhHMUC+nGOVkmfdpJI9pTmqSCW95jfBWD4YbQHIXXLexwGoseLdHaDKMPkF5mudJ9zfWw2RTBykn0SUBZ4KonPX58Vn+QFXc90O0L26MnBmDWhLMhyF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VVsmCBsTbmoNEDvOisP0DU0vksXfNKdqLnxNPQrtAo=;
 b=J7l7ISfpsMLPd4COR/w/7mmpVCbHScsng6YF/6yZypvxjtipuPLobHHUx8nLFhfsvsmuShCtffH9kkLJo1RVReEW5Rycq07mLobuaQp96UWbroP4DVKQlNI8opj5Yp6JCIYzxmWr3ExcpDDKEdlFCYfLKXfPUu6ip7yzNH3J4p3hG/xNAQwV5j1gXK7QHaheWFgPGM8ZrkPGKIroyBbqgIrEwJ2pdyb5/oOAvblQIAbvBEQA/f2zMYudNsrHRSaslCsk/fQi5DPf5ReUYHyC4e4NYk9R05t1VnnOsPjcoSCAuHMKx9rrF9qVTNZNXi6KSmjj/mh3CpbtUKsaWhtFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VVsmCBsTbmoNEDvOisP0DU0vksXfNKdqLnxNPQrtAo=;
 b=nQqGP49dEWavXICi3IN0D9Cy1ZHdLyWPDUIOUzJTw1yaVUMoYeJYQ5E9eKolHMFNN5iTFuIyJdhnX/ucYv/7ZA9hRhpjDxsQCE/GZQ/HwZa06y6gPL6MulCtmTieAq91l98oM5i6dwdMa/queYm5TnoxVRQub/MU0CO/M43IaKKsut6obtFQCUq0lWLoDYLm3c3rhXaEUg+Zz/hLI2/LXIcjCF4D3gUsQ9rcxvCOnNnND2GtB81PlGBkg+8nf8l8t2EKMibVVmuPq/T89dwtzaIhVRiTu0OOpKXLjVGYI6EqkK09wZBiC3dFOoFGWLex1dhbdWgPE/+z5KznmlDX/A==
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 15:31:02 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::e6) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:49 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:47 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 3/8] RDMA/mlx5: Add new ODP memory scheme eqe format
Date: Wed, 4 Sep 2024 18:30:33 +0300
Message-ID: <20240904153038.23054-4-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: e96aa37f-74e9-46a4-e652-08dcccf69579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FNkLHH1DP/IjFTAZnx/Nna1fztv4eyrGLqD8+YTSpovsr3391IqjZuov+ixy?=
 =?us-ascii?Q?y2ZmWDvgltMmbKbwP9DGZed2mMR4i1xheR8hwiTMhMI8NQN1KxoBCASPZxAX?=
 =?us-ascii?Q?FopF/LAmZ0bQf7SzFkRBA8L/5qGo6+xUn/OmE3XDHCC8OTHiIn8mtNrvc4mZ?=
 =?us-ascii?Q?Po4924qR0+52VnaMCG/BsYHzvw1YApstUydqoCmJDsY8tVHZt2FLNAYBLQsD?=
 =?us-ascii?Q?ydyAR1qWPe4uDTHZ3oSwYaO6BIJeeObDu+By4rU+lzER5inxy363XlntBZWN?=
 =?us-ascii?Q?L/BZuR3bS5moXZcv6YQj0UFlhCQaP+gwPzN7kxYZ46ZwX33oev0M3kzAs4Pb?=
 =?us-ascii?Q?PFY60GV475AtUNUyWJ1gcJbr2q6qe9cMSdyrotTqpISmrJCYRU4JJLIiqrSF?=
 =?us-ascii?Q?jyjN7qFuaInazNJRYGw56riQW+/M/z0anRc0+/yxcPU93UDjye+CIuEvdP+f?=
 =?us-ascii?Q?2co7Jwei3lMDkHWiLsoG17P2dIDqYEGNx1OxVkoMLv/XnfXPRqDJqMJjlpxv?=
 =?us-ascii?Q?dortJ93b1ZZjD1YLgKKVnz+CpbIE8a5p/LoNq8VJWI65dXR4/n2TD+/VJja2?=
 =?us-ascii?Q?6qbt9ERFvrgOX0msyoJFpEVKEfms74NMHZNkjyHxVueMiUK8EBf6GxIRfCuD?=
 =?us-ascii?Q?DIZwfB+v4J1DZnsLBuQurX1zTTa5IEAK0ouj2yNRl8XAC+/60SUvkcbxz7Gs?=
 =?us-ascii?Q?Cd/D6TPYkjye6gKheA8AC6zFhIPJP7YsdtaxY2cIRKUalh3crZH4/RQswmLv?=
 =?us-ascii?Q?pUKZ6FOx8PWL0vbLdl3NT6S0JaYtvCO4dK12I5MTxAtduCiLC60yK44DmmJ0?=
 =?us-ascii?Q?2TJ4TAK8+u9Zn0Ccvg70nZsJkfg3RpsYv33uVBZqhjIQCADYwYLOvl8kU5Nb?=
 =?us-ascii?Q?aqRXldx/eJzDuP6IKMCauhBd+jKrsa5sW7tzH6GBc5ZF+4NuMEyLMgoNfQOL?=
 =?us-ascii?Q?ut/8yAmyxAmwwYOyjuzDTnSTJkLrBXgrFx4v471/java6aQrwcj3nbEvwsRC?=
 =?us-ascii?Q?KXjZP0P3wRIvcyJTBGr4e+5MVme63fJrbnB32jgv4+9qZUa4aLtdImV3PHqT?=
 =?us-ascii?Q?ExQcySFB8bE+OL19e3h51I0vqcYod3vmXqcHmlKokjTWPK+884sNb7eWheON?=
 =?us-ascii?Q?U6AnsdNJcX4prXdScbXkQLrriwyJYHcPCiAS0gLKbL0gVkwrmgm99JSzYypy?=
 =?us-ascii?Q?hJWqYMcsd47o0nIfLuAPBiaZgRgoWcWZ0Z8p0KMWT+olCSE7Y1oEQbRmG669?=
 =?us-ascii?Q?6DCkzkhiy8WsG6zfrzONQy4zU4RIV5TjQk+1wwYQsQhY4RSBF2RYtvKZh2vG?=
 =?us-ascii?Q?lJN50vecw5udl7y/gUo7UcONYl/L/wXQkpJNPxZjDzLCsYUHClhKIcMQzJEA?=
 =?us-ascii?Q?+Ra/rc5PHLTRzF/F+o4Q8/wFdxPFbTeDq+ikB/I4sSn6+FYZOZvZMRAClED/?=
 =?us-ascii?Q?+wlQS7K1G2VSOnhwTtHUYBEiLiwEdjJS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:02.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96aa37f-74e9-46a4-e652-08dcccf69579
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

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


