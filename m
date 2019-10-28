Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0CE6ECB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfJ1JP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:15:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37885 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387874AbfJ1JP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fqi0032512;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9FqcQ031555;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9FqKf031554;
        Mon, 28 Oct 2019 11:15:52 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 2/6] verbs: custom parent-domain allocators
Date:   Mon, 28 Oct 2019 11:14:55 +0200
Message-Id: <1572254099-30864-3-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haggai Eran <haggaie@mellanox.com>

Extend the parent domain object with custom allocation callbacks that
can be used by user-applications to override the provider allocation.

This can be used for example to add NUMA aware allocation.

The new allocator receives context information about the parent domain,
as well as the requested size and alignment of the buffer. It also
receives a vendor-specific resource type code to allow customizing it
for specific resources.

The allocator then allocates the memory or returns an
IBV_ALLOCATOR_USE_DEFAULT value to request that the provider driver use
its own allocation method.

Signed-off-by: Haggai Eran <haggaie@mellanox.com>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/man/ibv_alloc_parent_domain.3 | 54 ++++++++++++++++++++++++++++++++
 libibverbs/verbs.h                       | 12 +++++++
 2 files changed, 66 insertions(+)

diff --git a/libibverbs/man/ibv_alloc_parent_domain.3 b/libibverbs/man/ibv_alloc_parent_domain.3
index 92b6058..6e2f356 100644
--- a/libibverbs/man/ibv_alloc_parent_domain.3
+++ b/libibverbs/man/ibv_alloc_parent_domain.3
@@ -41,11 +41,23 @@ The
 argument specifies the following:
 .PP
 .nf
+enum ibv_parent_domain_init_attr_mask {
+.in +8
+IBV_PARENT_DOMAIN_INIT_ATTR_ALLOCATORS = 1 << 0,
+IBV_PARENT_DOMAIN_INIT_ATTR_PD_CONTEXT = 1 << 1,
+.in -8
+};
+
 struct ibv_parent_domain_init_attr {
 .in +8
 struct ibv_pd *pd; /* referance to a protection domain, can't be NULL */
 struct ibv_td *td; /* referance to a thread domain, or NULL */
 uint32_t comp_mask;
+void *(*alloc)(struct ibv_pd *pd, void *pd_context, size_t size,
+               size_t alignment, uint64_t resource_type);
+void (*free)(struct ibv_pd *pd, void *pd_context, void *ptr,
+             uint64_t resource_type);
+void *pd_context;
 .in -8
 };
 .fi
@@ -56,6 +68,48 @@ will deallocate the parent domain as its exposed as an ibv_pd
 .I pd\fR.
 All resources created with the parent domain
 should be destroyed prior to deallocating the parent domain\fR.
+.SH "ARGUMENTS"
+.B pd
+Reference to the protection domain that this parent domain uses.
+.PP
+.B td
+An optional thread domain that the parent domain uses.
+.PP
+.B comp_mask
+Bit-mask of optional fields in the ibv_parent_domain_init_attr struct.
+.PP
+.B alloc
+Custom memory allocation function for this parent domain. Provider
+memory allocations will use this function to allocate the needed memory.
+The allocation function is passed the parent domain
+.B pd
+and the user-specified context
+.B pd_context.
+In addition, the callback receives the
+.B size
+and the
+.B alignment
+of the requested buffer, as well a vendor-specific
+.B resource_type
+, which is derived from the rdma_driver_id enum (upper 32 bits) and a vendor
+specific resource code.
+The function returns the pointer to the allocated buffer, or NULL to
+designate an error.  It may also return
+.B IBV_ALLOCATOR_USE_DEFAULT
+asking the callee to allocate the buffer using the default allocator.
+
+The callback makes sure the allocated buffer is initialized with zeros. It is
+also the responsibility of the callback to make sure the memory cannot be
+COWed, e.g. by using madvise(MADV_DONTFORK) or by allocating anonymous shared
+memory.
+.PP
+.B free
+Callback to free memory buffers that were allocated using a successful
+alloc().
+.PP
+.B pd_context
+A pointer for additional user-specific data to be associated with this
+parent domain. The pointer is passed back to the custom allocator functions.
 .SH "RETURN VALUE"
 .B ibv_alloc_parent_domain()
 returns a pointer to the allocated struct
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 12a33a9..d873f6d 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -1976,10 +1976,22 @@ struct ibv_cq_init_attr_ex {
 	uint32_t		flags;
 };
 
+enum ibv_parent_domain_init_attr_mask {
+	IBV_PARENT_DOMAIN_INIT_ATTR_ALLOCATORS = 1 << 0,
+	IBV_PARENT_DOMAIN_INIT_ATTR_PD_CONTEXT = 1 << 1,
+};
+
+#define IBV_ALLOCATOR_USE_DEFAULT ((void *)-1)
+
 struct ibv_parent_domain_init_attr {
 	struct ibv_pd *pd; /* referance to a protection domain object, can't be NULL */
 	struct ibv_td *td; /* referance to a thread domain object, or NULL */
 	uint32_t comp_mask;
+	void *(*alloc)(struct ibv_pd *pd, void *pd_context, size_t size,
+		       size_t alignment, uint64_t resource_type);
+	void (*free)(struct ibv_pd *pd, void *pd_context, void *ptr,
+		     uint64_t resource_type);
+	void *pd_context;
 };
 
 struct ibv_counters_init_attr {
-- 
1.8.3.1

