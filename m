Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E912346A69C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 21:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbhLFURE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhLFURE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 15:17:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51482C061746
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 12:13:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so48270909edd.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LT7xFOTnWv5IVJkC+l9MrZr37AOmnuu7+FggLw+KP+A=;
        b=Pas6awd8GKQZW7QTnpACs28Z0ioduRModDs2gsJaDbyXZy15z9AkpouCppJhhhW7+d
         HJ/rrBejD8bOoLZTMrfIBU20lMwEsaYbl5xL8mdb3fIHql8bx0S+JfbJKNSBPyS3P2Y9
         oEPISyp8jHkrYWDOyHp8jT6Vdnkv8tlbPbk36EU7Qo6BwbJiFQhrnBfkr7FH/2mBde7I
         rQHsAF7yiIqaxOtbRIYsIwdjk7ezfYm9jeNEMymBh8nmVc9R5o3cul7iASYrJqpFbVTk
         hDrX7UdD0iBX6pYDiZrDcXEX2kJXmgIH2bjKWYOVUFCqBjSU6F5y4AV2LwnWczX5BEx+
         QZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LT7xFOTnWv5IVJkC+l9MrZr37AOmnuu7+FggLw+KP+A=;
        b=eCSuQXxWKGu8X9VEzr4xrbvhXougxpp4wDL9yr4pbp6LV8ff90slrsAtzJjGjob7Xi
         FYlSeK+HD1UjxgVyMge5Wzuzdmr/n5Z78yxSBxakIPXVw61Jlk3kEmivy0sjNDNJ3BQP
         uiURQHNxARiRy2H8I/c6t2JZvYN0/469LL/5b9KBbwWg75EyBsSQbKl6NHkzNUNC0jC9
         +7a1E0R6RUL5SixxDCNJbR41UjQ0pF+yhbzAphp/qliYYrwvWs/3p95uAc/jgzsd7Jh/
         fhMmzkdcJY71PvxCrEsCyYlWBGaO9HA0KrHuHk965E4gZfb8ROpqslX2644JZA8lQXjx
         Fp6A==
X-Gm-Message-State: AOAM530/rDkYUrPiCcaaRcsfUSMNHlO05qxh+VdguvxzD9B3LL1EHlGI
        K/kNCw37Xrz51w9KKigcTTHiP1EgHs0=
X-Google-Smtp-Source: ABdhPJxd1tKnRSq2jLHks6PovK0YYOECyyf+5l7e+jWiG285vPPqnupGi5wWaM9+KUsANK20yaa3Og==
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr1771275edb.325.1638821613724;
        Mon, 06 Dec 2021 12:13:33 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id dp16sm8315201ejc.34.2021.12.06.12.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:13:33 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/qedr: Fix reporting max_{send/recv}_wr attrs
Date:   Mon,  6 Dec 2021 22:13:14 +0200
Message-Id: <20211206201314.124947-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the wrongly reported max_send_wr and max_recv_wr attributes for user
QP by making sure to save their valuse on QP creation, so when query QP
is called the attributes will be reported correctly.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 9100009f0a23..a53476653b0d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1931,6 +1931,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	/* db offset was calculated in copy_qp_uresp, now set in the user q */
 	if (qedr_qp_has_sq(qp)) {
 		qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
+		qp->sq.max_wr = attrs->cap.max_send_wr;
 		rc = qedr_db_recovery_add(dev, qp->usq.db_addr,
 					  &qp->usq.db_rec_data->db_data,
 					  DB_REC_WIDTH_32B,
@@ -1941,6 +1942,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 
 	if (qedr_qp_has_rq(qp)) {
 		qp->urq.db_addr = ctx->dpi_addr + uresp.rq_db_offset;
+		qp->rq.max_wr = attrs->cap.max_recv_wr;
 		rc = qedr_db_recovery_add(dev, qp->urq.db_addr,
 					  &qp->urq.db_rec_data->db_data,
 					  DB_REC_WIDTH_32B,
-- 
2.31.1

