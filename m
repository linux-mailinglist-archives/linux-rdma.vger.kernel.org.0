Return-Path: <linux-rdma+bounces-8727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270CA6349D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 09:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B073B3603
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B51993BD;
	Sun, 16 Mar 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DA1eRqry"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DB42A96;
	Sun, 16 Mar 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112895; cv=fail; b=uCF0GL/kMP+9YdSfU6ajXcmUaKWnOjtUdsb+ejp0Hff6Uuccrzh+MlrH+abf/Gqx6g6Gx4nXK/f89qEOZ4bvhawsLEiEbh+eSeAhur35+Dj007Pt1ciwLydfQqGs99hEa25kiJPfBqQ8HaiQjCVoEL6Wcvjse6YZbG32bltthgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112895; c=relaxed/simple;
	bh=c29w1oxLksAQwz4UZAjRlCob/bM6i1pZbdnEsm+S7QU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/H/p7xrwz30MLqqq8bgHIs4YmPblkxcNP0A/KdFa79CyZreUoy85fGhx2XBXJJoJ7CdWuk1Oh+olqkgQvGQnveYC4/jwwJaBTNKvGSq5+k7NNDddIqaWKaEDBHPOh8PKlJdRYJaFPPXss7D2ZITRIe3cYLLbdFM15q/GrhgqG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DA1eRqry; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYRfD56W4yXYMvyoxmmcw8rd2/29OAxUw38GKdc1m2pyIi2dVHalQ6J3Bjd8ub3vKLh6A/ZFVw5KYrjM1vprCTkpZWO5+iMq/JbaKb2yUMEh+aXi/gNuTeygxE6rEk9IWvgFe5AawzUKa5oHwiYDXon/C2faOoI7uqC610u3Yoe+17IKJx6DcUzZTsNGOk9lv9+/bqHk7sRD//P1HCBbUNvfQm3x/5QB9yh1k9z7q5pD4I81UGpI5LnPpKPLIHiWmfM4NyMpq6urQthVUuvasOZFWqaswpRsJUC9Z60NejvkMPBLOuBNwVgrRQQDXp4PAu4LVOxbIP3HMIOGW3x+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhgnlpbE2cICD8iTHp8AFJWXcGRWxqRilPIPtabQjIA=;
 b=C5fWyRVc+F3CoqD/dD36sWIQiCTdBDRJk1zQ27bvN9k/SMM47WK7BgvGWGDWJfNFE3quw1+rdsVG68F+W/Rgife1aLG+yhTXCSLU7Bl2G0sPciBUoq/B1QImwAXmMA1Cf5OUsWjHdE5PpQcPp1FlLgNAfWpjYwQxfK1GvDUS1mdFFsrUOOj8yRsJ/U40v2HXi1K1sbdzBPtjVcjU+ah1sWw3yEPKkUHOo8LgYPe2wInY0o9n27kKcC6HfE8BZ0fcuHoTMRUzAVdhTv4vQY9X8diUp6bpEj+0iU82Pl3hDg3M24ibgoizsf3ElUbYhiRXt/wwYZ0zliaRsiqHVM6Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhgnlpbE2cICD8iTHp8AFJWXcGRWxqRilPIPtabQjIA=;
 b=DA1eRqryycXGY1dO4wglz2fA6VxScc9ztjpfEhFuyoIAI6ZHVs1gTNOVQueHj/UWYbhjz+Q3NX7uLAsXqAGJwrRK8HhtSFN8HxZlC2Uxma/DOKXM8MexQJ9l8Rp3rOjOPzelwPnTVURgE1S2999Qe14kuaE1WdNEteXj/WBCMDLxVbqtG9kqLbaFb7r7LAYwa/KYOYy3MjbTchk++SaNnoKiuhyHXZFpc+cQ9slSw9ehySCQbrrMJQzuNR7si1mIOr3a7/LMX+F63c4PPdDkCSZZ6vknefpG8Rfhe0agDkw/UaHl8foX9t17Gb+RTojF9y/zqkOfVtv6/M7y71awqA==
Received: from DM6PR02CA0054.namprd02.prod.outlook.com (2603:10b6:5:177::31)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 08:14:50 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::7a) by DM6PR02CA0054.outlook.office365.com
 (2603:10b6:5:177::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Sun,
 16 Mar 2025 08:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 08:14:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Mar
 2025 01:14:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 01:14:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 16 Mar 2025 01:14:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Yael
 Chemla" <ychemla@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kalesh Anakkur Purayil
	<kalesh-anakkur.purayil@broadcom.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net-next V2 0/4] mlx5e: Support recovery counter in reset
