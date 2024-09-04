Return-Path: <linux-rdma+bounces-4747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B996C277
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5751C21FA9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55A1DEFCB;
	Wed,  4 Sep 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHj/QH8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFE1DEFF3
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463874; cv=fail; b=DCk9VJDKnbuvXQIWKj85/8z/LiezKghmTpGquqI5pErd+J2fIeiEkSvdBz/9E10tGRZkqQUqHQFss1pljGZQtBpdnGkNI6ZTP5PZZZIjB3vXB1K0jJfoYUjHXxoV7aKBSfE+YPxcgu9h2oGjrg/id2fmSPCNcXY8kDGZ6yRSD1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463874; c=relaxed/simple;
	bh=BUFmWbS9FKrS39yLkH2iuk0nOTBFDgj893f2A0hrvPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enwdXcUF241GmMHDb48mlfL/yeN8sC25zSECfVR00Hpl9pKNFy+aJNEyOCMMttCDW4HDSelL2xTNd+Karyh7C0VHwgcXHzx1NUee5QXk6HDhYrydYrOEjQdI+E7WFE3B5tUKpAyJFNwqoUbQ8nrlQhYjwjzybW76aBt+xbpgob0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHj/QH8O; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR1CMiHEu29jfG8+sUH1qFfA+VgVUF0IKyd5s+KJiQdFO9BQzCkbhGGVodL3Umc0N4ssb/pCRl2VPFlkYpBtxlOGjfZmodYO7HO1hbtJffA2FUob+9uisGuoTTRa4VtXsSn2Qy7nzXn71UBMBsi96hSeHnqgeRvHc5na4yt8gUhzeJlxEqBJG4AdCFjYNvs1zEFS07Sn5doKUM2uUr8ZUk6LlxKpLAp081YelCzEgyxcu7CP2jcJXqD6x2bdvjhQ3Vt+hLWHB4PB77aD6DVMRJwbKXoJmtEapwj1xysSL4VXNtlnGJ8tM4GgJTJAex74VtEm/jz6fGNUSKF7zETxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkwQYRhdbg7/r4cMwsxk5qyL1NVCqzgjNM0m4JkjMMs=;
 b=qIO/5qe8lFDMA02Ns6tFcUnxDMh3Whcz/N75xrtjyZ2PIJCHloBM5kelm4wDItqjIsfAVspBM0RFYZ84/618qlICIxgMTuZwA/kG6N6i3Xf+4zSHZD/vGHMjka5RnSZjlsuYHhGUUnMiloDyP3B1q+6U9Wh33ZJ2dTWwtxCcvf6vlRmgwl/hI+/aAlYz4fu7+nV4ivgaT60L5yrPnqZ5ZkFcWizETq2kOEfrpbq7gxcNJzcWislZXc5rzzkA6qf1zt17qYRtFHTvHpG7dARkt92IP2nw1G0I7RV0UmdM63jucNMjeTUZOHzBVFwVl78xoHgZGhZ+zARDJIxau9a0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkwQYRhdbg7/r4cMwsxk5qyL1NVCqzgjNM0m4JkjMMs=;
 b=GHj/QH8O6iaXJT3S82YtBpGi1NL+g22v15s7P5Pk5PEAgwdEGJCWuCipNRwLOWwj+i3EwYgU3dahZX+4HY58BjG6SpPHHtsfl6EtJliiyGM++PxkZRO+rkV7H+TcrXH9BYipKg4/4HoJOceBzBZ9Uc/NRwtUKpf5r0cEfLTg/gh9oJFlL3kWp4YVQxGLlhvZYzqJhedK4Gk2e/ulrQPGcyF9Nci/oOapgrVcIWlCiv5r6PkbKaFaohFei5+YZHXC4s5qjElQNgA97cX4tMuCBJORy/cjexCSDCIQfyk8TAx7YJeWBs0scO97poUaEnncHoGkJhADPGcljcLaQYJaJA==
Received: from SJ0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:a03:331::15)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 4 Sep
 2024 15:31:07 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::58) by SJ0PR03CA0070.outlook.office365.com
 (2603:10b6:a03:331::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:51 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:49 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 4/8] RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
