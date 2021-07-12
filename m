Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2633C43D9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 08:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhGLGKp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 02:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhGLGKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 02:10:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37265C0613E5
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so10650517wmq.3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMOlkJ/7n+lh5liKE0v3uj39M6w6vAHGDdB9+X7SX2U=;
        b=bEcgNo0GP+KMGh5HmGbYzd8pACjrzaWt3oTyAxrzVCY5mYRKJk7X1tkCH5ADJOWUju
         E/de2G3758DxOgxef8Kcxw86Jqn58Vh6Ae6Uqzp2sAVKJ+1W/iwyUjfgGiVckdzBc72J
         V+tYC4kYIfzMv841uUoTfjPjMLd8QLdsJKEQP5YdarSFYaibKmEK1adJiuyXI64FtMi7
         JhkM8yQcWjpFO8uDB83/6x2rcjKGrK2uDKcSeVUGrbtJKN8O++XJvCdIT+hG5pAsL+U3
         7zj7r6EtCjpxVOJus3Nw/rvym8c0vquCw7KbX/mVnwAkJ4uIQ+sXh3uuFL2WgGxMFvl4
         M5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMOlkJ/7n+lh5liKE0v3uj39M6w6vAHGDdB9+X7SX2U=;
        b=mJ8ilpmZ7D5vwXVSbdgdeVSUCH3b9ZGrPeKi/0pfyQ+oYLaJEWQSu0x3i16MQB/LBi
         dlrGLjKtSJenLRd/pHTe58PdGWFRxDZKB/uP0zMgW3WbOEbltTUC/wluqmnnZaEvmir8
         GzS4b0o1mzjFCXyV5qd/P+BFjyyBLp+0o6ZgfgWSkKz32a+N/+Z5pVdEc7ChIIufSLS0
         jDyElMWjI/KzzIs19NxC1GY2H4vbe8RK0TEsAkW/JPwleh76zMpXZACfTt2rgJ6j0TXa
         F5yWdYjm16jZMMXFcEV5i6yEYOX8FB04Wg3Hm3zMK8u7ZYnuiYgYBvp50w/BA3SDC6rz
         84Sw==
X-Gm-Message-State: AOAM53340zOL2BAZo9TdsjVT1kzC94EMgEhUGHeyig5p2zonAWfr2njr
        HBxEzCLObM95e84m1YiXWnXoHmGA+DVQEQ==
X-Google-Smtp-Source: ABdhPJwXQqYDLDJ2jVXl/T22XS8215EcynfIq8YSDuFQw6leBJoovcTy97tiWx2utqEscgAXH94xbA==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr12641255wmh.5.1626070075700;
        Sun, 11 Jul 2021 23:07:55 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49bc:8600:895c:e529:e1b8:7823])
        by smtp.gmail.com with ESMTPSA id s17sm13344245wrv.2.2021.07.11.23.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:07:55 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-rc 5/6] RDMA/rtrs: Remove unused flags parameter
Date:   Mon, 12 Jul 2021 08:07:49 +0200
Message-Id: <20210712060750.16494-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

flags is not used, so remove it from rtrs_post_rdma_write_imm_empty.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 528d6a57c9b6..b56dc5b82db0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -185,7 +185,6 @@ EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
 static int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con,
 					  struct ib_cqe *cqe,
 					  u32 imm_data,
-					  enum ib_send_flags flags,
 					  struct ib_send_wr *head)
 {
 	struct ib_rdma_wr wr;
@@ -320,7 +319,7 @@ void rtrs_send_hb_ack(struct rtrs_sess *sess)
 
 	imm = rtrs_to_imm(RTRS_HB_ACK_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					     0, NULL);
+					     NULL);
 	if (err) {
 		rtrs_err(sess, "send HB ACK failed, errno: %d\n", err);
 		sess->hb_err_handler(usr_con);
@@ -354,7 +353,7 @@ static void hb_work(struct work_struct *work)
 
 	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					     0, NULL);
+					     NULL);
 	if (err) {
 		rtrs_err(sess, "HB send failed, errno: %d\n", err);
 		sess->hb_err_handler(usr_con);
-- 
2.25.1

