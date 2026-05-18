Return-Path: <linux-rdma+bounces-20880-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gItZMVu9Cmrb7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20880-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:18:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C569567566
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BFD30573F6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F63D330E;
	Mon, 18 May 2026 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ERCFv+rn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31E3B9608;
	Mon, 18 May 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088533; cv=fail; b=tGHyyFYmEzBDMIdIKK+be8Nq4gaSS3OjtRMMU11eClG237njwJwO7ajV2Hpx5584aS9rma/cjzUyJazk73vgvZSJnD0IFFoItVbmAoZEXl545Tcs4mbVPUaeEL0S58XqCRKK3DwqmjW57C05GjCM7Dx4T2mjuwALvSK9RQcdS90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088533; c=relaxed/simple;
	bh=NrzUIh+vvGHnelbpq7MsBfl+D4ah8apPa+x6j20FFEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf6ypgkpLhGW+APOrD2aCDz2f2PQ2UJgkFMIJAKl+BLgmwucvpoqLtaVb8mXcbEgccEJF2SDgu5o1INMy4j74cYFxtsdPFC/j9w7lBPPz/xshmKHmAuvdVplaKbUFOpFtWb4oL8s2q8GVWyZeTqw4Of+nRkbqzEvc/OvLtatxTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ERCFv+rn; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaG0DBs6AcBlqVdTN2tNWjfcY+4prahzhkR819rUeuE1h/SOb4PihI1w7hUT3o4OQOEOe3zRbggHxLSq2LZFTEWnWDaXF99jn3x0Y05o+vWJhM5Ycz9csXeWm3Nls1y8BVcS+ntattE51jRTvy2BI2OolUniDHtLDWiVKruhOUg+lgFmUqOiWh2bdKNXPLu5TIFQRKBiRWeZtxjY0heee9R8WejtSD/laj2ONYYEKKZg0YuxgiWHavdANspoEboujuz2uoT9HsO8iv/iTWj/zWegh3mnKgvvXr8hnVkaMQ+TTBrve58+gIDu/wG8lwr3XSJ7GWSmvR40XlOleXVQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XK7Z1C7U0P73WEF4Pa03inxPzC+L4F/WJrQHPhHzF0=;
 b=xGhtVeQ2FKnJxV2ulns1XIv2UFiBc/tNDrp0as6jUn4yfHStQwDjjA/cnU4Aw5Y77t+hdZBvSCWMQoHXXqFB7RbGMToKIApBY96JuXdZ7ruQy32aRR24a6ec5qwqcgfL0ynbYdkzm0kQdYVGAcTvomhijEQ/t0kTmDLA0kfMors2QSsdNxn72Pt0CgL0T7mbtzoujjH7eCD0BmmJBLROT66DbjEPSr+j119rbcxPcuxX8N8Lv5fdM4Mbl6+ljHqoJw8pkBTeJlQ6lOxAndzJNtpABon5Lfpf+oD8qc74pUgJA/1QszcdCe8YEmF4T3mX4cXjP1QVwYaNzUxIJR0fHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XK7Z1C7U0P73WEF4Pa03inxPzC+L4F/WJrQHPhHzF0=;
 b=ERCFv+rnj6medLuBBC7Y3nZqlXQdsXhxXkbBCdO8L3913l3mHJ37IW0Hxp9saprFBuGm7+OGtDTXfBQJ06S25FT0yCo33Fl/L8jeShl3w0MCJWqgfJDT81q9+r4Khi9g1Nk7Y7JecpYEixvF1WvQCjDth+qlW2Vf1KACHU5NfGbu+3f0KYYqVtCxe6WQEGTUWPRmdehq2UmOe0Wc4mvXbC/od0y2TA3oUTOOwGyuW6NphBp7q4DpKqtnxp5ef6DEEVgWv0cWGxUPtyVZPZ8DExL6zgdk5VvIpv0TB9sMYM8aSzVZ3+emf0xwwYzFTKkD2IL3gh2roM4XGoiWY0KUGA==
