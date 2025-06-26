Return-Path: <linux-rdma+bounces-11691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE77AEA5F8
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADE53AD9B9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FB2EF654;
	Thu, 26 Jun 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwEysQHZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219D2EF64C
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964326; cv=none; b=g+FF9zIfLSnXUSM83yuSmsaZc7zewDLOLuLEy6i4CNdtIMq7uhDwCVKYAa5e2xUiZpyu0coPa9exQamPtHHXP4Z3RLlHQK6GrC4CooTrZEF6LUpoW8Jevcjk5BXmbs3jXZN6vuq4/d/B85NSmja136ahiXjKQ33jyt4Qr15ZE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964326; c=relaxed/simple;
	bh=xHtxt1SiwTwFtHsZLQhU24D4PT5dmuWdcASh99n8Noc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXJZI9DDrbEYDaaZJczw73D9j2yh/ki55VUxNw+6rlT9HtqeoYdtdGZtkQAm1d9u6wLeJo64IND3QV1dW2rMFBgC/X4K6QaY891iv2OBq0scOgZSAi4er9i6pU9RjXCVg7Kka/np0fmiPx6CozO823ErOw90H786tR+tKDYSuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwEysQHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2373FC4CEEB;
	Thu, 26 Jun 2025 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964326;
	bh=xHtxt1SiwTwFtHsZLQhU24D4PT5dmuWdcASh99n8Noc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwEysQHZBsacnfvlcwOkA4+kA97DGkEJF0QD9jr/y9mM3CH/cdAUg8HNQCCpKLWyK
	 +v37fF4LrXg6nR2dKwOaE968hmUMI2TAChfqyabUnVQIHAnKKnoRQkEiaSSJzMLPQB
	 Z/SVYyw7kKciF1FCPb+DrGvg72nM/jPQFxy7saZhOv1nHc7HRO/ItBFMIHZLUY/LxJ
	 kRkKjOHYF2ggvsljYslmgiLbiziHsQT/q+Wg9ng09/8GSl5wx2caHMNVrptU6owdWe
	 UBWz5NxcN/MburRSSkSrUx3KHvKYrZBIVdMWBz/uj07A24jINez7AczN4kiEI2pAXw
	 62Yb222KMktQA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 1/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
Date: Thu, 26 Jun 2025 21:58:04 +0300
Message-ID: <6df6f2f24627874c4f6d041c19dc1f6f29f68f84.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
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
when a process is running using Podman, it fails to create
the flow resource.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 436f2ad05a0b ("IB/core: Export ib_create/destroy_flow through uverbs")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c     | 27 ++++++++++++++++++++++++++
 drivers/infiniband/core/rdma_core.c  | 29 ++++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c |  2 +-
 include/rdma/ib_verbs.h              |  3 +++
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c0f8b8cba7c0..1ca6a9b7ba1a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -145,6 +145,33 @@ bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
 }
 EXPORT_SYMBOL(rdma_dev_access_netns);
 
+/**
+ * rdma_dev_has_raw_cap() - Returns whether a specified rdma device has
+ *			    CAP_NET_RAW capability or not.
+ *
+ * @dev:	Pointer to rdma device whose capability to be checked
+ *
+ * Returns true if a rdma device's owning user namespace has CAP_NET_RAW
+ * capability, otherwise false. When rdma subsystem is in legacy shared network,
+ * namespace mode, the default net namespace is considered.
+ */
+bool rdma_dev_has_raw_cap(const struct ib_device *dev)
+{
+	const struct net *net;
+
+	/* Network namespace is the resource whose user namespace
+	 * to be considered. When in shared mode, there is no reliable
+	 * network namespace resource, so consider the default net namespace.
+	 */
+	if (ib_devices_shared_netns)
+		net = &init_net;
+	else
+		net = read_pnet(&dev->coredev.rdma_net);
+
+	return ns_capable(net->user_ns, CAP_NET_RAW);
+}
+EXPORT_SYMBOL(rdma_dev_has_raw_cap);
+
 /*
  * xarray has this behavior where it won't iterate over NULL values stored in
  * allocated arrays.  So we need our own iterator to see all values stored in
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 90c177edf9b0..18918f463361 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -1019,3 +1019,32 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 		WARN_ON(true);
 	}
 }
+
+/**
+ * rdma_uattrs_has_raw_cap() - Returns whether a rdma device linked to the
+ *			       uverbs attributes file has CAP_NET_RAW
+ *			       capability or not.
+ *
+ * @attrs:       Pointer to uverbs attributes
+ *
+ * Returns true if a rdma device's owning user namespace has CAP_NET_RAW
+ * capability, otherwise false.
+ */
+bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_file *ufile = attrs->ufile;
+	struct ib_ucontext *ucontext;
+	bool has_cap = false;
+	int srcu_key;
+
+	srcu_key = srcu_read_lock(&ufile->device->disassociate_srcu);
+	ucontext = ib_uverbs_get_ucontext_file(ufile);
+	if (IS_ERR(ucontext))
+		goto out;
+	has_cap = rdma_dev_has_raw_cap(ucontext->device);
+
+out:
+	srcu_read_unlock(&ufile->device->disassociate_srcu, srcu_key);
+	return has_cap;
+}
+EXPORT_SYMBOL(rdma_uattrs_has_raw_cap);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index bc9fe3ceca4d..6700c2c66167 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3225,7 +3225,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (cmd.comp_mask)
 		return -EINVAL;
 
-	if (!capable(CAP_NET_RAW))
+	if (!rdma_uattrs_has_raw_cap(attrs))
 		return -EPERM;
 
 	if (cmd.flow_attr.flags >= IB_FLOW_ATTR_FLAGS_RESERVED)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7da27f01eeb6..010594dc755b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4817,6 +4817,8 @@ static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
 }
 #endif
 
+bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
+
 struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
 				     enum rdma_netdev_t type, const char *name,
 				     unsigned char name_assign_type,
@@ -4871,6 +4873,7 @@ static inline int ibdev_to_node(struct ib_device *ibdev)
 bool rdma_dev_access_netns(const struct ib_device *device,
 			   const struct net *net);
 
+bool rdma_dev_has_raw_cap(const struct ib_device *dev);
 static inline struct net *rdma_dev_net(struct ib_device *device)
 {
 	return read_pnet(&device->coredev.rdma_net);
-- 
2.49.0


