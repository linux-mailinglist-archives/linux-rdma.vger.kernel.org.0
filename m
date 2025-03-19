Return-Path: <linux-rdma+bounces-8811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB7A686B9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853803B5598
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB652512E5;
	Wed, 19 Mar 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qd3hh2r0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDF2512DA;
	Wed, 19 Mar 2025 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372755; cv=fail; b=dSZacKSKo+iXrBWHA1A+AZNkuEE3pWqvGUYtp+96NTiflIIFhoYZ2PRGTzABTJc9hVpCpGPTRezZHXY+p3XAuT5yJmUnC3+J9s/eLRiRa4lRaWU+vAZ/4HrugfsxcrlZPfp9StB2/k6BIN+Ey0RvBAkFKe0wAFr7AtFdA6OjpKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372755; c=relaxed/simple;
	bh=qlQV5eaHkfqbLllyRJBa30xG4QXejH3NvY8jiCu1u3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/bVOom2GCU32ABGGQrRDBdztfnQ8aWZ2dZb04p9Sb1oIz+B5lthdsLkM2mSWtQwLojS0Om+z0T5n473XWYFY6tDwq+zLl8nfh2YBFYEVNU1ca+6eYt/h2fkr+G+rjU1F51r4xo+22nV+nEltVrK7NVor4dFs31u/1Z0Xr6plfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qd3hh2r0; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2M1uUlsUKLRuNHYnGrroEc8+Oy0cp7MPJeUMo5m3y6LdcUh/v5juR0oVoOTa3M+Sy98aafvSfaNFXp/wrQhFoWknYRG14FGTxNSkDPtxmug2KNw0iJz7mQnZkiqBfAXxnPfbq1GKQb0qApa3v17w1kjSUAt/xxvOp1Y6nni7wXSkzE9OidbMArIaIfUEg0o43EAQfdU2A8N/tzh83jY6huHp3gAehzZ44KDds+Fz32NRhFBnd3RiynBDn3K4tplU1I+7Xacxxo3P4aaIDX34TzsssleQ+ABMkMycYR5uDyu0FWUxIXFgwz2xUtsXFxXiZzwYeGiIQIDwHtmgM3cIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxNNhQC/9expJ1cU4qr29Gw7MevaOG7BeWs97ne8CSA=;
 b=d0XSBKp98Me168NrXZ+4FUAI204q2eUqNayxRmZ0y+RHAqBe4dZyIOYJxz98Q6BS28v5pi3Hz+KHw/k41JAlYUYKEm60w1jbR8ewSUI9TgNehsCQeBS6WW4jN3NAA0kk/ZZNDwXosecVC4crIzu+tRiz1bDKyCxR20r/jSl9JY/DNM1MfTOGzEGUV8aSi6ZmNe1PzQGd+Q4pKRdwBR6PNVnwU4HDRCRYqkCkWN7b4OCyvaDxwWy4A2t7ZKIIZCyFGUZvNo6POJBHrRCae1YUCoBaImVSWF+L1+ZXeFFtWICCoul4iHb3dvBKz4yFA5Y3LzCTveXjJRRkbOnQ3j3fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxNNhQC/9expJ1cU4qr29Gw7MevaOG7BeWs97ne8CSA=;
 b=qd3hh2r0Z7cVQcz2xuujQG2QcylkhJmwWVk4npt1wEtROInV31kh6cUFeJ3PGUXKJq/D3MBD/5Rt4D5hqBeUHczWU5nqSSxHs6PSJFrtx/eZHFU6Go+rBmuqRCXvqpLHtTxEQ/nno63WS1LO15rgqHpYu25k+N1V9hgFOryy85S9xpIRm3K49KH/UR2bNr58/VcQCbj22DG8zXav8dWGvWetjFybAOJ5f1hTJrro7fDKD+uAGCVbb6uRIUEM0iXmBhN/P0dtI6HSyMuhs/xGiz6QotKezIMOhX+63wPCuq+FRKLUbi3R6U/xaw5Rdj5iOldlpLJLkNYYFcZIy3m8ig==
