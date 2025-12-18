Return-Path: <linux-rdma+bounces-15076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1DCCCCACB
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C35E3303DD04
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BD3612FB;
	Thu, 18 Dec 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnm6ri5S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60D3612E1;
	Thu, 18 Dec 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073501; cv=fail; b=tnmWopz81qJNsLjZv38zJgC9ehu+oZzGvuiTps4PwZxUkopLbbOzmhkeJ9ruteLV/cKzmEKzSWiCN/czvDe7AFQsqxgWp6lxpyY8EbiPYAbvcdBPIQe7WpbKK50LobyvLI4OV3CjvusY2RRYpjDrF4eZRTqskByjPFRmY18IiIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073501; c=relaxed/simple;
	bh=outsDNRgQOokMP6MRL/KEAdnW82aI/4PYtih12OFpm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQz5OsvYKznjsEsvara5gxe9rONzYtrqlbCnSi9PUl+dTlvMt5OUPQenwa95lEyVzRyKIXWjxR9l7poDzJfnZ/s4CCfpcr/UCYcfZJSvHsueMpp9RXYKhp7qm7sRRv/hM923FQi+3qg8/veTcTu6njohhuc5m4U+jc6kIvngkXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnm6ri5S; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5Xt5VywXuUH8v+kc/faO/3OKEOs/UqrCpdawQF8F3RLZ2dhUeJk90vhzgZdh3/PkhsTZRhdV54BkxKff/JgMth0xNlW2C0tGuquX2dSnpY3T8vhMJDrFrvOKlYCPN5Cgo5lCswAo/FS3CHtnmsgBwg184OZwMYCG43+yfkl2TDs78X7gVjCv5lTAtlb3ds1RX/FJBQqkR3TdfghQ5RyZiFkOVUbGr9b8B5d1zjnCgdpyKNJoAHJWcRTKQ5xIBiQTMVj/4UbIhpoLNmPahREqBWiRL4xtLKdGDSgFJZfhHG4LHlQkkP8QSR5B7+yC5Ck8SKmORX/d4owoeBw6DpTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO30pYx7x41QFIPAl9Sk/JoT4u2Hk6NyzpmjyglRe0I=;
 b=DGwJ44kDnda60M/BxqpizzXyjSOcVpIX/IEqsGkQT7WQu79l8FmviBYOjHCMR1nP6mBPc+d643fAM5QaUl9p9vw7Uhkjor0b9NmIY24f2MLWU/WY9LYCo3Vf0ZyDSc5OjTPlxCS8dTY2MCSzyQcgrbaE3zmfMqIJLp6XeKXj0xcE0wBO6zfzvXJp1RpHLArayThhb5qKhtEt9PQNIoRuY6ZCyqnny/YHFiFiA1l7arAJLr4mzdakYtHQtXEDbXceiGcAbH63Ny4ATgLK/anJ1S1cOqWyS26p+7M7PUjvBkCMrIvPe+R0DNWajXb3EqlZOqNFbxpmkhdxdIX2CBAkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO30pYx7x41QFIPAl9Sk/JoT4u2Hk6NyzpmjyglRe0I=;
 b=mnm6ri5SaFhAXb8ww7gbcDzUDxCdQ1IF1oJgF9S/Z2+tD+WygYszza389kralEZ3Ddnjl/A9efkQZaBphFFp8dItplkJmumi2PVbM050IOuMatmc6j7YLpnBSWX4U+bxpecba7nD0bdCU2koEk7kiL51Q0e5WHLC6zOodpjAG0VDuYmpWURyLp4OdCpbDDY/24nz/P7FLWh8wRx4rIzF5ffbb7uR88PhdASMVvwJ7hKKq/VtZqZCCo1+nq0tN3ocI0DzHQS+XUFT2hV0bNHY+ADqT32C2fyVU/AUXlRp+tCiikixonoB4fqRbSOMH/yUsEXFP8PTQe8ORyEjD6AFYg==
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:58:16 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::3e) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 15:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:58:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:57:56 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:57:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 18
 Dec 2025 07:57:51 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>
