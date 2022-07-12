Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17257175C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 12:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiGLKb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGLKbX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 06:31:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18AAD854
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id oy13so8641985ejb.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHPqIaxLqgWf7NR1j5EX5ARr+fAYM2yGQ7O88dTMNcI=;
        b=Rr09vrN0BIW9cbDjJzenRB73ZSEODXyzM/MeK8GSeye4IfnrY9gbNrSksCe2bv5T/T
         x4Jl5+Zb4fEuV7+I4y9M0AbvNcqF6agU8dHRi/MrzDn7mb2JO8ufvgZHrffXy5/XdLUt
         EqGOU/rp+F2GD5OhH7DXsESpXJmBhAfOZFa9AWQIW6lMGSwm3RCPIxa5aqiL3wn0zrdQ
         Eyt8sfdPvbMUOlSRoQ0pV4sJXYA6M5zkRH+yuH5YTSkI8kvYR89awFzsebSXp9zZpGXb
         +7p3yGgsbUfRxCq0dRqGvc2KNNwD2U2ROHzGxUL5MQx+aIHnNTs9Sbi2DWpwbj9wY8NX
         NdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHPqIaxLqgWf7NR1j5EX5ARr+fAYM2yGQ7O88dTMNcI=;
        b=rxiUlyrmbFiek4iDvfLZswaNLFq6o/QoGeUmzGgOcIA+dcoU+fKj+pKHYgDQElUAPu
         /XtFw170SSxiHhx20epH8qcULlhi/AOAHkoHd+WxNQNEstuHyYHBdyU3U6FIPBteVvFJ
         gy8R65/Pz9c+PU6UBUdmI553DYsBtv6mEN3sRqzfHNlCcULkMfDeHLBn4zsBUBwgkuZ9
         LBQCupR9L5lXqsB7RUiEN2NMaj2z30mE5ycExigwCRBYCkCOUNLcrlh7D3SE/rD0rSr3
         dlCRAWilVhBnu2F8QyIG5d+Ggjsy5l5/WiT4L6ts5fn+qO/TTgfirSnsLvSd8RbzAlSy
         RIJQ==
X-Gm-Message-State: AJIora+0VLMuRGT7u3qYsPNuY9fdawne3D8T1uOcY1NgTaSGdoHPxdEz
        2aLdFz2e1P3/Pe5BhyyjFMKcSyqhd/T29g==
X-Google-Smtp-Source: AGRyM1uM06d4ZQC0QGTP+mhQQHA9kKMzGpiZFb193r1EknwOIrZu9UYiwIDZccW7DcxyFbM+9aF7hA==
X-Received: by 2002:a17:907:2e01:b0:72b:764f:ea1a with SMTP id ig1-20020a1709072e0100b0072b764fea1amr4112315ejc.666.1657621878932;
        Tue, 12 Jul 2022 03:31:18 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b004355d27799fsm5763419edr.96.2022.07.12.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:31:18 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 4/5] RDMA/rtrs-clt: Replace list_next_or_null_rr_rcu with an inline function
Date:   Tue, 12 Jul 2022 12:31:12 +0200
Message-Id: <20220712103113.617754-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712103113.617754-1-haris.iqbal@ionos.com>
References: <20220712103113.617754-1-haris.iqbal@ionos.com>
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

