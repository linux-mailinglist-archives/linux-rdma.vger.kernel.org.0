Return-Path: <linux-rdma+bounces-7706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA8A33B8C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255E5188AD75
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F7211A07;
	Thu, 13 Feb 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GG1jFtVt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF8211468;
	Thu, 13 Feb 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440062; cv=fail; b=mVWApnW6g8mLWnLMA/gsKGq0UXExlLjZ/OjtW8VpFUHaqo0qITZCH1X9SDcfASXzkJ4TGw9gHLsD0iMURiJ05tnzmlVy4nyM7kIEZqkb4SCIXRgqLfTxqi7p3p3nu0DGZgGx2Rgf6vHE5+qtHGCYGGeyDrFafPLuaWl0Trd8U0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440062; c=relaxed/simple;
	bh=FKG7InIs2ZUMpYYi59x0vFJ2xwpyT+Lepq6JgFgcetc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fg9rlmFf050XEYeMnAJAioVi6J6YJG6+dqO9YFaJ4Nbp6Rfe3UOj5j2Vr8ssZ/fO+aWySCydF23wDLoZS9IYUQkavyE3vA5wp2rUlYH7JrD/atw5AnAzYO0uvg/RLXEFYz31ZCOj2CxTHHGomkYJjAuq28VcmM71pnCuT8+tNjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GG1jFtVt; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9My4Fv/r/OLuYBHnP0JmYbM2Yoqw7/5Y+duBEbIk8po7RWada2HNnQg1UpADHwncqdDyg9JTGsIQgswBZZ/v5upFv3qWAlcKjkd4321hhuIq241KwLrgzDp7IGTXwHKezNQ4YOPee/6A3LROFXhcr9VLFl/PlZcTPzDgAEdNpUAEu/v0sTWmeX/1db+lGjvLsVVI743kmKVk5O7byAcSQ8Td83JaZolYdSal1SSOdcl0ytEH06GuoUcZZBfs+LYoYgam4ooiCF6pyNSRWvfeGo317z17nTohspo9SdMRq8tBDx+0FoCzHMqzAfd8/eJglZadD74GaVn/7gQw3bqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXTDt/Bd+ukODSiY+1VnI5b+T11S06mTbgCc2Ypw7Pk=;
 b=UGxLufi3Ov7xHBt1EhEGVRi/fa18tOUzTIJ8zaYiPZiZZDbtZIxq2SP4oEtvogvZ8YtNpxDQxMeK6JYDnoHZUyJM76eaOLXK/aD9H60hrMBRj2RiTw1ExejiJYg3qs41I9ZQAW3BnR2fliSrO1+Ch0BwNwnPEl2JgDqhyvnvU+WC0YrE3JPKg09EbllQz9wa2yHzDq1nuDK6BUfCN2yKTNHRrAMlw2MuHKRwpUoavjHjSQyqEl7wy5RJnRn2uw0ntPRK0JG7zwezSkXz7llpjOHGWwFCDw4h4Tdqq/eDhWb+8GWIP0TjdJ4s4VkrRfbnArKGTraCPCj5oBPJdr8gKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXTDt/Bd+ukODSiY+1VnI5b+T11S06mTbgCc2Ypw7Pk=;
 b=GG1jFtVtjgkKsGhj7nyQiNB89HuD8j/4Mibi8zSuHXKB1fCBSB4Ml80LAhldJ8VGuWpEUqG4NL7yppnVF/VvD+7iFUwODg1yVcv3lWxrhMOD5XM2Ya5N4bC9fie8KICJtUA988vTfKPbbBLsxtr4f6r+14VX31PJyu/aqRHrsWTVodVg61+WkjI0ThVXFvA2AA/XLjHFJue0+G3NpffUsTgUz+mOtRHLTsb8k8Q62DufdOK9Qb7cCUlkbx+iFzb/U6dZvak9YBQIiKXJ1nnyrbuTb7VHdXAK5xk3sk+SRX5fK25fT5VdtZVIkeH7jgSy64mFHXVrSFxhTLs4o/g/EA==
Received: from BYAPR07CA0012.namprd07.prod.outlook.com (2603:10b6:a02:bc::25)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 09:47:36 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::63) by BYAPR07CA0012.outlook.office365.com
 (2603:10b6:a02:bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 09:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:47:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 01:47:23 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 01:47:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 01:47:20 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] mlx5: Add sensor name in temperature message
