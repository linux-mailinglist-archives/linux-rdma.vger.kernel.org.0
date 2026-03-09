Return-Path: <linux-rdma+bounces-17763-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G6+FsyVrmnqGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17763-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:41:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B651D2365D1
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA58303FF32
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5F37B413;
	Mon,  9 Mar 2026 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkAan/G2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6C34F48B;
	Mon,  9 Mar 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048974; cv=fail; b=A2/KpFyjo6M6p8mhxs2jOG4OjZQffTlAbPIQ3NoqWsbWx8UWxkzJ5hLcgqvzUbFEFlrq4sdWg3oDUs/py+vEOZkOWKaZ87wn0E5lvq+4+SRtKuigQdj9M9uI9hCTfIJdpuHNM6r6mx7rGJ6kBB6AoWdcMQbBEkvo7zO92U932TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048974; c=relaxed/simple;
	bh=60lmkc64UJdFJh0+3HFfqKCbwPOYvIy3O8qVBZcaZps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN60G2W5F+02Zp6/RI/X4dQ0TYiM9OP0vUEDrLquypV1ti8ety0vhfPz2UBP8+mQledcT0ufCRplRxI6gdaV/dwMnx3PoCm5K28hZyjKHkK51WJOHqNdRGp+Krn8Jz+4/p+Yt+DbYgIuy4IfQ/neAOu/ike8obsGEgpEw8Ef/NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkAan/G2; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq029cdYqRcmeXxQ8WOe8kuajqYi8dKpKH7w5htGXv/WVJOSIFuKisgrIKtKGvqA1kltEyPfa88QcW44L3t9xXJ9CBzh9CvZa2TnwD+QVp9d0tGWjorEZ3uxuarQub8JETBm9GoeSG7H5gC0PpiPiEDO5VRYfYqDGymFwDarQainXuMgey0Wng+9m6kPoMKubhDrMg3CX/P2/LI2J48ueAn70tfxL97OZir40X5/K27WNxaaTdywkNRjD+q+YwsSIDbwHplZWTA6bMIuY0bx7dUUskugxhjauw6WudlqmFkAOAArHkEXFcG/8TgUMzE983yWfm42eEk93G0KFlmP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0wev/o6RCc9soyJD6jGyPnoAMq0oX0w935ZINxMLL4=;
 b=SPBnElFHCs1LizXPgzlPcwzOCh7LgE5GlQRF4zJF59NwNc34fZxQO+TZp5znrfLVoX4pDk13sbhOl51gmf9y56A42TZoqJvSXEgy2eYN8VBYin31RGCLhankWm4pkozCRCK/sGJQzFflde/AAJE0D4CrgupXgdkE3ssWhUpJSlpYyke2bslwVIGN68pDQSzfOhJTUUrKhOq3lE7GOIsDpwBSxQJspqp3qVXFwY+RCI9OlRTmVHR/Nah+oMM6hhUJ2bT7v9wDxmqSjcl7uzEBYIpzSZFCJE9pDBsIDZhQpCy5rypyNctUIubUiP2kdnO/dJgxVkFDEl2OwE66TVLOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0wev/o6RCc9soyJD6jGyPnoAMq0oX0w935ZINxMLL4=;
 b=mkAan/G21Oy/pPbdFKVUM1/ZDfeT9l0jZ9Rbcd+cWsDvnf6Xp+7uKda/kAiHHAMq1l0dQhP2jqxeXMn7QzrxfOLZazIv/GE0FZkvgNaQ5SkZixQnQt0CikltA1oX6kQ42z0DKvSLUT0WNRCSfYnyjD749tS+MnMSbDOyrgAAtp5ksd2PcXjjSj6JKJqIf/0i2C9LDP5nTBxCiNaeih2vIKUA+VTnYD8mlR788d5sRECgLE7pTlLkMvFTZUQE/Aos2X5DdLrwBA+XeLoXo24fCraFn1SHQ72pZz10iB9aAfIlgSwAwWXaybTQT3o3Y1wAeMZa6CoOAlo6S0fs4T3U3Q==
