Return-Path: <linux-rdma+bounces-23171-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yyOfKp7UVWpNuAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23171-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:18:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19AA751678
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:18:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pedpX1bT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23171-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23171-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD17303CD2C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C938398E;
	Tue, 14 Jul 2026 06:18:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C834CFDD;
	Tue, 14 Jul 2026 06:17:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009880; cv=fail; b=mkQzeJa4jAYsKWEXIE7h9xRX7sHFu5YTxEfOsiSZBYSKCjNbDBpCCuIxHKKLEdMVeuFuBxEgcQ2k3kX69gO26c9Q/ZoT76eXgkyabjpWB7vXiCH/OxWny4+gw7qLEvQ8lGigJbqQHMs+bbWdne0RvDquluWBVFWYey/FU/pLYzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009880; c=relaxed/simple;
	bh=RoW1xLNqkr6WVJSgd7G78abNw+yVpijwdETVHxNBDkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPDBfE6SlgQ2MfkrMWv6RVRm2dwwyNYmUPWF+gA8q0PvmtmI1S3tJwcnYgKhXOBegSUVXCn+m17exWRnpq4vBWP2MHvGk/YhiwkR5Up7tZJWdx29Y6cxwM+FNFSYb1H17Pf4Q+80vE8tnrThkoyC5VGm7XerzwhKNE2qyOwJDNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pedpX1bT; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=perlDvUjKsmGW8f/sdspMRXtcKQ46RArVUu8NDpgRS3BVjiyLoJurcPkAX3KBChUOJ67D9YQlpGICJi9CZ8ScTvPhn/ilBt5uzi4KripgI9x/IXhOp5dXrFN9lRJhhBZjZaYeX7IpSP2ADGv47A3y/ld/3oecHXG4vkiX019Ix3WCvPtryUb6PwRBcbvsheli7oMmb8fMQ6Gt/wQC5ILP2WHvOTxwD8Ucw8Epu92krzmTOzhYsVm4W3ckuE6ygGYE2fpPZoacn2SzcFIZorzTg3ZZkMVIs4cmgOahfmq1Vgm3npUfr/iN1VktcLKhDQmWv7R03/nfiUnaCAfFEMPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rQj2u02+BlzS7ShDyNMjWS9LBoOsUoIsCoVRGDz84o=;
 b=ScRLfSOX0/v3EtPbzd5MUvfxp9T7W1If72Th9io+OkrFJq8orcljITHPyibNSIwP8AEbzL/xwPM8krJYyMl5H63Uda1LjnvBxhseKn5S/ohCKcNwXa8ab/ZWWdRAkEb+eUfntNeamImHpepHOyaNb4InGfVo3QruRye+7/mJ6fAH1Uyd7CqyFvCLElcBAckhlxxWWKsYtuRgkhmi/LhAYy/kytyJiQMGYPcZ3M73afMdkfH77ZYDDKCZ0l6cnMammCpDqkV4P5a9QBFA341B8iJMX6OAkAuNzFOEVJDWLgfs+rQ+iRwJEDeonILC8PUnL6fdTyJlc92kofnwrl5gKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rQj2u02+BlzS7ShDyNMjWS9LBoOsUoIsCoVRGDz84o=;
 b=pedpX1bTuuCv0UG7hRDow+Fk4vSEKtV3IwF+wSp9xzwotAT9hGD8SgZoJDRdZUlDsqm5dLbvzUFWshnLTl2WUJ/qs/yYFwh3S9czq31c7mXnSWwVda+mdy1EeR5l4tZLKdOCK4iHPRnkhp544jZipyHscspeiM2iGOhbO/STUPCOFKV9Bp9tz0SVKWQKYa8vU7bJqLxuntdW/+tDu+MNrZcrCeYvXQ40fMkHvGyG1vjge1QvxUPutxVgEWvxnRtVFHwNVtgMvvi5IW1Ggt5uaSFLDco3BRiThPArrehkppvmuowUu4Xc5i/C58lTWYLH+mQr/Rnq00MkzzFVZvh6cA==
Received: from SJ2P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::6)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:17:54 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::73) by SJ2P220CA0003.outlook.office365.com
 (2603:10b6:a03:5da::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 06:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:17:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 23:17:37 -0700
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
Subject: [PATCH net-next V6 1/4] net/mlx5: Clear FW reset-in-progress bit before reload
Date: Tue, 14 Jul 2026 09:17:27 +0300
Message-ID: <20260714061731.531849-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714061731.531849-1-mbloch@nvidia.com>
References: <20260714061731.531849-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: b499070f-8ec8-447a-85f9-08dee16fa3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|7416014|36860700016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MVsbLmCs4d+SnX+tepLE+UTgtmKembJULIHDt4BTMuX9vVFXXOo2vlwCN0veYEPuoRoyOtdPhPAc+6YYfH/4MSQBERUhIDHTP7IsWSp8V1rbE1+rNqfNQd/OEsT/AyI4DV1/1FfJIY/Y2xXvxKw8seNv04JeNKfG53BYTaTBHkmf3dWNq0Dc63MwDi8DPqfFAqpkuhTmrcL4QJTTievm8FgG58RKXuud2elrRgTRhU/S6AvLXwCq1knByJ/EB4nPXN+mvhr+Px+XeIXdGQbRZHoxrkf4GVcJRzfrb5x0XZcF5JTzO+oCKlPLwnyXCVFR9YRzo/UE+tgcgKgKrYoxlUW4sXNvFupUcIY4DKTWTd67mwiTWTs/s6jMeaNIiOwcXIvBjA8Tcngg4C9JEzDHVDf/C0QL6+eJmHmJ8Ju+0gYSGZzTRCSQpppifqP44d0sZFyRSqWSD353+hTYHrhxrvtb/3ltSGJIkRnifAS/LpGOgM86+hDuPrL49YzHV259uNlTz9xCZ9ceyM7BMfCGemxsKAXRweR9SZYMy2y49aI9Z9eD4m45PWakgSvS3rJM22KQWrIJVV1A/+nFQOKxnwZUc8p0bgY+vHCy67nd3nR3aVt51gKx7KU2P2oWiTlxa6qDw3q5hJ592FkQrjL2fJT9FFFPrIl9B+VlMgj+oRd+Avg1I3PrF8bOngdq9R2n
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(7416014)(36860700016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QVtblH8o8TUebFwkT+es3bFITngushGgzPZXKOPZL8pOEu4ztX7cXPK5Be26cvLFH5MBdx/QgsOxkYqObQUWHMjfQviS3FefWJp9+Cz3R7eVVvphscDQoPch241+P+kAIhuvxA0HlKglIWUV75Rp9NEB2NF1AdE532HGG3kVY+sjl+RuGGBqULbXLD+qeluyrjLiwBzBVRtqYdPLpSn1XXRna+RSA01oQuV+xcaH1iQbxMC2AT+oloGhA7jIN+7dV3OwGx83E/dhu/x7SNYCLFw1l2ABVw15uf/0u/mXb3stcA947c8WXrnf2Ni3mF/k8xmT4mNUG9H/L2jqBSb3LeaDVPntYXITV6xDtyYyCC4Nidp8Y+6JkqJ7jySNl9AOS3qvi9vaHsaU0TnfU8uYsWX0voPjVFXUCapjQnvf+RhGTVf+toY2t1cZ3q5S9ZN8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:17:54.1377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b499070f-8ec8-447a-85f9-08dee16fa3f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23171-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F19AA751678

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


