Return-Path: <linux-rdma+bounces-21768-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xnVNHzpoIWrLFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21768-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:57:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8463FA28
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:57:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=C5p8o+n9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21768-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21768-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0406E304C925
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF542B751;
	Thu,  4 Jun 2026 11:49:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D74426696;
	Thu,  4 Jun 2026 11:48:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573740; cv=fail; b=AJp/KSESPrtkETBsOUH/qLUcWnQlOIs8W3XzPoKJ4S12Y67Nh3DETqUmK68+fiksHb1bXaW2jfXLoY/bDcJm/g7cFiuvPvX+XertjlA08z+IhKBCyH9v3FskwLs01cnWX1buz4jtKX1+3BGieCUl94Yx0fIOaSCun9w2i450FAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573740; c=relaxed/simple;
	bh=SENDyx4CaLb0ECmwsLJyJtQm7GsxxCOvv/JEisT3J5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3UVr+gBANGldlXOnfcEkMSaEBjF0MgpckWhP4lu0MLdgwyFmXQvncu8m1yKMVbJeZvZiYFVHJfkcXNWVCL5vUGFo42PWHUm5rt43pGg5Ia53zmnHeiJiOTLohKyhEii7KUHPKL+fh9lYAbvYSLeJLGHkLdyVZdnjLagLbOUHIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5p8o+n9; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jr+XgIFUBSJWteQ8IfUeCmC4yRiP/9K+DipWPQhBZ2gv5heVeoExPeGotN9WQw8CtmTUukWvCtcDpU3KQ17zpTs4eTzpSXQDXmKcUTeouJt+BugF8eIgi6ccZBNVEVC4Kmt59a8Htfu6uKMftiXTwJB+przh4s2Bi5HvlYfL4cpAy9N5wkm6pgOHq2REEOCUg7LC2++pJ1MZDcSXI/kc2a4qH2/E+0klSbbGk3vhHEKRuUMB6QqT3yKBEADpy+XInEGBcV9hkVnguqIQzRtA/dAyWpLmHXsHJv2wb8IQSPh4JMoHQ/Jfxw0rme6LFBsFadyjYemcjjChRNxABtJF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RQv35ctv5lgnd7mvwOAHcERDQEVo5yHL1Pv7h4SR+U=;
 b=pHHx21mxoH/aMhoJ8IhhuLYyQfY0b+HPKYXlAGNPGB2NGrfs0MT5z71Wi+alaUtnnF3bWCW3u+vFqI5qTi+pykv8w3rtEYXQV2FRIifd9dc27f25fA3LKAqzFEnvzhKRP5X4W6hcSRc6TLKM/5ufI1JtPQnQbx206vGLhroFgZ/7RlsoSvSVuyz9xAoponF/NK7n8ItjmveH23ud8HhEUj431C3WadFIBjI67M7HflIJtqywfv/kFidb6GuPOhB5nI4/EqmJhoQOlVcR6cYr7yitlAN5uXvMzXosiG097kzqtYebZPL3aqSsC+ncW41Q+X3mgtZf487JZijVqGH5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RQv35ctv5lgnd7mvwOAHcERDQEVo5yHL1Pv7h4SR+U=;
 b=C5p8o+n9vjSCBVCuDkW1+nhX2Z1pNhOTFONen06bX0g+vx8H83KQsKp3yRF3aeBCinYR6aNsfc/BANHMGaT20948+sM+6CN70xeZB51Kk/8TP40uftEaaJwJm3siLRhS+ziY20XViiiZ+Wg1CR1rCIR1BH+Hnzz2gpnJij23FccaFiTeRQolm6CF8Gf1DAUSbuVTGRJDx/cv4vrYbiEnd6yR3fsekHJUmSukMadyiInwglw0v4OkBMKhhri47Ec+85ZRGw/VjvSOx8G9moliazOXIfittGXD4M32HlOzV19r+QVGrbu2btwMkpYM1GE9h9OjSyIDzI+jl683ht8Mwg==
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Thu, 4 Jun 2026
 11:46:10 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::22) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 11:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:45:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:45:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 05/15] net/mlx5: SD, add L2 table silent mode query support
