Return-Path: <linux-rdma+bounces-18974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD/PG8aFz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:17:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E139C392B19
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B803105069
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D843890EA;
	Fri,  3 Apr 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JXVYJCWY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BF38A72F;
	Fri,  3 Apr 2026 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207464; cv=fail; b=b5vn6SqB6nT4oGLzh+7Y2KzHRUKUMZFuDLRL4ew7myrp87WD+CXxK9Dth+cpNcFxaXPocoIwUKZniimZmrwi+hEpC+N1B/Giqza5hpu+qaFI9NOtl3pZbT+3ure+8zqIVJhgGYeJBylpSk6e8200RHpBG0K0qExVIwE3ZeObiqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207464; c=relaxed/simple;
	bh=wsq8b9R041HUbXWhQB1DPBLhGCuHEfHEzB5kb964KQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRrhYDDRboktLOuEDXD0/EbDpxz/GBshdmx7X9tA3PWcDvHhHNyJiap/1cwV8n5B49NRPLLrBrpQ1gRGx3UoXDmIFOTt5z/fFs+qpRt8Hif5bDxECvmDIWEJGtkfyo5Td54FlkBhy3QZG5HAxVTRHq/pfKoT6R8vwtrs4M3Bfas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JXVYJCWY; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP2Jlqm8J39qddcdpwqBotpP3yxfQjBIvZeFha0k0HirUvAnOekdyIYoKdoGRm44b8T80u1aksDXiO3v8clJIA1b7gsPS6ErX3eL90vHGW8jpxjuJw4rq5SHqmpwm8T9eGYl2Z3lR40OJCpyuSYM1LRXr2V4qjCYTp2O2o2N3yifp1n8+SL825W++3zkUHUfsTm5fHW3V+NE1SVcqeFTsp28Vg/3GhkXL3ZbCx4hhP7yidMV2LgH+dp9lZDK3NevJdcccMP1xcQ+x/ArjUEEWbh/nYiOqhk5PFNpB3WQUyXyZiIiBfyOSHrqny70525SH+PsOAaap6r1mdKpSgdX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v49i3WWrw3c1hs6KdINsQCTfFJxFfg/xjqC0DhtKWSg=;
 b=BDe30JX//XT/gpfHfASMWzNfljr++XibBOm7SJj0FEZd6tgH3rEVFzdRJpH/C6C60L31lPdb6NlTUWxzP6AdJoehzz1hkyJDKhasahiHnG4lr5XgYkz9hF96g0GCmGMp98FD484ZUKPsc16i6Bg7+Oq+r/aYhlCv175oc0MmzyVXmtzY5OOm9bRdZV00s1AiDo/LKNb7eQTpoR7IJvx/KsfqcV5s6zaqoU1BrKWLWAkyCzXVus8kTExQ0PXPml4menpgArM4M/y+SF3q4ktWSf5RItMBcUyVaH7D13pSRK0WTl5PjGW7IwHFtbIJmRcYp0Nk0GWyqS8jzXRwxLPOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v49i3WWrw3c1hs6KdINsQCTfFJxFfg/xjqC0DhtKWSg=;
 b=JXVYJCWYormdibGlQqPI40WPcCdwu/VBRG37P7btrMNTMi22tNgtIbh8RBNjMohsOaUJcpyQBRGONNkicFXi7jXHYmmUiiYgy7elKAO8M1WaRtT6A7xKu/mCObzOdWi9hqBqG7J8s1dIKwIQPKVmNKt3bAWbSFCDRM8CXBzmQYlthW7YQGQ+KhSBlmaBCEM287H2ro5JfHVRujXpNp9PakejKDz4fog3JHrU+ob4Upbb2OtEn1GonI2J/r8Z5XvP81Is+xsqwUbnehB+LSpGD9Qh4BRaQjwJVtRc+Cjpi73gPbKcG6kijcKdjf3fSx0Wda1kuAbp7puqWHPBG9oekQ==
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:10:50 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::fd) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:10:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:10:25 -0700
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
Subject: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear page per rq
Date: Fri, 3 Apr 2026 12:09:26 +0300
Message-ID: <20260403090927.139042-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b07f924-517e-4593-50b5-08de9160e63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uhFfsVlc3Pzs04uss7/KD+E8+wHPBQ9SgiMP58MCZ6HIeLRO0sZAZVcdRfSOIadIR+KBJPvDbVpsx7vsfp1h8aij6bgAzP/R1FQombD7LQZ23o5WX0v6JfJX/NmliY1ClC8ZY5pWqFBgxXRJUxA0fXQ/U6Mzy5E//jbFdtIVi62BIIBy2KgWvI2XZvi7a+kPDQuLZ43Qs2ct+G714GIQ4AheV6KZRTBbaZzSD7pc3nqLZuBD34bf/XFErrPPuZ7q2Tm/6eXGV2rHUWWIi7b08aZgYG/f8NxbLjfexQx8ev98wzR5a7OBI1FXlFDFNSC0oJ09Iy6J43vicjm0TnsHm2bH3kj0dII3hi2Ipdq9U/GGsBN2BB5nMMxeEc+KXpQlh00jY683eJuKu4oLdrFWxVOveLUM8A3p3VxsPIxrnu9udnlcgP9ZtE9wQI/29s12aoipJDXjB9/QZiJFQy7FfAcCwyGOF1LD83gOjv1YaMFRG1EYn4BojuR/gUpMBHELuoRSChduPWLOh1Pecg/Zwid/8y/mNOZuf3X9QrzGzzR6Rzpcz7eBmSzHi0465wYLWFIGibDJeiJA4vizhAj4cTz42hcg8OXsJ9x6pFRhC+dTsLbPNzwnpnnlPiMMQE+d+H2ZFV8i3eCvGzLZq2nCYn730m4c83Ag8kmU7mjHy0TVh2A2Oh74yv6Te/nm5YShT/kVdKfzynp2rpxKGOnMJ0Q4Wa0fCFzxFkZPoMv2moMfTo4lf7dsaiIqAULoUJTCYGYFZcW4mmvliVnSeeLDYw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qAt6y/2uVZtKRL/vEujYRmYQt4ijb9WNh+NhomIhI2yEDldBZFa9Ja/zVv4Ins8sAt37VbqhzVuwA3JiClVamIWOdKAaW8ITiJuPSwxMm9Ttqrm5G0WSX3QvzC94ZkNJF2zlOIXoNmX/iM/D+OGqtb2MVLUBeetU9o4dQN8GX21w3SK40qFxoSxHvwm9yvPVOHGl2eb6w2G5S5lDWpSzGr97Ha5zE17N3GFuSk29wp6aTtt5KVCVsM3nNw50BzqWdsxPoN23fP59r4g/wpdPS9uFwzQz89awc1iOZFPWodo2vUxgcOHNZPpCpeoHg75yY/S7BX1JbVy4b4M1PJIkWVxuUYT3PgciwQ6mg18xoJfHBSHXpGeZyN41K2KVHcyimoXPjygdjz8TPfm3XXOQPTbgGiODBwxesKLEjzPkR+xQHT0plW0NYbAdXF0/bML8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:10:49.7527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b07f924-517e-4593-50b5-08de9160e63d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18974-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E139C392B19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently in striding rq there is one mlx5e_frag_page member per WQE for
the linear page. This linear page is used only in XDP multi-buffer mode.
This is wasteful because only one linear page is needed per rq: the page
gets refreshed on every packet, regardless of WQE. Furthermore, it is
not needed in other modes (non-XDP, XDP single-buffer).