Subject: [PATCH rdma-next 00/10] Support effective VF bandwidth query in LAG mode
Date: Thu, 18 Dec 2025 17:57:50 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251218-vf-bw-lag-mode-ae720fe54e51
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=3375; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=outsDNRgQOokMP6MRL/KEAdnW82aI/4PYtih12OFpm8=; b=12EssAuAqfAZfxhr8ThhlZHBUqLF3uY013djs1nwtv634TUwgdlV5ehlgoZuY8OYIru1R7EUa yZ2LlsBzpxFBu0dhLPlrpfU7eMR9z+uw/AQx5Sw4I3CLPjnH50a+9aH
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce374d7-bfa3-4561-9c0f-08de3e4e405a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qjl2UUsyTGxLMEJrOCtjOExoTFJOVUpOY3YrVFZSWXpHL2hTYmFtWWFNeXVF?=
 =?utf-8?B?aER6Qms5dXlZMW8yd1VMSDhiMWtNMDJzU21TRFlobzA2MTVuTnBCdmNHcTFk?=
 =?utf-8?B?azFHS2ZFaElXaEdIY3NnUjlpbFozZUlNczhOS09MUmZhdjU4NVJEWTJxQmEy?=
 =?utf-8?B?NnhKbjViaXZNUy9yaWFyanBVSHBua2JpUXg3REh3ZTF3WUxsZGdvK2wwdm9P?=
 =?utf-8?B?ZUpQeWNodTNaYlhjLzFTUlRuenIzbHk5MU5vNnllY0VkV0ZRNTZQa1BPZlc2?=
 =?utf-8?B?RnRwaVg1QzRJQm5FaTN5VWQ4eFE3alo1QmRVQ3pqM2llWEhzMDd1by9zZjR1?=
 =?utf-8?B?aEJCZ3M1dGdLOFlCSFdRTkpxMUt1WGx2d0ZVNnB3bTEySHpXbS9TNG50V3Ey?=
 =?utf-8?B?ZDFUUjc0ODFDVEFyRjN4cXdnS1YwT3pPdGRTU2lZM0h3YUVIRXhEMHpOQlBx?=
 =?utf-8?B?dU0wdUsvK21NektIeEUvc3A1ZDVNWFJvOTEvNGRwUTBoM3BoVnR5UE5QcTdy?=
 =?utf-8?B?bnBYc1hwMmtPM2ptN1dQbFNlNmJaRzlOQy9JTHluR0xLQWhWVHE3djE4Y045?=
 =?utf-8?B?UnBvNHd0WC9CYUJXWGhZZTEyVWZYTXBnQVVpQW5FWjVmT1ZtTzBhOW5xTlJo?=
 =?utf-8?B?aW1ac2FTVFJxd0FuS0NiZERRUmVYYWZIeUtDOHh0dFJPVVNFMzFuNkhmYmxZ?=
 =?utf-8?B?dCtEZXNIQk53RE1seEZxaWdjQSs2a1c4S2xvUGNVS3FXR21zd1p0ZjZVeGN6?=
 =?utf-8?B?ZDdFSlZnU2FlaU9sSThBSkJoMy8rZ1p5eis0bG80N0xkWVFTUThuclZacXZx?=
 =?utf-8?B?SllHRERNQWd6bWR4Rko3eUpGanExSFpKWHJQV3FwMUdGOFBLSVd2N09xcTN4?=
 =?utf-8?B?YURxL2hkaTZqUjRDNlkrR2lycmU5R3JZT3NOcXovaTZHNU1sZ2NzOVZZUC9S?=
 =?utf-8?B?VVNuWXlxTjVWT283TmVRR1BETkZmb0JtZURlRjFjYWx6YXdudzNNQXgvbU1O?=
 =?utf-8?B?RDNVWmtLUnR1RGNOUzNXNGd0T0k4Q0x3YUdtalF0ZzZZM05XdFMvU3dWbkZO?=
 =?utf-8?B?WndVWnhjUTc4WStYVWs0emRXcTVCZXFyWVB6QjRUQ1dFRzROZFhHODRqYktC?=
 =?utf-8?B?UDljZkJrR3FjYS9HZU1Kc0dOUEJiaUhXZ2E5R0RFbnE4RXk2ZlhpWURoQ0dN?=
 =?utf-8?B?S0hSQWdmbVVoVVlJK0lRVXZCZ2lsS2VaZUhmRCt6bFhEVmtnUUMyTEZNZFRD?=
 =?utf-8?B?R3lsQkxJdFRhZzkxaVVyVnhXdFZjTDlPZi90NFBsUnlGUXBYV2xuaVhjZWVo?=
 =?utf-8?B?Sy9zVE5xU09yc3UvM0NnZjVBZ3hpYmpaK2Z6WjNvS2duN1pPRjRtRHdqR2w1?=
 =?utf-8?B?SEpoU2hlRVliU2VyMmtRYzduK2NuUjkzUEp5TlhUcGlkcURYYmtlZ2pPZFRH?=
 =?utf-8?B?WXVlOW4wL29HdE41NE93WVo1YXBkUU0vUHk3WmRFL2tTcVNZNksxQ1g4Q0tp?=
 =?utf-8?B?WTJZUmlheklPVVE5NGU5MThxelY4bWdhZWU5c3V5M2FjSldMU3VISTg3Skxq?=
 =?utf-8?B?NzFab0t2eVV3TzdBWlRYY1c1TXFUVldzbWNHb0FjSDdycUQxdlZmNVA5YkQ4?=
 =?utf-8?B?UE94K3pQTVJnYU02NmNUbGh2ZldxNDhMK1RIL0Q2UDNNWVNtcy9GSkJ0Zkpl?=
 =?utf-8?B?UWNvMHY2dC9BVGNqRm9UMzRYdE4za1ZPNTZKQ1pHZnlXbk4zamtaMCt6Uktq?=
 =?utf-8?B?cVhMTTU3dnMyUXV3UldaQTFvblB5T3ozT3QreDVvZjN4QnQ2b0UrN09aOWdE?=
 =?utf-8?B?ajdmc0I4eC9pd0J2VlhmUzVQR2krL0hKOWxYU2RZZ1hkMElocHd4SFNaaHBD?=
 =?utf-8?B?K2sxUGZFeHFUc0xyR2Fnb0RaVERGbEVpTkJDV2R0WE1UU2N1TFkvRzdVRzF4?=
 =?utf-8?B?dXBDS1F5QW9oM2lzdHFXc0hQUVBsNCs3S3ZUc3MvRmduWStWOVJiUllwUldF?=
 =?utf-8?B?ZUdTd3JVS0JxR3FVWFBweEVDelVwU3loY2RUcmZlSEF3NWNqZXNKR3R0Qm11?=
 =?utf-8?B?VU5HRGpCbHBjUUpySDZnNk1SODZVZFY1ZDlkQXVwSjdTZ3c0aElNTElZbFV5?=
 =?utf-8?Q?nmwRCHM5/JLruVnCqBtJIEoYi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:58:13.9931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce374d7-bfa3-4561-9c0f-08de3e4e405a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

