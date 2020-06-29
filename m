Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3520D443
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 21:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgF2TGr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 15:06:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:9636 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730789AbgF2TGj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:39 -0400
IronPort-SDR: mz8Q2zCl+i3/prfpgKcIU6H/j8V9zgz+O5BHQ2wcIDrs4xpo71ywRFYsfoh0GuxG0D41JlaecT
 c/5i1F//ifew==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="125645698"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="125645698"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 10:20:11 -0700
IronPort-SDR: JD1ApKSWcfD2wIDSYSmsTowU3SpmYYlXgFvecUG1sQw7TGDnaYOoFBSdtT5kUDUTw40qjCou5K
 kvKnPoLpc9xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="320698825"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 10:20:11 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC PATCH v2 3/3] RDMA/uverbs: Add uverbs command for dma-buf based MR registration
Date:   Mon, 29 Jun 2020 10:31:43 -0700
Message-Id: <1593451903-30959-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add uverbs command for registering user memory region associated
with a dma-buf file descriptor.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 112 ++++++++++++++++++++++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  14 ++++
 2 files changed, 126 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index c1286a5..2c9ff7c 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -154,6 +155,85 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	return ret;
 }
 
+static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_REG_DMABUF_MR_HANDLE);
+	struct ib_pd *pd =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE);
+	struct ib_device *ib_dev = pd->device;
+
+	u64 addr, length, hca_va;
+	u32 fd;
+	u32 access_flags;
+	struct ib_mr *mr;
+	int ret;
+
+	if (!ib_dev->ops.reg_user_mr)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_copy_from(&addr, attrs, UVERBS_ATTR_REG_DMABUF_MR_ADDR);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&length, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_LENGTH);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&hca_va, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_HCA_VA);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&fd, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_FD);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_flags32(&access_flags, attrs,
+				 UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS,
+				 IB_ACCESS_SUPPORTED);
+	if (ret)
+		return ret;
+
+	ret = ib_check_mr_access(access_flags);
+	if (ret)
+		return ret;
+
+	mr = pd->device->ops.reg_user_mr(pd, addr, length, hca_va,
+					   (int)(s32)fd, access_flags,
+					   &attrs->driver_udata);
+	if (IS_ERR(mr))
+		return PTR_ERR(mr);
+
+	mr->device  = pd->device;
+	mr->pd      = pd;
+	mr->type    = IB_MR_TYPE_USER;
+	mr->uobject = uobj;
+	atomic_inc(&pd->usecnt);
+
+	uobj->object = mr;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
+			     &mr->lkey, sizeof(mr->lkey));
+	if (ret)
+		goto err_dereg;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
+			     &mr->rkey, sizeof(mr->rkey));
+	if (ret)
+		goto err_dereg;
+
+	return 0;
+
+err_dereg:
+	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
+
+	return ret;
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,
@@ -200,6 +280,37 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 			    UVERBS_ATTR_TYPE(u32),
 			    UA_MANDATORY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_REG_DMABUF_MR,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
+			UVERBS_OBJECT_MR,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_ADDR,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_HCA_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_FD,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS,
+			     enum ib_access_flags),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_MR_HANDLE,
@@ -210,6 +321,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_MR,
 	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
+	&UVERBS_METHOD(UVERBS_METHOD_REG_DMABUF_MR),
 	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
 	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
 	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR));
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index d4ddbe4..31aacbf 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -161,6 +162,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_DM_MR_REG,
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
+	UVERBS_METHOD_REG_DMABUF_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -174,6 +176,18 @@ enum uverbs_attrs_advise_mr_cmd_attr_ids {
 	UVERBS_ATTR_ADVISE_MR_SGE_LIST,
 };
 
+enum uverbs_attrs_reg_dmabuf_mr_cmd_attr_ids {
+	UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
+	UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE,
+	UVERBS_ATTR_REG_DMABUF_MR_ADDR,
+	UVERBS_ATTR_REG_DMABUF_MR_LENGTH,
+	UVERBS_ATTR_REG_DMABUF_MR_HCA_VA,
+	UVERBS_ATTR_REG_DMABUF_MR_FD,
+	UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS,
+	UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
+	UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
+};
+
 enum uverbs_attrs_create_counters_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_COUNTERS_HANDLE,
 };
-- 
1.8.3.1

