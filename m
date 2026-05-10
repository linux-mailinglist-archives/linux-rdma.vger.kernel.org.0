Return-Path: <linux-rdma+bounces-20293-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJKHJjoaAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20293-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:40:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA1502B24
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 045583062304
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD8355F3A;
	Sun, 10 May 2026 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FsmxJSed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948934DCC7;
	Sun, 10 May 2026 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391368; cv=fail; b=Q8c2c3Rvu0wbIxnf9xFL6IsxzUw/Asoami/MbEU66pANWfw7VZv5Wvpb0agr1iGhZdLqTp3gO77I07zuzCq2go/wy8OoMUv2/Z/a9nSdKiyo1p2sd7pEq7JKkecD/IpGfo+n0XyYGvj8mBRwBq0S1ZZDYSBr0Zf6Idf0xWegZuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391368; c=relaxed/simple;
	bh=tQGfnkH9F4I81N/g/P3ZmdfBdICToAbIKUkaztMRL/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOE5RDUkwdsaEyVX4jEHtDuT9S3badvS+k3HXE9fxBUA6AvLrxNEkfQL0sgbVUHdS4WH2rfzMraWb6d2TcxGiaL7Jp7+rvVR4mRfuErL9DyFmpWdMzI7RNXO4nJXgulCv4H48tQAJT6v1m6OzrUKLQ1TSbiE7HywmaoOiRMUFU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FsmxJSed; arc=fail smtp.client-ip=52.101.57.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yct9fsiaBAU5rE7y8u1KmK5RnXHfIOTQ16tgZd7bZb1IqSFkkxTM28VWMplUl4KG++XEuqLB1SfX9bA14crElmARqxGoH6HoMxP6gP8PGLV3kRFM+IcnPXA1HRJhvBb00cpfhQ2gl72rrC7z32PVHyQmx5C+4v09YlH9SMv8eRKLWgganJXOcgvScPZn9xC8TacR1/W29VB+AEodczEUhr+Ga08kXRnfDX/JYE7kW0cghQjHmytnQsM5vKM/5ywJTojlRjYmPXA6RH+6Vjfm6xKNCvAY/U7JOVfBP/YWDrIyjXtoCAQDcCicyXIafCpINmycGv7BlgcRZ/H9Z0DPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+MCUb8TmhXN5OyMFxVX6ZGv5Yl8Zo6tIBlnxEBQmPU=;
 b=RugCd+hRTY8BgTOagEys+qC4zysi/hX/A2hT5ZclY//wZcpWdPs9XxVWXLzvwF4hVIXnUUAriCZkHn1In2bCZw1UGhakUy6hSF7bbXUx2/33rgveB5RgpsnXY+pe5v4RKG9jHV0BMHxrFThqkqhyBbxIGuXCMp5IndIy/XE/6phvfaaxy23MBfVXzf6tkTWtMIYyOV7zbLPw4e5MablrlgXB1AabA5DEgZr6Ekp/p+LkEkrtAmdNbYjf4Uu9ZY9oT7cjJllEeB5h+5wzONolaFBOrZDjCdgsW0IlaAdkaGsqaSnWY+1o9LAOL5Ofb6jgbo7YkBSOSd39co5qSQoFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+MCUb8TmhXN5OyMFxVX6ZGv5Yl8Zo6tIBlnxEBQmPU=;
 b=FsmxJSedvLLZ4/y+BjBy8gGViFD/BP/PEIXmONkzwGiZo0BtgkQL4W8LZ485ElrPa/98JV+R4ysUEpc/OjZ05u+wLqmiylW19LqmpHZPfOo3gvtJ+ZxgKVxIBi7g0RTwU+Jc7Sh16TMVBT/UUaI7IrWy0yLM1JUB+kqdd52W4ZSbu2gqmMwJL02u98ymMfulHX9nuGhzH79fiE9O92JpkLB8cmR/dGBYQhBB3i5HHHmmCzAthwER21KIb/n8a7N0rLgNWT/2XX7JLMPlQWJYQGX0l2VTKhkVlAmxUpfb5EqtgIDesSXMWoSN6Rr5IcN5YXpd3KJFLK/eCksWBwu0aA==
