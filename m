Return-Path: <linux-rdma+bounces-6243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF39E4789
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FB0165D77
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC57197A9F;
	Wed,  4 Dec 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MhxL9QzW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB192191F7E;
	Wed,  4 Dec 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350299; cv=fail; b=FAvGkCbjX/BfCgLqVfezMeZBmFvs2A1D7hvj7q/J8Pdko0JBsdpEoo6D3ziYa9vBV/Q7/C1yilcF0gFdUawuxwJuKWEhDD243veJQHgMQH4erfSTxANeNi2zSD0Pw4cmOOoStKizL/5X5cuXQJG4Z+L84/m40GtUKWsPHH5h734=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350299; c=relaxed/simple;
	bh=0ABi4XmSjb6JrpRZYSpic5rb6lt8sdHprZx9hxjKXlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UGQ0LpEUgs//5g5ykeA5uUxT9+w19XOBxsFzV52Fif6UyhwXHAyVonoSHeo51NMapXrf2npAKziON+1mZ5RQZZ1eKkK8vZZmzs4JQ6F1pI21HLlcdHFRLnHJMkyVIpKGb8zdN5tJJuazcq6A6JofFr4vw23Vgf79G8CwjhPxZvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MhxL9QzW; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tty8JG98z7ATTByzqNuSzxCfzfI+W3HKPuCUgk6qAbHJ+o6W9XgikYlvsL5OnVdYwjqgQW5d1nn68BirxzDPX8RiwJ1ZrsLxSRexw4JDj8+DU8mcXSjazIDJD2U44TL3gEAMyZwS22phJkISiMk03KnNcs5/ijTf5LAsxy0WL7lhxbmQq5gwWMueVEBWUs13jmzYe03pl1QS8euSSL1vswFZ+Wj0sezrzswf4c2v3dMTRknpQC2bl1ncBfavgQo5Mvyt8Fzf2bufkJCzSG7cWNoJ3PwJawsUNjJDxeEQ4UKXWqUjT2KoXUrL/+FQiSuT4XiY3vJKqg5YQCgcLV8U7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf2bK0EUzDsFo/Sq2rDby/2xFep+5XxlwhFXrb+62+s=;
 b=MEE1POEoeErcBklb9uoPquVcvli5gB0bPa8fCdiAq4JWav/b++UOePbbsl+e4VJo8jTCEJGH7T3oNDovHLSS6h+opzdO//nMk4qqn7v4VjdyiXeWS3aLnHqR6lq/usTPQa2fJ15zaHpu9ItWxQk+WSNLncjqTdasMbTzzoOEohufwzqRFeBRhUQi0IbxAWtA6J9IzuOvzvOKi48EcOlOx2kPzmaZU6dFwHI29FuGsirZlHLdubr+7ytDapLHXQpNpM4dMhdpyhGmnlLdjZMMFpY/PqduABm2LWL2mdy9rwQfP/6qHTqbl8rttjbLJEMJuiJckOcehyoW2iQZyNImlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf2bK0EUzDsFo/Sq2rDby/2xFep+5XxlwhFXrb+62+s=;
 b=MhxL9QzWD1w1Of3v6RA7trZgMqwssgzaQIhQVGp0eQUkpjMI5X5yxwYHhX7yp4UilUuHmleybCPEwJItcEsTmbhqiq2ziFqPxP/pnQEezQC0fFhSID7/kdn3m2EiyV8U9w5BdvgJexg5io7A3Z6wCPCjmBQOkCL1NvPruwXsgo0tap7ftv/0G6KA0cEIUPOaMxybJXYxgik31HR40hxX9t6apyU7FIrAndq5IyIJ6vdnIVbuPK4HliKRjcEFvGt1l/hibPyr1ZZFy0Fm3KDDfK19cH6VN/JIu9Gn5UBV5+6KCiisFRzuUZllk8KOtQjlos2wxgKfjEGOugke2Z/c4Q==
