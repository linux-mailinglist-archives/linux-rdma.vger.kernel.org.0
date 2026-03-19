Return-Path: <linux-rdma+bounces-18381-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI3IOrSpu2nHmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18381-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:45:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71C2C7719
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4215430FF310
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E83A3E7F;
	Thu, 19 Mar 2026 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbTBlIgG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6939E176;
	Thu, 19 Mar 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906271; cv=fail; b=p2//toUapLsu3sBqbuhGsy8OR/xT2oH7rqU1qtXlnOEZxGx2wi4MQzl3hBZ4gFnGR2FfNBIq4yD4HHEUw6wpZM17+qoptoAMjBCojeCECH1TVAZh6mjd8ApF2CZGQXdfeSFQXNpNUUBALmIIPEYNCSU+uyr6khiWgBoefKxuOXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906271; c=relaxed/simple;
	bh=0k/hrSd18vOsMlSOWVDcNYQYJI5ncLSRIA6SS2qxs+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B81b0xQ9n8hmMFZMsIN04bk0XrvecxafB5hBYwNalT/iQoSUAtBGfYhKvwB1DU19NAbmSPpRPpBU37pxIkxDo/TyAlEajSnw7X47CE68aqVLAggw9AO3r1aiEbZK0JelIeYQD3uF81oGI32lZ5PVK3zpB5BL+OM/EjF8ptE2PvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbTBlIgG; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKTaQNDgJKS6iRsS162e4J8tMtJUbIFZWIVxS9VAne8i1CAKYaAsDU70M21A19IIPtR/j6VZH1AzhEZMmwD3sym2uAu0sJXfYpTol0IF7TBDkDr/+JHAH9QTA8Me51HtrxNYL5NbYXVJp5JzJcdpI9zOdAbTK/0ZjO4yvP25b6udXRtR4wUkpOg8NznHuDVsd5V/xXOTdrBdWdk5NGPU0lGo5sVIf3HhkGybR8xC/dHDtIEkwuJYgLRRynsNyhfgIJssSRq/RT6c0PO5yB+3y94XnPBvslrRBpsNlE2DJYNm4sthh6aUaGkQB2G/0uySvK/s+zgHBaUZ+RF83WiqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+6PtvVVi/DqpGnt3ASfded1GDECtfJB/ACxM+Zf7/8=;
 b=iQYmEHETvlY7ZIi1QECPJx0keZZ3TNpm49OSsVg99O0YVcmfhp23rC1AcmP2tcUOLE6kWKyZ95mTJb3x7oIAairK+csnqOkYWa9uWlMkoOfWBnRL06YTz4jHcVecIfIUjrm68QKnBGe4ZxEQSh17pqOzVHzO7glJEYeC527kaeDSyoGwG7pGgAk0qGWGPsaAtlv064EtagEZ1RVF+m6QCzOfOtCBtHJtEoeO06SDx4FZLSuDkRGeiRYVXNMpdHV1ChGtrrwvbxNJDI0ruoQnd4v2+k1dsC4Gvjm5QnKCGFxX09g4Rv7tJqAqtDQ/AeojHXB61xi+7sQxQuXuKN2DSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+6PtvVVi/DqpGnt3ASfded1GDECtfJB/ACxM+Zf7/8=;
 b=PbTBlIgGwArlgAdQm+vuRizrtEmbxrIysOWVGDKbZCuc4gCKcJtQuIIuMoYliASsKRKd+W889Cwu30+YZD0S6AcZAPDk4xXXLZMQgXabrf9TC0VDuLvwKq6lUxfXcz1uDiSsHXLFDjQqGQ9P5XKrxcqTuSUH2rd+LTI9ToDTGXK/+1LWsdyxgNWoxlVN4w4Uo1AO8Rxc5lJXnUHBOJ+fzmvrF9HWPfe/u7Eh4ASQjKknZJmrATTKbp+mAPBbZy7TbqtvSnpIkpRQ4iahPPliFmm36ckO6DfyNNjLTNaEI++k/dF0M8PlqklL601k6Meu900vphsvAE7k7ZnxQLEP1g==
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:44:26 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::44) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:44:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:44:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5e: Move RX MPWQE slowpath fields into a separate struct
Date: Thu, 19 Mar 2026 09:43:36 +0200
Message-ID: <20260319074338.24265-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319074338.24265-1-tariqt@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1cf3cb-b23e-47be-ab45-08de858b581a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DtZAfspX1WOC1Jb9PSsdS5LuAXjeG2I82nYDyg9wZox9tw8E5QfMelpgvaRE3qrJpWO+rkPIYBLkEasteVW/h921CfwUFholb4Pu9cPZoM+sqbciiIa2NvJYy2Xb/CpTxkaVupmgCpWQ1P/HgBmg5DlDoJrk/1riAjI9gO6ihz8uW8JhaTeaHadNOLVueEnzExcpT1KDtP/4gIBmnHTEw7ihI3oHDxwVxJd8mNm7l81ZObBG5zcfZiBl1DrPPutMBCGle8fsP6yilKdCSvBzDDOxjjlTRcgeif8gY8AQ5sFeK1AusCgAG/vtDTOvUMRNTQNedw9CCkrbvaCR8oblvc6DkoIPJpZN0WKdeg4zG63sgXJn4iLrpr84XhAskxY+EZqQrueZ9tIqw98vbobV0gV849e+4azi/SDRPHs7bSuhFNsxhmz4pgNOmU0mL0hR6xOGsyszl/MkgPPzFCtUHOZCQzfwx7BFw/wy/yQnTuK+LjgIlZCr98LpAzDSjvQ5n56rCeVBHV1CnCbzAT/Ke6t/wDQJJJteA1pkxQkvpJOsx3dqMJgUZR3X8My+k8+aP8y93S5dGA1iEeA3IMVJmB0cpg76CkIezgMZkIkrpPMQO9YDeJwMkzcLAGSjWQcSF+hhyGAIHCpwaOLt3VQl2adPoPUj/M2nlPaQHuFrAoi5fc2C9CNx+/kX3xkxD4G0taHY8a6jp828M7ha8mQ1rkmfgTxXM4r8JDpgYS412pKomuPf20Lngoj9VZ106gH+13ut+217MCvLmZvieGKOvQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/DjYDHSlB+xT5Z5bwM0y0TnkWS14wTtQOyNPDz83LS/shc8gH6eZ2P1286GoTbMbA3fvOkx7Wn8IvegAkplk8mE31OLkhHgc9kwui2c2j4KvSE1sXfWPtDhs9g8TkCKREwEA3aiDe8QA8qAM2J5bK2FDhOhXHuzdGpWrRNeLF3PLCCL5sNkZ2Ghzyvi6WWNYinaU/eUX30hIG7vldHLdB5p0Bq7tlr7r/hOX2LNmi3wKn0PBVcf9eHgZB+tg8CwfvizcM3YXdGANgYpMS4XJ4fn3yk9jzI8JoUpwSVPMtRB7x87FkCd3+sXdAtLnpLfgohk6CLWzCRiGoPizQMxV8gGA+XeDlnQFW6zsG9szCGXc5tf7eE2rhTLm1FjIECZ5z3RO7RHvV/1JieC3LdSmcHc0X0bbtM4/plbA6mZtvlo5IECgqGnxdNJUYsYGZkTS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:44:25.7184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1cf3cb-b23e-47be-ab45-08de858b581a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18381-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8F71C2C7719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move fields that are not read/written in fast path to a different
struct / cacheline in the RQ structure.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 +++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c7ac6ebe8290..d90be82a9019 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -676,7 +676,6 @@ struct mlx5e_rq {
 			struct mlx5e_umr_wqe_hdr umr_wqe;
 			struct mlx5e_mpw_info *info;
 			mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
-			__be32                 umr_mkey_be;
 			u16                    num_strides;
 			u16                    actual_wq_head;
 			u8                     log_stride_sz;
@@ -745,6 +744,9 @@ struct mlx5e_rq {
 	struct mlx5_core_dev  *mdev;
 	struct mlx5e_channel  *channel;
 	struct mlx5e_dma_info  wqe_overflow;
+	struct {
+		__be32 umr_mkey_be;
+	} mpwqe_sp;
 
 	/* XDP read-mostly */
 	struct xdp_rxq_info    xdp_rxq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..20c24d829ee2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -332,7 +332,7 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 
 	cseg->qpn_ds    = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
 				      ds_cnt);
-	cseg->umr_mkey  = rq->mpwqe.umr_mkey_be;
+	cseg->umr_mkey  = rq->mpwqe_sp.umr_mkey_be;
 
