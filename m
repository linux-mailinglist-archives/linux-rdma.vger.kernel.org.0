Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739075970F1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiHQOW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiHQOWZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 10:22:25 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D58FD5C
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 07:22:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660746141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wG+fQz975JYKYklK2lPVbPQIBmwzO+DihlbEVra3ywM=;
        b=du8So3FvZ58McjD5dJ4LxPQE8tS0y8Hp7zQwr4DxUPf81TDqi++KuQTiT3h+LZjU1hpMKX
        tbGTrnde/8AlPbAYRQBOTv2tFVWvauwXHmkRnA6xkW3wtJYZ0sLBnQ8Ma/ArUZcxvME+FB
        ErSxfnJREOx3Dr3ED7kPjMTZ8VRp5EA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/hfi1: Suppress compiler warnings
Date:   Wed, 17 Aug 2022 22:22:15 +0800
Message-Id: <20220817142215.17251-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With W=1, the following compiler warnings appears.

In file included from ./include/trace/define_trace.h:102:0,
                 from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                 from drivers/infiniband/hw/hfi1/trace.h:15,
                 from drivers/infiniband/hw/hfi1/trace.c:6:
drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘trace_event_get_offsets_hfi1_trace_template’:
./include/trace/trace_events.h:261:9: warning: function ‘trace_event_get_offsets_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  struct trace_event_raw_##call __maybe_unused *entry;  \
         ^
drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 ^~~~~~~~~~~~~~~~~~~
In file included from ./include/trace/define_trace.h:102:0,
                 from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                 from drivers/infiniband/hw/hfi1/trace.h:15,
                 from drivers/infiniband/hw/hfi1/trace.c:6:
drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘trace_event_raw_event_hfi1_trace_template’:
./include/trace/trace_events.h:386:9: warning: function ‘trace_event_raw_event_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  struct trace_event_raw_##call *entry;    \
         ^
drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 ^~~~~~~~~~~~~~~~~~~
In file included from ./include/trace/define_trace.h:103:0,
                 from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                 from drivers/infiniband/hw/hfi1/trace.h:15,
                 from drivers/infiniband/hw/hfi1/trace.c:6:
drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘perf_trace_hfi1_trace_template’:
./include/trace/perf.h:64:9: warning: function ‘perf_trace_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  struct hlist_head *head;     \
         ^
drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/hw/hfi1/trace_dbg.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 582b6f68df3d..489395bfb5b3 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -22,6 +22,11 @@
 
 #define MAX_MSG_LEN 512
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 		    TP_PROTO(const char *function, struct va_format *vaf),
 		    TP_ARGS(function, vaf),
@@ -36,6 +41,8 @@ DECLARE_EVENT_CLASS(hfi1_trace_template,
 			      __get_str(msg))
 );
 
+#pragma GCC diagnostic pop
+
 /*
  * It may be nice to macroize the __hfi1_trace but the va_* stuff requires an
  * actual function to work and can not be in a macro.
-- 
2.31.1

