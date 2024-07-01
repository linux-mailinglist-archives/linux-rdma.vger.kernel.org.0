Return-Path: <linux-rdma+bounces-3576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BE91D9F3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D527A1C20F7C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A78E80BF8;
	Mon,  1 Jul 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQ+5j8w9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098579B96
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822703; cv=fail; b=AbB/VK5yLxIkrxmzZKX+EyxfDAAIkUnR1O4jlvKv4sgxqfZqr3C3xkhIvrHTx0K8EVuMIYkyqPol3ytHNJ2yb/B2pivg2xks7pJ/TI8351nRCVl9EBXVMTk5VCxxArAKp0MDp5TDCu5WXmsZQtOItmvpyqG1P5S4YQBzOjkmmfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822703; c=relaxed/simple;
	bh=B+JlRruLEOUde8jeoNJemi6Ctq7geCvwLGp6FS1lto0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yn/snoKC5p2qCl51AjYocMaAkD9obZS3U24KefTOculf+VToTWIMrQpZ3wMOsE4oUUqUN9cakW0Wadg4xAmICGQNu25l8oa31BKOUHbV0jfgahBTK2MdRBeI+MaoUzmmj39IdsS40vha3CThrDdhqaiBJEWY6TfiqbFi843MtFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQ+5j8w9; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW/HJNCvc6h0FsIEUoqlDG96rRKi4hSMlQt+52YfwDwgB6/JHa9+HX99ETprt8Qb/DKkNex2w13AfsYtnI85uovlms0UX/R65fHP4s4kDavSjCcMeC2KU+qNujFNpXF2RragLQwJ+L2HYHI9d3R0le+LLA5f5BS4AZ4mYFlgKiiFwfdfv4cYl4UP9zR2XaX94+1yiF/CW2hvmfz8TONVOtKOuhxu8+IlqfhSr/fhCQGvIG+OuQZ0tk06h/Q7vm5M6hG667IthECmWuc4ttlXacJ3OGKzUTLUIpFlATM3vDz0B/NTbsXQl8oFvuyscdoLjr08MJ5/j2qbVFpxTpM5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5MnzfB1hk1FD3qxLwd95E08cWqPTsWr/jRwGfxRq8U=;
 b=Ooh9nTOOcLfaVUkEhcoTFXkXlMjWHIQzDE3XL88P00X7MhHdfTy1ErHi36oxSJDC2Ztn6MQev8dwKk23dkSq3KcQfpyQBEXw/zq6darzucp3xgMLlkNOWzmXzJjfW9VBZWhiOrKMcQaMJEYQeTfwJR1iRHy8IEnTL0b0+ROOHxJ0J4LYQaqDLFzFEogTFcZMX0BgC6CmJo5AE3H/RaLX1ARgGM9OGazzjK6X0Vm2Q/2zTXYZAXSTXvpDQeuAlJnAbjysBvHJ7gpuQ1aqP0rgHKV6ky75NZz2tAgqZbYTKYQehOUHKywMlBJxh4QWogYPTCFTYrVcWUMuQkmzil+VoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5MnzfB1hk1FD3qxLwd95E08cWqPTsWr/jRwGfxRq8U=;
 b=EQ+5j8w9KSTqcK9SZiDS792Nqs04s/W24sNJDNlFiwg3AKVYzJUKLfovW/sZtB/i+dNjCq95iw55wLtpQlkUIc/gL9zh+ExVmoPVzRXv6jBTjX3rM2pC7dhPL+fXOwgmmJKf1jkMf9XAJ7lnf0k3PeXEXSZjwOHCUqRPKPZFnpK1XPSGONd6gPDeDAVzOjTjzbAGBIYLnx9jTSsZbIvBHIjLV53RN1dNuUUAe3mlO0F4aloGenaneui+WxCgEm5tUYLDGzKEym7j0d+VSH1fIpWoEV7WiiXJ1X4Los0fOpJzlBtuJi2b3GI+EmYVG35YrCjxSh4l/HwzAgWR6n62Lg==
