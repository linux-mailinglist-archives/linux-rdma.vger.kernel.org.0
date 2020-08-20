Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25E24C7EC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgHTWr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHTWrX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F6BC061388
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h22so132003otq.11
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ukgpbblYz7Y1bTcYeNcegeBSN5CRt6pKn1YDnVhuGA=;
        b=L58lgSLTPwFT8N7wgD9mpsTT01KJN9hcnsxYqBX0apMhfjFlYvdQUexZMyHhUcouoh
         eU8OsljWaL3QENM1FdJh4fbLiBI2UGnTKU1cDi4Ta0h8d76nWzTIDngTjtrhiuy+Lpi6
         NoykUzjmnR7yR2sNGYZfy89qiyGiEYRy8TRPsCGnHlLnnUWprvb3BS2D2+c2qNeAoK+Y
         GgVfIhmCO0LMRQGYzEAhXMLdNh93TPg2/A+wkI6jk2kt166x9zirj0hInGmRrUymmSiE
         3MHSojZ4UsbmxLnRsMvk5B6bof/ZUmX7UtanzPixhgYqLcYSdY9AweD/q8v63zgaQG0R
         xDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ukgpbblYz7Y1bTcYeNcegeBSN5CRt6pKn1YDnVhuGA=;
        b=hy2lJ0EkJ7U2h/CBOxCh3dkxX7AYJAG84Dqih3ssn6jL5TyLxUFz6YVZBmJMIJpqcu
         4ocdCWh9idb0hgaRDlil/GheYbw+oqBuyfVsc8HHxGC2ECMlGU1/2WhvyJDXMuTpXUsf
         y/cN0uStJ/Cukrc8+KEgLwz521cqfRtcJuuVTljAPRmFrQ/oBZXvwO7DUgGipi4NDUcs
         yj82jumIAqadvCqZxR+HVhAuzBwNmLcOpCQfh3c84ZB5+633xbrZBWQ+Csx3IbjT7eIW
         jay/fI1e/4ZsKYM+4OBKEaqYswkE17t7sHSFTYhT3Q1ABxsft89Yy9G2Be+mGyFTJoU/
         1OWA==
X-Gm-Message-State: AOAM5336/KpJ1NzhD7ItImQJn3H5PD6w7f+ceBscDfjK7ZEWV5k4K2mi
        KMumQ94YBonOIAgRFTQKtqbh60yr5ZgG0w==
X-Google-Smtp-Source: ABdhPJyYLfgaO3tjbRk3XcK/tQhYsG7WBsoY3I9paQ/aGzlUCHLpa7cb5rfHlsb+f/mUYkOlwyIwMQ==
X-Received: by 2002:a9d:2f23:: with SMTP id h32mr8461otb.334.1597963637776;
        Thu, 20 Aug 2020 15:47:17 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id w9sm684646oih.31.2020.08.20.15.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 06/17] rdma_rxe: Added stubs for alloc_mw and dealloc_mw verbs
Date:   Thu, 20 Aug 2020 17:46:27 -0500
Message-Id: <20200820224638.3212-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added a new file focused on memory windows, rxe_mw.c and adds stubbed
out kernel verbs API for alloc_mw and dealloc_mw. These functions are added
to the context ops struct and bits added to the supported APIs mask.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/Makefile    |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  5 +++++
 drivers/infiniband/sw/rxe/rxe_mw.c    | 22 ++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  4 ++++
 4 files changed, 32 insertions(+)
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
index 47d1730f43dd..9ab5f2c34def 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -111,6 +111,11 @@ void rxe_mem_cleanup(struct rxe_pool_entry *arg);
 
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
index 000000000000..f5df5e0b714f
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * linux/drivers/infiniband/sw/rxe/rxe_mw.c
+ *
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ */
+
+#include "rxe.h"
+#include "rxe_loc.h"
+
+struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
+			   struct ib_udata *udata)
+{
+	pr_err_once("%s: not implemented\n", __func__);
+	return ERR_PTR(-EINVAL);
+}
+
+int rxe_dealloc_mw(struct ib_mw *ibmw)
+{
+	pr_err_once("%s: not implemented\n", __func__);
+	return -EINVAL;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c2d09998b778..dcd8693f8ce6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1106,6 +1106,8 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
+	.alloc_mw = rxe_alloc_mw,
+	.dealloc_mw = rxe_dealloc_mw,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
@@ -1167,6 +1169,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
+	    | BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW)
+	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
 	    ;
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
-- 
2.25.1

