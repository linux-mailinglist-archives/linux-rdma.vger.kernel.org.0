Return-Path: <linux-rdma+bounces-8439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8183A558BF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 22:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE51899480
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7125A2B5;
	Thu,  6 Mar 2025 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYUvorY4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C153423FC59;
	Thu,  6 Mar 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296426; cv=fail; b=ohajWJC2rkv7cJFsCqB04DK+pBoMibWfbo4UjPI5XaSKBGOkHEkOY4LwzbctWGIzmohkruURrryH4RVd1W209ZrXKsNLwGbmN6W8kOEVqnLBMxCfYcRVdvTt48BIozFDL3Xvr1khea3OtA3IB0zIlhGwLdxX2FvH85WktGfZxSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296426; c=relaxed/simple;
	bh=d28+P444m0mLMJHk0GbO2/twMos+IjANQjpCi9DkuJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oUFAk8cVlC/Bj9fVELPjLyCgBNlY8G2MTOaPHOd70DZSoM7E8neGoUxhtiCg/2mSGUXmGJVXnjkQfrH3DelDVg5aaf9eBsssXSMSM9dgmZ90y3Jni7wegEQ03ihABOwmhJKLMgmRRrKBolPpqCB91+wHmrbc5vmONnQaFX9X6DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EYUvorY4; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxFmth9QdHB8XRosj1OMJa0bAKVzFbg/aDWza7MwyPsM2R6lcP/QVWgwULd2lTe5ULg1Eehh0gT0Tj0UkdkOUPPhlI1z+fq2VFu1A8IQB3TI6G7B6gIy3lxwBwwBzCwh9veF4WkZzA3kM6yTn5LaexNC962u6C9PxyQg4ViS1tMN6xZfD8owqWwUtfCupzTQfIeNRtpN9+VglMRgTdQogEcLWZUHwvqg96xTyteYZn4kClIkNbJ9u2eXeiC/FXjOTnniM9qwQK/81aTtL4Hj1+Vkg4wyWvgirWQe4BoAIhyJKC1zA7TqEuXkZ/swHbYSs1wfIToT+/upVuPp95RSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDF9UxIwfNTC1xwxT3KN9nnSejko0o5Kas5taovfeIs=;
 b=BWyZxuV+DGWUrOQWpmGSQuB47ZxNnQfw7lFypR7tY/HvhXXoE7Vd7SjKWeFcs3Kn3hyLumJih108FdLf4c8PAkW+jczZ2+acNxufbk+E2GXYmmIYOXo/WMA6+0wXJHegTAMaz8Wn+/Vrr+SKb65Qo+V2U8RRpWCz1vu3BC4AxfUGnvuXiyYQKJaMVjcGWGywRsZlI4hOh5yboetJeXuUXHl9lcjduxAenB/Ap6y2D+LOKTs3Spoz/+j0Xei01NYhewdHnnuXxnXfZ3FHaIuqq93JiGXIB4dH67iwV4KwxNYD5hm7iIfSjecn2Mkaff1UREaZQPJLBXzzsWhaIoThYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDF9UxIwfNTC1xwxT3KN9nnSejko0o5Kas5taovfeIs=;
 b=EYUvorY4acMHg2KwUc4q65vFYubSmxDMMpdXK7z8mJBLiKqeTt58JnNINvdsBBtFHGxzKcVGiXzi40gZkLj/C9JIKAeeKANAqpH6ll0VPGqJVzEDs+FZF16Rfvr+mq67ayv+Ysu5LaY4Wepk3jHwuySyhSyqK3CsCf28EDRrEky9hxVwJd/9jNJIV8t0qnVWWDmRRy9nKnUKRD/hfDbXcAH6to3+K5jj147hTIKOXNJMyiVp2UV9a6AyCnVfPU3KtjJ8nOjxLOBXkTHrn6P3JKRh7Sxn3No5rCx6SsZm3xb2sStbUS05MCl+d4eJYqtKbaK4OuiT4c1ayHhEuiSY8A==
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 21:27:01 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::7) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 21:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 21:27:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 13:26:42 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 13:26:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 6 Mar
 2025 13:26:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net RESEND] net/mlx5: Fill out devlink dev info only for PFs