Received: from BYAPR02CA0046.namprd02.prod.outlook.com (2603:10b6:a03:54::23)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:36:03 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::65) by BYAPR02CA0046.outlook.office365.com
 (2603:10b6:a03:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:36:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:35:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:35:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 8/9] {net/RDMA}/mlx5: Add LAG demux table API and vport demux rules
Date: Mon, 9 Mar 2026 11:34:34 +0200
Message-ID: <20260309093435.1850724-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: b884787b-cd4a-4277-2b53-08de7dbf4792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	6ffuKM8tIW2vsNCzP3jDuaTiX5fxnKjh0Mszaqg0OHRQU9zABdne1A6z3xpKq8oMozkm2wY/pdkwP/NrPPZSvjwJurG+S3MBvx2Mellor02DveBo5Dt3KUw/qwFKvq8HgXCMRzxj3gnj9GiUIhMEKcyLHsR7MC81jiCLo9mdfyeJn7DQuq0Hpdbo5XcusU5+2NcRw++Dh6a9d1MXt7Om6zVUrZ0p20dCZnbQB1Rt0uQrXZXOOxsGlRjj+L7VmQ69RM9Fk8Q1LixoC4uIUGjK7JmYYclsbPcuDXLwa3sDyeILkgizGInNBPfFmKh3BxBQypW0iY5bCDet9Y4lTAXrNA0TD5Urg1s+/f4pNBjG3hDVNxK87LDpnFfYe40F4ShsRY8hKRAzkw1QV+D87ka8iqdE6DvP8WwnKGiYb4zZ004NTmje/mpeTcd2rcJpRQFWYOI3jLqZ8ydxwGiPYR1FAOLL1WjBcqgGLVaTfpNqOTWVwuUlxVTMsVOQi88Np9dCHlfn45hgJdJu0FAQF8NhwxumUUGxjeliVhjmuPYlmO1cUNqQQ9cN/T0Uuf+enA4EYaJwYW/KFYXp2uWERBuMkY+4SELN7D764SL7vEfooOYzCMJZbV9qPso86BIvYHBm24wUJ/AfgCL+m0DZr4H5669kD0xOx10lS2lscUB2UatQAwld6Ic38DZaHq46j+nmoXyP6JtnhTL+zkPqUtEkJrsLDAzilRTzS2YZFpHjm2elPCjI5K5jvZpz2mGgTS9XNhl3a5qLhOSpq4Ibhn9geA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gPRKDq7qVpIOAjkHI5ZLx+s7rYdnwVecCYC6AgBoOIm+94OrJlgHLl0YOJucC9u/L9wCYhlbAcD8fOg6YZYyM8xgi5tpYRbKNRsM2wXCjJqSESyt2U10t7BUHCHejO5+XIEjjrbTJQIicQGVhM0xoZZ+KuIr+qCYw4+8vfAwyOuIyD3d+yPhdm48QRAlYmj7qXSbVgaHr7EhnsXsaeKPwZMUagMLBdpaw0dX/s9RKNV6ldqZuLdx7EIiRTV3/7iSUFOz+yZR7k3jodv2CM/VE74X1j4W84+C9uzSzO+vXU41vFAx87ua0wX4wbraSNpHpQjUevhY69uEg3j8gXTBnLZ2JmvPzn/QmZF8MQwxjZqnyiedEHcLD7Enr/3WHe9ZyW5EsP1aHG41uqtFMD4Aav1uzmqckkBo1obkSCNkmcgaIT8rynahOjvmVBMUVAm5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:36:02.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b884787b-cd4a-4277-2b53-08de7dbf4792
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
X-Rspamd-Queue-Id: B651D2365D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17763-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Downstream patches will introduce SW-only LAG (e.g. shared_fdb without
HW LAG). In this mode the firmware cannot create the LAG demux table,
but vport demuxing is still required.

Move LAG demux flow-table ownership to the LAG layer and introduce APIs
to init/cleanup the demux table and add/delete per-vport rules. Adjust
the RDMA driver to use the new APIs.

