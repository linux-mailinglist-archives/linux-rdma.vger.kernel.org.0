Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E2184DB4
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMReS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 13:34:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33435 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMReR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 13:34:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so13176313wrd.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lah+oOSSBHSPDO3p3xGKmMu0K3A0qAIfOLZw3W00xZM=;
        b=A6Qa0pcz67opa8dthdoI0Q0gUYrir0mQrMwZMmNXzv+eUOgZqMCu/C6xcwavAL6Agv
         GnBchXDqFDLHFVDGvutIOM4n3mSbe/38i9TPTWOabzZp/8p+Ceqbst59yjXvJSLSSeQV
         /Xpzdq1U5IO+fJZKu4qawpxW6/T7mHPB84smQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lah+oOSSBHSPDO3p3xGKmMu0K3A0qAIfOLZw3W00xZM=;
        b=cAus6oIrdjnHObsQnIfToZBDATEFmqa7dqMh0OVBlAl/2FL5puff8P0XG/KLoOb6JL
         fYylCuUzWlh3mgmXfzO8/5g88q6hi0NNh1u2A6OfQhvGmgYFmLp+aF5u91qWPzjvnV5r
         3vds9HxlqlewOZmd+AYxDRlHqZWDQ4HRO29iSvA+72KcNXz5Ap6gfBXmaP7NKarBugoK
         1Qu/JyQnE2HpXT54NHq7JsNWBBCmnkmYyhf15pikDegjjKyKsIfyRTnGq+oZzmtSPOoh
         50QpEep0F2JVM6ll29cDkwD50bW2bxj96TVEX78HX0a/9xJtZv9BysjvdnB/JZygZpsF
         ZrZw==
X-Gm-Message-State: ANhLgQ3FPK8HxxbQiCClQdszN0OWs2DEgzfIPOoZ53b6h9EHmbjqSXg4
        HPu8DDtPoG7wk3nkSTb5iK/JF8Q56+0=
X-Google-Smtp-Source: ADFU+vuq+blowug30e+hA99uiTZcnw3KOlNnzJhRu/ci2C9u6Ef7nFV6kKQ8Ja2aM0L143dI+UCGQw==
X-Received: by 2002:a5d:6544:: with SMTP id z4mr18587849wrv.298.1584120855545;
        Fri, 13 Mar 2020 10:34:15 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w22sm17891958wmk.34.2020.03.13.10.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:34:14 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Wait for all the CQ events before freeing CQ data structures
Date:   Fri, 13 Mar 2020 10:34:02 -0700
Message-Id: <1584120842-3200-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Destroy CQ command to firmware returns the num_cnq_events
as a response. This indicates the driver about the number
of CQ events generated for this CQ. Driver should wait
for all these events before freeing the CQ host structures.
Also, add routine to clean all the pending notification
for the CQs getting destroyed. This avoids the possibility
of accessing the CQ data structures after its freed.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 74 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  1 +
 2 files changed, 75 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 2ccf1c3..e39c7d4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -43,6 +43,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <linux/prefetch.h>
 #include <linux/if_ether.h>
 
@@ -231,6 +232,71 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 	return rc;
 }
 
+static void clean_nq(struct bnxt_qplib_nq *nq, struct bnxt_qplib_cq *cq)
+{
+	struct bnxt_qplib_hwq *hwq = &nq->hwq;
+	struct nq_base *nqe, **nq_ptr;
+	int budget = nq->budget;
+	u32 sw_cons, raw_cons;
+	uintptr_t q_handle;
+	u16 type;
+
+	spin_lock_bh(&hwq->lock);
+	/* Service the NQ until empty */
+	raw_cons = hwq->cons;
+	while (budget--) {
+		sw_cons = HWQ_CMP(raw_cons, hwq);
+		nq_ptr = (struct nq_base **)hwq->pbl_ptr;
+		nqe = &nq_ptr[NQE_PG(sw_cons)][NQE_IDX(sw_cons)];
+		if (!NQE_CMP_VALID(nqe, raw_cons, hwq->max_elements))
+			break;
+
+		/*
+		 * The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+
+		type = le16_to_cpu(nqe->info10_type) & NQ_BASE_TYPE_MASK;
+		switch (type) {
+		case NQ_BASE_TYPE_CQ_NOTIFICATION:
+		{
+			struct nq_cn *nqcne = (struct nq_cn *)nqe;
+
+			q_handle = le32_to_cpu(nqcne->cq_handle_low);
+			q_handle |= (u64)le32_to_cpu(nqcne->cq_handle_high)
+						     << 32;
+			if ((unsigned long)cq == q_handle) {
+				nqcne->cq_handle_low = 0;
+				nqcne->cq_handle_high = 0;
+				cq->cnq_events++;
+			}
+			break;
+		}
+		default:
+			break;
+		}
+		raw_cons++;
+	}
+	spin_unlock_bh(&hwq->lock);
+}
+
+/* Wait for receiving all NQEs for this CQ
+ * and clean the NQEs associated with this
+ * CQ.
+ */
+static void __wait_for_all_nqes(struct bnxt_qplib_cq *cq, u16 cnq_events)
+{
+	u32 retry_cnt = 100;
+
+	while (retry_cnt--) {
+		if (cnq_events == cq->cnq_events)
+			return;
+		usleep_range(50, 100);
+		clean_nq(cq->nq, cq);
+	}
+}
+
 static void bnxt_qplib_service_nq(unsigned long data)
 {
 	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
@@ -244,6 +310,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	uintptr_t q_handle;
 	u16 type;
 
+	spin_lock_bh(&hwq->lock);
 	/* Service the NQ until empty */
 	raw_cons = hwq->cons;
 	while (budget--) {
@@ -269,6 +336,8 @@ static void bnxt_qplib_service_nq(unsigned long data)
 			q_handle |= (u64)le32_to_cpu(nqcne->cq_handle_high)
 						     << 32;
 			cq = (struct bnxt_qplib_cq *)(unsigned long)q_handle;
+			if (!cq)
+				break;
 			bnxt_qplib_armen_db(&cq->dbinfo,
 					    DBC_DBC_TYPE_CQ_ARMENA);
 			spin_lock_bh(&cq->compl_lock);
@@ -278,6 +347,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 			else
 				dev_warn(&nq->pdev->dev,
 					 "cqn - type 0x%x not handled\n", type);
+			cq->cnq_events++;
 			spin_unlock_bh(&cq->compl_lock);
 			break;
 		}
@@ -316,6 +386,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 		hwq->cons = raw_cons;
 		bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
 	}
+	spin_unlock_bh(&hwq->lock);
 }
 
 static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
@@ -2003,6 +2074,7 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_destroy_cq req;
 	struct creq_destroy_cq_resp resp;
+	u16 total_cnq_events;
 	u16 cmd_flags = 0;
 	int rc;
 
@@ -2013,6 +2085,8 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 					  (void *)&resp, NULL, 0);
 	if (rc)
 		return rc;
+	total_cnq_events = le16_to_cpu(resp.total_cnq_events);
+	__wait_for_all_nqes(cq, total_cnq_events);
 	bnxt_qplib_free_hwq(res, &cq->hwq);
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 9e8d1c5..7edb70b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -402,6 +402,7 @@ struct bnxt_qplib_cq {
  * of the same QP while manipulating the flush list.
  */
 	spinlock_t			flush_lock; /* QP flush management */
+	u16				cnq_events;
 };
 
 #define BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE	sizeof(struct xrrq_irrq)
-- 
2.5.5

