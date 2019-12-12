Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7366E11C96D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfLLJi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfLLJiu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:38:50 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADC72467A;
        Thu, 12 Dec 2019 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143530;
        bh=isWG08aPpLtMetL3wpIGsC/lLXgv4w1eyMK8B++ELhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToJSHS8MuqhIivxjEActRn05XclbQYUpRNyOi3RsnyUYdJ/hx3DuCXeNqhwBgq56I
         PvD8Y8h5iviLJQmDN+3OU0ROdfjqZBBvoigvAPeYZgZu/PCXOeS90kJF36sHWSgoQK
         QvewiKOOA7C5ljRphvuTkh8F6473SKsmNxAfxESI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 04/48] RDMA/cm: Add SET/GET implementations to hide IBA wire format
Date:   Thu, 12 Dec 2019 11:37:46 +0200
Message-Id: <20191212093830.316934-5-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no separation between RDMA-CM wire format as it is declared in
IBTA and kernel logic which implements needed support. Such situation
causes to many mistakes in conversion between big-endian (wire format)
and CPU format used by kernel. It also mixes RDMA core code with
combination of uXX and beXX variables.

The idea that all accesses to IBA definitions will go through special
GET/SET macros to ensure that no conversion mistakes are done.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm_msgs.h |   6 +-
 include/rdma/iba.h                | 138 ++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 5 deletions(-)
 create mode 100644 include/rdma/iba.h

diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 92d7260ac913..9bc468833831 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -8,14 +8,10 @@
 #ifndef CM_MSGS_H
 #define CM_MSGS_H
 
+#include <rdma/iba.h>
 #include <rdma/ib_mad.h>
 #include <rdma/ib_cm.h>
 