In this mode, the LAG layer will create a flow group that matches vport
metadata. Vports that are not native to the LAG master eswitch add the
demux rule during IB representor load and remove it on unload.
The demux rule forward traffic from said vports to their native eswitch
manager via a new dest type - MLX5_FLOW_DESTINATION_TYPE_VHCA_RX.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c           |  20 ++-
 drivers/infiniband/hw/mlx5/main.c             |  21 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   1 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  12 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  83 +++++++++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  10 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 152 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  12 ++
 include/linux/mlx5/fs.h                       |   6 +-
 include/linux/mlx5/lag.h                      |  10 ++
 10 files changed, 300 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index df8f049c5806..1709b628702e 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -10,11 +10,13 @@
 
 static int
 mlx5_ib_set_vport_rep(struct mlx5_core_dev *dev,
+		      struct mlx5_core_dev *rep_dev,
 		      struct mlx5_eswitch_rep *rep,
 		      int vport_index)
 {
 	struct mlx5_ib_dev *ibdev;
 	struct net_device *ndev;
+	int ret;
 
 	ibdev = mlx5_eswitch_uplink_get_proto_dev(dev->priv.eswitch, REP_IB);
 	if (!ibdev)
@@ -24,7 +26,17 @@ mlx5_ib_set_vport_rep(struct mlx5_core_dev *dev,
 	rep->rep_data[REP_IB].priv = ibdev;
 	ndev = mlx5_ib_get_rep_netdev(rep->esw, rep->vport);
 
-	return ib_device_set_netdev(&ibdev->ib_dev, ndev, vport_index + 1);
+	ret = ib_device_set_netdev(&ibdev->ib_dev, ndev, vport_index + 1);
+	if (ret)
+		return ret;
+
+	/* Only Vports that are not native to the LAG master eswitch need to add
+	 * demux rule.
+	 */
+	if (mlx5_eswitch_get_total_vports(dev) > vport_index)
+		return 0;
+
+	return mlx5_lag_demux_rule_add(rep_dev, rep->vport, vport_index);
 }
 
 static void mlx5_ib_register_peer_vport_reps(struct mlx5_core_dev *mdev);
@@ -131,7 +143,7 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 
 				if (mlx5_lag_is_master(peer_dev))
 					lag_master = peer_dev;
-				else if (!mlx5_lag_is_mpesw(dev))
+				else if (!mlx5_lag_is_mpesw(peer_dev))
 				/* Only 1 ib port is the representor for all uplinks */
 					peer_n_ports--;
 
@@ -145,7 +157,7 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	if (rep->vport == MLX5_VPORT_UPLINK && !new_uplink)
 		profile = &raw_eth_profile;
 	else
-		return mlx5_ib_set_vport_rep(lag_master, rep, vport_index);
+		return mlx5_ib_set_vport_rep(lag_master, dev, rep, vport_index);
 
 	if (mlx5_lag_is_shared_fdb(dev)) {
 		ret = mlx5_ib_take_transport(lag_master);
@@ -233,6 +245,8 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 		vport_index = i;
 	}
 
+	mlx5_lag_demux_rule_del(mdev, vport_index);
+
 	port = &dev->port[vport_index];
 
 	ib_device_set_netdev(&dev->ib_dev, NULL, vport_index + 1);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..9fb0629978bd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -26,6 +26,7 @@
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/driver.h>
+#include <linux/mlx5/lag.h>
 #include <linux/list.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem_odp.h>
@@ -3678,12 +3679,12 @@ static void mlx5e_lag_event_unregister(struct mlx5_ib_dev *dev)
 
 static int mlx5_eth_lag_init(struct mlx5_ib_dev *dev)
 {
+	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_flow_namespace *ns = mlx5_get_flow_namespace(mdev,
-								 MLX5_FLOW_NAMESPACE_LAG);
-	struct mlx5_flow_table *ft;
+	struct mlx5_flow_namespace *ns;
 	int err;
 
+	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_LAG);
 	if (!ns || !mlx5_lag_is_active(mdev))
 		return 0;
 
@@ -3691,14 +3692,15 @@ static int mlx5_eth_lag_init(struct mlx5_ib_dev *dev)
 	if (err)
 		return err;
 
-	ft = mlx5_create_lag_demux_flow_table(ns, 0, 0);
-	if (IS_ERR(ft)) {
-		err = PTR_ERR(ft);
+	ft_attr.level = 0;
+	ft_attr.prio = 0;
+	ft_attr.max_fte = dev->num_ports;
+
+	err = mlx5_lag_demux_init(mdev, &ft_attr);
+	if (err)
 		goto err_destroy_vport_lag;
-	}
 
 	mlx5e_lag_event_register(dev);
-	dev->flow_db->lag_demux_ft = ft;
 	dev->lag_ports = mlx5_lag_get_num_ports(mdev);
 	dev->lag_active = true;
 	return 0;
@@ -3716,8 +3718,7 @@ static void mlx5_eth_lag_cleanup(struct mlx5_ib_dev *dev)
 		dev->lag_active = false;
 
 		mlx5e_lag_event_unregister(dev);
-		mlx5_destroy_flow_table(dev->flow_db->lag_demux_ft);
-		dev->flow_db->lag_demux_ft = NULL;
+		mlx5_lag_demux_cleanup(mdev);
 
 		mlx5_cmd_destroy_vport_lag(mdev);
 	}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4f4114d95130..3fc31415e107 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -306,7 +306,6 @@ struct mlx5_ib_flow_db {
 	struct mlx5_ib_flow_prio	rdma_rx[MLX5_IB_NUM_FLOW_FT];
 	struct mlx5_ib_flow_prio	rdma_tx[MLX5_IB_NUM_FLOW_FT];
 	struct mlx5_ib_flow_prio	opfcs[MLX5_IB_OPCOUNTER_MAX];
-	struct mlx5_flow_table		*lag_demux_ft;
 	struct mlx5_ib_flow_prio        *rdma_transport_rx[MLX5_RDMA_TRANSPORT_BYPASS_PRIO];
 	struct mlx5_ib_flow_prio        *rdma_transport_tx[MLX5_RDMA_TRANSPORT_BYPASS_PRIO];
 	/* Protect flow steering bypass flow tables
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 96309a732d50..9b729789537f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -940,6 +940,12 @@ int mlx5_esw_ipsec_vf_packet_offload_supported(struct mlx5_core_dev *dev,
 					       u16 vport_num);
 bool mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev);
 void mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev);
+struct mlx5_flow_group *
+mlx5_esw_lag_demux_fg_create(struct mlx5_eswitch *esw,
+			     struct mlx5_flow_table *ft);
+struct mlx5_flow_handle *
+mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
+			       struct mlx5_flow_table *lag_ft);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
@@ -1025,6 +1031,12 @@ mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 
 static inline void
 mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev) {}
+static inline struct mlx5_flow_handle *
+mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
+			       struct mlx5_flow_table *lag_ft)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 
 #endif /* CONFIG_MLX5_ESWITCH */
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 90e6f97bdf4a..f98837470f39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1459,6 +1459,83 @@ esw_add_restore_rule(struct mlx5_eswitch *esw, u32 tag)
 	return flow_rule;
 }
 
