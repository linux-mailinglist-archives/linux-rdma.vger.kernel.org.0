Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8F341D7F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCSM4o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 08:56:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:4853 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhCSM4n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 08:56:43 -0400
IronPort-SDR: Xmbnit1YHX6KH26z53MpWsT+YI9vuDo4b/7zm+OUrRgNyob/HdVW8zGpsBcSJ3E5It3xKPoAU4
 xyavvT9sCN5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209910284"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="209910284"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 05:56:42 -0700
IronPort-SDR: 9yWbDQpRpw56ljwPgwZKGYRICzJH1quRVDtWH7qsrZwZFNcx7FUzYZV9YFQknLrBldz1htnI1t
 9itF8YsSzPQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="450851734"
Received: from phwfstl014.hd.intel.com ([10.127.241.142])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 05:56:41 -0700
From:   kaike.wan@intel.com
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, todd.rimmer@intel.com,
        Kaike Wan <kaike.wan@intel.com>
Subject: [PATCH RFC 5/9] RDMA/rv: Add function to register/deregister memory region
Date:   Fri, 19 Mar 2021 08:56:31 -0400
Message-Id: <20210319125635.34492-6-kaike.wan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210319125635.34492-1-kaike.wan@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

This patch adds functions for user application to register/deregister
memory region (mr) for user buffers. Two types of mrs are supported:
user mrs and kernel mrs.

User mrs are used soley by the user application. The reason that
the user mrs are cached in the rv module instead of in the user
application is that a middleware application may not known when a user
buffer (allocated by a upper lay application) is freed in order to free
any stale nodes. On the other hand, the rv module can register an MMU
notifier callback so that it can promptly remove any stale cache nodes.

Kernel mrs are used by the rv module for any RDMA transactions between
nodes.

A user mr is registered in a way similar to that in the verbs
interface. A kernel mr is registered similar to that in
ib_reg_user_mr() for on-demand paging. An RDMA hardware may have to
be qualified for this mechanism.

Signed-off-by: Todd Rimmer <todd.rimmer@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
---
 drivers/infiniband/core/core_priv.h     |   4 +
 drivers/infiniband/core/rdma_core.c     | 237 ++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c    |  54 +---
 drivers/infiniband/ulp/rv/Makefile      |   2 +-
 drivers/infiniband/ulp/rv/rv_file.c     |  31 ++
 drivers/infiniband/ulp/rv/rv_mr.c       | 393 ++++++++++++++++++++++++
 drivers/infiniband/ulp/rv/rv_mr_cache.c |   2 +-
 drivers/infiniband/ulp/rv/trace.h       |   2 +
 drivers/infiniband/ulp/rv/trace_mr.h    | 109 +++++++
 drivers/infiniband/ulp/rv/trace_user.h  |  66 ++++
 include/rdma/uverbs_types.h             |  10 +
 11 files changed, 860 insertions(+), 50 deletions(-)
 create mode 100644 drivers/infiniband/ulp/rv/rv_file.c
 create mode 100644 drivers/infiniband/ulp/rv/rv_mr.c
 create mode 100644 drivers/infiniband/ulp/rv/trace_mr.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_user.h

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 315f7a297eee..678fb9a3d77b 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -404,4 +404,8 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 
 void ib_cq_pool_cleanup(struct ib_device *dev);
 
+struct ib_mr *uverbs_reg_mr(struct uverbs_attr_bundle *attrs, u32 pd_handle,
+			    u64 start, u64 length, u64 hca_va,
+			    u32 access_flags, struct ib_udata *driver_udata);
+
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 75eafd9208aa..22120adf0ef2 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -1013,3 +1013,240 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 		WARN_ON(true);
 	}
 }