Received: from PH8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:2cd::21)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 08:31:39 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::63) by PH8PR07CA0022.outlook.office365.com
 (2603:10b6:510:2cd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 08:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 08:31:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 01:31:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 01:31:21 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 1 Jul
 2024 01:31:20 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [RFC iproute2-next 1/2] Update rdma_netlink.h file upto kernel commit
Date: Mon, 1 Jul 2024 11:31:11 +0300
Message-ID: <20240701083112.1793515-2-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20240701083112.1793515-1-markzhang@nvidia.com>
References: <20240701083112.1793515-1-markzhang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 22745d96-4b00-4dc5-93fb-08dc99a83a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S04n36S3omDrvq+7lFfoY/8zTbCo4zAajv5hNdDxSOCS9exkqjx50e3pJlrv?=
 =?us-ascii?Q?LZML2xCdglEho76MoZlxkXXBlO0DQtP2yH6me3MMBG1fz0X1UHMMNIXPzL9Z?=
 =?us-ascii?Q?LEnQ1USQEKruOwiSeosMebEGciu2buspOZ9nQF4WXl+8anpNqXuEoADwEwRD?=
 =?us-ascii?Q?G1Kxtot+j9I7IsCgtaP7vb1TCXU/TmcDVthjT+ZtJCIBUGe+4564tweyLA3G?=
 =?us-ascii?Q?2KeGLzBcplOqwWElptLsuTp9HW7xNvNgKmHNO+fVlJuMsUrwyEbmbAUSTfMU?=
 =?us-ascii?Q?NM9JrwDPktrPzTLd96hJTvqCyV8uOgaACST4eU8szQ1yyp9+wm8Bl5Kd/YQY?=
 =?us-ascii?Q?ac8LgIbY4FCwkywj5LgOPOHzfp5jejfyDJa0kx/v5vK7UNbfDsmsfq7fnv+N?=
 =?us-ascii?Q?bYmxiT7HDrie+52T+eXsvD/B5rIPp060gCbKGaaLtyyLWU20mk4O9JQaNLzo?=
 =?us-ascii?Q?mGEYGq40+QkfA9lx0PEJSHu0spmuGqMgKl0LWCMBUUm6oKquT/eTt19bp4Mj?=
 =?us-ascii?Q?L2gwJNnf2ohWQa3bMIjON6Vy0NQe0QpuBjrwT4tI+LlDjefigfjGY2bT8RKF?=
 =?us-ascii?Q?f+99ZpAB0mgCDOcL7fUQemqhmREpLjcgE98cgC/A7u5eoBWIx32Hm4QU+d31?=
 =?us-ascii?Q?etdamDOQhohdOMr4ZtuqjiaZ5DggZ+Ca6KYkQipAUBjQ/xVXBqNuGTGCFF39?=
 =?us-ascii?Q?ZeIYJ2CWjrwoiSg88e73A7vOWc0P6dyQaU6eN5ScU84cKgJCzQEi4AENPdgt?=
 =?us-ascii?Q?Dfm9XzDmq0Py0Fn1ZJp8agtkLfB41zBL+AcJ3cL86Y5TSKbUj9yQkMyRs+7s?=
 =?us-ascii?Q?YSd4GDGcr/JwEWAUn/O+lScp0oMNKvuOaKOtTvhXC5TgrX3u43DM9HSPabVR?=
 =?us-ascii?Q?lCf7ZsMpAnjkV+yp4+bS18UqZKnF9XK6GFK7vFPbO0p8ci8bewxnu3HX1/qd?=
 =?us-ascii?Q?NhRMLDvFbtwf1Mw4zie3z3PaRhu6V+o4Azl0jJK3kG0IHS+AmjIT1u4nsVBs?=
 =?us-ascii?Q?KRLjL5Qqwup5hx6j5ZOoBJrOSpKyd3pj0TvcuxRxzl7asy6L2JK3Xr2XFfca?=
 =?us-ascii?Q?8KovJsWyzpAOYtGt+Frk9rnRK0ZL6WxYfoewpNV2gpIuORMz6llePVBCvnvb?=
 =?us-ascii?Q?3nttfEOE3Cbj8WL2ksXLbUHin2lARaEEgK+mqQ+5TJo6mAaX3v0fueHkYoEf?=
 =?us-ascii?Q?Pftuip1HHMpeGntyYvPGcICFOyPPYfa9Xo5Rov2si7TUcXp6q4/X3AeEfzql?=
 =?us-ascii?Q?V2zIN3Q3AwHRYcghedrFjcw2WUgYtL5w6P3y0gfAq5xpdmUv3Dxc0KbRlIge?=
 =?us-ascii?Q?pUeQR9PxzlY1jZ6f03iyo5yQ8+fhLG2pf0x66Y+xckv5pNY+ImOMoUTLTDU1?=
 =?us-ascii?Q?Y6FoH7ls6U8O9WBJTJS6KWRci39eZFYoEZHs2b+fR9X1QxWT716pCfKLPhbH?=
 =?us-ascii?Q?j1+s2VaRwX1kLXn7o9a497R15Yd0RhfM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:31:38.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22745d96-4b00-4dc5-93fb-08dc99a83a3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index a6c8a52d..aea1d5ef 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -301,6 +301,10 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_RES_SRQ_GET_RAW,
 
+	RDMA_NLDEV_CMD_NEWDEV,
+
+	RDMA_NLDEV_CMD_DELDEV,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -564,6 +568,10 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_RES_SUBTYPE,		/* string */
 
+	RDMA_NLDEV_ATTR_DEV_TYPE,		/* u8 */
+
+	RDMA_NLDEV_ATTR_PARENT_NAME,		/* string */
+
 	/*
 	 * Always the end
 	 */
@@ -602,4 +610,9 @@ enum rdma_nl_counter_mask {
 	RDMA_COUNTER_MASK_QP_TYPE = 1,
 	RDMA_COUNTER_MASK_PID = 1 << 1,
 };
+
+/* Supported rdma device types. */
+enum rdma_nl_dev_type {
+	RDMA_DEVICE_TYPE_SMI = 1,
+};
 #endif /* _RDMA_NETLINK_H */
-- 
2.26.3


