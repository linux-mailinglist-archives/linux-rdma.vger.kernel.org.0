Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0621A1620C4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgBRGUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 01:20:37 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51052 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRGUh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 01:20:37 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so552474pjb.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 22:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zEdwZ3J3ZhJhinuk0g9qzs3Gv4GRsX5FiBafDbmgzcY=;
        b=S0Aq3UFpl55LgJ//9CRJTgAXM6jo6PLnkqzlj+XKg1q3KwMm1v7/HTn6jrVdMlwlEF
         ZFi2dAZw+1CEmkqrR28g38lceYHrEFzTME+bpOcQdIpPhnd5cJ2UrofHl2VEuoy/NvyX
         eNT9z8PrehK1l/Ewocz3UtGLlLWH/h2uzaNyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zEdwZ3J3ZhJhinuk0g9qzs3Gv4GRsX5FiBafDbmgzcY=;
        b=WBLP9foIhBV8X77Nt311F8woYEL9p7eWF6xtYpMM/xKJLAvsuXNC5XrSN1r4wJ1QbD
         SNIQzh7wfXSexHDRA4TFA8/kd98+GTce89T5oQZB9cDCbRp8OUHFObkGM5cufX3eIh0W
         /eoDFikmeChrgOSuzSJVx49ss99USrJwnBaecNixpDPL2A5yqYBBhgkUibAnFCRmEuel
         RSY1x+gWSEEpTdpjNA2ul8eb4wrI1vUiqMZzcJVOoDmEqePHkNSvJsbhTQ5nh/Mz6qF/
         Jmun8Wl0oNfyui1arr1rD3AsPWo4B0tNvuAgLFdwhpRy/GMYPUghM9N8eRxyWGzxd+0e
         vrFQ==
X-Gm-Message-State: APjAAAXZis6e0MJeCAzYwvDHtzcvY79aHxdX8AFhy6bQOpOhedenFbST
        cenEzUo8Erhs79Pe1Z5I7pFElg==
X-Google-Smtp-Source: APXvYqyKw2GFJH0spQowkz1qsVZw+QQ7SKb+1C7rYdYRcYDNJXedx04KIYsPacHjpea8yezK4L+8Iw==
X-Received: by 2002:a17:90a:5d88:: with SMTP id t8mr776322pji.120.1582006836529;
        Mon, 17 Feb 2020 22:20:36 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 72sm2606753pfw.7.2020.02.17.22.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 22:20:36 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 2/2] RDMA/bnxt_re: Use rdma_read_gid_hw_context to retrieve HW gid index
Date:   Mon, 17 Feb 2020 22:20:10 -0800
Message-Id: <1582006810-32174-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

bnxt_re HW maintains a GID table with only a single entry for
the two duplicate GID entries (v1 and v2). Driver needs
to map stack gid index to the HW table gid index.
Use the new API rdma_read_gid_hw_context () to
retrieve the HW GID context and then the HW table index.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 52b6a4d..69c3587 100644
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
-	 */
-	ah->qplib_ah.sgid_index = grh->sgid_index / 2;
+	sgid_attr = grh->sgid_attr;
+	ctx = rdma_read_gid_hw_context(sgid_attr);
+	if (!ctx)
+		return -EINVAL;
+	ah->qplib_ah.sgid_index = ctx->idx;
+	rdma_put_gid_attr(sgid_attr);
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
-		 */
-		qp->qplib_qp.ah.sgid_index = grh->sgid_index / 2;
+		sgid_attr = grh->sgid_attr;
+		ctx = rdma_read_gid_hw_context(sgid_attr);
+		if (!ctx)
+			return -EINVAL;
+		qp->qplib_qp.ah.sgid_index = ctx->idx;
+		rdma_put_gid_attr(sgid_attr);
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

