Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC427082D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRV0C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRV0C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:26:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B72C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:01 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o6so6723301ota.2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYUqPwrdKio6Ftu5fSfnu1rqoGPHxbhaUHOnWSih834=;
        b=jBHfFz4B7YGbH7tyE7x+Bbnwa2GVmaaqcJxp1+uRenxQ1WWwQb2szzIsMzEX2p55Hl
         mBAvPkccWVgHCwrmgVO8IEi7nl9r8ArepVt6F6FMv4IvbrJMdy868l7of2WvZkpGiG0y
         LTuU3V+829r2fGlnvEHdRfXynu5qngRifpYMEP+N3+SawfYA5m5f5xbsxS2VDk/paEGB
         thckBmbFBEVwFf3CVDvToNIo5Q3deItyYPkQkHodPoldFnw81PUVIG90YF8MdT0plHQJ
         UB54ZN2WqqLxjqp1TIJHRN/KcSdmOnx1nE+MIG5vt0SWqpIV59Ela5U9iVKllpVm1nGl
         Jnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYUqPwrdKio6Ftu5fSfnu1rqoGPHxbhaUHOnWSih834=;
        b=TdCSQynpNNrLnDQTTsVkbSfzkSoTUQgXs3PknGttjKlCe9k5garsFE9kJBebdWK9+x
         iRTbuuMfvxaEfKfUIhOJHw+6+XCU6U1GeamknNb0ccPQscgH9VxItH/XTIm5bxlaBEOQ
         eqsf3nGURJrGEJQAPt03XO0ULimKHTD9n0jLwsH7atfwjM//4ULq7UEai6BAxxM26MPB
         H4G/bSfKYTMue4zGf69V+REG2OepJOESt+vH2Ci8R02YWIdYA4u1sKVEgGfWZn3iz+h3
         Pi7biEDNwvE5nLXAbgs+bMLqTJzOKoKS8UjUJiYq6BmGJEQl6rgi3beQ3lsYsMlZ8mNp
         /BCQ==
X-Gm-Message-State: AOAM530oh0ZXMPcbxThS8WtcjDWwl48BA2a1OLJn8FOiTCovq+YzgYgt
        6SqhbpWAkZwA4UQgLdgEaHA=
X-Google-Smtp-Source: ABdhPJyI5ZQQKChM5rfdCXOIVOvtzfXqzxsm/fev7ZWWTQ8tDitEBBdFqy10cEoijJ095PfoX8Hkgg==
X-Received: by 2002:a9d:70cb:: with SMTP id w11mr23734171otj.222.1600464361385;
        Fri, 18 Sep 2020 14:26:01 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id p20sm4286174ook.27.2020.09.18.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:26:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 2/4] rxe: add extended query device verb
Date:   Fri, 18 Sep 2020 16:25:55 -0500
Message-Id: <20200918212557.5446-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918212557.5446-1-rpearson@hpe.com>
References: <20200918212557.5446-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added ibv_query_device_ex verb.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 providers/rxe/CMakeLists.txt |   1 +
 providers/rxe/rxe.c          |  62 +--------------
 providers/rxe/rxe.h          |  12 +++
 providers/rxe/rxe_dev.c      | 146 +++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 61 deletions(-)
 create mode 100644 providers/rxe/rxe_dev.c

diff --git a/providers/rxe/CMakeLists.txt b/providers/rxe/CMakeLists.txt
index ec4f005d..96052555 100644
--- a/providers/rxe/CMakeLists.txt
+++ b/providers/rxe/CMakeLists.txt
@@ -1,5 +1,6 @@
 rdma_provider(rxe
   rxe.c
+  rxe_dev.c
   rxe_sq.c
   rxe_mw.c
   )
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index ff4285f2..79863985 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -64,67 +64,6 @@ static const struct verbs_match_ent hca_table[] = {
 	{},
 };
 
