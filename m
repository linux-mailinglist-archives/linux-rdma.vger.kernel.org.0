Return-Path: <linux-rdma+bounces-20288-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH47EzUZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20288-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:35:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C1502A88
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42B2D3005A80
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F10351C06;
	Sun, 10 May 2026 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxGE2n9z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B334DCC7;
	Sun, 10 May 2026 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391346; cv=fail; b=SKotiLUiyMbjrVTQMNiNEvLI1e7G4RqJqGYgrcESwXhRPGIEwvZHT6ft4j25ER0s58jvBov+Jt2bGs0/+iRw/5S6rzkdU+NeUP5O2H30R/mCsg8GwmBGkFzyy8z4k49YvGFjwaXIYCIVOgEG1Atw4pH+dLOcg+GXEHrEMjFvXdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391346; c=relaxed/simple;
	bh=Imiyc4JkQ9507L/3L3ICNB6mDfkWJi5/Foqhwtwqt3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acbYKXBuWujZHpv2PPX8cLoc7aKzS2R+P9MWiTDrDQVjVM7eDZlcmMOZF/fPGfaqNPywkOr2aD8Kh8b92VUw4LsXjL0Cz2MoOECsPiFV4wqzr14IE5597T8t0UXMykW9seozyyd07PcneslWOhIdxnnvtUnm7NIaZQFJ9ewM+Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxGE2n9z; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hompxr9JASmZekyfF/UFY2Xzlgby+yFeRU7w5Pefdc4GE1xDKsOPyiVNeZPDVPOTgf2KwfgA9jCNzlqnFfBEfv5JApzjG/i9UlVmAaynV0j/AlVptXOuB3jiOEbJrnSKcvFj8NJSiuOL/jIZmStsAFAmyv8kuGSxN2Tl2YqrvTa/w0y354I2i/Yqb5H/a+4/3MhnJhP+s7eEoFsmPAnk+EAYBT5yizgysPNRp49BfCsE992I8KgBbW+oegKQ6Ol0Alh9/WxJj1BpSx0yaLU/qloO2STM7PXZK8Wypw5qF/QU5ODVfMDKmIlCRiEV8dyfKGsotz5wYJ7Y6oIRJ+M+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T2tcPdLK52zItliQ5yhu/ldUvY90XwPGct/NrkxDTY=;
 b=LUQdf93oU9geth16gdqPPLzqWJX3HaegmJJI3t33obUoAZ3YKFotgLSgsSMv9n962Yx5RZ5lTa6zTbdQRrXNMh2yoOb0ajlIQX7S9if0xJBAF7echl1MCnRWJtzWVcxTKEPqoRlyu/hy7N0awDqPj4dJjUqwdsQ8ojxr7eTk0Pd/LgcrSvjfpAeZlyW4zvcirTws44aTYoqbOu5JoPxyj+9PZwkOPolW3PQ96YnTn8VgsQh+znkzheddAGQeXg5duKK6I7fIcXOnL7dMPAoaf7x/BqDIOgpUMJC+6SbGvezAOLblGiXdWN6C5oTHLQAISv5L2ocv7k7SVzfnY/dt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T2tcPdLK52zItliQ5yhu/ldUvY90XwPGct/NrkxDTY=;
 b=jxGE2n9z14viZiIzO6NYiJ33pFCgkDwUvi8ayp0438Q0s5M+w4cVcCQkFFF28B/tqlo1Yf/HQIipbIg9/td3xDnzyMos3ohSvd38jBrNaVWP5rXBpsgX954MYtXD6O1VxO8EfP/NG0yzPb/fqok/jsOzKeqNrTLEMlmBj+9Ps91bqsMXt/rUkdvgupOv4NcbTwpHjHNX3++W0cFEwLhsYLd7slUHdWsxkCCYwuJha8yUsbUqKr1vywiOfH6Py/htCWFCL95JKV1Ow2k9Vh8I6N12lxPssUIzZBFDKydRg7NbLOc2s3lnBRZucWrIhHfMNs2C2tJB00pT5N/GIdkflw==
