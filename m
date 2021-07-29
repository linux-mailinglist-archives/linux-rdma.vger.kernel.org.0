Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D633DAE9C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhG2WBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhG2WBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:01:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8059C061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:01:17 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u10so10377591oiw.4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKKJrf7mLQn0k2EwC26VsgAI7rm1jxxLCMTrAp4d6SM=;
        b=f/WelwLWuIa6Nqc4V+S9rLfecodk5WPpwaEdP+ZorSsQn8NX1LdLozu9x/837wKxiG
         QAvTCRHGhEh1bfICCyi/dMZweVV2t2bCPPGUWrDh4GAYp6verhBo+uqm/E4+c2Gam4SW
         1aLoGZ5+opnz6giP2M5u1TuihE/v/m4dPHJxK/2S3CI4TyzRHae/+8zasaf9imdDq9nV
         Cj5ci5ceE2NUsTMFBEgiyFkM991ltkXABraOmYdlPzr1fIjayv9kXA1Uv9WJEZYZRv8v
         JlIn1Dgzh8IB0JyZLPSgqiF8vVf48nJJ1p32neumEBBltwj7GwOndWnEP4dMIS9BBtfQ
         cLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKKJrf7mLQn0k2EwC26VsgAI7rm1jxxLCMTrAp4d6SM=;
        b=Px5j7Ut7cITac4eOo7gyuix3FJGPg1BBWVF3ETCzvgnO2ewAE9G+WMFyFho+ApJLbl
         dq2r+41+FNCyjNY99GOBvl3ZMsnIldbrvcMds5kZE1Vi9uMLubHB48vdHOblaB706vO1
         Jic0F/Zi1yBE87eTQ8uO9uvO/UKcUlfZ308x3ASiDxli02zxnsVakgn6kbRO4V/wPb6q
         o8SPh11UpcygdlVUPbbpTUrpLUwR9e8L2S1RcDsMcC9R1+ZukWHvUOfPS/tsTr/mlEIu
         Zy3Lu/VLPEIuUwwea4bEqdRYbbZ69VWq6e/z3dEtX0G8aOULI+/2vxcZbVtxy3dHFUvN
         qAHQ==
X-Gm-Message-State: AOAM532uXk8UhwOknqeLWhn9CV2QC20dMaqv3sxL6abvOJp+Wt34c8dA
        zPGp8iEs7CU4rss7dAsJEQ8=
X-Google-Smtp-Source: ABdhPJw4MTa55Dtf8Btfhbx9GAxSGZE57x/qQfI6jL2V9Bihd9n/Wkxwsq9wSnLSXeKIRbtkKB6YGA==
X-Received: by 2002:aca:b342:: with SMTP id c63mr11288876oif.83.1627596077129;
        Thu, 29 Jul 2021 15:01:17 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id h2sm742993oti.24.2021.07.29.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:01:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/3] RDMA/rxe: Fix bug in get_srq_wqe() in rxe_resp.c
Date:   Thu, 29 Jul 2021 17:00:38 -0500
Message-Id: <20210729220039.18549-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729220039.18549-1-rpearsonhpe@gmail.com>
References: <20210729220039.18549-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The memcpy() that copies a WQE from a SRQ the QP uses an incorrect size.
The size should have been the size of the rxe_send_wqe struct not the
size of a pointer to it. The result is that IO operations using a SRQ
on the responder side will fail.

Fixes: ec0fa2445c18 ("Fix over copying in get_srq_wqe")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 685b8aebd627..5501227ddc65 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -318,7 +318,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
 		return RESPST_ERR_MALFORMED_WQE;
 	}
-	size = sizeof(wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
+	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
 	memcpy(&qp->resp.srq_wqe, wqe, size);
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
-- 
2.30.2

