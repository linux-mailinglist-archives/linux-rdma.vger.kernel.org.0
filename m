Return-Path: <linux-rdma+bounces-4824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B29714CE
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FBA1C230C3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F71B3F00;
	Mon,  9 Sep 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dPW2EBGG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4E1B373F
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876336; cv=fail; b=hyTucuIzTo+fskX1sYp6NgKSKc5MUukd/GgwnKUIQOc8r9tQy5CCe4MuybQwHMsLANFwi5cn4bhpeXLt7KnCRp+2hN4dX5kuAPURc9LOBsdt7256mftYcU8XVj0M9blTi4sRw8X/z9HSfG+ka/5/2wJN8Bv43e1d9jRnPSeX5/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876336; c=relaxed/simple;
	bh=BUFmWbS9FKrS39yLkH2iuk0nOTBFDgj893f2A0hrvPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zpg7i7OrLZ18tMIBtJ8LFc4miLWiqN5ed8pnp/6tSaJreRJc1wrKVPaMVzv/3QFaHWij30Z5KIlvfxvrwWf4vtNu6XxrxcxJ19lt3gX09AbNiGCcVIAtXWGZtpegjSLuq2Zs3r4oX0uj3U4onzLoZUVWwprs1Du92/s5VXPR+1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dPW2EBGG; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBtpBuH7TGfcgZAWfly4f+TYa9Q/ttQqSydZG6mlZ+JCoSPr2XW5Ok5bCGpOn9DFXN/k1gxfFZZnn9mCpbVPNW1hWhpuNZArH+PmkQ65Yu9HxJbaU7aL6lW5I6Lsx/WRlQ5mj4Z+JyzDqcmPkmNmobZVdgrsbZpiKeKiU05pCSgLH7Tut9tcBBge8umkEQdgMTLL0fMqFhANMLpksfEMDleGlcuGef5pRVIDLCcXK6uUX+i/Gv9Hp4aRGx6+LqTuSngmkLMr4Y6wzfBOvqlghIO8GN6PmMkXQo21JL8Co6EtlnDzxCOEf6c9OnEER9IqbsRlXkLm5gjN9C1m/eKH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkwQYRhdbg7/r4cMwsxk5qyL1NVCqzgjNM0m4JkjMMs=;
 b=xeTupMZUIw7kATVTuArC8M+ip3jWS2xU7QvoYJ2wR3owLfol2EzH+sNaQ19pa44pdnf3DN3Ac/mKZqkLAF/zwuFm7twdxLvH97mBgr0MJ0MtRVT1OnErcyTNyPvX+BnohVRni3UTZZPCPpzCxoQBaNJwKO0CxFfnNupeEkfey7zAYO/pEBGkL3DbI8BArIH/dR++CtR/mVrCPDtaGxXZ+5jZYBiwqfBCStva/MrwfU9e5bCOZ7ohgKc1MNwACcM4Hf+n+YmCCCKslG8TiPaYlr0oFK2D6UaUd69asc+lZPNPcuOnvmm18KTZQpSlVtqlVh/NlPImTXaLbt/vaG8hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkwQYRhdbg7/r4cMwsxk5qyL1NVCqzgjNM0m4JkjMMs=;
 b=dPW2EBGGZLAw+eRJ5OKlr1LphSnAWciDuKAIl7DwCS8CIrC22FRYl8Dy3WbSsytcCrefWYMG6jG2V+01snqH0CWdZotdeAm14+i5P5jaNMaUrec7m6aJmX9yfW5YN7dGSFtPgXSbq0yrGZe3AiS9KmI3IeGrXFJdbuvbYg2cdnaj/22ell1/noFhoQg/EFs1Di0RUcYxanG/vXtTZR62fH8UgwtCGyISwgEITddTBhYKajnn7CHfhw6pS1veMA9fI1s7cibIVOZsV5yP48iXgCCmdcv7Z+oKGaALYbdbYMehIekDGbqm2/8XLpxsnhGbdVszUwW18CCAYO6djEkg3g==
