Return-Path: <linux-rdma+bounces-20884-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aSrYOD29CmoE7QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20884-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:18:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B00567534
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A1C43046DC2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843A3CFF61;
	Mon, 18 May 2026 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYPjrz1Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B52777FC;
	Mon, 18 May 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088555; cv=fail; b=KUqtbdmhGP5Ei1eA0YKrLEHMlTdyV5/DAb9gIQhpb/LlWdtrKgERYhJfLyje/hU0t1tbA3bchw75Naj61lcvjNLuO7ysIrAA8Hq6aGgio/7ywue6/NTPSzI8FAo6OffhlAex2foPZb+BaVN8GJkT9PqloyF/h9dqPfpJareoppQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088555; c=relaxed/simple;
	bh=dmlHeHL3Vzwqv3Pn5dynHIgWA43cpXX22f9yw+PrbfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jc1zDvM+qZvJrmzPlc0EDjwfNw69moSY3FTJ2f/Rv9o9hmBOgZDddAEZojdUdqhaEU7Q8sQG/Bcm7hF0Kdm0dvsGwYwzt92c/g1hVCLYRZA4yNsM52I9DxmiuizqOJpAFEXirDtK1nQWfquseKxhRX3T7TYYtOwg09rbecErtiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYPjrz1Q; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2fq7Tlz/ZkO8AdF1C7vTUAl1EbtKkVtuSS09DPgClJBSCAZ9yLARLOd4octH7zyGAM92zKE+omRoLA40My/1ozS9eW+CgCaBEddlsKqr4H6baJtaXk0ROYbGbLwKfcUOc7agKA7sidzpKI4uGmz38bcIRKREt9psyVndc6Cx9hqGqtFc4k0MWbwOBA40o6veM0oLX0GR4ZLakazaC4fyz8S/ybislf0Mia7kHYEhYKvGTFClaVuO1DklTQQ6IstOXL50/XM4djkcOzUh3TnzO0a41ZLgj+zI3VzGOWqjlkoCnaWta2BLq3XKu1zWuvowxpG6Z8hBYAxJFWu9g9vgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k//5NYtzwYj9LoHrlzJhqgt85UtgcgQD4sdpBuoEwRQ=;
 b=SXnUfA2rCJnw0STKLds/sfji8+Uyd7Ewzm4/1LrZ0FyTx0M3HAh970LUSv0zaHvCHqzHcuTGcxjOv/oahLtF+jnZMDZjewvifjWVm009QuQRqJ6tY1AumzbCCfWzr0oKjlKrEF9m18/mGMMIwFTOLwXvzifE+rLoMHUwHTQWXJQKFsxs5X/gYCd7WwDfKH7t3pe3M3W6WPzUk9RfEs9+KK1/P6zjGgx26FqNdhUrl4NxBfsutHzwGvSf3UH3j4xfBmTZJr3JWkXdf/niJV0vOOEqkRI3ZdzLERXcCPD+mNCcLLxiodT3nIcqfd6sLFbVn14AgcBsSyszaJnypfcO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k//5NYtzwYj9LoHrlzJhqgt85UtgcgQD4sdpBuoEwRQ=;
 b=tYPjrz1QbUaCWEKG4nBEciW0uIQnsoejQLCkkTx9S6cvPjVpoz3z21BxCjRnauYS6B7TNJ6pJrdor2Wn7t35oDSTKDCanuZLDSHppeUmRDja9y5ZQowfOL4o7qzSG5uvwaEcSl6wjgJIRstcXY/29McFDaJyf51yxOnvt95N5uQnhlU1NsQmTw/695o+xYQo0u7Gj9s9/01I9Qbu0zzcjc7Xq+DmZf0YgEvqMArsLf5rDK/UPqS0ikHv0sQYmMPyvcrDFj2wRxg004we+ctwEQyse9UGAEqy/8rvGDrDXZeCC0unoWVcHddAviC4Kzdd0MzweA4CFca1OXiDvugY0g==
