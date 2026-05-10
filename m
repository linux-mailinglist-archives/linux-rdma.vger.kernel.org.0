Return-Path: <linux-rdma+bounces-20289-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPpWJIkZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20289-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:37:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33EF502AD3
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82C8301B70A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1C352921;
	Sun, 10 May 2026 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6D14luy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3D351C14;
	Sun, 10 May 2026 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391351; cv=fail; b=BeRI3WR/Bz0kD8PX1Ar7rKjGLCWwEiPM2OtD/LgrZW6bPy17hZ6pqMaQ/42dxnEHz0k6650Q9nCCaO/YZbeHxYxv+XxceM9FGIIUFxRgyEikcjfkr8rDOiXEnctUsjNzYg1NJK0Ltk1cbG7fZYrC6gCpTQsd7qmH76u4ySKIhGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391351; c=relaxed/simple;
	bh=H4hXwnLJFJpfzzGXbiQbvTVznHVhQ8weOqWn+iJaQAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcB3RUCPx5i0iNPzkh/oGHMWCBNIeHjlDf6yytWWJeqnUwsh6EvTGr8Ejs3vpFuH9lbYE0rvOTYwEGZ24o16OEp//evaVx6oVGXh26eTuK9ClYAXQg7D7RimL2a/bLiI5Z7G8NWZinXwpmq5haWCBB7K0BgL+/V2FirINK+Y/7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S6D14luy; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFYetvr4k/JKYWhz/kxfLvoKHD/fUSBsE26/JHxx75VAtgCeV7J1tszI07+Q3dkIcuIRBjqj7DQtWjUVr8vkQKCTL6ixYrNQNJsqzkIAwf3mJg/IgE8YrM3foF0tU+1knkN4wj66DBNBKJ/TeqxnqJQFp83EHZy2d4SB97sx9SynE4CbwLH5bGUf0k8ADpGPOvlb2TK2WPSi0NdW5Saa44fZlXEMx/RGadziF1WrcIR2SaMljx0yQmSCi7dzeBAClesPMBePx3w6StPKu3ksGvSSdbR9hlMKpbt+HHTutYyEMn1/blAVXT7jrUC2tk2aH1m9jKFGQV9LkICIwA218g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqNRFrbQML1SBZp9yspiz/OB9A4G0PM5gmJVxRpoUjQ=;
 b=IBF7JbF4EhupJCT4RBpb3PiLef41PqVghv4ByyBvAptR/3rcbnHJA/X2fVRpZXKeMeRAn6N8bz0UvuOYE7Go5HkGbW58ju2QOiHxZ9z851k8qdl/TkzHoQYKpjKGknPiYw8OBuFOKt3qn4xphnZ8mxpJZlKaUarOK67dxuvoUlFmQOm1a4jXVXjhqtDODc3F/7uWWueHXfGEt4w4wRipWIIOofUKl9eimYAlGHDtMkwNW8Strzc3ULzV1KXYJP9yzT6xn7hmhWLND1LddJGfwH38lSxvry+Y1xuGPcVu14vRa0Z/0TNSoepaZ22kTLVu8wYYYeEIX2fpXsgSLdh98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqNRFrbQML1SBZp9yspiz/OB9A4G0PM5gmJVxRpoUjQ=;
 b=S6D14luyFPts9zCNtGmdWnlkwsFtQQr5ldCSdxX14zifgJo8FyN+VbzTpRJLVDju+x2aOcb8oyXFIYHdzVolV14BRAYAUubzhZSGNXBNrfTj6z8wT6uCJF8JdmV174EsrvdgHrBJ6lgzfkTlj+T7o+vWz3fU01AjsjR1WoMv97YYtiX5CQe+IvX/4tM63299P6TvqixJm9W0RL/eDZBnoRPQvD04Q3+Y5W9N5x7K8i9DAfkZUAu/aqAl5MY0RANQSzAjFKHIjUdBTrIQ3MsH4GlXZnDdwQQgV7myVJPkT4LRnQhtajqRIGsbjog1ReoOb9jiwfQjgYvSXgTdhL4l0A==
Received: from CH0PR03CA0412.namprd03.prod.outlook.com (2603:10b6:610:11b::24)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 05:35:43 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::4c) by CH0PR03CA0412.outlook.office365.com
 (2603:10b6:610:11b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Sun,
 10 May 2026 05:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 3/8] net/mlx5: Use mlx5_eswitch_is_vf_vport() for IPsec VF checks
