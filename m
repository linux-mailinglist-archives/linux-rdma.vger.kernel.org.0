Return-Path: <linux-rdma+bounces-5686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13709B897F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47511C209C8
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 02:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F013A416;
	Fri,  1 Nov 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oq+4R1/t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18E5D8F0
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429745; cv=none; b=qptgx05zYkJEo4VGvgOiQqUC06klQd6nHeX7j2dnFs+OibTwKHWGVTHN6q3GUGnyt4pTplZZGY+smbwNnUHSYCJxRhRCfqGnrIHwLka38ZmqVe7+/3ZBXeSEcIhSEKi8Lcvr2xCN4TRRz9iuGTAJhS0yniX4vusbL1aymcWpX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429745; c=relaxed/simple;
	bh=+nEGVLypFOA+tV79l+RRx1Z2yCGLIpVpRLqaMLLOsrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RCyOsJZm/m4OnszZ5eUKGsu0wyqfKHWbkAV3F2CSNmvRm8VFgvPAcMS5azUGrDqba18LxgP7M3JLjWfo52nQCJmypuS8blXBDqlmH8YRX7Y/68eW3ZQUiacJ4BJxAbHJl1qGzJQp3volP3NQ8qY6+mn2ckr4R0V/P2caOCaHifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Oq+4R1/t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c803787abso12508395ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730429742; x=1731034542; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+j42xfiCbwQYMme/yv6J3XnO7iBC56CT7KzgmPTIH4=;
        b=Oq+4R1/tTA5T2uK7upSmrNatJV0ro1XbZROnkcTR+zWwIO66n8U3bKY0Z1iAoq/F1L
         RclyqDGr+CVaZfihoRdvC4YG4vmRB4J3/G6uLf/F76iKPlRWbkmzMuHhl1kjhFNnyrcx
         JsowUyJwWpCLMl2CUMIJ6+ovV8YXMVP5G624A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730429742; x=1731034542;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+j42xfiCbwQYMme/yv6J3XnO7iBC56CT7KzgmPTIH4=;
        b=Jv6//jpKE0QPAs5rp6viIfByXsMFTv32Ca/ETqCUs+fpb4lqlaqdHuAAenMe3ejT1L
         Njlzz/AE1myqJTQW762jXu1wJaTQAsspTar0oV+v1L9i73khODcOZR0NNOzuolFU5/id
         VQUilmTOh6GcK2vcXtUxx0pnX8vUlYXFE20hs1HMRWqnjYGAnKYJ2cxloZG+mMtAG2TA
         cTP6lRiBIOKsLROv8m5bskK9FTfAaxpjx0m1IY6oWm+TMC+QowKpqlO6VaCo1LLRT9yh
         ZvJua5B3Ei3tel1q+iD6xVwc+kDirOYCWomldEwKsrgZugl5P4LhgbhoKwJE7AUtk41X
         BHSw==
X-Gm-Message-State: AOJu0YzHdT+la/+Q9M3ut29Se78wOgr1odcTIwvb84/zApswYV9sb+z6
	wKRBnW4N8MizjiQXbv+7eWJW0dAtRWnkkrEbRudbPTZml8IWvyKG0BgjyE4CIw==
X-Google-Smtp-Source: AGHT+IEHYQM0g8yKi/VDD/iIKZyQE4GF383tMCjdEXVscytUaDtyNZqBa3peHVSzIPEsZxO3G3fEHg==
X-Received: by 2002:a17:903:230a:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-211194691a8mr31175955ad.22.1730429742110;
        Thu, 31 Oct 2024 19:55:42 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc1asm14961005ad.57.2024.10.31.19.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 19:55:41 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/4] RDMA/bnxt_re: Support driver specific data collection using rdma tool
Date: Thu, 31 Oct 2024 19:34:40 -0700
Message-Id: <1730428483-17841-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Allow users to dump driver specific resource details when
queried through rdma tool. This supports the driver data
for QP, CQ, MR and SRQ.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
v1 - v2 :
	- Remove the unnecessary user/kernel text
	  displayed in dump output
 drivers/infiniband/hw/bnxt_re/main.c | 141 +++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d825eda..24124c2 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -870,6 +870,139 @@ static const struct attribute_group bnxt_re_dev_attr_group = {
 	.attrs = bnxt_re_attributes,
 };
 
