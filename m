Return-Path: <linux-rdma+bounces-4750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82E96C279
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7745928CA20
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299B1DFE06;
	Wed,  4 Sep 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fXjaHNEA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3591DEFC0
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463880; cv=fail; b=fbiGQWNnPmrfYoRhb0p34hxVEZvt3wY2v/kTaB+uv+HbX8OrCw5GPx/KXzBGiVH1jFDWULGnIJXFfwtpKXPTL1wkExXv+dy/hpIvcYGekap0+zAco+CD+GLmQq27FxtiHHUtZ0/XVWH/a0ouHVG7/UQNpYEMqfebEREokUZnoy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463880; c=relaxed/simple;
	bh=jPeiXjI37ANc39RDWrpbzn5xjmtlmGhKn/vQVj11IIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPVnYej1mVFs9OUY3GmIaPClTBFScaJW25XLKK8gKFbleVdwPXUJFXruIstjQpyKeWEb/jBJEPKI+hL94YiZ+u9X5Cc75zgnzjv76/jJCo24uoso3w+cKpc/+xTuRhzXiP2Ja0VpdTPwpDuVrW1NBhpNaCLy8eYxaFRkhaVFYQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fXjaHNEA; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRwFWocbHtg3aJxJxYlUWwSfNgfucYIpFI/1jmPWj2aSeOOQ1Aann7b0pj+Su7HW1h5/s3ksLLp4a1ip44FeUR6GFNt7k8r0wzakHzfgRvYe2MtlZbybjTAS5zIYFDmIgkk/xYWnX5cj8tNUyASWu6fobsTbP1mbLgZMjzvFsJnOhB1Z8SIkTbNws0DG59iAnU7WAGT7f0QB3sGLZ0EpTa4jlbSTYO5B/3mAzwKGqI3LnxrFZ1spj04sEl8yyfy8TpYBz6BAqwckACAx00Q9mlVoi4XxRCaV0C/C+jtSeCaTJ+wpG4DcZaoBJtoNQ9Teabuf2n3MTc4yYofVPCxI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+9e/SoPO2gjOMHZLXNmZsnaD9SS90hM6w7pGL1AZBQ=;
 b=wznFR3FlV0CsOplcMj98hTOb8GuhxEEcQXL2YPoVCmddvSiyYlf53VcVbF0d8ZWITasTlEHdjXWTXqTfocU38mQeVx3gMWf5YxoHPwsp6+qe72X890cb5KjFXZqTo/JKxD+BlJognE5qkTyGzZt7nLgqr2cwYCpr+8jXDQtzRFTbWwR6Az00/DWqxBcFw0w+Qw4FZcgcqPXS8QQ2ucf1GTZ9I2DmLVx9DbKlZ7aJAQqAx/tzQH1X8OF79ie6tpWnt4EYjqRzbrvwak57mLhx9HJXj1NmU20YSA4mymv4AIeKDz+WmIsES1xczBIE7UEPc5e/dvWHqXd0lekyxHfbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+9e/SoPO2gjOMHZLXNmZsnaD9SS90hM6w7pGL1AZBQ=;
 b=fXjaHNEAs2wQt+BtkuZqkPeXxYVWGI6pwSPMsjw+HJtE/1c6D1XX/xVOeRlel93G8+M2OV9f23JHPlFBXdTifMyJTsed4FoTBG9yDB+2EQDOMeWvEwUnk+hN1J+/h+65EabDXNjKnADm6RSbNzpeHUUChgSmXCtXzTJanid60tHJrbug0efBHq29PtUJdG8SpQbB1ZevFBllPGnE0dD4yD3XQNyPkG4mc9qFkdPzMnJRyXSKPN8W2o2YZYRQ2Gi0NvOWELlj2cZUxQtftHHz+5puRFEEkYtUEeZuVVikdNprpK4IdPPR+/paH+x67xuiVzWgqCuq34z86Ns4ORUxVw==
Received: from SJ0PR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:334::12)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:31:13 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::f1) by SJ0PR05CA0097.outlook.office365.com
 (2603:10b6:a03:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:55 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:54 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 6/8] RDMA/mlx5: Add handling for memory scheme page fault events
