Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4369E16415D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 11:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgBSKUW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 05:20:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39940 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBSKUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 05:20:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so27514941wru.7
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JSUGzQSzqOLxhKPOwrhzESZXagM2gmOgogk0afq+Vxg=;
        b=OfZJfRt069uYcMB/q4zw5s7ibSgp3/uSEuFJ4dtBFGaEng9/2s5AYoX3/veO7BSpmc
         JYaaI3e9vkIznwATi80UisWqX0M26vGxSNwg/T+Vbxut6ld1DDfBbq+RI0h5rRufxYh9
         2KFCws8+OFmNYKXJqucuqgETbkAa8tdEgF3gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JSUGzQSzqOLxhKPOwrhzESZXagM2gmOgogk0afq+Vxg=;
        b=tpeMJTS4QBYyACBQNqQRI0mXL9xGETjk83E6ModbEXzLHReuE6G4MEP7ANRAtCaJst
         MReLflp4a9K6MxcJfc7s9PTHSFx+tReHUARp1vAflab9bKsGkRRzrkXlIAgWGmB48MVb
         vrdUdnipdaY9g3O23KRkj0Snh7NdEw7PFaiHH+OAwXxiXTv3BQtI92FtAUrlEclFfecV
         Pg1GhvFBdHiGb0dfifoCuQfpQQ/TZchTiZQqhRVS2aoe8w0jrtANCqXXhgXFCbDrZotV
         Thi3hPTRlwo/3KC9MY9rfLVY4NaiBlfCHLm8caqyLIqWwMzRNxPvStq1YpMYHdYSpsQX
         RXHg==
X-Gm-Message-State: APjAAAV0IxJihIimlCRxvEZEmgW2oPA0ADG0DLravKb4i9PAlOI1F8W3
        cp/x38GsIDkWGZoWBx/rtWgcew==
X-Google-Smtp-Source: APXvYqxEUN0t3aw8rN5W88VzS5AHle0196beY11pTON85U/3hYaIFtzps3lYNMXw5aJwk1/SQrOrVA==
X-Received: by 2002:adf:f310:: with SMTP id i16mr36004280wro.326.1582107618916;
        Wed, 19 Feb 2020 02:20:18 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k16sm2408260wru.0.2020.02.19.02.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 02:20:18 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v4 2/2] RDMA/bnxt_re: Use rdma_read_gid_hw_context to retrieve HW gid index
Date:   Wed, 19 Feb 2020 02:19:54 -0800
Message-Id: <1582107594-5180-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

bnxt_re HW maintains a GID table with only a single entry for
the two duplicate GID entries (v1 and v2). Driver needs
to map stack gid index to the HW table gid index.
Use the new API rdma_read_gid_hw_context () to
retrieve the HW GID context to get the HW table index.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 52b6a4d..18579e8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -639,6 +639,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
 	struct bnxt_re_dev *rdev = pd->rdev;
 	const struct ib_gid_attr *sgid_attr;
+	struct bnxt_re_gid_ctx *ctx;
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
 	u8 nw_type;
 	int rc;
@@ -654,19 +655,18 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	/* Supply the configuration for the HW */
 	memcpy(ah->qplib_ah.dgid.data, grh->dgid.raw,
 	       sizeof(union ib_gid));
-	/*
-	 * If RoCE V2 is enabled, stack will have two entries for
-	 * each GID entry. Avoiding this duplicte entry in HW. Dividing
-	 * the GID index by 2 for RoCE V2
+	sgid_attr = grh->sgid_attr;
+	/* Get the HW context of the GID. The reference
+	 * of GID table entry is already taken by the caller.
 	 */
-	ah->qplib_ah.sgid_index = grh->sgid_index / 2;
+	ctx = rdma_read_gid_hw_context(sgid_attr);
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
@@ -1593,6 +1593,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		const struct ib_global_route *grh =
 			rdma_ah_read_grh(&qp_attr->ah_attr);
 		const struct ib_gid_attr *sgid_attr;
+		struct bnxt_re_gid_ctx *ctx;
 
 		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_DGID |
 				     CMDQ_MODIFY_QP_MODIFY_MASK_FLOW_LABEL |
@@ -1604,11 +1605,12 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		memcpy(qp->qplib_qp.ah.dgid.data, grh->dgid.raw,
 		       sizeof(qp->qplib_qp.ah.dgid.data));
 		qp->qplib_qp.ah.flow_label = grh->flow_label;
-		/* If RoCE V2 is enabled, stack will have two entries for
-		 * each GID entry. Avoiding this duplicte entry in HW. Dividing
-		 * the GID index by 2 for RoCE V2
+		sgid_attr = grh->sgid_attr;
+		/* Get the HW context of the GID. The reference
+		 * of GID table entry is already taken by the caller.
 		 */
-		qp->qplib_qp.ah.sgid_index = grh->sgid_index / 2;
+		ctx = rdma_read_gid_hw_context(sgid_attr);
+		qp->qplib_qp.ah.sgid_index = ctx->idx;
 		qp->qplib_qp.ah.host_sgid_index = grh->sgid_index;
 		qp->qplib_qp.ah.hop_limit = grh->hop_limit;
 		qp->qplib_qp.ah.traffic_class = grh->traffic_class;
@@ -1616,7 +1618,6 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		ether_addr_copy(qp->qplib_qp.ah.dmac,
 				qp_attr->ah_attr.roce.dmac);
 
-		sgid_attr = qp_attr->ah_attr.grh.sgid_attr;
 		rc = rdma_read_gid_l2_fields(sgid_attr, NULL,
 					     &qp->qplib_qp.smac[0]);
 		if (rc)
-- 
2.5.5

