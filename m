Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAE1ACE30
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbgDPQ5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 12:57:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:59302 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390596AbgDPQ5k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 12:57:40 -0400
IronPort-SDR: 7gPn8rILODFggCPrLRB/MIA3ygyWQ1flNGWPuPJNEZD/dQGgtz0keKye6iAmfTI7K3BvN8M+0O
 wIOfRikpcNHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:57:37 -0700
IronPort-SDR: s+YapKkmwPY3xucBDx83hXj8cr4poYx2udgW5o/0u+Rku+fJKjg4ip1nMTlOb4ef81+yvhmOFS
 I0Di4/CdHCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="364053031"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 09:57:38 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [RFC PATCH 2/3] RDMA/uverbs: Add uverbs commands for fd-based MR registration
Date:   Thu, 16 Apr 2020 10:09:32 -0700
Message-Id: <1587056973-101760-3-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add new uverbs commands for registering user memory regions associated
with a file descriptor, such as dma-buf.  Add new function pointers to
'struct ib_device_ops' to support the new uverbs commands.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/core/device.c     |   2 +
 drivers/infiniband/core/uverbs_cmd.c | 179 ++++++++++++++++++++++++++++++++++-
 include/rdma/ib_umem.h               |   3 +
 include/rdma/ib_verbs.h              |   8 ++
 include/uapi/rdma/ib_user_verbs.h    |  28 ++++++
 5 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index f6c2552..b3f7261 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2654,9 +2654,11 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, read_counters);
 	SET_DEVICE_OP(dev_ops, reg_dm_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr);
+	SET_DEVICE_OP(dev_ops, reg_user_mr_fd);
 	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
+	SET_DEVICE_OP(dev_ops, rereg_user_mr_fd);
 	SET_DEVICE_OP(dev_ops, resize_cq);
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 060b4eb..b4df5f1 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -879,6 +879,171 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	return ret;
 }
 
+static int ib_uverbs_reg_mr_fd(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_reg_mr_fd   cmd;
+	struct ib_uverbs_reg_mr_resp resp;
+	struct ib_uobject           *uobj;
+	struct ib_pd                *pd;
+	struct ib_mr                *mr;
+	int                          ret;
+	struct ib_device            *ib_dev;
+
+	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
+		return -EINVAL;
+
+	ret = ib_check_mr_access(cmd.access_flags);
+	if (ret)
+		return ret;
+
+	uobj = uobj_alloc(UVERBS_OBJECT_MR, attrs, &ib_dev);
+	if (IS_ERR(uobj))
+		return PTR_ERR(uobj);
+
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	if (!pd) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	if (cmd.access_flags & IB_ACCESS_ON_DEMAND) {
+		if (!(pd->device->attrs.device_cap_flags &
+		      IB_DEVICE_ON_DEMAND_PAGING)) {
+			pr_debug("ODP support not available\n");
+			ret = -EINVAL;
+			goto err_put;
+		}
+	}
+
+	mr = pd->device->ops.reg_user_mr_fd(pd, cmd.start, cmd.length,
+					    cmd.hca_va, cmd.fd_type, cmd.fd,
+					    cmd.access_flags,
+					    &attrs->driver_udata);
+	if (IS_ERR(mr)) {
+		ret = PTR_ERR(mr);
+		goto err_put;
+	}
+
+	mr->device    = pd->device;
+	mr->pd        = pd;
+	mr->type      = IB_MR_TYPE_USER;
+	mr->dm	      = NULL;
+	mr->sig_attrs = NULL;
+	mr->uobject   = uobj;
+	atomic_inc(&pd->usecnt);
+	mr->res.type  = RDMA_RESTRACK_MR;
+	rdma_restrack_uadd(&mr->res);
+
+	uobj->object  = mr;
+
+	memset(&resp, 0, sizeof(resp));
+	resp.lkey      = mr->lkey;
+	resp.rkey      = mr->rkey;
+	resp.mr_handle = uobj->id;
+
+	ret = uverbs_response(attrs, &resp, sizeof(resp));
+	if (ret)
+		goto err_copy;
+
+	uobj_put_obj_read(pd);
+
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
+
+err_copy:
+	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
+
+err_put:
+	uobj_put_obj_read(pd);
+
+err_free:
+	uobj_alloc_abort(uobj, attrs);
+	return ret;
+}
+
+static int ib_uverbs_rereg_mr_fd(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_rereg_mr_fd   cmd;
+	struct ib_uverbs_rereg_mr_resp resp;
+	struct ib_pd                  *pd = NULL;
+	struct ib_mr                  *mr;
+	struct ib_pd                  *old_pd;
+	int                            ret;
+	struct ib_uobject	      *uobj;
+
+	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	if (cmd.flags & ~IB_MR_REREG_SUPPORTED || !cmd.flags)
+		return -EINVAL;
+
+	if ((cmd.flags & IB_MR_REREG_TRANS) &&
+	    (!cmd.start || !cmd.hca_va || 0 >= cmd.length ||
+	     (cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK)))
+		return -EINVAL;
+
+	uobj = uobj_get_write(UVERBS_OBJECT_MR, cmd.mr_handle, attrs);
+	if (IS_ERR(uobj))
+		return PTR_ERR(uobj);
+
+	mr = uobj->object;
+
+	if (mr->dm) {
+		ret = -EINVAL;
+		goto put_uobjs;
+	}
+
+	if (cmd.flags & IB_MR_REREG_ACCESS) {
+		ret = ib_check_mr_access(cmd.access_flags);
+		if (ret)
+			goto put_uobjs;
+	}
+
+	if (cmd.flags & IB_MR_REREG_PD) {
+		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
+				       attrs);
+		if (!pd) {
+			ret = -EINVAL;
+			goto put_uobjs;
+		}
+	}
+
+	old_pd = mr->pd;
+	ret = mr->device->ops.rereg_user_mr_fd(mr, cmd.flags, cmd.start,
+					       cmd.length, cmd.hca_va,
+					       cmd.fd_type, cmd.fd,
+					       cmd.access_flags, pd,
+					       &attrs->driver_udata);
+	if (ret)
+		goto put_uobj_pd;
+
+	if (cmd.flags & IB_MR_REREG_PD) {
+		atomic_inc(&pd->usecnt);
+		mr->pd = pd;
+		atomic_dec(&old_pd->usecnt);
+	}
+
+	memset(&resp, 0, sizeof(resp));
+	resp.lkey = mr->lkey;
+	resp.rkey = mr->rkey;
+
+	ret = uverbs_response(attrs, &resp, sizeof(resp));
+
+put_uobj_pd:
+	if (cmd.flags & IB_MR_REREG_PD)
+		uobj_put_obj_read(pd);
+
+put_uobjs:
+	uobj_put_write(uobj);
+
+	return ret;
+}
+
 static int ib_uverbs_dereg_mr(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_dereg_mr cmd;
@@ -3916,7 +4081,19 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 			ib_uverbs_rereg_mr,
 			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_rereg_mr,
 						struct ib_uverbs_rereg_mr_resp),
