Return-Path: <linux-rdma+bounces-4836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4954972119
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1445AB2244B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A71891C0;
	Mon,  9 Sep 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnxxaOhK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B417E010
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903076; cv=fail; b=ZkUnXCHzuEg0y7PUzt5LaZRqBmdnpufuy0alQWNR5sphYYMENXmm2skIduiX4TfBj/LP0NwAh4wGdiAlXSTCgmYdWokuUkAHUe8KNQ6rA3gN56AKoNNj6DD8N11povH5il+dy0Tp5YA6/c9cYBzVAic3kSmwNxn+ij3vtPsxHrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903076; c=relaxed/simple;
	bh=E/UZ+SjKKOxBRCS0EvOUdXE6BA0cZu3zPMkBLOagI9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJYvOYtNPOqHhY16JTeCJqLIli/v7hM/vrTSklyrVrPWM9plod2kjqoXF6eeIV/VE/sJTD4sBlKWAlx/8nv5nEq61h7dgWiwmpqvk9/xbgK4Iqp64zl2y160XLTogBu6p34FNzEHPSJBtWYNziN5CLpaS11mlUXBbtdwBPEEywc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnxxaOhK; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnzwzskwUxSEjJTX5OQZ14OGLPLr3RWE0f1Ry9HCvR+jbKNumIpW+hNQc0bPDyuU61ZNOcJYkG/Sfd2yu9Lbvdrh2vOCCAUIbVu0TrNbuIyfX5CnP+cRcne4hZ+WP0G3bxrXuYZ2b5DDmtsQ87qhgLMNMNtItMAJfySMfpoWAMuQozZKZwzVhDIfhzpQNSWrNT+flp5mwJn2vnVI6jRehIU701BEMjTdXNE0jynUbMbInaOGvi9Uxcs77viN9SKyWiY9630pwT5psDD88PQqOLkntzeb5oYCB8qhdFbeY/VBukZGJ5gVvMr/cWmovRFVsrTG5d6TBJfdf0ty379JIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L6o0Xb8vdDzQOVm+4hNgsraing69YLMZpPhm5ff2qg=;
 b=MJkMyp+9947LXMCkqTzS1xwe8Zyb/h8a3x5YaP/EZHD6dRrOtEWu2od0BR4v5kBJxhjDiZ/KZqZiMiv5GJHVXNIxtjuV+m9tQZX8jSVxwm4i0GMiUIJmys1TtAlJ+0/5iTyTO+DoGXEShIXlSdemMtFpNBzvRidKjXY0ITWa36+FDuIzImJ5ij3SO/iQn5ROhQxIp7doU5vwOJbKxxiJPBH33Nh2Cso6DENEXCjDhMVMLxUwXayaStjRaQWfEVvxdofk0ZtGmm6o4n3D1dHbxgU/iBeqb2vnkUdHjespXsBoc4bylP/X0LAWbqz0GNeOfJgqMrXgG99K+8TSEXrzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L6o0Xb8vdDzQOVm+4hNgsraing69YLMZpPhm5ff2qg=;
 b=dnxxaOhKafB59vPNUuR6qvz43N8KjOWh+0aOhCW5CwDpyVTe/Q8n+01jYZ6q5b/WJkBdRMGHFeTL/1tKmKmavANhw743LmdAgEUl4hf41aftWUKjCxfp22TMwBshqPN/5rutKLwrRwDQnet6Ydv1+PFnMjXOshIp1r4hc6bPfxrrV3r232SkF93cWEisy1k9sDnmEjXkcQ9Piu0+vESriaxb+nwfMbOeKvhdGXtiK/Sl2ZowdmG9DBpaFErxMtsL6xNXvtgSw9/8aLKsfwoGe0iY6RyzjRrHVGMUF1u6V/rtfnAi0Ktsa7qqhQlykKB2uLC2s0SD1LHHEOBneQxTQg==
Received: from BL1PR13CA0309.namprd13.prod.outlook.com (2603:10b6:208:2c1::14)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 17:31:08 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::f0) by BL1PR13CA0309.outlook.office365.com
 (2603:10b6:208:2c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:43 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:41 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 4/7] RDMA/device: Remove optimization in ib_device_get_netdev()
