Return-Path: <linux-rdma+bounces-7748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F63A34CF3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E0E188F1A0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A1266B64;
	Thu, 13 Feb 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTr7XhWu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0493266B51;
	Thu, 13 Feb 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469795; cv=fail; b=SBn4KRN1vdbw/BUG1ip4Yhnp9RmuAiiEUPpPE04TBdQl0tke+Zfptv8Jbp09dcafuUeikFglhNnvI6jGFkuGE8/2E1BSI7r0JY/fw4dU7Cas1y7EEUUYywaITzho6Cy4DZbFjMlzGGPUMYFfp33/IJATzdYYgoU3g8uFpws+IwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469795; c=relaxed/simple;
	bh=C83+eZf5KUuNCQScrqnktNXJKq6/WbImoXb5Nr+F0Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3ICFCHNkS/8ur2YmmNoqsPDQh70sujjuwP3Hk6BVaa5EMDwU0N/g0xvsPqWFe0YU/xLlHICtG2Z6QOAbhZI+qgw7YYC+OB2+yUuDwA8rZl/aKx8e8hxosEYfnng2qFlnOv5jZ5sq2p7jdIP7feycjzpgh2CS13MLtl8sm0mx1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTr7XhWu; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEVWh0iYCcvYmn6edSIA4h7c2fmERoG1PADNBq6vNcR+8F+p66iCCWPoAOU6KJI1sl7P2PGkugqFmxUHJz7PlPTMyuqGGWalevSxL26Vc3nI3raKh339nRnd9rOFL9g9qJazLzrqxWbHpFhg4lSyHxavD/PoIMOoiVomo8z7SF0GySRw9Hdz/33beDa+nD3JdoiAyNtKCdYfNnb5Qx5i06mJHuxTrj0KFTXfJ1yY0snPT4xPQcXKemDMY2SvU8Gq/ie4aYDnA53CaS0DQyko0zLRGKchk4VJF/HMIb/+18ZH8tg48yHjE90WZaKuAqQtCt7SdbBBGOO1FAUSlT7vSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eBV3PeVhl++UF3uYeqBLMNKZ6EeqSrm14B797LVSGU=;
 b=N6pfdYbYJPsRuBKBqdPE+ZncD/ICDJ/RD/oPM1kPiQPy0L4RINui0mh22ZpS8R2Hm25DtmyVk+c1XXlqyciF3tV4P9n/AwOeY/1LLARVIe7+vfSs8hZDmP+5sJxqYRPO7QdDvZDgfPlA9O7wmtqatRgWdCmFzK5QKlJRjYXnF4iO1f5/bI3N0yMKkYbOXsUGCZXUeKleU5agYaUMdrTfnR+S6/rp+zteSIu1eKBdd1S1XZ4VBzrv0jKA7Q09z/CiTp2Rk7jsQyA6xdVvXjUhX+2PpKtOcYueh5gvAszE3lbfHSWYr74HMZKNsVQ1gXC4ijVhQ/s05+/gRuVM7O/WaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eBV3PeVhl++UF3uYeqBLMNKZ6EeqSrm14B797LVSGU=;
 b=BTr7XhWuebpELzGbMxJigvqVAZDy0znN2EgZT/YvBpE+cApPB5+IXSAJmVKan/jIbZ3Is6Mbm8sVAPvfRiChvBuUgitlX28vr15L4pKHUNykRsWZ4yrEi5JfmJiEwpC1U4cTkbclopEcX3q+J4ht3VsrsGWZjybMskChd3U44SDu/ut22d1/4Hle1sBN+iB9HosUF8TOv9S02jvg5qQ+CfW7lfnwUZ24mwivh527aypdQRMRF5WBVzYPT3VD4mudGr0J8W2Hdypks2tazs/MD56+yqBkiotnY4+kJhxDv9J9/aCCAIYLi4JvY94Z/dtFpg19t/MEnyaPZUftjGhhWA==
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:03:06 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::87) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.15 via Frontend Transport; Thu,
 13 Feb 2025 18:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:03:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:51 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 09/10] net/mlx5: qos: Init shared devlink rate domain
