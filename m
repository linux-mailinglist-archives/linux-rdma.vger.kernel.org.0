Return-Path: <linux-rdma+bounces-12462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAFBB1129C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FF3A5904
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1792EE280;
	Thu, 24 Jul 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEzHZimS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684102ECD39;
	Thu, 24 Jul 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390248; cv=fail; b=YPCRaiV/AOs+hYo2UcielsHoiLsbA7xyov6tTRJsx4VfSh3LuwqNjfQSr79Q9KJdrlqU2kyJdOThVXZSRO23sEqo6GPYjJDVdfjTCAwVmCrG2sYpwPruAFlfIqAHmc0ukTQfTPSk0GYXNkk7FpWBxbxaMZEuUy8mMAvdBlhkOg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390248; c=relaxed/simple;
	bh=BvhYurb0heOvjuYajOcz1jnCGJ0jkwlCwGdLZzJpo9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBRYpPCtNSWxxQ1f8M49tRTsNW9/f6nq5sXj9gpn7XJQ2GxL8UQUSi4sfCZOPDJE5UHjcxS1k5TNTIIDsW/KsZHFzTjq404kR8SVSBx84ce7jwIPevSTNqnlF2Lhnb/V5vT2TWR2ssedsVaeF3Ysu5lNSJZljhbP6SYsd0qNb/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEzHZimS; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=au3DnX5rJlLd/b7nqxGlMz+JTwnn29qbPl1XV1622DTsfKtql3IImcZupMeG2CI3nr8ZLe0CRxMj4wFd+kbfJF/mvGFVsekQF2KZvFQWdN0gqcGBGv7NQ4X65E3uCwDbFSAbVywNIgr23JZ1XBNchhn82GiFX+bf5yVtKqglDdhmV5FxUloECMX6BF+8rMCXdMs7VeuD8PVaptgpZ4PyZCtg3ENX3qGZfenX3Lx6U/W3qmgxsou9v3LgsaiF6f2PwKIWC+97FJOvZp0N/gY9hRXmPgXV3ztaQ5+U6ao5QYkH87bCvs5GtXEUEUxjvWjzYWsBW6agCxlH4QvPPyTOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy5sf8xHtt7VTqNK1SGp1oY+L+UVIIve/ZxCo+d8l9k=;
 b=CBVP93HEWEn2ZpCP0dHSQPEZ25NhxDkGX6Jeh+3xl95utdFRgrfPnigLEgjSfNuYPXspqHe3RlpzYonzLnfvuDYBxH7Zh1mZjyaiMS/G8UemXs5uBglqLRIjiWgtPswqiNbErKFz5Hn5bX95I+D2hw7AAsSxTCuM9pNu1ew8nYyF7SjSliEjuvfNS0apqNcyhoZrxXqDQZpSmQs61g+m6fGmtoJhUjTq/mV1Wrj379GG0OORHANrLLQXH9TjZh9/P6zNFBvPitDz3NeZnUhD9NmEQryplfLv+ZclhldTxcgKwDJYRMXIhc10gTOBnq7NVjNsUMcLoQ2fm/mCtQpx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy5sf8xHtt7VTqNK1SGp1oY+L+UVIIve/ZxCo+d8l9k=;
 b=YEzHZimS8UD6xRZHZpHh/1y4VIND9rqUrL7OR4dpdw/+60XQYbmNQCLpqFutYe6iMjn8MdgxzPwWMOygk0op5OOvlUDLr+vq868z9tNjtCJ4YfIpfuK3/Z9PSwUOFZ4JjhCbRWb0PyqWFh+0gSJ+Pd5hg30zwqMNK0P40IQjQ5SPesA7MmktAkKnnEFZloNDjIVsnuIM31YjafO4h/GlQoYqpINuz71cbCk7yn2qDpSz1hz/IPbrzpCDLijcL4gkX2w+EP76nj25dMntwSewd7uLiDcFmU5ne20Qn4lo4y56ti6TLi9zke6gzcIaZNIlNHyjdqapultWBmJjOeyUhg==