Date: Wed, 4 Sep 2024 18:30:34 +0300
Message-ID: <20240904153038.23054-5-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff6c53d-1dff-441b-98b5-08dcccf69897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPnBycswoFVuNfFSoXLipqtJ1xeqhxC0DQ0fguqmnWA+COB1HCB4Tsut9/A6?=
 =?us-ascii?Q?9YBjMhN2HL7nga1vOR9M4ml6S76ub+zyQUh1zbt0tqeVOTygpP035GOlKVci?=
 =?us-ascii?Q?iRADuFG7nAf0BF/TQvIO+mrsLGAEqveVIx6GL/x7vSyDcfGSbHzFxxP2TbKE?=
 =?us-ascii?Q?kektO6n/AuJNS+iMBuKJ2HKRNnGrACGF5HQkzcZcemnpiUtTWUhO7ff66u/S?=
 =?us-ascii?Q?gGYWl2lpS0qYgv6qXB+W4hbDrvK3UVFLVcKGwBA+ocO7R06vNrQHefawpeA0?=
 =?us-ascii?Q?5++hKi5oDXOIQWg92brkGZBEyN4/WujWHMi05+KTnQpglL2/80rDvkFTG9qj?=
 =?us-ascii?Q?uAb/9SnTFrYS1w/RRZhMQs+slL9fJXalFWLQEwL7r+NkFdGhvohrmoAERW77?=
 =?us-ascii?Q?W4251ED+IX+29K1k0Rr4SMdbbxjSoUZw5CCdb7hbB4V1/mZnnvL+gcaje4Wp?=
 =?us-ascii?Q?h3HPFwXh5owVaYV41JG8rek+WokRU22Af30ZtcMZrgCJ7SBSsIq6UZko/zLc?=
 =?us-ascii?Q?UcE3sX2uAFGkVSMWEVg5Bw/hlcjxj9fQuVGg4gc19JtZzFQSmlleJgBRTAnB?=
 =?us-ascii?Q?ekSXcFLfB9wgCSe/RhfVFHoxNwl9z20ppOLYba5trA8nNb+6BWpEpJJjmcvm?=
 =?us-ascii?Q?1hwdRCI5H470mBdHhcMZPdJHpnlNOtx9M+J3v444pvMu59anaL1PkAZk4vrU?=
 =?us-ascii?Q?CGR08qG2ZPc03eWzMIOKUR9DoC3kfznuJQN2F44XT1Bk7VwknSaMf1gfsTYx?=
 =?us-ascii?Q?EkLEbBrORfUaNUZwRJpQzxnMI/sM3OBxqwBPeO3givrRZZO4fRnJLyFg2zTh?=
 =?us-ascii?Q?RrNBhx6oKkp33uqtR3y6JaowMQbkOMujISBc1XLSu6Jdgix6ZC+ZoCct5TMD?=
 =?us-ascii?Q?zDO2Rtf4GUgcU/+uFxsDnivcVB/MN7uReaVbOeFem0ZAsDO8HaUt/Vyp0J5W?=
 =?us-ascii?Q?TALeMAuWA9EnO1hAERjf7xTsjq5VEccla5FZLASLu3s1UUNlUCppD+eRplb+?=
 =?us-ascii?Q?jxuccZQ2hHrSjq3J3gseykuF6kfknwvTIZVHpPzxo95tu8WTKUzo5wIgB9m5?=
 =?us-ascii?Q?ADfrcSRpnKAJtmUR3OK4G/Jh6wRd6vDEL33QkhGoISXIiTW/eODbQcQPB0E/?=
 =?us-ascii?Q?7w3p2piU2KcYBkhI8khSsnobTav/LgS/UCsIkCclUd3vLTpp7FEH+hx4E84t?=
 =?us-ascii?Q?TXHCGZUjgCfHyUyezAWO4oeZ9upXmEG0hV1iUMi//jhD7cPjxokidilZjokw?=
 =?us-ascii?Q?VsTWk4sNKFsyssJkx0IvIePtZHUKsrmk9c1lq9eI2YbG6iI9pMQ/exG4wKQq?=
 =?us-ascii?Q?f6So8lJvZkCJyKiHeGz3Rf2cSD/Nk/UY3a/5Sp17UalRWQLJvnOLFx6HenBH?=
 =?us-ascii?Q?wwSu9/k/4/HQm5pdo+udMAm1CkbpRFJ7k+Kch4GX1epp2ud3VYM/xrAUkFYq?=
 =?us-ascii?Q?5+qbvHOLjmk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:07.3235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff6c53d-1dff-441b-98b5-08dcccf69897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341

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


