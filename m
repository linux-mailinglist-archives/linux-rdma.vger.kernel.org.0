Return-Path: <linux-rdma+bounces-20294-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP8BAGEaAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20294-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:40:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FF502B42
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31542306F19A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90780355819;
	Sun, 10 May 2026 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qbyvBs96"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CB351C1F;
	Sun, 10 May 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391377; cv=fail; b=pCnyLZj67iC4rRiP1C+ZS0CJ6KAlu//6qwQx+BPUluh+ZGYHPiPkZ/gtpfU/FnTHdCQEJw1tSDXvlgCrle019Y55UrLaPiR0V4Up7k1TLd2RoRkyqaZnh1HK+/MbJnHDGY8gWSCb4EROZwDEn3z4TNStCqy8ToLaGx+WxpBZphI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391377; c=relaxed/simple;
	bh=FJ6bNCM82zoO7lIe7vpOQAMzjmUIXErxyMPLeIIyudg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qut/1w8rGzmqmy508gTv/LO1a/FvOy12pDStUER/euq5GZf62Mux55wurHOrkzr1Vjo/xeBABtwHVWNBzo7P99lBQW2z0fr0RdJPfcTguYHWxI90Z29Xpw14ZgxwZ6B1ACBSkjm0paJ/+NIu/5idJblWHAc7/1ZgdYd2RFYsv58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qbyvBs96; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So1BN2/u30iJ7+W93J2hR9fGpADO+TUY3OwzewWDfcID/S5JFF1g1gRUGdcfdX8/VG/uzUZnc2f79/kb4dwzr8eM3RR+tAH3P295zu1dYfEuVZZaRrhzIoC/sFND55Lwn9ah2yEzGNiwIiEQCr17C/ZST5ggqZVHCtL1i8rZa+UNfmUSTB+b9h6y/1leUw5fIPZ2IT4j1bqnRrrZ90A4mO0BxQB8fQYfV20I/kZNelVR22DFAZujb2QVXmTLxu7Uy47xMsptmImgRVjI+xQLVoclZGssbFlHAvOuvweHZHqMQcf6C96ulwQExy8hUxiyqbvwDvj0AKk3ja7EzAO8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WquzEuT3uild5hfbMR7BosqzCK7/3Xcu7d7smLcN4/w=;
 b=v2jRiAU23yGIh4uYMwXFKsxuA6F3mwyEkggaA1OWPu25i5pxlnj8q5PDv60F17iD2iHURLCFQ/Hq/SQyeuu4uYAV2ApmoFd6lgDJY109QIpbq0IvX9kdrd6xtVuqT6YznjiNJ9QZu233iBMjTNPRAByMV+epW0Ip276qwlgckPTAlbA+VpQWrC5PwMI31hgryUM0GLG6kfaTpBXGqYTLk8vZE8cZZmEkikvAeu9mMoezTHV3DkFmpCluSrJ/72IRsMbq0/MMQyAVKcPa4epqeDmVgA0y1YHF+FGevHbJXJXEvPgGHSKpj6PKtQDdWqxazUw1SYVlzPXk/loyb9oPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WquzEuT3uild5hfbMR7BosqzCK7/3Xcu7d7smLcN4/w=;
 b=qbyvBs96hTQHAM63gXXW6+kRAanDVvLZK98bxzsa/aODrn+eWKQVOSQ0VLLl1ZrHUmt3K5ToehImgUsUyKwstnXDr4qgK/LbUr+kuL5DK3f4dlWMwOpbTV8VL3qybP+1s0z8AtssjUaXBa1DBmguqagzoP7LvaRM3fMSO7HJl4KLkX6tTxypFZNAUx4073M0wXd0hmpxP2vfVUCShg4ZAWNNzleI1LmqQ1DFtDv1W5HWm9qbdyLsr6Ak3U+G18fEREtohjBvQNjmxe+XqT5r4nz2VR0KUCCbYkq6e6ojwY+4t5+3vzstPzvlDNTUpgVsjHVauve0TeyYdOTLYnVrwA==
