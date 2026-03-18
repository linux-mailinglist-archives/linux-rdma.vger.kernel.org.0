Return-Path: <linux-rdma+bounces-18337-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C05HynGumlobwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18337-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:35:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03D2BE511
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDF73214237
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F653DEAC5;
	Wed, 18 Mar 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="PbhW5o6m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021105.outbound.protection.outlook.com [40.93.194.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2283E9F6C
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846511; cv=fail; b=JlEfuYyBrDNDMBahYw8yrwxgMGibVAU4cNKDFv3TXA2OOHM02feiTyMu5tCSdotVETZ8Nk8SJOcuHiC8rUa4LlQyK1eCGHFw5mjgJPANSWCzzoZtNlewTiPKLrXioG2o34jxlOdFpUhQHTHf/CTe0RVXCb9n7humNrsaKiPxC0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846511; c=relaxed/simple;
	bh=4PcvmvH20aQVs5FYdpdg7arLfaj0z++dsixBSvBPw14=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Rrq0eUJsA7AF5sxZsFk64imn9/dkLvQ6y9NdNWlWNpSHuZjcGBTeT3pkwOVdGMgf6NG4Z27rXh0oSZ65iOYwm1H+VsstTZubBBhu3XTXXScYPCTXybAZoXm2yNH6/oDTs1YSHGokibwQnGl1SvjpupDIiyT4wt97xBUcrlc5ew8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=PbhW5o6m; arc=fail smtp.client-ip=40.93.194.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIMkskT6w6piRyJcWlQ+00rVViXndVxooZaOQ3oDcYWbREQRl6B6pRhM0IYCBljEnd5ZWvK96PuDHMzyMa7kH/ygsJwStGHYc9nnpdLbbrQjog3bVt/p8MyLJn/RB39FMKM7pUsH7HkBEScJ8IzPlWCtagNz7hdyC+iYe1iBtw7dVTrSAzVJfxySDyVZFgoyEFyVCm5/3ulj7q5dTIJhchewA0ug+LmRbdFsqjhqY3oDCzg7w4e0SISk6zLG7o2LQBkuSfCC1qZo+2II8gf/M5Or9J/VmVqRM+Gj/xHZG0E9G1wXAub7mSoJluAGPZ24hBtrfeboPfvSmXqht6KOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlS+VCS+VV6HiWVW4576A3H8qzJ1/wuMz/Y/GDJh/ng=;
 b=xoQOPyP97YPShCTlrK+Y6n3EKUOctmOOS8ca1nxMy2GPDkblid/7CQInY8wR0ufc1bdbxePe79fi+rj2psshD+liYnslhRZnOwLVBQScM4c4B3G3/NyDz87OfR8XzPV0/pSaAS1842eFadWwkrfGvPM+dvswp4GtP9C+fSEf4+eTcnUu4Uin447VQYOJ86z2cXFYoDfvoGssii0tMZ2XWWNPJ+sPr6677/mjWbaen1uwZ8NXB6mJgyooui49U1pLY6MwIAkuXvqIqVXRUT38VwHTJ8bjPcahbaDVclQGYtOdWs9XhjynnHviWUlsi5QrkGhwaNPIRo+fRLi5DnPHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlS+VCS+VV6HiWVW4576A3H8qzJ1/wuMz/Y/GDJh/ng=;
 b=PbhW5o6manb+7LqUS3aRR0OvVzRvdzAgwP8RKn/a1ff6v6F4gKrUdQSIk2aHpfMNFlNutukBq1ZajjDfGIqkSWE/OM9GI23EdevQQDk/WBo9r+TDRHJX+QTjCjn+hmvZGQhhyn6UjTsqznsAutAzuOJgJMLOwBvXH0KGs4SNmgZCVyTAuFkB+WcBBxvUlSG9Xsci8kf3TvdWPc5Rz4XMsyFqmlucG5F3bT27JOB5PKTHVIc1+DqpfevsA94SGh0Hk1C0fFoFRU7lWaBiL3O9RRD50ZfE1k/ptm76TAIN3gub5lKIdMy+PYKRt5BM2ZJylIxOAOlsrvtOV1fh0UvgNA==
