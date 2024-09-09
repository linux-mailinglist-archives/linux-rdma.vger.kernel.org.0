Return-Path: <linux-rdma+bounces-4837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446697211A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9EAB23D71
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BD189500;
	Mon,  9 Sep 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NkGj/bfZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA518950E
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903079; cv=fail; b=s3Y/E/cMFcxlHqgpmPmbAQLAJCXpdi5ms5qeT8pMcOemPwwmco0+lDlFCcZXewPWGCBAFzxoKNY8cyPI9Pyi/qNo9VMRB40i/pk4W9dHmfUF1VvrfVZD1NvZkm5HD2cT1ZnhiM2vxrW+UWU/uOZdTfYwYbHDknlBmd7FPQCgRnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903079; c=relaxed/simple;
	bh=xWP2jeU5dPrV6UR509bMAe5e4I5o2qzEfiOGmI56xZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsEBaqII3U9ayl19puIKSYWn7Ri9FROxNECkJcsQwzTVfH9JaMPqo+KV2OOL/rlNxB5ToetTzqdshvXiwuvBao1kfLGBLifZS9v+aw9WK7UlUcJDqhh4puYWosOXPt+5ZLKrmVubqe8LXLgcB4xNpgP+HY9AuZucz9Jrq15ORAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NkGj/bfZ; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0awmGJIci+m4BGnImOo2Yea7RqIHHIEOk23P6wb0+Znt+8ZspnQbrALEDYwz6TUomtk05jgcefQa7Xs2ssepyXZZhYi0JC0NYieu9xjw0e3ILrkSZrGoyQbszeDfRWs/13vPiHTSR59G/LPZOhahhq0Q5TmhsTK7gr3QlJc0nw9RX9dAsHmA/USWZ0uaZy+oLfa8iwAEQMYkEtB4f58CNlTNHBR2qVjDg0dO5JDWB50QWMeI5NGRzc3lH/nx/ahQFDePgmdK8CfN+b6nDi8xTRMrD1d5rQBkf19L9v0qlwl4N/tJ0BMa6Pbsr17Ez/ihGQzWQQ5qGf+vLuWo6uerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmzKhBQfEEZFhc4PuqNqyR/ZS5xARz64NwjVDxh3VtY=;
 b=S2w1PygkNkq7Ib8aOXW4xD86LfNgmc/gFH1rD9XCThDRqk2owA9Xm8vysBX/ZP6ky8VBZsPk+8Z1FLWxxaUwuvraJhKsPul0XzduS4scLE0LSs8K+bXOvAHS99HWm/99Ln1iOSpcmYej+ATTNZfrRLWwyxCCSCG4tBF+yQZMjXhax7bhtgjxK7KU2RuT24ueAwIfEXkHfJ2Jgo40Djy6uoxQ0g1PdIM6GW0JFEQcJzxJKI5hBpf0Nrv7BCUkOmrnIZ9T4lZWZUlF56QzHVO5sS7HjjyeHobdEIwq/05QZVUCM9fCLFcNzAgO/Wma0r8Q3MoHHcd6SLM2AuNgwEnIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmzKhBQfEEZFhc4PuqNqyR/ZS5xARz64NwjVDxh3VtY=;
 b=NkGj/bfZ7Yv5lpR5LyHwcDH/cGixXnMPmFy91gYcW7wjNLX60FqDfwM6YMsdcgCKLGrqtPrHW8NTcWjq2j4ceIFzvPfLpraNsTYpkKOAooAzlF37aqqzBPklfUFKb7hfHyHd5zqKDOIvdJYiYFawC3NLbQ3J7pKmv3PUsuIrByUdq5+HzRhTmG2C9xkdKxacF6crat0e5XfJ57fqhkZ/T0Ada07fczY9xVp97XzIftKsew6pSJGIylfpZWJCulEjlica8Wo7nfepcjXgE3DYd1mu7rUMYdBvS4MatGMDEZMmannSlmGD4Pjxs0MeKOlgPWtoZL+MfE0mKc+ojpCL4Q==
Received: from MN2PR06CA0007.namprd06.prod.outlook.com (2603:10b6:208:23d::12)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 17:31:13 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::c2) by MN2PR06CA0007.outlook.office365.com
 (2603:10b6:208:23d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:52 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:49 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 7/7] RDMA/nldev: Expose whether RDMA monitoring is supported
