Return-Path: <linux-rdma+bounces-12720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A888FB25380
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DDC5C1408
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8FA305E35;
	Wed, 13 Aug 2025 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I2QkoXIc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A67305E2A;
	Wed, 13 Aug 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111424; cv=fail; b=ZSY5CsDJqFDg6jOxc+dsYrM85JhO94MydAQQAOGXvnLGLo2U0by/J5R5neGsExWwJFw0azshI/136Z9xg+e70d6wjxvU9tpAgBWaV1HPu17zlnhVdd3CYTfevaJgVTD9l4XjPWnDQP53tt/6gMzKSze8H2coImYspGxZxXvQl4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111424; c=relaxed/simple;
	bh=bpaGTdNufOcgWmLgBYcOIi7YgNK/i37WCEh8kn+ahrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4b7I6qdW3ymcTZT0RE1NrMOjJymcct1TE50tqGVlSfcyU0iLgGzerqJO8UIVkpjH2Thg6JYjDaUXHsMZ4Nh27gJOYqRiDnittVyjRAlHb3hXQu+a5kJ8//hz1mjIXzqNEUs50H2SyXrGm4d00cslI61WN+3HM5RsTpLRapEZq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I2QkoXIc; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKx2VVwVZaG/wlQTQOpkIBTpbkxIeWo8rBRvm1Wyn2RMG1bxZ76TJooZvkNze++GC2QEr9Nv8P/cJlk2Cbi0xwnKQHwa3md0TonSgDZq1OehUPJGysM31yRJyquDA4NSXs+JfBrVrxbOOSsRqaCF0QYO5s/eqOjsTGliik3Bj1151Y2gFiTY3ENQoz7DClQsdZqBsw04AnrvAJa3nGmOIpZtc1WYB0nfRfRzh6ytM4Q+ao9Rqd+19C3oATehnLo7YdDBBJxX6pzZG2fQECcWL5zs4/Y1Iz8SC0F0CTPvXZ1iTo/7WnXV9ZK3mK0e/NZFFEaE60yFqM3tAqaw/2o1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya3u/VU+6QdkvhIk4g9Ohazh/sHNKSNHpVk1YHxknQM=;
 b=vA0KCiyWMp17j0PUkWl54zsHLWXHaRuYyNECctC8gdlYAqxdcueinIYL4ybKMrIgXH61phsZhFG3BkRqJH+HXlnvjDkpUYV3K3WfzvceRLH0iFNCIvMNp4OIANciBo92X29v9sORN9lF9khTok7mtfd5hKiNYC6nTT/5UQnCes0J5yK7+LIj/WIj9pupEHZL0bH2cF6TiEeXdgZdNGUwun4/2J0WhSOAXJ/2YPhsRCbFh8eZ9xa/DpGskbgEi3KzPT/u1NmuOZSYrNx5x/PZVDkCFY/Unpqb4xhpJx1OKTFJDfZxOO0/+8OKtf+mGhxwxs1w3Vo8Y0qiHJE6aZt8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya3u/VU+6QdkvhIk4g9Ohazh/sHNKSNHpVk1YHxknQM=;
 b=I2QkoXIcbJHQA4UPlHGfkHSN7DYO2gprRfrZmWAuy56VsrzItd9sDwmxucUJzRMaMfWdqbVtSDNJUMNpBegbRwb7y9DXCa6ZbjuoEm7xSmwg0vXj7Ap5tEWXeWBZy+3eaLV2pPWBSYNjXg2Sd+gZUWYIh9MFyNTQXNJ77WbiHINlsFZjzdo0HzXqZzqqAp/f4D/uS+AhnZD73LWOA5MzZ+LcNMu2hy1NveZCMdKSzPi8fG54TtjynHm2H66Dzw2uFQ5IHRyzgqF+ldpwcHu2k/auCEA82Y0FoWuSfxqs1I3f0LWFMua8MEodgW9vm6fQgg8pBBJmlaf/esyIV9PhAA==
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 18:56:56 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::4) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 18:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:56:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:56:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:56:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 11:56:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
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
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Shahar
 Shitrit" <shshitrit@nvidia.com>
