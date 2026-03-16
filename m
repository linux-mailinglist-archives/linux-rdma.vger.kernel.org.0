Return-Path: <linux-rdma+bounces-18173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLQXEPLSt2n0VgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:52:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA582976D5
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9557E30471E3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AA390C88;
	Mon, 16 Mar 2026 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GKbcmwCd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC133ADA2;
	Mon, 16 Mar 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654417; cv=fail; b=k3GiNzFXSu1IkL6wZwyiQFAhT5ZQsSgwL2uiD76NtUht8cxLgHWmPsdGq+/tM/3c+32TBJ8WcihqwnB3pZ0orTR099C6eco6z38rZywYiKwNyJZM6WCLDgwu5Li0ZkTtORErpSQ9FSY6qDfW8lIUBtnLnzgtV2ETk6w9FglVey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654417; c=relaxed/simple;
	bh=OsGlWM+KTdCOlkPZeXuUTymjBJd9IZ3xTdWJUxkaSEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIjQzvdtuDLu7ZH/SPtLL7fNLvF0sxfWyEe3E8w7A9CHoE5z7qY8T8nA+/Cp1bVWsMMemHyFEMfJ6WEkRTa/f2OwQuDqdPkVtVKLCsMnOc6MmwRUFT7Oo1SX34vQXpAH1OadhZ77Djupu1migNzU6x0szo62HZnsCgb5kYvGQ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GKbcmwCd; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6tuUjAKpxJxt7Tg8oAMdNEeBuLa005K2MXL3k2r4CeQT+N79UkG0f6QvMyNdItpPSvEdB6rRssWR4I9IGCCevcTruPg+2oggOIwDmhHErzId44ewaK7lbcxwj26fTQ3M0dnaMoB1HfH94T9PGrJNwR1l6jMSKSP0LNVei+yN7HOzsHjuSXWHQzxkZmrXETY5b8qetK0yOnz2sc1lN+EYT1oyheRzb1shzGtPKcgbSM7e8MUIy/I8OtMTBfisrUvH0AHIPWtCcrV/NGXJyS3hyCHSJYAuhxKikc5NZYLJY6AbGAVJJBzvybWqZK5tyLiYQXa5hRHBvEaztV464ijyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lszy+c6X0vSPb7QJ6T6eYV9DU4o0qYO1OGkxobr9Qt0=;
 b=KQDo9DXTuJB5niSo++H1q5yRqlVhuxXAa16E9YN1VzAz+o6gKYBjhuPTus1cEtjkhtimGWcmPaPb27c3VLJ33j3YJ+gMyvP5zsqtj5UA3l16VpuTpsyHaSvdMxIlHMT7gRDhOq4ECxyiVN/w7ZczKj3xIun/clsPM6SHeEh95haavWFFK+mo3hMyxCgTTB/UZx5KQ1LvuidTFfweCpKInqembZupMGEPUzOQUNPyJVtKv2cYpTq71JlhWVbkzhj5RW0OHdR12AzTfc+h1UgRVGOl0Wx5fPRCX7IiY6/TA3TBqOSdX0YWQWXYXE+fhN+FZQyqI8ACPSz4MtgkX2LD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lszy+c6X0vSPb7QJ6T6eYV9DU4o0qYO1OGkxobr9Qt0=;
 b=GKbcmwCd9weXNSRpJ/oITA4Q2BWQ6EYUyOOBLFE1pNjqTC7Vctz1V1XzZYtTp/KfhqzN41SaxFdfOihCg6xYnCFGyNHKaGiORdNM+jiI6JKmZN74Oppvck+zRjLasysNxAGe5KXQbM0K+BsBNgpmuCtkCAG65M+qtizjhvRaqNX6RT/kKNQv/trAL3++GgFesqG2xbmMnzeMOSEAAAog4PpjXc90BCttn4NDGV1bLFX/gVTfJHiUaGcykstsdVok0z5TpI/PYUmuYLcIzrnyQIpOqS0rrKCTvZopPo+5c9QhuImGyH9evNjY5X40qI4j3L2xqsZBfocafOnmOYAB7g==