Received: from CH0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:610:b2::35)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 20:50:39 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::fc) by CH0PR13CA0060.outlook.office365.com
 (2603:10b6:610:b2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.5 via Frontend Transport; Thu,
 24 Jul 2025 20:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 20:50:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 13:50:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Jul 2025 13:50:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Jul 2025 13:50:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Shahar
 Shitrit" <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V2 1/5] devlink: Move graceful period parameter to reporter ops
Date: Thu, 24 Jul 2025 23:48:50 +0300
Message-ID: <1753390134-345154-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
References: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: f4671458-7ad2-45e4-c762-08ddcaf3bf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sEOY1NB1Vv9QWm0ViOnkerawunJ29TrPnioPcJRjyEhqwufvIXj/b7uC/FGS?=
 =?us-ascii?Q?uEMw53f57C+sHMbCZDXYw9NtAT0ocSJutg+N+Wg3kuCyUjyGmwq36OHOHC+W?=
 =?us-ascii?Q?nOgeOOpXc1HtkoWpIJKKNy0vSu0OpEbkIhn/nGGWG05a7Xz9fZ7b7vTExbMg?=
 =?us-ascii?Q?JWM0UnCR3Do8K46BQqYm0GPaLHgactntQrwHwnty4VM6zW0wPQxrQ2f3WNqN?=
 =?us-ascii?Q?cqL2q7h9nmY6LeU4oa0mWw57P8j/Ut8sNnmX3d+ATCy1elGP41gQp8IF4X0m?=
 =?us-ascii?Q?/Fef0NTYqDXHSKpsB1SSKS6WMcovIvGTmZyDoA/LCmSwSCHEu99DU9gefL7a?=
 =?us-ascii?Q?I/eIpny6bQUEJxRCSueeyTCE3poX2jzvcnkC2TgjAyyWV+zuuShK6m9WM+Ge?=
 =?us-ascii?Q?PodTu5bAWGc563TL7OYJIv5ZAGqWqDoT8E7M1a62wEa63Roo16ObzeX/l6Wd?=
 =?us-ascii?Q?oFBxloHag6oQiapQPbXVidar3ikxuFUeN362UMpS7r/UMBSSj0uV/6+rfI2X?=
 =?us-ascii?Q?4oAD7GT6gTMkv648G3/wfBvNJTCIXBv2Udg8roVE2XWLvgX4FanClAjVlZR5?=
 =?us-ascii?Q?osva5bNws/iGnjtirtS2YQ4B61p5ROKiplSYxMJergClhoop1WFbCgCkdmO5?=
 =?us-ascii?Q?31UAvmXUwigkvk+6LgA8+tfWSPbgR6NrXxqqygXnv990ki31tlr+Yh48Qj+E?=
 =?us-ascii?Q?GEJ9P8ml8Fq5x0+DONkP64oUscUFKTsSm1t8jqBocsc0ESlgXmWMg3UuxdnN?=
 =?us-ascii?Q?yTYbuwvEVDGuYN1gS2IUKXEshGuhJbHtx7fXDsHCcyeuNjSbYAFzu7t6HDca?=
 =?us-ascii?Q?4HXyZPvEOzU4P4vvgg7sYUzUm/2CkV49XEN70Fxb2R7t/LWyrVXtu1Irg/WZ?=
 =?us-ascii?Q?ADq3vq2v8OkNlfjqi+beAMHbq0IC+TvomMGIGJYAjmWXz9dCKbANDsCdzJwd?=
 =?us-ascii?Q?qRFRoE7fRc+tRChJSXsu5Yx/o7Tow+AhA/A5gIdTxCICY5kXlbaJUV3066/i?=
 =?us-ascii?Q?6FU2RzRkfef2qjHAxY0L3l2MSNNd8Zfmd+ghG3ZIVkbRrNULsgFemC8prcSH?=
 =?us-ascii?Q?X/ocj5PUopqVR5VOs4ASg4x12Pbd6WA3HnRLdSaLHbPO5iW+1qIWcNl62prM?=
 =?us-ascii?Q?7G1Z7LzKLfz2OiYnRDKY6LadfJIEJSHNyRVaVNA0dIxjV3aREUAzi0IGFg83?=
 =?us-ascii?Q?cE5ycJpG6Y13CcU0VgBYtyezZHi7ULaoWPW/BX9OCxRkvlelKXEEYhEPYiPZ?=
 =?us-ascii?Q?L77LkWocTBmoudrmT7vcjFvJ9WsKCARYUmN4j2BTlSU3AoNI0bhoYWqYQkdu?=
 =?us-ascii?Q?RnKlpFHK6bRU+1L6O87qZaQhNLz1/O0PPspxS/YkKLtSZeBfqxm85wgb/Zxy?=
 =?us-ascii?Q?6P7zcnO9DnWfPnS0W86T7JCX5pwgk3haZ51I9Pu3VlnABhaCbUGhx1n2eNoR?=
 =?us-ascii?Q?f/YjeGKoTkbauElSTANVBX2kneH0z3LluMg0/ZKIDqdfc7aOtkp21Iilt2AQ?=
 =?us-ascii?Q?+RvER+v/KANm7PZoUr2fPnwm/K6hLGW8ej5m?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:50:39.4924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4671458-7ad2-45e4-c762-08ddcaf3bf92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

From: Shahar Shitrit <shshitrit@nvidia.com>

Move the default graceful period from a parameter to
devlink_health_reporter_create() to a field in the
devlink_health_reporter_ops structure.

This change improves consistency, as the graceful period is inherently
tied to the reporter's behavior and recovery policy. It simplifies the
signature of devlink_health_reporter_create() and its internal helper
functions. It also centralizes the reporter configuration at the ops
structure, preparing the groundwork for a downstream patch that will
introduce a devlink health reporter grace period delay attribute whose
default value will similarly be provided by the driver via the ops
structure.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/amd/pds_core/main.c      |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 10 +++--
 .../net/ethernet/intel/ice/devlink/health.c   |  3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++----
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  2 +-
 .../mellanox/mlx5/core/en/reporter_rx.c       | 10 +++--
 .../mellanox/mlx5/core/en/reporter_tx.c       | 10 +++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/health.c  | 41 +++++++++++--------
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c | 10 +++--
 drivers/net/netdevsim/health.c                |  4 +-
 include/net/devlink.h                         | 11 +++--
 net/devlink/health.c                          | 28 +++++--------
 15 files changed, 98 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 9b81e1c260c2..c7a2eff57632 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -280,7 +280,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 		goto err_out_del_dev;
 	}
 