Date: Wed, 4 Sep 2024 18:30:36 +0300
Message-ID: <20240904153038.23054-7-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 991f3db8-b1eb-4f5b-60ae-08dcccf69c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2qMdBCsB62g5P5V0WhRUCDC0DuKiWzgmcJO0r6aXklkUmehygmEEPooDIZJ?=
 =?us-ascii?Q?MfkkjN67wUmUeR0J8Kv9NNILUDqVQxXq/ZXGV9Di3H8FldYKTrQEjhZrUXaG?=
 =?us-ascii?Q?IBtvlQItMnlCMEJlRtQ/HKG1SXP79RZuoSFA1kcZtzf/D3iQUVnSI8sPi7zX?=
 =?us-ascii?Q?8acRHv4f6PsAo2BmBARUSyFTnr7MZzNP4seJ2Dba8//x/gVrxsxNssXXBbsg?=
 =?us-ascii?Q?8m2q+KRLMMLtll3coBqDuIOZwht5VEM43LXWYpdwXgkXiNCjKt3WxJ5RwBII?=
 =?us-ascii?Q?w+BrMB+Kp5S0VMIQrUXS+lK69CS/z9KdAGbm5BW8APmxEFwzZB4bK9+yoQyk?=
 =?us-ascii?Q?Pnc4n7xlUF/N5W4cLV60hxCPL220xCsLh6PqCGd2V0n3mSpoDD+KCRQsjwVn?=
 =?us-ascii?Q?08zVv4VGEJ4otUM8K0BRuDwJqW7x1pOyfuD724DiY9sztdXhPni2KF69B4Mo?=
 =?us-ascii?Q?/WlS/ksIor6FQu+NvcDLUJEdUWPHzZLy1keUsBM3UGgq4w8RJas/5yJI2VTj?=
 =?us-ascii?Q?rSgfCoevzgUW81r3qduJOmCMoceisW/DchQwgRLzuG5ONGYkJIGj5JRI9ukQ?=
 =?us-ascii?Q?1vx+395RjbuzqFyWWfXcZACTrnm6e4P8IYVP+84OgAlpddv7Mwqjn1TOJQBt?=
 =?us-ascii?Q?MUp1+o927/qec348s2AuSk7J6aVZXhpgvL9pLimNhz/9CzoQvtCIzFO7hbgh?=
 =?us-ascii?Q?Zom7q4KrVtiOiykokFlTrL7JuKxNMy5IIBSef11qkmlwwsP1+wGT6N9h1nSp?=
 =?us-ascii?Q?6y4MCCPRCP0vDX2d3QQ3RcOHK98Js1QQbAodpT1lIqva8pJvJRMY5tR7IY5k?=
 =?us-ascii?Q?s0FQKWrmt8sWifaJzVK1x4RI3OB4nR1cqIRQj05wH4cD2iKVzGl7wQw5VVS5?=
 =?us-ascii?Q?kAH9LEMTvGDeJB4alnl5nEaJY9QK/NasfnldnhzUhF0anmAZnd/mXacViboN?=
 =?us-ascii?Q?EJP9oXO/DqJKjSR2oVV6J++Hc97XIFAv+VpAwtwIyqfQJOO0PUGdp17/TJab?=
 =?us-ascii?Q?PNs36mMnsLOLwM7+ZcwiWPRDjoHi4IgANryYlQi8h0XwOuv9+uy8Dn04a996?=
 =?us-ascii?Q?sGxWA/rrGIfu45wi+8BsK3tMLaatlV90kB7aJrVHhBsrhatGQjQjWTJTrBKC?=
 =?us-ascii?Q?hjl4rz35MgapjBfqR7fI2INBk8+5GYFpGZ3IrzRQft996BvR8ArvrVPcvC7t?=
 =?us-ascii?Q?PzBVjWYiJfAOj0OeS6JJrcgyRxPl8SYfpnFVzyDHjA+SI8kxqvE7WMprDRLp?=
 =?us-ascii?Q?SFBy2elmON3UKCiyJWTKER2ei4gzloKWYdRFj1daOLecjKeBHoqEPIfRK6Df?=
 =?us-ascii?Q?nfNsS8ZeqYKO6g7b6U19e2HEYb2Ip0cRx6Nv9IhnjtcTbSHk+S7l4rr5dqY2?=
 =?us-ascii?Q?zlkN01h1sEEgF/gXcn6D9iWPYXjMyi4HBVSWDtcguY80HP0g6+/teN9azr7c?=
 =?us-ascii?Q?fU7NQfE8kZMq3MO328wIxDddzjNDrFwV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:13.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991f3db8-b1eb-4f5b-60ae-08dcccf69c3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

