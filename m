Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D86A5981AE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiHRKwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbiHRKwr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:52:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB9861F8
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:52:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so473684wru.7
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1qrvbd0g46UhnoWkKjLMCDoF17aqbk0izzjRe3Q8Itc=;
        b=TsRsnVV8MVia0tf+RLfpkS9JKBlEc86WogEIGCF18cG/zSxwAeM4S80LrvYYNXUd4k
         9dTqC01/VufGNYbQWXBCdmdCM+qpNezHwk05yFHWC9m8ueIYVEClNegwNzxIrcYlV02k
         4mhpyQ80LMezOJ49yXzyW3etpPXRRnYF7lEgHhEo559fsessbL2fsYVvaNXkWPiO88xt
         6z55noZWXsztem6FdF8HEGlE65eyvqS4S+PjiTVSQ6n2PtnDKNAHRoOMCtNo8VSViTb4
         t934uxIXHoKawDesYpz0JR1I+02rZSbu8foD2aEke3i8/l2VTHnpgj9MoRaKeIjw2ggL
         OEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1qrvbd0g46UhnoWkKjLMCDoF17aqbk0izzjRe3Q8Itc=;
        b=LHbjoLbV224EBzcOtcKRab+MG2Q7vTRDZZM5BbYBd0E1EnPfU3G0g/I+jw26iuzXAn
         UD0yOsRUV33aswYMjVXvezMRIyjQAG5M7Lg9jlipvkgb2UXq03xfckWZjpdG1u4+/KHA
         qS7EVVLUfD3pAfHcHewXTTmtjZ7DPfW4g0+W/aK2deY7zMxoTkIo1izNMqVQKLr+GWQ0
         NdT3uMvh9K76Q0TeFkLqYjau3mtGnBOrNe2vZOQIACSwTRT8fT1uuA0dLTswpg9MHeuN
         KYLV1sTIUgFKn2Uc6HIizO5Ir1UKKt5gy1uN3HycGA6KoPnNCv51iDX9FJANLsot3SBt
         5IHw==
X-Gm-Message-State: ACgBeo3lhV/VvvgxNfL52I8A90DENT2iUxVg0SShzQ4+nE94kIuVfSJm
        S6LVuUNVbyTvVs7D0P61dyTMuczUS2A+Kw==
X-Google-Smtp-Source: AA6agR7iCq7//icgEIXbZdlTkB4/ZR3OXBsXIxG/a5HSp9BgHgQvNEK3Wuqzklui/I9/EKoDhde3BA==
X-Received: by 2002:a5d:6b10:0:b0:21e:4bbd:e893 with SMTP id v16-20020a5d6b10000000b0021e4bbde893mr1300529wrw.613.1660819964313;
        Thu, 18 Aug 2022 03:52:44 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm6233583wmg.5.2022.08.18.03.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:52:43 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Santosh Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH for-next 1/2] RDMA/rtrs-clt: Add event tracing support
Date:   Thu, 18 Aug 2022 12:52:39 +0200
Message-Id: <20220818105240.110234-2-haris.iqbal@ionos.com>
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
- rtrs_clt_reconnect_work()
- rtrs_clt_close_conns()
- rtrs_rdma_error_recovery()

How to use:
1. Load the rtrs_client module
2. cd /sys/kernel/debug/tracing
3. If all the events need to be enabled:
        echo 1 > events/rtrs_clt/enable
4. OR only speific routine/event needs to be enabled e.g.
        echo 1 > events/rtrs_clt/rtrs_clt_close_conns/enable
5. cat trace
6. Run some workload which can trigger rtrs_clt_close_conns()

Signed-off-by: Santosh Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/Makefile         |  5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c | 15 ++++
 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h | 86 ++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  7 ++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h

diff --git a/drivers/infiniband/ulp/rtrs/Makefile b/drivers/infiniband/ulp/rtrs/Makefile
index 3898509be270..1fdf918b37eb 100644
--- a/drivers/infiniband/ulp/rtrs/Makefile
+++ b/drivers/infiniband/ulp/rtrs/Makefile
@@ -1,8 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+CFLAGS_rtrs-clt-trace.o = -I$(src)
+
 rtrs-client-y := rtrs-clt.o \
 		  rtrs-clt-stats.o \
