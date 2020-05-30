Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEB1E9183
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2020 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgE3N2i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 May 2020 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 May 2020 09:28:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758EC03E969;
        Sat, 30 May 2020 06:28:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so2328852ioe.2;
        Sat, 30 May 2020 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TV42Sou8aMygUuJA03fyTdblg9o3Ei8GWJ1p5HoMi9k=;
        b=KuupHzHLe6Y9YDP9j4PKVVjPsbV4SyJQ6xRpE6zPpeRrUAWO+2qpMfzcLTuMrQE38o
         FtopM9v/mGHuCoYCxhpLk67M2+N6lsg+ucwzY9J0y6Qw6U9E8sEjYIKarDBKlyAWuBGx
         z0A6SerOosXAMiY0BNt8OX5/SPAFKRgmcpm0T8RCwuROEi1tEHcB7OYVq5eWfG6xA4Uk
         MMkoN9jzovXxMfBO4THDcv7GWZuHfjrY18S3y+Xd+8ogLLeVQZXEAPWqqwc2pKm+BhlP
         faF4+fPiBYzz4K94G44etGLPpGA4hU374ShW8B44i3MVo4AqKXHFhL4sDudknSiQLKoy
         FfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TV42Sou8aMygUuJA03fyTdblg9o3Ei8GWJ1p5HoMi9k=;
        b=hTeVJHAmQbGheJ13IgZ6gMHfxWCm/eSOJF43yPvFDZzKoK2mrfgLjEKmwHJGG5bEU+
         luWz6bOuArmzQiDKZ2ZlXgZ+cmfvLZ+UkXBc4GsW7DOwm60dmcuyLB1FyTuL8DcuvYnv
         SFy4d3IknBvRSXbS21NnFG+7h2mI6NzMHB9hg8A5dMLPkQJML8GlZTc9lNWfoIRlzxR8
         V7Mkpt81ViOpT5HKeXGeqUjUiQdVM/xt9Nvq/t9YZ/JA1D71cOs1x5V/rzqChz/8advz
         QO8Sbe90GlEtGwLrXOxyoSWHUDWLg0u3Mn1F/Gi/pmSHrrooG9Hhx3sna1L55oDonk16
         AyoQ==
X-Gm-Message-State: AOAM532576daWILUEREZ6EJ/R9wozL4T6ZfHFqwp7HyMDEbt+y4zf3Jf
        IK0L0K4JEMwbdd4TKzbXg5O8prsf
X-Google-Smtp-Source: ABdhPJzkfGb1mdq0DCg3NfUw5LQHj765Wsub23A51aXPHBKzZ7nW7cBNzKTL164xxvXL/2jEA0iAkA==
X-Received: by 2002:a02:c6a7:: with SMTP id o7mr10928048jan.67.1590845317047;
        Sat, 30 May 2020 06:28:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r17sm6588040ilc.33.2020.05.30.06.28.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:36 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSal3001402;
        Sat, 30 May 2020 13:28:36 GMT
Subject: [PATCH v4 06/33] svcrdma: trace undersized Write chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:36 -0400
Message-ID: <20200530132836.10117.26430.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Clean up: Replace a dprintk call site.

This is the last remaining dprintk call site in svc_rdma_rw.c, so
remove dprintk infrastructure as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   32 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    7 ++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index d6da6b8d521d..c046b198072a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1665,6 +1665,38 @@ TRACE_EVENT(svcrdma_page_overrun_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_small_wrch_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		unsigned int remaining,
+		unsigned int seg_no,
+		unsigned int num_segs
+	),
+
+	TP_ARGS(rdma, remaining, seg_no, num_segs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, remaining)
+		__field(unsigned int, seg_no)
+		__field(unsigned int, num_segs)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->remaining = remaining;
+		__entry->seg_no = seg_no;
+		__entry->num_segs = num_segs;
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s remaining=%u seg_no=%u num_segs=%u",
+		__get_str(addr), __get_str(device), __entry->remaining,
+		__entry->seg_no, __entry->num_segs
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 17098a11d2ad..5eb35309ecef 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -9,13 +9,10 @@
 
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
-#include <linux/sunrpc/debug.h>
 
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
 static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc);
 static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 
@@ -484,8 +481,8 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return 0;
 
 out_overflow:
-	dprintk("svcrdma: inadequate space in Write chunk (%u)\n",
-		info->wi_nsegs);
+	trace_svcrdma_small_wrch_err(rdma, remaining, info->wi_seg_no,
+				     info->wi_nsegs);
 	return -E2BIG;
 }
 

