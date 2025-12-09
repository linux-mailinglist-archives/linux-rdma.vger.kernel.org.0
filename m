Return-Path: <linux-rdma+bounces-14942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B776DCB0005
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025BB31290E1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A13B8D75;
	Tue,  9 Dec 2025 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISHD/Edj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7826329C64;
	Tue,  9 Dec 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285037; cv=fail; b=SwBwGRh3pquJL/rh+O+/AN16cpurepSjKgz43hRlu87bVgkcChMy3Wz5wFnYbbWZ0keApPuzw+Xpm+ZoRCzkdCmgKlnzIz+m4of0sPZeDdYeQV+sTUVmbhcSP+6Q7WuvvYfVP5ModZ+qEvOG5/JqXmN8Bw/pa82LC61XZ1qpbX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285037; c=relaxed/simple;
	bh=gIiZoMNlSQWUkiLvjmbdpq3cPHtd8RFAhIQMJK67e/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjYRqmQdoBYCki3KNWE3SY9Lb1RLvE/fOB+SGl19J/LN/O4mE59bZbNwGXnN5oIRl6cOX1MCAGtHTcPPMcmSAkMgMjJc8AnXaf5DnEHZOoIFHzMY7/ZQY2WibTfP6rb8UT5VK0GOXeNegEUhpltCo9kyvrhZD+aleb/4I9Qd92s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISHD/Edj; arc=fail smtp.client-ip=40.107.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esuxy60VariraSgvZLcDSQIofJUEgthLnhzVxLyUTtDmQtFd9497BZJuTa8X477biVptfho8ZpMAhHxK75vInM0C4mvjQeSUa2tXpII6rUzKycPHC4I/pnSNh5RlYv0vqhSr1Kb3EGwvCqqHwO9rzp/bTOXhKiVFrI992rYtW955y3/Slh+4BJ/TMhVmSh0F9sL28Rq5iCr42vHiIPfVTgt6ai3idOF30OXAJkBN/k59TXFcTXOdhSKK25t3iTbtvGv+0V8xLywSSWSiIUonh7hyIPJfOhQ5nEr+yRqkt/pgXNxae1DqMfCSD5V/CLQyi5h8nm1IUIyhG+59+KTcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFPRvYiSLWwaq0YMaIFDZgZz8lupjIucuTciInsJtLw=;
 b=AVFMfGxucipefx3o/6wkAE2G6Yo3QCpe15iW3Bovl0oienSpNtclaSinTQRsFZaaKiGxEiyrSPzDWr+2QfFuodc9IalqLiIVNvZPJ6IERrzTZkXk7gtfDQu8rs1cYezrcrozOAYvSeQGJ0mk35tEQAdtHJ6sJRFMPkE5UVu2yWyrmNwG6VVo/kpv68Q7zoOzpBrscD1dLljSKEyIlUmArvZxCJRQYgSTfeld2bc/n5AaHrqgAkvtabgshXab6jIoq+OyND6wcoNkT84hrsktCTXyz5fYfD+HzhPlwIKQbPp2FBIrbM57bwpDyWKCwrkHiXxP+8bUy3C4kk2cL2KzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFPRvYiSLWwaq0YMaIFDZgZz8lupjIucuTciInsJtLw=;
 b=ISHD/EdjdoaQ3YGaD1Hi3TntoJf7aXF9Pkb/AgULblDGcy9w4qD3VXbTgTuW4r6t/Eqzo8PHiWcDvakIQyYUdwSjC/oYIHFrUlhIORnDQNo+BnKLWP10hn1Cy80fodtkLCWE6hzmN9h7ONz8V7hD9/bBR/khz5Md/AdObt1hQVM7FR4qay9RVJWUTbnYGFKP2qIRO6DLHFr7I2nr48rRoeUPcJ8y06E8tTsM7izwfnd7b64xE2mD+3FTFsCbVGZaUtiZxAmOUxo5dz0CLzO352qU+oyV3gr0QMCnzHQ/pRfyV/aGWdWUf/xEqRYdMXIhdP6HXLoxc/L2I6s26NHmDA==
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:57:09 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::50) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 12:57:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:56:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:56:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 5/9] net/mlx5: Serialize firmware reset with devlink
Date: Tue, 9 Dec 2025 14:56:13 +0200
Message-ID: <1765284977-1363052-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 23abec29-3e7b-4b50-8533-08de372276af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2aSCxTDvf+HxXqXMxz9/eCjFEchsvNF1QwE2XHzTZSgBfQ1Q85ai2eDdS1YL?=
 =?us-ascii?Q?MsX2H2yJAUIg6xQ0woqxkdaQAfZNf5RWkpjJQWG7Dq3+jDIGiETj1Awg8Mm9?=
 =?us-ascii?Q?uvKmL1vwriudBhgI1MsrI8ISveQOdtZszagl846CGBijK5/vLQWghVyuWJRd?=
 =?us-ascii?Q?VLcXC9v+wuTQIEkVh4JI8cpX+0gNdNYeG22gCqSEOCKt/AkiDydUvMbv4cco?=
 =?us-ascii?Q?0Mut5VrlPJrE21FMR3QzC3ZW1CWX8e6S9xwNxIWlojUUajED2Fu25xWkzZ1U?=
 =?us-ascii?Q?SOLJHODTwl6ItamuTfSW34jdMiXPw0r8SoHR/lMOibA4kIN/oznhephkTylJ?=
 =?us-ascii?Q?nwJSz3Sk4CHj/5Z7ZmE2qhSWFuDblRpC1cnk7BE2ntbyq5TqoddWmVAGIpzo?=
 =?us-ascii?Q?ovpE2spzcjpTgTPpnB1rP8JqwPpfASnf2II0G22L6TVJxZhA9471S7Te8PHs?=
 =?us-ascii?Q?qjricVKTLIJJ2FxRYrHHn9KaXT6SAYfX0hrP3n9TOhLkxn6rtGzH85SpzPHU?=
 =?us-ascii?Q?xlz4F74imwEcgPDsHpLyLXsaa0v7XdiHW/J9GX4aJRhnpUIuJvOwaap+qBam?=
 =?us-ascii?Q?KTeuzzftcDL1i009yfq/KZbh6jp5tYNJe6h68hGiEE1uYK/wR1DHy2YYUEvq?=
 =?us-ascii?Q?WRgBRaAgVCUtNB5k5O4o7t72aNpMCIowP3TXLxet2pVOMTWrieg/ARexpfrX?=
 =?us-ascii?Q?qk626Z1FyIpkWlkJpEQuccoIWTBkMw4/PHio+4AY62OucvAHHV2yYPwi6f3j?=
 =?us-ascii?Q?hxaXBN47WU9MmMghcSUm9DRh9+wg6RVSsXOt0Nt+StbKrMBGOz3rNZx68OYJ?=
 =?us-ascii?Q?7Qqs4WnKoVrZ7kuriEqRA3VjUFFVPT3AsRiyzp0nl+HxMgTxeNRsH+tDxp6T?=
 =?us-ascii?Q?wqa6KI9EMdsR1hXU55Em/k3OAudlhgCybv95Ea6eEDUL9tE6bkkwincn6/uj?=
 =?us-ascii?Q?CgMmq6vEUKkciV2XMi002ixnQ7Dvv03VSwk6sMe6SaIBXGU51okVSwxV/MHv?=
 =?us-ascii?Q?h7b0f6vAy20cA4CXxom3n3oGZj8QBU+dVeaNHNmdmLL9D7Fs1eyHCAi+5Ww+?=
 =?us-ascii?Q?NoubFXTcDL+bbl7p3thneGwjPBY9dEP3pNkke5B4mGQUB8DFVVMg1ANgB1DW?=
 =?us-ascii?Q?1hjrUpjf82AWyLMjBWCyKfm60rUzoKWtpiPganzp4+TLuX1m+8+RFEmDmaEa?=
 =?us-ascii?Q?q70d056fxiD9FGqnYTQ9w4BBNjBSPqfpJa3NRqiWLtHEeKQ1Y/q+qDa7uxa3?=
 =?us-ascii?Q?wSFiFNpseHx4RN0b/streKnw7F1bMrgkASgAD6RdGXk3IFpULDFtRC2HKCSA?=
 =?us-ascii?Q?LUJ5LneY2Kq6tKCgdFf7sZBYXS+8tpEeJ3ud+kRm3g1NgbalHNDbCZBvQ+Kx?=
 =?us-ascii?Q?syz8B9ySlCJ55YvgnLgfcrLOzLpN8rSbD3taDuLdVMMHNF3LYUfrCjbM59tA?=
 =?us-ascii?Q?6gHh/deWw68hAMaTU31NxrDddkq6XLggtioAHUzbLe2YsnrjYSDQA+Ym8K/B?=
 =?us-ascii?Q?lEJuxRLX2fdurTvN8VTeRO4ZNEUNTCVOMdd8B2UIPjrapILLyvKeh4r8kIAz?=
 =?us-ascii?Q?kpU0ku6ejf5HkbntVZddRnnVxzxHaae9UA0r+VFhY9yPodkC7omuP1nI96R2?=
 =?us-ascii?Q?ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:57:09.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23abec29-3e7b-4b50-8533-08de372276af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815