-		  rtrs-clt-sysfs.o
+		  rtrs-clt-sysfs.o \
+		  rtrs-clt-trace.o
 
 rtrs-server-y := rtrs-srv.o \
 		  rtrs-srv-stats.o \
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c
new file mode 100644
index 000000000000..f14fa1f36ce8
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2022 1&1 IONOS SE. All rights reserved.
+ */
+#include "rtrs.h"
+#include "rtrs-clt.h"
+
+/*
+ * We include this last to have the helpers above available for the trace
+ * event implementations.
+ */
+#define CREATE_TRACE_POINTS
+#include "rtrs-clt-trace.h"
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h b/drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h
new file mode 100644
index 000000000000..7738e2676855
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2022 1&1 IONOS SE. All rights reserved.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rtrs_clt
+
+#if !defined(_TRACE_RTRS_CLT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RTRS_CLT_H
+
+#include <linux/tracepoint.h>
+
+struct rtrs_clt_path;
+struct rtrs_clt_sess;
+
+TRACE_DEFINE_ENUM(RTRS_CLT_CONNECTING);
+TRACE_DEFINE_ENUM(RTRS_CLT_CONNECTING_ERR);
+TRACE_DEFINE_ENUM(RTRS_CLT_RECONNECTING);
+TRACE_DEFINE_ENUM(RTRS_CLT_CONNECTED);
+TRACE_DEFINE_ENUM(RTRS_CLT_CLOSING);
+TRACE_DEFINE_ENUM(RTRS_CLT_CLOSED);
+TRACE_DEFINE_ENUM(RTRS_CLT_DEAD);
+
+#define show_rtrs_clt_state(x) \
+	__print_symbolic(x, \
+		{ RTRS_CLT_CONNECTING,		"CONNECTING" }, \
+		{ RTRS_CLT_CONNECTING_ERR,	"CONNECTING_ERR" }, \
+		{ RTRS_CLT_RECONNECTING,	"RECONNECTING" }, \
+		{ RTRS_CLT_CONNECTED,		"CONNECTED" }, \
+		{ RTRS_CLT_CLOSING,		"CLOSING" }, \
+		{ RTRS_CLT_CLOSED,		"CLOSED" }, \
+		{ RTRS_CLT_DEAD,		"DEAD" })
+
+DECLARE_EVENT_CLASS(rtrs_clt_conn_class,
+	TP_PROTO(struct rtrs_clt_path *clt_path),
+
+	TP_ARGS(clt_path),
+
+	TP_STRUCT__entry(
+		__field(int, state)
+		__field(int, reconnect_attempts)
+		__field(int, max_reconnect_attempts)
+		__field(int, fail_cnt)
+		__field(int, success_cnt)
+		__array(char, sessname, NAME_MAX)
+	),
+
+	TP_fast_assign(
+		struct rtrs_clt_sess *clt = clt_path->clt;
+
+		__entry->state = clt_path->state;
+		__entry->reconnect_attempts = clt_path->reconnect_attempts;
+		__entry->max_reconnect_attempts = clt->max_reconnect_attempts;
+		__entry->fail_cnt = clt_path->stats->reconnects.fail_cnt;
+		__entry->success_cnt = clt_path->stats->reconnects.successful_cnt;
+		memcpy(__entry->sessname, kobject_name(&clt_path->kobj), NAME_MAX);
+	),
+
+	TP_printk("RTRS-CLT: sess='%s' state=%s attempts='%d' max-attempts='%d' fail='%d' success='%d'",
+		   __entry->sessname,
+		   show_rtrs_clt_state(__entry->state),
+		   __entry->reconnect_attempts,
+		   __entry->max_reconnect_attempts,
+		   __entry->fail_cnt,
+		   __entry->success_cnt
+	)
+);
+
+#define DEFINE_CLT_CONN_EVENT(name) \
+DEFINE_EVENT(rtrs_clt_conn_class, rtrs_##name, \
+	TP_PROTO(struct rtrs_clt_path *clt_path), \
+	TP_ARGS(clt_path))
+
+DEFINE_CLT_CONN_EVENT(clt_reconnect_work);
+DEFINE_CLT_CONN_EVENT(clt_close_conns);
+DEFINE_CLT_CONN_EVENT(rdma_error_recovery);
+
+#endif /* _TRACE_RTRS_CLT_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE rtrs-clt-trace
+#include <trace/define_trace.h>
+
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index baecde41d126..5219bb10777a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -16,6 +16,7 @@
 
 #include "rtrs-clt.h"
 #include "rtrs-log.h"
+#include "rtrs-clt-trace.h"
 
 #define RTRS_CONNECT_TIMEOUT_MS 30000
 /*
@@ -302,6 +303,8 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
 
+	trace_rtrs_rdma_error_recovery(clt_path);
+
 	if (rtrs_clt_change_state_from_to(clt_path,
 					   RTRS_CLT_CONNECTED,
 					   RTRS_CLT_RECONNECTING)) {
@@ -1942,6 +1945,8 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 
 void rtrs_clt_close_conns(struct rtrs_clt_path *clt_path, bool wait)
 {
+	trace_rtrs_clt_close_conns(clt_path);
+
 	if (rtrs_clt_change_state_get_old(clt_path, RTRS_CLT_CLOSING, NULL))
 		queue_work(rtrs_wq, &clt_path->close_work);
 	if (wait)
@@ -2648,6 +2653,8 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 				reconnect_dwork);
 	clt = clt_path->clt;
 
+	trace_rtrs_clt_reconnect_work(clt_path);
+
 	if (READ_ONCE(clt_path->state) != RTRS_CLT_RECONNECTING)
 		return;
 
-- 
2.25.1