Date: Mon, 9 Sep 2024 20:30:25 +0300
Message-ID: <20240909173025.30422-8-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: c32bfc3d-8621-457b-3f8b-08dcd0f533b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fArufpEAlp4dvICosNJIcQT9dGHQGqmiXZ6/A975I38j2tLmMGQWmMaD6i48?=
 =?us-ascii?Q?47RMVR60wPx3iwvCfKrTZqAAXPIv7oxzvjHf0VXrwynChsPEJ3x4vkFz5nFv?=
 =?us-ascii?Q?+PDWAX9TjthPKRfNlGS86k+/KYAHz72oVdXYDsRIDScChIuv43OVuOqkIGCR?=
 =?us-ascii?Q?N9tR01VNFDJIIrTAI0ah9rdO84OkL+fy8pNwHnSG6bN0JVUxgM3EV3Olb4T0?=
 =?us-ascii?Q?BA6j2tAXf4abMXzZdNrQJwAciurFXgE32mxIGjknsGVttNNhzB/Reah6V6AE?=
 =?us-ascii?Q?jzBX6KsiAUmZFNDluk2gRGUYmCQpBzS/Ag/BdG73Zm3mxiNax4mOchyeIuYg?=
 =?us-ascii?Q?eNEQizodVVO01SuuxtnkcrlMqTYYa21/f2xLfjhzphDnrHojLfZrsQNIiuAo?=
 =?us-ascii?Q?NX2Was/StiJ99yTqELeS3UkaTRpzJDBC6/VDd5ZEvj6InDqyi2mBIGAk+oYR?=
 =?us-ascii?Q?U2+wOvc1BiHO6CqrLQ01ghL0ZOx0sXRJmQbUWAOyQ4pVZ5VT0pfjBCgsUeHp?=
 =?us-ascii?Q?2E9TBgeL+GtUF2kkH37LnQbX5dc/dqpJACrGFCx9MGoxo5hlxvHJOSgOGhvU?=
 =?us-ascii?Q?fq5gFfWfV2VKylq7HeEJdeCcqU0uKVt/NaiC6Ke5QykWzJytEW7D+nEAZwrc?=
 =?us-ascii?Q?MmQK/XwG6AaMBnKoKwbITCnb3qTWtM6RV6nioQTpTiz/mNDkSL7cGi566pB8?=
 =?us-ascii?Q?U3aJOgzsYJysbLBZkLhYgoicir94wO5MTVWvU55jf9rBVExZyjySC+wo0HoN?=
 =?us-ascii?Q?ncckzVvVkwaUsdv4oyXbjcdvFQ5ORlsRGgnAoYvfzsAZQ5f+0K/qZ8968C0c?=
 =?us-ascii?Q?sPHSPVxRUQ61ZVyGEaBTcj4+eHoycUy1qbhpQtPamvPSmFvDspIQAxgEfir4?=
 =?us-ascii?Q?m5psR7Hw2i89LRdsJ8DautnnQIvlX7udVYePv021JYHl/LsuVUxkqxpqYNuR?=
 =?us-ascii?Q?oNLHg6bE9/no0eXUcLIEQQiOQqcAY9pi/CHWRonptRV0FOUxndiunr6yQsmw?=
 =?us-ascii?Q?4798i85I/rreawx+MYm1sxALjTIsg8u/fkUheIz5yBnMZjrUw7FssNbGPdv2?=
 =?us-ascii?Q?sN9+OXTYEha/Mxmd5WZlrEQosB2EawbQB103hcZ3RbEDfQu0W3veH6+KOUXR?=
 =?us-ascii?Q?d6HMMqPHwrZ0OltjDpD3BVjEAoIfGZKJn1ClwveFClIctzOVD0x18cP0KEHk?=
 =?us-ascii?Q?UFu29hVFTfFDPOH3ButoyL4Cwp4igQU8h9oOW9jjtWo+OjRzJQ8xh4kUG6Rj?=
 =?us-ascii?Q?S4g3E9NHiqayJn8zBC7C2GtPuablO5jK38vFxcvijy+8LZiR9NAlUTsLgSzY?=
 =?us-ascii?Q?q8Oiu4cpdhcuU44tjgs8XnB5uDaZiuo96MMl2dAsmKCwJx5Ifs0C3SNe3sKh?=
 =?us-ascii?Q?e4T+HR/F4CKPTSNiV0lKX2tk3bS/n9RigVeMNWmbgLZTntyvcuMSZYDMO3ax?=
 =?us-ascii?Q?bT4vMPZwt0Xdh7kWEsCJVjXulat8rpKD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:13.0843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32bfc3d-8621-457b-3f8b-08dcd0f533b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869

From: Chiara Meiohas <cmeiohas@nvidia.com>

Extend the "rdma sys" command to display whether RDMA
monitoring is supported.

RDMA monitoring is not supported in mlx4 because it does
not use the ib_device_set_netdev() API, which sends the
RDMA events.

Example output for kernel where monitoring is supported:
$ rdma sys show
netns shared privileged-qkey off monitor on copy-on-fork on

Example output for kernel where monitoring is not supported:
$ rdma sys show
netns shared privileged-qkey off monitor off copy-on-fork on

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 6 ++++++
 include/uapi/rdma/rdma_netlink.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 30b0fd54a7d3..b2dca6aa531d 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1952,6 +1952,12 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		nlmsg_free(msg);
 		return err;
 	}
+
+	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_MONITOR_MODE, 1);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
 	/*
 	 * Copy-on-fork is supported.
 	 * See commits:
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 5f9636d26050..39be09c0ffbb 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -579,6 +579,7 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
 
+	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.17.2


