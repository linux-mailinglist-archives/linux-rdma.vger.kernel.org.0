Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39279282CD8
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 21:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJDTAc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 15:00:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:53809 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgJDTAc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 15:00:32 -0400
IronPort-SDR: qbzf2/wr7HdXNBUBfOip0yELbz+5mfWXvCoDr5J/JccgyRo/KeXR1ATsykuiobQ1VI96Wjo3kJ
 fkGS6Gg1zCew==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="160609901"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="160609901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 12:00:31 -0700
IronPort-SDR: YkwA//ASjfSyp0i7fTQt03iuBdNmcl73D6coanVOYNud/lwxYHyqfxHIsHS6slW3wvodJUGgF8
 EHBL2pdxEHLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="295384924"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga007.fm.intel.com with ESMTP; 04 Oct 2020 12:00:31 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC PATCH v3 4/4] RDMA/uverbs: Add uverbs command for dma-buf based MR registration
Date:   Sun,  4 Oct 2020 12:12:31 -0700
Message-Id: <1601838751-148544-5-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add uverbs command for registering user memory region associated
with a dma-buf file descriptor.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 115 ++++++++++++++++++++++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  14 ++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 9b22bb5..388364a 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -178,6 +179,88 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
 	return IS_UVERBS_COPY_ERR(ret) ? ret : 0;
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
+	struct ib_user_mr_attr user_mr_attr;
+	struct ib_mr *mr;
+	int ret;
+
+	if (!ib_dev->ops.reg_user_mr)
+		return -EOPNOTSUPP;
+
+	if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
+		return -EOPNOTSUPP;
+
+	ret = uverbs_copy_from(&user_mr_attr.start, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_ADDR);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&user_mr_attr.length, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_LENGTH);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&user_mr_attr.virt_addr, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_HCA_VA);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&user_mr_attr.fd, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_FD);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_flags32(&user_mr_attr.access_flags, attrs,
+				 UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS,
+				 IB_ACCESS_SUPPORTED);
+	if (ret)
+		return ret;
+
+	user_mr_attr.access_flags |= IB_ACCESS_DMABUF;
+
+	ret = ib_check_mr_access(user_mr_attr.access_flags);
+	if (ret)
+		return ret;
+
+	mr = pd->device->ops.reg_user_mr(pd, &user_mr_attr,
+					 &attrs->driver_udata);
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
@@ -243,6 +326,37 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
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
@@ -253,6 +367,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_MR,
 	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
+	&UVERBS_METHOD(UVERBS_METHOD_REG_DMABUF_MR),
 	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
 	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
 	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 99dcabf..6fd3324 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -249,6 +250,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_METHOD_QUERY_MR,
+	UVERBS_METHOD_REG_DMABUF_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -270,6 +272,18 @@ enum uverbs_attrs_query_mr_cmd_attr_ids {
 	UVERBS_ATTR_QUERY_MR_RESP_IOVA,
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

