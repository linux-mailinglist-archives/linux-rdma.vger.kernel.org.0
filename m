Return-Path: <linux-rdma+bounces-22560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zDtrI8+3Qmp7AAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BD6DDFB0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=HVFp1vtc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22560-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22560-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B0C33001D54
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57538399A;
	Mon, 29 Jun 2026 18:21:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95478EEC0;
	Mon, 29 Jun 2026 18:21:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757311; cv=fail; b=fT771y46yrDipvtKIrP5x16D1NWbHCBFyK5/78/9ru9HGJ/avejdz3ZX3F1bhUx0vvbA7kvPqYD5UxRV8V2RWWJxdkZ3K2d37guqgOCDIjRDF6ncLutbThrRv+XTZF7pllsJkcki2ryehPxiBm2COVxwBLI3NUSfeQ7kGIQyiZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757311; c=relaxed/simple;
	bh=RoW1xLNqkr6WVJSgd7G78abNw+yVpijwdETVHxNBDkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dngxr6A/31z/VlzVk3P2BTijx9CZbn9/4DI+F357YR05HHdNbt6gtlTPQVOzWrPxxMvg+IHEJB1hlMw/R/g6cewTrZLrlnmoHLmhZcK4Bd/H72f4kvdVzGA9VqaNOvdTiTJUIxHV0wPjOJsxjqVs/WoggpRhoNk0R2wbSzTaWrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HVFp1vtc; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3FJIgmz2G4vitUGBb84wvjqeha66fVYbRoeaRb9ftQlYIRqVZjv3/BBFqIkJRvRLrLoOZVObv4W3bOFxjjCColWPTyCREaWZVt6OM44uIbKsOjm0ClhrRhZOmqI8/x+opa0r06E3MheNA9OUVHjL7t7o8eZ/5yNcWytkfj5RT7Mhn4gcbgD3r4m8FRWsvWN5MFDMblDuJAaihJCy0cOhj57T+qezlXEexfm/niO3Y4KFv1+f1wfvYHYBwHOcZkaXVUecNwwYRsJSfAz2jWl9AJuJNMZ5ZKgsEC9DHDP1mpq5NUki7HnLqY52VqTF+AUYKF9bVBUIV365PwUQNcckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rQj2u02+BlzS7ShDyNMjWS9LBoOsUoIsCoVRGDz84o=;
 b=BlKIHB7UpcA+FDezThashrIzbFsgJqHb/nkkpgoG9hz8LLan2hoMpWgKEnItQRW7M4P+F+gzeWoMFbZqdVZlAT7pDn5pHKcpBsIG/3heQKczPbIo/VzEjhtRFi6VGvydJUu8tnz84FkEQ4YbOteXg3gexrVHrYpKjh7KSOSEus+pHDc3Y8FraJjE2ojS84Rj5LH0aEVNp+qVW1fzyO8pyefFPvbwEH4NeIfb5FaIsXyD7lKZIuGHeVOvvfPpG50aiZ8aLYMS5ZJWTv+T++BKKQeRpa+cVotEdmaeD9hRUYdOV6GUiiNlpDCLQ48qx334ZhJO1pvDVzzg3odb65wQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rQj2u02+BlzS7ShDyNMjWS9LBoOsUoIsCoVRGDz84o=;
 b=HVFp1vtcaIRV7Qx6NXUGozRNe2FYqlfVXPm9Oj8JZNIo03J6nDDY1/M+syX6RQsq4h4c/v+expGIgFseyJ1UgnrLDmDU4VfchHJkwyhJEwZUmPtwKetLUr22CtO9M/N2H4fXCOYP00Bs/hKfc5va8K51jzI5mMz3fJDvmtSaSe8c30JCindCoqUwl1h5hBWABJBE6CEd0izxmKzIeW7Z8xuB1a+ka7lAHleYWrnn3OkV/d81jrenretkF78ijmugGB8T4U9em4dFv2lluNQd/uX/JeMayjeoxHiJU65Dmb9PAH0vHkdNTQVqXTh7yUNKRZSoZRgxZpgwwqA5/fT0ew==
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:21:44 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::3d) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 18:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:21:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 29
 Jun 2026 11:21:08 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next V4 1/6] net/mlx5: Clear FW reset-in-progress bit before reload
