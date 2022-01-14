Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1348ED62
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 16:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbiANPsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 10:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbiANPsI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 10:48:08 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F59C061574
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p18so6930782wmg.4
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DG/wPzrEZX+cGPa+/ASYMtDjTpVe3vuN81m46Aeu5lk=;
        b=DBTXRop2kSC3ju0SoDzfn5YxteR1IHjluDzArLSs1JNIVirwOQMoeIGaffcuTfIhIy
         qqFl3fDgqr4VJwVP4HzsleCYOTjrZ1EwgkMSTgMD5gP29KAvT9sUEF8M4IWT+dNkl0dn
         Td8RBaIDfOZhM2l6ynoixT2pdj4RXTX3s8h6LBtues862gFTFN/GzP1cHe4KRK4q3+P7
         ZefMp4zL8SRfDbDEZVsTmzxd+wah11dzHd4KWbvHuJ54M1Vo7/tZ0EVceXaAYokf2Q8z
         byM746El3SUjpVRXBl7lnPTwt5yEcgAUzixGTOUaO7pyGAogv0lgZBg5CgvNmrYncqzr
         6g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DG/wPzrEZX+cGPa+/ASYMtDjTpVe3vuN81m46Aeu5lk=;
        b=o4gFq1CIugjqp4BvDG4kfI0OdjGODvmfrfjJhlDXLUfuJrAl+M2tSeJMSWpb3ZPDjA
         vM3mcQOGO6NQ2DqQHw4iFPm15DosCb3+qL5uoSXUNO+iXorKM+QYuJ9mkIit7lq0cyA2
         YCmBY4TUYLc2Qpy13kJpwwUmbimS/KpGsVAqqx4RtXiHP0RNTolDsko+0kt9qPP6B6kH
         u15lGbQhxRWBJHOfdOwMv7v4ysSvZZuJY1r5M2IfI/2R3oo5r7I+53B3gU5E2SgCQGvR
         ggrpkFVkSDHIBuzPHDYw2qFrAHavpMm4Db4hBwGHcKaH5rU6okkBl6ACx0SBePogDgLK
         060w==
X-Gm-Message-State: AOAM530D1HQHCYQQO3eM1m37diFkFvABqk0meED3iVudjt9TlT6zCarc
        ooDxI2g0Ua7FRjYtNjbDiI3TZa5wyMeHsg==
X-Google-Smtp-Source: ABdhPJwJkMQlPxarSlf6Mrg6FcyPlvCmUnbdkHf9f9Rvx8w25ytNbrXVc5B4or/mtRaJD+roWt80sg==
X-Received: by 2002:a17:907:7b8a:: with SMTP id ne10mr7734351ejc.587.1642175286170;
        Fri, 14 Jan 2022 07:48:06 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id x20sm2522028edd.28.2022.01.14.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:48:05 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 2/5] RDMA/rtrs-clt: fix CHECK type warnings
Date:   Fri, 14 Jan 2022 16:47:50 +0100
Message-Id: <20220114154753.983568-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114154753.983568-1-haris.iqbal@ionos.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

First this patch removes list_next_or_null_rr_rcu macro to
fix below warnings. That macro is used only twice.
CHECK:MACRO_ARG_REUSE: Macro argument reuse 'head' - possible side-effects?
CHECK:MACRO_ARG_REUSE: Macro argument reuse 'ptr' - possible side-effects?
CHECK:MACRO_ARG_REUSE: Macro argument reuse 'memb' - possible side-effects?

This patch also fixes below warning:
CHECK:SPACING: No space is necessary after a cast

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 49 ++++++++++++--------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7c3f98e57889..62ba0f17ac9d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -748,26 +748,6 @@ struct path_it {
 	struct rtrs_clt_path *(*next_path)(struct path_it *it);
 };
 
-/**
- * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
- * @head:	the head for the list.
- * @ptr:        the list head to take the next element from.
- * @type:       the type of the struct this is embedded in.
- * @memb:       the name of the list_head within the struct.
- *
- * Next element returned in round-robin fashion, i.e. head will be skipped,
- * but if list is observed as empty, NULL will be returned.
- *
- * This primitive may safely run concurrently with the _rcu list-mutation
- * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
- */
-#define list_next_or_null_rr_rcu(head, ptr, type, memb) \
-({ \
-	list_next_or_null_rcu(head, ptr, type, memb) ?: \
-		list_next_or_null_rcu(head, READ_ONCE((ptr)->next), \
-				      type, memb); \
-})
-
 /**
  * get_next_path_rr() - Returns path in round-robin fashion.
  * @it:	the path pointer
@@ -797,10 +777,20 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
 		path = list_first_or_null_rcu(&clt->paths_list,
 					      typeof(*path), s.entry);
 	else
-		path = list_next_or_null_rr_rcu(&clt->paths_list,
-						&path->s.entry,
-						typeof(*path),
-						s.entry);
+		/*
+		 * Next element returned in round-robin fashion, i.e. head will be skipped,
+		 * but if list is observed as empty, NULL will be returned.
+		 *
+		 * This primitive may safely run concurrently with the _rcu list-mutation
+		 * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
+		 */
+		path = list_next_or_null_rcu(&clt->paths_list,
+					     &path->s.entry,
+					     typeof(*path),
+					     s.entry) ?:
+			list_next_or_null_rcu(&clt->paths_list,
+					      READ_ONCE((&path->s.entry)->next),
+					      typeof(*path), s.entry);
 	rcu_assign_pointer(*ppcpu_path, path);
 
 	return path;
@@ -1863,7 +1853,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		}
 		clt_path->queue_depth = queue_depth;
 		clt_path->s.signal_interval = min_not_zero(queue_depth,
-						(unsigned short) SERVICE_CON_QUEUE_DEPTH);
+						(unsigned short)SERVICE_CON_QUEUE_DEPTH);
 		clt_path->max_hdr_size = le32_to_cpu(msg->max_hdr_size);
 		clt_path->max_io_size = le32_to_cpu(msg->max_io_size);
 		clt_path->flags = le32_to_cpu(msg->flags);
@@ -2268,8 +2258,13 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 	 * removed.  If @sess is the last element, then @next is NULL.
 	 */
 	rcu_read_lock();
-	next = list_next_or_null_rr_rcu(&clt->paths_list, &clt_path->s.entry,
-					typeof(*next), s.entry);
+	next = list_next_or_null_rcu(&clt->paths_list,
+				     &clt_path->s.entry,
+				     typeof(*next),
+				     s.entry) ?:
+		list_next_or_null_rcu(&clt->paths_list,
+				      READ_ONCE((&clt_path->s.entry)->next),
+				      typeof(*next), s.entry);
 	rcu_read_unlock();
 
 	/*
-- 
2.25.1

