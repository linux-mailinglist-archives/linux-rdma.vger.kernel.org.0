Return-Path: <linux-rdma+bounces-22163-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0r/HFtvwK2qqIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22163-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:43:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5916790B4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:43:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=C3pt5oKs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22163-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22163-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C940F31D41A4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88F3839BE;
	Fri, 12 Jun 2026 11:40:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF683DEFED;
	Fri, 12 Jun 2026 11:40:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264422; cv=fail; b=O/UyM33QJ6NtS8W5z4s7MIuhIKDzOEhzUAk8DojSvkescgmEpnOIQQlJJHzox7v/xt2iriNwDdcgdPFPaGEEGeQ6lFIcuRqgOqL/XMcxHA8HV4PTtJiVyDPpVXGNlPK5pBGPN1EuKNFYrj7fUa4T42BwRx1ueoLsMRvhSjlKi8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264422; c=relaxed/simple;
	bh=U3TBuEupDyfn1U5N6a52P70EptAbZ15QQ5bZ5+rqJqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opk3dA7LhAo6gctHERTL6JQdVCq8EXFvNclPQ/H+1sm5UM3fk3ZGYLobyN4VUsO3/z01YZu+0Ql9p050cxHvy0EsKSfjPX5i0ZIUz7wfpPGgfwN7lxZYe6rdyuGheCKiNj9oinzoLzi/gOYFyZrBOuimwB7DdN4OVin/ZHrFS3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C3pt5oKs; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEnLY0jE/nqvo6t6AicDr4JNfl2hjf/j6tvxhGuHGMgUJsw8t4YepX7t/7+X7TkGvwdH4uMr7zeN/8oAsTaLifGzrUhx62H4iWQiA1jSmSeZFdE0L+kmZlIoqsK1rNDYNbVqlbjuLWhudo3cl49fjRHvzs3eQUIOM1xZt4skMdXijEict4fZdVMJIK9tLelyvMiY0rRs7qhiAQ7mnea6jPnIaVVHamr+BeoSF1gWHAdTEfbWPvY849pcuF4WhJANOW1B7uzWr+iosjqiAqrqGp3uftfhC4BQV+XnTtpUDtrAgzJiQNLTrUGDa/mcKJVg9D29c/PcYFqdyo+vD4TMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFM/90Cj5CnTVQZXwf6Ziwrd9qmzwOdADD72R6a5jIA=;
 b=R4e2VEM2/HiHTo2wuNStd42pyFk4Bb51814CNLUHfWVUi8AVWFc4B8cUHZ2FJmhdgPelp5QvXUFYfl3pLoUGLMCHViCURxJZXHCZwVo8FOclFIZoq0NH3wgyj5buPly7jEv5X6i0n9onhhXAPhzPnyULeh+JU8/HnIMpZU2D7e2bFddRviB3aSyhc75msl3fEHC+onvPXIdxqKZz3JCZ/egZpDLEgzt1sx5688qfMup5FFNh8gMKv0vKPjCAzPfNCrf+84Fk1nfG4R/+S08SjeaXqrorNW+5ShsDpYhn5WfFjKpPkkOgAWQprhW/M0mPLPUWMrfUIYq5s5h9J+5FbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFM/90Cj5CnTVQZXwf6Ziwrd9qmzwOdADD72R6a5jIA=;
 b=C3pt5oKs6um9VZPweCruEbf7GBcPJs2YImNVX3w2K8moGAlBMz8CgfSJ9dOp98BROguCFOTaJR2XwaKAgvZqX27ykvv6P4evZbB77rkT+K6vmft6e6PNacMQruX9dOI6W/9ZYDhjV3BqACAUeR2/pFxvsq4SmArW1e1iYAcG6yt/yoCT8ZLf7a8ncIqDDnTK4Bj7cD56SnUAsmFWA3anaBy+l00HQbKyeG1kG6OpCunBF9nqeKZwvRy9zDuBJgSz4fT+Cof2TC1w8z0loGDDcctVyvvfNEsGNv5FzzyaqISUgwk0HKNtY6JrVOiuT60nfzsTonhgE/MBafphjlc7yw==
