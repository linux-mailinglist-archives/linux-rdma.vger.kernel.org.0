Return-Path: <linux-rdma+bounces-8424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6653AA54A15
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A7C1884B77
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098320AF92;
	Thu,  6 Mar 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaH3XMFz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652720AF7D
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261959; cv=none; b=dh6zEk/7wWOrSMTojlH9eGrPEZIsfr7QkXr9ObntUm2UR6y1NHf6GcnBsMaRwQBDuP7Sr9Rdo6H6lOnMjGDIWozxSI1cIsoQhbpUPYa0PFEw9djnrelR3Dhp5pyWR2nHPYPQcMJ0EKnzi2aKX/Yj1bpXNzua2U/xwzx4cnrtRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261959; c=relaxed/simple;
	bh=FVhnjMExwMrpFaHFuREiJ/T+XdJSrxiV9jaFai0DEVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVM3eejlasRbDfU+7kFBeBTdiWivFP8da+sA2IxwEKr4VhMdiC6BKM6n42MfytU6H6nJE/FJ3mHaECWt/4PieS69F3oUAmFF6zo+qyJA0k1McsZ752oLWoKLOSCx0KzdIPNApsk/1uPGT4emSiND009PUNj3BMi7eCOTWXXxRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaH3XMFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F2AC4CEE4;
	Thu,  6 Mar 2025 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261959;
	bh=FVhnjMExwMrpFaHFuREiJ/T+XdJSrxiV9jaFai0DEVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaH3XMFzPOu+TsqMK8NWNk9xis0U4pWvo+fWqN/NWEouqlUF0cN6yctx+FSF91C6p
	 LQszzI/e3zWC3QDz0BeQU2PCQSZ8rlaGZmBhdSxhgPOgLSdLTeZ6ICL8SWGo7bmRCh
	 MxuzL4u5aMsZLF8452JwJksH7a/BZmUqyaWwcfe0nD1BnQp6dxQCaMTQA0LzCWjz1s
	 MJ6b8lwjkw/63u96S8bBq6tAt0Mn+VEch6T/1EG1en7hH4iqy34rfeRJ5o7etg47rw
	 RC+TOS9HRq/PS/c3M0qIRI0JAi1LN3bSkOMUiyNoEI5+2WNBymA7AMkN+sipTFLANp
	 bUknpd+IRc+qA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 3/6] RDMA/uverbs: Add support for UCAPs in context creation
Date: Thu,  6 Mar 2025 13:51:28 +0200
Message-ID: <ebfb30bc947e2259b193c96a319c80e82599045b.1741261611.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741261611.git.leon@kernel.org>
References: <cover.1741261611.git.leon@kernel.org>
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
index a5761038935d..9941f4185c79 100644
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


