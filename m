Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD02D5981A9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiHRKwt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbiHRKws (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:52:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474B86701
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:52:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u14so1272521wrq.9
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HVX3yWws+1xdQlSaut4w1dl9Bi5bbjXS7bYxCt7JZmA=;
        b=hYbAD/DMPRoX/fKD4CXtR/AbSo81IhrBIwKfijYb3pO3o1Feudc0m0Sui5tnBg/5E/
         bJFhRkQGzfgLwWd4yHxtggwATAiedj+Q53xBL90Kw6WeQ2QOWKzsp+twBZwSrJIQvXxL
         NTfwcGaV2u1iwmCSXbCHCIkx5xjrkMSZxuR/R+kQSvzgsWzcRGAj+xBMfBJwTXxsD/BX
         rC6L4rXCg/iCI/O+UrUIxRW0MOhU2qLpD2FAR1whsMu2f3oJsrY1YGuRHOLpjMaj/Mcd
         1dp79Skmwev0z8yFg5Cja1OyFmdFgjRKEVEm5XByAmg1EatVkon9ns55IRwYv83FRk2U
         CLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HVX3yWws+1xdQlSaut4w1dl9Bi5bbjXS7bYxCt7JZmA=;
        b=amXTKwOjP79D5PA1b9pvK2WgqLwl8oQ3imsEwm1XLGZKtUyIFKt+hWKURFibTScysi
         ydrAEgZVLF6Aj4ZYhzS1diaOC0fZPC5Mjx94sKrdOZDN053+LPpEZGNiLlF/cK6jNP+X
         S+Rp10nK4wYkjS+02bhAbBieLEPrIxOaQaVrjT0BG0UHMxzR3L4eEUUecp6vfIeSXEPS
         Tn98S6qOSmi948/afEACzpJR2GGJuuTSiNtyrhzQ+KaIPwZa+dP99VyNwjkDEeN4TulP
         kr94eORWuL5aXdd78LgSLwnGtlFH7zMo9MmQ3dlaPncURtPwldZmWqCd36U1rn6/zZpx
         sT/Q==
X-Gm-Message-State: ACgBeo1+lOdtqpHWA4UIRstdc24uUE2ajkUKVcvOu6oZ4YiuWUpeuFXV
        W7X7mu2XDSk/kNa/WOT3rf4s5IUfJeW0+g==
X-Google-Smtp-Source: AA6agR6oDtPpRVM6JfAXPKERi8YtxEsXLYnO1UZpI7D3Wdq3PIIyxLgCXaYgD5t8RPnEJblvEdoI9Q==
X-Received: by 2002:adf:e101:0:b0:225:a31:854b with SMTP id t1-20020adfe101000000b002250a31854bmr1246828wrz.143.1660819965305;
        Thu, 18 Aug 2022 03:52:45 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm6233583wmg.5.2022.08.18.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:52:44 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Santosh Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH for-next 2/2] RDMA/rtrs-srv: Add event tracing support
Date:   Thu, 18 Aug 2022 12:52:40 +0200
Message-Id: <20220818105240.110234-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105240.110234-1-haris.iqbal@ionos.com>
References: <20220818105240.110234-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Santosh Pradhan <santosh.pradhan@ionos.com>

Add event tracing mechanism for following routines:
- send_io_resp_imm()

How to use:
1. Load the rtrs_server module
2. cd /sys/kernel/debug/tracing
3. If all the events need to be enabled:
        echo 1 > events/rtrs_srv/enable
4. OR only speific routine/event needs to be enabled e.g.
        echo 1 > events/rtrs_srv/send_io_resp_imm/enable
5. cat trace
6. Run some I/O workload which can trigger send_io_resp_imm()

Signed-off-by: Santosh Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/Makefile         |  5 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c | 16 ++++
 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h | 88 ++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  8 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  5 ++
 5 files changed, 116 insertions(+), 6 deletions(-)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h

diff --git a/drivers/infiniband/ulp/rtrs/Makefile b/drivers/infiniband/ulp/rtrs/Makefile
index 1fdf918b37eb..5227e7788e1f 100644
--- a/drivers/infiniband/ulp/rtrs/Makefile
+++ b/drivers/infiniband/ulp/rtrs/Makefile
@@ -7,9 +7,12 @@ rtrs-client-y := rtrs-clt.o \
 		  rtrs-clt-sysfs.o \
 		  rtrs-clt-trace.o
 
+CFLAGS_rtrs-srv-trace.o = -I$(src)
+
 rtrs-server-y := rtrs-srv.o \
 		  rtrs-srv-stats.o \
