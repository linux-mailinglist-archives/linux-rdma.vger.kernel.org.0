Return-Path: <linux-rdma+bounces-14731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC442C82B11
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 813204E9CDF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941753370F0;
	Mon, 24 Nov 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gz883ON7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD902335574;
	Mon, 24 Nov 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023399; cv=fail; b=N4Z+PzjdtabQwuln949ulF+cwRvk7ShmiwuWeTY7EWqPFfk3DialWLsQcvSUJ+Vqsc1jhtlZQJH9a2OUwF1sAEZfP0XT1+G9TyjPxACJLc4vpTul/DoNMsYQOaLhWu2LXeQ8MQ7Xn83X8ssB6f3dOLPDrSLKk24rcfDmpQUE5wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023399; c=relaxed/simple;
	bh=WXI4mPHSLY+tAy1zXP51/Q7vhoBiJyspgV9I95XoDtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw8m9HzEx497WN04xHbACTQI6c2XfJHb46YLSuLwRwrodGISUavUTqQnC7b4IFLppQmqVdOVVinnWW+97k+7nBT/dYqQGNWG87Tyj5rpih40iu/pYQWUPMc0wO+dNFWB3+LfVriNqDcrOu5c1jp6eJKckRWGfuNtXBFFJNpbSRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gz883ON7; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWrZn/w+gRjVnD+O40GMzZca+wkLmta5hLPa5UuJMZ54hrpuz21RWggk/uD51RoVYPxaNQFbbeQmouyyMp8E2j7I1xpS6GopwW/vPtPb4LcR8oCdH0xWvJMItxKvIsL3GjmWN1utMbF1Ieei3+fQxrz7Agwk24I085FZsJrBkUFdPcbeOZgOSxNLConbIf9DGi2sIXlcakW9rGQtgB8LuONzJ4RnlCdz47hdhRAJMFeiSNh0QWFx8xIPxFIRCfKRWa7iVYYeHYIgGytC8M/Qdf8dLP7athMYQNGstzr6sYsxsLRxSJ1XVYU6WbeVFOa954FdTafR/jd1Zi6A5V6/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=Xy6QAilRXUVKHo5piCdDYR5DKPzvfUF2lmpJqp6/dqFBMzbtqKPXy8TPEEZAp7MfnMCcgeRe9+c+qNgi9goEvZmQKO/xYaSxPaH+dxh8JXf0u2g7KXnlQTimNcOJfoTa/BTtlPRLdfD4yivn4YpjyfDBfGbfu6QrAGXaerfiLOT3sk88CqlIoMTEjODbNSp3auJKnzhuwxMiBYKVBqGGPkDse/TOV/C5vbxBaf1mKH3EOfIqNswAFnzegfMyGRL56IBvxMdUKdK/IDIdAc7X2ed7EQiFbROEy5sIvqQ7lm0kndYdrsQWw4NWMtgBv7hlUe5LB6+yh8qwdQTqJK+Lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=Gz883ON7htVh6fSQWesSYxC/53vzI51asJtUXsr1KeYRek8xqURuniy9nSaF0Zi66K5FteXqLdcHlcuUU2q9ZjsMtM0psACQfXysddm9CznOr1BxXFRDWbXFX8RxIUtg/z91/Alm6gtM64QQ7d0sju/sXQ5gbiQLz8LyjBrsslTuGHkYNiqOyOk3wp3aFD2NdsY+OpOMYh7AOlIcPsvJnOWI7dfQpQfww5O/mTPdYvoXFprliDb62MyLPiePH3DDEdjnuY3eRWmValMJ+7PDS+6olFzKULoQ3UARHvsPs49gVmMmGb7CYKCRS4rS7QESgwMTOmaAvQEhRk5rsP3pyw==
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:53 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::53) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Mon,
 24 Nov 2025 22:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:31 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 10/14] net/mlx5: Expose a function to clear a vport's parent