+static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
+{
+	struct bnxt_qplib_hwq *mr_hwq;
+	struct nlattr *table_attr;
+	struct bnxt_re_mr *mr;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	mr = container_of(ib_mr, struct bnxt_re_mr, ib_mr);
+	mr_hwq = &mr->qplib_mr.hwq;
+
+	if (rdma_nl_put_driver_u32(msg, "page_size",
+				   mr_hwq->qe_ppg * mr_hwq->element_size))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "max_elements", mr_hwq->max_elements))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "element_size", mr_hwq->element_size))
+		goto err;
+	if (rdma_nl_put_driver_u64_hex(msg, "hwq", (unsigned long)mr_hwq))
+		goto err;
+	if (rdma_nl_put_driver_u64_hex(msg, "va", mr->qplib_mr.va))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+static int bnxt_re_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
+{
+	struct bnxt_qplib_hwq *cq_hwq;
+	struct nlattr *table_attr;
+	struct bnxt_re_cq *cq;
+
+	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
+	cq_hwq = &cq->qplib_cq.hwq;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (rdma_nl_put_driver_u32(msg, "cq_depth", cq_hwq->depth))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "max_elements", cq_hwq->max_elements))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "element_size", cq_hwq->element_size))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "max_wqe", cq->qplib_cq.max_wqe))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+static int bnxt_re_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
+{
+	struct bnxt_qplib_qp *qplib_qp;
+	struct nlattr *table_attr;
+	struct bnxt_re_qp *qp;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	qplib_qp = &qp->qplib_qp;
+
+	if (rdma_nl_put_driver_u32(msg, "sq_max_wqe", qplib_qp->sq.max_wqe))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "sq_max_sge", qplib_qp->sq.max_sge))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "sq_wqe_size", qplib_qp->sq.wqe_size))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "sq_swq_start", qplib_qp->sq.swq_start))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "sq_swq_last", qplib_qp->sq.swq_last))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "rq_max_wqe", qplib_qp->rq.max_wqe))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "rq_max_sge", qplib_qp->rq.max_sge))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "rq_wqe_size", qplib_qp->rq.wqe_size))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "rq_swq_start", qplib_qp->rq.swq_start))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "rq_swq_last", qplib_qp->rq.swq_last))
+		goto err;
+	if (rdma_nl_put_driver_u32(msg, "timeout", qplib_qp->timeout))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+static int bnxt_re_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq)
+{
+	struct nlattr *table_attr;
+	struct bnxt_re_srq *srq;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
+
+	if (rdma_nl_put_driver_u32_hex(msg, "wqe_size", srq->qplib_srq.wqe_size))
+		goto err;
+	if (rdma_nl_put_driver_u32_hex(msg, "max_wqe", srq->qplib_srq.max_wqe))
+		goto err;
+	if (rdma_nl_put_driver_u32_hex(msg, "max_sge", srq->qplib_srq.max_sge))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
 static const struct ib_device_ops bnxt_re_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_BNXT_RE,
@@ -928,6 +1061,13 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, bnxt_re_ucontext, ib_uctx),
 };
 
+static const struct ib_device_ops restrack_ops = {
+	.fill_res_cq_entry = bnxt_re_fill_res_cq_entry,
+	.fill_res_qp_entry = bnxt_re_fill_res_qp_entry,
+	.fill_res_mr_entry = bnxt_re_fill_res_mr_entry,
+	.fill_res_srq_entry = bnxt_re_fill_res_srq_entry,
+};
+
 static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 {
 	struct ib_device *ibdev = &rdev->ibdev;
@@ -949,6 +1089,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 		ibdev->driver_def = bnxt_re_uapi_defs;
 
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
+	ib_set_device_ops(ibdev, &restrack_ops);
 	ret = ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
 	if (ret)
 		return ret;
-- 
2.5.5


