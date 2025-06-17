Return-Path: <linux-rdma+bounces-11388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B2AADC522
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3658E1887BF1
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40328FFE5;
	Tue, 17 Jun 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj+m4V9+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81A28FABE
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149364; cv=none; b=aBwsuYRpcqleZEvbHpsooMijV74EbETYe50Kf3uZdnhiyOMCwKYRzubBjhn/08NrmqThKN4S6WQT6hfO/5wKek/2r9c+emSnG8WobhwTgFwYtaeZv/1aO+NsXd6hj++sq5Bso5f+WmSnl+EkTTkH1dmgv6VZ0/Vx26CdwqXRiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149364; c=relaxed/simple;
	bh=a1kEFaEZ/yywk/TZOJ44qo859jl8kLNWfJfkXbM8TdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G60Y8K7tnCURpy1RVWHVQLxNsKTX6uMHCYL4iis+ZyPGijMF6kJYtrIjfrWvfI0B4hqShLzFTKhSv/lkqOmiKM/0d5wdTkk9ao+CdRwRKN9RA7+Zbmcw3HbG0lg9q8xaEVGLRF5xRlsmAsS/Gesayctd+KeeOTjjEGtNWrYtViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj+m4V9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF6FC4CEED;
	Tue, 17 Jun 2025 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149364;
	bh=a1kEFaEZ/yywk/TZOJ44qo859jl8kLNWfJfkXbM8TdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cj+m4V9+fyO/zrxWqr7keyfKVXMgAuHBYE3pruZchEX9IdHac5UlsTgsedhwYbFir
	 zFxyyn7zgcWuu9zHZVZtgo0T9wfPsLrZ9Dop03IWGzrqqw7BUSQtzkFQwe857/l0p7
	 nKZxRRcTi2m4DAU0FAojuOCdGVBURWaPm79Lg4sYFgltQQTuzfIAZFjhqq3O1tdeLy
	 SFrWegNJ2RAG0MFu8xY9/GFHHGA5mybMzRl7EiwtPTUbGHCd+Dvws4rkZLhXINnBLY
	 RcyN9yd3S9rBbOfWoc8vH6rLNQEpzCnXgfYGhi53ykHht6osFAfz98K/Ow/mhVYfhu
	 pw5nxI6yw6G3A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 2/7] RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
Date: Tue, 17 Jun 2025 11:35:46 +0300
Message-ID: <1845d577e9b09caad3af28474aa2498390587db3.1750148509.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148509.git.leon@kernel.org>
References: <cover.1750148509.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using podman, it fails to create
the QP.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 2dee0e545894 ("IB/uverbs: Enable QP creation with a given source QP number")
Fixes: 6d1e7ba241e9 ("IB/uverbs: Introduce create/destroy QP commands over ioctl")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 11 +++++++----
 drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 08a738a2a1ff..84f9bbc781d3 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1312,9 +1312,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 	switch (cmd->qp_type) {
 	case IB_QPT_RAW_PACKET:
-		if (!capable(CAP_NET_RAW))
-			return -EPERM;
-		break;
 	case IB_QPT_RC:
 	case IB_QPT_UC:
 	case IB_QPT_UD:
@@ -1330,6 +1327,12 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 						 &ib_dev);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
+
+	if (cmd->qp_type == IB_QPT_RAW_PACKET) {
+		if (!rdma_dev_has_raw_cap(ib_dev))
+			return -EPERM;
+	}
+
 	obj->uxrcd = NULL;
 	obj->uevent.uobject.user_handle = cmd->user_handle;
 	mutex_init(&obj->mcast_lock);
@@ -1451,7 +1454,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	}
 
 	if (attr.create_flags & IB_QP_CREATE_SOURCE_QPN) {
-		if (!capable(CAP_NET_RAW)) {
+		if (!rdma_dev_has_raw_cap(device)) {
 			ret = -EPERM;
 			goto err_put;
 		}
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 7b4773fa4bc0..3f7bd5702fe4 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -133,7 +133,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 		device = xrcd->device;
 		break;
 	case IB_UVERBS_QPT_RAW_PACKET:
-		if (!capable(CAP_NET_RAW))
+		if (!rdma_dev_has_raw_cap(attrs->context->device))
 			return -EPERM;
 		fallthrough;
 	case IB_UVERBS_QPT_RC:
-- 
2.49.0