+
+static struct ib_uverbs_file *get_ufile_from_fd(struct fd *fd)
+{
+	return fd->file ? (struct ib_uverbs_file *)fd->file->private_data :
+			  NULL;
+}
+
+static struct ib_uverbs_file *get_ufile(u32 cmd_fd, struct fd *fd)
+{
+	struct fd f;
+	struct ib_uverbs_file *file;
+
+	/* fd to "struct fd" */
+	f = fdget(cmd_fd);
+
+	file = get_ufile_from_fd(&f);
+	if (!file)
+		goto bail;
+
+	memcpy(fd, &f, sizeof(f));
+	return file;
+bail:
+	fdput(f);
+	return NULL;
+}
+
+struct ib_mr *uverbs_reg_mr(struct uverbs_attr_bundle *attrs, u32 pd_handle,
+			    u64 start, u64 length, u64 hca_va,
+			    u32 access_flags, struct ib_udata *driver_udata)
+{
+	struct ib_uobject           *uobj;
+	struct ib_pd                *pd;
+	struct ib_mr                *mr;
+	int                          ret;
+	struct ib_device            *ib_dev;
+
+	uobj = uobj_alloc(UVERBS_OBJECT_MR, attrs, &ib_dev);
+	if (IS_ERR(uobj))
+		return (struct ib_mr *)uobj;
+
+	ret = ib_check_mr_access(ib_dev, access_flags);
+	if (ret)
+		goto err_free;
+
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, pd_handle, attrs);
+	if (!pd) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	mr = pd->device->ops.reg_user_mr(pd, start, length, hca_va,
+					 access_flags, driver_udata);
+	if (IS_ERR(mr)) {
+		ret = PTR_ERR(mr);
+		goto err_put;
+	}
+
+	mr->device  = pd->device;
+	mr->pd      = pd;
+	mr->type    = IB_MR_TYPE_USER;
+	mr->dm      = NULL;
+	mr->sig_attrs = NULL;
+	mr->uobject = uobj;
+	atomic_inc(&pd->usecnt);
+	mr->iova = hca_va;
+
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_set_name(&mr->res, NULL);
+	rdma_restrack_add(&mr->res);
+
+	uobj->object = mr;
+	uobj_put_obj_read(pd);
+	uobj_finalize_uobj_create(uobj, attrs);
+
+	return mr;
+
+err_put:
+	uobj_put_obj_read(pd);
+err_free:
+	uobj_alloc_abort(uobj, attrs);
+	return ERR_PTR(ret);
+}
+
+struct ib_mr *rdma_reg_user_mr(struct ib_device *ib_dev, u32 cmd_fd,
+			       u32 pd_handle, u64 start, u64 length,
+			       u32 access_flags, size_t ulen, void *udata,
+			       struct fd *fd)
+{
+	struct ib_mr *mr;
+	struct ib_uverbs_file *ufile;
+	struct uverbs_attr_bundle attrs;
+	int srcu_key;
+	struct ib_device *device;
+
+	if (!fd) {
+		mr = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	memset(&attrs, 0, sizeof(attrs));
+	ufile = get_ufile(cmd_fd, fd);
+	if (!ufile) {
+		mr = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	srcu_key = srcu_read_lock(&ufile->device->disassociate_srcu);
+	/* Validate the target ib_device */
+	device = srcu_dereference(ufile->device->ib_dev,
+				  &ufile->device->disassociate_srcu);
+	if (device != ib_dev) {
+		mr = ERR_PTR(-EINVAL);
+		goto out_fd;
+	}
+	attrs.ufile = ufile;
+	attrs.driver_udata.inlen = ulen;
+	if (ulen)
+		attrs.driver_udata.inbuf = udata;
+
+	mr = uverbs_reg_mr(&attrs, pd_handle, start, length, start,
+			   access_flags, &attrs.driver_udata);
+	if (IS_ERR(mr))
+		goto out_fd;
+	else
+		uverbs_finalize_object(attrs.uobject, UVERBS_ACCESS_NEW, true,
+				       true, &attrs);
+
+	goto out_unlock;
+
+out_fd:
+	fdput(*fd);
+out_unlock:
+	srcu_read_unlock(&ufile->device->disassociate_srcu, srcu_key);
+out:
+	return mr;
+}
+EXPORT_SYMBOL(rdma_reg_user_mr);
+
+int rdma_dereg_user_mr(struct ib_mr *mr, struct fd *fd)
+{
+	struct ib_uverbs_file *ufile;
+	struct uverbs_attr_bundle attrs;
+	int srcu_key;
+	int ret;
+
+	if (!fd || !mr || !mr->uobject)
+		return -EINVAL;
+
+	memset(&attrs, 0, sizeof(attrs));
+	ufile = get_ufile_from_fd(fd);
+	if (!ufile || !ufile->device)
+		return -EINVAL;
+
+	srcu_key = srcu_read_lock(&ufile->device->disassociate_srcu);
+	attrs.ufile = ufile;
+
+	ret = uobj_perform_destroy(UVERBS_OBJECT_MR, (u32)mr->uobject->id,
+				   &attrs);
+	fdput(*fd);
+
+	srcu_read_unlock(&ufile->device->disassociate_srcu, srcu_key);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_dereg_user_mr);
+
+struct ib_mr *rdma_reg_kernel_mr(u32 cmd_fd, struct ib_pd *kern_pd, u64 start,
+				 u64 length, u32 access_flags, size_t ulen,
+				 void *udata, struct fd *fd)
+{
+	struct ib_mr *mr;
+	struct ib_uverbs_file *ufile;
+	struct uverbs_attr_bundle attrs;
+	int srcu_key;
+
+	if (!fd) {
+		mr = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	memset(&attrs, 0, sizeof(attrs));
+	ufile = get_ufile(cmd_fd, fd);
+	if (!ufile) {
+		mr = ERR_PTR(-EINVAL);
+		goto out;
+	}
+	srcu_key = srcu_read_lock(&ufile->device->disassociate_srcu);
+	attrs.ufile = ufile;
+	attrs.driver_udata.inlen = ulen;
+	if (ulen)
+		attrs.driver_udata.inbuf = udata;
+
+	mr = kern_pd->device->ops.reg_user_mr(kern_pd, start, length, start,
+					      access_flags,
+					      &attrs.driver_udata);
+	if (IS_ERR(mr)) {
+		fdput(*fd);
+		goto out_unlock;
+	}
+
+	mr->device  = kern_pd->device;
+	mr->pd      = kern_pd;
+	mr->dm      = NULL;
+	atomic_inc(&kern_pd->usecnt);
+
+out_unlock:
+	srcu_read_unlock(&ufile->device->disassociate_srcu, srcu_key);
+out:
+	return mr;
+}
+EXPORT_SYMBOL(rdma_reg_kernel_mr);
+
+int rdma_dereg_kernel_mr(struct ib_mr *mr, struct fd *fd)
+{
+	struct ib_pd *pd;
+	struct ib_uverbs_file *ufile;
+	int srcu_key;
+	int ret = 0;
+	struct ib_udata udata;
+
+	if (!fd || !mr)
+		return -EINVAL;
+
+	ufile = get_ufile_from_fd(fd);
+	if (!ufile)
+		return -EINVAL;
+
+	srcu_key = srcu_read_lock(&ufile->device->disassociate_srcu);
+	memset(&udata, 0, sizeof(udata));
+	pd = mr->pd;
+	ret = pd->device->ops.dereg_mr(mr, &udata);
+	atomic_dec(&pd->usecnt);
+	fdput(*fd);
+
+	srcu_read_unlock(&ufile->device->disassociate_srcu, srcu_key);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_dereg_kernel_mr);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index f5b8be3bedde..83751801d217 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -696,11 +696,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_reg_mr_resp resp = {};
 	struct ib_uverbs_reg_mr      cmd;
-	struct ib_uobject           *uobj;
-	struct ib_pd                *pd;
 	struct ib_mr                *mr;
 	int                          ret;
-	struct ib_device *ib_dev;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -709,55 +706,16 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
 		return -EINVAL;
 
-	uobj = uobj_alloc(UVERBS_OBJECT_MR, attrs, &ib_dev);
-	if (IS_ERR(uobj))
-		return PTR_ERR(uobj);
-
-	ret = ib_check_mr_access(ib_dev, cmd.access_flags);
-	if (ret)
-		goto err_free;
-
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
-		goto err_free;
-	}
-
-	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
-					 cmd.access_flags,
-					 &attrs->driver_udata);
-	if (IS_ERR(mr)) {
-		ret = PTR_ERR(mr);
-		goto err_put;
-	}
-
-	mr->device  = pd->device;
-	mr->pd      = pd;
-	mr->type    = IB_MR_TYPE_USER;
-	mr->dm	    = NULL;
-	mr->sig_attrs = NULL;
-	mr->uobject = uobj;
-	atomic_inc(&pd->usecnt);
-	mr->iova = cmd.hca_va;
-
-	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_name(&mr->res, NULL);
-	rdma_restrack_add(&mr->res);
-
-	uobj->object = mr;
-	uobj_put_obj_read(pd);
-	uobj_finalize_uobj_create(uobj, attrs);
+	mr = uverbs_reg_mr(attrs, cmd.pd_handle, cmd.start, cmd.length,
+			   cmd.hca_va, cmd.access_flags,
+			   &attrs->driver_udata);
+	if (IS_ERR(mr))
+		return PTR_ERR(mr);
 
 	resp.lkey = mr->lkey;
 	resp.rkey = mr->rkey;
-	resp.mr_handle = uobj->id;
+	resp.mr_handle = mr->uobject->id;
 	return uverbs_response(attrs, &resp, sizeof(resp));
-
-err_put:
-	uobj_put_obj_read(pd);
-err_free:
-	uobj_alloc_abort(uobj, attrs);
-	return ret;
 }
 
 static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
