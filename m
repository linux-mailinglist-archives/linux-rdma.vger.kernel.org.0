Return-Path: <linux-rdma+bounces-4835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F0972118
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C391F23F4A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E91891BC;
	Mon,  9 Sep 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SEXw96Qv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EE188CD6
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903071; cv=fail; b=upd+rIIIKHES1Q4gZ9qbar2xrW83SgbKn+71oJU9vZfwUlwk11OtzzAgGBMudd+oYgMC508dFnwMUt5Ta4rB4cjfLWQNyNUIRu+aOGEEYsllIIgijj1I8I/i4BQfZW9otQVNNPsQKf9iRouf8DtNoAL9gNSbWGoUyPgJfv9ANn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903071; c=relaxed/simple;
	bh=lLEMnxsxyqW9JKAvem3D0RAljr/RlvLLG90QJIOYFXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAnafF/HI0Z3qRyUe0d+p+wSbPo2FERo6Z6ZcjZm7vpR3B6OXCVqB0M9JpjvAriO0aopvon8aMzIigCjCMadXS8u0DP3Vn/7IECD51AlS3bNdTd2D2mSqtbMW9QTLijzgGEipJ3Nm8kQs0HSjFtgOawwSbJ7ToFcpDBc8jX5xUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SEXw96Qv; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd95QgkC6ZVb2O2MseGkiyq0ZsMSYRE1dNUH5L20/CvxXMT0ccq/MKrNhaH0EWz+7shcLez52KnyqprrP3+wz5onPR9lNwJtFULiYm3z/h2AHCO1VuEh1mBJUV+eostz4omNwTA6enXx5q9oSkCeMxbksk2xuAJrbC8VH58C8SCKkTLiy17t7QeH7T3shJ7Z6AWqIKfWFbBHLa3mHONZfjUDyu6lU5ZDC0pyUsp+ZfohtZJ+xAwkt/RabncD4XwL4+Mtn8h5Ep7ARh/qg8JOXtO85yoXcLluTFlRO/JSgBVqrk7q8s/Eos98wUgM+WMv0p8wVNiQWMOHd2legn8kRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2OqhVHk8El4CAjcA45dc2j34faTtRc0H2tjll4NbU0=;
 b=RMU4wxTDrMTgMgSct7Q0vsJxjhEO0wj5ZXD8A3ZJZ+3CN9Kp58fFOtR1+W2T5RewX8A2HDW6l8UU3mwHyhY7tyvaso1XUCyN4noPcruR1k4gM9A7rRzluDNd4QsoUeqaWeqzVlLVyjQWlHgo3RLxv75s/OHWJBsS6Bb9MzSZOXtnPt5Cno7YPxgfSYneGSvQ/ur3mch4kqWxqoMWml1nBWB85nhr9BgOiQf/bzipYWk4pVXBrlwbdL1XfKgWAYfL2hTS1HsruJKwZY7gbAaRkyFONBy2/7rjNc3R4rkiZOtnmtuwtiNC/iiBWVKnKwrpI42PVngdldCSwx+yazhZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2OqhVHk8El4CAjcA45dc2j34faTtRc0H2tjll4NbU0=;
 b=SEXw96QvvlUiXE1By+el1RI3Vusb7aYwFXcjMpHdSpHeIC+JoxXyIuTSjEEgIbNOjVZ1ZpIGJ1FoN/3dPIB6ZpW8AY7FmwkFuKg6fFJPuTTtHxtyKyqRZZCTgDR8+MZNVojutEcx/vd3VH06oAz157FGa3yAuS04MI6e+CIHOa9/FiTvIs0QrTqtBzvROYQtprlTy/GvFz8m1KqgOLXCwX3CbsXZIOs+gT49keXvG+9DWMvXCwj9sv5CBsb5ZaE34COD6mnxbfxE6FD2+wRcpivmSUXNp12UfpMQ+A0lqSi9S39EC80fNlZD39gVWxe56rsTGLuvMNQ/b/IBoL5d2A==
Received: from MN2PR17CA0014.namprd17.prod.outlook.com (2603:10b6:208:15e::27)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 17:31:05 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:15e:cafe::6e) by MN2PR17CA0014.outlook.office365.com
 (2603:10b6:208:15e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:38 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:36 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 2/7] RDMA/mlx5: Obtain upper net device only when needed
