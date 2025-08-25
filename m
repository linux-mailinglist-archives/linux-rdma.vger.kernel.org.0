Return-Path: <linux-rdma+bounces-12896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA930B34428
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8597B3621
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE20301468;
	Mon, 25 Aug 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZggJbSTp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7872F0C64;
	Mon, 25 Aug 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132537; cv=fail; b=QMBT/EG8T6xwvD+Z1ult+cXHQazZechi2gStUU82Kc80eRJGlDJaZ3qvaeIQMaCXrRlDPoCRXeWE1GOf1L1QkdVbp8gJkxdA+n5Jmk3d7MqsOtaVnexcNpq/vcQEnz4L+hnTO15838fr4148hem2qDNN/dh65/DmdZkYAHN+jEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132537; c=relaxed/simple;
	bh=4wynCkAEk3DkaBtg4jY24gosyi+QBhPcPKNUQkgFW9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOz0Q+7XTw3T+dI9Zv3HvaOzm0YbZm2P+UhppwfmI4cXiSCWBICnorrapmnT0jytCZx31Ht80RKWVyFkqODEEevJlMDPpJqpBHQnh7HW4iBQB24UlUH4dLcsjMuI8b2jEu0T8kFshv+NrNBZOH5hvJQaymiA7yx1OZrtM8nCEj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZggJbSTp; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en3Rcjmkw10SlmP/KCSy4Jcw4SjbmD7qiI0YSeVPMTgdOFlgWoWTKduMqaSqhXr3lqnZi1I9vjWCnwwxtcQrl5XWNkt+bUkNJ2SkGOEOsvN6jEgvqciqgrYrAHa3a9blUOoGqaaB3bpliVDuEqrayQQXQ4gsBucUYeUoC9XS3mLUnsi/I6yKOkuLB5vDm1Q389aR1IzHMl7QS+/Jz5PJLxcVORs+BPfIdcv+XW9xukpRG/S8Ly3m3JnZ/3esCu9pvYONmLgoF00lTQcoUqeGnXfTvQEpnSU6FZoTcr7Ye7lZ45dtQyeyC0YNwlfqb2pygCHOA0+huFyr9NT+Obceuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovmJcB4B6dVfpnjW61Ui9xNMEPCtH0/RPY4WjVrQUhw=;
 b=dv+Aswyo/IvkJh4pdnSG5dGwbpnw34NSujpWx2nZ6M5gRx6E+pYRvq+68OHhZwqP1grwUwr6GaLlKDMulGqL0rr0llRu6pHgNxFF+wuYh/WMUJIUkYBlz/tevUfASRAkPux3CwOZe1Lhh0qgVcIPSlAzf93jcYq4yRMRPewwNtxaaUP6F44XMY6aoKBaoDTH2r0fnohtBxWzK5GKXx5t0fWusxepyiQfQu6KeLrc0FS3e4dFka0AgvNW8UiSFDgduWzx7mYrPTFb0ostnX+wPhdOSf+1r6s23hbas055eafwXuWXc38RZfzbuTm8T90LULeNG0A0A1vT17yoPyGZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovmJcB4B6dVfpnjW61Ui9xNMEPCtH0/RPY4WjVrQUhw=;
 b=ZggJbSTpBfRjbetaeQxJm5fA/+maNUFrbQf1Q5yaL2x8CAe9QkDPEEkbp4qxcu7xwZ2yuIZvYFBSKKpd7zeLdPMrZS/+OOz++i6M9u4ZqIcfpxtnZLQTx7YpFaEOTUkS5DEJTJXLtYE8Vl78gIFsL4x0eXu5hbfKm3JEE3RknLIeN1+wFUSH4PTHfOk6FGUfec1eC7A9TRfPpfxuXGKK4tzqwrL6fBOHngUkGrgbLZA7LVXsxqfzdx/RFSQUu4qeAWAR7mvWITZwuEBrm9fh2Xn2ZsXbjm5SGrPJyIab20LmPnXRoHQ5BlgLFMPOX+RE6zauJwGxNwodqaXYDaD4iA==
