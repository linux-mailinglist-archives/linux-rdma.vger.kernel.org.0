Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7424941D26B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhI3Eh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhI3Eh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:37:58 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE8C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:36:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so5727700otv.4
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rnph8n3lz4XfDGvrHQ9k3gv+YZef3cwysa36LX/XIz4=;
        b=mmJYG/arklm+ULnhgEER0tctlt6hD/ihtYVHV+PmdBmhngfGO6heA4mJhVPQ2sxbG+
         naseXHJBBaYGioHMv8i0Nd3ghyLURqdGnQaHH0AQmVbirCGGesZBjq3NSAI5/nnFLhoN
         m9kgibpvEvr73a2iG2gKKYe/R9DlWf30uapSs0uqsjOvaaEZD4X8BwSC/xVLw4t/3ks8
         4rgf4bISosl8tLnKo1Pn8J8eQE7YOtxUFRy7LQQH5UCI+RiArdicazR7iXAmJHxwB+Cs
         QA0Kv39cqUYGu9Ggd+oIdC9a7lW4QeOiGRbOPL6HswyjE55bqFAVrxnxLaqtzDs+mdOh
         MotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rnph8n3lz4XfDGvrHQ9k3gv+YZef3cwysa36LX/XIz4=;
        b=Ybazpdfb2ZZrFtX7MQiHhUGxckGUHq1/NGOemvtdRLhV5xNhofM+qxev6KzoEqJd5r
         5kTzxLJgZxSbmcl4vxorQ8APV7d2HBHAmU9jW2UY+mGs/TOb0E04QUiPDndgox2fbaoN
         e+P0lV6YiBUqI/+kamBk/W/6PEi3fKEyLo/EgW481AqgwY3s3FyEWJtx9jB3sR8/gKcr
         emdkNLSOtKbILAV5DYdJ/sIA20QysT4FcFa/a2qRO60YedSmA7YIkw/4BebxOLuiDL4s
         GXjlPeZHNcp81b2XMda0b8MRJjr7yvUOG2L0yFfRFylojy2uDFEUMN8g9bN0oqHtNYoQ
         SONQ==
X-Gm-Message-State: AOAM531Imq+BJDEkmC6yAtDWjxmcNh7m/JUPTfM6NtW/ufAx00uUVJDM
        zU9WRx0kUZwWJTyYzcBvyZk=
X-Google-Smtp-Source: ABdhPJye/ZPKURgVBFqF9dxKNqB3Ji+aaSntmot/p/t4Vj2xXX1o+fWgQ4TDADDvum4RQEX97K5xLQ==
X-Received: by 2002:a9d:734f:: with SMTP id l15mr3286438otk.4.1632976576130;
        Wed, 29 Sep 2021 21:36:16 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id k15sm389427ooh.41.2021.09.29.21.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:36:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH resending v2 1/2] Update kernel headers
Date:   Wed, 29 Sep 2021 23:35:02 -0500
Message-Id: <20210930043502.4941-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930043502.4941-1-rpearsonhpe@gmail.com>
References: <20210930043502.4941-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/rxe: Convert kernel UD post send to use ah_num").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 10 +++++++++-
 providers/rxe/rxe.c                 |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index e283c222..ad7da77d 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -98,6 +98,10 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	ah_num;
+			__u32	pad[4];
+			struct rxe_av av;	/* deprecated */
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +152,6 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
@@ -168,6 +171,11 @@ struct rxe_recv_wqe {
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
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3c3ea8bb..d19aa9df 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -982,7 +982,7 @@ static void wr_set_ud_addr(struct ibv_qp_ex *ibqp, struct ibv_ah *ibah,
 	if (qp->err)
 		return;
 
-	memcpy(&wqe->av, &ah->av, sizeof(ah->av));
+	memcpy(&wqe->wr.wr.ud.av, &ah->av, sizeof(ah->av));
 	wqe->wr.wr.ud.remote_qpn = remote_qpn;
 	wqe->wr.wr.ud.remote_qkey = remote_qkey;
 }
@@ -1467,7 +1467,7 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 	convert_send_wr(&wqe->wr, ibwr);
 
 	if (qp_type(qp) == IBV_QPT_UD)
-		memcpy(&wqe->av, &to_rah(ibwr->wr.ud.ah)->av,
+		memcpy(&wqe->wr.wr.ud.av, &to_rah(ibwr->wr.ud.ah)->av,
 		       sizeof(struct rxe_av));
 
 	if (ibwr->send_flags & IBV_SEND_INLINE) {
-- 
2.30.2

