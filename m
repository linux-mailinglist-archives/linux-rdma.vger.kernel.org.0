Return-Path: <linux-rdma+bounces-14090-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5FC13342
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 07:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A7C408464
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DDB2C3248;
	Tue, 28 Oct 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbYFWlfQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69F2C17A8;
	Tue, 28 Oct 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634085; cv=fail; b=rVu+G6orzj+1NLOiN3on0gVy1qRLJa5W3Ae900Pdx5AeQMvgjOkf1EjrwX9qgnDOsL6HiLA2nKgo0Us5CnzuUIAWiKHczB72c0EQcQeWi7sVrZ4V08w/nAtcgRd7l14V8inRIQCFJtd7fhuIXB8D9OY5Tzb6au6wFUf8oPGO1TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634085; c=relaxed/simple;
	bh=2OtnUGrFmzEmEoSMR3xxeTY0cYQ2baS5+rnTZTRhQwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/bQIh3sHDAWBadt3iBVR/xXG4tGvC8zIsXLQmhI1CP4DUBmwe6DRbrBO8+MtF25JEeFFtFFx0inhPqgsdBeoDVxmx5wiSHqF+hbaaCL1XDKBPdgvE+Vi57S1Ctg8NIK2qdB3bY9/aYj1wXftSnXIFaZai7TvluvxtVsSZq3wI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lbYFWlfQ; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkS75FN67xd1XqnUa1mfIDSRck/rawZZGF/nkHIx84LivIguPkRLcvqS5OzyKv+0GUipI3Y0CdT8jYFt616/BBOUtp2gIkzg0K0WlfK4IERr3Z5qLGD4kPIiqf199RSv4sP6YWWhL9/uwkFCiqSPyPsaqmyImasY+yjRM7n3x94qkFFnkgUbwczP6D4S9xOxR9dLAOxs2F00tyF991jaeW9gDTi6hXGmsX243H9MDNOFAdoRGxCcRoT0wgCfOkrGAZCKiWX8ChRpd2wEtikFGcAqE8SarT9CohhmXUWfEN389pwPVTBxiX6JWgcs+lA2oSdcspV/9AbtvkAu5wn8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OHJMCML2K4ZF+ehdfrtr4oTtwi1kcts8LJqttTyHKs=;
 b=E/9oT1t8guedK+En57jLVg8exO5CTKurrY5hWIpMSjHGbFHk7jfvagcRrsL6FAOXgzkd+iQQ6qte7z7FRJ01HRYbRxzn0QWT9xC3eCUNhb2gVVcDxvniVZD2DTue/DVn/pn0e5IU/SIUDYR8+5UmgIrU8W/sT9kwYjm23Wdqsr3Vm3ApMLf/A3LkdmLdsnQneBlONLvgphuNxHr3Vud5b/2ccBT/j1Xr3cBn5lqhGbusqJdno4cxrSSgy9IAZPFDb1SK75tlyK44+P5i/hpB7u/0u5i/jtNCRUIeDYyOTJKFKFBL3BjTmLsNf9MfsU1h2+b+xC+/e2Peow0rIi6aDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OHJMCML2K4ZF+ehdfrtr4oTtwi1kcts8LJqttTyHKs=;
 b=lbYFWlfQoj32Wp+QR+Sh4Ty8UmQegV+d0+imbk2cGpxdo0ZbynrR2w4Q0FuoYy9d5bVw75NMmT+0008nUqnO2J743QGfYIYNqiVXxtRx6CaMzuvrMGA1HdE4q5wJQtZRYkzOXn1s3DS5bz1Q8BMyxE27B4wnGFwyFJLVC+PGsuYsVRwzaHRI3Vv87YT+ky57xQgrqJALHMgwir1wP+TGMHfcjexi9+JN6teSa8ZzsYb+wmPc56L6FNsjraqfXJgcs/T7PtEJqDRFMeMamNzDiR1Rv9UUJdTgeFXH2wsIZUMU/wB7kGgA4Uhu+PKYOGzicZku8WmWB0l8su4lgCduIw==
