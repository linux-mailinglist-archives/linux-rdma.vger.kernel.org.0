Return-Path: <linux-rdma+bounces-20290-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNjbNKsZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20290-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:37:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367E502AE9
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375223039CA3
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A28355F54;
	Sun, 10 May 2026 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ougVtVab"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF0221FD4;
	Sun, 10 May 2026 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391352; cv=fail; b=n/vS1rJOMsWxi8JjADgYh2wmuWfEzP3DniglWKN3e94qgelp7siuH4E43VRTOOvJ3VS9FSgdcEYTVP7Enuufx01f4TTh+mqIdp9DDQQxDriOhYSHRMBkO5xTqUUbuNFqq+YVmKm3l20u8wYt4IKbLyaS5dXxUdhvNiy0XzVouW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391352; c=relaxed/simple;
	bh=r2jatyJSARMcRxyW7hHy/YeXLWv/QSl8CVCIByUQGuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drLU1xSH5w1pYXpIRRLmeK0LOUqQ8W6dY+c1axAl1PpyZVPPk/vM6hTmJKPGiwPEg7ZWhC5/RtvYoz0S5pHz+tQ8H+WjSZ3+Ux5BfSQFVJ3v/571TRGD4q16/Rby/gsTWgsF0/JvrsOF7YA9gdXUkOfk3X8uFTzFguMO6C+K1OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ougVtVab; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktb1xqi3LNiAHSODO3z0PNq9QVCaESftuyxjc6FCIhP5TlzgSXGthOrtXWdUueNMhL3DqE1gL7vf4IRDn3RlOtT6XTV3Pqnw8u8grCckxDPSrKNvh6Q3VG7f6CVJHJC7XeYmKMuhYsWysu723cjC2GeaMkI0xWBGnbS4jk+1kA36zSLYPo1iRrwb8qfGodnYPnDg7HoZ2m+KI8nIwr2vViqCfgiNK17HrscrMj54jZHv9y9iIKLxVapdu7pqdjexcbtOahEo1ShV47u/ds9khJZ5kFGQFEJCfYKUj4VkgM2FEbsJU+exgqvt1v0x5FSoexYAhkIgKG0l+t72PYPsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKXCdreMC2e2wwIUTwS8qFyb3bC6jQvi7mIHk4qMTLw=;
 b=Ur0zjKXgH/iBGLtdyIIzRbWvMI39NdQ0dp4FAEavGEbz0KCg5navtD1UGF4eLLVs2Hf/nVmyBhOinTB3i84mK5Knz+J/8PiP4T1h/csBm9tkGmr62HiAmt5FHV0N/NEAVKDzSympe6NThcTbwxaKlAh1Zoqe+d5xzYOZQo6smvbpzQU9WbBO9NflB6xYud4HD/N8S3JZ7weI09m4kyhNPgufujP2+xmhQpY+N/v/xmo3unXZtkxoKcRI6VS2plSdolDt6smakCcxUOA1hkamiuwXSLe9aexTnOLEhAKrpW0tfUxM2mmR4dL3FOZ783QQRdWi21EyWd0kiuVv6sFiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKXCdreMC2e2wwIUTwS8qFyb3bC6jQvi7mIHk4qMTLw=;
 b=ougVtVabk5cgESIkBogycZMHXCcYAewwdzOGLPGohmfJZqb2nfrBmdVI1t6DZsqAga7KJvvFyAZcuqp+y7uhAkkoqjWdRAcjoi/gyjz/bJFDCb64srjABLqjXPSk26Ngue/7xRSixwApS62OY9TWdxS/2IcR6rzR7hRp5ybOcldkDTEbIdRbtLi+gvaUZIj8bfERLI2NGjnUKS2M9csGBrLyAN30ri2bJ+lHvLhssxeQ7LBkPMY02UAe5Vmr3d7RwntTwDJMteIG60yRgXCmUvrDZF3QeVI3UlELDCKR3tOANpK2lnXx6AqDningiDzjYBW7yPa+Ezm73AU1tpikYw==
