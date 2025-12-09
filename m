Return-Path: <linux-rdma+bounces-14937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842ACAFFB9
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 13:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36F6B300D65B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A2328628;
	Tue,  9 Dec 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXzZKBba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F621DDC37;
	Tue,  9 Dec 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285008; cv=fail; b=WY1ra2IZv5mnjvyehn+AwZKJruiMQYHwP9RnO7aTAuOMU55gXpJ95ucYGkuZHMEAx5tY0+kbf+GeYNwrEiDkcDJ4thbkbUYqAcmvH+j04fLfSgb3BH5esHPTAOPsXrCvhdUsW1P4NwwRFmNJqZoIwoWBAkdkBNFDvnGfAcHC/Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285008; c=relaxed/simple;
	bh=n7QgLDAloR6aGyo/2YoUex6SsXMFI7LDLpxT0gTh+L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTG/UgySriOXy0I4B03gD8YnrBg+qUHnV/UIHxKpfh/fw/iTS/uJ3ItyrFsUA5b8IleI0rP34cmVYnaAcHYIbB88bZfaL3ybSn3h4s82PCHod6KEVQBSJE/mg4aFAEDeY+LDl8fVZ+WjElqTx1ZUpO8eVmn/2n+Ys47IKqYFnF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXzZKBba; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDjB3Qmw1rOW2htQahVDA6PadixXppyJ9nP2Bo7SpqtoSgn8odBwLtEPBdoV3/fkQBLbNtvy0Fd7/cHO/nGmptmPFhKnZgJKDL9LNOmxfQp1TmvKouf8rRwZRk57U4b3W7czXow2OPiogwwn/iSWyhBT4j2PSrZ9Ky8nUzjIlhmM3ftwlF/ULnk+u/DsRcssEk7v5O5NXzxrQLH5zQCcTjDV7/+owMbFFPyKxozrSPOStOq/waijtXv06uKiAHYhJNKC0UfVXq9o0nxTUvPgJnl9Su8jbvPUV9SVEK/+L2X5bGldDZDoqoBorkrkYDcAuGDX00OHt3LqjsrFrgnq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htccfu4ZumdSLhI/YDJDu1QzegaLJWwyaNyPM2OSaOY=;
 b=edfjWR+QeEjikcNjZQdSXUu5YE2I4OMZMZPw+E8EUKH2I4ij7iIJZe2ltL3TfO/W1MFnNopuWRurpY1OqPMzB8G8gH8fgK4mTDnBuLo1uRBQ1oJG9zetWYL9Qni4+j01PoJ48q6jDtWozbW6uc20os3xPQSacVAeWlGe1IC2OSJAMT5L1aOvCuMUcDQY7Il3vMdfEGUT8CDUhCbuyKFzHjSFj5ydZkUufcB/0khmQSvI3rVnzarexwLya1qLV+L0bIrr5OQo/umQ6CUgG61/E2S/AIHd+OqnypnyCNtaUi4Pc/ZBQmCIJ3ztfGVe/Dpx1VqmhcAWKSvlnTA2J/Hbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htccfu4ZumdSLhI/YDJDu1QzegaLJWwyaNyPM2OSaOY=;
 b=XXzZKBbagSRvOsr7DArz9NasD8oC8Bml0pIhm0ODpLwk5WzATBNoRsqR2WJBVoLj1XsEyKdoSsHlFln62FDZRoPGWh3Eb73PZwlGEydIyNgDZvHq8rlG5VLGyO6UV9Kvb2hFg4UPY34BzZExX3WglSh7onDdZ0QfAq6GnEjIKKs5jHnB38cCoyIGpy6gk8gtOaP1FwkAWgfPUdCVNdxt+Xv21kaW+8tNqJRzcZIo5qtDWwtlgCdia5JqEH5Bz+X0gLls26amXZHt4EtaT9RzWxkyI9BO511SUe+URx06uiTOnu/OijgMaSXrUzZAPL6pkYo6+lpGcjCzZPJfr72p5Q==