diff --git a/drivers/infiniband/ulp/rv/Makefile b/drivers/infiniband/ulp/rv/Makefile
index 01e93dc25f1d..677b113c0666 100644
--- a/drivers/infiniband/ulp/rv/Makefile
+++ b/drivers/infiniband/ulp/rv/Makefile
@@ -4,6 +4,6 @@
 #
 obj-$(CONFIG_INFINIBAND_RV) += rv.o
 
-rv-y := rv_main.o rv_mr_cache.o trace.o
+rv-y := rv_main.o rv_mr_cache.o rv_file.o rv_mr.o trace.o
 
 CFLAGS_trace.o = -I$(src)
diff --git a/drivers/infiniband/ulp/rv/rv_file.c b/drivers/infiniband/ulp/rv/rv_file.c
new file mode 100644
index 000000000000..3625a9c1681a
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/rv_file.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+
+#include "rv.h"
+
+/* A workqueue for all */
+static struct workqueue_struct *rv_wq;
+
+void rv_queue_work(struct work_struct *work)
+{
+	queue_work(rv_wq, work);
+}
+
+void rv_job_dev_get(struct rv_job_dev *jdev)
+{
+	kref_get(&jdev->kref);
+}
+
+static void rv_job_dev_release(struct kref *kref)
+{
+	struct rv_job_dev *jdev = container_of(kref, struct rv_job_dev, kref);
+
+	kfree_rcu(jdev, rcu);
+}
+
+void rv_job_dev_put(struct rv_job_dev *jdev)
+{
+	kref_put(&jdev->kref, rv_job_dev_release);
+}
diff --git a/drivers/infiniband/ulp/rv/rv_mr.c b/drivers/infiniband/ulp/rv/rv_mr.c
new file mode 100644
index 000000000000..76786bd11502
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/rv_mr.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include <rdma/uverbs_ioctl.h>
+
+#include "rv.h"
+#include "trace.h"
+
+unsigned int enable_user_mr;
+
+module_param(enable_user_mr, uint, 0444);
+MODULE_PARM_DESC(enable_user_mr, "Enable user mode MR caching");
+
+static void rv_handle_user_mrs_put(struct work_struct *work);
+
+static bool rv_cache_mrc_filter(struct rv_mr_cached *mrc, u64 addr,
+				u64 len, u32 acc);
+static void rv_cache_mrc_get(struct rv_mr_cache *cache,
+			     void *arg, struct rv_mr_cached *mrc);
+static int rv_cache_mrc_put(struct rv_mr_cache *cache,
+			    void *arg, struct rv_mr_cached *mrc);
+static int rv_cache_mrc_invalidate(struct rv_mr_cache *cache,
+				   void *arg, struct rv_mr_cached *mrc);
+static int rv_cache_mrc_evict(struct rv_mr_cache *cache,
+			      void *arg, struct rv_mr_cached *mrc,
+			      void *evict_arg, bool *stop);
+
+static const struct rv_mr_cache_ops rv_cache_ops = {
+	.filter = rv_cache_mrc_filter,
+	.get = rv_cache_mrc_get,
+	.put = rv_cache_mrc_put,
+	.invalidate = rv_cache_mrc_invalidate,
+	.evict = rv_cache_mrc_evict
+};
+
+/* given an rv, find the proper ib_dev to use when registering user MRs */
+static struct ib_device *rv_ib_dev(struct rv_user *rv)
+{
+	struct rv_device *dev = rv->rdma_mode == RV_RDMA_MODE_USER ? rv->dev :
+				rv->jdev->dev;
+
+	return dev->ib_dev;
+}
+
+/* caller must hold rv->mutex */
+static int rv_drv_api_reg_mem(struct rv_user *rv,
+			      struct rv_mem_params_in *minfo,
+			      struct mr_info *mr)
+{
+	struct ib_mr *ib_mr;
+
+	mr->ib_mr = NULL;
+	mr->ib_pd = NULL;
+
+	/*
+	 * Check if the buffer is for kernel use. It should be noted that
+	 * the ibv_pd_handle value "0" is a valid user space pd handle.
+	 */
+	if (minfo->access & IBV_ACCESS_KERNEL)
+		ib_mr = rdma_reg_kernel_mr(minfo->cmd_fd_int, rv->jdev->pd,
+					   minfo->addr, minfo->length,
+					   minfo->access & ~IBV_ACCESS_KERNEL,
+					   minfo->ulen, minfo->udata,
+					   &mr->fd);
+	else
+		ib_mr = rdma_reg_user_mr(rv_ib_dev(rv), minfo->cmd_fd_int,
+					 minfo->ibv_pd_handle,
+					 minfo->addr, minfo->length,
+					 minfo->access, minfo->ulen,
+					 minfo->udata, &mr->fd);
+	if (IS_ERR(ib_mr)) {
+		rv_err(rv->inx, "reg_user_mr failed\n");
+		return  PTR_ERR(ib_mr);
+	}
+	/* A hardware driver may not set the iova field */
+	if (!ib_mr->iova)
+		ib_mr->iova = minfo->addr;
+
+	trace_rv_mr_info_reg(minfo->addr, minfo->length, minfo->access,
+			     ib_mr->lkey, ib_mr->rkey, ib_mr->iova,
+			     atomic_read(&ib_mr->pd->usecnt));
+	mr->ib_mr = ib_mr;
+	mr->ib_pd = ib_mr->pd;
+
+	return 0;
+}
+
+int rv_drv_api_dereg_mem(struct mr_info *mr)
+{
+	int ret;
+	struct rv_mr_cached *mrc = container_of(mr, struct rv_mr_cached, mr);
+
+	trace_rv_mr_info_dereg(mrc->addr, mrc->len, mrc->access,
+			       mr->ib_mr->lkey, mr->ib_mr->rkey,
+			       mr->ib_mr->iova,
+			       atomic_read(&mr->ib_pd->usecnt));
+
+	if (mrc->access & IBV_ACCESS_KERNEL)
+		ret = rdma_dereg_kernel_mr(mr->ib_mr, &mr->fd);
+	else
+		ret = rdma_dereg_user_mr(mr->ib_mr, &mr->fd);
+	if (!ret) {
+		mr->ib_mr = NULL;
+		mr->ib_pd = NULL;
+	}
+	return ret;
+}
+
+/* Cannot hold rv->mutex */
+struct rv_user_mrs *rv_user_mrs_alloc(struct rv_user *rv, u32 cache_size)
+{
+	int ret;
+	struct rv_user_mrs *umrs;
+
+	umrs = kzalloc(sizeof(*umrs), GFP_KERNEL);
+	if (!umrs)
+		return ERR_PTR(-ENOMEM);
+
+	umrs->rv_inx = rv->inx;
+	ret = rv_mr_cache_init(rv->inx, &umrs->cache, &rv_cache_ops, NULL,
+			       current->mm, cache_size);
+	if (ret)
+		goto bail_free;
+	kref_init(&umrs->kref); /* refcount now 1 */
+	INIT_WORK(&umrs->put_work, rv_handle_user_mrs_put);
+	return umrs;
+
+bail_free:
+	kfree(umrs);
+	return ERR_PTR(ret);
+}
+
+/* called with rv->mutex */
+void rv_user_mrs_attach(struct rv_user *rv)
+{
+	struct rv_user_mrs *umrs = rv->umrs;
+
+	if (rv->rdma_mode == RV_RDMA_MODE_KERNEL) {
+		/*
+		 * for mode KERNEL the user_mrs object may survive past the
+		 * rv_user close, so we need our own jdev reference to dereg
+		 * MRs while outstanding send IOs complete.
+		 * For mode USER, the MRs are using the user's pd
+		 * and rv_user will free all MRs during close
+		 *
+		 * the jdev->pd we will use for MRs and QP needs ref to jdev
+		 */
+		rv_job_dev_get(rv->jdev);
+		umrs->jdev = rv->jdev;
+	}
+	trace_rv_user_mrs_attach(umrs->rv_inx, umrs->jdev,
+				 umrs->cache.total_size, umrs->cache.max_size,
+				 kref_read(&umrs->kref));
+}
+
+static void rv_user_mrs_release(struct rv_user_mrs *umrs)
+{
+	trace_rv_user_mrs_release(umrs->rv_inx, umrs->jdev,
+				  umrs->cache.total_size, umrs->cache.max_size,
+				  kref_read(&umrs->kref));
+	rv_mr_cache_deinit(umrs->rv_inx, &umrs->cache);
+	if (umrs->jdev)
+		rv_job_dev_put(umrs->jdev);
+	kfree(umrs);
+}
+
+static void rv_handle_user_mrs_put(struct work_struct *work)
+{
+	struct rv_user_mrs *umrs = container_of(work, struct rv_user_mrs,
+						put_work);
+
+	rv_user_mrs_release(umrs);
+}
+
+static void rv_user_mrs_schedule_release(struct kref *kref)
+{
+	struct rv_user_mrs *umrs = container_of(kref, struct rv_user_mrs, kref);
+
+	/*
+	 * Since this function may be called from rv_write_done(),
+	 * we can't call rv_user_mrs_release() directly to
+	 * destroy it's rc QP and rv_mr_cache_deinit (and wait for completion)
+	 * Instead, put the cleanup on a workqueue thread.
+	 */
+	rv_queue_work(&umrs->put_work);
+}
+
+void rv_user_mrs_get(struct rv_user_mrs *umrs)
+{
+	kref_get(&umrs->kref);
+}
+
+void rv_user_mrs_put(struct rv_user_mrs *umrs)
+{
+	kref_put(&umrs->kref, rv_user_mrs_schedule_release);
+}
+
+int doit_reg_mem(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_mem_params mparams;
+	struct rv_mr_cached *mrc;
+	int ret;
+	struct rv_user_mrs *umrs = rv->umrs;
+
+	if (copy_from_user(&mparams.in, (void __user *)arg,
+			   sizeof(mparams.in)))
+		return -EFAULT;
+
+	if (!enable_user_mr && !(mparams.in.access & IBV_ACCESS_KERNEL))
+		return -EINVAL;
+
+	/*
+	 * rv->mutex protects use of umrs QP for REG_MR, also
+	 * protects between rb_search and rb_insert vs races with other
+	 * doit_reg_mem and doit_dereg_mem calls
+	 */
+	mutex_lock(&rv->mutex);
+	if (!rv->attached) {
+		ret = rv->was_attached ? -ENXIO : -EINVAL;
+		goto bail_unlock;
+	}
+	if (rv->rdma_mode != RV_RDMA_MODE_KERNEL &&
+	    (mparams.in.access & IBV_ACCESS_KERNEL)) {
+		ret = -EINVAL;
+		goto bail_unlock;
+	}
+
+	trace_rv_mr_reg(rv->rdma_mode, mparams.in.addr,
+			mparams.in.length, mparams.in.access);
+	/* get reference,  if found update hit stats */
+	mrc = rv_mr_cache_search_get(&umrs->cache, mparams.in.addr,
+				     mparams.in.length, mparams.in.access,
+				     true);
+	if (mrc)
+		goto cont;
+
+	/* create a new mrc for rb tree */
+	mrc = kzalloc(sizeof(*mrc), GFP_KERNEL);
+	if (!mrc) {
+		ret = -ENOMEM;
+		umrs->stats.failed++;
+		goto bail_unlock;
+	}
+
+	/* register using verbs callback */
+	ret = rv_drv_api_reg_mem(rv, &mparams.in, &mrc->mr);
+	if (ret) {
+		umrs->stats.failed++;
+		goto bail_free;
+	}
+	mrc->addr = mparams.in.addr;
+	mrc->len = mparams.in.length;
+	mrc->access = mparams.in.access;
+
+	ret = rv_mr_cache_insert(&umrs->cache, mrc);
+	if (ret)
+		goto bail_dereg;
+
+cont:
+	/* return the mr handle, lkey & rkey */
+	mparams.out.mr_handle = (uint64_t)mrc;
+	mparams.out.iova = mrc->mr.ib_mr->iova;
+	mparams.out.lkey = mrc->mr.ib_mr->lkey;
+	mparams.out.rkey = mrc->mr.ib_mr->rkey;
+
+	if (copy_to_user((void __user *)arg, &mparams.out,
+			 sizeof(mparams.out))) {
+		ret = -EFAULT;
+		goto bail_put;
+	}
+
+	mutex_unlock(&rv->mutex);
+
+	return 0;
+
+bail_dereg:
+	if (rv_drv_api_dereg_mem(&mrc->mr))
+		rv_err(rv->inx, "dereg_mem failed during cleanup\n");
+bail_free:
+	kfree(mrc);
+bail_unlock:
+	mutex_unlock(&rv->mutex);
+	return ret;
+
+bail_put:
+	rv_mr_cache_put(&umrs->cache, mrc);
+	mutex_unlock(&rv->mutex);
+	return ret;
+}
+
+int doit_dereg_mem(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_mr_cached *mrc;
+	struct rv_dereg_params_in dparams;
+	int ret = -EINVAL;
+
+	if (copy_from_user(&dparams, (void __user *)arg, sizeof(dparams)))
+		return -EFAULT;
+
+	/* rv->mutex protects possible race with doit_reg_mem */
+	mutex_lock(&rv->mutex);
+	if (!rv->attached) {
+		ret = rv->was_attached ? -ENXIO : -EINVAL;
+		goto bail_unlock;
+	}
+
+	mrc = rv_mr_cache_search_put(&rv->umrs->cache, dparams.addr,
+				     dparams.length, dparams.access);
+	if (!mrc)
+		goto bail_unlock;
+
+	mutex_unlock(&rv->mutex);
+	trace_rv_mr_dereg(rv->rdma_mode, dparams.addr,
+			  dparams.length, dparams.access);
+
+	return 0;
+
+bail_unlock:
+	mutex_unlock(&rv->mutex);
+	return ret;
+}
+
+/* called with cache->lock */
+static bool rv_cache_mrc_filter(struct rv_mr_cached *mrc, u64 addr,
+				u64 len, u32 acc)
+{
+	return mrc->addr == addr && mrc->len == len && mrc->access == acc;
+}
+
+/* called with cache->lock */
+static void rv_cache_mrc_get(struct rv_mr_cache *cache,
+			     void *arg, struct rv_mr_cached *mrc)
+{
+	int refcount;
+
+	refcount = atomic_inc_return(&mrc->refcount);
+	if (refcount == 1) {
+		cache->stats.inuse++;
+		cache->stats.inuse_bytes += mrc->len;
+	}
+	rv_mr_cache_update_stats_max(cache, refcount);
+}
+
+/* called with cache->lock */
+static int rv_cache_mrc_put(struct rv_mr_cache *cache,
+			    void *arg, struct rv_mr_cached *mrc)
+{
+	int refcount;
+
+	refcount = atomic_dec_return(&mrc->refcount);
+	if (!refcount) {
+		cache->stats.inuse--;
+		cache->stats.inuse_bytes -= mrc->len;
+	}
+	return refcount;
+}
+
+/* called with cache->lock */
+static int rv_cache_mrc_invalidate(struct rv_mr_cache *cache,
+				   void *arg, struct rv_mr_cached *mrc)
+{
+	if (!atomic_read(&mrc->refcount))
+		return 1;
+	return 0;
+}
+
+/*
+ * Return 1 if the mrc can be evicted from the cache
+ *
+ * Called with cache->lock
+ */
+static int rv_cache_mrc_evict(struct rv_mr_cache *cache,
+			      void *arg, struct rv_mr_cached *mrc,
+			      void *evict_arg, bool *stop)
+{
+	struct evict_data *evict_data = evict_arg;
+
+	/* is this mrc still being used? */
+	if (atomic_read(&mrc->refcount))
+		return 0; /* keep this mrc */
+
+	/* this mrc will be evicted, add its size to our count */
+	evict_data->cleared += mrc->len;
+
+	/* have enough bytes been cleared? */
+	if (evict_data->cleared >= evict_data->target)
+		*stop = true;
+
+	return 1; /* remove this mrc */
+}
diff --git a/drivers/infiniband/ulp/rv/rv_mr_cache.c b/drivers/infiniband/ulp/rv/rv_mr_cache.c
index 48ea7c958f74..830ee246006b 100644
--- a/drivers/infiniband/ulp/rv/rv_mr_cache.c
+++ b/drivers/infiniband/ulp/rv/rv_mr_cache.c
@@ -374,7 +374,7 @@ static void do_remove(struct rv_mr_cache *cache, struct list_head *del_list)
 	while (!list_empty(del_list)) {
 		mrc = list_first_entry(del_list, struct rv_mr_cached, list);
 		list_del(&mrc->list);
-		/* Deregister the mr here */
+		rv_drv_api_dereg_mem(&mrc->mr);
 		kfree(mrc);
 	}
 }
