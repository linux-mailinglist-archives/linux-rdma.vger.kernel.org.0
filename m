Return-Path: <linux-rdma+bounces-17982-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBBGD3ynsWn4EAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17982-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:33:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C43282680F0
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B88F3303320D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB642BEFED;
	Wed, 11 Mar 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="fmnFb+Qc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022072.outbound.protection.outlook.com [52.101.43.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD231E848
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250424; cv=fail; b=XaTaoAWhKHfuLIhUoot4MpF4mnWi0LIvaj0Tt9PJlEnz3hjd27Txl7xGGLNE7uIPouFLWq9A72szaNTEjFqe922ncfHz5OLMMTf9FsKN7662tO2rLGhgzwXTJysMDCkMYha/ismqXwWr8jB/fblE0hQ5V1myLodM+ZciHiUoGzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250424; c=relaxed/simple;
	bh=AhjHvfxBMc5tCALvczLe8yMay3ER/yChW02jHVGGd+4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=KAU+p0nJ+dfMIXuMV6hu8unp7Cd1ktimqPmhPDilpzvm4cykMShucDYCMdqhdBzmnztIsOnRrEBJkLMUSSf32lzLJyxJvyWXkPLkpSOKnWqZIg3+byBfOeR/MvskSA4NvaGxQx6n1ndlkG47e1svFDkgPwlVfyOpeE7fuJb+04I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=fmnFb+Qc; arc=fail smtp.client-ip=52.101.43.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtIGVRxyQ6aSDJcbHvowkl0nqLkn/qTiVhbauRXRYBhMPRzHUYw1GUYMuSjw3fVH5fPs39P4kfZ+5bUrPbaS2NbTgPSxLe9cejyl/nk0jUsA+OZcqReCy1BFV2cYbjaN+wm6oYqsPtBrdsHFQBXHWasMs3Ph2eXBd+pXECZeq3A64deUCxsW5QWHijXC85PlaYzoSgMXFqXC/iCf77GDHUVSlw2qoOSjs2G1DqR9XhpSzgqfKE0nrgkLVbeyyFrK9mMQrWRC0JUIGxFmCGCyZKoWbWrcBIWz6aQOLKzmWiIFdHTCTYOZHW/iHMiqQ20V3AxalqitJdRkcw1ARj7cTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSnIfVsqzqpKoz6Y8a0mCKiQSvvcPoqyy63+EUsV7oA=;
 b=HsfvLb4l8cfPBAtRrLAoVYpuOoP0eaUUsNUbcLVXFoCFqS0uSj+jLEW33IEC3vBHH623Hs+drW+igsNweKecdNs5AdeZQNZPu/iT+D8GKtIKUFhyuZaynP4jlvzJ6beB5PlFoIud82eMZiwgBXiM7h9wn2Vlakw+TjMFw4/A+TagCFnFJq5heTLiPf2gAO245kJd9g/wEgExeBlf4oa3QIIa/xDgVq5+INPSLOAukFMWPHN9ysOJe3K2Li5TtKhMDcPHVnwYf+NQgPKdMtxVpPwpdcNO5G5WB318POGaLOVZ44DdE8sHtREd+se6L3oRJSLtsKajY7/k2frAaVhJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSnIfVsqzqpKoz6Y8a0mCKiQSvvcPoqyy63+EUsV7oA=;
 b=fmnFb+Qcrs9q68/Y5ZNr00ki3wuXQmkS6u5NNyL7A8yJf61GQ23rbXiN279OF84dsdx/T+BCQLkkUKDfZJR7uoOBUTyrlVRlGb6uqsVrAL3vEZAHA5LIbTVLRJboXuOXd+Dk5kwk/+QC/RO0ORnJP3IpB/IbPrZ+ELxciRsBSLfwMjhZYehevRQnUxfzWHIyHq+/z4kc0VRNjkZO3QISiHw9URZZ3CIxzuUjjTjQrRArbYFaTUsHVfe3FotXbzbYPtHUM4Pf/5ueYiqMp3VYxycDOdsZlU+uUHt8RLh3DJU5iBxk8iLffu62qKxgFK42T5XuEM789Sz2thgZLefW7A==