-	hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, 0, pdsc);
+	hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, pdsc);
 	if (IS_ERR(hr)) {
 		devl_unlock(dl);
 		dev_warn(pdsc->dev, "Failed to create fw reporter: %pe\n", hr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 4c4581b0342e..43fb75806cd6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -220,7 +220,7 @@ __bnxt_dl_reporter_create(struct bnxt *bp,
 {
 	struct devlink_health_reporter *reporter;
 
-	reporter = devlink_health_reporter_create(bp->dl, ops, 0, bp);
+	reporter = devlink_health_reporter_create(bp->dl, ops, bp);
 	if (IS_ERR(reporter)) {
 		netdev_warn(bp->dev, "Failed to create %s health reporter, rc = %ld\n",
 			    ops->name, PTR_ERR(reporter));
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 03e42512a2d5..300bc267a259 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -443,8 +443,9 @@ int hinic_health_reporters_create(struct hinic_devlink_priv *priv)
 	struct devlink *devlink = priv_to_devlink(priv);
 
 	priv->hw_fault_reporter =
-		devlink_health_reporter_create(devlink, &hinic_hw_fault_reporter_ops,
-					       0, priv);
+		devlink_health_reporter_create(devlink,
+					       &hinic_hw_fault_reporter_ops,
+					       priv);
 	if (IS_ERR(priv->hw_fault_reporter)) {
 		dev_warn(&priv->hwdev->hwif->pdev->dev, "Failed to create hw fault reporter, err: %ld\n",
 			 PTR_ERR(priv->hw_fault_reporter));
@@ -452,8 +453,9 @@ int hinic_health_reporters_create(struct hinic_devlink_priv *priv)
 	}
 
 	priv->fw_fault_reporter =
-		devlink_health_reporter_create(devlink, &hinic_fw_fault_reporter_ops,
-					       0, priv);
+		devlink_health_reporter_create(devlink,
+					       &hinic_fw_fault_reporter_ops,
+					       priv);
 	if (IS_ERR(priv->fw_fault_reporter)) {
 		dev_warn(&priv->hwdev->hwif->pdev->dev, "Failed to create fw fault reporter, err: %ld\n",
 			 PTR_ERR(priv->fw_fault_reporter));
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 19c3d37aa768..3177496e7828 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -448,9 +448,8 @@ ice_init_devlink_rep(struct ice_pf *pf,
 {
 	struct devlink *devlink = priv_to_devlink(pf);
 	struct devlink_health_reporter *rep;
-	const u64 graceful_period = 0;
 
-	rep = devl_health_reporter_create(devlink, ops, graceful_period, pf);
+	rep = devl_health_reporter_create(devlink, ops, pf);
 	if (IS_ERR(rep)) {
 		struct device *dev = ice_pf_to_dev(pf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 27c3a2daaaa9..3735372539bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -505,7 +505,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_reporters->nix_event_ctx = nix_event_context;
 	rvu_reporters->rvu_hw_nix_intr_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_intr_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_intr_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_intr_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_intr reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_intr_reporter));
@@ -513,7 +515,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_nix_gen_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_gen_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_gen_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_gen_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_gen reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_gen_reporter));
@@ -521,7 +525,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_nix_err_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_err_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_err_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_err_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_err reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_err_reporter));
@@ -529,7 +535,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_nix_ras_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_ras_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_ras_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_ras_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_ras reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_ras_reporter));
@@ -1051,7 +1059,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_reporters->npa_event_ctx = npa_event_context;
 	rvu_reporters->rvu_hw_npa_intr_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_intr_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_intr_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_intr_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_intr reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_intr_reporter));