Received: from PH8P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::33)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sun, 10 May
 2026 05:35:37 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::dc) by PH8P222CA0022.outlook.office365.com
 (2603:10b6:510:2d7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 05:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:14 -0700
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
Subject: [PATCH net-next 1/8] net/mlx5: Use helper to parse host PF info
Date: Sun, 10 May 2026 08:34:41 +0300
Message-ID: <20260510053448.326823-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4483ca2a-4a8f-46ae-69fb-08deae55f6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	44+Qvg36oQhAiPgS2dztzC65mjLYEfFTOGz+ZrLSHNjNMcMLOo1BXLYooLvUp3LHvzEfrSOclfrBEbYWtNBAdrWQsoyuoG+4tvLk/v45l0Su7lEbu5LnsKYCYthnNJ6l/SZpLSbxDQwBNgz+7KO4gkYd6StYg4w17Rk99MeT5mlQaYJkHfxCYQQl15OrvzHW5Y+k7Zr1/jibIXG6xA3j+bi4fDJ72qmDmTAYksAgrANDs6dgSN2uhrWNifvpGj0ksKMXLGmaGTPyqxYdPKsN4SyiRb/gQa58thsP4Qhw3SVFHkt+agm4q7NP5k6qHJ6GDk+erD2L/HQTO2P0wNxAYsZ7bYU/U5TBdANCEWODLoJef9PcspWVKmQY6VLazSdOpHvJverQfaLLDK0BrXa/V4p1bnL1QM2c8FXr/RL3Rza4lleFddPOalBaYE96xt3V8z/j5xDYfYTI44TUayN58M5RW+TL45tdhFMiNEahibPJwNvXnhCf8Mxxk7kVN7RlMY+auJcJcIhpC3r7lKL1+ow21rPXwA723AY1IpfDrlbx5kTMeA8Zto2DJjryp08IK+kjCxSWh+tMKa1xw/dRopMcWugiOCF2zUfKulNqjHleo8qPTMNoIHXnrCwJkzWAR9vImJ4av1jBt+SLp7gUDWfnXzGITp04z3hMkQGXtFlPWLAXsAdNbgil7NDOjbz/DIFcnF2ERw/LOnsW+IZGupX5h3GIewtAw8jwQjG8Az4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	giKfDYw7J2O/Kmwos5bDPBuom4dBJQnLKHcraOiDPtRGx+RSKXWNo1t0AyX+Sx2MJC7Bsv3w1hMvCvvLM/Dpbf2CAgIpFZZlOuQzzP2Z2mOrF8uzWeE4Ppnv/Ure+fPspLBrIHR2PuQDCYHLvd5rTtoG2M7584g3qmB5NdMJXm2deYoFtWCb1KegvhrrfGdeQ34meiGLUNRZB5SQBBLuP62S5WghH+ogXV4jflPoeL2V1XziHhcjZgpdk/AMBqWaGU2SPsWTFaH+3kVLcmRUb1fTgrc2EcZjrqUbw3oidLdF5tTcI8kyqd+Nm4dDwvsWTMNqQ9dXypenE7G0DTj11PuRJkJibCmKxtRyVBZuDAoXNxZIyMT4suxxfuMlMDDRwADY0DzaQdhiv2pHSqxywyuQ6hx7MjCo/EO9kuBvwsuxWXNgsDGwjh/x+J3g+Ymf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:36.6186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4483ca2a-4a8f-46ae-69fb-08deae55f6ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
X-Rspamd-Queue-Id: E91C1502A88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20288-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Add a helper mlx5_esw_get_host_pf_info() to retrieve host PF data from
the query_esw_functions command output, so callers no longer need to
parse the layout to obtain the required information.

Convert all callers of mlx5_esw_query_functions() to use the new helper,
preparing for upcoming support of the new op_mod that returns data in
the network_function_params layout.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 43 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 15 +++++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 ++++++---------
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |  8 ++--
 4 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 43c40353b2d8..861e79ddb489 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1083,10 +1083,36 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(err);
 }
 
+static struct mlx5_esw_pf_info
+mlx5_esw_host_pf_from_host_params(const void *entry)
+{
+	return (struct mlx5_esw_pf_info) {
+		.pf_not_exist = MLX5_GET(host_params_context, entry,
+					 host_pf_not_exist),
+		.pf_disabled = MLX5_GET(host_params_context, entry,
+					host_pf_disabled),
+		.num_of_vfs = MLX5_GET(host_params_context, entry,
+				       host_num_of_vfs),
+		.total_vfs = MLX5_GET(host_params_context, entry,
+				      host_total_vfs),
+		.host_number = MLX5_GET(host_params_context, entry,
+					host_number),
+	};
+}
+
+struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out)
+{
+	const void *entry;
+
+	entry = MLX5_ADDR_OF(query_esw_functions_out, out, net_function_params);
+
+	return mlx5_esw_host_pf_from_host_params(entry);
+}
+
 static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 {
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_host_out;
-	void *host_params;
 
 	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -1095,11 +1121,8 @@ static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 	if (IS_ERR(query_host_out))
 		return PTR_ERR(query_host_out);
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out,
-				   query_host_out, net_function_params);
-	esw->esw_funcs.host_funcs_disabled =
-		MLX5_GET(host_params_context, host_params,
-			 host_pf_not_exist);
+	host_pf_info = mlx5_esw_get_host_pf_info(query_host_out);
+	esw->esw_funcs.host_funcs_disabled = host_pf_info.pf_not_exist;
 
 	kvfree(query_host_out);
 	return 0;
