Return-Path: <linux-rdma+bounces-18803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCA7KhPSymmsAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:42:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF036091C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78284308C5EC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6139A807;
	Mon, 30 Mar 2026 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SwqC01O8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7139A057;
	Mon, 30 Mar 2026 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899346; cv=fail; b=uik8nUitEDYHfB9BHteLC9yvtrGVz/dZY77UIGoaEBV3CkJ5SX478o5Lgs5NDKrZbbd33d4ZPJmdAwAD8QlZxeIoxYmwHSepwc6jD4qj9jPlU07MJJ7E84c3A8c6RIwWA5q32PqPlOd64D6VuIAmBzPGcaj85YEDxYtHbtPDfnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899346; c=relaxed/simple;
	bh=OVd3RmrvqmPFI5xhVeCvOaBSiI2oeZvvwFXdtiHW43o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9vpBdHBB3NUbd0+iED2v4Fs4PbiMOVSQn6artCVtjmRe28L0a2E/ZG6kSx/wVbfKnzddm86Dy1EsW35/Nmo88wYTLdc/l7JPcSzmbHo68GqfIzzcr7qnYqL0lAnjh2+QniN3GNaS7ZHu0nv60Tnfl98XWpvo1Zgfdwdo3aG7V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SwqC01O8; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJxxQrzPufeV9tXChh4Fm2qCRqcIo1ScspRHMB3p1YBKBWBJwPclP8T/mfEk/7YLlP18sVDuakKH85BfHHYZ/m/WvsJ5GDEv4NDlis21Rpeqr8NySNr/7qlWckRCnn8ouXObA7+pa9WoQmj5v1XffN7CWt0NfSdLhK7Ng+emeNYEQKjp4D7qAZuZ4cQ91erO4tNMr3cQOQLCQJy/7P+DTfZOCt6p6UEv00jy9irJuAVDZ6p1UfjPoovuEpLnDvO3tk5KGepjHpbpoF4x1qJaFv++8LYvKxhJwHJBti5L2Fx+v2913mzR6PLiwIpvAelRP1ezI3WTTFQ0A2ZbNWUvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7xU1a/vZn6oCF1xo3iRL7cZxfD4tMF9TclgBMHONnM=;
 b=mWr2VxwtbCaNEWZfEC+TsVk48E5MhCWMDZY8ydO4UfwXoG7MOd3MJrY8DWzhoPAWeIZdgEfZAGe1n4qXtxG3bCY5kWKwPoNXcszMOmZn/JVXQvbVxUITGxDtUtW8ILhpjPbn1e5MH4QkC7HKHDN4hkodJzw0yrACkqii4YHi58rHnuT+siPrXTg59caRgtt+Oxqtir0M5TYqWxuRZ0ggmVFQev/j2Q5M80HBKyYFwpt7sLGq58/MqayorzKWRVos5qqr8TtUTyv68B170A0ZYCh3piQwusrAmZvvzvxlFl7Cg/zBCwSema23yAOgMQmqJE1/FFQDhhMU10NUq1AjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7xU1a/vZn6oCF1xo3iRL7cZxfD4tMF9TclgBMHONnM=;
 b=SwqC01O8emEO4QgS9smzpZnKptfhGPzpdSia4TdSOoFGDnsPnUKoai29BBsp4mIojcZLkmVkJSXkpfoTCY11HKT9bZLCkKDkkmW6EL79KTQhWnDwQc3WxEvVA1WVhHiJOZcDwKMeVMSVxmJUlRboYZ/M5W4GMnH8VZM7cw13m2m2V4V+8IodJK/o+spcjvQxQ/+KBKcuEQL9OOoGlQa721VxmytVHo9Ve+8GkhWRzD0wnrBPFXY4Si05AoClJ1K3wQ5gl7u5sJgNfDWvdEQfY4LyC0HzZQ65ZWk3SBlohNtRN2HWcmxgss6jClyY0NL5d4HooqY24+JWS1jb0pZ/rA==
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:35:40 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9d) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:35:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 12:35:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/3] net/mlx5e: SD, Fix race condition in secondary device probe/remove
Date: Mon, 30 Mar 2026 22:34:10 +0300
Message-ID: <20260330193412.53408-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260330193412.53408-1-tariqt@nvidia.com>
References: <20260330193412.53408-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 80258cd6-0c30-4f1d-3a84-08de8e938652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8Oa3oi5757fEEXjtbPIA/yYX7LhU595cSgHuqYsvbatV6RirV5hxMeWjaWcAHWPeBBCNYrY/ZTZ6RxgfMcA7XO1kQipVTnS/ecKirRjOqk8OsrpvElMx7t0LytFcgZscr8wuk0cSwh49V3o/D0AxfUnKgvyaUA9blx1bFiD/zBeRh8H9BJ/q7p8sh/pCMROtU9uhEeiLRVAD67slw5eVOTMGoAK2o+z9T73V7F0vbLCk6J1ptQ95WY6S0r8OUJgrWzbWKNs+juX0oq6GX4MQdhH+f6kzEeSGqtRRXyPVNX6dfeZjzywd8Y2ChBPYwNpNyYkKuFdA6DnVDIYDF4Gc+IiBaCR4mN5Xj2jsDHUfXVgzqmH7vv+rDqdyy1EhN5TeSiXtG4Syb7/DwTEfT3+NKUGf4bfOAs1lELYNIIdW60MM0c/c36XbdsCr1yTdTIYi/nFq+1nZQj/H6Tn3KAhO7dDuq9snapQA6XmvFGDmXhYQlPdiR/t1YBjrPjB5qmBOEHQUiGFEqX6o1Y5EtM8JlCLYgb0+7GHSCXAYyHbKaBFI1HkibvimZIiH2qOEdIVH3KZ+6SdRi9oBdvszBnFFlgBQloMM8ARoDKD13OAbMNkxysDBYpauROrGAR5UcZj1N6gwbq3sdr/eKI1ytrhIYGinw+I6EAVK8OkFaWSPFmP94HtbMz8x77yay+GurM2MtCHUTGbXTIM+t/3y4IvKYnhR0SGO6EE5aSCdQDIDjq0aLb6YHUPq68o3LL1FJoUIfCQ81pvZZPOnTsjKZ9sagA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a3usjad7eJJqJ7wJ7NFpLeMJDYBCJwZJ/MH/h4vMn7Bjoe4oLFeSnvpu022a5icLGrB9J2prysMM5lTHE+xwZuW0UUKjvbUpYCZPH2jg6vLM9/v60oMUwAUrYbkKI+EPIjtJjGFirzn3HL0caCgcmlXc5Yl+3JpEFtuqIgCBs4qSuDrhjvtmAptnDSciP9x8T0AwnXuq1Mxzq+3WQsxWveZ4iAzaLX21jerzhPhwb7ea0mA8ucdYh8Usqq0vCNTNZfCi2aNNFjP2Ru+CSP4PitQh7GNAkydrI95qmRVNnC0bh+/s1jfYtsRP5fB1EFipnYmxeTSqt8tiMg6XtgEnYC6S+L8g8EI46LQ8y/QcuEYyPs0pKktlBEcBWmuLIjxlgvkZoy5gFMHVJ4Bzh61wPMSivxXCB6aA48M/JJlAPbg5tqzUS8X7hgKNqeQEPL4t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:35:39.7721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80258cd6-0c30-4f1d-3a84-08de8e938652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18803-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 04DF036091C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

