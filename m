Return-Path: <linux-rdma+bounces-15746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E91D3C187
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29EB0446621
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44D3D2FED;
	Tue, 20 Jan 2026 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jWBIOySk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD73D1CD3;
	Tue, 20 Jan 2026 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895985; cv=fail; b=qk4rl5rIda2Sh0+kC/gYMKdw2AZEyFo1mzvR4keYIw8InWrlsvwlh91nM3C4J9by4yu8eCoTLK7Ga5NyAhOVZbY/3EWTRXyiqYUcrXN59OR9odQTuwl25MPZ9NRjp1gfOwjrsn1OLyZtuW32XaW5F4+kn5/E36SFnwNe4na72aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895985; c=relaxed/simple;
	bh=ZiuPw4gxpJnm8Fp0BXF0/Uke9+Efb6aDVL1bFBDGfhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEQEw6QNjeUTgEjgMFzW63kTN1SNjTTRsxJlbqAJKUcvMCBv5evM+w4sexgBOkCpTiGyoSEhaF0YNfJ/+baQzupKYJQfntAQis5oI6SbqB9lwSOC+wKH5JWxGmRbmMCsutJOhXbgsdn+GcTVnFAesDiDmofFNm1lTAw1rVF6m2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jWBIOySk; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v14Jdj94niNbJhwb3Gj1qXsI5WXzm6FOvr0DV+II0Cuq5maVoh+13lSTok1+VOF0D8BhrPi908cs/YmiCou5gMErYZB3nBhOsIewUba7BhC1iXwQzBUYMaRkMb9m1g+Uxosn2+w7Fjf9kSsXgHL5EELbzz290nSHsY8rOd49eDcpVTbJ3FmBubGPEBM7H36n/Iqi6O8UBWfhBp4d2sQs9MTCT0hwHCJeQvukbqmC+KTnYDRGLTufCHBfLNeq/WOGby8L4erYWCO45NOVvssTtBPE28p0BeUOU+uPqRLL9/+LEhvHPV11BcTMq6E22H+EarnwUdyelTG0KYWkMcoaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gbcaRZVuCbu+AI/JbON4SU/SCvsGg3RX98vpdOBgJk=;
 b=Da2HVaV6unhA7sS/VFi5Ea0umWQecPMxI1nJ845KnRQ1fzG2j2FgUFugzEdlIB89MLwv5//3TPRW/v8UBMFcQVG7wAR1Aq5ljhAUo43Q70lCiaz2thP68J8IOSJMKD8Z2FZu8lYMSX3fENY45Nm0DmQljJDaMvRx2k2ZRo3/rWodPUxhE3x0ZnzbUpOlUaO1fd7Ve/4Fr4iuTPJgezVAQMoZgYr8GFsOVXdEkYHrwUmXQKxrscqChIoZgGVF4M5CDV2sNXw5WOWSmZ8Q8xi/mdE1ur62Vqf9EYPyiBIHRazMMosMNK9gpYGisXq4zmEdfVGcr1FBtfpldxYPeTwBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gbcaRZVuCbu+AI/JbON4SU/SCvsGg3RX98vpdOBgJk=;
 b=jWBIOySkBU2pzMXotfmiFm933TBS8gNqJg8dy+R8rKU4YtXx5nKbMzYZlAivx+AQva/QrjaUM9XAGLW76vtGmG/UbGqpN1ncwKQhvggbMdpAt8uHIhl7eQstTDEjM1SjC9/k/Ku0zjfec/HffU5NZUxYtVDDv5X1COU+rSZlpD0i+z3N+RjQq/4ekxH1oUV31GoU4P5MyIe34HeCTohP6KqampnDRUtOjLlQd7OACVGwUeL19Hpfi73GKHb8hrPTs4SqCauNTdjOqCJYKnB4RJxjpQMMTj7RhjIst9Z/B+r52FRTaEC5FdhyQaTmSLCkELyH65mFYf9nYmXDF8bRHg==
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:59:39 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3a) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 20 Jan 2026 07:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:59:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:23 -0800
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
Subject: [PATCH net-next V5 11/15] net/mlx5: Expose a function to clear a vport's parent
Date: Tue, 20 Jan 2026 09:57:54 +0200
Message-ID: <1768895878-1637182-12-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: a568a82e-d8a9-45f2-343b-08de57f9dca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QfnnMQMxLgIsNhID11VFlNcJlzSglcC50XK7UVFDppMRwu2ZSp9MpgH2byXQ?=
 =?us-ascii?Q?BjpkzbAi98fy0v2TFQV3FoOPazITzDKRB8k52G6M9QdomRwBuyU9O+c2PhnT?=
 =?us-ascii?Q?YGL9LGW3k+MPb7WgwWJtZsZNEXGYKomT1rsERMbrGOli3NSZY2tXZxLYot7m?=
 =?us-ascii?Q?BPe64TLKgb53B2+k/hrDDQcHtb1U4cCCuJ8ccn0nohN6EP9kUT4j97BhfTnP?=
 =?us-ascii?Q?YJKXgu3zA1VHRz+x4Ucpl178AtACqXfgP7J+UEc2ajQrup9XevSD/yhByhcd?=
 =?us-ascii?Q?Iol1MWZZ3qh2OdLUhjNGxQwxNXdWrTbS9gGPDSGIhzXNDclTyKagqxLMPbBT?=
 =?us-ascii?Q?rRopu6mxXxvlnQhRfGGan2I5vm8HgF2wzZCxeIFF+ONgehoMOesCGd3QsRLf?=
 =?us-ascii?Q?5dEyS+RTKTpsYoDKJDNcJnl8FiHEyhK/6Hcp0Pja8UF+P7fUrXBUKKgUiTjt?=
 =?us-ascii?Q?z1m8579X8cwhNIkjuzEDPvla0eC9EOXF78uA4IWo/lbpbVVfaXp3Hd7ftayN?=
 =?us-ascii?Q?aJt4nV38r5OzXR9MAh6DL/6ehwhNCvMmsTXRRadOXthj8byOZjXtwV2NcCgx?=
 =?us-ascii?Q?x0KXR5ghDHLlImehDakHa1dTeQMmYfWIfYmg7iCaFNt1vIXXsSNWHMwhFFdZ?=
 =?us-ascii?Q?i1CAy0VWIstYrfHcIXYOz1RGLyLF7EMAUhO7V5j2MiUANx5asLDDvSedHE/u?=
 =?us-ascii?Q?HLDYjyZFA71eZpR3JrriMdYejQJ/t1IumvGDtNJYNr0pkGVbEM1OPeV1hRNU?=
 =?us-ascii?Q?cIMvhJLT/vZmisyMPI8Jh8THMlO14TdHh1p0jILucGs69UiWEue1QSrJBXnF?=
 =?us-ascii?Q?yLgIFYdqd5SgfLorF//Lot3oN6RHHlAG14U2qxsrS+yy95SxYu/8FfpJBwbG?=
 =?us-ascii?Q?HDu3Kszlbx1mS6RMG945DZuJQCYP/3TvUdpRCXzMWS0W5EGY1SyNAu8Qc+UZ?=
 =?us-ascii?Q?aTZ4gKMqMmKWkf1v1RAM2vvaskMHPmYYQaxNJgEu84fd2UqPKkHLD/n1YdtA?=
 =?us-ascii?Q?DaqUVXSIJRY72r6NH4rd7/aNq34Ba1aHh+B4oiAt/DNxESEyT9fbremOg32s?=
 =?us-ascii?Q?GnIyY0ZRtf0wa07sCOf2ZE8LKoGBip6bLhcUwmEKTOEP5LrxD7usJnIgeWdB?=
 =?us-ascii?Q?QYbPxTlpNDVNJAzr5gG9VM2JGzUnIdP7dTnCdkP0LFYb28IFlZIQSf4HdNBT?=
 =?us-ascii?Q?oqTrn2iuoinPAue4HP22pq8ABoZbJ6Aoff4qJYas7QsD4GAcig8dazaojLN0?=
 =?us-ascii?Q?yFazEuX8ILJpNZO8ZoJiUbL1b9QcIKVIY3VzxhERL207hCBU/z5uvzYTbUUp?=
 =?us-ascii?Q?5Yg1tG3TrYbHdmLhGBqbF24ZAQF1hrkNPvlDUlk1lPWOy4muSxs1aFclN002?=
 =?us-ascii?Q?roMLUf0j2l/yf+H62eU3YVD1QjBPx0QcJVRyHOisUJycwWRp4n+YHO0e5yuS?=
 =?us-ascii?Q?OFLBSyMjfQhQL7fzKkHklBXNNCOO0IkjC4P3F8NgHgVcz2Z1f24WJZTDdbL6?=
 =?us-ascii?Q?enkMgpaVRZz1G9OnRYL401w1xtmnsXFnXU2FlXocl1wyAU2+izGwYHiu0OZ5?=
 =?us-ascii?Q?VcLlsdOo3BTXDLIfkgfR/aBr/5rzW8W2mkOUsJq64JqQ6V3WAWAbC/RDn5Ga?=
 =?us-ascii?Q?c1LV1tgbubYHw+EhcBk7r4aWh0dbB2Vv1dkEqlA9PmdLx8eyLg30w8E6lrA1?=
 =?us-ascii?Q?OoiNbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:39.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a568a82e-d8a9-45f2-343b-08de57f9dca1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

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
2.44.0


