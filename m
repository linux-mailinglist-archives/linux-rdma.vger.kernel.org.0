Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9A135AF5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgAIOF2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:28 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33790 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730033AbgAIOF2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:28 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5FCP016606;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5FcV001329;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5Fso001328;
        Thu, 9 Jan 2020 16:05:15 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-core 2/7] verbs: Move free_context from verbs_device_ops to verbs_context_ops
Date:   Thu,  9 Jan 2020 16:04:31 +0200
Message-Id: <1578578676-752-3-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

As free_context is always called after alloc_context has been called, we
can have the operation in the verbs_context_ops struct.

This is needed for downstream patch from this series where the
alloc_context is moved to use the ioctl interface.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/device.c                | 5 ++---
 libibverbs/driver.h                | 2 +-
 libibverbs/dummy_ops.c             | 7 +++++++
 providers/bnxt_re/main.c           | 6 ++++--
 providers/cxgb4/dev.c              | 4 +++-
 providers/efa/efa.c                | 4 +++-
 providers/hfi1verbs/hfiverbs.c     | 4 +++-
 providers/hns/hns_roce_u.c         | 4 +++-
 providers/i40iw/i40iw_umain.c      | 6 ++++--
 providers/ipathverbs/ipathverbs.c  | 4 +++-
 providers/mlx4/mlx4.c              | 4 +++-
 providers/mlx5/mlx5.c              | 4 +++-
 providers/mthca/mthca.c            | 6 ++++--
 providers/ocrdma/ocrdma_main.c     | 6 ++++--
 providers/qedr/qelr_main.c         | 4 +++-
 providers/rxe/rxe.c                | 6 ++++--
 providers/siw/siw.c                | 3 ++-
 providers/vmw_pvrdma/pvrdma_main.c | 4 +++-
 18 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/libibverbs/device.c b/libibverbs/device.c