 	ucseg->flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
 	octowords = mlx5e_mpwrq_umr_octowords(rq->mpwqe.pages_per_wqe, rq->mpwqe.umr_mode);
@@ -513,7 +513,7 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 	err = mlx5e_create_umr_mkey(mdev, num_entries, rq->mpwqe.page_shift,
 				    &umr_mkey, rq->wqe_overflow.addr,
 				    rq->mpwqe.umr_mode, xsk_chunk_size);
-	rq->mpwqe.umr_mkey_be = cpu_to_be32(umr_mkey);
+	rq->mpwqe_sp.umr_mkey_be = cpu_to_be32(umr_mkey);
 	return err;
 }
 
@@ -1024,7 +1024,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 			wqe->data[0].addr = cpu_to_be64(dma_offset + headroom);
 			wqe->data[0].byte_count = cpu_to_be32(byte_count);
-			wqe->data[0].lkey = rq->mpwqe.umr_mkey_be;
+			wqe->data[0].lkey = rq->mpwqe_sp.umr_mkey_be;
 		} else {
 			struct mlx5e_rx_wqe_cyc *wqe =
 				mlx5_wq_cyc_get_wqe(&rq->wqe.wq, i);
@@ -1057,7 +1057,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 err_free_mpwqe_info:
 		kvfree(rq->mpwqe.info);
 err_rq_mkey:
-		mlx5_core_destroy_mkey(mdev, be32_to_cpu(rq->mpwqe.umr_mkey_be));
+		mlx5_core_destroy_mkey(mdev,
+				       be32_to_cpu(rq->mpwqe_sp.umr_mkey_be));
 err_rq_drop_page:
 		mlx5e_free_mpwqe_rq_drop_page(rq);
 		break;
@@ -1082,7 +1083,8 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		mlx5e_rq_free_shampo(rq);
 		kvfree(rq->mpwqe.info);
-		mlx5_core_destroy_mkey(rq->mdev, be32_to_cpu(rq->mpwqe.umr_mkey_be));
+		mlx5_core_destroy_mkey(rq->mdev,
+				       be32_to_cpu(rq->mpwqe_sp.umr_mkey_be));
 		mlx5e_free_mpwqe_rq_drop_page(rq);
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
-- 
2.44.0


