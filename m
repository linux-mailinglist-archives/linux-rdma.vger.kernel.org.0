Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6994200F3
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Oct 2021 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhJCJJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Oct 2021 05:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhJCJJ4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 3 Oct 2021 05:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DCEF61B3E;
        Sun,  3 Oct 2021 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633252089;
        bh=6pWomhfOVahVZykDCvLCYpB4y+neaQ61MPumOZ0Coto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fial3gyhd0UyvBLkkezOJEHLMLCxz9nxiRFA0+PHBWN9cSsqVrHD9mtm/5tuPOGT1
         ZQiMGHHHgszzi88Z+CJ/MGC4kPFGsOhpdxs/L//NDW30YTbn9P7uQFEc0HQXloUii9
         IjzQxXvaQSXYzGqhFuBCqj+RZvO1vh1pBaTIPIM7vvqhk6GsRYHBRLrSXPbTp9c7jc
         aFBtUfwz75Qqf3Qy1qZZd1eCH6wwB6JSdj1hymPhkv2DfZLBr+aFj5kG5n2B5RBQdl
         IQf9/aJfKRtwHfOCZj6UgyRSaDkbTCgLzCh3VqFlK2U3DQ4IKlUVpNNiJw9dwzvj+K
         anSrML0NFY1CA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jgg@ziepe.ca, airlied@gmail.com
Cc:     christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, dledford@redhat.com,
        alexander.deucher@amd.com, leonro@nvidia.com, hch@lst.de,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH v7 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Date:   Sun,  3 Oct 2021 12:07:55 +0300
Message-Id: <20211003090756.117809-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211003090756.117809-1-ogabbay@kernel.org>
References: <20211003090756.117809-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User process might want to share the device memory with another
driver/device, and to allow it to access it over PCIe (P2P).

To enable this, we utilize the dma-buf mechanism and add a dma-buf
exporter support, so the other driver can import the device memory and
access it.

The device memory is allocated using our existing allocation uAPI,
where the user will get a handle that represents the allocation.

The user will then need to call the new
uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.

The driver will return a FD that represents the DMA-BUF object that
was created to match that allocation.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
Changes in v7:
 - Change the type of the fd variable returned from IOCTL to be __s32

 include/uapi/misc/habanalabs.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ccfcb4d188fc..f980fbfb1a0e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -959,6 +959,10 @@ union hl_wait_cs_args {
 #define HL_MEM_OP_UNMAP			3
 /* Opcode to map a hw block */
 #define HL_MEM_OP_MAP_BLOCK		4
+/* Opcode to create DMA-BUF object for an existing device memory allocation
+ * and to export an FD of that DMA-BUF back to the caller
+ */
+#define HL_MEM_OP_EXPORT_DMABUF_FD	5
 
 /* Memory flags */
 #define HL_MEM_CONTIGUOUS	0x1
@@ -1030,11 +1034,26 @@ struct hl_mem_in {
 			/* Virtual address returned from HL_MEM_OP_MAP */
 			__u64 device_virt_addr;
 		} unmap;
+
+		/* HL_MEM_OP_EXPORT_DMABUF_FD */
+		struct {
+			/* Handle returned from HL_MEM_OP_ALLOC. In Gaudi,
+			 * where we don't have MMU for the device memory, the
+			 * driver expects a physical address (instead of
+			 * a handle) in the device memory space.
+			 */
+			__u64 handle;
+			/* Size of memory allocation. Relevant only for GAUDI */
+			__u64 mem_size;
+		} export_dmabuf_fd;
 	};
 
 	/* HL_MEM_OP_* */
 	__u32 op;
-	/* HL_MEM_* flags */
+	/* HL_MEM_* flags.
+	 * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
+	 * DMA-BUF file/FD flags.
+	 */
 	__u32 flags;
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
@@ -1071,6 +1090,13 @@ struct hl_mem_out {
 
 			__u32 pad;
 		};
+
+		/* Returned in HL_MEM_OP_EXPORT_DMABUF_FD. Represents the
+		 * DMA-BUF object that was created to describe a memory
+		 * allocation on the device's memory space. The FD should be
+		 * passed to the importer driver
+		 */
+		__s32 fd;
 	};
 };
 
-- 
2.17.1