-		  rtrs-srv-sysfs.o
+		  rtrs-srv-sysfs.o \
+		  rtrs-srv-trace.o
 
 rtrs-core-y := rtrs.o
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c
new file mode 100644
index 000000000000..29ca59ceb0dd
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2022 1&1 IONOS SE. All rights reserved.
+ */
+#include "rtrs.h"
+#include "rtrs-pri.h"
+#include "rtrs-srv.h"
+
+/*
+ * We include this last to have the helpers above available for the trace
+ * event implementations.
+ */
+#define CREATE_TRACE_POINTS
+#include "rtrs-srv-trace.h"
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h b/drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h
new file mode 100644
index 000000000000..587d3e033081
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2022 1&1 IONOS SE. All rights reserved.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rtrs_srv
+
+#if !defined(_TRACE_RTRS_SRV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RTRS_SRV_H
+
+#include <linux/tracepoint.h>
+
+struct rtrs_srv_op;
+struct rtrs_srv_con;
+struct rtrs_srv_path;
+
+TRACE_DEFINE_ENUM(RTRS_SRV_CONNECTING);
+TRACE_DEFINE_ENUM(RTRS_SRV_CONNECTED);
+TRACE_DEFINE_ENUM(RTRS_SRV_CLOSING);
+TRACE_DEFINE_ENUM(RTRS_SRV_CLOSED);
+
+#define show_rtrs_srv_state(x) \
+	__print_symbolic(x, \
+		{ RTRS_SRV_CONNECTING,	"CONNECTING" }, \
+		{ RTRS_SRV_CONNECTED,	"CONNECTED" }, \
+		{ RTRS_SRV_CLOSING,	"CLOSING" }, \
+		{ RTRS_SRV_CLOSED,	"CLOSED" })
+
+TRACE_EVENT(send_io_resp_imm,
+	TP_PROTO(struct rtrs_srv_op *id,
+		 bool need_inval,
+		 bool always_invalidate,
+		 int errno),
+
+	TP_ARGS(id, need_inval, always_invalidate, errno),
+
+	TP_STRUCT__entry(
+		__field(u8, dir)
+		__field(bool, need_inval)
+		__field(bool, always_invalidate)
+		__field(u32, msg_id)
+		__field(int, wr_cnt)
+		__field(u32, signal_interval)
+		__field(int, state)
+		__field(int, errno)
+		__array(char, sessname, NAME_MAX)
+	),
+
+	TP_fast_assign(
+		struct rtrs_srv_con *con = id->con;
+		struct rtrs_path *s = con->c.path;
+		struct rtrs_srv_path *srv_path = to_srv_path(s);
+
+		__entry->dir = id->dir;
+		__entry->state = srv_path->state;
+		__entry->errno = errno;
+		__entry->need_inval = need_inval;
+		__entry->always_invalidate = always_invalidate;
+		__entry->msg_id = id->msg_id;
+		__entry->wr_cnt = atomic_read(&con->c.wr_cnt);
+		__entry->signal_interval = s->signal_interval;
+		memcpy(__entry->sessname, kobject_name(&srv_path->kobj), NAME_MAX);
+	),
+
+	TP_printk("sess='%s' state='%s' dir=%s err='%d' inval='%d' glob-inval='%d' msgid='%u' wrcnt='%d' sig-interval='%u'",
+		   __entry->sessname,
+		   show_rtrs_srv_state(__entry->state),
+		   __print_symbolic(__entry->dir,
+			 { READ,  "READ" },
+			 { WRITE, "WRITE" }),
+		   __entry->errno,
+		   __entry->need_inval,
+		   __entry->always_invalidate,
+		   __entry->msg_id,
+		   __entry->wr_cnt,
+		   __entry->signal_interval
+	)
+);
+
+#endif /* _TRACE_RTRS_SRV_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE rtrs-srv-trace
+#include <trace/define_trace.h>
+
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 34c03bde5064..22e6f991946c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -16,6 +16,7 @@
 #include "rtrs-log.h"
 #include <rdma/ib_cm.h>
 #include <rdma/ib_verbs.h>
+#include "rtrs-srv-trace.h"
 
 MODULE_DESCRIPTION("RDMA Transport Server");
 MODULE_LICENSE("GPL");
@@ -57,11 +58,6 @@ static inline struct rtrs_srv_con *to_srv_con(struct rtrs_con *c)
 	return container_of(c, struct rtrs_srv_con, c);
 }
 
-static inline struct rtrs_srv_path *to_srv_path(struct rtrs_path *s)
-{
-	return container_of(s, struct rtrs_srv_path, s);
-}
-
 static bool rtrs_srv_change_state(struct rtrs_srv_path *srv_path,
 				  enum rtrs_srv_state new_state)
 {
@@ -375,6 +371,8 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 		}
 	}
 
+	trace_send_io_resp_imm(id, need_inval, always_invalidate, errno);
+
 	if (need_inval && always_invalidate) {
 		wr = &inv_wr;
 		inv_wr.next = &rwr.wr;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 186a63c217df..2f8a638e36fa 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -91,6 +91,11 @@ struct rtrs_srv_path {
 	struct rtrs_srv_stats	*stats;
 };
 
+static inline struct rtrs_srv_path *to_srv_path(struct rtrs_path *s)
+{
+	return container_of(s, struct rtrs_srv_path, s);
+}
+
 struct rtrs_srv_sess {
 	struct list_head	paths_list;
 	int			paths_up;
-- 
2.25.1

