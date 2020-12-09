Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B52D470E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgLIQrM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgLIQrM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:12 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FBC0611CA
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:01 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id h16so2275495edt.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce/Bwa3SIK5dxNWoTyb5Ghqa/Fpa/H/KZk3y3B+mcdU=;
        b=GFOyaUJkol6SisFyzhPsi1r1uwk6EAoGGZ/HIRtQqO2ZOX0GNiITJLC1MuW4P7+Z2u
         CIpP/UmukDTfNoT61JNdWGDNZ3NCba7pCjDhPzu55QjhpJMZFe74mI528OBFI7PyAO5Y
         DeMAdBgc7JvyJsBVTkrwAIf7m9XfMopatIHtFyYihhTB3ApFl1Amizf6k08nX6ZnWlF2
         uZNpFREPbRXrVazsxQ78KYygDM1kN+cFmH8++B8ns4+SOFDYYHD3b8ujvbKaf2qvRYyZ
         qwEXGuR1np8I+/DojcwV8JK4All8MwlDh0fgCLheYM3VUQ0Pl7YtAzF/bM0EaCENI3vI
         mwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce/Bwa3SIK5dxNWoTyb5Ghqa/Fpa/H/KZk3y3B+mcdU=;
        b=NPSFv0Kx7+IsMoPjv31Z7eO7/0xh9PZIOHBpmFB26ebrkcondT7G1v3r44GV/VO0Xi
         pOWEtyNi03zGJki01sjP6uxIf8UAS3QVQ0nofHeSWrEI8bOILNrd9s2U2LpWHj+q0Jtt
         fR6UruwCjjeg3ugy5gVRSM59C8rV79qiNYBAbqO5EqFxPUZLYa9sqUG1hFnLNAUW9dv9
         VvEvFUQEqSVSWPuuVQyldTb8PwwOazS2pbWjodNcR6BRPEHC9p2deKEOlUwaNvBvjCu/
         AHFZLcz7Z6HnN8IxubrYW3i6vKoC26BxPdXhhxbR3m3K52pNlfe8WY0UntFiU6WsD/e8
         4F1g==
X-Gm-Message-State: AOAM531QTOBvlRna1fCAEBpH+huLKU1i1R8g4OKviXBvG2s+IV7xzSbh
        8DPYTQUJpBGMjvWNpDbx79yzYksw+9hqjg==
X-Google-Smtp-Source: ABdhPJy7JIeEW4EQnchTNtfB67ibK11H6cVMS96M1eJ9bm8ewcrBAWAY9falCgJmI45nH3eC6Mlm4Q==
X-Received: by 2002:a50:c299:: with SMTP id o25mr2815783edf.343.1607532360227;
        Wed, 09 Dec 2020 08:46:00 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:59 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 13/18] RDMA/rtrs-srv: Fix missing wr_cqe
Date:   Wed,  9 Dec 2020 17:45:37 +0100
Message-Id: <20201209164542.61387-14-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We had a few places wr_cqe is not set, which could lead to NULL pointer
deref or GPF in error case.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 27ac5a03259a..c742bb5d965b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -267,6 +267,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		WARN_ON_ONCE(rkey != wr->rkey);
 
 	wr->wr.opcode = IB_WR_RDMA_WRITE;
+	wr->wr.wr_cqe   = &io_comp_cqe;
 	wr->wr.ex.imm_data = 0;
 	wr->wr.send_flags  = 0;
 
@@ -294,6 +295,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		inv_wr.sg_list = NULL;
 		inv_wr.num_sge = 0;
 		inv_wr.opcode = IB_WR_SEND_WITH_INV;
+		inv_wr.wr_cqe   = &io_comp_cqe;
 		inv_wr.send_flags = 0;
 		inv_wr.ex.invalidate_rkey = rkey;
 	}
@@ -304,6 +306,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 
 		srv_mr = &sess->mrs[id->msg_id];
 		rwr.wr.opcode = IB_WR_REG_MR;
+		rwr.wr.wr_cqe = &local_reg_cqe;
 		rwr.wr.num_sge = 0;
 		rwr.mr = srv_mr->mr;
 		rwr.wr.send_flags = 0;
@@ -379,6 +382,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 
 		if (need_inval) {
 			if (likely(sg_cnt)) {
+				inv_wr.wr_cqe   = &io_comp_cqe;
 				inv_wr.sg_list = NULL;
 				inv_wr.num_sge = 0;
 				inv_wr.opcode = IB_WR_SEND_WITH_INV;
@@ -421,6 +425,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 		srv_mr = &sess->mrs[id->msg_id];
 		rwr.wr.next = &imm_wr;
 		rwr.wr.opcode = IB_WR_REG_MR;
+		rwr.wr.wr_cqe = &local_reg_cqe;
 		rwr.wr.num_sge = 0;
 		rwr.wr.send_flags = 0;
 		rwr.mr = srv_mr->mr;
-- 
2.25.1

