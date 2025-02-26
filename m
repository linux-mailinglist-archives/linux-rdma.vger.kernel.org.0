Return-Path: <linux-rdma+bounces-8156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0E7A46253
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D5317C797
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7B221735;
	Wed, 26 Feb 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8wwQpIt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8BB22171E
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579477; cv=none; b=fSdfVWzS/clJU6BrLcGAHaOWvhpH3Ke/CsXyQNBFf2zuCmWi4YPHsaNjF+BT/wRjTpclRIEyZOgh2/GX9PI0aLODOrpvDshmpLt9pVw+kw5azby3h1jvKRDz3IDrUumT2rK8vTp7/UqsPgmMs30ZyUxVQTzYZsMJsQzIZdAyZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579477; c=relaxed/simple;
	bh=K0nftxyvHz7gX5c75uVRWlp6980Ou0pQ+UbIuElFXZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQolf4bVa8vmXWufg9t9El/4PJ00nx22Q9UebfvC849jRBbJP9tFMk5zqmuEUcTUwJIZhSXTMWm08GfWo1BrAtDXjIJZ68b+QndEP3Q5EbLRsZ2zOtJ6vIRPdlPcFYLpS5Z75TIxfXXim9EBcJ94twMP+itpzpkWeynUiltSPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8wwQpIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2A2C4CED6;
	Wed, 26 Feb 2025 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579476;
	bh=K0nftxyvHz7gX5c75uVRWlp6980Ou0pQ+UbIuElFXZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8wwQpIt7zYOIrI4BGGd21DnhUD07E0tkIcsV95h7g17Ag4WMlS6Ln5v9KJIJ1/NA
	 JUp5gDFzo76PxvCpDR+s2PZc050eM1qWq3q7lJr5Ih1emoIAXh+JlQeW/RgjRZfPC4
	 JV8dsFnUdqBsHCj8rMqpeYkgpJfuY/ZYU/lJsu0DoJdOcAtWi4tEOTKLHU/kC/c9Sn
	 zSuVGPzE9P/+W/DXMUV/a0gQL28h9mFjFK6ELzWARZtdAxAiKzh5nIjBLAgw9ic4EQ
	 s4dZmwnlrSdu8gHGVtW4TVK8F5WJeEBLaGVF7+LTHwugYDfTCIdxENMc52E6zABarY
	 LM0tGsMhd+2jQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 3/6] RDMA/uverbs: Add support for UCAPs in context creation
Date: Wed, 26 Feb 2025 16:17:29 +0200
Message-ID: <761767651e7dd0592f2977560321b88905ac3a65.1740574943.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574943.git.leon@kernel.org>
References: <cover.1740574943.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Add support for file descriptor array attribute for GET_CONTEXT
commands.

Check that the file descriptor (fd) array represents fds for valid UCAPs.
Store the enabled UCAPs from the fd array as a bitmask in ib_ucontext.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/core/uverbs_cmd.c          | 19 +++++++++++++++++++
 .../infiniband/core/uverbs_std_types_device.c |  4 ++++
 include/rdma/ib_verbs.h                       |  1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 4 files changed, 25 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5ad14c39d48c..96d639e1ffa0 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -42,6 +42,7 @@
 
 #include <rdma/uverbs_types.h>
 #include <rdma/uverbs_std_types.h>
+#include <rdma/ib_ucaps.h>
 #include "rdma_core.h"
 
 #include "uverbs.h"
@@ -232,6 +233,8 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_ucontext *ucontext = attrs->context;
 	struct ib_uverbs_file *file = attrs->ufile;
+	int *fd_array;
+	int fd_count;
 	int ret;
 
 	if (!down_read_trylock(&file->hw_destroy_rwsem))
@@ -247,6 +250,22 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err;
 
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_GET_CONTEXT_FD_ARR)) {
+		fd_count = uverbs_attr_ptr_get_array_size(attrs,
+							  UVERBS_ATTR_GET_CONTEXT_FD_ARR,
+							  sizeof(int));
+		if (fd_count < 0) {
+			ret = fd_count;
+			goto err_uncharge;
+		}
+
+		fd_array = uverbs_attr_get_alloced_ptr(attrs,
+						       UVERBS_ATTR_GET_CONTEXT_FD_ARR);
+		ret = ib_get_ucaps(fd_array, fd_count, &ucontext->enabled_caps);
+		if (ret)
+			goto err_uncharge;
+	}
+
 	ret = ucontext->device->ops.alloc_ucontext(ucontext,
 						   &attrs->driver_udata);
 	if (ret)
diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index fb0555647336..c0fd283d9d6c 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -437,6 +437,10 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(u32), UA_OPTIONAL),
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,
 			    UVERBS_ATTR_TYPE(u64), UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_GET_CONTEXT_FD_ARR,
+			   UVERBS_ATTR_MIN_SIZE(sizeof(int)),
+			   UA_OPTIONAL,
+			   UA_ALLOC_AND_COPY),
 	UVERBS_ATTR_UHW());
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b59bf30de430..84b6d64c9e3a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1530,6 +1530,7 @@ struct ib_ucontext {
 	struct ib_uverbs_file  *ufile;
 
 	struct ib_rdmacg_object	cg_obj;
+	u64 enabled_caps;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index ec719053aab9..ac7b162611ed 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -88,6 +88,7 @@ enum uverbs_attrs_query_port_cmd_attr_ids {
 enum uverbs_attrs_get_context_attr_ids {
 	UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
 	UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,
+	UVERBS_ATTR_GET_CONTEXT_FD_ARR,
 };
 
 enum uverbs_attrs_query_context_attr_ids {
-- 
2.48.1


