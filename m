Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25AC30DFA6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 17:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBCQZO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 11:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhBCQZL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 11:25:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF76264E4D;
        Wed,  3 Feb 2021 16:24:26 +0000 (UTC)
Subject: [PATCH v2 6/6] rpcrdma: Capture bytes received in Receive completion
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 11:24:25 -0500
Message-ID: <161236946591.1030487.17569515553232560373.stgit@manet.1015granger.net>
In-Reply-To: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 76e85e16854b..c838e7ac1c2d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -60,6 +60,51 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
+DECLARE_EVENT_CLASS(rpcrdma_receive_completion_class,
+	TP_PROTO(
+		const struct ib_wc *wc,
+		const struct rpc_rdma_cid *cid
+	),
+
+	TP_ARGS(wc, cid),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(u32, received)
+		__field(unsigned long, status)
+		__field(unsigned int, vendor_err)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->status = wc->status;
+		if (wc->status) {
+			__entry->received = 0;
+			__entry->vendor_err = wc->vendor_err;
+		} else {
+			__entry->received = wc->byte_len;
+			__entry->vendor_err = 0;
+		}
+	),
+
+	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x) received=%u",
+		__entry->cq_id, __entry->completion_id,
+		rdma_show_wc_status(__entry->status),
+		__entry->status, __entry->vendor_err,
+		__entry->received
+	)
+);
+
+#define DEFINE_RECEIVE_COMPLETION_EVENT(name)				\
+		DEFINE_EVENT(rpcrdma_receive_completion_class, name,	\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
 DECLARE_EVENT_CLASS(xprtrdma_reply_class,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep
@@ -838,7 +883,8 @@ TRACE_EVENT(xprtrdma_post_linv_err,
  ** Completion events
  **/
 
-DEFINE_COMPLETION_EVENT(xprtrdma_wc_receive);
+DEFINE_RECEIVE_COMPLETION_EVENT(xprtrdma_wc_receive);
+
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_send);
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_fastreg);
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_li);
@@ -1790,7 +1836,7 @@ TRACE_EVENT(svcrdma_post_recv,
 	)
 );
 
-DEFINE_COMPLETION_EVENT(svcrdma_wc_receive);
+DEFINE_RECEIVE_COMPLETION_EVENT(svcrdma_wc_receive);
 
 TRACE_EVENT(svcrdma_rq_post_err,
 	TP_PROTO(