Received: from BL0PR02CA0064.namprd02.prod.outlook.com (2603:10b6:207:3d::41)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 10:05:28 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::75) by BL0PR02CA0064.outlook.office365.com
 (2603:10b6:207:3d::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:16 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:15 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 4/8] RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
Date: Mon, 9 Sep 2024 13:05:00 +0300
Message-ID: <20240909100504.29797-5-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: a0872a40-ed70-4607-3b26-08dcd0b6ee70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqPp3V2+3G9osT4UMxV/sohlZOzNqQN1uRk91uXTfEwiru35yp8FB6ZbjWJ/?=
 =?us-ascii?Q?ECsdZ5wM0bsrYJFuBG/SLQmbDR56Fe0pIYX81IxjYsJCK5G8cj+Yck51fzfQ?=
 =?us-ascii?Q?K+rxxCEK63nRhz9SdvRgZ9GvMRq0jYVha1X3Ya8RzW1VMWuggr7CmI1/FPZ1?=
 =?us-ascii?Q?86FbWJYzDWh7bR/ilXAsizkZXkDHoXnR7nB+d7cZ6cmhneHAtIt6drJIL1nl?=
 =?us-ascii?Q?LoITGiftOriDBfHMJ9ERiKggXB+Dll/HNKB7Swfpx5wML7HhPRVcAq0Vetgu?=
 =?us-ascii?Q?fUoaOI5GKVst6zq2bWSO7AADvEzCkP77ibnQtUb7Vz67KVDiU/JNG/ROxYMm?=
 =?us-ascii?Q?pUHkWLqNpM7A/lJeMaVkjfakYof8n/oa6fzEw4yNkLS+Ml5bJL04YYAXJ4s5?=
 =?us-ascii?Q?9WeNR9u83kFfwulkcOyDbWOt3SSS0rpgmkqCVTRD1ToK2lSbgC8kMlkggZ2r?=
 =?us-ascii?Q?dsLmLoak8V6UD3xHp7sAHxw6Hcmw2IuT3RbXMSDBEjEF1uyReITlEoVsyDGh?=
 =?us-ascii?Q?bOBFerDWlmHa4hOVRU5Uux6W1jE+P+S4inpwX2uDT6pzTn83Wf/5PlJVk/eD?=
 =?us-ascii?Q?naaFh01gV+LIdSF+eABqhUQWwLuvNw11fkYYtVxlmVMH1DJ9fHkTCqkV4aPt?=
 =?us-ascii?Q?ELPSc6vm1DN61lw9wLM8X/RinYYoz8d2PU3NoPhjLqGNwPtesKaNkIsCN3q5?=
 =?us-ascii?Q?JOguX21eCOLv72Jf8a3q4tKb5UM/tSARDNxeMuXWyOUD/NAAf24bJoKIsWFu?=
 =?us-ascii?Q?rgU4GDgOh6VG/83bohGx7D9DI9qMGGnUIsP2DNrOExlMrCXyodNeAhYe/f6x?=
 =?us-ascii?Q?R0bM8zc1RX60Ue7qA3zKh0+lyzLS+wLwgdOtjeyRQu61+iIJrb3JWf1ov5EI?=
 =?us-ascii?Q?dqkyHuFbhq+/4fsMHMW7By6kN0d3yb+ZpP4aeUgfG2jEBeZG5qXBLyc5M2OV?=
 =?us-ascii?Q?QTIwIyzm1ObRTZ7VLNDBTpdeyzrZxsbTw2MTu5LSmEM2EQ1JIAEk1ehLtL2A?=
 =?us-ascii?Q?+8zA5bQ2Ky4kGVARHBoCYhdZ29aHr/0BjJke1z7hBik/ooyVATCUnuwa+SzP?=
 =?us-ascii?Q?QHKGr+hTUeaE2bW496SpvCIZJVW0OV6ZbcqCePDG47K+IpegYOBoEDqPmfJj?=
 =?us-ascii?Q?6+7PpfeM0lKP1+YbL5L5S65kY5ZAdsdvwxOQsG83CVYfW9fhInOzu4KsWaVO?=
 =?us-ascii?Q?6XLe/RGb45pL0ZYRBmkxQOqhYrvX4gtH+BzDCjPZpKnBU1hqtizMZi+6wIL7?=
 =?us-ascii?Q?skttyX0HY6hWZrD3S3VYsuakfwsfHSliYN41W8y3uC4YRr3zhyV9ahOORkY4?=
 =?us-ascii?Q?+dOKyYxqxxhNbyv9p7PcvUZ9HyVONBAj/E4i1SfdcUQSKUnP32H0FseCaMur?=
 =?us-ascii?Q?LfB1KDcel0gs4Nt5mwVA/DwHu13uAUINiVDRAbQsUk9P53K14iKJTNCLWwRv?=
 =?us-ascii?Q?UhfDS48LYPA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:28.0850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0872a40-ed70-4607-3b26-08dcd0b6ee70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