index edd8f33..bc7df1b 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -379,10 +379,9 @@ LATEST_SYMVER_FUNC(ibv_close_device, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_context *context)
 {
-	struct verbs_device *verbs_device = verbs_get_device(context->device);
-
-	verbs_device->ops->free_context(context);
+	const struct verbs_context_ops *ops = get_ops(context);
 
+	ops->free_context(context);
 	return 0;
 }
 
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 88ed2b5..88603ce 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -218,7 +218,6 @@ struct verbs_device_ops {
 	struct verbs_context *(*alloc_context)(struct ibv_device *device,
 					       int cmd_fd,
 					       void *private_data);
-	void (*free_context)(struct ibv_context *context);
 
 	struct verbs_device *(*alloc_device)(struct verbs_sysfs_dev *sysfs_dev);
 	void (*uninit_device)(struct verbs_device *device);
@@ -315,6 +314,7 @@ struct verbs_context_ops {
 	int (*destroy_wq)(struct ibv_wq *wq);
 	int (*detach_mcast)(struct ibv_qp *qp, const union ibv_gid *gid,
 			    uint16_t lid);
+	void (*free_context)(struct ibv_context *context);
 	int (*free_dm)(struct ibv_dm *dm);
 	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
 	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 6560371..d949275 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -272,6 +272,11 @@ static int detach_mcast(struct ibv_qp *qp, const union ibv_gid *gid,
 	return ENOSYS;
 }
 
+static void free_context(struct ibv_context *ctx)
+{
+	return;
+}
+
 static int free_dm(struct ibv_dm *dm)
 {
 	return ENOSYS;
@@ -485,6 +490,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	destroy_srq,
 	destroy_wq,
 	detach_mcast,
+	free_context,
 	free_dm,
 	get_srq_num,
 	modify_cq,
@@ -600,6 +606,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP(ctx, destroy_srq);
 	SET_OP(vctx, destroy_wq);
 	SET_PRIV_OP(ctx, detach_mcast);
+	SET_PRIV_OP_IC(ctx, free_context);
 	SET_OP(vctx, free_dm);
 	SET_OP(vctx, get_srq_num);
 	SET_OP(vctx, modify_cq);
diff --git a/providers/bnxt_re/main.c b/providers/bnxt_re/main.c
index 803eff7..8893673 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -50,6 +50,8 @@
 #include "main.h"
 #include "verbs.h"
 
+static void bnxt_re_free_context(struct ibv_context *ibvctx);
+
 #define PCI_VENDOR_ID_BROADCOM		0x14E4
 
 #define CNA(v, d) VERBS_PCI_MATCH(PCI_VENDOR_ID_##v, d, NULL)
@@ -113,7 +115,8 @@ static const struct verbs_context_ops bnxt_re_cntx_ops = {
 	.post_send     = bnxt_re_post_send,
 	.post_recv     = bnxt_re_post_recv,
 	.create_ah     = bnxt_re_create_ah,
-	.destroy_ah    = bnxt_re_destroy_ah
+	.destroy_ah    = bnxt_re_destroy_ah,
+	.free_context  = bnxt_re_free_context,
 };
 
 bool bnxt_re_is_chip_gen_p5(struct bnxt_re_chip_ctx *cctx)
@@ -218,6 +221,5 @@ static const struct verbs_device_ops bnxt_re_dev_ops = {
 	.match_table = cna_table,
 	.alloc_device = bnxt_re_device_alloc,
 	.alloc_context = bnxt_re_alloc_context,
-	.free_context = bnxt_re_free_context,
 };
 PROVIDER_DRIVER(bnxt_re, bnxt_re_dev_ops);
diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
index ecd87e6..1e99ee3 100644
--- a/providers/cxgb4/dev.c
+++ b/providers/cxgb4/dev.c
@@ -43,6 +43,8 @@
 #include "libcxgb4.h"
 #include "cxgb4-abi.h"
 
+static void c4iw_free_context(struct ibv_context *ibctx);
+
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
 /*
@@ -96,6 +98,7 @@ static const struct verbs_context_ops  c4iw_ctx_common_ops = {
 	.detach_mcast = c4iw_detach_mcast,
 	.post_srq_recv = c4iw_post_srq_recv,
 	.req_notify_cq = c4iw_arm_cq,
+	.free_context = c4iw_free_context,
 };
 
 static const struct verbs_context_ops c4iw_ctx_t4_ops = {
@@ -456,7 +459,6 @@ static const struct verbs_device_ops c4iw_dev_ops = {
 	.alloc_device = c4iw_device_alloc,
 	.uninit_device = c4iw_uninit_device,
 	.alloc_context = c4iw_alloc_context,
-	.free_context = c4iw_free_context,
 };
 PROVIDER_DRIVER(cxgb4, c4iw_dev_ops);
 
diff --git a/providers/efa/efa.c b/providers/efa/efa.c
index 645a29b..a8ba14e 100644
--- a/providers/efa/efa.c
+++ b/providers/efa/efa.c
@@ -12,6 +12,8 @@
 #include "efa.h"
 #include "verbs.h"
 
+static void efa_free_context(struct ibv_context *ibvctx);
+
 #define PCI_VENDOR_ID_AMAZON 0x1d0f
 
 static const struct verbs_match_ent efa_table[] = {
@@ -40,6 +42,7 @@ static const struct verbs_context_ops efa_ctx_ops = {
 	.query_port = efa_query_port,
 	.query_qp = efa_query_qp,
 	.reg_mr = efa_reg_mr,
+	.free_context = efa_free_context,
 };
 
 static struct verbs_context *efa_alloc_context(struct ibv_device *vdev,
@@ -127,7 +130,6 @@ static const struct verbs_device_ops efa_dev_ops = {
 	.alloc_device = efa_device_alloc,
 	.uninit_device = efa_uninit_device,
 	.alloc_context = efa_alloc_context,
-	.free_context = efa_free_context,
 };
 
 bool is_efa_dev(struct ibv_device *device)
diff --git a/providers/hfi1verbs/hfiverbs.c b/providers/hfi1verbs/hfiverbs.c
index 02e15d7..9bfb967 100644
--- a/providers/hfi1verbs/hfiverbs.c
+++ b/providers/hfi1verbs/hfiverbs.c
@@ -65,6 +65,8 @@
 #include "hfiverbs.h"
 #include "hfi-abi.h"
 
+static void hfi1_free_context(struct ibv_context *ibctx);
+
 #ifndef PCI_VENDOR_ID_INTEL
 #define PCI_VENDOR_ID_INTEL			0x8086
 #endif
@@ -87,6 +89,7 @@ static const struct verbs_match_ent hca_table[] = {
 };
 
 static const struct verbs_context_ops hfi1_ctx_common_ops = {
+	.free_context	= hfi1_free_context,
 	.query_device	= hfi1_query_device,
 	.query_port	= hfi1_query_port,
 
@@ -205,6 +208,5 @@ static const struct verbs_device_ops hfi1_dev_ops = {
 	.alloc_device = hfi1_device_alloc,
 	.uninit_device  = hf11_uninit_device,
 	.alloc_context = hfi1_alloc_context,
-	.free_context = hfi1_free_context,
 };
 PROVIDER_DRIVER(hfi1verbs, hfi1_dev_ops);
diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 5872599..fffc9ff 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -40,6 +40,8 @@
 #include "hns_roce_u.h"
 #include "hns_roce_u_abi.h"
 
+static void hns_roce_free_context(struct ibv_context *ibctx);
+
 #define HID_LEN			15
 #define DEV_MATCH_LEN		128
 
@@ -81,6 +83,7 @@ static const struct verbs_context_ops hns_common_ops = {
 	.modify_srq = hns_roce_u_modify_srq,
 	.query_srq = hns_roce_u_query_srq,
 	.destroy_srq = hns_roce_u_destroy_srq,
+	.free_context = hns_roce_free_context,
 };
 
 static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
@@ -206,6 +209,5 @@ static const struct verbs_device_ops hns_roce_dev_ops = {
 	.alloc_device = hns_device_alloc,
 	.uninit_device = hns_uninit_device,
 	.alloc_context = hns_roce_alloc_context,
-	.free_context = hns_roce_free_context,
 };
 PROVIDER_DRIVER(hns, hns_roce_dev_ops);
diff --git a/providers/i40iw/i40iw_umain.c b/providers/i40iw/i40iw_umain.c
index 33f3c57..b418d11 100644
--- a/providers/i40iw/i40iw_umain.c
+++ b/providers/i40iw/i40iw_umain.c
@@ -50,6 +50,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+static void i40iw_ufree_context(struct ibv_context *ibctx);
+
 #define INTEL_HCA(v, d) VERBS_PCI_MATCH(v, d, NULL)
 static const struct verbs_match_ent hca_table[] = {
 	VERBS_DRIVER_ID(RDMA_DRIVER_I40IW),
@@ -115,7 +117,8 @@ static const struct verbs_context_ops i40iw_uctx_ops = {
 	.destroy_ah	= i40iw_udestroy_ah,
 	.attach_mcast	= i40iw_uattach_mcast,
 	.detach_mcast	= i40iw_udetach_mcast,
-	.async_event	= i40iw_async_event
+	.async_event	= i40iw_async_event,
+	.free_context	= i40iw_ufree_context,
 };
 
 /**
@@ -224,6 +227,5 @@ static const struct verbs_device_ops i40iw_udev_ops = {
 	.alloc_device = i40iw_device_alloc,
 	.uninit_device  = i40iw_uninit_device,
 	.alloc_context = i40iw_ualloc_context,
-	.free_context = i40iw_ufree_context,
 };
 PROVIDER_DRIVER(i40iw, i40iw_udev_ops);
diff --git a/providers/ipathverbs/ipathverbs.c b/providers/ipathverbs/ipathverbs.c
index c22571a..0e1a584 100644
--- a/providers/ipathverbs/ipathverbs.c
+++ b/providers/ipathverbs/ipathverbs.c
@@ -45,6 +45,8 @@
 #include "ipathverbs.h"
 #include "ipath-abi.h"
 
+static void ipath_free_context(struct ibv_context *ibctx);
+
 #ifndef PCI_VENDOR_ID_PATHSCALE
 #define PCI_VENDOR_ID_PATHSCALE			0x1fc1
 #endif
@@ -86,6 +88,7 @@ static const struct verbs_match_ent hca_table[] = {
 };
 
 static const struct verbs_context_ops ipath_ctx_common_ops = {
+	.free_context	= ipath_free_context,
 	.query_device	= ipath_query_device,
 	.query_port	= ipath_query_port,
 
@@ -203,6 +206,5 @@ static const struct verbs_device_ops ipath_dev_ops = {
 	.alloc_device = ipath_device_alloc,
 	.uninit_device  = ipath_uninit_device,
 	.alloc_context = ipath_alloc_context,
-	.free_context = ipath_free_context,
 };
 PROVIDER_DRIVER(ipathverbs, ipath_dev_ops);
diff --git a/providers/mlx4/mlx4.c b/providers/mlx4/mlx4.c
index 0afe59c..0842ff0 100644
--- a/providers/mlx4/mlx4.c
+++ b/providers/mlx4/mlx4.c
@@ -43,6 +43,8 @@
 #include "mlx4.h"
 #include "mlx4-abi.h"
 
+static void mlx4_free_context(struct ibv_context *ibv_ctx);
+
 #ifndef PCI_VENDOR_ID_MELLANOX
 #define PCI_VENDOR_ID_MELLANOX			0x15b3
 #endif
@@ -131,6 +133,7 @@ static const struct verbs_context_ops mlx4_ctx_ops = {
 	.open_xrcd = mlx4_open_xrcd,
 	.query_device_ex = mlx4_query_device_ex,
 	.query_rt_values = mlx4_query_rt_values,
+	.free_context = mlx4_free_context,
 };
 
 static int mlx4_map_internal_clock(struct mlx4_device *mdev,
@@ -302,7 +305,6 @@ static const struct verbs_device_ops mlx4_dev_ops = {
 	.alloc_device = mlx4_device_alloc,
 	.uninit_device = mlx4_uninit_device,
 	.alloc_context = mlx4_alloc_context,
-	.free_context = mlx4_free_context,
 };
 PROVIDER_DRIVER(mlx4, mlx4_dev_ops);
 
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 7ea725d..1a54e0e 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -49,6 +49,8 @@
 #include "wqe.h"
 #include "mlx5_ifc.h"
 
+static void mlx5_free_context(struct ibv_context *ibctx);
+
 #ifndef PCI_VENDOR_ID_MELLANOX
 #define PCI_VENDOR_ID_MELLANOX			0x15b3
 #endif
@@ -156,6 +158,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.read_counters = mlx5_read_counters,
 	.reg_dm_mr = mlx5_reg_dm_mr,
 	.alloc_null_mr = mlx5_alloc_null_mr,
+	.free_context = mlx5_free_context,
 };
 
 static const struct verbs_context_ops mlx5_ctx_cqev1_ops = {
@@ -1451,7 +1454,6 @@ static const struct verbs_device_ops mlx5_dev_ops = {
 	.alloc_device = mlx5_device_alloc,
 	.uninit_device = mlx5_uninit_device,
 	.alloc_context = mlx5_alloc_context,
-	.free_context = mlx5_free_context,
 };
 
 bool is_mlx5_dev(struct ibv_device *device)
diff --git a/providers/mthca/mthca.c b/providers/mthca/mthca.c
index c3293d8..abce486 100644
--- a/providers/mthca/mthca.c
+++ b/providers/mthca/mthca.c
@@ -44,6 +44,8 @@
 #include "mthca.h"
 #include "mthca-abi.h"
 
+static void mthca_free_context(struct ibv_context *ibctx);
+
 #ifndef PCI_VENDOR_ID_MELLANOX
 #define PCI_VENDOR_ID_MELLANOX			0x15b3
 #endif
@@ -111,7 +113,8 @@ static const struct verbs_context_ops mthca_ctx_common_ops = {
 	.create_ah     = mthca_create_ah,
 	.destroy_ah    = mthca_destroy_ah,
 	.attach_mcast  = ibv_cmd_attach_mcast,
-	.detach_mcast  = ibv_cmd_detach_mcast
+	.detach_mcast  = ibv_cmd_detach_mcast,
+	.free_context = mthca_free_context,
 };
 
 static const struct verbs_context_ops mthca_ctx_arbel_ops = {
@@ -237,6 +240,5 @@ static const struct verbs_device_ops mthca_dev_ops = {
 	.alloc_device = mthca_device_alloc,
 	.uninit_device = mthca_uninit_device,
 	.alloc_context = mthca_alloc_context,
-	.free_context = mthca_free_context,
 };
 PROVIDER_DRIVER(mthca, mthca_dev_ops);
diff --git a/providers/ocrdma/ocrdma_main.c b/providers/ocrdma/ocrdma_main.c
index 31fefe9..f7ed629 100644
--- a/providers/ocrdma/ocrdma_main.c
+++ b/providers/ocrdma/ocrdma_main.c
@@ -50,6 +50,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+static void ocrdma_free_context(struct ibv_context *ibctx);
+
 #define PCI_VENDOR_ID_EMULEX		0x10DF
 #define PCI_DEVICE_ID_EMULEX_GEN1	0xe220
 #define PCI_DEVICE_ID_EMULEX_GEN2        0x720
@@ -93,7 +95,8 @@ static const struct verbs_context_ops ocrdma_ctx_ops = {
 	.destroy_srq = ocrdma_destroy_srq,
 	.post_srq_recv = ocrdma_post_srq_recv,
 	.attach_mcast = ocrdma_attach_mcast,
-	.detach_mcast = ocrdma_detach_mcast
+	.detach_mcast = ocrdma_detach_mcast,
+	.free_context = ocrdma_free_context,
 };
 
 static void ocrdma_uninit_device(struct verbs_device *verbs_device)
@@ -194,6 +197,5 @@ static const struct verbs_device_ops ocrdma_dev_ops = {
 	.alloc_device = ocrdma_device_alloc,
 	.uninit_device = ocrdma_uninit_device,
 	.alloc_context = ocrdma_alloc_context,
-	.free_context = ocrdma_free_context,
 };
 PROVIDER_DRIVER(ocrdma, ocrdma_dev_ops);
diff --git a/providers/qedr/qelr_main.c b/providers/qedr/qelr_main.c
index bbe9b02..da31456 100644
--- a/providers/qedr/qelr_main.c
+++ b/providers/qedr/qelr_main.c
@@ -48,6 +48,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+static void qelr_free_context(struct ibv_context *ibctx);
+
 #define PCI_VENDOR_ID_QLOGIC           (0x1077)
 #define PCI_DEVICE_ID_QLOGIC_57980S    (0x1629)
 #define PCI_DEVICE_ID_QLOGIC_57980S_40 (0x1634)
@@ -104,6 +106,7 @@ static const struct verbs_context_ops qelr_ctx_ops = {
 	.post_send = qelr_post_send,
 	.post_recv = qelr_post_recv,
 	.async_event = qelr_async_event,
+	.free_context = qelr_free_context,
 };
 
 static void qelr_uninit_device(struct verbs_device *verbs_device)
@@ -249,6 +252,5 @@ static const struct verbs_device_ops qelr_dev_ops = {
 	.alloc_device = qelr_device_alloc,
 	.uninit_device = qelr_uninit_device,
 	.alloc_context = qelr_alloc_context,
-	.free_context = qelr_free_context,
 };
 PROVIDER_DRIVER(qedr, qelr_dev_ops);
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 4e05d5b..3af58bf 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -56,6 +56,8 @@
 #include "rxe-abi.h"
 #include "rxe.h"
 
+static void rxe_free_context(struct ibv_context *ibctx);
+
 static const struct verbs_match_ent hca_table[] = {
 	VERBS_DRIVER_ID(RDMA_DRIVER_RXE),
 	VERBS_NAME_MATCH("rxe", NULL),
@@ -856,7 +858,8 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.create_ah = rxe_create_ah,
 	.destroy_ah = rxe_destroy_ah,
 	.attach_mcast = ibv_cmd_attach_mcast,
-	.detach_mcast = ibv_cmd_detach_mcast
+	.detach_mcast = ibv_cmd_detach_mcast,
+	.free_context = rxe_free_context,
 };
 
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
@@ -926,6 +929,5 @@ static const struct verbs_device_ops rxe_dev_ops = {
 	.alloc_device = rxe_device_alloc,
 	.uninit_device = rxe_uninit_device,
 	.alloc_context = rxe_alloc_context,
-	.free_context = rxe_free_context,
 };
 PROVIDER_DRIVER(rxe, rxe_dev_ops);
diff --git a/providers/siw/siw.c b/providers/siw/siw.c
index df00fc5..9530833 100644
--- a/providers/siw/siw.c
+++ b/providers/siw/siw.c
@@ -18,6 +18,7 @@
 #include "siw.h"
 
 static const int siw_debug;
+static void siw_free_context(struct ibv_context *ibv_ctx);
 
 static int siw_query_device(struct ibv_context *ctx,
 			    struct ibv_device_attr *attr)
@@ -841,6 +842,7 @@ static const struct verbs_context_ops siw_context_ops = {
 	.destroy_cq = siw_destroy_cq,
 	.destroy_qp = siw_destroy_qp,
 	.destroy_srq = siw_destroy_srq,
+	.free_context = siw_free_context,
 	.modify_qp = siw_modify_qp,
 	.modify_srq = siw_modify_srq,
 	.poll_cq = siw_poll_cq,
@@ -919,7 +921,6 @@ static const struct verbs_device_ops siw_dev_ops = {
 	.alloc_device = siw_device_alloc,
 	.uninit_device = siw_device_free,
 	.alloc_context = siw_alloc_context,
-	.free_context = siw_free_context
 };
 
 PROVIDER_DRIVER(siw, siw_dev_ops);
diff --git a/providers/vmw_pvrdma/pvrdma_main.c b/providers/vmw_pvrdma/pvrdma_main.c
index 4d64d96..14a67c1 100644
--- a/providers/vmw_pvrdma/pvrdma_main.c
+++ b/providers/vmw_pvrdma/pvrdma_main.c
@@ -45,6 +45,8 @@
 
 #include "pvrdma.h"
 
+static void pvrdma_free_context(struct ibv_context *ibctx);
+
 /*
  * VMware PVRDMA vendor id and PCI device id.
  */
@@ -52,6 +54,7 @@
 #define PCI_DEVICE_ID_VMWARE_PVRDMA	0x0820
 
 static const struct verbs_context_ops pvrdma_ctx_ops = {
+	.free_context = pvrdma_free_context,
 	.query_device = pvrdma_query_device,
 	.query_port = pvrdma_query_port,
 	.alloc_pd = pvrdma_alloc_pd,
@@ -208,6 +211,5 @@ static const struct verbs_device_ops pvrdma_dev_ops = {
 	.alloc_device = pvrdma_device_alloc,
 	.uninit_device = pvrdma_uninit_device,
 	.alloc_context = pvrdma_alloc_context,
-	.free_context  = pvrdma_free_context,
 };
 PROVIDER_DRIVER(vmw_pvrdma, pvrdma_dev_ops);
-- 
1.8.3.1

