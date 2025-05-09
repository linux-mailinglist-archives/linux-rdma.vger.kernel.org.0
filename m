Return-Path: <linux-rdma+bounces-10182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B8AB09FF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 07:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556B67BF377
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 05:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48526B09F;
	Fri,  9 May 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HXApGcdN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946D26B081;
	Fri,  9 May 2025 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769794; cv=fail; b=TlFUj/2IpB1ksMZM9rKitxHPUJix2DK4HrMxTgSzyXaQ0BrX0+v9JAGc+DOXB34dZ6ThLCj8JkbQ8lJMQ4SPblpg5MRR8k/3d/1UsOsbMoKbl6d2sox2gG0UwSBCXG7RARcxd3bLMzurbvnlmfA2evieZ9tzUdS1LdI6GutUZZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769794; c=relaxed/simple;
	bh=QbAPYdinVWbi3XXtdhznrwpKyIXwwhUt2rACrNs8bIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/i1TU5HSuK+M8sN5lcSrugkiR8Caot+M8qfScJ8kBR7HGE/snP/r8DDUVnnmvdZbrG4SJxI55cyCLfN7CzsloaLWgkRDYPVSIm2Q71hlwbxNOdWaDMabLD4AJmLnu2LT3zrsRfpFQj+kYwy3RYC7tH2EUwfD+u3WXUYHHfjyVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HXApGcdN; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvO1ZBVnXE8X2tajE/4jsoO1rbE18m+vpt1cSyXuJg/o9twbyTUfGvhpW4VjSrtt9r0GqfRr3JOrfkzKcOQt841oZC8gnPElo7ZDgGJ96uQsLsMyg52OXjQGIsi1Rv0nP3rjC/6+l7NF8tiCHlkVea2dB9WY3j2ogMrvhtl5OV0nXaG0PC9MyjjXzrWlDzC4fsBRY5maSEPnXNZI49vP/zfKqgMM9nAntssxqiQ2rk4yO9dN8eiAc8nbCc4JFyTyIK3P22wQiYSz4/OCE7UQYxfWPKTg2ZaKz4o1coPESIZ4I1Qasz19O8ns+nkX0tZoisbuwRgmMjWj2SRRky0y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQOpHjhhjgC5vAEBkkrCB+8r8M63mcDrsMSPDsK9LXI=;
 b=j0OXkUNHs7ZYhTec4DQ9d1k2Nq9MJAhckZ1t7+md6MCk1AqiegshuwreZxGZ37cGDzrMDLuMmn0GIw1l42V6jn6irorphW/AT3zGcAYY1ZvytDx0IF3cnymRksfb4SSNdl9HidbPGxASP+eRAyGg4kA56FqzsQnhLOttJH+Ed4mnPmPmTOitsUsBqC3c8uR6+hSkXKkTH/xCqQH95EvqQrslopsf/vyftson+cQbm8ZPHANICVnhwNV6PfyUHf2JXtxp+K1ffBRyyoVRrNZEHZneEYHY9R3wmZbk2oZocHNtSaIYwfyL6aErHimkG7ypwUKNgX5D52q84GaYvszywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQOpHjhhjgC5vAEBkkrCB+8r8M63mcDrsMSPDsK9LXI=;
 b=HXApGcdNPVl7z/Ee6kO6BdU/Qkyrg6KtQLvZZmi8XNETCew+7i41nc9CV9BJxLOqwaCbuSEbp51CldZoAB8vJ1P9x2MUbKuGJdjHwGXMy66tflxRQ1/MGpcTwE9HbZ3JCWrHCgXjafB5MbO0+TS6vStBuo3CCDsh5XbWylgIuNofAOrlr0UxWm/ac9kVtMsIP6hVn34AX1iXD6HZmH2aZPYtWQ0w44vqMzW9C17QUZSJq7Thx7kdg4ewCVbKzDq2+kYA41ZluZ9ifwmiZ6uEg05LS7tSIEJTFO6rMGFdjz3aKOiqqrq6Z6Rec7Xb68BU+KQJ9MsmA3f/BFRCuPIQdg==
