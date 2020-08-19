Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5798C249385
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHSDmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHSDmP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:42:15 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D712C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:42:15 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g18so4618213ooa.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1U4NvlXpIgjpAkukbV23CnbRJK3/Kz1JeNtZIw1+Ro=;
        b=Dx7d3dTCPq9Hfl8Ar/sgGGGlN522YjgY127VecrSuvNqhdbut8HQX6/ZjZ60AJazMe
         tlnRXD3ZgF65hOmXqrHxod2tr9d/TppDSnyBsuZMI9tK5cEpeD4fiQShkHUozY/s/k/g
         KdpvlFXMki4cN+H1apc24fXz3xnkVxWjqayRxnG0zQjG4SxsOEVlJcY+LnyJmff3hVE/
         H8CQpUYu9yDw8rpbAx4L9mOZE8YHZn5MXxDKchzDYBob13bgnz9h1NTN/L8MgjF9l9Fs
         /J3YgNkT1wLCa897xj3vcr8Aa4ceyUEOkiC3HFYdhU3Gt9rbpMq/2ujpODOm1p76zbEb
         kIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1U4NvlXpIgjpAkukbV23CnbRJK3/Kz1JeNtZIw1+Ro=;
        b=IIW+bKAmimuKJxMxYvZ67BcqLn8LVxtm3mdeSeWukYZiyyLSRY9JpqEN6b2ZXzvSu6
         INPXP8VZLI1cTCaLdArbQZqyFWrcJJnh4KHPWG74fttUhSCGeMu7C25GQdW+K4mtQPAt
         KkcKMalbuBjS3S9LExzMHFZRIofGwv2or7cpvi+FQ5XEQT4zMHpNuHUFMkEJqiEXfRzv
         k486YCe79aj5rqzOYeDGouPuL5zT7sx+tcp94RNQyy4PiL39El4VMFn2PHhi0RLmxcBP
         jvc4i3LRgJ2A7CtXm8s/rRNasdAKAV+8kN0eNsKP2YO7xpaMr9mqkjYXEClxyzxR63bg
         +Kiw==
X-Gm-Message-State: AOAM5324s78nmi8LlDurvhdcpFnWKjGsUaoLVW9l+Ur4aCf0MY3ehZsM
        SzsoP6+eCDoh0T2OCfnwe0Y=
X-Google-Smtp-Source: ABdhPJxAuvajwONHq1uXmCTtb2vL01pqgFAcDdZFuIGFaA9+xEUKg2aiXReiO/vvZUU0+8CjC7XUnQ==
X-Received: by 2002:a4a:982e:: with SMTP id y43mr17074120ooi.64.1597808534083;
        Tue, 18 Aug 2020 20:42:14 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id f20sm4324066otq.80.2020.08.18.20.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:42:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 06/16] rdma_rxe: Added stubs for alloc_mw and dealloc_mw verbs
Date:   Tue, 18 Aug 2020 22:39:58 -0500
Message-Id: <20200819034002.8835-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
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
index 73e3253c7817..8ac0a1ad0daf 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -114,6 +114,11 @@ void rxe_mem_cleanup(struct rxe_pool_entry *arg);
 
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
index 0e6cf5aca4e8..b81163840048 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1130,6 +1130,8 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
+	.alloc_mw = rxe_alloc_mw,
+	.dealloc_mw = rxe_dealloc_mw,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
@@ -1191,6 +1193,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DESTROY_AH)
 	    | BIT_ULL(IB_USER_VERBS_CMD_ATTACH_MCAST)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DETACH_MCAST)
+	    | BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW)
+	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
 	    ;
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
-- 
2.25.1