Received: from BN9PR03CA0488.namprd03.prod.outlook.com (2603:10b6:408:130::13)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Wed, 4 Dec
 2024 22:11:33 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::df) by BN9PR03CA0488.outlook.office365.com
 (2603:10b6:408:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 22:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering + Rate management on traffic classes
Date: Thu, 5 Dec 2024 00:09:20 +0200
Message-ID: <20241204220931.254964-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 872d997e-367a-483d-d0cd-08dd14b09c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZnenRCdXJSbDZ5S3F1N09NTlk2NkhNRWhJMktvL090UXhqUTVlcGVTUENx?=
 =?utf-8?B?dXhyRUUvcE1wYXhzMVY2dnRQei8vZGxTZDkwS0JiWW9ycDRwWVVMNW9WVkVY?=
 =?utf-8?B?YUo0TTNETUdET0dhUDVXcDl3d0ltMjhVUmNhbG1McnVEZ1kwUXZsNHN4TTho?=
 =?utf-8?B?UWN2NlRZQVhWZCt2UGlxVy9FYlVRa21ZcDY2MWw4TTJkVG9yRHdOa0NZV1ZP?=
 =?utf-8?B?bXdiOGVZUDVNT0h1RGdmUHJHYjhRSUR4c05VYWs0TTZxcE9remZ1ZlVUMkJw?=
 =?utf-8?B?czJFSVdZaklJaWRjbUhtVDZ3VzBDQm5Ceitvdm9IY3VBK1JrQllWSTNtNGNX?=
 =?utf-8?B?UGZHc0VselV4VkJQRmh5TldwS3NEazJjank1WUg2SlpHSlJRVmVSZHZnSDcr?=
 =?utf-8?B?WDJtbSs3dlp5b0kxTlorK2hGWmtVK3FpSEhxYkJaREhBcGx6STRsMWRNNnpI?=
 =?utf-8?B?eHl5dTJ3TWNNc000YkU3QU14Ung1eENUelJjNUNGWTVFMkY5L1JNelRaYmdE?=
 =?utf-8?B?cXFCbVJwNWhmbzkxcDFLNmF5OXBOelhqTXhZRndlMlhCMjJpUURnWGQ3K2xQ?=
 =?utf-8?B?Mmt5ZGJVdGxNY0J1M3gxT1RXcXVFRndsNndIKzRTcFI5WHFOaWk1dEF0RFdM?=
 =?utf-8?B?b2RhdG1YcVhmaCtNMm9Bako4MTJMTnNsS2JvTi9XWTVGUGdQS2dmVm5sZjdN?=
 =?utf-8?B?RnlabE1PZE5Gc0ZhYXhNSFJoSWt0eENiZ0ZudS9GYXBnSDV6eEpOTXV2VHlx?=
 =?utf-8?B?Z0cwTUZlMVlFZHA2TUZpWGhaUWd1cHRDTG13ZEh5Ty9SUE5tTHltT2orRzZh?=
 =?utf-8?B?MGMvZFBUTlN1YUdaZW9tL3Zkc3dzckpCSkVDMHRaakh3aURHM1NoSzQ5VFAy?=
 =?utf-8?B?a0drMzR1NjFlUWl3VDluaVRmOWViTk9JZ2pYWFhMZ2JralVHYmFLVnh6Nisz?=
 =?utf-8?B?L0RhK0p2bmpLWVZmdHNlVGFOeWRmL3A1SXVrNkJxUDRFeHM3azE2TFBtMmd3?=
 =?utf-8?B?d1NmaHZhdGZKSjNKeDl5dk5qbGwrR1JVWEJmZlpSWDBBaHVNUU9HaGgwTzBl?=
 =?utf-8?B?aTdjS1Fma2I4OEMvQVB2UEpnbmVFTUI5SnJzVG5oTnBjU2pJcC8rL1cyUzQ1?=
 =?utf-8?B?UW9ESitwalFOaHhDc3luTkFwUUYxbk0rejllQ083ZzJGNTgvS1BEVWdZZDcz?=
 =?utf-8?B?NnphdURJZjREaFZJU0MwOUNyMUpnczVMZmZBOGF6VFo5QXV2TGJQcWdaZFNj?=
 =?utf-8?B?SzNWUW9UWStIbHRxcHloUkpySW83eVN0R1V2SDVtNEpQTkpPTGFHdWtoa3Q2?=
 =?utf-8?B?UU14VjJyaklXa1IzaXNDU28vNHZMZytrQjBpWDUrOXlPSDB4UjRpUmVIQVRZ?=
 =?utf-8?B?TjZ3MFZybHNHK055SlFnVmNJb2VTK0ROK3J5bG90WWQzSFdNdVVwWHBjU0x2?=
 =?utf-8?B?dFVDZnAyeEhraFR0NTZZc0NXWDBJaFgzZ1BFajdlTVFtdXdyc1Jxb2VDV3cw?=
 =?utf-8?B?alJTbzlhbkZEd3MrNklieTdWQUU2YlNQaE51TGd6NzNONWpJVEZzdFd6bDMr?=
 =?utf-8?B?UCs4QUhyLytRNXJXRlJSWDlNUmtaZnNNRUVZQit2Zi82QnhpdlJKK3FsaXhS?=
 =?utf-8?B?N0VTbjF0ODZTMGVKd1h2WnBWK0FvcnVPeEFjWVZDSVVvWks1VFZCQVgrL3Mz?=
 =?utf-8?B?c3pPbTQvQ1FmdncrbmVUc2FYa1h4WXlHRlFHd2U4SmVHVHhwZlR5VkZPbjBS?=
 =?utf-8?B?V1diZzZnamV1bWUydTNVS3paN3ZEc3dXTmR2MUNUNElWbGVDeVBHSzBJaUZo?=
 =?utf-8?B?VElBeDU5T1FMWFdpd3pYYmM3ZkNGUlQvcG5LNURWc21GbUVmd0dpVitvYzFm?=
 =?utf-8?B?S3Y5Qkd1WDlSaGY5UEUxVEMxSnBiRXZKT1BPdXZGK1U1cDlsR1pxbDR3enlN?=
 =?utf-8?Q?8n1hv+/IPgLJZcZkvIZltO4LaU8uErk7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:32.2936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872d997e-367a-483d-d0cd-08dd14b09c43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787

Hi,

This patchset starts with 4 patches that modify the IFC, targeted to
mlx5-next in order to be taken to rdma-next branch side sooner than in
the next merge window.

This patchset consists of two features:
1. In patches 5-6, Itamar adds SW Steering support for ConnectX-8.
2. Followed by patches by Carolina that add rate management support on
traffic classes in devlink and mlx5, more details below [1].

Series generated against:
commit bb18265c3aba ("r8169: remove support for chip version 11")

Regards,
Tariq

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


