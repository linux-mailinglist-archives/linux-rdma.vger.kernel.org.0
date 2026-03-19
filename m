Return-Path: <linux-rdma+bounces-18388-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DOGEj6su2ngmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18388-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:56:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE22C78F8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C043210A3F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF93A63E1;
	Thu, 19 Mar 2026 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2RheOs9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842B3A545F;
	Thu, 19 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906752; cv=fail; b=DpW4P7hR8cM9fekIhs9Ap2ZPW3La281+hgIb84I/GDHuwariyXhwystpMUr6VAR271PmPQ62tIj+ecmdT/D31rtvV2EMMS25/WdyEYUqyaC/Y1GihmJi0aZ2l3V4aGJY067rPDN1bB/cUGbFuNV224l+Tt2KS/1K5SYcBFGUFq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906752; c=relaxed/simple;
	bh=qYw9wAGf2KWDd+h/Lj3b5gj3KUtiVdSSM647XtH+2us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWK+tE9ET/9mdCp0+3ubYdBFTeJolgfS3j/EKcfcjvAlHo+t+63iJRpy7B5LcJ9pGhxqu9y32zX3pkwl5++uOOc2CgcTjv3GsycW4YoiEXaCnOnB65T+QVHt31v1Iu+SU8PBZQKGkrW15WVq/eeuBS8OAh2JVChpkjaY0juvF7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2RheOs9; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgCfgJXHlyeESKnF4oeygen5I3BQEcgpyomI/H60pPaRjJnIKdvghR5FhA3MyM73Qil1DXaniOMqE4FcDXgriYjvFUoVAHqXdlmnjkaCAQ02ydXtYwsQ/XzAKp9uk28DS9+yxeXdEIDf/aEYPAf0d1ig4SPNeadvYbiHI/mErV2axStcJcvC9OVSsT4vG1b229b5a8/w+Q6IKaGf+qc8gijdbDtUs1hhLmkKm5Gq1AuWQrVROY558pk3FMwRZjYbXeHgcQuTEWgJknac2xG5LMFbLA9RtbAL/85D9nGNLyRO36qRkEKPNnZ2FtdunLCPrx+1PHMs1uFxCCScPYn2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcaBF+HfkpVymaOTomIEBmPEDgf1FwPVqeTbbic/mWM=;
 b=IY2WiA1HgDfv3UCTe8mBPvDeBOFPem88nAIdnmeylMmvXtTbtJzUrGXVijmnb9xiJn55kRuW/dOtNhcBKnNncK5xBEw+HDXimTDIZnPydenVEiKpRdSfQ0EoZSgwUtO8acLVQLhs9OEyeLLXaEj9TXnAq1kjLd6L9DLh+nZyzGG0DmNQvihcxiyWACFh0G8kaGXJyEQ6gAx+TZoQb11xgyujlXmqFapmqXUhSzfEWoWpGJvSt7oXRmPvG6bgfrOOeE532Ul1r5LfkGqqynbadUTDLWoErTA51p4FLRauvQTfNb0yBjumZ0mA1xbDCZSDgkPKSVNNceDYrFMYRuW2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcaBF+HfkpVymaOTomIEBmPEDgf1FwPVqeTbbic/mWM=;
 b=Z2RheOs9twh48KdJFOrqsceuzZcvtx1tcBjlLG0oXaBUdvL5sv7B/OTjANt50drwPhT2cGCF3hBJPGtZoNnmFclRvEcU2ecntd5phlr3OM/az+wnUqSCrIMXmE4pHnOuBnpfF7gg+VxtO66Tu5x3zKrtlfl+eOOR6NqKS4C1Y3MC1JBLnI9BOUhabbeIrM1lhF5C3zscgqzeV/SLs2CDtK4YIh8gXZRzukcIXD+xhTwdeWTV9X0qRJDeUZaGR8Rm/QZqPVjduebBuoA6n5ezbLJj4U0ZI3QrqiJ8aW4uFFLr4PbUGQG+VGXciW7yeWrtQ5nFi74O1tWwVnnl3Z86Hg==
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by EAYPR12MB999155.namprd12.prod.outlook.com (2603:10b6:303:2be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:52:25 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::a5) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:52:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:52:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:52:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:52:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode
Date: Thu, 19 Mar 2026 09:50:36 +0200
Message-ID: <20260319075036.24734-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319075036.24734-1-tariqt@nvidia.com>
References: <20260319075036.24734-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|EAYPR12MB999155:EE_
X-MS-Office365-Filtering-Correlation-Id: 652735be-b7ea-4155-be36-08de858c75bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zm7+fTL8VkI7XyoSiUJTbMLJhsXhGpTqEHAhSkg7IzPI1qJZrMt4tm9niPhhW9QAUn6a/P/hc25c+T7esnly1oH008CYlfaUNTe1GQ+FyEl31bourwTADHdJh8/dFgjUn6cJ3+PLuSpykq/1FClM6GgEWzFVQ0dGAEY9Pszt/a+Kvwidnpz9kB+UgG3tMLD7txqYB8fESEQerC0//fsLz2gsFH3xs1eaw/5T5s2f3CyVDwKS4p8PSdcn09UHkygVRTqRNEl4c3o22YaAEjqaMzLVxOrsgd7jjUXloBIqirF4tsHMqrINvEMm/jRRKWZGJlKuBUbEc22OZc52hSMA8v/AjRk0WecnYMQBzLxM3tphxgDFCOXqFbgU8z4JzQ/my6ig6EYD/z11+32WgNJIyDDibth96O2yGgH2NXxh/46qkzQWfLM5aSokplXtGS6vM62dkZMHJ1y9DdWiUNDDpg3PXz8lq/M65ajyr+6iTXm7Wju6wH7Xn0vcnCmfMpfomozlsbG46NL1dRNO90WkSk9uBKOCHd6vVOQEnvBeox1I8FQ8HUojTPdijbr2AcJLHfLIoHWwxwQvHrqMt9/NwQsREwUdBqTlnN0IEf+zI/ZOiBMMG7w4MMTATGA1AQfA1tSrVnQQHq1mI60IcSOdXh2guB6e5DnRi0rMarY5fDEEDSP/tqdW+yrviWZlBeTOHFEDxU5+DLmgPNG5EPiW0NV6Hl/fyShmtjVo1aNH/yJNHiEPR+itDh3HXyIhuF2tV4zHTPolcimBJ0MZ5eDzcQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AOljpQDTITJLLeJPuoPe9kj7RLzokzN2UYMqjb8JlnzF0rUr2P+AFDLlA/qEWLDCrM8PgMoKBO2RcWiVmH/+PANmSZnOwF+78390yS+GdsHt0HErKapVJ/UEvjsqWIGjV8ZyxzkTEZKgL5SaaYjMy4z9W+WquCmpi9hvbLvUwJ1Zu/5h6tTENCb+B7pq48zXaGXzHoY9+FQdgJT8yK2EyTFKQyovj+VkuiHwwg2wP3aBmRuHOJEc4sOwZQwqvr+PkX6Y61B+/IvhlEcQiBj0pbBqm26YQ7D8AGBv/DvQzXEirbfPf4wCj0WYZATPX22zOfAh4UkIDjY0GtJuWrpUL8xGHbfIeTq4dQ27dWRIlfQhzHjAUbwKvkPsF1g3AHXqDUuPBJfUnBE0wg+8tJ4fTmww4DFFTThQ6myk0+BG3QGJVXT1SgKZ0TrCVlzYBdYl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:52:24.8797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652735be-b7ea-4155-be36-08de858c75bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999155
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18388-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.935];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E3BE22C78F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently in XDP multi-buffer mode for striding rq a whole page is
allocated for the linear part of the XDP buffer. This is wasteful,
especially on systems with larger page sizes.

