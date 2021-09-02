Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA65F3FEE62
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbhIBNJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbhIBNJa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 09:09:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C43C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 06:08:30 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k24so1872130pgh.8
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdKx1CchErer0L4Gf3BkL6es4TGk0q8NPWAfgcNqaLg=;
        b=H95BuP3iy0w2R2nZvHcuTTKBo7w14Pnmc0+iO+a94GaamGWCsLjOi4cumQ73d6w8fv
         6tfO7fg9iGBp7Rxia98lH8x7Pkc4e76+ji87IT5yr/jsR5HvZig4ZAjG04wxQl4YBIot
         47BrSMpfkqDDso600vcsriCTOwA4OEtF6yIXDNvK+A+i7Dj5VvoSkO2ZXJ1M+pe+4Gtn
         5zQENlbRLSkDd9uUavygA+V/FdGv7I7hGpwdo5MsDA/Yc+FCGHTpsp/I3GdyFd31i5Ol
         FY94jhdlgasgqeZk+FMl5i1iWDSns5VoljZ8MWhXOSfcKKXUY2/DLUaT1gaiRJ7fOcc+
         bHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdKx1CchErer0L4Gf3BkL6es4TGk0q8NPWAfgcNqaLg=;
        b=sP7UUEyzPAsy8xBYuAQyOHSNz2Xr8Mh4ODuvIIAHbV1WINo7jsPYl3g5OlHDCR9d+I
         QJbuP7MpJAL2XhhrJs6og29UtYJ0/A9n5AjpxtU78LU0nxFjyAAKU2xNJdDkkp7RRU+6
         b7KySizenaRdnyyKG1ALZ3ClLGWBfnzptvEmCRMMDA3xJ4A1YHiwyVV44j7SyXFU5L7K
         T4wtyqJ3eA6sl3ip+5AaLBHHzjgPSANR4zFjwenmWw94HpiXCEGXg1Ps+HFVUQbHY2JE
         VgLIBiYvmT65v7KengMw1Z0M8vYvmgg20yrSzLFw8HLcGalCpUTb6d3KS1aYHDdh8eJS
         DjKw==
X-Gm-Message-State: AOAM531BWOD+LDsbPhz5fi9PPI3PrudOsYPdVWO0u5XzQH6YgDF2LmqJ
        uZqQptI1IRqHDiJ4BQ09QadaC733EEplCw==
X-Google-Smtp-Source: ABdhPJyU+U98LGYjuuoG2RpNVXFbZNMBasd0En9CmUJeS8X21CurptkmyJlQ0zTkZVnDy2IsXygXrQ==
X-Received: by 2002:aa7:8e81:0:b0:3fe:f212:f9dd with SMTP id a1-20020aa78e81000000b003fef212f9ddmr3374201pfr.46.1630588109969;
        Thu, 02 Sep 2021 06:08:29 -0700 (PDT)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d6sm2307415pfa.135.2021.09.02.06.08.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:08:29 -0700 (PDT)
From:   Junji Wei <weijunji@bytedance.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com,
        jasowang@redhat.com, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de
Cc:     xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        weijunji@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC 5/5] hw/virtio-rdma: VirtIO rdma device
Date:   Thu,  2 Sep 2021 21:06:25 +0800
Message-Id: <20210902130625.25277-6-weijunji@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This based on Yuval Shaia's [RFC 2/3]

[ Junji Wei: Implement simple date path and complete control path. ]

Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Signed-off-by: Junji Wei <weijunji@bytedance.com>
---
 hw/rdma/Kconfig                             |   5 +
 hw/rdma/meson.build                         |  10 +
 hw/rdma/virtio/virtio-rdma-dev-api.h        | 269 ++++++++++
 hw/rdma/virtio/virtio-rdma-ib.c             | 764 ++++++++++++++++++++++++++++
 hw/rdma/virtio/virtio-rdma-ib.h             | 176 +++++++
 hw/rdma/virtio/virtio-rdma-main.c           | 231 +++++++++
 hw/rdma/virtio/virtio-rdma-qp.c             | 241 +++++++++
 hw/rdma/virtio/virtio-rdma-qp.h             |  29 ++
 hw/virtio/meson.build                       |   1 +
 hw/virtio/virtio-rdma-pci.c                 | 110 ++++
 include/hw/pci/pci.h                        |   1 +
 include/hw/virtio/virtio-rdma.h             |  58 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 13 files changed, 1896 insertions(+)
 create mode 100644 hw/rdma/virtio/virtio-rdma-dev-api.h
 create mode 100644 hw/rdma/virtio/virtio-rdma-ib.c
 create mode 100644 hw/rdma/virtio/virtio-rdma-ib.h
 create mode 100644 hw/rdma/virtio/virtio-rdma-main.c
 create mode 100644 hw/rdma/virtio/virtio-rdma-qp.c
 create mode 100644 hw/rdma/virtio/virtio-rdma-qp.h
 create mode 100644 hw/virtio/virtio-rdma-pci.c
 create mode 100644 include/hw/virtio/virtio-rdma.h

diff --git a/hw/rdma/Kconfig b/hw/rdma/Kconfig
index 8e2211288f..245b5b4d11 100644
--- a/hw/rdma/Kconfig
+++ b/hw/rdma/Kconfig
@@ -1,3 +1,8 @@
 config VMW_PVRDMA
     default y if PCI_DEVICES
     depends on PVRDMA && PCI && MSI_NONBROKEN
+
+config VIRTIO_RDMA
+    bool
+    default y
+    depends on VIRTIO
diff --git a/hw/rdma/meson.build b/hw/rdma/meson.build
index 7325f40c32..da9c3aaaf4 100644
--- a/hw/rdma/meson.build
+++ b/hw/rdma/meson.build
@@ -8,3 +8,13 @@ specific_ss.add(when: 'CONFIG_VMW_PVRDMA', if_true: files(
   'vmw/pvrdma_main.c',
   'vmw/pvrdma_qp_ops.c',
 ))
