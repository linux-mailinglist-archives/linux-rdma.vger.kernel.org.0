Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E83CCAD7
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhGRVaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhGRVai (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:30:38 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4FC061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id s11-20020a4ae48b0000b02902667598672bso45456oov.12
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYx1T+4atNwsYAUkNYXAuWRC7vMHJzuHplwG+C79x20=;
        b=VhesS1YjmgIrkvbvvHGDLgJqgHkfuafzxO6MIYZf5Jd1xZPkJyMoIiO7lLn5NxQrqr
         Zz1sysUhyqXkS99HA0dA5mzp84hAfWJoVhdL3TcRKpFtIDEg/yh9QrYUSCoexrWqDcc7
         UPNFtmrHGw6r66ArOrpr9vyrrXXmZUD3WreC11OgDcCr5DzxVVhwbG+bPLff/QkRAlNf
         Cjs9JJ2bxTbzgQYSnz4JQZr4RUZxAJKUCazxlNIivKWfkHJwskZYq8dxN5fzzSErI4EM
         0F89n6QdsNKkrgWNxi5XEkFDYHSWcMPY98VNJdjqTXQcKpCqyhTVt0HP0TVgza2D+o53
         B4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYx1T+4atNwsYAUkNYXAuWRC7vMHJzuHplwG+C79x20=;
        b=HMiRmX+uFXUvJU+04d9xCEhIWF/dZMrbzP+fX67MaqK39uteJyrjtTZdKhAbxK4VKT
         iSTuaw/0V5FxfFRrKoo4Ybhpyc+13y9XA21maqtLb7kcZFdL4qfaV2VtCHOcrcGYs3Ra
         0OD2TWSx5DD++IuKJzWjazpgEuvQBQ0y2erUQEwNcw/dDMzXlLyR4IXa2I+sJtMh3j9f
         +cPea1ESYGeoaqtjo3vlzRVmxew3l8ulrbQySZLZfBkMe6vt73h3w5WvplBUokefnaG3
         afZFhJYsvbny8y1yFwGnrlEMxNEmbZ/pncm743bAt1ZEMBmdckD3Tlu+7N1Buok+BNSW
         2JOg==
X-Gm-Message-State: AOAM530MEG3nKsxaDEusMKsW7bNSZSdXjmcoaR3luoW7yHGZ0vI1/gqh
        A4DGwamMrAUl7dh8yp7+PBOPYGp3lsQ=
X-Google-Smtp-Source: ABdhPJxmTG/Hoy8x4SkaFgXWiI34fRoTcs5wVvpJU95JkI7V3G9xzyVxfo2Fu0+j9FhBXnXz2rDkYA==
X-Received: by 2002:a4a:8241:: with SMTP id t1mr15425559oog.13.1626643659625;
        Sun, 18 Jul 2021 14:27:39 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id x73sm2967690oif.44.2021.07.18.14.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:27:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 3/5] RDMA/rxe: Create AH index and return to user space
Date:   Sun, 18 Jul 2021 16:27:02 -0500
Message-Id: <20210718212703.21471-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718212703.21471-1-rpearsonhpe@gmail.com>
References: <20210718212703.21471-1-rpearsonhpe@gmail.com>
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
index 4176fffa7fdc..1cc12c913e39 100644
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

