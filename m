Return-Path: <linux-rdma+bounces-12798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD6AB294FA
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE07203BC6
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE91242D6E;
	Sun, 17 Aug 2025 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+oO3bNy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8401D5AC0;
	Sun, 17 Aug 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462224; cv=fail; b=fpJMY9ObsvvOQr+ULE/zLh+zG03tVHYyWmVmd1q+2a6qtitZzGhnLTn6HXDcMOi6Nskswp+cwUVdMll9fMeOH14cGx14OLoyR0F5zF6Mdcz1fa42/lgq1I0XTSRMQYiU8XfEPwzOECR/gkIq2PB16hdaHcp1wBYVtwSmcxlQ3nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462224; c=relaxed/simple;
	bh=G0wdsMn6MwP6jTOLa0oWOeE4zrUJFoNO0CESKAkJNn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9JNRAh6T3b9dh38DOLSOYqF/abyq/ZOc6Vffz3Ff7ZORmiGoocaIc4Faiv6rFUuJD1Eix0FaUpNj+Gy9rQYLM5rzSUxN6jstSNmuwyd2KXVmiDPigk2NcH1lPWAF9wlIp3czRVmnmcq1N33fH1JTC1o2T3SRiCm28cmKskli+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+oO3bNy; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivvK7hEewrC+P45cEDGqQij+dxigUD/ysn+7JLKRj4QZrV6m1Oour7Yq9Hj+Es/q77BfZZsSz6lSaEG1ftyPp12X3FCZaVIPrQJ73RTk3ioz21Vkhg/CWtT5/KvhWoQoxNFQJI1cad8J+A0A1Xtq7hmr7R7y25Cp6QceXVdHq+lDcyT+SniAHvmezs0uNnJ08TKY+qcpMlndLWXb2UQQOL3mBLo4OeJNx5qpBM3IN3hSkQJZjodkuR/QlKaGzqeP3pZapJ7Ba9YzSarOPdceyclHoBiqs2xe2MeDZ22MyGwpyqiNit7BjyueyL3AJ3GtVIs52Nq4/mt5aLD3o8/s2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObYbidOvKmB2ezcXnlv7iun845QXt0jPG2zgXD7GgtA=;
 b=cQBeW69WRJPbvmgsTexDzfpV6EoekBs7cm2v5otLxqr7EQmmvDK4qx+gq0aOGZ+vZd2sxJlZkiP0rUz0v6W33h1B+3TyRvmhSJK/JUDdkCwRfYUbFWG+c+/3sdT5/+GdZZpH0AkdRBit9EuTk71YKHLNebhKYqDa1ByZXWirtqY+YNxZwaL1kuRtUdSryYWy01qegSa9o3jhVh6TLrFTLGDNzdkAHZyn0odVQcVfPqbCfBZIZ+7YQdFlNNnOaNom4Yi+Y5nnjuw4Vb6NhFDZlGUBe9z5n1yG7tgFzBVUIvRbf3xFJ5psqBodLlp5bc4EzADuxqIraDEJA3d8sX4KjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObYbidOvKmB2ezcXnlv7iun845QXt0jPG2zgXD7GgtA=;
 b=k+oO3bNyy/zRh+vRtxwsvpHlz6SEfLmB8F6Ls5Cxgww0c72e+4nG2s2UopYH2X30AYxDG7B8JJnw0ju31IscPX8yRd6t2R0QNaJZTGHZXDP36elWQjHg6PTgn5crt50hfRsukbS8xRpiZWh3h4W1ZsXhHNi8wFEIrjv0BAyY+YQS8st1rGtF7PAh1kNCG2JdAukpeT0r91nRvkQ65puCqmjOoPTQbWu5KVP879NsvOyw7enulZEJlgWn/FlijscdRcK51YhYg2xxjvK+KN0NPtKaRl0TMSIWCYG0TuLly6jueJ/AivZRxmAfz9q6MTc1DA2XeZIggzTg5KRLQNNxUA==
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 20:23:37 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::21) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Sun,
 17 Aug 2025 20:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:23:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:27 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 0/7] mlx5 HWS fixes 2025-08-17
