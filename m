Return-Path: <linux-rdma+bounces-15753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B5D3C2AF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F33602F42
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86673D34AF;
	Tue, 20 Jan 2026 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/+16pCO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91D3BC4E0;
	Tue, 20 Jan 2026 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897062; cv=fail; b=HVdkBqA2X698bfavienIQzhNtwmKE0rEXqQ/RKIeNfGfjMPJRCga9apJFLfIsydjWf7M9cSc9Xu3/GJQBIdarwKiGqKo6enjT3C+HhUiI4Lqyy8Hvs/qG7Dv3gDyXC84bVwzrAkCTVP6LHglAwg4Bm/Egt6Cv4s+5tdM55UPwrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897062; c=relaxed/simple;
	bh=6762QeW6lZq+1siE+Y4/llrINpzMVUR+Y5s0wfceC04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZccMqwUTDelDn0rMFKAW3VfwWfJw4XSOV2lZg+vb6uFTOuOfdRBmXRLat6qaUW0jKSyPHf38Ci+eXcUqJJePhXq333drEEahYbYxe/bCafsI2gADs/GMI87NMfnkFoUugpiWRh49TUc1Hlj3wyhF9+1ehqXNTPjKllrJ2T023ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/+16pCO; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxxjruJiKhkigi9lDAVRE2uy60ssfB6y9N2qcCan0iqZnDQBXgLPL/U/JMF3r/TSfC3hwEjcDSf3a/4n5qXkQrOymHMBVGqqxyqvI7FAxZi7/9poaIxqxUvDwODSL54O826k4YGPSAdsxBhuF+4r0LK2EomobbzVQIXiqpBcoV+LSfo5MET9Sou/hwwFpF7Tks0WPXdOFfJF4K/JsTbk+/oQFqXzdrn3pHpjxLnk6UyzyIDYQCth+GFb9wK6cbx2V6RNU+hote/K7gfODegFOcbv1Kl8HT1LpqvjfswiiPiJ30RXgDCfSZPTQC1xuhx0++vTvw0SkbodHxg3ztALEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpABNlIUY7jHY2IYCdZRXhE3QDrgfpoLwfCFXjIHbOY=;
 b=QxNdJ8Lxy93C/HkvnS3Qo2iNpEhXofUb158aCiEgvI1Lw2jwzJ0P4FsLbfRM8lJ9su6JrWMzEzmiGlAfBMEkj07g+JbBXtl92KNqbdzhrbMNPjjwcgQBjhS1RoXdXXhHnT/sXiZd4lRiR8tNpPqU6GXJkakoaG4gdeYLH46bqnVtvoff5g5byL3qCPvV194wWS9q4TDS92MvVy7Ux++8ntjsgrnV8A1qXZpWbrzBGzjCiCXVjzSkCTg1Jzkv6fRedpl2oiTCgtycNUwVDABd3I3SC3P9/YRBsJo9OMo0rUjyy5DvL8+HecTRhkYqLc2NwEiM1ZtejsBukAvaotIrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpABNlIUY7jHY2IYCdZRXhE3QDrgfpoLwfCFXjIHbOY=;
 b=H/+16pCOjIVIXPB3NQ2p4Mow5L2hlW82e9oTxYdybZ5Wy7a51sDMBuhsS63M8xBKCzuU+3U5TRO4O6LDrctOL42P2wAUQT+Mw91aDFvmhWRnq2yVz8+wT7BhFoPF5GMjL0Tk/zDc1+XXRTaqMw4exRzgCXJkKYnpBIG+kd/eHuuMD4cGrp0Ht5wSYief6D/4XkOls0KIuf/pZHvaIy2tQmk2zbC0tS0Jbp9UxZ6q8eRMKw5SIRJILvCYY9r+xvRSHCH8XMIFNLstBG9g3++CJa3okTsgCRNQUXW0yQSsrSddAokIRMtBA9ITu2WAzqOnsmQ6CaQRI8yvC3DX6qu91g==
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 20 Jan
 2026 08:17:36 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::82) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 08:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:17:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:22 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 20
 Jan 2026 00:17:17 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 2/4] net/mlx5: Fix deadlock between devlink lock and esw->wq
