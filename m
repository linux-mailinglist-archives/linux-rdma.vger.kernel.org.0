Return-Path: <linux-rdma+bounces-4826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA379714D0
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC01F22151
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9AF1B3F1C;
	Mon,  9 Sep 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6Gvn7M3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F661B3B23
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876341; cv=fail; b=JPZcEcQG1qpk8q72hIaSJN2m/lyExF39ubBEqqb5EfwWiHnJ6BUfvVPARAdKp7437905kitlb921/BtIBl43iaCscpZ6F4n5NHoXCYmzjp97psXlEXRZ+tQNw0V61FmUmqpsu3fBnHpgIrxIbzxqo1NygjhLy+NmKZ1w1wimXoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876341; c=relaxed/simple;
	bh=jPeiXjI37ANc39RDWrpbzn5xjmtlmGhKn/vQVj11IIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXtYV+Tj0qtvlm7rDcTRT8GCD1GrhqCRWbIlgdGLKZ8mYG2IioNU+sQ7+s4IUdihA0ppqIJADNSy74w1ClxPhtCVDjAL0sM2Gxzkcl6WSlYWau3oLUAPGkWWUGrLZScRBB/FQKjcn5De88aceB/3WOraHLP3xK/QMVHmKlTVlCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6Gvn7M3; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW4cOCz/06+hHLJpjbp4LcAyDmugsoyYuLYbTNvzkLieFP79whbQfY+jDGks13oX1BCU0C61rg1ex++HXih/VJW1JFDes9cRbArpkelybisMOXGTiJQy3zrtg5HJogPDLHhq+tLRTvM6XU4nyPF9pEKr8R2/DBQQJeww5hSZ+XWsNDjMavWypo5uCbz+bu6Jc3yEdJuDoHOtQe9HW6kI2B1UUmKqk09AqNbbApGsBmNzFWHjTOL/jK0wLNT9Nqqi5QFUj2cB3koQlWpsBLDaKtWufWXUAk7f1gAy1W6JyW9Q9bWX0e+Enb33ukcH+SK5aRrf1oVkynKdrxPSh9cX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+9e/SoPO2gjOMHZLXNmZsnaD9SS90hM6w7pGL1AZBQ=;
 b=HtxuMu4oCiN7Ql/+i+R0emHraHsvNhfuDvpiyovR56VvKOBSStL9QUwaSV153h2mJqOEoKnKpz87ZtTNCI7xBhvEH3jDN9W7xEnfDmCzbm3alv6VI2ZFbG6LnIRM4h8Ce0OICAEVcj4o6gzNb85y4I8tZTbdR/CCzVY95zjv028GrOI/b+uqUiArxEOcy4p0BJ9/smoFbZ/4T741sLvGREQB/8xWuiiiJvH1KXvfOq1zBBcqQKE+DDjNa24VAAed8qoKmy069WdHAkpTHCU0/LfQL+WDgfJHpjsdN2z/kYPIunSikO2qbMAGu01PCGGPFt2xIzVaWbso7kQ6QodyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+9e/SoPO2gjOMHZLXNmZsnaD9SS90hM6w7pGL1AZBQ=;
 b=V6Gvn7M3H4dkn0xfw8V2R+xkwi7Qqm9phwrVvw+jpkazxD3ZQj7Rqc7PNGtqmkEOWqRmP5lh42DTWbAiMCQ3uin7IeXfBs2HlvvAXtvocKImky2bQ/1sL/JhrnkANlfwmedtYvbFYuCLUCC9gQKOHtXI7/zinTxa441wAfMagdy4Z2yyb/HKx4zoc6A3bsUI7fr7U/MGv1uAW4TRbvAJ/HAVE2Lb28vTjATZms3PTWC3bdDP6/GLokRhsmtog8hq2q77Jmr/JkYjt7AXB5OXtCTMUeaMkGoY2QJFICWy0lM3aJiegiHgn70TEpAA+4ErT046mc6izYbkiSs/i4hTfA==
Received: from PH8PR07CA0004.namprd07.prod.outlook.com (2603:10b6:510:2cd::13)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 10:05:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::cc) by PH8PR07CA0004.outlook.office365.com
 (2603:10b6:510:2cd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:20 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:19 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 6/8] RDMA/mlx5: Add handling for memory scheme page fault events
