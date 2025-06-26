Return-Path: <linux-rdma+bounces-11674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F5AE9D33
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC073AB6E4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34D72635;
	Thu, 26 Jun 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN+EmNZ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5402F1FEC
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939593; cv=none; b=uXftEeHnpiiHlkUrzO5eRQTfUnr1ahgn8ZSNEhN6MPZ1u2KWfRthlfNt1PV8Sodj+iAo1amWfII9GDouqpp+iVSrm0TscHU9Egy/Ff/b9AZaVRUgdyClfE7f+HBRy7yvoJsS2cAWaQ6srWaUe/VlmF3whpepgNGrmQelvOg7ECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939593; c=relaxed/simple;
	bh=a1kEFaEZ/yywk/TZOJ44qo859jl8kLNWfJfkXbM8TdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRr0/5563REdm30vwIfgbGLy8pb8MZiggHAee1rNxdPH+++i/cHmlqBBP9ezLukS8yb2xJRPVC3C6z59Nt+ZRDb8O7/qNkVB3keGblWBF85oTykUPOtSksQ4hrG94lyv8gQz4Rk2fJZtf81wPCotqC68WRryr5XpBpBfAHX+ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN+EmNZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABE6C4CEEB;
	Thu, 26 Jun 2025 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939593;
	bh=a1kEFaEZ/yywk/TZOJ44qo859jl8kLNWfJfkXbM8TdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oN+EmNZ1NjfvCXnLIQ4CrHT1oOHELjX1epjG8GUFY94MzepmTJMLh7AM55gbBCQWY
	 c8pVL+2UkEOb0a8U4TPpB2OYu0Z5P3D3BgBd1/o/ZaErUBxiTTYM01smysJZsSLRMD
	 j6+gwdL1Rt6kpXPSO0TDo9rklEcKGmNLUCXvw3DK6tvNW+mKBVVKKO6d+DGD1lLBbo
	 ihyq07DX3xZUlkQbAKclzgUGoVorwkRvFXZ8DNYsjXTsrueKAp5FS/y+W4/SQgXwH/
	 uH5V/qNgTk3S0GXMyJD8/vXiwc7oWB0JST/Ur7G0UpP2s3JXyYa8egddFlUFsQ9VXu
	 Zrj+w3IZNRhNA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 2/7] RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
Date: Thu, 26 Jun 2025 15:05:53 +0300
Message-ID: <57bee7a9d1831a43124323a29549ecf44efa5362.1750938869.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750938869.git.leon@kernel.org>
References: <cover.1750938869.git.leon@kernel.org>
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


