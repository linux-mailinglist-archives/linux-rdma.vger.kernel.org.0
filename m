Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777A511FE6D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 07:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfLPGUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 01:20:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfLPGUX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Dec 2019 01:20:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so5743879wro.2
        for <linux-rdma@vger.kernel.org>; Sun, 15 Dec 2019 22:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QByDstfhDJ20xCva0sgOY5XM9gfyZNSRlYjytnPYU/0=;
        b=Q14k70GWJpF0K/gGKK7SkeLR70ByuiDty0Z+yIbhB3aGNhRQVM6EedCF0/6hI6RoBM
         NNh1WJfJuSurlxX2NLV5TGXxCKRuQVcM0pkwZCo4FswRTku7pdlpmAxpMMMbSS8TQ4Xb
         mi5t+iWq/gW9xI4OoJKvM/AOFvoyu+p6omZ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QByDstfhDJ20xCva0sgOY5XM9gfyZNSRlYjytnPYU/0=;
        b=dzmI3Scca8g5vluWUMdVYXQLW5p+4dvUJKOHv7vIFIXXtpibvFzaW7NZDBjvjrTNj0
         cI0BI1qJlNa5B+N/H+vochroLA1lKfKfq3BHdX0aGOTTkBDjxvYHZjRtT7eJqowkp3C9
         iMmNZpzdndpaeBjqMCTGe8Ez1Pg1CC+E6Lba/+FAzgzpdYzZZmnAGrTa5tuRrXlzzrzv
         wuzEXGcNsUeIc9JY5YAWTgmUXcjuhuSEpDzP/eA8d+DzYtGLBuwkn1g/vskjL52nxazZ
         gqJMmH/CpzsLrz3ZMd76YXD4ye/pV9u98HOmExPEUH6KVOiXgNm3mS2tYyHP2v3h4WDc
         HFPQ==
X-Gm-Message-State: APjAAAUMmy5onraTYaggF1BWlmwCiXXt4ZiPI5QgEzGo5kyUkChEP2vR
        lXtP08qmVENLzDlbJZxhdd83qg==
X-Google-Smtp-Source: APXvYqyy4qggv7JktzW+Y5IpQ+59ahCXfWwN3XbgH5SDu24gmqIze1kTalXNguLRo54K132jX4Q45Q==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr29604428wrx.141.1576477220996;
        Sun, 15 Dec 2019 22:20:20 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 60sm20663639wrn.86.2019.12.15.22.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 22:20:20 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-next v2 2/2] RDMA/bnxt_re: Retrieve the driver gid context from gid_attr
Date:   Sun, 15 Dec 2019 22:20:01 -0800
Message-Id: <1576477201-2842-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
References: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the container_of macro to retrieve the driver gid
context.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ad5112a..b5f611f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -640,6 +640,8 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	struct bnxt_re_dev *rdev = pd->rdev;
 	const struct ib_gid_attr *sgid_attr;
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
+	struct ib_gid_attr_info *info;
+	struct bnxt_re_gid_ctx *ctx;
 	u8 nw_type;
 	int rc;
 
@@ -651,22 +653,21 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	ah->rdev = rdev;
 	ah->qplib_ah.pd = &pd->qplib_pd;
 
+	sgid_attr = grh->sgid_attr;
+
+	info = container_of(sgid_attr, struct ib_gid_attr_info, attr);
+	ctx = info->context;
+
 	/* Supply the configuration for the HW */
 	memcpy(ah->qplib_ah.dgid.data, grh->dgid.raw,
 	       sizeof(union ib_gid));
-	/*
-	 * If RoCE V2 is enabled, stack will have two entries for
-	 * each GID entry. Avoiding this duplicte entry in HW. Dividing
-	 * the GID index by 2 for RoCE V2
-	 */
-	ah->qplib_ah.sgid_index = grh->sgid_index / 2;
+	ah->qplib_ah.sgid_index = ctx->idx;
 	ah->qplib_ah.host_sgid_index = grh->sgid_index;
 	ah->qplib_ah.traffic_class = grh->traffic_class;
 	ah->qplib_ah.flow_label = grh->flow_label;
 	ah->qplib_ah.hop_limit = grh->hop_limit;
 	ah->qplib_ah.sl = rdma_ah_get_sl(ah_attr);
 
-	sgid_attr = grh->sgid_attr;
 	/* Get network header type for this GID */
 	nw_type = rdma_gid_attr_network_type(sgid_attr);
 	ah->qplib_ah.nw_type = bnxt_re_stack_to_dev_nw_type(nw_type);
@@ -1521,6 +1522,8 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	struct bnxt_re_dev *rdev = qp->rdev;
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
 	enum ib_qp_state curr_qp_state, new_qp_state;
+	struct ib_gid_attr_info *info;
+	struct bnxt_re_gid_ctx *ctx;
 	int rc, entries;
 	unsigned int flags;
 	u8 nw_type;
@@ -1592,6 +1595,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 			rdma_ah_read_grh(&qp_attr->ah_attr);
 		const struct ib_gid_attr *sgid_attr;
 
+		sgid_attr = qp_attr->ah_attr.grh.sgid_attr;
+		info = container_of(sgid_attr, struct ib_gid_attr_info, attr);
+		ctx = info->context;
+
 		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_DGID |
 				     CMDQ_MODIFY_QP_MODIFY_MASK_FLOW_LABEL |
 				     CMDQ_MODIFY_QP_MODIFY_MASK_SGID_INDEX |
@@ -1602,11 +1609,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		memcpy(qp->qplib_qp.ah.dgid.data, grh->dgid.raw,
 		       sizeof(qp->qplib_qp.ah.dgid.data));
 		qp->qplib_qp.ah.flow_label = grh->flow_label;
-		/* If RoCE V2 is enabled, stack will have two entries for
-		 * each GID entry. Avoiding this duplicte entry in HW. Dividing
-		 * the GID index by 2 for RoCE V2
-		 */
-		qp->qplib_qp.ah.sgid_index = grh->sgid_index / 2;
+		qp->qplib_qp.ah.sgid_index = ctx->idx;
 		qp->qplib_qp.ah.host_sgid_index = grh->sgid_index;
 		qp->qplib_qp.ah.hop_limit = grh->hop_limit;
 		qp->qplib_qp.ah.traffic_class = grh->traffic_class;
@@ -1614,7 +1617,6 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		ether_addr_copy(qp->qplib_qp.ah.dmac,
 				qp_attr->ah_attr.roce.dmac);
 
-		sgid_attr = qp_attr->ah_attr.grh.sgid_attr;
 		rc = rdma_read_gid_l2_fields(sgid_attr, NULL,
 					     &qp->qplib_qp.smac[0]);
 		if (rc)
-- 
2.5.5

