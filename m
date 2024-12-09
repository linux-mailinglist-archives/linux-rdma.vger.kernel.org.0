Return-Path: <linux-rdma+bounces-6352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E89EA0DD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFA1887075
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBFA19ABD4;
	Mon,  9 Dec 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nsk8Cynr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7417836B;
	Mon,  9 Dec 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778792; cv=fail; b=RVM9nj/6EVnvau1UsCKPZ5scLQqq+2yBN411+8sHLMaNnMnKBS15+8iCCzW110POi0rO0mczXIe+hgPwUIal9D7X6fQo/MULPdidmaJELEBaXV1ytR1fBngUYtCKD1w2gbrz8ITPl4LSUaWlYA8h5+VyBN3UK9S+1Os/crqPK2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778792; c=relaxed/simple;
	bh=60qC2WjD0uLTlOc1SIjP7M+4ZQ/iIyPP6awT4lW9tz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NTcpUnXcXIGQjOnsdyjb8+gymCfugZ0fZRUV8Q95fs7XF491wDOSZYrs6VVQmc6Drk+B96LA4I3JPgtw6RCoaFDvIp/p8HwPUDhLzS4BEcAGEBPRQ5TRScv0jj5LfJhZFkr1ZRSZj8ax7U4GUaDbWsdOi21CB0JPm/eB/8eQOUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nsk8Cynr; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLfRK0ZImEerKYG2VJeLMg7JwDvE/ddVlcAkAafrkA3zMD25hIp8p7fdhnAkDpYygUUkS0rEDmkrWCXIxgoYO+osK0zDYKjSRAoJ4FVsa5Cf26pWnDnV/hTwolR5BBs3AgUw2yeF33MIy7qcBsk3qia0TYtUjOhLAYnFiyHnyzVkGJHzZdHqLYpwGKoW04K18xq6tuR8jniXYGxsY946wx+SNRFV94X4YviRPVi6EF0PQlViPNEacSvfND1ffBZQqMidXi4gl9nPvcSDatiNREOZ85avZ9vheLXX3pwIBD4bInOIcxxcXsW3xmRSrCs4fQG9I7RLHIOVOVgtDbwz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEGFcvp4SGmS4CbQZdVDHs/3LWlFoofmVzwvaMJfkQ=;
 b=YcdtI+Elswb5kOYw55/nAkhl0mMyZXrMHjFq84uL5LpfyRvfZhDkD2Hk/qxsEjQSrQUfcfC0YRKghHvv1uKzdDBO6JGc67vWov4MYe6RJZ3IJvB/rJAc4uRnMCLtf8DglNA1cHWJxtT35U2ivIPM5yRwO7nOjTbm9qyasfvNEmDLIjYI5poOLM1wal6ZBuIfDM+qnigFbbssGG1gOs1a61couCjxqq3yGCK2nZE1t2FZMcap1fkRvX7wsKzntW5SEzSZZ3vbTNQ93Gg989Y5S/t7AG9EUk7M05PwOjNlgRLXo6OTr+6IrvQxcw3Y5DzxpkpHwrIATKH2Q+NXkj0Sxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJEGFcvp4SGmS4CbQZdVDHs/3LWlFoofmVzwvaMJfkQ=;
 b=nsk8CynrIOj3DIDm3ZRRug/QpKVPLt+xQpyDaoHLt3Q20Qesz5taWyOBF1Xwin1S3XZAZEb+eXKzNJ/0/5XbvU7XW54JUmqWIgYubsPo5whj/EBVLhwTCcXe3OTJQUUSpZTSKlYWOceyOp83ukvhVrzjbiuDe33Zh2OhrN223d4+rFn8Xvjne1zI9ZIY7HUHxFsd+bY/5FL+VaOwt/ulfbGQfqaNMQvrzTHmKRJhLvqayOmufgk6kLsASRLJTd+EyqkezE2sUHUyUG528+Fax7WsK6LEc7Y2BHCz0waBB7Ie1aH6Soy/rK6eFESqGNxKXwbJ5GzcvHoTOQxXjcXbBA==
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:13:05 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::7f) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 9 Dec 2024 21:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 21:13:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 13:12:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 13:12:52 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 13:12:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V6 0/7] net/mlx5: ConnectX-8 SW Steering + Rate management on traffic classes
Date: Mon, 9 Dec 2024 23:09:43 +0200
Message-ID: <20241209210950.290129-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8e8406-3271-4f24-824a-08dd18964540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S04rZGttUUdUaFYzOG5xL1YxMUNTN2kydUsrZ2o2dGg5NG5uOGRjVXM1ZTNt?=
 =?utf-8?B?QzJISkc0TVhzQUh3QU9YMkdvUlBsc1RYZEFtTWRrOVQyZWVQK1ZCbFhiTFh1?=
 =?utf-8?B?R1pNNU5yQVRRd3dUQU44Qkd4MWZ1MDlQei85MTVDRTdNZ3NMMmpPdzRxc2di?=
 =?utf-8?B?RzV1WnRHdzJ1a21lZmtFbFhJN2U0MTlsUXdadXB6cExBUk9SdXR5S3VQS0ZK?=
 =?utf-8?B?QmtaRkpJNmNvd1psaFNwMGxnd3ZFVEsxMk9BVHk2L1VHRlNyb2NBaUwyMnZD?=
 =?utf-8?B?LzJPZTEyWFlwVjFVcHNEVXVzNy9aWXFURmFqb09hUlZBYUtROUg0T25HV1pz?=
 =?utf-8?B?cHZ6NGdJam1DbVFXMERRdzIvMmdtcHk4UW1OZ0tpTXJkY3VqTHkycGNITGRU?=
 =?utf-8?B?bU9ZSERnbjZ3MmlaRFM3OGdwYmk5N1BvaDEzWUFZTlNpT1dRdDlHYWNRWm4w?=
 =?utf-8?B?Z0NhVGxPYldPcEJwbC8xOGU5TnFrRUFTN2hVTDl4WTF0Z0kzODk4bGkyWlpp?=
 =?utf-8?B?UmVsQXQ0dzNUTHpsTEU0SHJRd3k0VWhNUlZYUzZhSWJsOWZxQlY0WDQwRzlP?=
 =?utf-8?B?bE11UGVwOG1zYTRydzFyNGRLK2Jxczg5VkhjbjBhRVBZdkIvZEdKL0xGcWp4?=
 =?utf-8?B?elg5UXVhUlNoSGVJRWNhYnRyUGo5eTFuSy9KRVRXdG5TV1Rsd2srcmYxQ0dE?=
 =?utf-8?B?dDBqYmhPQlFUTFYxalNJenY1N0ovYmoyS1E0cS9oN1p4WmNiampITjd0Ynpj?=
 =?utf-8?B?TFRoVmZ4WC9iNUk1NyttQXE1QVhIVXk4MktiR2MrcnNERG1OV2ZlakxidzdI?=
 =?utf-8?B?bEd1dkxCS0xWdkQrY0tvZkZYVGFtS0JIZ3E0Z3BWTHhJUVc3SU5OR0xRNWpD?=
 =?utf-8?B?c0JyVUFLekxxdS9sNnZGK2NzY2M5a3RGMXhuZ2RiUDY5K1FhclVWdFBrQ2xP?=
 =?utf-8?B?RFdKRXlqZVhicmhiMzdFUWNTQzFpREJkMTVBRDArd29TdE11ZzhtTzYzRlBa?=
 =?utf-8?B?NXo2ZEZEYjBWbm93d3V6THoyTDI2NDQyL1BtVzBMMVJ2ck9lMDNCc0NHd0gr?=
 =?utf-8?B?K2RhS0FsU3gwa0d2eXBXc05zck9td3dCU213UDZNVTJYZTk2dHBtdmFleVpy?=
 =?utf-8?B?UTJUZ3oyVGZOK1BPTHJxOUI4a2FGS0dJeC9MK3BpMTMrL1lZSkQzamFOU1kr?=
 =?utf-8?B?TW1LZmt4T0dMaElGR2dVaU9LQ28wRm4wZTl5MGVVT3o3SUlNMVdhNFVNVU9D?=
 =?utf-8?B?R1FyOFcrQTJnd2hkTDB0Z2tnWVFXelZsMDJVVjZsakFHelFSbmNpNnRjcU5v?=
 =?utf-8?B?SjRTOERpY3M1WmxZd2E3L1JZK3Q4VUVIcHdmOFF3NmVldUl1cEhscm5UV2ZN?=
 =?utf-8?B?ZWpzNGw0YUZ1NTRQcGdKTjlXMEdmSS9EdzRvQW1VSjI2QlNHbjZ2bVdpQUtZ?=
 =?utf-8?B?akhHQm5QeGZWZ2ZQSTZLR0xsMW9qMmV4M1RtbWtLdUppUWNUN2FBSUtUYVZB?=
 =?utf-8?B?Y2l3TVRIZDlWdWJaTE5PU0VwM3VEUEpOd2hmTHpvQndzWGd5clYrNTVZOWpT?=
 =?utf-8?B?V21ycVQ3bURGV1B0THdVZ081N0hBMnJkamtVWlJkYlRuaUVMOGhnelRWOE9N?=
 =?utf-8?B?aUJOSXFaRzBzY1R2amVVODUwbUIxSFVOcy84UllJbDkyUll6Z0lMVERNbGRX?=
 =?utf-8?B?enhsN01rSEFlcWg4Y2syWGMvNkxHM2RtRHRsaGdIYlhQTVFxd0d4OHl3RWo2?=
 =?utf-8?B?TGR3dW54MGNWSkMzcFhZZGlVYXp3cFIvV0xEMWtPKzlzQlc3Wm5PdHh4bjJi?=
 =?utf-8?B?RWJsbFVQWjFKYXFVZmhJYlMwUmdpdWZhWWJBd0FYekRDdnNhK29RWmsvRVZ6?=
 =?utf-8?B?QmxGZnF1ajZaL25hU0Q2TkpuWlZxVjN3WE1pa0duNVhtMndSd2l6Qk5yRENh?=
 =?utf-8?Q?Dm7T94NO9KjrRvogPdbrdFFdY+W88hs6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:13:04.1557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8e8406-3271-4f24-824a-08dd18964540
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