Currently, mlx5 driver exposes only the parent function's speed to VFs,
providing no way to query the actual effective bandwidth in LAG and
MPESW configurations. This limitation prevents userspace and
upper-layer software from obtaining accurate bandwidth information,
which impacts traffic scheduling decisions.

This series addresses this by:

1. Adding mlx5 internal logic to calculate and propagate the effective
   aggregated LAG speed to all attached vports. The vport speeds are
   dynamically updated when LAG member link states change.

2. Extending RDMA core with a new ib_query_port_speed() verb and an
   IB_EVENT_DEVICE_SPEED_CHANGE async event. These interfaces expose
   the effective port speed to userspace, supporting speeds that are
   not expressible as IB speed * width (where width is 2^n).

This series enables userspace applications to query the effective
port speed and receive notifications on speed changes in real-time.
In LAG configurations, each mlx5 port reports the aggregated bandwidth
of all active LAG members.

The series spans rdma-next and mlx5-next.
Patches 1–4 target rdma-next (IB/core, RDMA/mlx5).
Patches 5–10 target mlx5-next (net/mlx5).
The patches are tightly coupled and cannot be reasonably split.
It is sent as a single series to allow coherent review.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Or Har-Toov (10):
      net/mlx5: Add max_tx_speed and its CAP bit to IFC
      net/mlx5: Propagate LAG effective max_tx_speed to vports
      net/mlx5: Handle port and vport speed change events in MPESW
      net/mlx5: Add support for querying bond speed
      IB/core: Add async event on device speed change
      IB/core: Add helper to convert port attributes to data rate
      IB/core: Refactor rate_show to use ib_port_attr_to_rate()
      IB/core: Add query_port_speed verb
      RDMA/mlx5: Raise async event on device speed change
      RDMA/mlx5: Implement query_port_speed callback

 drivers/infiniband/core/device.c                   |   1 +
 drivers/infiniband/core/sysfs.c                    |  56 +-----
 drivers/infiniband/core/uverbs_std_types_device.c  |  42 ++++
 drivers/infiniband/core/verbs.c                    |  52 +++++
 drivers/infiniband/hw/mlx5/main.c                  | 132 +++++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 215 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  11 ++
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |  39 ++++
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    |  14 ++
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  24 +++
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  74 +++++++
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 include/linux/mlx5/vport.h                         |   6 +
 include/rdma/ib_verbs.h                            |  17 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   6 +
 18 files changed, 651 insertions(+), 51 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251218-vf-bw-lag-mode-ae720fe54e51

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