This change splits the page into fixed sized fragments. The page is
replenished when the maximum number of allowed fragments is reached.
When a fragment is not used, it will be simply recycled on next packet.
This is great for XDP_DROP as the fragment can be recycled for the next
packet. In the most extreme case (XDP_DROP everything), there will be 0
fragments used => only one linear page allocation for the lifetime of
the XDP program.

The previous page_pool size increase was too conservative (doubling the
size) and now there are much fewer allocations (1/8 for a 4K page). So
drop the page_pool size extension altogether when the linear side page
is used.

This small improvement is at most visible for XDP_DROP tests with small
64B packets and a large enough MTU for Striding RQ to be in non-linear
mode:
+----------------------------------------------------------------------+
| System               | MTU  | baseline   | this change | improvement |
|----------------------+------+------------+-------------+-------------|
| 4K page x86_64 [1]   | 9000 | 26.30 Mpps | 30.45 Mpps  | 15.80 %     |
| 64K page aarch64 [2] | 9000 | 15.27 Mpps | 20.10 Mpps  | 31.62 %     |
+----------------------------------------------------------------------+

[1] Intel Xeon Platinum 8580
[2] ARM Neoverse-N1

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  6 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 ++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 54 +++++++++++++++----
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 592234780f2b..2270e2e550dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -82,6 +82,9 @@ struct page_pool;
 
 #define MLX5E_PAGECNT_BIAS_MAX U16_MAX
 #define MLX5E_RX_MAX_HEAD (256)