Received: from DS7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:8:54::13) by
 SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:40:13 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::a5) by DS7PR06CA0046.outlook.office365.com
 (2603:10b6:8:54::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Fri,
 12 Jun 2026 11:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 05/15] net/mlx5: SD, add L2 table silent mode query support
Date: Fri, 12 Jun 2026 14:38:54 +0300
Message-ID: <20260612113904.537595-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a92b34e-97b2-4470-c22c-08dec8775e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	C5co21vctSKIM/VUovggxhuod78iRpYLSKk647rX2Yg60uM0SoGe6W+bn+0BpTXAXllLUv6WaRWjZ1eqmT3IOVklHOUva4u/pgjbT+avn7bOBzp1cVGXm6u7wK2LEP5MJC7ifEGtx66LgWvSBaRQuJQNMpL7P2Zois9hCsKOoWpsPXVWix6XE7bn2lPTFMVq2l+UHvEaxNEOglrHXKrGJlOzgE9Yff2cLRM8vs9zP7MfFZZmUF7y0Y07H++mymLbQry+Vv2U57IUoLU94sHC/lo/26D58twUILPQ7Ta2m9BQqpty23sjhFgXGmud5mmETlPsULwYndm7lDiUS28o3LpmGyySG2ke7j7uDLMuMiBkKvM/cd+H4IalBt6DniO9S0n/lK08ArxzHcPBe8vcrsjrRPczrpfoXy7VjcCXlSM4mbN2Gbt4bILaH7HNRJteqnAx9p9k54n7PuBk8GgPANoJqq0l5iWgRJ3wMZkJ0etQd2i+aSw286+NeO433mOO07B99SZk+qBJVOAo0UaNBpfzXIQ91Bun/0fd01xx66Wcx25GrdHikCdFTX9x6GMxDxeb86yiNrUiJI2a9bWmMup9NrRAIOaWzv5y+YmtpSJwOZ8h9oYHzkLUtYmTtBO1uc4jAs5fXkVL+t0v9p75kqRfMja+JBmoCznAL1ndpA/1j2pAqV4K8+NZsPXpUhJbD2p0tNlU9MUXJ+aYvjH3jVXJsJ6wpKFIqI3Xodc5HxM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tx3iI8sFpIhLIGNHEKJQOcR6glOqxcaaNBaFlKJlzWKxQKe/PD4tpORandzRFsrn/5grMJeiWOnNvOsFzR9XVafdljrsdbhWazDsIOKUFJu9y0j0PdpP8HqcC4R4bkoEZ0I035gMGxLF2JuP1W++RV2uj8AUZAWhTGWP4o2Sq6sD7ku5rFLXY8Gh81p/4i11Py6qzAj8l48lsPHnSj4Na3FGidUSQ7IbDbfVzwwZtJRr4Lv9s8oTrALMV21W6mPTtfSney75EiUl6BFOW5hytTg8qbrBnuiC9tOX/IjUfuuDJSu6leFC+RmCZGbU2bw3yoZX1MYnIyxsmyyjju8wWHea+4v+WJZ0bZcLaZMDYu2x+pGLF/OoYWvAp6phhS/LK+fggTpi7Uc+MqnvunesBjBhjwrKrVwGlQgxp7+hwJ/0gG2rIr+xGghdgPJzS0Ab
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:13.6987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a92b34e-97b2-4470-c22c-08dec8775e17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22163-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD5916790B4

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
index 5209a27f82ed..6b007b038f8b 100644
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
@@ -469,9 +527,21 @@ static int sd_register(struct mlx5_core_dev *dev)
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
@@ -589,9 +659,11 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
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
@@ -607,15 +679,20 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
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


