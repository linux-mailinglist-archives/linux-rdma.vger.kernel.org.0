Return-Path: <linux-rdma+bounces-6207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E832D9E2D17
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 21:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87D4282A18
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170821D7E21;
	Tue,  3 Dec 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZG5O6mS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7952F9E;
	Tue,  3 Dec 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257813; cv=fail; b=rbqrAebcO2jyd9R6uZCUEhzmq323BUoeYlYqsW7cc4+Mp/DCal2f9jb2VgnP/4EbAf6bvKG84XF3WA/LfhIAjNZgNGwRGjaFXZPG/1td6IOzoO7tXY+tneaEfkQGb0RoThl2h6K/0HyC3xpu1/PozlsAA48+zRHab7Co0csroIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257813; c=relaxed/simple;
	bh=nj5hPiUVW1h60vL8TTN9I5S6xOlSR1xCmxl05FvTueY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AaSdX3bwNwKK/j5kccQUVlfPSl0KLzcH8r/jIK4yktAyWY8BjVknYf/fGLREWWKhD4hQPb/g678T9THhBbCibUF4gcvZC4TGHxQ775pKNH/jZlK7yyGljOz45S4adC19km+HgoFw/Bk9fb1Wn+/W3lkOtLWv+99A2hnZLlThSuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZG5O6mS; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYWuRvB9HJ3Htx/vlQ9oRCml3YcDygpn3sP/e0mTxHZBqKCQqxEjzkR2iuYoVUrGBsUqn0qggMcnAwRE5FBaINIg9XW9fhf48OFYqxYpV4Sq48ZXzXpo8axHQbe+UEkQhc+JpJNTiEyLOS4Mv7AOeFPjcuAVUeQXYyq+1BZn40zUTNcYWBW25o/i6L5Av+xOVhAYW2eJRxW4QSLrTFfKflsva9fU8cDnuJ00rSWWASzYG08aIoi+JVAS6z2EaJY8OmbIe6HhGXzyUbuGZa55UqHJE1rvfsc7ObA5+LBr3iygFcW9CjQgzYxNcqDIXuTW4e4N7G8HfDmKTlKy6riV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm52LBuFPQ2qaArVCeAvnilOWXCSXRn69fX/jFD1gIo=;
 b=FRHuDocJvYMhckZ5xiyhLSgMB2IM0FHQvcix1mQyzqcZyRoNBSEuq2GJYbHr6rbIrdVF4nTUCK2VmMadURKATFofJqAcwf2KAyIQHTOBLDzvGB9gtosTCC2rQxUIdyDI92ev1LSSjR9TvMPyHLQhhYuG+abejzE/b5uFHMEmZNcIQnF8QqJz2vxdqd2ECzOJgiRZk5Arp/7pAPMnhQN70Y98aAgbBJ0KxbeDzFTeMyIGfi82IdpAMXWaRsRvWWVjcrZkaCdgRUCnDh7GlVbGWjHihP/xFxbbhAGOhSzU3Y4LSJG08w7v8dsDFUFJdevIJkAiqYCda2/0Rytqp5DHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm52LBuFPQ2qaArVCeAvnilOWXCSXRn69fX/jFD1gIo=;
 b=jZG5O6mSPxvQH3Eb+qvC/WPuylBMYR1hKfLPP5r9CXht13zioynx4cxNaq2mR+fDU+soZm4xzDxm0+wfoGFLzH6zuPWwG15CHP4rzr/0lblr9W4mgVfEAHu4p0k0cUx40+PZOtAIvQKsKhe6LcIyEoVDCJcgvdR6FMT2NWulTkoxYuALMDZJBtHdkHYeR6sGUje48f2+6QaDtXRXZcy096mRE+pXZ2G9Ja8ythOaFYjpQcTZjXq9m2RgbfdmC5tCSSAJmnpC8MgRy8ryXUR8c8jYG+9Rap/ZKzHS5mgPkxApiMyOxjkY51QB7iSX/CRZ2YKsAzJAnh2OVlYEmDRlgw==