Received: from CH2PR17CA0030.namprd17.prod.outlook.com (2603:10b6:610:53::40)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 05:36:09 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::2b) by CH2PR17CA0030.outlook.office365.com
 (2603:10b6:610:53::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Sun,
 10 May 2026 05:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:36:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:49 -0700
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
Subject: [PATCH net-next 8/8] net/mlx5: Generalize enable/disable HCA for any PF vport
Date: Sun, 10 May 2026 08:34:48 +0300
Message-ID: <20260510053448.326823-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e8a02a-106b-4d9b-43f9-08deae5609fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ViwZJzY6SZILvH0KUaNt+Eu54jXzXKNbCEwx77jmNDxSex22Me0CaigIhXNkudfpX1S6ICKwnkJer5lC1IRTd0hvlbMLSpDDn2HP5inBSMinBHquYEGA+jqv2cJ0nFOHVf7g0EHCF9vcyyp36PAHt/Zov0o5HPn7PwCE6EiyvkeC4LkouyQXHLTmQjIyrCkJQEEzjaBF0R2L7LGH1vJ+n3QtgvxiwqmmSrHfgfdaSaH2EJAieCKgRdrrj1sQZxCtDOBCRN/CLbXod6cx23srWyHncyfTq2QUDq5ii5tQLVsT+hWoUHzwjNg7tKdtv9uyGRDHyTpX1bVXc3lWxC59vQOb5Gjo+rUNFnwGfNou1OjmnjRLOvk1GZ6iycd7Rl49JzZiH7AKfIfbeNqpbkomLsnjK25IfalW8SdqhxXv8yUz3qAusiO4fI2yBmSOyU1Q06JX+KADrN7cQz5HOWbsAky4YciPsY2QZ4FW+WErzCwcCGSGVj0tXbr3qnD2drW1MrrWhQ5noGHYzS4hrFhrAR7OM+HdOgr/9k7ZDRaiD/i3azr+nOlACJbRl7bQWQeZnKH+tTFN1vBH+kW3T+UX4jZWjdMdqJsfqmf/1kBU9TcvLkXcfQbHRis7SfAc0vJAMhkaZrJVo2cXimOCTWahAbQ/NqGSlm1aT4vPexinU/a5LEsmUk7cXy1lq1cz8yvQaWUnHIghCCeT524uvW9TZYqthTURu1h0GPue4Wwx+0Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Au3ua7W+tr9UqrP0sy/X8OsIzp2Y7d39hcO6g+gLK7BxxkSPnSsJNwY2k4xMS4e1xdF0LVpnB2pM39lP8ZoJoTBGNr8zFjlFBTjR49qynZaw+NAE7i7sOwYOVU/9bLSoS1yXKDKHzf3E58+M30nxy+S/jtUn7CXNvg/7MMbk0lZu3s0O+C5BpraRvuJdLZEmYiZN+4tg9WF5tz6nswPDduqLOCgyz4h/rxSc77kEx+fd5Ho8ORF0uA075TSdcF071gbHFVaPx27BbSJ9MMH+Dum3mJPlSZZlhzuZ8dUK85S64Y7BT2S6cEnfM+/YCHll2G1jh2mwCVruGGk7ZfS/bk0shBWjJCMFzqcbyrxK39gapcqFl9Ox1zH6gjvZTnCfVnoN5mupe5lvA7FDus+RfUG1CxkXEoCOeNVMA/X/MX3d+xX7FFK6hyqk7Vo+4tt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:36:08.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8a02a-106b-4d9b-43f9-08deae5609fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
X-Rspamd-Queue-Id: 516FF502B42
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20294-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Refactor the host-PF-specific mlx5_cmd_host_pf_enable/disable_hca()
into generic mlx5_cmd_pf_enable/disable_hca() that accept a vport
number. The new functions use vhca_id as function_id when supported.

Similarly, refactor the eswitch layer into generic static helpers
mlx5_esw_pf_enable/disable_hca() with thin wrappers for the host PF
case, in preparation for enable_hca on satellite PF vports.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/ecpf.c    | 24 +++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/ecpf.h    |  4 +--
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 28 +++++++++++++------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/vport.c   |  4 +--
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
index 15cb27aea2c9..350c47d3643b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
@@ -18,25 +18,35 @@ static bool mlx5_ecpf_esw_admins_host_pf(const struct mlx5_core_dev *dev)
 	return mlx5_core_is_ecpf_esw_manager(dev);
 }
 