@@ -1059,7 +1069,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_npa_gen_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_gen_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_gen_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_gen_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_gen reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_gen_reporter));
@@ -1067,7 +1079,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_npa_err_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_err_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_err_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_err_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_err reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_err_reporter));
@@ -1075,7 +1089,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_npa_ras_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_ras_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_ras_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_ras_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_ras reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_ras_reporter));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index 86253a89c24c..878f9b46bf18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -133,7 +133,7 @@ void mlx5_reporter_vnic_create(struct mlx5_core_dev *dev)
 	health->vnic_reporter =
 		devlink_health_reporter_create(devlink,
 					       &mlx5_reporter_vnic_ops,
-					       0, dev);
+					       dev);
 	if (IS_ERR(health->vnic_reporter))
 		mlx5_core_warn(dev,
 			       "Failed to create vnic reporter, err = %ld\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e75759533ae0..e106f0696486 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -644,22 +644,24 @@ void mlx5e_reporter_icosq_resume_recovery(struct mlx5e_channel *c)
 	mutex_unlock(&c->icosq_recovery_lock);
 }
 
+#define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
+
 static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.name = "rx",
 	.recover = mlx5e_rx_reporter_recover,
 	.diagnose = mlx5e_rx_reporter_diagnose,
 	.dump = mlx5e_rx_reporter_dump,
+	.default_graceful_period = MLX5E_REPORTER_RX_GRACEFUL_PERIOD,
 };
 
-#define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
-
 void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
 {
+	struct devlink_port *port = priv->netdev->devlink_port;
 	struct devlink_health_reporter *reporter;
 
-	reporter = devlink_port_health_reporter_create(priv->netdev->devlink_port,
+	reporter = devlink_port_health_reporter_create(port,
 						       &mlx5_rx_reporter_ops,
-						       MLX5E_REPORTER_RX_GRACEFUL_PERIOD, priv);
+						       priv);
 	if (IS_ERR(reporter)) {
 		netdev_warn(priv->netdev, "Failed to create rx reporter, err = %ld\n",
 			    PTR_ERR(reporter));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index bd96988e102c..6fb0d143ad1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -514,22 +514,24 @@ void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
 	mlx5e_health_report(priv, priv->tx_reporter, err_str, &err_ctx);
 }
 
+#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
+
 static const struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
 		.name = "tx",
 		.recover = mlx5e_tx_reporter_recover,
 		.diagnose = mlx5e_tx_reporter_diagnose,
 		.dump = mlx5e_tx_reporter_dump,
+		.default_graceful_period = MLX5_REPORTER_TX_GRACEFUL_PERIOD,
 };
 
