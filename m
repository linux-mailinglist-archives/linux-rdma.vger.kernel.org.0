Return-Path: <linux-rdma+bounces-5350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7599802C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69641C2417B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463BB1BDAB8;
	Thu, 10 Oct 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="I7DzKQ2D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from va-2-31.ptr.blmpb.com (va-2-31.ptr.blmpb.com [209.127.231.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05271B86CF
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547870; cv=none; b=SflxndKPz9nz3Zo2NTuU8t7hFWl1jInfkgJUt/KHUI/9L70YxF1WrPq2ZTZzdj+HzpbxCJNBJp5qLsPfXp97XsOMwtnYCKRQa09M5XD28GyZ98Wvhmv6V06CaMhEaCJRYh5GYWts5vvxuPLrLtl2MVkOubjFRIy0FVkwGgY6uIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547870; c=relaxed/simple;
	bh=bdGXiFf7EyREM9gvcbweFm8+IouBDSE7oymzWzT3tk8=;
	h=Message-Id:Content-Type:Subject:Date:Cc:Mime-Version:To:From; b=aJx85KmRcC4aVNJ3pbaEIgR7LA6QoTVWzYMYlSFXmivuPj41pDNC66v2+5hquCAito6XszNM9ntQsE3CHd8A/fAf/yq/X1+ZAfYkgaeXOwhuVRBfMzRrzq9kbSOj5WJhXv8K+kHoMUgmMtDK1coWpO+AXVDSyt+5qABhYx7dQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=I7DzKQ2D; arc=none smtp.client-ip=209.127.231.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1728547854; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xKrCar+uyunZ0s04dIKvUFSI5U+jnfPjPJGOXGwXoT8=;
 b=I7DzKQ2D3P28NRSt/Yq3JhMUY1SfYrA7KCz3Bi4a/OpSnCLJTnxa8f/enXeo8wUD0tDLnn
 rmRYCCp1QTWSjS2VcLiPYe+JKzYGfqzYO81syRTKvoz0WeLZvRzlLnSuduBkJSF4O6lFCl
 TPyVAfPty+5NtY7GQREuLtRytQGmSz+fCDXnwqBPqKer6F0DjvF6RisFOAslYPagll2K/D
 R/b4n2NWWc+SbLB6Hhw5AVPqUFrSz1fqXKp8xXAC/HTL3AQYUNDHFYVCbzZCW9P133Vcmu
 O6xnJeSloS77UG0C/6Js4jst9v3qnnmsZtO/0/y5nKnGhQAI0jM4f9aUPcxWag==
Content-Transfer-Encoding: 7bit
Message-Id: <20241010081049.1448826-2-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/6] libxscale: Introduce xscale user space RDMA provider
Date: Thu, 10 Oct 2024 16:10:44 +0800
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267078c0d+7d24f2+vger.kernel.org+tianx@yunsilicon.com>
Cc: <linux-rdma@vger.kernel.org>, "Tian Xin" <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 10 Oct 2024 16:10:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
From: "Tian Xin" <tianx@yunsilicon.com>

libxscale is a user-space driver that provides RDMA
capabilities to user applications. The current patch
includes the following components:
1. basic compile framework
2. register/unregister user-space driver via verbs
3. query_port
4. query_device_ex

Signed-off-by: Tian Xin <tianx@yunsilicon.com>
Signed-off-by: Wei Honggang <weihg@yunsilicon.com>
Signed-off-by: Zhao Qianwei <zhaoqw@yunsilicon.com>
Signed-off-by: Li Qiang <liq@yunsilicon.com>
Signed-off-by: Yan Lei <jacky@yunsilicon.com>
---
 CMakeLists.txt                  |   1 +
 MAINTAINERS                     |   9 +
 providers/xscale/CMakeLists.txt |   4 +
 providers/xscale/verbs.c        |  75 +++++++++
 providers/xscale/xsc-abi.h      |  31 ++++
 providers/xscale/xscale.c       | 282 ++++++++++++++++++++++++++++++++
 providers/xscale/xscale.h       | 164 +++++++++++++++++++
 7 files changed, 566 insertions(+)
 create mode 100644 providers/xscale/CMakeLists.txt
 create mode 100644 providers/xscale/verbs.c
 create mode 100644 providers/xscale/xsc-abi.h
 create mode 100644 providers/xscale/xscale.c
 create mode 100644 providers/xscale/xscale.h

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b2bd4f41..83976180 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -729,6 +729,7 @@ add_subdirectory(providers/mthca)
 add_subdirectory(providers/ocrdma)
 add_subdirectory(providers/qedr)
 add_subdirectory(providers/vmw_pvrdma)
