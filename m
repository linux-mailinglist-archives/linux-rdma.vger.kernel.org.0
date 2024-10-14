Return-Path: <linux-rdma+bounces-5402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AEF99D643
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 20:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AE0283BC3
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115B1C0DE2;
	Mon, 14 Oct 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L6jEkf2/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9771FAA
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929821; cv=none; b=mxIYHPpMZfaTT7j1kcYHyzBRu4SAlAWOE7znfTfz0WpoMeUw5qon53bcBnV7Z3rV4TNW1TzkIa65ZNffuDOXGcEA49qbqdPuCDZk5w7hSE20qYjY1LXqBS1hLrIl/HbmYC14yApCqtnNQbucBTwct+f3SrlvM+9Ok53awKpZjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929821; c=relaxed/simple;
	bh=wA+FjWd/Jg4uGv9NrtaDmbO5RZbGelYng6d/oKlQphg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VXONDJzwbrNGsxMr7dXnX+KVOgLc5Pq6C6IXLHcQaGXnD9ELRSMKkz81r4DfczjCdb1P7p4VvEIr3IyM3dmuhnhQQ+KbERHKtD5wKAIh14ykvSzzR3RlrJpapCCWEH5mxUNe0cXN3Ga9kSJOTzHd4+hy7wI+sk3mTzznWdH+xXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L6jEkf2/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caea61132so26736465ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728929819; x=1729534619; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3H9gIt1oG/hIkkrt7AkaIiqG5kInDjyrX8VCzkmFMiY=;
        b=L6jEkf2/ElO31+S3IntpiVPewPJZ4j0mKRnhaGPLmBkX5Hxm5SazIiFtXLyxJUQYmO
         c2XCcMkUzs2Yp3OVtz/eYOBhyhgegZR30Yf+5FaHVqjxe6YnlFyiT3AfnjNbbdhI2nLT
         Y1o1k8M/rD/zZxjQOfNWEYAlEfWQIuLmwxFEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929819; x=1729534619;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3H9gIt1oG/hIkkrt7AkaIiqG5kInDjyrX8VCzkmFMiY=;
        b=vsOcz+7BbY5KGHXAPQ+Oy2IMn5Fv7JQAty6fYpJXdQ4gzOa9RDWxRRgSUUn7okioYc
         U0/hK90xPSyLwSsX5Xd8UzIySYvclnYhJa2ugZ2o7c3q+vfngMAJ33mv2zJNm4WJoy7g
         vne06ek6/huu6nAt+VpeucNJQLwQKPra4W3lPtXN0e3DuHtbiAh0fu1a0qyuw3PATBoK
         PskzMSxBMhWE/H9p283CT5DEzKPM2jbU/sMfjiYUk4PUq36UCzcOi5Fz7qiYRgoVEK6G
         l/oa8PTb6iK6Mkn5SJoOUGJctYcpssy3pRHc6OHTdoVKbIRNSicMyE7CPqp+DrOsDp3q
         tLQA==
X-Gm-Message-State: AOJu0YzPja813HuT/DPFmaUfiGC/HB4PMpRJL2OMbCbAnhOYZ6AzwqMj
	qVjULjU/ZldEnesPeItzCmLW2CIoJKJvCrgY8kPVOUB5flCgUhE8YToLFtxlqw==
X-Google-Smtp-Source: AGHT+IEVttvUtIfffpSAga4g+0PmLmOVCcIA86X2kLsK1QqJY8KjXs6AmVPPtUlC7KLHx/Dv2Paq7A==
X-Received: by 2002:a17:902:f54d:b0:20c:ecd8:d092 with SMTP id d9443c01a7336-20cecd8d2edmr48929745ad.30.1728929818696;
        Mon, 14 Oct 2024 11:16:58 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada14asm69245605ad.7.2024.10.14.11.16.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:16:58 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/4] RDMA/bnxt_re: Add support for CQ rx coalescing
Date: Mon, 14 Oct 2024 10:55:59 -0700
Message-Id: <1728928561-25607-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

RoCE message rate performance is heavily degraded
without the use of cq coalescing. With proper coalescing,
message rates get better. Furthermore, coalescing
significantly reduces contention on the PCIe Root
Complex/Memory subsystems.