Date: Tue, 20 Jan 2026 10:16:52 +0200
Message-ID: <20260120081654.1639138-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260120081654.1639138-1-tariqt@nvidia.com>
References: <20260120081654.1639138-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: a7639116-27b9-43fd-ae29-08de57fc5e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YDePzfywB3t+UeiR1KT0iaTVRp91lk6UCk45YQ2WNcHa2UzpcQoo4ScThfoF?=
 =?us-ascii?Q?ae6D293T5F3SBvckH5ysbCfhTqR6eIj8+OVy8Q/33Fb746bX80AF60fudu+R?=
 =?us-ascii?Q?617w5S98nbl0RvUSyf7jBl6P34N50J5e3aUj6xIhf5LB0kLpMqDbtgcaScXN?=
 =?us-ascii?Q?lyBpwmX0CFwpcjtITRP5jtVRIufJ84OESrS4mm3RoU6IsMK3U43YXw8MFcju?=
 =?us-ascii?Q?fOhLbtkAVDJeB9pJcfJiOR0LCIG6mMWG7puSAedgHTwEF3Po34FRVqp7P4GK?=
 =?us-ascii?Q?KRyqpOvi8AjymrCLwEDQZmsJlT3zejRPl+VfKSpkaOSTqK7tS0ZNm2Gi4IgG?=
 =?us-ascii?Q?dUsUFaygheY1pP3/8s3DcksCFuumy3ndkNlnRWqSpfNfX5VEwmqJ5StYawzN?=
 =?us-ascii?Q?/HcR4NQd5amQqwaFgsnE+QAQb9Ltcwj55KALOLNYMtH/PJMvDhcdCVJL5qYt?=
 =?us-ascii?Q?m8ggFYwBj2i19l6RQeU1fOsaRTePJN3hWn5yVc1HyotGugmRijhaaSmIbO2M?=
 =?us-ascii?Q?TsGhYki4H/JnyuQ10nnc999HaensIzx9YSGGQVLqSCZN+IhJ/gQvR6pLOS9/?=
 =?us-ascii?Q?1og1aSqWXm1QNre9jUdxlkFaaLrWl6QEaKstoNjVmVYPe0BpQ7UT+i6dEzgo?=
 =?us-ascii?Q?ECdLYOOP8bPghYWGO7urlXr+iZGywBcfZxwGMMXdib19Cptuf9AmO8fSBD7R?=
 =?us-ascii?Q?hLKuaW2KowcoJUTIM1vGl4i2oqfMncyztbNFnwHLtVDKrTtCfgroOQkRLvJv?=
 =?us-ascii?Q?EiFNUu3IEdjAvrOG/HGxZ1V251Bcz3ZQjTKhGoRruoK3SxdgsDPk0G8gB5lX?=
 =?us-ascii?Q?z/mvUiHiFg2u+W67ZdN/FZXyAWhQh+4wYnrX8LaxblhOWpJjGD6kK9IZX6Os?=
 =?us-ascii?Q?RPbAcTH9IqdLtUeKTixYen8wUS3U4VCHEGE4ufGWm95vzgG+QOFlKt7enFPp?=
 =?us-ascii?Q?7tPCpTQhuJFSWhuJrKGHEo7P5sgUdP3HWos6rtgC0cePwod9GVShK4Gi81LH?=
 =?us-ascii?Q?u3fh4YJDxsSU4GQWyf1zCs7zuETgZ2TBvxfcTW4fGw6N+wOkNMCEeGHol2DR?=
 =?us-ascii?Q?EAdciMGeHVINIEnjtj7oQaNyUFr5rBLehzC01W4oy0x2TVtsAuexE0Av3utx?=
 =?us-ascii?Q?GAx6O0KxBnJvw2pA5PcepplU+dF+AKCUBnHWLIQXtrcgSTJ0aaiCDIFX34x5?=
 =?us-ascii?Q?u2qj66e0aaqmtC8dLGqkvqiJmLXnyyUN/4KFL3WL6o15HRi2uPSTMaikXQbQ?=
 =?us-ascii?Q?GBHigx79qrd0fEBdkdzx6gnEPczy17Wnok7I5aVNt5510Cj8syD9WIFn6h9D?=
 =?us-ascii?Q?KCw92adyE0J3TYbYIIGT869X/TxuNzl83m/NurSlZEVRBfv53dDbIAf63nC1?=
 =?us-ascii?Q?Dji3S+dPRT5s5oyv6m3KZMWBgvJf4frb/sDxjIOSNJdzIYxpz+qWjz4ClzBP?=
 =?us-ascii?Q?usk3+KiDqw17Y8oZwKbrYHWe68QKE7rqrokiye+rzwJE3eimYLubIvHUKxR3?=
 =?us-ascii?Q?jhH/tcAnACuPjZeiLIZNlpbRu3mD5aptjiVp7vjq33jmqHsumY21Ks0MnMUj?=
 =?us-ascii?Q?OnWLe1Qq50TyNq5cW1QawMrEiBklm1G45hn4UL+J6HP+BFTcxJz0oD9sv1ZZ?=
 =?us-ascii?Q?h8E11KVOIqSBu7h9BACpVxM0yCxsBMn76Gg7L586yOXzqmamRqJr9c8dHeP1?=
 =?us-ascii?Q?1/zfiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:17:36.1136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7639116-27b9-43fd-ae29-08de57fc5e87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