-/*
- * Parameters to routines below should be in network-byte order, and values
- * are returned in network-byte order.
- */
-
 #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
 
 struct cm_req_msg {
diff --git a/include/rdma/iba.h b/include/rdma/iba.h
new file mode 100644
index 000000000000..a77cc89f9f3f
--- /dev/null
+++ b/include/rdma/iba.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2019, Mellanox Technologies inc.  All rights reserved.
+ */
+#ifndef _IBA_DEFS_H_
+#define _IBA_DEFS_H_
+
+#include <linux/kernel.h>
+#include <linux/bitfield.h>
+#include <asm/unaligned.h>
+
+static inline u32 _iba_get8(const u8 *ptr)
+{
+	return *ptr;
+}
+
+static inline void _iba_set8(u8 *ptr, u32 mask, u32 prep_value)
+{
+	*ptr = (*ptr & ~mask) | prep_value;
+}
+
+static inline u16 _iba_get16(const __be16 *ptr)
+{
+	return be16_to_cpu(*ptr);
+}
+
+static inline void _iba_set16(__be16 *ptr, u16 mask, u16 prep_value)
+{
+	*ptr = cpu_to_be16((be16_to_cpu(*ptr) & ~mask) | prep_value);
+}
+
+static inline u32 _iba_get32(const __be32 *ptr)
+{
+	return be32_to_cpu(*ptr);
+}
+
+static inline void _iba_set32(__be32 *ptr, u32 mask, u32 prep_value)
+{
+	*ptr = cpu_to_be32((be32_to_cpu(*ptr) & ~mask) | prep_value);
+}
+
+static inline u64 _iba_get64(const __be64 *ptr)
+{
+	/*
+	 * The mads are constructed so that 32 bit and smaller are naturally
+	 * aligned, everything larger has a max alignment of 4 bytes.
+	 */
+	return be64_to_cpu(get_unaligned(ptr));
+}
+
+static inline void _iba_set64(__be64 *ptr, u64 mask, u64 prep_value)
+{
+	put_unaligned(cpu_to_be64((_iba_get64(ptr) & ~mask) | prep_value), ptr);
+}
+
+#define _IBA_SET(field_struct, field_offset, field_mask, mask_width, ptr,      \
+		 value)                                                        \
+	({                                                                     \
+		field_struct *_ptr = ptr;                                      \
+		_iba_set##mask_width((void *)_ptr + (field_offset),            \
+				     field_mask,                               \
+				     FIELD_PREP(field_mask, value));           \
+	})
+#define IBA_SET(field, ptr, value) _IBA_SET(field, ptr, value)
+
+#define _IBA_SET_MEM(field_struct, field_offset, byte_size, ptr, in, bytes)    \
+	({                                                                     \
+		WARN_ON(bytes > byte_size);                                    \
+		if (in && bytes) {                                             \
+			field_struct *_ptr = ptr;                              \
+			memcpy((void *)_ptr + (field_offset), in, bytes);      \
+		}                                                              \
+	})
+#define IBA_SET_MEM(field, ptr, in, bytes) _IBA_SET_MEM(field, ptr, in, bytes)
+
+#define _IBA_GET(field_struct, field_offset, field_mask, mask_width, ptr)      \
+	({                                                                     \
+		const field_struct *_ptr = ptr;                                \
+		(u##mask_width) FIELD_GET(                                     \
+			field_mask, _iba_get##mask_width((const void *)_ptr +  \
+							 (field_offset)));     \
+	})
+#define IBA_GET(field, ptr) _IBA_GET(field, ptr)
+
+#define _IBA_GET_MEM(field_struct, field_offset, byte_size, ptr, out, bytes)   \
+	({                                                                     \
+		WARN_ON(bytes > byte_size);                                    \
+		if (out && bytes) {                                            \
+			const field_struct *_ptr = ptr;                        \
+			memcpy(out, (void *)_ptr + (field_offset), bytes);     \
+		}                                                              \
+	})
+#define IBA_GET_MEM(field, ptr, out, bytes) _IBA_GET_MEM(field, ptr, out, bytes)
+
+/*
+ * The generated list becomes the parameters to the macros, the order is:
+ *  - struct this applies to
+ *  - starting offset of the max
+ *  - GENMASK or GENMASK_ULL in CPU order
+ *  - The width of data the mask operations should work on, in bits
+ */
+
+/*
+ * Extraction using a tabular description like table 106. bit_offset is from
+ * the Byte[Bit] notation.
+ */
+#define IBA_FIELD_BLOC(field_struct, byte_offset, bit_offset, num_bits)        \
+	field_struct, byte_offset,                                             \
+		GENMASK(7 - (bit_offset), 7 - (bit_offset) - (num_bits - 1)),  \
+		8
+#define IBA_FIELD8_LOC(field_struct, byte_offset, num_bits)                    \
+	IBA_FIELD_BLOC(field_struct, byte_offset, 0, num_bits)
+
+#define IBA_FIELD16_LOC(field_struct, byte_offset, num_bits)                   \
+	field_struct, (byte_offset)&0xFFFE,                                    \
+		GENMASK(15 - (((byte_offset) % 2) * 8),                        \
+			15 - (((byte_offset) % 2) * 8) - (num_bits - 1)),      \
+		16
+
+#define IBA_FIELD32_LOC(field_struct, byte_offset, num_bits)                   \
+	field_struct, (byte_offset)&0xFFFC,                                    \
+		GENMASK(31 - (((byte_offset) % 4) * 8),                        \
+			31 - (((byte_offset) % 4) * 8) - (num_bits - 1)),      \
+		32
+
+#define IBA_FIELD64_LOC(field_struct, byte_offset, num_bits)                   \
+	field_struct, (byte_offset)&0xFFF8,                                    \
+		GENMASK_ULL(63 - (((byte_offset) % 8) * 8),                    \
+			    63 - (((byte_offset) % 8) * 8) - (num_bits - 1)),  \
+		64
+/*
+ * In IBTA spec, everything that is more than 64bits is multiple
+ * of bytes without leftover bits.
+ */
+#define IBA_FIELD_MLOC(field_struct, byte_offset, num_bits)                    \
+	field_struct, (byte_offset)&0xFFFC, (num_bits / 8)
+
+#endif /* _IBA_DEFS_H_ */
-- 
2.20.1