Received: from BL1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:256::35)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 07:15:46 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::8d) by BL1PR13CA0030.outlook.office365.com
 (2603:10b6:208:256::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Mon, 18
 May 2026 07:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Mon, 18 May 2026 07:15:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:26 -0700
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
Subject: [PATCH net-next V2 7/8] net/mlx5: Use vport helper for IPsec eswitch set caps
Date: Mon, 18 May 2026 10:13:55 +0300
Message-ID: <20260518071356.345723-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 36feebdf-eb15-4b97-020e-08deb4ad47c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	PZXT0cSiiFnSTx14Tgnj7VXMFCOJn7ZB3fSVsfq4xCcwDFVDdj/JX20iT353GTCOoTt/U6A8iXMlnxkW7zLd2a2yy6LxMZX+XV4no57148VVRG0q0txyTrPNCYJHvm8ea/a7ZxYLpx96LfG3o05qJqh5ZheMyhOL4Kev/lILzAPnUbLSLY6o9+jOgB8lT9YoG0QO9vRtmrm2pggJXptfucvmnBAE1Z4RkOXsJvlxdJ6puNs1WXIMtkoAvI3j+klVrUriUuErVUkxLQ0qThFo73/KEA75MtR3BK1a4n5RcaUpD50o4Np7q7ee+vpe7ztyt1cYjUWgyCYX9xYFi5WNX1q4Qet2+mqYQFBLw/P5N+j//4oNx3cOcpMpJxhc4VDOneVbK+gHkNMVddle4/rVA71T0ylZeHbiUSMSbCpTckWhzLOGlVWLyiIEywxGrpjuPoV+MscZxX0mzJMAK7C2yqVAI4+jjca9N97SKeh0AQZG5/aNfD6mKOqdnweh5KEWd7iBSv+N8wYdSynDLEM722TDgTMpeK8gNQeH4mszXTvBnl/5rB74nMmVB+0eFgIAxdyq065bsb9lkXVIR0/0aAkcj8bpo0XeJ9Hf+p1uT05X5qFZikQfKPF+uNZ5Jcy52fINmiJjKxOqgGcgahTptvhnszOBXIySY+tP5wqNauhEGXfoZ//mVidzFlMo5QnNE/9cnRlV8nNCOdvJrG4G9JVVCleqqHY/tETe76nBvxc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fdGIyNjB9mzw9LVW+zE/HuvkVwWfCmQof7AEcj1dbiMDTBfV3U4nMSI/kwjU9G5TUGj1ryf4wY0xuK0aEo66d1t67DqITg8g4V/pKGg0nOf0Y1/lp+cWXHZJerO1/NSZZg21/mnk+U2vgFWOHGHXD0jxY06shB7DoambZEm0F3pRrSibrc843qbXcyNMfQ3EOJl68KFG9maBzpaY1d8qMYDiVEfXKbC2/7UQSKwz3tvvLS44AIJh+P/FmaShf4PqlZ+EBy8SQrCa/fZnHX6wvEstA14fG9nQJYZ92NROX8BdMxf/52AkzHtZoQcm8RdmcbtL8k+JBB5rcdLCAcENH3fQRKofj/aZwnT8Q1435Y98EOfyaSewnTNsvrEJ+/dpDM4/FGinLUGcU1uArDla3f6XuvwJzVSPDMc16Ki6hexeu81jJ1rF769vXIXrRTZi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:45.7389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36feebdf-eb15-4b97-020e-08deb4ad47c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
X-Rspamd-Queue-Id: 53B00567534
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20884-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Use mlx5_vport_set_other_func_cap() and
mlx5_vport_set_other_func_general_cap() in the IPsec eswitch functions
instead of open-coding the SET_HCA_CAP command. This removes redundant
buffer allocation and boilerplate, and also enables vhca_id based
addressing when supported.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   | 81 ++++++-------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index b830ccd91e62..2b5765ab60d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -81,38 +81,25 @@ int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev, struct mlx5_vport *
 static int esw_ipsec_vf_set_generic(struct mlx5_core_dev *dev, u16 vport_num, bool ipsec_ofld)
 {
 	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
-	void *hca_cap, *query_cap, *cap;
+	void *query_cap, *hca_caps;
 	int ret;
 
 	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
 		return -EOPNOTSUPP;
 
 	query_cap = kvzalloc(query_sz, GFP_KERNEL);
-	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
-	if (!hca_cap || !query_cap) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	if (!query_cap)
+		return -ENOMEM;
 
 	ret = mlx5_vport_get_other_func_general_cap(dev, vport_num, query_cap);
 	if (ret)
 		goto free;
 
-	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
-	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
-	       MLX5_UN_SZ_BYTES(hca_cap_union));
-	MLX5_SET(cmd_hca_cap, cap, ipsec_offload, ipsec_ofld);
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	MLX5_SET(cmd_hca_cap, hca_caps, ipsec_offload, ipsec_ofld);
 
-	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
-	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
-	MLX5_SET(set_hca_cap_in, hca_cap, function_id, vport_num);
-
-	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1);
-	ret = mlx5_cmd_exec_in(dev, set_hca_cap, hca_cap);
+	ret = mlx5_vport_set_other_func_general_cap(dev, hca_caps, vport_num);
 free:
-	kvfree(hca_cap);
 	kvfree(query_cap);
 	return ret;
 }
@@ -121,49 +108,37 @@ static int esw_ipsec_vf_set_bytype(struct mlx5_core_dev *dev, struct mlx5_vport
 				   bool enable, enum esw_vport_ipsec_offload type)
 {
 	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
-	void *hca_cap, *query_cap, *cap;
+	void *query_cap, *hca_caps;
 	int ret;
 
 	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
 		return -EOPNOTSUPP;
 
 	query_cap = kvzalloc(query_sz, GFP_KERNEL);
-	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
-	if (!hca_cap || !query_cap) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	if (!query_cap)
+		return -ENOMEM;
 
 	ret = mlx5_vport_get_other_func_cap(dev, vport->vport, query_cap, MLX5_CAP_IPSEC);
 	if (ret)
 		goto free;
 
-	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
-	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
-	       MLX5_UN_SZ_BYTES(hca_cap_union));
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
 
 	switch (type) {
 	case MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD:
-		MLX5_SET(ipsec_cap, cap, ipsec_crypto_offload, enable);
+		MLX5_SET(ipsec_cap, hca_caps, ipsec_crypto_offload, enable);
 		break;
 	case MLX5_ESW_VPORT_IPSEC_PACKET_OFFLOAD:
-		MLX5_SET(ipsec_cap, cap, ipsec_full_offload, enable);
+		MLX5_SET(ipsec_cap, hca_caps, ipsec_full_offload, enable);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 		goto free;
 	}
 
-	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
-	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
-	MLX5_SET(set_hca_cap_in, hca_cap, function_id, vport->vport);
-
-	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_IPSEC << 1);
-	ret = mlx5_cmd_exec_in(dev, set_hca_cap, hca_cap);
+	ret = mlx5_vport_set_other_func_cap(dev, hca_caps, vport->vport,
+					    MLX5_SET_HCA_CAP_OP_MOD_IPSEC);
 free:
-	kvfree(hca_cap);
 	kvfree(query_cap);
 	return ret;
 }
@@ -171,34 +146,24 @@ static int esw_ipsec_vf_set_bytype(struct mlx5_core_dev *dev, struct mlx5_vport
 static int esw_ipsec_vf_crypto_aux_caps_set(struct mlx5_core_dev *dev, u16 vport_num, bool enable)
 {
 	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
-	struct mlx5_eswitch *esw = dev->priv.eswitch;
-	void *hca_cap, *query_cap, *cap;
+	void *query_cap, *hca_caps;
 	int ret;
 
 	query_cap = kvzalloc(query_sz, GFP_KERNEL);
-	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
-	if (!hca_cap || !query_cap) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	if (!query_cap)
+		return -ENOMEM;
 
 	ret = mlx5_vport_get_other_func_cap(dev, vport_num, query_cap, MLX5_CAP_ETHERNET_OFFLOADS);
 	if (ret)
 		goto free;
 
-	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
-	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
-	       MLX5_UN_SZ_BYTES(hca_cap_union));
-	MLX5_SET(per_protocol_networking_offload_caps, cap, insert_trailer, enable);
-	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
-	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
-	MLX5_SET(set_hca_cap_in, hca_cap, function_id, vport_num);
-	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_ETHERNET_OFFLOADS << 1);
-	ret = mlx5_cmd_exec_in(esw->dev, set_hca_cap, hca_cap);
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	MLX5_SET(per_protocol_networking_offload_caps, hca_caps,
+		 insert_trailer, enable);
+
+	ret = mlx5_vport_set_other_func_cap(dev, hca_caps, vport_num,
+					    MLX5_SET_HCA_CAP_OP_MOD_ETHERNET_OFFLOADS);
 free:
-	kvfree(hca_cap);
 	kvfree(query_cap);
 	return ret;
 }
-- 
2.44.0