Received: from PH8PR20CA0019.namprd20.prod.outlook.com (2603:10b6:510:23c::25)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Sun, 10 May
 2026 05:35:43 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::34) by PH8PR20CA0019.outlook.office365.com
 (2603:10b6:510:23c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Sun,
 10 May 2026 05:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:19 -0700
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
Subject: [PATCH net-next 2/8] net/mlx5: Use v1 response layout for query_esw_functions
Date: Sun, 10 May 2026 08:34:42 +0300
Message-ID: <20260510053448.326823-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be03f7a-1ddc-4930-8c74-08deae55fa62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	pIyPfu6AZqmJZ/JKbOrhA9wt5TP8qLQTPI1C2okpfqMmpyuDUCLrDBQG5eQcwQ4PPT9DGPra79o8rzIr8UboUWdNh6SZrB5SYiM41Cqa28zrfpuq+aYyN80mTClREtE9n+hAGKipQTMyBqYysr9AsmgC29dBfOs13M1IUDf2yBnIlpuMbMuBT22KIMeeoThaUmIBo4+UOI/1OzI7/Ovsdr+MW9Wzo1YQ7LJcyHF0t2pBNZAQZMusmivo6grIT+Vi27iXVl5wW636hniTGj+AbYbimWC5zSmLL8MYzUJLx7Ns1SyZDYOLCeEVXmXKfCgPNRy+92GClfwY/v2/udnd3m+ubZDofjq5n1PptdxxtEhclAgADY3V43qTjyCzCTsuPAhyEEawkOvVzQHhvDc+eXFqGxD6tER3mC6+QtpmVXyAgsU1JK8KbSrSXbNXRrwc+FhD3EhDd8OCxAjj/SfHMjNSf0QPGCUIiTsLw2j8HYI8mvpWMaVK4PeX+Me983QfuaPwOesSsecsHsqP5RKTCjr9BIGpb4/JYIH8rCcSqJTM6M/RlZoOREVKD2RFZeKnsQm1xtUZSsypjmXcG6xRiefsS/ksyNM1q5aN26H7bMmvSQOAto/BfzJ1R9LwBTW6nzx07/jaA5aoI3X9TLRHDndB1U8UBRcxLsxoSSISCiNtx5CVJ+vS0e3DcRjolEvAcCJDdxabwg3kWSUjThtgL0I5cnq9/a1Yn0r0acpBDTA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QaBdsQvqKda443ucdhnSLtNiIvXtHPAiSkVcc5zYjZz1NmNV+TyWBcHxaJU8jTk7Ia5RRWftjYYHXPxrP6sqZw0ND2LdrXPD0OG/fZj7SSOG+6iOhl9lksiyB/VTSJHxA02AGGS3RW0zZ1Qj/5YfSeoJgDVppOIu0v+YVqA73uXLtAcPeTlA2uzfyn13Stxnbt+HUU4dexOZuGRzb9gi9k+LeplFg5SDF1ngeSnmWJE7104W3i7nocb9BcwytnPGFJ0zmkxlGMjDcktnf7uqOqzwvgKdLlHYV+PTURuEGIKAEBofhehJGZC6jjESMyxZdPjCX3i5Xa5XNBCB6POeKZTbgAnRjsKXLF6QgwrFCxSguwIYhhOUVu/rjSi9Nc9M3+GcTBYr+sqBJXHNPRGdaTtZnC8ERZjBsyxxRSednphcAMtin/XjPQJAM9UZE5r2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:42.8280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be03f7a-1ddc-4930-8c74-08deae55fa62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
X-Rspamd-Queue-Id: 7367E502AE9
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
	TAGGED_FROM(0.00)[bounces-20290-lists,linux-rdma=lfdr.de];
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

Use the v1 response layout for the query_esw_functions command when
supported by the device. When query_host_net_function_v1 capability is
set, use MLX5_QUERY_ESW_FUNC_OP_MOD_LAYOUT_V1 to retrieve parameters
for multiple network functions, allocating the output buffer according
to query_host_net_function_num_max. Validate that firmware does not
return more entries than the allocated buffer.

This change does not introduce new functionality, but enables the
existing mlx5_esw_query_functions() callers to retrieve host PF
information with the new layout as well. The mlx5_esw_get_host_pf_info()
helper abstracts parsing the command output in both legacy and new
formats, so callers do not need to handle the different layouts.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 88 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  6 +-
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |  2 +-
 4 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 861e79ddb489..8b62dde7eb70 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1063,11 +1063,28 @@ static int eswitch_vport_event(struct notifier_block *nb,
  */
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 {
-	int outlen = MLX5_ST_SZ_BYTES(query_esw_functions_out);
+	bool net_func_v1 = MLX5_CAP_GEN(dev, query_host_net_function_v1);
 	u32 in[MLX5_ST_SZ_DW(query_esw_functions_in)] = {};
+	int alloc_entries;
+	int outlen;
 	u32 *out;
 	int err;
 
+	if (net_func_v1) {
+		alloc_entries = MLX5_CAP_GEN(dev,
+					     query_host_net_function_num_max);
+		alloc_entries = max(alloc_entries, 1);
+		MLX5_SET(query_esw_functions_in, in, op_mod,
+			 MLX5_QUERY_ESW_FUNC_OP_MOD_LAYOUT_V1);
+		outlen = MLX5_BYTE_OFF(query_esw_functions_out,
+				       net_function_params) +
+			 alloc_entries * MLX5_UN_SZ_BYTES(net_function_params);
+		outlen = max_t(int, outlen,
+			       MLX5_ST_SZ_BYTES(query_esw_functions_out));
+	} else {
+		outlen = MLX5_ST_SZ_BYTES(query_esw_functions_out);
+	}
+
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return ERR_PTR(-ENOMEM);
@@ -1076,9 +1093,25 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 		 MLX5_CMD_OP_QUERY_ESW_FUNCTIONS);
 
 	err = mlx5_cmd_exec(dev, in, sizeof(in), out, outlen);
-	if (!err)
-		return out;
+	if (err)
+		goto free;
+
+	if (net_func_v1) {
+		int num_entries;
+
+		num_entries = MLX5_GET(query_esw_functions_out, out,
+				       net_function_num);
+		if (num_entries > alloc_entries) {
+			mlx5_core_warn(dev, "Got %d entries, max expected %d\n",
+				       num_entries, alloc_entries);
+			err = -EINVAL;
+			goto free;
+		}
+	}
+
+	return out;
 
+free:
 	kvfree(out);
 	return ERR_PTR(err);
 }
@@ -1100,12 +1133,55 @@ mlx5_esw_host_pf_from_host_params(const void *entry)
 	};
 }
 
-struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out)
+static struct mlx5_esw_pf_info
+mlx5_esw_host_pf_from_net_func_params(const u8 *entry, int num_entries)
+{
+	int i;
+
+	for (i = 0; i < num_entries; i++) {
+		int pf_type, state;
+
+		pf_type = MLX5_GET(network_function_params, entry, pci_pf_type);
+		if (pf_type != MLX5_PCI_PF_TYPE_EXTERNAL_HOST_PF) {
+			entry += MLX5_UN_SZ_BYTES(net_function_params);
+			continue;
+		}
+
+		state = MLX5_GET(network_function_params, entry, vhca_state);
+
+		return (struct mlx5_esw_pf_info) {
+			.pf_disabled = state != MLX5_VHCA_STATE_IN_USE,
+			.num_of_vfs = MLX5_GET(network_function_params,
+					       entry, pci_num_vfs),
+			.total_vfs = MLX5_GET(network_function_params,
+					      entry, pci_total_vfs),
+			.host_number = MLX5_GET(network_function_params,
+						entry, host_number),
+		};
+	}
+
+	/* No external host PF entry found */
+	return (struct mlx5_esw_pf_info) {
+		.pf_not_exist = true,
+		.pf_disabled = true,
+	};
+}
+
+struct mlx5_esw_pf_info
+mlx5_esw_get_host_pf_info(struct mlx5_core_dev *dev, const u32 *out)
 {
 	const void *entry;
 
 	entry = MLX5_ADDR_OF(query_esw_functions_out, out, net_function_params);
 
+	if (MLX5_CAP_GEN(dev, query_host_net_function_v1)) {
+		int num_entries = MLX5_GET(query_esw_functions_out, out,
+					   net_function_num);
+
+		return mlx5_esw_host_pf_from_net_func_params(entry,
+							     num_entries);
+	}
+
 	return mlx5_esw_host_pf_from_host_params(entry);
 }
 
