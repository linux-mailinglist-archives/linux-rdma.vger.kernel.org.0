Return-Path: <linux-rdma+bounces-21352-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFwzBWvrFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21352-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:02:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838785E48D9
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 146323013B56
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED43E0087;
	Wed, 27 May 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSkyVkGE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB931F9A4;
	Wed, 27 May 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886532; cv=fail; b=M3VnHlMhZdXpsAHNu1NSBX0EEupuAwi6r+O9Xe2r+jjFWjDSUgCswXliqC62srEavHjM1xtBMEM5+DbfV483eo/T+vBvn/WH+Ospow5zy1smi17cMNkw6pbYRT27cQ/yfeD8XhujTK2BKxMUJak1kiL52E9ZBJpmLJhWNbWsEUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886532; c=relaxed/simple;
	bh=kqg525A/p3kwSuVLlNWYidx9zUL49Mf4WQSa3O0wOc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LtoPIPP6lm/EQd3NxRUiVQbWu5uMzFB4HPz49pnDrO2EBuxeLYo+1eATh1fnxxt7VZQ220FBppycm9pxmISdr17QjVUwlQqJQK96qyuCZD+Z0FwSexDrehHY7wXTbSni7WVJgXSN0d7NVjWuyr25Qnl2eZ6lmTSmQHMaueVqmuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSkyVkGE; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ak4KAWcu4DwQ9xmVPFPptghYLh/AWU/pjl6l4tC7RJZSaooMM4wwrUmz2RLz5BuZsNoei6a7ZFk68L8ZrdqyvD7QaE0ffYkmm1K7/PZ/8OEwqQzOUceKgWmyMNt7GtHDgqf8hf7vymaIF4k9pEsY0eK0TgUzXFYKtYsTfrwrl7dq5vdLSFRaTag0KQ7LiDmVOJbyn/S+Tf6EBasnwhg7t7Pij13zHCHDzvZHBx++gXEbQlCswfYlMXDCW/9LLjIKKcc+zv1WIodVtaTM0S+ngrgjsmw7/0LiDUCv0O4dQITjCVavwIWfkVCJnfkzKZZihV5NjQVbf4TE92nudUwSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxys6uu9eCbdHxbCvmGqOQ23xpONLouWzHlMLfa4XGg=;
 b=eAPnTu9VTquIHwjIWJ6oWtu4Yqwiv7wU/x+wwjU6O+qftdiC1K42yCM3fwij2AzymBJnLkQdpRq1RjdZPFQeMM5DMFkn/DQIl/YTt33xTep16I8TTOiMJy9koE6JNr8nQlmb9XpwMpy/gmuh6DOOVwKCaRYtJOCq+/L3y066FMT3kMDqtfxHUsRoNy0WJrnlbuOUvpwP56h0I3BhTCJ8YUVLii0ZhG3xTYhZnvTox4fzbWJcwYwEsvG4ho5jP0r+rXuTB+LAHfuV0Q68SF7QkA499aSdWXznq2lgRFaVUxPIf28pu4IJlp+vUs2BmHXF1th0ra1pDJVgOrU9qGSFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxys6uu9eCbdHxbCvmGqOQ23xpONLouWzHlMLfa4XGg=;
 b=PSkyVkGEIp7m+KlcuUMvtGs3jptvHqIXLHf0ZuB6sTrFyh53efJnr5uvt/fXLsyS2UJnnGkgThvD7UED77/Vw8H59kk9FOhprHIu7m3dMh3LX3p0h1clU15tfDaqlzIJF9lZLXcsaExpMxqUhep0kFtKy6ID7nrTnf04ib+90FFApexVzN3jY5sDiCFlMp0mcc8d/uyeRTEl8EVF6aQzHbz9VxNQN6OcJYdRpRIN0cJGd7opeWh9HKQWqcklStZdQI922dY5/GYd2yfNfd6K79UKEkS3Z16nOG5ijWU8Su5EFCGopaNDk7J/5JU2/NIKzOxi7LZU0aY3anFPPXG3vA==
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 27 May
 2026 12:55:22 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::2e) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:55:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:54:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 00/13] net/mlx5: Add switchdev mode support for Socket Direct single netdev, part 1/2
