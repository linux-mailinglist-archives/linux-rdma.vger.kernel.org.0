Return-Path: <linux-rdma+bounces-15082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2ECCCB07
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2773A307A593
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38758366DAC;
	Thu, 18 Dec 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+45g0qF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D87366572;
	Thu, 18 Dec 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073547; cv=fail; b=iz1OEQxQmq4l+0vH5uXPQrd638ozZ7JPm9TuDTxoPcP3HB0o/U+zTD0rR0+Cftq/+daN/3oI8RkkYB5GtiPW/UOHteuWXX8wAeCZS379Fwt93zaUWe9dl//GOtDOSfbiaw15u0RXxyVa1zkuz02/g/8hgWpOkdHVkWBN8wK59rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073547; c=relaxed/simple;
	bh=/wlKTOehVOekuGkhOv4tqQQjjf+qAa4Zu86XEkb6ph8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/5H+zPcZmQMBfMWXbaJSDWbaDm58JnrSP9EQTiSFJ0F0TjKR0sbdvnldjOR43BX3N9SbTTXuQ15hxlCWKvRYwgMTawd6YDO6P277ImHiSsi0rke22txapchN6d8N+/lSi7RBMxTmE2KNUDgm4udUzmTSE5lXMVVg9z4W8Ua5Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+45g0qF; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2l+lKG0SeVgcQB6pQTwQ4ovUoFq98qeV0BCNfzntv+QZFr9BAF+gvx28KzwdinV7rE4L4AZbWDOgSNZ3JXXdhmTuEQHWRmMyBhGXa7glEUOhq9yjNgs36GsHIXuEx73Z1sSp+d8XulVobwrXVjid48VJzAEUygvr0UIWQnZzzBWV8TY2ZIt/hccfR8B58sMlZM1dUaxTp1EbzxRK7GdoMvIOk4e42W7EPY0M4X2TThUa8UGRuzn6BcHZRDpxpobZ3og8QzDMsVNH3RpPSx67P1p34pBE3ejz7u60OCP8Y6YfSL3Vdc2Ycx6aaJl/TrAhRZCWeUq1+2MKddOK9M/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XD+0JjbisXfPSJhTUBaLQIdpJ3tSBDX09a/uKf9nls=;
 b=QTyMIq/lIhEKSMbAY2QxxGiG6DJh0PEqd87ewl5ynxJZ7nU+ZS5ONdCWrjYWGxfLr2AnIGso51qGgdSKqmtMCLb2QByXCDqhBmIjAc4Dy6YZLObeIKJNZE8jTf68RSg9MPB8Lx3VDV+5y2Dg+3uTBpDwfzYWThFYHbNeBeLczVqgDYvzpHcxYTtDO8xHSUQ6KxT7iEW003cMhMP1y5GzncQVMfIn0Da7U874yxkGXywDF8Nj9bj0QSDFMRAiqeK6fTaqrCGGoGo8DJP5Ls9keFzIYVtAXTkeK983jTKKrXqu9g6dA6anyUKWbe0RE3dEnciwUN8C167l8HgvAhQTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XD+0JjbisXfPSJhTUBaLQIdpJ3tSBDX09a/uKf9nls=;
 b=G+45g0qFf416BoXY0zqPiExn2Ejql3HkekpPk1wqSkbW+f2Yz78hW4zibVFJcgD5r10EK6eSUyCiUVfNLwQjpkKJZxZChT9Lr5Zj0mTb9Co3yKmkCcr2h2SMwvUVbK3CNjHWTDe5w5ewrUVcRA7fC4nE7LCTEUYIidNA1sc2Jzhg+Lk58xa82qPwRq26iR/Tc/XzVd9GyUjdS74hgn/bq5siUnu2nPuLfFLUyGRTQ4hhxO+h9i2IQ714pn0qbFfsRi21WJmLs3JUYk7bXSXaHgiiqqHFJJDyKSjZq5EVOLB+VqvyOmfoLs8lJDtiF1VWUctHThJa5rRjdzLYfs4OWA==
