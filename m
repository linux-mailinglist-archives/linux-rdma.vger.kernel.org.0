Return-Path: <linux-rdma+bounces-5411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47D99F110
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA874B21E88
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA551DD0C6;
	Tue, 15 Oct 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LHMbqxL0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672701D517F;
	Tue, 15 Oct 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005877; cv=fail; b=rOztvadZOYh9QX0vWo5rHzNeDy/Ts1fCNJXdjy3L8ZqqSzZsmy9dANeOgnUgC8Ykl/bZIUGC+6lV+fiMDxMmCIHDcB8cBO5M71R9C5/r5krbtNgRhz+y277RYZAfBVT6nsCrxmkSRORg1hCcl7LGpzjfQyQb9tRneGKxr2y5hV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005877; c=relaxed/simple;
	bh=AdoM/2bcIdn0tBZPYycdb5VUChG4GlqCn+/Ru7aaaTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVwR9NqSofJFGKSOM6jkNWgb6tLNUpzPeJTidilrJjV8p64XDdovNPGQVqGVbSFLdFBGp2JNUX0lRAztz/DpB2QzZM3Y5RmFODsVK4JZsGZHd7vYGK5UyIJQ9v8lC0zH1dSy+4l3UJXm797ZvqqTP+tUS97/OwRiY9XjugS5hjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LHMbqxL0; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BczGfVw2kiHqT6X4uX2ZvTRAN2vzGXTe2+5IPBG30OJ16PdJPVpTADLe+TpijcTjXA5ydE99zjrrqES8pMfKl/KgSmLIqPRnWl/yVM4WCnU2gkyVfCFe0P/SVFJ37Zj6YxWwUlw54QJfd0EpnEm/ieRdg1RVWEzpAVkJ+oSdFV3GtnqDT04r1Vw8cydMUAiNCWn1i7p4OHcMgyh51NRL+hCvZp7+FxNDx1Rvtj+ALjonYIhJ06dh2qZf1WG67gyQJE+WgmjFvLFuMUSfWK8HoY5LutpN5Q+B39xULHeIOy+oWO8Zhpnoyw01uxXJBteCo7Ge8Hicbi4iYRUgowh81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edElnGBClLAiAIzr2HyoPLhOZQadZKfGUs1gCkMRJUw=;
 b=KZOH1lJzBDItjPztpavhm18cE9S/7jgbhWjC0Sxni1NqXwhw3sx1ourLHhtClryGVN9sz/2yfV//5DA/ALWl+wyAaBXDCYOYfvMTfIOSzkHKJXD+3/+x313VRoBNKLDpL7V8/YNYQD8uYfQ6GaNnpAM0/XxH7kVwnjVks55GtjOaGsrEs1DHXjnkXSosgTTLYgUGxjGiYIDFvkm3Bm9aPnIIYuXssgT3jHm6uAzsiHGwo6M2aR/ZKcf521FMc7HM0nnFaO3Wwmrf8AZitYyh3NUZmBNMANMRr3x26OJWnyLjMNhSmD8ALzkWVISjJ3Ep8d0xtkNIxTyeTSzRHZlDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edElnGBClLAiAIzr2HyoPLhOZQadZKfGUs1gCkMRJUw=;
 b=LHMbqxL0uTpeNiT6Y/2KX/xEVbGKUNzG1aqI0iMpcbvloHdzx2b+sdIz2XsBk/cLjZLE6guetblQskzqpPeJd3uW7QDSyOB6sd9tmNNOcKccFampyhtrpDlMprCmSRRq2JvNj3QUHoeM4ZMTmvLwjdJZTjRqRfFc2VxCsmlPoSqKB6HKahuRsGjt14iwxIkbwajThE8YAst5/EmuT/0A2CU43BPT44u4959oy2NzYJPLB2Kad96VmR9mUrbkV07pJdEIfnOz8pesVrwZpb2n+Tqj2qkP8QD1Tw5heV+Ejqmmut3gCqe6Nq0znjzgbnFKe/wexCfG+u9Dsa1pAq7Cuw==