Date: Wed, 27 May 2026 15:54:14 +0300
Message-ID: <20260527125427.385976-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e63ca4-2437-4210-d5b9-08debbef36a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|3023799007|5023799004|6133799003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UMubzqOS6phzFGtBJ3/Vyvteu98a/lVGSvfA5LMBkMMyxx9+fceWJk0ZuNuvWmB+73XtUgg334nlku302sJ2U/yQ0PJeqrjciyhZRym8VRn5oiNz+2xl+iJdJhaqhnfpXzXapXqV7vAQQLd6/lzG/sTm7yKkwg+m8Vwmj2wYHpRUrwcX7jns2wFYQWhehTDZ+Mq4EjCC0Eo55r1/GtrVc9NhGtSkzR9dG1GqOdc2IVlf05w4Z6vmPnUNsa3jQNVmR81I+7nOhUH8pTkeENZ36Ft/NCXlitFLgjXrSbr81lgXJZ5dn8KO+1Xj7Lrb0pozERxkjy6NfQCq/ABzr8CXIMTEUabTq5hevJmp4g8Zft+m63eGIz/FqTkX0o+g3X09O7CHE0G+WAURm93/eLK0LFuX9YycrgXkff5g0DJQN0BrJ1ZdAtGoMf6/5ybOkrwnrSPX/pwZkba10Eb6kcTPJ9dkGe8NMkU77xU6Hmyd13yYwTyZqVxOOUotmSgD4PnMgZYH1hjm8rKa0zvRFXhUjrNDeW6gwrmQQpHawsDdGSz+7NUmQVDkCn7SfNvr8fYynanLaO0pDpmJEdA6v5S5wrDlItj7/Vu740ncbMDXxOcPuEgQBVWhUh7sANy6Ea6a0nR17B7BuYmfgUG813mpjusEzx/PmBzE4N79t7xfhQMU5WGDRz0ZkAeXdBd1khlEzUQ3Mpueop0M9XmFGeWL347xcCL5ud9syLyaEVyNjnU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(3023799007)(5023799004)(6133799003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o8jkcFTM8xQmgC7w7RhJ+BYRETCm65GXTgxdKWSlXJmlxzBlx/ux+qKSE7RVRSpUCWd/owSDKbZCf6+2aJZ9P/9A9NnvlCdQojeayqfBP3XgcHewbzgtLgwF3ZwNM7Z5x9Vg5nPKOcwWjpBFwY4ayd9Wm5fUaJMSC7Kq7Rn8qMA6zRIJMzf5DlQfQcCZsA0mSWUbz0xeN/DS2Q/f2CxSAF0EeF7LQ38qHMZsXpzfolRB4kuBKLy61EFMBMZX8vapk8pCzJU2Ip/zFQvflIaK4b9CreJ6wOG5l0nOo5xFlw8eUegfZQvlAP1Wa6r2PbMwXrWnKI3vY2FNUgeHjo5sgcm1f9BIA1OAihHLKDcsL4i3KTGbIYkiMm4mIJxEIf29RrJIn3Yj39+mgj7No4hPtWrKyxOlEuCD7Z1llQKaI+JahJYrKMS4QQ6YbLig8eu5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:55:22.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e63ca4-2437-4210-d5b9-08debbef36a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21352-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 838785E48D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series enables Socket Direct single netdev to operate in switchdev
mode with shared FDB. See detailed feature description by Shay below.

Regards,
Tariq


This series enables Socket Direct single netdev to operate in switchdev
mode with shared FDB. SD single netdev combines multiple PCI functions
behind a single netdev interface. To support switchdev offloads, these
functions must participate in virtual LAG (shared FDB).

Design

Rather than introducing a separate LAG instance for SD, this series
integrates SD secondary devices into the existing LAG structure
(priv.lag) created at probe time. Each lag_func entry carries a
group_id field that identifies its SD group membership (0 means not
part of any SD group). An xarray mark (XA_MARK_PORT) distinguishes
physical port entries from SD secondaries, enabling a single unified
iterator that filters by group:

  - MLX5_LAG_FILTER_PORTS: iterate port-level entries only (existing
    behavior, used by bonding, FW LAG commands, v2p_map)
  - MLX5_LAG_FILTER_ALL: iterate all devices including SD secondaries
    (used by MPESW shared FDB across all devices)
  - specific group_id: iterate only devices in that SD group (used by
    per-group SD shared FDB operations)

Existing callers use mlx5_ldev_for_each() which maps to
MLX5_LAG_FILTER_PORTS, preserving current behavior for non-SD
configurations.

Lifecycle and ownership

The SD LAG lifecycle is tied to the SD group, not to bonding events:

1. At PCI probe, mlx5_lag_add_mdev() creates the LAG structure
   (priv.lag) for each LAG-capable PF. e.g.: SD primary devices

2. During mlx5_sd_init(), after the SD group is fully formed (primary
   and secondaries paired), sd_lag_init() registers the secondary
   devices into the primary's existing priv.lag by calling
   mlx5_ldev_add_mdev() with the SD group_id. The primary's lag_func
   also gets its group_id set. No separate LAG instance is created.

3. After all the devices in SD group transition to switchdev,
   mlx5_lag_shared_fdb_create() is invoked with the group_id to create
   a software-only shared FDB scoped to that SD group. This sets
   sd_fdb_active on all lag_func entries in the group. No FW LAG
   commands are issued since SD devices share the same physical port.

4. If MPESW (multi-port eswitch) is enabled on top of SD groups, the
   per-group SD shared FDB is torn down first, then MPESW shared FDB is
   created spanning all devices (ports + SD secondaries) using
   MLX5_LAG_FILTER_ALL. On MPESW disable, per-group SD shared FDB is
   restored.

5. On SD teardown (mlx5_sd_cleanup or device unbind), sd_lag_cleanup()
   removes secondaries from priv.lag and clears the primary's group_id.
   The LAG structure itself is not destroyed.

The sd_fdb_active flag is set on all lag_func entries in a group (not
just the primary), so any device can detect the SD shared FDB state
during lag_disable_change teardown without needing to look up peer
entries.

SD shared FDB is a pure software construct -- unlike regular LAG modes
(ROCE, SRIOV, MPESW), it does not issue FW create_lag/destroy_lag
commands. The software vport LAG for SD is implemented via eswitch
egress ACL bounce rules, managed by the IB layer through
mlx5_eth_lag_init(). And the software LAG demux is implemented via
steering rules that utilize new destination, VHCA_RX.

Patches

Infrastructure (patches 1, 5-6):
  - Factor out shared FDB code into a dedicated file
  - Extend lag_func with group_id and sd_fdb_active fields;
    add XA_MARK_PORT and unified iterator with group_id filter
  - Extend shared FDB API with group_id parameter

E-Switch preparation (patches 2-3):
  - Align eswitch disable sequence ordering
  - Move devcom init from TC to eswitch layer

SD group management (patches 4, 7-9):
  - Replace peer count check with direct peer lookup
  - Register SD secondaries in the existing LAG at SD init time
  - Block RoCE and VF LAG for SD devices
  - Block multipath LAG for SD devices

Switchdev integration (patch 10):
  - Keep netdev resources local in switchdev mode

Steering (patches 11-12):
  - Track peer flow slots with bitmap for selective peer flow deletion
  - Enable TC flow steering for SD LAG

Enablement (patch 13):
  - Verify unique vhca_id count for cross-VHCA RQT

Shay Drory (13):
  net/mlx5: LAG, factor out shared FDB code into dedicated file
  net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy
    transition
  net/mlx5: E-Switch, move devcom init from TC to eswitch layer
  net/mlx5: LAG, replace peer count check with direct peer lookup
  net/mlx5: LAG, prepare for SD device integration
  net/mlx5: LAG, extend shared FDB API with group_id filter
  net/mlx5: SD, introduce Socket Direct LAG
  net/mlx5: LAG, block RoCE and VF LAG for SD devices
  net/mlx5: LAG, block multipath LAG for SD devices
  net/mlx5: SD, keep netdev resources on same PF in switchdev mode
  net/mlx5e: TC, track peer flow slots with bitmap
  net/mlx5e: TC, enable steering for SD LAG
  net/mlx5e: Verify unique vhca_id count instead of range

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  27 +-
 .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   7 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  83 ++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  26 ++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 429 ++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h | 100 +++-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |   4 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  28 +-
 .../mellanox/mlx5/core/lag/shared_fdb.c       | 233 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 227 +++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  23 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   3 +-
 14 files changed, 914 insertions(+), 289 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c


base-commit: aa064a614efcfa4c300609d1f01134e99a12ad10
-- 
2.44.0


