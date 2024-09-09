Return-Path: <linux-rdma+bounces-4833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A329E972115
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327221F23911
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CBE17AE0C;
	Mon,  9 Sep 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h07oTF4k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E617C205
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903068; cv=fail; b=hnRCm9HMUjA6+fi5D9fugZ2DyRJC1rL1l+ksTe10WCSBDH5oxiVoj1phClCu3C6MkKqHUy1aiVxLE/HZUN3oHD5HsruQgj89fUR49CtQoA291vuHHE3LZje14VMe2CGWiD6ku239tXe1v7c3p5oyM1XtKzUyweTHyuvQvvd09GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903068; c=relaxed/simple;
	bh=EQFkdF98ImVIpiz+D5z6Qiggi1JO6HFXBAoFITwzt6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLTnvsnSeTQ7Q+9uM/JjCIwzJJ7WBJEOLuQRhR1kxIUjsgzrpdu4pi2tQBNpjR53fFJAUNpDuX1zEPi1nbEq6viBSSEvPzfQhBfppafA9w9dsYITzkHCB0o//XcqZbjturVJEXd0GjvEotYvzhqJ3Pxyt9NsSjr69cmVsFSOxe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h07oTF4k; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+LNBJ6E1+fL5nLx7rIFSUcyn/tyZExFx6ndGXPgWIkyk3Q3WrS/LkLHx99zMHXojjCPIdlUh4jq2zB7q4BwgFg1fEjhFN5d0a9L/rkQou4SUD4sHy1mdrkqMwFpTECh2HZTqFsNXskMl+hG2x4GkB2ssmE3RxTdkREv4f28v1hFXA0gAdSpn6EUadbOA+9kk4QYqsAN+vc817bOP8/b0BlhaiRRa2Wu5rlN2tMpDS7FnhRcYg1/UKDkH8tiT+n9KVhIgImtQ+7Bw4+FuwBKYxiZWGdOUS4i0GqqC4Y3lz6sUpx8RUNVNMkmljVvq/L/J8K1J1r3O6v0fsVg6wp2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY+B4Nsuo7WtmAU1ohBNCsMm+kGOeHPENTxEA13abtY=;
 b=B4Uu0+TOmmueQuD9+90XLMLRNOTCU2GxINm9hB7aDBoq8AuXAgd7gAfN5zS6KOQJ7MuNEsO6Mn2xbu8PZMcfRjWglzJtXcvsoiWZGifCzza/ZjBk4qr6cAqzGTWzsEAkRIPRyXCRKef5KEa0/kc2Buv0/f/Kz46vl8Ur5G+kbHhz9bjYDPpFSM6mtR5/C13Sc7L8zTdhdeUf0xuTItEI1YabRCeWwONHlSRyxOkWjeYCRKvjIBHMwke7Z6PNDNjDpo17F18SIDbgy2v0jsaBtEZUy1KTcTJvws4uYvphJ7zPwMTWNEtwMxjbggOye0zW8CaE+PezzdOT88qMTkIy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY+B4Nsuo7WtmAU1ohBNCsMm+kGOeHPENTxEA13abtY=;
 b=h07oTF4ksvgJSRhw9vQJsCUcT25sq7XEpqTGdvII1Fif1Z+r86IX0YVHcmTPSU7gCq8VXeRECNyQn3UfERfuh8YMCjreS6JIvONTHgAOiLIHTn2vsHL4vjXhYLHE1ASXfL94AkwPjKun4DJIBWSHDdRmVdOuOUKxfTdbVJGhxEwCC9boweT4y2U8Cf/3U/FL2g58XD754a7dBNfZ5ep98XfqxfxReB23gJ54QFJAIg6F0yMaTYGeY99xKWzC17JH9iXRTJsNfZ4D/TEHLi1iG7HT01M8Taz6B+jC6X1zG1p6PXzq69iX7sBMI4OrXD9u2LVjWE8YeHvJWJjafeDgxQ==
Received: from MN2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:208:15e::40)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 17:31:04 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:15e:cafe::46) by MN2PR17CA0027.outlook.office365.com
 (2603:10b6:208:15e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:35 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:33 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 1/7] RDMA/mlx5: Check RoCE LAG status before getting netdev
