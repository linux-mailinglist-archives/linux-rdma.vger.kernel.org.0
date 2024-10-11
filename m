Return-Path: <linux-rdma+bounces-5374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDD999C16
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 07:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D071F24A28
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FDD1F9401;
	Fri, 11 Oct 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F53Mm2Pq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F01F9406
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624294; cv=none; b=R0MsztaCyhInbNorscVBVoM4ji0k4RdwdhDAIts7no2OXVBVc8QHuEXvm3uJZg1/xU9QPHNoD5z4Gmp5mOR/5RIiYt9BegPdzo5WiuzJbPuiowbo8jBygRVblHu2HcfXSoag1he0nBKQuucRM/IHtK3Crrk3/APd1g/l3Y5Zc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624294; c=relaxed/simple;
	bh=9F27MqjdGLMNMdDCB2gUmqnORLZ4TgMSEIX1X2GxIT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OpSzAhHHCVR7JPEf6EkxpU7q/PueL010gJqhPGnYpGiZKye3ZWsp6cG6Y2AqA7QgM9LZ0JrbFjvyalr4WcZ/ni93bJVbycq8vyeNziz3oN+l0C2+lJZLVtWMLkLpcApxJe99E4SPqbT7UCKYwzmBZnvoVSlUq+nDC9YV/hgTm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F53Mm2Pq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so439259a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 22:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728624291; x=1729229091; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Ey5dXfCeKCOImhyt9jiF8giNPGPemECAFJc7DJO6hc=;
        b=F53Mm2PqhSo2cvZWQibDkQuTlf9qZMLGtwudtv5m/Ju6eR/MF+LyQsTskS8mUJ5DXG
         +JYHX7PE1J1eoA2YUR4Tqv+eDADCuG0lFln+yfGENcGPXpD0J0eGNZbcryjXZdzNf81N
         Apv9ucQb6QqO1xonpr9XLSArTKb9nGTff7uTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624291; x=1729229091;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ey5dXfCeKCOImhyt9jiF8giNPGPemECAFJc7DJO6hc=;
        b=sm6V/kYFofWmQFftH4NuISQYV4QzQN7M9ZQTlH9902ePvrJiH43F6Uj1OY/KsmYKv+
         cpLASrIg+bNsqvpTbchVHKaM203/VIzypAD2UPylXjv0dwhrxKYBEKMJsFuMjIHr/AZz
         eI/bl3zYfUicBYy7dmekUE6oIQerhlMd/HPUIJYsNttGQvLh3vFb+bZSToDJVUCQr80R
         V8sZC3y+Yhu14dfPvQxkooMoMPAg7vBw09/QkppKxEuQMNK2/A55i64UOUvzCLPtcSKx
         u0pzN4QCrLuuEKbiQkivOj3VY06IKCp8hg/NCKjOc+ssS6bAuiQ2JBUAxCFyirBQjAGd
         BojQ==
X-Gm-Message-State: AOJu0YytUxgdv/8bUzUpfGeuSmh/kfulC7UWmfH+W1qQpMFDP4eOx/7g
	WbQYVk4l89/FnN28AKru9PbfuGsYQPXJVdtfPZJjBSt8axwp0Yez2Z1GVfBIYQ==
X-Google-Smtp-Source: AGHT+IGuCcfcmG3X2iycqgj6ITFXECgMhcfqlAZcXs50BxcVblko94IPLj9GXO3q9KU6lDc/lOi+sQ==
X-Received: by 2002:a17:90a:d987:b0:2c8:647:1600 with SMTP id 98e67ed59e1d1-2e2f0a62d56mr2155334a91.9.1728624291423;
        Thu, 10 Oct 2024 22:24:51 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f09ff1sm2377069a91.26.2024.10.10.22.24.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 22:24:50 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/4] RDMA/bnxt_re: Add support for CQ rx coalescing
Date: Thu, 10 Oct 2024 22:03:53 -0700
Message-Id: <1728623035-30657-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
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
index 775604f..ffa7634 100644
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


