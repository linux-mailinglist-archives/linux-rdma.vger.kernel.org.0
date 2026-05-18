Return-Path: <linux-rdma+bounces-20885-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCfpM3m9Cmrb7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20885-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:19:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93826567594
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 009563054236
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB7A3CCFD9;
	Mon, 18 May 2026 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fa6DKQK8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89127453;
	Mon, 18 May 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088561; cv=fail; b=pknxhOUxcSYSHU6K5plUsq7cO2NbaSjy5PWnC83kHLRbeSZ9u9mf4aBrACwEL8CTyy5oTMgeKWI3veRa5jfqrJJ4L4RH4bQsngDfylmVsRaWQ7DnTw8Ab02imZue8FsW9MP2lBMttNW8xpccm5hRAYShDVVVi+lUz3UcDc5oQGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088561; c=relaxed/simple;
	bh=FJ6bNCM82zoO7lIe7vpOQAMzjmUIXErxyMPLeIIyudg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0LYE0ZBmjrDxC2/3Ai/OzUfP8nrqtPs5IuRNX39GfUUguDYYFAJL91f5KGELyPJ+wVtig9LVU/k+B5k+6pn5m2LHEqZODATdV6r7t7BF1/Jsk0oRjLzrbc2xl6vaUajzLIBkUSkobTYBxGfjJD3kflotsrzdEjpnpaZ//O7wKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fa6DKQK8; arc=fail smtp.client-ip=52.101.57.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjR2FDHCsTpMugkCROrpLwbArjUAKwwsDO0EQ+QKAKje8cBynHpRUj/ZRln8jbc5DJ5a0Ef5zhQ21jJM/HKLo3VNd7BOj8aaTK/O110QY0SCRx6oOj5Sg7enybDOApdT7djLUxQEmOA80AG/7N+AhK/nuQW7VDgzBdLXTRm3qKdr+bXdlYh0pVda5tBla3ocvyGfcUxiN5FmjwzGlEQs81loLKFEzbvLh/JrOUVk5+3bCssE0AJpSVdIfF3DsZN5pjOXdKe14DmHrOBx8T0hJmj//Vkzeb5s8bO5XsNTpAxFLyzIe0KOI4Mt/SoStHnWUJP8eXLLK0a0Tgs1JAdbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WquzEuT3uild5hfbMR7BosqzCK7/3Xcu7d7smLcN4/w=;
 b=FTM9UEU+qf/7mmZh/YkO+Ynhdmi8fKJPXwUBDMFf9KT1icza0UyJ5GJtm+DwuTXSvZL/wLtwJ+zWbTCRM3WoMpwy9YlJQA46vXZTCOG/FqB4+ttaLH/j/r1c4wmMiLOHNvCbwg7GWC3RP5SLMyNbveoaClTfESuE6j19O57+NhKmcUqrOD7VIED16g1vDVxAyvEVCUDET+TRSBQpkOIaktWEmPaZEcSd1bxrgUggwHeeGk1qyDWkGybOUW/TzGW0kE+yHhss8O/STZOUEU0fS7oMmFhlqqL/vGNoq0wHREdfRiXHiuy3+oLwLo1rxtNl7/F4GCO7T4ojZCruzqQfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WquzEuT3uild5hfbMR7BosqzCK7/3Xcu7d7smLcN4/w=;
 b=Fa6DKQK8S2rbN2VUChYrENXXwzGCjt1Xh6gxe+SJBcfsKbAMMHymEWsA3um2LjCa1k2CSpaaohJCXkVvemXKCA6DKDG99jGGpwiq4yQls1ykXvLknUptC70seOdgliqxV4vymM2SoeEa2m3kK+ahrtmODKYksj5ZoQb+oB6gEv8lTi64sw3Nfv3yPC01IFKBheDkA+UDoEjkViFa24AUJ82/AzZe67A7abFE0AgCKimZ+QhJg/6P0OEa9AgrJjWgCLg/p9ENXdlFcLciNjqv1ndIg2fpdQ3dUYj1IUTukwkwX9JHGCJm+UdPFo7Iwa33uEo7+9JZeoBFICm/khOw3A==
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 07:15:53 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::c1) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:15:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 8/8] net/mlx5: Generalize enable/disable HCA for any PF vport
Date: Mon, 18 May 2026 10:13:56 +0300
Message-ID: <20260518071356.345723-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260518071356.345723-1-tariqt@nvidia.com>
References: <20260518071356.345723-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f78031-10b5-41dd-52e8-08deb4ad4c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	PmRRD8+Q6KAQDO11s74b8hCSS6yUKCoWwQP4JunIBQAQmVfFGpziEf0ROjxnpklAqsmcJH2wYHFUUlN6S/UKBpaT9ua4yhdYLRNXplGkNC4mM2kX2IPSbq0pTQBuznYDp64jNhCWAMS1dlxY4xjjCA9M3CjPY8oaOJja9XA/Gy0ZCoewRL9nGUmevrK7ozYFL0wgSmHtu1CiEpXlLDPSCJlrZ0I/fkUPCBRrIEmJQ0YuqoIYl5646O5vtDr4lnPwkn3UwWzCPWtMWNQDXZ+aupmXCryeFDTTtL2OsBlBDOgmFGMJ2WnfSgUkETeZamC95QTrcYKrYVaWEmt66LSSmbnXQM5ok5gbkBL5IHWn/8HPbG5aBP1PToAkjHqzvWU1RuBMVYlObzXr8AkRBDdAaFrV7AGMvxnV0sO/pDhwopbqxyAWV760tYUwiJYYNxiiUs8UoGiL/FiLdf6SdniABsH+5DvqOIDVhYdjJ/J/P8kDbfIcAvt8XRq1Az1RpYeXxzaQKI8h0XfbKbBzznaxFaInhxx7YUhddqDGtd5c/kbvRd+ktKVEMVLb7mWRe9NTId5zbV3b9HY4jLVYzp6IIqSRZ5RGmGH5/GxwF+PABPiClmG2I65dG7oFeObYy2j4bY4AzVVZSiJUYuGiLSVUE2NjuqU6EdDZc4iY4PaT0pguNW0S55TMtGWzPmQLQVSS2HGHQWriegTaaVRlDywPAh7AogT2zXNG9FYXvSLo974=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OYqzEoEITqGiGYk6iti5epi2l1S7WiJE0HMwvcqJzPz3lI2RNONKZKlwTRon1Qntz1thtGQvo36oHc6qwJJSd6tphY3ud0QhZjt7ExyOgDkjdQddrnYJV5IEa3xnIiwI+orP0RfPSfYgrsadMWkkKCiOT3F6mjXhh1BFlgrarvE8S0oFdRsyr1iChEctWijQ/sSIJ0/igIHE8xsUD/cE4mjW7zB9+EeRUnlwltg0T338o44z37IVBdyi4E1cWkBBiXJM0bWTj502BOOi9SY3VFbv4W5cGp5LUJSxpUlioN/uIkETk0qe6d0eGjbYqlWjRAdo4GKg88rtsQ3uuAYK1U1z2bHshmj+4povcPAa06Z48Kn7dL5FWEHSLTpcoW0owN9nYEP6FHHXxPWmpgCz5QprmTUudGLI8TRUF083mw+h4KQLlLJ10L+WeIRjrCtM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:53.3636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f78031-10b5-41dd-52e8-08deb4ad4c44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
X-Rspamd-Queue-Id: 93826567594
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20885-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


