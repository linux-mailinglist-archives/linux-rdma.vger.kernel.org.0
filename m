Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE4245306
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgHOV51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgHOVwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:06 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C0C0612A2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so9261265oth.5
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFiXWVNDlXpo9SVgxkQ2DmbUogJKMp46f6P28S9Kqw0=;
        b=vHVhJQKFdbP5GGzx3LI4g7rY7xmBJgI95BmOOfHExHNhIcgUZjriDSVcVWAt/XTxcP
         Adq+hSRsdgukqek0kGdXJy0GEtWV8BO+WGSlzKMp2Gtzqu9e8qlYvo/4kFtc6kiFmfXW
         q9idA7HzkkNBrzUCWTZeJoHnThesXVQt3fAR+nK+iowlPd6MOJB9Dawxul47OdT3wMnh
         yWlx5Ou54k1DY2GjqjSvZI7acBKbLvDlxy4r2q95m13KKWO/nQB243Cod6dzlkZ1f0dC
         UJzLqxcPdysQb1CO962+OYJrQ54CtgMKvUNA7oJhn9DfbuAnOAKKJiuZi7ed0zxqmlnb
         /VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFiXWVNDlXpo9SVgxkQ2DmbUogJKMp46f6P28S9Kqw0=;
        b=fxmFGwnlwp6Qv+qmxkjnP4nFDlntaeo2KtruzsNmkqiF/l8AXIUffh2LDaFqBUPPMM
         tPY6pXc7OI8Mqp3GU4wRVxxW15FbQvE9Dz1RqvpTQ4PwkhAO+2oZkhcq/97ole1IMjYB
         ix+EIZbPVpNnUE+BWfCNLrnDg+gM0GJBotGuwPshATk1KSdrPvVKkAp2jgtMDQO/dthg
         AJSLENoVVoVzcRMpVLQdEk0tD2TRtsYc6pOS8pwF3IReJ5LdBxFeyX/uozvLxpJ53wnO
         rTctUJhvoxda71ebv3N6ieg8/O5VZzQhMHfBraujUc8fo8/eWZZ0uDNhZ3LYKwz9FxAX
         rvKg==
X-Gm-Message-State: AOAM5301BCiY/Y80hFsxPGueZRg2IJINKsWb97XAdpE7IBYi+iQGkpQ4
        kwZEHvMTqJn9zSOBqeBUT61E/vvqrPwt4w==
X-Google-Smtp-Source: ABdhPJwG1Ivp2YLVZs8xksuNA8e39C0GxYidiEQlPH++mUnbrpnq+noCoauN+QreyXq80nFRzQe9vQ==
X-Received: by 2002:a9d:7f8e:: with SMTP id t14mr4390772otp.63.1597467592379;
        Fri, 14 Aug 2020 21:59:52 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id y15sm2089439oto.60.2020.08.14.21.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 04/20] Added stubs for alloc_mw and dealloc_mw verbs.
Date:   Fri, 14 Aug 2020 23:58:28 -0500
Message-Id: <20200815045912.8626-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added a new file focused on memory windows, rxe_mw.c and adds stubbed
out kernel verbs API for alloc_mw and dealloc_mw. These functios are added
to the context ops struct and bits added to the supported APIs mask.

These APIs allow progress on the rdma-core user space testing.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/Makefile    |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  5 +++
 drivers/infiniband/sw/rxe/rxe_mw.c    | 49 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  4 +++
 4 files changed, 59 insertions(+)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 66af72dca759..1e24673e9318 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -15,6 +15,7 @@ rdma_rxe-y := \
 	rxe_qp.o \
 	rxe_cq.o \
 	rxe_mr.o \
+	rxe_mw.o \
 	rxe_opcode.o \
 	rxe_mmap.o \
 	rxe_icrc.o \
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 39dc3bfa5d5d..02f8ff4ed8f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -136,6 +136,11 @@ void rxe_mem_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
+/* rxe_mw.c */
+struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
+			   struct ib_udata *udata);
+int rxe_dealloc_mw(struct ib_mw *ibmw);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
new file mode 100644
index 000000000000..6139dc9d8dd8
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
+ * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
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
+#include "rxe.h"
+#include "rxe_loc.h"
+
+struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
+			   struct ib_udata *udata)
+{
+	pr_err_once("rxe_alloc_mw: not implemented\n");
+	return ERR_PTR(-ENOSYS);
+}
+
+int rxe_dealloc_mw(struct ib_mw *ibmw)
+{
+	pr_err_once("rxe_dealloc_mw: not implemented\n");
+	return -ENOSYS;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bb61e534e468..1dbc69b86859 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1128,6 +1128,8 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
+	.alloc_mw = rxe_alloc_mw,
+	.dealloc_mw = rxe_dealloc_mw,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
@@ -1189,6 +1191,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
+	    | BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW)
+	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
 	    ;
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
-- 
2.25.1

