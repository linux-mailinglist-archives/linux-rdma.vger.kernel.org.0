Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C683C43D8
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 08:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhGLGKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhGLGKo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 02:10:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666CCC0613DD
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso9160454wme.0
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLAc5qb7iSWM1BvhJGNoOPseoj8qwLBemACiNj21/oI=;
        b=D64HFzDlvxfE9e8LaDhyF4tEWJfIlpVIo6mvrM/C7Wuu3LaleeIWjXWI1UQle7duMq
         knL+X5qwKELKMML9wLFv7B+TMlT4ye8vuD3vGMkwALqPQm11l0dfJAtIhWkgLbp7umEY
         ESH4gFBq8rUpS28zbCKQ4uV01bLjd6lkEbJS68U+1NC1s5ATcX/K7xVepz4BgVdZ+Qt8
         YOPTLa+mnTrzdyt0p5RDrkHWJbsdUSruS8WPygodRAxZJ7Rajh62u9ya4Yu6HN2ntFq1
         U4L651Ukpqv2EG20JhTgWBnq+c3Sfx/17HDDzjJRQNE8s9GMTfLLlnCfziMNN+Maihy0
         Mx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLAc5qb7iSWM1BvhJGNoOPseoj8qwLBemACiNj21/oI=;
        b=W0LsWELRM5q+ADOOepuM4l4m5VXQjRsNuooOgVCD1GYenwCFuyZ1+xf0ZC+pS/AcQP
         WdmXdOkjjTciXIXVY3Acl/06dWWko4kZn+oDdrbMBqzNi7PE5rxl05chFAxvgcBbR4Im
         gboxu5mybbAX/e7kj5oknGRXkcQuijw6SHNmD3fUaf00KnTUheBjyevgA0R9inIuduSA
         ubVM0Eij6tOAJ+6czZOqZtMGcF+hJzKX77a1dTd2lBnudGwqzmJk/VWsZuMsIngysDFn
         f1Ft3MSUIV4x9MZy3LOKeXacoO4opa3K214l5AOupmi66vrYEsZakjgdXycqDSgwwu2M
         D23A==
X-Gm-Message-State: AOAM531c1X5IKnBVTQrnOOIqTPZrXSpVy208KZ7vPNpv/RjwrzUXLO34
        67Fq6WFoT3RIXpvD9vTKhvyFvTHBZ4r2gw==
X-Google-Smtp-Source: ABdhPJwMqRpQbIw9BeAYgOG/cPdnO2MqH19HJyEJeSaApza+itTOiSZHwYgStbayGNZZc4N6MUEKuQ==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr22785097wmj.73.1626070074977;
        Sun, 11 Jul 2021 23:07:54 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49bc:8600:895c:e529:e1b8:7823])
        by smtp.gmail.com with ESMTPSA id s17sm13344245wrv.2.2021.07.11.23.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:07:54 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-rc 4/6] RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
Date:   Mon, 12 Jul 2021 08:07:48 +0200
Message-Id: <20210712060750.16494-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's only used in rtrs.c, so no need to export.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 3 ---
 drivers/infiniband/ulp/rtrs/rtrs.c     | 9 +++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index b88a4944cb30..76581ebaed1d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -311,9 +311,6 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 				struct ib_send_wr *tail);
 
 int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe);
-int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
-				   u32 imm_data, enum ib_send_flags flags,
-				   struct ib_send_wr *head);
 
 int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 		      u32 max_send_sge, int cq_vector, int nr_cqe,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 7f2dfb9d11fc..528d6a57c9b6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -182,9 +182,11 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
 
-int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
-				    u32 imm_data, enum ib_send_flags flags,
-				    struct ib_send_wr *head)
+static int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con,
+					  struct ib_cqe *cqe,
+					  u32 imm_data,
+					  enum ib_send_flags flags,
+					  struct ib_send_wr *head)
 {
 	struct ib_rdma_wr wr;
 	struct rtrs_sess *sess = con->sess;
@@ -202,7 +204,6 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 
 	return rtrs_post_send(con->qp, head, &wr.wr, NULL);
 }
-EXPORT_SYMBOL_GPL(rtrs_post_rdma_write_imm_empty);
 
 static void qp_event_handler(struct ib_event *ev, void *ctx)
 {
-- 
2.25.1

