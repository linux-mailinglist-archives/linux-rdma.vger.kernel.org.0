Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D133CCAE6
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhGRVcO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhGRVcO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:32:14 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B14BC061764
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:29:15 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id b18-20020a0568303112b02904cf73f54f4bso2613151ots.2
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rnph8n3lz4XfDGvrHQ9k3gv+YZef3cwysa36LX/XIz4=;
        b=UD/dgRc/0rG1jgfQyRwYztJ5b9O8VSETDpfGGSw9hNbnaRcVW7GksEItnojDP53Kzb
         DHeMk9y3tDN25jxmJokuMPK8BV3oL0XLvGme56n8LV4H/yxfNDAx+3lF632KAd4lbZ9d
         8t+aDRiLPmoRUuy4ot1lfW3tl6j7079X9beLi8vFgDUZpIRGLNV9KV1nsaXNUI7dn+/J
         /aoPqSqGhF9+2QKLvbczAbbC3Gw3NJRywsQ1PHGnCKHOrJVQxTYT5lunhvoNCcWRRowN
         i5CfdiI56ax0VviA63I66mH+gqyt3WkK5yaRtj5s3fIxiIGAF8D65sVa0kKVqzbHOasf
         71OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rnph8n3lz4XfDGvrHQ9k3gv+YZef3cwysa36LX/XIz4=;
        b=oLLGh1C1p8nz28HprgM/mWgRw45/j5HhnExLy0eIUuzGS5BFmDAo4NXcBEI3lOdmxb
         govisRSfAsGs/Z+t67kCPoMtvjTW2hsa4Wb1Zop75VXDNHD51JfIL44xtxc58MgrI2N/
         9WQOSjTAt6dviEkHHGVLqOl0PrTtAhhL7HEj2S/tKIKFqcIHJnZNVBsF9gRLAGB6DK5R
         r8BI6/xxP+tTAJ8+lYJt9iLo1SbSCmCLY5gHJi9IC3gVls1LgQK60QVQ0R6JofhLRsq9
         viRAejomgvwXcAPMEB8NwwABKnzZHA6B9d8LkGjmQVJI+ndBQAptKvxc+qSmvSHvaZQW
         j6wQ==
X-Gm-Message-State: AOAM53359BRmHVKVGQRIqQlQ3m15FFZJdtFwTfeLMdCao5/VQ/OUWMoP
        L7sMwitEA0vwITMgm0HNi5jvxbadiRI=
X-Google-Smtp-Source: ABdhPJzc6BRXEk235AclC0vhzaEZq8y4PAwmjJ8UuaLrT0xiGP+hAa7TCcdT0e8CVxQ2vBqICScfmg==
X-Received: by 2002:a9d:bc5:: with SMTP id 63mr16596753oth.284.1626643755046;
        Sun, 18 Jul 2021 14:29:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id u18sm3482726oif.9.2021.07.18.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:29:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 1/2] Update kernel headers
Date:   Sun, 18 Jul 2021 16:28:42 -0500
Message-Id: <20210718212842.21559-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718212842.21559-1-rpearsonhpe@gmail.com>
References: <20210718212842.21559-1-rpearsonhpe@gmail.com>
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