Received: from DM5PR08CA0028.namprd08.prod.outlook.com (2603:10b6:4:60::17) by
 BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 20:30:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::ce) by DM5PR08CA0028.outlook.office365.com
 (2603:10b6:4:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Tue,
 3 Dec 2024 20:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:29:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:29:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:29:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V4 00/11] net/mlx5: ConnectX-8 SW Steering + Rate management on traffic classes
Date: Tue, 3 Dec 2024 22:29:13 +0200
Message-ID: <20241203202924.228440-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fe0818-4146-48fc-2b80-08dd13d9468d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzRpSm5HSGtYN1l6cHg5Y2RDYm41bEpaVHhZampTaVpJTkYrWVlUdEZDa245?=
 =?utf-8?B?VitBUDN6SlBKTldBajYzUjEwU0xFQkhtell6MTBCVjFpdGxWcVVpV1ZZcnNP?=
 =?utf-8?B?Q2VBR3p0bXpheGRCTHBveDVic0NUbm5RSm90ZWJWcGp0aEEzdjJnU1htbk9J?=
 =?utf-8?B?TTBhNE9LUVUrb2xQWXp5WFl4dGRKV2ZhaGNUT3FpUC8yaktLQmdlMjFNcjdk?=
 =?utf-8?B?Rm40SUZsa0ZoTndMQ3VkbnVPZzJaZEVBMjlVZk5jNVNGbkowMXp2YTRvMTZB?=
 =?utf-8?B?ZlR0K1JzRkxRN3g4cE5zTTFmSFNjeXllRGhXNnpqeXNzckNqdlhnYWZPZ3VY?=
 =?utf-8?B?QnBNSThJZW5LSzJpMkpPZkRJSmI5b0UwcjNsRmhNWnYyQUgweS9jNXZkYzJK?=
 =?utf-8?B?ZWpjSHE1TmNBY0xQOCtKSEpJWGdSczZsWkkyWWxOcCtPWVN6b2had25yTUJ1?=
 =?utf-8?B?ZEVhMmVOK0xjZHVFenF0Yi9aZDdicC84aEU4TGxsbWx1dlFqY01FTEdWWVdw?=
 =?utf-8?B?REFKM3ErTGFVQkJoamdvSHJBaDBOMURaSG1ibDB1ZDlJa1hDWmNOQS9Ma3ZL?=
 =?utf-8?B?NitRVDhjelMwQ2RyS0VqZWNsS0lsczUzaUQyTFZETk1VMFdBYlFuSmpiOUlZ?=
 =?utf-8?B?VTRaa0dHb2lrcmFTRkp2MGFhNlM4blQwZWVBWEhRRmNMNkRmU3FRaENuZktC?=
 =?utf-8?B?L2JnYzd3UTlzZ1Jhc2VWbzdOSmgvUmdzdFU3ODFxWWMzMTZEWDBMcEpwY3pH?=
 =?utf-8?B?Z0NsUjl0MGRTaWRWL2laUzBxc1dBWEttakdlUElUZ3NlcklodXV4ZGVQZnJo?=
 =?utf-8?B?SXQvekJLRTVJRkhPZWRUQkpkeWtSd3RhcXJVY1I4aGpaYlhXYklMVjF5R0dQ?=
 =?utf-8?B?Yng5QVQrNEFRenBVd3dqRlV1QnVhd1lTaEZhWUNSRStaekRSRmIrMEJkYUFR?=
 =?utf-8?B?b0ZuVURaZ1RqSnEwdktFa0lBU0tDWFM4Y2ZDNDhGeXJzaXJMcXJ5N0JvMjBm?=
 =?utf-8?B?bzE5OHZYYXdvM0FWWnJuZmgyaWcvblI2N2JUS0F0UDRKQ1hOL053aTh6c2J1?=
 =?utf-8?B?QUwvY0RxVktKcWl3dGtiZXJlRFdVSW9wUkhQYytRL1hxQTRKUjZBRGQ5dndm?=
 =?utf-8?B?TE4vOXBaNWhPQ1FmdjNWakNmbmR1QjBEYVVEdXViUHZsNWlDSXdaNFQwVXMv?=
 =?utf-8?B?ZEpEV2NDT3pQNUFGQlVnU1dyRkhDcXcydkNwejhGOXJ0OHdOSlEyZlBzV2pt?=
 =?utf-8?B?eTNCRWtUQ2pHdTdvWVpCNTVaOUd2QlRMTTY2Qi94aVlpNkFtTk5xOHBiMVZ6?=
 =?utf-8?B?ZU02L3FWYnhFc1dKRy81RFZ5akRNWmdaV0ZvUEQwYXdkaWZZQWRpdnFYckpT?=
 =?utf-8?B?dFBHTVdPUUFKU2d2eTRGNGl5c29BcXpSd1NYTU5WNU8yUG1DQUdkMmNzY0U1?=
 =?utf-8?B?bjloZmR5c0t1Mm96MEFBSE1YcFN1U29OWW8rNUpjOUlrNFpXcGRGVXJRYkJn?=
 =?utf-8?B?Mi9iSFJmMFkydGQ1WjNDUkorZmpzU0sxKzZzeHovWkNYK2orYjVRZ0dZdFVH?=
 =?utf-8?B?VE00SkcwRFdaWkpYNGM5eURyT3h6ZjV5QnVpSkJvVXRWVUxlbFNKQ05LeGJT?=
 =?utf-8?B?K0NVTEwra2VPUHVJdmlPTnFUSEJwVWdNb1VQSTJTeHJwQ2cvVUkzRDVkK2I4?=
 =?utf-8?B?K2ZrVFRua1lWZE5LcXJGQkVBeERQL3FHNEUrbVo1YXhWZy9HOEEzdHR4YUVs?=
 =?utf-8?B?bnZiK0xPUk5jcW1nWmhKRVJLdkV3OGVWYXFua0tWOHRvRk12TEdTZUxjNmx4?=
 =?utf-8?B?d0FBNWVsYzh0R0lqMzBBdFZ1Zy9zQ1dlWG9USldXYkkxb2FoRTVCcFZOZHJI?=
 =?utf-8?B?UU9pNDV0bkJPSS9aZWdPV0hqb3NXeGNJL2tjYXVkZ25oVW4wK1BkNWEwRzF0?=
 =?utf-8?Q?RpRRqUD+X4mmrsBfxyiBz3h8TmiB4Nqp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:06.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fe0818-4146-48fc-2b80-08dd13d9468d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307

