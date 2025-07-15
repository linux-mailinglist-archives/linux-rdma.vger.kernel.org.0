Return-Path: <linux-rdma+bounces-12194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CDBB06192
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF6A922E96
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DB233148;
	Tue, 15 Jul 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b52GtZnX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351F1D5ADE;
	Tue, 15 Jul 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589865; cv=fail; b=Wvi7FiiHY2a0ncv4bazZlbW93f8VXMujND6X2SjfTztFcrhSac+b2vubfvTRaLWwN3sqthc2/G+h6lD/TB4WlQpDVJ2C/HmfKPASrygC0VrIrFbnOxKNXpxyH+ryS5AnXU5g60dC78O2SAxGsY1dxyBuVArOeRE0eNfMO3VfZV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589865; c=relaxed/simple;
	bh=OfBiEEkTY7ke8rixiZF9kw5wxS7M660udlrSPF54IsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZkvdnsHm2chRsyse6JyjiLbPhcllUEHnFVq3/TapFLFK6t5ORoHWxfAXKUXNdsHtGcTEn6sc+Y0YOIhCW0rUVLCuBTwD9nHbfNXH3fNCppLHwcPHNUql/OHkKD+DbaYrqoQEoYlcvotD5KOAjRoj/kXn/K/WCXdoQR9MJbP+cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b52GtZnX; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY9MWvsKEGBjzr1EwhTeexSap+4rsywkiaceZk2TUoTrdWIhH490uqSuBiMs9/GJNZ8bhnB6Ehp6yJiZ2kZoxCoxZNaK9zSF266c7sGyZKkaYbiyMKvf+lRYQnInX9eP4cIL+yDCTRoD2L0q2HIc+5oRsj0QY//e1DXmcKZ8gjnxaq7x793/sArzKWecMN0aHBNcrITEnWvtic5zQKCL3e4ZfdLZGc9Xv3onKmJb9ta2CafcBvDeegO4qbCu+ePX9lM0sh0p21QyWVOQAJBdFQ5atDvp22GxcpQcssC5CCuePNzBue7uRMpNIfkwfXa8uVn6axxBu89xiLmT6XVb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beaNdidvVZo7UNIOEvxRA01FxUm+ogWRXngwQvZT0fU=;
 b=KYpXAv+AUM2amdbY/upITDJVBCW98MXecosyKqE74x0E2KpdXR6gJFKCmMmRtlmp1jADOShoxVh8S1jBloCd8f4wyWzRJTQ8/ndRRbV1bjfWyYW8zAS/i7fKwthlN+ptTnfZisJgCCRuAX/0BHUfw2cojJXrp8yBWSzb7eTjLv0rQei26Cy0+UvygXJvAiv+BDMpViKEBEHPH8nmeFiHMsHykwP/QMxQivjhV16zWF756mSQ56fFAp0mhH68PzsANr3wI+AKfbOCe6+CIuhgbmeEb2yBwgolyvMPYPO7xnTnRPpgQFjMkPCSU5pwXC14tE4MDqN1s8ZVJDl3OXM5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beaNdidvVZo7UNIOEvxRA01FxUm+ogWRXngwQvZT0fU=;
 b=b52GtZnXQISHtraAW+RAioc8MDobeq0C/EF0dNo0ic3AARjHA8PeaLBKnfnLU1ma+70fDuHu1pe/GW13LJg0TZMu+guhrHvITWvDQNfNngQ0GcpDDZ053hzW71JvB0pjOLLHJD/iX3A3j4pnw46Ynsh3AY1hdkmCpvwgDvbq75Zgi9EdJ7kBBcrDr59xoDj9yKrxA6sKp4lQqM4LBvN4QGFYov+gDp5uR1Qy9rk5LWfuCoFwDJysDPDScjU+9HNuovjNxNlGctdoJ5jlEG1lALjc3pCKj5XfMB7p5xUos7pX2m8oleuRTwqdjE10rM90w8N9Gv025jQh/+kj8jTdoQ==
Received: from SA0PR11CA0087.namprd11.prod.outlook.com (2603:10b6:806:d2::32)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 15 Jul
 2025 14:30:59 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::d1) by SA0PR11CA0087.outlook.office365.com
 (2603:10b6:806:d2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 14:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 14:30:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 07:30:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 07:30:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 07:30:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 0/2] net/mlx5e: Add support for PCIe congestion events