+#define MLX5E_XDP_LOG_MAX_LINEAR_SZ \
+	order_base_2(MLX5_SKB_FRAG_SZ(XDP_PACKET_HEADROOM + MLX5E_RX_MAX_HEAD))
+
 #define MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE (8)
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE \
 	(PAGE_SIZE >> MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE)
@@ -596,6 +599,7 @@ struct mlx5e_mpw_info {
 
 struct mlx5e_mpw_linear_info {
 	struct mlx5e_frag_page frag_page;
+	u16 max_frags;
 };
 
 #define MLX5E_MAX_RX_FRAGS 4
@@ -1081,6 +1085,8 @@ bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
 bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
 					bool dim_enabled, bool keep_dim_state);
 
+void mlx5e_mpwqe_dealloc_linear_page(struct mlx5e_rq *rq);
+
 struct mlx5e_sq_param;
 int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 		     struct mlx5e_sq_param *param, struct xsk_buff_pool *xsk_pool,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8b3c82f6f038..b376abc561fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -371,11 +371,11 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 
 static int mlx5e_rq_alloc_mpwqe_linear_info(struct mlx5e_rq *rq, int node,
 					    struct mlx5e_params *params,
-					    struct mlx5e_rq_opt_param *rqo,
-					    u32 *pool_size)
+					    struct mlx5e_rq_opt_param *rqo)
 {
 	struct mlx5_core_dev *mdev = rq->mdev;
 	struct mlx5e_mpw_linear_info *li;
+	u32 linear_frag_count;
 
 	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) ||
 	    !params->xdp_prog)
@@ -385,10 +385,22 @@ static int mlx5e_rq_alloc_mpwqe_linear_info(struct mlx5e_rq *rq, int node,
 	if (!li)
 		return -ENOMEM;
 
+	linear_frag_count =
+		BIT(rq->mpwqe.page_shift - MLX5E_XDP_LOG_MAX_LINEAR_SZ);
+	if (linear_frag_count > U16_MAX) {
+		netdev_warn(rq->netdev,
+			    "rq %d: linear_frag_count (%u) larger than expected (%u), page_shift: %u, log_max_linear_sz: %u\n",
+			    rq->ix, linear_frag_count, U16_MAX,
+			    rq->mpwqe.page_shift, MLX5E_XDP_LOG_MAX_LINEAR_SZ);
+		kvfree(li);
+		return -EINVAL;
+	}
+
+	li->max_frags = linear_frag_count;
 	rq->mpwqe.linear_info = li;
 
-	/* additional page per packet for the linear part */
-	*pool_size *= 2;
+	/* Set to max to force allocation on first run. */
+	li->frag_page.frags = li->max_frags;
 
 	return 0;
 }
