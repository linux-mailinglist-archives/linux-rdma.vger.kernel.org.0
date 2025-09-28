Return-Path: <linux-rdma+bounces-13708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07001BA780A
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94DA1897CD1
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C332BE7A7;
	Sun, 28 Sep 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I7xY6z9T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A029BD83;
	Sun, 28 Sep 2025 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093375; cv=fail; b=XSIlagsaVM/UBhaQlNyNb721EMf6aNmumeKHjsIsKjo8PSPRQfAcoTus5O5HbnqTKFybuHQzihp5roiktSz3MczU2HCRxXJwZRyIN+ps/hnWzGNHjPG/gjuJnJq/6ldx0Um8l8OnGD1NUbjSBgXNbGnRTDwlsOItlKvYJ0Of48Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093375; c=relaxed/simple;
	bh=mNeb0EYcwehtct/43eGSISHb3Ei/JMZq1LX1rJFJXNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXLpFPfE0EtgGi6AXIvY9qvpur83WDmiz2aqEx9XKVySsZDg/cnXFmlGTBtEb5oRTEcRiGW8qzBjsqGpOGXt7fe184BMXXMvvjgOEmmc5oQD3Uk9B5QAvmI+8209PRDDcy/TtQ+pGzhgPYfdHSQ981vZfADZgTNdWaX3/zlc00k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I7xY6z9T; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ozs+bBNXDZX3yVe0JzhTOOMW9PRdhl8PqM0p7Vg5Toce6Ycou6g6Cl7HVJGDS4Domc46kcSC6F5jAMbjFoucCH1Ptijx8l/2rc6LXzIWg93W6XSvhJZJUWkDBZ5pQg6AFuAO34cNcbk4JB1Q5rWQeH5OS5V8HszHDlWfYZHrr/VxCE3glihapqpWgQdNoHQsfQTkHXqF1+hdguqN4cNCyu+WeYakfWk4qecACHxtlP6ada40ih+GXXySr62gcdsZLQHtf5pId++qatBYxNasWHGrqJdoBY/r3KqduDYsNtzdELrA6UmCxWGfUwzPnhVcfrSONhGQCY5/W4FJLoreQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKygiVGRSSSgOxG1xVn/AHtVdA6X9LbWv5Me9yLhZj4=;
 b=i9wkEWBfN7zZ1jINFYTWnoU3HfN31V/N4RInrwGWfitZdGD9LIL5wPKTQYKie0BDTnjvO544vbc2tIS1uZtR/H2zye6TGQsx8VfXmzOsEfKPx+MI1gZY6/53+MvE01XFtnp+tbT7+FLn6OdYHZDJfq+NLYiiFXYHojxCbuhbH1bs1WQ0MOX1mKdsP9k0uSOtDMW3azXC6Z/ZsHyE8s13mMhqXSU2bI4eKkny3OybGriUegMRUJWYICZgo7tS6qsHwV+yP+QNuN/Er1shQNL8MW5DlabodC+H1qSnbsFXM0Av4Lmy7A0ZJSTjhAHpglrsU/kNTiVxCauUJsM/zqdccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKygiVGRSSSgOxG1xVn/AHtVdA6X9LbWv5Me9yLhZj4=;
 b=I7xY6z9ThxxhVdQLtsH5npr4b6ca9DZ7yuB2TG+tMSUTh0sMrGE9Ti7jpbpIChtLPL4PrDEjRFeXHQI9ek2o6vlt3wH0InGXTlfV4fXQMUdj+NpdkwTX8MgaBzw1O86JQMQQrefJ1pvf7ay1njvZ8bDpELM1xO6HziCskYSZVrHlAp2DVA4mtopnlUrB2BNvIRHwR9gMLhQFYtOHYLenYiS5KH/U14bKlwb9mqddS7o56Ow2DRysW/WmId6JTETUpX+KmZI3gQhRJZkaJgqGCFEnkbBAL5vQk1/4DOnQKqNmemDik4jR7IpXcM/TED/HKTrmTEA8Ut/z8h4B+T9dRQ==