Received: from BN0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:141::22)
 by DM4PR01MB7618.prod.exchangelabs.com (2603:10b6:8:61::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:33:38 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::c) by BN0PR07CA0004.outlook.office365.com
 (2603:10b6:408:141::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.1
 via Frontend Transport; Wed, 11 Mar 2026 17:33:37 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 6C19714D813;
	Wed, 11 Mar 2026 13:33:37 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 54A9E1810D6C5;
	Wed, 11 Mar 2026 13:33:37 -0400 (EDT)
Subject: [PATCH for-next] RDMA/core: Add writev to uverbs file descriptor
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:33:37 -0400
Message-ID:
 <177325041723.52970.2153579331168741909.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR01MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c72180-cc95-443f-cc87-08de7f945454
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|34020700016|1800799024|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZQXO17m3zMGT+iKz+OOBSg8zuw483BAVoTfjJONZ8elzW5Ll1fLiwa9z/LU9SP1i94TgHXG3vLn0OFPns2MbfqreIMv6nhLyhUrESIzR+Oz5Nj6oW90mH92HZOLunQb93KLF0IamJKaqI2aNUyUtxpxndhRsHdGQJ/HludE2FdxrHZTGXyMb7pKKYqlcXmPsA+Z4n6cTCAh05Sxu35CH4QmsFpSZoP48e5JB2LM94BGpec9DgsNrfXzRhCuFDF3NjS3mRdlTbl+AqIprtI8f651+rDGAs0qZd0cCGEXR62rlJw3JMIqLtAis6W6gmpDCwR+4j21x/BGtGId6q1UWqgq+ShAu9bZi61yO5PUqSsWY/3++5bH6OkfzNKtWtwEa8iZxZ9spmvweXA1XgymD6ggm7mKiuGpbb7n9zZ4KaYl64sI9P8ufgybSSRFlEyt90tDD5mc6rep3SdgzjBeDjswTnXJyQltY06qh/vkGYE3vW24WpjDqIZP4GLpDJf+FjU7aJ9J21IZajH1IqCOuFYuiD+lzVv5WfMjMRsD2JwKkodGulqgxuaBnjQLeDHTv3fGDVbRKg2vDZwcNmBrRsqSwdJRID6RWWztUeWIqyZxC4BDVTrMjyZRri1FplIZZJoZNkUDWNTz9j6iM7ZhYJtcvlERJQXVJUt8uEaEJ6v4HJvOhTumDFQ5GxLgwYlt0DFAsi85ps7778dLHw6/X+cpg44IERlM9SKdE/piF1m9xaytaUyCBiIvN2KGNGGDQCfjToIZpR1mCCNavmiNsNg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(34020700016)(1800799024)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0h+a0R/83frHcEOhWhyi0SJtLKUY4j58OcCs9NiMSPABO6HGj74simxX9WecMAKFTTMtsxu8LJiuzR8XIv/i7/ZJj1ILCOr3up87mStc1bvlukhdKnMmjMxbL8i6eMDX0q1U/9DspqrQQr9UTg7DvEFLJFJF+mZ1cDchLocwzkgIlwLBzKO4ntOYJ7Gb6/KWi3o6sNYApNYTQZewqAz7wJKmL/0g6cHT7i8ymlDDjmZf0Tn9dagGCgGE7s42gaLKbuCUzGtjedGNVBTkE7pOIkbGPOal/Gw1OsZLTKbYk0HFNmXeFtOwoM0UWnYPcvNXPhoOKBiQRd05ZT/ikTs8XCLrGklKV86xsKgG7T0YRVic7yrNGFgQ+ti6bXqrndaBjYWFiDeZiTjtmIAbya2H1jG5Ri6RIo6kX37anStara9kMrSMNjfHrrmBIfTXV3eL
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:33:37.9254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c72180-cc95-443f-cc87-08de7f945454
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7618
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17982-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,awdrv-04.cornelisnetworks.com:mid,cornelisnetworks.com:dkim,cornelisnetworks.com:email];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C43282680F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dean Luick <dean.luick@cornelisnetworks.com>

Add a writev pass-through between the uverbs file descriptor and
infiniband devices.  Interested devices may subscribe to this
functionality.

The goal is to keep all the semantics of the user interface the same so
it's an easy migration to the uverbs cdev from the private cdev. The idea
is that all the command and control is still ioctl, but the "data path" is
still using the writev() to pass in the iovecs.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
Changes since v1:
Updated commit message to indiate why we are keeping the
writev semantic.
---
 drivers/infiniband/core/device.c      |    1 +
 drivers/infiniband/core/uverbs_main.c |   22 ++++++++++++++++++++++
 include/rdma/ib_verbs.h               |    2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1b5f1ee0a557..e94aebea16e1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2805,6 +2805,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
 	SET_DEVICE_OP(dev_ops, report_port_event);
+	SET_DEVICE_OP(dev_ops, write_iter);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 7b68967a6301..b393d3a0f11c 100644
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
index 3f3827e1c711..c92496783028 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2757,6 +2757,8 @@ struct ib_device_ops {
 	 * Everyone else relies on Linux memory management model.
 	 */
 	int (*get_numa_node)(struct ib_device *dev);
+	/* subscribe to file ops write_iter callback */
+	ssize_t (*write_iter)(struct ib_ucontext *context, struct iov_iter *from);
 
 	/*
 	 * add_sub_dev - Add a sub IB device