Date: Thu, 4 Jun 2026 14:44:45 +0300
Message-ID: <20260604114455.434711-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 759b11f2-8d7a-4919-c5a9-08dec22edf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZlmwNUzisUyq50mAM0Y2q7Q5v5SCFWnrGMq0qiYrVfIH562fc3Rz3qigHSDZu4vxC76sJni5ReO1dsjzRgcgjtuOPHMmnE8SFOg9hBoRU1hoMI1ppxZZYY0B+rvN9EXs32bVHKb5wc/0KOHCvM8zwwAco8wYlnF/5NRjyEKF6kFJvGYlijXN2ryfQs9OEvpb8fWo7haG2ERrhs1D7YlrhmITtgR+rWmPh8E285S8NvlOwSM3JnBlwG40+m6iCQoo3ejLjeErY8GCpa+ig5excvGf0hrfjZtr7LnNHL/6TEHT2Xjz2ODAvxRKgxObKIaTWm8DxMx+oXIzTRUEtvh8NzL6J6qjSBnEcCCoSDLIUc0HROKrlXYAwK+r/7fglPg2un8WjsuqLAOKkcS4WX0nBgvOxd09YlzRAp1haIar/WZmxPmE29WIR/DQirn6e1JO66TSaFhZiFHJ7TmunpPIxVsWQ34eMwVPTgFvE4gRwFCLTbcEA9htsUgU17YlAfkC0/bOVyZQkpUrRDDCwFp0OrfUI5qz2SRcweBIzcTBM+eDo8xOROzkw18zR2QNX6kepDblPjkDiM+SUnKXRvf1NWD4rSam5qhwVK9dmGc2lKXeX5gxsGdCVW96Fq3m6NKQngphfbOMH10AJPFpWUuAyUVXkuG7rFwOYC+L4vJXu33h5ExJ7C8Yv+EjFa/YQuz4ryRVX3ZpIWdocjUIcdZQ/lhMcGsF8wbuB39z3l6s6vw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V0AneuDRo/Krdsr40aACGtGC7kaMLKl0rdztzDeALvmvrJWJOCgbXksjWFV5I2q6wp6Jf/Pcph6UhY32iQ8HqKK/KiDgTgVJFlvnD5LwQ2hh9+r+NAE4hcdp4Yse/Wgp81XZZ0UDqmRDnY78WuF18xTKEghESGM/xYD5fobbFOb0Ip1XQc1w0eJowUeZXdHa1FXa6YMeJji4wkvCZDWZUyrX3Y6nMMrAuOBXKcCX4Qsc3PfNDyvCwLNQiEexa7FuOJ+7cnAAvm3Wa2ZYjagDaxgLF9067OaRt/HsaAvnya4pRZxLSbpaExEeDd03+dPjXKDe4h0L6xtSj8w1jQ52nGl91FPssnjyqXL7sWQ+eSvLHmkDSVBlg8D7OwXGRtswN0UD47IoriM2DyytbCWKV+88unjqnvABkOwiR1DWvvJWs1OPKH3X01fDyEUewm5a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:10.1867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b11f2-8d7a-4919-c5a9-08dec22edf4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21768-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17A8463FA28

From: Shay Drory <shayd@nvidia.com>

Add mlx5_fs_cmd_query_l2table_silent() to query the current silent mode
state from firmware. This allows detecting if firmware has already put
secondary devices into silent mode.

During SD group registration, query the silent mode of each device. If
a device is already in silent mode (set by firmware), record this in
the fw_silents_secondaries flag and use it to help determine the
primary/secondary roles.

When fw_silents_secondaries is set, skip the driver-initiated silent
mode set/unset operations since firmware manages this state. This
handles configurations where firmware persistently silences secondary
devices.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  21 ++++
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |   2 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 105 +++++++++++++++---
 3 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 1cd4cd898ec2..8af73393770c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1217,3 +1217,24 @@ int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, boo
 
 	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