Hi,

Welcome to V6.
The first 4 IFC patches were applied to mlx5-next, and need to be pulled
before applying this series.
https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

This patchset consists of two features:
1. In patches 1-2, Itamar adds SW Steering support for ConnectX-8.
2. Followed by patches by Carolina that add rate management support on
traffic classes in devlink and mlx5, more details below [1].

Regards,
Tariq

V6:
- Addressed comments on devlink patch #3.
- Removed first 4 IFC patches, to be pulled from mlx5-next.

V5:
- Fix warning in devlink_nl_rate_tc_bw_set().
- Fix target branch of patch #4.

V4:
- Renamed the nested attribute for traffic class bandwidth to
  DEVLINK_ATTR_RATE_TC_BWS.
- Changed the order of the attributes in `devlink.h`.
- Refactored the initialization tc-bw array in
  devlink_nl_rate_tc_bw_set().
- Added extack messages to provide clear feedback on issues with tc-bw
  arguments.
- Updated `rate-tc-bws` to support a multi-attr set, where each
  attribute includes an index and the corresponding bandwidth for that
  traffic class.
- Handled the issue where the user could provide
  DEVLINK_ATTR_RATE_TC_BWS with duplicate indices.
- Provided ynl exmaples in devlink patch commit message.
- Take IFC patches to beginning of the series, targeted for mlx5-next.

