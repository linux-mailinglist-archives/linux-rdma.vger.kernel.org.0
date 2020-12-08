Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A022D3632
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgLHWZJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 17:25:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:1907 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbgLHWZJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 17:25:09 -0500
IronPort-SDR: mkXprRnnk5efcpuDR92FY8COnqJJV3KgOfuzMruerdPfnCxEGDiMo22yMQl8W8sIUEYFTrS7IN
 R2WweSt+HxYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153789994"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="153789994"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 14:23:48 -0800
IronPort-SDR: SRVoqd2OW/oj55SvFUzZJJ7JKQ9To8te+McvqOIPprJVUhh6HdlDCoxIHjsBrFxZuKuoFprOda
 40fXBVq+woaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363844600"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga008.jf.intel.com with ESMTP; 08 Dec 2020 14:23:48 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v14 3/4] RDMA/uverbs: Add uverbs command for dma-buf based MR registration
Date:   Tue,  8 Dec 2020 14:39:14 -0800
Message-Id: <1607467155-92725-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607467155-92725-1-git-send-email-jianxin.xiong@intel.com>
References: <1607467155-92725-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement a new uverbs ioctl method for memory registration with file
descriptor as an extra parameter.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Acked-by: Christian Koenig <christian.koenig@amd.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 117 +++++++++++++++++++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  14 +++
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index dc58564..4660c76 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -182,6 +183,86 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
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
+	u64 offset, length, virt_addr;
+	u32 fd, access_flags;
+	struct ib_mr *mr;
+	int ret;
+
+	if (!ib_dev->ops.reg_user_mr_dmabuf)
+		return -EOPNOTSUPP;
+
+	if (!(pd->device->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
+		return -EOPNOTSUPP;
+
+	ret = uverbs_copy_from(&offset, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_OFFSET);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&length, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_LENGTH);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&virt_addr, attrs,
+			       UVERBS_ATTR_REG_DMABUF_MR_IOVA);
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
+				 IB_ACCESS_LOCAL_WRITE |
+				 IB_ACCESS_REMOTE_READ |
+				 IB_ACCESS_REMOTE_WRITE |
+				 IB_ACCESS_REMOTE_ATOMIC |
+				 IB_ACCESS_RELAXED_ORDERING);
+	if (ret)
+		return ret;
+
+	ret = ib_check_mr_access(access_flags);
+	if (ret)
+		return ret;
+
+	mr = pd->device->ops.reg_user_mr_dmabuf(pd, offset, length, virt_addr,
+						fd, access_flags,
+						&attrs->driver_udata);
+	if (IS_ERR(mr))
+		return PTR_ERR(mr);
+
+	mr->device = pd->device;
+	mr->pd = pd;
+	mr->type = IB_MR_TYPE_USER;
+	mr->uobject = uobj;
+	atomic_inc(&pd->usecnt);
+
+	uobj->object = mr;
+
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DMABUF_MR_HANDLE);
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
+			     &mr->lkey, sizeof(mr->lkey));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
+			     &mr->rkey, sizeof(mr->rkey));
+	return ret;
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,
@@ -247,6 +328,37 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
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
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_DMABUF_MR_IOVA,
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
@@ -257,10 +369,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_MR,
 	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
+	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
 	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
 	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
-	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
-	&UVERBS_METHOD(UVERBS_METHOD_QUERY_MR));
+	&UVERBS_METHOD(UVERBS_METHOD_QUERY_MR),
+	&UVERBS_METHOD(UVERBS_METHOD_REG_DMABUF_MR));
 
 const struct uapi_definition uverbs_def_obj_mr[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MR,
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 7968a18..dafc7eb 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2020, Intel Corporation. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -251,6 +252,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_METHOD_QUERY_MR,
+	UVERBS_METHOD_REG_DMABUF_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -272,6 +274,18 @@ enum uverbs_attrs_query_mr_cmd_attr_ids {
 	UVERBS_ATTR_QUERY_MR_RESP_IOVA,
 };
 
+enum uverbs_attrs_reg_dmabuf_mr_cmd_attr_ids {
+	UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
+	UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE,
+	UVERBS_ATTR_REG_DMABUF_MR_OFFSET,
+	UVERBS_ATTR_REG_DMABUF_MR_LENGTH,
+	UVERBS_ATTR_REG_DMABUF_MR_IOVA,
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