diff --git a/drivers/infiniband/ulp/rv/trace.h b/drivers/infiniband/ulp/rv/trace.h
index 7a4cc4919693..d2827582be05 100644
--- a/drivers/infiniband/ulp/rv/trace.h
+++ b/drivers/infiniband/ulp/rv/trace.h
@@ -4,3 +4,5 @@
  */
 #include "trace_mr_cache.h"
 #include "trace_dev.h"
+#include "trace_mr.h"
+#include "trace_user.h"
diff --git a/drivers/infiniband/ulp/rv/trace_mr.h b/drivers/infiniband/ulp/rv/trace_mr.h
new file mode 100644
index 000000000000..158c1b106b77
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/trace_mr.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 - 2021 Intel Corporation.
+ */
+#if !defined(__RV_TRACE_MR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __RV_TRACE_MR_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv_mr
+
+#define MR_INFO_PRN "addr 0x%llx len 0x%llx acc 0x%x lkey 0x%x rkey 0x%x " \
+		    "iova 0x%llx pd_usecnt %u"
+
+DECLARE_EVENT_CLASS(/* mr */
+	rv_mr_template,
+	TP_PROTO(u8 mode, u64 addr, u64 len, u32 acc),
+	TP_ARGS(mode, addr, len, acc),
+	TP_STRUCT__entry(/* entry */
+		__field(u8, mode)
+		__field(u64, addr)
+		__field(u64, len)
+		__field(u32, acc)
+	),
+	TP_fast_assign(/* assign */
+		__entry->mode = mode;
+		__entry->addr = addr;
+		__entry->len = len;
+		__entry->acc = acc;
+	),
+	TP_printk(/* print */
+		"mode 0x%x addr 0x%llx, len %llu acc 0x%x",
+		__entry->mode,
+		__entry->addr,
+		__entry->len,
+		__entry->acc
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_mr_template, rv_mr_reg,
+	TP_PROTO(u8 mode, u64 addr, u64 len, u32 acc),
+	TP_ARGS(mode, addr, len, acc)
+);
+
+DEFINE_EVENT(/* event */
+	rv_mr_template, rv_mr_dereg,
+	TP_PROTO(u8 mode, u64 addr, u64 len, u32 acc),
+	TP_ARGS(mode, addr, len, acc)
+);
+
+DECLARE_EVENT_CLASS(/* mr_info */
+	rv_mr_info_template,
+	TP_PROTO(u64 addr, u64 len, u32 acc, u32 lkey,
+		 u32 rkey, u64 iova, u32 pd_usecnt),
+	TP_ARGS(addr, len, acc, lkey, rkey, iova, pd_usecnt),
+	TP_STRUCT__entry(/* entry */
+		__field(u64, addr)
+		__field(u64, len)
+		__field(u32, acc)
+		__field(u32, lkey)
+		__field(u32, rkey)
+		__field(u64, iova)
+		__field(u32, cnt)
+	),
+	TP_fast_assign(/* assign */
+		__entry->addr = addr;
+		__entry->len = len;
+		__entry->acc = acc;
+		__entry->lkey = lkey;
+		__entry->rkey = rkey;
+		__entry->iova = iova;
+		__entry->cnt = pd_usecnt;
+	),
+	TP_printk(/* print */
+		MR_INFO_PRN,
+		__entry->addr,
+		__entry->len,
+		__entry->acc,
+		__entry->lkey,
+		__entry->rkey,
+		__entry->iova,
+		__entry->cnt
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_mr_info_template, rv_mr_info_reg,
+	TP_PROTO(u64 addr, u64 len, u32 acc, u32 lkey,
+		 u32 rkey, u64 iova, u32 pd_usecnt),
+	TP_ARGS(addr, len, acc, lkey, rkey, iova, pd_usecnt)
+);
+
+DEFINE_EVENT(/* event */
+	rv_mr_info_template, rv_mr_info_dereg,
+	TP_PROTO(u64 addr, u64 len, u32 acc, u32 lkey,
+		 u32 rkey, u64 iova, u32 pd_usecnt),
+	TP_ARGS(addr, len, acc, lkey, rkey, iova, pd_usecnt)
+);
+
+#endif /* __RV_TRACE_MR_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_mr
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/ulp/rv/trace_user.h b/drivers/infiniband/ulp/rv/trace_user.h
new file mode 100644
index 000000000000..2707e39bdfd6
--- /dev/null
+++ b/drivers/infiniband/ulp/rv/trace_user.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ */
+#if !defined(__RV_TRACE_USER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __RV_TRACE_USER_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv_user
+
+#define RV_USER_MRS_PRN "rv_nx %d jdev %p total_size 0x%llx max_size 0x%llx " \
+			"refcount %u"
+
+DECLARE_EVENT_CLASS(/* user_mrs */
+	rv_user_mrs_template,
+	TP_PROTO(int rv_inx, void *jdev, u64 total_size, u64 max_size,
+		 u32 refcount),
+	TP_ARGS(rv_inx, jdev, total_size, max_size, refcount),
+	TP_STRUCT__entry(/* entry */
+		__field(int, rv_inx)
+		__field(void *, jdev)
+		__field(u64, total_size)
+		__field(u64, max_size)
+		__field(u32, refcount)
+	),
+	TP_fast_assign(/* assign */
+		__entry->rv_inx = rv_inx;
+		__entry->jdev = jdev;
+		__entry->total_size = total_size;
+		__entry->max_size = max_size;
+		__entry->refcount = refcount;
+	),
+	TP_printk(/* print */
+		RV_USER_MRS_PRN,
+		__entry->rv_inx,
+		__entry->jdev,
+		__entry->total_size,
+		__entry->max_size,
+		__entry->refcount
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_mrs_template, rv_user_mrs_attach,
+	TP_PROTO(int rv_inx, void *jdev, u64 total_size, u64 max_size,
+		 u32 refcount),
+	TP_ARGS(rv_inx, jdev, total_size, max_size, refcount)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_mrs_template, rv_user_mrs_release,
+	TP_PROTO(int rv_inx, void *jdev, u64 total_size, u64 max_size,
+		 u32 refcount),
+	TP_ARGS(rv_inx, jdev, total_size, max_size, refcount)
+);
+
+#endif /* __RV_TRACE_USER_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_user
+#include <trace/define_trace.h>
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index ccd11631c167..93aefd4d085f 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -134,6 +134,16 @@ static inline void uverbs_uobject_get(struct ib_uobject *uobject)
 }
 void uverbs_uobject_put(struct ib_uobject *uobject);
 
+struct ib_mr *rdma_reg_user_mr(struct ib_device *ib_dev, u32 cmd_fd,
+			       u32 pd_handle, u64 start, u64 length,
+			       u32 access_flags, size_t ulen, void *udata,
+			       struct fd *fd);
+int rdma_dereg_user_mr(struct ib_mr *mr, struct fd *fd);
+struct ib_mr *rdma_reg_kernel_mr(u32 cmd_fd, struct ib_pd *kern_pd, u64 start,
+				 u64 length, u32 access_flags, size_t ulen,
+				 void *udata, struct fd *fd);
+int rdma_dereg_kernel_mr(struct ib_mr *mr, struct fd *fd);
+
 struct uverbs_obj_fd_type {
 	/*
 	 * In fd based objects, uverbs_obj_type_ops points to generic
-- 
2.18.1