Date: Mon, 29 Jun 2026 21:20:56 +0300
Message-ID: <20260629182102.245150-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629182102.245150-1-mbloch@nvidia.com>
References: <20260629182102.245150-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 2381b2c5-dd13-4d92-0469-08ded60b45d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	hDuFQMzZVcSipWRZ3deTxym6uGeyy8wLt5k5lofVotLqBYNDBULtqoKBi33UJAVqXtA2CqoFW8krwlYOCqo/uCusKokwQ1TnyT3D6WD9AVTyc0WHZ4JvvjCCtfMmVBBNZdeOIFm0JaD1dBLXlvmlR24BSAwCbk+GDFjJeYC2oAdJpJqA6EF7QTh7cumSGz0B1LuamIbcFqFKvSpnHAIP1Egki+2zWq/6tgPkbkI4XM+/MRDKKAlldxcCEiAj9qDxLH388bzXkKOf9hGsWFXsvnaOlTVOEMqfbv4n6JnOSDDfoQqLMhtsF5GpVnbMcSdWvJFgZiH3XPvpD/8VxMvO+ulPMZ/H1q06fHvt6DURCmNUIs9N5QnOxsDqbHdBWebBIlC9TU5S2lMhiN/j6oi/7fjzfpUiUgZ3/N7NHAZT5XKiMe8MdLJ6Y4a4QcaUmUTEJ2zUKWS3zWihlXDj/Q/s+6uzLKsgZVaw3UOyi2EqyG44BN+HRV7gXeKguGBtFg68CSklXsOmef1KCei6LPXKaXHNuf/yBsKQDDxy1KwdCSCyZWk5axsZLm6Npt0ilFLlmqG19BHnFzdAbsexY3s9o9B0vsaYN010GMVF3HWgVgfLFdsWqF4T2fHeEGWWOKONia2Vpmro6egNaLxKOGW6oKON7mvIM7O4AeYKuxIE56A1CdUp8igv3BOZ8jjM7lFd
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lCqy66ypcgRayWnCK7JBGxfvhikpyxZ47hTB2AmEKsJeMQ9VCqrXkKHcIKWGJhg4CAueS9cJgVHyx4Nyc0PrmksfVCshtB49P5DHTZEOX3OYeWnRYkSHGhIzRxNEYnO6REJ4wheIxpKPeRCdvZR3VgmgJ0ya9Ig3xVTZrlWsSd/M9qOaOyyN3Yck9XQUfFR+idWGdhi3iIUR6r7P0a8z+Cd3/+BWzhI5dYwls4i984a1KKoa1zrXbmKgUxQbAQ4itOOA34AhW0/i3nHtfpb1Tti8CQr3hg2JGJiGtMldPlynrG1O7tODlfPtSBTy7AgrHPUdzx/o8HoPzHtVO+e5ihDLEYiqBJWqhcyPGRIYhtzF4rTVUReayEFVfi71nge9ndo7O1Z/I9lsyreTWqGCi+ateC/UiSSfi9JmyjZ1SZC0vCrPHpe+EBNCifV+d+uK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:21:43.7683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2381b2c5-dd13-4d92-0469-08ded60b45d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22560-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:moshe@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 353BD6DDFB0

mlx5 sets MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS when acknowledging a sync
reset request. This bit blocks devlink reload and other devlink operations
while the firmware reset is running, but it was kept set until after the
driver reload finished.

Clear the reset-in-progress bit once the reset unload flow is done and PCI
access is back, before reloading the device. For a reset initiated through
devlink, clear it before completing the reload waiter. For a reset reported
through an asynchronous firmware event, keep the unload flow outside
devl_lock, then take devl_lock before clearing the bit and reloading
through the devl-locked load helper.

Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 07440c58713a..7283e5b49eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -238,24 +238,30 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	struct devlink *devlink = priv_to_devlink(dev);
+	int err;
 
 	/* if this is the driver that initiated the fw reset, devlink completed the reload */
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
+		clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS,
+			  &fw_reset->reset_flags);
 		complete(&fw_reset->done);
-	} else {
-		mlx5_sync_reset_unload_flow(dev, false);
-		if (mlx5_health_wait_pci_up(dev))
-			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
-		else
-			mlx5_load_one(dev, true);
-		devl_lock(devlink);
-		devlink_remote_reload_actions_performed(devlink, 0,
-							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
-							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
-		devl_unlock(devlink);
+		return;
 	}
 
+	mlx5_sync_reset_unload_flow(dev, false);
+	err = mlx5_health_wait_pci_up(dev);
+
+	devl_lock(devlink);
 	clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
+	if (err)
+		mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
+	else
+		mlx5_load_one_devl_locked(dev, true);
+
+	devlink_remote_reload_actions_performed(devlink, 0,
+						BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
+						BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
+	devl_unlock(devlink);
 }
 
 static void mlx5_stop_sync_reset_poll(struct mlx5_core_dev *dev)
-- 
2.43.0