Received: from BN9PR03CA0546.namprd03.prod.outlook.com (2603:10b6:408:138::11)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 28 Sep
 2025 21:02:48 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::4b) by BN9PR03CA0546.outlook.office365.com
 (2603:10b6:408:138::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Sun,
 28 Sep 2025 21:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:02:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:02:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:02:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:02:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5: fw reset, add reset timeout work
Date: Mon, 29 Sep 2025 00:02:09 +0300
Message-ID: <1759093329-840612-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
References: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: a95d6147-ee97-4514-ab88-08ddfed260fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2tAjYl5P9HV9SHJQCkBOfEkMqQOgHPChzpURP/4YEx5bv2m/I8ZVMjWgLupD?=
 =?us-ascii?Q?GpbOidDjzOleCCgd0ZG6JWproEmeOQ6mObusQSisGp5F945KAZsb2kuj/reJ?=
 =?us-ascii?Q?TwrPByFPQNp4/YSRMg4SuwDzpAqdB59hpnLTaJy8EMeKUmAQgGb5N2Q8pmO/?=
 =?us-ascii?Q?rtmUm8weEziGI7XuOvx8DnFEivThPR5+aW2ndGrUyuszKU4s4ACZaESGxEcu?=
 =?us-ascii?Q?oaTdzXVOgS5vggBUA5Re213kmfLcxjcmOrzV+vXBR6DhVcDihQLS06GMkvWP?=
 =?us-ascii?Q?mS2Uv/LQVHrEJFtbJGu7n9ekLXgizvWsBQTArE48ztEgY+Yhkhc0jAvQDbDQ?=
 =?us-ascii?Q?khPkAVrRpDCx98HjIiM4LnJ2JS+SGyNAwfoQbigadOumLMx/AQU7FIsk+rVT?=
 =?us-ascii?Q?dAvYmlhTrLSegCNzTveJXMTlP9M5i7i4fLkMPdHeTeGZQTz5BbieFoMITGrl?=
 =?us-ascii?Q?zeAFF886WIIk77cTUFsouzEMAeZTmLdeQFSFTgfD1V2Hi9egMOWJvRF/rF0C?=
 =?us-ascii?Q?YRR80i6rMDoUdHOWOIUAud8Z+TmB/AzNFCHZ2syfYYWcUh7dgnhp1smlfT0G?=
 =?us-ascii?Q?f2j/Em6fO01tCbVFWXnGvzXiPSE7ApFZ7/ZrFdzuastDJrRXXwSeA7uUbhYn?=
 =?us-ascii?Q?4w1FYxWAeFmJdhHlL0VnH0kaSaUQZK+DFc2xIH4eQa/SDp1FfqIIdqIhGKOJ?=
 =?us-ascii?Q?1f7+tCmgsGyl/ef8ZTScfIJ4Z/1q1NhzZb6JHufhPnff25LDtC9SRcma+Fup?=
 =?us-ascii?Q?ipOdr8krgvy7KQPcjjXvXcnUte1JWNJfC247PRywwl2MyTQF1B3O8XcfacUJ?=
 =?us-ascii?Q?6vXjjCHMNQx/9NJ9rsOcEA/rgoUzlPxiInjiJg8CNE4rvR8swC3jLs/ocKmD?=
 =?us-ascii?Q?BRKTEIfV7raB1jNOf/nj3bLgQR2wS0q1r10PuBulchJpPRTNaXyR5iqqlFYg?=
 =?us-ascii?Q?GJI5F59yO5PSwiqkPfkgTcdtIOAAMQy/5YL5aMkue6ljejF0cNVn28YhtMVp?=
 =?us-ascii?Q?LNDRHO3U3JVfP/A5I6ag1YaAyusALaZua/AsREl/USOElzB7qKpcqrwu92Oo?=
 =?us-ascii?Q?F+nO3QrbVHH/mdFU74slq+xy/foGKcXd1VRLFFVWqTBLMI81d2eP18DAznKQ?=
 =?us-ascii?Q?DprT4AXyZvfKB+MVjWAMUkZhq0g0TNnh4w4DF11KYHqPdKM6Ul7akB3LJ4o0?=
 =?us-ascii?Q?pfWtNT3wvsSWNFfGi+ZMaQVcQ4i8xNdG7SCx5S1efpaW4JbTc5Qzl2Z16J/h?=
 =?us-ascii?Q?+tdqZIYxeVgMdvO/zcsvvhrYeDT9cp83p4SX04rQMmwGkbj2YpGazar+miPB?=
 =?us-ascii?Q?jI4PSD3cwbwj6dJI3W8/CQnHzxzLCJcfRKqx4lXz/Cxi95m3bG8SiXBIqF7O?=
 =?us-ascii?Q?qUEIlW1H+dApymshCD0WRMl2nciJh/pEgWDdqS16YRX/A26A7FnqsAC9i3wU?=
 =?us-ascii?Q?UtO8TN0eWzG85stS8uK1PdEaiw+8MslpNJLdggZnKFctQqoKRnVKUtgnbSTc?=
 =?us-ascii?Q?187Nof+MvEY66IHPHpxmehXvF0KZQWIs2ZVt5jQ1ebBOfs9hmbVl1wSHAx6g?=
 =?us-ascii?Q?FnHtjK1P6DUKvr3M8yc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:02:47.8495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95d6147-ee97-4514-ab88-08ddfed260fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE

From: Moshe Shemesh <moshe@nvidia.com>

Add sync reset timeout to stop poll_sync_reset in case there was no
reset done or abort event within timeout. Otherwise poll sync reset will
just continue and in case of fw fatal error no health reporting will be
done.

Fixes: 38b9f903f22b ("net/mlx5: Handle sync reset request event")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 22995131824a..89e399606877 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -27,6 +27,7 @@ struct mlx5_fw_reset {
 	struct work_struct reset_reload_work;
 	struct work_struct reset_now_work;
 	struct work_struct reset_abort_work;
+	struct delayed_work reset_timeout_work;
 	unsigned long reset_flags;
 	u8 reset_method;
 	struct timer_list timer;
@@ -259,6 +260,8 @@ static int mlx5_sync_reset_clear_reset_requested(struct mlx5_core_dev *dev, bool
 		return -EALREADY;
 	}
 
+	if (current_work() != &fw_reset->reset_timeout_work.work)
+		cancel_delayed_work(&fw_reset->reset_timeout_work);
 	mlx5_stop_sync_reset_poll(dev);
 	if (poll_health)
 		mlx5_start_health_poll(dev);
@@ -330,6 +333,11 @@ static int mlx5_sync_reset_set_reset_requested(struct mlx5_core_dev *dev)
 	}
 	mlx5_stop_health_poll(dev, true);
 	mlx5_start_sync_reset_poll(dev);
+
+	if (!test_bit(MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
+		      &fw_reset->reset_flags))
+		schedule_delayed_work(&fw_reset->reset_timeout_work,
+			msecs_to_jiffies(mlx5_tout_ms(dev, PCI_SYNC_UPDATE)));
 	return 0;
 }
 
