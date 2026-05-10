Return-Path: <linux-rdma+bounces-20295-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK4jA2cZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20295-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:36:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D2502AC4
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E4593012C94
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901D359A6F;
	Sun, 10 May 2026 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VhySzxE8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F299351C25;
	Sun, 10 May 2026 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391377; cv=fail; b=VxR2oHhI2we5SUyJC16Z3jjVj7hlw7MM17CrfF+/j2jrU3CCChu2VfylFhX9XZ09XvZHtBf1v6zkIO0Zyt6gKCfXY+sKWeDDeH7K8fDORQBYGGRCnNdVdDILfouWA8fXkchPEpAT6nbd9bfSLNqqZvBgwsMGSQ4ljXjHVyo/7Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391377; c=relaxed/simple;
	bh=dmlHeHL3Vzwqv3Pn5dynHIgWA43cpXX22f9yw+PrbfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2Ax/vu3chMA5khG03M22N1iQIHAJEqkjFLGkK9zVBNkSykrWBTDXJ69n4Sy/NYLon0fZ1rExQ42/8Pt7xkL/OOcGBwFoMqF1S6GUiz+r/+/Pa6y8gR1ofGO2706D+byaQgqXCx4uu+6+W/cNE8l4aMzN6PpoEMJR9iGGhgZJsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VhySzxE8; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRm7qdd2gM748NcKLvA90n4ry5TCKRsm1TR5ximAUXOJ5HFHyW4ib9d0duWW9nNgkM8rE/ub5gznL0napSS/6/nBLH3miLZMsEH9J/1X1VyfLE9mYHWoMlKrINHwl2w5UrB/OXwx1jwU37CILcwVQUPfmtjOzqF3mViTg13aT9kKyo+ojQQJyuD6jAhLlR1uWp4rg/+qLogIk7/c19tIfAsInd/i+nfdPF76VHmzNmDn6jercy0E5jry6iAvjNj9UCvTsLO/qzgU6cw5KU+OlYZQfs32dRG98JO3lkCzQqX9znAZWX/xw3d9Ic7NhrMJLiH4gIeU3GLazU4w05sE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k//5NYtzwYj9LoHrlzJhqgt85UtgcgQD4sdpBuoEwRQ=;
 b=qH0o/dsFypylApzKwMLLU3vVosaguSPmR7G/dSDJRm+eCSyRJ7uDBaF8KlzvJ9AKSefnpfhETuWdr0QJhFZ59pGi2wNB3gJW58MR86MveSyY08OyH+2TN4RusbKDRtE+9KYjWyZ0Q2P7CvJiOa6Anvv7iLZ/QL0UtX6jGXN1N491+uGKaa2rbDgYA/2+ZoaR0JDhXjkTuZJt7MODmgDX7gixWR3bfblnBBsFJBlIF6ajqTKNEUS4ksV5YO6fw6E+gWXuFmtv6c1mBPCPbI2w2iCc7DDdGKcwelBSp024nq1/hg5okr6vtOMB75DdkqYsFXKfoB9i+Owx0l2IkW6Qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k//5NYtzwYj9LoHrlzJhqgt85UtgcgQD4sdpBuoEwRQ=;
 b=VhySzxE8c+TVD6FV6n7Y0Zxh1ELa6QVW1gk5v8FnHOesXRYOBVtTKVTjV3yKuIBhTdLUZvobhcvLFFoZbhPFy+5PQveJq1WaRv4I0dOG1B8cN2KTPKyAwPV8tneDd+hIeOM0RixVaEM2fRIS4D/LWrIRHq5Pc4VgOLil0nnYTKn8lGDVjFMRpQrJStJrxlU/j08zS6EHVjQLNwzeQeFQs5/Do87R/FpS119gzOJbuhnD1d+zzMniM8PvwKHrzHsyoT/k0XEDht8VL+p+KQSjMASXCr+1rD1EzZo9jLPfJR1IETGWvQSEeVo8MzPbNZRRJxq/Ev4Tqq5JgUUzLIP3qw==
Received: from PH8PR20CA0022.namprd20.prod.outlook.com (2603:10b6:510:23c::22)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Sun, 10 May
 2026 05:36:11 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::24) by PH8PR20CA0022.outlook.office365.com
 (2603:10b6:510:23c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 05:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:36:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:44 -0700
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
Subject: [PATCH net-next 7/8] net/mlx5: Use vport helper for IPsec eswitch set caps
Date: Sun, 10 May 2026 08:34:47 +0300
Message-ID: <20260510053448.326823-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 525a058c-8816-4c85-3d43-08deae560b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	8yK1zJhxe/hxkeXZzA2z7Kgo3tCZK6tJ16BKhgY96qcFjz3uDxp5ZjsdSjYjaPhdaY0LZMpfaQw4KrXVBX2nxITtJpGaxPHxIXY34ccW5j3d3lRsnK9Ef8NRhrv/t+u3+h2bhtsM8tMuYidQ3seMnBewBlAJ9bfCA4Wumz4PWSPjKrL67vIzHSr0vx+k1PXYqPjruW+saFXxw1gtQqoO5Ks45NXJVS2p3OJ7WlFkS3KThk2gB+s1I0odq0O5Q0ImmPFnEvQh8OVyr+3hHEJjxEUPkiTBY9YXJRZQCVzbsO5uXeHXQZ/9KY1Nk6gSGEej11pawYegkkn/TR8BnXa0GVgRlqG+fqZ6raqlxKV/UlMN/4U6EypaVueKcfsZ7eVCKbQ744ZU0fJwWET2bWc/fIyBQ+TIhSzvC4jYz6cx7LCsqsZHS4/rIwVTZIo+FsGsrBFRP6mHCF5nVo8UbWjcFTx/803L7Mqw47qFID1IGNTFkxZatRwS9HwhEbxr6WIDuk53bTNlLPnPaQnl0lykNqwv4iFpQce0QUuuVzmHkEWjMMHMemDz5PbmWjPXI80Atah72fSWmebn/tSKdySN79AxZYyfJqHi810MPoTn+2HK0BAKtkVYG66TEV5uZYi1aJZwZUqtqmDHhcyo/po5XDWwcytRn1xFgCgKybhoTjj6UxJfYBVOd9a6yOPwuF5yYsEaj0Bs7CeO4jcm+bHHznVUgqwAFOiwOkBbKS3zQcg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BPL3zN6IavYaNtdyOt/jrswmjVpHuKKC94zQGzIIo2zvT+jf3VlmzesvkvduKahKre99WhhhTQeEaxE2T+39BcU3UTO4Heh2nUPxpIxb1sH+yXFhjQii9xR6u9BA1D6IyOmAe2BAJQxmrcSRZP8F/NRneU3gg7aVHALD1KZFrwUqViq7AFJDfocRQs4FtEP3/e7oZNLI7DePT7759W1ogh58SMBJss/Em60513v2z2qVAWB1kORGg/6TKV/1Y+JL5f8fhSjNp9nVG3coDA1TT+9Dg25y1w69rKVtYHy1VlR4ZskU4nTPJungskd8rCYUxDA3/VvyQKKqeDJVse3vO7jsjtuC831Bgzzc43y3LvrwoJqysc4TMA6hfo8dtJA5fTGBUghkm37BNgYaxw7324/GAwmDkX+ULvrQ2sNhTUQ1V+6j28aSFS26BnR8bYpJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:36:11.4881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525a058c-8816-4c85-3d43-08deae560b76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
X-Rspamd-Queue-Id: 7B8D2502AC4
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20295-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
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


