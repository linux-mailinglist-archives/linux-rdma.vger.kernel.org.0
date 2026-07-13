Return-Path: <linux-rdma+bounces-23103-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QZkgCoimVGpMowMAu9opvQ
	(envelope-from <linux-rdma+bounces-23103-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:49:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 950AC748EBC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TpF0ikFy;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23103-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23103-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4C5304E333
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA923C1963;
	Mon, 13 Jul 2026 08:44:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B433C109F;
	Mon, 13 Jul 2026 08:44:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932277; cv=fail; b=EFi46vv0RmaehkfCw5C3+NfLd/l3j1F4FWFEq5fvPVm5KJMfGNmdWGNCmqU47Qn1I4XKdzYfJSMPPFRTKYWXogK/x6metUX4UNVBRvavZWuNMzf4yb36e76CEwDbUTfPXN4m/ciQBeoZGxRqAoStZAFEnTf2bo2cxzYuD2E4HPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932277; c=relaxed/simple;
	bh=qY8uoAs38pCzHVqpTrVQSb0ZhjNZXI40aQUJOBu35iQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnaeidMyBN9PRJ/auG4onrirnA7GUSa3BBsOnRcNypfmoj/fYcOwAUqstfYW9Mykh81TZuhWtJ3uEVz789u8ZHjwZNDlhJxDEOo7vYUei2qZDlSm3XV/RM3orHLJwtN/wBClQ5Ay3lW/rGCQfToCZy9KqhivoChnAskobU2b5oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TpF0ikFy; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9/+01PkEK3a3zGusCJHPZIjgS7co6izGPd58BZgDRGSoYaxPtLwmGyaerwcat4OTChRwk0c8dzyBdjP2VJz34nz2vDcDT49FnQVAItvEKrgAUXB2oJrQTE7Yug8NAxn4210Innx/M5e04gn/VhgLXGDm9vNMAJMDkrjF+q4U1edHzxkO1RMACiNWY06aATAKn1Df0jaZaXdr+jgQYS8Ht8auLydjmL+G8CttedHPmI8iSs8G+MF36c+ykH0nHNb4ymnyHmFuYCuP3Q/RWi4jyycS9EJpUesm9vQ2daAjyVqOA+SI074IFyp8d8xPAXwV77D+6Uxj/kCcamieX4LKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOiEZHT53l8YKrUVjmeYrA2xeEBpLgteFshysnEE9Jk=;
 b=V5QudP0qpLAO+044idkWw9PInyiym66lOjHI1mKWeFwtt4C6cVYYeUauiGwrQZhxzC5PKRnXRR2CbEpO74ueNVAcNm0Pox3OYChhV4BJnCuOkHt3HlYVwSE/SNrEIo9WRlw5IWxLDH30zNFy4Yb6QoAV+HK6PZq8SQzf0XxS5kc2G+09ytOEoItRLtcqFfacnHu/Xn9LtnE0BbguJ05B3msPlMQtbG6lvjAeOu8JRRixYN4F2zPqBhRm80JhAIGI2HOR6/aMFp/wn1o6AUEc3gp/M799Qos4HytI00Dfq1a5DmmA3BJnB4zOQ8fopkkf1n0q9tdSMcvHpfjfiqdOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOiEZHT53l8YKrUVjmeYrA2xeEBpLgteFshysnEE9Jk=;
 b=TpF0ikFy2Lh6WcGkOXX5F/38Sl1lxanlnzddL8oCTqfYQ02+Nx4WSUH6lG5QBjdQEHgyBgJQWAdTnD3t7wI7BI3kHOtvevSRPwyfYAXMKcqtC44OASCRat/bGSaGQbB1Fs2d95usy4UiF3Iw5zx+MpFhze2nTA1QASwSrn+MqN7Acun8suE2cllxoeJVPor9fNdcq2zczDNKVfJDHxx8HJX9fOz40MZE1tehmW5e04OyZmrBIKAnr/2RzzqZLyrJYUawUZfK4gMt4hMf8KWSLcArj+u2jln0SM97yH9vTyEbk4zO7hJRZHU3OidxysZGMbDpagNroCHb1Ex9mX4ZwA==
Received: from PH7PR02CA0016.namprd02.prod.outlook.com (2603:10b6:510:33d::15)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:44:13 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::9f) by PH7PR02CA0016.outlook.office365.com
 (2603:10b6:510:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 08:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Mon, 13 Jul 2026 08:44:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 01:43:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 01:43:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 01:43:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Alexei Lazar <alazar@nvidia.com>, Alex Vesker <valex@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Cosmin Ratiu <cratiu@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Dragos Tatulea <dtatulea@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Feng Liu <feliu@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Drop redundant esw_cap, reuse e_switch_cap
Date: Mon, 13 Jul 2026 11:43:19 +0300
Message-ID: <20260713084320.1015240-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260713084320.1015240-1-tariqt@nvidia.com>
References: <20260713084320.1015240-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7653f9-0ee2-4b5e-2e9b-08dee0baea7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	EgoEa5IEnUJ8nsyitoQPHPBiByR3Nl+LqjToTdxn5dAODs/cSZWukOQothqdEuRiW+6dMx8jbrP1xhjlHszX8JSl2SZwWXx/ypYqXRBO3kCKB8/ACEZknv7cwhebCrM8UAF9sJT5edy5cNSsH3/fP0C9Pj0Ml95+PrCx1LmFRJWZ6VGk765pW4Y0cFXzf2VTLWP2PnryG5PoehNU5rWGFIMILdk6xM1Il48ZDq7pUnbG4EXu/9tZVa33QHolAsuA++Ueo3TdUJbrUX4nN4lQU5LzgtPpnxOcRYrtxAmMAwx3ASLKR7vf6pgXbkxCtwxTKLPK60nfRIN3FceRrkD/7Jv7KDBmAc4AHlvLT9tIsUITJ3sZ+5keo4zp7OI8PycnTIaxgK8sM3XrPyueIpDVrUzGj+h/pLHPg2Ef6z0+oIXnnJ1q66J6Z7owSiQbHJ9XLBbzEt4dqMTNKXSUd99oaYN6hAawtb0SfRQbAh+KhLh8h1LnMHqILuiKrHJDedqqhV2xBqS7lpVQjR9N6krTT1nXYwUwmLeyfvVSxNVuKRtd9+jIvSmUyb7uzzPpIOjs+cR6cETJylIw2j0QTAhqXzGtXq/oivv1k62uu+8AgsbDAsbdWYpcD54mnbGbtZunqlzRDFSYfMgyydRuYO6wo9m/Y0MiJOh2A5HZgWFxb+WGsccS2P0N5oQ2ofl8Np0Vl+bAyhmLhjqUGkGzMnXlFg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b9XntSK31k+GrlYkNnRw7+XZittxDP4RMPXZrMRbLuVKoPo2OLrOsISfUACnYuCDGso6Ea21kPbgmByPLRiuE4/3cwdhwkndOImoiL6nZcSBZOSfpcsCGQYbVzwclwV5hQzvh7rP4OF/OhDbwU6305o3/fOonXrnvvjJPCcUKu8/8FuVMC7MkttiKpk1+PHxuO5+riTQ+d709ti3Nu+MNMj4c/MZs0Y7wsatKqBkcL0QMRriKMBXXM60yqC+ytxdn/dFtiavfyRIHREqzSlN5NQH082NQIc+AbLJoNeEv6HqhK6do9YpEMRqmRtUlMEmlT43lpDI2Dcorbl6w/rdDWz80wfk0mABjEtm/YOvWfl52EYLH90oLj4+ArnL6ghjflB86s2KI16KoqRDellq4hB/jMySlVh14siPmxrOPrRaOqaX6m7m22AGgXmUWS1k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:44:13.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7653f9-0ee2-4b5e-2e9b-08dee0baea7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23103-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:alazar@nvidia.com,m:valex@nvidia.com,m:andrew+netdev@lunn.ch,m:cratiu@nvidia.com,m:davem@davemloft.net,m:dtatulea@nvidia.com,m:edumazet@google.com,m:feliu@nvidia.com,m:kuba@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:shayd@nvidia.com,m:horms@kernel.org,m:kliteyn@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 950AC748EBC

From: Shay Drory <shayd@nvidia.com>

esw_manager_vport_number{,_valid} and merged_eswitch were read through a
separate mlx5_ifc_esw_cap_bits struct, but these bits live in the
e-switch capability that mlx5_ifc_e_switch_cap_bits already describes
(both overlay the same QUERY_HCA_CAP op_mod 0x9 output).

Add esw_manager_vport_number{,_valid} to mlx5_ifc_e_switch_cap_bits at
the same offsets, drop the redundant mlx5_ifc_esw_cap_bits and its
hca_cap_union member, and switch the only user (hws/cmd.c) to
capability.e_switch_cap.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  6 +++---
 include/linux/mlx5/mlx5_ifc.h                 | 21 +++++--------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index e624f5da96c8..8fae90101653 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -1172,13 +1172,13 @@ int mlx5hws_cmd_query_caps(struct mlx5_core_dev *mdev,
 		}
 
 		if (MLX5_GET(query_hca_cap_out, out,
-			     capability.esw_cap.esw_manager_vport_number_valid))
+			     capability.e_switch_cap.esw_manager_vport_number_valid))
 			caps->eswitch_manager_vport_number =
 				MLX5_GET(query_hca_cap_out, out,
-					 capability.esw_cap.esw_manager_vport_number);
+					 capability.e_switch_cap.esw_manager_vport_number);
 
 		caps->merged_eswitch = MLX5_GET(query_hca_cap_out, out,
-						capability.esw_cap.merged_eswitch);
+						capability.e_switch_cap.merged_eswitch);
 	}
 
 	ret = mlx5_cmd_exec(mdev, in, sizeof(in), out, out_size);
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4f59b7e8a3d5..7de01d4f1b5e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1042,20 +1042,6 @@ struct mlx5_ifc_wqe_based_flow_table_cap_bits {
 	u8         reserved_at_1c1[0x1f];
 };
 