Received: from MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:56:43 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::67) by MN2PR07CA0019.outlook.office365.com
 (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 12:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:56:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:56:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:56:34 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:30 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>
Subject: [PATCH net 0/9] mlx5 misc fixes 2025-12-09
Date: Tue, 9 Dec 2025 14:56:08 +0200
Message-ID: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: f836a0ed-ce10-4b7a-0068-08de37226724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fv5WKlOzrnjMCeX6HgIFDZW/65Uo6Lv0+nT3yOOJekt9zfZhOgEEVix58rNt?=
 =?us-ascii?Q?WQMFwbtbRsYFWuB3+uW03gIqm/Et7zihWJa1cHBGAUPGwa+TEqxU6VM7HitC?=
 =?us-ascii?Q?kpmWym7xK3R7Uz4MtGPWzYqW+3zZCjobHf9RIqmOyEmmkaq3JYYq0RXrEiGS?=
 =?us-ascii?Q?epFJLj7LeSxQy8ttU+4ptmASa7rPAP9ovO+/MO2yxFarVeFzwGwHSreHra6l?=
 =?us-ascii?Q?jKMvXlq1BaePa/3iNHFIZ95w1GeWg7c2womLCok2j1pX56FGeHaoIPl22yvY?=
 =?us-ascii?Q?JEyfa0oLdu5XWGbxvCqHoYRl/KaFxKdO+ljLk1K5FcrSBL1/fVSv207MjzFf?=
 =?us-ascii?Q?dQ4c4VxBmsEG7W58Qop82dzq07+lbw14S64WlOJmKBn9PYXC4OMEAWs+9HZv?=
 =?us-ascii?Q?dnUkW1nIeLovTrIFV/tYAWLPv8tN4mexaG5jbsUGkief0mHcfjF/it+tEcNl?=
 =?us-ascii?Q?Z2spK+hF3PH7vmIC6C2vNxO3EjTeB1UYB+o1jFqkLjSwV/KwmRl85+4eC5OZ?=
 =?us-ascii?Q?p2q4lhh6+Z6u17pafp+X2TzKjwy5QRdBD+gqFQWlWooYLZaU4Qv7//be5/BX?=
 =?us-ascii?Q?4vG2a0oviRkdxc4WdON8OcoEE2Mcrvl6Ltju6LooCSqYjpVf+X0zyQGxgTr/?=
 =?us-ascii?Q?eVPSpXLgtMmJOvx73iwcDiChLNdTYQKpqpapDpCIEx36exzl+rS7Fcz4L+Dx?=
 =?us-ascii?Q?KWyzPrVcdXMKKBKpZTwRqWyWS0KBkhHG4KeasFMmZEDp7L4eSTYKMwQAxpZD?=
 =?us-ascii?Q?uAEKeDgRuP46LG0ubJC2oLNWIU8ZkxZ7MjbCxvuUN622cTH/3QenRj87Mrbd?=
 =?us-ascii?Q?nZPdF2Ptry/Uot+DGGkXbQ2D32sdXVgqdTzEsbuD/1SNQcUaKHfg3OnMN+/e?=
 =?us-ascii?Q?i3JsalHO4vy3h1DG3/1YPNMY2FouO6YQTXRA4Va2BGak47Hm57YxKOqUBEoB?=
 =?us-ascii?Q?JziJLHvxsjn1ApZfPc0DNYMDCKQ7sj9VGUoB59zuB/0CiszCb87b0thm87Qx?=
 =?us-ascii?Q?ThHaGJ7FPANHnulafndTKY8NS0uzSy1BBy8IgAY8fb4EDBdRjHwhzp4hRKNs?=
 =?us-ascii?Q?Pm/fhK+7yfT/ThP1mGNz2fwxmBbL2PKyzFf1epaP/RsmHj98xiRmenbRleK0?=
 =?us-ascii?Q?ao2hICU1I9J/79u15XBk7TQnixk/EJMnt0F+53zr3iZymuRajIAR8DJzQhj6?=
 =?us-ascii?Q?cYXQo0nkO9pJGeHnlKJx8vuDwW2V8ZArcUe9FvqW/4b9AuGbYYtggGLzf9NL?=
 =?us-ascii?Q?Yqz3V9j6VeOhYHfZDL8WhwTqB8SoepdDcORHwps+Xy7/QwBiX9dNjCjTEFD7?=
 =?us-ascii?Q?6dm2oeb1pNpCmsF2TUTiN3YThYCE5LwnCGNgU3pzZOKi3jeYNWpezGSM+hZ+?=
 =?us-ascii?Q?ceff4W3VoLrFGZJiQ8L+0GnzX+4qTTqoCZF4VRaPBRMbLXq88JUlV8jzEnm5?=
 =?us-ascii?Q?79SPFMzaGeh9ll4/ML9GbRq4+jtRmILAgfLEKhgLwB30nreUPpKqK8+W+R1b?=
 =?us-ascii?Q?CU0Qz4q2MTuHPCYgBupV7MntNlWQp7Rsc1OMIivtsme59w7xfC6Kp4A+Jec5?=
 =?us-ascii?Q?HmDIRObojF5+xcALIRfwYp+9ZmFXyitYZqrxCMa2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:56:43.0365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f836a0ed-ce10-4b7a-0068-08de37226724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.

Cosmin Ratiu (1):
  net/mlx5e: Don't include PSP in the hard MTU calculations

Jianbo Liu (2):
  net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC
    init
  net/mlx5e: Trigger neighbor resolution for unresolved destinations

Moshe Shemesh (2):
  net/mlx5: fw reset, clear reset requested on drain_fw_reset
  net/mlx5: Drain firmware reset in shutdown callback

Shay Drory (3):
  net/mlx5: fw_tracer, Validate format string parameters
  net/mlx5: fw_tracer, Handle escaped percent properly
  net/mlx5: Serialize firmware reset with devlink

Tariq Toukan (1):
  net/mlx5e: Do not update BQL of old txqs during channel
    reconfiguration

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  5 +
 .../mellanox/mlx5/core/diag/fw_tracer.c       | 97 ++++++++++++++++---
 .../mellanox/mlx5/core/diag/fw_tracer.h       |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  8 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  6 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  6 ++
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 48 ++++++++-
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |  1 +
 10 files changed, 152 insertions(+), 23 deletions(-)


base-commit: 0373d5c387f24de749cc22e694a14b3a7c7eb515
-- 
2.31.1


