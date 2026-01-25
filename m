Return-Path: <linux-rdma+bounces-15976-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PzaJwQBdmmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15976-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:39:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399768062F
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B8230670BA
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE43242D5;
	Sun, 25 Jan 2026 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qY9oOWZh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124331DDBB;
	Sun, 25 Jan 2026 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340844; cv=fail; b=Ha5GAIpv9uF4jkWd2FG8Eq6RbB9yFrqIqQqFdEFbJzJyDn1+XwY7ic7MAaXyfNse0JERvNx2zVy0fZjd9jhiMij73nwI8vBzyEVUpHYfBtGLL+4sXNnu/jyhBLYfJlbDx78fyqOZsvix93snb4+GD+R1RZjbSKArZkEpemb06ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340844; c=relaxed/simple;
	bh=BroX3II/tEOf6iM9tpnbFqGuhumx+EiPNodqpespYtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBbY2KBb6prj0yXWnVx2egHlgqvmhKnj/Yka+eqVqDXQQH03OL+jZd0REzO0sN7zgeRDYe+GanJ8Wf/4EMqw0AhTA3fe9vRxEJrvKXITCwqCQ77DHm/N8pawA3wpNaUV0GGHdmeEjhBR2jJb2btmSdEBhntU7xPooFF8XoBa7rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qY9oOWZh; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj5Aw/HECtWHxe8dtolRyBPEfPP8khAfs6LOzzmQUU/T3i3sfkfpoLJwrdG1mC9ZE6qGW/K6fmYZYQfs/Qx7hjdHp8idKDkxSkV59tvJCgwJZfnFLketBAugfwp6GtO+4fR8DbaeQjF78pPdLMdGFF0HNaFOpW6Rm8BLAvQvRQQM5XB+Q5MJtQ4o6q+LEnDaTZfzPY0Z4LhkXBEZ6v0Zt4psvt4TvK/wpYpYMruhpLSPQTRUbcF5uiOljUYRAxUMzcsfmEtIl3dMcYVwNy7HAiJi/dxP7XVAzCIktj8Bc+Rbi7krT1tky3Mi/jR4QeWUBsdqF3w6O9K4U4dOe/rPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AceF3QBnkw7/F8E3GDlLILlWsc3XeeYDg0evUwTlIBw=;
 b=mcZi08hN9RTtRIq6dZ8LIp0ZpLlPXW2XmilltLS0dDLdpuj2FS6UJU72prFe/wVMD8j2B+3+/kV4Cr2HB9eIN+PC6fu63fD4U1HJIguUeJ3xQWC+8Jr1LDyki3ZB6Axu/hKWbgtXoEigSr4KSUX+pYApc9bmBJabpF53Ys9PDfQwsyRIdbOkMW/USbQSHPjREsD8GIrn6HvpbhT1uSoANntZ+rtanXbYMMCKQFI81IWiqoUsvlQssFeab/Infydw2snFvECfVCBh7rRsQ4Qxlr9SwcrkFa4NnQDoeAtJOMl5PaHmjQUPmvroA1JuLX0t6hp4LVDwUDzPHh+Ogl2wTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AceF3QBnkw7/F8E3GDlLILlWsc3XeeYDg0evUwTlIBw=;
 b=qY9oOWZhpZwTliu7LCC//9ayw7xSGZh1Mx2awjiFE6o36bTeJY5ZNMlS3i8pORYyus1Q+OH/bdpP7GZd4wtrZgbVIbHKRl7djgOECgohvu/R/B/n18p1UOYTqti0ThSs8Mf4krcT1Iwz2v1srFlq0H3+oHjSROwAVPJrdj1FDoRj5wY3lYH7da91dZEre/aDvJWsN7SxDfxs2BObCFUGUcOMN410cqdggBInMu4DWm/PJwWi9oqk5x8ZVvBfMHb38FpaStBbnwTskPp4veiHQ4xYLMnpw89uyO88AxMjRSjQPs1qBf9K8qHwZ9Zpf4RS1lEuCYhHCAZwDdMWv3R7YQ==
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 11:33:58 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::41) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Sun, 25 Jan 2026 11:33:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V6 11/14] net/mlx5: Expose a function to clear a vport's parent
Date: Sun, 25 Jan 2026 13:32:00 +0200
Message-ID: <1769340723-14199-12-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2c2255-c992-44a4-acfb-08de5c05a0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1AJgvok2/7CHFszpTA/A/qVJsleR94nxUsK5LWfMZUC5RPd8tpHJiDC6Ted?=
 =?us-ascii?Q?Hi+WXSswkNkULJ5rMHn5Y6EzZc9vtLqtJ+jogCwx8Y/g6lHpDXMMbSuwBqq6?=
 =?us-ascii?Q?g9aiVeA3/UUQsX6ghFo23H7an0IbWaNG6Aerk6EBPiChrYxdc6wtoJmL8GXr?=
 =?us-ascii?Q?sxH2zWU0Op1xqYK1Gc7Dy001m3BAsfwhW0eSYcmPAYplLhQDBTV/TxvnXbYz?=
 =?us-ascii?Q?DBgTe9uYS0Fs4PBkDQBOuc3xkqQFcqjXMbdvYdkugVU0dhrquPFBGtCT1c2z?=
 =?us-ascii?Q?FQR5xH2ucdOj9+MT5JTvn95IOUuezHN193T5RfyKwSV+EYum/ibM+rQC1b0R?=
 =?us-ascii?Q?jKDfcBFA+yQzhr6q3R1+cwmS5Tibnk59ZAAid9kqD7sJ38SInifgYD2kw6uD?=
 =?us-ascii?Q?XVyVVXSC5ZxzGEW/wrM+teOCR67lLqXDt+VDxzzma+bSJN+lo3oiyf58KOT1?=
 =?us-ascii?Q?NA9cs+dsOP6hONtw4AfzZbEek8i6nBu2uRHXm5ojy4x2zOQwhGLpozmTBqeQ?=
 =?us-ascii?Q?WvVrQ7wFkw7ftsbV4kF+9f3noplNJesaL8Ys3kHza4gZVrIqRT8dingfp3QA?=
 =?us-ascii?Q?aQ89cGUwNZsJZFcl7qawFNb+Bbsn4APsL874q/fBrGG/yA8bjXQ0afGeuJf+?=
 =?us-ascii?Q?Rl3sfYq6X3hN9Z+DW7MIO9RzhMX+/gSWq1komdu8c9YODDodpj7KmPgNrImJ?=
 =?us-ascii?Q?aVEH8ote3O67jCbDXccnJLBLBzDQLfKnZJvDCSTSeVM0KAbVsdR8cqyXtHM6?=
 =?us-ascii?Q?OUGeHwRTgZpNJn99YQpek8G2iK7AqChXmYBNr8RucnTGGlQyMjPtn1nty+EB?=
 =?us-ascii?Q?6G1X10gaW3meZPfu6uEXSwiCVkkL1cZNtJetvGEopwqQxDq2YO93AJ9WwD5x?=
 =?us-ascii?Q?2P9OZA84OW2ksf7U1h/MQWm7XKmiPlUTN6/q5Z3mADuKudEozq/HoPClW/HJ?=
 =?us-ascii?Q?3ym5svKt15gvf0qo95ljmZxg6IjgZNWeRKT311eRTf1OFoEjxIbBOwdxV9tt?=
 =?us-ascii?Q?KZnFDWkM95EjlUYtsvx3RNM+eAITEtwOkK+yHWJE1YpiBvNboI95rCtBchLo?=
 =?us-ascii?Q?ADTZG7cFnx/QiiaGVB5Nbi0dZQ6Pcr6CBwGgqQ/ARGQcTEfdgFkj7C3aJhIQ?=
 =?us-ascii?Q?uuNx0t0mZ+S0jZRVJqXh1hVwfRGKXntTUbEK5RigpX4DYjjmDbRWYOZjH3Ru?=
 =?us-ascii?Q?58jK+CDfdZ2Re8eI8GtG9GaNjrfm00deqpWym34n0ajP96kEq/NLKAjBQvvz?=
 =?us-ascii?Q?qp+miGfP7HgNhDKUTprmOFvyErF+9CkEopd84FxfNOdEaaayXnHoVLtIF25a?=
 =?us-ascii?Q?ZQFTCzk7H3+JJlEsSsfVXGxwHr/8pr0lnpAuAByAmaZq/GDekhOt5hN62WXa?=
 =?us-ascii?Q?HBoXz4NyTABFI0ysitqnsGzjUsr1mOmULhX7M3iivKkhmPftoWS056wPhIfY?=
 =?us-ascii?Q?3D9QKlEmyRLprtMvU6LrYG6k11eHJcvcCqE/VZrpkniLug5Gl95E8P5KwaK8?=
 =?us-ascii?Q?pCj4dd5XmUot1qzYsAVlSc1g1OjQiUDUpfG4mrToILPH1a3c7O7D+M18RehD?=
 =?us-ascii?Q?i+Dw3WMjuFgKAHcE0aDBIL/NGMZaIy7kWNN8N1HAmUD2mpqBGze0FtLP41Qt?=
 =?us-ascii?Q?0jWu9g4wHFiKCTHqkUn0ioiVCM6/nV9tXbe05EZ/bwZzI3sRRq9FhECgnvG3?=
 =?us-ascii?Q?+8z2Lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:57.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2c2255-c992-44a4-acfb-08de5c05a0e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15976-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 399768062F
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, clearing a vport's parent happens with a call that looks like
this:
	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);

Change that to something nicer that looks like this:
	mlx5_esw_qos_vport_clear_parent(vport);

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c     | 11 +++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h     |  3 +--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 89a58dee50b3..31704ea9cdb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -202,7 +202,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	mlx5_esw_qos_vport_clear_parent(vport);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4278bcb04c72..8c3a026b8db4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1896,8 +1896,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int
+mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
+				 struct mlx5_esw_sched_node *parent,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
@@ -1922,6 +1924,11 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	return err;
 }
 
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
+{
+	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+}
+
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  struct devlink_rate *parent,
 					  void *priv, void *parent_priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..20cf9dd542a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -452,8 +452,7 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack);
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.40.1