Received: from BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 14:35:32 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::66) by BN9PR03CA0163.outlook.office365.com
 (2603:10b6:408:f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:10 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net V2 06/11] net/mlx5: Fix lockdep assertion on sync reset unload event
Date: Mon, 25 Aug 2025 17:34:29 +0300
Message-ID: <20250825143435.598584-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b17c0a-e1c0-49b9-6b6f-08dde3e4a4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6/nR81mtjAlJeA0nXhbcNH9YUyRZ8ZDe4RUr1WSin1U9uqnEHalkLkkQe8L?=
 =?us-ascii?Q?0IUzHBOqSrKQF/mAGBy1hHxd8y1hR2NLe5bEdnprON30ZyJ7TkxMaMOUDEvy?=
 =?us-ascii?Q?RPKlStq0BGhH35ofdkcs6cCtFjVZ4Zt9uuL6SjB6jhieQadJh70fLAiluoiK?=
 =?us-ascii?Q?RXHZ4fWXxNeHsR5UklNSpNx+Uuch16iyWNFYCtT1SyxOrvt7PwPHuPZ6jGFd?=
 =?us-ascii?Q?xMcqlRel75DNVKhkYHFeu4OrgxM74tk+2MP/FWntJ93u8R3Jz951mlZ7M84V?=
 =?us-ascii?Q?Bo6tBCtGKbOF2TTyJcD7LKjGsQLPSmM+uAUTM3Pfh/qOaDhB9wZezAGQGKpo?=
 =?us-ascii?Q?4xzfXHydTLT8E4wuWOG2HwuLd+3yFXFu67yMQFQ8Y8p6y3yuxmU9ZvxgM+Bw?=
 =?us-ascii?Q?uCejVBpV44Zswoi3K4WSudxtV8+xtggCMnhmF59vAzLfI9DCfo91ehTzq7pj?=
 =?us-ascii?Q?e+bZqNhdxMM2K4fbQXFlh72Oi9RtXgh587/Pt/vw9IEDbE+K0EOW2uJ8OqoY?=
 =?us-ascii?Q?MYdpn/sw0Bcyu1AXaTAlEA+GVt91mPh1ad4aSLM3OqK8cg/ptplUaMOyPLhH?=
 =?us-ascii?Q?K9yo2lsaoYP2mTWUcFTVyK9XrOYg5OytnBWXT9Bf1ThAPC6ajc78LFbHOvjn?=
 =?us-ascii?Q?87tap30+SsU2eQUrWaJ4ers1corO1ShBaKlQJFgxxSeqY2U6yzEm9MCHiXH1?=
 =?us-ascii?Q?RAWNHnUFX9CGxrMSqXPSXBz+9URlQmUeyBTtyJDWp0n0Jnz7QQg4ZxAlKE6l?=
 =?us-ascii?Q?5bvf4AaaS93nBson/AEGm68mzhJ/8BZ2vDfHC4IZ9yN3JvI5WbjaHdt86+dS?=
 =?us-ascii?Q?ymF9SPaDqkfO+rKNbhZazJEXF0xA99M9z3YORFxp4IF2bvh3CdPbrnJAlzEL?=
 =?us-ascii?Q?8pXGWA39L0DYmAvze862mO0Rr3aPFkTA7SuNI1yJpFT2DcxtXB+Kx5UzfiE2?=
 =?us-ascii?Q?TdLWd6aTaHsgaHNTAXHWjZVrwMLtBS1XtAip0LLZeDlTjzCCrFm/82AV9bSD?=
 =?us-ascii?Q?HYOqoyQ+O8Ip/mahmLH15gBZQABF2uXKRwTpP6xJLXAIxeoOxV45nZi9IvsQ?=
 =?us-ascii?Q?nxEDOcpNcPL2tA9A+lLcI3gjr3GFl1HChfWLV8UAdmupPpu6qoXyPNdTZ5sY?=
 =?us-ascii?Q?HRu1pwx0x1dI07VbAqsLIOhaga+3PSXKp4gXFH2Cggo+eG7BuNfaGsver9Ky?=
 =?us-ascii?Q?L2isXpbO28TneoIvrRRkQFxHl2SfWw5kNwNTwhaVAHkgnfUxNWyw2xH6GI/4?=
 =?us-ascii?Q?/r8vEFPk7enjgXLOEb55e1l7RbZc2Ckcw3GbXpZ856drjVwLms1nEWiUe7ja?=
 =?us-ascii?Q?f1lBMlbwldvuByVR3eBRc2OIpZ4hyd2WQOlPejk0X91BQA3KyaX3z2NidLdM?=
 =?us-ascii?Q?U8NN8Y44Lz5c9rQFy9hj+rku8wusBDaj4fSoApGZky+LEjlhSQW6PX6OFqcM?=
 =?us-ascii?Q?rPZmFN8axBfBCgselnTKfPDfBIfSlQuw6GbtUhyS/nl+fRXed1etjf6jAYPc?=
 =?us-ascii?Q?spF+ln0cly67bCgyd7nuif6WdYZfs85sWCt5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:31.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b17c0a-e1c0-49b9-6b6f-08dde3e4a4f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864

