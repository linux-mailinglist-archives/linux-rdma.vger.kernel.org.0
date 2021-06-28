Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640F3B6AC3
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhF1WFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbhF1WED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:04:03 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F254C0613A2
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so18709800otk.7
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5l6kftMSkFZYVSaVgxLdOb1qSScAKIujctFXK0ELPE=;
        b=rPPFYq85wf+9n2csiILmhSPINCYMYlszzmu3/7WGCUamFp78TJaLbEIVCLyrWRcmge
         hJajmO+TDIpiJGpuC9sXDuMRPEOxTiNZwG8KBSxfP5TI4u4BfaL+/sdTKWvSVBdwHa2o
         XxWwth/47dLM56WIVwXZUWG3bigWtBRjYYwNGqY+roA335hU6M48LAc2/SHLt8jBk0B3
         qo3+Or/nQBNrhKW3mX7NhWm15hhSo98F2e3Tf1jWTVz7MKfmIU06i3zKRbDR78MbnzAU
         U8AuSlyebpI9Z2bHg1MvcW9Uautvn37pbsGkp7ZPVjd0RrNLmR1Z8sGT8R52YQqnTNvm
         jObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5l6kftMSkFZYVSaVgxLdOb1qSScAKIujctFXK0ELPE=;
        b=NrYTDZ3nSd+TDFhWQ+L0FXT42Ghg2tlOxobX81p13mP199px9K9aJc1wEoTIxTWHuq
         tzRUJpwrbBRHOy/sznuxbgd2uoeW/5PEZhgplMavldxi8wKD8H4esL8YzBf2gOkGavVm
         iwrPgPLQ/m3R8XqQMG/buE2oH1C9DPvx6pZH86frD/8smH4ACQyjbxWu8IL/joqRyqAX
         cfhyHDQr7YYF9HtdM8HHNX2I35PhrA5ZMTgUAFFlwmcyz9ntdPVubO40d0kgXfbxJELw
         nMoIrjQdBPZf6T/Oo/r06exkRi/Y/KEqOlFCSxVfKfR70aLUfZopKyoxW7w+tLFnHqom
         OrQw==
X-Gm-Message-State: AOAM533sTfWiNyfJJ+0bXwBxeSZWnU2Qrzx4Y7f/rGP/63riVNSeqWGc
        JMmgwDM0DCF9dXB489xzWMM=
X-Google-Smtp-Source: ABdhPJw6JufNRoAm52MPIZ3D26NuoUkqocw4hyWGHzSY3LkIT7SgvIruB2LtNvO5/iRtWsXNt2h2dg==
X-Received: by 2002:a05:6830:40b4:: with SMTP id x52mr1453761ott.117.1624917694565;
        Mon, 28 Jun 2021 15:01:34 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id 59sm3715499oto.3.2021.06.28.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:01:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 3/5] RDMA/rxe: Create AH index and return to user space
Date:   Mon, 28 Jun 2021 17:00:42 -0500
Message-Id: <20210628220043.9851-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628220043.9851-1-rpearsonhpe@gmail.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify rxe_create_ah() to add an index to AH when created and if
called from a new user provider return it to user space. If called
from an old provider mark the AH as not having a useful index.
Modify rxe_destroy_ah to drop the index before deleting the object.

Also use the PD in the core ib_ah struct instead of a duplicate copy in
rxe_ah.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 31 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  8 ++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c223959ac174..11d166bc11e3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -161,9 +161,19 @@ static int rxe_create_ah(struct ib_ah *ibah,
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
@@ -173,6 +183,24 @@ static int rxe_create_ah(struct ib_ah *ibah,
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
@@ -205,6 +233,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
+	rxe_drop_index(ah);
 	rxe_drop_ref(ah);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 959a3260fcab..fa234d7ad382 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -46,8 +46,9 @@ struct rxe_pd {
 struct rxe_ah {
 	struct ib_ah		ibah;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_av		av;
+	bool			is_user;
+	int			ah_num;
 };
 
 struct rxe_cqe {
@@ -469,6 +470,11 @@ static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
+static inline struct rxe_pd *ah_pd(struct rxe_ah *ah)
+{
+	return to_rpd(ah->ibah.pd);
+}
+
 static inline struct rxe_pd *mr_pd(struct rxe_mr *mr)
 {
 	return to_rpd(mr->ibmr.pd);
-- 
2.30.2