+struct mlx5_flow_group *
+mlx5_esw_lag_demux_fg_create(struct mlx5_eswitch *esw,
+			     struct mlx5_flow_table *ft)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_group *fg;
+	void *match_criteria;
+	void *flow_group_in;
+
+	if (!mlx5_eswitch_vport_match_metadata_enabled(esw))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (IS_ERR(ft))
+		return ERR_CAST(ft);
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return ERR_PTR(-ENOMEM);
+
+	match_criteria = MLX5_ADDR_OF(create_flow_group_in, flow_group_in,
+				      match_criteria);
+	MLX5_SET(create_flow_group_in, flow_group_in, match_criteria_enable,
+		 MLX5_MATCH_MISC_PARAMETERS_2);
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, 0);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index,
+		 ft->max_fte - 1);
+
+	MLX5_SET(fte_match_param, match_criteria,
+		 misc_parameters_2.metadata_reg_c_0,
+		 mlx5_eswitch_get_vport_metadata_mask());
+
+	fg = mlx5_create_flow_group(ft, flow_group_in);
+	kvfree(flow_group_in);
+	if (IS_ERR(fg))
+		esw_warn(esw->dev, "Can't create LAG demux flow group\n");
+
+	return fg;
+}
+
+struct mlx5_flow_handle *
+mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
+			       struct mlx5_flow_table *lag_ft)
+{
+	struct mlx5_flow_spec *spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *ret;
+	void *misc;
+
+	if (!spec)
+		return ERR_PTR(-ENOMEM);
+
+	if (!mlx5_eswitch_vport_match_metadata_enabled(esw)) {
+		kvfree(spec);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	misc = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+			    misc_parameters_2);
+	MLX5_SET(fte_match_set_misc2, misc, metadata_reg_c_0,
+		 mlx5_eswitch_get_vport_metadata_mask());
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+
+	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value,
+			    misc_parameters_2);
+	MLX5_SET(fte_match_set_misc2, misc, metadata_reg_c_0,
+		 mlx5_eswitch_get_vport_metadata_for_match(esw, vport_num));
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_VHCA_RX;
+	dest.vhca.id = MLX5_CAP_GEN(esw->dev, vhca_id);
+
+	ret = mlx5_add_flow_rules(lag_ft, spec, &flow_act, &dest, 1);
+	kvfree(spec);
+	return ret;
+}
+
 #define MAX_PF_SQ 256
 #define MAX_SQ_NVPORTS 32
 
