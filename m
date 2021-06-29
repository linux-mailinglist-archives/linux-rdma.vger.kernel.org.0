Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515CD3B6E67
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhF2Gzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhF2Gzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886BC061760
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hc16so34350548ejc.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLAc5qb7iSWM1BvhJGNoOPseoj8qwLBemACiNj21/oI=;
        b=LssMiIYHe4O5W+znX2LPhO6vOGOVykovUo9JT9aX+CBIyNuAMLtNLBEmy7VCs9oj+W
         quax65wQCf0oxQknUZ73oNHhcfwLzUV4XER7ihhiQYTUv1gWYtyoJA3W63Dyfg2gvNwj
         BGu9bjKG/xvJu48Y5uZNSMminyjyUm+2YqchdUxdEqby9XcQX322eeR13n7YQAForKqH
         JSnlJCtABb+djLG6ovr6y42riyvHtnAJ+Jz6zoyePqf4ZBh3T68Kmwm4BoUly0Om+doD
         nX3vR9QPKahTefktWnjMFJYfMTIDLI6Tkj7luD2YqJ00TbD1uxItLcNKEX/hrNrw5Lz2
         e/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLAc5qb7iSWM1BvhJGNoOPseoj8qwLBemACiNj21/oI=;
        b=EN1geggNLU4YXtrxfNX5h0HXWFLnGlNOXgJ1f1yOxToNHWRALnDAMBKHKL1thbzLT6
         TpCO0BhiKCN0jd7HOWxSPf1mM6lmOSWHM5/ZW+Uug1cRt1dTfksqR9Gqz7uPRnoltUg+
         z59/rjwn4nQuNpPuzUATVvznDsDptqSVv3/mjADRrpL9K0VZW3+HGTvQoYp8XGiR76/H
         0Dx2E03L94coi2qrqA7DZinka3Cah+oDscdN2IwjhBxGBdr5DaoCX1IrvP0b1GsrLnuv
         S5j/xfrOUu7/BxXzlJUYyyZEar3ucvDRJffoledaVu4CLvVmpaEbA61rXTkqj6vS+bKs
         bSXQ==
X-Gm-Message-State: AOAM530fc5ZTRFuwdoRps2e+rTWcZO8Ze11cHEgTMWocvrVm8APZ2/6h
        VzYt2q/aIV26J8tSdbdJeef7Y5Vn9DFFVA==
X-Google-Smtp-Source: ABdhPJxtmaiI/82sspg6H8B9jz5X1ArPilPeMXZcR4ezEW3PlBvY0lkGNSNUehoWG5YK/KIqxBhwFw==
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr25813632ejc.165.1624949606351;
        Mon, 28 Jun 2021 23:53:26 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:26 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 4/6] RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
Date:   Tue, 29 Jun 2021 08:53:19 +0200
Message-Id: <20210629065321.12600-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629065321.12600-1-jinpu.wang@ionos.com>
References: <20210629065321.12600-1-jinpu.wang@ionos.com>
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