Received: from CY8P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::9) by
 IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sun, 10 May 2026 05:36:00 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:930:6b:cafe::4c) by CY8P222CA0024.outlook.office365.com
 (2603:10b6:930:6b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 05:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:39 -0700
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
Subject: [PATCH net-next 6/8] net/mlx5: Refactor mlx5_set_msix_vec_count() SET_HCA_CAP
Date: Sun, 10 May 2026 08:34:46 +0300
Message-ID: <20260510053448.326823-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 826df3ef-f497-4338-e127-08deae560492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y6kXtaZ2boidPy1NoljGNJzBPupHYE7wuUBBX0VQmmIRNpdRUHBEKlTSGXMN3NqIji7zkMOAjrc0iWSzEk7ddX8ewmnhyJynmouXvFfuxNnsmA6D1lNM+ARAeXGc79YoSJ76rrGc/j9rv7G6F4BQjLacI3zmmEjrx+j3GLXKiXTQpG6TgF4Rb1p3GL59m0AnKKlNR1A+Y0C6chBp9VLv7Qjit/dp1SJA61xdaMcCSDZ5YuYsszMczyPUKNorLXPuvImA/Thpzd3n+AQRmEgcD9qLgYsNxi6F/JLjBeAg9bLEzpSzntMQnBYzlsRokM3a4vKHMDKExW+en5j9XuXhMtY1LejaK6wop7s1KcX4IpBJ+uQwNk+O9ZsJIEaYkK5F/ZaP4i3s+Uo+SNoam/NBzCJmkQgb5B84ZThg5uFbfQ1IO922SGhBQUKCJyzeFItxJW41frU3MdNLKQUkH56emxwOspafGepfzeuvXhfD4CMMxPq8XeFYoDzUWnh45N5+D6KQ8cjSjT7F3t9cXU/SY43NVKNgPXVB26mNs54F8UoKo9ec7UGFff5i/VLmoXovCStyCtAywtCIPnaKPPZfqk57M5hflZTyo/j89Lb7qcx6VgDYDmzxnYh7775UMjlYnxVR7uCVjftTXi4L+mFtae00ECX7FKVF5TB8hc+0Ey6Zak9L5m4oLPLm/qXF89mxy1ZO0itpnEkalB6R1S99Z9vkfQ0gnjRBJ6bd4fkvp8U=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sgiwLIkW1MK0CclGEzRV2rf0M6Py59jerF0bYNKoGzxrgRilMbADfOOFoblQ9EzYzvao4eC6iFn8FRgB8rvLh7Fuf3INW17l17pQyC1uxwVXkKhL+RZZqL55hJ2mL97Ghpnhv+OjoMlyPoYGSyRtj2mUmPHd7KYzvJoDW2DvmoLcjBF5eUI44UJzboQl3vgZVPe8+sokX9pwDsh/koeAFD65t2kPOfoRS9+nb6HdAoc9JUDS/XI4m90sq9m6JmuRUGbDz6Zw3O7djAEfl1TS/3EQoPuZSGDPdn2fBbwuv4KYogGijxPyoDlqgFjeI6X6bsPm6AvFP9hoavdR59i/2PDajL3RMgNz3vWtX5k27sIvJxPVqu8vm8YDEP1EWFRs68ZEhKFcywfOb+8tqODEdr6t0/2854D2eDpF0QSpjp4n4rTpKU7N043nVzIMaFns
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:59.8791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826df3ef-f497-4338-e127-08deae560492
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
X-Rspamd-Queue-Id: 3BDA1502B24
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
	TAGGED_FROM(0.00)[bounces-20293-lists,linux-rdma=lfdr.de];
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

Use mlx5_vport_set_other_func_general_cap() instead of open-coding the
SET_HCA_CAP command. This removes redundant buffer allocation and
ensures consistent use of vport-based function addressing.

mlx5_vport_set_other_func_general_cap() supports both function_id and
vhca_id based addressing, so this also enables SET_HCA_CAP for vhca_id
indexed functions which was not supported before.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 27 +++++--------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index e051b9a939ee..0f5b8bc7861e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -87,9 +87,8 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 			    int msix_vec_count)
 {
 	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
-	void *hca_cap = NULL, *query_cap = NULL, *cap;
 	int num_vf_msix, min_msix, max_msix;
+	void *query_cap, *hca_caps;
 	bool ec_vf_function;
 	int vport;
 	int ret;
@@ -111,11 +110,8 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 		return -EOVERFLOW;
 
 	query_cap = kvzalloc(query_sz, GFP_KERNEL);
-	hca_cap = kvzalloc(set_sz, GFP_KERNEL);
-	if (!hca_cap || !query_cap) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!query_cap)
+		return -ENOMEM;
 
 	ec_vf_function = mlx5_core_ec_sriov_enabled(dev);
 	vport = mlx5_core_func_to_vport(dev, function_id, ec_vf_function);
@@ -123,21 +119,12 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 	if (ret)
 		goto out;
 
-	cap = MLX5_ADDR_OF(set_hca_cap_in, hca_cap, capability);
-	memcpy(cap, MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability),
-	       MLX5_UN_SZ_BYTES(hca_cap_union));
-	MLX5_SET(cmd_hca_cap, cap, dynamic_msix_table_size, msix_vec_count);
-
-	MLX5_SET(set_hca_cap_in, hca_cap, opcode, MLX5_CMD_OP_SET_HCA_CAP);
-	MLX5_SET(set_hca_cap_in, hca_cap, other_function, 1);
-	MLX5_SET(set_hca_cap_in, hca_cap, ec_vf_function, ec_vf_function);
-	MLX5_SET(set_hca_cap_in, hca_cap, function_id, function_id);
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	MLX5_SET(cmd_hca_cap, hca_caps, dynamic_msix_table_size,
+		 msix_vec_count);
 
-	MLX5_SET(set_hca_cap_in, hca_cap, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1);
-	ret = mlx5_cmd_exec_in(dev, set_hca_cap, hca_cap);
+	ret = mlx5_vport_set_other_func_general_cap(dev, hca_caps, vport);
 out:
-	kvfree(hca_cap);
 	kvfree(query_cap);
 	return ret;
 }
-- 
2.44.0