-static int rxe_query_device(struct ibv_context *context,
-			    struct ibv_device_attr *attr)
-{
-	struct ibv_query_device cmd;
-	uint64_t raw_fw_ver;
-	unsigned int major, minor, sub_minor;
-	int ret;
-
-	ret = ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof(cmd));
-	if (ret)
-		return ret;
-
-	major = (raw_fw_ver >> 32) & 0xffff;
-	minor = (raw_fw_ver >> 16) & 0xffff;
-	sub_minor = raw_fw_ver & 0xffff;
-
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
-		 "%d.%d.%d", major, minor, sub_minor);
-
-	return 0;
-}
-
-static int rxe_query_port(struct ibv_context *context, uint8_t port,
-			  struct ibv_port_attr *attr)
-{
-	struct ibv_query_port cmd;
-
-	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof(cmd));
-}
-
-static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
-{
-	struct ibv_alloc_pd cmd;
-	struct ib_uverbs_alloc_pd_resp resp;
-	struct ibv_pd *pd;
-
-	pd = malloc(sizeof(*pd));
-	if (!pd)
-		return NULL;
-
-	if (ibv_cmd_alloc_pd(context, pd, &cmd, sizeof(cmd), &resp,
-				sizeof(resp))) {
-		free(pd);
-		return NULL;
-	}
-
-	return pd;
-}
-
-static int rxe_dealloc_pd(struct ibv_pd *pd)
-{
-	int ret;
-
-	ret = ibv_cmd_dealloc_pd(pd);
-	if (!ret)
-		free(pd);
-
-	return ret;
-}
-
 static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 				 uint64_t hca_va, int access)
 {
@@ -652,6 +591,7 @@ static int rxe_destroy_ah(struct ibv_ah *ibah)
 
 static const struct verbs_context_ops rxe_ctx_ops = {
 	.query_device = rxe_query_device,
+	.query_device_ex = rxe_query_device_ex,
 	.query_port = rxe_query_port,
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 6dfca0ab..11f337ee 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -155,6 +155,18 @@ static inline struct rxe_mw *to_rmw(struct ibv_mw *ibmw)
 	return to_rxxx(mw, mw);
 }
 
+/* rxe_dev.c */
+int rxe_query_device(struct ibv_context *context,
+		     struct ibv_device_attr *attr);
+int rxe_query_device_ex(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr,
+			size_t attr_size);
+int rxe_query_port(struct ibv_context *context, uint8_t port,
+		   struct ibv_port_attr *attr);
+struct ibv_pd *rxe_alloc_pd(struct ibv_context *context);
+int rxe_dealloc_pd(struct ibv_pd *pd);
+
 /* rxe_mw.c */
 struct ibv_mw *rxe_alloc_mw(struct ibv_pd *pd, enum ibv_mw_type type);
 int rxe_dealloc_mw(struct ibv_mw *mw);
diff --git a/providers/rxe/rxe_dev.c b/providers/rxe/rxe_dev.c
new file mode 100644
index 00000000..2156bebf
--- /dev/null
+++ b/providers/rxe/rxe_dev.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ * Copyright (c) 2009 Mellanox Technologies Ltd. All rights reserved.
+ * Copyright (c) 2009 System Fabric Works, Inc. All rights reserved.
+ * Copyright (C) 2006-2007 QLogic Corporation, All rights reserved.
+ * Copyright (c) 2005. PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *	- Redistributions of source code must retain the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer.
+ *
+ *	- Redistributions in binary form must reproduce the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer in the documentation and/or other materials
+ *	  provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <config.h>
+
+#include <endian.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <errno.h>
+
+#include <endian.h>
+#include <pthread.h>
+#include <stddef.h>
+
+#include <infiniband/driver.h>
+#include <infiniband/verbs.h>
+
+#include "rxe_queue.h"
+#include "rxe-abi.h"
+#include "rxe.h"
+
+int rxe_query_device(struct ibv_context *context,
+		     struct ibv_device_attr *attr)
+{
+	struct ibv_query_device cmd;
+	uint64_t raw_fw_ver;
+	unsigned int major, minor, sub_minor;
+	int ret;
+
+	ret = ibv_cmd_query_device(context, attr, &raw_fw_ver,
+				   &cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	major = (raw_fw_ver >> 32) & 0xffff;
+	minor = (raw_fw_ver >> 16) & 0xffff;
+	sub_minor = raw_fw_ver & 0xffff;
+
+	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
+		 "%d.%d.%d", major, minor, sub_minor);
+
+	return 0;
+}
+
+int rxe_query_device_ex(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr,
+			size_t attr_size)
+{
+	int ret;
+	uint64_t raw_fw_ver;
+	unsigned int major, minor, sub_minor;
+	struct ibv_query_device_ex cmd = {};
+	struct ib_uverbs_ex_query_device_resp resp = {};
+
+	ret = ibv_cmd_query_device_ex(context, input, attr, sizeof(*attr),
+				      &raw_fw_ver, &cmd, sizeof(cmd),
+				      &resp, sizeof(resp));
+	if (ret)
+		return ret;
+
+	major = (raw_fw_ver >> 32) & 0xffff;
+	minor = (raw_fw_ver >> 16) & 0xffff;
+	sub_minor = raw_fw_ver & 0xffff;
+
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
+		 "%d.%d.%d", major, minor, sub_minor);
+
+	return 0;
+}
+
+int rxe_query_port(struct ibv_context *context, uint8_t port,
+		   struct ibv_port_attr *attr)
+{
+	struct ibv_query_port cmd;
+
+	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof(cmd));
+}
+
+struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
+{
+	struct ibv_alloc_pd cmd;
+	struct ib_uverbs_alloc_pd_resp resp;
+	struct ibv_pd *pd;
+
+	pd = malloc(sizeof(*pd));
+	if (!pd)
+		return NULL;
+
+	if (ibv_cmd_alloc_pd(context, pd, &cmd, sizeof(cmd), &resp,
+				sizeof(resp))) {
+		free(pd);
+		return NULL;
+	}
+
+	return pd;
+}
+
+int rxe_dealloc_pd(struct ibv_pd *pd)
+{
+	int ret;
+
+	ret = ibv_cmd_dealloc_pd(pd);
+	if (!ret)
+		free(pd);
+
+	return ret;
+}
-- 
2.25.1