Date: Mon, 9 Sep 2024 20:30:20 +0300
Message-ID: <20240909173025.30422-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909173025.30422-1-michaelgur@nvidia.com>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: cbba309d-f556-44b0-c575-08dcd0f52ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qF7fa00f1uM3Iei/iKNfOZiONh7bX+FZhfmLCJHtK9PLT+f7E6BJn477ktXy?=
 =?us-ascii?Q?CtFnLhvjDeb8fvWn3PLmzGC+JD5C1F48GnVwHXsZTSkr8VBizHWovC1czwOF?=
 =?us-ascii?Q?F42TbUdNbGqYRcvJjzdrySsUnEZAEC+cAFe9rMs7nLg1GYdLz0j8U9J5mCrT?=
 =?us-ascii?Q?orji0SauRsSN7zjR3lBlxT6ALybHNDmpbukkSJRxwJeYrXK28ALjbbWPQ2z+?=
 =?us-ascii?Q?iH2FC0Joo1e6zyXoBw+5PrnY6B3GaI7RGKsxKUPKBDc4eliC75DLCD0VRM2u?=
 =?us-ascii?Q?bPsaODEcHa3IjgXULomw/rz+kbAmGKmmppDqnbsmcG4iqNkvLkArl2CM3jY3?=
 =?us-ascii?Q?NtUY3uS3rw0FYvfjAQZcqlS7VXwXB5d2GMcDgpnjoXL6vnuh/DdooSgQZegp?=
 =?us-ascii?Q?MwsM6x0pV/eq3l0lAReab2gzEsmTh6u3wmlLJpmgzdmdFAFclrXQS6JYUJTz?=
 =?us-ascii?Q?ZbGlmjmaofOW0mCikWyUhBe7B8agL5OVSX9D95MMdcohmRq0HsPqgyeMVazF?=
 =?us-ascii?Q?xLfBEbEhTuca4xdvVNfnAhKlhrHdrSoFGJ7zfrrN2CVfG3Ou2FFroBxU//nG?=
 =?us-ascii?Q?3vOCeFSum8OvS0EAjQPTI33k0A1QeNzylxqN3RENE0YwdJ/9UB4uVAMa/3V7?=
 =?us-ascii?Q?0sphUH+k6y53JecyVDOyAy1e5cCGvTkyhXFCFbyKHaxNTPMBNKr2mocprrjU?=
 =?us-ascii?Q?C/0dgWsS737yFV4sYtkyBFbKsH3yrGyo7PEYCURQeTD4emr9OW0B+Q6w2YUZ?=
 =?us-ascii?Q?DAEYfEU6PbC19t/LFjgwThYjgNnueFFwJkjhdLS/u99QYgk2zP2fs2AjKaT1?=
 =?us-ascii?Q?z6GV1xUE+91h8lJ4dwPj6MhHUhgH5Ig2uCsfp5My6jPSGjdAUfhY6PT6ZtOq?=
 =?us-ascii?Q?x5YRdcwpVP3IT48znp9TR2yoZRJOkx4bfmRO2lkTNNZbBvTdhIgHK61zR+/+?=
 =?us-ascii?Q?rC2hpIrJU9Wg+/6EFWmYpymVLguTTF3qNx/IEVa60bzt/t1LCPklonLDGfI9?=
 =?us-ascii?Q?wy5+M+2jNvGOIxOVYkz8jgQQ36UcEPIvZ9WrmokKlF2CjYiJi+90QzYq+/HQ?=
 =?us-ascii?Q?tjSZ0k84QwZv4kavFP+/97rHfsupbKt3H6GLSCEk0jAj3zb9J5XXdFsYfmr4?=
 =?us-ascii?Q?ptKAQ7qRKp4fA07jBPmkXL3wtOJ+9mVo6bgf41bzyjaxUuWoXZtzQtSy3iwZ?=
 =?us-ascii?Q?gyeidqBfqKZM9DXG9NNZdF0FKCqnYVkUaFa2iix46dqA16wC6Fv5QqLnFpeA?=
 =?us-ascii?Q?JkfGXBhUm0YJEIC5p3dIoB6J1KpEIcfgLqmhE9wNhb97Vl89JifkJxVv1sSc?=
 =?us-ascii?Q?jYVUQxEkSyJfb9t16qsoLCncTNVZrq5TWNK2sbkuze98gh1ye+C5Igd4qzjo?=
 =?us-ascii?Q?HHq8LaqsujR0MbgWafykTzOMBfNFz69YQxgYI+YEgy3Nc4F45bHJZFnGMpXE?=
 =?us-ascii?Q?rLrESyGg2YRiULDPUdD02mryHM/W7y9O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:04.6114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbba309d-f556-44b0-c575-08dcd0f52ea8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

From: Mark Bloch <mbloch@nvidia.com>

Report the upper device's state as the RDMA port state only in RoCE LAG or
switchdev LAG.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index cdf1ce0f6b34..c75cc3d14e74 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -558,7 +558,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!ndev)
 		goto out;
 
-	if (dev->lag_active) {
+	if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 		rcu_read_lock();
 		upper = netdev_master_upper_dev_get_rcu(ndev);
 		if (upper) {
-- 
2.17.2


