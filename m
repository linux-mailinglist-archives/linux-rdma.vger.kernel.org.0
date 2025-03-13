Return-Path: <linux-rdma+bounces-8636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB809A5EADF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 06:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55932189ABB7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6121CBA02;
	Thu, 13 Mar 2025 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZt2AgsT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709E139D1B;
	Thu, 13 Mar 2025 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842546; cv=fail; b=KduC9MaEGZx9PtbgTsVHFJtomFYifx5Mzc7kZksLFlutrSN/bSs39sVVS4XREoe660nDBGWY291GD7NxzY6ohHG1uBJbINRRYW+2kDzzvlHNhljUq5jicA3wI3Bt/GqPgybhuGv8T1nqF0amY+kPm7yfa5OaM97UvjlWZv3nBjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842546; c=relaxed/simple;
	bh=YrLDiffC0zy+wyHt2oX56LdD+CfZfwV+Sfzfy6l92uA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MHN+Px06pVn1wjBNu6khE4mZLPnVvzAu8FUU2rsCuxCXMqen+i+ISjdQQX7ytrNi7SK3kDs6z+5FslI+pXjbAjgLan+BCa5N8Er8J5DyNnKo4gX0mrzTIrCpgpFDGSE9oJzjQAhGYIer3f2RnAEb+yD99Q0rWlvmOJuTv0niSgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZt2AgsT; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf8FRSiz+VW1mQ8wDlXSvR7ipC+rsMtzAZNeR1OxyMBEtKIc+tR+8ql3XOd1P4xd+KLc0mHg8wl9du9zxLSUU3W2JD/1QtezMsJMEKVKb3BaUVfNq+0bSLfYZf/x7dNb3BEppHnhONSUTjjmD4NXA/UchoveutxyrFLNakhz/GqTa++ETu9HVoF9OiiwQ2NU3/W21w+RZ9vFZ9GsNyLjkfy1hjkMKydDKGu9oFtZq756Ll10gcUhHjsCS3oOeJJbkBItc7Qaar7LeEw4B/TvFEuoBpuD6jaraC2B55OTqe8sydV5z++KHXGKdlSRjFsW4XvjlYHVq7dJ9K8V7iy6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsfSEkqY2DlxB6s42A+IIo33t1DnYs7yS8QmRStSKQ0=;
 b=FvX8+BzN9akak1Mm+1lzMAThieiEsUAb5LcgE4V1A7ftT+aK7zbXXoj/1nBNwuEMYrglnBYtTDydHbYik+Oib+LZwZcS2kPC9Mg0lZBG/aQgV0WWRMxjdQ5ZOk4ML1nRrhkt0LPM7b1nW0XEw6x08sMy6evSc8UOE5OCBJDp+TDvFZvnr9Z25oJqOmGHiaWvAWrQjTVr/7IGi1FcIH3uqeP31CVYhSs11GJmKz8LCj/q7AQlw4FrVZM7OdKKNAKnFjIhsBfIz9G0t5i3d7Ov7LJ7VpxkoZ2EJLlWRpII80VRmKPsKuOLGcurEkzsE7IU0P5ONY7CYBVsSLKJk1cLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsfSEkqY2DlxB6s42A+IIo33t1DnYs7yS8QmRStSKQ0=;
 b=WZt2AgsTyjfL2ZoK5lqY371WM1NzCPik1m0HKBlr0/McjcgHi4HZ4vze8CvxE40EONpn+I8h6jsQCgxzcUX1n9SXSOcXVanO9Tqe1e+c/AKmtu5eLs78tB4kSMaF+KprSis9NPVrQrrU9loFiXx8rKOAC83v+3f21THypFFSyvgPJaktsVgHSR9pPpO/UCY4ByzjtTGe+oxYGWbN8zn97/DLKT1m2yK8kuLFnCf0+KCnRXwwM1Xx+VYx/33ulBcBBjCLyug1OHdGsr/1RIQ7e4ZibeN0tymDsC7+OlPcKyTZQ3Z5a+TBuC+yWvDO1aqkdwT82YWgrJpZICrz4rdoyw==
Received: from SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:09:01 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9e) by SJ0PR03CA0200.outlook.office365.com
 (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 05:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 05:09:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 22:08:47 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 22:08:46 -0700
From: Parav Pandit <parav@nvidia.com>
To: <linux-rdma@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC: <ebiederm@xmission.com>, <serge@hallyn.com>, <leonro@nvidia.com>,
	<jgg@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH] RDMA/uverbs: Consider capability of the process that opens the file
