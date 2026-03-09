Return-Path: <linux-rdma+bounces-17755-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCkAJ6yUrmnRGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17755-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:36:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094F82363F3
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3359630488DE
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642437AA80;
	Mon,  9 Mar 2026 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="peSIwAuz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130837AA9B;
	Mon,  9 Mar 2026 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048917; cv=fail; b=KynOHs7niXBLb8zaVHmsCURlSCYtJW9q6hA36OXFYmIV6pBRBBG6vahbAfCutH8x2KSr1MCEHKqlXXrJ85AGDQ/QmT4lL7H2xW/KTLNRpscAYtlsWADBSUW+kjwGBIFAOw3CnXY1NYK+KW2w4B4mdjb4i9AxkCIPURhdPKyL4wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048917; c=relaxed/simple;
	bh=+Rgr7mKNr8GnoeOClpy8SsmLjBqXsZHNa1p6QZ8tRO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjW8R8AcciFGpI0WRbeY3j7lMoVwvOy8HwXrvBKt0YSCvZVwaSY1w1qp3KOAgiLk4peK7FkQX4j7GbcX+B/ABoKCZxC8j9G6TiCHwpBY+WrWci7bBnb4MC39REKX84vrHCKvzgxYDXf1SooEMcVeP5/kqRzX6OJOkdVzgDSXuNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=peSIwAuz; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIH8mABbOQ3+a/Mc2ZFStjGsGDF5VFRX1hr2k2FjRk+eV3PuFPUn82PlDd1BdZyrwImlQbPbAoNT/4LotpWC7zjdBDABRDr1nkLjz+cjVEpMEaQkNbgVrPLhuqNB9udQJrhzqAQjBsPWpWVA/V4hLloo2R3gAVpQQBHa+aphkcq6hjWGW1pyR+jGumDDaCdEh6HXGSOqBnLG7//ufvgesC3X2ii96ObK2M7yDxFj0lnxnl+Sm27Lv2G0q36P1LwN8UMGR8gO5JithoaUUdlXVH2OUhHm1s2bb5fKt6+MsHrPVDW4eWSG95/mtUKjuleT95rhnpf4miviRL/bByOZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3kYmlXsnpzfJ0iEobweDJAkgO3f8Pv/HfCZpDv9koM=;
 b=k8W0g+RjfNSRvea4s6yIPeUqrv5+gZ3xou30kcPEc7dCs90MHDnYL+Pq1nPLsc5ril3hDwoaOiA9UDbRCRmrGHv9CKym7BOm3q377avVUhfQZhM/ygqgOm8hPyDFOvhMoTNdeEXeJf4KxKShDLbpn2UuocR7xLG8HO8spqw9+dzZiAQxnKzFsXLufREFrQi1I6Nt0bSw+COgt56Cw4XgxYSVijyZNEHnXV5adVPRKuhC1jxOPSgqjDvl3ijhIOnHPH1f96KNpeZRA7aeBTypxY+laijF/YewhJiXiJubwZT47NTxKq5Bt44njlRp06XWKd2gsJ7U/stwepm2YTATJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3kYmlXsnpzfJ0iEobweDJAkgO3f8Pv/HfCZpDv9koM=;
 b=peSIwAuzHUC+0a9aDDkCvvPYbVkzYTBHrI+jNX4hbz/uPD4hyHOa8XtR6odKq3H/Ya6TqlddE2Scdy2ZFnh9yqLFqVsW41TV0jFfNJPuIpeR+c/4hkVvLk3gMx1fRa9Z7a5ho7tVp/bJSUVKcC5s8tKwT9LkP3t4rxlLhRE1l3kbkiMOiE20JB4/CTdAX0ivYMtf7+/t5p7sQqnpDkCUdaNLE3f+2vMeKe8Cw91F5bSq6rCQwzBZqoeoiJRH94rZEAsNnl1npEiA5ydWIrbpYPsY+tpa5b7S99+0mPvKyR4HRXfFjB7gX2v4glMxLqq2IBDVJnrqlKFe1KmTjDOOgw==
