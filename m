Return-Path: <linux-rdma+bounces-12081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39407B02EF7
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82556168191
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C91A76D4;
	Sun, 13 Jul 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdGMjTA+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A001A3A8A
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388686; cv=none; b=L5PGq1MJF3BB4LW/KUXh5SEpsvR0LEROD6Px9RsWAdQadiBUImkxnDMkePdX6RdndT0mkW3M4CHcozvE0ykDEdBXeY9PGohT3ZaWJ6x5vXXQjo6ZFanhjmpp6QuC4Ot1c4QELEel5Sfz5Xe1FP5vWX3QixW/d5Tw4h9y8tyOxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388686; c=relaxed/simple;
	bh=8qrhCjRWtt8Mka7vr8YZzKfDGjGzp2poyqvA01PE4aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nueel8uXGi6b6ZsguiEMrWsSnu1CmgpUDQUajbWLuen5qow8er/JtiAc/ZfjwfzFzcEtEzfC7ELr8khwjEtjNXV9a3uYviTuGkJysIdUOzCq39tSxhtosjVeiwEDJrDcPn30gqBEdLO4Ipy54zbZW1acYUh+4znMhqd14Z5J24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdGMjTA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8A5C4CEE3;
	Sun, 13 Jul 2025 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388686;
	bh=8qrhCjRWtt8Mka7vr8YZzKfDGjGzp2poyqvA01PE4aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdGMjTA+Qj+Sz7ItfZLF/CIZcFZpVWozP/BbfYfqFymAIs3+G8yAW4nNA0uiZrduI
	 84LSpzgHkAx6ZVsZ0+hbdFUu4wVdDZ1v8oOosYzAKnN79Md7uN7UGbTM81pP4Nb6b2
	 VfC+TGwbL8AvzwNf3xtaveh7sQ9p/tl0tp94OBoNCcESIbNRLsplysIfNBvqpyRBVb
	 uEQuZ6Rwy+z2SN3D7XGr7NXLRjW3R4DLLIStCvab70pjNhX+lNPTFphWlZr91hGe2H
	 nGdIPz0PzSvYLfWmgPcytCnH/Y5/zWM7ahJUIL8fz8J2tWXhrNS7gw+mI7urTUD4hn
	 CgkE+58rsq/DQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/8] IB/core: Add UVERBS_METHOD_REG_MR on the MR object
Date: Sun, 13 Jul 2025 09:37:25 +0300
Message-ID: <10def41b658ca56f28f77472e3460a802ee09053.1752388126.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752388126.git.leon@kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

This new method enables us to use a single ioctl from user space which
supports the below variants of reg_mr [1].

The method will be extended in the next patches from the series with an
extra attribute to let us pass DMA handle to be used as part of the
registration.

[1] ibv_reg_mr(), ibv_reg_mr_iova(), ibv_reg_mr_iova2(),
ibv_reg_dmabuf_mr().

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 153 +++++++++++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  14 ++
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 7ebc7bd3caae..1bd4b17b5515 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -266,6 +266,122 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
 	return ret;
 }
 
