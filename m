Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A314235A2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhJFCAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFCAQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21DC061749
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a3so1880181oid.6
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBxkpKC/Ie6Rn+yTC69M869crKSuud+tFzqyCacmKP8=;
        b=aWRPwrwSLhm03F60jFJKc25Aqn13/FS73db6Od1aFGTyF55SbEn36Op8uq5KAa+uJ5
         w73Yp5LdBsme0K7hEAVypcTppUThnVQ9hIWpiHxNmjEW7VB0nokEPKrD2TOfep1g7Vw5
         55Wg7gc/BQYsVqXBoCsg9ZVjaO2/+BktkO/aMBfOefX83v3PuGb71pKONFNS+QWedXTm
         ctJhUkwwG53bZR/8qSQv6Y/D04nVhqwfdeYln8tV86qYeALVH/Lbm2Ub3h1y2LC+inVZ
         9NW6SSqMWVagMZy2zPITPppjG0G7lHf2Q8FIprCqE4woUKlN66h3+EdvNqueEQ5M1QHA
         6eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBxkpKC/Ie6Rn+yTC69M869crKSuud+tFzqyCacmKP8=;
        b=LCt8CPoqFcvgwMbLLOP7Q6l2TkF0hBIdVvyBY15/AoSSmN3wHdUQtEgYLCKAKJfwOr
         bRunz7SP5zOR68sM6st4YQaUW+nx9jkqWPIbeYq4tLKxRltHS0Rw+r5PFr4ynXwwaMG3
         q0dnDQgx6Wsv+iq+v5gq7emfeEsTp3Croy2VuJoEKp6BJqWTw8F5xqWVZ+5xcUpBlnna
         LmlvHwaQ6knUR85xWWX1jHXVAyaZF2Jrg4pqwiA2Xm9LAd0UqY8ypWl4eYohpMSOxGkX
         RFAxXOMapeFImxUt9RDw6dlBYer6eHAMhEmxUhe0pj2wxjIAa0tu4eWr5lKvA8UCSjoB
         pzUw==
X-Gm-Message-State: AOAM530d/VLAuXGNfJ0vpdNp047TriY49t47JBWcchuumX5o9eUV4CYy
        AHxwP0hj/z+zVJcuapVWAudvDl77eC5Rbw==
X-Google-Smtp-Source: ABdhPJxbZSRQPQGCkNwmORQbrRhm4MWo7ZQ+QE5/FcGzE70FjqnFN6V8nlDgKM7wt4M3yeDWNlMD/A==
X-Received: by 2002:a05:6808:1522:: with SMTP id u34mr5172916oiw.76.1633485504466;
        Tue, 05 Oct 2021 18:58:24 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 3/6] RDMA/rxe: Create AH index and return to user space
Date:   Tue,  5 Oct 2021 20:58:12 -0500
Message-Id: <20211006015815.28350-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
the index in UD send WRs to the driver and returning the index to the rxe
provider.

Modify rxe_create_ah() to add an index to AH when created and if
called from a new user provider return it to user space. If called
from an old provider mark the AH as not having a useful index.
Modify rxe_destroy_ah to drop the index before deleting the object.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 31 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 ++
 include/uapi/rdma/rdma_user_rxe.h     |  8 ++++++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c09e1c25ce66..8854ace63acd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -158,9 +158,19 @@ static int rxe_create_ah(struct ib_ah *ibah,
 			 struct ib_udata *udata)
 
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibah->device);
 	struct rxe_ah *ah = to_rah(ibah);
+	struct rxe_create_ah_resp __user *uresp = NULL;
+	int err;
+
+	if (udata) {
+		/* test if new user provider */
+		if (udata->outlen >= sizeof(*uresp))
+			uresp = udata->outbuf;
+		ah->is_user = true;
+	} else {
+		ah->is_user = false;
+	}
 
 	err = rxe_av_chk_attr(rxe, init_attr->ah_attr);
 	if (err)
@@ -170,6 +180,24 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	if (err)
 		return err;
 
+	/* create index > 0 */
+	rxe_add_index(ah);
+	ah->ah_num = ah->pelem.index;
+
+	if (uresp) {
+		/* only if new user provider */
+		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
+					 sizeof(uresp->ah_num));
+		if (err) {
+			rxe_drop_index(ah);
+			rxe_drop_ref(ah);
+			return -EFAULT;
+		}
+	} else if (ah->is_user) {
+		/* only if old user provider */
+		ah->ah_num = 0;
+	}
+
 	rxe_init_av(init_attr->ah_attr, &ah->av);
 	return 0;
 }
@@ -202,6 +230,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
+	rxe_drop_index(ah);
 	rxe_drop_ref(ah);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c807639435eb..9cd203f1fa22 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -48,6 +48,8 @@ struct rxe_ah {
 	struct rxe_pool_entry	pelem;
 	struct rxe_pd		*pd;
 	struct rxe_av		av;
+	bool			is_user;
+	int			ah_num;
 };
 
 struct rxe_cqe {
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 2f1ebbe96434..dc9f7a5e203a 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,7 +99,8 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 			__u16	reserved;
-			__u32	pad[5];
+			__u32	ah_num;
+			__u32	pad[4];
 			struct rxe_av av;
 		} ud;
 		struct {
@@ -170,6 +171,11 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_create_ah_resp {
+	__u32 ah_num;
+	__u32 reserved;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.30.2