@@ -2047,7 +2124,8 @@ static int esw_create_vport_rx_group(struct mlx5_eswitch *esw)
 
 	if (IS_ERR(g)) {
 		err = PTR_ERR(g);
-		mlx5_core_warn(esw->dev, "Failed to create vport rx group err %d\n", err);
+		esw_warn(esw->dev, "Failed to create vport rx group err %d\n",
+			 err);
 		goto out;
 	}
 
@@ -2092,7 +2170,8 @@ static int esw_create_vport_rx_drop_group(struct mlx5_eswitch *esw)
 
 	if (IS_ERR(g)) {
 		err = PTR_ERR(g);
-		mlx5_core_warn(esw->dev, "Failed to create vport rx drop group err %d\n", err);
+		esw_warn(esw->dev,
+			 "Failed to create vport rx drop group err %d\n", err);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 003d211306a7..61a6ba1e49dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1438,15 +1438,9 @@ mlx5_create_vport_flow_table(struct mlx5_flow_namespace *ns,
 
 struct mlx5_flow_table*
 mlx5_create_lag_demux_flow_table(struct mlx5_flow_namespace *ns,
-				 int prio, u32 level)
+				 struct mlx5_flow_table_attr *ft_attr)
 {
-	struct mlx5_flow_table_attr ft_attr = {};
-
-	ft_attr.level = level;
-	ft_attr.prio  = prio;
-	ft_attr.max_fte = 1;
-
-	return __mlx5_create_flow_table(ns, &ft_attr, FS_FT_OP_MOD_LAG_DEMUX, 0);
+	return __mlx5_create_flow_table(ns, ft_attr, FS_FT_OP_MOD_LAG_DEMUX, 0);
 }
 EXPORT_SYMBOL(mlx5_create_lag_demux_flow_table);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 51ec8f61ecbb..449e4bd86c06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1471,6 +1471,158 @@ struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
 	return devcom;
 }
 