Date: Sun, 10 May 2026 08:34:43 +0300
Message-ID: <20260510053448.326823-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260510053448.326823-1-tariqt@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e11fb62-9f3e-4250-b9d5-08deae55faeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6OH/KFANxm2HAzp1IwSZC+hyWenfm+g4VweUY2L/T6IKCboFqYczL9BR7QFeBNkCFiYIykbhyTJNq+1UJZhjM81jFI/3Lo79r+LO9p5OhLnfEyY9c4pQuvrFgIktkrY8YdJcZFjCrPBs8REUjfotgeW57NEWsAvGMtqJmGmTJw/yWyxwH8ujuk313r1TmysC2OhlPY7PI24pC7wmV+z8iUhdZl46EkrmuiwRqguK0NfC0KCelsed2l6vRxy81vKmuy0mfetEO6gQqWMASmIW+A4EZiVPQl6TDrmmtXFqP05+wlGRdLjne1nEMRQ3aBF8narZjuUyeQQQfSBzs7nvLgVCtDQNL/UrskiJGtTqCU4OHDbsm3ok0YzMCwcuzXIF+0nFIK7r19uYrV5DxWYxNsEz/MD3I1qKVoFfccnDAIPHR0HWsB2lkls7mN5evmiTMNXXXQUnPJrRmi5c3XjXKqIoho4Eh8WJmbPKQnKuphQSnf/UonhZ5nFNc1CqRml0+TE0cPiDzuNB+C1LY4LK6DEEdjJ3wbm35HXeiez+uGRUixDLjCj6UTYB581ku5O96FkZNyqPkjq1aJ6gZCo3g3b6NZOn1C3r+WU7kpf+KTLT5SDRErs5sDvcbhXBQn0/lnyf8gCeL2SxGQYisCmeLEdU4Yj6KzTxMpcnx+vN79IauSx/t0PXcSCRD20WvDq8SWFhvmrIzumuTb74lPyu2Kk20zsSol6r8JZy+uqULGo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wrvw32c5tVA3JRnNT9nGbgaO5Mv45J5bgwhtcC6W3+cFo1SoJs87hvSIpnizB+53QFcscweK+a4i1oWHHX1KC8d+9jblmXZgja8I3aWLAKjJUibswG6QC9N+sX2IrT3PY3znQWCbzczUmY5yPauy/5JjE6sNvn7EhhA+nyX8MLNLq6SpDZENcKsI8zXreM4yWT3z3hNq/vD1xgQBKO4vevuotLDYwPKHh8RmkMDltoOenJqt5/ElCQPzePVTHNZf0+x4qHGThT0EvH461BXEIRANJMDmBv5wxzIlkdqFterXqQ9slO6W6FMUUtZiSufTceb34iIfSCPoXMfUhQFPAtgJqhkKNTwj6APD9kyDp16ZXGJFQ8Kl8e+9WABJ3w++RmPrem2I4jTj4V+Mq5Io2FD24xVdDd/KWEm0g9t6zT3rEWeylE9RmEAfViNeaFYw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:43.6725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e11fb62-9f3e-4250-b9d5-08deae55faeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
X-Rspamd-Queue-Id: F33EF502AD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20289-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

IPsec eswitch offload operations and the enabled_ipsec_vf_count counter
are intended for VF vports only. Replace the MLX5_VPORT_HOST_PF checks
with mlx5_eswitch_is_vf_vport() to properly identify VF vports, as
preparation for adding another type of PF vports.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index 4811b60ea430..b830ccd91e62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -209,7 +209,7 @@ static int esw_ipsec_vf_offload_set_bytype(struct mlx5_eswitch *esw, struct mlx5
 	struct mlx5_core_dev *dev = esw->dev;
 	int err;
 
-	if (vport->vport == MLX5_VPORT_HOST_PF)
+	if (!mlx5_eswitch_is_vf_vport(esw, vport->vport))
 		return -EOPNOTSUPP;
 
 	if (type == MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 8b62dde7eb70..9a7de7c9a667 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -958,7 +958,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 	/* Sync with current vport context */
 	vport->enabled_events = enabled_events;
 	vport->enabled = true;
-	if (vport->vport != MLX5_VPORT_HOST_PF &&
+	if (mlx5_eswitch_is_vf_vport(esw, vport_num) &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count++;
 
@@ -1020,7 +1020,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 		mlx5_esw_vport_vhca_id_unmap(esw, vport);
 	}
 
-	if (vport->vport != MLX5_VPORT_HOST_PF &&
+	if (mlx5_eswitch_is_vf_vport(esw, vport_num) &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count--;
 
-- 
2.44.0


