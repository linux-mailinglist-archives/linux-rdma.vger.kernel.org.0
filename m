Return-Path: <linux-rdma+bounces-16010-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEUaOQwVd2mHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16010-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:17:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7AC84C35
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 522B9301CDA4
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31B2C028F;
	Mon, 26 Jan 2026 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQ7lG5+u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42F2BDC0F;
	Mon, 26 Jan 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411756; cv=fail; b=CE79NHMZxw5i4bbPOfkkuOjwVhad1UPY84s541a6SyeIKw6SCvL1pOMQiIMfVGF1r9GScOM1GnhkVwHneRnW+yHey/PBW0QtVoDiKkWd/DgH4WhtHczsGku/ypIAx5k/S09yjtR3tOrj6SCa4d1jbkMgTsVWDuIJbqeGDbFZRDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411756; c=relaxed/simple;
	bh=OwI94IJmojNpHu2vl6hrDwIewAmA+OeX2rEvoGCi2w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoZyuZf+WdAQ97k2M4H5aybekMjX+USTseUkmBqh2NXyJa9FOYsFi4WO6Z6BRMLJDy+lGWOtuc6TWVCluWmQefIrZU9d/0wQ/DmPy1iEqc1aD1pIp41NWywaSt+o+WffR7yYLRxbUHvQ599pObTT7z32q8W9VKHAF3UmV2EcGEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQ7lG5+u; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIiW/WSn/x0WcGrGUW23zJdNhVAKzao+VXCK8JaRCyD8jrkVajekXEgXE1v+3D8lzNrwnTRoRCTZr9LCruG0fRxHVbBdF/vjLj4JKxAOB+KrztYriOxNfEZHs21S+8zJ7/Txp0L9SpyieN18l2bRqMM0vxEsWb4dS+o2nKxUhsE+la2VWT6qMEtQFF+xDbjHwXOgOlgKVNpnj53DZsHrVAdL8wvs6/MPanRbUqfeWy7zR8+lThtrx9EQHBZR2R9F5lBkYSv7x9aIenF2ohA9iFZTlDxUrwcPQvDkoOMTNGntpKWXOMe1XQTfG40ih+1JizFTeZk4aUnKDR5063M50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wyFlgnw3OQYwh5sR2TzkGh2apbMShux98lez9pwcqU=;
 b=d70QH+3rAO0XR/aj5S3juQA1QRssLhRkf4/PS7NTrPc8LdYzwgUIqNG7amf06afM8VMpUVl78C9dgCB1r2FC5wqpLJoueEhk52vAP2HESedf7LEI0PffMR9iOHrGQLnPLpo/17+/lrQBhgQ2DdKUBs1TvryRT+/De3d8WcLROeKVJAn3mlR24dwkrtcG0c/OBQ3b56lwGe6GrTVItI1vJd4iX2LY4Awa/H1tNyKZVZyqllIXxi+vLFMs7xJyAKHs52N4eIIfiTeYc1sg2Rf0oS61r2TGPJOE+zx+bt4K507MokHlr6Ek4M5beRGKtt00NrOZM+e8hyjf4kgo11f6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wyFlgnw3OQYwh5sR2TzkGh2apbMShux98lez9pwcqU=;
 b=XQ7lG5+ufEgIthC3TUALCvAcDNqfXp98a1Mchke6kPcatURkzmFcjo2uaDKq4RUlP0lCLahrbUFT4AIkHbf14QiavSxpfNLhqtX/wKwydbU7BKMqdsKU94o5MXDsSoEpSYN2QZJrb6KP6ZVMcDiM1ZNzbXLkwbQzHTH03fiP1R6/2mdOnWfqgRDVIuya1i8CWa5qCXdE8ZBYVOXxq4cNGV0rwuCmtRR6z1Da3hcoD5ca7HeSGwK1YpVxgTycvQHxQ4WUTnHLl9YDbtYvCPoOXggZpAuNg132/0DdaabYgPnYv67KKhfgyxccSWKIi/Dn3sXigLiJjJG9aJaI6jxlbA==
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 07:15:48 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::9e) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 07:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:15:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:15:30 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:15:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 25 Jan 2026 23:15:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Account for netdev stats in ndo_get_stats64
Date: Mon, 26 Jan 2026 09:14:55 +0200
Message-ID: <1769411695-18820-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
References: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4ffcf5-51ae-4cb1-bdad-08de5caabad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kUgrA+AZG2syNxQPADcYIhL2YUSHpRWWS9mr+veW5Z64d6CWsPVBnirpd5c0?=
 =?us-ascii?Q?yAstIK+TfQNi9otQKDtcGWSkVh37Bx+d25M0Vvg6TjuJ1thyDeSbXswrzSuJ?=
 =?us-ascii?Q?DR2MKFGlpU9xVbp+ChGV0QYGhoDU21Q3nK+W776VI7SzMA3ie2D6GA/JxchT?=
 =?us-ascii?Q?s+XJWjVFjt/nzh/2TliGjYts1pKh6vcVtajyzU5J+llHb4QJQNQHaB9/dyLs?=
 =?us-ascii?Q?Qx3RnNHmYs7+N2upkZt9qid2G8uCj8MUdQmLZ1FzjFyh00Lj+E31ABozvEGx?=
 =?us-ascii?Q?Rlgd+CHxBzEGKGPeOseiNmWw70oBJXY9akoFxXhFX5KRS4p8rn174rcssdxo?=
 =?us-ascii?Q?7/rz8RQew/l5ILOihrc38Y3vpdHXLW9rLksEvC4d9RHx+nuolpF2Cnuh8KPf?=
 =?us-ascii?Q?6Zu6yvISVAQR4OknJ9q2dddCBVurFgxnUkmzAhnjkrpZ/o20tYj8A+v2Jrj6?=
 =?us-ascii?Q?QFabtJOyTl1pLGjHffYMvFma3NvsOh3ByMfxXo3/YnUiixyLp/mu3R1lY96x?=
 =?us-ascii?Q?Vfa7seBeRgKbQ+bh921tEe9+xC9N3cMCPvTUKlq5FG5g0knb1rOWN9KY4p7t?=
 =?us-ascii?Q?LEd0nk+zYkIHAzMWrDOuIiFWCNWqkWJ+rrkKeNIZyiIDsQBDLUxI+YhQllZ+?=
 =?us-ascii?Q?HBhyd3cIbBJBI+39ojrSyld2vUWWQcqbNp+qVY3oKYg+0vqGTcVsK5QjN61D?=
 =?us-ascii?Q?Wm7Xv/xtcKDMmqdL6SH8khG2iAlJyCefB++isjwEgJjHow8Y/zjP6GKbUfQw?=
 =?us-ascii?Q?HUOmP4Wo9X9+WfV4FGBxPstiDfEKCxIHouFqsgWZsUiXtrrvQtITxxxt/uNT?=
 =?us-ascii?Q?yTEx2IRkSGBi+zuRGc4DI+uGN8Nk4ZMGa/9iYGVSuVmUp/BACpw9WQ1zco/F?=
 =?us-ascii?Q?8lsG9lw6w16aTa2RCqpkhz+UeV/W0JPGNCADo8HKrsAGmG4Gi9NLnfVoH8XK?=
 =?us-ascii?Q?12KEO4xJllmLicPsxriKGtkbShg8IbMvpZOS107QWoptA41RMcis4l0l84Jd?=
 =?us-ascii?Q?kc1g+ajpOj5Vb12UkVCi/by0viqL+ZMXEkuBWRgjVg5dV78IuhBKww8/Jidr?=
 =?us-ascii?Q?w1SqcFC2fZRymR3F93EBGFZGUSX4eqDrDqXwtYFFlaEUrygy0sL/yPHqbUZh?=
 =?us-ascii?Q?eY7j0QsyPK1r8ZLDoKe3lKNS8orpHlXYToSjOVJIcbD4iQsKZ3dXyGwZdGbY?=
 =?us-ascii?Q?Sy0d3vXtfG2pASw1Ftd33qrjFOUyDO8VQZZKuIkjOcIICZKvikvtYwp+CkjZ?=
 =?us-ascii?Q?rNlCRXhpE/KGeC9/Ezttu7Idp/M5uZ7McG7ZV+dDBho3qbXlopoiuipepy7K?=
 =?us-ascii?Q?8u8bbscVLXbtm1OmxjHdxVmUOnnvmoTpkVFdY6M29EVu9MWUwW5SS0oriwkp?=
 =?us-ascii?Q?BGq/mojz92z9hArxca8l8085To7g1oEIZmALitfdKz4PwuSJ+brQnbgjFZLh?=
 =?us-ascii?Q?5hCMZIRuRNy0smrCd+z+xtk7JHIIkYFtvVflSAIeQOaq8G8FGqYmY85YejLf?=
 =?us-ascii?Q?W+ICBN9DK/cxnjR3goK9vxkRB3SzWpdRRrPcVLU2BDVm6Fgio6rN98QONLGU?=
 =?us-ascii?Q?ZZ0B2o0Ld1vvMSfP7N9BDOHNV64suPcrK2wefJTQ/S2jVGm5oZReooMvo+9w?=
 =?us-ascii?Q?f0+M2/rmCQIAYEFRzouQNrw09mZtcA3jVSYQsM6yNFG/Oeluat02fwncgmRr?=
 =?us-ascii?Q?aHcmsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:15:48.1121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4ffcf5-51ae-4cb1-bdad-08de5caabad6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16010-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9A7AC84C35
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The driver's ndo_get_stats64 callback is only reporting mlx5 counters,
without accounting for the netdev stats, causing errors from the network
stack to be invisible in statistics.