Date: Sun, 16 Mar 2025 10:14:32 +0200
Message-ID: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 149c7aaa-843d-4ed3-b459-08dd64629e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJKOAgYVZNp+I2VH5/61xD08moBxDayzVfrk8Rp6kR1aSM1QkZU4MxWmDM9o?=
 =?us-ascii?Q?nYokNwgUsd5utQj7hkI1QGm5S52q+rP4Ie3Kn6/9GS88rUOmRpVtz90PVKNG?=
 =?us-ascii?Q?DApQpLWP7o0ZWa5g0y2VBloDCaI5+j+8MzR9hUfK+dwc3wEuKmRHbloiDPKe?=
 =?us-ascii?Q?m+rwc4fBr28/BF1vGNKnMD/Jt9hnKsoez8ti07WlCLmIpcV97GDl/G4qh8Sq?=
 =?us-ascii?Q?q7rJRFhmtLLHBPM28o+aDDXVHEK25aqIuoQW2SjnqpKOOSQrJF4bTM+25Xh/?=
 =?us-ascii?Q?xtoSkTWbVX5Wvy2TUN2QK3u8f6CM2AqxB83c/0auU1t5UntMADYDvmouDdbP?=
 =?us-ascii?Q?Har3JqpBAwM9n6G1q62Jfyh1PMjnYAWqvEOQMjg8MlskIRpkklz7+fqPHzWA?=
 =?us-ascii?Q?QCqEGrAFl0POFS+s/xKqZFMIbCN3zAbfGgjrNeRZTGfCWn4It6KZnvGvTtzi?=
 =?us-ascii?Q?tA4JSlIeu2ZSXrBQb+KYbZ65RXz79B5yciiaYKBW6SBgR34rjKGESN77yPDm?=
 =?us-ascii?Q?rIXQWVHepVbYBa6EfNr2ytJqvJQ8Zhr5mhRB73+QzEL/Um/+jeewV4ltHIzh?=
 =?us-ascii?Q?Lty8QJkZUBZrGQJJanhgAnO09Dt0MfivT5FyKjxghWgoGCAoDdrDtFOMlrx3?=
 =?us-ascii?Q?EW0d76nnzvD6Yc/GYDq8xqwWvY6Zx4NYcLCodr1wHUCEbMo+UIRwO2+Gpiy4?=
 =?us-ascii?Q?zT40/AVrqs8DdZfRq12SV7Gainu8FOG+bgzx/t1gbTEmmo4sGUi4L59l36DG?=
 =?us-ascii?Q?sbrREcX+Xvv1xz+wsggXnXfWAn56ed5GeHiAOhCopmPUrxyzEuRhmAIQEeem?=
 =?us-ascii?Q?EHyvu9pRfUA/IdMSgxGRkDCQy5Xc4t7RVjFqhaKt3Z6bQi4XmN1uM6LONY2N?=
 =?us-ascii?Q?RmFMh47007EG96ytKBk8qzsbjId77avQz4aLtvCmJjeTG3NVOQuknY9IZKgT?=
 =?us-ascii?Q?LKzC9bSGTk93OWPG/PfHKgJHe4LjI7EyoTMMMijMjWfWyPOFDmYDkp6Uz8en?=
 =?us-ascii?Q?Kh+qAt7YzF77rl4P4hekhsZx0kpx8XK2nuSoR8K8ugazXEERSt6eLlQB8FTl?=
 =?us-ascii?Q?q6ZKBTBmLbsE1Q7+RM9ZWwdLtar4N4wxD4JQYZpk58bH98Qg/cRsTiRns77H?=
 =?us-ascii?Q?4gNMTAGgEYOtCOglDuwO4s8gC6qYxYN/wrnfFiItoYspwJsStYMnclUQWFcN?=
 =?us-ascii?Q?MxNaOrOiTJkosYZDrRRNLqlnT/5KgMIUE29R+xv/9IDE+aNGars0vnKp4iHN?=
 =?us-ascii?Q?DyaD40yPClms5w43lPZQBY660oU4YaUiiRINtljFxXncRN1jZWJ5d136xrIH?=
 =?us-ascii?Q?2625W+e146tPKni9gCcyog+GH4/zSUFIAUwJ89kJjtJwArZ92EKhejeKRIZa?=
 =?us-ascii?Q?vyG/ElNfNAMLPBPcNifvCKbYvEmGEn4VJ0vOW3/FYLwuw4VvltHqS1e4BAgK?=
 =?us-ascii?Q?2aPh5OwcPbmutLT5IUT6VA9gctvYd0FAQaoDSb5ddEMTEOL8QWE2UB+egNIU?=
 =?us-ascii?Q?J1hGDTN5abcwR+U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 08:14:48.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149c7aaa-843d-4ed3-b459-08dd64629e90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Hi,

This series by Yael adds a recovery counter in ethtool, for any recovery
type during port reset cycle.
Series starts with some cleanup and refactoring patches.
New counter is added and exposed to ethtool stats in patch #4.

Regards,
Tariq

V2:
- Fix bad indentation failing the html build. (Stanislav Fomichev).
- Add review tags.

Yael Chemla (4):
  net/mlx5e: Ensure each counter group uses its PCAM bit
  net/mlx5e: Access PHY layer counter group as other counter groups
  net/mlx5e: Get counter group size by FW capability
  net/mlx5e: Expose port reset cycle recovery counter via ethtool

 .../ethernet/mellanox/mlx5/counters.rst       |   5 +
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 119 ++++++++++++------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   4 +
 3 files changed, 91 insertions(+), 37 deletions(-)


base-commit: 89d75c4c67aca1573aff905e72131a10847c5fda
-- 
2.31.1