+
+specific_ss.add(when: 'CONFIG_VIRTIO_RDMA', if_true: files(
+  'rdma.c',
+  'rdma_backend.c',
+  'rdma_rm.c',
+  'rdma_utils.c',
+  'virtio/virtio-rdma-main.c',
+  'virtio/virtio-rdma-ib.c',
+  'virtio/virtio-rdma-qp.c',
+))
diff --git a/hw/rdma/virtio/virtio-rdma-dev-api.h b/hw/rdma/virtio/virtio-rdma-dev-api.h
new file mode 100644
index 0000000000..d4d8f2acc2
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-dev-api.h
@@ -0,0 +1,269 @@
+/*
+ * Virtio RDMA Device - QP ops
+ *
+ * Copyright (C) 2021 Bytedance Inc.
+ *
+ * Authors:
+ *  Junji Wei <weijunji@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VIRTIO_RDMA_DEV_API_H
+#define VIRTIO_RDMA_DEV_API_H
+
+#include "virtio-rdma-ib.h"
+
+#define VIRTIO_RDMA_CTRL_OK    0
+#define VIRTIO_RDMA_CTRL_ERR   1
+
+enum {
+    VIRTIO_CMD_QUERY_DEVICE = 10,
+    VIRTIO_CMD_QUERY_PORT,
+    VIRTIO_CMD_CREATE_CQ,
+    VIRTIO_CMD_DESTROY_CQ,
+    VIRTIO_CMD_CREATE_PD,
+    VIRTIO_CMD_DESTROY_PD,
+    VIRTIO_CMD_GET_DMA_MR,
+    VIRTIO_CMD_CREATE_MR,
+	VIRTIO_CMD_MAP_MR_SG,
+    VIRTIO_CMD_REG_USER_MR,
+	VIRTIO_CMD_DEREG_MR,
+    VIRTIO_CMD_CREATE_QP,
+    VIRTIO_CMD_MODIFY_QP,
+	VIRTIO_CMD_QUERY_QP,
+    VIRTIO_CMD_DESTROY_QP,
+    VIRTIO_CMD_QUERY_GID,
+	VIRTIO_CMD_CREATE_UC,
+	VIRTIO_CMD_DEALLOC_UC,
+	VIRTIO_CMD_QUERY_PKEY,
+	VIRTIO_MAX_CMD_NUM,
+};
+
+struct control_buf {
+    uint8_t cmd;
+    uint8_t status;
+};
+
+struct cmd_query_port {
+    uint8_t port;
+};
+
+struct virtio_rdma_port_attr {
+	enum ibv_port_state	state;
+	enum ibv_mtu		max_mtu;
+	enum ibv_mtu		active_mtu;
+	int			        gid_tbl_len;
+	unsigned int		ip_gids:1;
+	uint32_t			port_cap_flags;
+	uint32_t			max_msg_sz;
+	uint32_t			bad_pkey_cntr;
+	uint32_t			qkey_viol_cntr;
+	uint16_t			pkey_tbl_len;
+	uint32_t			sm_lid;
+	uint32_t			lid;
+	uint8_t			    lmc;
+	uint8_t         	max_vl_num;
+	uint8_t             sm_sl;
+	uint8_t             subnet_timeout;
+	uint8_t			    init_type_reply;
+	uint8_t			    active_width;
+	uint8_t			    active_speed;
+	uint8_t             phys_state;
+	uint16_t			port_cap_flags2;
+};
+
+struct cmd_create_cq {
+    uint32_t cqe;
+};
+
+struct rsp_create_cq {
+    uint32_t cqn;
+};
+
+struct cmd_destroy_cq {
+    uint32_t cqn;
+};
+
+struct cmd_create_pd {
+	uint32_t ctx_handle;
+};
+
+struct rsp_create_pd {
+    uint32_t pdn;
+};
+
+struct cmd_destroy_pd {
+    uint32_t pdn;
+};
+
+struct cmd_create_mr {
+    uint32_t pdn;
+    uint32_t access_flags;
+
+	uint32_t max_num_sg;
+};
+
+struct rsp_create_mr {
+    uint32_t mrn;
+    uint32_t lkey;
+    uint32_t rkey;
+};
+
+struct cmd_map_mr_sg {
+	uint32_t mrn;
+	uint64_t start;
+	uint32_t npages;
+
+	uint64_t pages;
+};
+
+struct rsp_map_mr_sg {
+	uint32_t npages;
+};
+
+struct cmd_reg_user_mr {
+	uint32_t pdn;
+	uint32_t access_flags;
+	uint64_t start;
+	uint64_t length;
+
+	uint64_t pages;
+	uint32_t npages;
+};
+
+struct rsp_reg_user_mr {
+	uint32_t mrn;
+	uint32_t lkey;
+	uint32_t rkey;
+};
+
+struct cmd_dereg_mr {
+    uint32_t mrn;
+
+	uint8_t is_user_mr;
+};
+
+struct rsp_dereg_mr {
+    uint32_t mrn;
+};
+
+struct cmd_create_qp {
+    uint32_t pdn;
+    uint8_t qp_type;
+    uint32_t max_send_wr;
+    uint32_t max_send_sge;
+    uint32_t send_cqn;
+    uint32_t max_recv_wr;
+    uint32_t max_recv_sge;
+    uint32_t recv_cqn;
+    uint8_t is_srq;
+    uint32_t srq_handle;
+};
+
+struct rsp_create_qp {
+    uint32_t qpn;
+};
+
+struct cmd_modify_qp {
+    uint32_t qpn;
+    uint32_t attr_mask;
+    struct virtio_rdma_qp_attr attr;
+};
+
+struct cmd_destroy_qp {
+    uint32_t qpn;
+};
+
+struct rsp_destroy_qp {
+    uint32_t qpn;
+};
+
+struct cmd_query_qp {
+	uint32_t qpn;
+	uint32_t attr_mask;
+};
+
+struct rsp_query_qp {
+	struct virtio_rdma_qp_attr attr;
+};
+
+struct cmd_query_gid {
+    uint8_t port;
+    uint32_t index;
+};
+
+struct cmd_create_uc {
+	uint64_t pfn;
+};
+
+struct rsp_create_uc {
+	uint32_t ctx_handle;
+};
+
+struct cmd_dealloc_uc {
+	uint32_t ctx_handle;
+};
+
+struct rsp_dealloc_uc {
+	uint32_t ctx_handle;
+};
+
+struct cmd_query_pkey {
+	__u8 port;
+	__u16 index;
+};
+
+struct rsp_query_pkey {
+	__u16 pkey;
+};
+
+struct cmd_post_send {
+	__u32 qpn;
+	__u32 is_kernel;
+	__u32 num_sge;
+
+	int send_flags;
+	enum virtio_rdma_wr_opcode opcode;
+	__u64 wr_id;
+
+	union {
+		__be32 imm_data;
+		__u32 invalidate_rkey;
+	} ex;
+	
+	union {
+		struct {
+			__u64 remote_addr;
+			__u32 rkey;
+		} rdma;
+		struct {
+			__u64 remote_addr;
+			__u64 compare_add;
+			__u64 swap;
+			__u32 rkey;
+		} atomic;
+		struct {
+			__u32 remote_qpn;
+			__u32 remote_qkey;
+			__u32 ahn;
+		} ud;
+        struct {
+			__u32 mrn;
+			__u32 key;
+			int access;
+		} reg;
+	} wr;
+};
+
+struct cmd_post_recv {
+	__u32 qpn;
+	__u32 is_kernel;
+
+	__u32 num_sge;
+	__u64 wr_id;
+};
+
+#endif
diff --git a/hw/rdma/virtio/virtio-rdma-ib.c b/hw/rdma/virtio/virtio-rdma-ib.c
new file mode 100644
index 0000000000..54831ec787
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-ib.c
@@ -0,0 +1,764 @@
+/*
+ * Virtio RDMA Device - IB verbs
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <infiniband/verbs.h>
+
+#include "qemu/osdep.h"
+#include "qemu/atomic.h"
+#include "cpu.h"
+
+#include "virtio-rdma-ib.h"
+#include "virtio-rdma-qp.h"
+#include "virtio-rdma-dev-api.h"
+
+#include "../rdma_utils.h"
+#include "../rdma_rm.h"
+#include "../rdma_backend.h"
+
+#include <malloc.h>
+
+int virtio_rdma_query_device(VirtIORdma *rdev, struct iovec *in,
+                             struct iovec *out)
+{
+    int offs;
+    size_t s;
+
+    addrconf_addr_eui48((unsigned char *)&rdev->dev_attr.sys_image_guid,
+                        (const char *)&rdev->netdev->mac);
+
+    offs = offsetof(struct ibv_device_attr, sys_image_guid);
+    s = iov_from_buf(out, 1, 0, (void *)&rdev->dev_attr + offs, sizeof(rdev->dev_attr) - offs);
+
+    return s == sizeof(rdev->dev_attr) - offs ? VIRTIO_RDMA_CTRL_OK :
+                                                VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_query_port(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct virtio_rdma_port_attr attr = {};
+    struct ibv_port_attr vattr = {};
+    struct cmd_query_port cmd = {};
+    int offs;
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    if (cmd.port != 1) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    if(rdma_backend_query_port(rdev->backend_dev, &vattr))
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    attr.state = vattr.state;
+    attr.max_mtu = vattr.max_mtu;
+    attr.active_mtu = vattr.active_mtu;
+    attr.gid_tbl_len = vattr.gid_tbl_len;
+    attr.port_cap_flags = vattr.port_cap_flags;
+    attr.max_msg_sz = vattr.max_msg_sz;
+    attr.bad_pkey_cntr = vattr.bad_pkey_cntr;
+    attr.qkey_viol_cntr = vattr.qkey_viol_cntr;
+    attr.pkey_tbl_len = vattr.pkey_tbl_len;
+    attr.lid = vattr.lid;
+    attr.sm_lid = vattr.sm_lid;
+    attr.lmc = vattr.lmc;
+    attr.max_vl_num = vattr.max_vl_num;
+    attr.sm_sl = vattr.sm_sl;
+    attr.subnet_timeout = vattr.subnet_timeout;
+    attr.init_type_reply = vattr.init_type_reply;
+    attr.active_width = vattr.active_width;
+    attr.active_speed = vattr.phys_state;
+    attr.phys_state = vattr.phys_state;
+    attr.port_cap_flags2 = vattr.port_cap_flags2;
+
+    offs = offsetof(struct virtio_rdma_port_attr, state);
+
+    s = iov_from_buf(out, 1, 0, (void *)&attr + offs, sizeof(attr) - offs);
+
+    return s == sizeof(attr) - offs ? VIRTIO_RDMA_CTRL_OK :
+                                      VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_create_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_create_cq cmd = {};
+    struct rsp_create_cq rsp = {};
+    size_t s;
+    int rc;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    /* TODO: Define MAX_CQE */
+#define MAX_CQE 1024
+    /* TODO: Check MAX_CQ */
+    if (cmd.cqe > MAX_CQE) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, cmd.cqe);
+
+    rc = rdma_rm_alloc_cq(rdev->rdma_dev_res, rdev->backend_dev, cmd.cqe,
+                          &rsp.cqn, NULL);
+    if (rc)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    printf("%s: %d\n", __func__, rsp.cqn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_destroy_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_destroy_cq cmd = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, cmd.cqn);
+
+    virtqueue_drop_all(rdev->cq_vqs[cmd.cqn]);
+    rdma_rm_dealloc_cq(rdev->rdma_dev_res, cmd.cqn);
+
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_create_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_create_pd cmd = {};
+    struct rsp_create_pd rsp = {};
+    size_t s;
+    int rc;
+
+    if (qatomic_inc_fetch(&rdev->num_pd) > rdev->dev_attr.max_pd)
+        goto err;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd))
+        goto err;
+
+    /* TODO: Check MAX_PD */
+
+    rc = rdma_rm_alloc_pd(rdev->rdma_dev_res, rdev->backend_dev, &rsp.pdn,
+                          cmd.ctx_handle);
+    if (rc)
+        goto err;
+
+    printf("%s: pdn %d  num_pd %d\n", __func__, rsp.pdn, qatomic_read(&rdev->num_pd));
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    if (s == sizeof(rsp))
+        return VIRTIO_RDMA_CTRL_OK;
+
+err:
+    qatomic_dec(&rdev->num_pd);
+    return VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_destroy_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_destroy_pd cmd = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d\n", __func__, cmd.pdn);
+
+    rdma_rm_dealloc_pd(rdev->rdma_dev_res, cmd.pdn);
+
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_get_dma_mr(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct cmd_create_mr cmd = {};
+    struct rsp_create_mr rsp = {};
+    size_t s;
+    uint32_t *htbl_key;
+    struct virtio_rdma_kernel_mr *kernel_mr;
+
+    // FIXME: how to support dma mr
+    rdma_warn_report("DMA mr is not supported now");
+
+    htbl_key = g_malloc0(sizeof(*htbl_key));
+    if (htbl_key == NULL)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    kernel_mr = g_malloc0(sizeof(*kernel_mr));
+    if (kernel_mr == NULL) {
+        g_free(htbl_key);
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        g_free(kernel_mr);
+        g_free(htbl_key);
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    rdma_rm_alloc_mr(rdev->rdma_dev_res, cmd.pdn, 0, 0, NULL, cmd.access_flags, &rsp.mrn, &rsp.lkey, &rsp.rkey);
+
+    *htbl_key = rsp.lkey;
+    kernel_mr->dummy_mr = rdma_rm_get_mr(rdev->rdma_dev_res, rsp.mrn);
+    kernel_mr->max_num_sg = cmd.max_num_sg;
+    kernel_mr->real_mr = NULL;
+    kernel_mr->dma_mr = true;
+    g_hash_table_insert(rdev->lkey_mr_tbl, htbl_key, kernel_mr);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_create_mr(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_create_mr cmd = {};
+    struct rsp_create_mr rsp = {};
+    size_t s;
+    void* map_addr;
+    // uint64_t length;
+    uint32_t *htbl_key;
+    struct virtio_rdma_kernel_mr *kernel_mr;
+    RdmaRmMR *mr;
+
+    htbl_key = g_malloc0(sizeof(*htbl_key));
+    if (htbl_key == NULL)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    kernel_mr = g_malloc0(sizeof(*kernel_mr));
+    if (kernel_mr == NULL) {
+        g_free(htbl_key);
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        g_free(kernel_mr);
+        g_free(htbl_key);
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    // when length is zero, will return same lkey
+    map_addr = mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+    rdma_rm_alloc_mr(rdev->rdma_dev_res, cmd.pdn, (uint64_t)map_addr, TARGET_PAGE_SIZE, map_addr, cmd.access_flags, &rsp.mrn, &rsp.lkey, &rsp.rkey);
+    // rkey is -1, because in kernel mode mr cannot access from remotes
+
+    /* we need to build a lkey to MR map, in order to set the local address
+     * in post_send and post_recv.
+     */
+    *htbl_key = rsp.lkey;
+    mr = rdma_rm_get_mr(rdev->rdma_dev_res, rsp.mrn);
+    mr->lkey = rsp.lkey;
+    kernel_mr->dummy_mr = mr;
+    kernel_mr->max_num_sg = cmd.max_num_sg;
+    kernel_mr->real_mr = NULL;
+    kernel_mr->dma_mr = false;
+    g_hash_table_insert(rdev->lkey_mr_tbl, htbl_key, kernel_mr);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+static int remap_pages(AddressSpace *as, uint64_t *pages, void* remap_start, int npages)
+{
+    int i;
+    void* addr;
+    void* curr_page;
+    dma_addr_t len = TARGET_PAGE_SIZE;
+
+    for (i = 0; i < npages; i++) {
+        rdma_info_report("remap page %lx to %p", pages[i], remap_start + TARGET_PAGE_SIZE * i);
+        curr_page = dma_memory_map(as, pages[i], &len, DMA_DIRECTION_TO_DEVICE);
+        addr = mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
+                     remap_start + TARGET_PAGE_SIZE * i);
+        dma_memory_unmap(as, curr_page, TARGET_PAGE_SIZE, DMA_DIRECTION_TO_DEVICE, 0);
+        if (addr == MAP_FAILED)
+            break;
+    }
+    return i;
+}
+
+int virtio_rdma_map_mr_sg(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_map_mr_sg cmd = {};
+    struct rsp_map_mr_sg rsp = {};
+    size_t s;
+    uint64_t *pages;
+    dma_addr_t len = TARGET_PAGE_SIZE;
+    RdmaRmMR *mr;
+    void *remap_addr;
+    AddressSpace *dma_as = VIRTIO_DEVICE(rdev)->dma_as;
+    struct virtio_rdma_kernel_mr *kmr;
+    uint32_t num_pages;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    mr = rdma_rm_get_mr(rdev->rdma_dev_res, cmd.mrn);
+    if (!mr) {
+        rdma_error_report("get mr failed\n");
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    pages = dma_memory_map(dma_as, cmd.pages, &len, DMA_DIRECTION_TO_DEVICE);
+
+    kmr = g_hash_table_lookup(rdev->lkey_mr_tbl, &mr->lkey);
+    if (!kmr) {
+        rdma_error_report("Get kmr failed\n");
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    num_pages = kmr->max_num_sg > cmd.npages ? cmd.npages : kmr->max_num_sg;
+    remap_addr = mmap(0, num_pages * TARGET_PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
+    rsp.npages = remap_pages(dma_as, pages, remap_addr, num_pages);
+    dma_memory_unmap(dma_as, pages, len, DMA_DIRECTION_TO_DEVICE, 0);
+
+    // rdma_rm_alloc_mr(rdev->rdma_dev_res, mr->pd_handle, (uint64_t)remap_addr, num_pages * TARGET_PAGE_SIZE,
+    //                  remap_addr, IBV_ACCESS_LOCAL_WRITE, &kmr->mrn, &kmr->lkey, &kmr->rkey);
+
+    kmr->virt = remap_addr;
+    kmr->length = num_pages * TARGET_PAGE_SIZE;
+    kmr->start = cmd.start;
+    // kmr->real_mr = rdma_rm_get_mr(rdev->rdma_dev_res, kmr->mrn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_reg_user_mr(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_reg_user_mr cmd = {};
+    struct rsp_reg_user_mr rsp = {};
+    size_t s;
+    uint64_t *pages;
+    dma_addr_t len = TARGET_PAGE_SIZE;
+    void *remap_addr, *curr_page;
+    AddressSpace *dma_as = VIRTIO_DEVICE(rdev)->dma_as;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    pages = dma_memory_map(dma_as, cmd.pages, &len, DMA_DIRECTION_TO_DEVICE);
+
+    curr_page = dma_memory_map(dma_as, pages[0], &len, DMA_DIRECTION_TO_DEVICE);
+    remap_addr = mremap(curr_page, 0, TARGET_PAGE_SIZE * cmd.npages, MREMAP_MAYMOVE);
+    dma_memory_unmap(dma_as, curr_page, TARGET_PAGE_SIZE, DMA_DIRECTION_TO_DEVICE, 0);
+    if (remap_addr == MAP_FAILED) {
+        rdma_error_report("mremap failed\n");
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    remap_pages(dma_as, pages + 1, remap_addr + TARGET_PAGE_SIZE, cmd.npages - 1);
+    dma_memory_unmap(dma_as, pages, len, DMA_DIRECTION_TO_DEVICE, 0);
+
+    rdma_rm_alloc_mr(rdev->rdma_dev_res, cmd.pdn, cmd.start, TARGET_PAGE_SIZE * cmd.npages,
+                     remap_addr, cmd.access_flags, &rsp.mrn, &rsp.lkey, &rsp.rkey);
+    rsp.rkey = rdma_backend_mr_rkey(&rdma_rm_get_mr(rdev->rdma_dev_res, rsp.mrn)->backend_mr);
+    rdma_info_report("%s: 0x%x\n", __func__, rsp.mrn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_dereg_mr(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_dereg_mr cmd = {};
+    struct RdmaRmMR *mr;
+    struct virtio_rdma_kernel_mr *kmr;
+    size_t s;
+    uint32_t lkey;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    mr = rdma_rm_get_mr(rdev->rdma_dev_res, cmd.mrn);
+    if (!mr)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    if (!cmd.is_user_mr) {
+        lkey = mr->lkey;
+        kmr = g_hash_table_lookup(rdev->lkey_mr_tbl, &lkey);
+        if (!kmr)
+            return VIRTIO_RDMA_CTRL_ERR;
+        rdma_backend_destroy_mr(&kmr->dummy_mr->backend_mr);
+        mr = kmr->real_mr;
+        g_hash_table_remove(rdev->lkey_mr_tbl, &lkey);
+        if (!mr)
+            return VIRTIO_RDMA_CTRL_OK;
+    }
+
+    munmap(mr->virt, mr->length);
+    rdma_backend_destroy_mr(&mr->backend_mr);
+    g_free(kmr);
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_create_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_create_qp cmd = {};
+    struct rsp_create_qp rsp = {};
+    size_t s;
+    int rc;
+    //uint32_t recv_cqn;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    // TODO: check max qp
+
+    printf("%s: %d qp type %d\n", __func__, cmd.pdn, cmd.qp_type);
+
+    // store recv_cqn in opaque
+    rc = rdma_rm_alloc_qp(rdev->rdma_dev_res, cmd.pdn, cmd.qp_type, cmd.max_send_wr,
+                          cmd.max_send_sge, cmd.send_cqn, cmd.max_recv_wr,
+                          cmd.max_recv_sge, cmd.recv_cqn, NULL, &rsp.qpn,
+                          cmd.is_srq, cmd.srq_handle);
+
+    if (rc)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    printf("%s: %d\n", __func__, rsp.qpn);
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+static void virtio_rdma_ah_attr_to_ibv (struct virtio_rdma_ah_attr *ah_attr, struct ibv_ah_attr *ibv_attr) {
+    ibv_attr->grh.dgid = ah_attr->grh.dgid;
+    ibv_attr->grh.flow_label = ah_attr->grh.flow_label;
+    ibv_attr->grh.sgid_index = ah_attr->grh.sgid_index;
+    ibv_attr->grh.hop_limit = ah_attr->grh.hop_limit;
+    ibv_attr->grh.traffic_class = ah_attr->grh.traffic_class;
+
+    ibv_attr->dlid = ah_attr->dlid;
+    ibv_attr->sl = ah_attr->sl;
+    ibv_attr->src_path_bits = ah_attr->src_path_bits;
+    ibv_attr->static_rate = ah_attr->static_rate;
+    ibv_attr->port_num = ah_attr->port_num;
+}
+
+int virtio_rdma_modify_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_modify_qp cmd = {};
+    size_t s;
+    int rc;
+
+    RdmaRmQP *rqp;
+    struct ibv_qp_attr attr = {};
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    printf("%s: %d %d\n", __func__, cmd.qpn, cmd.attr.qp_state);
+
+    rqp = rdma_rm_get_qp(rdev->rdma_dev_res, cmd.qpn);
+    if (!rqp)
+        printf("Get qp failed\n");
+
+    if (rqp->qp_type == IBV_QPT_GSI) {
+        return VIRTIO_RDMA_CTRL_OK;
+    }
+
+    // TODO: assign attr based on cmd.attr_mask
+    attr.qp_state = cmd.attr.qp_state;
+    attr.cur_qp_state = cmd.attr.cur_qp_state;
+    attr.path_mtu = cmd.attr.path_mtu;
+    attr.path_mig_state = cmd.attr.path_mig_state;
+    attr.qkey = cmd.attr.qkey;
+    attr.rq_psn = cmd.attr.rq_psn;
+    attr.sq_psn = cmd.attr.sq_psn;
+    attr.dest_qp_num = cmd.attr.dest_qp_num;
+    attr.qp_access_flags = cmd.attr.qp_access_flags;
+    attr.pkey_index = cmd.attr.pkey_index;
+    attr.en_sqd_async_notify = cmd.attr.en_sqd_async_notify;
+    attr.sq_draining = cmd.attr.sq_draining;
+    attr.max_rd_atomic = cmd.attr.max_rd_atomic;
+    attr.max_dest_rd_atomic = cmd.attr.max_dest_rd_atomic;
+    attr.min_rnr_timer = cmd.attr.min_rnr_timer;
+    attr.port_num = cmd.attr.port_num;
+    attr.timeout = cmd.attr.timeout;
+    attr.retry_cnt = cmd.attr.retry_cnt;
+    attr.rnr_retry = cmd.attr.rnr_retry;
+    attr.alt_port_num = cmd.attr.alt_port_num;
+    attr.alt_timeout = cmd.attr.alt_timeout;
+    attr.rate_limit = cmd.attr.rate_limit;
+    attr.cap.max_inline_data = cmd.attr.cap.max_inline_data;
+    attr.cap.max_recv_sge = cmd.attr.cap.max_recv_sge;
+    attr.cap.max_recv_wr = cmd.attr.cap.max_recv_wr;
+    attr.cap.max_send_sge = cmd.attr.cap.max_send_sge;
+    attr.cap.max_send_wr = cmd.attr.cap.max_send_wr;
+    virtio_rdma_ah_attr_to_ibv(&cmd.attr.ah_attr, &attr.ah_attr);
+    virtio_rdma_ah_attr_to_ibv(&cmd.attr.alt_ah_attr, &attr.alt_ah_attr);
+
+    rqp->qp_state = cmd.attr.qp_state;
+
+    if (rqp->qp_state == IBV_QPS_RTR) {
+        rqp->backend_qp.sgid_idx = cmd.attr.ah_attr.grh.sgid_index;
+        attr.ah_attr.grh.sgid_index = cmd.attr.ah_attr.grh.sgid_index;
+        attr.ah_attr.is_global  = 1;
+    }
+    
+    printf("modify_qp_debug %d %d %d %d %d %d %d %d\n", cmd.qpn, cmd.attr_mask, cmd.attr.ah_attr.grh.sgid_index,
+           cmd.attr.dest_qp_num, cmd.attr.qp_state, cmd.attr.qkey, cmd.attr.rq_psn, cmd.attr.sq_psn);
+
+    rc = ibv_modify_qp(rqp->backend_qp.ibqp, &attr, cmd.attr_mask);
+    /*
+    rc = rdma_rm_modify_qp(rdev->rdma_dev_res, rdev->backend_dev,
+                           cmd.qpn, cmd.attr_mask,
+                           cmd.attr.ah_attr.grh.sgid_index,
+                           &cmd.attr.ah_attr.grh.dgid,
+                           cmd.attr.dest_qp_num,
+                           (enum ibv_qp_state)cmd.attr.qp_state,
+                           cmd.attr.qkey, cmd.attr.rq_psn,
+                           cmd.attr.sq_psn);*/
+
+    if (rc) {
+        rdma_error_report( "ibv_modify_qp fail, rc=%d, errno=%d", rc, errno);
+        return -EIO;
+    }
+    return rc;
+}
+
+int virtio_rdma_query_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_query_qp cmd = {};
+    struct rsp_query_qp rsp = {};
+    struct ibv_qp_init_attr init_attr;
+    size_t s;
+    int rc;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    memset(&rsp, 0, sizeof(rsp));
+
+    rc = rdma_rm_query_qp(rdev->rdma_dev_res, rdev->backend_dev, cmd.qpn,
+                          (struct ibv_qp_attr *)&rsp.attr, cmd.attr_mask,
+                          &init_attr);
+    if (rc)
+        return -EIO;
+    
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_destroy_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out)
+{
+    struct cmd_destroy_qp cmd = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    rdma_info_report("%s: %d", __func__, cmd.qpn);
+
+    rdma_rm_dealloc_qp(rdev->rdma_dev_res, cmd.qpn);
+
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_query_gid(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct cmd_query_gid cmd = {};
+    union ibv_gid gid = {};
+    size_t s;
+    int rc;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    rc = ibv_query_gid(rdev->backend_dev->context, cmd.port, cmd.index,
+                       &gid);
+    if (rc)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    s = iov_from_buf(out, 1, 0, &gid, sizeof(gid));
+
+    return s == sizeof(gid) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_create_uc(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct cmd_create_uc cmd = {};
+    struct rsp_create_uc rsp = {};
+    size_t s;
+    int rc;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    rc = rdma_rm_alloc_uc(rdev->rdma_dev_res, cmd.pfn, &rsp.ctx_handle);
+
+    if (rc)
+        return VIRTIO_RDMA_CTRL_ERR;
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+int virtio_rdma_dealloc_uc(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct cmd_dealloc_uc cmd = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    rdma_rm_dealloc_uc(rdev->rdma_dev_res, cmd.ctx_handle);
+
+    return VIRTIO_RDMA_CTRL_OK;
+}
+
+int virtio_rdma_query_pkey(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out)
+{
+    struct cmd_query_pkey cmd = {};
+    struct rsp_query_pkey rsp = {};
+    size_t s;
+
+    s = iov_to_buf(in, 1, 0, &cmd, sizeof(cmd));
+    if (s != sizeof(cmd)) {
+        return VIRTIO_RDMA_CTRL_ERR;
+    }
+
+    rsp.pkey = 0xFFFF;
+
+    s = iov_from_buf(out, 1, 0, &rsp, sizeof(rsp));
+
+    return s == sizeof(rsp) ? VIRTIO_RDMA_CTRL_OK :
+                              VIRTIO_RDMA_CTRL_ERR;
+}
+
+static void virtio_rdma_init_dev_caps(VirtIORdma *rdev)
+{
+    rdev->dev_attr.max_qp_wr = 1024;
+}
+
+int virtio_rdma_init_ib(VirtIORdma *rdev)
+{
+    int rc;
+
+    virtio_rdma_init_dev_caps(rdev);
+
+    rdev->rdma_dev_res = g_malloc0(sizeof(RdmaDeviceResources));
+    rdev->backend_dev = g_malloc0(sizeof(RdmaBackendDev));
+
+    rc = rdma_backend_init(rdev->backend_dev, NULL, rdev->rdma_dev_res,
+                           rdev->backend_device_name,
+                           rdev->backend_port_num, &rdev->dev_attr,
+                           &rdev->mad_chr);
+    if (rc) {
+        rdma_error_report("Fail to initialize backend device");
+        return rc;
+    }
+
+    rdev->dev_attr.max_mr_size = 4096;
+    rdev->dev_attr.page_size_cap = 4096;
+    rdev->dev_attr.vendor_id = 1;
+    rdev->dev_attr.vendor_part_id = 1;
+    rdev->dev_attr.hw_ver = VIRTIO_RDMA_HW_VER;
+    rdev->dev_attr.atomic_cap = IBV_ATOMIC_NONE;
+    rdev->dev_attr.max_pkeys = 1;
+    rdev->dev_attr.phys_port_cnt = VIRTIO_RDMA_PORT_CNT;
+
+    rc = rdma_rm_init(rdev->rdma_dev_res, &rdev->dev_attr);
+    if (rc) {
+        rdma_error_report("Fail to initialize resource manager");
+        return rc;
+    }
+
+    virtio_rdma_qp_ops_init();
+
+    rdma_backend_start(rdev->backend_dev);
+
+    return 0;
+}
+
+void virtio_rdma_fini_ib(VirtIORdma *rdev)
+{
+    rdma_backend_stop(rdev->backend_dev);
+    virtio_rdma_qp_ops_fini();
+    rdma_rm_fini(rdev->rdma_dev_res, rdev->backend_dev,
+                 rdev->backend_eth_device_name);
+    rdma_backend_fini(rdev->backend_dev);
+    g_free(rdev->rdma_dev_res);
+    g_free(rdev->backend_dev);
+}
diff --git a/hw/rdma/virtio/virtio-rdma-ib.h b/hw/rdma/virtio/virtio-rdma-ib.h
new file mode 100644
index 0000000000..457b25f998
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-ib.h
@@ -0,0 +1,176 @@
+/*
+ * Virtio RDMA Device - IB verbs
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VIRTIO_RDMA_IB_H
+#define VIRTIO_RDMA_IB_H
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "hw/virtio/virtio-rdma.h"
+
+#include "../rdma_rm.h"
+
+enum virtio_rdma_wr_opcode {
+	VIRTIO_RDMA_WR_RDMA_WRITE,
+	VIRTIO_RDMA_WR_RDMA_WRITE_WITH_IMM,
+	VIRTIO_RDMA_WR_SEND,
+	VIRTIO_RDMA_WR_SEND_WITH_IMM,
+	VIRTIO_RDMA_WR_RDMA_READ,
+	VIRTIO_RDMA_WR_ATOMIC_CMP_AND_SWP,
+	VIRTIO_RDMA_WR_ATOMIC_FETCH_AND_ADD,
+	VIRTIO_RDMA_WR_LOCAL_INV,
+	VIRTIO_RDMA_WR_BIND_MW,
+	VIRTIO_RDMA_WR_SEND_WITH_INV,
+	VIRTIO_RDMA_WR_TSO,
+	VIRTIO_RDMA_WR_DRIVER1,
+
+	VIRTIO_RDMA_WR_REG_MR = 0x20,
+};
+
+struct virtio_rdma_cqe {
+	uint64_t		wr_id;
+	enum ibv_wc_status status;
+	enum ibv_wc_opcode opcode;
+	uint32_t vendor_err;
+	uint32_t byte_len;
+	uint32_t imm_data;
+	uint32_t qp_num;
+	uint32_t src_qp;
+	int	 wc_flags;
+	uint16_t pkey_index;
+	uint16_t slid;
+	uint8_t sl;
+	uint8_t dlid_path_bits;
+};
+
+struct CompHandlerCtx {
+	VirtIORdma *dev;
+    uint32_t cq_handle;
+    struct virtio_rdma_cqe cqe;
+};
+
+struct virtio_rdma_kernel_mr {
+	RdmaRmMR *dummy_mr; // created by create_mr
+	RdmaRmMR *real_mr; // real mr created by map_mr_sg
+
+	void* virt;
+	uint64_t length;
+	uint64_t start;
+	uint32_t mrn;
+	uint32_t lkey;
+	uint32_t rkey;
+
+	uint32_t max_num_sg;
+	uint8_t dma_mr;
+};
+
+struct virtio_rdma_global_route {
+	union ibv_gid		dgid;
+	uint32_t		flow_label;
+	uint8_t			sgid_index;
+	uint8_t			hop_limit;
+	uint8_t			traffic_class;
+};
+
+struct virtio_rdma_ah_attr {
+	struct virtio_rdma_global_route	grh;
+	uint16_t			dlid;
+	uint8_t				sl;
+	uint8_t				src_path_bits;
+	uint8_t				static_rate;
+	uint8_t				port_num;
+};
+
+struct virtio_rdma_qp_cap {
+	uint32_t		max_send_wr;
+	uint32_t		max_recv_wr;
+	uint32_t		max_send_sge;
+	uint32_t		max_recv_sge;
+	uint32_t		max_inline_data;
+};
+
+struct virtio_rdma_qp_attr {
+	enum ibv_qp_state	qp_state;
+	enum ibv_qp_state	cur_qp_state;
+	enum ibv_mtu		path_mtu;
+	enum ibv_mig_state	path_mig_state;
+	uint32_t			qkey;
+	uint32_t			rq_psn;
+	uint32_t			sq_psn;
+	uint32_t			dest_qp_num;
+	uint32_t			qp_access_flags;
+	uint16_t			pkey_index;
+	uint16_t			alt_pkey_index;
+	uint8_t			en_sqd_async_notify;
+	uint8_t			sq_draining;
+	uint8_t			max_rd_atomic;
+	uint8_t			max_dest_rd_atomic;
+	uint8_t			min_rnr_timer;
+	uint8_t			port_num;
+	uint8_t			timeout;
+	uint8_t			retry_cnt;
+	uint8_t			rnr_retry;
+	uint8_t			alt_port_num;
+	uint8_t			alt_timeout;
+	uint32_t			rate_limit;
+	struct virtio_rdma_qp_cap	cap;
+	struct virtio_rdma_ah_attr	ah_attr;
+	struct virtio_rdma_ah_attr	alt_ah_attr;
+};
+
+#define VIRTIO_RDMA_PORT_CNT    1
+#define VIRTIO_RDMA_HW_VER      1
+
+int virtio_rdma_init_ib(VirtIORdma *rdev);
+void virtio_rdma_fini_ib(VirtIORdma *rdev);
+
+int virtio_rdma_query_device(VirtIORdma *rdev, struct iovec *in,
+                             struct iovec *out);
+int virtio_rdma_query_port(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+int virtio_rdma_create_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_destroy_cq(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_create_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_destroy_pd(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_get_dma_mr(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+int virtio_rdma_create_mr(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_reg_user_mr(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_create_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_modify_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_query_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_query_gid(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+int virtio_rdma_destroy_qp(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_map_mr_sg(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_dereg_mr(VirtIORdma *rdev, struct iovec *in,
+                          struct iovec *out);
+int virtio_rdma_create_uc(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+int virtio_rdma_query_pkey(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+int virtio_rdma_dealloc_uc(VirtIORdma *rdev, struct iovec *in,
+                           struct iovec *out);
+
+#endif
diff --git a/hw/rdma/virtio/virtio-rdma-main.c b/hw/rdma/virtio/virtio-rdma-main.c
new file mode 100644
index 0000000000..a69f0eb054
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-main.c
@@ -0,0 +1,231 @@
+/*
+ * Virtio RDMA Device
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <infiniband/verbs.h>
+#include <unistd.h>
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-rdma.h"
+#include "hw/qdev-properties.h"
+#include "include/standard-headers/linux/virtio_ids.h"
+
+#include "virtio-rdma-ib.h"
+#include "virtio-rdma-qp.h"
+#include "virtio-rdma-dev-api.h"
+
+#include "../rdma_rm_defs.h"
+#include "../rdma_utils.h"
+
+#define DEFINE_VIRTIO_RDMA_CMD(cmd, handler) [cmd] = {handler, #cmd},
+
+struct {
+    int (*handler)(VirtIORdma *rdev, struct iovec *in, struct iovec *out);
+    const char* name;
+} cmd_tbl[] = {
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_QUERY_DEVICE, virtio_rdma_query_device)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_QUERY_PORT, virtio_rdma_query_port)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_CREATE_CQ, virtio_rdma_create_cq)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_DESTROY_CQ, virtio_rdma_destroy_cq)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_CREATE_PD, virtio_rdma_create_pd)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_DESTROY_PD, virtio_rdma_destroy_pd)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_GET_DMA_MR, virtio_rdma_get_dma_mr)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_CREATE_MR, virtio_rdma_create_mr)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_MAP_MR_SG, virtio_rdma_map_mr_sg)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_REG_USER_MR, virtio_rdma_reg_user_mr)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_DEREG_MR, virtio_rdma_dereg_mr)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_CREATE_QP, virtio_rdma_create_qp)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_MODIFY_QP, virtio_rdma_modify_qp)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_QUERY_QP, virtio_rdma_query_qp)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_DESTROY_QP, virtio_rdma_destroy_qp)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_QUERY_GID, virtio_rdma_query_gid)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_CREATE_UC, virtio_rdma_create_uc)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_DEALLOC_UC, virtio_rdma_dealloc_uc)
+    DEFINE_VIRTIO_RDMA_CMD(VIRTIO_CMD_QUERY_PKEY, virtio_rdma_query_pkey)
+};
+
+static void virtio_rdma_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIORdma *r = VIRTIO_RDMA(vdev);
+    struct control_buf cb;
+    VirtQueueElement *e;
+    size_t s;
+
+    virtio_queue_set_notification(vq, 0);
+
+    for (;;) {
+        e = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!e) {
+            break;
+        }
+
+        if (iov_size(e->in_sg, e->in_num) < sizeof(cb.status) ||
+            iov_size(e->out_sg, e->out_num) < sizeof(cb.cmd)) {
+            virtio_error(vdev, "Got invalid message size");
+            virtqueue_detach_element(vq, e, 0);
+            g_free(e);
+            break;
+        }
+
+        s = iov_to_buf(&e->out_sg[0], 1, 0, &cb.cmd, sizeof(cb.cmd));
+        if (s != sizeof(cb.cmd)) {
+            cb.status = VIRTIO_RDMA_CTRL_ERR;
+        } else {
+            printf("cmd=%d %s\n", cb.cmd, cmd_tbl[cb.cmd].name);
+            if (cb.cmd >= VIRTIO_MAX_CMD_NUM) {
+                rdma_warn_report("unknown cmd %d\n", cb.cmd);
+                cb.status = VIRTIO_RDMA_CTRL_ERR;
+            } else {
+                if (cmd_tbl[cb.cmd].handler) {
+                    cb.status = cmd_tbl[cb.cmd].handler(r, &e->out_sg[1],
+                                                        &e->in_sg[0]);
+                } else {
+                    rdma_warn_report("no handler for cmd %d\n", cb.cmd);
+                    cb.status = VIRTIO_RDMA_CTRL_ERR;
+                }
+            }
+        }
+        printf("status=%d\n", cb.status);
+        s = iov_from_buf(&e->in_sg[1], 1, 0, &cb.status, sizeof(cb.status));
+        assert(s == sizeof(cb.status));
+
+        virtqueue_push(vq, e, sizeof(cb.status));
+        g_free(e);
+        virtio_notify(vdev, vq);
+    }
+
+    virtio_queue_set_notification(vq, 1);
+}
+
+static void g_free_destroy(gpointer data) {
+    g_free(data);
+}
+
+static void virtio_rdma_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORdma *r = VIRTIO_RDMA(dev);
+    int rc, i;
+
+    rc = virtio_rdma_init_ib(r);
+    if (rc) {
+        rdma_error_report("Fail to initialize IB layer");
+        return;
+    }
+
+    virtio_init(vdev, "virtio-rdma", VIRTIO_ID_RDMA, 1024);
+
+    r->lkey_mr_tbl = g_hash_table_new_full(g_int_hash, g_int_equal, g_free_destroy, NULL);
+
+    r->ctrl_vq = virtio_add_queue(vdev, 64, virtio_rdma_handle_ctrl);
+
+    r->cq_vqs = g_malloc0_n(64, sizeof(*r->cq_vqs));
+    for (i = 0; i < 64; i++) {
+        r->cq_vqs[i] = virtio_add_queue(vdev, 64, NULL);
+    }
+
+    r->qp_vqs = g_malloc0_n(64 * 2, sizeof(*r->cq_vqs));
+    for (i = 0; i < 64 * 2; i += 2) {
+        r->qp_vqs[i] = virtio_add_queue(vdev, 64, virtio_rdma_handle_sq);
+        r->qp_vqs[i+1] = virtio_add_queue(vdev, 64, virtio_rdma_handle_rq);
+    }
+}
+
+static void virtio_rdma_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORdma *r = VIRTIO_RDMA(dev);
+
+    virtio_del_queue(vdev, 0);
+
+    virtio_cleanup(vdev);
+
+    virtio_rdma_fini_ib(r);
+}
+
+static uint64_t virtio_rdma_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    /* virtio_add_feature(&features, VIRTIO_NET_F_MAC); */
+
+    vdev->backend_features = features;
+
+    return features;
+}
+
+
+static Property virtio_rdma_dev_properties[] = {
+    DEFINE_PROP_STRING("netdev", VirtIORdma, backend_eth_device_name),
+    DEFINE_PROP_STRING("ibdev",VirtIORdma, backend_device_name),
+    DEFINE_PROP_UINT8("ibport", VirtIORdma, backend_port_num, 1),
+    DEFINE_PROP_UINT64("dev-caps-max-mr-size", VirtIORdma, dev_attr.max_mr_size,
+                       MAX_MR_SIZE),
+    DEFINE_PROP_INT32("dev-caps-max-qp", VirtIORdma, dev_attr.max_qp, MAX_QP),
+    DEFINE_PROP_INT32("dev-caps-max-cq", VirtIORdma, dev_attr.max_cq, MAX_CQ),
+    DEFINE_PROP_INT32("dev-caps-max-mr", VirtIORdma, dev_attr.max_mr, MAX_MR),
+    DEFINE_PROP_INT32("dev-caps-max-pd", VirtIORdma, dev_attr.max_pd, MAX_PD),
+    DEFINE_PROP_INT32("dev-caps-qp-rd-atom", VirtIORdma,
+                       dev_attr.max_qp_rd_atom, MAX_QP_RD_ATOM),
+    DEFINE_PROP_INT32("dev-caps-max-qp-init-rd-atom", VirtIORdma,
+                      dev_attr.max_qp_init_rd_atom, MAX_QP_INIT_RD_ATOM),
+    DEFINE_PROP_INT32("dev-caps-max-ah", VirtIORdma, dev_attr.max_ah, MAX_AH),
+    DEFINE_PROP_INT32("dev-caps-max-srq", VirtIORdma, dev_attr.max_srq, MAX_SRQ),
+    DEFINE_PROP_CHR("mad-chardev", VirtIORdma, mad_chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+struct virtio_rdma_config {
+    int32_t max_cq;
+};
+
+static void virtio_rdma_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VirtIORdma *r = VIRTIO_RDMA(vdev);
+    struct virtio_rdma_config cfg;
+
+    cfg.max_cq = r->dev_attr.max_cq;
+
+    memcpy(config, &cfg, sizeof(cfg));
+}
+
+static void virtio_rdma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    vdc->realize = virtio_rdma_device_realize;
+    vdc->unrealize = virtio_rdma_device_unrealize;
+    vdc->get_features = virtio_rdma_get_features;
+    vdc->get_config = virtio_rdma_get_config;
+
+    dc->desc = "Virtio RDMA Device";
+    device_class_set_props(dc, virtio_rdma_dev_properties);
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo virtio_rdma_info = {
+    .name = TYPE_VIRTIO_RDMA,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIORdma),
+    .class_init = virtio_rdma_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_rdma_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/rdma/virtio/virtio-rdma-qp.c b/hw/rdma/virtio/virtio-rdma-qp.c
new file mode 100644
index 0000000000..8b95c115cb
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-qp.c
@@ -0,0 +1,241 @@
+/*
+ * Virtio RDMA Device - QP ops
+ *
+ * Copyright (C) 2021 Bytedance Inc.
+ *
+ * Authors:
+ *  Junji Wei <weijunji@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <infiniband/verbs.h>
+#include <malloc.h>
+
+#include "qemu/osdep.h"
+#include "qemu/atomic.h"
+#include "cpu.h"
+
+#include "virtio-rdma-ib.h"
+#include "virtio-rdma-qp.h"
+#include "virtio-rdma-dev-api.h"
+
+#include "../rdma_utils.h"
+#include "../rdma_rm.h"
+#include "../rdma_backend.h"
+
+void virtio_rdma_qp_ops_comp_handler(void *ctx, struct ibv_wc *wc)
+{
+    VirtQueueElement *e;
+    VirtQueue *vq;
+    struct CompHandlerCtx *comp_ctx = (struct CompHandlerCtx *)ctx;
+    size_t s;
+    struct virtio_rdma_cqe* cqe;
+
+    vq = comp_ctx->dev->cq_vqs[comp_ctx->cq_handle];
+    e = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!e) {
+        rdma_error_report("pop cq vq failed");
+    }
+
+    cqe = &comp_ctx->cqe;
+    cqe->status = wc->status;
+    cqe->opcode = wc->opcode;
+    cqe->vendor_err = wc->vendor_err;
+    cqe->byte_len = wc->byte_len;
+    cqe->imm_data = wc->imm_data;
+    cqe->src_qp = wc->src_qp;
+    cqe->wc_flags = wc->wc_flags;
+    cqe->pkey_index = wc->pkey_index;
+    cqe->slid = wc->slid;
+    cqe->sl = wc->sl;
+    cqe->dlid_path_bits = wc->dlid_path_bits;
+
+    s = iov_from_buf(&e->in_sg[0], 1, 0, &comp_ctx->cqe, sizeof(comp_ctx->cqe));
+    assert(s == sizeof(comp_ctx->cqe));
+    virtqueue_push(vq, e, sizeof(comp_ctx->cqe));
+
+    virtio_notify(&comp_ctx->dev->parent_obj, vq);
+
+    g_free(e);
+    g_free(comp_ctx);
+}
+
+void virtio_rdma_qp_ops_fini(void)
+{
+    rdma_backend_unregister_comp_handler();
+}
+
+int virtio_rdma_qp_ops_init(void)
+{
+    rdma_backend_register_comp_handler(virtio_rdma_qp_ops_comp_handler);
+
+    return 0;
+}
+
+void virtio_rdma_handle_sq(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIORdma *dev = VIRTIO_RDMA(vdev);
+    VirtQueueElement *e;
+    struct cmd_post_send cmd;
+    struct ibv_sge *sge;
+    RdmaRmQP *qp;
+    struct virtio_rdma_kernel_mr *kmr;
+    size_t s;
+    int status = 0, i;
+    struct CompHandlerCtx *comp_ctx;
+
+    RdmaRmMR *mr;
+    uint32_t lkey;
+    uint32_t *htbl_key;
+
+    for (;;) {
+        e = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!e) {
+            break;
+        }
+
+        s = iov_to_buf(&e->out_sg[0], 1, 0, &cmd, sizeof(cmd));
+        if (s != sizeof(cmd)) {
+            rdma_error_report("bad cmd");
+            break;
+        }
+
+        qp = rdma_rm_get_qp(dev->rdma_dev_res, cmd.qpn);
+
+        sge = g_malloc0_n(cmd.num_sge, sizeof(*sge));
+        s = iov_to_buf(&e->out_sg[1], 1, 0, sge, cmd.num_sge * sizeof(*sge));
+        if (s != cmd.num_sge * sizeof(*sge)) {
+            rdma_error_report("bad sge");
+            break;
+        }
+
+        if (cmd.is_kernel) {
+            if (cmd.opcode == VIRTIO_RDMA_WR_REG_MR) {
+                mr = rdma_rm_get_mr(dev->rdma_dev_res, cmd.wr.reg.mrn);
+                lkey = mr->lkey;
+                kmr = g_hash_table_lookup(dev->lkey_mr_tbl, &lkey);
+                rdma_rm_alloc_mr(dev->rdma_dev_res, mr->pd_handle, (uint64_t)kmr->virt, kmr->length,
+                     kmr->virt, cmd.wr.reg.access, &kmr->mrn, &kmr->lkey, &kmr->rkey);
+                kmr->real_mr = rdma_rm_get_mr(dev->rdma_dev_res, kmr->mrn);
+                if (cmd.wr.reg.key != mr->lkey) {
+                    // rebuild lkey -> kmr
+                    g_hash_table_remove(dev->lkey_mr_tbl, &lkey);
+
+                    htbl_key = g_malloc0(sizeof(*htbl_key));
+                    *htbl_key = cmd.wr.reg.key;
+
+                    g_hash_table_insert(dev->lkey_mr_tbl, htbl_key, kmr);
+                }
+                goto fin;
+            }
+            /* In kernel mode, need to map guest addr to remaped addr */
+            for (i = 0; i < cmd.num_sge; i++) {
+                kmr = g_hash_table_lookup(dev->lkey_mr_tbl, &sge[i].lkey);
+                if (!kmr) {
+                    rdma_error_report("Cannot found mr with lkey %u", sge[i].lkey);
+                    // TODO: handler this error
+                }
+                sge[i].addr = (uint64_t) kmr->virt + (sge[i].addr - kmr->start);
+                sge[i].lkey = kmr->lkey;
+            }
+        }
+        // TODO: copy depend on opcode
+
+        /* Prepare CQE */
+        comp_ctx = g_malloc(sizeof(*comp_ctx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = qp->send_cq_handle;
+        comp_ctx->cqe.wr_id = cmd.wr_id;
+        comp_ctx->cqe.qp_num = cmd.qpn;
+        comp_ctx->cqe.opcode = IBV_WC_SEND;
+
+        rdma_backend_post_send(dev->backend_dev, &qp->backend_qp, qp->qp_type, sge, 1, 0, NULL, NULL, 0, 0, comp_ctx);
+
+fin:
+        s = iov_from_buf(&e->in_sg[0], 1, 0, &status, sizeof(status));
+        if (s != sizeof(status))
+            break;
+
+        virtqueue_push(vq, e, sizeof(status));
+        g_free(e);
+        g_free(sge);
+        virtio_notify(vdev, vq);
+    }
+}
+
+void virtio_rdma_handle_rq(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIORdma *dev = VIRTIO_RDMA(vdev);
+    VirtQueueElement *e;
+    struct cmd_post_recv cmd;
+    struct ibv_sge *sge;
+    RdmaRmQP *qp;
+    struct virtio_rdma_kernel_mr *kmr;
+    size_t s;
+    int i, status = 0;
+    struct CompHandlerCtx *comp_ctx;
+
+    for (;;) {
+        e = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!e)
+            break;
+
+        s = iov_to_buf(&e->out_sg[0], 1, 0, &cmd, sizeof(cmd));
+        if (s != sizeof(cmd)) {
+            fprintf(stderr, "bad cmd\n");
+            break;
+        }
+
+        qp = rdma_rm_get_qp(dev->rdma_dev_res, cmd.qpn);
+
+        if (!qp->backend_qp.ibqp) {
+            if (qp->qp_type == IBV_QPT_SMI)
+                rdma_error_report("Not support SMI");
+            if (qp->qp_type == IBV_QPT_GSI)
+                rdma_warn_report("Not support GSI now");
+            goto end;
+        }
+
+        sge = g_malloc0_n(cmd.num_sge, sizeof(*sge));
+        s = iov_to_buf(&e->out_sg[1], 1, 0, sge, cmd.num_sge * sizeof(*sge));
+        if (s != cmd.num_sge * sizeof(*sge)) {
+            rdma_error_report("bad sge");
+            break;
+        }
+
+        if (cmd.is_kernel) {
+            /* In kernel mode, need to map guest addr to remaped addr */
+            for (i = 0; i < cmd.num_sge; i++) {
+                kmr = g_hash_table_lookup(dev->lkey_mr_tbl, &sge[i].lkey);
+                if (!kmr) {
+                    rdma_error_report("Cannot found mr with lkey %u", sge[i].lkey);
+                    // TODO: handler this error
+                }
+                sge[i].addr = (uint64_t) kmr->virt + (sge[i].addr - kmr->start);
+                sge[i].lkey = kmr->lkey;
+            }
+        }
+
+        comp_ctx = g_malloc(sizeof(*comp_ctx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = qp->recv_cq_handle;
+        comp_ctx->cqe.wr_id = cmd.wr_id;
+        comp_ctx->cqe.qp_num = cmd.qpn;
+        comp_ctx->cqe.opcode = IBV_WC_RECV;
+
+        rdma_backend_post_recv(dev->backend_dev, &qp->backend_qp, qp->qp_type, sge, 1, comp_ctx);
+
+end:
+        s = iov_from_buf(&e->in_sg[0], 1, 0, &status, sizeof(status));
+        if (s != sizeof(status))
+            break;
+
+        virtqueue_push(vq, e, sizeof(status));
+        g_free(e);
+        g_free(sge);
+        virtio_notify(vdev, vq);
+    }
+}
diff --git a/hw/rdma/virtio/virtio-rdma-qp.h b/hw/rdma/virtio/virtio-rdma-qp.h
new file mode 100644
index 0000000000..f4d9c755f3
--- /dev/null
+++ b/hw/rdma/virtio/virtio-rdma-qp.h
@@ -0,0 +1,29 @@
+/*
+ * Virtio RDMA Device - QP ops
+ *
+ * Copyright (C) 2021 Bytedance Inc.
+ *
+ * Authors:
+ *  Junji Wei <weijunji@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VIRTIO_RDMA_QP_H
+#define VIRTIO_RDMA_QP_H
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "hw/virtio/virtio-rdma.h"
+
+#include "../rdma_rm.h"
+
+void virtio_rdma_qp_ops_comp_handler(void *ctx, struct ibv_wc *wc);
+void virtio_rdma_qp_ops_fini(void);
+int virtio_rdma_qp_ops_init(void);
+void virtio_rdma_handle_sq(VirtIODevice *vdev, VirtQueue *vq);
+void virtio_rdma_handle_rq(VirtIODevice *vdev, VirtQueue *vq);
+
+#endif
\ No newline at end of file
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index fbff9bc9d4..4de3d4e985 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -41,6 +41,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RDMA', if_true: files('virtio-rdma-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
diff --git a/hw/virtio/virtio-rdma-pci.c b/hw/virtio/virtio-rdma-pci.c
new file mode 100644
index 0000000000..c4de92c88a
--- /dev/null
+++ b/hw/virtio/virtio-rdma-pci.c
@@ -0,0 +1,110 @@
+/*
+ * Virtio rdma PCI Bindings
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-net-pci.h"
+#include "hw/virtio/virtio-rdma.h"
+#include "virtio-pci.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+
+typedef struct VirtIORdmaPCI VirtIORdmaPCI;
+
+/*
+ * virtio-rdma-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_RDMA_PCI "virtio-rdma-pci-base"
+#define VIRTIO_RDMA_PCI(obj) \
+        OBJECT_CHECK(VirtIORdmaPCI, (obj), TYPE_VIRTIO_RDMA_PCI)
+
+struct VirtIORdmaPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIORdma vdev;
+};
+
+static Property virtio_rdma_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_rdma_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORdmaPCI *dev = VIRTIO_RDMA_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIONetPCI *vnet_pci;
+    PCIDevice *func0;
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
+    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
+
+    func0 = pci_get_function_0(&vpci_dev->pci_dev);
+    /* Break if not virtio device in slot 0 */
+    if (strcmp(object_get_typename(OBJECT(func0)),
+               TYPE_VIRTIO_NET_PCI_GENERIC)) {
+        fprintf(stderr, "Device on %x.0 is type %s but must be %s",
+                   PCI_SLOT(vpci_dev->pci_dev.devfn),
+                   object_get_typename(OBJECT(func0)),
+                   TYPE_VIRTIO_NET_PCI_GENERIC);
+        return;
+    }
+    vnet_pci = VIRTIO_NET_PCI(func0);
+    dev->vdev.netdev = &vnet_pci->vdev;
+}
+
+static void virtio_rdma_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id = PCI_DEVICE_ID_VIRTIO_RDMA;
+    k->revision = VIRTIO_PCI_ABI_VERSION;
+    k->class_id = PCI_CLASS_NETWORK_OTHER;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    // dc->props_ = virtio_rdma_properties;
+    device_class_set_props(dc, virtio_rdma_properties);
+    vpciklass->realize = virtio_rdma_pci_realize;
+}
+
+static void virtio_rdma_pci_instance_init(Object *obj)
+{
+    VirtIORdmaPCI *dev = VIRTIO_RDMA_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_RDMA);
+    /*
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+    */
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_rdma_pci_info = {
+    .base_name             = TYPE_VIRTIO_RDMA_PCI,
+    .generic_name          = "virtio-rdma-pci",
+    .transitional_name     = "virtio-rdma-pci-transitional",
+    .non_transitional_name = "virtio-rdma-pci-non-transitional",
+    .instance_size = sizeof(VirtIORdmaPCI),
+    .instance_init = virtio_rdma_pci_instance_init,
+    .class_init    = virtio_rdma_pci_class_init,
+};
+
+static void virtio_rdma_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_rdma_pci_info);
+}
+
+type_init(virtio_rdma_pci_register)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 72ce649eee..f976ea9db7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -89,6 +89,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
 #define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
 #define PCI_DEVICE_ID_VIRTIO_MEM         0x1015
+#define PCI_DEVICE_ID_VIRTIO_RDMA        0x1016
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/include/hw/virtio/virtio-rdma.h b/include/hw/virtio/virtio-rdma.h
new file mode 100644
index 0000000000..1ae10deb6a
--- /dev/null
+++ b/include/hw/virtio/virtio-rdma.h
@@ -0,0 +1,58 @@
+/*
+ * Virtio RDMA Device
+ *
+ * Copyright (C) 2019 Oracle
+ *
+ * Authors:
+ *  Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_VIRTIO_RDMA_H
+#define QEMU_VIRTIO_RDMA_H
+
+#include <glib.h>
+#include <infiniband/verbs.h>
+
+#include "chardev/char-fe.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-net.h"
+
+#define TYPE_VIRTIO_RDMA "virtio-rdma-device"
+#define VIRTIO_RDMA(obj) \
+        OBJECT_CHECK(VirtIORdma, (obj), TYPE_VIRTIO_RDMA)
+
+typedef struct RdmaBackendDev RdmaBackendDev;
+typedef struct RdmaDeviceResources RdmaDeviceResources;
+struct ibv_device_attr;
+
+typedef struct VirtIORdma {
+    VirtIODevice parent_obj;
+    VirtQueue *ctrl_vq;
+    VirtIONet *netdev;
+    RdmaBackendDev *backend_dev;
+    RdmaDeviceResources *rdma_dev_res;
+    CharBackend mad_chr;
+    char *backend_eth_device_name;
+    char *backend_device_name;
+    uint8_t backend_port_num;
+    struct ibv_device_attr dev_attr;
+
+    VirtQueue **cq_vqs;
+    VirtQueue **qp_vqs;
+
+    GHashTable *lkey_mr_tbl;
+
+    /* active objects statistics to enforce limits, should write with qatomic */
+	int num_qp;
+	int num_cq;
+	int num_pd;
+	int num_mr;
+	int num_srq;
+	int num_ctx;
+} VirtIORdma;
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index b052355ac7..4c2151bffb 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -48,5 +48,6 @@
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_RDMA         30 /* virtio rdma */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.11.0