-			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr))),
+			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr)),
+		DECLARE_UVERBS_WRITE(
+			IB_USER_VERBS_CMD_REG_MR_FD,
+			ib_uverbs_reg_mr_fd,
+			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_reg_mr_fd,
+						struct ib_uverbs_reg_mr_resp),
+			UAPI_DEF_METHOD_NEEDS_FN(reg_user_mr_fd)),
+		DECLARE_UVERBS_WRITE(
+			IB_USER_VERBS_CMD_REREG_MR_FD,
+			ib_uverbs_rereg_mr_fd,
+			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_rereg_mr_fd,
+						struct ib_uverbs_rereg_mr_resp),
+			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr_fd))),
 
 	DECLARE_UVERBS_OBJECT(
 		UVERBS_OBJECT_MW,
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 026a3cf..2347497 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -38,6 +38,9 @@
 #include <linux/workqueue.h>
 #include <rdma/ib_verbs.h>
 
+#define IB_UMEM_FD_TYPE_NONE	0
+#define IB_UMEM_FD_TYPE_DMABUF	1
+
 struct ib_ucontext;
 struct ib_umem_odp;
 struct ib_umem_dmabuf;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bbc5cfb..2905aa0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2436,6 +2436,14 @@ struct ib_device_ops {
 	int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
 			     u64 virt_addr, int mr_access_flags,
 			     struct ib_pd *pd, struct ib_udata *udata);
+	struct ib_mr *(*reg_user_mr_fd)(struct ib_pd *pd, u64 start, u64 length,
+				     u64 virt_addr, int fd_type, int fd,
+				     int mr_access_flags,
+				     struct ib_udata *udata);
+	int (*rereg_user_mr_fd)(struct ib_mr *mr, int flags, u64 start,
+				u64 length, u64 virt_addr, int fd_type, int fd,
+				int mr_access_flags, struct ib_pd *pd,
+				struct ib_udata *udata);
 	int (*dereg_mr)(struct ib_mr *mr, struct ib_udata *udata);
 	struct ib_mr *(*alloc_mr)(struct ib_pd *pd, enum ib_mr_type mr_type,
 				  u32 max_num_sg, struct ib_udata *udata);
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c74..999fa34 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -88,6 +88,8 @@ enum ib_uverbs_write_cmds {
 	IB_USER_VERBS_CMD_CLOSE_XRCD,
 	IB_USER_VERBS_CMD_CREATE_XSRQ,
 	IB_USER_VERBS_CMD_OPEN_QP,
+	IB_USER_VERBS_CMD_REG_MR_FD,
+	IB_USER_VERBS_CMD_REREG_MR_FD,
 };
 
 enum {
@@ -346,6 +348,18 @@ struct ib_uverbs_reg_mr {
 	__aligned_u64 driver_data[0];
 };
 
+struct ib_uverbs_reg_mr_fd {
+	__aligned_u64 response;
+	__aligned_u64 start;
+	__aligned_u64 length;
+	__aligned_u64 hca_va;
+	__u32 pd_handle;
+	__u32 access_flags;
+	__u32 fd_type;
+	__u32 fd;
+	__aligned_u64 driver_data[0];
+};
+
 struct ib_uverbs_reg_mr_resp {
 	__u32 mr_handle;
 	__u32 lkey;
@@ -365,6 +379,20 @@ struct ib_uverbs_rereg_mr {
 	__aligned_u64 driver_data[0];
 };
 
+struct ib_uverbs_rereg_mr_fd {
+	__aligned_u64 response;
+	__u32 mr_handle;
+	__u32 flags;
+	__aligned_u64 start;
+	__aligned_u64 length;
+	__aligned_u64 hca_va;
+	__u32 pd_handle;
+	__u32 access_flags;
+	__u32 fd_type;
+	__u32 fd;
+	__aligned_u64 driver_data[0];
+};
+
 struct ib_uverbs_rereg_mr_resp {
 	__u32 lkey;
 	__u32 rkey;
-- 
1.8.3.1