Received: from BYAPR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:e0::33)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:47:57 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::79) by BYAPR05CA0092.outlook.office365.com
 (2603:10b6:a03:e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 06:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 06:47:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 23:47:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 23:47:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 23:47:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5e: SHAMPO, Fix header mapping for 64K pages
Date: Tue, 28 Oct 2025 08:47:17 +0200
Message-ID: <1761634039-999515-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ad7b44-c53a-4724-0d3f-08de15ededef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m6cAcM2RcCJQRfLXbcJ+Nici08pm60CEKImOpKYEA1kydSsUtjCCm4TTXAWu?=
 =?us-ascii?Q?/9F8bCkyCUzFeppL5JlpEr9Zduz/b7RxWJX4ppBbt1QqemDDv4iVJRmqRBo8?=
 =?us-ascii?Q?u7hwZKH6SiWWNogGBIRk2B0f9zrX4dpZIJRTA5i+DbMIbvNSSDzb+9ieO4Av?=
 =?us-ascii?Q?wjwVzVWrHBBooQjlSglP8KIMryCzbp7DPtQB74fiRR0NvukY/wZ4PnB9+n8d?=
 =?us-ascii?Q?2iJvG03a7LEYd/QZFqQ01LVape8UAozaRkcznKnQbtNCul7C4A9Bu9w5Tr23?=
 =?us-ascii?Q?okvTKJkB44V8DsjMlV6eeNCazkga25wCESRXUUUUMdn0G4zQ2KoYWvrLUOnL?=
 =?us-ascii?Q?NMZRocRpx4q8GY5bPeSo7C6zY6zXtOsbsOBiEvodbvh2aJN8KrRnyTx2+j81?=
 =?us-ascii?Q?JMo54O8OphMailB3p/S4kXjq3CGEhd4wMWEq3kUxS7tmQLF2H206rebfV8IO?=
 =?us-ascii?Q?Qp3T7oALGZh+E/gmW+dg5H9cy2eJcWj2Rpjss1NQCQukAV0724oKaVNsf1Cs?=
 =?us-ascii?Q?27MdQSNATMgp5Cg68HxCqMOOgZXBbCOa0MW2ASAOt1/5eb6VujdhOF25IjxQ?=
 =?us-ascii?Q?SDUTHBWkooXapxRaQ0MF4yP/tUFG0Y20uEmDQLjFjYydZxn6uGDPVgud14cy?=
 =?us-ascii?Q?Zs19odwRB4xssgxN0tQbEu8sJUXNWIWzOAsg1kBMkVhs2RUY5trg6UnQPgPz?=
 =?us-ascii?Q?1Ztvve1wYiKFZnQjqvfQnEFj69sbBmahJetS3evOMwQZsRaHtqLW3IWJDPwG?=
 =?us-ascii?Q?tlUX4zy/wT7BfVtkOyVDWXYIER3lcbO7UVCus5T/Eq/Wws1pUers2ZGxu2Sx?=
 =?us-ascii?Q?lePPA+PzGiHjOx5yBNugFLgRHS/4PDIqD1ZiyZE7nGFNWH9Bd/e4/Keb/5Sx?=
 =?us-ascii?Q?A1e8+YxJ5fFbY6H92D0mBwq0G7u9J4v5Zf4kyq1xfLNL2OQw335vCKMA99qu?=
 =?us-ascii?Q?/LcTrI33x+Y6f3ez6ByUOlOB4Jr5etF2Sj2qjroguuaet+PKPIyeMwfC4J7f?=
 =?us-ascii?Q?zN63QAPShxwgkvsvCoYtE04LZ3+RqBMkIoBmzGk6kzSjuRiOhloWDhLKeZKE?=
 =?us-ascii?Q?60unCwN/TGdlaEw0eqDgmN2+x/xIxk7RvisU8JgzayR0BN1PlRaBQi28iylX?=
 =?us-ascii?Q?UKSF1ai+vzbeVABAVZjcBMhAPM6BvHcbpqkTLAOIlHUtooW+w9TF3YNAYQcc?=
 =?us-ascii?Q?JCqFslOJGiva1y11xGvy++Uun21NxPT1RS/zbqUQSf5Sk57nk7rFVN9i0cLz?=
 =?us-ascii?Q?TAisge45AL9H3OKtqBDtloYfoab3e5lL7eg+LtwFL0dEqbNCtzRLke3amUdE?=
 =?us-ascii?Q?hTuDcKAxFELAQEPy+4fglqQYlpjT8HjwZTDS+z5RWWryB8tngZ9+THZQWjJt?=
 =?us-ascii?Q?yHnQJcjhQvBJ6nh0d2DdXJ2OshHCAL0vF9iO0QqOQCOtgzXSKrGNp4avvgJI?=
 =?us-ascii?Q?JhNZ22aQAc1ONgvMPye8oRy7LrEQxfs3kN7stSxBuE53Ly6+9bDrBRUoouxU?=
 =?us-ascii?Q?S4SC4bKd3yi/a5oHe2Zp31Pairz2WSWi96U6TY/B+n1+wC+aWEuL1YW2gAjB?=
 =?us-ascii?Q?rVEZJ+vA03/LjtVZTRI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 06:47:57.6318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ad7b44-c53a-4724-0d3f-08de15ededef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529

From: Dragos Tatulea <dtatulea@nvidia.com>

HW-GRO is broken on mlx5 for 64K page sizes. The patch in the fixes tag
didn't take into account larger page sizes when doing an align down
of max_ksm_entries. For 64K page size, max_ksm_entries is 0 which will skip
mapping header pages via WQE UMR. This breaks header-data split
and will result in the following syndrome:

mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x4c9, ci 0x0, qn 0x1133, opcode 0xe, syndrome 0x4, vendor syndrome 0x32
00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
00000030: 00 00 3b c7 93 01 32 04 00 00 00 00 00 00 bf e0
mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1133

Furthermore, the function that fills in WQE UMRs for the headers
(mlx5e_build_shampo_hd_umr()) only supports mapping page sizes that
fit in a single UMR WQE.

This patch goes back to the old non-aligned max_ksm_entries value and it
changes mlx5e_build_shampo_hd_umr() to support mapping a large page over
multiple UMR WQEs.

This means that mlx5e_build_shampo_hd_umr() can now leave a page only
partially mapped. The caller, mlx5e_build_shampo_hd_umr(), ensures that
there are enough UMR WQEs to cover complete pages by working on
ksm_entries that are multiples of MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.

Fixes: 8a0ee54027b1 ("net/mlx5e: SHAMPO, Simplify UMR allocation for headers")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 34 +++++++++----------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1c79adc51a04..77f7a1ca091d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -679,25 +679,24 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
 	build_ksm_umr(sq, umr_wqe, shampo->mkey_be, index, ksm_entries);
 
-	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
-	while (i < ksm_entries) {
-		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+	for ( ; i < ksm_entries; i++, index++) {
+		struct mlx5e_frag_page *frag_page;
 		u64 addr;
 
-		err = mlx5e_page_alloc_fragmented(rq->hd_page_pool, frag_page);
-		if (unlikely(err))
-			goto err_unmap;
+		frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+		header_offset = mlx5e_shampo_hd_offset(index);
+		if (!header_offset) {
+			err = mlx5e_page_alloc_fragmented(rq->hd_page_pool,
+							  frag_page);
+			if (err)
+				goto err_unmap;
+		}
 
 		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
-
-		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
-			header_offset = mlx5e_shampo_hd_offset(index++);
-
-			umr_wqe->inline_ksms[i++] = (struct mlx5_ksm) {
-				.key = cpu_to_be32(lkey),
-				.va  = cpu_to_be64(addr + header_offset + headroom),
-			};
-		}
+		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
+			.key = cpu_to_be32(lkey),
+			.va  = cpu_to_be64(addr + header_offset + headroom),
+		};
 	}
 
 	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
@@ -713,7 +712,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	return 0;
 
 err_unmap:
-	while (--i) {
+	while (--i >= 0) {
 		--index;
 		header_offset = mlx5e_shampo_hd_offset(index);
 		if (!header_offset) {
@@ -735,8 +734,7 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	struct mlx5e_icosq *sq = rq->icosq;
 	int i, err, max_ksm_entries, len;
 
-	max_ksm_entries = ALIGN_DOWN(MLX5E_MAX_KSM_PER_WQE(rq->mdev),
-				     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE);
+	max_ksm_entries = MLX5E_MAX_KSM_PER_WQE(rq->mdev);
 	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
-- 
2.31.1