Date: Mon, 9 Sep 2024 20:30:22 +0300
Message-ID: <20240909173025.30422-5-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae55b81-c7f6-4ecd-af17-08dcd0f53051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EhR1Q5AzaPLkRUMtEQ4lQlpSpN497KhOleHTV/1+5s06TBSSUQKkBeGqTuS0?=
 =?us-ascii?Q?1nm/PBTdhVCYK69AiFgFYTwjXKkQ1c7fEBoWJfSWH/BXesxw5COz0HjGaHDU?=
 =?us-ascii?Q?ZlUOt3gPrVx5dCy/BB3gOhYivQSp3uVo7vFzivUomPTAczVPKSkaANmyVYzF?=
 =?us-ascii?Q?ze4n73rb2NFlwxOdj0bB34XUVdgSZQPYXxkYSsodSD6UkWuC6G0q5bk7EDCa?=
 =?us-ascii?Q?JwBZuxjWb8K5Emg6rulNp1IgAwe4lA7VpMBC1o7I2IzZF4j8CvhQMk4rpD5E?=
 =?us-ascii?Q?dc2kuKPUN29X4663URHjJDUFI8BwFdDq+HEhRaOviBCABxu2dbj6U1WQZBfi?=
 =?us-ascii?Q?6nRb7DTPXfMLvNPmWQH/9iLWrEaEshB/jWmf6DivfBzCZKXwF79arfaJzFbx?=
 =?us-ascii?Q?OxvIOgvW6TeE2zzX6ABrimmbYhxIRG1NkGcMwVKZhzUb08dq+8cf9/qfi05n?=
 =?us-ascii?Q?5rfUujgOFXeSdS9MHjIPZvAOly6LiySiBi1exXkt1aP6XgbXHwz7rkvSegNq?=
 =?us-ascii?Q?k+ZEU5/XgEK28aMTlUUsx3vk7LbP2hPpXKTSlJeKOhI95yElJCxc1s2ZokzL?=
 =?us-ascii?Q?Lp3k9ibnIB8RdSIK3BMtXImiMZMorRI/9QBjHnakQuCzYiQh2SMu1n0gV88q?=
 =?us-ascii?Q?TWK0y5BPNzrDdo8VorYSzQBt2cNq0/Z27MUHXutvQCsZa1LSwBAmNa+QYdqG?=
 =?us-ascii?Q?ljYfZz072cZutu7PjqUEf6sj1o2SvpI5n02ba6o+TSuMa5JPjtm+FU8kD0s5?=
 =?us-ascii?Q?pHGC7kPX+rGnQocDRNbrnSp7egTampYeYOx83PGO96S4IgykVAU4BFUVBgwg?=
 =?us-ascii?Q?GF5qpgQt1QlDuqqtnSyv8rUrGnliF8WIRdW0nbHYyoPDS8a1EIMP1ZyOpmrS?=
 =?us-ascii?Q?fG9aI3f6GacZQdj/F0ptgv30iIt7KU04eF95klvNEYrhv8RvXBKNgwcMs+Li?=
 =?us-ascii?Q?uhs2iTkg2xVjjz+56pZveb0nykSCYAVkg9Bt+aYSy1499+M6ZKoLpKio4VTd?=
 =?us-ascii?Q?ooVZzNrcsXQzrkwb1dltIHmktOGzCPLubA+ZAN8n75wXGuUo3eOVBFIMWe/w?=
 =?us-ascii?Q?idcebugqCIj/5krcAGqbPcxGUomBIuA6FQLfGqWIbp6qrq+r6n9Hra7vYtRE?=
 =?us-ascii?Q?ysEFjO7AIFyUSyEhli/Aw9ZZa4px0Bs8+TrSNaiyJew07XD3LKXG7gHl6yqa?=
 =?us-ascii?Q?Ggzs1k4xBiqFVOW30iNSfoBClCNxQzqJRo9O8eiKXUi1Qky3RtutnDg9Fr6F?=
 =?us-ascii?Q?r36ZPQlN0EetZHZdNCi6kZHo52zWGKkz2BS2repAoqZlguxZChgCB7Hk4IrD?=
 =?us-ascii?Q?jfrcyxf0dCOMSZCSCtH5JRoiZuS5Yr2YD4wbEioah74z6U25YLJO6sQf5FLj?=
 =?us-ascii?Q?89ZYODApH5LZu4k6CAhLJxNILtK158Ltr+sVYpXGQIQ76mt45sfbJ6c7M30Z?=
 =?us-ascii?Q?9PsW6BFTNUOXpoHr9covIQ0gsDZib8lJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:07.3804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae55b81-c7f6-4ecd-af17-08dcd0f53051
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

From: Chiara Meiohas <cmeiohas@nvidia.com>

The caller of ib_device_get_netdev() relies on its result to accurately
match a given netdev with the ib device associated netdev.

ib_device_get_netdev returns NULL when the IB device associated
netdev is unregistering, preventing the caller of matching netdevs properly.

Thus, remove this optimization and return the netdev even if
it is undergoing unregistration, allowing matching by the caller.

This change ensures proper netdev matching and reference count handling
by the caller of ib_device_get_netdev/ib_device_set_netdev API.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0290aca18d26..b1377503cb9d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2252,15 +2252,6 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 		spin_unlock(&pdata->netdev_lock);
 	}
 
-	/*
-	 * If we are starting to unregister expedite things by preventing
-	 * propagation of an unregistering netdev.
-	 */
-	if (res && res->reg_state != NETREG_REGISTERED) {
-		dev_put(res);
-		return NULL;
-	}
-
 	return res;
 }
 
-- 
2.17.2