Date: Thu, 6 Mar 2025 23:25:29 +0200
Message-ID: <20250306212529.429329-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6325633e-8a3c-4a02-2655-08dd5cf5a1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S6UKSLdWzr4SIP230hgR3ddV+cYu6sjb4n/w8skqyyC1gYKRkqULUKf/XIIt?=
 =?us-ascii?Q?yKVWm8J4U8khGcJbvC+FxTSOcxS/GIn7eg/++ZkN7ufhrGnjrRzmegHoKq9D?=
 =?us-ascii?Q?bwiiRxRKVx/By7F3bOZbWWkQZr2Zyue5G6S4k9AcKFOTSn71+fiuAFSlrCqT?=
 =?us-ascii?Q?88M0NkuWtKq8zFWHeYCPjIH75I83SWCs6Mjn6xYL0r5XpcLWITz2kiOgcLND?=
 =?us-ascii?Q?EKYD3rBuhd92CKaT37HeaEDOzJ1krl8gZUU58b+pzHqiDcFFS7QmDwTrrIjq?=
 =?us-ascii?Q?vkqU2zHoTSe0ws+xHbNxltanzbZlYswlFxVWdF+BoUeV+SQ4HI8+BUNqWNAR?=
 =?us-ascii?Q?uzIEPWY56MFuJxl0GPL/CrLWTFMUYdxaJH40LkGe8C8OE7LCWpVjdv4u4c4i?=
 =?us-ascii?Q?uD/l3X1HtDEe2YzHA2GtXE6F8N60cDFXKxy/AIB3D0Cnyeghn0DEpsVMNe6Z?=
 =?us-ascii?Q?1tFdO5tanBckX4YC1N4oAR3nQKdYoDGndc6nDFAJmjSjq80OFisiCYOBDhof?=
 =?us-ascii?Q?SwUIH/C3olrSmv8Nm4VE7nkdO2vhtFrNYcTwtpwcSk7EJSBZyujVvA2XQXKN?=
 =?us-ascii?Q?PZ5nG/1JZq58p7RgcNIoAL0oK2HyczZAUUy+Dq0yNREoPrzUpjCsKZYqbvbe?=
 =?us-ascii?Q?GmOYPJWwpttsRCHF0z6YmH+yhDHz9YkfReJPzO9ke5/hxPXIKoflnuW3N8YG?=
 =?us-ascii?Q?bjOs3xGgmhsGjvhv7jV7dfurn94dER6edEJc6Csld44selOXDEcY1kPbTxms?=
 =?us-ascii?Q?6uEZhUf/CEiUvL+KU/Jpvl1OA6EskBY8YcJBlAP1OUtV+j7hIf8QxkbXw8FL?=
 =?us-ascii?Q?GQrYCkyqV+PAgfdfM605sumpP4MtOVrb2QWaoyQfd1kyU5scyrcfLorGkOeB?=
 =?us-ascii?Q?KKhKCPNimKw7B0nYtF4qjzMYHH2QkGpAbcFf2ZcVpnFrU8Hl9id5RAKN2360?=
 =?us-ascii?Q?t3fzCB3P1qdik467NGQUJsFUfQqPbZb32qze1H2lFdJXpU2SfDbQ9I15FHsk?=
 =?us-ascii?Q?qDqzOf5we0SG3dn9aRqDegvmQOKsoh5SSAIXeKxwqCxKAZqYDmon3TgF8WHQ?=
 =?us-ascii?Q?xHYw2WAjDeyv7VAb9zWWayy+lU/+cLdmt6OABnhbGrVv2UyfYsl66H2BzvGi?=
 =?us-ascii?Q?z5yJNXSXbnOeQg79eTjgRNSjmtb/jHmKLMKdDZ8UDJ4BYCJ1JaYXmTrPNvJd?=
 =?us-ascii?Q?Cm1okaxiOiG1PMxt99cQNDrwy5gFqBRcKV7vJ5afp+rJkPHX8hpZDpfdkuMz?=
 =?us-ascii?Q?VwXFrjG/Myp6Q+KsZJus1tu1DB6fYG42O7Ywym3frtyMema5lAS+f2INiioG?=
 =?us-ascii?Q?frifjBCpUSdkwfT5EcgHNlcyEVeKfOq8OhUo0meJAFtib/mH0acnT+1aFAoy?=
 =?us-ascii?Q?WBlMbRucN3g62acf507Zyb0mZfpVgw7ezcqxUru/qdXzVqQhtyfOBnFYQn24?=
 =?us-ascii?Q?DprDGEZSFg6RfMpl/YCqTdX14+1vvkcHukb0WSDYVHM5pZhK6MRW34HdBV+V?=
 =?us-ascii?Q?6UH1J8r4Kkq/5As=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:27:00.6250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6325633e-8a3c-4a02-2655-08dd5cf5a1d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475

From: Jiri Pirko <jiri@nvidia.com>

Firmware version query is supported on the PFs. Due to this
following kernel warning log is observed:

[  188.590344] mlx5_core 0000:08:00.2: mlx5_fw_version_query:816:(pid 1453): fw query isn't supported by the FW

Fix it by restricting the query and devlink info to the PF.

Fixes: 8338d9378895 ("net/mlx5: Added devlink info callback")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..a2cf3e79693d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -46,6 +46,9 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	u32 running_fw, stored_fw;
 	int err;
 
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
 	err = devlink_info_version_fixed_put(req, "fw.psid", dev->board_id);
 	if (err)
 		return err;
-- 
2.45.0


