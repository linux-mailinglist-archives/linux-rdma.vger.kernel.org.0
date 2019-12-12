Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7391D11CA84
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfLLKWl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 05:22:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40438 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfLLKWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 05:22:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so393720plp.7
        for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2019 02:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2hSM206uuQtKm8x/vA4O6+NIhtcnv2Msldd5ttrsiYs=;
        b=QCxHzUNvwhkzhX14YoZSx+6ODpnewr5gG3sXuU5neztmFuGovEhBC+0A9Y+ATl6D9k
         A7VbBlkPOh4/17z/Jv5KFDId3MFaFSj6dAf17GuP7DFL7NIyENNMP+HAMd/DfltpWswg
         E0qSVRwOE7EVxnPQzTg9/JPkf3rl07/MvEojQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2hSM206uuQtKm8x/vA4O6+NIhtcnv2Msldd5ttrsiYs=;
        b=N2VlHvNt902FpGSTii4iACmlN4Wl9cl3vvnjVfKtvsBMu2vH9r8r8X0dix+7LnznFl
         t6UYeAw0KyK/h2uO+sz55Xrp2fNJj7bAw2IYno0B1ipsUt0ExI/csynmZULa53/auTPw
         TEpKOWoTPUeqW9U6ZQHmkbUOPTs5N8Zs5B/yAfiFWB9QCcIqj2IFA7jvElFJGiXdp7Ey
         f7+Pbg7KiBrLMlN1MTJLacshMhU/Cm2ChXNBCV2QfPgj6LmgYg6FURQO6FWyhtIHtYQy
         NuBcWfqkpZQpfv0GYjf3eVqByQfjyUvq5jd5DmUdTe5Wo0p74Wcqq/aSXFVQiH/Bcut/
         nUHQ==
X-Gm-Message-State: APjAAAXM2uvtB/F7/Y84FbRtuBh5cLzt939NNI8H0BPRpUIGiyAiFvlg
        ClziGrY1q2nTBYEd9Kepv6aDJ2//HlE=
X-Google-Smtp-Source: APXvYqyMRxJ+fy+5lMZ9/SCwa2Tu0uoywKXa05hO2wvAIBSCpISFXgFIY8pSj7xy7CnR4wya155MaA==
X-Received: by 2002:a17:90a:9bc7:: with SMTP id b7mr9076396pjw.72.1576146160271;
        Thu, 12 Dec 2019 02:22:40 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m12sm6119290pgr.87.2019.12.12.02.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 02:22:39 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: Retrieve the driver gid context from gid_attr
Date:   Thu, 12 Dec 2019 02:22:23 -0800
Message-Id: <1576146143-28264-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1576146143-28264-1-git-send-email-selvin.xavier@broadcom.com>
References: <1576146143-28264-1-git-send-email-selvin.xavier@broadcom.com>
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
index ad5112a..bd657fb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -640,6 +640,8 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	struct bnxt_re_dev *rdev = pd->rdev;
 	const struct ib_gid_attr *sgid_attr;
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
+	struct ib_gid_attr_info *info;
+	struct bnxt_re_gid_ctx *ctx = NULL;
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
+	struct bnxt_re_gid_ctx *ctx = NULL;
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

