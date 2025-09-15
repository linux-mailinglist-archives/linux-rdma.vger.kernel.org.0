Return-Path: <linux-rdma+bounces-13375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9AB57B68
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0056C7B0A40
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B3830E828;
	Mon, 15 Sep 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GZnbsyxT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55630B53D;
	Mon, 15 Sep 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940142; cv=fail; b=bspmIi6+nHFlyREuM/agYUGG+Du0vr2YBirQ49zyF+urmAQGId16qMXbsdwe0V/bumQ2qknx8yetZKfkTBjLV4m58+HcgOfGKFCFncsFO35Yo8O2P2t9Fzo5Et+/blu6H7lQWucDcpHQFrk53XsZEUjfHpK8VfeL36jl2gESwQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940142; c=relaxed/simple;
	bh=CfKesXywrM86LMoaohDw+m0M457yr9MTXXH5pseX4zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+4H4vUMDW/jvaMJpq1rbde2niw18UmrjoFGGXvsjPDkXUeqz/ciiFYjemXI1b9gVoLiHBJKWZ7vcsmFIkwgGiiDCvyeri2eogdklMEW2wpA2P2rLAf1jiu5ZeJJ5nh+xFKOOkQ48r8RGyhMTC6rLNvuNxXDqs1IjTZbFzI9Cu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GZnbsyxT; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/Rf4h04xxmfJKid5CwphxhFIVN+BDIgBTr8ZpNqIBFIvfPtUXtbnuyrxcEZ1S560QY1CBitzs4PNcuq7laZsl5NhSYtF4y4A6P+CzzusvHAwkBT5XJvuSXrHIZeXIvb3o5cfETrjFVVuRL3Hxc+OobbKdy377xp8UErxRBzxNQnDc/AJ9riObakQtuWI4fYAjIZ+ZsiOLoEPIAXbOS2GdyCfv3Bp8A5leUAV7QPBFNmSEImBmtlwXbR8MMmehazN6AwHXqhTMkqBtul83Nw53l9dU6gPsw4Pv3fJeJ5okFQsKDMlwkPl+sLpEH4nFG8hPOENpmgFfYp5XYMdxe4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6btaOgzBc/vOo0m9aDgalqCMnPc5pVGofMa0KQ74o8=;
 b=uaX0nXcTw5mpGhRaTgr36oWYHZJ2o7kc+TGN8A3sMeYsANOJeSouwcYW4x9rzMyJuHRU/13Qza38LzVXGmi5FzwH/u6tNmqbCm08HBmEYOcEKbY3lBdU8YaMk/ycZVlc3k0xVEkCx1CeZixmqoLeQ98YjOl+iCDaENJSx3qWtGBErGRmoukNDvTnz7DOxrhAvEEQjJZ0kvthX19aKz54KPpn8DadfU17tcdMOmHfH0R8Qi6OUWsmmQPrcla6G6ZtJZh1eZFm7bWoLO86WUvX3wNY+7uyWnupERUhoQsVceJv2wV524PqXBeVSl2Tw4z4Ud7osVS3PtQyUbL+bVynNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6btaOgzBc/vOo0m9aDgalqCMnPc5pVGofMa0KQ74o8=;
 b=GZnbsyxTIfveVNWcaYmzDlNH++lMSXJ3CV0qCtE7X8XlcMZ9a1d3Po+bMcTDlUiyqWFtsq0DZ18HRTZb2gCLfteKqmZRvKYgi4wtf/jqzEOEICcEJphZ5rJROWyA5VAdID08hvC+dSF1FUPzOjiKDeWs+e5w+dewDE9QA0o57vLmcVvOUilg0dHJVbjhwsWJs0akw3qsdrDirqEOOmGLxtziHmuUV0nS6EGkOGWg80NC3qcRsZMO/NzMAomDZMt2sRhEFUhqpAgWWGIzru6itwYfJHAfOce6tG14QN51fVw9cMrtjPhmyZE/1oT+BApDDPtDys/b4XhOGG12+hchMQ==
Received: from BN1PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:e1::15)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 12:42:17 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::d) by BN1PR12CA0010.outlook.office365.com
 (2603:10b6:408:e1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 12:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:42:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:42:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 05:42:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 05:42:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next V2 4/4] net/mlx5: Lag, add net namespace support
