Return-Path: <linux-rdma+bounces-18975-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLA2IGiFz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18975-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:16:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7D392AC7
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAFC1311DD8E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B338C2D0;
	Fri,  3 Apr 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpFko8/l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5138C412;
	Fri,  3 Apr 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207468; cv=fail; b=ORnya7o25An4yXsa6Li7Z6klLjYXw3QHHuY7ypuuBIZrmcU9AEIfMsZ6GIMZoPy2S8TkvhUgFvrtG5+GKJj94fKlX21t0yNen2fyXkJLlKLWcLERfn89uchz2DXvQQyjX9ZfWcJ78Y6q8ih1gnV/SHIB1HJJQtFOTX/v6PrQz3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207468; c=relaxed/simple;
	bh=EkY8c2QQPzxv8j2oIGLfR3CYz+Ae/VCC9II+U8UcziU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOH6oNKIkpplAv/gv8k8itgluaqDMVpicvfoes6xG9W0DBIDAoUiFdyzyHw8qwafzrfmW8/k7QW3X6ll5NdikS+6dipu8QuXBZ8iSQWN1WP8xls9C0q5mycSDMvfub6C1QIeZX+6KU6/XIsVGO+1LpKNF/wGhgquh+XKDn1LJeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpFko8/l; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJrtHNA6TbJCx3BUBg3Yw+UtOTUfCxvDeAzUHfI+A1aqwnZG/UGz4iFTYA/n9sxP7b57gFNZ45iDSkzSP2AN+ODve7zKzJaHBteZVpe18GxZOIhF+dq/0aZLsdZbjGh+UtfIjpvyxy5RX6VJOoXWuKRrOiBpNs7sE4uSLViDdAi+hFgXFSQaHBZT0/T0fL7YBgUE8B2Osx42JYPMKc6a0V9JhbNzKVRDGB2G8nLl8vp1bRrCrclbZ78yo/3X6QGtKvZI01dafUtv4ynXolCxeTSKFqv+jYS3AdPdMZJocmlLpCVCQyVc2kSacxhNjcjYO54KaclPTDQ/vTXJXktAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sbWdnrjXMcAGaIUoY8btvw4kpvQh3helWrysZixPqs=;
 b=MEHQQf9GfXml2zqsIaRxiVYiFW5ERs376pB3ZHwNESOe+R0y1mCIIrRoZxIS2nQUjGUXIH+D+rGpPVXfsjyBnp1lR/0Ga1T5ynvuT5LPFHj0L+1ukVwGD9+H+n1hHjEijE/f2u0XbtrsmbPt+SiFZoUcg0dKM0jBEdUC84gT7TS95SG4d1jAPBOTU5Xws30fB1pj6cJSSgxiRvhrzFuyTO42Yhm2lRAQksLk8PxKkNvxpnYdC5WjhusJSvJcf8O6xCdZEKtBtbja+rBzXtVQRe1x8idg7KqGL3RujYkMWzMFZ185Ecq4J+h6y4LeBU+zA5xRl0Q7E5XrLZHbGwqjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sbWdnrjXMcAGaIUoY8btvw4kpvQh3helWrysZixPqs=;
 b=ZpFko8/lTUx5bYowBHyOiN3wT955aMfymRHDodXgGwzKJJzfTgWdHnGLjM+p4wTkHCuy1WbRPZdyCOMJpJLCdnD1P5MtHz4K8Ayx2f3/jrUbcIy/jYRm2jOeQJh7tSu4/GqZbfnoY9Cx4S/v+NvCMo2R/DY42L8eFRMiBb7SeW6M0DgJPhbweonmYsnKoIdUcByII8Lk+7zNn1ueV4aoHVtPrh0g/cSRvg5WSef6lbDOoosGCtj9nr0JsmK2swdySDtBuheYXtBoKgPu48CSnyu9XznxhNQbDdnGgRvy5wg89x1Sei+ZX9Api8MbzSREKGGaQ6ReE25VO3AUwMSF/A==
Received: from BY3PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:39b::10)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 09:10:59 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::71) by BY3PR05CA0035.outlook.office365.com
 (2603:10b6:a03:39b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Fri,
 3 Apr 2026 09:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:10:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:10:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Dragos
 Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman
	<horms@kernel.org>, "Jacob Keller" <jacob.e.keller@intel.com>, Lama Kayal
	<lkayal@nvidia.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V2 5/5] net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode
Date: Fri, 3 Apr 2026 12:09:27 +0300
Message-ID: <20260403090927.139042-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260403090927.139042-1-tariqt@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b14c3e9-bbef-4fb9-7b07-08de9160eb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b2o57Isp+Kwm6S9W8TXLWkXPEGKOqt3L7Fpqc0cQwg4C6QWOwD0FZ+biH9Vz2cXjN3ZiZLp0mXTSPGndMrYJ6/xsRzNyaQhRrM9JlPBVrJxnVY3+9PAO1rQoH2wIQFGe64PzY9a0NKW3vTgHw0CW/IJ/DP4JIwG8HfS01+exmpIe5QB+KKJGcxx2+UvdCA1kHVVUjFn3sBjY5/3QKlPvT1wmtMfYVc3DYLYk9+pSb+hgR/tvQ4Ou7H+bLb2kZSkKNZ1kpUX9aS67E+8wHWpQMbCffmyuHedqWpUmgZ7eRVMhDio7E28owKc91Y3UTcK4ACp7HTPyFwspGULdotgLjV0q560h/BUWPU2k1X6h57AmeUvJeslQZ/phrM+oUvcm3YzHJtJnqch5siWw48gjlaQ1T0nE4888/Qy/lwROHcWtKsMBB0aAE9pGEMdrlK3Ixkke1QwvVy6sBpTVoH0sTHWr4Lq+c7A6JQc83XhaJlPyCm4J44vpstjEb67lv7A6hIDn7VJNk4wmmJdBxlsr7xrY5FE071ePqd+oqfmaF92byMkiNy/5Xv1YEmmgboAWGCK8jlFaLfa64OMgau/tvrzfYrWuGO3NluvH8QnbPym+sCEHEG/awFK9XTfiBoyRHM0ZHHoys0oEgclWLOqwzH6jenjj9YQmeHi+AW6Ck2T9e9pZxRKb0AyOGRKvshjUdhhsWmzf3ukggiSgQN5eyAtSg6yTGbKXHy1T/mllywFx/6VnLkhvmA+C0nDcxCP//U3B8h3Wz/r9lyNVzDdHJg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ugQjkdb1KIlpp+LeXBUosL8oaRufyBYSjmEgawx99UqSvf6rOvKXGV+9GN4+KWPi7wzDraaWKWy4sMgRPBWGbLPhNtvT6s9xcB+SACoYPqu3uUaVKHUnJu5GW3DLm7yuKGb929+SMmAFfmDd8Nt9SMnBO+pnOwgJb6hsuwLX/94HvpawyOYcHl5Cw3N0oJWLMTxpB7BGl0tmK+46f30Id21vEyqvPn4vhMk6oiWo7z/RATKMg0FlsF+L/jz3SvYEQUlDk3wsuaHfI0liAiDatBwiHph/kTF2N/uwMzyy/TzChYOpvWrc9zWZJA4yyjwqN78l+M9SznFlwpnAWZE3sTCvw5sTEKpMQkLmtvHuQEXzx+sI0Ujun1qd1YvOs7ZEaRDv+oDaw7JWIdXdqV+IibkA37oBcgAXbLPLPYqgfNYxuhwQV5qQX/CrZLiY5eUL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:10:58.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b14c3e9-bbef-4fb9-7b07-08de9160eb87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18975-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 13C7D392AC7
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
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  6 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 ++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 60 +++++++++++++++----
 3 files changed, 74 insertions(+), 17 deletions(-)

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
index aa8359a48b12..4ba198fb9d6c 100644
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
index feb042d84b8e..5b60aa47c75b 100644
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
@@ -702,6 +731,22 @@ static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
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
+
+	/* Recovery flow can call this function and then alloc again, so leave
+	 * things in a good state for re-allocation.
+	 */
+	li->frag_page.netmem = 0;
+	li->frag_page.frags = li->max_frags;
+}
+
 INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
@@ -1899,18 +1944,17 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
@@ -1971,8 +2015,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 				linear_page->frags++;
 			}
-			mlx5e_page_release_fragmented(rq->page_pool,
-						      linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -1989,15 +2031,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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