From: Cosmin Ratiu <cratiu@nvidia.com>

esw_functions_changed_event_handler -> esw_vfs_changed_event_handler is
called from the esw->work_queue and acquires the devlink lock.

Changing the esw mode is done via .eswitch_mode_set (acquires devlink
lock in the devlink_nl_pre_doit call) -> mlx5_devlink_eswitch_mode_set
-> mlx5_eswitch_disable_locked -> mlx5_eswitch_event_handler_unregister
-> flush_workqueue.

This creates a circular lock dependency which could lead to a real
deadlock, as the code flushing the workqueue is holding the devlink
lock, and the work handler being flushed could try to acquire it.

Fix that by adding a new bool field 'notifier_enabled' next to the event
handler scheduling the work, keeping it true while the notifier is
active, and using it to repeatedly try to acquire the devlink lock from
the work handler while true, with a slight delay to avoid busy looping.

This avoids the deadlock because the event handler will be removed
first (turning 'notifier_enabled' false), and the work handler will
eventually give up in acquiring the lock because the work is no longer
necessary.

Fixes: f1bc646c9a06 ("net/mlx5: Use devl_ API in mlx5_esw_offloads_devlink_port_register")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c    |  6 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  1 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 +++++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4b7a1ce7f406..fddc3b33222d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1066,14 +1066,18 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		MLX5_NB_INIT(&esw->esw_funcs.nb, mlx5_esw_funcs_changed_handler,
 			     ESW_FUNCTIONS_CHANGED);
+		esw->esw_funcs.notifier_enabled = true;
 		mlx5_eq_notifier_register(esw->dev, &esw->esw_funcs.nb);
 	}
 }
 
 static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev))
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
+	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
+		esw->esw_funcs.notifier_enabled = false;
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
+	}
 
 	flush_workqueue(esw->work_queue);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..e20574a197e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -338,6 +338,7 @@ struct mlx5_host_work {
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
+	bool                    notifier_enabled;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ea94a727633f..0199bea2cb31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3597,7 +3597,17 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, const u32 *out)
 		return;
 
 	devlink = priv_to_devlink(esw->dev);
-	devl_lock(devlink);
+	/* Repeatedly try to grab the lock with a delay while this work is
+	 * still relevant.
+	 * This allows a concurrent mlx5_eswitch_event_handler_unregister
+	 * (holding the devlink lock) to flush the wq without deadlocking.
+	 */
+	while (!devl_trylock(devlink)) {
+		if (!esw->esw_funcs.notifier_enabled)
+			return;
+		schedule_timeout_interruptible(msecs_to_jiffies(10));
+	}
+
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
-- 
2.44.0