Date: Thu, 13 Feb 2025 11:46:37 +0200
Message-ID: <20250213094641.226501-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 38558185-3c56-4325-6c81-08dd4c137201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5iVMn7kQLdGhmnIzAc2DMvuRxPm5aH9OoKTOWoXxaSPgjMbOSGUPHlp0oi9?=
 =?us-ascii?Q?wnG/PI6V7EUX3Fs0LKHcHbx+c6wSkkKkKOBlj41k//A99i8K+yfg2gonYSZL?=
 =?us-ascii?Q?PAZ/FQM52peHcn+qvule6lya5h0Y2KaRz9LugoJJvHV6KIKp1AkDyrccPVEH?=
 =?us-ascii?Q?d/KdbQRx7sAoMgMgqstzv+HIe/uo99AM5twZVlU7qVZdrYUv4zgdjlmsjWnS?=
 =?us-ascii?Q?yGQ7qK2/d+w/UfieDcXa7/gAf1DwFQvjfB12e/nQOdR7LgbWBoSQuh/aXCKD?=
 =?us-ascii?Q?Znpb2deQ6lBRSy/pqfu6PkPKs+edjTbBVkAzzW5PGN1You9wQGcw876X+dpE?=
 =?us-ascii?Q?3OwuqQRAaUXx5R7IeT7bZeh1ajzgJTri3UJ4g54J4TH8t8HjBTomnYaFz1XS?=
 =?us-ascii?Q?q/UoBXbzfUOKU26a95A8Dh36FfPeYOsq15RHto8B7a9+W2/cVZu36hCxwSLv?=
 =?us-ascii?Q?d7SiQNdL+tojqglYRQ8UgSwyvoBQBjzIlkiayXSAz5MQpToV9P9Tom9nSFTc?=
 =?us-ascii?Q?DZ+cznxsCVaSdlCOiLbeCkvBNvyuTeCikV1Ls5JpboVVfYXf3EVsMq+FRnbY?=
 =?us-ascii?Q?LTj1q0IhZIhc+cKX8VSzBfNjDfwNv2x8P0xqVwAvFjeMEkLDyF+nVp1rk4U2?=
 =?us-ascii?Q?bXY/V32CTcX/V46+P+npJwPxLE1xsc3UtzfseKd3P0M2A04kI4aepHhUC/Lf?=
 =?us-ascii?Q?zsyf97v2fEnUXP2UEUxeLGX3HCL93OHVxXwFEGpbG2t0v8vKF5QUeTIABSAV?=
 =?us-ascii?Q?nX3LhgiRs30F/bpIzac2+IEawCxj/DGI2fKVcZ+xsoJWcZv43AkJjqDv5keL?=
 =?us-ascii?Q?IHwAB2idG6oL+EpSp/pR03UOilWLusz0Fk0JBqCotoKcXv32+QR1vQp0V6Fi?=
 =?us-ascii?Q?fTIMqn/G7a/SXYvKgK0HG8WWT/Km6WUGNQfV3lTMISJegw0Z47f7mizMrVuL?=
 =?us-ascii?Q?tXykcryXBG8E7POxY8Ncd1wof7PF2weyy51LoKzqHJGIK4Qch98i6nSZulWy?=
 =?us-ascii?Q?MZ0tHoaTvdD2h5fdwhF1uBFo770Kew8Rfe6NFguQnYCxwh4J1sn1gBUyzLB/?=
 =?us-ascii?Q?5dvPFMHKjWR1TBrEIxrXUdfT4GGKvTbs6aRbGZBGLhJK5sEGWd42FMpDsXOH?=
 =?us-ascii?Q?+RyksUusHEVpPuf22ARdjcn7qe2/fXKMzhjUT71P/ohY98cK/JBagQV0RrL+?=
 =?us-ascii?Q?RdKPlE0BUXZG1PxZ21FviaVKW/P4OOuREZoEaM6+YqG8cvtrJwbD2O3frVRA?=
 =?us-ascii?Q?aCnihqkpfjnDuRTT+T7LCc0XEcPhNEFOSp1UMvnDDQmTFpr5O531npRbSdfQ?=
 =?us-ascii?Q?qKJ4qxDKRLUPkJZ12bs2ggglJjN3JFcIzm9BOGyitASQV8bvUj/UqtC9PyLj?=
 =?us-ascii?Q?eXKa19AmrxNzaQnBXm2acyvMgdCjgMxSEU0IpwcgUiRhFpwlNSLUV7J//nwC?=
 =?us-ascii?Q?KeHYurpe2LdvIiPFX/jTP9NeBkLejim8WoRdiYHFKwaHX1jkVJ3AEj/MMPGd?=
 =?us-ascii?Q?lG6zv9GVO5PT6So=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:47:35.7107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38558185-3c56-4325-6c81-08dd4c137201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

Hi,

This small series from Shahar adds the sensors names to the temperature
event messages, in addition to the existing bitmap indicators.
This improves human readability.

Series starts with simple refactoring and modifications. The top patch
adds the sensors names.

Regards,
Tariq

Shahar Shitrit (4):
  net/mlx5: Apply rate-limiting to high temperature warning
  net/mlx5: Prefix temperature event bitmap with '0x' for clarity
  net/mlx5: Modify LSB bitmask in temperature event to include only the
    first bit
  net/mlx5: Add sensor name to temperature event message

 .../net/ethernet/mellanox/mlx5/core/events.c  | 36 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/hwmon.c   |  5 +++
 .../net/ethernet/mellanox/mlx5/core/hwmon.h   |  1 +
 3 files changed, 39 insertions(+), 3 deletions(-)


base-commit: 8dbf0c7556454b52af91bae305ca71500c31495c
-- 
2.45.0