Date: Mon, 9 Sep 2024 20:30:19 +0300
Message-ID: <20240909173025.30422-2-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fe414a-f125-4a89-1bc3-08dcd0f52dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KG9vffdqRsyUS4D8J6HTcUlKx4Nb7WhLKbJK3pN+zVahPmwwHOMHuP8+LNsj?=
 =?us-ascii?Q?+pxZGcTIFzrjI+ZPXaPypnxGaq0RffnhfKQJpVy6IiCvRZx/MRmuVuyBKnAj?=
 =?us-ascii?Q?75BbYhdzQ5gTlh5TPV6kLimjrfgACW/Lwfid3D2+MpE+HSybvzcIZBbZG+SJ?=
 =?us-ascii?Q?TLDkzEYPFk1zMjpzSAtUs3ekwPLDBRTojipy4v2N1wJnF2UdCNX9H3pi8aIB?=
 =?us-ascii?Q?7QZyITZZbBDl6L7FzA2AueTOTylzq+92Ji4MhbV3bsSZ52YpUtJtvXKM9Roi?=
 =?us-ascii?Q?j9rPSBrYTyEHo+HZOHpHyZiesuNKVjox7ZqAYFWeXMX3Pgq0ffe+TMLYWoBp?=
 =?us-ascii?Q?UpeUJ95LD0nkaS/YH4SJb0rFiwzs6pdcKPrTPf5DKvpCJt07yWErlJPrDReZ?=
 =?us-ascii?Q?1odJKoyAWOQflQNNnUNBXfFcBKiFxtCGA5H5aHemhX+6ZhhWi3y0gZHjIZAM?=
 =?us-ascii?Q?U5bnv1p1WF5//iUOg5Rm1s0xQGUfNrkQ/f9XiYXVaJUxEbY76s/pNNnKvigs?=
 =?us-ascii?Q?xtAURCskyjO4dxJlOf49sJGA/FBFkj9jLiylmJbsMp+GxuMxErvmn84cHuSF?=
 =?us-ascii?Q?ITkRpU++WTsMpNgChfa3dwdacFlaejOGcWD1u96hnVDcgf+TXmei2l5CbnX4?=
 =?us-ascii?Q?qhUTb9nF+ersHchWfPBfZollAaIGsYNJVLiewVTDFOoBTXFu6ihWLU8NHUTD?=
 =?us-ascii?Q?2q+7DOnAGLyptERfTaABPmHIiLO8YIrlB+q9x9ykkQwZ7x2TXKZTrlRKVzlc?=
 =?us-ascii?Q?lf3FsKYzMSuasI9QKHFN2ECjPRCDF/auAHm2Zo5stVrgONOOA8MKi2gyORtO?=
 =?us-ascii?Q?tazCfsFBzqKz/emTo+gtpBvbXX2xjAQpWMHl1JvqL5eLoqI3859O68HxgSfM?=
 =?us-ascii?Q?zehGRxrsGQmKO/JBI8ijSrWTakSRuDWGvtpVmZrhEpwQI/ZGScbg5oqIP2VQ?=
 =?us-ascii?Q?s191yavnOY0oiJIt++V44qb9I4atnkorP987vh5DnH5h/fwWwR5p3qB0UkzL?=
 =?us-ascii?Q?hodI//SfyMmzSF4rzjIxF7APhFfPyx4vbhyLShHLSNHoUeqNXBPteqMKusuc?=
 =?us-ascii?Q?pVsFS/dbWLQb9Ej3h+di2rmuo11S6vrqxCrJhfR6sz1OgpUuFKgcS+kyf9Cc?=
 =?us-ascii?Q?5DLCRsjKuNfsGBHNmSqA9K+hUWhxMtmXVROhfBmCe7V1okTYkyeEVONH/2Rn?=
 =?us-ascii?Q?DIovZaX+Owzkl47jUGsXsGQjEI73g4qZnkRuuP6cJotkcWfeJ/CfV6XOfytx?=
 =?us-ascii?Q?snoOFFkIe8k5Al/flAi9rapj3yZ/YQLAo7RQNr3rdk6wtfwXIaoKT2H59Xl4?=
 =?us-ascii?Q?stePeWW/dNWKDe+4SXjPZl3sGSMj7uwSFYUqNsUVuZhaJSJjBBjlGJUFvKBH?=
 =?us-ascii?Q?cHvF5GLeu1IhJd5ukJN4YjbN7v38SJEqGLLJsakEkxNTYRcU7SpAj2hdgdwG?=
 =?us-ascii?Q?YZ5fmYUSyjXkYal4t87HQkdsifyD2cne?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:03.4707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fe414a-f125-4a89-1bc3-08dcd0f52dfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

From: Mark Bloch <mbloch@nvidia.com>

Check if RoCE LAG is active before calling the LAG layer for netdev.
This clarifies if LAG is active. No behavior changes with this patch.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b85ad3c0bfa1..cdf1ce0f6b34 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -198,12 +198,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	case NETDEV_CHANGE:
 	case NETDEV_UP:
 	case NETDEV_DOWN: {
-		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
 		struct net_device *upper = NULL;
 
-		if (lag_ndev) {
-			upper = netdev_master_upper_dev_get(lag_ndev);
-			dev_put(lag_ndev);
+		if (mlx5_lag_is_roce(mdev)) {
+			struct net_device *lag_ndev;
+
+			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			if (lag_ndev) {
+				upper = netdev_master_upper_dev_get(lag_ndev);
+				dev_put(lag_ndev);
+			} else {
+				goto done;
+			}
 		}
 
 		if (ibdev->is_rep)
@@ -257,9 +263,10 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	if (!mdev)
 		return NULL;
 
-	ndev = mlx5_lag_get_roce_netdev(mdev);
-	if (ndev)
+	if (mlx5_lag_is_roce(mdev)) {
+		ndev = mlx5_lag_get_roce_netdev(mdev);
 		goto out;
+	}
 
 	/* Ensure ndev does not disappear before we invoke dev_hold()
 	 */
-- 
2.17.2