This change moves the linear page into its own structure (struct
mlx5_mpw_linear_info) and allocates it only when necessary.

A special structure is created because an upcoming patch will extend
this structure to support fragmentation of the linear page.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 37 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 17 +++++----
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c7ac6ebe8290..592234780f2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -591,10 +591,13 @@ union mlx5e_alloc_units {
 struct mlx5e_mpw_info {
 	u16 consumed_strides;
 	DECLARE_BITMAP(skip_release_bitmap, MLX5_MPWRQ_MAX_PAGES_PER_WQE);
-	struct mlx5e_frag_page linear_page;
 	union mlx5e_alloc_units alloc_units;
 };
 
+struct mlx5e_mpw_linear_info {
+	struct mlx5e_frag_page frag_page;
+};
+
 #define MLX5E_MAX_RX_FRAGS 4
 
 struct mlx5e_rq;
@@ -689,6 +692,7 @@ struct mlx5e_rq {
 			u8                     umr_wqebbs;
 			u8                     mtts_per_wqe;
 			u8                     umr_mode;
+			struct mlx5e_mpw_linear_info *linear_info;
 			struct mlx5e_shampo_hd *shampo;
 		} mpwqe;
 	};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1238e5356012..aa8359a48b12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -369,6 +369,29 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 	return 0;
 }
 