Date: Sun, 17 Aug 2025 23:23:16 +0300
Message-ID: <20250817202323.308604-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: f47a8bda-ca2f-4076-63f9-08ddddcbf27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R9f+1XVFP+t2OnfT7TUUNzRIdCV2xbkZngKX8y/s1ZCEStVRHGYVJoZF8GKp?=
 =?us-ascii?Q?JtiXnH9nqi878plLUw5/RHvV11veY3h52nF0SRHYsJIdYaU9WzhhLCim+lX5?=
 =?us-ascii?Q?ot16GfjGfsk7Guq2/gL5QK0cdbOS6NCl46GMgX0mAdBtnqX/slr0GN2QzAQE?=
 =?us-ascii?Q?u9PToloH1sZPXMFNS/278dZvDB3Ximcwo40AqdQjxgMyIayDYwKF2fbvvLXN?=
 =?us-ascii?Q?BlmMeKDHbaCocE5e69dyFTadBxjw7kZMKHVDoG09L++T+Uy7Xu8xyBPczIjT?=
 =?us-ascii?Q?iV/i3Y/VTQ38fmP3A/Mk02FLKI3QD7fElwal0+dHqpoUeh2sAFSCSX5SMcqU?=
 =?us-ascii?Q?CzOpnjaeGHlWA0TtBs/D+vGLkaAgMh6jX1/rOGvRoPlD0QAffYwnLHKmFF6T?=
 =?us-ascii?Q?2cpmgaF/m3SfWTE8i43xf841AYmyn7B07dqPZt5788b4pWiY4S8Gll61pxsp?=
 =?us-ascii?Q?n8xP8I2BRI3LRaHDfPsiKc8IwPnobMEMjYtUssC/hHZBnOA/kqL+cgNQlj1m?=
 =?us-ascii?Q?dbrIEN0HRn6QOoZHfIEbsa+u0mqOrTyXPu0M9B7FWOos302LtaC7nT9lwWYm?=
 =?us-ascii?Q?DiAuT403io7NbCxXLof1KID7ypN4dDIBzB3y0L5z9L5HDQroLYQzJ2WDKv0c?=
 =?us-ascii?Q?jwzjT0DGTxFUGxOoBGirZXex2WIAHkOnpxDp9ZuGjVfooPIi1UW7BqS2itvo?=
 =?us-ascii?Q?JgaXl7hgyLRuHi4cibapJZtkNBptLQZrMWbkRKRoAsxTs5FA3dq+pd1yOcmS?=
 =?us-ascii?Q?rbU/8zAQ1IapwwEvxmYBiVIritQfmfc5NfSqOAacwd2CIs7IOJF+4BXn6C2v?=
 =?us-ascii?Q?sNyh0Ok/frBrQmAbJehhIbRou04H4BC23jwBhggCgC5Uk/1viDtjN4ockb7C?=
 =?us-ascii?Q?0h3W/9KFDo0AfSs/1XS4kmxaLt+Nk5Cdk4yfalIVCKUZQVWgWAV4XrGirqjM?=
 =?us-ascii?Q?kYMA3cxC5ulmhIfHucBEy/pboa7QyLGW+c+K/ERoQ100za5xJuxnhtmTsxl4?=
 =?us-ascii?Q?WMG9FwhLBTm2EMpq3xo9P1n3v44wr1T8NOoGM1Qir/gF2GQ1p1JTpkFnFgz2?=
 =?us-ascii?Q?KO59puFwAa1Hz3Rm7899ikR/ZQC+9xj7CG47Jm4zMeBZ54fEd0JBm50EA03G?=
 =?us-ascii?Q?Mwp+U8b02gbA91/gWKdq1+l7+Fhgy6gqMyv9P+TnM6VaqwHi7oQAIUiCFEbS?=
 =?us-ascii?Q?NQl6RRT8x1epaqngKBSQbsUMAITPptdw5Fr+p6/YeZYRdvR+F2zMpPgUu99G?=
 =?us-ascii?Q?qu/q+AaXwKAMSFH+mPMJOjTCakJ4Bg0xVv4Tl0XIpGxSOZSo3RaWg9jqcgOo?=
 =?us-ascii?Q?45mDg3ksmRpW1feauwQ0sZaa0pp4mzJZFHs3gNUR3sFeAXR+DrnsP951r4VL?=
 =?us-ascii?Q?HKv8D7qe2j9BydNU04BrZ8bdbJQ7XPNEmlqJKcsyhY8SUwEpyjMiuPADttLs?=
 =?us-ascii?Q?hbSrR841qa50QDPC2KWKuB8IzmAGSO8unjDhfVrXTbVGxfHzBaSVXcBzD6VT?=
 =?us-ascii?Q?0X0Nw7cmhBogRUqWLI+4gRNwNC0cG/2b50jQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:23:37.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47a8bda-ca2f-4076-63f9-08ddddcbf27f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

Hi,

The following patch set focuses on hardware steering fixes
found by the team.

Alex Vesker (1):
  net/mlx5: HWS, Fix table creation UID

Vlad Dogaru (1):
  net/mlx5: CT: Use the correct counter offset

Yevgeny Kliteynik (5):
  net/mlx5: HWS, fix bad parameter in CQ creation
  net/mlx5: HWS, fix simple rules rehash error flow
  net/mlx5: HWS, fix complex rules rehash error flow
  net/mlx5: HWS, prevent rehash from filling up the queues
  net/mlx5: HWS, don't rehash on every kind of insertion failure

 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     |  2 +
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 81 ++++++++++++++-----
 .../mlx5/core/steering/hws/bwc_complex.c      | 41 +++++++---
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  1 +
 .../mellanox/mlx5/core/steering/hws/cmd.h     |  1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c |  5 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  1 +
 .../mellanox/mlx5/core/steering/hws/send.c    |  1 -
 .../mellanox/mlx5/core/steering/hws/table.c   | 13 ++-
 .../mellanox/mlx5/core/steering/hws/table.h   |  3 +-
 11 files changed, 112 insertions(+), 38 deletions(-)


base-commit: 715c7a36d59f54162a26fac1d1ed8dc087a24cf1
-- 
2.34.1


