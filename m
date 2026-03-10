Return-Path: <linux-rdma+bounces-17864-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNWeGor4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17864-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:55:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB3249C78
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C510930F6CDD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB243815E1;
	Tue, 10 Mar 2026 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gpo1kY+n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C070372688;
	Tue, 10 Mar 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139764; cv=fail; b=RRZ4KiRcugAAgphdpccHGhip8wnuWDmO+T3CNWh+vLpjkpYJvcVEfU8oUz1Ki/IxeGVdpCKVwEar9fPbakIpHVY63VgOwVy8tBAPKVRdgVJklLTPn/xcA/sYwTdeWyHUTb5BE6vUX1EViFJpXftznAimfv/9yadgyF4vxeYVObY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139764; c=relaxed/simple;
	bh=rxI+cvpGWimbuxltXdoPi+t1dM4EUKZc+rFu9na/W1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mtWXixolhzYxK3JDCspNgwAwoUNSFupeQADRHAiYOdILMPjk3MWzZGXAXn3S8imj/8XemYy5muRNdq0cRLSS3KHiXkrhwNNmclIhTh78RxUZtFoxyaOhEfvLKtCQVDhTXObSQFn13t5i1yc424kYmVzctQMfcjLoThpLVNf6Vhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gpo1kY+n; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqyPsn1lxyAIUUXMjlZadlmQdfnWq63Ei1E2YwdhXcpbfXI0Cpue5DRfWQ8ZaTHWR0TrTLgOEuoJx5ZVpFWEKuufy7uMNAqLvQDZAdqHmERKpw4OJelwglKhqQ7VVKd1gRSZKLBE9UQNNRftn8gW3WvemM9b306hl1mXQHxLnJ4VYKoQOPRUEhUj/zX+9SS4p08OK4UFechog3MWUGQckPRnheeMSgBafHpY7QG6b9g3FdRSk4pKtMXc4IkGm8sBwjao5XTpubl6K/g7i2g1dcn0fKWs1W3vtTWdxP3M3ZbTJ0pqtlMd4CmSWh9qZM5Mx6z/dbmlqeqLH0BfahPuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S69akIKvbOHtyN6zfq+7D4DGFK0aZtBAbfZUBNwzLoA=;
 b=Y25CPmMkJ02L07zq2MaSgRZ9UBNZfb7XI9lU1ufjtQ42jOUxXgpju2DIMoOzpzOH2qa2fXRTm79gIGT3je3v0aCS+a1Gt+0lKdHSEbOciXk4yyhBwLqwtFqykKcd6pTHCNxT1mujolhp2p4ZbemoYLPjEH6xDtzGEPMYXgfwt+VWhMfB4/bXB3lGIjLlGVA6y9pD2xVYCV60KPCqimewZTACgy6Z9RF6BuzX2ufjLcIfSaqvcaL2aO+JcknTyY/K2lIlKE5dUj7D5LggmBW1BmzZ9oZn77sdyakfkkyPz2ZGC9O/nBE4I+rPZfU4d4XdRtNhxD+Q8+juiCYQU2cYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S69akIKvbOHtyN6zfq+7D4DGFK0aZtBAbfZUBNwzLoA=;
 b=gpo1kY+nAE5xnbeBBw5jIWKiGFk/9JVCAk6qBZw3pgWhHSs/VC0djTWPwXSNiHGpg7bDQL+z5kUD0oguWTFX3kyGAdHXe7e9gr2Y8oIjkoem9X09Lc8ibyYZ6b0G7WdX1LGC/mDdzoi30WfnFBmvqpvQhXxVXK8wBBli7vjOg4Hlx+vgflzDw5u8ASuoEOo8eoCn/a7nA3vTr95b18xKKFdNqetrnDSNE2MfhrR8zdW5Trne0b9ydkcXl9j7A4ygigKJ3I7gxiOeY/lJJaSmJSY9AtatWjzfbbWRcixZohOFl2uNbsb7rR7ky0asswUUHnT07B1apNkEQknDFo4Fzw==
