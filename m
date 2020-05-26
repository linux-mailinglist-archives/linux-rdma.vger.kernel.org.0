Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810BC1D00CF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 23:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgELVYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731334AbgELVYa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 17:24:30 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7AC061A0C;
        Tue, 12 May 2020 14:24:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a136so6307715qkg.6;
        Tue, 12 May 2020 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OIkLNkuUBokCAU8V9zFcyjFw2DAuyf2mNKo6UP//+hw=;
        b=RgCeRcXv+Y9Gy+Boznxpc2n4Hx3p5qz/huIrwl4H++W03d3DrdH3ZKQV1FA/NVsio9
         ZaAZy7agryLxzj1TfkDtAWFHAozUtXsiPwj1ynzcjPFBOu6uMvaVSVE5+xgSJV90wzE4
         3/o2NUctBnhBqv/+Q74DJWoTAfJKr94wFKkkT01gwLSTKrtWGZyY/Z72N9TxqALIsyKG
         fKzarAb6cSdTL+k1GBM8jLhKP5nLrYMdx82xncTFvzG9iLoBn+bEXtCEeroJaS7fs/4s
         lzcACjcqxnSBExRMgdcJtWcvL5J9Nhcx02y14E9FjsjjJ5EYAdPrlIZlv4N5BvTaheR7
         YG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OIkLNkuUBokCAU8V9zFcyjFw2DAuyf2mNKo6UP//+hw=;
        b=jyuw8wzBAXVzlEgoGDWgIBTyYB+yR2CsEk7LkwQ7XVbC30njBhem8bKcFgs0lMlHY7
         l2BwgW4/aNLtRyovQ9xRr/5rp+APVomuptOAv7cQ3lwBjd7kxpiwtyxnVDPZZLbQYLYp
         aDzrNHA+HzqjZOL4QsYdAJ3xJw6yOIcUM3qvUNcOkT11btMUpCLIpED28hHt44RoaxYn
         YCzhf3A5qyej2Xm6PjPKxpycW8Vfp/UqQBb+MPfQ9orlPbuk5jCCCtp0A+Iw+v0VP1dM
         m9MntiX6piATs4/zBuu6TVIsp3vHn6xJNmXVFVP3uJZmRpQ4zQi4y17vRBvCGHq9QTCn
         JhFw==
X-Gm-Message-State: AGi0PuZ8OmJ6C/0+DxEoz4lOdSLzukYJYOod+0nszKFx3XqBgVFMxXQ1
        W1KHd6t5if8C4d28uT5OKspDgWzT
X-Google-Smtp-Source: APiQypJCwZiPgwjH5hCWSnuRipVuXtyFCkaXcU+veZmlIfqL35uJqMPsb3AUIXyeBiZvZ7r0lBxyfg==
X-Received: by 2002:a05:620a:1379:: with SMTP id d25mr23165394qkl.173.1589318667680;
        Tue, 12 May 2020 14:24:27 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c19sm12936229qtn.94.2020.05.12.14.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:24:27 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLOQe3009957;
        Tue, 12 May 2020 21:24:26 GMT
Subject: [PATCH v2 27/29] SUNRPC: Clean up request deferral tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:24:26 -0400
Message-ID: <20200512212426.5826.9093.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- Rename these so they are easy to enable and search for as a set
- Move the tracepoints to get a more accurate sense of control flow
- Tracepoints should not fire on xprt shutdown
- Display memory address in case data structure had been corrupted
- Abandon dprintk in these paths

I haven't ever gotten one of these tracepoints to trigger. I wonder
if we should simply remove them.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   11 ++++++++---
 net/sunrpc/svc_xprt.c         |   12 ++++++------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 6fa08c36c6ca..b15b5c5dad16 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1406,27 +1406,32 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 	TP_ARGS(dr),
 
 	TP_STRUCT__entry(
+		__field(const void *, dr)
 		__field(u32, xid)
 		__string(addr, dr->xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->dr = dr;
 		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
 						       (dr->xprt_hlen>>2)));
 		__assign_str(addr, dr->xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s xid=0x%08x", __get_str(addr), __entry->xid)
+	TP_printk("addr=%s dr=%p xid=0x%08x", __get_str(addr), __entry->dr,
+		__entry->xid)
 );
+
 #define DEFINE_SVC_DEFERRED_EVENT(name) \
-	DEFINE_EVENT(svc_deferred_event, svc_##name##_deferred, \
+	DEFINE_EVENT(svc_deferred_event, svc_defer_##name, \
 			TP_PROTO( \
 				const struct svc_deferred_req *dr \
 			), \
 			TP_ARGS(dr))
 
 DEFINE_SVC_DEFERRED_EVENT(drop);
-DEFINE_SVC_DEFERRED_EVENT(revisit);
+DEFINE_SVC_DEFERRED_EVENT(queue);
+DEFINE_SVC_DEFERRED_EVENT(recv);
 
 TRACE_EVENT(svcsock_new_socket,
 	TP_PROTO(
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 0a546ef02dde..c1ff8cdb5b2b 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1145,16 +1145,15 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 	set_bit(XPT_DEFERRED, &xprt->xpt_flags);
 	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
 		spin_unlock(&xprt->xpt_lock);
-		dprintk("revisit canceled\n");
+		trace_svc_defer_drop(dr);
 		svc_xprt_put(xprt);
-		trace_svc_drop_deferred(dr);
 		kfree(dr);
 		return;
 	}
-	dprintk("revisit queued\n");
 	dr->xprt = NULL;
 	list_add(&dr->handle.recent, &xprt->xpt_deferred);
 	spin_unlock(&xprt->xpt_lock);
+	trace_svc_defer_queue(dr);
 	svc_xprt_enqueue(xprt);
 	svc_xprt_put(xprt);
 }
@@ -1200,22 +1199,24 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
 		       dr->argslen << 2);
 	}
+	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt = rqstp->rq_xprt;
 	set_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	dr->handle.revisit = svc_revisit;
-	trace_svc_defer(rqstp);
 	return &dr->handle;
 }
 
 /*
  * recv data from a deferred request into an active one
  */
-static int svc_deferred_recv(struct svc_rqst *rqstp)
+static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 {
 	struct svc_deferred_req *dr = rqstp->rq_deferred;
 
+	trace_svc_defer_recv(dr);
+
 	/* setup iov_base past transport header */
 	rqstp->rq_arg.head[0].iov_base = dr->args + (dr->xprt_hlen>>2);
 	/* The iov_len does not include the transport header bytes */
@@ -1246,7 +1247,6 @@ static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt)
 				struct svc_deferred_req,
 				handle.recent);
 		list_del_init(&dr->handle.recent);
-		trace_svc_revisit_deferred(dr);
 	} else
 		clear_bit(XPT_DEFERRED, &xprt->xpt_flags);
 	spin_unlock(&xprt->xpt_lock);