Date: Thu, 13 Mar 2025 07:08:32 +0200
Message-ID: <20250313050832.113030-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 567e9ac7-6ba9-41da-0670-08dd61ed2ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z43wsIq8F0gNdE+DCpUwVACO52dl2hojL2T236yVkKA/lUs70hQpUWCMlbPm?=
 =?us-ascii?Q?q3G8DfDkCCPyccVXcBS2N3uDdY2JYjyF34YMpby0xAZ3eGCCgNbVUqxdtj52?=
 =?us-ascii?Q?Vo7sFkKvsg36r9zf269WmkNJnyBmrKKd+YCsjSWYheRSvYSqozxx8iI0211Q?=
 =?us-ascii?Q?zZhRGoi8RAfUUkHzNut0IsaScDJ45IhDl9ty0f2szlus/r1TOF+SkuxZK2rV?=
 =?us-ascii?Q?sHXruP8Zl+WUSMh1xv6BcVfKBFeSC6XFsv7qSs1x1um52rhC1FT7fZuYlRkB?=
 =?us-ascii?Q?alwQ5lBsKP/8bvghmLQEzZ/P2YqtlPqflsBKD+37FDNUl8oOByEY7uLAQRES?=
 =?us-ascii?Q?wn0ecyAyOwK2DQUBhHJobDnGYmGw4rF/oLXe5od/86OZOkVZM30kO7WVB2sH?=
 =?us-ascii?Q?orqPGyk018d+LuG3JK86nis0JQ4QHcqF7IRqF0C0LpsweVzxTaZ20KFLhOnP?=
 =?us-ascii?Q?Wak4YFF+DqPfkkfifpsfJunncztykIjKrNU2w+HgPB20shEfBWeMEVnxEUzd?=
 =?us-ascii?Q?zhrS2BxFBBZTq0LU6/mo0n/aYrJyqG83aLokNeqLEacQBvSU8qHi6Cx9riua?=
 =?us-ascii?Q?gH4Dmrdj+Vjn6lCY3iOMEPpSkbtkbS3BpYErbRiENTMXlokicfceCg2W4Iy8?=
 =?us-ascii?Q?Xwx3U+aSTeiH11rqVuxXJwqckCuUCU5bqHBBDXp6bryRHuL2XPtN9iDsZk+E?=
 =?us-ascii?Q?2yrFlJf2clWOy6UInTymvW6Z/NIr693I5gbeZyc71Df4mpK2HqO7vbLBNPAf?=
 =?us-ascii?Q?MCokvdocsLMdyyGhBblb4Ftmp9ZNCjubSN0gLLBP40w9h6cCCHs+1JkIPaLN?=
 =?us-ascii?Q?bUJtxR9/2jFYVf3/n4+1BdZwqtDgQG6IMfM7i028MstHc1SfsKgVJ8zJIGnR?=
 =?us-ascii?Q?Z3nsRGArNZV5WDJy34TbVq7bbB64RpddMcQMKmqDlwHX1TbE2U4Z18Oala1Y?=
 =?us-ascii?Q?9XxsPKv+2uY5xXzIaehijDt9A2gpUCnEqFpz7yzIWmSWBwkFZqfpUuKyOKNF?=
 =?us-ascii?Q?HB4Nho6ISU0TDSOew4eabgH9AL5+T8rckgrGT3Z/n+eByfpkF1pkVpPH/qxR?=
 =?us-ascii?Q?/+EOH6OZ66RO6QbH8dzrCfKRtiFJWjPnx3FyrlWqGk+Uqm/gRwax1to2g2b6?=
 =?us-ascii?Q?5o9Xbl/JLHuiuwcCo/W7dGi0/mvtSDlsHwz4AsFoYGpI5W+KnifUHyqcuEm8?=
 =?us-ascii?Q?HJvX7McM+43G6Ikjct/xNwdF495Cfv3Mhf3ywtwPMAZtxkj1csxfWO4wL21h?=
 =?us-ascii?Q?hb9/g6G7PZzfAsPu0GdPsHyFi1j1sCNdieI6RXt/xNTtM5VS5YZoJv1c98G1?=
 =?us-ascii?Q?EO0ihmyiw8iF3bSpAC/uxqw3Ltoh9uzho+a4weZV9pld987Yg/hkM1rNXY+i?=
 =?us-ascii?Q?kfJmQasOs4bN83bXD/DTbXueSMSA4zf4iRAGS/NquvDpSCLrYeKF++h5a1j9?=
 =?us-ascii?Q?0ve7j6T5ndzCJX02uuLNLV1VM9TJKk75YETCe0kHiTnMS732ftgw+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:09:00.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567e9ac7-6ba9-41da-0670-08dd61ed2ac4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

Currently, the capability check is done on the current process which
may have the CAP_NET_RAW capability, but such process may not have
opened the file. A file may could have been opened by a lesser
privilege process that does not possess the CAP_NET_RAW capability.

To avoid such situations, perform the capability checks against
the file's credentials. This approach ensures that the capabilities
of the process that opened the file are enforced.

Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>

---

Eric,

Shouldn't we check the capabilities of the process that opened the
file and also the current process that is issuing the create_flow()
ioctl? This way, the minimum capabilities of both processes are
considered.

---
 drivers/infiniband/core/uverbs_cmd.c  | 2 +-
 drivers/infiniband/core/uverbs_main.c | 2 +-
 include/rdma/uverbs_types.h           | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 96d639e1ffa0..e028454bcd7e 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3217,7 +3217,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (cmd.comp_mask)
 		return -EINVAL;
 
-	if (!capable(CAP_NET_RAW))
+	if (!file_ns_capable(attrs->ufile->filp, &init_user_ns, CAP_NET_RAW))
 		return -EPERM;
 
 	if (cmd.flow_attr.flags >= IB_FLOW_ATTR_FLAGS_RESERVED)
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 973fe2c7ef53..8e5ee702e9f8 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -993,7 +993,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	srcu_read_unlock(&dev->disassociate_srcu, srcu_key);
 
 	setup_ufile_idr_uobject(file);
-
+	file->filp = filp;
 	return stream_open(inode, filp);
 
 err_module:
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 26ba919ac245..06f57d28d349 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -181,6 +181,7 @@ struct ib_uverbs_file {
 	struct xarray		idr;
 
 	struct mutex disassociation_lock;
+	struct file *filp;
 };
 
 extern const struct uverbs_obj_type_class uverbs_idr_class;
-- 
2.26.2


