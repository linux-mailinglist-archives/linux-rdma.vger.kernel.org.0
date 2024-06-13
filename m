Return-Path: <linux-rdma+bounces-3113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5296906725
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E2F1C208D4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39313F45E;
	Thu, 13 Jun 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="Olo4lOUJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72A13E8A5
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267900; cv=none; b=aY8r3eu12Sjc+yOf3A889jbGbikjz7Nl28bfV9GGLZrr/j93AheWSVpZB5Xu2iL7qQQKyd794B8xNDBprsEjGRropMwDjT2qGVudEvgoAdufZOR0rQXUdt2WJBaQSXpbqAEhFSgrsJwke6bgvNJW1G60pY3q5A0yCLHkWaxOClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267900; c=relaxed/simple;
	bh=kijB3TDckcsicfjc+VDRlawV692fU+f83dWNt689vfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qsieu0lgHGX+/iNUIBGRpklxXX5z+UEH+dVi2OVPlnZVdKDb7enogt+XmoLFUASub4jqwzRXpd0/28K1Qe3bph2eSGpW9va8DEBti7hAhrKKsZls+oEXKQerccXpnDbSmD9VmHK8k00aiLvjIAdCBPMNqWXKnspmnTQIl19iDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=Olo4lOUJ; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718267901; bh=kijB3TDckcsicfjc+VDRlawV692fU+f83dWNt689vfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Olo4lOUJgAtSNHzdqDlcu/bL0ThfMNgr0HlIRkbk6pvYaKOQ7XxfBgkm244CXQlJt
	 NOxQKXmrIuYGYaVNgs34NZ0MUMRsWwO4rQRV1UMPEXvEhlQJMGTDIGxL0v2M+qgwcz
	 6VONHAGkZRUEzf17p+4v6ftS+rPXz7E5dvwA6YlyhXVhlkOj4BXzXuFHfXK+MYx8Eq
	 Tml80lZE4HA0zs3Xh70z7cBfsyAxuIBG9Tz4RqNoJ1cV7D73ePL6GzVnZrolrFxJfz
	 wKDVumYg+g7ODQFrRRFK0wC6rcUC3iTn0qlgx/xWLr0eKSmy7PjtWv8UJe6Q/eLhzQ
	 ZyhZt8mDNOKbQ==
Received: from oshpigelman-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by oshpigelman-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45D8c2vY1440923;
	Thu, 13 Jun 2024 11:38:03 +0300
From: Omer Shpigelman <oshpigelman@habana.ai>
To: linux-rdma@vger.kernel.org
Cc: ogabbay@kernel.org, oshpigelman@habana.ai, zyehudai@habana.ai
Subject: [PATCH 1/4] Update kernel headers
Date: Thu, 13 Jun 2024 11:37:59 +0300
Message-Id: <20240613083802.1440904-2-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613083802.1440904-1-oshpigelman@habana.ai>
References: <20240613083802.1440904-1-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To commit: ?? ("accel/habanalabs/gaudi2: network scaling support").

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Co-developed-by: David Meriin <dmeriin@habana.ai>
Signed-off-by: David Meriin <dmeriin@habana.ai>
Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
---
 kernel-headers/CMakeLists.txt              |   4 +
 kernel-headers/rdma/hbl-abi.h              | 204 +++++++++++++++++++++
 kernel-headers/rdma/hbl_user_ioctl_cmds.h  |  66 +++++++
 kernel-headers/rdma/hbl_user_ioctl_verbs.h | 106 +++++++++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h  |   1 +
 5 files changed, 381 insertions(+)
 create mode 100644 kernel-headers/rdma/hbl-abi.h
 create mode 100644 kernel-headers/rdma/hbl_user_ioctl_cmds.h
 create mode 100644 kernel-headers/rdma/hbl_user_ioctl_verbs.h

diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 82c191cad..b4558b94d 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -3,6 +3,9 @@ publish_internal_headers(rdma
   rdma/cxgb4-abi.h
   rdma/efa-abi.h
   rdma/erdma-abi.h
+  rdma/hbl-abi.h
+  rdma/hbl_user_ioctl_cmds.h
+  rdma/hbl_user_ioctl_verbs.h
   rdma/hns-abi.h
   rdma/ib_user_ioctl_cmds.h
   rdma/ib_user_ioctl_verbs.h
@@ -68,6 +71,7 @@ rdma_kernel_provider_abi(
   rdma/cxgb4-abi.h
   rdma/efa-abi.h
   rdma/erdma-abi.h
+  rdma/hbl-abi.h
   rdma/hns-abi.h
   rdma/ib_user_verbs.h
   rdma/irdma-abi.h
diff --git a/kernel-headers/rdma/hbl-abi.h b/kernel-headers/rdma/hbl-abi.h
new file mode 100644
index 000000000..c545e07c9
--- /dev/null
+++ b/kernel-headers/rdma/hbl-abi.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#ifndef HBL_IB_ABI_USER_H
+#define HBL_IB_ABI_USER_H
+
+#include <linux/types.h>
+
+/* Increment this value if any changes that break userspace ABI compatibility are made. */
+#define HBL_IB_UVERBS_ABI_VERSION	1
+
+#define HBL_IB_MTU_8192			6
+
+/**
+ * struct hbl_ibv_alloc_ucontext_req - Request udata for alloc ucontext.
+ * @ports_mask: Mask of ports associated with this context. 0 is for all available ports.
+ * @core_fd: Core device file descriptor.
+ * @use_dvs: Indicates if we're going to use our DVs.
+ */
+struct hbl_ibv_alloc_ucontext_req {
+	__aligned_u64 ports_mask;
+	__s32 core_fd;
+	__u8 use_dvs;
+	__u8 reserved[3];
+};
+
+/**
+ * enum hbl_ibv_ucontext_cap - Device capabilities.
+ * @HBL_UCONTEXT_CAP_MMAP_UMR: User memory region.
+ * @HBL_UCONTEXT_CAP_CC: Congestion control.
+ */
+enum hbl_ibv_ucontext_cap {
+	HBL_UCONTEXT_CAP_MMAP_UMR = 1 << 0,
+	HBL_UCONTEXT_CAP_CC = 1 << 1,
+};
+
+/**
+ * struct hbl_ibv_alloc_ucontext_resp - Response udata for alloc ucontext.
+ * @ports_mask: Mask of ports associated with this context.
+ * @cap_mask: Capabilities mask.
+ */
+struct hbl_ibv_alloc_ucontext_resp {
+	__aligned_u64 ports_mask;
+	__aligned_u64 cap_mask;
+};
+
+/**
+ * struct hbl_ibv_alloc_pd_resp - Response udata for alloc PD.
+ * @pdn: PD number.
+ */
+struct hbl_ibv_alloc_pd_resp {
+	__u32 pdn;
+	__u32 reserved;
+};
+
+/**
+ * enum hbl_ibv_qp_wq_types - QP WQ types.
+ * @HBL_WQ_WRITE: WRITE or "native" SEND operations are allowed on this QP.
+ *                NOTE: the last is not supported!
+ * @HBL_WQ_RECV_RDV: RECEIVE-RDV or WRITE operations are allowed on this QP.
+ *                   NOTE: posting all operations at the same time is not supported!
+ * @HBL_WQ_READ_RDV: READ-RDV or WRITE operations are allowed on this QP.
+ *                   NOTE: posting all operations at the same time is not supported!
+ * @HBL_WQ_SEND_RDV: SEND-RDV operation is allowed on this QP.
+ * @HBL_WQ_READ_RDV_ENDP: No operation is allowed on this endpoint QP!
+ */
+enum hbl_ibv_qp_wq_types {
+	HBL_WQ_WRITE = 0x1,
+	HBL_WQ_RECV_RDV = 0x2,
+	HBL_WQ_READ_RDV = 0x4,
+	HBL_WQ_SEND_RDV = 0x8,
+	HBL_WQ_READ_RDV_ENDP = 0x10,
+};
+
+/**
+ * struct hbl_ibv_modify_qp_req - Request udata for modify QP.
+ * @local_key: Unique key for local memory access.
+ * @remote_key: Unique key for remote memory access.
+ * @congestion_wnd: Congestion-Window size.
+ * @dest_wq_size: Number of WQEs on the destination.
+ * @priority: Requester/responder QP priority.
+ * @wq_type: WQ type. e.g. write, rdv etc
+ * @loopback: QP loopback enable/disable.
+ * @congestion_en: Congestion-control enable/disable.
+ * @compression_en: Compression enable/disable.
+ * @encap_en: Encapsulation enable flag.
+ * @encap_num: Encapsulation number.
+ * @wq_granularity: WQ granularity [0 for 32B or 1 for 64B].
+ */
+struct hbl_ibv_modify_qp_req {
+	__u32 local_key;
+	__u32 remote_key;
+	__u32 congestion_wnd;
+	__u32 reserved0;
+	__u32 dest_wq_size;
+	__u8 priority;
+	__u8 wq_type;
+	__u8 loopback;
+	__u8 congestion_en;
+	__u8 reserved1;
+	__u8 reserved2;
+	__u8 compression_en;
+	__u8 reserved3;
+	__u8 encap_en;
+	__u8 encap_num;
+	__u8 reserved4;
+	__u8 wq_granularity;
+	__u8 reserved5;
+	__u8 reserved6[5];
+};
+
+/**
+ * struct hbl_ibv_modify_qp_resp - Response udata for modify QP.
+ * @swq_mem_handle: Send WQ mmap handle.
+ * @rwq_mem_handle: Receive WQ mmap handle.
+ * @swq_mem_size: Send WQ mmap size.
+ * @rwq_mem_size: Receive WQ mmap size.
+ * @qp_num: HBL QP num.
+ */
+struct hbl_ibv_modify_qp_resp {
+	__aligned_u64 swq_mem_handle;
+	__aligned_u64 rwq_mem_handle;
+	__u32 swq_mem_size;
+	__u32 rwq_mem_size;
+	__u32 qp_num;
+	__u32 reserved;
+};
+
+/**
+ * enum hbl_ibv_cq_type - CQ types, used during allocation of CQs.
+ * @HBL_CQ_TYPE_QP: Standard CQ used for completion of a operation for a QP.
+ * @HBL_CQ_TYPE_CC: Congestion control CQ.
+ */
+enum hbl_ibv_cq_type {
+	HBL_CQ_TYPE_QP,
+	HBL_CQ_TYPE_CC,
+};
+
+/**
+ * hbl_ibv_cq_req_flags - CQ req flag used for distinguision between CQ based on attributes.
+ * @CQ_FLAG_NATIVE: Bit 1 is set, it represents the CQ is called for native create CQ.
+ */
+enum hbl_ibv_cq_req_flags {
+	CQ_FLAG_NATIVE = 1 << 0,
+};
+
+/**
+ * struct hbl_ibv_create_cq_req - Request udata for create CQ.
+ * @port_num: IB Port number.
+ * @cq_type: Type of CQ resource as mentioned in hbl_ibv_cq_type.
+ * @flags: CQ req flag used for cq attributes.
+ */
+struct hbl_ibv_create_cq_req {
+	__u32 port_num;
+	__u8 cq_type;
+	__u8 flags;
+	__u8 reserved[2];
+};
+
+/**
+ * struct hbl_ibv_port_create_cq_resp - Response udata for create CQ.
+ * @mem_handle: Handle for the CQ buffer.
+ * @pi_handle: Handle for the Pi memory.
+ * @regs_handle: Handle for the CQ UMR register.
+ * @regs_offset: Register offset of CQ UMR register.
+ * @cq_num: CQ number that is allocated.
+ * @cq_size: Size of the CQ.
+ */
+struct hbl_ibv_port_create_cq_resp {
+	__aligned_u64 mem_handle;
+	__aligned_u64 pi_handle;
+	__aligned_u64 regs_handle;
+	__u32 regs_offset;
+	__u32 cq_num;
+	__u32 cq_size;
+	__u32 reserved;
+};
+
+/**
+ * struct hbl_ibv_create_cq_resp - Response udata for create CQ.
+ * @mem_handle: Handle for the CQ buffer.
+ * @pi_handle: Handle for the Pi memory.
+ * @regs_handle: Handle for the CQ UMR register.
+ * @regs_offset: Register offset of CQ UMR register.
+ * @cq_num: CQ number that is allocated.
+ * @cq_size: Size of the CQ.
+ * @port_cq_resp: response data for create CQ per port.
+ */
+struct hbl_ibv_create_cq_resp {
+	__aligned_u64 mem_handle;
+	__aligned_u64 pi_handle;
+	__aligned_u64 regs_handle;
+	__u32 regs_offset;
+	__u32 cq_num;
+	__u32 cq_size;
+	__u32 reserved;
+	struct hbl_ibv_port_create_cq_resp port_cq_resp[];
+};
+
+#endif /* HBL_IB_ABI_USER_H */
diff --git a/kernel-headers/rdma/hbl_user_ioctl_cmds.h b/kernel-headers/rdma/hbl_user_ioctl_cmds.h
new file mode 100644
index 000000000..7ac2bf116
--- /dev/null
+++ b/kernel-headers/rdma/hbl_user_ioctl_cmds.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#ifndef HBL_IB_USER_IOCTL_CMDS_H
+#define HBL_IB_USER_IOCTL_CMDS_H
+
+#include <linux/types.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+
+enum hbl_ib_objects {
+	HBL_IB_OBJECT_USR_FIFO = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_OBJECT_SET_PORT_EX,
+	HBL_IB_OBJECT_QUERY_PORT,
+	HBL_IB_OBJECT_RESERVED,
+	HBL_IB_OBJECT_ENCAP,
+};
+
+enum hbl_ib_usr_fifo_obj_methods {
+	HBL_IB_METHOD_USR_FIFO_OBJ_CREATE = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_METHOD_USR_FIFO_OBJ_DESTROY,
+};
+
+enum hbl_ib_usr_fifo_create_attrs {
+	HBL_IB_ATTR_USR_FIFO_CREATE_IN = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_ATTR_USR_FIFO_CREATE_OUT,
+	HBL_IB_ATTR_USR_FIFO_CREATE_HANDLE,
+};
+
+enum hbl_ib_usr_fifo_destroy_attrs {
+	HBL_IB_ATTR_USR_FIFO_DESTROY_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum hbl_ib_device_methods {
+	HBL_IB_METHOD_SET_PORT_EX = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_METHOD_QUERY_PORT,
+};
+
+enum hbl_ib_set_port_ex_attrs {
+	HBL_IB_ATTR_SET_PORT_EX_IN = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum hbl_ib_query_port_attrs {
+	HBL_IB_ATTR_QUERY_PORT_IN = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_ATTR_QUERY_PORT_OUT,
+};
+
+enum hbl_ib_encap_methods {
+	HBL_IB_METHOD_ENCAP_CREATE = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_METHOD_ENCAP_DESTROY,
+};
+
+enum hbl_ib_encap_create_attrs {
+	HBL_IB_ATTR_ENCAP_CREATE_IN = (1U << UVERBS_ID_NS_SHIFT),
+	HBL_IB_ATTR_ENCAP_CREATE_OUT,
+	HBL_IB_ATTR_ENCAP_CREATE_HANDLE,
+};
+
+enum hbl_ib_encap_destroy_attrs {
+	HBL_IB_ATTR_ENCAP_DESTROY_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+#endif /* HBL_IB_USER_IOCTL_CMDS_H */
diff --git a/kernel-headers/rdma/hbl_user_ioctl_verbs.h b/kernel-headers/rdma/hbl_user_ioctl_verbs.h
new file mode 100644
index 000000000..ce896f5c5
--- /dev/null
+++ b/kernel-headers/rdma/hbl_user_ioctl_verbs.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#ifndef HBL_IB_USER_IOCTL_VERBS_H
+#define HBL_IB_USER_IOCTL_VERBS_H
+
+#include <linux/types.h>
+
+#define HBL_IB_MAX_BP_OFFS		16
+
+enum hbl_ib_wq_array_type {
+	HBL_IB_WQ_ARRAY_TYPE_GENERIC,
+	HBL_IB_WQ_ARRAY_TYPE_RESERVED1,
+	HBL_IB_WQ_ARRAY_TYPE_RESERVED2,
+	HBL_IB_WQ_ARRAY_TYPE_RESERVED3,
+	HBL_IB_WQ_ARRAY_TYPE_RESERVED4,
+	HBL_IB_WQ_ARRAY_TYPE_MAX,
+};
+
+struct hbl_wq_array_attr {
+	__u32 max_num_of_wqs;
+	__u32 max_num_of_wqes_in_wq;
+	__u8 mem_id;
+	__u8 swq_granularity;
+	__u8 reserved0[6];
+	__aligned_u64 reserved1[2];
+};
+
+struct hbl_uapi_usr_fifo_create_in {
+	__u32 port_num;
+	__u32 reserved0;
+	__u32 reserved1;
+	__u32 usr_fifo_num_hint;
+	__u8 mode;
+	__u8 reserved2;
+	__u8 reserved3[6];
+};
+
+struct hbl_uapi_usr_fifo_create_out {
+	__aligned_u64 ci_handle;
+	__aligned_u64 regs_handle;
+	__u32 usr_fifo_num;
+	__u32 regs_offset;
+	__u32 size;
+	__u32 bp_thresh;
+};
+
+struct hbl_uapi_set_port_ex_in {
+	struct hbl_wq_array_attr wq_arr_attr[HBL_IB_WQ_ARRAY_TYPE_MAX];
+	/* Pointer to u32 array */
+	__aligned_u64 qp_wq_bp_offs;
+	__u32 qp_wq_bp_offs_cnt;
+	__u32 port_num;
+	__aligned_u64 reserved0;
+	__u32 reserved1;
+	__u8 reserved2;
+	__u8 advanced;
+	__u8 adaptive_timeout_en;
+	__u8 reserved3;
+};
+
+struct hbl_uapi_query_port_in {
+	__u32 port_num;
+	__u32 reserved;
+};
+
+struct hbl_uapi_query_port_out {
+	__u32 max_num_of_qps;
+	__u32 num_allocated_qps;
+	__u32 max_allocated_qp_num;
+	__u32 max_cq_size;
+	__u32 reserved0;
+	__u32 reserved1;
+	__u32 reserved2;
+	__u32 reserved3;
+	__u32 reserved4;
+	__u8 advanced;
+	__u8 max_num_of_cqs;
+	__u8 max_num_of_usr_fifos;
+	__u8 max_num_of_encaps;
+	__u8 nic_macro_idx;
+	__u8 nic_phys_port_idx;
+	__u8 reserved[6];
+};
+
+struct hbl_uapi_encap_create_in {
+	__aligned_u64 tnl_hdr_ptr;
+	__u32 tnl_hdr_size;
+	__u32 port_num;
+	__u32 ipv4_addr;
+	__u16 udp_dst_port;
+	__u16 ip_proto;
+	__u8 encap_type;
+	__u8 reserved[7];
+};
+
+struct hbl_uapi_encap_create_out {
+	__u32 encap_num;
+	__u32 reserved;
+};
+
+#endif /* HBL_IB_USER_IOCTL_VERBS_H */
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index fe15bc7e9..016ac5c8f 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -255,6 +255,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 	RDMA_DRIVER_ERDMA,
 	RDMA_DRIVER_MANA,
+	RDMA_DRIVER_HBL,
 };
 
 enum ib_uverbs_gid_type {
-- 
2.34.1