+
+int mlx5_fs_cmd_query_l2table_silent(struct mlx5_core_dev *dev, u8 *silent_mode)
+{
+	u32 out[MLX5_ST_SZ_DW(query_l2_table_entry_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(query_l2_table_entry_in)] = {};
+	int err;
+
+	if (!MLX5_CAP_GEN(dev, silent_mode_query))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(query_l2_table_entry_in, in, opcode,
+		 MLX5_CMD_OP_QUERY_L2_TABLE_ENTRY);
+	MLX5_SET(query_l2_table_entry_in, in, silent_mode_query, 1);
+
+	err = mlx5_cmd_exec_inout(dev, query_l2_table_entry, in, out);
+	if (err)
+		return err;
+
+	*silent_mode = MLX5_GET(query_l2_table_entry_out, out, silent_mode);
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
index 7eb7b3ffe3d8..60280ff7da50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
@@ -124,6 +124,8 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_fw_cmds(void);
 
 int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mode);
 int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, bool disconnect);
+int mlx5_fs_cmd_query_l2table_silent(struct mlx5_core_dev *dev,
+				     u8 *silent_mode);
 
 static inline bool mlx5_fs_cmd_is_fw_term_table(struct mlx5_flow_table *ft)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 41979bf6a615..afad05a1e3fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -22,6 +22,7 @@ struct mlx5_sd {
 	struct dentry *dfs;
 	u8 state;
 	bool primary;
+	bool fw_silents_secondaries;
 	union {
 		struct { /* primary */
 			struct mlx5_core_dev *secondaries[MLX5_SD_MAX_GROUP_SZ - 1];
@@ -167,7 +168,8 @@ static bool mlx5_sd_caps_supported(struct mlx5_core_dev *dev, u8 host_buses)
 	/* Disconnect secondaries from the network */
 	if (!MLX5_CAP_GEN(dev, eswitch_manager))
 		return false;
-	if (!MLX5_CAP_GEN(dev, silent_mode_set))
+	if (!MLX5_CAP_GEN(dev, silent_mode_set) &&
+	    !MLX5_CAP_GEN(dev, silent_mode_query))
 		return false;
 
 	/* RX steering from primary to secondaries */
@@ -379,23 +381,77 @@ static void sd_lag_cleanup(struct mlx5_core_dev *dev)
 enum {
 	SD_PRIMARY_SET,
 	SD_SECONDARIES_SET,
+	SD_FW_SILENT_CHECK,
 };
 
-static void sd_handle_primary_set(struct mlx5_core_dev *dev,
-				  struct mlx5_core_dev *peer)
+static int sd_handle_fw_silent_check(struct mlx5_core_dev *dev,
+				     struct mlx5_core_dev *peer)
+{
+	struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	u8 dev_silent = 0, peer_silent = 0;
+	int err;
+
+	if (peer_sd->fw_silents_secondaries) {
+		sd->fw_silents_secondaries = true;
+		return 0;
+	}
+
+	err = mlx5_fs_cmd_query_l2table_silent(dev, &dev_silent);
+	if (err) {
+		sd_warn(dev, "Failed to query silent mode for dev: %d\n", err);
+		return err;
+	}
+
+	err = mlx5_fs_cmd_query_l2table_silent(peer, &peer_silent);
+	if (err) {
+		sd_warn(dev, "Failed to query silent mode for peer: %d\n", err);
+		return err;
+	}
+
+	if (dev_silent || peer_silent) {
+		sd->fw_silents_secondaries = true;
+		peer_sd->fw_silents_secondaries = true;
+		sd_info(dev, "FW indicates at least one device is silent\n");
+	}
+	return 0;
+}
+
+static int sd_handle_primary_set(struct mlx5_core_dev *dev,
+				 struct mlx5_core_dev *peer)
 {
 	struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	struct mlx5_core_dev *candidate;
 	struct mlx5_sd *candidate_sd;
+	bool dev_should_be_primary;
 
 	/* Peer is the device that being sent to all the other devices in the
 	 * group. Hence, use peer to get the candidate device.
 	 */
 	candidate = peer_sd->primary ? peer : peer_sd->primary_dev;
 
-	if (dev->pdev->bus->number >= candidate->pdev->bus->number)
-		return;
+	if (sd->fw_silents_secondaries) {
+		u8 candidate_silent = 0;
+		int err;
+
+		err = mlx5_fs_cmd_query_l2table_silent(candidate,
+						       &candidate_silent);
+		if (err) {
+			sd_warn(candidate, "Failed to query silent mode for dev: %d\n",
+				err);
+			return err;
+		}
+		/* Candidate is silent, dev should be primary */
+		dev_should_be_primary = candidate_silent;
+	} else {
+		/* No FW silent mode, use bus number */
+		dev_should_be_primary =
+			dev->pdev->bus->number < candidate->pdev->bus->number;
+	}
+
+	if (!dev_should_be_primary)
+		return 0;
 
 	candidate_sd = mlx5_get_sd(candidate);
 
@@ -404,6 +460,7 @@ static void sd_handle_primary_set(struct mlx5_core_dev *dev,
 	candidate_sd->primary_dev = dev;
 	peer_sd->primary = false;
 	peer_sd->primary_dev = dev;
+	return 0;
 }
 
 static void sd_handle_secondaries_set(struct mlx5_core_dev *dev,
@@ -431,12 +488,13 @@ static int mlx5_sd_devcom_event(int event, void *my_data, void *event_data)
 	struct mlx5_core_dev *dev = my_data;
 
 	switch (event) {
+	case SD_FW_SILENT_CHECK:
+		return sd_handle_fw_silent_check(dev, peer);
 	case SD_PRIMARY_SET:
-		sd_handle_primary_set(dev, peer);
-		break;
+		return sd_handle_primary_set(dev, peer);
 	case SD_SECONDARIES_SET:
 		sd_handle_secondaries_set(dev, peer);
-		break;
+		return 0;
 	}
 
 	return 0;
@@ -468,9 +526,21 @@ static int sd_register(struct mlx5_core_dev *dev)
 	    mlx5_devcom_comp_is_ready(devcom))
 		goto out;
 
+	/* If silent mode query is supported, ask each device whether it is
+	 * silent and propagate the result to the whole group. In each group
+	 * only one device is not silent
+	 */
+	if (MLX5_CAP_GEN(dev, silent_mode_query)) {
+		err = mlx5_devcom_locked_send_event(devcom, SD_FW_SILENT_CHECK,
+						    SD_FW_SILENT_CHECK, dev);
+		if (err)
+			goto err_devcom_unreg;
+	}
+
 	/* Send SD_PRIMARY_SET event with this device.
 	 * All peers will receive this event and compare to this device.
-	 * The one with lowest bus number will be marked as primary.
+	 * If fw_silents_secondaries is set, choose non-silent device.
+	 * Otherwise use bus number.
 	 */
 	sd->primary = true;
 	err = mlx5_devcom_locked_send_event(devcom, SD_PRIMARY_SET,
@@ -586,9 +656,11 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 	struct mlx5_sd *sd = mlx5_get_sd(secondary);
 	int err;
 
-	err = mlx5_fs_cmd_set_l2table_entry_silent(secondary, 1);
-	if (err)
-		return err;
+	if (!primary_sd->fw_silents_secondaries) {
+		err = mlx5_fs_cmd_set_l2table_entry_silent(secondary, 1);
+		if (err)
+			return err;
+	}
 
 	err = sd_secondary_create_alias_ft(secondary, primary, primary_sd->tx_ft,
 					   &sd->alias_obj_id, alias_key);
@@ -604,15 +676,20 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 err_destroy_alias_ft:
 	sd_secondary_destroy_alias_ft(secondary);
 err_unset_silent:
-	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
+	if (!primary_sd->fw_silents_secondaries)
+		mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
 	return err;
 }
 
 static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 {
+	struct mlx5_sd *primary_sd;
+
+	primary_sd = mlx5_get_sd(mlx5_sd_get_primary(secondary));
 	mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
 	sd_secondary_destroy_alias_ft(secondary);
-	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
+	if (!primary_sd->fw_silents_secondaries)
+		mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
 }
 
 static void sd_print_group(struct mlx5_core_dev *primary)
-- 
2.44.0