+static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_REG_MR_HANDLE);
+	struct ib_pd *pd =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_MR_PD_HANDLE);
+	u32 valid_access_flags = IB_ACCESS_SUPPORTED;
+	u64 length, iova, fd_offset = 0, addr = 0;
+	struct ib_device *ib_dev = pd->device;
+	bool has_fd_offset = false;
+	bool has_addr = false;
+	bool has_fd = false;
+	u32 access_flags;
+	struct ib_mr *mr;
+	int fd;
+	int ret;
+
+	ret = uverbs_copy_from(&iova, attrs, UVERBS_ATTR_REG_MR_IOVA);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&length, attrs, UVERBS_ATTR_REG_MR_LENGTH);
+	if (ret)
+		return ret;
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_REG_MR_ADDR)) {
+		ret = uverbs_copy_from(&addr, attrs,
+				       UVERBS_ATTR_REG_MR_ADDR);
+		if (ret)
+			return ret;
+		has_addr = true;
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_REG_MR_FD_OFFSET)) {
+		ret = uverbs_copy_from(&fd_offset, attrs,
+				       UVERBS_ATTR_REG_MR_FD_OFFSET);
+		if (ret)
+			return ret;
+		has_fd_offset = true;
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_REG_MR_FD)) {
+		ret = uverbs_get_raw_fd(&fd, attrs,
+					UVERBS_ATTR_REG_MR_FD);
+		if (ret)
+			return ret;
+		has_fd = true;
+	}
+
+	if (has_fd) {
+		if (!ib_dev->ops.reg_user_mr_dmabuf)
+			return -EOPNOTSUPP;
+
+		/* FD requires offset and can't come with addr */
+		if (!has_fd_offset || has_addr)
+			return -EINVAL;
+
+		if ((fd_offset & ~PAGE_MASK) != (iova & ~PAGE_MASK))
+			return -EINVAL;
+
+		valid_access_flags = IB_ACCESS_LOCAL_WRITE |
+				     IB_ACCESS_REMOTE_READ |
+				     IB_ACCESS_REMOTE_WRITE |
+				     IB_ACCESS_REMOTE_ATOMIC |
+				     IB_ACCESS_RELAXED_ORDERING;
+	} else {
+		if (!has_addr || has_fd_offset)
+			return -EINVAL;
+
+		if ((addr & ~PAGE_MASK) != (iova & ~PAGE_MASK))
+			return -EINVAL;
+	}
+
+	ret = uverbs_get_flags32(&access_flags, attrs,
+				 UVERBS_ATTR_REG_MR_ACCESS_FLAGS,
+				 valid_access_flags);
+	if (ret)
+		return ret;
+
+	ret = ib_check_mr_access(ib_dev, access_flags);
+	if (ret)
+		return ret;
+
+	if (has_fd)
+		mr = pd->device->ops.reg_user_mr_dmabuf(pd, fd_offset, length, iova,
+							fd, access_flags, attrs);
+	else
+		mr = pd->device->ops.reg_user_mr(pd, addr, length,
+						 iova, access_flags, NULL);
+
+	if (IS_ERR(mr))
+		return PTR_ERR(mr);
+
+	mr->device = pd->device;
+	mr->pd = pd;
+	mr->type = IB_MR_TYPE_USER;
+	mr->uobject = uobj;
+	atomic_inc(&pd->usecnt);
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_set_name(&mr->res, NULL);
+	rdma_restrack_add(&mr->res);
+	uobj->object = mr;
+
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_MR_HANDLE);
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_MR_RESP_LKEY,
+			     &mr->lkey, sizeof(mr->lkey));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_MR_RESP_RKEY,
+			     &mr->rkey, sizeof(mr->rkey));
+	return ret;
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,
@@ -362,6 +478,40 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(u32),
 			    UA_MANDATORY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_REG_MR,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_HANDLE,
+			UVERBS_OBJECT_MR,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_IOVA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_REG_MR_ACCESS_FLAGS,
+			     enum ib_access_flags,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_ADDR,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_FD_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_REG_MR_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_MR_RESP_LKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_MR_RESP_RKEY,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_MR_HANDLE,
@@ -376,7 +526,8 @@ DECLARE_UVERBS_NAMED_OBJECT(
 	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
 	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
 	&UVERBS_METHOD(UVERBS_METHOD_QUERY_MR),
-	&UVERBS_METHOD(UVERBS_METHOD_REG_DMABUF_MR));
+	&UVERBS_METHOD(UVERBS_METHOD_REG_DMABUF_MR),
+	&UVERBS_METHOD(UVERBS_METHOD_REG_MR));
 
 const struct uapi_definition uverbs_def_obj_mr[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MR,
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index ac7b162611ed..e7b827e281d1 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -253,6 +253,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_ADVISE_MR,
 	UVERBS_METHOD_QUERY_MR,
 	UVERBS_METHOD_REG_DMABUF_MR,
+	UVERBS_METHOD_REG_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -286,6 +287,19 @@ enum uverbs_attrs_reg_dmabuf_mr_cmd_attr_ids {
 	UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
 };
 
+enum uverbs_attrs_reg_mr_cmd_attr_ids {
+	UVERBS_ATTR_REG_MR_HANDLE,
+	UVERBS_ATTR_REG_MR_PD_HANDLE,
+	UVERBS_ATTR_REG_MR_IOVA,
+	UVERBS_ATTR_REG_MR_ADDR,
+	UVERBS_ATTR_REG_MR_LENGTH,
+	UVERBS_ATTR_REG_MR_ACCESS_FLAGS,
+	UVERBS_ATTR_REG_MR_FD,
+	UVERBS_ATTR_REG_MR_FD_OFFSET,
+	UVERBS_ATTR_REG_MR_RESP_LKEY,
+	UVERBS_ATTR_REG_MR_RESP_RKEY,
+};
+
 enum uverbs_attrs_create_counters_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_COUNTERS_HANDLE,
 };
-- 
2.50.1


