Return-Path: <linux-rdma+bounces-11396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A36ADC535
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA8188E4AF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DA28FFD0;
	Tue, 17 Jun 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgr0flCi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058798528E
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149860; cv=none; b=NJZ1gcUfoV44a6cBTRiWU+MpYFfs7bxaY4RpYMcyNTNimqkgIHS54Wh817DVwOxLbmkdiy+khdO9j0xp5/U7OP+kEUyNb+9RjFlreFW9KVhxsgNa7z8OP2BvrzDZZuxlea2UM0xD1qzwIpv6qOm8y3ymhSjeE3QOEyvkkbzlh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149860; c=relaxed/simple;
	bh=uO9sF8mtbGcXtQWFce4oUHEEMNOhL5QqkiArmVoQ/Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJS31QUVVml3dqaV2IPJGo645KtSXA4STdcZ3O//b7wV7dL1xxc7Oq2k1jJn3Jq417WgCI+90U26wblGRmj+yW+yOXjNea3jBXPf7pn7grcEd/EyqkSK0PR+4JGEAdJQCCKvXxMDXdcfO3QPyPc9Ih6NtpOJubd48eLtM+HxE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgr0flCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25147C4CEE3;
	Tue, 17 Jun 2025 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149859;
	bh=uO9sF8mtbGcXtQWFce4oUHEEMNOhL5QqkiArmVoQ/Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tgr0flCiVTVFwQJF1wpWFCVDHrOQEHtvxJnbUazc1KnycY2n8efdkQR7dB7fZfb1D
	 UhN1U0DxYt16lvoyqHC7ItGTWmupiisO0dbVcQitWcI0JsJweDL+D1rgD4NqRGdue4
	 bdKbRtSA/WXk2Q9cJ855mrYLlT90PK/Ee37FV2fdiCMYFN2VVtMftoAPwDaRPvoSdh
	 nGL4CYRWT759MF+es4cXpzWjvbvwghrWzuRdZvnqgN7HloN65Fo2k6UIlAnVP4EOfh
	 5pgUnAutyAZNDqCZ/doLhoJ7fLNRsIUcVOCuh4pgpJUuTbh2I939GCNga9hYPJ0OcL
	 qsnX6SXd+U5cQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 1/3] RDMA/core: Extend RDMA device registration to be net namespace aware
Date: Tue, 17 Jun 2025 11:44:01 +0300
Message-ID: <e383de8cd1df118e6cc4a0a5c0d27c0118611fe4.1750149405.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750149405.git.leon@kernel.org>
References: <cover.1750149405.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Presently, RDMA devices are always registered within the init network
namespace, even if the associated devlink device's namespace was
changed via a devlink reload. This mismatch leads to discrepancies
between the network namespace of the devlink device and that of the
RDMA device.

Therefore, extend the RDMA device allocation API to optionally take
the net namespace. This isn't limited to devices that support devlink
but allows all users to provide the network namespace if they need to
do so.

If a network namespace is provided during device allocation, it's up
to the caller to make sure the namespace stays valid until
ib_register_device() is called.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c  | 14 ++++++++++++--
 drivers/infiniband/sw/rdmavt/vt.c |  2 +-
 include/rdma/ib_verbs.h           | 11 +++++++++--
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 79d8e6fce487..1ca6a9b7ba1a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -584,6 +584,8 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 /**
  * _ib_alloc_device - allocate an IB device struct
  * @size:size of structure to allocate
+ * @net: network namespace device should be located in, namespace
+ *       must stay valid until ib_register_device() is completed.
  *
  * Low-level drivers should use ib_alloc_device() to allocate &struct
  * ib_device.  @size is the size of the structure to be allocated,
@@ -591,7 +593,7 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
  * ib_dealloc_device() must be used to free structures allocated with
  * ib_alloc_device().
  */
-struct ib_device *_ib_alloc_device(size_t size)
+struct ib_device *_ib_alloc_device(size_t size, struct net *net)
 {
 	struct ib_device *device;
 	unsigned int i;
@@ -608,7 +610,15 @@ struct ib_device *_ib_alloc_device(size_t size)
 		return NULL;
 	}
 
-	rdma_init_coredev(&device->coredev, device, &init_net);
+	/* ib_devices_shared_netns can't change while we have active namespaces
+	 * in the system which means either init_net is passed or the user has
+	 * no idea what they are doing.
+	 *
+	 * To avoid breaking backward compatibility, when in shared mode,
+	 * force to init the device in the init_net.
+	 */
+	net = ib_devices_shared_netns ? &init_net : net;
+	rdma_init_coredev(&device->coredev, device, net);
 
 	INIT_LIST_HEAD(&device->event_handler_list);
 	spin_lock_init(&device->qp_open_list_lock);
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 5499025e8a0a..d22d610c2696 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -49,7 +49,7 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
 {
 	struct rvt_dev_info *rdi;
 
-	rdi = container_of(_ib_alloc_device(size), struct rvt_dev_info, ibdev);
+	rdi = container_of(_ib_alloc_device(size, &init_net), struct rvt_dev_info, ibdev);
 	if (!rdi)
 		return rdi;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5e70a5cf35c3..77cea846eb2d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2914,11 +2914,18 @@ struct ib_block_iter {
 	unsigned int __pg_bit;		/* alignment of current block */
 };
 
-struct ib_device *_ib_alloc_device(size_t size);
+struct ib_device *_ib_alloc_device(size_t size, struct net *net);
 #define ib_alloc_device(drv_struct, member)                                    \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
 				      BUILD_BUG_ON_ZERO(offsetof(              \
-					      struct drv_struct, member))),    \
+					      struct drv_struct, member)),     \
+				      &init_net),			       \
+		     struct drv_struct, member)
+
+#define ib_alloc_device_with_net(drv_struct, member, net)		       \
+	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
+				      BUILD_BUG_ON_ZERO(offsetof(              \
+					struct drv_struct, member)), net),     \
 		     struct drv_struct, member)
 
 void ib_dealloc_device(struct ib_device *device);
-- 
2.49.0


