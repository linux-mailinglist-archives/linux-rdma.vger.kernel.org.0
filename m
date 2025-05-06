Return-Path: <linux-rdma+bounces-10075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92099AAC294
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9123BA12F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4327C177;
	Tue,  6 May 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgC357U1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52351C84C5;
	Tue,  6 May 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530870; cv=fail; b=qCXtYC2OhdMbYjzUQL3jnFAcGlwnBCGxW2lAWTKfjzrSU8lPYabHbt1VIjNaS2NVykmvArU9rW6I7htG0m40CXL/htebolSp/fgWnZriJ3bO/cVcxqoBzM+2LC/XSosq5/Wyvw6k4N72yLfIMX9Sh4RhGxhH72aJjOiv3zYiBjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530870; c=relaxed/simple;
	bh=lgJbu0ECHG9aeQY2NbNtz+wdtOSHCxmpoIVqmO2UCDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGOsnGYkopSgyobPsq9ISHepkfNnxzCukzh53dbZe5zWBPJhpv79WM8qmnq7sDO0RoaRmb8/ovA4eMjRCHr35cmrj9/QfGPXpEacVhJYxreBlwem3Bej9Vkx/QfUkmh9qodvYorD/nTvLE7tj2zLNqfVjUExNsVLaw4lroUkMIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgC357U1; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgjFJT0kZODeJ1q+olBbGDVXh33PKoy6OKUJ2LQh+/tDeLkZBxQ/HvBJuEDoS44Xm+WAKtrTl0KL6K7QCAxPTPFm4YC+Zbr9VfJsWE15/ItMYlaMcNXYiAEvEg4wZFjdlh9o5pVcM54yKYdBWDbwJCp7Axn/ElTOgbHJqWv1LDzT5LhkMiHVUhmPX2Jn42EOZqThvmqhnr0BaJLZEe0QQxFPr3tJuxA3uM87pYd+0rDjPC+F8CfdJ/iFBRdPODHaqaLqzbdWHFs/9YBP3AUOvvIbp2iozI/wwK7ueyYfwVNauS8hnOZo847edf2Q/+Duu595SRsJEOVCQg5q08xxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z42hs6IrNvRxY/wJhSsvCbZ9dNLF+C9zgVMbCjfhXOA=;
 b=xlSzvFkKd6/UGH8DvvGwgIf4uhYudcyNKuWgv6ik/d9Tpq7J6KSL3VDtoO2sV/Zpb2/wslOWRFZi/9etDDMlA38O6d/RFk2WKb8lbarlu2ReLBPoGyqKq+peZ1+BOewUkQaR2AaAg3WfsAJLGAX2oBjCfSbE3HuVl9Elt7oN1ClfaOnxyG/cBnExfftJnkPq2DzZJRFpm165Zxbt8ecQlOy9stHKYI17WZYdxdx2yaVJgThYr4/l6ZE0SCy3YN5wFS4/K05mC0Vd0/mBcsVWREon/PHiVUqTCC69hL2chdh8VJSQyzZdESNBj4SJWgrtxkGsf2E/cVOeYLGSUj8+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z42hs6IrNvRxY/wJhSsvCbZ9dNLF+C9zgVMbCjfhXOA=;
 b=cgC357U1acxdgph+F9X0dqVLZRaljWS4vUgCDeIROb+jYvnUaXUtCIdi8IG2Zz2T3YB0TDBC28wEq3RoypsJcgUBf8eNtWeuxFBH0N48FCIfF+BvRcqAXa+r3NdT7NWJs2nAp46WGH14Wp+nzVsfXcssi4jZAF6jg+q0MiHclLY+DtUREnYpOKJCXhhol2hXdJ4vItQIqHRXe50NrWB/CAuHHyXj34d8laas/PnT/2S6oJmIcpHocBBhy7Pkqdxpn/ZVTsR5pIOcgTDtJpOEUVLdMg3nipeOoeG9473upD12CKUFbwXVPYzR1gHSlQ7H52dkOUdNvMSCgS7wqjCubg==
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 11:27:37 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::fd) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 11:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:27:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 04:27:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:27:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 04:27:21 -0700
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
Subject: [PATCH net-next V8 3/5] net/mlx5: Add support for setting tc-bw on nodes
Date: Tue, 6 May 2025 14:26:41 +0300
Message-ID: <1746530803-450152-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
References: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fb962e-8975-4d92-d6f4-08dd8c910114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1FURlFJYWtHQTBpMVZtWjFkaTcvRzNvekV6anFZNVdudjVKT3R4L3JtOXNl?=
 =?utf-8?B?MGgybStxRHZvc3BjWWZhQkU4MitjOEpjVk1PdlVldjl3VWxsRmxqVi90NXVR?=
 =?utf-8?B?UDFlUnBoN3d6M2x0c2kwRjk1RW9OUDFtQUZxL01uM1lmRkVjeEJFOHRsRlo2?=
 =?utf-8?B?OTZZMzN2QzlOQnpzclBxcGZxYVBTT2RldXdSRCtKclRpUmFReExUUUhxQnRQ?=
 =?utf-8?B?ZHJpK21LRUNBNmptVVJhOWQ2NVZmUG5seUlCU3ZGWHZsMHBBTDBycVdESnIv?=
 =?utf-8?B?R3BodGVlTXViTHNqeVlnR3BwWC8xVVFyemNUVzRPTlFNVVkrYWw2RHJtdHNv?=
 =?utf-8?B?NmVoSjBtS1IreFdhcE9lSm95dzVJYlpwTFdCVnJoNVpaaTRadGdjUHpKeDll?=
 =?utf-8?B?aWdzZVdLbHQ2cFZwSFBCc0U2ZGtWOEtRYUtiOUJEazRTcVpsTlBTWjRYUllh?=
 =?utf-8?B?WEZGY3R2eWZvWTJhak1GTlNTMWYycDlDZ2VISTdPNWZnYnhiOStVZjRwcnJB?=
 =?utf-8?B?NWpicGI4UXdydXJIeHZlZ1ovWFNVMXdzTDN4Mys3ZjlodEVGRkpmM2VBSHlQ?=
 =?utf-8?B?bXVYb2F0Rzk3ckhUdXF4WmNlQnhycVNtR1JsbHV1N3hZMjA0bUIvWkdSQTFN?=
 =?utf-8?B?cHpYajVTNURIUHlncTByTzkwYlA3am9EcFNPZmM5U0UwUFRITHVGV05JKzdV?=
 =?utf-8?B?WHVmYTBvR08vK0RXMkJRbnNTZy8rRmFCWTB3enpzODRTZVpRQ2RVZFFxVml4?=
 =?utf-8?B?TVdOVXhCNERuODAvZjRxNzlZa3hQRFVKM09JMXBteUUzODByczA5Wi9YMk1M?=
 =?utf-8?B?UUY5YkhEd3hZbU90MTE1Y1NuMG1Dbm5iQ2tkR3FRV3BzbWdOL3JPNWRReE1l?=
 =?utf-8?B?WUxnQUYwd3FSeUlDU1NQdzBSa01GaW4xOVN4bUI0SExGaEEzMDlURk9KcWR6?=
 =?utf-8?B?cXFYQWF0bHlBdmRwNS8zd29OK2t6azZQTUdYMVRhNUI4c0trbDE5VG16RUV0?=
 =?utf-8?B?bjNscFBydnBmS1BlYmdRcVZrMEx5ZHE0TlZDWmpZVzZQUmxRMzVFVmVTeklS?=
 =?utf-8?B?Nm1veFR6UmwxU1YvUHpjcGN3Sk5Dc1NyQXZGMnNldnM5c3JZZ2RiN1NxazVz?=
 =?utf-8?B?aVRFUXFCcWVXV21pSyszMDh0U3pQV3haT2ozZ0w4bzlEOU92Y2JSYTJ4MmI5?=
 =?utf-8?B?Y20wSnZ3dWFpK0VXMHNIaHU4L1dHYkZIWjA5UHFOOUg5YzU2UDJUZ2JFSXEz?=
 =?utf-8?B?Mm1lNnh5UUtiV2lRODZoK0lDYkNuZi9uMDh4WkhVS3BTcVpiM0c1WFRtK3gx?=
 =?utf-8?B?bWpxS3NOTGFBcnBiQXk5OU94Nk45SXNsWXpnaGNTN3FsMFNXZmY0Tk1lTGJz?=
 =?utf-8?B?dEROd0ZnRlJtZm9RV3pyMldHNVhQRXZBTEZId3pwRTF0T0xsQTJXN0M4ZTcy?=
 =?utf-8?B?eG8vei9MWll6b3FpS0NmTmgvM2hERGR2Y1M3NnlwSHAyOGlaQzh0YnQ0VVoz?=
 =?utf-8?B?U3pCWTBKWEl0dzYweDZteEhwSkRxai9GbzhYYzNXano5dTdScHBHVVhpdGor?=
 =?utf-8?B?T0d1SUN5Z0tWUmwxUGJLUk5RaDZXNzducFFOU1F3OUk2ZVJGNTV0MDFlcHpw?=
 =?utf-8?B?aWtxWGRpOS9VREh3OVNZREt5ZFIyN1RIaWxNM0tkN3UyL3lLZ0cvWXQzemJE?=
 =?utf-8?B?MHZSUGsrSHNiSlVVaW9XZGliRm5MNHJ2eDgwNVlRWU91eHFtakN2N0tNU0N2?=
 =?utf-8?B?cWMvZUdGNzRUVi9tY201UWZQTW9SMUg0UTkycE5xQVNRY2VDbGQ4eUdrbC9v?=
 =?utf-8?B?bmw1d2tHbWl5Nkc4ZmxnZ1phOVlUekRrSTViM2I3VUhydGFHbVdFZzlydXI1?=
 =?utf-8?B?bWVXakZiZ1FlZytiaFhPd05OYnRQdHlvZWpycklXa1Nub1EvK1JmeThsN0pQ?=
 =?utf-8?B?MmN5aXIveWVBMXd4YXVYbzNUdUtaMmhPa09kdnJlTFJoamVETDF6OEFZa2ZN?=
 =?utf-8?B?eGlBV2d5dGkySE5ETEVPME1rVUtsbUs0YitSV2RKLzFreEE4dktLWlZ3aDZJ?=
 =?utf-8?Q?+LZl6W?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:27:37.1666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fb962e-8975-4d92-d6f4-08dd8c910114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069

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
index ec706e9352e1..9a92121cb4cb 100644
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
+	return num_tcs < IEEE_8021QAZ_MAX_TCS ? num_tcs : IEEE_8021QAZ_MAX_TCS;
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
+	for (i = num_tcs; i < IEEE_8021QAZ_MAX_TCS; i++) {
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
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
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