Date: Tue, 15 Jul 2025 17:30:19 +0300
Message-ID: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 57442788-a38d-411d-ec2e-08ddc3ac374b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jxkwo/6Bj6C8910VwTRLgCm5a1ttmCB/8FxnvBXXEiGCJXGwGPJd8bA0abt8?=
 =?us-ascii?Q?lQI4bM+I0JF5EbuZLGpsHbY2hso9zozkkWKrxpwmNqW9dVhyJuuhxSSdXKqq?=
 =?us-ascii?Q?95fZBTveuw4cmNfzsOS/HABKomZszSRvEyD56CJ9Vt9WcjBoqiHTNYaPB8Ei?=
 =?us-ascii?Q?o2IQ5qONDn7GxED71bsKIFqicf9uUfiSY1B+7rEwykX5Fwo3PqYhz7zwkGVV?=
 =?us-ascii?Q?EvAqvWirUxb3juw7nQRUnPahjqZXjPHeVXmw/3Wf+aihvuPeivy9WEpMjE4A?=
 =?us-ascii?Q?HWko/nNFra4nd3KJW4HzJT8IXGw27mkI5BC3L4jTYTDOqkH6tpHhW0ewKiXG?=
 =?us-ascii?Q?EtRqxN9JtrLYYPp+2zk85Sf7w/7XfE8o12QN1niPBXof9SXjLzvhltO3xpmv?=
 =?us-ascii?Q?T6I8y4eXIggD+so5sw0MW2+x32SzMIrwl/jqCMtZOp3nDLw76yszES/PHGGi?=
 =?us-ascii?Q?oCMAg1N/XAqlofGjZ2b77/ukZb/3gqd6lFNutmeMOVYJZWg5/kAEafuZ9ke2?=
 =?us-ascii?Q?uAFyw+dtEjFl3joMfMhb4r2PME1NTqCuyfRiDxRdsFUq6XpbNRFR49lGUCH1?=
 =?us-ascii?Q?2m0qa9YfpxPtMjnmnmJ0sY2FBeGvpRQZI8NnUHxoqa49yjD3oj96wWKLwgEw?=
 =?us-ascii?Q?sWVk7XcUdGCtD8t/HDyW3GIoWkTlJ3qan37JTVt60GaC6pMnT9slH37Bn8qd?=
 =?us-ascii?Q?1NNkZ/jeGc7fXBb39IL41JImsgmcCx6PZiVDsAnnNRuJ4ambUG5735iRNHXh?=
 =?us-ascii?Q?o72ts0HFZ6WVnIWWx21oLhq25NmJtJovrUbiELVlxsfANPCcPODONpXqHkaL?=
 =?us-ascii?Q?FOQ26ekED+XAksRkCuNxoO66VJKmBYXtvnKEMcb6ETMWW5yO/kboEfa7nSyC?=
 =?us-ascii?Q?56lwV0DI1SMsafEkCD5EiRduksRLtViFbiZ9NZlz6lmOXudupBsO/pXLL/l0?=
 =?us-ascii?Q?BJu2K7XElNqAeToK5d/8vAVbHWTEx0u7ZhqpG5BLXVRhNWDweawyMxPzebDk?=
 =?us-ascii?Q?e+gyAlZCo9Htzm3e/coUfUyf1uUnlGf/VKMTK+hUOqpvPE5xroS6gi8qjTen?=
 =?us-ascii?Q?nYNGlPshYJPrtmhuhSyqSUTqFWrpe/+Zn1qVz6xquTNlCyzDE1yFZ/sFEVkW?=
 =?us-ascii?Q?7tve5bVmllIadvj3cV6xVisRFEMZJd88VBfCk8PNrMtZpDtOrVHfU6Ag+0fE?=
 =?us-ascii?Q?n1EL9UojgyFLsiLHMv5mx5kqy1e687Q5Lg/0oDsMqZdr4czrZfJpLWLjO0kC?=
 =?us-ascii?Q?HilA6T6MYkkI6I1UUcJNbEM8BY/nTnCcP0gdpwK48fnnpVBsxGcr8IwxuUCd?=
 =?us-ascii?Q?f2G2UY+LQEG2eUV9B90IsT1cytR8HMO/oPmm7gIye41HY7gbMwCJrHEmdHm9?=
 =?us-ascii?Q?xh8KWmtJifhDG8IzEQpUkAVyZdoAjpugauI6lUZ57hr3As15OAeLnhWa4Uds?=
 =?us-ascii?Q?vUYgYjoobpR0q4hFsmDWuN66vpKQCybsRO2spV2jKgoG9Ci8aFCpkpbjvmXT?=
 =?us-ascii?Q?oKqP8JeXMlwGsVKgiEbQ9ehZtHCkp2o5T+l+xPFP/ED80AK5mSo8L6AAww?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:30:58.4561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57442788-a38d-411d-ec2e-08ddc3ac374b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

Hi,

This is V3. Find V2 here:
https://lore.kernel.org/all/1752130292-22249-1-git-send-email-tariqt@nvidia.com/

Find detailed feature description by Dragos below [1].

Regards,
Tariq

V3:
- Dropped sysfs configuration patch.
- Fixed compilation issue when !CONFIG_MLX5_CORE_EN.
- Updated cover letter description.

V2:
- Rebase on top of the IFC patches, they got pulled through mlx5-next.


[1]
PCIe congestion events are events generated by the firmware when the
device side has sustained PCIe inbound or outbound traffic above
certain thresholds. The high and low threshold are hysteresis thresholds
to prevent flapping: once the high threshold has been reached, a low
threshold event will be triggered only after the bandwidth usage went
below the low threshold.

This series adds support for receiving and exposing such events as
ethtool counters.

2 new pairs of counters are exposed: pci_bw_in/outbound_high/low. These
should help the user understand if the device PCI is under pressure.

Planned followup patches:
- Allow configuration of thresholds through devlink.
- Add ethtool counter for wakeups which did not result in any state
  change.


Dragos Tatulea (2):
  net/mlx5e: Create/destroy PCIe Congestion Event object
  net/mlx5e: Add device PCIe congestion ethtool stats

 .../ethernet/mellanox/mlx5/counters.rst       |  32 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 315 ++++++++++++++++++
 .../mellanox/mlx5/core/en/pcie_cong_event.h   |  10 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   3 +
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   1 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   3 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  13 +
 10 files changed, 381 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h


base-commit: 06baf9bfa6ca8db7d5f32e12e27d1dc1b7cb3a8a
-- 
2.31.1


