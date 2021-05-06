Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEED375D82
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEFXiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhEFXiT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:19 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6CC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=l5TAd/20QZ8OSJ+6jWJNzrr1+IYZ42ZUw0bVB2P7asY=; b=Pv6xo1zrOOa6LfTpR4vACUmVny
        5mhuUgxz1sCax6om6GflbKcebXsLRAuOFFK4bCCSRlwuS4LQhBk92PjtVYLLOdPG5DYN9cg2csJP4
        QnZ++tcAKZp6AP+x91nhOKcXFOBAic4dxRbSXa7N2VQcSU5gX9C8ZkU39CScqI7Ry+A1e7EK1xz1o
        lz0Us1Xql5oWDn3mU3VCqFH7dIjmxirHki61kU6mMTViL2fdU1LjdnE2wO2PqnsaFWZ1lha/0ZV0q
        HeYO6J9YnUCQhtu5+XsIN5OfXqES/zGPm/bm39q1XlrEYMx40rRiILxxPpJ80c7ID7lTSR8YKTklW
        mlhZ2bLtCQwGb48YToHTZDhx3rtMXsTCLanv2EqE/05QWHxCzvuADz9Ky0/anPsOkKbwyOMWNDwl+
        fpOY9zIl9mkWGAwTHTxDC+USY3MUxng0TMMNB9/4vvEuqIwWTVah3bW9wySrRh1HYSNpmHgViAVtl
        PLdYk5N9Mchy7Sg8y8qff0bg;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYD-0004ID-Tb; Thu, 06 May 2021 23:37:01 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 01/31] rdma/siw: fix warning in siw_proc_send()
Date:   Fri,  7 May 2021 01:36:07 +0200
Message-Id: <1aa26782ef60cc69aa49886a4c478fbbf74a186e.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  CC [M]  drivers/infiniband/sw/siw/siw_qp_rx.o
In file included from ./include/linux/wait.h:9:0,
                 from ./include/linux/net.h:19,
                 from drivers/infiniband/sw/siw/siw_qp_rx.c:8:
drivers/infiniband/sw/siw/siw_qp_rx.c: In function ‘siw_proc_send’:
./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_rx.c:335:16: note: ‘flags’ was declared here
  unsigned long flags;

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 60116f20653c..0170c05d2cc3 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -333,7 +333,7 @@ static struct siw_wqe *siw_rqe_get(struct siw_qp *qp)
 	struct siw_srq *srq;
 	struct siw_wqe *wqe = NULL;
 	bool srq_event = false;
-	unsigned long flags;
+	unsigned long flags = 0;
 
 	srq = qp->srq;
 	if (srq) {
-- 
2.25.1

