Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67D438F7C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJYG3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 02:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhJYG3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 02:29:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20BC061745
        for <linux-rdma@vger.kernel.org>; Sun, 24 Oct 2021 23:27:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 62-20020a1c0241000000b0032ca21cffeeso7839641wmc.1
        for <linux-rdma@vger.kernel.org>; Sun, 24 Oct 2021 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbD+K8TkVWV5bnkSXwUXZvPH4tfi7iasgm5zzjeX34I=;
        b=ErswWdXgpHy0y4Wevg4Nq9i8Yh6TG732V2Z3J2G1liQ9uFprsdD831o5ebFr/RM20p
         EMvddAhAgdfagr3STK2q0wwMETvx/u3phB5aBmxDUe7TSBJfSRCZnJzzT4qB0VyitGvn
         ogMpsGdqzXeKMUwfU8lcaYVw2LT9jq017Z6XAgf4p51OFIfK0JUzFOjet0M9WvxUa0/v
         ieCJGvdU5fkgNlRoAMpOUfMeVDjpdy9pkaRtEsw9GIIlhcRSteolb+SqqWUee0QBlojg
         O0ZRfzxAsx5XKyFkb/cLgqgacxu33bPSXAyY44e8wo6imE1HYeevquZz1Qh4tXPP+1zM
         ZxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbD+K8TkVWV5bnkSXwUXZvPH4tfi7iasgm5zzjeX34I=;
        b=tD1Xv8C7Gvt4JZ5mc1ZJ2zllDdt4UWmuWPMwko+6Gg+P7m4bsfsWj3OY3LJnAd4jj/
         /lwZljzqQMMpl8XFaWGE/Izy3B4dXjMlXU3YYqkp71Cjp1m3NmJoI1j05RqFZlbH12J8
         u8K1q24PHoumU0TujFrM9L4w9zsIm0X7A0F1NXmT3yVD58Ng/121DmSArF10u70OxdfZ
         Go2tkFdnRKlNMElbH036j+TZYlQq4ax11wjSseJZ+Jy8q5vm6AVH2qaIRif2OBAGZUg7
         +HhOmdO3/FLM7nhWM4jLyeLPQ4fZxGHLWshYwyCy+aaqZMlpI5JNAx2Joxpx5PFvCtQD
         UahQ==
X-Gm-Message-State: AOAM5325Y2D0zmTfTmXU3YoXWZuq9W06uvIzMbxQ9z0z0SG+gZsowulV
        k27skA0PsqrAJYFDLFyWQt+lM3CxV4foRw==
X-Google-Smtp-Source: ABdhPJzdBvBpf3kzVGxRo2tVjGgcyFoDo8XVbSEXtMBaQ436Fbqcdmc48RJ1Stg2nYfsxN0k4uT6jg==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr17936476wmg.35.1635143233707;
        Sun, 24 Oct 2021 23:27:13 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id g2sm14987264wrq.62.2021.10.24.23.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 23:27:13 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/qedr: Remove unsupported qedr_resize_cq callback
Date:   Mon, 25 Oct 2021 09:26:32 +0300
Message-Id: <20211025062632.3960-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: a7efd7773e31 ("qedr: Add support for PD,PKEY and CQ verbs")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/main.c  |  1 -
 drivers/infiniband/hw/qedr/verbs.c | 10 ----------
 drivers/infiniband/hw/qedr/verbs.h |  1 -
 3 files changed, 12 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 755930be01b8..8b5291d424d2 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -228,7 +228,6 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.query_srq = qedr_query_srq,
 	.reg_user_mr = qedr_reg_user_mr,
 	.req_notify_cq = qedr_arm_cq,
-	.resize_cq = qedr_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, qedr_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, qedr_cq, ibcq),
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3fbf172dbbef..ce0e24fa14c5 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1052,16 +1052,6 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return -EINVAL;
 }
 
-int qedr_resize_cq(struct ib_cq *ibcq, int new_cnt, struct ib_udata *udata)
-{
-	struct qedr_dev *dev = get_qedr_dev(ibcq->device);
-	struct qedr_cq *cq = get_qedr_cq(ibcq);
-
-	DP_ERR(dev, "cq %p RESIZE NOT SUPPORTED\n", cq);
-
-	return 0;
-}
-
 #define QEDR_DESTROY_CQ_MAX_ITERATIONS		(10)
 #define QEDR_DESTROY_CQ_ITER_DURATION		(10)
 
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 031687dafc61..081753df79ef 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -53,7 +53,6 @@ int qedr_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata);
 int qedr_dealloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata);
 int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		   struct ib_udata *udata);
-int qedr_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
 int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int qedr_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
-- 
2.31.1