From: Moshe Shemesh <moshe@nvidia.com>

Fix lockdep assertion triggered during sync reset unload event. When the
sync reset flow is initiated using the devlink reload fw_activate
option, the PF already holds the devlink lock while handling unload
event. In this case, delegate sync reset unload event handling back to
the devlink callback process to avoid double-locking and resolve the
lockdep warning.

Kernel log:
WARNING: CPU: 9 PID: 1578 at devl_assert_locked+0x31/0x40
[...]
Call Trace:
<TASK>
 mlx5_unload_one_devl_locked+0x2c/0xc0 [mlx5_core]
 mlx5_sync_reset_unload_event+0xaf/0x2f0 [mlx5_core]
 process_one_work+0x222/0x640
 worker_thread+0x199/0x350
 kthread+0x10b/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x8e/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
</TASK>

Fixes: 7a9770f1bfea ("net/mlx5: Handle sync reset unload event")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 120 ++++++++++--------
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |   1 +
 3 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 26091e7536d3..2c0e0c16ca90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -160,7 +160,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 
-	mlx5_unload_one_devl_locked(dev, false);
+	mlx5_sync_reset_unload_flow(dev, true);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 69933addd921..38b9b184ae01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -12,7 +12,8 @@ enum {
 	MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST,
 	MLX5_FW_RESET_FLAGS_PENDING_COMP,
 	MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
-	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED
+	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED,
+	MLX5_FW_RESET_FLAGS_UNLOAD_EVENT,
 };
 
 struct mlx5_fw_reset {
@@ -219,7 +220,7 @@ int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
 	return mlx5_reg_mfrl_set(dev, MLX5_MFRL_REG_RESET_LEVEL0, 0, 0, false);
 }
 
-static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unloaded)
+static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	struct devlink *devlink = priv_to_devlink(dev);
@@ -228,8 +229,7 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unload
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
 		complete(&fw_reset->done);
 	} else {
-		if (!unloaded)
-			mlx5_unload_one(dev, false);
+		mlx5_sync_reset_unload_flow(dev, false);
 		if (mlx5_health_wait_pci_up(dev))
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
@@ -272,7 +272,7 @@ static void mlx5_sync_reset_reload_work(struct work_struct *work)
 
 	mlx5_sync_reset_clear_reset_requested(dev, false);
 	mlx5_enter_error_state(dev, true);
-	mlx5_fw_reset_complete_reload(dev, false);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 #define MLX5_RESET_POLL_INTERVAL	(HZ / 10)
@@ -586,6 +586,65 @@ static int mlx5_sync_pci_reset(struct mlx5_core_dev *dev, u8 reset_method)
 	return err;
 }
 