@@ -1121,7 +1197,7 @@ static int mlx5_esw_host_functions_enabled_query(struct mlx5_eswitch *esw)
 	if (IS_ERR(query_host_out))
 		return PTR_ERR(query_host_out);
 
-	host_pf_info = mlx5_esw_get_host_pf_info(query_host_out);
+	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, query_host_out);
 	esw->esw_funcs.host_funcs_disabled = host_pf_info.pf_not_exist;
 
 	kvfree(query_host_out);
@@ -1561,7 +1637,7 @@ mlx5_eswitch_update_num_of_vfs(struct mlx5_eswitch *esw, int num_vfs)
 	if (IS_ERR(out))
 		return;
 
-	host_pf_info = mlx5_esw_get_host_pf_info(out);
+	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, out);
 	esw->esw_funcs.num_vfs = host_pf_info.num_of_vfs;
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
 		esw->esw_funcs.num_ec_vfs = num_vfs;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index cfaae59a6e7c..a5f832ed2251 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -657,7 +657,8 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 			       struct mlx5_core_dev *dev1);
 
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
-struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out);
+struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(struct mlx5_core_dev *dev,
+						  const u32 *out);
 int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev);
 int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev);
 
@@ -986,7 +987,7 @@ static inline const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 }
 
 static inline struct mlx5_esw_pf_info
-mlx5_esw_get_host_pf_info(const u32 *out)
+mlx5_esw_get_host_pf_info(struct mlx5_core_dev *dev, const u32 *out)
 {
 	return (struct mlx5_esw_pf_info) {};
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 217c2fe6b690..acbc37b05308 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3716,7 +3716,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 	if (IS_ERR(out))
 		return;
 
-	host_pf_info = mlx5_esw_get_host_pf_info(out);
+	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, out);
 	new_num_vfs = host_pf_info.num_of_vfs;
 
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_info.pf_disabled)
@@ -3832,7 +3832,7 @@ static int mlx5_esw_host_number_init(struct mlx5_eswitch *esw)
 		return PTR_ERR(query_host_out);
 
 	/* Mark non local controller with non zero controller number. */
-	host_pf_info = mlx5_esw_get_host_pf_info(query_host_out);
+	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, query_host_out);
 	esw->offloads.host_number = host_pf_info.host_number;
 	kvfree(query_host_out);
 	return 0;
@@ -4988,7 +4988,7 @@ int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
 	if (IS_ERR(query_out))
 		return PTR_ERR(query_out);
 
-	host_pf_info = mlx5_esw_get_host_pf_info(query_out);
+	host_pf_info = mlx5_esw_get_host_pf_info(vport->dev, query_out);
 
 	*opstate = host_pf_info.pf_disabled ?
 			DEVLINK_PORT_FN_OPSTATE_DETACHED :
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index 79f76c456d72..0770b5d99c5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -285,7 +285,7 @@ static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 		 */
 		if (IS_ERR(out))
 			goto done;
-		host_pf_info = mlx5_esw_get_host_pf_info(out);
+		host_pf_info = mlx5_esw_get_host_pf_info(dev, out);
 		host_total_vfs = host_pf_info.total_vfs;
 		kvfree(out);
 		return host_total_vfs;
-- 
2.44.0