The new memory scheme page faults are requesting the driver to fetch
additinal pages to the faulted memory access.
This is done in order to prefetch pages before and after the area that
got the page fault, assuming this will reduce the total amount of page
faults.

The driver should ensure it handles only the pages that are within the
umem range.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f01026d507a3..20ad2616bed0 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -748,24 +748,31 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
  *  >0: Number of pages mapped
  */
 static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
-			u32 *bytes_mapped, u32 flags)
+			u32 *bytes_mapped, u32 flags, bool permissive_fault)
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
 
-	if (unlikely(io_virt < mr->ibmr.iova))
+	if (unlikely(io_virt < mr->ibmr.iova) && !permissive_fault)
 		return -EFAULT;
 
 	if (mr->umem->is_dmabuf)
 		return pagefault_dmabuf_mr(mr, bcnt, bytes_mapped, flags);
 
 	if (!odp->is_implicit_odp) {
+		u64 offset = io_virt < mr->ibmr.iova ? 0 : io_virt - mr->ibmr.iova;
 		u64 user_va;
 
-		if (check_add_overflow(io_virt - mr->ibmr.iova,
-				       (u64)odp->umem.address, &user_va))
+		if (check_add_overflow(offset, (u64)odp->umem.address,
+				       &user_va))
 			return -EFAULT;
-		if (unlikely(user_va >= ib_umem_end(odp) ||
-			     ib_umem_end(odp) - user_va < bcnt))
+
+		if (permissive_fault) {
+			if (user_va < ib_umem_start(odp))
+				user_va = ib_umem_start(odp);
+			if ((user_va + bcnt) > ib_umem_end(odp))
+				bcnt = ib_umem_end(odp) - user_va;
+		} else if (unlikely(user_va >= ib_umem_end(odp) ||
+				    ib_umem_end(odp) - user_va < bcnt))
 			return -EFAULT;
 		return pagefault_real_mr(mr, odp, user_va, bcnt, bytes_mapped,
 					 flags);
@@ -872,7 +879,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
-		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0);
+		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0, false);
 		if (ret < 0)
 			goto end;
 
@@ -1727,7 +1734,7 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 	for (i = 0; i < work->num_sge; ++i) {
 		ret = pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
 				   work->frags[i].length, &bytes_mapped,
-				   work->pf_flags);
+				   work->pf_flags, false);
 		if (ret <= 0)
 			continue;
 		mlx5_update_odp_stats(work->frags[i].mr, prefetch, ret);
@@ -1778,7 +1785,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 		if (IS_ERR(mr))
 			return PTR_ERR(mr);
 		ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
-				   &bytes_mapped, pf_flags);
+				   &bytes_mapped, pf_flags, false);
 		if (ret < 0) {
 			mlx5r_deref_odp_mkey(&mr->mmkey);
 			return ret;
-- 
2.17.2