Date: Tue, 25 Nov 2025 00:27:35 +0200
Message-ID: <1764023259-1305453-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d1e2b7-5694-42ed-248a-08de2ba8fd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6u2+7QAmfS8znWMjpygY/es7KRAp2L0JUaVpN0snk6VLaDxsrShFbSvc64z?=
 =?us-ascii?Q?KPdy+b9Y1+MjCje51CUZNIZ2J7KUHNJbCTVL6t3AU69js0y+sziQPkLreZvI?=
 =?us-ascii?Q?x4Q04tm1/OSxPrIFwIl2RN3Tty7pNSjZIJcqWdmUJobf9SRfWDFkKoN6Mq1X?=
 =?us-ascii?Q?NB7p6AAwlSe51WDEObYqQWA+by9BcaVvTItoPWzmtQRoBW06WFWG663MUsjJ?=
 =?us-ascii?Q?Zt1An4VmuhbHxzp3zp7k2PGNaAlIs8HbRb9kKPxkCgrdUf/pJmIfmTxiMSlY?=
 =?us-ascii?Q?b/iBxyDgPnjMZQOoZN/gWRzpsjp2Guyxmra+8E0TIBm242SFlVh6rbB2OfwU?=
 =?us-ascii?Q?7vwQ3cijGJt2/MPuEUCJ0JdZEzdBl7Ks4sBfHCLs2BZt11lO3iZJ2uavNXuA?=
 =?us-ascii?Q?92GIpiPX3uMXZpOhZzEvQUtpmw8rmXbwdiUEhpf/K2WSjruAbNE8DXO/HnWK?=
 =?us-ascii?Q?Yy8UYGFhZbVxwCcdlt7ElUrQu0TAd29mnAr5d9dtRygVMT0ToOjFlps003If?=
 =?us-ascii?Q?8xgFC6xycDmJqLAA0VApVqZhifN4ZYO09uquvH2F236f4EyLOc+DYySpjRmd?=
 =?us-ascii?Q?svMQCQqXXPhisJx44+mH+kCDt05d6DXxhNVfXrZisN1DpH296miccxjT5xs7?=
 =?us-ascii?Q?Newc6zim3ASY/OlJlZ7FKG28+VpVPraKab6IwgTLgJRuWCHyglMLZsGH1/P4?=
 =?us-ascii?Q?nl5ciYq8KMc4nkDg1cpR93NzbbCcfmw+6g7ebkm8/MstIs8y4plbaj/SsiGs?=
 =?us-ascii?Q?rFOt3JecG6OJ62Kohr8JDgvxJqkBTnuNlFo4lvkW2FV6bx0ilfs097cFha7t?=
 =?us-ascii?Q?ZsVKw7b+Adof7WYoKPC4Mt4WE4UM9FDGNhDDgEX0ohVhXauHeuBcvK1YgdtO?=
 =?us-ascii?Q?zIgnfePU6VpglEk4mm+Q5mX81ECbK0mqhMDazPN0my/mbjO7o4yBIc/A99w3?=
 =?us-ascii?Q?xjfD3VXgJYjS5cOc0BNNPQZ0mRzVZaFNY2VCJe8GBCSNjLXdMthJfIRl/8B6?=
 =?us-ascii?Q?frfCNWRcbAkIxO0FilCPeqI0lVPJTeBU9wdbmKoVAAJFQOfST6HKrnO/fq6d?=
 =?us-ascii?Q?YvdhMHbwy8Sq8vJrIZvsKJQ9Apz9nKqKV+EYJuvo6IduO9sTljxc4mxaoqHy?=
 =?us-ascii?Q?5xSuEDFK9Xg1knqBJHkyAZSnpngZpHqVAUCDgRqxWCTXxuNs4XVBIJsSSXp5?=
 =?us-ascii?Q?VwI+j3+gidhHsPkTO67gRpueNt71AKIp7ygoF6fQirV+7/+k5DdeiH4a5sMx?=
 =?us-ascii?Q?6rFA9rfVoNCB/TqFGJZqG9FxqzWI//oGPlMSsPQsiSEkRWtbSiLWYem/stxb?=
 =?us-ascii?Q?B2qfjLCuJ7JA1kf2/+wW7rtoCrfp89gx2wIpRSM3ItJFs/yb3PlxwSMiVCXw?=
 =?us-ascii?Q?SLBT4W1H/D3dwQ1uHFtuKyomssiroir984pSUBFXkRKhz2Pvmv9LprkrumN6?=
 =?us-ascii?Q?ZE/FZK6VfeLRftX6SMxBR8MY95TsiiQYjsnMgyDL1rVb4To20KL83flYd/Cw?=
 =?us-ascii?Q?ZtEGnAilpP4R2pNonxS63g5JMBun/HIAJROjuia1ILpE6oJ0Fw1o4CxJj5bk?=
 =?us-ascii?Q?yQaUFIt2Bm0JREkYvMk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:53.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d1e2b7-5694-42ed-248a-08de2ba8fd14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256

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
2.31.1