@@ -1523,7 +1546,7 @@ static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
 static void
 mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 {
-	void *host_params;
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *out;
 
 	if (num_vfs < 0)
@@ -1538,10 +1561,8 @@ mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 	if (IS_ERR(out))
 		return;
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
-				   net_function_params);
-	esw->esw_funcs.num_vfs = MLX5_GET(host_params_context, host_params,
-					  host_num_of_vfs);
+	host_pf_info = mlx5_esw_get_host_pf_info(out);
+	esw->esw_funcs.num_vfs = host_pf_info.num_of_vfs;
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
 		esw->esw_funcs.num_ec_vfs = num_vfs;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 291271afa96c..cfaae59a6e7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -71,6 +71,14 @@ struct mlx5_mapped_obj {
 	};
 };
 
+struct mlx5_esw_pf_info {
+	bool pf_not_exist;
+	bool pf_disabled;
+	u16 num_of_vfs;
+	u16 total_vfs;
+	u16 host_number;
+};
+
 #ifdef CONFIG_MLX5_ESWITCH
 
 #define ESW_OFFLOADS_DEFAULT_NUM_GROUPS 15
@@ -649,6 +657,7 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 			       struct mlx5_core_dev *dev1);
 
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
+struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out);
 int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev);
 int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev);
 
@@ -976,6 +985,12 @@ static inline const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct mlx5_esw_pf_info
+mlx5_esw_get_host_pf_info(const u32 *out)
+{
+	return (struct mlx5_esw_pf_info) {};
+}
+
 static inline struct mlx5_flow_handle *
 esw_add_restore_rule(struct mlx5_eswitch *esw, u32 tag)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d95af87a4f5f..217c2fe6b690 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3708,8 +3708,7 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 
 static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 {
-	bool host_pf_disabled;
-	void *host_params;
+	struct mlx5_esw_pf_info host_pf_info;
 	u16 new_num_vfs;
 	const u32 *out;
 
@@ -3717,14 +3716,10 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 	if (IS_ERR(out))
 		return;
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
-				   net_function_params);
-	new_num_vfs = MLX5_GET(host_params_context, host_params,
-			       host_num_of_vfs);
-	host_pf_disabled = MLX5_GET(host_params_context, host_params,
-				    host_pf_disabled);
+	host_pf_info = mlx5_esw_get_host_pf_info(out);
+	new_num_vfs = host_pf_info.num_of_vfs;
 
-	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
+	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_info.pf_disabled)
 		goto free;
 
 	mlx5_esw_reps_block(esw);
@@ -3826,8 +3821,8 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb,
 
 static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 {
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_host_out;
-	void *host_params;
 
 	if (!mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -3837,10 +3832,8 @@ static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 		return PTR_ERR(query_host_out);
 
 	/* Mark non local controller with non zero controller number. */
-	host_params = MLX5_ADDR_OF(query_esw_functions_out,
-				   query_host_out, net_function_params);
-	esw->offloads.host_number = MLX5_GET(host_params_context,
-					     host_params, host_number);
+	host_pf_info = mlx5_esw_get_host_pf_info(query_host_out);
+	esw->offloads.host_number = host_pf_info.host_number;
 	kvfree(query_host_out);
 	return 0;
 }
@@ -4980,9 +4973,8 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_out;
-	void *host_params;
-	bool pf_disabled;
 
 	if (vport->vport != MLX5_VPORT_HOST_PF) {
 		NL_SET_ERR_MSG_MOD(extack, "State get is not supported for VF");
@@ -4996,13 +4988,11 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 	if (IS_ERR(query_out))
 		return PTR_ERR(query_out);
 
-	host_params = MLX5_ADDR_OF(query_esw_functions_out, query_out,
-				   net_function_params);
-	pf_disabled = MLX5_GET(host_params_context, host_params,
-			       host_pf_disabled);
+	host_pf_info = mlx5_esw_get_host_pf_info(query_out);
 
-	*opstate = pf_disabled ? DEVLINK_PORT_FN_OPSTATE_DETACHED :
-				 DEVLINK_PORT_FN_OPSTATE_ATTACHED;
+	*opstate = host_pf_info.pf_disabled ?
+			DEVLINK_PORT_FN_OPSTATE_DETACHED :
+			DEVLINK_PORT_FN_OPSTATE_ATTACHED;
 
 	kvfree(query_out);
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index 6eb6026eadd6..79f76c456d72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -273,8 +273,8 @@ void mlx5_sriov_detach(struct mlx5_core_dev *dev)
 
 static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 {
+	struct mlx5_esw_pf_info host_pf_info;
 	u16 host_total_vfs;
-	void *host_params;
 	const u32 *out;
 
 	if (mlx5_core_is_ecpf_esw_manager(dev)) {
@@ -285,10 +285,8 @@ static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 		 */
 		if (IS_ERR(out))
 			goto done;
-		host_params = MLX5_ADDR_OF(query_esw_functions_out, out,
-					   net_function_params);
-		host_total_vfs = MLX5_GET(host_params_context, host_params,
-					  host_total_vfs);
+		host_pf_info = mlx5_esw_get_host_pf_info(out);
+		host_total_vfs = host_pf_info.total_vfs;
 		kvfree(out);
 		return host_total_vfs;
 	}
-- 
2.44.0