Received: from SA0PR11CA0122.namprd11.prod.outlook.com (2603:10b6:806:131::7)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 9 May
 2025 05:49:47 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::ad) by SA0PR11CA0122.outlook.office365.com
 (2603:10b6:806:131::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 05:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 05:49:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 22:49:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 22:49:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 8 May
 2025 22:49:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next V9 3/5] net/mlx5: Add support for setting tc-bw on nodes
Date: Fri, 9 May 2025 08:43:07 +0300
Message-ID: <1746769389-463484-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 23344e03-6011-426a-41cf-08dd8ebd4dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzAwZHB1Rk05c0s1NURXdmkza0RWNzVKZEtiSUlmRytqbjkrYVFBY203L2Jh?=
 =?utf-8?B?dlhLOEoxUUR5SG5LUzUwNmFGQW41MEtpTm1xTXJwelhlVFpYYm52TGQvUmlF?=
 =?utf-8?B?RFcvM0grdEsrTGt3MjlJSWpNUHFoWmRBNDQvdXpWMkdGVCtHYVgvQm9mL3V4?=
 =?utf-8?B?U1NVMll5VkZVbExmcFZJTzU0RjNxZ2hkQTdKR0o0N2ZBTVdQQ3hON01XcDhm?=
 =?utf-8?B?ZXlrV3RVdUkxMFpEL0IxUzBxa3d6M1p1c3FZZGlWTVpTSVBEWW9xYmE2bUp0?=
 =?utf-8?B?eGtPSmE3OG43bkhmamJkd1ZKQ2dlSVFHOG9aL1c3YjdoSkhGQXoxUEkwMXIv?=
 =?utf-8?B?WG0ydkZHNXJGQWJQVVYrMUJ2KzM3TU9pRFBoUEZXdEovTVRQY1lmWUZnWFNP?=
 =?utf-8?B?MXN2Vi9LQzVacTFjZExkajJ2Q3IxRUZyb1htRVk4MzNXeFZVOS9tQmdjTTBa?=
 =?utf-8?B?aWp4bmlESjA3L0gxTmJMSS9iWG5LenVjUnh1aGFicjJVRmJPTHl3bFFwbHZ3?=
 =?utf-8?B?czVOTmF0RU0zUmhZaUhVbHZaVHIvdVNFaEo2QmZvdXlwNGNvNjBoclR6R3hI?=
 =?utf-8?B?NENQNDFLTEhIc2dKNk5jVzBqaGo4Yk1SWUs0RXN5d2FOdXdhZ0JYTU05RW04?=
 =?utf-8?B?bW04dlVueHJlTHBiTnJjR2R6SXRqSDFQcFJDK21RMCtxbVZrTTRZMU9HSENW?=
 =?utf-8?B?czR2bm5Ja3JDbThsL1hXbG1OcExtVXk3dDhERjRhTFVaL0ZIb1Npd2FFd2JI?=
 =?utf-8?B?MGN0bjY5eU41WDVyVVFReXFKSlZhRXZmUS9XTWNNS0ZXbExUa2grbWkzNU1J?=
 =?utf-8?B?YVFOdDVtL1ozZTlmNHNjY1NrSWRZMjhJOU53UmR3bVJiUWtHVWlZbzJ5cmxa?=
 =?utf-8?B?c2wvQVFlS25SUzc3K3ZnOS9NcmZiOWlucWFIbHBWLzF2SHhwRVdmWU9neVZH?=
 =?utf-8?B?NTlJTVJ6K3NpVXg0QW45THBRdHh0Q3EvSTBudlVIZGs5SUQ0MEFIZGp4QnJa?=
 =?utf-8?B?c0lvdEU1bzY0L1dmaUdVVGNRRytnU3dzTHNSRVhDa2NmRmxtaHN4cDdkUXV3?=
 =?utf-8?B?MmhiKzNDUjFUaGNsWUx5SDQ5cXFocFFUczRwS0pET0JMQUl3TU1FVkJvVk1u?=
 =?utf-8?B?UzU0aUJVbkdtMi9xSjVBNVhSZzkxbVlMV0lzMTlYY0c0ZUFPM0ZHOGdKSEpY?=
 =?utf-8?B?V1k5NGZlWVhiYTNnZWRIU2p0aEpnWWoyRzR6Z3Y1c2xzMWxNQ0JCRzNZc1lX?=
 =?utf-8?B?cHRFVzFRQjcwM1dldTRZMkFqa3ZMeWh4di8vSDhSdm9hdlBPRnlkN1Y4YlJx?=
 =?utf-8?B?OEhwZTlWa3ZQdUlpZzhzWGd2KzE1aDZONS9UQ1V2Q3VnL1NLSTVweUZtY0NO?=
 =?utf-8?B?eFBLbHJPMGxXejhVYktXN1ROMFo3NFZaaEhJc3VQTUxmaFo2U055N0NwT1ZW?=
 =?utf-8?B?dFQ1ZVU1SSswcHBFNkp3V1J6UFpFcDVoVTZoOEhlSmxGR2ZzS1lOWkQrcXRM?=
 =?utf-8?B?YkJ5VHVkYjBVK3Fxb0dNSUNKNFAxZUx0MllPbEMvTS93TS9BOVdOaHdpb1hJ?=
 =?utf-8?B?MjBhenpmUjRJWVpRc0RnM3dXVy9ZQ3VqMFBCck9NRUt0aXk0c2x0Rit3NTY3?=
 =?utf-8?B?cmxNMkprb1J2SGFTMVpZU0JLSU8ySXRsZFBLelR0MEdNSE9EWjM3dFptZkxi?=
 =?utf-8?B?bTJZZjAzOEZabWNlL1hxbW9XL3hiODBFMjN4VThwQWF5c1k5ZGV5bDE5QlNp?=
 =?utf-8?B?UGtYc3BKdERYMDZoeEtPczhpVldreEZoZUdCOElTWG5wZk5GSjlqOEJkODVU?=
 =?utf-8?B?VkhMcTR4cU1qTTNBL2tDL0lmTHpSNkdjOFowYjE4QzRyblhnK1ArZzY2bEpQ?=
 =?utf-8?B?ZURJSFlkVDZ5bHpmOFVVTlV3NHc1cmFBNzBHUUtTYlNXaGZ4ZDBqMWtWZWNt?=
 =?utf-8?B?NTEzTjZxeG9TRWh2bXkrUFkwVkZvM2NTYWRxTG1IRHI3QzVHTkNMYkpUREZh?=
 =?utf-8?B?dEZwaCtkaER1dlhCZGthdklrblJKVmFnN0pUL3hHeHVOczJrZE50R0U4MGhX?=
 =?utf-8?Q?BGptJt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 05:49:46.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23344e03-6011-426a-41cf-08dd8ebd4dea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for enabling and disabling Traffic Class (TC)
