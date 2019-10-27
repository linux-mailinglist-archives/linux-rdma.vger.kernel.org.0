Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8CE6135
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfJ0HGc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:31 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA6520873;
        Sun, 27 Oct 2019 07:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572159990;
        bh=ZkQdcjHISlEsZvIGOb80bDzrj0KNBpAgi9QOisOom54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZTJC7IO15MRFPAiFLzE+6awK1JWFIC5SBTKrO435qz9PxPWiNSk4Bd3SRWuofLKC
         EODq50EXiLDHdBuv3jXHqJl5gmf9WQJ8Wnq1xIMzF0ZKWE25hUkQwoj33021hl30+i
         OsUSJTme4NqD6+xzXcGAY9lEd/InJqhYzC9GJzFg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 01/43] RDMA/cm: Add naive SET/GET implementations to hide CM wire format
Date:   Sun, 27 Oct 2019 09:05:39 +0200
Message-Id: <20191027070621.11711-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027070621.11711-1-leon@kernel.org>
References: <20191027070621.11711-1-leon@kernel.org>
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

The idea that every converted variable will have two fields which
describes the byte offset and mask for the access, e.g.

 #define CM_REP_LOCAL_QPN_OFFSET 12
 #define CM_REP_LOCAL_QPN_MASK GENMASK(23, 0)

Such format will allow us to use same GET/SET macros for all
be16/be32 variables and bitfields too.

Separate wire protocol from kernel logic by special GET/SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm_msgs.h | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 92d7260ac913..99e35a4610f1 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -8,6 +8,7 @@
 #ifndef CM_MSGS_H
 #define CM_MSGS_H
 
+#include <linux/bitfield.h>
 #include <rdma/ib_mad.h>
 #include <rdma/ib_cm.h>
 
@@ -17,6 +18,76 @@
  */
 
 #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
+#define _CM_SET(p, offset, mask, value)                                        \
+	({                                                                     \
+		void *field = (u8 *)p + sizeof(struct ib_mad_hdr) + offset;    \
+		u8 bytes =                                                     \
+			DIV_ROUND_UP(__builtin_popcount(mask), BITS_PER_BYTE); \
+		switch (bytes) {                                               \
+		case 1: {                                                      \
+			*(u8 *)field &= ~mask;                                 \
+			*(u8 *)field |= FIELD_PREP(mask, value);               \
+		} break;                                                       \
+		case 2: {                                                      \
+			u16 val = ntohs(*(__be16 *)field) & ~mask;             \
+			val |= FIELD_PREP(mask, value);                        \
+			*(__be16 *)field = htons(val);                         \
+		} break;                                                       \
+		case 3: {                                                      \
+			u32 val = ntohl(*(__be32 *)field) & ~(mask << 8);      \
+			val |= FIELD_PREP(mask, value) << 8;                   \
+			*(__be32 *)field = htonl(val);                         \
+		} break;                                                       \
+		default: {                                                     \
+			u32 val = ntohl(*(__be32 *)field) & ~mask;             \
+			val |= FIELD_PREP(mask, value);                        \
+			*(__be32 *)field = htonl(val);                         \
+		} break;                                                       \
+		}                                                              \
+	})
+#define CM_SET(field, p, value)                                                \
+	_CM_SET(p, CM_##field##_OFFSET, CM_##field##_MASK, value)
+#define CM_SET64(field, p, value)                                              \
+	({                                                                     \
+		_CM_SET(p, CM_##field##_OFFSET,                                \
+			lower_32_bits(CM_##field##_MASK),                      \
+			lower_32_bits(value));                                 \
+		_CM_SET(p, CM_##field##_OFFSET + sizeof(__be32),               \
+			upper_32_bits(CM_##field##_MASK),                      \
+			upper_32_bits(value));                                 \
+	})
+
+#define _CM_GET(p, offset, mask)                                               \
+	({                                                                     \
+		void *field = (u8 *)p + sizeof(struct ib_mad_hdr) + offset;    \
+		u8 bytes =                                                     \
+			DIV_ROUND_UP(__builtin_popcount(mask), BITS_PER_BYTE); \
+		u32 ret;                                                       \
+		switch (bytes) {                                               \
+		case 1:                                                        \
+			ret = FIELD_GET(mask, *(u8 *)field);                   \
+			break;                                                 \
+		case 2:                                                        \
+			ret = FIELD_GET(mask, ntohs(*(__be16 *)field));        \
+			break;                                                 \
+		case 3:                                                        \
+			ret = FIELD_GET(mask, ntohl(*(__be32 *)field) >> 8);   \
+			break;                                                 \
+		default:                                                       \
+			ret = FIELD_GET(mask, ntohl(*(__be32 *)field));        \
+		}                                                              \
+		ret;                                                           \
+	})
+
+#define CM_GET(field, p) _CM_GET(p, CM_##field##_OFFSET, CM_##field##_MASK)
+#define CM_GET64(field, p)                                                     \
+	({                                                                     \
+		u64 a = _CM_GET(p, CM_##field##_OFFSET,                        \
+				lower_32_bits(CM_##field##_MASK));             \
+		u64 b = _CM_GET(p, CM_##field##_OFFSET + sizeof(__be32),       \
+				upper_32_bits(CM_##field##_MASK));             \
+		a | (b << 32);                                                 \
+	})
 
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
-- 
2.20.1

