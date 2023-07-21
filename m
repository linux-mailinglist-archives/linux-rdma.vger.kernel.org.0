Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7575D5F6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGUUvJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUUvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:08 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9E30EA
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:07 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55b8f1c930eso1498669eaf.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972666; x=1690577466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JUn5TGcUWqYXziIB1X+oJSW2dprGCzLxbWBVFHQeq4=;
        b=jVXmpr0DpdHp4gKarA5ejGnFwrs1LYpP3kRy3Raf23WHaZJF+Ej6pGRlSfM53MhI5/
         lG3QicstHRJNOz2WWkQOplMb8RJKGs/ZPdJfl6iFKGvrB8G5Cc3Uxe0zrEi7wLN3xsjQ
         YEI0nDWCPlYwsWlc2Ci0OWz5XlMN2r/dSlRHvOYNFqVcRJt0nCNzr0kKk6gjU8Mht2iq
         yUPQtiq6046QSB5wLfdhV4Wxmj69/XpfqfFE+lc1JJGYEvkn8haW/+BHDkPT3G5NEDYU
         9mnYETagPWVhi3tMNM9TfH7BziDrctqGxZpFO/DRIfKRDMqNWzjfnbMB75f1AUseWxIO
         wNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972666; x=1690577466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JUn5TGcUWqYXziIB1X+oJSW2dprGCzLxbWBVFHQeq4=;
        b=dhoahdiC3JBVhVLHJ2I+T7ea4qQRqk5NNyGLv5TMURzWjN5++4dZwCQUw14Bop079b
         eoQhH77qatt0pLWGt8t7mnVQV0AHm5JrVG7+4+p9g5bj1d+5Z0wkl6NbnyS5eCYq9oCF
         hpjwVgzx7Nmi8q3+OH6yCcq90c4ERK+JMyGa7DjUap9rEexshmFVQZs8hGSYcuXbvU5Z
         CX0FRvTzCVebyFPkr9J7JDsXNn2GS4GuTC/HEsreNdZUrfSy0tvN/bBErSSmkeu6xPSu
         u/kurJjvHQlyCf+9DNJJrJjJXhjC66DYFvKJcKkX61JD6LkwDwsaSvxSKv0FGEK/hs7N
         C/4Q==
X-Gm-Message-State: ABy/qLaEgUa7ppEgpIryIDlb6Sy4G0rtef69c8jlBi1yTVdpAfYNU12p
        09WN6qwL9wBrmLEKCmJmO1E=
X-Google-Smtp-Source: APBJJlF3E5XsHan7gpa8hQEAocf9wNFNCXNp3qgHkWGgUZXQSFfo4MHnQVuxIQ3pVenoumDNbrIxvg==
X-Received: by 2002:a05:6808:2005:b0:3a4:11a1:4cd8 with SMTP id q5-20020a056808200500b003a411a14cd8mr3998076oiw.4.1689972666598;
        Fri, 21 Jul 2023 13:51:06 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/9] RDMA/rxe: Fix handling sleepable in rxe_pool.c
Date:   Fri, 21 Jul 2023 15:50:14 -0500
Message-Id: <20230721205021.5394-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since the AH creation and destroy verbs APIs can be called in
interrupt context it is necessary to not sleep in these cases.
This was partially dealt with in previous fixes but some cases
remain where the code could still potentially sleep.

This patch fixes this by extending the __rxe_finalize() call to
have a sleepable parameter and using this in the AH verbs calls.
It also fixes one call to rxe_cleanup which did not use the
sleepable API.

Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  |  5 +++--
 drivers/infiniband/sw/rxe/rxe_pool.h  |  5 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 ++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6215c6de3a84..de0043b6d3f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -247,10 +247,11 @@ int __rxe_put(struct rxe_pool_elem *elem)
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
-void __rxe_finalize(struct rxe_pool_elem *elem)
+void __rxe_finalize(struct rxe_pool_elem *elem, bool sleepable)
 {
 	void *xa_ret;
+	gfp_t gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
 
-	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, gfp_flags);
 	WARN_ON(xa_err(xa_ret));
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index ef2f6f88e254..d764c51ed6f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -77,7 +77,8 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable);
 
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
-void __rxe_finalize(struct rxe_pool_elem *elem);
-#define rxe_finalize(obj) __rxe_finalize(&(obj)->elem)
+void __rxe_finalize(struct rxe_pool_elem *elem, bool sleepable);
+#define rxe_finalize(obj) __rxe_finalize(&(obj)->elem, true)
+#define rxe_finalize_ah(obj, sleepable) __rxe_finalize(&(obj)->elem, sleepable)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b899924b81eb..5e93dbac17b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -265,6 +265,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	struct rxe_dev *rxe = to_rdev(ibah->device);
 	struct rxe_ah *ah = to_rah(ibah);
 	struct rxe_create_ah_resp __user *uresp = NULL;
+	bool sleepable = init_attr->flags & RDMA_CREATE_AH_SLEEPABLE;
 	int err, cleanup_err;
 
 	if (udata) {
@@ -276,8 +277,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		ah->is_user = false;
 	}
 
-	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah,
-			init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
+	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah, sleepable);
 	if (err) {
 		rxe_dbg_dev(rxe, "unable to create ah");
 		goto err_out;
@@ -307,12 +307,12 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	}
 
 	rxe_init_av(init_attr->ah_attr, &ah->av);
-	rxe_finalize(ah);
+	rxe_finalize_ah(ah, sleepable);
 
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(ah);
+	cleanup_err = rxe_cleanup_ah(ah, sleepable);
 	if (cleanup_err)
 		rxe_err_ah(ah, "cleanup failed, err = %d", cleanup_err);
 err_out:
@@ -354,9 +354,10 @@ static int rxe_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
+	bool sleepable = flags & RDMA_DESTROY_AH_SLEEPABLE;
 	int err;
 
-	err = rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
+	err = rxe_cleanup_ah(ah, sleepable);
 	if (err)
 		rxe_err_ah(ah, "cleanup failed, err = %d", err);
 
-- 
2.39.2