-int mlx5_cmd_host_pf_enable_hca(struct mlx5_core_dev *dev)
+int mlx5_cmd_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 {
 	u32 out[MLX5_ST_SZ_DW(enable_hca_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(enable_hca_in)]   = {};
+	u16 vhca_id;
 
 	MLX5_SET(enable_hca_in, in, opcode, MLX5_CMD_OP_ENABLE_HCA);
-	MLX5_SET(enable_hca_in, in, function_id, 0);
-	MLX5_SET(enable_hca_in, in, embedded_cpu_function, 0);
-	return mlx5_cmd_exec(dev, &in, sizeof(in), &out, sizeof(out));
+	if (mlx5_vport_use_vhca_id_as_func_id(dev, vport_num, &vhca_id)) {
+		MLX5_SET(enable_hca_in, in, function_id, vhca_id);
+		MLX5_SET(enable_hca_in, in, function_id_type, 1);
+	} else {
+		MLX5_SET(enable_hca_in, in, function_id, vport_num);
+	}
+	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
-int mlx5_cmd_host_pf_disable_hca(struct mlx5_core_dev *dev)
+int mlx5_cmd_pf_disable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 {
 	u32 out[MLX5_ST_SZ_DW(disable_hca_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(disable_hca_in)]   = {};
+	u16 vhca_id;
 
 	MLX5_SET(disable_hca_in, in, opcode, MLX5_CMD_OP_DISABLE_HCA);
-	MLX5_SET(disable_hca_in, in, function_id, 0);
-	MLX5_SET(disable_hca_in, in, embedded_cpu_function, 0);
+	if (mlx5_vport_use_vhca_id_as_func_id(dev, vport_num, &vhca_id)) {
+		MLX5_SET(disable_hca_in, in, function_id, vhca_id);
+		MLX5_SET(disable_hca_in, in, function_id_type, 1);
+	} else {
+		MLX5_SET(disable_hca_in, in, function_id, vport_num);
+	}
 	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.h b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.h
index 40b6ad76dca6..d9f9a53b019b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.h
@@ -17,8 +17,8 @@ bool mlx5_read_embedded_cpu(struct mlx5_core_dev *dev);
 int mlx5_ec_init(struct mlx5_core_dev *dev);
 void mlx5_ec_cleanup(struct mlx5_core_dev *dev);
 
-int mlx5_cmd_host_pf_enable_hca(struct mlx5_core_dev *dev);
-int mlx5_cmd_host_pf_disable_hca(struct mlx5_core_dev *dev);
+int mlx5_cmd_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num);
+int mlx5_cmd_pf_disable_hca(struct mlx5_core_dev *dev, u16 vport_num);
 
 #else  /* CONFIG_MLX5_ESWITCH */
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 9a7de7c9a667..206911817a04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1452,7 +1452,7 @@ static int mlx5_eswitch_load_ec_vf_vports(struct mlx5_eswitch *esw, u16 num_ec_v
 	return err;
 }
 
-int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
+static int mlx5_esw_pf_enable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_vport *vport;
@@ -1461,15 +1461,15 @@ int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
 		return 0;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_HOST_PF);
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	/* Once vport and representor are ready, take out the external host PF
-	 * out of initializing state. Enabling HCA clears the iser->initializing
-	 * bit and host PF driver loading can progress.
+	/* Once vport and representor are ready, take the PF out of
+	 * initializing state. Enabling HCA clears the iser->initializing
+	 * bit and PF driver loading can progress.
 	 */
-	err = mlx5_cmd_host_pf_enable_hca(dev);
+	err = mlx5_cmd_pf_enable_hca(dev, vport_num);
 	if (err)
 		return err;
 
@@ -1478,7 +1478,7 @@ int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
 	return 0;
 }
 
-int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev)
+static int mlx5_esw_pf_disable_hca(struct mlx5_core_dev *dev, u16 vport_num)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_vport *vport;
@@ -1487,11 +1487,11 @@ int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
 		return 0;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_HOST_PF);
+	vport = mlx5_eswitch_get_vport(esw, vport_num);
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	err = mlx5_cmd_host_pf_disable_hca(dev);
+	err = mlx5_cmd_pf_disable_hca(dev, vport_num);
 	if (err)
 		return err;
 
@@ -1500,6 +1500,16 @@ int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev)
 	return 0;
 }
 
+int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
+{
+	return mlx5_esw_pf_enable_hca(dev, MLX5_VPORT_HOST_PF);
+}
+
+int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev)
+{
+	return mlx5_esw_pf_disable_hca(dev, MLX5_VPORT_HOST_PF);
+}
+
 /* mlx5_eswitch_enable_pf_vf_vports() enables vports of PF, ECPF and VFs
  * whichever are present on the eswitch.
  */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 2eba141bd521..51637e58a48b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -452,6 +452,8 @@ void mlx5_unload_one_light(struct mlx5_core_dev *dev);
 
 void mlx5_query_nic_sw_system_image_guid(struct mlx5_core_dev *mdev, u8 *buf,
 					 u8 *len);
+bool mlx5_vport_use_vhca_id_as_func_id(struct mlx5_core_dev *dev,
+				       u16 vport_num, u16 *vhca_id);
 int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap, u16 vport,
 				  u16 opmod);
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index f8e6b1ab7c5c..e0848f4e88dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1283,8 +1283,8 @@ void mlx5_query_nic_sw_system_image_guid(struct mlx5_core_dev *mdev, u8 *buf,
 		buf[(*len)++] = MLX5_CAP_GEN_2(mdev, load_balance_id);
 }
 
-static bool mlx5_vport_use_vhca_id_as_func_id(struct mlx5_core_dev *dev,
-					      u16 vport_num, u16 *vhca_id)
+bool mlx5_vport_use_vhca_id_as_func_id(struct mlx5_core_dev *dev,
+				       u16 vport_num, u16 *vhca_id)
 {
 	if (!MLX5_CAP_GEN_2(dev, function_id_type_vhca_id))
 		return false;
-- 
2.44.0