Date: Mon, 15 Sep 2025 15:41:10 +0300
Message-ID: <1757940070-618661-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
References: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 215cc34d-29fa-48f7-9708-08ddf4554dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHBFdlNCTmhwNFk1RHV4b2ZwcXlFdmdtajVvYjRzTHBWS0ZnZjZxM3dxeEVE?=
 =?utf-8?B?VG9iTG90M053MmZkNnBob2FFNzhlRUJWOENac3Q2elB3V0R6THRmaGQySG5V?=
 =?utf-8?B?blE0Q2hoK3BTLzBBNnZnVkNoTXkvS3R2dHl0dkliNytVRW84N0JzaWZrTjY0?=
 =?utf-8?B?OStLTkp5ZGZBa0VwSWRpUjNINUM2UzRkUFRnWXRrcXFvNGpVb3RXTW8vVUxa?=
 =?utf-8?B?aUtnVFpvaW56L1A2VHdxMTJ3bUxtRXBRNWhjWWZwdGFTRTJnV3dObXJPb2c1?=
 =?utf-8?B?eW10cjBJZ05lY0xHMzZLSDBBbHp0Sld2Y1pNdFhqUk43Zk5KaldsM3dmMzJy?=
 =?utf-8?B?TnFtQVdRTitTSzlnaGMwVk5xRkN3TEJHdjlKZjlKOUExV3BtcWEzY2MwSS9j?=
 =?utf-8?B?R2lVSEJiRjdaU2c0WlFMNzRhQWVKdzdSU2NnTS9uSTd3cEprNGVCSndIUHpP?=
 =?utf-8?B?bURDV0dOVWVHSmdsa1RlRlQ3T2d3OFozalFTYnFPSk10bXM1NFVENGR5bEth?=
 =?utf-8?B?YWZxbkZKQjdSdE8yMlIxNWdwRjdwbk9aNHF0ak1GS0N4K1hMZnZyS2t5cmc0?=
 =?utf-8?B?eTdtU0JETDhjSHl0WkpMMHY2dDBqeDF0L3UzMmk1dCt5QUxUS3JYOFBHK2N0?=
 =?utf-8?B?ejdTT2FGUjdvcGNIN2x0YW9ldmJacDgzeEJoTlFsSHd2bVFPZXVTTkxuallN?=
 =?utf-8?B?dzJkMGp1YTNaanVheXhkTit6MGptUVBPUGF6ZTVaNk9ad3dHM1VxMENCMVRi?=
 =?utf-8?B?dy9acDBsQ3lYdDdoaUVZdjJZWEFwc245M0hKNDJXdHlIbDBYNXA4K0lwMFFR?=
 =?utf-8?B?MVkyNVgyVnA1cHpvcytObE53bHhVKzNaenRTYnVqdGdoSHhXZzZocERVV3NN?=
 =?utf-8?B?UGJMdFFtRVRXdnJ3a1FLdzZUcktTZ2MydlFlRmJxQmJjVkVUM3VVN1RJQjZO?=
 =?utf-8?B?YmFjWWhGcUFNRmhGVW4wSlpTamtXV01JNnRpYnMrM25ydmVVd2ZrTDY0MUdp?=
 =?utf-8?B?bFJ5d1dZckE4aCs5NWNRNEZGUlgxMXpaL0sxMjljMnN6WWhRVEpIWkUyc1Vq?=
 =?utf-8?B?THJ1U0ZXclphZTdMVHUyVFJXa0lmd1dVK0Y5SXl1a3oyQysyeDVBVXgvVHc2?=
 =?utf-8?B?S09CUU1Sd2laM1hlZnJCZ2ZNamY0Wm1KTlppclErT3hpWU1kOHN1bXJ6eXV0?=
 =?utf-8?B?djBBb2JXLzM3R0FySVRIUjdwOVFRSmlUR3ZLSEFFdC9hVnVNcVRxVlk1YU5G?=
 =?utf-8?B?Z3VLS011OWI0aDlEU0xxdW5HVlArSmJxUW00ZXp5RDVGaWNSckVJdzMzZEg2?=
 =?utf-8?B?dExDbnRqdmFIb1R1QlJJcWIySXVZNWpxbHVSQ1pOVjdFWG1Bcmt1bC90QWVQ?=
 =?utf-8?B?T2ZGWHk0a2xMWmdKSC83aFVKYVE0b3JZK0dxSGlKSHljNTNEOUFwTjhLbzdL?=
 =?utf-8?B?eW9GaGdsQVdHOElGQXNhTGZ6bTR0bDBVN09uRGg5MWg0RUJoZSs4L0pXdWVD?=
 =?utf-8?B?SkhScG53V1FVOTlnRGx5R3RCUjBtNnUvZGJKNUpGTUlib0U2STVwdGZPMU9v?=
 =?utf-8?B?RmZHRWJja2tPRjVJVE1xOXJxTm8zYm9kdWlVR3Y3MDRxUHZqUHlXaUpibFYv?=
 =?utf-8?B?eklKaDdZbVhHQTR6VXpWVGdscFV1dlhJNXJyT284aXBWUGNGb0RrUmdFclhC?=
 =?utf-8?B?V2grZVdhL2I1Vjl5Y0tRejQvRVlHbVJvZ0srano5R0ZObnExNEJEOUZCdUtz?=
 =?utf-8?B?OXM5d24zT2pZb1BjaTZGSW16Mkx6YUVoUkRuZ1lVV291SGRmZk9id1NzYmZK?=
 =?utf-8?B?L05ROTZXdHNCK2ZGR2grZkhlK0c2dER3SGkyb201ZnlZRG11b0xwY2pNR0lN?=
 =?utf-8?B?Qjh4eFV4RGQxV3dsMGlaQW83T21SYUJVZnh5U3ZRZjNObEErMk91Z2pUSXcz?=
 =?utf-8?B?Vi9LNEpJMmYyV0pkemkxbHlMSzh0S05ncVNqdnUyVjREaFlKZVZ2QlRDWHZY?=
 =?utf-8?B?VEhuRHRpUTJJbTI0L1hIbDZFZDIvaDRMV292YUlIN2RzTGR0eEZ0dWtOUEh0?=
 =?utf-8?Q?e4Drdu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:42:17.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215cc34d-29fa-48f7-9708-08ddf4554dda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

