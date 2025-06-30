Return-Path: <linux-rdma+bounces-11765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C142DAEE62E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF94D189C323
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8632E540F;
	Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="aepkR4M/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2097.outbound.protection.outlook.com [40.107.92.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B628DB5E
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306294; cv=fail; b=l7kF/z257rOgTATzKZJIv7PsUk2BHE5D3I9hSOI+afMlGVv0+nPTlPzpLp3YilldQU9wYuKaxoh9T0YFus6u1iB3XDSKaBNvc5REPJIuEkgyNbR2ZrUFMmJ7fiJPIH6kX6xOkxeBn835LpB4WbUN5PQpaMxpcAWWEpFvpWeq6Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306294; c=relaxed/simple;
	bh=B0ba+kCtn6Kmqff0k+4MKM4uYjei9WEaXmbfVETRY5E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOaXQvQJYhdxR3O+21a5CQY0tZkc1b5Ao1I6L9Cic1wJq/CwLUPbM8W2ylGKoaqFhFk9GrbnDoMkXHhJ19nZadFPZ9OC/s2sweytqmdilHZoXUS4KDGfd4r9EQ4Sn7PnIn+qXyX9gNtWIe/KusyBOaUeByTl01mCJDe+otVL5xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=aepkR4M/; arc=fail smtp.client-ip=40.107.92.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM19AL7jNMw2WcQ6gBcJ2B2iIoFwqZ8i6sp1TR323ElSnXMoxyLcFK2rlDPCYek2ru17kvXx8MrWN9nvbpIzRfXt/sLXBBo231nuCv34cFh7FmnAQ3QT7xqe+Br1bvF0lRrN5McHx2/l2pvcLJPA3CZIcleIixqtkYoADiOCzA7RmOAodoenp87PL4lZp7whBKrQlst1S+wiYKnTSijhvvnyyC4RM7ZtXKVV++tmCC+MzamRyn3A8EAI6io0sfxqlQKi+64GQAJ682ZuQ14A2sxipUDvv9lm2NDdtfYxFqcc492Z2DPc7jsFl9uAS5CXlrZEyy9tIV4x3oP5QWPWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJyHSv6NV3b6Dq4RYAaf3bgJbX23L4AqCx5GC8ASbuo=;
 b=dy/pM0QoAVYEwfOBU1Ir5jm2gB+EoPNYA5RoLdwLXMyxORCFAN7bcil8wRObA+DpvnylnXxf8k0u0u/VlcgOx5tcqwHwax2kah6X6zMlVRHbLeRgaQbF5vnN52GvzKuCjngIsb+hTtPpAxeYMIEOd3Sy5mAx5ituaSXbsumHCZx0Jb1ndSYtRgcWQXKMFz+0Br9PTqgVPm6BKDBNcp+6y+N5M5taO2mkLB/by+1Bojf2QnS6xKHBWrUFPo16D1uttSy8ZCBUqRJ1NOmmuNyRMw+lGKaVIZuGIg8o+eQ+6ozPUivYzgrlUpDkuLDqCGDcQXp0nf5LC7yo27GXP8ByCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJyHSv6NV3b6Dq4RYAaf3bgJbX23L4AqCx5GC8ASbuo=;
 b=aepkR4M/SaqrFilKLUouJHGxTy8wzQoDl3KuHYDvLQH0jOgyxly+j4ta4OsoVFKXGA6vtE7f0q6RZQW43tBS2FYwB70tjapCb13cUL4awGNYpnOz2ZvzZa+d8j/+Bt9WKjvmdSOcWq0wl14NSjkuyk1CM4+m6YLspmxLjZ3lc8Vs7yBAWtj4whY60HPi1AymzwW2DrSpuTQwJyIHs4bscdUHpYcWJaHLAot2JcUlC34ReUiYhO12AMihvDXB5qxBugRGqxdmto8d4OmKjvsClvNAqinuwepkAU306YmxZIFGTqHPG+187E2v0n4Okc+8+msAWeKxnQjcz5nutP/I+g==