+static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
+				     struct mlx5_flow_table_attr *ft_attr,
+				     struct mlx5_lag *ldev)
+{
+#ifdef CONFIG_MLX5_ESWITCH
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_group *fg;
+	int err;
+
+	ns = mlx5_get_flow_namespace(dev, MLX5_FLOW_NAMESPACE_LAG);
+	if (!ns)
+		return 0;
+
+	ldev->lag_demux_ft = mlx5_create_flow_table(ns, ft_attr);
+	if (IS_ERR(ldev->lag_demux_ft))
+		return PTR_ERR(ldev->lag_demux_ft);
+
+	fg = mlx5_esw_lag_demux_fg_create(dev->priv.eswitch,
+					  ldev->lag_demux_ft);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		mlx5_destroy_flow_table(ldev->lag_demux_ft);
+		ldev->lag_demux_ft = NULL;
+		return err;
+	}
+
+	ldev->lag_demux_fg = fg;
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int mlx5_lag_demux_fw_init(struct mlx5_core_dev *dev,
+				  struct mlx5_flow_table_attr *ft_attr,
+				  struct mlx5_lag *ldev)
+{
+	struct mlx5_flow_namespace *ns;
+	int err;
+
+	ns = mlx5_get_flow_namespace(dev, MLX5_FLOW_NAMESPACE_LAG);
+	if (!ns)
+		return 0;
+
+	ldev->lag_demux_fg = NULL;
+	ft_attr->max_fte = 1;
+	ldev->lag_demux_ft = mlx5_create_lag_demux_flow_table(ns, ft_attr);
+	if (IS_ERR(ldev->lag_demux_ft)) {
+		err = PTR_ERR(ldev->lag_demux_ft);
+		ldev->lag_demux_ft = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
+			struct mlx5_flow_table_attr *ft_attr)
+{
+	struct mlx5_lag *ldev;
+
+	if (!ft_attr)
+		return -EINVAL;
+
+	ldev = mlx5_lag_dev(dev);
+	if (!ldev)
+		return -ENODEV;
+
+	xa_init(&ldev->lag_demux_rules);
+
+	if (mlx5_get_sd(dev))
+		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, ldev);
+
+	return mlx5_lag_demux_fw_init(dev, ft_attr, ldev);
+}
+EXPORT_SYMBOL(mlx5_lag_demux_init);
+
+void mlx5_lag_demux_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_flow_handle *rule;
+	struct mlx5_lag *ldev;
+	unsigned long vport_num;
+
+	ldev = mlx5_lag_dev(dev);
+	if (!ldev)
+		return;
+
+	xa_for_each(&ldev->lag_demux_rules, vport_num, rule)
+		mlx5_del_flow_rules(rule);
+	xa_destroy(&ldev->lag_demux_rules);
+
+	if (ldev->lag_demux_fg)
+		mlx5_destroy_flow_group(ldev->lag_demux_fg);
+	if (ldev->lag_demux_ft)
+		mlx5_destroy_flow_table(ldev->lag_demux_ft);
+	ldev->lag_demux_fg = NULL;
+	ldev->lag_demux_ft = NULL;
+}
+EXPORT_SYMBOL(mlx5_lag_demux_cleanup);
+
+int mlx5_lag_demux_rule_add(struct mlx5_core_dev *vport_dev, u16 vport_num,
+			    int index)
+{
+	struct mlx5_flow_handle *rule;
+	struct mlx5_lag *ldev;
+	int err;
+
+	ldev = mlx5_lag_dev(vport_dev);
+	if (!ldev || !ldev->lag_demux_fg)
+		return 0;
+
+	if (xa_load(&ldev->lag_demux_rules, index))
+		return 0;
+
+	rule = mlx5_esw_lag_demux_rule_create(vport_dev->priv.eswitch,
+					      vport_num, ldev->lag_demux_ft);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_warn(vport_dev,
+			       "Failed to create LAG demux rule for vport %u, err %d\n",
+			       vport_num, err);
+		return err;
+	}
+
+	err = xa_err(xa_store(&ldev->lag_demux_rules, index, rule,
+			      GFP_KERNEL));
+	if (err) {
+		mlx5_del_flow_rules(rule);
+		mlx5_core_warn(vport_dev,
+			       "Failed to store LAG demux rule for vport %u, err %d\n",
+			       vport_num, err);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mlx5_lag_demux_rule_add);
+
+void mlx5_lag_demux_rule_del(struct mlx5_core_dev *dev, int index)
+{
+	struct mlx5_flow_handle *rule;
+	struct mlx5_lag *ldev;
+
+	ldev = mlx5_lag_dev(dev);
+	if (!ldev || !ldev->lag_demux_fg)
+		return;
+
+	rule = xa_erase(&ldev->lag_demux_rules, index);
+	if (rule)
+		mlx5_del_flow_rules(rule);
+}
+EXPORT_SYMBOL(mlx5_lag_demux_rule_del);
+
 static void mlx5_queue_bond_work(struct mlx5_lag *ldev, unsigned long delay)
 {
 	queue_delayed_work(ldev->wq, &ldev->bond_work, delay);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 30cbd61768f8..6c911374f409 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -5,6 +5,9 @@
 #define __MLX5_LAG_H__
 
 #include <linux/debugfs.h>
+#include <linux/errno.h>
+#include <linux/xarray.h>
+#include <linux/mlx5/fs.h>
 
 #define MLX5_LAG_MAX_HASH_BUCKETS 16
 /* XArray mark for the LAG master device
@@ -83,6 +86,9 @@ struct mlx5_lag {
 	/* Protect lag fields/state changes */
 	struct mutex		  lock;
 	struct lag_mpesw	  lag_mpesw;
+	struct mlx5_flow_table   *lag_demux_ft;
+	struct mlx5_flow_group   *lag_demux_fg;
+	struct xarray		  lag_demux_rules;
 };
 
 static inline struct mlx5_lag *