Received: from MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47) by
 PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Tue, 15 Oct 2024 15:24:31 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::55) by MW2PR16CA0034.outlook.office365.com
 (2603:10b6:907::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 15:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 15:24:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 08:24:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Oct 2024 08:24:15 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 08:24:11 -0700
From: Yonatan Maman <ymaman@nvidia.com>
To: <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, <herbst@redhat.com>,
	<lyude@redhat.com>, <dakr@redhat.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <jgg@ziepe.ca>, <leon@kernel.org>, <jglisse@redhat.com>,
	<akpm@linux-foundation.org>, <dri-devel@lists.freedesktop.org>,
	<apopple@nvidia.com>, <bskeggs@nvidia.com>
CC: Yonatan Maman <Ymaman@Nvidia.com>, Gal Shalom <GalShalom@Nvidia.com>
Subject: [PATCH v1 3/4] IB/core: P2P DMA for device private pages
Date: Tue, 15 Oct 2024 18:23:47 +0300
Message-ID: <20241015152348.3055360-4-ymaman@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015152348.3055360-1-ymaman@nvidia.com>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e92872e-9f3d-418a-f069-08dced2d7731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?41tq66SQC9BvA+ZxClDXTtEFy2mvOJ0ssmBFrOYs1l89eCSNlpsFKp2jCJNs?=
 =?us-ascii?Q?n0hP/BgSFrTPTFiqVg5HXJG0lYHl1bgIt+FB48h5mM9Vyookr3EjXC+hQcOJ?=
 =?us-ascii?Q?GS7j8fAtLKyFKwJf3N8nILhwtJtOSNGniWTsv5S8556K8DxF0fwS1auMhqcU?=
 =?us-ascii?Q?IZz2x9DzL1QZkc5kueW24woCSFEG5iyHtjlIWGaGhLRO1QIroVIG1lkOkM6/?=
 =?us-ascii?Q?8tQ8Xiu+Vls8yapMhtJ29Tf89HMr0qLXkpopwo+m6eNJl0pZkOHNlZahjfyR?=
 =?us-ascii?Q?e3IiiNRoynSZWoOgPQUn4nj/nCmiwoQTTTjZb12bmegFtgeJNz0mU9i2neyO?=
 =?us-ascii?Q?7BzR0BjPR85AmOMKYOHPE0tC09AHKcRLffQRUvFF4SQnT9NtDGCNlzMC9/ME?=
 =?us-ascii?Q?4zyrug9M0dAlA1grjERgdAGSE804EE1LVXUVG/S5IyIY5V/HmT6wnyD7Pxvy?=
 =?us-ascii?Q?3gzhvTWUH5q+O5kah163U3DlO6MvkpR3rFZEOdVdcgUHAf7uzEPNCuw/Uwtf?=
 =?us-ascii?Q?cTlcLOx6/jiI52W/QfYdS6KJNfC/TChQyjhRqygXNuluJQJf7E6plzm79aAr?=
 =?us-ascii?Q?OkL7zvRDlcIBiXTdc2PS1nPp9/X/XAWZRm90FPhTAF8MaTdt4FqgluQ+aF61?=
 =?us-ascii?Q?Rv/Sh79JjjOaqXeaQ+Slw27uBJe4eJrxuLaaArFwfZg/A1Y6X6fG2c89Nob7?=
 =?us-ascii?Q?qg9u0Iru15toAR4hLXiBI5LNjDCQ8oDhR6X+670D264LA2ObTJMtEtwWY8ig?=
 =?us-ascii?Q?ldKlOicVfBZ8b1m4K34UR2gGVkn9RQagyIwsS3y+Qq2I4CSpJRd74bEwZkOG?=
 =?us-ascii?Q?PWolFwlB4+8kBmofrGkovawhXJ5vh97zT4OisZDxhY0QhDOErv9OwOsH3lfE?=
 =?us-ascii?Q?Pbt8f6whfozVj62pxcsq01U0zJjVZR9X5OcwnwE1SwTuoP1S0ZEh9YEwpxv/?=
 =?us-ascii?Q?Hea97QUh6LFr4z2fOZIyu1gR+5hGTjrPRyGNUpR8tqT6xjVSiyAM2dSIZFx6?=
 =?us-ascii?Q?vM3NL9dR7iubQtySU0d6LKaTnUijeqeokB+SpcaihYn7rWFyKgMg/xs6m1/E?=
 =?us-ascii?Q?mEeqGqjZ90G04hlxWLhOk9P5vp1KqjETdab4mFKHbUC1fkDcvIbHwOOtGEE9?=
 =?us-ascii?Q?QCFQ/OiJfr88Op4LLEvxgNcyGDqvcLnN1RNXrKbqQCAWEd+CH+hmRqZyVg29?=
 =?us-ascii?Q?VXQF/jnYoBIr2FcygahRh1+74XoqBy2xlsQxkQbsOf0oO3L8vYQNH1KHzVWH?=
 =?us-ascii?Q?f83VIBxHEa9UHDPETouAAV/IMt4ZjCAIuwh9JjvFsUFx2YH9nzvBr7FViET4?=
 =?us-ascii?Q?LAcV/kYH37FLPobzcjfeCvuQM+Ffy1I2w+dOpDvHTYjCifKuNv/ouqOp3z00?=
 =?us-ascii?Q?lxNKZmZCbKdylMixQdGZplqvt/9u?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:24:30.8684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92872e-9f3d-418a-f069-08dced2d7731
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

From: Yonatan Maman <Ymaman@Nvidia.com>

Add Peer-to-Peer (P2P) DMA request for hmm_range_fault calling,
utilizing capabilities introduced in mm/hmm. By setting
range.default_flags to HMM_PFN_REQ_FAULT | HMM_PFN_REQ_TRY_P2P, HMM
attempts to initiate P2P DMA connections for device private pages
(instead of page fault handling).

This enhancement utilizes P2P DMA to reduce performance overhead
during data migration between devices (e.g., GPU) and system memory,
providing performance benefits for GPU-centric applications that
utilize RDMA and device private pages.

Signed-off-by: Yonatan Maman <Ymaman@Nvidia.com>
Reviewed-by: Gal Shalom <GalShalom@Nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d31c23..1f6498d26df4 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -381,7 +381,7 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	pfn_start_idx = (range.start - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
 	num_pfns = (range.end - range.start) >> PAGE_SHIFT;
 	if (fault) {
-		range.default_flags = HMM_PFN_REQ_FAULT;
+		range.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_ALLOW_P2P;
 
 		if (access_mask & ODP_WRITE_ALLOWED_BIT)
 			range.default_flags |= HMM_PFN_REQ_WRITE;
-- 
2.34.1


