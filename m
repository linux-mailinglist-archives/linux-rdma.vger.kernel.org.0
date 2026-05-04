Return-Path: <linux-rdma+bounces-19940-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GtvEuLf+GmU2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19940-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:05:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861F4C24F0
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 351FD304E094
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5113E3DAB;
	Mon,  4 May 2026 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5QoNhXe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFF3E5ED0;
	Mon,  4 May 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917811; cv=fail; b=ojGl4sU397hac0rDHOuatXuGGCcLhem7fCA7AH6ismjQlCF2zUPv3aWrfRbly6g9Ati9zV+EYKgucBj/ieLve07WOdKUz1+sf6qmha8Ye3QmqEOqGA8ir1+aNZMZY/QhJ314n11xTn5LEXwfaf4YWMZBK1LmzbkC8lfco1u2A8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917811; c=relaxed/simple;
	bh=YHZJQSaMPe3v9BxQq0xRjC1+pvSGBUmbNHTXCNosqUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/FSMeRHM/Msay9litZnuz69QI7n5V7bEsbWWiarr1f5tjFBgPOmxsJibyVueJnLfHU+z9cL79I1SAZuftequOQoOploWb1RsDIUyig5eyENfuuO4DeTSShiDLNjK3o820laPovxL3i/s0902H02SWFkcsvUnAjEv5Wq9vuD0Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5QoNhXe; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NARXL9kpBboNuZgAOFYyjZ/PY20XLDI2K/3OCkxaP3PRdcxsdOdb2JavloLeQr6v2M+clYEy0FPZuKhzs+JtYJ05BOhFwalZKtKHF+wvrQRAf6H0SX04XPcRDV7eYt6BKQoC+XRSrAKZe0vGQWTIYwLUKOaokuM1Bj7+aOxYK6w3KzotdSQcJZNx5lloi3HxSkN4VAxzkx+Gh83e3NE5bytQmOPXefhTfEmIJumT7wP9eKTVn+ElhIip27wCDdssV0YuohYEF/8hxznkaH7VMevhjieJnmX5FgsBzMAig4CQv55/KuROhLDzOU0IfwT8lVYowET9P80td2q/+NNmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6ysd3GA/gstBNG2rWbr+6Rw6OlkpdgWpcuunnzAOAM=;
 b=xLzrVFwlhgq6Lf9lAejuCDLXyf7ZW/CNd46yRhOzA93cjgfU60p27IF0UDgqVUgypR2uftCNn2h6Spm+PsFlLCCE8/fwW8Ato3h7fnq/zUdzqEYEo5406plP1pJzCXC9YzLfelVGc/pCT3LC0tWOm0avLG9k8mE7/YxJ3o9ClWL3UhOKv5uv78YOz1Z2MfuyiXQ/1h1nMAaOfI0ioHPwBA7Jad6CtAMfLwnnD1hysykcKXnrTijIiZB2FDV3mxBeyvRuEOZDXQuhwQUREZQwqIk4SJdVuodxbZtiQZNEhAJNz6rk4yWqJTnFRcM3+I9w0a+449vfdjFh2JRC+Pw4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ysd3GA/gstBNG2rWbr+6Rw6OlkpdgWpcuunnzAOAM=;
 b=O5QoNhXevNJgWtNop81EICvQZTdLWgtSadIyOtAu6ZFSBY+d54tj5vv1mZi0cHLsyiJRVtDU9d2ei7oDsSSCjtTlErSfCWseyGPoYpldib3UBkvMwf/1+D6xPrY2c3zw3vE50VUDgi4H2KfIAgdrbqel5/wqM3VKbTUWtcQqyIWdCswGwgrZU4bbJ0aJ0U4kniIiXLlHoGVPvjm2FS0Kq3e1mIvXvJib7GdnY3nrxTHsFab1opX9lV12Z+ZjQp09Omh4ddISS9owvPO6OpozbAOfnayiQTyomxE2u2brcQnW8h9jPQdseACqzcKa2upEni+UMAr6ZAnWAHia5Rp+tg==
Received: from PH7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::32)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:03:08 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::6a) by PH7P220CA0021.outlook.office365.com
 (2603:10b6:510:326::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:03:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:02:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V5 2/4] net/mlx5: SD, Keep multi-pf debugfs entries on primary