arbitration for existing devlink rate nodes. This patch adds support
for a new scheduling node type, `SCHED_NODE_TYPE_TC_ARBITER_TSAR`.

Key changes include:

- New helper functions for transitioning existing rate nodes to TC
  arbiter nodes and vice versa. These functions handle the allocation
  of TC arbiter nodes, copying of child nodes, and restoring vport QoS
  settings when TC arbitration is disabled.

- Implementation of `mlx5_esw_devlink_rate_node_tc_bw_set()` to manage
  tc-bw configuration on nodes.

- Introduced stubs for `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()`, which will be extended in
  future patches to provide full support for tc-bw on devlink rate
  objects.

- Validation functions for tc-bw settings, allowing graceful handling
  of unsupported traffic class bandwidth configurations.

- Updated `__esw_qos_alloc_node()` to insert the new node into the
  parent’s children list only if the parent is not NULL. For the root
  TSAR, the new node is inserted directly after the allocation call.

- Don't allow `tc-bw` configuration for nodes containing non-leaf
  children.

This patch lays the groundwork for future support for configuring tc-bw
on devlink rate nodes. Although the infrastructure is in place, full
support for tc-bw is not yet implemented; attempts to set tc-bw on
nodes will return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 313 +++++++++++++++++-
 1 file changed, 304 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ec706e9352e1..1066992c1503 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -64,11 +64,13 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
+	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
+	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -106,6 +108,13 @@ static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
 	}
 }
 