Received: from CY5PR13CA0040.namprd13.prod.outlook.com (2603:10b6:930:11::15)
 by CO1PR01MB8889.prod.exchangelabs.com (2603:10b6:303:272::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Mon, 30 Jun 2025 17:58:08 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::6) by CY5PR13CA0040.outlook.office365.com
 (2603:10b6:930:11::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Mon,
 30 Jun 2025 17:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:07 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id B7DD414D719;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id D4F071811CE72;
	Mon, 30 Jun 2025 11:30:12 -0400 (EDT)
Subject: [PATCH for-next 05/23] RDMA/core: Add writev to uverbs file
 descriptor
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:12 -0400
Message-ID:
 <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CO1PR01MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6d6463-a1b4-4156-f0ac-08ddb7ffab4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1MyUDZEU3RYeWJNM1JMeUNBOVVaWld6eThVWDFkNU1ManFhbTRvSWV4ck1v?=
 =?utf-8?B?N2VpcTFZamNCZnRTWDFhcExyb0RXNEp5TnBoMUh0SDVVZEFLeEJVdzNtMWlr?=
 =?utf-8?B?Mzg2OUV6T0FwY01pQkJ3MTN4aUZBNkk5VGxnOVpZTU5TY1RNRjUwZ2krakg1?=
 =?utf-8?B?d1F2UVNEYkE1SXFzOC8zTVJIdzIvZzBqYU1pWTlUcW1Db0MxWHQ1WTFBR01x?=
 =?utf-8?B?bUNkeGJJWXg3QkRObGp2TFI0UTgyeWZuSU4xTFJDS0gxdnRLZzRFL1pJQXV6?=
 =?utf-8?B?SGtZOXpDUjk0OU1tNDZVYlFYR1hma3N5S24wbnNKaXp1cHpMMCtYSThFd0ZD?=
 =?utf-8?B?WU5KcUdNWXdIZXc0SG1KdnlWNWR5bnpHWTdDbFJNUWVOS2k0VW9DYng4UmxB?=
 =?utf-8?B?aE9mOXR0MFhKVms4S2NyRnlPOFdETXdxSjM1L2p4N0V5Z3FueWtMZ2JaSUw2?=
 =?utf-8?B?cnNxalNWUmZRd1NrQlMyUTVqZmkxMWRQcm5TRk5QT3ZVNmxQdUFWN1RqYUpn?=
 =?utf-8?B?bkMvMVBGUVE1d3hOeEFiempva1E3Z3lGV2pQNk1hd1pSM2p5RFM3M0dYclpJ?=
 =?utf-8?B?dExNaGMrU1gvWUp1YjRFZVZsUXUwdXhHUS9FSkMrWDNENE10b1NEWWdJT3NR?=
 =?utf-8?B?aEY4WHhlb3dLREwwZWtSYVJsVDhzMHh4ZTBzajYvdXNLTkFlMEhTaG9pdnJG?=
 =?utf-8?B?ei82YTFFWi8zYURUQ0d3UjhuQ1BzTisrRU10M25yYmRLekR2U25vS0F1NVpr?=
 =?utf-8?B?dzVOTTZYU24yRVJFcEdOWWlWQklQZU4wLzZEMWVRVGsyVnlDaWl1KzZ5M0Qy?=
 =?utf-8?B?cy9aZE1LVkFMWjZnT0g0d0R4aW9Ed05YeE03WHNoR3JGTHR2UUhkQ3RtN2Nj?=
 =?utf-8?B?Vzg3QkRSaStSTVhCYm5yaWpmVm5XYWFVSG5aUzdMMHo0U0pkUGQyQVhtREs3?=
 =?utf-8?B?dEFkYzd3YWhpNHlWckNNWTMyTm52Rk5TaGthWURwYzljRGMvVlFlbGhIQ1V4?=
 =?utf-8?B?YW5meDlwdXNpSisySW1nTjdpUUVHNlp3K2VrR0pibnZnTVhPMFpRZCtIamo0?=
 =?utf-8?B?QUN6SnZ1blYySjFHNHd2SHBRcXo0dklzYURtb0E5a1MxY2RNcExtK1pBblB5?=
 =?utf-8?B?bURJTDhxUW5Rc1hCS0tvZys0Q2tiUm5OMzVPSHk1YmtKWGFKS2hVcXBjU09R?=
 =?utf-8?B?NndsRjNwd0xnd1dnL1RCTmFveEY4ZmxMbEhCdGpSVEtaN0twRGdGTjJEZW9G?=
 =?utf-8?B?dFJlbXlSRWRxTXA1S01sTmdpUU9pT2lzOElSckVsZE9kQzlxSkNiQ2ZLaG1i?=
 =?utf-8?B?NXlMbnBhZ1ZCL2pCZDVZUlRmMFhhVGlFUnhLNmg2LzFjbVEzWDJ5UU02Vmow?=
 =?utf-8?B?UExheFBXRHdwWlB2YzFJdzJZYW5QTXNuYnZ0T29FMEd1S0lVdFV5eEo5TFZJ?=
 =?utf-8?B?c3JLUFowSUFPZk5OeWJWZytEZWVZZ1V6V2g1aWNnQVZjMjB0ZHYvcHJ0d2Nv?=
 =?utf-8?B?dmMydHdwVStrTjlkUDFmb0NBWkpIRDhPSGpkZkRZOGlrNzFXNGxtdXpYWTRx?=
 =?utf-8?B?bzB6VXlMb2VlRXRoZEpJWmI5eE50eGtzVzY2b2JzbDNLTTJOallMQ2VTaUd2?=
 =?utf-8?B?TFNsRHo3c3dHMHFmTDJ0VU8xVEJrOERkbC8rZ3QyKzYwRm1zazVRc3Vteklq?=
 =?utf-8?B?TG9pazEzcml1Tk1sK2lXa2NHeVVReUJMYnRyYldsaHRla2FzaXlXK1VXbHEx?=
 =?utf-8?B?b0tObHJCRkZHM2VtaHVSUjUwQStiUW5NVjdnUGhpaTJGeFdHdTUrS0dqN3p4?=
 =?utf-8?B?MnJBWGt3dElvazRxMzVJdk1iR1dDR0pvR3p5cGlxdEhNc3RJLzRYQ3RJTW5m?=
 =?utf-8?B?TFcvZ0xVakhwK2pvcnU1cUc4Y1VUWFJvTHR3cGo0WW1IZ25VVDZiZXhGN1di?=
 =?utf-8?B?QWdla3FvdEtwajBPVXpRU3JKNlV5Si9rQklLcDl4UVVSVjUyb0R6QXgzV2Fy?=
 =?utf-8?B?NEpsTitIMjE5NjlCM3ZCaTVuUHZoK0FtNVRmbHhZNnFwYjFtVmxtSUU4aWln?=
 =?utf-8?Q?h3WGhm?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:07.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6d6463-a1b4-4156-f0ac-08ddb7ffab4f
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8889

From: Dean Luick <dean.luick@cornelisnetworks.com>

Add a writev pass-through between the uverbs file descriptor and
infiniband devices.  Interested devices may subscribe to this
functionality.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/core/device.c      |    1 +
 drivers/infiniband/core/uverbs_main.c |   22 ++++++++++++++++++++++
 include/rdma/ib_verbs.h               |    2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d4263385850a..6c270f9421af 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2789,6 +2789,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
 	SET_DEVICE_OP(dev_ops, report_port_event);
+	SET_DEVICE_OP(dev_ops, write_iter);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 973fe2c7ef53..9cb7c60f85b0 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -713,6 +713,26 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
+static ssize_t ib_uverbs_write_iter(struct kiocb *kiocb, struct iov_iter *from)
+{
+	struct ib_uverbs_file *file = kiocb->ki_filp->private_data;
+	struct ib_ucontext *ucontext;
+	ssize_t ret = -EOPNOTSUPP;
+	int srcu_key;
+
+	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
+	ucontext = ib_uverbs_get_ucontext_file(file);
+	if (IS_ERR(ucontext)) {
+		ret = PTR_ERR(ucontext);
+		goto out;
+	}
+	if (ucontext->device->ops.write_iter)
+		ret = ucontext->device->ops.write_iter(ucontext, from);
+out:
+	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
+	return ret;
+}
+
 /*
  * The VMA has been dup'd, initialize the vm_private_data with a new tracking
  * struct
@@ -1031,6 +1051,7 @@ static const struct file_operations uverbs_fops = {
 	.release = ib_uverbs_close,
 	.unlocked_ioctl = ib_uverbs_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
+	.write_iter = ib_uverbs_write_iter,
 };
 
 static const struct file_operations uverbs_mmap_fops = {
@@ -1041,6 +1062,7 @@ static const struct file_operations uverbs_mmap_fops = {
 	.release = ib_uverbs_close,
 	.unlocked_ioctl = ib_uverbs_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
+	.write_iter = ib_uverbs_write_iter,
 };
 
 static int ib_uverbs_get_nl_info(struct ib_device *ibdev, void *client_data,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 901353796fbb..db4597b67d3b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2686,6 +2686,8 @@ struct ib_device_ops {
 	 * Everyone else relies on Linux memory management model.
 	 */
 	int (*get_numa_node)(struct ib_device *dev);
+	/* subscribe to file ops write_iter callback */
+	ssize_t (*write_iter)(struct ib_ucontext *context, struct iov_iter *from);
 
 	/**
 	 * add_sub_dev - Add a sub IB device



