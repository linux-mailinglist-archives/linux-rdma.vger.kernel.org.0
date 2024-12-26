Return-Path: <linux-rdma+bounces-6747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FE9FC9D2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B751F7A151E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89A14A609;
	Thu, 26 Dec 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eZ1VhX+9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB29170A1A
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735202515; cv=none; b=Wd1WI/MYP/KQyEdGeRyi0l4MYRCFCJ+09pUULaqn8VGJeVUWWvPIv4t+tHp4evGE39jmt9ifbtRJaeD+p/t1PARYJvbfkR7J4tRXdnCqSNKAOSardanOAp8LlDrSgxvoJ7Nc+7sHXIvtNkg9HguFCL2pRSNbSE2Bo81SPZEKCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735202515; c=relaxed/simple;
	bh=dpI/Oe4NzgikgGHXxvT0YTdZ8vW3uTVLUV5uPZRktLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhwFH8uaXcPdlz06G7v5xJSyqmqneYMN3065uTTPtiSdemWHxJGoCzXvJL/4lOxlk8IO6KoUHT8XCFvz5ABLdTavCtdaQoMS0MZO8OUY+83ucYiQH7fEPvbS2957tpBZvi5F+DMaxu3VI6dhbNRK6g44OScd0ayTufP5WmdvKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eZ1VhX+9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735202505; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZH2tWDpZsgct1ovsI23CJOr5jWl2TbMKA/kqK9o+xao=;
	b=eZ1VhX+9APN5ZbPiezp/Z+5NlsdiYaD3gfm4bUr9roXyBhUoyQEbppwFcGXwhaa4Fb59czP9p1gEg1taI9Oa7OycnmxJXes4iYrjlHJ1TYOqj/dqCxhOi3Ow6GsIFrJHAAi7rPAwH42qtRZPyyJeCcMSRXGWi4uWSpz8n2XcgLQ=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WMHVs9Q_1735202504 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 16:41:44 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 2/4] RDMA/erdma: Fix incorrect response returned from query_qp
Date: Thu, 26 Dec 2024 16:41:09 +0800
Message-ID: <20241226084141.74823-3-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
References: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The erdma_post_cmd_wait() function returns the cmdq response
only when both resp0 and resp1 are not NULL.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index e7967193ac82..27e03474e348 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1799,7 +1799,7 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	struct erdma_cmdq_query_qp_req_rocev2 req;
 	struct erdma_dev *dev;
 	struct erdma_qp *qp;
-	u64 resp;
+	u64 resp0, resp1;
 	int ret;
 
 	if (ibqp && qp_attr && qp_init_attr) {
@@ -1833,20 +1833,20 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 					CMDQ_OPCODE_QUERY_QP);
 		req.qpn = QP_ID(qp);
 
-		ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp,
-					  NULL);
+		ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
+					  &resp1);
 		if (ret)
 			return ret;
 
 		qp_attr->sq_psn =
-			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_SQ_PSN_MASK, resp);
+			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_SQ_PSN_MASK, resp0);
 		qp_attr->rq_psn =
-			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_RQ_PSN_MASK, resp);
-		qp_attr->qp_state = rocev2_to_ib_qps(
-			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_QP_STATE_MASK, resp));
+			FIELD_GET(ERDMA_CMD_QUERY_QP_RESP_RQ_PSN_MASK, resp0);
+		qp_attr->qp_state = rocev2_to_ib_qps(FIELD_GET(
+			ERDMA_CMD_QUERY_QP_RESP_QP_STATE_MASK, resp0));
 		qp_attr->cur_qp_state = qp_attr->qp_state;
 		qp_attr->sq_draining = FIELD_GET(
-			ERDMA_CMD_QUERY_QP_RESP_SQ_DRAINING_MASK, resp);
+			ERDMA_CMD_QUERY_QP_RESP_SQ_DRAINING_MASK, resp0);
 
 		qp_attr->pkey_index = 0;
 		qp_attr->dest_qp_num = qp->attrs.rocev2.dst_qpn;
-- 
2.46.0