From: Shay Drory <shayd@nvidia.com>

The firmware reset mechanism can be triggered by asynchronous events,
which may race with other devlink operations like devlink reload or
devlink dev eswitch set, potentially leading to inconsistent states.

This patch addresses the race by using the devl_lock to serialize the
firmware reset against other devlink operations. When a reset is
requested, the driver attempts to acquire the lock. If successful, it
sets a flag to block devlink reload or eswitch changes, ACKs the reset
to firmware and then releases the lock. If the lock is already held by
another operation, the driver NACKs the firmware reset request,
indicating that the reset cannot proceed.

Firmware reset does not keep the devl_lock and instead uses an internal
firmware reset bit. This is because firmware resets can be triggered by
asynchronous events, and processed in different threads. It is illegal
and unsafe to acquire a lock in one thread and attempt to release it in
another, as lock ownership is intrinsically thread-specific.

This change ensures that firmware resets and other devlink operations
are mutually exclusive during the critical reset request phase,
preventing race conditions.

Fixes: 38b9f903f22b ("net/mlx5: Handle sync reset request event")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mateusz Berezecki <mberezecki@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  6 +++
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 45 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |  1 +
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 887adf4807d1..ea77fbd98396 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -197,6 +197,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 	struct pci_dev *pdev = dev->pdev;
 	int ret = 0;
 
