Return-Path: <linux-rdma+bounces-5942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1709C5293
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0343284CCA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246CB20EA2D;
	Tue, 12 Nov 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiI9WX3L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39B20B801;
	Tue, 12 Nov 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405553; cv=fail; b=nw7cIWFYGPOnQxXAHaKZzsIP2wor1C3vMKb15FNcXFmxyVDDhc9kI365ZzafO0n08QeDwCm0wLoSMp/8IDuwU9GPWFD+jKPDY7VMxnLEB9xhn242OEb/k54mdQOSM8C8r7QHkx6Kbq8Ym/i3KjYlPTIE3ra0fHTnJGwwOOJ9I2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405553; c=relaxed/simple;
	bh=kPSzhW/HlrttbnmapXqwUMOVhd2/8kC2Vz21qdIZOy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNQeJRjhS2CNxmBVjj7eou9g0w3hYqs87mky+66NVHhvePuFRMAxSE2RUL98JlFMaqZpn8OyvV3npYVg437LNNBrnx+9qCvXj3ZLMJ/ipxWxiKxSn74gJr3DUgD6QhRijHniqCGzI/RkutVWf7Wc9BQkqclzJu44+u26mfYUFPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiI9WX3L; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZdmv5jEZ5uvhKg6ljnnxdR5R4U3GgWb8Jevz5UvtcrlRsw9igIFfrRb268lIklbnlb/CnLaS1m18G6M7jMvil9Q8fuHBhywdlAOjeDH5pRhs2mVHKc9fsf8VOyBMeo8Qvy2gqp2EuLw8O35Nkxq9imCBkWI3JruoIVZj7Wnvw3GSbl3PpDC8/FhO+F/LW6NxLp7rTLwnLG1cPabfkR7S6HLTYJr8//uuwO1g/2Gzp4R5cBjTvJRKj57PA5BHsu2B9uCEA0YsWAsuOBiDfSUrvAhQmUzfrJ7DaXMynMg4svXOlm+qVb1b//AAyi9NtYHPoKMXnl4P5ZC8rquHjHqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA/MGtEORUUmGMMwM0leDBwubCRVf/5+1zCImVGoFBo=;
 b=qVXH4+ZtYaVvNwAP9rQztnuFDKYgoC2UDXodpCsNbLJdbXOeYJ0s51NTt/wDEr3Zju2otzXx2z1zVAsMgO0v8C5QnEO2857YQH9F5b8iUSfz9Ej9Rbi15DN5MecC0G4wVlHiC6Ok3VC3LjbSmRWqQqDPRsagzq96bhCHUF4bQWtJxsZwwkapiSw7ghEOR+GLkFBVIt2nGtkuBQ7HxB4F/2skIwhIGMPo6lxTFrUAj+v6mBgFWrRUR2UR6nMkWgaeWYmCMw8/NC4s+/VEYWOLj5RiPz1zl5vfy3njJMbrALPw6x10OX/4bgVCEME10SV3RcFTzi5AT9oqrkfnUsA4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA/MGtEORUUmGMMwM0leDBwubCRVf/5+1zCImVGoFBo=;
 b=CiI9WX3L7a1LDR6canJcFltA28dJLPRWBuLgShEvpb0O+egna8trqqNHPzzEsACIGzm3WuGGRaGKnCH8/4rXqvdPYdXEaLlOj07Mgu6JdoW+1KwKzao2A6dPGbv1jhkNrkHeOPPKNCLQO1WaB6wdvIWoT6u3ynowS4J6AtyaSYeHaEvfVwB6t1i9I7Uczfh+EJH6w938mBpUPb2wVOEKQbcLOCfTUTlDM7ATsKS3A3mgkXw5QdqTQyUOc81yINnga9WvuhhM2W83R2AN9br6275yjTbDCbuG+6XUoFp0VQAo3V45T6vCvK+YQyH25LFCCaSx+HUBxZZ1D32fQvRS1A==
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:59:01 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::e2) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 09:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 09:59:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 01:58:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 01:58:50 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 01:58:48 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH v3 iproute2-next 4/5] rdma: update uapi headers
Date: Tue, 12 Nov 2024 11:58:01 +0200
Message-ID: <20241112095802.2355220-5-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112095802.2355220-1-cmeioahs@nvidia.com>
References: <20241112095802.2355220-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd9c8c2-99fe-492e-96c6-08dd0300a22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vz8LB9oEM/5Mx45yvEtjqWeY1AU55XQwVrjUnUNzQH4KbjkzfjhjalMCqAv1?=
 =?us-ascii?Q?y+n+o5v7T00Oo/1TqIXoiRa2SzZw8J9j8woNVIVaKLZq0VkdmJqrjm+FHRzX?=
 =?us-ascii?Q?QIOxg8+JqaZHhBZoAKJ/xVejOlFlk6iRa01tP1z+KCfQFT88l8NKazBiWDe7?=
 =?us-ascii?Q?Mup48iAe9o2/DgyV20tqBHSwYBQ1Ro/JodQr/wjn+YTv6DSKKgaSk0d3jcUj?=
 =?us-ascii?Q?d7DJZm7O2DQ3N9xWVPC7inN6o8QdwhGD1wZt/7b6W1LVQqvdWyBx2eAEWuGD?=
 =?us-ascii?Q?BFbY3G9HHM/LgQns0fvIDNKI0WvHmBmb4GaI2awf1h1YPg9CzP8qH0oN5JzC?=
 =?us-ascii?Q?gxY8gXHzSta0meW/RIFbAb4yHg1PBKYnBH+C3VANBtGdgeIgTPSXQdWdM4g/?=
 =?us-ascii?Q?++Wb2VtOBGCX1bFlP6ChlcMRkbM5TyQXAPop2GZna5xGiNbkka6IwXRyCaHO?=
 =?us-ascii?Q?xV0ifdTpognONlvbrsfIUGAcea2dw4Ukej9D9FZwzOhOtfQ3hPbiUMbqjEnC?=
 =?us-ascii?Q?UpQNq2gUYuoRKlV9Y2FJoalivY2LSdv5he4N/dg458PKTOtVegQsk5t850Nv?=
 =?us-ascii?Q?4rWxfT1OlgPTd+R59NacYd4e5iv4Yc0YHj1MQakEgL78H83J5dCk1UbxxenD?=
 =?us-ascii?Q?AdXhHyKemqSL+eLT1RUEeXDjv/teV3XOWP9ogtf8zNKyFGvNgb721Hb7pXKg?=
 =?us-ascii?Q?uSO4iT75cnstvv4FClo3VsE/ROnm53vAnQ/9Yvw4DMQbPExn9j+DE31/jwgW?=
 =?us-ascii?Q?k0DmjJxhdhesIh+XUN4L2/9Pgwvg5S5Akd9iPZpsvfNb1pXv0qTOsbpAq/g/?=
 =?us-ascii?Q?sSkOOBRiAIKEd8AeonsjoZY69on7PBtJ0ZprMb2bO7YjLoPViInD8rbIuv27?=
 =?us-ascii?Q?Z5xVZOzCT2tSrp7WYJbqWj8HpdZ2rO5p6KVG+a4dd3p0Yz77u2fEDmSwZV1u?=
 =?us-ascii?Q?UK+CwiKim/r9LRhfiU3IhjM2W5+nU4eVoncOOXYW102MUevPRLB0bXXL1+sz?=
 =?us-ascii?Q?OVl9HmRPNLOTuaWynTwuVUIgF8A+V5HS3hIOKE9Sx2SSA+fc79F53DvJAbza?=
 =?us-ascii?Q?de7AMXeYZkcjvj65JaOGh1RwCgaOX2qB+eAHP23shYEyekiznEnoMmIss8Va?=
 =?us-ascii?Q?Xnh/K51Fi/+17o/godkAfyejfim82dnAWCK/uoII9Q4R1QStNVIgg4hw9vSi?=
 =?us-ascii?Q?Q5+RU1ikJoR4xt9UB065t9KpmdiG7FIHUAkdYcfDfVukiYH8yD02/nObdtFO?=
 =?us-ascii?Q?CdLh2XbdwsNHbDkJb1ZgUn2izRESbAebl64QzKInCQ9jsDFcn6wJVAz6WeU3?=
 =?us-ascii?Q?pFBmANXtTnKNlYyl0MUzm3T6g8Avi5bbs9i3DvIoKD+rSGgbns72JnZYhIDE?=
 =?us-ascii?Q?tb51zbj2UsiAVbe7WYihxg3lYyeKsfyqvxxvTOmub9oLObH9ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:59:01.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd9c8c2-99fe-492e-96c6-08dd0300a22f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

From: Chiara Meiohas <cmeiohas@nvidia.com>

Update rdma_netlink.h file upto kernel commit 7566752e4d7d
("RDMA/nldev: Add IB device and net device rename events")

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index aaa78e93..28404085 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -638,6 +638,8 @@ enum rdma_nl_notify_event_type {
 	RDMA_UNREGISTER_EVENT,
 	RDMA_NETDEV_ATTACH_EVENT,
 	RDMA_NETDEV_DETACH_EVENT,
+	RDMA_RENAME_EVENT,
+	RDMA_NETDEV_RENAME_EVENT,
 };
 
 #endif /* _RDMA_NETLINK_H */
-- 
2.44.0