+add_subdirectory(providers/xscale)
 endif()
 
 add_subdirectory(providers/hfi1verbs)
diff --git a/MAINTAINERS b/MAINTAINERS
index 4b241171..4f4aed69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -189,3 +189,12 @@ PYVERBS
 M:	Edward Srouji <edwards@mellanox.com>
 S:	Supported
 F:	pyverbs/
+
+XSCALE USERSPACE PROVIDER (for xsc_ib.ko)
+M:	Wei Honggang <weihg@yunsilicon.com>
+M:	Zhao Qianwei <zhaoqw@yunsilicon.com>
+M:	Li Qiang <liq@yunsilicon.com>
+M:	Tian Xin <tianx@yunsilicon.com>
+M:	Yan Lei <jacky@yunsilicon.com>
+S:	Supported
+F:	providers/xscale/
diff --git a/providers/xscale/CMakeLists.txt b/providers/xscale/CMakeLists.txt
new file mode 100644
index 00000000..cfd05b49
--- /dev/null
+++ b/providers/xscale/CMakeLists.txt
@@ -0,0 +1,4 @@
+rdma_provider(xscale
+  xscale.c
+  verbs.c
+)
diff --git a/providers/xscale/verbs.c b/providers/xscale/verbs.c
new file mode 100644
index 00000000..943665a8
--- /dev/null
+++ b/providers/xscale/verbs.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <config.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdatomic.h>
+#include <string.h>
+#include <pthread.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <ccan/array_size.h>
+
+#include <util/compiler.h>
+#include <util/mmio.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+#include <infiniband/cmd_write.h>
+
+#include "xscale.h"
+#include "xsc-abi.h"
+
+int xsc_query_port(struct ibv_context *context, u8 port,
+		   struct ibv_port_attr *attr)
+{
+	struct ibv_query_port cmd;
+
+	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof(cmd));
+}
+
+static void xsc_set_fw_version(struct ibv_device_attr *attr,
+			       union xsc_ib_fw_ver *fw_ver)
+{
+	u8 ver_major = fw_ver->s.ver_major;
+	u8 ver_minor = fw_ver->s.ver_minor;
+	u16 ver_patch = fw_ver->s.ver_patch;
+	u32 ver_tweak = fw_ver->s.ver_tweak;
+
+	if (ver_tweak == 0) {
+		snprintf(attr->fw_ver, sizeof(attr->fw_ver), "v%u.%u.%u",
+			 ver_major, ver_minor, ver_patch);
+	} else {
+		snprintf(attr->fw_ver, sizeof(attr->fw_ver), "v%u.%u.%u+%u",
+			 ver_major, ver_minor, ver_patch, ver_tweak);
+	}
+}
+
+int xsc_query_device_ex(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size)
+{
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size = sizeof(resp);
+	union xsc_ib_fw_ver raw_fw_ver;
+	int err;
+
+	raw_fw_ver.data = 0;
+	err = ibv_cmd_query_device_any(context, input, attr, attr_size,
+				       &resp, &resp_size);
+	if (err)
+		return err;
+
+	raw_fw_ver.data = resp.base.fw_ver;
+	xsc_set_fw_version(&attr->orig_attr, &raw_fw_ver);
+
+	return 0;
+}
diff --git a/providers/xscale/xsc-abi.h b/providers/xscale/xsc-abi.h
new file mode 100644
index 00000000..66d2bd1a
--- /dev/null
+++ b/providers/xscale/xsc-abi.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_ABI_H
+#define XSC_ABI_H
+
+#include <infiniband/kern-abi.h>
+#include <infiniband/verbs.h>
+#include <rdma/xsc-abi.h>
+#include <kernel-abi/xsc-abi.h>
+
+#define XSC_UVERBS_MIN_ABI_VERSION 1
+#define XSC_UVERBS_MAX_ABI_VERSION 1
+
+DECLARE_DRV_CMD(xsc_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEXT,
+		empty, xsc_ib_alloc_ucontext_resp);
+DECLARE_DRV_CMD(xsc_alloc_pd, IB_USER_VERBS_CMD_ALLOC_PD, empty,
+		xsc_ib_alloc_pd_resp);
+DECLARE_DRV_CMD(xsc_create_cq, IB_USER_VERBS_CMD_CREATE_CQ, xsc_ib_create_cq,
+		xsc_ib_create_cq_resp);
+DECLARE_DRV_CMD(xsc_create_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
+		xsc_ib_create_cq, xsc_ib_create_cq_resp);
+DECLARE_DRV_CMD(xsc_create_qp_ex, IB_USER_VERBS_EX_CMD_CREATE_QP,
+		xsc_ib_create_qp, xsc_ib_create_qp_resp);
+DECLARE_DRV_CMD(xsc_create_qp, IB_USER_VERBS_CMD_CREATE_QP, xsc_ib_create_qp,
+		xsc_ib_create_qp_resp);
+
+#endif /* XSC_ABI_H */
diff --git a/providers/xscale/xscale.c b/providers/xscale/xscale.c
new file mode 100644
index 00000000..c7be8127
--- /dev/null
+++ b/providers/xscale/xscale.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#define _GNU_SOURCE
+#include <config.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <string.h>
+#include <sched.h>
+#include <sys/param.h>
+
+#include <util/mmio.h>
+#include <util/symver.h>
+
+#include "xscale.h"
+#include "xsc-abi.h"
+
+static const struct verbs_match_ent hca_table[] = {
+	VERBS_MODALIAS_MATCH("*xscale*", NULL),
+	{}
+};
+
+u32 xsc_debug_mask;
+static void xsc_free_context(struct ibv_context *ibctx);
+
+static const struct verbs_context_ops xsc_ctx_common_ops = {
+	.query_port = xsc_query_port,
+	.query_device_ex = xsc_query_device_ex,
+	.free_context = xsc_free_context,
+};
+
+static void open_debug_file(struct xsc_context *ctx)
+{
+	char *env;
+
+	env = getenv("XSC_DEBUG_FILE");
+	if (!env) {
+		ctx->dbg_fp = stderr;
+		return;
+	}
+
+	ctx->dbg_fp = fopen(env, "aw+");
+	if (!ctx->dbg_fp) {
+		fprintf(stderr, "Failed opening debug file %s, using stderr\n",
+			env);
+		ctx->dbg_fp = stderr;
+		return;
+	}
+}
+
+static void close_debug_file(struct xsc_context *ctx)
+{
+	if (ctx->dbg_fp && ctx->dbg_fp != stderr)
+		fclose(ctx->dbg_fp);
+}
+
+static void set_debug_mask(void)
+{
+	char *env;
+
+	env = getenv("XSC_DEBUG_MASK");
+	if (env)
+		xsc_debug_mask = strtol(env, NULL, 0);
+}
+
+static int xsc_cmd_get_context(struct xsc_context *context,
+			       struct xsc_alloc_ucontext *req, size_t req_len,
+			       struct xsc_alloc_ucontext_resp *resp,
+			       size_t resp_len)
+{
+	struct verbs_context *verbs_ctx = &context->ibv_ctx;
+
+	return ibv_cmd_get_context(verbs_ctx, &req->ibv_cmd, req_len,
+				   &resp->ibv_resp, resp_len);
+}
+
+static int xsc_mmap(struct xsc_device *xdev, struct xsc_context *context,
+		    int cmd_fd, int size)
+{
+	u64 page_mask;
+
+	page_mask = (~(xdev->page_size - 1));
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX, "page size:%d\n", size);
+	context->sqm_reg_va =
+		mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, cmd_fd,
+		     context->qpm_tx_db & page_mask);
+	if (context->sqm_reg_va == MAP_FAILED)
+		return -1;
+
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX, "qpm reg va:%p\n",
+		context->sqm_reg_va);
+
+	context->rqm_reg_va =
+		mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, cmd_fd,
+		     context->qpm_rx_db & page_mask);
+	if (context->rqm_reg_va == MAP_FAILED)
+		goto free_sqm;
+
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX, "qpm reg va:%p\n",
+		context->rqm_reg_va);
+
+	context->cqm_reg_va =
+		mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, cmd_fd,
+		     context->cqm_next_cid_reg & page_mask);
+	if (context->cqm_reg_va == MAP_FAILED)
+		goto free_rqm;
+
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX, "cqm ci va:%p\n",
+		context->cqm_reg_va);
+	context->db_mmap_size = size;
+
+	context->cqm_armdb_va =
+		mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, cmd_fd,
+		     context->cqm_armdb & page_mask);
+	if (context->cqm_armdb_va == MAP_FAILED)
+		goto free_cqm;
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX, "cqm armdb va:%p\n",
+		context->cqm_armdb_va);
+
+	return 0;
+
+free_cqm:
+	munmap(context->cqm_reg_va, size);
+free_rqm:
+	munmap(context->rqm_reg_va, size);
+free_sqm:
+	munmap(context->sqm_reg_va, size);
+
+	return -1;
+}
+
+static void xsc_munmap(struct xsc_context *context)
+{
+	if (context->sqm_reg_va)
+		munmap(context->sqm_reg_va, context->db_mmap_size);
+
+	if (context->rqm_reg_va)
+		munmap(context->rqm_reg_va, context->db_mmap_size);
+
+	if (context->cqm_reg_va)
+		munmap(context->cqm_reg_va, context->db_mmap_size);
+
+	if (context->cqm_armdb_va)
+		munmap(context->cqm_armdb_va, context->db_mmap_size);
+}
+
+static struct verbs_context *xsc_alloc_context(struct ibv_device *ibdev,
+					       int cmd_fd, void *private_data)
+{
+	struct xsc_context *context;
+	struct xsc_alloc_ucontext req;
+	struct xsc_alloc_ucontext_resp resp;
+	int i;
+	int page_size;
+	struct xsc_device *xdev = to_xdev(ibdev);
+	struct verbs_context *v_ctx;
+	struct ibv_device_attr_ex device_attr;
+
+	context = verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
+					       RDMA_DRIVER_XSC);
+	if (!context)
+		return NULL;
+
+	v_ctx = &context->ibv_ctx;
+	page_size = xdev->page_size;
+
+	open_debug_file(context);
+	set_debug_mask();
+	if (gethostname(context->hostname, sizeof(context->hostname)))
+		strncpy(context->hostname, "host_unknown", NAME_BUFFER_SIZE - 1);
+
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
+
+	if (xsc_cmd_get_context(context, &req, sizeof(req), &resp,
+				sizeof(resp)))
+		goto err_free;
+
+	context->max_num_qps = resp.qp_tab_size;
+	context->max_sq_desc_sz = resp.max_sq_desc_sz;
+	context->max_rq_desc_sz = resp.max_rq_desc_sz;
+	context->max_send_wr = resp.max_send_wr;
+	context->num_ports = resp.num_ports;
+	context->max_recv_wr = resp.max_recv_wr;
+	context->qpm_tx_db = resp.qpm_tx_db;
+	context->qpm_rx_db = resp.qpm_rx_db;
+	context->cqm_next_cid_reg = resp.cqm_next_cid_reg;
+	context->cqm_armdb = resp.cqm_armdb;
+	context->send_ds_num = resp.send_ds_num;
+	context->send_ds_shift = xsc_ilog2(resp.send_ds_num);
+	context->recv_ds_num = resp.recv_ds_num;
+	context->recv_ds_shift = xsc_ilog2(resp.recv_ds_num);
+
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX,
+		"max_num_qps:%u, max_sq_desc_sz:%u max_rq_desc_sz:%u\n",
+		context->max_num_qps, context->max_sq_desc_sz,
+		context->max_rq_desc_sz);
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX,
+		"max_send_wr:%u, num_ports:%u, max_recv_wr:%u\n",
+		context->max_send_wr,
+		context->num_ports, context->max_recv_wr);
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX,
+		"send_ds_num:%u shift:%u recv_ds_num:%u shift:%u\n",
+		context->send_ds_num, context->send_ds_shift,
+		context->recv_ds_num, context->recv_ds_shift);
+
+	pthread_mutex_init(&context->qp_table_mutex, NULL);
+	for (i = 0; i < XSC_QP_TABLE_SIZE; ++i)
+		context->qp_table[i].refcnt = 0;
+
+	context->page_size = page_size;
+	if (xsc_mmap(xdev, context, cmd_fd, page_size))
+		goto err_free;
+
+	verbs_set_ops(v_ctx, &xsc_ctx_common_ops);
+
+	memset(&device_attr, 0, sizeof(device_attr));
+	if (!xsc_query_device_ex(&v_ctx->context, NULL, &device_attr,
+				 sizeof(struct ibv_device_attr_ex))) {
+		context->max_cqe = device_attr.orig_attr.max_cqe;
+	}
+
+	return v_ctx;
+
+err_free:
+	verbs_uninit_context(&context->ibv_ctx);
+	close_debug_file(context);
+	free(context);
+	return NULL;
+}
+
+static void xsc_free_context(struct ibv_context *ibctx)
+{
+	struct xsc_context *context = to_xctx(ibctx);
+
+	xsc_dbg(context->dbg_fp, XSC_DBG_CTX, "\n");
+	xsc_munmap(context);
+
+	verbs_uninit_context(&context->ibv_ctx);
+	close_debug_file(context);
+	free(context);
+}
+
+static void xsc_uninit_device(struct verbs_device *verbs_device)
+{
+	struct xsc_device *xdev = to_xdev(&verbs_device->device);
+
+	free(xdev);
+}
+
+static struct verbs_device *xsc_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
+{
+	struct xsc_device *xdev;
+
+	xdev = calloc(1, sizeof(*xdev));
+	if (!xdev)
+		return NULL;
+
+	xdev->page_size = sysconf(_SC_PAGESIZE);
+
+	return &xdev->verbs_dev;
+}
+
+static const struct verbs_device_ops xsc_dev_ops = {
+	.name = "xscale",
+	.match_min_abi_version = XSC_UVERBS_MIN_ABI_VERSION,
+	.match_max_abi_version = XSC_UVERBS_MAX_ABI_VERSION,
+	.match_table = hca_table,
+	.alloc_device = xsc_device_alloc,
+	.uninit_device = xsc_uninit_device,
+	.alloc_context = xsc_alloc_context,
+};
+
+PROVIDER_DRIVER(xscale, xsc_dev_ops);
diff --git a/providers/xscale/xscale.h b/providers/xscale/xscale.h
new file mode 100644
index 00000000..85538d93
--- /dev/null
+++ b/providers/xscale/xscale.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 - 2022, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSCALE_H
+#define XSCALE_H
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdatomic.h>
+#include <util/compiler.h>
+
+#include <infiniband/driver.h>
+#include <util/udma_barrier.h>
+#include <ccan/list.h>
+#include <ccan/minmax.h>
+#include <valgrind/memcheck.h>
+
+#include "xsc-abi.h"
+
+typedef uint8_t   u8;
+typedef uint16_t  u16;
+typedef uint32_t  u32;
+typedef uint64_t  u64;
+
+enum {
+	XSC_DBG_QP = 1 << 0,
+	XSC_DBG_CQ = 1 << 1,
+	XSC_DBG_QP_SEND = 1 << 2,
+	XSC_DBG_QP_SEND_ERR = 1 << 3,
+	XSC_DBG_CQ_CQE = 1 << 4,
+	XSC_DBG_CONTIG = 1 << 5,
+	XSC_DBG_DR = 1 << 6,
+	XSC_DBG_CTX = 1 << 7,
+	XSC_DBG_PD = 1 << 8,
+	XSC_DBG_MR = 1 << 9,
+};
+
+extern u32 xsc_debug_mask;
+
+#define xsc_dbg(fp, mask, fmt, args...)                                        \
+	do {                                                                   \
+		if (xsc_debug_mask & (mask)) {                                 \
+			char host[256];                                        \
+			char timestr[32];                                      \
+			struct tm now_tm;                                      \
+			time_t now_time;                                       \
+			time(&now_time);                                       \
+			localtime_r(&now_time, &now_tm);                       \
+			strftime(timestr, sizeof(timestr), "%Y-%m-%d %X",      \
+				 &now_tm);                                     \
+			gethostname(host, 256);                                \
+			fprintf(fp, "[%s %s %s %d] " fmt, timestr, host,       \
+				__func__, __LINE__, ##args);                   \
+		}                                                              \
+	} while (0)
+
+#define xsc_err(fmt, args...)                                                  \
+	do {                                                                   \
+		char host[256];                                                \
+		char timestr[32];                                              \
+		struct tm now_tm;                                              \
+		time_t now_time;                                               \
+		time(&now_time);                                               \
+		localtime_r(&now_time, &now_tm);                               \
+		strftime(timestr, sizeof(timestr), "%Y-%m-%d %X", &now_tm);    \
+		gethostname(host, 256);                                        \
+		printf("[%s %s %s %d] " fmt, timestr, host, __func__,          \
+		       __LINE__, ##args);                                      \
+	} while (0)
+
+enum {
+	XSC_QP_TABLE_SHIFT = 12,
+	XSC_QP_TABLE_MASK = (1 << XSC_QP_TABLE_SHIFT) - 1,
+	XSC_QP_TABLE_SIZE = 1 << (24 - XSC_QP_TABLE_SHIFT),
+};
+
+struct xsc_device {
+	struct verbs_device verbs_dev;
+	int page_size;
+};
+
+#define NAME_BUFFER_SIZE 64
+
+struct xsc_context {
+	struct verbs_context ibv_ctx;
+	int max_num_qps;
+	struct {
+		struct xsc_qp **table;
+		int refcnt;
+	} qp_table[XSC_QP_TABLE_SIZE];
+	pthread_mutex_t qp_table_mutex;
+
+	int max_sq_desc_sz;
+	int max_rq_desc_sz;
+	int max_send_wr;
+	int max_recv_wr;
+	int num_ports;
+	char hostname[NAME_BUFFER_SIZE];
+	u32 max_cqe;
+	void *sqm_reg_va;
+	void *rqm_reg_va;
+	void *cqm_reg_va;
+	void *cqm_armdb_va;
+	int db_mmap_size;
+	u32 page_size;
+	u64 qpm_tx_db;
+	u64 qpm_rx_db;
+	u64 cqm_next_cid_reg;
+	u64 cqm_armdb;
+	u32 send_ds_num;
+	u32 recv_ds_num;
+	u32 send_ds_shift;
+	u32 recv_ds_shift;
+	FILE *dbg_fp;
+	struct xsc_hw_ops *hw_ops;
+};
+
+union xsc_ib_fw_ver {
+	u64 data;
+	struct {
+		u8 ver_major;
+		u8 ver_minor;
+		u16 ver_patch;
+		u32 ver_tweak;
+	} s;
+};
+
+static inline int xsc_ilog2(int n)
+{
+	int t;
+
+	if (n <= 0)
+		return -1;
+
+	t = 0;
+	while ((1 << t) < n)
+		++t;
+
+	return t;
+}
+
+static inline struct xsc_device *to_xdev(struct ibv_device *ibdev)
+{
+	return container_of(ibdev, struct xsc_device, verbs_dev.device);
+}
+
+static inline struct xsc_context *to_xctx(struct ibv_context *ibctx)
+{
+	return container_of(ibctx, struct xsc_context, ibv_ctx.context);
+}
+
+int xsc_query_device(struct ibv_context *context, struct ibv_device_attr *attr);
+int xsc_query_device_ex(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size);
+int xsc_query_port(struct ibv_context *context, u8 port,
+		   struct ibv_port_attr *attr);
+
+#endif /* XSC_H */
-- 
2.25.1

