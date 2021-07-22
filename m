Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAD3D2F0B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhGVUnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhGVUnG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:06 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867DDC061575
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r80so8070319oie.13
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b51+QyWnP4GsydKYsDZr65dmDBEIovJplf60P7dpXy4=;
        b=qD8H0IwAJHLDtQqCUgwKyuwd8u//qldnlG7rN8CbBuSpVTWHGyzK/4Nx2Q1I4V0thq
         VLEpEZfqOVrBjwJofmDtB4TJRYvEXKvYr7B6v2ihlxvXVQtxtgm8hHrwyCsB5AslnGEN
         P7flzjmu4OLEr7Yxq0ViR9mBSzDcyj+HvIExsVMWtis6gRf13ay0DZuM0Ww2JF2Dee9B
         Dn9y/AK2dz/esmexq6XnexJkQsCu/K/PwASJx6OvvqYEfWQx5in8mEnkHhnvsrTxrpNU
         b2CSrNKqAnnL/dMnMc2w8hypoXXyQ6DgRUtY9wM96vt6v0JRCBvWw0BZh8WFaPQUC9Xi
         pFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b51+QyWnP4GsydKYsDZr65dmDBEIovJplf60P7dpXy4=;
        b=YpecEACyiL8DFpRhkVeBtCHEx7e1lTtgQDJ5GdnwxWGjB07kKrfReUPjEzYhqzJ1rO
         826Of/IMCATJTnKoFYWZ37mQRxHcf9btHUXupCcYNBBVI+XzlugqMBnvNMvm7qSTgpwp
         xF6brAPRmNiJUF5fyxYMXhGCDqc96idp2HTEidi9nVd1XL2n/E0lkQJzeZkDjSPbO6EL
         uxZ4YPTGJwNE4qS1SCUxWNDTXgLX910R4Yx/zC/FbUKm1QaHl3VIYbeQ8uzpq7qCNpp2
         8gwS/Jku0PXAmvyOShVGxp5rT6Hzd49i/np2qfeynDXM/0XYHqakj92eC/qDjUHJCV5N
         dwuQ==
X-Gm-Message-State: AOAM530pHiIbQIyDxisuDaqexYhveBzS1ujSqF6TyYeiB7inkmBfFE7d
        BanlTmk9vDUsdg/eHK1N8r0=
X-Google-Smtp-Source: ABdhPJx90deijZSCvGTzKI1BtoJa3zUEFWzZ0Moxpl25/udEX1S8EZpU6oza0ctqLC3nWxCIf1T9KA==
X-Received: by 2002:aca:5882:: with SMTP id m124mr1284372oib.153.1626989019894;
        Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id a44sm5047073ooj.12.2021.07.22.14.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v3 3/6] RDMA/rxe: Create AH index and return to user space
Date:   Thu, 22 Jul 2021 16:22:42 -0500
Message-Id: <20210722212244.412157-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722212244.412157-1-rpearsonhpe@gmail.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
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
index 725015a2e84c..7181e21f0c55 100644
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
index 959a3260fcab..500c47d84500 100644
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