V3:
- Dropped rate-tc-index, using tc-bw array index instead.
- Renamed rate-bw to rate-tc-bw.
- Documneted what the rate-tc-bw represents and added a range check for
  validation.
- Intorduced devlink_nl_rate_tc_bw_set() to parse and set the TC
  bandwidth values.
- Updated the user API in the commit message of patch 1/6 to ensure
  bandwidths sum equals 100.
- Fixed missing filling of rate-parent in devlink_nl_rate_fill().

V2:
- Included <linux/dcbnl.h> in devlink.h to resolve missing
  IEEE_8021QAZ_MAX_TCS definition.
- Refactored the rate-tc-bw attribute structure to use a separate
  rate-tc-index.
- Updated patch 2/6 title.


[1]
This patch series extends the devlink-rate API to support traffic class
(TC) bandwidth management, enabling more granular control over traffic
shaping and rate limiting across multiple TCs. The API now allows users
to specify bandwidth proportions for different traffic classes in a
single command. This is particularly useful for managing Enhanced
Transmission Selection (ETS) for groups of Virtual Functions (VFs),
allowing precise bandwidth allocation across traffic classes.

Additionally the series refines the QoS handling in net/mlx5 to support
TC arbitration and bandwidth management on vports and rate nodes.

Extend devlink-rate API to support rate management on TCs:
- devlink: Extend the devlink rate API to support traffic class
  bandwidth management

Introduce a no-op implementation:
- net/mlx5: Add no-op implementation for setting tc-bw on rate objects

Add support for enabling and disabling TC QoS on vports and nodes:
- net/mlx5: Add support for setting tc-bw on nodes
- net/mlx5: Add traffic class scheduling support for vport QoS

Support for setting tc-bw on rate objects:
- net/mlx5: Manage TC arbiter nodes and implement full support for
  tc-bw

Carolina Jubran (5):
  devlink: Extend devlink rate API with traffic classes bandwidth
    management
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw

Itamar Gozlan (2):
  net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, add support for ConnectX-8 steering

 Documentation/netlink/specs/devlink.yaml      |  28 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 795 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   6 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  19 +-
 .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 +----
 .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 +++-
 .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +---
 .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 +++++
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 +
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 include/net/devlink.h                         |   7 +
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/netlink_gen.c                     |  15 +-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            | 125 +++
 22 files changed, 1605 insertions(+), 377 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


