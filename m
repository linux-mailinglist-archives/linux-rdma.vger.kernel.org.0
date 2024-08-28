Return-Path: <linux-rdma+bounces-4601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA9961F17
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D4FB20C8E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE06155A21;
	Wed, 28 Aug 2024 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WQyWK9Bv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15B1552ED
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825393; cv=none; b=koM1KPeiFfehWglGEulLL5ocY3wK1UMUWTlxcIYAVC0BsBjO+R6R6UKOLj0ASvEOTCpLujNIKzCimseHaAgSS/3eda5rjPuXItWuQmctUOUA1hX11dMlAc9O0Gnp9JyzuEyedQZmMaoXrZEheYNuEVDlOuLg3HgqE6nC6dKc8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825393; c=relaxed/simple;
	bh=atrAcBXqGYOwK9IhJ5JVPvzdvvQ4IF74G4Aivl+S04U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npMESPmS2KdPOPfDZmfmksKgLrq1IiGXkW5Bj0WCRxHywy8tQ/y0WkP3TM1ExZgy6D2XTUDqnQb6hXkUm2fn9y1/vRdQu/VDeZ86aDXGCtas8YkpgkjgzdMohmwWPDziIr1lajFquLyb1muRPLR2Uhylqg8Ts1dgl6nQ1QHWFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WQyWK9Bv; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724825389; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PKiV/AnZhD8XWBkIWGSe+NiegrdQamtp1efkIRSVEOQ=;
	b=WQyWK9BvbWvrBeswBft+LY0fRjamzZeJx7ib3M9WFPUpiv2PnHr55PQWsNf2lnOyiyT3sEmFXKgkcCwlMm1Gx0VCO7Y74ExFnx+05aiyNshOXyGsYqjIbCbwHdeFte7IIcx8rxRTukKUzEY2C3ob6DDMtNAS1ZLCVlLHe6txS48=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDonSTL_1724825388)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 14:09:49 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 4/4] RDMA/erdma: Return QP state in erdma_query_qp
Date: Wed, 28 Aug 2024 14:09:44 +0800
Message-Id: <20240828060944.77829-5-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240828060944.77829-1-chengyou@linux.alibaba.com>
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix qp_state and cur_qp_state to return correct values in
struct ib_qp_attr.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 25 ++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 48b08a15e6a8..de11f0f1adb1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1544,11 +1544,31 @@ int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 	return ret;
 }
 
+static inline enum ib_qp_state query_qp_state(struct erdma_qp *qp)
+{
+	switch (qp->attrs.state) {
+	case ERDMA_QP_STATE_IDLE:
+		return IB_QPS_INIT;
+	case ERDMA_QP_STATE_RTR:
+		return IB_QPS_RTR;
+	case ERDMA_QP_STATE_RTS:
+		return IB_QPS_RTS;
+	case ERDMA_QP_STATE_CLOSING:
+		return IB_QPS_ERR;
+	case ERDMA_QP_STATE_TERMINATE:
+		return IB_QPS_ERR;
+	case ERDMA_QP_STATE_ERROR:
+		return IB_QPS_ERR;
+	default:
+		return IB_QPS_ERR;
+	}
+}
+
 int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		   int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
-	struct erdma_qp *qp;
 	struct erdma_dev *dev;
+	struct erdma_qp *qp;
 
 	if (ibqp && qp_attr && qp_init_attr) {
 		qp = to_eqp(ibqp);
@@ -1575,6 +1595,9 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	qp_init_attr->cap = qp_attr->cap;
 
+	qp_attr->qp_state = query_qp_state(qp);
+	qp_attr->cur_qp_state = query_qp_state(qp);
+
 	return 0;
 }
 
-- 
2.31.1