+static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
+{
+	int num_tcs = mlx5_max_tc(dev) + 1;
+
+	return num_tcs < DEVLINK_RATE_TCS_MAX ? num_tcs : DEVLINK_RATE_TCS_MAX;
+}
+
 static void
 esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
 {
@@ -116,6 +125,27 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 	esw_qos_node_attach_to_parent(node);
 }
 
+static void esw_qos_nodes_set_parent(struct list_head *nodes,
+				     struct mlx5_esw_sched_node *parent)
+{
+	struct mlx5_esw_sched_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, nodes, entry) {
+		esw_qos_node_set_parent(node, parent);
+		if (!list_empty(&node->children) &&
+		    parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+			struct mlx5_esw_sched_node *child;
+
+			list_for_each_entry(child, &node->children, entry) {
+				struct mlx5_vport *vport = child->vport;
+
+				if (vport)
+					vport->qos.sched_node->parent = parent;
+			}
+		}
+	}
+}
+
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
 	kfree(vport->qos.sched_node);
@@ -141,16 +171,24 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
-	if (node->vport) {
+	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
-		return;
+		break;
+	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
+	case SCHED_NODE_TYPE_VPORTS_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (err=%d)\n",
+			 op, sched_node_type_str[node->type], err);
+		break;
+	default:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s scheduling element failed (err=%d)\n",
+			 op, err);
+		break;
 	}
-
-	esw_warn(node->esw->dev,
-		 "E-Switch %s %s scheduling element failed (err=%d)\n",
-		 op, sched_node_type_str[node->type], err);
 }
 
 static int esw_qos_node_create_sched_element(struct mlx5_esw_sched_node *node, void *ctx,
@@ -388,6 +426,14 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
 	esw_qos_node_attach_to_parent(node);
+	if (!parent) {
+		/* The caller is responsible for inserting the node into the
+		 * parent list if necessary. This function can also be used with
+		 * a NULL parent, which doesn't necessarily indicate that it
+		 * refers to the root scheduling element.
+		 */
+		list_del_init(&node->entry);
+	}
 
 	return node;
 }
@@ -426,6 +472,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
+	list_add_tail(&node->entry, &esw->qos.domain->nodes);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
@@ -498,6 +545,9 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 					  SCHED_NODE_TYPE_VPORTS_TSAR,
 					  NULL))
 			esw->qos.node0 = ERR_PTR(-ENOMEM);
+		else
+			list_add_tail(&esw->qos.node0->entry,
+				      &esw->qos.domain->nodes);
 	}
 	if (IS_ERR(esw->qos.node0)) {
 		err = PTR_ERR(esw->qos.node0);
@@ -555,6 +605,18 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
+static void
+esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
+				       struct netlink_ext_ack *extack)
+{}
+
+static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
+	return -EOPNOTSUPP;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
@@ -723,6 +785,195 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	return err;
 }
 