Date: Thu, 13 Feb 2025 20:01:33 +0200
Message-ID: <20250213180134.323929-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a3ca5c-f924-4cb7-18a9-08dd4c58aaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RV+DvtWb/txInid3rOzHiR8FhgDJzhS/xqk7ggnJOI1eD1dw/geQ62c1Q3/q?=
 =?us-ascii?Q?rg8rFWwuIcrdJGHLV0xAuqYi1aCx46IBo9Nb+gqUUno/36MfA5ANH4vnnOTf?=
 =?us-ascii?Q?/QKD0xQjp60mtu3pITKbmJjSWIYG4xBgkfUYFU/xRnN9KpJdWSL6GGoe18Yr?=
 =?us-ascii?Q?R9L5BrQjXoB8kMYaXX4WEdisNqHITp10mQSOdupsHVV+/O5TFITigP0BIko4?=
 =?us-ascii?Q?vzALfeYF6RqNtZAHmFhIGbOPyfU49/o6o5oDezTvLXkUGRb6S+56128400e5?=
 =?us-ascii?Q?FJxtB/iuJ9FqsheUPq+naSLt32srAT4ZPD3gQBGqacmYpOMWges/RWpCbwsO?=
 =?us-ascii?Q?VmvY0WdVhuoMIDiIG2bfwGqOtINwzFhmEj53u/ZYKuWpZ4KBOT85+/Hnybcg?=
 =?us-ascii?Q?amHiQ6BVkIWZ5PnYTf9v4JwXLln5V6ogPNfr7FYiHYJ+m6H05EgvGlT8LiyL?=
 =?us-ascii?Q?wL8LJWaVGbYmRUSR5/HQWCkDFLGE0UlwRpAPfwRYjbGrAv/8kIGYai0BhMyk?=
 =?us-ascii?Q?5yhzy8NFxIksxALwhsVq/RmAFYX9upoDDdRcjVd5nweyZmnmX2G37sDn8mmi?=
 =?us-ascii?Q?aQNrx1PHcIB6nqK7UirB0n4XfTZZdcddQmREQktePmLlKBvsahmSKZl9Bc0f?=
 =?us-ascii?Q?7oA6qA+MpbkObIbVTqGc7tchmxOnyf1W6Rh2he0sQZQpw0sgzYBYMEV3tblB?=
 =?us-ascii?Q?rSxSdEgIzI2P56xLXal7O04ZxTRXQO4c3ueLP/82sVHJULR9C63nR8hKK51A?=
 =?us-ascii?Q?RcL2F7RG5Hhft5SZPeT7Ag9jEsQaSIboRTgwYy4EbFewy1ENXOTEueJ6Apqz?=
 =?us-ascii?Q?Dqx5XTgc7lb6aWssdmZMPhFAyI/+ayEv4aCYhEu7IRgY5JAd3+nw4cnT+pdV?=
 =?us-ascii?Q?rzmsaEyUJDK+C+UHDzSIDezUpMUp6he/SWsrXew6kV+1FtqB5I/Bq0ciI2IN?=
 =?us-ascii?Q?E2cNoREgnrdlPNPX3y62DfDJW98P5j75aZrbBQ5nAb9SjXv1mPcdcZNd9RWu?=
 =?us-ascii?Q?h9wqYjGS6nHeoTlMlHDxfF1sBq25QWMPAEoKre/+R684JSKFTm+rt2YQCcr5?=
 =?us-ascii?Q?RRiWVnBuGIteTNW+LJBVPzNNfbF58pLBRtXT8hoHHKNJPDakpoxivnV9s9te?=
 =?us-ascii?Q?gNn0kecv0zUBX4xOW61Sw5CDCKTEsEl6e2ah8v0Xo/ze1FzNN0XVIfu0mbdL?=
 =?us-ascii?Q?F5VFImenYLjc+tLZIa1SDKBi/VoknSEzSohqwZ3D74nwhH6e2xRU6mErni1D?=
 =?us-ascii?Q?qnMDGNxFnIEElUy5L/crl52tVs+bWIsptSdbqkdPJu5koCZe+60E2naMpY0e?=
 =?us-ascii?Q?7RsRGMy8akpgBVwHsZqnH6ojaiI6owyyfCLMkbFkXFUZvG5Zjt0Y92mjGF+D?=
 =?us-ascii?Q?jR4wRsnR4MB0THrE6ue8yoLgCxoVxssCUdwx9zyCvT8VaHXT0x2qGGvLs+c8?=
 =?us-ascii?Q?2if/BPcHMCaCw2tjn+ZZGtC8QkuGX76DV7E0MHCXW/crYQFzbjM6S9EaCL/J?=
 =?us-ascii?Q?OIMV4VfAhxMnW/g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:03:05.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a3ca5c-f924-4cb7-18a9-08dd4c58aaae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

From: Cosmin Ratiu <cratiu@nvidia.com>

If the device can do cross-esw scheduling, switch to using a shared rate
domain so that devlink rate nodes can have parents from other functions
of the same device.

As a fallback mechanism, if switching to a shared rate domain failed, a
warning is logged and the code proceeds with trying to use a private qos
domain since cross-esw scheduling cannot be supported.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index e6dcfe348a7e..9af12ae98691 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -899,6 +899,20 @@ int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 	bool use_shared_domain = esw->mode == MLX5_ESWITCH_OFFLOADS &&
 		MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched);
 
+	if (use_shared_domain) {
+		u64 guid = mlx5_query_nic_system_image_guid(esw->dev);
+		int err;
+
+		err = devlink_shared_rate_domain_init(priv_to_devlink(esw->dev), guid);
+		if (err) {
+			/* On failure, issue a warning and switch to using a private domain. */
+			esw_warn(esw->dev,
+				 "Shared devlink rate domain init failed (err %d), cross-esw QoS not available",
+				 err);
+			use_shared_domain = false;
+		}
+	}
+
 	if (esw->qos.domain) {
 		if (esw->qos.domain->shared == use_shared_domain)
 			return 0;  /* Nothing to change. */
-- 
2.45.0


