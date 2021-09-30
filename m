Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359FF41D263
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbhI3E27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347920AbhI3E26 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A6C06176C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so5691794otq.7
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBxkpKC/Ie6Rn+yTC69M869crKSuud+tFzqyCacmKP8=;
        b=LEQGWgUjTN2IM4ykt5wEWjmkF0I12yebGMBEmBIb3KmEbLCKb9fE+3BJOR+exIMF65
         yMM1mmrrUaJoubeHpPdLDP0iG5mvwbjNwVgeCglHwFgfmf/LDvLrOQeCewuZskffNtDg
         MS37KxRM+9BNZePtycT85JgYxb6MlXOh+Lr3ZVSgtzH+WCeloQcsiNFEz33d2jmpG722
         Mf8OWMbhERMw7tVjZvTS+8dm5Jl/6NavN5yF+YcBeoQDomrwsS9Sf6GbFAz1xRzJpv1g
         0k+DEB0iBSdFU3VxiltmKtGduLQFOMgu9AMqGoc0+2gCv3gmT9qJAxLnBvK9dubSmkYA
         RdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBxkpKC/Ie6Rn+yTC69M869crKSuud+tFzqyCacmKP8=;
        b=TCJUoUe5PPW3bM4hEYZg4PPECC4hHDn0hzjIdg9DwLiF6wzeIEaBFaiI7BRzds/n93
         fLNJLieTTh3ckaaT65veYYA4nG2EEQoOhSssBFGvNKaBQBNOSZP/FQuwW9I0US3gYg0S
         IoioPiSHA4AIlPyKhs0TtF79Af46nWwJXbwZwiH4R+IS96+b+Fi979H3N4RyHPwTYXRj
         hZhE1ZAuCe8qTtKp2MUKdzjfJYz8K4pkKASOW9ER/Zba8Bi5UMGg4b38KG4RUTIAN4Eh
         Gt+11WT7Lzn5iIEITfL7/QrNiacVzdwRXvIlnwd7AtxMNByRd6SEDpRe6/NU61s94oYJ
         YYHA==
X-Gm-Message-State: AOAM532trdU0GtQPKOt9w/zIowPR0aaueP7eoNLXM6YBY2qNXCHF8Mi2
        xy+Wqtak2Cwi9Wk9lFNYZP4=
X-Google-Smtp-Source: ABdhPJxsz3bPZqA9X717mA1MK4x1rvt+F3LCULChhMqLLzKAuDo6QyznotuDEieJLzvFW6GjOCAbpg==
X-Received: by 2002:a05:6830:24a8:: with SMTP id v8mr3134279ots.185.1632976035451;
        Wed, 29 Sep 2021 21:27:15 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 3/6] RDMA/rxe: Create AH index and return to user space
Date:   Wed, 29 Sep 2021 23:26:01 -0500
Message-Id: <20210930042603.4318-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
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