@@ -955,8 +967,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5e_rq_alloc_mpwqe_linear_info(rq, node, params, rqo,
-						       &pool_size);
+		err = mlx5e_rq_alloc_mpwqe_linear_info(rq, node, params, rqo);
 		if (err)
 			goto err_free_mpwqe_info;
 
@@ -1347,6 +1358,8 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
 			mlx5_wq_ll_pop(wq, wqe_ix_be,
 				       &wqe->next.next_wqe_index);
 		}
+
+		mlx5e_mpwqe_dealloc_linear_page(rq);
 	} else {
 		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 		u16 missing = mlx5_wq_cyc_missing(wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index feb042d84b8e..2ac38536afe9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -300,6 +300,35 @@ static void mlx5e_page_release_fragmented(struct page_pool *pp,
 		page_pool_put_unrefed_netmem(pp, netmem, -1, true);
 }
 
+static int mlx5e_mpwqe_linear_page_refill(struct mlx5e_rq *rq)
+{
+	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
+
+	if (likely(li->frag_page.frags < li->max_frags))
+		return 0;
+
+	if (likely(li->frag_page.netmem)) {
+		mlx5e_page_release_fragmented(rq->page_pool, &li->frag_page);
+		li->frag_page.netmem = 0;
+	}
+
+	return mlx5e_page_alloc_fragmented(rq->page_pool, &li->frag_page);
+}
+
+static void *mlx5e_mpwqe_get_linear_page_frag(struct mlx5e_rq *rq)
+{
+	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
+	u32 frag_offset;
+
+	if (unlikely(mlx5e_mpwqe_linear_page_refill(rq)))
+		return NULL;
+
+	frag_offset = li->frag_page.frags << MLX5E_XDP_LOG_MAX_LINEAR_SZ;
+	WARN_ON(frag_offset >= BIT(rq->mpwqe.page_shift));
+
+	return netmem_address(li->frag_page.netmem) + frag_offset;
+}
+
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
 				    struct mlx5e_wqe_frag_info *frag)
 {
@@ -702,6 +731,16 @@ static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 }
 
+void mlx5e_mpwqe_dealloc_linear_page(struct mlx5e_rq *rq)
+{
+	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
+
+	if (!li || !li->frag_page.netmem)
+		return;
+
+	mlx5e_page_release_fragmented(rq->page_pool, &li->frag_page);
+}
+
 INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
@@ -1899,18 +1938,17 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
 
-		linear_page = &rq->mpwqe.linear_info->frag_page;
-		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
-							 linear_page))) {
+		va = mlx5e_mpwqe_get_linear_page_frag(rq);
+		if (!va) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
 
-		va = netmem_address(linear_page->netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
 		linear_frame_sz = MLX5_SKB_FRAG_SZ(linear_hr + MLX5E_RX_MAX_HEAD);
+		linear_page = &rq->mpwqe.linear_info->frag_page;
 	} else {
 		skb = napi_alloc_skb(rq->cq.napi,
 				     ALIGN(MLX5E_RX_MAX_HEAD, sizeof(long)));
@@ -1971,8 +2009,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 				linear_page->frags++;
 			}
-			mlx5e_page_release_fragmented(rq->page_pool,
-						      linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -1989,15 +2025,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
 			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
-		if (unlikely(!skb)) {
-			mlx5e_page_release_fragmented(rq->page_pool,
-						      linear_page);
+		if (unlikely(!skb))
 			return NULL;
-		}
 
 		skb_mark_for_recycle(skb);
 		linear_page->frags++;
-		mlx5e_page_release_fragmented(rq->page_pool, linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.44.0