-struct mlx5_ifc_esw_cap_bits {
-	u8         reserved_at_0[0x1d];
-	u8         merged_eswitch[0x1];
-	u8         reserved_at_1e[0x2];
-
-	u8         reserved_at_20[0x40];
-
-	u8         esw_manager_vport_number_valid[0x1];
-	u8         reserved_at_61[0xf];
-	u8         esw_manager_vport_number[0x10];
-
-	u8         reserved_at_80[0x780];
-};
-
 enum {
 	MLX5_COUNTER_SOURCE_ESWITCH = 0x0,
 	MLX5_COUNTER_FLOW_ESWITCH   = 0x1,
@@ -1096,7 +1082,11 @@ struct mlx5_ifc_e_switch_cap_bits {
 	u8         log_max_esw_sf[0x5];
 	u8         esw_sf_base_id[0x10];
 
-	u8         reserved_at_60[0x7a0];
+	u8         esw_manager_vport_number_valid[0x1];
+	u8         reserved_at_61[0xf];
+	u8         esw_manager_vport_number[0x10];
+
+	u8         reserved_at_80[0x780];
 
 };
 
@@ -3855,7 +3845,6 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_flow_table_nic_cap_bits flow_table_nic_cap;
 	struct mlx5_ifc_flow_table_eswitch_cap_bits flow_table_eswitch_cap;
 	struct mlx5_ifc_wqe_based_flow_table_cap_bits wqe_based_flow_table_cap;
-	struct mlx5_ifc_esw_cap_bits esw_cap;
 	struct mlx5_ifc_e_switch_cap_bits e_switch_cap;
 	struct mlx5_ifc_port_selection_cap_bits port_selection_cap;
 	struct mlx5_ifc_qos_cap_bits qos_cap;
-- 
2.44.0