Hi,

This patchset starts with 3 patches that modify the IFC, targeted to
mlx5-next in order to be taken to rdma-next branch side sooner than in
the next merge window.

This patchset consists of two features:
1. In patches 4-5, Itamar adds SW Steering support for ConnectX-8.
2. Followed by patches by Carolina that add rate management support on
traffic classes in devlink and mlx5, more details below [1].

Series generated against:
commit e8e7be7d212d ("mctp i2c: drop check because i2c_unregister_device() is NULL safe")

Regards,
Tariq

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

Carolina Jubran (6):
  net/mlx5: Add support for new scheduling elements
  devlink: Extend devlink rate API with traffic classes bandwidth
    management
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw

Cosmin Ratiu (2):
  net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
  net/mlx5: qos: Add ifc support for cross-esw scheduling

Itamar Gozlan (2):
  net/mlx5: DR, Expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, Add support for ConnectX-8 steering

Yevgeny Kliteynik (1):
  net/mlx5: Add ConnectX-8 device to ifc

 Documentation/netlink/specs/devlink.yaml      |  28 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 795 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c  |   4 +
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
 include/linux/mlx5/mlx5_ifc.h                 |  56 +-
 include/net/devlink.h                         |   7 +
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/netlink_gen.c                     |  15 +-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            | 124 +++
 24 files changed, 1645 insertions(+), 396 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