@@ -739,6 +747,19 @@ static void mlx5_sync_reset_events_handle(struct mlx5_fw_reset *fw_reset, struct
 	}
 }
 
+static void mlx5_sync_reset_timeout_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work,
+						  work);
+	struct mlx5_fw_reset *fw_reset =
+		container_of(dwork, struct mlx5_fw_reset, reset_timeout_work);
+	struct mlx5_core_dev *dev = fw_reset->dev;
+
+	if (mlx5_sync_reset_clear_reset_requested(dev, true))
+		return;
+	mlx5_core_warn(dev, "PCI Sync FW Update Reset Timeout.\n");
+}
+
 static int fw_reset_event_notifier(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct mlx5_fw_reset *fw_reset = mlx5_nb_cof(nb, struct mlx5_fw_reset, nb);
@@ -822,6 +843,7 @@ void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 	cancel_work_sync(&fw_reset->reset_reload_work);
 	cancel_work_sync(&fw_reset->reset_now_work);
 	cancel_work_sync(&fw_reset->reset_abort_work);
+	cancel_delayed_work(&fw_reset->reset_timeout_work);
 }
 
 static const struct devlink_param mlx5_fw_reset_devlink_params[] = {
@@ -865,6 +887,8 @@ int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
 	INIT_WORK(&fw_reset->reset_reload_work, mlx5_sync_reset_reload_work);
 	INIT_WORK(&fw_reset->reset_now_work, mlx5_sync_reset_now_event);
 	INIT_WORK(&fw_reset->reset_abort_work, mlx5_sync_reset_abort_event);
+	INIT_DELAYED_WORK(&fw_reset->reset_timeout_work,
+			  mlx5_sync_reset_timeout_work);
 
 	init_completion(&fw_reset->done);
 	return 0;
-- 
2.31.1


