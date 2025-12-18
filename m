Return-Path: <linux-rdma+bounces-15085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E443ECCCA6B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3343305BEDE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA8369231;
	Thu, 18 Dec 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="daQhEoER"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878E364E80;
	Thu, 18 Dec 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073561; cv=fail; b=NgYN6ha6zNlOim8jT734IGF4nUywvV15mwENuVCSaCR1pkn9RHkEWjNPOgpWPjO1DqNZ95DSyfyNDTOLluojGm5Huz7aA0E+vA/TjnJmPogMdBogpjZD6RVrKqVfdxBZzwi+Tq4aerWhA4BApaC568OcAZmQQOlwTGTCDH8tlY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073561; c=relaxed/simple;
	bh=0/cYhx10Gd83iNVjMB6oWWjKRwV1BNfBteIHDo6qEW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz/oJNoBjrZuyjrwJccnYogVyw8GzBbNnJzelpCjI2r+7nvS/LHaGOyiZm6WMulp+E/NSCGKuQyhK8BBQUNw48Be1+I7YRhMNFx2X6XXk1qHIEfkKDffj8aGRF8aFtooWlTGD59SKjhudVQ4CL/miFJUYoXwPZSaZ3uOIBjXWEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=daQhEoER; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fF8LJKt0Gwqf22o//hzHTG8Nww9ksOOHIn8NNiXJdMVuSXNDvHm57lpUHDsHMiOYMjlzaPHFDlu68gQbGNbLU/Zs/D/wz/PypstapY0Xtl6/TAfaMRUjOzURNqneAT5rsRuRzLa5AAZwXfMYuNM+6gh1oo9uYghW3YhfDhDhWEFw1bwgqLriw3UEek2+kEKbjWo6scX/hfjjGVrlDd15ItaGH/IwI51zr1em3s9zBV4ju3tNhCxEAHEPZl5+22V7NIMpEJC3SOHe0i9bCI49vFzKm13ke3ViMQ0bp4cFyzER31uJaKu705UmQSDZiSWrQt0+Tw1iDkeh1Hz3MRFLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiSo2Nx2YCkLaiPBb4KJ/I7hdOOAdVE8e5Js9isFYIs=;
 b=O/3vOEMm8MOAkHD2bgVjeCsKHA8ghan1OZ+NbMGgbbzgc9/2TBfPuryI0+MBZp7MK8gnj1Y0GZRanTi3u1LcgRky/qG635V6RvaaE2uSceINn+AWn/j7M7/8/wr8KSHkWELeUlD6TtZkrHdNPny/3FKKgdEmG7gt71BnDszQjkwsO0DgFFEPkkJhhHm6Wc3eeDV9x0KbkIuhCHz+W9XHDP4qTlGHQqQrUM4FXxeSrAZfNtievhTQvLx9oWJWAVo/wv/M4rVvd4/d1kzwMca6A6wuIfLfigxidajIBSDVCTQatFlDYmuMfJVfqlBnzZy0LNn27agnzSXynnlNrN4tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiSo2Nx2YCkLaiPBb4KJ/I7hdOOAdVE8e5Js9isFYIs=;
 b=daQhEoERlKPyem71k3/yxBN6qz63/TzVZ3IWF4HEgW3xV7hfsHGO4CWoEFYZX2Shai+KADoBv1asmVNzxV6gzlkRgy3UXKMv0DjOpnmN9PWoDpXafcMS1IcHktqZ/5xIDHmJq1mHDSJdq+wPE/CLIK1n4/2CIj6MKfB/oWLvYRg8SmH+6Bt8tt76LcVEWiiRaGq6E/DEWYsJfdHiyouaW+bD6gl3AfSI+//PCBsdJT2/I5o+1ybSIHVlXyBO2Sn3LZ4NtjIQq+K5cCTw63RW768oqVOtzjo8b441KHOxxWnpRF0d6Y4aGb/vikoMgk/bz/vfTCajS+UEbZxY+uk+lg==
Received: from SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:59:13 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::fb) by SJ0PR05CA0064.outlook.office365.com
 (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 15:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:59:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 07:58:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 07:58:54 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 09/10] RDMA/mlx5: Raise async event on device speed change