Received: from SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::28)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Tue, 10 Mar
 2026 10:49:17 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::99) by SA1P222CA0172.outlook.office365.com
 (2603:10b6:806:3c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 10:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:49:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 03:49:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 03:49:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 10
 Mar 2026 03:48:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Enable mac forwarding on uplink representor
Date: Tue, 10 Mar 2026 12:48:41 +0200
Message-ID: <20260310104841.1862380-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2a79dd-3e09-47b2-8859-08de7e92ad45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	5xh1yVm2+QsBtbBce0rrxd0dt/5aLlpLwDtCoufEgFlAwU7DZSprOhzA/8Rknc04ok1qajd5mwP+ZdWwxtvUwVrU4fSYJ16WpvEWImCNk7xvsmfzvBUsqngdpANJ/B5A0M3lAKWO4KfaZ/nentrXrAXxwSVAXoh+z6Lcj1MM+Umwrt/KJEf4DKipNOQDedVK0wQdoAA13iIzBhm7iaIWCuLuN+dtabGkzDeSBCzIZstzZyzeCnWoq7AMHyyoSfC68hk/MKugkVxc5jmvsd/oMoijYMPF+kF296w0QpQ+USracW2WfO441FP+W0P1KwJ7HEWbZv3V0H0aCnHm4812Qu5mwYVsjzOx6os+slE1PU3iHYQKOMIJVdNHZKLByHMveBihpkKNZqmUnFzX8cw9mjfHRa5xKtr7KsCqtAtjE2o4RrB5zBqOEsNzs/EFm1SSu7fd/MpnRtttAFUYfvdA2BVWvBipTcVAyINfD/xRCEcLZCbqtLKmyslGPqHMfGQBU6jsR8Iju4911MNBwdiWDRirR0lCOgbPB9zpjVo68wYkXg6ePAYQg+rDfVUH0a3x0584GjZnmpVHOYYNPWV16wMXcQmCQAfaFgcVl7VT1xs2Isi82SPI/gVKORQJuO1omc6aii1MOP4xQpfxI/mBh2hGntwLDFHNh0mlEFIEenmuaX2YMKVqhUuWA/fALvRCztHouzdfTTyek6n0iNLUkf7ZRMQKqfafsyOSZ6CpykrMI5j3/A4ff0URDWCWYr3wD1nqAxDLpF+pExOv5fgSMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kYjXhfX/X2G/LikitZsw1kpbxcQt84+bPrdpwg6/ND2ihFaEaG0/AW7+3EyUYDZCI6VRqYqwIsH5g8phoD5pYux888B0PXLNLnEK2A5TlGFnJSei3QdSjFN3wvjkQyjfMj+a7WMoANCFVf22jHqLD4uPRNGq8rdEA/KPFLZccHe1fe+K5oxRQ6VlWWG5F0rsXgVYQLA3E5WfVnUrbEY5dNimPCw1yKo+C3y8OgJNPBHVcAI1UrjenCa20UDzCiS8zqmeC5FKoxDtvAG+dDDzLaO2oT+t3dwceNUHkV4cqo4ez1qDvSRucLVXOOTSG/0CPAR/H5zcSf1Fw5ZnfKrWL6DnMGPXozTyU9J8VpVlcULdb3g2zPJ60pWeqKP2gcYZleLgRvtdcWP+uxA61E2Gf1IdkuD+WnQTbLC3FpuGXY7E5BbDzCHjOccVOcXTqZTU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:49:16.9042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2a79dd-3e09-47b2-8859-08de7e92ad45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741
X-Rspamd-Queue-Id: DADB3249C78
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17864-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Saeed Mahameed <saeedm@nvidia.com>

MAC forwarding and namely 'set_rx_mode' handler, was disabled on uplink
representor as they rely on FDB to forward all traffic to it by default,
which works perfectly on a single PF per physical port configuration.
But, in case of multi-host and DPU environments, uplink was stuck
with its own mac, since MPFs (Multi PF switch) requires PFs to request
explicit mac forwarding.

This small patch enables mac forwarding to MPFs via uplink representor,
by enabling only the mac (uc/mc) list handling logic in
mlx5e_set_rx_mode() handler for uplink representor netdevs.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c   | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  3 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 9352e2183312..d7556d611155 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -823,8 +823,14 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 			       struct net_device *netdev)
 {
+	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_l2_table *ea = &fs->l2;
 
+	if (mlx5e_is_uplink_rep(priv)) {
+		mlx5e_handle_netdev_addr(fs, netdev);
+		goto update_vport_context;
+	}
+
 	bool rx_mode_enable  = fs->state_destroy;
 	bool promisc_enabled   = rx_mode_enable && (netdev->flags & IFF_PROMISC);
 	bool allmulti_enabled  = rx_mode_enable && (netdev->flags & IFF_ALLMULTI);
@@ -864,6 +870,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	ea->allmulti_enabled  = allmulti_enabled;
 	ea->broadcast_enabled = broadcast_enabled;
 
+update_vport_context:
 	mlx5e_vport_context_update(fs, netdev);
 }
 
@@ -984,6 +991,9 @@ static int mlx5e_add_l2_flow_rule(struct mlx5e_flow_steering *fs,
 	u8 *mc_dmac;
 	u8 *mv_dmac;
 
+	if (!ft)
+		return -EINVAL;
+
 	spec = kvzalloc_obj(*spec);
 	if (!spec)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..3eebdf402129 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4102,9 +4102,6 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 {
-	if (mlx5e_is_uplink_rep(priv))
-		return; /* no rx mode for uplink rep */
-
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 1db4ecb2356f..8992f0f7a870 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1369,6 +1369,8 @@ static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
 	netdev_unlock(priv->netdev);
 	rtnl_unlock();
 
+	/* clean-up uplink's mpfs mac table */
+	queue_work(priv->wq, &priv->set_rx_mode_work);
 	mlx5e_rep_bridge_cleanup(priv);
 	mlx5e_dcbnl_delete_app(priv);
 	mlx5_notifier_unregister(mdev, &priv->events_nb);

base-commit: 52ede1bce557c66309f41ac29dd190be23ca9129
-- 
2.44.0