Received: from SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 09:35:10 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::dc) by SN7PR04CA0077.outlook.office365.com
 (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:34:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:34:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 2/9] net/mlx5: Add silent mode set/query and VHCA RX IFC bits
Date: Mon, 9 Mar 2026 11:34:28 +0200
Message-ID: <20260309093435.1850724-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: dac5a100-f449-4e85-c608-08de7dbf285a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	vvAAwkNbI57hX0TAqSspKCYAK/gmhSXhsw6xn7HGX/qmmwoLT1nMEQz2QHrfMHXQtE1f4dttnTU4XvJauQ3NUoeymVTsjeh4jcTsRvAhaNJxiMSSBXmKnSPiK7bCCWZ0ZY3z5oVuGVpDVqcHdv5DS7GkCR//4UNMCgou8BYgKuHl9bp25MeNLB/W272fzBKYB70qKI5Si3OzDpa5uL2ynFNmKvi1szMq9b+S24ViuzF8PFU9ReA64HW9dBJcULO1Hw7yNL03rh9FSjf1z0ZU6B+wRF8gS+r37CoUcL15f53oO85LFw5gsI0VDNwBx/OT3ViHsTR4mzojwn/XrjtXUmUqAegHv5ytSKeLi7T8PjnlcaqJhOgbn5pd91dl4yE77EDTiaohelnsZizk8LiNDy9wWU6/aK1f3BM3Gg7vvO6CVAiwhmqBk+nhsG3KkT+v7ELalA1WgACC99bY2ILlCehE6zfhX0NNmmSJVxXf5hzJHvlsiDDZruKTqyCZfG9egPPH1pPGFNoChqH/2A0OekqFZXaVTRL5GKY+E+OFAGw/EtAQLfSBaLbETQbP8SQaE1YAjMGByOWfZSjdvfi69RVi11dVpCDlb+gqPxVTx65PzERrxGaEdQ/BEk61gYzOCljNXcK5VQThjDASorcksA4MNX8zdIdeSmIkU44UvS8GzT5E+vtKjhpxILGU4bhU7yThSy6j/gAMVSnyOtjabYwk6+vyBG0ooBMb/EvDQwpJ8KK72h2B8vBNh/ml1NSIUCzhraguLAF1IboUfJcfQw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B77+CGnhEXpk84q0GiYlRe28fJ2z+PjmE2i7lPbz6KQ0yCH1TWUdtvRBC3T3gy8wekBPay7CATVrUB7+9EDifhw4DVYr2/V5RSdMMRPJS8tg3VLZIXdfcTL3TcNkq/Kvi46Ydz++LBHFZNgs9p51O0Fwb8od96HsxTAzb5uWkmEzKBEQHHxpK8D5WPduwy59USloh8iAf1ZtzgMqYNwg3v3NzivyLh+K5CRH2oe1ztW9VAK9PeXKJFFfKUHJhs8pW/c3SPYMk8ByucgnOgOY05e6DV8b8SfKfQE3wXkscytrA3vNmyrsZQX7T140SYnYWNySkEErw6wYKXnKJTi3nVaC5WeQ+Nu0keAB4EuDLPjPimyaVv/ik6gnFmIDg+xrDb7Imwih/EHuIGxIY45Tel6ZMSdN86m9z/3Wb3G1j5LTk6omc4VfQH+lgUk7QaEv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:10.1176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac5a100-f449-4e85-c608-08de7dbf285a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
X-Rspamd-Queue-Id: 094F82363F3
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17755-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Update the mlx5 IFC headers with newly defined capability and
command-layout bits:

- Add silent_mode_query and rename silent_mode to silent_mode_set cap
  fields.