Date: Mon, 4 May 2026 21:02:04 +0300
Message-ID: <20260504180206.268568-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260504180206.268568-1-tariqt@nvidia.com>
References: <20260504180206.268568-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e7e304-4e3e-4696-596b-08deaa076558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6VDMHX0kd4C72dljznGV7RYt+bqPAtqlD2UqmZX4dpDplTGXqL1TX5yab0tqLadTpsF93y6KXQf0CGO6bKf/lWmxYJIxlFU/MCOglEez6kIgZcZpkf9MpcXdoCQXkwfT4UUrY/WuTntQP8RJW2Xvzbnh0R1RLTzKjbBNJNdQyHmcf2rt6HPRkTytIK7P97OGgx/FOHMhHa2tEAJXgFH25rmxKuV/NkvOwmjj/9eOrUMf1oLUfamlK5hhnUwIbXtmRn2BTrKVZJpKxo13iAlM4lWfWxgm7Hfa/OhPy5+x8Dx59Nc7eET6fn8TL8pqXW6gDtqNtxkM54e1Cx0fHajDcl9UHhqO9lwhc9+0nA27hiMyV0rzJGuEgWhX9LnxxNWffBSE1PfCU5wonwF1J73gUMjKDRFNAYP9wFVnw6QtITkXCXD1Z9UzY/VzRa9E9cHRkQft6QlxJ0/HHwxKw+KCOch9cupNJVT/FHbhpwiOS5ELi/87pNxgaz/FrDfqSG7ZFqo9Rmtuap8mPWj2Gcp+gNFT4Py2Tx82htaImY5SPqL1BMeOIBiMRXm1FE73OrQ87ZeHuTxHsj89oTRut1X6WdX38EGV4Y7AgeLAzeoAOYWnWcaNezbQy6+tlBGZGX1oaaVUZVDRuWJ3iy0HVEC2VfPif+Uz7MjXzwFGvemAnKSC0WCtv/aeT+p0uKmfuyyBV6I5PLQMyLc1eqLjcuMyhPOHXDxLaPW4FP137WX6BsM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ipyS7XGzhysJqGZTYdKBzEHrgsnbI6kQmhUdv+EUQkfKJfHMmNRM+Iv5121w3+dostaA45Los/6jG/icD4eh9irEtTe6a2riyokZbSW3pP1r92IgBRmNODIYQDuB1MnQ/rKkq7EuSLS8uhTpO8DmfqGkssg8y6MC8RDWgsTImqputxVltLsyd3h5AdIyTy8qHmwzC62a4/8hA/pTXazbHiKY252AwZ0Pm/jk61qOcaAuhEdtx40gFA39yxTn5VuRBbHDx75gsuXyi5N0KNuq+44pgBbI952v5J9A8HKYiUvjPhcJE9zHg+rS6actCsHWo5pKNxbLDrlRvAwmfW0I5+C5y64SqKgt9Z/67ZfQi2F1/hN0anongROwt9VjGTSkM0aF4toMlRHSaHLUaB1sM9ZqSwDtRn/09jqLLiKmPeNF3IPgsMFy+QvB0X80lEkE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:03:07.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e7e304-4e3e-4696-596b-08deaa076558
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
X-Rspamd-Queue-Id: 0861F4C24F0
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19940-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Shay Drory <shayd@nvidia.com>

mlx5_sd_init() creates the "multi-pf" debugfs directory under the
primary device debugfs root, but stored the dentry in the calling
device's sd struct. When sd_cleanup() run on a different PF,
this leads to using the wrong sd->dfs for removing entries, which
results in memory leak and an error in when re-creating the SD.[1]

Fix it by explicitly storing the debugfs dentry in the primary
device sd struct and use it for all per-group files.

[1]
debugfs: 'multi-pf' already exists in '0000:08:00.1'

Fixes: 4375130bf527 ("net/mlx5: SD, Add debugfs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index ec42685bdece..89b7e4d67303 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -463,9 +463,13 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_unregister;
 
-	sd->dfs = debugfs_create_dir("multi-pf", mlx5_debugfs_get_dev_root(primary));
-	debugfs_create_x32("group_id", 0400, sd->dfs, &sd->group_id);
-	debugfs_create_file("primary", 0400, sd->dfs, primary, &dev_fops);
+	primary_sd->dfs =
+		debugfs_create_dir("multi-pf",
+				   mlx5_debugfs_get_dev_root(primary));
+	debugfs_create_x32("group_id", 0400, primary_sd->dfs,
+			   &primary_sd->group_id);
+	debugfs_create_file("primary", 0400, primary_sd->dfs, primary,
+			    &dev_fops);
 
 	mlx5_sd_for_each_secondary(i, primary, pos) {
 		char name[32];
@@ -475,7 +479,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 
 		snprintf(name, sizeof(name), "secondary_%d", i - 1);
-		debugfs_create_file(name, 0400, sd->dfs, pos, &dev_fops);
+		debugfs_create_file(name, 0400, primary_sd->dfs, pos,
+				    &dev_fops);
 
 	}
 
@@ -493,7 +498,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 err_sd_unregister:
 	mlx5_sd_for_each_secondary(i, primary, pos) {
 		struct mlx5_sd *peer_sd = mlx5_get_sd(pos);
@@ -535,7 +541,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 	primary_sd->state = MLX5_SD_STATE_DOWN;
-- 
2.44.0