The memory scheme page fault event is a new approch in handling page fault
on mkeys using the on-demand-paging feature.
The major shift in handling the page fault in this scheme is that the HW
is taking responsibilty for parsing the faulted mkey instead of the
previous approach where the driver would read and parse the wqes and
query the mkeys to get to the direct mkey that we need to handle.

Therefore, the event we get from FW in this scheme will contain the
direct mkey and address we need to handle and require much less work
from driver.

Additionally, to optimize performance, the FW can generate the event on
a memory area that is larger than the faulted memory operation is
requiring, to 'prefetch' memory that is around it and will likely be
used soon.

Unlike previous types of page fault, the memory page scheme fault does
not always require a resume command after handling the page fault as the FW
can post multiple events on same mkey and will set the 'last' flag only on
the page fault that requires the resume command.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 120 +++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 05b92f4cac0e..841725557f2a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -401,12 +401,24 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 
 	MLX5_SET(page_fault_resume_in, in, opcode, MLX5_CMD_OP_PAGE_FAULT_RESUME);
 
-	info = MLX5_ADDR_OF(page_fault_resume_in, in,
-			    page_fault_info.trans_page_fault_info);
-	MLX5_SET(trans_page_fault_info, info, page_fault_type, pfault->type);
-	MLX5_SET(trans_page_fault_info, info, fault_token, pfault->token);
-	MLX5_SET(trans_page_fault_info, info, wq_number, wq_num);
-	MLX5_SET(trans_page_fault_info, info, error, !!error);
+	if (pfault->event_subtype == MLX5_PFAULT_SUBTYPE_MEMORY) {
+		info = MLX5_ADDR_OF(page_fault_resume_in, in,
+				    page_fault_info.mem_page_fault_info);
+		MLX5_SET(mem_page_fault_info, info, fault_token_31_0,
+			 pfault->token & 0xffffffff);
+		MLX5_SET(mem_page_fault_info, info, fault_token_47_32,
+			 (pfault->token >> 32) & 0xffff);
+		MLX5_SET(mem_page_fault_info, info, error, !!error);
+	} else {
+		info = MLX5_ADDR_OF(page_fault_resume_in, in,
+				    page_fault_info.trans_page_fault_info);
+		MLX5_SET(trans_page_fault_info, info, page_fault_type,
+			 pfault->type);
+		MLX5_SET(trans_page_fault_info, info, fault_token,
+			 pfault->token);
+		MLX5_SET(trans_page_fault_info, info, wq_number, wq_num);
+		MLX5_SET(trans_page_fault_info, info, error, !!error);
+	}
 
 	err = mlx5_cmd_exec_in(dev->mdev, page_fault_resume, in);
 	if (err)
@@ -1388,6 +1400,63 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 	}
 }
 
