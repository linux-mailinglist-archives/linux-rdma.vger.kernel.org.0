Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB13290A7A
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 23:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfHPVuL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 17:50:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32807 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfHPVuL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Aug 2019 17:50:11 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so9129481iog.0;
        Fri, 16 Aug 2019 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hlzYAOo1dHYf3fdfTKCWewuOI3rJaLH+SGb6LnWdClM=;
        b=BIld9Fb6o5qIkGPZvCgK1+icGivU+79gWtvABLHLUqznDSDyEBpOB8h9OBJisDeBNP
         JhQQUmT6Q3ofaq7TJn+yictP3SKQJ2M4VywzG4vg2v570DeOu9ursRSm2D6GXiqO6BWb
         WxsDLYY9sLOdmO56HRwr8Ftae5IjPFopdBui2VCJcBWJitFHxv7uRd3tL02Yor76WDUC
         tb/ai1F7PGkOZA0WD04RFQXa7AsVOs/WYTiFdxu+FU2ZAJ+HgNAVsRWa5Cw+AVjTtMse
         vRw7R7zc6fmLiWm19ESCB5Ji29E34BRurcwsDzJEWhFiPV2VW2HSS7N8k7p9OtvQIFwM
         1ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hlzYAOo1dHYf3fdfTKCWewuOI3rJaLH+SGb6LnWdClM=;
        b=F8vlel0std56PhM5yYeNXRiiJsfbCGQoA6cjrXlsA/2feOL1zfSr2UnwnxoUocXDvx
         B97VeL/s1xOFgoNe403I9Z7DxqpfaW5w7hdWWeVVi3eVPWrU/XpH9JXENV9f32oOStfi
         3peZGJYmejnskWrh1GT6N/ZfyQgPkzndlFrmhwhalGAbYPVCqbMIGehYaWl43xdwKGls
         RCzeijCJ52mYags/6ynwRFy9AzVCaJAvrIio//xF9HrbFq6+/1AIS0/Jf7HlicvHSR9y
         5iEyJHherXDLkdzuNUH7udTPRicEzUigqEiS5J4S/UHjJuAbU15zBqTdqbqlSzvYpYo1
         E6Fw==
X-Gm-Message-State: APjAAAWJYWcDdcoCr7M4DMNUdeDsgg5fRpHGePOL0E79lItWG4kExdEp
        xTpm17cdJQrpCy7KMxTaPnI=
X-Google-Smtp-Source: APXvYqws8MGvDoDsIkIlKlPdFcuB3g5fA4GaX5EfH+nH2t8NOpljrkp2Azgua2vdjVymzd7uulsBJw==
X-Received: by 2002:a5d:9942:: with SMTP id v2mr1913291ios.177.1565992210225;
        Fri, 16 Aug 2019 14:50:10 -0700 (PDT)
Received: from seurat29.1015granger.net ([8.46.76.57])
        by smtp.gmail.com with ESMTPSA id m10sm5885787ioj.75.2019.08.16.14.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:50:09 -0700 (PDT)
Subject: [PATCH 2/2] svcrdma: Use llist for managing cache of recv_ctxts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 16 Aug 2019 17:49:38 -0400
Message-ID: <156599215880.1245.16378203886528228113.stgit@seurat29.1015granger.net>
In-Reply-To: <156599209136.1245.654792745471627630.stgit@seurat29.1015granger.net>
References: <156599209136.1245.654792745471627630.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use a wait-free mechanism for managing the svc_rdma_recv_ctxts free
list. Subsequently, sc_recv_lock can be eliminated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    5 +++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   24 ++++++++++--------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    3 +--
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index edb39900fe04..40f65888dd38 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -42,6 +42,7 @@
 
 #ifndef SVC_RDMA_H
 #define SVC_RDMA_H
+#include <linux/llist.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/rpc_rdma.h>
@@ -107,8 +108,7 @@ struct svcxprt_rdma {
 	struct list_head     sc_read_complete_q;
 	struct work_struct   sc_work;
 
-	spinlock_t	     sc_recv_lock;
-	struct list_head     sc_recv_ctxts;
+	struct llist_head    sc_recv_ctxts;
 };
 /* sc_flags */
 #define RDMAXPRT_CONN_PENDING	3
@@ -125,6 +125,7 @@ enum {
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
 struct svc_rdma_recv_ctxt {
+	struct llist_node	rc_node;
 	struct list_head	rc_list;
 	struct ib_recv_wr	rc_recv_wr;
 	struct ib_cqe		rc_cqe;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 65e2fb9aac65..96bccd398469 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -172,9 +172,10 @@ static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
 void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 
-	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_recv_ctxts))) {
-		list_del(&ctxt->rc_list);
+	while ((node = llist_del_first(&rdma->sc_recv_ctxts))) {
+		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
 	}
 }
@@ -183,21 +184,18 @@ static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 
-	spin_lock(&rdma->sc_recv_lock);
-	ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_recv_ctxts);
-	if (!ctxt)
+	node = llist_del_first(&rdma->sc_recv_ctxts);
+	if (!node)
 		goto out_empty;
-	list_del(&ctxt->rc_list);
-	spin_unlock(&rdma->sc_recv_lock);
+	ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 
 out:
 	ctxt->rc_page_count = 0;
 	return ctxt;
 
 out_empty:
-	spin_unlock(&rdma->sc_recv_lock);
-
 	ctxt = svc_rdma_recv_ctxt_alloc(rdma);
 	if (!ctxt)
 		return NULL;
@@ -218,11 +216,9 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 	for (i = 0; i < ctxt->rc_page_count; i++)
 		put_page(ctxt->rc_pages[i]);
 
-	if (!ctxt->rc_temp) {
-		spin_lock(&rdma->sc_recv_lock);
-		list_add(&ctxt->rc_list, &rdma->sc_recv_ctxts);
-		spin_unlock(&rdma->sc_recv_lock);
-	} else
+	if (!ctxt->rc_temp)
+		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
+	else
 		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 30dbbc77ad16..145a3615c319 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -140,14 +140,13 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_send_ctxts);
-	INIT_LIST_HEAD(&cma_xprt->sc_recv_ctxts);
+	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	INIT_LIST_HEAD(&cma_xprt->sc_rw_ctxts);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
 
 	spin_lock_init(&cma_xprt->sc_lock);
 	spin_lock_init(&cma_xprt->sc_rq_dto_lock);
 	spin_lock_init(&cma_xprt->sc_send_lock);
-	spin_lock_init(&cma_xprt->sc_recv_lock);
 	spin_lock_init(&cma_xprt->sc_rw_ctxt_lock);
 
 	/*

