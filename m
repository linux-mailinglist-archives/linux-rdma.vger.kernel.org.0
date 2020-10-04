Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF625282B8B
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJDPnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 11:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgJDPnv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 11:43:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAEC020759;
        Sun,  4 Oct 2020 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601826230;
        bh=FgRdIP4AGV94fdzUhyA3YXoVe8TraD2dOsq6sGTJh2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ8hgBuh1xxUHMOD11A4e2hakbRV0tE72jn2cHRi3icqLat5Ys3HlOrPjmixcoOEq
         mq5Ob6H4lWnI5lxDC0bM67rCmxNWMSPu/a7DZuccowuanBuZxD8v7UFLoOR2/Iknob
         aYPslalVAjRUhO6tfBWeNvS19MZMYHK7m+Dlp6C0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: [PATCH rdma-next v5 2/4] tools/testing/scatterlist: Rejuvenate bit-rotten test
Date:   Sun,  4 Oct 2020 18:43:38 +0300
Message-Id: <20201004154340.1080481-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004154340.1080481-1-leon@kernel.org>
References: <20201004154340.1080481-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

A couple small tweaks are needed to make the test build and run
on current kernels.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 tools/testing/scatterlist/Makefile   |  3 ++-
 tools/testing/scatterlist/linux/mm.h | 35 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/scatterlist/Makefile b/tools/testing/scatterlist/Makefile
index cbb003d9305e..c65233876622 100644
--- a/tools/testing/scatterlist/Makefile
+++ b/tools/testing/scatterlist/Makefile
@@ -14,7 +14,7 @@ targets: include $(TARGETS)
 main: $(OFILES)

 clean:
-	$(RM) $(TARGETS) $(OFILES) scatterlist.c linux/scatterlist.h linux/highmem.h linux/kmemleak.h asm/io.h
+	$(RM) $(TARGETS) $(OFILES) scatterlist.c linux/scatterlist.h linux/highmem.h linux/kmemleak.h linux/slab.h asm/io.h
 	@rmdir asm

 scatterlist.c: ../../../lib/scatterlist.c
@@ -28,4 +28,5 @@ include: ../../../include/linux/scatterlist.h
 	@touch asm/io.h
 	@touch linux/highmem.h
 	@touch linux/kmemleak.h
+	@touch linux/slab.h
 	@cp $< linux/scatterlist.h
diff --git a/tools/testing/scatterlist/linux/mm.h b/tools/testing/scatterlist/linux/mm.h
index 6f9ac14aa800..6ae907f375d2 100644
--- a/tools/testing/scatterlist/linux/mm.h
+++ b/tools/testing/scatterlist/linux/mm.h
@@ -114,6 +114,12 @@ static inline void *kmalloc(unsigned int size, unsigned int flags)
 	return malloc(size);
 }

+static inline void *
+kmalloc_array(unsigned int n, unsigned int size, unsigned int flags)
+{
+	return malloc(n * size);
+}
+
 #define kfree(x) free(x)

 #define kmemleak_alloc(a, b, c, d)
@@ -122,4 +128,33 @@ static inline void *kmalloc(unsigned int size, unsigned int flags)
 #define PageSlab(p) (0)
 #define flush_kernel_dcache_page(p)

+#define MAX_ERRNO	4095
+
+#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
+
+static inline void * __must_check ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
+static inline long __must_check PTR_ERR(__force const void *ptr)
+{
+	return (long) ptr;
+}
+
+static inline bool __must_check IS_ERR(__force const void *ptr)
+{
+	return IS_ERR_VALUE((unsigned long)ptr);
+}
+
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
+
+#define IS_ENABLED(x) (0)
+
 #endif
--
2.26.2