Received: from DS7PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:3b8::14)
 by DS5PPFC9877909A.namprd12.prod.outlook.com (2603:10b6:f:fc00::661) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 07:15:26 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::69) by DS7PR03CA0009.outlook.office365.com
 (2603:10b6:5:3b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Mon,
 18 May 2026 07:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:15:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:05 -0700
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
Subject: [PATCH net-next V2 2/8] net/mlx5: Use v1 response layout for query_esw_functions
Date: Mon, 18 May 2026 10:13:50 +0300
Message-ID: <20260518071356.345723-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS5PPFC9877909A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d249a17-381c-4e71-414d-08deb4ad3c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|1800799024|376014|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	Dq2o6LiCDYnquVtKogOe/exd5crjkCgjZ6k0LyKS3MOQqdhmefUG20+mLxk5S9rB6kMawVfaGPhbDyyyinMM+omJDP4SCHtigNW05URQ94toVLJ+csniY4i4laTHvwOv77neH1+cpU7ZVUp+cqu/obTpGHufaKyTctxhyKrjFAa5AtrVXy31/hGG8Ll9oX1UDMAXQCMRfi0xlBDupV0IEcbvyHMNr6VIBq8z/u0dN/EgftrmLy4BzgDHwUsPhWXpEK0mq7jf6yaNNA+y8QOcODC7239Q5Lqe9lucgtwpSnUEgMmBcAVzGaj2wvnVDELKmsW1G7L3Gp3+yBvc+2HsEGomq76RfcX8PyRqzoZs/I7/MII7YSLdIB/B1hbqVlRYSaDNnaChOE0IA/kCUds/CVtLrtva9tcg+hRBFP6k2ec93LsdViuenogx3FwX5tNWuq/b/uSE6NDoGuMQfjWOK8AaF/bEx4Mvl68R7dL6JQpJ6Upgat28og8N4cEYVqi3/xJLcbarf/H/r+Nq6nGqRpj8b6PqXbFv1qKxOCqFUe0EIbKmT+sFpQcaGNRy6QgB4vRUhA7DCNcsDVr6L2429uCma/uQf0diGnaJ+10x01yl/kYxytp5VqwKGqVZlEhm8NqMALszAzgy+o9MYIAqJgKVBcsQZUmyiCL0wGqir1MetQdbEmHE+/Rpx0aQja3uSOQInynUVeo0Hut4W2dKGCCafUjweY8abMtdkfTAUOI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(376014)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	As6DuOO62LI4k+YIdae2gvLnYlkJV/NXYVDNIEunyEPAx3hfkcmDfLkmFyvlLacU33P25mz448P5xs1gZXkQbZ+eFWhjm0B6btUF/LdT/JtqYnp9zal/wUgtLizdtmxfGFwu/c1H22IUBB/ci4GmfCUv+MpQxAPkRliSa8Q+pjT3ui/562LBKvkPtBBJpLg4HTYg4V4+bUQA7iwpLd3+2Mjf9jMqWI2AdgmsKwQiLO5vVTdkicqBZ31byAUpWsOqUxSz8/WNZPCDXR9Z6lIcf234TMVGErElO+JITe8Cc1wb64tUeCcpfIXePSfsVHMjnW1ve696tOK1XcevdcONlxvh6lB2pqgOGYlIAakVS3TgEaTqD2svyxr6CfpP4EXISy8AN/gONKOiq9XmwVJu82BLhr278cFl3AyFNHNfg1pofVnK985RAiyv0ZI+UDtf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:26.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d249a17-381c-4e71-414d-08deb4ad3c1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC9877909A
X-Rspamd-Queue-Id: 4C569567566
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20880-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
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

The v1 layout reports vhca_state instead of the legacy host_pf_disabled
bit. PFs transition through ALLOCATED, ACTIVE, and IN_USE states (they
do not use TEARDOWN_REQUEST as SFs do). When the ECPF calls disable_hca,
firmware resets the PF and moves it to ALLOCATED. When the ECPF calls
enable_hca, the PF moves to ACTIVE, and once the PF driver enables it,
it reaches IN_USE. The PF is only fully operational in IN_USE, so
pf_disabled is derived as vhca_state != IN_USE, equivalent to the legacy
host_pf_disabled bit.

The mlx5_esw_get_host_pf_info() helper abstracts parsing the command
output in both legacy and new formats, so callers do not need to handle
the different layouts.

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


