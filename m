Return-Path: <linux-rdma+bounces-4832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F7A972114
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D8228455F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55F17588;
	Mon,  9 Sep 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hht9K8RP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DB17AE0C
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903068; cv=fail; b=i5B36E/VEXPVQN1WM2LQWfQNkyMpozJa9SKf+Fqq46DVj3zU3Mk76mcMNEBCSaMnQ75kPPkwPI/h0jWRaCzYEuZV962ZqGG6bM+jtvC53Yc5v2JQZE0V4soTIb4nHHtg1HjprIHTslvG+SERNoLlY16+r4MxkILt5JA0zsbrSew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903068; c=relaxed/simple;
	bh=q7HXMqkZE7eOtUkHj+BXF11yrBylrCVWFI3k+pGmR3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CMt65W395ODYTuR4AjbFNMCS/Y+/pBC3yuPzTk/uIcD3+S91To0CrprRtFy50fJ5Cx38suNnFk9ULCPz3lGGBmMnZ2x1CAAJFdy9uULLgClv4IW/FdmxqFpaIPiU62M3TrhLR2SJnoXTYu2AKTYgemBzGTtSDbKNwBU/wRnVns0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hht9K8RP; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKQYShgG+eQ8gYnM/8edRZ2yyCQJ6N7u5FNYQ3aArDk99erqyIDrFMuupHMP7azUI+9xsNuemEiCY7Sv0KjgcMdKIlEx+LMSk8l+fy2b2PhUE5jAx1bbyFCAX74Rc5CJL7/1PnuTVkJzHDl9HIh3PEZ2/DhZfK4mt+BDTJSHJzOFwXirDk9mdP9+PY8OrzD8XrzZ93cvOApoLspKCX/cr5OcHIKbf0F6NBHp1gwJ5aLSXNo3MbpZIDcvI26yfFgeqEqN3I2fHk9R6dSGaMAyRnkCqzOHG+ETno/izvwlLlKJONCh/Nc3cM7udkY2iCM4ylO0onv6kzUu24fRlh/Ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPCEBIIcRIa0KiES5skRiMH4UMpOvRvuEpBV+F1ZJq0=;
 b=l6CCj+7D9RRkgoRuRdJxk5tptbh3NKqIpo1ApYkZhA3y+er9R+jjeQwrbp0GsGVOCsmK3eWft1Wp4xPWo30uUKOtTVOWN/fbtr9hAA29tKKVVBvsXrcf/XtgB67LYtQnFmE3zPX5/qjCy5DbKqS7+2E2mlCXTtzZeRwlOpMOG/K6y9tLnAR/dWl7BQ/lKcAov2D2um9bqbkTbtdz+J1A0TiIukOqEOC28iEZFGKackrYpAZHJ3xy5ZcJVdkoamJmeiXTmXFsluYlEjdMX/p9YTafajZGpmKNanFE5azub6Htolm5dyQoNyCoq+xNKm09vm8ldGUTiVDUJeI2+OyhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPCEBIIcRIa0KiES5skRiMH4UMpOvRvuEpBV+F1ZJq0=;
 b=Hht9K8RPZgNlzsMW4zCaKdsPuYrwBVSt/P9pNH7POQEm4p8+NFLWpeIjSdAv5tgVhcupQ8jbxlm5OpCx9spzMsApFj7j/xvQoyvK+aTZN6eXohZFKfdhe8mrVLwCARLF4FNclXkvl8J6vUor2X/j9H5/v14BBZaGuvjwhnS6dSmvIORvO6AJ17fG34FNmOknOnQZ3msz/3BRw6cENap99uHpRKr+6ryl0E3MLuXkewSW3ZdlPaW2mpnHlNjZQgmfjdZv2Ftt7X0LfC5rRc9of4lzawIzs9ClheTf5XlWMKtEql/uynxP86Lo/9FW7lL+cwtz1QLZh+Mk3CKOTktL1w==
Received: from MN2PR17CA0017.namprd17.prod.outlook.com (2603:10b6:208:15e::30)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 17:31:01 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:15e:cafe::d1) by MN2PR17CA0017.outlook.office365.com
 (2603:10b6:208:15e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:32 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:30 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH rdma-next v3 0/7] Support RDMA events monitoring through
