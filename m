Return-Path: <linux-rdma+bounces-11389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14242ADC524
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8264C188D636
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9F28F527;
	Tue, 17 Jun 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYMZPVmt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578419DF6A
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149368; cv=none; b=H6fu6QD1AoTp/URLR1a7XwFImdE7C6j4XAdTF+KWMpDVlcuObQfXlieDf3PRMedNOmSTH+Mvc8lkRGUsVWHq6FigcL6b63fR/c23DH6FZQHwknotN9bfHbUBCKO84SHaOmhhPyhCSnp036FkDYdO0jjxltAuM2oWqKt9rFD8ePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149368; c=relaxed/simple;
	bh=hSMSiZb3PGlfN5vxPVmRZjLI9TI+XWBxFYYuG/YWIPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8O6xZF5p9DNkflroKHVb2+zu0xXTplZDVoFkqCtcJ88G3OEAbxmTxtQQTs0XYtUNkwliLZaELNNUO666PDYwobxkcoDIQrmuuKy7Cea5cOCNVKNzey4+ivITiqjWKBkfHnlpOm0kSIuJfT3zq+gweyYIyHtCzxkcDWzu20KxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYMZPVmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A4AC4CEE3;
	Tue, 17 Jun 2025 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149368;
	bh=hSMSiZb3PGlfN5vxPVmRZjLI9TI+XWBxFYYuG/YWIPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYMZPVmtYYYvmUdYYswf5GC7ql6VFMB0KiiLG/pGTdGnXraY7OkGPtdZuzI/zqwcH
	 hFV10R+Z4kVcbw7YK5TfdbA2KbBRdbI/DsbL96fD7XSkjF7TP+YqhwQT4IWl7eAEc8
	 4FIw7MUqUaEyadkMfoAacunr6Qwtd8Owdogn+7Q0Fo5uJIdusFzZvwhB2+jjJJcSbl
	 X+N75Cm9zsoPTjK/UkGezO+75EJDSFn32WkEuukG5BG5himKNBguwZVhjab25/GTfC
	 NWwSwncmPsHRWgycEQzZXGv729f0mGAb/eKl+aHhzAQcivNqw1UNv1zbwRc+FFGcUx
	 OOWXYEv2z30ew==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 1/7] RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
Date: Tue, 17 Jun 2025 11:35:45 +0300
Message-ID: <2507c8db067e0e983c4ff9a76bf82ce8cb7256aa.1750148509.git.leon@kernel.org>
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
the flow resource.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 436f2ad05a0b ("IB/core: Export ib_create/destroy_flow through uverbs")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c     | 27 +++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c |  8 +++++---
 include/rdma/ib_verbs.h              |  2 ++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 468ed6bd4722..79d8e6fce487 100644
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
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index bc9fe3ceca4d..08a738a2a1ff 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3225,9 +3225,6 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (cmd.comp_mask)
 		return -EINVAL;
 
-	if (!capable(CAP_NET_RAW))
-		return -EPERM;
-
 	if (cmd.flow_attr.flags >= IB_FLOW_ATTR_FLAGS_RESERVED)
 		return -EINVAL;
 
@@ -3272,6 +3269,11 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free_attr;
 	}
 
+	if (!rdma_dev_has_raw_cap(uobj->context->device)) {
+		err = -EPERM;
+		goto err_uobj;
+	}
+
 	if (!rdma_is_port_valid(uobj->context->device, cmd.flow_attr.port)) {
 		err = -EINVAL;
 		goto err_uobj;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 38f68d245fa6..5e70a5cf35c3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4864,6 +4864,8 @@ static inline int ibdev_to_node(struct ib_device *ibdev)
 bool rdma_dev_access_netns(const struct ib_device *device,
 			   const struct net *net);
 
+bool rdma_dev_has_raw_cap(const struct ib_device *dev);
+
 #define IB_ROCE_UDP_ENCAP_VALID_PORT_MIN (0xC000)
 #define IB_ROCE_UDP_ENCAP_VALID_PORT_MAX (0xFFFF)
 #define IB_GRH_FLOWLABEL_MASK (0x000FFFFF)
-- 
2.49.0