@@ -133,6 +139,12 @@ mlx5_lag_is_ready(struct mlx5_lag *ldev)
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev);
+int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
+			struct mlx5_flow_table_attr *ft_attr);
+void mlx5_lag_demux_cleanup(struct mlx5_core_dev *dev);
+int mlx5_lag_demux_rule_add(struct mlx5_core_dev *dev, u16 vport_num,
+			    int vport_index);
+void mlx5_lag_demux_rule_del(struct mlx5_core_dev *dev, int vport_index);
 void mlx5_modify_lag(struct mlx5_lag *ldev,
 		     struct lag_tracker *tracker);
 int mlx5_activate_lag(struct mlx5_lag *ldev,
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 02064424e868..d8f3b7ef319e 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -252,9 +252,9 @@ mlx5_create_auto_grouped_flow_table(struct mlx5_flow_namespace *ns,
 struct mlx5_flow_table *
 mlx5_create_vport_flow_table(struct mlx5_flow_namespace *ns,
 			     struct mlx5_flow_table_attr *ft_attr, u16 vport);
-struct mlx5_flow_table *mlx5_create_lag_demux_flow_table(
-					       struct mlx5_flow_namespace *ns,
-					       int prio, u32 level);
+struct mlx5_flow_table *
+mlx5_create_lag_demux_flow_table(struct mlx5_flow_namespace *ns,
+				 struct mlx5_flow_table_attr *ft_attr);
 int mlx5_destroy_flow_table(struct mlx5_flow_table *ft);
 
 /* inbox should be set with the following values:
diff --git a/include/linux/mlx5/lag.h b/include/linux/mlx5/lag.h
index d370dfd19055..ab9f754664e5 100644
--- a/include/linux/mlx5/lag.h
+++ b/include/linux/mlx5/lag.h
@@ -4,8 +4,18 @@
 #ifndef __MLX5_LAG_API_H__
 #define __MLX5_LAG_API_H__
 
+#include <linux/types.h>
+
 struct mlx5_core_dev;
+struct mlx5_flow_table;
+struct mlx5_flow_table_attr;
 
+int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
+			struct mlx5_flow_table_attr *ft_attr);
+void mlx5_lag_demux_cleanup(struct mlx5_core_dev *dev);
+int mlx5_lag_demux_rule_add(struct mlx5_core_dev *dev, u16 vport_num,
+			    int vport_index);
+void mlx5_lag_demux_rule_del(struct mlx5_core_dev *dev, int vport_index);
 int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev);
 
 #endif /* __MLX5_LAG_API_H__ */
-- 
2.44.0