Received: from SA9PR13CA0177.namprd13.prod.outlook.com (2603:10b6:806:28::32)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 08:25:50 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::bd) by SA9PR13CA0177.outlook.office365.com
 (2603:10b6:806:28::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.30 via Frontend Transport; Wed,
 19 Mar 2025 08:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 08:25:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 01:25:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 01:25:38 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 01:25:36 -0700
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH iproute2-next 1/2] rdma: update uapi headers
Date: Wed, 19 Mar 2025 10:25:25 +0200
Message-ID: <20250319082529.287168-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250319082529.287168-1-phaddad@nvidia.com>
References: <20250319082529.287168-1-phaddad@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: b553443b-a273-4fef-357e-08dd66bfa826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OsepCFdxgLGu6RO2ABqs/d+OYr026p4/WG5vOCq3qXrg23F84ot4pXjXNDYA?=
 =?us-ascii?Q?oW0tLd3Ud6VNb3mYm4PzyAJ3TBHp5ndk4C/Rx+JCakr1FByjjUkmQYrW2psA?=
 =?us-ascii?Q?CFjBDXJVYMcjm1HWj3mWSZW8gBu0Dw2HuvkWAeVvLORcuhxWFgXcAiN7pIMp?=
 =?us-ascii?Q?GjKg7POD9uXPl1fz8vRSrsD690iyAG6YrLF+ohbhuUbD5eCNIvGqChrWejap?=
 =?us-ascii?Q?HMtTgbw6gq7j0B/J6k9trr64DTmTfouU/Nwgg1kcGNkVvlqebEgcgjpV82Fh?=
 =?us-ascii?Q?ZAf+nMYgSvGp87xD5d8AzduNXPW2ItKCSO2uVMhoRtMKBcx2ECY4oT9/0Z5L?=
 =?us-ascii?Q?v8nM6GHlKS3i5PHaxthifAJNOLsJDOACG4/a95RigzuSW6GcFuPfM4qtpDLp?=
 =?us-ascii?Q?o1Sl2eGQkL70UnQyPCOzfeDGA1rlRHa6bGMJAprWvRqXCKl/j1FJbnr4ssT7?=
 =?us-ascii?Q?fNNjPO4/Hiy7JBBp6ECF2fstrPUKDZnSDhxlw9aDp/crgt3NIaDbJaVN08SJ?=
 =?us-ascii?Q?8i6zzzKt8SLuCYZ67zZqE7sOvMP/VMxjkbNEFmVq9xfpLN901LuzIHdru112?=
 =?us-ascii?Q?uIjL7UQ2j540+Kb0aWgJNI1cQEC92JNkAm/COudZfSG1b1D2A16yeGEnNd5P?=
 =?us-ascii?Q?JDtWMubh72tZZ6oHy+SUo6bdsQYQB/NXig4pOFm5psTa9OCZAtX/hXJx+UPw?=
 =?us-ascii?Q?bnfkc3viKwVC4M6Z3WgTrcAPSq9asUoV+stRXoxtR2WAmLMLw0S9+ITEYUpW?=
 =?us-ascii?Q?zlJsdjVmPl3ovDqwwq2xZfgGBGLUTKZYhwHqJCrsaEVVs/0Pe+P6vjpKmpnY?=
 =?us-ascii?Q?GEcekkNR/Py8OvqEj/zY2u0K7Ija+Rq7O/XQPghskHu0L08H/EVDZpnA+OVw?=
 =?us-ascii?Q?dH8h3k2bBk/J8LOGkm6hpsUurT9jDsE5se+wK6V0ukQ/8JupRQeMcC95MRQR?=
 =?us-ascii?Q?QoOSFB53dSyqGSBMcmOXVuHLn5xE/2wNI/LY2o/xbVH+H+4DaIbwF9tKHs1d?=
 =?us-ascii?Q?LphAXiPQLr8UOFDY6Gt/8JD85Q7i/oUvfw9zDr1/mky0joICajDTWF+Cjw3j?=
 =?us-ascii?Q?IrDsqJpfAvmPu9en0KiejHspEf0qTP8E+aIsvJXStHo1YVcRb4m2EA53E2k/?=
 =?us-ascii?Q?o9SKIDuhXUtJGVghLXPmgMtjy68Xj8rP/5QZ59gQ2E/z5Iu11RCYzhMrnUlq?=
 =?us-ascii?Q?TbEYBUu7GNTnYh1zju/e26fv4a3hz43bz1gFrJRfhqG6h/d9OOhvPNYvxMHt?=
 =?us-ascii?Q?XWoqyGa9X7jz6jGGoYc2UuctqB1bhESpfQX8OvWhw3q979o9aZAzIOe7Bszc?=
 =?us-ascii?Q?AcOU7cUAF+iCjL4SdptW3AMWmvqkw+/5UlhD7tXNri9EDAv5wNtnIIOl6Cy1?=
 =?us-ascii?Q?5fQg9jPus1Wy3EU8RoIHwp6pc06el0MZzMW2erzUd8wC0KC/Z7YWXcv1Lnew?=
 =?us-ascii?Q?dnkIyMWJ1QYLrpouurAo7lET8q12SoKxozE4D+H7fLe+y9KgfryQe+AZ6QV+?=
 =?us-ascii?Q?dGJDChZvWaCqRM0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:25:50.1091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b553443b-a273-4fef-357e-08dd66bfa826
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

Update rdma_netlink.h file upto kernel commit da3711074f52
("RDMA/core: Add support to optional-counters binding configuration")

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 28404085..ec8c19ca 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -580,6 +580,8 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
 
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
+
+	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.47.0