Date: Mon, 9 Sep 2024 20:30:18 +0300
Message-ID: <20240909173025.30422-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e19bc0-7165-477b-7ff9-08dcd0f52c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eM1OWP5vUnamtq10SpL2KxZG6jhCtSnG6i+VGbx8LulXKgVoziY26nWzDw3l?=
 =?us-ascii?Q?BAGhXPFbOGH8CVCbbkGd+0znlVZSq2s72S3205BKKlurwHoEEKU8kNYBRw47?=
 =?us-ascii?Q?RgrNZJ5AIdYFCoBBFG8SQ8HcYi/lvPKdbIZ5o5TKwGUns9cu57Xb4zGf7BFs?=
 =?us-ascii?Q?zsJSSS5LpXGskrr3bK8um+OTdZdxaakSPYC5tTyi7kPtp75k9v8u2tn2Pqti?=
 =?us-ascii?Q?hcNmV7lDJgL6bI+T815WtY5b7SoqvWKiqIUX/GJc/smlRSkVb3CsQ8EcXFC/?=
 =?us-ascii?Q?11j49RcKfCBj20Yah44i6G+aqDaNqh3jFY29K2GrLZSyAuPKyYtuTRyVfy0x?=
 =?us-ascii?Q?vnJpMl0GNVkr31BvPy5akQFy/7NVVtziLP9UaYy2gajnCi2d6GF5v6EvV/WK?=
 =?us-ascii?Q?YAEdahyQT7yJU8OOgocxmCA9VJ0SMHo4D8P6Pua2V35tsdc/xxSFBpbbhXYH?=
 =?us-ascii?Q?bhVYVRR7vCH3A8IsCi5lkilO6fVPtaxmDi3l7aqu6VkexmxFOstzMFMhMQ8N?=
 =?us-ascii?Q?c++vz6Be9GumngixNsYL7BOvaWWfe/PJw0QSZfdMRARktHfOOvOwJr2Uzw97?=
 =?us-ascii?Q?TeISqB+TLL66u7Zopvw7WWINTGK8fLpMwiwnlnZX1KtfiijhP9ElaiTxO0lC?=
 =?us-ascii?Q?AsHZMdEBWI6A2nBTm7SOF5yOSA/QjpwyYixpg4ORFgztAzl0Aw7AUe5jvU4y?=
 =?us-ascii?Q?hWijao5a0e7TBhvnU3+r8RwpdLvgo5LptbISAgiARFkgQz7ijQ6n+2jv0uKR?=
 =?us-ascii?Q?OsPLsd8XMOCBPZ1pqodleIXkAqHxF03szOHjq5iU5ygUS7+4GwDJQZvDQ1GX?=
 =?us-ascii?Q?AdJ4mKRsrJAzOLYuz4Igyfg6cc/GA8pXRkBaLquk+OWL3JbGcjwLQ+ermlhO?=
 =?us-ascii?Q?gLSnc8jT6UJLEZWNyncfxjpWPApZ7LttmZYnVM80L+q2N7ZMV7dDdPkKK37J?=
 =?us-ascii?Q?prrgvH9PH7MjObDKWlf9uYYVacS+nHeKZo7xCUvSBDQ0hG+FheG0k4EYpx6S?=
 =?us-ascii?Q?uprZHUn/A8jhmvYSsh5215MpUeKnNUrTgXNjUGiJF0LSRcEhx0Qe4DDkoPAz?=
 =?us-ascii?Q?ift0/+huHKSx7x7X1mJO+6iJEN7KymRrFjvFpXBOgkG7r9EFqq5w3nuGfbdQ?=
 =?us-ascii?Q?SuAvLRGIj/SA47LHEajYGeURdfXqNH/JYe5hry3aPPpAa1iohpZZUJ9dWcOf?=
 =?us-ascii?Q?W0yfQ2SRn8wUwty+7w+oXfMqvr0sErWxmbyPWpUL8yxr+CG9iFpF8TP8lUmH?=
 =?us-ascii?Q?iugetBH56wNyaTcMbeiid3L5+m5hxMSc70Z9BvjYS7IVcqdvAq+T8W+ayg3s?=
 =?us-ascii?Q?+4HTB1z1YyskTQ5+nAFvwj80MELCq7kiQhkYUnpe5umR/zYVLizEb8tSEK7n?=
 =?us-ascii?Q?6TEDyRgHNlNXeioB2W29YkqRDJ9hGTjd90GidULZLipcVuxS+9Z/AyYwYcMu?=
 =?us-ascii?Q?su4un8E8zmLhQt9WZY9oXnvsyjQryD3o?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:00.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e19bc0-7165-477b-7ff9-08dcd0f52c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

This series consists of multiple parts that collectively offer a method
to monitor RDMA events from userspace.
Using netlink, users will be able to monitor their IB device events and
changes such as device register, device unregister and netdev
attachment.

The first 2 patches contain fixes in mlx5 lag code that are required for
accurate event reporting in case of a lag bond.

Patch #3 initializes phys_port_cnt early in device probe to allow the
IB-to-netdev mapping API to work properly.

Patches #4,#5 modify and export IB-to-netdev mapping API, making it accessible
to all vendors who wish to rely on it for associating their IB device with
a netdevice.

Patches #6,#7 add the netlink support for reporting IB device events to
userspace.

Changes in v3:
	- Fix lockdep warning in ib_device_get_netdev by dropping
	  optimization part from it
	- Extend event info to include device names
	- Instead of disregarding unknown events, report them to
	  userspace
	- Remove fill_mon_register and replace with fill_nldev_handle to
	  fill netlink messages for register events

Changes in v2:
	- Fix compilation issues with forward declaration of ib_device
	- Add missing setting of return code in error flow

Chiara Meiohas (5):
  RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
  RDMA/device: Remove optimization in ib_device_get_netdev()
  RDMA/mlx5: Use IB set_netdev and get_netdev functions
  RDMA/nldev: Add support for RDMA monitoring
  RDMA/nldev: Expose whether RDMA monitoring is supported

Mark Bloch (2):
  RDMA/mlx5: Check RoCE LAG status before getting netdev
  RDMA/mlx5: Obtain upper net device only when needed

 drivers/infiniband/core/device.c              |  51 ++++-
 drivers/infiniband/core/netlink.c             |   1 +
 drivers/infiniband/core/nldev.c               | 130 ++++++++++++
 drivers/infiniband/hw/mlx5/ib_rep.c           |  22 +-
 drivers/infiniband/hw/mlx5/main.c             | 197 +++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  76 +++----
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |   2 +-
 include/rdma/ib_verbs.h                       |   2 +
 include/rdma/rdma_netlink.h                   |  12 ++
 include/uapi/rdma/rdma_netlink.h              |  16 ++
 12 files changed, 399 insertions(+), 114 deletions(-)

-- 
2.17.2