- Add forward_vhca_rx and MLX5_IFC_FLOW_DESTINATION_TYPE_VHCA_RX.
- Expose silent mode fields in the L2 table query command structures.

Update the SD support check to use the new capability name
(silent_mode_set) to match the updated IFC definition.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  2 +-
 include/linux/mlx5/mlx5_ifc.h                 | 19 ++++++++++++++-----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index c348ee62cd3a..16b28028609d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1183,7 +1183,7 @@ int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mo
 {
 	u32 in[MLX5_ST_SZ_DW(set_l2_table_entry_in)] = {};
 
-	if (silent_mode && !MLX5_CAP_GEN(dev, silent_mode))
+	if (silent_mode && !MLX5_CAP_GEN(dev, silent_mode_set))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(set_l2_table_entry_in, in, opcode, MLX5_CMD_OP_SET_L2_TABLE_ENTRY);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 954942ad93c5..762c783156b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -107,7 +107,7 @@ static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 	/* Disconnect secondaries from the network */
 	if (!MLX5_CAP_GEN(dev, eswitch_manager))
 		return false;
-	if (!MLX5_CAP_GEN(dev, silent_mode))
+	if (!MLX5_CAP_GEN(dev, silent_mode_set))
 		return false;
 
 	/* RX steering from primary to secondaries */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index a76c54bf1927..8fa4fb3d36cf 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -469,7 +469,8 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8	   table_miss_action_domain[0x1];
 	u8         termination_table[0x1];
 	u8         reformat_and_fwd_to_table[0x1];
-	u8         reserved_at_1a[0x2];
+	u8         forward_vhca_rx[0x1];
+	u8         reserved_at_1b[0x1];
 	u8         ipsec_encrypt[0x1];
 	u8         ipsec_decrypt[0x1];
 	u8         sw_owner_v2[0x1];
@@ -2012,12 +2013,14 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         disable_local_lb_mc[0x1];
 	u8         log_min_hairpin_wq_data_sz[0x5];
 	u8         reserved_at_3e8[0x1];
-	u8         silent_mode[0x1];
+	u8         silent_mode_set[0x1];
 	u8         vhca_state[0x1];
 	u8         log_max_vlan_list[0x5];
 	u8         reserved_at_3f0[0x3];
 	u8         log_max_current_mc_list[0x5];
-	u8         reserved_at_3f8[0x3];
+	u8         reserved_at_3f8[0x1];
+	u8         silent_mode_query[0x1];
+	u8         reserved_at_3fa[0x1];
 	u8         log_max_current_uc_list[0x5];
 
 	u8         general_obj_types[0x40];
@@ -2279,6 +2282,7 @@ enum mlx5_ifc_flow_destination_type {
 	MLX5_IFC_FLOW_DESTINATION_TYPE_VPORT        = 0x0,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_FLOW_TABLE   = 0x1,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_TIR          = 0x2,
+	MLX5_IFC_FLOW_DESTINATION_TYPE_VHCA_RX	    = 0x4,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_FLOW_SAMPLER = 0x6,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_UPLINK       = 0x8,
 	MLX5_IFC_FLOW_DESTINATION_TYPE_TABLE_TYPE   = 0xA,
@@ -6265,7 +6269,9 @@ struct mlx5_ifc_query_l2_table_entry_out_bits {
 
 	u8         reserved_at_40[0xa0];
 
-	u8         reserved_at_e0[0x13];
+	u8         reserved_at_e0[0x11];
+	u8         silent_mode[0x1];
+	u8         reserved_at_f2[0x1];
 	u8         vlan_valid[0x1];
 	u8         vlan[0xc];
 
@@ -6281,7 +6287,10 @@ struct mlx5_ifc_query_l2_table_entry_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x60];
+	u8         reserved_at_40[0x40];
+
+	u8         silent_mode_query[0x1];
+	u8         reserved_at_81[0x1f];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_index[0x18];
-- 
2.44.0