Date: Mon, 9 Sep 2024 13:05:02 +0300
Message-ID: <20240909100504.29797-7-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b107d5-8a28-41a9-fb24-08dcd0b6f278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0U1pVxY2Rqb+XZCUFiDEg0tDsHsHH58+b/4+9RN68qcGcjRyCxG1i0bWkfr3?=
 =?us-ascii?Q?/jACTIkYElWdiNyz3hvXDSufVREY6Xdn76uHflgzL8/zXQ25aeUlsAscBBic?=
 =?us-ascii?Q?LzxnCpt1ujBNNXtq5ZrYM+JFOcbo8MxG9ENDbor5lYVItLG2GHKMUl1AC1aN?=
 =?us-ascii?Q?rMW5jiQFFbKqjX2cg+3Cz60A8VGplgzSCbwJcjNgGAc6maHAVjHbz9CwEFl0?=
 =?us-ascii?Q?H7IEXt/wrBBbqMtZ5a3E4oFVuIkcGRbXPNC7xM/zVByWB2Z9D1hSCGDh//Bg?=
 =?us-ascii?Q?lvRSBN3ykD44JPAUWhXZ0cDyk5fvYdWniohbeP0mp+wuNg6W5mCIo0STseS8?=
 =?us-ascii?Q?iHmmW6nh7cGW0Krdy41qzS+5IQaKoTl8BU08f3wzJytCXsxFgslow61eArwb?=
 =?us-ascii?Q?yj3cz6dq8n7oEabNvBC0GaVJxvjkTeFOEuF2xK4PFwbBFNj4+xwJH1OxXCBp?=
 =?us-ascii?Q?yagby2JTZbj5mJb44E1A1nDrnzxddLeOurBhVdpX/apSCcw5pbtPA871JcV2?=
 =?us-ascii?Q?HvNygbyKmm5aHHbqttC6rTccGiEqKDfIzDLiHUhjXMpFZL06pXPOFdLgfUOf?=
 =?us-ascii?Q?mWg+psEDjFZ1C3VaS1dogXI8VJLjNhayupjjhZ/0/AKWeY0771gcjUkMYpXP?=
 =?us-ascii?Q?6olp2SOPxWisdm9NWg7rBpD+hi+opo+0RuTmwlmxmZbYcp2I9vUq33MaOPY6?=
 =?us-ascii?Q?dPoFJO/qyEDYx32PPJ3fwLuTjcanbe6f8IlhN4V3gdJoY0B/d38/bSpFLUGJ?=
 =?us-ascii?Q?4s/gkLGyJzMyDkMPO9pJ4VvscqGgvmuajdBkeJ6sfDQVrV3elQQEWcP3jirt?=
 =?us-ascii?Q?emxHYBpTEkyaaTp/2q5qLlNeVNS5efk1TQXJCdHqJRaB74C3IYrKFiWihnJ4?=
 =?us-ascii?Q?1s2Uv1x10jqmG4sI5LUnpFhTKag2hZhva19Anuj22jNbamIhJv6puwgeHMsq?=
 =?us-ascii?Q?huW3yG5tTcWvGz8gE4wKa/wF+Bg5DBDA1H5r8kx/fsXon3oBXNVOHe5heRXt?=
 =?us-ascii?Q?jw/BtLRGeQh+sFq+ahTbutpo3YrUX83tbCgpe2R0nQfbKFQ4tz6D96xDo9Dk?=
 =?us-ascii?Q?JJANmcehiiY94Dlsyt4ZkIzXWJF9toFad1o1j2NlkD07pknl/wGqAbnsagR8?=
 =?us-ascii?Q?hWu38Nf/1WxbWFxXBHH0QVIpLxfglaDrblF4XONMk81j8dx4gvGqakJujgmJ?=
 =?us-ascii?Q?zXD5gLz1m7FzSJT124enNvVxPVAas/8VWFTIJUNuJ9Fzr5g7E6vqdUWD/PZq?=
 =?us-ascii?Q?5VP+tI1cg8Ysm9mZqG24jm8DJKtHTtUULiYxpLBOJgENHRolONhi9+2t9kte?=
 =?us-ascii?Q?F0DLRSC1R37kpQc/6YA8pPKtyp0KUDYHPLJ0gM40Yj5QCWHV5Jw4eDOAccao?=
 =?us-ascii?Q?lehdP6qWJdw67qdE2nqr3ZlrLZzs8uEW4kZhdVup4Eq5tAUOWzJzmR0mI2AV?=
 =?us-ascii?Q?rQrqiymvXfpgGwRf7fguhtGjh107XmLv?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:34.9314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b107d5-8a28-41a9-fb24-08dcd0b6f278
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857

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


