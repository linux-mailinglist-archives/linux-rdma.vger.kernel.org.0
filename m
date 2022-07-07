Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6256A546
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiGGOWG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiGGOWF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 10:22:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9C23165
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 07:22:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a9so2981434ejf.6
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHPqIaxLqgWf7NR1j5EX5ARr+fAYM2yGQ7O88dTMNcI=;
        b=DFWnFgPsFYhdag8PxLNU/hYYHcoRjM36y+XRZ4q+SCwy9TkXMXmpJ7G5mEnPc3QXa2
         koPsFiSrNvRbjt1kkBTT44KqA1OSd4WzVkk4/IeRArOhoPm5BcIhPDCO2IM/vjcG0uTz
         S1m6o4NYDx9CUj2UuGlbuuX5afVTZbBfOaN+wtwVD0pZ6L9IMkPzFeyeQ8+KokIc9Q7D
         l38qmmxab3u+VIGy9OUQcqIpFpd1SroGNRkw2d5NUG3jBJx+tUtvAaF36DNO6KZA1Q5e
         XtlGB0Kk6QGlt19vmy3ZKbFxq+pBHKUB9PB3UYo67P2IJodBJseZFLr1RNFMYqoVG1QP
         RauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHPqIaxLqgWf7NR1j5EX5ARr+fAYM2yGQ7O88dTMNcI=;
        b=5uZewalvRIC7wZch280wL7fheUlVZcQjAj+tvIdKpN/JxjQwnM5o22A02trmThXb30
         XwUPUshYN38dmquM0f1uMZrCnGT9+e50enza5w0uargkLDoUPHjmWMpcRwMUxACwROrq
         GrZlrMfSrv7pG05nP3aeCC9Bf6EmqV7CS/HxWyVJZ3isXT0hdJUyIiaV+oH9Tkv0Hp0Q
         AdwX48su7JPmuTpP+DQYnWs97ynX4ovnMuaeeMdNa0JDaTeCwWxwsnAyw1C/As4HBHb5
         vuj4Q9cog3V7Q1ZLwf5IMgVfF67gEs6DzVg5XItbYpZH07DKmxk/IdFfGH0z/Xs8YNax
         KWAQ==
X-Gm-Message-State: AJIora+Oo3OfKHDIs/t+fPF3XAR4sX8nDrqXCKvqYZNf45to+PjCEVcE
        5jFk1oDKlEif2G6Cci1S6LqDYgaBJkXTMg==
X-Google-Smtp-Source: AGRyM1tjpX3Ai4hAWBgJzgHXL3GHonbEe3/u2wFu0Q0x3XhZPLP7lEDQuzw24JBTZAm2S9byH5QSeA==
X-Received: by 2002:a17:907:724a:b0:726:3713:cfd3 with SMTP id ds10-20020a170907724a00b007263713cfd3mr47062756ejc.460.1657203722064;
        Thu, 07 Jul 2022 07:22:02 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072b13fa5e4csm693807ejo.58.2022.07.07.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:22:01 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH for-next 4/5] rtrs-clt: Replace list_next_or_null_rr_rcu with an inline function
Date:   Thu,  7 Jul 2022 16:21:43 +0200
Message-Id: <20220707142144.459751-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707142144.459751-1-haris.iqbal@ionos.com>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

removes list_next_or_null_rr_rcu macro to fix below warnings.
That macro is used only twice.
CHECK:MACRO_ARG_REUSE: Macro argument reuse 'head' - possible side-effects?
CHECK:MACRO_ARG_REUSE: Macro argument reuse 'ptr' - possible side-effects?
CHECK:MACRO_ARG_REUSE: Macro argument reuse 'memb' - possible side-effects?

Replaces that macro with an inline function.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Cc: jinpu.wang@ionos.com
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 35 ++++++++++++--------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 9809c3883979..525f083fcaeb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -740,25 +740,25 @@ struct path_it {
 	struct rtrs_clt_path *(*next_path)(struct path_it *it);
 };
 
-/**
- * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
+/*
+ * rtrs_clt_get_next_path_or_null - get clt path from the list or return NULL
  * @head:	the head for the list.
- * @ptr:        the list head to take the next element from.
- * @type:       the type of the struct this is embedded in.
- * @memb:       the name of the list_head within the struct.
+ * @clt_path:	The element to take the next clt_path from.
  *
- * Next element returned in round-robin fashion, i.e. head will be skipped,
+ * Next clt path returned in round-robin fashion, i.e. head will be skipped,
  * but if list is observed as empty, NULL will be returned.
  *
- * This primitive may safely run concurrently with the _rcu list-mutation
+ * This function may safely run concurrently with the _rcu list-mutation
  * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
  */
-#define list_next_or_null_rr_rcu(head, ptr, type, memb) \
-({ \
-	list_next_or_null_rcu(head, ptr, type, memb) ?: \
-		list_next_or_null_rcu(head, READ_ONCE((ptr)->next), \
-				      type, memb); \
-})
+static inline struct rtrs_clt_path *
+rtrs_clt_get_next_path_or_null(struct list_head *head, struct rtrs_clt_path *clt_path)
+{
+	return list_next_or_null_rcu(head, &clt_path->s.entry, typeof(*clt_path), s.entry) ?:
+				     list_next_or_null_rcu(head,
+							   READ_ONCE((&clt_path->s.entry)->next),
+							   typeof(*clt_path), s.entry);
+}
 
 /**
  * get_next_path_rr() - Returns path in round-robin fashion.
@@ -789,10 +789,8 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
 		path = list_first_or_null_rcu(&clt->paths_list,
 					      typeof(*path), s.entry);
 	else
-		path = list_next_or_null_rr_rcu(&clt->paths_list,
-						&path->s.entry,
-						typeof(*path),
-						s.entry);
+		path = rtrs_clt_get_next_path_or_null(&clt->paths_list, path);
+
 	rcu_assign_pointer(*ppcpu_path, path);
 
 	return path;
@@ -2277,8 +2275,7 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 	 * removed.  If @sess is the last element, then @next is NULL.
 	 */
 	rcu_read_lock();
-	next = list_next_or_null_rr_rcu(&clt->paths_list, &clt_path->s.entry,
-					typeof(*next), s.entry);
+	next = rtrs_clt_get_next_path_or_null(&clt->paths_list, clt_path);
 	rcu_read_unlock();
 
 	/*
-- 
2.25.1