When utilizing Socket-Direct single netdev functionality the driver
resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
the current implementation returns the primary ETH auxiliary device
without holding the device lock, leading to a potential race condition
where the ETH device could be unbound or removed concurrently during
probe, suspend, resume, or remove operations.[1]

Fix this by introducing mlx5_sd_put_adev() and updating
mlx5_sd_get_adev() so that secondaries devices would acquire the device
lock of the returned auxiliary device. After the lock is acquired, a
second devcom check is needed[2].
In addition, update The callers to pair the get operation with the new
put operation, ensuring the lock is held while the auxiliary device is
being operated on and released afterwards.

[1]
for example:
BUG: kernel NULL pointer dereference, address: 0000000000000370
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 4 UID: 0 PID: 3945 Comm: bash Not tainted 6.19.0-rc3+ #1 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5e_dcbnl_dscp_app+0x23/0x100 [mlx5_core]
Call Trace:
 <TASK>
 mlx5e_remove+0x82/0x12a [mlx5_core]
 device_release_driver_internal+0x194/0x1f0
 bus_remove_device+0xc6/0x140
 device_del+0x159/0x3c0
 ? devl_param_driverinit_value_get+0x29/0x80
 mlx5_rescan_drivers_locked+0x92/0x160 [mlx5_core]
 mlx5_unregister_device+0x34/0x50 [mlx5_core]
 mlx5_uninit_one+0x43/0xb0 [mlx5_core]
 remove_one+0x4e/0xc0 [mlx5_core]
 pci_device_remove+0x39/0xa0
 device_release_driver_internal+0x194/0x1f0
 unbind_store+0x99/0xa0
 kernfs_fop_write_iter+0x12e/0x1e0
 vfs_write+0x215/0x3d0
 ksys_write+0x5f/0xd0
 do_syscall_64+0x55/0xe90
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
    CPU0 (primary)                     CPU1 (secondary)
==========================================================================
mlx5e_remove() (device_lock held)
                                     mlx5e_remove() (2nd device_lock held)
                                      mlx5_sd_get_adev()
                                       mlx5_devcom_comp_is_ready() => true
                                       device_lock(primary)
 mlx5_sd_get_adev() ==> ret adev
 _mlx5e_remove()
 mlx5_sd_cleanup()
 // mlx5e_remove finished
 // releasing device_lock
                                       //need another check here...
                                       mlx5_devcom_comp_is_ready() => false

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 13 +++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h   |  2 ++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b6c12460b54a..5761f655f488 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_resume(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_resume(actual_adev);
+		mlx5_sd_put_adev(actual_adev, adev);
+		return err;
+	}
 	return 0;
 }
 
@@ -6698,6 +6701,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 		err = _mlx5e_suspend(actual_adev, false);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 	return err;
 }
 
@@ -6787,8 +6792,11 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_probe(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_probe(actual_adev);
+		mlx5_sd_put_adev(actual_adev, adev);
+		return err;
+	}
 	return 0;
 }
 
@@ -6841,6 +6849,8 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 		_mlx5e_remove(actual_adev);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 }
 
 static const struct auxiliary_device_id mlx5e_id_table[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 954942ad93c5..060649645012 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -528,5 +528,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 	if (dev == primary)
 		return adev;
 
+	device_lock(&primary->priv.adev[idx]->adev.dev);
+	/* In case primary finish removing its adev */
+	if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
+		device_unlock(&primary->priv.adev[idx]->adev.dev);
+		return NULL;
+	}
 	return &primary->priv.adev[idx]->adev;
 }
+
+void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
+		      struct auxiliary_device *adev)
+{
+	if (actual_adev != adev)
+		device_unlock(&actual_adev->dev);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 137efaf9aabc..9bfd5b9756b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -15,6 +15,8 @@ struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int c
 struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 					  struct auxiliary_device *adev,
 					  int idx);
+void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
+		      struct auxiliary_device *adev);
 
 int mlx5_sd_init(struct mlx5_core_dev *dev);
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev);
-- 
2.44.0