+	if (mlx5_fw_reset_in_progress(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Can't reload during firmware reset");
+		return -EBUSY;
+	}
+
 	if (mlx5_dev_is_lightweight(dev)) {
 		if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
 			return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 8de6c7f6c294..ea94a727633f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -52,6 +52,7 @@
 #include "devlink.h"
 #include "lag/lag.h"
 #include "en/tc/post_meter.h"
+#include "fw_reset.h"
 
 /* There are two match-all miss flows, one for unicast dst mac and
  * one for multicast.
@@ -3991,6 +3992,11 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
+	if (mlx5_fw_reset_in_progress(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Can't change eswitch mode during firmware reset");
+		return -EBUSY;
+	}
+
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index b81de792c181..ae10665c53f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -15,6 +15,7 @@ enum {
 	MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
 	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED,
 	MLX5_FW_RESET_FLAGS_UNLOAD_EVENT,
+	MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS,
 };
 
 struct mlx5_fw_reset {
@@ -128,6 +129,16 @@ int mlx5_fw_reset_query(struct mlx5_core_dev *dev, u8 *reset_level, u8 *reset_ty
 	return mlx5_reg_mfrl_query(dev, reset_level, reset_type, NULL, NULL);
 }
 
+bool mlx5_fw_reset_in_progress(struct mlx5_core_dev *dev)
+{
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+
+	if (!fw_reset)
+		return false;
+
+	return test_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
+}
+
 static int mlx5_fw_reset_get_reset_method(struct mlx5_core_dev *dev,
 					  u8 *reset_method)
 {
@@ -243,6 +254,8 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
 		devl_unlock(devlink);
 	}
+
+	clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
 }
 
 static void mlx5_stop_sync_reset_poll(struct mlx5_core_dev *dev)
@@ -462,27 +475,48 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
 						      reset_request_work);
 	struct mlx5_core_dev *dev = fw_reset->dev;
+	bool nack_request = false;
+	struct devlink *devlink;
 	int err;
 
 	err = mlx5_fw_reset_get_reset_method(dev, &fw_reset->reset_method);
-	if (err)
+	if (err) {
+		nack_request = true;
 		mlx5_core_warn(dev, "Failed reading MFRL, err %d\n", err);
+	} else if (!mlx5_is_reset_now_capable(dev, fw_reset->reset_method) ||
+		   test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST,
+			    &fw_reset->reset_flags)) {
+		nack_request = true;
+	}
 
-	if (err || test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST, &fw_reset->reset_flags) ||
-	    !mlx5_is_reset_now_capable(dev, fw_reset->reset_method)) {
+	devlink = priv_to_devlink(dev);
+	/* For external resets, try to acquire devl_lock. Skip if devlink reset is
+	 * pending (lock already held)
+	 */
+	if (nack_request ||
+	    (!test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP,
+		       &fw_reset->reset_flags) &&
+	     !devl_trylock(devlink))) {
 		err = mlx5_fw_reset_set_reset_sync_nack(dev);
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Nack %s",
 			       err ? "Failed" : "Sent");
 		return;
 	}
+
 	if (mlx5_sync_reset_set_reset_requested(dev))
-		return;
+		goto unlock;
+
+	set_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
 
 	err = mlx5_fw_reset_set_reset_sync_ack(dev);
 	if (err)
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Ack Failed. Error code: %d\n", err);
 	else
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Ack. Device reset is expected.\n");
+
+unlock:
+	if (!test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags))
+		devl_unlock(devlink);
 }
 
 static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev, u16 dev_id)
@@ -722,6 +756,8 @@ static void mlx5_sync_reset_abort_event(struct work_struct *work)
 
 	if (mlx5_sync_reset_clear_reset_requested(dev, true))
 		return;
+
+	clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
 	mlx5_core_warn(dev, "PCI Sync FW Update Reset Aborted.\n");
 }
 
@@ -758,6 +794,7 @@ static void mlx5_sync_reset_timeout_work(struct work_struct *work)
 
 	if (mlx5_sync_reset_clear_reset_requested(dev, true))
 		return;
+	clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
 	mlx5_core_warn(dev, "PCI Sync FW Update Reset Timeout.\n");
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
index d5b28525c960..2d96b2adc1cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
@@ -10,6 +10,7 @@ int mlx5_fw_reset_query(struct mlx5_core_dev *dev, u8 *reset_level, u8 *reset_ty
 int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 				 struct netlink_ext_ack *extack);
 int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev);
+bool mlx5_fw_reset_in_progress(struct mlx5_core_dev *dev);
 
 int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev);
 void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked);
-- 
2.31.1