From: Shay Drory <shayd@nvidia.com>

Update the LAG implementation to support net namespace isolation.
Recent devcom changes added namespace-aware client matching. Align LAG
with this model so that hardware LAG forms only between mlx5 interfaces
that share the same network namespace. This avoids cross-namespace
interference and matches user expectations when devices are placed in
different netns.

Make LAG netns-aware by storing the device’s namespace in mlx5_lag and
registering the devcom client with that namespace. As a result, only
peers in the same netns are eligible to form a LAG.
Adjust reload handling so LAG teardown/re-evaluation happens in the
correct namespace context. Remove the blanket restriction that prevented
devlink reload when LAG was active. Remove the reload restriction here
allowing devlink reload in LAG mode is part of delivering complete netns
aware LAG support:

With per-netns devcom registration, reload no longer risks
cross-namespace coupling. The devcom client is torn down and
re-registered in the device’s current netns, and LAG is re-evaluated
within that scope. The change is trivial and self-contained, and keeping
it in this patch avoids splitting a feature that is functionally one
unit.

Only devices in same netns can form hardware LAG.
devlink reload no longer fails just because LAG is active.
LAG is torn down/re-created as needed within the correct namespace.
No change for setups that don’t use namespaces.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 -----
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 14 +++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a0b68321355a..bfa44414be82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -204,11 +204,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return 0;
 	}
 
-	if (mlx5_lag_is_active(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
-		return -EOPNOTSUPP;
-	}
-
 	if (mlx5_core_is_mp_slave(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported for multi port slave");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ccb22ed13f84..59c00c911275 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -35,6 +35,7 @@
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
+#include "lib/mlx5.h"
 #include "lib/devcom.h"
 #include "mlx5_core.h"
 #include "eswitch.h"
@@ -231,9 +232,13 @@ static void mlx5_do_bond_work(struct work_struct *work);
 static void mlx5_ldev_free(struct kref *ref)
 {
 	struct mlx5_lag *ldev = container_of(ref, struct mlx5_lag, ref);
+	struct net *net;
+
+	if (ldev->nb.notifier_call) {
+		net = read_pnet(&ldev->net);
+		unregister_netdevice_notifier_net(net, &ldev->nb);
+	}
 
-	if (ldev->nb.notifier_call)
-		unregister_netdevice_notifier_net(&init_net, &ldev->nb);
 	mlx5_lag_mp_cleanup(ldev);
 	cancel_delayed_work_sync(&ldev->bond_work);
 	destroy_workqueue(ldev->wq);
@@ -271,7 +276,8 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);
 
 	ldev->nb.notifier_call = mlx5_lag_netdev_event;
-	if (register_netdevice_notifier_net(&init_net, &ldev->nb)) {
+	write_pnet(&ldev->net, mlx5_core_net(dev));
+	if (register_netdevice_notifier_net(read_pnet(&ldev->net), &ldev->nb)) {
 		ldev->nb.notifier_call = NULL;
 		mlx5_core_err(dev, "Failed to register LAG netdev notifier\n");
 	}
@@ -1413,6 +1419,8 @@ static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 {
 	struct mlx5_devcom_match_attr attr = {
 		.key.val = mlx5_query_nic_system_image_guid(dev),
+		.flags = MLX5_DEVCOM_MATCH_FLAGS_NS,
+		.net = mlx5_core_net(dev),
 	};
 
 	/* This component is use to sync adding core_dev to lag_dev and to sync
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index c2f256bb2bc2..4918eee2b3da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -67,6 +67,7 @@ struct mlx5_lag {
 	struct workqueue_struct   *wq;
 	struct delayed_work       bond_work;
 	struct notifier_block     nb;
+	possible_net_t net;
 	struct lag_mp             lag_mp;
 	struct mlx5_lag_port_sel  port_sel;
 	/* Protect lag fields/state changes */
-- 
2.31.1