Date: Thu, 18 Dec 2025 17:58:53 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-9-7d8ed4368bea@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=1432; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=h5wZW1LI1kWmTGlwtXPO+VEysmFaSQ5nBUeqft/eCio=; b=BSSxujtTgcHm+t59ewdX32GQaVWakv6mtB5FTnbdx5v8Kn3t04uu9SCK0TEaOrIj+P0CQ6mux ljOCMXa63eLDhGV58+Z+5BHoXNcVVGO80WwfUSKVT5fxkwFmAk6Cbrq
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fb7987-3717-4bf6-13a4-08de3e4e63b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FtcEpVRkJDSHJtaWV3NmtweUtpN1hqdi9KUjFlWXkvWXBLWFI2Q1VqbHFs?=
 =?utf-8?B?U2RTeURvRVBhOFVvTUdLT2tjV2NpazUyWnRVeEhiaDl5QWZMVEZmK1J3OFY3?=
 =?utf-8?B?UWJwZnQ1eE1ZTmtabGJiMWZWZDdqTFNiWjR2UVR4V1BHL292UnRvbVVsTFph?=
 =?utf-8?B?cEJjb3BsMVJVbjhhMDVxU2N0cENCaTVHRmEwS1E4bVlNMWl5QmQ1dmhNeFpS?=
 =?utf-8?B?T0d4cXpQM01jRnlJcmJpcmk1M0lpaWVtWjE2NzFoam90NFA2Zm9jLzk1b1VR?=
 =?utf-8?B?Vm5LaWZrUi9wek4rZi80d2ptS1c2TjBEWFFSRXJmNndYTEIvMDUreVNZeVQ2?=
 =?utf-8?B?YjYyRGVtbjdvWnJENXRjU3Q3YjdHQ0FkRHFTWG94YTYva3h1V043NWpsN0c0?=
 =?utf-8?B?ZEJzUHJlWkhvNVlJUDY1aFZiNVNIRXJJa21uQm96UmdPeWVoYURKOTVPMVBt?=
 =?utf-8?B?NmVQZjNsbWV4amd0VFpNYS9TWHlXbytNaU0yd0lBMEZKSjl3azZhM3JFNlpP?=
 =?utf-8?B?QjBiMG83R3UvM29FTHBHc0YxQXJzZ1R3V3NxTTJILy96QVdOaDFxQlVlSTRE?=
 =?utf-8?B?emJ4TW5DbmhrSnM1MnAzemNIbThLTUdJQmhaVkk3d0VleWo3cklncmEvUEhy?=
 =?utf-8?B?SkxlbUtyZFU4L01hc1BkN0lEQkFxZU4rTHhVanczYnZidkVuakdLdzcyTC9t?=
 =?utf-8?B?d2FQQUI0cmdKc3FaTk0xaWZLYVBxMkhaaU1rT2RBSElDUzFkNzJhZURnc2dM?=
 =?utf-8?B?NGZlTlJaeGE0UTJFOWRGSkdlV0NLV3Z4Qld2ME8vMmVJZmxVMUIxY05VQUZi?=
 =?utf-8?B?SXJEcWNaYUI4bkVDMTJCSnFjRnpIZWtFMzZuYWJMOXl4VGxBa1UvMzVPNk9o?=
 =?utf-8?B?UDlEQzVPYUlNOEZkSnAzMWNyV290bng5dDZINXlmVWh2YnZZNTM5d2VyK3ZG?=
 =?utf-8?B?anpTZ2JRcVduQzk3RDNSRXpNbEJ2cHVkZlhSd2VxMlFGWk1sN0Fmb0g1ZVBG?=
 =?utf-8?B?Y2FOZ0VDMHJneGUvbzM2Tzk2VXZoeEg4RkhSeGlVTlR0cUdtUlJtUFBQb2cx?=
 =?utf-8?B?UkhwL0piMEV4ZG1jdEhxWEQyY2JvZzhIKzlEbksvSFEwaGNEazVURUFYeFdv?=
 =?utf-8?B?bStldnVxeGFNYituMk5LQ3hFYWxBMjBrUnUxN3d3bkptRnY4bXhqQmVZVlM0?=
 =?utf-8?B?aW1NQjA5NXhDbDI4VlRxUlFJU3QraE9zYVBYbDJiRjVVRkl5UWZQVUE2UUlj?=
 =?utf-8?B?VUdGL3VlSHR3VW02NVhJNkwxOGpoQ3RZeTlRbW1jWnhmeldWUk5LMDV2QzI5?=
 =?utf-8?B?R0o5M3BaaldJb1N3OFg4RHErM0oxTlNOMzJTcVBEbXRzTjRQUm9DbU9NYm51?=
 =?utf-8?B?OHA5LzdJbTZFcGR0d1ZXVzM4SDNINTBoZFNmNjlyMnh3clZUWjRuclFZRngv?=
 =?utf-8?B?VjUvUzBURW4zQVdURDkxd2YyZnk4ZzFBVlpreDVLd0p4N25ZZXVsS04rNTZk?=
 =?utf-8?B?dktRQS9KUVJKOWdLZ055SXhyTlM4WFZndnl2TWhtaFoxVVBKaGhrb0w4eFhW?=
 =?utf-8?B?Q2RwQnBDdmt4dFRLREpnVFV5S3FyOWdycmErUk5hQXQvcEV5a0MzYkF5U3lE?=
 =?utf-8?B?Z1ozOE1URU9uaVdxaktvV1g5K0J4UDN5M2xCSUZnQzN0Sjhram9EWDl1bGZW?=
 =?utf-8?B?aUZYZGYzQy8xV3pYb0txeDlsNHhYZDhjdVc4VUJSZU1GNjM3TEVSMitIT1F4?=
 =?utf-8?B?RmhjazlJd2JVdUZBZi9GRUpBTUoxL0ZlejBhQ0xUUExpS3FIS3ZaamV6V2g3?=
 =?utf-8?B?SUhNeTB2cW5rZnZpdUwyRGRCUHYxZFoyQVVhUXA0VERuTVVKbzFwV1pZalB5?=
 =?utf-8?B?aHBydW84UVlzNUI1Y1JOd2ZxVUxOTGpRaVNDTDdnMWRnUFZKL2R1dGZKdndM?=
 =?utf-8?B?ZTBjSHQ3dnBNRGJvby9qZU1VY3VlY2NGanE5UFVPRkpBOTg5K25ZdDM5T3lr?=
 =?utf-8?B?L2h3WWh3eXN6MnhOT3doazBPVnRYS3VLa2w1WlFTeWpUaDBtMndUeTVIZCtp?=
 =?utf-8?B?VUc2aTArRlA4ci9QZTgzQnNXeWw0VGRORFhsdk5YN3I1MXVOT3VBc2gvMDRY?=
 =?utf-8?Q?7mHlIAuI70iUskx1lHkGwrstf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:59:13.4162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb7987-3717-4bf6-13a4-08de3e4e63b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

From: Or Har-Toov <ohartoov@nvidia.com>

Raise IB_EVENT_DEVICE_SPEED_CHANGE whenever the speed of one of the
device's ports changes. Usually all ports of the device changes
together.

This ensures user applications and upper-layer software are immediately
notified when bandwidth changes, improving traffic management in dynamic
environments. This is especially useful for vports which are part of a
LAG configuration, to know if the effective speed of the LAG was
changed.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 40284bbb45d6..bea42acbeaad 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2838,6 +2838,14 @@ static int handle_port_change(struct mlx5_ib_dev *ibdev, struct mlx5_eqe *eqe,
 	case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
 	case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
 	case MLX5_PORT_CHANGE_SUBTYPE_INITIALIZED:
+		if (ibdev->ib_active) {
+			struct ib_event speed_event = {};
+
+			speed_event.device = &ibdev->ib_dev;
+			speed_event.event = IB_EVENT_DEVICE_SPEED_CHANGE;
+			ib_dispatch_event(&speed_event);
+		}
+
 		/* In RoCE, port up/down events are handled in
 		 * mlx5_netdev_event().
 		 */

-- 
2.47.1