Subject: [PATCH net-next V3 1/5] devlink: Move graceful period parameter to reporter ops
Date: Wed, 13 Aug 2025 21:55:45 +0300
Message-ID: <1755111349-416632-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: a3df5e19-9a82-47be-af9e-08ddda9b2c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnQHFzXiOn+PTxEeAmAP+QGOdOvli8HubOc2GMNRtbfSB2QnD7Jzqr91s02N?=
 =?us-ascii?Q?KPm+YbN1P3WM0+fSPsKWUBBUjndf2wxWS9Gyw0BJr8WaQQUJCQ0dXAORc02i?=
 =?us-ascii?Q?5KLgbfrjgfGQgJgIKNaxcjoL687ZkSOOTGd0n/hUYXYNuTejgqkZ2x6tYGrM?=
 =?us-ascii?Q?06J8MCCxmpZsCi8BIR9q1ogVPd5hOOhMWWCY30TjEHS5NZZlhRz1sVeiAv70?=
 =?us-ascii?Q?KgG1thjqCtYsgh0hGFjpYVbMNdfOdbKIh12jS48uM7DjtuUFSS1hOUqvMVmG?=
 =?us-ascii?Q?DktA/FstgpmXAqPl5/hqKo3bGg9mbB4JZLT3Dtx6blKxBOpwbGo1v3Vtm3N7?=
 =?us-ascii?Q?zxRQ8VUUIdakdSrrje42i2Rh35r64PXJJTVQWfmFVa+7A9VBMX2MH0SUdrq1?=
 =?us-ascii?Q?mLHWBW6rLuUlo3WRrUMv77b76xsve0iLjs39iL1eXh7Wn/QnV2q79oOqv3EB?=
 =?us-ascii?Q?vKpHC1gbt7I6vOjbUIm4dUPUB8nvEBQbWKIC4xrxX1GJtrld4h1Vlo4msZ8u?=
 =?us-ascii?Q?832dJ3lIPlUWbUKueHHwp71517KeakDN74AGO3JuKXdM9cbS6MAwCwfZFO2j?=
 =?us-ascii?Q?FMtP9A8U0OTo29J/+PRcorp1pbEJLK7bVYIi1nIB5ntlDAeZvMxDlwmmrVcL?=
 =?us-ascii?Q?09HOR/r1XmRRVUAdVhGrQx6Qqils7LrJH4Z5AUGvig0i3XkaHXH1lr+u9j6h?=
 =?us-ascii?Q?AP3RKpcCjeSPz/uehAiep95BPAMXnUX+Y5D4JksbXcE1VfMif78OBsmol8Es?=
 =?us-ascii?Q?+OAEgaL+udJZaeYXSaqOh6NigCgH+loVJAsj93Camt9Gljpa2LpXNCgjDxQx?=
 =?us-ascii?Q?NJj7OHwPywZ3UJtP4vbs8p7DdDsoKdEh7T9QzV+XxWcPODtyFlY0bcV0Er6Y?=
 =?us-ascii?Q?AlAlV+sgO2q2H1DDlO3d7yvLDrHwrH/viVYzbn77Uj37cT/p+wf6RhXffANa?=
 =?us-ascii?Q?B+89+z4nKrZW/MoNbHx4mCU9Q7P4bS6T1Zwl7I7qBqK0yvfzIbS5ePh+0JcU?=
 =?us-ascii?Q?o0HOFOSBYlXK4OEv88e9FAyrJ3Wsp2xUFyiPkzYxANpiiV76DoUccgv4m+UK?=
 =?us-ascii?Q?QWnhfx9G0fihN8OMf0XO/IVKUOliewhCoSw9/YXz0p3UG1+DJ4ibQF0ndCpl?=
 =?us-ascii?Q?YiRoDdP+N4ac7Icn8t0peROtSHdztl3r+fO2k7drakz8DV6s1JscbNfPE/Qg?=
 =?us-ascii?Q?so0V/trZ0mhGD3Vi9qFDvxpTneLe2cCeNUH9P5iVYLeccxxo6xPWFgVxOzL2?=
 =?us-ascii?Q?4s/cA6LvjwA1HHN8b5NIpbbMERY7e1XO+z7nuaLoNzlrRO9rXGlyLYNbot5I?=
 =?us-ascii?Q?fcEc5kGDfvmGYN2TZNAUicJFnBHQau8S5cd8BrVVERQkTbQ+sbpr3IHt3Ail?=
 =?us-ascii?Q?GoUGi5mzkY4QLenvF3Ii+wicjudzwwPA9RvaHrP+rJSkZ0J6/kDeyRwEhHDg?=
 =?us-ascii?Q?+Bz9s0Q2CnUEmdSV9dcoGauOM7tHG30hfkf25pfXvQZmtO9FJxT56rwbfX70?=
 =?us-ascii?Q?ML4BBJY45YxHahL5WFPaICUaySwu6SmnoRwx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:56:55.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3df5e19-9a82-47be-af9e-08ddda9b2c8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558

From: Shahar Shitrit <shshitrit@nvidia.com>

Move the default graceful period from a parameter to
devlink_health_reporter_create() to a field in the
devlink_health_reporter_ops structure.

This change improves consistency, as the graceful period is inherently
tied to the reporter's behavior and recovery policy. It simplifies the
signature of devlink_health_reporter_create() and its internal helper
functions. It also centralizes the reporter configuration at the ops
structure, preparing the groundwork for a downstream patch that will
introduce a devlink health reporter error burst period attribute whose
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
index ab519c0f28bf..8e9a8a8178d4 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -450,9 +450,8 @@ ice_init_devlink_rep(struct ice_pf *pf,
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
index 16c44d628eda..1b9ea72abc5a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -651,22 +651,24 @@ void mlx5e_reporter_icosq_resume_recovery(struct mlx5e_channel *c)
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
index 85d5cb39b107..7a4a77f6fe6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -539,22 +539,24 @@ void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
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