-#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
-
 void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
 {
+	struct devlink_port *port = priv->netdev->devlink_port;
 	struct devlink_health_reporter *reporter;
 
-	reporter = devlink_port_health_reporter_create(priv->netdev->devlink_port,
+	reporter = devlink_port_health_reporter_create(port,
 						       &mlx5_tx_reporter_ops,
-						       MLX5_REPORTER_TX_GRACEFUL_PERIOD, priv);
+						       priv);
 	if (IS_ERR(reporter)) {
 		netdev_warn(priv->netdev,
 			    "Failed to create tx reporter, err = %ld\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 63a7a788fb0d..b231e7855bca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1447,7 +1447,7 @@ static void mlx5e_rep_vnic_reporter_create(struct mlx5e_priv *priv,
 
 	reporter = devl_port_health_reporter_create(dl_port,
 						    &mlx5_rep_vnic_reporter_ops,
-						    0, rpriv);
+						    rpriv);
 	if (IS_ERR(reporter)) {
 		mlx5_core_err(priv->mdev,
 			      "Failed to create representor vnic reporter, err = %ld\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index cf7a1edd0530..6959fea03443 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -669,54 +669,61 @@ static void mlx5_fw_fatal_reporter_err_work(struct work_struct *work)
 	}
 }
 
+#define MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD 180000
+#define MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD 60000
+#define MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD 30000
+#define MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD \
+	MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD
+
+static const
+struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ecpf_ops = {
+		.name = "fw_fatal",
+		.recover = mlx5_fw_fatal_reporter_recover,
+		.dump = mlx5_fw_fatal_reporter_dump,
+		.default_graceful_period =
+			MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD,
+};
+
 static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_pf_ops = {
 		.name = "fw_fatal",
 		.recover = mlx5_fw_fatal_reporter_recover,
 		.dump = mlx5_fw_fatal_reporter_dump,
+		.default_graceful_period = MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD,
 };
 
 static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
 		.name = "fw_fatal",
 		.recover = mlx5_fw_fatal_reporter_recover,
+		.default_graceful_period =
+			MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD,
 };
 
-#define MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD 180000
-#define MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD 60000
-#define MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD 30000
-#define MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD
-
 void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 {
 	const struct devlink_health_reporter_ops *fw_fatal_ops;
 	struct mlx5_core_health *health = &dev->priv.health;
 	const struct devlink_health_reporter_ops *fw_ops;
 	struct devlink *devlink = priv_to_devlink(dev);
-	u64 grace_period;
 
-	fw_fatal_ops = &mlx5_fw_fatal_reporter_pf_ops;
 	fw_ops = &mlx5_fw_reporter_pf_ops;
 	if (mlx5_core_is_ecpf(dev)) {
-		grace_period = MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD;
+		fw_fatal_ops = &mlx5_fw_fatal_reporter_ecpf_ops;
 	} else if (mlx5_core_is_pf(dev)) {
-		grace_period = MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD;
+		fw_fatal_ops = &mlx5_fw_fatal_reporter_pf_ops;
 	} else {
 		/* VF or SF */
-		grace_period = MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD;
 		fw_fatal_ops = &mlx5_fw_fatal_reporter_ops;
 		fw_ops = &mlx5_fw_reporter_ops;
 	}
 
-	health->fw_reporter =
-		devl_health_reporter_create(devlink, fw_ops, 0, dev);
+	health->fw_reporter = devl_health_reporter_create(devlink, fw_ops, dev);
 	if (IS_ERR(health->fw_reporter))
 		mlx5_core_warn(dev, "Failed to create fw reporter, err = %ld\n",
 			       PTR_ERR(health->fw_reporter));
 
-	health->fw_fatal_reporter =
-		devl_health_reporter_create(devlink,
-					    fw_fatal_ops,
-					    grace_period,
-					    dev);
+	health->fw_fatal_reporter = devl_health_reporter_create(devlink,
+								fw_fatal_ops,
+								dev);
 	if (IS_ERR(health->fw_fatal_reporter))
 		mlx5_core_warn(dev, "Failed to create fw fatal reporter, err = %ld\n",
 			       PTR_ERR(health->fw_fatal_reporter));
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 2bb2b77351bd..980f3223f124 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2043,7 +2043,7 @@ static int mlxsw_core_health_init(struct mlxsw_core *mlxsw_core)
 		return 0;
 
 	fw_fatal = devl_health_reporter_create(devlink, &mlxsw_core_health_fw_fatal_ops,
-					       0, mlxsw_core);
+					       mlxsw_core);
 	if (IS_ERR(fw_fatal)) {
 		dev_err(mlxsw_core->bus_info->dev, "Failed to create fw fatal reporter");
 		return PTR_ERR(fw_fatal);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
index 1adc7fbb3f2f..d000ed734c7c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
@@ -87,20 +87,22 @@ qed_fw_fatal_reporter_recover(struct devlink_health_reporter *reporter,
 	return 0;
 }
 
+#define QED_REPORTER_FW_GRACEFUL_PERIOD 0
+
 static const struct devlink_health_reporter_ops qed_fw_fatal_reporter_ops = {
 		.name = "fw_fatal",
 		.recover = qed_fw_fatal_reporter_recover,
 		.dump = qed_fw_fatal_reporter_dump,
+		.default_graceful_period = QED_REPORTER_FW_GRACEFUL_PERIOD,
 };
 
-#define QED_REPORTER_FW_GRACEFUL_PERIOD 0
-
 void qed_fw_reporters_create(struct devlink *devlink)
 {
 	struct qed_devlink *dl = devlink_priv(devlink);
 
-	dl->fw_reporter = devlink_health_reporter_create(devlink, &qed_fw_fatal_reporter_ops,
-							 QED_REPORTER_FW_GRACEFUL_PERIOD, dl);
+	dl->fw_reporter =
+		devlink_health_reporter_create(devlink,
+					       &qed_fw_fatal_reporter_ops, dl);
 	if (IS_ERR(dl->fw_reporter)) {
 		DP_NOTICE(dl->cdev, "Failed to create fw reporter, err = %ld\n",
 			  PTR_ERR(dl->fw_reporter));
diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index 688f05316b5e..3bd0e7a489c3 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -183,14 +183,14 @@ int nsim_dev_health_init(struct nsim_dev *nsim_dev, struct devlink *devlink)
 	health->empty_reporter =
 		devl_health_reporter_create(devlink,
 					    &nsim_dev_empty_reporter_ops,
-					    0, health);
+					    health);
 	if (IS_ERR(health->empty_reporter))
 		return PTR_ERR(health->empty_reporter);
 
 	health->dummy_reporter =
 		devl_health_reporter_create(devlink,
 					    &nsim_dev_dummy_reporter_ops,
-					    0, health);
+					    health);
 	if (IS_ERR(health->dummy_reporter)) {
 		err = PTR_ERR(health->dummy_reporter);
 		goto err_empty_reporter_destroy;
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 93640a29427c..a65aa24e8df4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -742,6 +742,8 @@ enum devlink_health_reporter_state {
  *        if priv_ctx is NULL, run a full dump
  * @diagnose: callback to diagnose the current status
  * @test: callback to trigger a test event
+ * @default_graceful_period: default min time (in msec)
+			     between recovery attempts
  */
 
 struct devlink_health_reporter_ops {
@@ -756,6 +758,7 @@ struct devlink_health_reporter_ops {
 			struct netlink_ext_ack *extack);
 	int (*test)(struct devlink_health_reporter *reporter,
 		    struct netlink_ext_ack *extack);
+	u64 default_graceful_period;
 };
 
 /**
@@ -1924,22 +1927,22 @@ void devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 struct devlink_health_reporter *
 devl_port_health_reporter_create(struct devlink_port *port,
 				 const struct devlink_health_reporter_ops *ops,
-				 u64 graceful_period, void *priv);
+				 void *priv);
 
 struct devlink_health_reporter *
 devlink_port_health_reporter_create(struct devlink_port *port,
 				    const struct devlink_health_reporter_ops *ops,
-				    u64 graceful_period, void *priv);
+				    void *priv);
 
 struct devlink_health_reporter *
 devl_health_reporter_create(struct devlink *devlink,
 			    const struct devlink_health_reporter_ops *ops,
-			    u64 graceful_period, void *priv);
+			    void *priv);
 
 struct devlink_health_reporter *
 devlink_health_reporter_create(struct devlink *devlink,
 			       const struct devlink_health_reporter_ops *ops,
-			       u64 graceful_period, void *priv);
+			       void *priv);
 
 void
 devl_health_reporter_destroy(struct devlink_health_reporter *reporter);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index b3ce8ecbb7fb..ba144b7426fa 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -108,11 +108,11 @@ devlink_port_health_reporter_find_by_name(struct devlink_port *devlink_port,
 static struct devlink_health_reporter *
 __devlink_health_reporter_create(struct devlink *devlink,
 				 const struct devlink_health_reporter_ops *ops,
-				 u64 graceful_period, void *priv)
+				 void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
-	if (WARN_ON(graceful_period && !ops->recover))
+	if (WARN_ON(ops->default_graceful_period && !ops->recover))
 		return ERR_PTR(-EINVAL);
 
 	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
@@ -122,7 +122,7 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	reporter->priv = priv;
 	reporter->ops = ops;
 	reporter->devlink = devlink;
-	reporter->graceful_period = graceful_period;
+	reporter->graceful_period = ops->default_graceful_period;
 	reporter->auto_recover = !!ops->recover;
 	reporter->auto_dump = !!ops->dump;
 	return reporter;
@@ -134,13 +134,12 @@ __devlink_health_reporter_create(struct devlink *devlink,
  *
  * @port: devlink_port to which health reports will relate
  * @ops: devlink health reporter ops
- * @graceful_period: min time (in msec) between recovery attempts
  * @priv: driver priv pointer
  */
 struct devlink_health_reporter *
 devl_port_health_reporter_create(struct devlink_port *port,
 				 const struct devlink_health_reporter_ops *ops,
-				 u64 graceful_period, void *priv)
+				 void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
@@ -150,8 +149,7 @@ devl_port_health_reporter_create(struct devlink_port *port,
 						   ops->name))
 		return ERR_PTR(-EEXIST);
 
-	reporter = __devlink_health_reporter_create(port->devlink, ops,
-						    graceful_period, priv);
+	reporter = __devlink_health_reporter_create(port->devlink, ops, priv);
 	if (IS_ERR(reporter))
 		return reporter;
 
@@ -164,14 +162,13 @@ EXPORT_SYMBOL_GPL(devl_port_health_reporter_create);
 struct devlink_health_reporter *
 devlink_port_health_reporter_create(struct devlink_port *port,
 				    const struct devlink_health_reporter_ops *ops,
-				    u64 graceful_period, void *priv)
+				    void *priv)
 {
 	struct devlink_health_reporter *reporter;
 	struct devlink *devlink = port->devlink;
 
 	devl_lock(devlink);
-	reporter = devl_port_health_reporter_create(port, ops,
-						    graceful_period, priv);
+	reporter = devl_port_health_reporter_create(port, ops, priv);
 	devl_unlock(devlink);
 	return reporter;
 }
@@ -182,13 +179,12 @@ EXPORT_SYMBOL_GPL(devlink_port_health_reporter_create);
  *
  * @devlink: devlink instance which the health reports will relate
  * @ops: devlink health reporter ops
- * @graceful_period: min time (in msec) between recovery attempts
  * @priv: driver priv pointer
  */
 struct devlink_health_reporter *
 devl_health_reporter_create(struct devlink *devlink,
 			    const struct devlink_health_reporter_ops *ops,
-			    u64 graceful_period, void *priv)
+			    void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
@@ -197,8 +193,7 @@ devl_health_reporter_create(struct devlink *devlink,
 	if (devlink_health_reporter_find_by_name(devlink, ops->name))
 		return ERR_PTR(-EEXIST);
 
-	reporter = __devlink_health_reporter_create(devlink, ops,
-						    graceful_period, priv);
+	reporter = __devlink_health_reporter_create(devlink, ops, priv);
 	if (IS_ERR(reporter))
 		return reporter;
 
@@ -210,13 +205,12 @@ EXPORT_SYMBOL_GPL(devl_health_reporter_create);
 struct devlink_health_reporter *
 devlink_health_reporter_create(struct devlink *devlink,
 			       const struct devlink_health_reporter_ops *ops,
-			       u64 graceful_period, void *priv)
+			       void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
 	devl_lock(devlink);
-	reporter = devl_health_reporter_create(devlink, ops,
-					       graceful_period, priv);
+	reporter = devl_health_reporter_create(devlink, ops, priv);
 	devl_unlock(devlink);
 	return reporter;
 }
-- 
2.31.1