Add netdev_stats_to_stats64() call to first populate the counters, then
add mlx5 counters on top, ensuring both are accounted for (where
appropriate).

Fixes: f62b8bb8f2d3 ("net/mlx5: Extend mlx5_core to support ConnectX-4 Ethernet functionality")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f83359f7fdea..4b2963bbe7ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4052,6 +4052,8 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_queue_update_stats(priv);
 	}
 
+	netdev_stats_to_stats64(stats, &dev->stats);
+
 	if (mlx5e_is_uplink_rep(priv)) {
 		struct mlx5e_vport_stats *vstats = &priv->stats.vport;
 
@@ -4068,21 +4070,21 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
-	stats->rx_dropped = PPORT_2863_GET(pstats, if_in_discards);
+	stats->rx_missed_errors += priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_dropped += PPORT_2863_GET(pstats, if_in_discards);
 
-	stats->rx_length_errors =
+	stats->rx_length_errors +=
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
 		PPORT_802_3_GET(pstats, a_out_of_range_length_field) +
 		PPORT_802_3_GET(pstats, a_frame_too_long_errors) +
 		VNIC_ENV_GET(&priv->stats.vnic, eth_wqe_too_small);
-	stats->rx_crc_errors =
+	stats->rx_crc_errors +=
 		PPORT_802_3_GET(pstats, a_frame_check_sequence_errors);
-	stats->rx_frame_errors = PPORT_802_3_GET(pstats, a_alignment_errors);
-	stats->tx_aborted_errors = PPORT_2863_GET(pstats, if_out_discards);
-	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
-			   stats->rx_frame_errors;
-	stats->tx_errors = stats->tx_aborted_errors + stats->tx_carrier_errors;
+	stats->rx_frame_errors += PPORT_802_3_GET(pstats, a_alignment_errors);
+	stats->tx_aborted_errors += PPORT_2863_GET(pstats, if_out_discards);
+	stats->rx_errors += stats->rx_length_errors + stats->rx_crc_errors +
+			    stats->rx_frame_errors;
+	stats->tx_errors += stats->tx_aborted_errors + stats->tx_carrier_errors;
 }
 
 static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
-- 
2.40.1