+#define MLX5_MEMORY_PAGE_FAULT_FLAGS_LAST BIT(7)
+static void mlx5_ib_mr_memory_pfault_handler(struct mlx5_ib_dev *dev,
+					     struct mlx5_pagefault *pfault)
+{
+	u64 prefetch_va =
+		pfault->memory.va - pfault->memory.prefetch_before_byte_count;
+	size_t prefetch_size = pfault->memory.prefetch_before_byte_count +
+			       pfault->memory.fault_byte_count +
+			       pfault->memory.prefetch_after_byte_count;
+	struct mlx5_ib_mkey *mmkey;
+	struct mlx5_ib_mr *mr;
+	int ret = 0;
+
+	mmkey = find_odp_mkey(dev, pfault->memory.mkey);
+	if (IS_ERR(mmkey))
+		goto err;
+
+	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+
+	/* If prefetch fails, handle only demanded page fault */
+	ret = pagefault_mr(mr, prefetch_va, prefetch_size, NULL, 0, true);
+	if (ret < 0) {
+		ret = pagefault_mr(mr, pfault->memory.va,
+				   pfault->memory.fault_byte_count, NULL, 0,
+				   true);
+		if (ret < 0)
+			goto err;
+	}
+
+	mlx5_update_odp_stats(mr, faults, ret);
+	mlx5r_deref_odp_mkey(mmkey);
+
+	if (pfault->memory.flags & MLX5_MEMORY_PAGE_FAULT_FLAGS_LAST)
+		mlx5_ib_page_fault_resume(dev, pfault, 0);
+
+	mlx5_ib_dbg(
+		dev,
+		"PAGE FAULT completed %s. token 0x%llx, mkey: 0x%x, va: 0x%llx, byte_count: 0x%x\n",
+		pfault->memory.flags & MLX5_MEMORY_PAGE_FAULT_FLAGS_LAST ?
+			"" :
+			"without resume cmd",
+		pfault->token, pfault->memory.mkey, pfault->memory.va,
+		pfault->memory.fault_byte_count);
+
+	return;
+
+err:
+	if (!IS_ERR(mmkey))
+		mlx5r_deref_odp_mkey(mmkey);
+	mlx5_ib_page_fault_resume(dev, pfault, 1);
+	mlx5_ib_dbg(
+		dev,
+		"PAGE FAULT error. token 0x%llx, mkey: 0x%x, va: 0x%llx, byte_count: 0x%x, err: %d\n",
+		pfault->token, pfault->memory.mkey, pfault->memory.va,
+		pfault->memory.fault_byte_count, ret);
+}
+
 static void mlx5_ib_pfault(struct mlx5_ib_dev *dev, struct mlx5_pagefault *pfault)
 {
 	u8 event_subtype = pfault->event_subtype;
@@ -1399,6 +1468,9 @@ static void mlx5_ib_pfault(struct mlx5_ib_dev *dev, struct mlx5_pagefault *pfaul
 	case MLX5_PFAULT_SUBTYPE_RDMA:
 		mlx5_ib_mr_rdma_pfault_handler(dev, pfault);
 		break;
+	case MLX5_PFAULT_SUBTYPE_MEMORY:
+		mlx5_ib_mr_memory_pfault_handler(dev, pfault);
+		break;
 	default:
 		mlx5_ib_err(dev, "Invalid page fault event subtype: 0x%x\n",
 			    event_subtype);
@@ -1417,6 +1489,7 @@ static void mlx5_ib_eqe_pf_action(struct work_struct *work)
 	mempool_free(pfault, eq->pool);
 }
 
+#define MEMORY_SCHEME_PAGE_FAULT_GRANULARITY 4096
 static void mlx5_ib_eq_pf_process(struct mlx5_ib_pf_eq *eq)
 {
 	struct mlx5_eqe_page_fault *pf_eqe;
@@ -1487,6 +1560,41 @@ static void mlx5_ib_eq_pf_process(struct mlx5_ib_pf_eq *eq)
 				pfault->wqe.wqe_index);
 			break;
 
+		case MLX5_PFAULT_SUBTYPE_MEMORY:
+			/* Memory based event */
+			pfault->bytes_committed = 0;
+			pfault->token =
+				be32_to_cpu(pf_eqe->memory.token31_0) |
+				((u64)be16_to_cpu(pf_eqe->memory.token47_32)
+				 << 32);
+			pfault->memory.va = be64_to_cpu(pf_eqe->memory.va);
+			pfault->memory.mkey = be32_to_cpu(pf_eqe->memory.mkey);
+			pfault->memory.fault_byte_count = (be32_to_cpu(
+				pf_eqe->memory.demand_fault_pages) >> 12) *
+				MEMORY_SCHEME_PAGE_FAULT_GRANULARITY;
+			pfault->memory.prefetch_before_byte_count =
+				be16_to_cpu(
+					pf_eqe->memory.pre_demand_fault_pages) *
+				MEMORY_SCHEME_PAGE_FAULT_GRANULARITY;
+			pfault->memory.prefetch_after_byte_count =
+				be16_to_cpu(
+					pf_eqe->memory.post_demand_fault_pages) *
+				MEMORY_SCHEME_PAGE_FAULT_GRANULARITY;
+			pfault->memory.flags = pf_eqe->memory.flags;
+			mlx5_ib_dbg(
+				eq->dev,
+				"PAGE_FAULT: subtype: 0x%02x, token: 0x%06llx, mkey: 0x%06x, fault_byte_count: 0x%06x, va: 0x%016llx, flags: 0x%02x\n",
+				eqe->sub_type, pfault->token,
+				pfault->memory.mkey,
+				pfault->memory.fault_byte_count,
+				pfault->memory.va, pfault->memory.flags);
+			mlx5_ib_dbg(
+				eq->dev,
+				"PAGE_FAULT: prefetch size: before: 0x%06x, after 0x%06x\n",
+				pfault->memory.prefetch_before_byte_count,
+				pfault->memory.prefetch_after_byte_count);
+			break;
+
 		default:
 			mlx5_ib_warn(eq->dev,
 				     "Unsupported page fault event sub-type: 0x%02hhx\n",
-- 
2.17.2


