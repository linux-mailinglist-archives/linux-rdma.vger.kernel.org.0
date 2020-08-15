Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF292453E1
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgHOWGl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgHOVus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D330C0612A4
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a65so9253212otc.8
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3qntwX4yEDo69n93Mf+8W7+8dALiakTimw2ltgpgv0=;
        b=W9SVVxvWSLNf6Mto2VLLU8l/ImQNwSQzKxvbQ84uCO77HPZBbCqGzxBa9iwao9btPo
         NixmMULeLw5vh3J24Zp53YOHAfqVz5M7+uLUIUFVHtq1pbdYPA0euMG5uH50le0PWsWf
         5j//xFARDlyWXkbR+bRX2rFhSsVfytWTgYUuEXkfhK4rLTLfLRUYl3jQZmwViRhCbhDx
         L4LhWFYpeGsw6TjHMOnDQnwHsmft4Csu7xjuC3ShUonwf+c/ZiVwiboDSPePC4bHQgRN
         APW31kxhrmrOS9kJPzOluXmFNJG5GDtrsLs1OXevHffo35DbTIwNgSuGo16Cq2ZfLEiX
         G4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3qntwX4yEDo69n93Mf+8W7+8dALiakTimw2ltgpgv0=;
        b=YYIDmehNK+bIuvupUApb1wRR4RygFLmkgt2JMSy1Je9QkntzllGUaTyaUiM/I6LMwy
         sFWdiHHjqnYHcY0xebwpwAjl/q0RJXV9Gi1llxpOaTzwnjONqceB0kUA26ypXSaQqLLI
         25jBs/+iT7izTuz2mn9TXHwjKVX2VYmwPyNbbo7SzHpkt2pPSHsaS0xb5algdkEw6e5A
         epe95hT3GS8pfMI0UX0O9tGb3mKGr2/hMQQcjHNvbRHjYPKxKzzjvZhuo+DM31LHu3r5
         AxlNWFw9bafBsojN98YYG0DKY1RHkou5vW/jFSnFkDGryBFlMPEP1xamryfEKhrxgaPS
         1Jhg==
X-Gm-Message-State: AOAM533+f2Bk+PbCMQwyuYfSA1CKpl4+5LHYIDtNsSSUVV/Z4xdBv0QG
        edzGwhVHIvxUrUqBDBUgc13l7I7k/Gvb0g==
X-Google-Smtp-Source: ABdhPJwv4ODi30u7z9YAX9oF7FVaFK/vAc8h5BDm0+XNYVanaE8pCTW8bKNUgAXbw/Z1MTscC8/URg==
X-Received: by 2002:a05:6830:20d3:: with SMTP id z19mr4005766otq.189.1597467595881;
        Fri, 14 Aug 2020 21:59:55 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id 1sm2099128otc.44.2020.08.14.21.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 06/20] Added a basic rxe_mw struct
Date:   Fri, 14 Aug 2020 23:58:30 -0500
Message-Id: <20200815045912.8626-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Created the new basic rxe_mw structure.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index f3f1a58e894b..6a4486893b86 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -347,6 +347,20 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+enum rxe_mw_state {
+	RXE_MW_STATE_INVALID,
+	RXE_MW_STATE_FREE,
+	RXE_MW_STATE_VALID,
+};
+
+struct rxe_mw {
+	struct rxe_pool_entry	pelem;
+	struct ib_mw		ibmw;
+	struct rxe_qp		*qp;	/* type 2B only */
+	struct rxe_mem		*mr;
+	enum rxe_mw_state	state;
+};
+
 struct rxe_mc_grp {
 	struct rxe_pool_entry	pelem;
 	spinlock_t		mcg_lock; /* guard group */
@@ -457,10 +471,10 @@ static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
 	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
 }
 
-//static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
-//{
-	//return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
-//}
+static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
+{
+	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
+}
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
-- 
2.25.1

