Return-Path: <linux-rdma+bounces-22842-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pPGmBmk7TWqgxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22842-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:46:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8471E610
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:46:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=dfB1Gm9Z;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22842-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22842-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F4AD300AD71
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6843B6FD;
	Tue,  7 Jul 2026 17:45:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3643B6DB;
	Tue,  7 Jul 2026 17:45:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446358; cv=fail; b=tTbvfIWcQoVOIhruWlWqz5tTfZrIHI0aeASIJtOmY2Dpa5i0QN5SWuIHE5A9a5f/nAKnNGBJ5/l4HwoEke0nCXxREy7D/zcEBYhAvEBzi9tQAjhX9gVQzd1dxxwwUVRHk9ulWMMZePNWVkM00PEJJpcDQbPLD975spF6iHO9/7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446358; c=relaxed/simple;
	bh=RoW1xLNqkr6WVJSgd7G78abNw+yVpijwdETVHxNBDkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaFLj5pFc+0PJ93RcwxBNmJKv9wapvCwjGU9BEIq7oAeLUr0mIWInBJOyYRWaHd1rgj0GRoJ1XI9EgX3WleZmwNmR9yhqaWWsjrOpa3h6wmMaaBB3YZ5CEBWwKLRscj+gDMbAIvWDwx5S/8B/5+8eMa9/plcoMkzKa/Zt9NtzCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfB1Gm9Z; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrXdMlsCykQGNZQNRrHrrOFvxfQcbF9SZ0qEqwNV/pBvtDTDyufIsxiiV6VnR0ZvmUMmMzOVGb03HurTP/0AC+A1+QRSkJXlL22ggJjQs1bSdQl1TV7NwE0RL0xSCARtWIZqzWja3O6KZ1KMmbgZ0V3I2Bt2uadfrix26rI0Wgwcp8fmEpXDyu4qnfXOGDQuHA224HskhiYrZ6i7YD0zo+2pknsoVHC1GLnuaiS6OyedKO6L2daBVpeeKbJ0vyps3Q/hNEUqq4CqHeCp6e9ZAMOGigGW0GYaAknGJtYtrFPKbjY6Eb0gNKOduZ+M+FAYS6l8Ua291lbqH3pwCMvVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rQj2u02+BlzS7ShDyNMjWS9LBoOsUoIsCoVRGDz84o=;
 b=cPZOkUXbrq4i38OFfhDM9uF/mg7ZYPXGmDVuXpzeaVhXpniSDguv+UONwgLDDSqYwfnjWUP3GO2f2SQJQJW/JLlrKR5fIja1UNVd1m3pOex4jdJ/fdELvECSyek7x6geiFHKS6ch0Mg5czv/e83TALEs065BwdxW04uewQXBHxANHJOWuLPmFseGEm6fZmG1Rx7X9wjWfPZz0BXovvpWv1EJSccBWNYrg465eqh6eAn5D6uLc2LyFr2FZkH2ndVMqn3UKWQuvuD4+llLTROcPF+68d6lKj3hRLKxiW0aYQfBcne6celSsmADT8uhQD4k+Co9AozV5KvaOaAcQEHTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rQj2u02+BlzS7ShDyNMjWS9LBoOsUoIsCoVRGDz84o=;
 b=dfB1Gm9ZQ8qFbaG+ApKAJmBrDStO6yU9DTkAJ/+wW7CJfJWYSFgyxeflPCqpEb8A3/FVnxZ/ZZzIfEYSidq+zLaZDAE5ArpY2qAijxF5Br/sscYEgFANmdcQINFZHg2rZxkhUQ8pyXhuUVW3P/5z60kKErdHIWBxyqdq3Mm3OOco3IUE5eKg44nnUV47/h/nq9J1TEnDZ4Mbz4gxVwBOo3XRNaQIMjuaPUSYmvcb5fA0BSNtMJmEePHVYmWYdbqbRTGU7J/9GzE3MLDFyc1ZMCunCtlAMuA2j6XeRVw9UjSA30pm4LlyImYxITXXXxqYbW3UXnOUkGnCYT7FuyN0Lw==
Received: from CH0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:610:b2::28)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 7 Jul
 2026 17:45:52 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::5) by CH0PR13CA0053.outlook.office365.com
 (2603:10b6:610:b2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:45:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:45:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:45:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:36 -0700
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
Subject: [PATCH net-next V5 1/6] net/mlx5: Clear FW reset-in-progress bit before reload
Date: Tue, 7 Jul 2026 20:45:22 +0300
Message-ID: <20260707174527.425134-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707174527.425134-1-mbloch@nvidia.com>
References: <20260707174527.425134-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 356567ad-73c8-4795-9f58-08dedc4f9651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+YkykMTFqrYermC1w0Onrh8WU9Jljit75DtdtxS6BghUtn13nO57WDhHpyEa9RZ22mLKfylKUfqVFkgI8eKCLi1tjAlQrpGefrWVBNQ63PlOpyBGHU9nH8V1U6RADqGSvK86LVBi3g345TOwCwU0kyjh8wNhFjPpVSsO6duz4eF+f6KQSb/ijJHHUVM+ahrbutl3bKMWVr8BhFMP/oZtXvGkWB03ZFYEfE2nhlC9u4E7tHFti4Z4TboAWLHppWarIlndryFCPGqCTyrVUc8AXgWdWnP/XYVqFoSaEF4BIx7HfNdOWvrtSn5vTs95BdgJo3MB7oRvwD7MI/EYmPu4xkDcCpyIzwrFO4d6B9L7Le1g/ZoammQTbRerflcRngg4kffu90PEYABWZBWOK2rQUSCQp40IMiCXi4y4E4hqVR770hC9N4SUJtHKpVvgthqPNah8tuZPISGFGK51jM23aeK8T7qWJBonI2E0U4innzqJ11L8uPSVdl6odYP857gK8LhuHBX26jSnQ1+BJhjGjTC3JR7r177t9IEeTA2x47+xSeEmmz0oJKwKotMlzerBfyc9q32uZfnQ3nIfbonNi6eUc+H19lWa1x5ol93SLszQCbp5tjX9JUg70Yce/QnqnxX2+cynKpS26OYaGCKkzA9oV8lb3rzwb2W0hrNgfnDoYngo/Lt35Uz9xkhtHL/3
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GwUbe6pr3FzZItwX0EVkJQxXnO2HMxK6FSmU+Ul9DA4xViO+3emVJ8B/7ynph0mGLeTvzaY188D1xVSs9x6KloXKnXbjdcdxZQ/XOR0U1Uf2peqxYdJ8cXe7RT4AXnxbVzn3RDYSafzdVWRorrcKotnWYN36zPVOPu+IicxwL77ymMRlO1ciT3Cx8SCxm4n5pxz8I/ri6yiZQLsrNNYma+nNkvP0ZgcJ/jz7VzGA6a37WOSC0yuEr6jr3muV7eNaSornNnBM4gIGt4lzP0OEQhou6fPWD6np6G/9TrwQZDdX5e+wNjt0K7+oLKIEP5GIv3qllEggh+KVYIFJnI9zUdFgyWz89Kj9eYX3y6s+5dxEb6bMTz939mVwKETv/iV0EyaNv+bOFbkmqpx1l8jzX5PUkjQKov3DV1GJLqZpWoJsmp1SWx4f+REv39mCBL/K
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:45:51.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 356567ad-73c8-4795-9f58-08dedc4f9651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22842-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13A8471E610

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


