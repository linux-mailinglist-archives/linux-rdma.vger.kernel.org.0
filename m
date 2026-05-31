Return-Path: <linux-rdma+bounces-21545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD7kG04eHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:41:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E06F2615CD6
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB40C301D32E
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6D377544;
	Sun, 31 May 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MH0sg49i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECA231842;
	Sun, 31 May 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227632; cv=fail; b=MIJCr6zNQxaFwxl2VV0bIgwnZfaoqPJCc+s50ie7BGEyCaK8M+GDdJcZtoI0ggnhPgPm6AJ+ss45K698t2/NR4oi2lX7vBRMf9QsxPcVKDq0QqXbGHp28cQzFQ5C6n0248Iu0FjRbqCpuT20LOgoU3FUpk3DunZGr0EgIrDOWUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227632; c=relaxed/simple;
	bh=uroEa6pu1atNHP7XGb00lrOqyWWGAHm15DCGGy7oeos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PneNBnL2nC2Ro1Dj7rgblCruxR6CfPyOp7oVKOQHwhkh0KTDKKKAcBYwtD7XD1rCf8yiqfs63gY8aY4Olr9oZ9/Ggj1j4dfsblsMgwUfPwrKJKme6FBaHvRdSY1mYYuBjsBCMeRSCR4vEe1GTMp8XxiSavsPIbUPK0GQ3rI3uZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MH0sg49i; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnAwd3PsWrK3hTockPtteFfhku7EUaMjS4mPgcMS/1wTglsxhFEZoI/OiWfbgfVN/ZxIjPVMLqJTPTE/cgcLgfhnus5dhHq0AFbscf0HZikGMG6Ey7MYtfidxTwvXTnR/TE+axJcaka1nPFPVSXfg7Kp5jLl0E32dlVkgnyR88XxThw6jyYoljhfllC239Tvhp61j5tLDEUe2tMMKhX0Cc+G8mzrX6ypvzxTxkergq3mysbp+ZtjZxQ0geTynqPsOq+5iw3noiaBu40nKF0K5T6XGk7eKd+PWqVFkeWt9s27ZYy9js9OKy6rzyh7xcnyG1db+mV8MsXs2UFjarXAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMctzLE4xmlPJs4ftkNcHEum760GkvfQa3FKxuxxCco=;
 b=BQswBMZZlIW/e9rKhm14BHjXv/Uh7gw5E9V4NDGCn0EpRnBkAJryZo0DuNwbK6Ww7xzcg5Llx1MK4ICcc98MVU+3ObQe4PKPa4M1ZomjFwUMmbebPIhrsmeJfy/RZSftlDY5h/GPRP+JNTuBSnoFqBkcarqVDxI3iwEVJKa38YyoXjP2rH6isgHCDKE3WyGvOjw9qgNjgCTOta+qMNzHFDpzC5E/jfX4YRW2PsnAXfVPP9QX8L/W0clPLi5p/6JL+YjmkEyd607qzDVMQnoHyPmY8aDybrET5taiIW9aBmgfbM7RMxI5DCGwEq31xOpdDygk714xF5IZOgRigEMpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMctzLE4xmlPJs4ftkNcHEum760GkvfQa3FKxuxxCco=;
 b=MH0sg49imP/uBlXZnr3UnkG556PXESmTtlxFs2cMPSsxQ/SV+5U5ZWPgYXYxkABz+lt/rirX+cdQG8040Kg3lyJtn5Chk5QGMUFQpDKyB7GDp6hXUnIJ8YM/xFh8Q3cRCPUYkawo4+0sRNmXtrO/hDF+g1XPN+oSgxXSPvmZT3ckh38TDQwfU7Uy9cnkKyqueluqZCTJ+k4SA4rGGHN6PFRSc/ODui8lfwwWRFeAlTKHfhwEZzAMUGAkGmhEdw1UAxz4ZJC/VmfHSo2c81z4MkTWkEA+kDRxnljL4hQD2HepSgsKP9Ae4TC56oxTQjB2BFDlHz3cDC7EyXhgR/fbPg==
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 DSVPR12MB999174.namprd12.prod.outlook.com (2603:10b6:8:389::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Sun, 31 May 2026 11:40:23 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:3bb:cafe::60) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Sun, 31 May 2026 11:40:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:15 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 02/13] net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition
Date: Sun, 31 May 2026 14:39:42 +0300
Message-ID: <20260531113954.395443-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DSVPR12MB999174:EE_
X-MS-Office365-Filtering-Correlation-Id: e801f8b9-4f97-4eb8-9155-08debf0966fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	f1bJlbHf1HQk2VvAyw2T5Z8hgSJpmq/D5nMHtPXv1uv3baD6p4fL0N6CVWLx3JpCLIumdEQm+Nq7NIwTgt+VQeDoxTXn4HQzrUv1ex/nH/o41XpXdXXVUX74lCjkID0wafhKugjULRUWaBIl+1IbcrPVU6Y42iKpiBJP+JeQd8h+oDYxO0xrxBIXLAPiXs+sX6c8bA8GKU8I1CeR0JeX3oXJ/LQSJswWk2tVcIA/3mYFUlqwK+L+25UjBjsMBIOQpQjRK4P/lEuEGabLGXs1pS4z5D33hfwVHCN2XbmcH3GuYHEC7SERUS2vtJQ8WPhMbp6tHoPqzofQ5qUkAGxRqsxm67bFd6Zc9gm8MHK5h6fn+CUZUvG0u2IuZUlQIL/UNPrOeElp+4kXVCeIEIg9Xwh3U2fVipbrQXvWDYJPEwAQrfu2oJDS1UlUhmdeTyTxgMnZqopyDfYXg4TBm+epZhNXGswr0n13qYt24MpiJ6E8+GWqQpV7fyX8C1hp0F26QNl+znBRHNh7gpFCz4KG3uuLtIQG6XJkrFn/elff0NZ57xJWcm7xj+KPlqPK2JE8Fd5o3DoKJN1B1Ftzgb21Yfcr3SndDTpue4VNaPFg7Ho0syLjL0EAgSw7J4xvFGvc83OFdZsSyuOniLkHInOYEu6T5v2SQ3TLu8jkxydTa7zE9tCZD5rBtGeM8dOn2K7oTDHDTsT/qMF4+GrWstafqkuKukTsRxiKjS9+lN5z+M0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZpjAvkVTWweRBz7Qnu5PCxVm/IA3o6RWpEZ6NZU7sKG2HLtcNTYiIdwmUOQKiZ7gfnyHLuZfVlx/HeO0a1Loauoc1Wmpx6BR5K1eulwxWeN+v4LHHrf/doD46jaQo8nzpdPmM/RHHXnwXfqjlRP7FuzxyqLOwf0N0bzDT1KQ9S+t4bpkYtNIl+bAvbVwe1VmvlYGj8IdxE3Yelo1cB3bjPNUlATya4Yq9f6lIfrfD1k5ZJ3eP0cWqf0H3DPC7VjExmu2CkHKg4wxmZ7ukDirwFFoscTQy6HbBI5C4Wc22eFwKDc+OnKj4ifkH8rkCHeAC440+hmTjFvriwCnvL7HCwFXLzSJjONYYSu+mnnUBiywVSmVIyTYILWsJu8aMEzmaDHnBvYTVnc0eJ8GIp7wWdRIRInt9p0AFNh4nwLLmdofuLpM7wP96tqUPiJRqSM3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:23.5009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e801f8b9-4f97-4eb8-9155-08debf0966fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999174
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21545-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E06F2615CD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

This patch align the eswitch disable sequence with the
switchdev-to-legacy mode transition, where eswitch must be disabled
before device detachment. The consistent ordering is required for proper
SD LAG cleanup which depends on eswitch state during teardown.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0c6e4efe38c8..fd285aeb9630 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1369,7 +1369,6 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 
 static void mlx5_unload(struct mlx5_core_dev *dev)
 {
-	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_devlink_traps_unregister(priv_to_devlink(dev));
 	mlx5_vhca_event_stop(dev);
 	mlx5_sf_dev_table_destroy(dev);
@@ -1484,6 +1483,7 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 
 	mlx5_hwmon_dev_unregister(dev);
 	mlx5_crdump_disable(dev);
+	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_unregister_device(dev);
 
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
@@ -1568,6 +1568,7 @@ void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev, bool suspend)
 	devl_assert_locked(priv_to_devlink(dev));
 	mutex_lock(&dev->intf_state_mutex);
 
+	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_detach_device(dev, suspend);
 
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
-- 
2.44.0


