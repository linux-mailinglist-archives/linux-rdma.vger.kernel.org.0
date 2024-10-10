Return-Path: <linux-rdma+bounces-5358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FF99812E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1588283B29
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE51BD4E0;
	Thu, 10 Oct 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="KNOX376Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from va-2-33.ptr.blmpb.com (va-2-33.ptr.blmpb.com [209.127.231.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE101BBBC1
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550573; cv=none; b=gim5G7lto0azhwi4aiAaXNsEuojR7FQZD58+a49DU/Fixxd6mi2aI/loSMRNh9g2VPnARcsmYzZ/cAaq7+NoyVXMnHvasUGnfHYwHcgW1UFwmB92rY+Axt8j9uWDo6qOpihPeS8msWEnG0ZfLx3EW/jwq3YufawZUECKDxc0byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550573; c=relaxed/simple;
	bh=/0sjkybflWzgyr6FyRk7PXvHj4emX5DyqCjcpkicu3I=;
	h=Cc:Subject:To:From:Content-Type:Date:Message-Id:Mime-Version; b=UgnzavlacZdJP8HhlPYEGZgm5F7psSXVWQc7D+qa5ubEpIo4z9LnyTtL5TpU72BXM7jjoB8+NU90u+v/OZ7SRfGt+JHV2UwJy3Mq7+o3MKviZ9o4u4xk07cPgu9W1HlYxqaSA5tzNijJQT2wPG/0xDGiFMVSmSd//PK7BxcJ74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=KNOX376Q; arc=none smtp.client-ip=209.127.231.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1728547862; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=r0DagfQsX8qsCeA2Nmyp4iUD1k/SjF2umfslZ1GYB0U=;
 b=KNOX376Q6v73mwcPbiLa9QYqgwXk6KDJlePwTZ0fFXxRgsY4L1yN0K0qc2wOEekgllVxaA
 mKBfLnGwBkr+WEOjNkrzNdicwjT34Beu5EHSA4TKjgJqBcvDo2ppfMN39BWySDhooA4uTT
 UiCEd8dc5wp1XzukimRCfkpEF53mAcKvC1MNzxUAyFstc4JRr/WMWwjZs/IF1tkZ0qJk1B
 hSRxzfTvsqAyYd5ontb0xkLEUSiuE6lLIrZsAH4WWHB3ox5kcGDbEBrPUBvkMdIT4xjdSp
 wKnwUFDmeLZY9mHib3pPBEFGnAyTyKSBCA3TmrzdTRtqa3JD1TZ0U7rcyUjqKg==
Cc: <linux-rdma@vger.kernel.org>, "Tian Xin" <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Subject: [PATCH 6/6] libxscale: Add xscale needed kernel headers
X-Mailer: git-send-email 2.25.1
To: <leonro@nvidia.com>, <jgg@nvidia.com>
From: "Tian Xin" <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 10 Oct 2024 16:11:01 +0800
X-Lms-Return-Path: <lba+267078c16+c6eb4e+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Oct 2024 16:10:49 +0800
Message-Id: <20241010081049.1448826-7-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

This patch adds xscale needed kernel abi headers into
the kernel-headers directory.

Signed-off-by: Tian Xin <tianx@yunsilicon.com>
Signed-off-by: Wei Honggang <weihg@yunsilicon.com>
Signed-off-by: Zhao Qianwei <zhaoqw@yunsilicon.com>
Signed-off-by: Li Qiang <liq@yunsilicon.com>
Signed-off-by: Yan Lei <jacky@yunsilicon.com>
---
 kernel-headers/CMakeLists.txt             |  2 +
 kernel-headers/rdma/ib_user_ioctl_verbs.h |  1 +
 kernel-headers/rdma/xsc-abi.h             | 74 +++++++++++++++++++++++
 libibverbs/verbs.h                        |  1 +
 4 files changed, 78 insertions(+)
 create mode 100644 kernel-headers/rdma/xsc-abi.h

diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 82c191ca..56eb3984 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -26,6 +26,7 @@ publish_internal_headers(rdma
   rdma/rvt-abi.h
   rdma/siw-abi.h
   rdma/vmw_pvrdma-abi.h
+  rdma/xsc-abi.h
   )
 
 publish_internal_headers(rdma/hfi
@@ -80,6 +81,7 @@ rdma_kernel_provider_abi(
   rdma/rdma_user_rxe.h
   rdma/siw-abi.h
   rdma/vmw_pvrdma-abi.h
+  rdma/xsc-abi.h
   )
 
 publish_headers(infiniband
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index fe15bc7e..9f36fcf1 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -255,6 +255,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 	RDMA_DRIVER_ERDMA,
 	RDMA_DRIVER_MANA,
+	RDMA_DRIVER_XSC,
 };
 
 enum ib_uverbs_gid_type {
diff --git a/kernel-headers/rdma/xsc-abi.h b/kernel-headers/rdma/xsc-abi.h
new file mode 100644
index 00000000..456d6c47
--- /dev/null
+++ b/kernel-headers/rdma/xsc-abi.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_ABI_USER_H
+#define XSC_ABI_USER_H
+
+#include <linux/types.h>
+#include <linux/if_ether.h>	/* For ETH_ALEN. */
+#include <rdma/ib_user_ioctl_verbs.h>
+
+/* Make sure that all structs defined in this file remain laid out so
+ * that they pack the same way on 32-bit and 64-bit architectures (to
+ * avoid incompatibility between 32-bit userspace and 64-bit kernels).
+ * In particular do not use pointer types -- pass pointers in __u64
+ * instead.
+ */
+
+struct xsc_ib_alloc_ucontext_resp {
+	__u32	qp_tab_size;
+	__u32	cache_line_size;
+	__u16	max_sq_desc_sz;
+	__u16	max_rq_desc_sz;
+	__u32	max_send_wr;
+	__u32	max_recv_wr;
+	__u16	num_ports;
+	__u16	device_id;
+	__aligned_u64	qpm_tx_db;
+	__aligned_u64	qpm_rx_db;
+	__aligned_u64	cqm_next_cid_reg;
+	__aligned_u64	cqm_armdb;
+	__u32	send_ds_num;
+	__u32	recv_ds_num;
+	__u32	resv;
+};
+
+struct xsc_ib_create_qp {
+	__aligned_u64 buf_addr;
+	__aligned_u64 db_addr;
+	__u32	sq_wqe_count;
+	__u32	rq_wqe_count;
+	__u32	rq_wqe_shift;
+	__u32	flags;
+	__u32	resv;
+};
+
+struct xsc_ib_create_qp_resp {
+	__u32   bfreg_index;
+	__u32   resv;
+};
+
+struct xsc_ib_create_cq {
+	__aligned_u64 buf_addr;
+	__u32	cqe_size;
+};
+
+struct xsc_ib_create_cq_resp {
+	__u32	cqn;
+	__u32	reserved;
+};
+
+struct xsc_ib_create_ah_resp {
+	__u32	response_length;
+	__u8	dmac[ETH_ALEN];
+	__u8	reserved[6];
+};
+
+struct xsc_ib_alloc_pd_resp {
+	__u32	pdn;
+};
+
+#endif /* XSC_ABI_USER_H */
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index cec00551..7127899c 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2277,6 +2277,7 @@ extern const struct verbs_device_ops verbs_provider_qedr;
 extern const struct verbs_device_ops verbs_provider_rxe;
 extern const struct verbs_device_ops verbs_provider_siw;
 extern const struct verbs_device_ops verbs_provider_vmw_pvrdma;
+extern const struct verbs_device_ops verbs_provider_xscale;
 extern const struct verbs_device_ops verbs_provider_all;
 extern const struct verbs_device_ops verbs_provider_none;
 void ibv_static_providers(void *unused, ...);
-- 
2.25.1