+void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked)
+{
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+	unsigned long timeout;
+	int poll_freq = 20;
+	bool reset_action;
+	u8 rst_state;
+	int err;
+
+	if (locked)
+		mlx5_unload_one_devl_locked(dev, false);
+	else
+		mlx5_unload_one(dev, false);
+
+	if (!test_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags))
+		return;
+
+	mlx5_set_fw_rst_ack(dev);
+	mlx5_core_warn(dev, "Sync Reset Unload done, device reset expected\n");
+
+	reset_action = false;
+	timeout = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, RESET_UNLOAD));
+	do {
+		rst_state = mlx5_get_fw_rst_state(dev);
+		if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ ||
+		    rst_state == MLX5_FW_RST_STATE_IDLE) {
+			reset_action = true;
+			break;
+		}
+		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
+			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
+			mlx5_set_fw_rst_ack(dev);
+			poll_freq = 1000;
+		}
+		msleep(poll_freq);
+	} while (!time_after(jiffies, timeout));
+
+	if (!reset_action) {
+		mlx5_core_err(dev, "Got timeout waiting for sync reset action, state = %u\n",
+			      rst_state);
+		fw_reset->ret = -ETIMEDOUT;
+		goto done;
+	}
+
+	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n",
+		       rst_state);
+	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
+		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
+		if (err) {
+			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n",
+				       err);
+			fw_reset->ret = err;
+		}
+	}
+
+done:
+	clear_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags);
+}
+
 static void mlx5_sync_reset_now_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
@@ -613,17 +672,13 @@ static void mlx5_sync_reset_now_event(struct work_struct *work)
 	mlx5_enter_error_state(dev, true);
 done:
 	fw_reset->ret = err;
-	mlx5_fw_reset_complete_reload(dev, false);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 static void mlx5_sync_reset_unload_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset;
 	struct mlx5_core_dev *dev;
-	unsigned long timeout;
-	int poll_freq = 20;
-	bool reset_action;
-	u8 rst_state;
 	int err;
 
 	fw_reset = container_of(work, struct mlx5_fw_reset, reset_unload_work);
@@ -632,6 +687,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	if (mlx5_sync_reset_clear_reset_requested(dev, false))
 		return;
 
+	set_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags);
 	mlx5_core_warn(dev, "Sync Reset Unload. Function is forced down.\n");
 
 	err = mlx5_cmd_fast_teardown_hca(dev);
@@ -640,49 +696,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	else
 		mlx5_enter_error_state(dev, true);
 
-	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags))
-		mlx5_unload_one_devl_locked(dev, false);
-	else
-		mlx5_unload_one(dev, false);
-
-	mlx5_set_fw_rst_ack(dev);
-	mlx5_core_warn(dev, "Sync Reset Unload done, device reset expected\n");
-
-	reset_action = false;
-	timeout = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, RESET_UNLOAD));
-	do {
-		rst_state = mlx5_get_fw_rst_state(dev);
-		if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ ||
-		    rst_state == MLX5_FW_RST_STATE_IDLE) {
-			reset_action = true;
-			break;
-		}
-		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
-			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
-			mlx5_set_fw_rst_ack(dev);
-			poll_freq = 1000;
-		}
-		msleep(poll_freq);
-	} while (!time_after(jiffies, timeout));
-
-	if (!reset_action) {
-		mlx5_core_err(dev, "Got timeout waiting for sync reset action, state = %u\n",
-			      rst_state);
-		fw_reset->ret = -ETIMEDOUT;
-		goto done;
-	}
-
-	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n", rst_state);
-	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
-		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
-		if (err) {
-			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n", err);
-			fw_reset->ret = err;
-		}
-	}
-
-done:
-	mlx5_fw_reset_complete_reload(dev, true);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 static void mlx5_sync_reset_abort_event(struct work_struct *work)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
index ea527d06a85f..d5b28525c960 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
@@ -12,6 +12,7 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev);
 
 int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev);
+void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked);
 int mlx5_fw_reset_verify_fw_complete(struct mlx5_core_dev *dev,
 				     struct netlink_ext_ack *extack);
 void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev);
-- 
2.34.1