Received: from BYAPR11CA0079.namprd11.prod.outlook.com (2603:10b6:a03:f4::20)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.8; Thu, 18 Dec 2025 15:59:02 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::f4) by BYAPR11CA0079.outlook.office365.com
 (2603:10b6:a03:f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:59:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 07:58:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 07:58:41 -0800
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
Subject: [PATCH rdma-next 07/10] IB/core: Refactor rate_show to use ib_port_attr_to_rate()
Date: Thu, 18 Dec 2025 17:58:40 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-7-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=2446; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=Md6wwD2353IEpn8JKq+dnoNCt45o17nRbOe4CnJ9/OI=; b=ENmc5pduIuIJyUri3JpOEaXXBPiKT6pU1aAwcwnxMv4DaG3O0LkdCpy+3cPqlqqbFRi7MbFBf 6DVHOsJ4PvAC+AngZUAE0TbPbCIy4R4Iw37dd3958alj8v+3wrjoEO/
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: e72a5f4d-d642-4408-e5e7-08de3e4e5cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnhSNXJvUXlVZ04xUmJvOC9zSlBhT3pENUpyU2tGZ3E3WlUzR2liM2tLd2lN?=
 =?utf-8?B?cXdvR2FZR2w4RTI5Ni9tMnhMNUZueExlOWtvMlgvK1NoQXZoQ1VpMWh3WE9q?=
 =?utf-8?B?M2RVYjJIV1pLOXE5VXNHYjFQMDR3c2hKREFkcWRPM0g3L1RNTlNSbEswdlJ0?=
 =?utf-8?B?TDdhd2R3MjRyZExSTGpzM21kWVRUYnNwNFM5a0hmRFpJT1k4NTlDMFN6UW1l?=
 =?utf-8?B?TjVrMzNIUlR6bmhFZHlieWxwclZLczJOYVdZelFSeXEyYm8vc3UrZm8yNmFt?=
 =?utf-8?B?bDRUcEkwTUx5MHNQUFoyTHo3YWRlcGo0NzRQN0NHbjRLSUpIZCswYUprUUJz?=
 =?utf-8?B?eHVrRGc1cnJ1WS9XZjNqcU85eG5ZVWc1bzR2a3YvYmIxZjNjN3NjUUhIcnNa?=
 =?utf-8?B?dHNkeHFVRTNlVG95cllJM3BZa1hZQlFhSDNrZ0R3MVBMakRDbmdiWTlVWnha?=
 =?utf-8?B?YnZKVlk1bFpZdUpFcU90ZjlJK29WTTNncUpQbmhwN2ZNY1p2NU5NMWp3bHor?=
 =?utf-8?B?YWJ0SE5wdElxVjV3Z1ErYUxhVjZMajBkdTcwcWw0czFmVHNYeEEyWEo1Mzhn?=
 =?utf-8?B?TEIza0FGbnlocUpTeVVlRmNoOXFsTE5Ta3VXTW4zNjBBa1VtcTN4WGhYcDBP?=
 =?utf-8?B?TXJLWXBWUmZoMS96Wm9ScUE3TmdiRnl5TlVSUFpEMFRuVjlRWUFmWXlRMUg3?=
 =?utf-8?B?Z0o2UGpXMTczNVBZQklhN0ltRlk5LzRmS1VuSVczbHkrSkJ1V0lsZ3ZnbTZl?=
 =?utf-8?B?d0JFMmd3QTFCVWRBQVJLNWRXRFhjR0Z4clNPd2JVVkJ4a2h1YkJySlJUYlcw?=
 =?utf-8?B?bVRoeWdQQXA5dWpqOFdZKy9UaXZOTHNxc0ZzOTJ2NTRmQlV1VW1wQXpaSk1I?=
 =?utf-8?B?ajlGQi9OS296dUwwcUhzcGNUYUtvZE96emZWeXhjbDkvcTREZWNTZ09XaFRa?=
 =?utf-8?B?TVFSRFZmc0NFYmlRaGwyOVJYL0k0ZFQvTUptVkNPSjZ4MXJyVHFIM1UxWG1y?=
 =?utf-8?B?djVuVlYvaVpMT2lzbUNYd1VmZ1ViRnZnblVxV1ZFeVZhSUtkSXRDcjBjc3Np?=
 =?utf-8?B?NWQrNTdVbUZlbFZvOTM3SVptUlZqV0dWanhuWS9lQTYyc3IwOGZHck9iNjY2?=
 =?utf-8?B?N0lEQUk1Tmp5T3htZ2lqR2RWV2dUT205QVU3K05iUThGYkc3Umx6eGZBZU13?=
 =?utf-8?B?VDJBc1BtVzk3Q0JudGRmQ0hwMVFtQ1ZjZEsxS2p4ZWNLOWZXdzJiWjB2bk0y?=
 =?utf-8?B?SWwzM0Z2M3ZVVjA4ZERjdjI4eHlOWStnTHJXTkRYVkUvT0xyUFJvRTRJOGdq?=
 =?utf-8?B?WXVuNVAxQ09qSnFwOFdzdTBYMllRNXhIYzJOZ3pUTU56dXgzVjFHZVFBSWRT?=
 =?utf-8?B?TFhwQTFLWFp2Ull6SkNCeFh3eFNkK0RzWXY2UHBNOTY0RUNKTjl2UDc5cFV1?=
 =?utf-8?B?ajVhNE80RDd0T2RIbHJoVlA3Y0ZmUXR3RlRmcWZuNi8vVWMvOXpKOU42WERy?=
 =?utf-8?B?bmwvM1B6enFUU3hJUlZ2cXk4VExQZStsaXU5Ylk0bGZmaHh5dWRtMDUzWi96?=
 =?utf-8?B?VURab2xIY2Q1L0RRVThCZTZ2dTJJbHBTVUhrRGREaEE5ZTBqM2V6QjArKy81?=
 =?utf-8?B?OEI2bHl2eFJpL1ZmTk9KRHIwMTRrWWNJTHVHUE5kamdMeGhIcVNLZzQ5aG1m?=
 =?utf-8?B?dmREWDZlUDQwOGlJNXRCM3VBNDlVRkcrVmY1REJ3WDhFWGZudVUybE9CNENl?=
 =?utf-8?B?TE0xRnoxeUtKT1JkWDVVYkFabndIRWZ1Kyt6bEhwa0Y2YmJZOFRwSk0xMFNi?=
 =?utf-8?B?ay9PMHpoODFsVU4rdWZDbkNtMGMzOVppeFJDRzVxVjlBNng2UnNSQlpjMmVB?=
 =?utf-8?B?U2FZRVgvY2ZUd0tCbDRhQWhGbjJvLzJTb0M5eXpIaTNNRWhPdWJGYUprSG1D?=
 =?utf-8?B?SzcvbTRmK2hFQ3hrYlZVMG5OaHVCRVpzMXcrUy9WSlp3TkxScG1VbEtTbEVa?=
 =?utf-8?B?cFdDMzFGRElFa2VHTXJlM04wU1lWeGdCQ1BqVUsxaFI0U294VTEwcHB4UVU2?=
 =?utf-8?B?SFpybXFxMGw4TVJ4VXJtbHlxWnVUMU5CdXlQR3dkZFdKTkFUeXY5WGhtVncv?=
 =?utf-8?Q?mjbs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:59:01.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72a5f4d-d642-4408-e5e7-08de3e4e5cdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

From: Or Har-Toov <ohartoov@nvidia.com>

Update sysfs rate_show() to rely on ib_port_attr_to_speed_info() for
converting IB port speed and width attributes to data rate and speed
string.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 56 ++++++-----------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 0ed862b38b44..bfaca07933d8 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -292,62 +292,22 @@ static ssize_t cap_mask_show(struct ib_device *ibdev, u32 port_num,
 static ssize_t rate_show(struct ib_device *ibdev, u32 port_num,
 			 struct ib_port_attribute *unused, char *buf)
 {
+	struct ib_port_speed_info speed_info;
 	struct ib_port_attr attr;
-	char *speed = "";
-	int rate;		/* in deci-Gb/sec */
 	ssize_t ret;
 
 	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
-	switch (attr.active_speed) {
-	case IB_SPEED_DDR:
-		speed = " DDR";
-		rate = 50;
-		break;
-	case IB_SPEED_QDR:
-		speed = " QDR";
-		rate = 100;
-		break;
-	case IB_SPEED_FDR10:
-		speed = " FDR10";
-		rate = 100;
-		break;
-	case IB_SPEED_FDR:
-		speed = " FDR";
-		rate = 140;
-		break;
-	case IB_SPEED_EDR:
-		speed = " EDR";
-		rate = 250;
-		break;
-	case IB_SPEED_HDR:
-		speed = " HDR";
-		rate = 500;
-		break;
-	case IB_SPEED_NDR:
-		speed = " NDR";
-		rate = 1000;
-		break;
-	case IB_SPEED_XDR:
-		speed = " XDR";
-		rate = 2000;
-		break;
-	case IB_SPEED_SDR:
-	default:		/* default to SDR for invalid rates */
-		speed = " SDR";
-		rate = 25;
-		break;
-	}
-
-	rate *= ib_width_enum_to_int(attr.active_width);
-	if (rate < 0)
-		return -EINVAL;
+	ret = ib_port_attr_to_speed_info(&attr, &speed_info);
+	if (ret)
+		return ret;
 
-	return sysfs_emit(buf, "%d%s Gb/sec (%dX%s)\n", rate / 10,
-			  rate % 10 ? ".5" : "",
-			  ib_width_enum_to_int(attr.active_width), speed);
+	return sysfs_emit(buf, "%d%s Gb/sec (%dX%s)\n", speed_info.rate / 10,
+			  speed_info.rate % 10 ? ".5" : "",
+			  ib_width_enum_to_int(attr.active_width),
+			  speed_info.str);
 }
 
 static const char *phys_state_to_str(enum ib_port_phys_state phys_state)

-- 
2.47.1