Add the changes to configure CQ rx colascing parameters
based on adapter revision when CQ is created.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  8 ++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  1 +
 drivers/infiniband/hw/bnxt_re/main.c      |  9 +++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 20 ++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  | 20 ++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  5 +++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 14 +++++++++++++-
 7 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index e94518b..bb28a1f 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -156,6 +156,13 @@ struct bnxt_re_pacing {
 
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
+
+static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
+{
+	return (chip_num == CHIP_NUM_58818 ||
+		chip_num == CHIP_NUM_57608);
+}
+
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -195,6 +202,7 @@ struct bnxt_re_dev {
 	struct bnxt_qplib_ctx		qplib_ctx;
 	struct bnxt_qplib_res		qplib_res;
 	struct bnxt_qplib_dpi		dpi_privileged;
+	struct bnxt_qplib_cq_coal_param	cq_coalescing;
 
 	struct mutex			qp_lock;	/* protect qp list */
 	struct list_head		qp_list;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 460f339..55a3cc8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3065,6 +3065,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.cnq_hw_ring_id = nq->ring_id;
 	cq->qplib_cq.nq	= nq;
+	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
 	if (rc) {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 777068d..3a01818 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -986,6 +986,15 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct bnxt_aux_priv *aux_priv,
 	atomic_set(&rdev->stats.res.pd_count, 0);
 	rdev->cosq[0] = 0xFFFF;
 	rdev->cosq[1] = 0xFFFF;
+	rdev->cq_coalescing.buf_maxtime = BNXT_QPLIB_CQ_COAL_DEF_BUF_MAXTIME;
+	if (bnxt_re_chip_gen_p7(en_dev->chip_num)) {
+		rdev->cq_coalescing.normal_maxbuf = BNXT_QPLIB_CQ_COAL_DEF_NORMAL_MAXBUF_P7;
+		rdev->cq_coalescing.during_maxbuf = BNXT_QPLIB_CQ_COAL_DEF_DURING_MAXBUF_P7;
+	} else {
+		rdev->cq_coalescing.normal_maxbuf = BNXT_QPLIB_CQ_COAL_DEF_NORMAL_MAXBUF_P5;
+		rdev->cq_coalescing.during_maxbuf = BNXT_QPLIB_CQ_COAL_DEF_DURING_MAXBUF_P5;
+	}
+	rdev->cq_coalescing.en_ring_idle_mode = BNXT_QPLIB_CQ_COAL_DEF_EN_RING_IDLE_MODE;
 
 	return rdev;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index ff2340c..e2eea71 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2182,6 +2182,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_create_cq req = {};
 	struct bnxt_qplib_pbl *pbl;
+	u32 coalescing = 0;
 	u32 pg_sz_lvl;
 	int rc;
 
@@ -2208,6 +2209,25 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	req.dpi = cpu_to_le32(cq->dpi->dpi);
 	req.cq_handle = cpu_to_le64(cq->cq_handle);
 	req.cq_size = cpu_to_le32(cq->max_wqe);
+
+	if (_is_cq_coalescing_supported(res->dattr->dev_cap_flags2)) {
+		req.flags |= cpu_to_le16(CMDQ_CREATE_CQ_FLAGS_COALESCING_VALID);
+		coalescing |= ((cq->coalescing->buf_maxtime <<
+				CMDQ_CREATE_CQ_BUF_MAXTIME_SFT) &
+			       CMDQ_CREATE_CQ_BUF_MAXTIME_MASK);
+		coalescing |= ((cq->coalescing->normal_maxbuf <<
+				CMDQ_CREATE_CQ_NORMAL_MAXBUF_SFT) &
+			       CMDQ_CREATE_CQ_NORMAL_MAXBUF_MASK);
+		coalescing |= ((cq->coalescing->during_maxbuf <<
+				CMDQ_CREATE_CQ_DURING_MAXBUF_SFT) &
+			       CMDQ_CREATE_CQ_DURING_MAXBUF_MASK);
+		if (cq->coalescing->en_ring_idle_mode)
+			coalescing |= CMDQ_CREATE_CQ_ENABLE_RING_IDLE_MODE;
+		else
+			coalescing &= ~CMDQ_CREATE_CQ_ENABLE_RING_IDLE_MODE;
+		req.coalescing = cpu_to_le32(coalescing);
+	}
+
 	pbl = &cq->hwq.pbl[PBL_LVL_0];
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&cq->hwq) <<
 		     CMDQ_CREATE_CQ_PG_SIZE_SFT);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index b62df87..fb01576 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -383,6 +383,25 @@ static inline bool bnxt_qplib_queue_full(struct bnxt_qplib_q *que,
 	return avail <= slots;
 }
 
+/* CQ coalescing parameters */
+struct bnxt_qplib_cq_coal_param {
+	u16 buf_maxtime;
+	u8 normal_maxbuf;
+	u8 during_maxbuf;
+	u8 en_ring_idle_mode;
+};
+
+#define BNXT_QPLIB_CQ_COAL_DEF_BUF_MAXTIME		0x1
+#define BNXT_QPLIB_CQ_COAL_DEF_NORMAL_MAXBUF_P7		0x8
+#define BNXT_QPLIB_CQ_COAL_DEF_DURING_MAXBUF_P7		0x8
+#define BNXT_QPLIB_CQ_COAL_DEF_NORMAL_MAXBUF_P5		0x1
+#define BNXT_QPLIB_CQ_COAL_DEF_DURING_MAXBUF_P5		0x1
+#define BNXT_QPLIB_CQ_COAL_DEF_EN_RING_IDLE_MODE	0x1
+#define BNXT_QPLIB_CQ_COAL_MAX_BUF_MAXTIME		0x1bf
+#define BNXT_QPLIB_CQ_COAL_MAX_NORMAL_MAXBUF		0x1f
+#define BNXT_QPLIB_CQ_COAL_MAX_DURING_MAXBUF		0x1f
+#define BNXT_QPLIB_CQ_COAL_MAX_EN_RING_IDLE_MODE	0x1
+
 struct bnxt_qplib_cqe {
 	u8				status;
 	u8				type;
@@ -445,6 +464,7 @@ struct bnxt_qplib_cq {
  */
 	spinlock_t			flush_lock; /* QP flush management */
 	u16				cnq_events;
+	struct bnxt_qplib_cq_coal_param	*coalescing;
 };
 
 #define BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE	sizeof(struct xrrq_irrq)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index ef198a6..115910c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -581,4 +581,9 @@ static inline bool _is_optimize_modify_qp_supported(u16 dev_cap_ext_flags2)
 	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED;
 }
 
+static inline bool _is_cq_coalescing_supported(u16 dev_cap_ext_flags2)
+{
+	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED;
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 69d50d7..58df876 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -1140,6 +1140,7 @@ struct cmdq_create_cq {
 	#define CMDQ_CREATE_CQ_FLAGS_DISABLE_CQ_OVERFLOW_DETECTION     0x1UL
 	#define CMDQ_CREATE_CQ_FLAGS_STEERING_TAG_VALID                0x2UL
 	#define CMDQ_CREATE_CQ_FLAGS_INFINITE_CQ_MODE                  0x4UL
+	#define CMDQ_CREATE_CQ_FLAGS_COALESCING_VALID                  0x8UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
@@ -1172,7 +1173,18 @@ struct cmdq_create_cq {
 	__le32	cq_size;
 	__le64	pbl;
 	__le16	steering_tag;
-	u8	reserved48[6];
+	u8	reserved48[2];
+	__le32  coalescing;
+	#define CMDQ_CREATE_CQ_BUF_MAXTIME_MASK          0x1ffUL
+	#define CMDQ_CREATE_CQ_BUF_MAXTIME_SFT           0
+	#define CMDQ_CREATE_CQ_NORMAL_MAXBUF_MASK        0x3e00UL
+	#define CMDQ_CREATE_CQ_NORMAL_MAXBUF_SFT         9
+	#define CMDQ_CREATE_CQ_DURING_MAXBUF_MASK        0x7c000UL
+	#define CMDQ_CREATE_CQ_DURING_MAXBUF_SFT         14
+	#define CMDQ_CREATE_CQ_ENABLE_RING_IDLE_MODE     0x80000UL
+	#define CMDQ_CREATE_CQ_UNUSED12_MASK             0xfff00000UL
+	#define CMDQ_CREATE_CQ_UNUSED12_SFT              20
+	__le64  reserved64;
 };
 
 /* creq_create_cq_resp (size:128b/16B) */
-- 
2.5.5