+static int mlx5e_rq_alloc_mpwqe_linear_info(struct mlx5e_rq *rq, int node,
+					    struct mlx5e_params *params,
+					    struct mlx5e_rq_opt_param *rqo,
+					    u32 *pool_size)
+{
+	struct mlx5_core_dev *mdev = rq->mdev;
+	struct mlx5e_mpw_linear_info *li;
+
+	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) ||
+	    !params->xdp_prog)
+		return 0;
+
+	li = kvzalloc_node(sizeof(*li), GFP_KERNEL, node);
+	if (!li)
+		return -ENOMEM;
+
+	rq->mpwqe.linear_info = li;
+
+	/* additional page per packet for the linear part */
+	*pool_size *= 2;
+
+	return 0;
+}
 
 static u8 mlx5e_mpwrq_access_mode(enum mlx5e_mpwrq_umr_mode umr_mode)
 {
@@ -915,10 +938,6 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo);
 		pool_order = rq->mpwqe.page_shift - PAGE_SHIFT;
 
-		if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) &&
-		    params->xdp_prog)
-			pool_size *= 2; /* additional page per packet for the linear part */
-
 		rq->mpwqe.log_stride_sz =
 				mlx5e_mpwqe_get_log_stride_size(mdev, params,
 								rqo);
@@ -936,10 +955,15 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5_rq_shampo_alloc(mdev, params, rq_param, rq, node);
+		err = mlx5e_rq_alloc_mpwqe_linear_info(rq, node, params, rqo,
+						       &pool_size);
 		if (err)
 			goto err_free_mpwqe_info;
 
+		err = mlx5_rq_shampo_alloc(mdev, params, rq_param, rq, node);
+		if (err)
+			goto err_free_mpwqe_linear_info;
+
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		err = mlx5_wq_cyc_create(mdev, &rq_param->wq, rqc_wq,
@@ -1054,6 +1078,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		mlx5e_rq_free_shampo(rq);
+err_free_mpwqe_linear_info:
+		kvfree(rq->mpwqe.linear_info);
 err_free_mpwqe_info:
 		kvfree(rq->mpwqe.info);
 err_rq_mkey:
@@ -1081,6 +1107,7 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		mlx5e_rq_free_shampo(rq);
+		kvfree(rq->mpwqe.linear_info);
 		kvfree(rq->mpwqe.info);
 		mlx5_core_destroy_mkey(rq->mdev, be32_to_cpu(rq->mpwqe.umr_mkey_be));
 		mlx5e_free_mpwqe_rq_drop_page(rq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f5c0e2a0ada9..feb042d84b8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1869,6 +1869,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
+	struct mlx5e_frag_page *linear_page = NULL;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 page_size = BIT(rq->mpwqe.page_shift);
 	u32 frag_offset    = head_offset;
@@ -1897,13 +1898,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
+
+		linear_page = &rq->mpwqe.linear_info->frag_page;
 		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
-							 &wi->linear_page))) {
+							 linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
 
-		va = netmem_address(wi->linear_page.netmem);
+		va = netmem_address(linear_page->netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
@@ -1966,10 +1969,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
-				wi->linear_page.frags++;
+				linear_page->frags++;
 			}
 			mlx5e_page_release_fragmented(rq->page_pool,
-						      &wi->linear_page);
+						      linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -1988,13 +1991,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
-						      &wi->linear_page);
+						      linear_page);
 			return NULL;
 		}
 
 		skb_mark_for_recycle(skb);
-		wi->linear_page.frags++;
-		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
+		linear_page->frags++;
+		mlx5e_page_release_fragmented(rq->page_pool, linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.44.0


