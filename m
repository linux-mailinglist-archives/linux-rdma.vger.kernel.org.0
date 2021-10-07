Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26456425DBB
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhJGUn2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGUn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01192C061570
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso8986251otj.13
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBxkpKC/Ie6Rn+yTC69M869crKSuud+tFzqyCacmKP8=;
        b=nMXTotcVtAjvqZnAIleAXAT6LviaZpPAli99KVVbRhZ/NnZ2WdH3Qy8Al6CxsUEgcH
         H1doknBMHlpLVQGCZIAGNG+JQT3qhHCsf1qLBjZ4TK2f9s6jLzWjh8Uk7ZrEYCOZPqZt
         1+o8nhG4a0B0pVfUnfaFVuTUzyy6APHsT7g7Bz2aYhQ3hEW0lPfXVSV8Dy7weOlbxdUU
         sFJWuMfqBNgAqKpd+Opixqzgjcf9n+dsjiatj5A3uO/aSIPQc12nSPoxPrtIdsElXs2d
         W9vMabSpP6Ew3uMS/CMllfcTTdqJITC27rtWBXOZii8GJEWdWvex1LmLq4hwNiddXQrJ
         tJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBxkpKC/Ie6Rn+yTC69M869crKSuud+tFzqyCacmKP8=;
        b=xEaNiZil1ZLrSyBVr7D0GTqrkTi8dj4GQJ2r6K8sgJja279yU95NTi19lASHhcdM9y
         yNKPMjxEgCxaK+xNxTTIPA0JFkG26ntme1rhSCe3RwXwESJ4ouOxs5cNzuJkJuyR/o8b
         qM6irlv7ACAYDVqRnBlyNPjwkaHRwsgu1THiwXV/3GBJkJNdRm+UWfvN1d9pnPOKA6kj
         m9jTj/9Jdk8AHOHAjjI6n/h/Tl2JtShUzGoQ1pGHFSk4dsPiH5Vg1koBhnY+jMNKR8yN
         tRsrfba1pcbBDhczZaV1oRQAPIrw5uncsuwMJGGbC7KoMg18pS9afpw0F9KqeR1EdT26
         B46w==
X-Gm-Message-State: AOAM531my8KYqVitBzchnL1w6oPALHDRv2Bxu2WnGotxh/OahWILiFGK
        6pMlR4MKwu4SqC4PLKEBeqE=
X-Google-Smtp-Source: ABdhPJzzNU/mlVCdLI4w/GOSwRx6HNbx7qhMMS1+28WT3MDeYuC8PVqYsEavMf3RaVY4rpFxZoKjTw==
X-Received: by 2002:a9d:6092:: with SMTP id m18mr5461337otj.215.1633639293439;
        Thu, 07 Oct 2021 13:41:33 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 3/6] RDMA/rxe: Create AH index and return to user space
Date:   Thu,  7 Oct 2021 15:40:49 -0500
Message-Id: <20211007204051.10086-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
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