+static void
+esw_qos_switch_vport_tcs_to_vport(struct mlx5_esw_sched_node *tc_arbiter_node,
+				  struct mlx5_esw_sched_node *node,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *vport_tc_node, *tmp;
+
+	vports_tc_node = list_first_entry(&tc_arbiter_node->children,
+					  struct mlx5_esw_sched_node,
+					  entry);
+
+	list_for_each_entry_safe(vport_tc_node, tmp, &vports_tc_node->children,
+				 entry)
+		esw_qos_vport_update_parent(vport_tc_node->vport, node, extack);
+}
+
+static int esw_qos_switch_tc_arbiter_node_to_vports(
+	struct mlx5_esw_sched_node *tc_arbiter_node,
+	struct mlx5_esw_sched_node *node,
+	struct netlink_ext_ack *extack)
+{
+	u32 parent_tsar_ix = node->parent ?
+			     node->parent->ix : node->esw->qos.root_tsar_ix;
+	int err;
+
+	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix,
+					     node->max_rate, node->bw_share,
+					     &node->ix);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to create scheduling element for vports node when disabliing vports TC QoS");
+		return err;
+	}
+
+	node->type = SCHED_NODE_TYPE_VPORTS_TSAR;
+
+	/* Disable TC QoS for vports in the arbiter node. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, extack);
+
+	return 0;
+}
+
+static int esw_qos_switch_vports_node_to_tc_arbiter(
+	struct mlx5_esw_sched_node *node,
+	struct mlx5_esw_sched_node *tc_arbiter_node,
+	struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node, *tmp;
+	struct mlx5_vport *vport;
+	int err;
+
+	/* Enable TC QoS for each vport in the node. */
+	list_for_each_entry_safe(vport_node, tmp, &node->children, entry) {
+		vport = vport_node->vport;
+		err = esw_qos_vport_update_parent(vport, tc_arbiter_node,
+						  extack);
+		if  (err)
+			goto err_out;
+	}
+
+	/* Destroy the current vports node TSAR. */
+	err = mlx5_destroy_scheduling_element_cmd(node->esw->dev,
+						  SCHEDULING_HIERARCHY_E_SWITCH,
+						  node->ix);
+	if (err)
+		goto err_out;
+
+	return 0;
+err_out:
+	/* Restore vports back into the node if an error occurs. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, NULL);
+
+	return err;
+}
+
+static struct mlx5_esw_sched_node *
+esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
+{
+	struct mlx5_esw_sched_node *new_node;
+
+	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
+					curr_node->type, NULL);
+	if (!IS_ERR(new_node))
+		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+
+	return new_node;
+}
+
+static int esw_qos_node_disable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node;
+	int err;
+
+	if (node->type != SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Allocate a new rate node to hold the current state, which will allow
+	 * for restoring the vports back to this node after disabling TC
+	 * arbitration.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up vports node");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Disable TC QoS for all vports, and assign them back to the node. */
+	err = esw_qos_switch_tc_arbiter_node_to_vports(curr_node, node, extack);
+	if (err)
+		goto err_out;
+
+	/* Clean up the TC arbiter node after disabling TC QoS for vports. */
+	esw_qos_tc_arbiter_scheduling_teardown(curr_node, extack);
+	goto out;
+err_out:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
+static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node, *child;
+	int err, new_level, max_level;
+
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Increase the hierarchy level by one to account for the additional
+	 * vports TC scheduling node, and verify that the new level does not
+	 * exceed the maximum allowed depth.
+	 */
+	new_level = node->level + 1;
+	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
+	if (new_level > max_level) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TC arbitration on nodes is not supported beyond max scheduling depth");
+		return -EOPNOTSUPP;
+	}
+
+	/* Ensure the node does not contain non-leaf children before assigning
+	 * TC bandwidth.
+	 */
+	if (!list_empty(&node->children)) {
+		list_for_each_entry(child, &node->children, entry) {
+			if (!child->vport) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Cannot configure TC bandwidth on a node with non-leaf children");
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	/* Allocate a new node that will store the information of the current
+	 * node. This will be used later to restore the node if necessary.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up node TC QoS");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Initialize the TC arbiter node for QoS management.
+	 * This step prepares the node for handling Traffic Class arbitration.
+	 */
+	err = esw_qos_tc_arbiter_scheduling_setup(node, extack);
+	if (err)
+		goto err_setup;
+
+	/* Enable TC QoS for each vport within the current node. */
+	err = esw_qos_switch_vports_node_to_tc_arbiter(curr_node, node, extack);
+	if (err)
+		goto err_switch_vports;
+	goto out;
+
+err_switch_vports:
+	esw_qos_tc_arbiter_scheduling_teardown(node, NULL);
+	node->ix = curr_node->ix;
+	node->type = curr_node->type;
+err_setup:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
 static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 {
 	struct ethtool_link_ksettings lksettings;
@@ -848,6 +1099,31 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
+					       u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
+{
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
 	if (esw->qos.domain)
@@ -921,9 +1197,28 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 					 u32 *tc_bw,
 					 struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack,
-			   "TC bandwidth shares are not supported on nodes");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
+	bool disable;
+	int err;
+
+	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch traffic classes number is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+	if (disable) {
+		err = esw_qos_node_disable_tc_arbitration(node, extack);
+		goto unlock;
+	}
+
+	err = esw_qos_node_enable_tc_arbitration(node, extack);
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
-- 
2.31.1


