Return-Path: <linux-rdma+bounces-21236-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JswlGW9bFGpxMwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21236-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:23:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D160B5CBAF2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52FD300F15B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678833B2FE6;
	Mon, 25 May 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0T8FD2W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21193B101C;
	Mon, 25 May 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719018; cv=fail; b=gsDoFySCmysbrSbYYcaw3hIKLooabYQLLvTltAC9S0iDZN4a4M2xrLbwcg61CFBealyOSvEY3+JUqDMNFtrnEuxmgXgoHXHsCNhr0RGrBrzA3DF1+kFjKRzV+ddL1Ipe0/D2bEbdq/3PQjEltPzcS9hSafOI+kH31HtAY2brNwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719018; c=relaxed/simple;
	bh=Clb0jhrhyViJ4kDLwNBjqgcI/NieJxhaqS3LCqp2SWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e9k0ejztg2XqyJ7geDtpOtt15zWb3XuuVR2aBeD2pmH2rMUQlsrI/v5R0efKWViEOlqfBcxSiIR8Ct5WPSkQJf94F/oyf/3OZdoJV7kUZEMYmupkxasI+Ds1zzW7TWF8dRk5oXZqEVppjhiUdAsdpY5KncQNSLcsoD2uer5vDVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0T8FD2W; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFQxPOfIL8OvKFD4HYmV4TmPaggOI2OFEuXwhl5MW1LWnSjeJsly2Nmc7WkRkFZHyZ2UlYtmzbpJsYUFrX62+3+dv9bo3saW4QHa8rElElDd2UoWS4degGDTUC6sm8YlzZINH2hT4sGR+UPIntBIxjyHl0+kDjp9mQsnbCtkAP7sWy5eujRDkg0xHtGK3D4cuhvHV42nbsYyQfkeaGeHpsxkhrTtev28gtnBBwpzOgXXbMz9Mxs+teXRLOq98d31eHUcRJDkYMyuLvypdOEAsrKQClfMrrOV01pPZWi24UOSoznBfJxyqaBWKtFZQwo+PaSHcgabuLaqvxPcq+ln3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P8zA+Jg/XXhoDB4jpUl1HectX9UclrRug4/FGJRoqk=;
 b=BsP/7snGgcmhcG4DVdvJe1chzkSrPB9FKFtx6OQg7wH8Y5se9XSc70jJtbqr+FBPo6MkZwNQlkzAUMSLUFuJ1oxi0Ic0PXx5wNduf1qD1Wg9nB7aKLUCevm7zzi4Bij71Vxg8SZIIvpIEbak4eNvHbjtcgxODkCCVYm001F0A8IieIyoLQUSdRg2/ZXM+J/AmV5gBTcYLMskC8mAAqD0XYoAQ3/x9INUTUx4N4fr9CquwxydxGNGYOEjfw55GyOzuEgnWePoSnnetLSeNqwSsJDDZHnYuXUe/c6+nWT6h9P685P2VkMO+JY60JNEBJrsAuNzosWyWLWfTRM/B37b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P8zA+Jg/XXhoDB4jpUl1HectX9UclrRug4/FGJRoqk=;
 b=R0T8FD2WcakKwAFsaqmHWCfIpBQo2zaPVEzzjjcI5soqIYw09LXhsqeLWd8xMbm4LiLtICTX9tzzDQq6WfRlH8e3+xHALb3Qb8uvCiIPC6MVIY7hL+y1aiTnYptdRrZXmkfCAEGfRWjLmJAPB0bZmnXgBH+4zer7NEOwRk/5El/FeFy7dgaFawOZCPgbhPX0Hbs96sZgQTvA6WAfBxQicl/JYgMJyOJHXh7q8yy6cQb9F693IxrTqEKHNTe1CRMRW+dJAMU1mTvFJxy/Yh2I4IUolk7Yn9mNV40742L3+WXSpxkUkaXE0U5sfXd62xxZGpqzJ2Kzat/pA1UaOuwJug==
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:23:31 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 14:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 14:23:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 07:23:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 07:23:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 07:23:16 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <jgg@nvidia.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<error27@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH alloc
Date: Mon, 25 May 2026 17:21:36 +0300
Message-ID: <20260525142136.28165-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 01246f79-b565-4a9b-dc22-08deba6931f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vsiJMHCCuPNeHzATv88ZZhf6a0uoOS4vRZdgRwTyClD3rRp0U8AWegmZwQAXywSGpSPHWqBMgd7E8B82PT/NpUNOpKg4BgYEIUuUmqt8rULAuLm5QEFBu0TQOD/gTgS1Lkt+icEil4X+XfhEg4PKemmVfZDVf9lKiq+T7KuqYW+IXim0lnu3rjpvTKSkNGUBz+Gt2kXhuMYggDjM5yfJO7C71Y+faXTaPzF0AG4c6amWmnwE97AY9A7ZEwEvMagFlf8N0VviuL6E0qglphRnKEHYO6Nv35yH3VG/GRSk+3gEHUs2UD/1OfxC25qezXuyVR9RBTnLRoyzVCvVqSFR/vKIB3kysTM9xNqVqGXeOiw6rjJ2pK1T+lNnhGjLo0g5rTyOwgld3QWVVGVQXdZDoYaKMgyX0uncNWII/7nK63gv1hwDryi2GWwhqLsqZzX7BpUY15Pi/CG3wR61HM/wQiegnAF3iqw2C8DnMUHFc+SoxhGWmACDT1EhkZDIb+BgVy3Gc0/Y3v49nOx9lAU9rWfiU+OzSgmlu3K8GSMQwJCUR+/ifDTLTDW4DUluWvJe0UoMbmUV+s0Qlnh6BW0rHVWYrjMnA9mV/luCM72yKnJ7IaEx7qTUjk9QBLi23+SoYGvBerH7QXjmsvenyCvTZQFKxMB/TgE94jao64kaMO5lJBh7mCPrfgBmMPImYObl2f0Hfi9RUsFkOlHqd5Le3RccsWETkQPmxHRCMJL/nsM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	elMUnKEDabpsdnTR9HexbsSMA/S46Ic05uAJLnOjrf+7himbGzCvTYTWtcu/pvAN7gpYy59QvZ1T5YZdRJqdtF6u7WTGg1bTNLCGPYiYmPTTYpFsM2gAfumCrzUhPVARIBjYhvfJLC8JaY/XWtwlH5u6aVyJBWFYCt3nmvWjqRtz8YRAKmS0z4XyVzcMfz92U6Mbfxw8s+UqMetqac5Fi79OR58RB2pp5+xinqyLT9id8PwZnpb3QBEr8lGMTSCQWA2hQ1zEiYwSkE3Dfr3S1/Phtu+kWdIqDQYcQANwAvHbU1cGy/IsV87CS43XbPVicJnQwE0IyreUxaa61DjWk1ZFnW21zvm8SVEGxYtRGhJB54O/vLg2wiJi8gFM0PShQZ5rZPzOxGLmiVXugKsQ/n9yj94M3SnipDGFxcwJH4Crei3qft3hmhp156tHUG75
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:23:30.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01246f79-b565-4a9b-dc22-08deba6931f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21236-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D160B5CBAF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cpu_id attribute supplied by user space through
UVERBS_ATTR_ALLOC_DMAH_CPU_ID is passed directly to cpumask_test_cpu()
without first verifying that the value is within the valid CPU range.

Passing such untrusted data to cpumask_test_cpu() may lead to an
out-of-bounds read of the underlying cpumask bitmap: the helper expands
to a test_bit() that indexes the bitmap by cpu_id / BITS_PER_LONG with
no bound check.

In addition, on kernels built with CONFIG_DEBUG_PER_CPU_MAPS it trips
the WARN_ON_ONCE() in cpumask_check(); combined with panic_on_warn this
turns a bad user input into a machine reboot.

Reject any cpu_id that is not smaller than nr_cpu_ids with -EINVAL
before it is used.

Reported by Smatch.

Fixes: d83edab562a4 ("RDMA/core: Introduce a DMAH object and its alloc/free APIs")
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/ag68qoAW3P04J7pT@stanley.mountain/
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_dmah.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
index 453ce656c6f2..97101e093826 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmah.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -47,6 +47,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
 		if (ret)
 			goto err;
 
+		if (dmah->cpu_id >= nr_cpu_ids) {
+			ret = -EINVAL;
+			goto err;
+		}
+
 		if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
 			ret = -EPERM;
 			goto err;
-- 
2.18.1