Received: from BN9PR03CA0730.namprd03.prod.outlook.com (2603:10b6:408:110::15)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 09:46:51 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::e1) by BN9PR03CA0730.outlook.office365.com
 (2603:10b6:408:110::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 09:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Mon, 16 Mar 2026 09:46:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 02:46:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 02:46:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 02:46:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: qos: Restrict RTNL area to avoid a lock cycle
Date: Mon, 16 Mar 2026 11:46:01 +0200
Message-ID: <20260316094603.6999-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260316094603.6999-1-tariqt@nvidia.com>
References: <20260316094603.6999-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe7e4a6-f6cb-4520-dde9-08de8340f2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rBmGG7rQBMqj+fk3kgK6EWbI5fE+L9L0EOk1q5N+P8a5ozqzJsKobV1V29Z9vuR1ZUAoDOlWwIrFIke+GpxuzLUxbvP5ggtbLs0zu40w9oa0qRVfAUiXaH+jhjSQanD5rE6ltsrwcn8iicsQud6HhioBIrIPLY2YEsJ8krOqhkeeVH/Yt0BDyTV8OBYdLPTsgDAR1XuINGR/7X9lTK7LtUDy+FSWJvxdNzvUfEc7XE4elmtX9T3ZIsjYC/QSKkRvkfWnAuAg6w9sHnT9PJDX6JGVmnXPhUFbUJKV+uqrdi2Eyd1u4NLtk0UyARFJqXuPYgyi9XnTOrDb/RXczXD8SVl/1y/yo4tG/ugcWnVJlcL870jqgxdMB+XZ0ejJ03U2gfPhyaNcAtwhSJyxGAanlqKrGRFt6o9t8mnkKmHVqveKyewAzfh+vXhBgwDwoXInaH9PSF/zq9UwWUrVyQp+WRyCKDIJuIrAkEYOe25HfGdM1M0rGzDmlnUAf4ag4H5oYI2HhKNaH/n4higDPvafzd8n5/l7182+3/rpVz1t5WOrjCXOQZ9Amgrsa5D70BWMAb0C7Y7Ju90DoQb6Zzfm+f4aqYa3BhJP+a6rgFBROkQuR5mJpR1s82FVUMDe0Lm5TZgTePOBSCp/C8+hfpLD1QnqmqinZMSu3GG7/mSSdOsx1x+vP1sicNnyosfDj4v4i5s0o6Niut6dwbbAOMTLrio6A7McNHC7hfTtMp+kBlyWcotlasJqcFHpqDecuTg5LMmu38GNAkz0ouXTdt7dWw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rka54KdIG7Ws0zZGWs+uGHvNhsI6+d5HyfKAVY4FCN72y83u2ahp21h3IiM4MzqgDGV/psxbd1wk2Ku4p1snkMd6GW1u+M26sC351uomc6OCS72uEv/24WpOOQCP9+SzNUe5OmERNIT2NpLjsEIjjhaKm0f0kKNkR/nbXrvNguEGISEw5FQ2CcfvL3ELViIM4k9YU5OkRAE6DfBdQbia/wIUDoJBCu3Nlo23naMfVJZ6rFPtnLKISKe35d1WvmGtApDw5eMs8m1bU1SpEmEgE373e7qFGsTQSuZq0/0TtoBt2sj3m+W5WVBD1jnBT1HW4VauhQ0JTrXZlxKA0hhZKFsfaDl65MEUNvQmkexSX1dWd7uY2MSMJAbtxoSOH78IB9FZerj9QoeILOmbqY2uTXF+7N2jTdRDFMZmGh3bmY8kXiJFe6eubqnOmaV48wyz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:46:50.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe7e4a6-f6cb-4520-dde9-08de8340f2d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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
	TAGGED_FROM(0.00)[bounces-18173-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1EA582976D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

A lock dependency cycle exists where:
1. mlx5_ib_roce_init -> mlx5_core_uplink_netdev_event_replay ->
mlx5_blocking_notifier_call_chain (takes notifier_rwsem) ->
mlx5e_mdev_notifier_event -> mlx5_netdev_notifier_register ->
register_netdevice_notifier_dev_net (takes rtnl)
=> notifier_rwsem -> rtnl

2. mlx5e_probe -> _mlx5e_probe ->
mlx5_core_uplink_netdev_set (takes uplink_netdev_lock) ->
mlx5_blocking_notifier_call_chain (takes notifier_rwsem)
=> uplink_netdev_lock -> notifier_rwsem

3: devlink_nl_rate_set_doit -> devlink_nl_rate_set ->
mlx5_esw_devlink_rate_leaf_tx_max_set -> esw_qos_devlink_rate_to_mbps ->
mlx5_esw_qos_max_link_speed_get (takes rtnl) ->
mlx5_esw_qos_lag_link_speed_get_locked ->
mlx5_uplink_netdev_get (takes uplink_netdev_lock)
=> rtnl -> uplink_netdev_lock
=> BOOM! (lock cycle)

Fix that by restricting the rtnl-protected section to just the necessary
part, the call to netdev_master_upper_dev_get and speed querying, so
that the last lock dependency is avoided and the cycle doesn't close.
This is safe because mlx5_uplink_netdev_get uses netdev_hold to keep the
uplink netdev alive while its master device is queried.

Use this opportunity to rename the ambiguously-named "hold_rtnl_lock"
argument to "take_rtnl" and remove the "_locked" suffix from
mlx5_esw_qos_lag_link_speed_get_locked.

Fixes: 6b4be64fd9fe ("net/mlx5e: Harden uplink netdev access against device unbind")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 26178d0bac92..faccc60fc93a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1489,24 +1489,24 @@ static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
 	return err;
 }
 
-static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
+static u32 mlx5_esw_qos_lag_link_speed_get(struct mlx5_core_dev *mdev,
+					   bool take_rtnl)
 {
 	struct ethtool_link_ksettings lksettings;
 	struct net_device *slave, *master;
 	u32 speed = SPEED_UNKNOWN;
 
-	/* Lock ensures a stable reference to master and slave netdevice
-	 * while port speed of master is queried.
-	 */
-	ASSERT_RTNL();
-
 	slave = mlx5_uplink_netdev_get(mdev);
 	if (!slave)
 		goto out;
 
+	if (take_rtnl)
+		rtnl_lock();
 	master = netdev_master_upper_dev_get(slave);
 	if (master && !__ethtool_get_link_ksettings(master, &lksettings))
 		speed = lksettings.base.speed;
+	if (take_rtnl)
+		rtnl_unlock();
 
 out:
 	mlx5_uplink_netdev_put(mdev, slave);
@@ -1514,20 +1514,15 @@ static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 }
 
 static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
-					   bool hold_rtnl_lock, struct netlink_ext_ack *extack)
+					   bool take_rtnl,
+					   struct netlink_ext_ack *extack)
 {
 	int err;
 
 	if (!mlx5_lag_is_active(mdev))
 		goto skip_lag;
 
-	if (hold_rtnl_lock)
-		rtnl_lock();
-
-	*link_speed_max = mlx5_esw_qos_lag_link_speed_get_locked(mdev);
-
-	if (hold_rtnl_lock)
-		rtnl_unlock();
+	*link_speed_max = mlx5_esw_qos_lag_link_speed_get(mdev, take_rtnl);
 
 	if (*link_speed_max != (u32)SPEED_UNKNOWN)
 		return 0;
-- 
2.44.0