Received: from BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::31)
 by DM8PR01MB7031.prod.exchangelabs.com (2603:10b6:8:19::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 15:08:18 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::3e) by BL1P221CA0024.outlook.office365.com
 (2603:10b6:208:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 15:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Wed, 18 Mar 2026 15:08:16 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 61438145A50;
	Wed, 18 Mar 2026 11:08:16 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 46B7A1810D6E7;
	Wed, 18 Mar 2026 11:08:16 -0400 (EDT)
Subject: [PATCH for-next v2] RDMA/hfi2: Consolidate ABI files and setup uverbs
 access
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Wed, 18 Mar 2026 11:08:16 -0400
Message-ID:
 <177384649619.507973.16055266883386579175.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|DM8PR01MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: a119a786-6627-4d61-b213-08de85002ee7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|34020700016|1800799024|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	f2GM7JaCpumNe0cwYs766DnOfxyz9dK/KCz+kZ7doyqg0XPFRh5m9XaSR/Vu+r5812N2ew7Er++bmquabHwKeybTqIGXlEfNnlV6u1P2xNEIUwLOPSHeJEas8IsjBc/BFGAzbHNu42GPE7XDD5XIboy+oYNah0CXM3bMXL2ow/NXMoxKrA/23fvoWja0kMlB8zciVAjloqYw9FCoCp7o7UC+VpAylD3CxCI0oF3WnuRYWD1JzUs2PtZDL/f7yBA8iGrNSJhzBh7EXIzxLc7vxvaFNqDEauoh0Q/XxvlVXiYL634GNgsT/n5i/SGOjY8c3llI9fY7/kKbpj3xjBeoWNuYjeYLJPZGSC/L5kZbBJdWEu9xgTy2L6OrCob9/2vN9Vi2kQVvIevFFOWxhEj5wD9ZmMoeU94ALXP/R6ra2kseocp7Anoh3ejZMEF6PCxeGTJUsjhpongdmYcE3QoLfjupYV+PaJ3qM29PLJzbw0+ql9lslMDPSY8cR5SxaWGALDHGHVHIskFcCI5M6tLG4etemADjukpS2y/Eet7czfYNv4rnXmT7gCipqyR/3zduqXwAju8FC78eprIScC3k63f6KxxpiuKwChzKJ096JLhhIiQ+0NR6MlfqSSwtD2M+S/6n9+wvr+wbcN10ou38gHJ6skbx/gUDvERtwpz9WrrTnSDtse6iNGOxDpn65zjyY/YcH31crVs3S1ARLxhuNwt1Pa5j/UEsJ2iQ29tUPY/6hKMvC0Ytu4Dig1hjX3SiSe2nHI7iXOh0mFBVk6wqCA==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(34020700016)(1800799024)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ekZUz3L376Fdh4VY1EtHVtLidR+TpZPMoPId78Pr8MPby1IfapG3ZscStraUTMf2h0eVg/dqoIapTDJ4vIeVSj5v9hze+ZyCndm+J8B2LyQbWJhKOWE4H20ThBPfldS8l7mqKZqNnK5AEwpAWIfFqhS7STP+JVHsRk8NsvwAT5Us4XFrwPSgsb8J8Yevt3xmlJ3fAD8W0U0TJNv2GpCA1C1vsADhPD6vqlwjQinyYuREMZq68B3xU22Uij4rabIIVpFr5pW2kurYz6ICqq+qd3r9CZAKPxbQ3PAff2rrlvUxGdkIDPUu/rv8L11xu7XeQrxksUyVUv3hSZc9OGqkg5tHBQlnRfe3s3rzE9REY9rAhZ99+wKGTGVasMGeg5kK/GohUwIELEU1JjphNlBxcWO64EdJau/bFFRtiKFntvM9b59GdgHkUpGJMvNJ8rGF
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:08:16.5948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a119a786-6627-4d61-b213-08de85002ee7
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7031
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18337-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AF03D2BE511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hfi1 driver is being replaced eventually with an hfi2 driver. Until that
happens rather than have all the duplicated code in header files, make hfi1
use hfi2 variants where it can. When compatibility breaks we'll keep a
separate hfi1 version.

This is the case for the <dev>_status struture. The hfi1 varaint is single
port and uses a freezemsg char array while the new hfi2 chip provides
multiple ports and thus needs and array of ports.

Likewise the tid info struct is expanded for hfi2 so we include both an
hfi1 and hfi2 vaiant.

There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
renamed to remove the 1 from the function name to keep the code readable
but allow it to compile due to the #define in hfi1_ioctl.h.

The big departure from hfi1 is that we are no longer supporting access from
users through a private character device. Instead we define two custom
verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
IOCTLs. We have added an additional method to get stats related to page
pinning done by the driver.

The hfi1_user.h is no longer needed and is removed from the uapi directory.
There is a private compat header in hfi1 that will be deleted when hfi1 is.
This removes driver specific content from generic RDMA UAPI headers.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---

  Changes since v1:
    - Remove include/uapi/rdma/hfi/hfi1_user.h; user-space libraries copy
      UAPI headers rather than including them from the kernel tree directly,
      so the hfi1_* compatibility aliases do not need to be exported as UAPI
    - Move hfi1_* to hfi2_* aliases into a new private driver header
      drivers/infiniband/hw/hfi1/hfi1_user_compat.h; hfi1 continues to use
      hfi1_* names with no changes to driver source files
    - Move HFI1_IOCTL_* command definitions from rdma_user_ioctl.h into
      hfi1_ioctl.h, removing the driver-specific include from the generic
      RDMA UAPI header
---
 drivers/infiniband/hw/hfi1/common.h           |    2 
 drivers/infiniband/hw/hfi1/file_ops.c         |    2 
 drivers/infiniband/hw/hfi1/hfi1_user_compat.h |   93 +++
 drivers/infiniband/hw/hfi1/trace_ctxts.h      |    2 
 include/uapi/rdma/hfi/hfi1_ioctl.h            |  140 +----
 include/uapi/rdma/hfi/hfi1_user.h             |  268 ---------
 include/uapi/rdma/hfi2-abi.h                  |  726 +++++++++++++++++++++++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |    1 
 include/uapi/rdma/rdma_user_ioctl.h           |   47 --
 9 files changed, 854 insertions(+), 427 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/hfi1_user_compat.h
 delete mode 100644 include/uapi/rdma/hfi/hfi1_user.h
 create mode 100644 include/uapi/rdma/hfi2-abi.h

diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 8abc902b96f3..011e0f12cea7 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -6,7 +6,7 @@
 #ifndef _COMMON_H
 #define _COMMON_H
 
-#include <rdma/hfi/hfi1_user.h>
+#include "hfi1_user_compat.h"
 
 /*
  * This file contains defines, structures, etc. that are used
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 56031becb273..e08049a43a95 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1159,7 +1159,7 @@ static int get_ctxt_info(struct hfi1_filedata *fd, unsigned long arg, u32 len)
 	cinfo.sdma_ring_size = fd->cq->nentries;
 	cinfo.rcvegr_size = uctxt->egrbufs.rcvtid_size;
 
-	trace_hfi1_ctxt_info(uctxt->dd, uctxt->ctxt, fd->subctxt, &cinfo);
+	trace_hfi_ctxt_info(uctxt->dd, uctxt->ctxt, fd->subctxt, &cinfo);
 	if (copy_to_user((void __user *)arg, &cinfo, len))
 		return -EFAULT;
 
diff --git a/drivers/infiniband/hw/hfi1/hfi1_user_compat.h b/drivers/infiniband/hw/hfi1/hfi1_user_compat.h
new file mode 100644
index 000000000000..d6522233e4cb
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/hfi1_user_compat.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright 2025 Cornelis Networks.
+ */
+
+/*
+ * Private compatibility header mapping hfi1_* names to their hfi2_*
+ * equivalents. User-space libraries maintain their own copies of the
+ * UAPI headers and do not include them directly from the kernel tree,
+ * so these aliases need not be exported as UAPI. This header allows
+ * the hfi1 driver to continue using hfi1_* names without modification.
+ */
+
+#ifndef HFI1_USER_COMPAT_H
+#define HFI1_USER_COMPAT_H
+
+#include <rdma/hfi2-abi.h>
+
+#define hfi1_user_info hfi2_user_info
+#define hfi1_ctxt_info hfi2_ctxt_info
+#define hfi1_base_info hfi2_base_info
+
+#define HFI1_USER_SWMAJOR HFI2_USER_SWMAJOR
+#define HFI1_USER_SWMINOR HFI2_USER_SWMINOR
+#define HFI1_SWMAJOR_SHIFT HFI2_SWMAJOR_SHIFT
+
+#define HFI1_CAP_DMA_RTAIL HFI2_CAP_DMA_RTAIL
+#define HFI1_CAP_SDMA HFI2_CAP_SDMA
+#define HFI1_CAP_SDMA_AHG HFI2_CAP_SDMA_AHG
+#define HFI1_CAP_EXTENDED_PSN HFI2_CAP_EXTENDED_PSN
+#define HFI1_CAP_HDRSUPP HFI2_CAP_HDRSUPP
+#define HFI1_CAP_TID_RDMA HFI2_CAP_TID_RDMA
+#define HFI1_CAP_USE_SDMA_HEAD HFI2_CAP_USE_SDMA_HEAD
+#define HFI1_CAP_MULTI_PKT_EGR HFI2_CAP_MULTI_PKT_EGR
+#define HFI1_CAP_NODROP_RHQ_FULL HFI2_CAP_NODROP_RHQ_FULL
+#define HFI1_CAP_NODROP_EGR_FULL HFI2_CAP_NODROP_EGR_FULL
+#define HFI1_CAP_TID_UNMAP HFI2_CAP_TID_UNMAP
+#define HFI1_CAP_PRINT_UNIMPL HFI2_CAP_PRINT_UNIMPL
+#define HFI1_CAP_ALLOW_PERM_JKEY HFI2_CAP_ALLOW_PERM_JKEY
+#define HFI1_CAP_NO_INTEGRITY HFI2_CAP_NO_INTEGRITY
+#define HFI1_CAP_PKEY_CHECK HFI2_CAP_PKEY_CHECK
+#define HFI1_CAP_STATIC_RATE_CTRL HFI2_CAP_STATIC_RATE_CTRL
+#define HFI1_CAP_OPFN HFI2_CAP_OPFN
+#define HFI1_CAP_SDMA_HEAD_CHECK HFI2_CAP_SDMA_HEAD_CHECK
+#define HFI1_CAP_EARLY_CREDIT_RETURN HFI2_CAP_EARLY_CREDIT_RETURN
+#define HFI1_CAP_AIP HFI2_CAP_AIP
+
+#define HFI1_RCVHDR_ENTSIZE_2 HFI2_RCVHDR_ENTSIZE_2
+#define HFI1_RCVHDR_ENTSIZE_16 HFI2_RCVHDR_ENTSIZE_16
+#define HFI1_RCVDHR_ENTSIZE_32 HFI2_RCVHDR_ENTSIZE_32
+
+#define _HFI1_EVENT_FROZEN_BIT _HFI2_EVENT_FROZEN_BIT
+#define _HFI1_EVENT_LINKDOWN_BIT _HFI2_EVENT_LINKDOWN_BIT
+#define _HFI1_EVENT_LID_CHANGE_BIT _HFI2_EVENT_LID_CHANGE_BIT
+#define _HFI1_EVENT_LMC_CHANGE_BIT _HFI2_EVENT_LMC_CHANGE_BIT
+#define _HFI1_EVENT_SL2VL_CHANGE_BIT _HFI2_EVENT_SL2VL_CHANGE_BIT
+#define _HFI1_EVENT_TID_MMU_NOTIFY_BIT _HFI2_EVENT_TID_MMU_NOTIFY_BIT
+#define _HFI1_MAX_EVENT_BIT _HFI2_EVENT_TID_MMU_NOTIFY_BIT
+
+#define HFI1_EVENT_FROZEN HFI2_EVENT_FROZEN
+#define HFI1_EVENT_LINKDOWN HFI2_EVENT_LINKDOWN
+#define HFI1_EVENT_LID_CHANGE HFI2_EVENT_LID_CHANGE
+#define HFI1_EVENT_LMC_CHANGE HFI2_EVENT_LMC_CHANGE
+#define HFI1_EVENT_SL2VL_CHANGE HFI2_EVENT_SL2VL_CHANGE
+#define HFI1_EVENT_TID_MMU_NOTIFY HFI2_EVENT_TID_MMU_NOTIFY
+
+#define HFI1_STATUS_INITTED HFI2_STATUS_INITTED
+#define HFI1_STATUS_CHIP_PRESENT HFI2_STATUS_CHIP_PRESENT
+#define HFI1_STATUS_IB_READY HFI2_STATUS_IB_READY
+#define HFI1_STATUS_IB_CONF HFI2_STATUS_IB_CONF
+#define HFI1_STATUS_HWERROR HFI2_STATUS_HWERROR
+
+#define HFI1_MAX_SHARED_CTXTS HFI2_MAX_SHARED_CTXTS
+
+#define HFI1_POLL_TYPE_ANYRCV HFI2_POLL_TYPE_ANYRCV
+#define HFI1_POLL_TYPE_URGENT HFI2_POLL_TYPE_URGENT
+
+#define hfi1_sdma_comp_state hfi2_sdma_comp_state
+#define hfi1_sdma_comp_entry hfi2_sdma_comp_entry
+
+#define HFI1_SDMA_REQ_VERSION_MASK HFI2_SDMA_REQ_VERSION_MASK
+#define HFI1_SDMA_REQ_VERSION_SHIFT HFI2_SDMA_REQ_VERSION_SHIFT
+#define HFI1_SDMA_REQ_OPCODE_MASK HFI2_SDMA_REQ_OPCODE_MASK
+#define HFI1_SDMA_REQ_OPCODE_SHIFT HFI2_SDMA_REQ_OPCODE_SHIFT
+#define HFI1_SDMA_REQ_IOVCNT_MASK HFI2_SDMA_REQ_IOVCNT_MASK
+#define HFI1_SDMA_REQ_IOVCNT_SHIFT HFI2_SDMA_REQ_IOVCNT_SHIFT
+
+#define hfi1_kdeth_header hfi2_kdeth_header
+#define hfi1_pkt_header hfi2_pkt_header
+#define hfi1_ureg hfi2_ureg
+
+#endif /* HFI1_USER_COMPAT_H */
diff --git a/drivers/infiniband/hw/hfi1/trace_ctxts.h b/drivers/infiniband/hw/hfi1/trace_ctxts.h
index 76c41bd79071..13b9716d37a2 100644
--- a/drivers/infiniband/hw/hfi1/trace_ctxts.h
+++ b/drivers/infiniband/hw/hfi1/trace_ctxts.h
@@ -62,7 +62,7 @@ TRACE_EVENT(hfi1_uctxtdata,
 
 #define CINFO_FMT \
 	"egrtids:%u, egr_size:%u, hdrq_cnt:%u, hdrq_size:%u, sdma_ring_size:%u"
-TRACE_EVENT(hfi1_ctxt_info,
+TRACE_EVENT(hfi_ctxt_info,
 	    TP_PROTO(struct hfi1_devdata *dd, unsigned int ctxt,
 		     unsigned int subctxt,
 		     struct hfi1_ctxt_info *cinfo),
diff --git a/include/uapi/rdma/hfi/hfi1_ioctl.h b/include/uapi/rdma/hfi/hfi1_ioctl.h
index 8f3d9fe7b141..89d7ccf47b73 100644
--- a/include/uapi/rdma/hfi/hfi1_ioctl.h
+++ b/include/uapi/rdma/hfi/hfi1_ioctl.h
@@ -7,6 +7,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2015 Intel Corporation.
+ * Copyright 2025 Cornelis Networks
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -51,124 +52,31 @@
 
 #ifndef _LINUX__HFI1_IOCTL_H
 #define _LINUX__HFI1_IOCTL_H
+
 #include <linux/types.h>
+#include <rdma/rdma_user_ioctl_cmds.h>
 
 /*
- * This structure is passed to the driver to tell it where
- * user code buffers are, sizes, etc.   The offsets and sizes of the
- * fields must remain unchanged, for binary compatibility.  It can
- * be extended, if userversion is changed so user code can tell, if needed
+ * HFI1 ioctl commands (legacy private cdev interface).
+ * Struct types reference hfi2_* directly to avoid a circular include
+ * dependency: hfi2-abi.h includes rdma_user_ioctl.h which includes
+ * this file, so hfi2-abi.h types are not yet visible here.
  */
-struct hfi1_user_info {
-	/*
-	 * version of user software, to detect compatibility issues.
-	 * Should be set to HFI1_USER_SWVERSION.
-	 */
-	__u32 userversion;
-	__u32 pad;
-	/*
-	 * If two or more processes wish to share a context, each process
-	 * must set the subcontext_cnt and subcontext_id to the same
-	 * values.  The only restriction on the subcontext_id is that
-	 * it be unique for a given node.
-	 */
-	__u16 subctxt_cnt;
-	__u16 subctxt_id;
-	/* 128bit UUID passed in by PSM. */
-	__u8 uuid[16];
-};
-
-struct hfi1_ctxt_info {
-	__aligned_u64 runtime_flags;    /* chip/drv runtime flags (HFI1_CAP_*) */
-	__u32 rcvegr_size;      /* size of each eager buffer */
-	__u16 num_active;       /* number of active units */
-	__u16 unit;             /* unit (chip) assigned to caller */
-	__u16 ctxt;             /* ctxt on unit assigned to caller */
-	__u16 subctxt;          /* subctxt on unit assigned to caller */
-	__u16 rcvtids;          /* number of Rcv TIDs for this context */
-	__u16 credits;          /* number of PIO credits for this context */
-	__u16 numa_node;        /* NUMA node of the assigned device */
-	__u16 rec_cpu;          /* cpu # for affinity (0xffff if none) */
-	__u16 send_ctxt;        /* send context in use by this user context */
-	__u16 egrtids;          /* number of RcvArray entries for Eager Rcvs */
-	__u16 rcvhdrq_cnt;      /* number of RcvHdrQ entries */
-	__u16 rcvhdrq_entsize;  /* size (in bytes) for each RcvHdrQ entry */
-	__u16 sdma_ring_size;   /* number of entries in SDMA request ring */
-};
-
-struct hfi1_tid_info {
-	/* virtual address of first page in transfer */
-	__aligned_u64 vaddr;
-	/* pointer to tid array. this array is big enough */
-	__aligned_u64 tidlist;
-	/* number of tids programmed by this request */
-	__u32 tidcnt;
-	/* length of transfer buffer programmed by this request */
-	__u32 length;
-};
+#define HFI1_IOCTL_ASSIGN_CTXT \
+	_IOWR(RDMA_IOCTL_MAGIC, 0xE1, struct hfi2_user_info)
+#define HFI1_IOCTL_CTXT_INFO _IOW(RDMA_IOCTL_MAGIC, 0xE2, struct hfi2_ctxt_info)
+#define HFI1_IOCTL_USER_INFO _IOW(RDMA_IOCTL_MAGIC, 0xE3, struct hfi2_base_info)
+#define HFI1_IOCTL_TID_UPDATE \
+	_IOWR(RDMA_IOCTL_MAGIC, 0xE4, struct hfi1_tid_info)
+#define HFI1_IOCTL_TID_FREE _IOWR(RDMA_IOCTL_MAGIC, 0xE5, struct hfi1_tid_info)
+#define HFI1_IOCTL_CREDIT_UPD _IO(RDMA_IOCTL_MAGIC, 0xE6)
+#define HFI1_IOCTL_RECV_CTRL _IOW(RDMA_IOCTL_MAGIC, 0xE8, int)
+#define HFI1_IOCTL_POLL_TYPE _IOW(RDMA_IOCTL_MAGIC, 0xE9, int)
+#define HFI1_IOCTL_ACK_EVENT _IOW(RDMA_IOCTL_MAGIC, 0xEA, unsigned long)
+#define HFI1_IOCTL_SET_PKEY _IOW(RDMA_IOCTL_MAGIC, 0xEB, __u16)
+#define HFI1_IOCTL_CTXT_RESET _IO(RDMA_IOCTL_MAGIC, 0xEC)
+#define HFI1_IOCTL_TID_INVAL_READ \
+	_IOWR(RDMA_IOCTL_MAGIC, 0xED, struct hfi1_tid_info)
+#define HFI1_IOCTL_GET_VERS _IOR(RDMA_IOCTL_MAGIC, 0xEE, int)
 
-/*
- * This structure is returned by the driver immediately after
- * open to get implementation-specific info, and info specific to this
- * instance.
- *
- * This struct must have explicit pad fields where type sizes
- * may result in different alignments between 32 and 64 bit
- * programs, since the 64 bit * bit kernel requires the user code
- * to have matching offsets
- */
-struct hfi1_base_info {
-	/* version of hardware, for feature checking. */
-	__u32 hw_version;
-	/* version of software, for feature checking. */
-	__u32 sw_version;
-	/* Job key */
-	__u16 jkey;
-	__u16 padding1;
-	/*
-	 * The special QP (queue pair) value that identifies PSM
-	 * protocol packet from standard IB packets.
-	 */
-	__u32 bthqp;
-	/* PIO credit return address, */
-	__aligned_u64 sc_credits_addr;
-	/*
-	 * Base address of write-only pio buffers for this process.
-	 * Each buffer has sendpio_credits*64 bytes.
-	 */
-	__aligned_u64 pio_bufbase_sop;
-	/*
-	 * Base address of write-only pio buffers for this process.
-	 * Each buffer has sendpio_credits*64 bytes.
-	 */
-	__aligned_u64 pio_bufbase;
-	/* address where receive buffer queue is mapped into */
-	__aligned_u64 rcvhdr_bufbase;
-	/* base address of Eager receive buffers. */
-	__aligned_u64 rcvegr_bufbase;
-	/* base address of SDMA completion ring */
-	__aligned_u64 sdma_comp_bufbase;
-	/*
-	 * User register base for init code, not to be used directly by
-	 * protocol or applications.  Always maps real chip register space.
-	 * the register addresses are:
-	 * ur_rcvhdrhead, ur_rcvhdrtail, ur_rcvegrhead, ur_rcvegrtail,
-	 * ur_rcvtidflow
-	 */
-	__aligned_u64 user_regbase;
-	/* notification events */
-	__aligned_u64 events_bufbase;
-	/* status page */
-	__aligned_u64 status_bufbase;
-	/* rcvhdrtail update */
-	__aligned_u64 rcvhdrtail_base;
-	/*
-	 * shared memory pages for subctxts if ctxt is shared; these cover
-	 * all the processes in the group sharing a single context.
-	 * all have enough space for the num_subcontexts value on this job.
-	 */
-	__aligned_u64 subctxt_uregbase;
-	__aligned_u64 subctxt_rcvegrbuf;
-	__aligned_u64 subctxt_rcvhdrbuf;
-};
-#endif /* _LINIUX__HFI1_IOCTL_H */
+#endif /* _LINUX__HFI1_IOCTL_H */
diff --git a/include/uapi/rdma/hfi/hfi1_user.h b/include/uapi/rdma/hfi/hfi1_user.h
deleted file mode 100644
index 1106a7c90b29..000000000000
--- a/include/uapi/rdma/hfi/hfi1_user.h
+++ /dev/null
@@ -1,268 +0,0 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-/*
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright(c) 2015 - 2020 Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Copyright(c) 2015 Intel Corporation.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
- * This file contains defines, structures, etc. that are used
- * to communicate between kernel and user code.
- */
-
-#ifndef _LINUX__HFI1_USER_H
-#define _LINUX__HFI1_USER_H
-
-#include <linux/types.h>
-#include <rdma/rdma_user_ioctl.h>
-
-/*
- * This version number is given to the driver by the user code during
- * initialization in the spu_userversion field of hfi1_user_info, so
- * the driver can check for compatibility with user code.
- *
- * The major version changes when data structures change in an incompatible
- * way. The driver must be the same for initialization to succeed.
- */
-#define HFI1_USER_SWMAJOR 6
-
-/*
- * Minor version differences are always compatible
- * a within a major version, however if user software is larger
- * than driver software, some new features and/or structure fields
- * may not be implemented; the user code must deal with this if it
- * cares, or it must abort after initialization reports the difference.
- */
-#define HFI1_USER_SWMINOR 3
-
-/*
- * We will encode the major/minor inside a single 32bit version number.
- */
-#define HFI1_SWMAJOR_SHIFT 16
-
-/*
- * Set of HW and driver capability/feature bits.
- * These bit values are used to configure enabled/disabled HW and
- * driver features. The same set of bits are communicated to user
- * space.
- */
-#define HFI1_CAP_DMA_RTAIL        (1UL <<  0) /* Use DMA'ed RTail value */
-#define HFI1_CAP_SDMA             (1UL <<  1) /* Enable SDMA support */
-#define HFI1_CAP_SDMA_AHG         (1UL <<  2) /* Enable SDMA AHG support */
-#define HFI1_CAP_EXTENDED_PSN     (1UL <<  3) /* Enable Extended PSN support */
-#define HFI1_CAP_HDRSUPP          (1UL <<  4) /* Enable Header Suppression */
-#define HFI1_CAP_TID_RDMA         (1UL <<  5) /* Enable TID RDMA operations */
-#define HFI1_CAP_USE_SDMA_HEAD    (1UL <<  6) /* DMA Hdr Q tail vs. use CSR */
-#define HFI1_CAP_MULTI_PKT_EGR    (1UL <<  7) /* Enable multi-packet Egr buffs*/
-#define HFI1_CAP_NODROP_RHQ_FULL  (1UL <<  8) /* Don't drop on Hdr Q full */
-#define HFI1_CAP_NODROP_EGR_FULL  (1UL <<  9) /* Don't drop on EGR buffs full */
-#define HFI1_CAP_TID_UNMAP        (1UL << 10) /* Disable Expected TID caching */
-#define HFI1_CAP_PRINT_UNIMPL     (1UL << 11) /* Show for unimplemented feats */
-#define HFI1_CAP_ALLOW_PERM_JKEY  (1UL << 12) /* Allow use of permissive JKEY */
-#define HFI1_CAP_NO_INTEGRITY     (1UL << 13) /* Enable ctxt integrity checks */
-#define HFI1_CAP_PKEY_CHECK       (1UL << 14) /* Enable ctxt PKey checking */
-#define HFI1_CAP_STATIC_RATE_CTRL (1UL << 15) /* Allow PBC.StaticRateControl */
-#define HFI1_CAP_OPFN             (1UL << 16) /* Enable the OPFN protocol */
-#define HFI1_CAP_SDMA_HEAD_CHECK  (1UL << 17) /* SDMA head checking */
-#define HFI1_CAP_EARLY_CREDIT_RETURN (1UL << 18) /* early credit return */
-#define HFI1_CAP_AIP              (1UL << 19) /* Enable accelerated IP */
-
-#define HFI1_RCVHDR_ENTSIZE_2    (1UL << 0)
-#define HFI1_RCVHDR_ENTSIZE_16   (1UL << 1)
-#define HFI1_RCVDHR_ENTSIZE_32   (1UL << 2)
-
-#define _HFI1_EVENT_FROZEN_BIT         0
-#define _HFI1_EVENT_LINKDOWN_BIT       1
-#define _HFI1_EVENT_LID_CHANGE_BIT     2
-#define _HFI1_EVENT_LMC_CHANGE_BIT     3
-#define _HFI1_EVENT_SL2VL_CHANGE_BIT   4
-#define _HFI1_EVENT_TID_MMU_NOTIFY_BIT 5
-#define _HFI1_MAX_EVENT_BIT _HFI1_EVENT_TID_MMU_NOTIFY_BIT
-
-#define HFI1_EVENT_FROZEN            (1UL << _HFI1_EVENT_FROZEN_BIT)
-#define HFI1_EVENT_LINKDOWN          (1UL << _HFI1_EVENT_LINKDOWN_BIT)
-#define HFI1_EVENT_LID_CHANGE        (1UL << _HFI1_EVENT_LID_CHANGE_BIT)
-#define HFI1_EVENT_LMC_CHANGE        (1UL << _HFI1_EVENT_LMC_CHANGE_BIT)
-#define HFI1_EVENT_SL2VL_CHANGE      (1UL << _HFI1_EVENT_SL2VL_CHANGE_BIT)
-#define HFI1_EVENT_TID_MMU_NOTIFY    (1UL << _HFI1_EVENT_TID_MMU_NOTIFY_BIT)
-
-/*
- * These are the status bits readable (in ASCII form, 64bit value)
- * from the "status" sysfs file.  For binary compatibility, values
- * must remain as is; removed states can be reused for different
- * purposes.
- */
-#define HFI1_STATUS_INITTED       0x1    /* basic initialization done */
-/* Chip has been found and initialized */
-#define HFI1_STATUS_CHIP_PRESENT 0x20
-/* IB link is at ACTIVE, usable for data traffic */
-#define HFI1_STATUS_IB_READY     0x40
-/* link is configured, LID, MTU, etc. have been set */
-#define HFI1_STATUS_IB_CONF      0x80
-/* A Fatal hardware error has occurred. */
-#define HFI1_STATUS_HWERROR     0x200
-
-/*
- * Number of supported shared contexts.
- * This is the maximum number of software contexts that can share
- * a hardware send/receive context.
- */
-#define HFI1_MAX_SHARED_CTXTS 8
-
-/*
- * Poll types
- */
-#define HFI1_POLL_TYPE_ANYRCV     0x0
-#define HFI1_POLL_TYPE_URGENT     0x1
-
-enum hfi1_sdma_comp_state {
-	FREE = 0,
-	QUEUED,
-	COMPLETE,
-	ERROR
-};
-
-/*
- * SDMA completion ring entry
- */
-struct hfi1_sdma_comp_entry {
-	__u32 status;
-	__u32 errcode;
-};
-
-/*
- * Device status and notifications from driver to user-space.
- */
-struct hfi1_status {
-	__aligned_u64 dev;      /* device/hw status bits */
-	__aligned_u64 port;     /* port state and status bits */
-	char freezemsg[];
-};
-
-enum sdma_req_opcode {
-	EXPECTED = 0,
-	EAGER
-};
-
-#define HFI1_SDMA_REQ_VERSION_MASK 0xF
-#define HFI1_SDMA_REQ_VERSION_SHIFT 0x0
-#define HFI1_SDMA_REQ_OPCODE_MASK 0xF
-#define HFI1_SDMA_REQ_OPCODE_SHIFT 0x4
-#define HFI1_SDMA_REQ_IOVCNT_MASK 0xFF
-#define HFI1_SDMA_REQ_IOVCNT_SHIFT 0x8
-
-struct sdma_req_info {
-	/*
-	 * bits 0-3 - version (currently unused)
-	 * bits 4-7 - opcode (enum sdma_req_opcode)
-	 * bits 8-15 - io vector count
-	 */
-	__u16 ctrl;
-	/*
-	 * Number of fragments contained in this request.
-	 * User-space has already computed how many
-	 * fragment-sized packet the user buffer will be
-	 * split into.
-	 */
-	__u16 npkts;
-	/*
-	 * Size of each fragment the user buffer will be
-	 * split into.
-	 */
-	__u16 fragsize;
-	/*
-	 * Index of the slot in the SDMA completion ring
-	 * this request should be using. User-space is
-	 * in charge of managing its own ring.
-	 */
-	__u16 comp_idx;
-} __attribute__((__packed__));
-
-/*
- * SW KDETH header.
- * swdata is SW defined portion.
- */
-struct hfi1_kdeth_header {
-	__le32 ver_tid_offset;
-	__le16 jkey;
-	__le16 hcrc;
-	__le32 swdata[7];
-}  __attribute__((__packed__));
-
-/*
- * Structure describing the headers that User space uses. The
- * structure above is a subset of this one.
- */
-struct hfi1_pkt_header {
-	__le16 pbc[4];
-	__be16 lrh[4];
-	__be32 bth[3];
-	struct hfi1_kdeth_header kdeth;
-}  __attribute__((__packed__));
-
-
-/*
- * The list of usermode accessible registers.
- */
-enum hfi1_ureg {
-	/* (RO)  DMA RcvHdr to be used next. */
-	ur_rcvhdrtail = 0,
-	/* (RW)  RcvHdr entry to be processed next by host. */
-	ur_rcvhdrhead = 1,
-	/* (RO)  Index of next Eager index to use. */
-	ur_rcvegrindextail = 2,
-	/* (RW)  Eager TID to be processed next */
-	ur_rcvegrindexhead = 3,
-	/* (RO)  Receive Eager Offset Tail */
-	ur_rcvegroffsettail = 4,
-	/* For internal use only; max register number. */
-	ur_maxreg,
-	/* (RW)  Receive TID flow table */
-	ur_rcvtidflowtable = 256
-};
-
-#endif /* _LINIUX__HFI1_USER_H */
diff --git a/include/uapi/rdma/hfi2-abi.h b/include/uapi/rdma/hfi2-abi.h
new file mode 100644
index 000000000000..a3d906759730
--- /dev/null
+++ b/include/uapi/rdma/hfi2-abi.h
@@ -0,0 +1,726 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _LINUX_HFI2_USER_H
+#define _LINUX_HFI2_USER_H
+
+#include <linux/types.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+#include <rdma/rdma_user_ioctl.h>
+
+/*
+ * This version number is given to the driver by the user code during
+ * initialization in the spu_userversion field of hfi2_user_info, so
+ * the driver can check for compatibility with user code.
+ *
+ * The major version changes when data structures change in an incompatible
+ * way. The driver must be the same for initialization to succeed.
+ */
+#define HFI2_USER_SWMAJOR 6
+#define HFI2_RDMA_USER_SWMAJOR 10
+
+/*
+ * Minor version differences are always compatible
+ * a within a major version, however if user software is larger
+ * than driver software, some new features and/or structure fields
+ * may not be implemented; the user code must deal with this if it
+ * cares, or it must abort after initialization reports the difference.
+ */
+#define HFI2_USER_SWMINOR 3
+#define HFI2_RDMA_USER_SWMINOR 0
+
+/*
+ * We will encode the major/minor inside a single 32bit version number.
+ */
+#define HFI2_SWMAJOR_SHIFT 16
+
+/*
+ * Set of HW and driver capability/feature bits.
+ * These bit values are used to configure enabled/disabled HW and
+ * driver features. The same set of bits are communicated to user
+ * space.
+ */
+#define HFI2_CAP_DMA_RTAIL        (1UL <<  0) /* Use DMA'ed RTail value */
+#define HFI2_CAP_SDMA             (1UL <<  1) /* Enable SDMA support */
+#define HFI2_CAP_SDMA_AHG         (1UL <<  2) /* Enable SDMA AHG support */
+#define HFI2_CAP_EXTENDED_PSN     (1UL <<  3) /* Enable Extended PSN support */
+#define HFI2_CAP_HDRSUPP          (1UL <<  4) /* Enable Header Suppression */
+#define HFI2_CAP_TID_RDMA         (1UL <<  5) /* Enable TID RDMA operations */
+#define HFI2_CAP_USE_SDMA_HEAD    (1UL <<  6) /* DMA Hdr Q tail vs. use CSR */
+#define HFI2_CAP_MULTI_PKT_EGR    (1UL <<  7) /* Enable multi-packet Egr buffs*/
+#define HFI2_CAP_NODROP_RHQ_FULL  (1UL <<  8) /* Don't drop on Hdr Q full */
+#define HFI2_CAP_NODROP_EGR_FULL  (1UL <<  9) /* Don't drop on EGR buffs full */
+#define HFI2_CAP_TID_UNMAP        (1UL << 10) /* Disable Expected TID caching */
+#define HFI2_CAP_PRINT_UNIMPL     (1UL << 11) /* Show for unimplemented feats */
+#define HFI2_CAP_ALLOW_PERM_JKEY  (1UL << 12) /* Allow use of permissive JKEY */
+#define HFI2_CAP_NO_INTEGRITY     (1UL << 13) /* Enable ctxt integrity checks */
+#define HFI2_CAP_PKEY_CHECK       (1UL << 14) /* Enable ctxt PKey checking */
+#define HFI2_CAP_STATIC_RATE_CTRL (1UL << 15) /* Allow PBC.StaticRateControl */
+#define HFI2_CAP_OPFN             (1UL << 16) /* Enable the OPFN protocol */
+#define HFI2_CAP_SDMA_HEAD_CHECK  (1UL << 17) /* SDMA head checking */
+#define HFI2_CAP_EARLY_CREDIT_RETURN (1UL << 18) /* early credit return */
+#define HFI2_CAP_AIP              (1UL << 19) /* Enable accelerated IP */
+
+#define HFI2_RCVHDR_ENTSIZE_2    (1UL << 0)
+#define HFI2_RCVHDR_ENTSIZE_16   (1UL << 1)
+#define HFI2_RCVDHR_ENTSIZE_32   (1UL << 2)
+
+#define _HFI2_EVENT_FROZEN_BIT         0
+#define _HFI2_EVENT_LINKDOWN_BIT       1
+#define _HFI2_EVENT_LID_CHANGE_BIT     2
+#define _HFI2_EVENT_LMC_CHANGE_BIT     3
+#define _HFI2_EVENT_SL2VL_CHANGE_BIT   4
+#define _HFI2_EVENT_TID_MMU_NOTIFY_BIT 5
+#define _HFI2_MAX_EVENT_BIT _HFI2_EVENT_TID_MMU_NOTIFY_BIT
+
+#define HFI2_EVENT_FROZEN            (1UL << _HFI2_EVENT_FROZEN_BIT)
+#define HFI2_EVENT_LINKDOWN          (1UL << _HFI2_EVENT_LINKDOWN_BIT)
+#define HFI2_EVENT_LID_CHANGE        (1UL << _HFI2_EVENT_LID_CHANGE_BIT)
+#define HFI2_EVENT_LMC_CHANGE        (1UL << _HFI2_EVENT_LMC_CHANGE_BIT)
+#define HFI2_EVENT_SL2VL_CHANGE      (1UL << _HFI2_EVENT_SL2VL_CHANGE_BIT)
+#define HFI2_EVENT_TID_MMU_NOTIFY    (1UL << _HFI2_EVENT_TID_MMU_NOTIFY_BIT)
+
+/*
+ * These are the status bits readable (in ASCII form, 64bit value)
+ * from the "status" sysfs file.  For binary compatibility, values
+ * must remain as is; removed states can be reused for different
+ * purposes.
+ */
+#define HFI2_STATUS_INITTED       0x1    /* basic initialization done */
+/* Chip has been found and initialized */
+#define HFI2_STATUS_CHIP_PRESENT 0x20
+/* IB link is at ACTIVE, usable for data traffic */
+#define HFI2_STATUS_IB_READY     0x40
+/* link is configured, LID, MTU, etc. have been set */
+#define HFI2_STATUS_IB_CONF      0x80
+/* A Fatal hardware error has occurred. */
+#define HFI2_STATUS_HWERROR     0x200
+
+/*
+ * Number of supported shared contexts.
+ * This is the maximum number of software contexts that can share
+ * a hardware send/receive context.
+ */
+#define HFI2_MAX_SHARED_CTXTS 8
+
+/*
+ * Poll types
+ */
+#define HFI2_POLL_TYPE_ANYRCV     0x0
+#define HFI2_POLL_TYPE_URGENT     0x1
+
+enum hfi2_sdma_comp_state {
+	FREE = 0,
+	QUEUED,
+	COMPLETE,
+	ERROR
+};
+
+/*
+ * SDMA completion ring entry
+ */
+struct hfi2_sdma_comp_entry {
+	__u32 status;
+	__u32 errcode;
+};
+
+/*
+ * Device status and notifications from driver to user-space.
+ * hfi1 and hfi2 status are different.
+ */
+struct hfi1_status {
+	__aligned_u64 dev;      /* device/hw status bits */
+	__aligned_u64 port;     /* port state and status bits */
+	char freezemsg[];
+};
+
+struct hfi2_status {
+	__aligned_u64 dev;      /* device/hw status bits */
+	__aligned_u64 ports[];  /* port state and status bits */
+};
+
+enum sdma_req_opcode {
+	EXPECTED = 0,
+	EAGER
+};
+
+#define HFI2_SDMA_REQ_VERSION_MASK 0xF
+#define HFI2_SDMA_REQ_VERSION_SHIFT 0x0
+#define HFI2_SDMA_REQ_OPCODE_MASK 0xF
+#define HFI2_SDMA_REQ_OPCODE_SHIFT 0x4
+#define HFI2_SDMA_REQ_IOVCNT_MASK 0x7F
+#define HFI2_SDMA_REQ_IOVCNT_SHIFT 0x8
+#define HFI2_SDMA_REQ_MEMINFO_MASK 0x1
+#define HFI2_SDMA_REQ_MEMINFO_SHIFT 0xF
+
+struct sdma_req_info {
+	/*
+	 * bits 0-3 - version (currently unused)
+	 * bits 4-7 - opcode (enum sdma_req_opcode)
+	 * bits 8-14 - io vector count
+	 * bit  15 - meminfo present
+	 */
+	__u16 ctrl;
+	/*
+	 * Number of fragments contained in this request.
+	 * User-space has already computed how many
+	 * fragment-sized packet the user buffer will be
+	 * split into.
+	 */
+	__u16 npkts;
+	/*
+	 * Size of each fragment the user buffer will be
+	 * split into.
+	 */
+	__u16 fragsize;
+	/*
+	 * Index of the slot in the SDMA completion ring
+	 * this request should be using. User-space is
+	 * in charge of managing its own ring.
+	 */
+	__u16 comp_idx;
+} __attribute__((__packed__));
+
+#define HFI2_MEMINFO_TYPE_ENTRY_BITS 4
+#define HFI2_MEMINFO_TYPE_ENTRY_MASK ((1 << HFI2_MEMINFO_TYPE_ENTRY_BITS) - 1)
+#define HFI2_MEMINFO_TYPE_ENTRY_GET(m, n)              \
+	(((m) >> ((n) * HFI2_MEMINFO_TYPE_ENTRY_BITS)) & \
+	 HFI2_MEMINFO_TYPE_ENTRY_MASK)
+#define HFI2_MEMINFO_TYPE_ENTRY_SET(m, n, e)    \
+	((m) |= ((e) & HFI2_MEMINFO_TYPE_ENTRY_MASK) \
+	     << ((n) * HFI2_MEMINFO_TYPE_ENTRY_BITS))
+#define HFI2_MAX_MEMINFO_ENTRIES \
+	(sizeof(__u64) * 8 / HFI2_MEMINFO_TYPE_ENTRY_BITS)
+
+#define HFI2_MEMINFO_TYPE_SYSTEM 0
+
+struct sdma_req_meminfo {
+	/*
+	 * Packed memory type indicators for each data iovec entry.
+	 */
+	__u64 types;
+	/*
+	 * Type-specific context for each data iovec entry.
+	 */
+	__u64 context[HFI2_MAX_MEMINFO_ENTRIES];
+};
+
+/*
+ * SW KDETH header.
+ * swdata is SW defined portion.
+ */
+struct hfi2_kdeth_header {
+	__le32 ver_tid_offset;
+	__le16 jkey;
+	__le16 hcrc;
+	__le32 swdata[7];
+}  __attribute__((__packed__));
+
+/*
+ * Structure describing the headers that User space uses. The
+ * structure above is a subset of this one.
+ */
+struct hfi2_pkt_header {
+	__le16 pbc[4];
+	__be16 lrh[4];
+	__be32 bth[3];
+	struct hfi2_kdeth_header kdeth;
+}  __attribute__((__packed__));
+
+
+/*
+ * The list of usermode accessible registers.
+ */
+enum hfi2_ureg {
+	/* (RO)  DMA RcvHdr to be used next. */
+	ur_rcvhdrtail = 0,
+	/* (RW)  RcvHdr entry to be processed next by host. */
+	ur_rcvhdrhead = 1,
+	/* (RO)  Index of next Eager index to use. */
+	ur_rcvegrindextail = 2,
+	/* (RW)  Eager TID to be processed next */
+	ur_rcvegrindexhead = 3,
+	/* (RO)  Receive Eager Offset Tail */
+	ur_rcvegroffsettail = 4,
+	/* For internal use only; max register number. */
+	ur_maxreg,
+	/* (RW)  Receive TID flow table */
+	ur_rcvtidflowtable = 256
+};
+
+/*
+ * This structure is passed to the driver to tell it where
+ * user code buffers are, sizes, etc.   The offsets and sizes of the
+ * fields must remain unchanged, for binary compatibility.  It can
+ * be extended, if userversion is changed so user code can tell, if needed
+ */
+struct hfi2_user_info {
+	/*
+	 * version of user software, to detect compatibility issues.
+	 * Should be set to HFI2_USER_SWVERSION.
+	 */
+	__u32 userversion;
+	__u32 pad; /* Port Address */
+	/*
+	 * If two or more processes wish to share a context, each process
+	 * must set the subcontext_cnt and subcontext_id to the same
+	 * values.  The only restriction on the subcontext_id is that
+	 * it be unique for a given node.
+	 */
+	__u16 subctxt_cnt;
+	__u16 subctxt_id;
+	/* 128bit UUID passed in by PSM. */
+	__u8 uuid[16];
+};
+
+struct hfi2_ctxt_info {
+	__aligned_u64 runtime_flags;    /* chip/drv runtime flags (HFI2_CAP_*) */
+	__u32 rcvegr_size;      /* size of each eager buffer */
+	__u16 num_active;       /* number of active units */
+	__u16 unit;             /* unit (chip) assigned to caller */
+	__u16 ctxt;             /* ctxt on unit assigned to caller */
+	__u16 subctxt;          /* subctxt on unit assigned to caller */
+	__u16 rcvtids;          /* number of Rcv TIDs for this context */
+	__u16 credits;          /* number of PIO credits for this context */
+	__u16 numa_node;        /* NUMA node of the assigned device */
+	__u16 rec_cpu;          /* cpu # for affinity (0xffff if none) */
+	__u16 send_ctxt;        /* send context in use by this user context */
+	__u16 egrtids;          /* number of RcvArray entries for Eager Rcvs */
+	__u16 rcvhdrq_cnt;      /* number of RcvHdrQ entries */
+	__u16 rcvhdrq_entsize;  /* size (in bytes) for each RcvHdrQ entry */
+	__u16 sdma_ring_size;   /* number of entries in SDMA request ring */
+};
+
+struct hfi1_tid_info {
+	/* virtual address of first page in transfer */
+	__aligned_u64 vaddr;
+	/* pointer to tid array. this array is big enough */
+	__aligned_u64 tidlist;
+	/* number of tids programmed by this request */
+	__u32 tidcnt;
+	/* length of transfer buffer programmed by this request */
+	__u32 length;
+};
+
+#define HFI2_TID_UPDATE_FLAGS_MEMINFO_BITS 4
+#define HFI2_TID_UPDATE_FLAGS_MEMINFO_MASK ((1UL << HFI2_TID_UPDATE_FLAGS_MEMINFO_BITS) - 1)
+#define HFI2_TID_UPDATE_FLAGS_RESERVED_MASK (~(__u64)(HFI2_TID_UPDATE_FLAGS_MEMINFO_MASK))
+
+struct hfi2_tid_info {
+	/* virtual address of first page in transfer */
+	__aligned_u64 vaddr;
+	/* pointer to tid array. this array is big enough */
+	__aligned_u64 tidlist;
+	/* number of tids programmed by this request */
+	__u32 tidcnt;
+	/* length of transfer buffer programmed by this request */
+	__u32 length;
+
+	/*
+	 * bits 0-3 memory_type
+	 *   memory_type=0 will always mean system memory
+	 *   See HFI2_MEMINFO_TYPE* defines
+	 * bits 4-63 reserved; must be 0
+	 */
+	__aligned_u64 flags;
+	/* Reserved; must be 0 */
+	__aligned_u64 context;
+};
+
+/*
+ * This structure is returned by the driver immediately after
+ * open to get implementation-specific info, and info specific to this
+ * instance.
+ *
+ * This struct must have explicit padding fields where type sizes
+ * may result in different alignments between 32 and 64 bit
+ * programs, since the 64 bit * bit kernel requires the user code
+ * to have matching offsets
+ */
+struct hfi2_base_info {
+	/* version of hardware, for feature checking. */
+	__u32 hw_version;
+	/* version of software, for feature checking. */
+	__u32 sw_version;
+	/* Job key */
+	__u16 jkey;
+	__u16 padding1;
+	/*
+	 * The special QP (queue pair) value that identifies PSM
+	 * protocol packet from standard IB packets.
+	 */
+	__u32 bthqp;
+	/* PIO credit return address, */
+	__aligned_u64 sc_credits_addr;
+	/*
+	 * Base address of write-only pio buffers for this process.
+	 * Each buffer has sendpio_credits*64 bytes.
+	 */
+	__aligned_u64 pio_bufbase_sop;
+	/*
+	 * Base address of write-only pio buffers for this process.
+	 * Each buffer has sendpio_credits*64 bytes.
+	 */
+	__aligned_u64 pio_bufbase;
+	/* address where receive buffer queue is mapped into */
+	__aligned_u64 rcvhdr_bufbase;
+	/* base address of Eager receive buffers. */
+	__aligned_u64 rcvegr_bufbase;
+	/* base address of SDMA completion ring */
+	__aligned_u64 sdma_comp_bufbase;
+	/*
+	 * User register base for init code, not to be used directly by
+	 * protocol or applications.  Always maps real chip register space.
+	 * the register addresses are:
+	 * ur_rcvhdrhead, ur_rcvhdrtail, ur_rcvegrhead, ur_rcvegrtail,
+	 * ur_rcvtidflow
+	 */
+	__aligned_u64 user_regbase;
+	/* notification events */
+	__aligned_u64 events_bufbase;
+	/* status page */
+	__aligned_u64 status_bufbase;
+	/* rcvhdrtail update */
+	__aligned_u64 rcvhdrtail_base;
+	/*
+	 * shared memory pages for subctxts if ctxt is shared; these cover
+	 * all the processes in the group sharing a single context.
+	 * all have enough space for the num_subcontexts value on this job.
+	 */
+	__aligned_u64 subctxt_uregbase;
+	__aligned_u64 subctxt_rcvegrbuf;
+	__aligned_u64 subctxt_rcvhdrbuf;
+};
+
+struct hfi2_pin_stats {
+	int memtype;
+	/*
+	 * If -1, driver returns total number of stats entries for the given
+	 * memtype, otherwise returns stats for the given { memtype, index }.
+	 */
+	int index;
+	__u64 id;
+	__u64 cache_entries;
+	__u64 total_refcounts;
+	__u64 total_bytes;
+	__u64 hits;
+	__u64 misses;
+	__u64 hint_hits;
+	__u64 hint_misses;
+	__u64 internal_evictions; /* due to self-imposed size limit */
+	__u64 external_evictions; /* system-driven evictions */
+};
+
+/*
+ * RDMA character device ioctls
+ */
+
+/* verbs objects */
+enum hfi2_objects {
+	HFI2_OBJECT_DV0 = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_OBJECT_DV1,
+};
+
+/* methods for custom objects dv0 and dv1 - max of 8 per object */
+enum hfi2_methods_dv0 {
+	HFI2_METHOD_ASSIGN_CTXT = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_METHOD_CTXT_INFO,
+	HFI2_METHOD_USER_INFO,
+	HFI2_METHOD_TID_UPDATE,
+	HFI2_METHOD_TID_FREE,
+	HFI2_METHOD_CREDIT_UPD,
+	HFI2_METHOD_RECV_CTRL,
+	HFI2_METHOD_POLL_TYPE,
+};
+
+enum hfi2_methods_dv1 {
+	HFI2_METHOD_ACK_EVENT = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_METHOD_SET_PKEY,
+	HFI2_METHOD_CTXT_RESET,
+	HFI2_METHOD_TID_INVAL_READ,
+	HFI2_METHOD_GET_VERS,
+	HFI2_METHOD_PIN_STATS,
+};
+
+/*
+ * assign_ctxt
+ */
+enum hfi2_attrs_assign_ctxt {
+	HFI2_ATTR_ASSIGN_CTXT_CMD = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+struct hfi2_assign_ctxt_cmd {
+	__u32 userversion;	/* user library version */
+	__u8 port;		/* target port number */
+	__u8 kdeth_rcvhdrsz;	/* 0 means default */
+	__u16 reserved1;
+	__u16 subctxt_cnt;
+	__u16 subctxt_id;
+	__u8 uuid[16];		/* 128bit UUID */
+	__u32 reserved2;
+};
+
+/*
+ * ctxt_info
+ */
+enum hfi2_attrs_ctxt_info {
+	HFI2_ATTR_CTXT_INFO_RSP = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+struct hfi2_ctxt_info_rsp {
+	__aligned_u64 runtime_flags; /* chip/drv runtime flags (HFI2_CAP_*) */
+
+	__u32 rcvegr_size;      /* size of each eager buffer */
+	__u16 num_active;       /* number of active units */
+	__u16 unit;             /* unit (chip) assigned to caller */
+
+	__u16 ctxt;             /* ctxt on unit assigned to caller */
+	__u16 subctxt;          /* subctxt on unit assigned to caller */
+	__u16 rcvtids;          /* number of Rcv TIDs for this context */
+	__u16 credits;          /* number of PIO credits for this context */
+
+	__u16 numa_node;        /* NUMA node of the assigned device */
+	__u16 rec_cpu;          /* cpu # for affinity (0xffff if none) */
+	__u16 send_ctxt;        /* send context in use by this user context */
+	__u16 egrtids;          /* number of RcvArray entries for Eager Rcvs */
+
+	__u16 rcvhdrq_cnt;      /* number of RcvHdrQ entries */
+	__u16 rcvhdrq_entsize;  /* size (in bytes) for each RcvHdrQ entry */
+	__u16 sdma_ring_size;   /* number of entries in SDMA request ring */
+	__u16 reserved;
+};
+
+/*
+ * user_info
+ */
+enum hfi2_attrs_user_info {
+	HFI2_ATTR_USER_INFO_RSP = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+/*
+ * Returns both general and specific information to this device open.
+ */
+struct hfi2_user_info_rsp {
+	/* version of hardware, for feature checking. */
+	__u32 hw_version;
+	/* version of software, for feature checking. */
+	__u32 sw_version;
+	/* Job key */
+	__u16 jkey;
+	__u16 reserved;
+	/*
+	 * The special QP (queue pair) value that identifies PSM/OPX
+	 * protocol packet from standard IB packets.
+	 */
+	__u32 bthqp;
+	/* PIO credit return address */
+	__aligned_u64 sc_credits_addr;
+	/*
+	 * Base address of write-only pio buffers for this process.
+	 * Each buffer has sendpio_credits*64 bytes.
+	 */
+	__aligned_u64 pio_bufbase_sop;
+	/*
+	 * Base address of write-only pio buffers for this process.
+	 * Each buffer has sendpio_credits*64 bytes.
+	 */
+	__aligned_u64 pio_bufbase;
+	/* address where receive buffer queue is mapped into */
+	__aligned_u64 rcvhdr_bufbase;
+	/* base address of Eager receive buffers. */
+	__aligned_u64 rcvegr_bufbase;
+	/* base address of SDMA completion ring */
+	__aligned_u64 sdma_comp_bufbase;
+	/*
+	 * User register base for init code, not to be used directly by
+	 * protocol or applications.  Always maps real chip register space.
+	 * the register addresses are:
+	 * ur_rcvhdrhead, ur_rcvhdrtail, ur_rcvegrhead, ur_rcvegrtail,
+	 * ur_rcvtidflow
+	 */
+	__aligned_u64 user_regbase;
+	/* notification events */
+	__aligned_u64 events_bufbase;
+	/* status page */
+	__aligned_u64 status_bufbase;
+	/* rcvhdrtail update */
+	__aligned_u64 rcvhdrtail_base;
+	/*
+	 * Shared memory pages for subctxts if ctxt is shared.  These cover
+	 * all the processes in the group sharing a single context.
+	 * All have enough space for the num_subcontexts value on this job.
+	 */
+	__aligned_u64 subctxt_uregbase;
+	__aligned_u64 subctxt_rcvegrbuf;
+	__aligned_u64 subctxt_rcvhdrbuf;
+	/* receive header error queue */
+	__aligned_u64 rheq_bufbase;
+};
+
+/*
+ * tid_update
+ */
+enum hfi2_attrs_tid_update {
+	HFI2_ATTR_TID_UPDATE_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_ATTR_TID_UPDATE_RSP,
+};
+
+struct hfi2_tid_update_cmd {
+	__aligned_u64 vaddr;	/* virtual address of buffer */
+	__aligned_u64 tidlist;	/* address of output tid array */
+	__u32 length;		/* buffer length, in bytes */
+	__u32 tidcnt;		/* tidlist size, in TIDs */
+	__aligned_u64 flags;	/* flags: [3:0] mem type, [63:4] reserved */
+	__aligned_u64 context;	/* reserved */
+};
+
+struct hfi2_tid_update_rsp {
+	__u32 length;		/* mapped buffer length */
+	__u32 tidcnt;		/* number of assigned TIDs */
+};
+
+/*
+ * tid_free
+ */
+enum hfi2_attrs_tid_free {
+	HFI2_ATTR_TID_FREE_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_ATTR_TID_FREE_RSP,
+};
+
+struct hfi2_tid_free_cmd {
+	__aligned_u64 tidlist;  /* user buffer pointer */
+	__u32 tidcnt;           /* number of TID entries in buffer */
+	__u32 reserved;
+};
+
+struct hfi2_tid_free_rsp {
+	__u32 tidcnt;		/* number actually freed */
+	__u32 reserved;
+};
+
+/*
+ * credit_upd
+ * (no arguments)
+ */
+
+/*
+ * recv_ctrl
+ */
+enum hfi2_attrs_recv_ctrl {
+	HFI2_ATTR_RECV_CTRL_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	/* no response */
+};
+
+struct hfi2_recv_ctrl_cmd {
+	__u8 start_stop;
+	__u8 reserved[7];
+};
+
+/*
+ * poll_type
+ */
+enum hfi2_attrs_poll_type {
+	HFI2_ATTR_POLL_TYPE_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	/* no response */
+};
+
+struct hfi2_poll_type_cmd {
+	__u32 poll_type;
+	__u32 reserved;
+};
+
+/*
+ * ack_event
+ */
+enum hfi2_attrs_ack_event {
+	HFI2_ATTR_ACK_EVENT_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	/* no response */
+};
+
+struct hfi2_ack_event_cmd {
+	__u64 event;
+};
+
+/*
+ * set_pkey
+ */
+enum hfi2_attrs_set_pkey {
+	HFI2_ATTR_SET_PKEY_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	/* no response */
+};
+
+struct hfi2_set_pkey_cmd {
+	__u16 pkey;
+	__u8 reserved[6];
+};
+
+/*
+ * ctxt_reset
+ * (no arguments)
+ */
+
+/*
+ * tid_inval_read
+ */
+enum hfi2_attrs_tid_inval_read {
+	HFI2_ATTR_TID_INVAL_READ_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_ATTR_TID_INVAL_READ_RSP,
+};
+
+struct hfi2_tid_inval_read_cmd {
+	__aligned_u64 tidlist;  /* user buffer pointer */
+	__u32 tidcnt;		/* space for this many TIDs */
+	__u32 reserved;
+};
+
+struct hfi2_tid_inval_read_rsp {
+	__u32 tidcnt;           /* numnber of returned tids */
+	__u32 reserved;
+};
+
+/*
+ * get_vers
+ */
+enum hfi2_attrs_get_vers {
+	/* no cmd */
+	HFI2_ATTR_GET_VERS_RSP = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+struct hfi2_get_vers_rsp {
+	__u32 version;
+	__u32 reserved;
+};
+
+/*
+ * pin_stats
+ */
+enum hfi2_attrs_pin_stats {
+	HFI2_ATTR_PIN_STATS_CMD = (1U << UVERBS_ID_NS_SHIFT),
+	HFI2_ATTR_PIN_STATS_RSP,
+};
+
+struct hfi2_pin_stats_cmd {
+	__u32 memtype;
+	/*
+	 * If -1, driver returns total number of stats entries for the given
+	 * memtype, otherwise returns stats for the given { memtype, index }.
+	 */
+	__s32 index;
+};
+
+struct hfi2_pin_stats_rsp {
+	__u64 id;
+	__u64 cache_entries;
+	__u64 total_refcounts;
+	__u64 total_bytes;
+	__u64 hits;
+	__u64 misses;
+	__u64 hint_hits;
+	__u64 hint_misses;
+	__u64 internal_evictions; /* due to self-imposed size limit */
+	__u64 external_evictions; /* system-driven evictions */
+};
+
+#endif /* _LINIUX_HFI2_USER_H */
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 89e6a3f13191..c7573131c862 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -256,6 +256,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_ERDMA,
 	RDMA_DRIVER_MANA,
 	RDMA_DRIVER_IONIC,
+	RDMA_DRIVER_HFI2,
 };
 
 enum ib_uverbs_gid_type {
diff --git a/include/uapi/rdma/rdma_user_ioctl.h b/include/uapi/rdma/rdma_user_ioctl.h
index 53c55188dd2a..263cace86f8f 100644
--- a/include/uapi/rdma/rdma_user_ioctl.h
+++ b/include/uapi/rdma/rdma_user_ioctl.h
@@ -39,47 +39,14 @@
 #include <rdma/rdma_user_ioctl_cmds.h>
 
 /* Legacy name, for user space application which already use it */
-#define IB_IOCTL_MAGIC		RDMA_IOCTL_MAGIC
-
-/*
- * General blocks assignments
- * It is closed on purpose - do not expose it to user space
- * #define MAD_CMD_BASE		0x00
- * #define HFI1_CMD_BAS		0xE0
- */
+#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
 
 /* MAD specific section */
-#define IB_USER_MAD_REGISTER_AGENT	_IOWR(RDMA_IOCTL_MAGIC, 0x01, struct ib_user_mad_reg_req)
-#define IB_USER_MAD_UNREGISTER_AGENT	_IOW(RDMA_IOCTL_MAGIC,  0x02, __u32)
-#define IB_USER_MAD_ENABLE_PKEY		_IO(RDMA_IOCTL_MAGIC,   0x03)
-#define IB_USER_MAD_REGISTER_AGENT2	_IOWR(RDMA_IOCTL_MAGIC, 0x04, struct ib_user_mad_reg_req2)
-
-/* HFI specific section */
-/* allocate HFI and context */
-#define HFI1_IOCTL_ASSIGN_CTXT		_IOWR(RDMA_IOCTL_MAGIC, 0xE1, struct hfi1_user_info)
-/* find out what resources we got */
-#define HFI1_IOCTL_CTXT_INFO		_IOW(RDMA_IOCTL_MAGIC,  0xE2, struct hfi1_ctxt_info)
-/* set up userspace */
-#define HFI1_IOCTL_USER_INFO		_IOW(RDMA_IOCTL_MAGIC,  0xE3, struct hfi1_base_info)
-/* update expected TID entries */
-#define HFI1_IOCTL_TID_UPDATE		_IOWR(RDMA_IOCTL_MAGIC, 0xE4, struct hfi1_tid_info)
-/* free expected TID entries */
-#define HFI1_IOCTL_TID_FREE		_IOWR(RDMA_IOCTL_MAGIC, 0xE5, struct hfi1_tid_info)
-/* force an update of PIO credit */
-#define HFI1_IOCTL_CREDIT_UPD		_IO(RDMA_IOCTL_MAGIC,   0xE6)
-/* control receipt of packets */
-#define HFI1_IOCTL_RECV_CTRL		_IOW(RDMA_IOCTL_MAGIC,  0xE8, int)
-/* set the kind of polling we want */
-#define HFI1_IOCTL_POLL_TYPE		_IOW(RDMA_IOCTL_MAGIC,  0xE9, int)
-/* ack & clear user status bits */
-#define HFI1_IOCTL_ACK_EVENT		_IOW(RDMA_IOCTL_MAGIC,  0xEA, unsigned long)
-/* set context's pkey */
-#define HFI1_IOCTL_SET_PKEY		_IOW(RDMA_IOCTL_MAGIC,  0xEB, __u16)
-/* reset context's HW send context */
-#define HFI1_IOCTL_CTXT_RESET		_IO(RDMA_IOCTL_MAGIC,   0xEC)
-/* read TID cache invalidations */
-#define HFI1_IOCTL_TID_INVAL_READ	_IOWR(RDMA_IOCTL_MAGIC, 0xED, struct hfi1_tid_info)
-/* get the version of the user cdev */
-#define HFI1_IOCTL_GET_VERS		_IOR(RDMA_IOCTL_MAGIC,  0xEE, int)
+#define IB_USER_MAD_REGISTER_AGENT \
+	_IOWR(RDMA_IOCTL_MAGIC, 0x01, struct ib_user_mad_reg_req)
+#define IB_USER_MAD_UNREGISTER_AGENT _IOW(RDMA_IOCTL_MAGIC, 0x02, __u32)
+#define IB_USER_MAD_ENABLE_PKEY _IO(RDMA_IOCTL_MAGIC, 0x03)
+#define IB_USER_MAD_REGISTER_AGENT2 \
+	_IOWR(RDMA_IOCTL_MAGIC, 0x04, struct ib_user_mad_reg_req2)
 
 #endif /* RDMA_USER_IOCTL_H */



