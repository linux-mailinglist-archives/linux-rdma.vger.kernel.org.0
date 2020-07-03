Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE294213CA4
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGCPe7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPe6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 11:34:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B1C061794
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 08:34:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so34502948wmf.5
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAGRW9RG5J5eOxJ/N27IiokN4JQ6OOliqfQ8Tu8usyg=;
        b=mpTCE4yiTGcsTci881sNV7IPrDBWtmTg25OAhK3M2BXENGHG9Mw3JLEjubsVTnGLbb
         C1FEay2jzKi+pQCdeEVjTlaWBuk7hGr5sc8uTqgdwGJNzL7ZbQX6z0WbALQSv8NNQdq9
         SRjtNU7h5/7vt+gmQfkJ3sJR1C3P0njCi5bZhQfkEGwHdPX3GaOVSENRryxxUX/Cwzbg
         HC3JMiCVlIoFVog7WL/4uBFFuHfD1jyayVt27gABIFwfdezF9o6d8md749R0mhozUmmL
         PuYrX1FC5zJz96WJq/DK7OrFQlm+kSGGq4FiJ2FznHzas6DlcKxFtwFgt1wrSDeSdVnd
         7EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAGRW9RG5J5eOxJ/N27IiokN4JQ6OOliqfQ8Tu8usyg=;
        b=siyIj0lohj5TJhKK7/FaQA9z4O7pKFrWUeAkdoS2TuRpqA202VrIatP6pdr2qvb7bG
         KiIxgY7PyplMij11TWw7u3orJ6CcHfMHPiAuez+N7PSK2OgFnrblCcfS8olzDmQHc0N4
         nfG5YgHO/zaG4/rm8NrHOpYRl164WiwsK5zhAhT9W57XfJp4rk5+HXSyfLkP65KFTYYV
         MG9a6Za74clLRKmnd9qZ9zTukVUFhBtRMqgJ5o2PAJVSYFzOeU19M0pV+EAqsh0OB1sZ
         BMWkmdewlhV/QbCPw9mIwH54lVOqallgkYUjM0SWKd9hAasByvunIATJtlZIPW5cF7SO
         DHSw==
X-Gm-Message-State: AOAM532FiM4sLfOdZI0+I+aSW0lbWw5F1YMht/Gvldvvwd8I2KrSSfPG
        BPWvij9c90GrJo+D5+gdeG/dGWfaw7g=
X-Google-Smtp-Source: ABdhPJyn6iqU4+L9B+u57XEdst3lNCB2e9CW52QqP5bLCcEul+6fJqI/JL8dxZkn+LUoHm01Ce629Q==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr36463167wmj.22.1593790496764;
        Fri, 03 Jul 2020 08:34:56 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r1sm14083225wrt.73.2020.07.03.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:34:56 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 3/4] RDMA/rxe: Return void from rxe_mem_init_dma()
Date:   Fri,  3 Jul 2020 18:34:27 +0300
Message-Id: <20200703153428.173758-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703153428.173758-1-kamalheib1@gmail.com>
References: <20200703153428.173758-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from rxe_mem_init_dma() is always 0 - change it to be
void and fix the callers accordingly.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 20 +++-----------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 238d6a357aac..0688928cf2b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -103,8 +103,8 @@ enum copy_direction {
 	from_mem_obj,
 };
 
-int rxe_mem_init_dma(struct rxe_pd *pd,
-		     int access, struct rxe_mem *mem);
+void rxe_mem_init_dma(struct rxe_pd *pd,
+		      int access, struct rxe_mem *mem);
 
 int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 		      u64 length, u64 iova, int access, struct ib_udata *udata,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index a63cb5fac01f..cdd811a45120 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -144,8 +144,8 @@ static int rxe_mem_alloc(struct rxe_mem *mem, int num_buf)
 	return -ENOMEM;
 }
 
-int rxe_mem_init_dma(struct rxe_pd *pd,
-		     int access, struct rxe_mem *mem)
+void rxe_mem_init_dma(struct rxe_pd *pd,
+		      int access, struct rxe_mem *mem)
 {
 	rxe_mem_init(access, mem);
 
@@ -153,8 +153,6 @@ int rxe_mem_init_dma(struct rxe_pd *pd,
 	mem->access		= access;
 	mem->state		= RXE_MEM_STATE_VALID;
 	mem->type		= RXE_MEM_TYPE_DMA;
-
-	return 0;
 }
 
 int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b8a22af724e8..ee80b8862db8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -901,30 +901,16 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mem *mr;
-	int err;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
-
-	err = rxe_mem_init_dma(pd, access, mr);
-	if (err)
-		goto err2;
+	rxe_mem_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
-
-err2:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
-err1:
-	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
-- 
2.25.4

