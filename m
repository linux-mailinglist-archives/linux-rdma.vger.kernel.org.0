Return-Path: <linux-rdma+bounces-5469-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF59AA020
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 12:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F79B22476
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24351993AF;
	Tue, 22 Oct 2024 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SA5oTOdU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A8146A63
	for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593179; cv=none; b=uJh01IU6/cBolgLanTD+RxAkphVc0ts8jmM7H2s8lQcKvG9Bd17em/kkLkMFONYFIMdPGfRYe/gX2m7ec+m3jNhoDHgDzhi38o4wlHoRniwlhAqlH4ZG+qPxbeWvPBEfEpe2t+3KQn58zO7exu4nsUd4TJ48ECGhnpczTPhkv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593179; c=relaxed/simple;
	bh=ljts7FtNkDVMjHieNDpWMTEl3ZOla0ETFs7mm3Ua5bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Q5czVHsuBhxnQZ46dWiVK2Vs+wKxIqX8MS6oTH3Gs/YBkocxWb99YJ3zUfBJTgfi6zQhq/DiJm+85dAkPoH2qr1j45lJxdkh1W9NXMnFMq/BrdgndH2IheZxFSs6t7tW+WdANf9lC/ICppcEVCEBHDF7Ggt4M7c0lQnTcShxPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SA5oTOdU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e7086c231so4113996b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729593174; x=1730197974; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gJbXC4hZbxY+tzVhIG1PR2dp81cu3i5BxtqvspIELk=;
        b=SA5oTOdUw9WHw74rUltwEwjagWIYHm8w070kpBEJMWdvWuPQ0Sa3CXWAM/LEVvKP0P
         lGOv9wdi4IZGy/ce8+4RsqZzDgloFp4+li9QFn1PuPtIi6a9I+Tl18clLzLlKlbZLqRr
         LaFj5wT2gj8jmtK3lgYvforjbjMgVsUrybgfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593174; x=1730197974;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gJbXC4hZbxY+tzVhIG1PR2dp81cu3i5BxtqvspIELk=;
        b=n+cgjGTUtpw2P1ohLL+uoikMlKFgYg4rnJpHJo6Lcm206SbpfTkvVflB2FDoXEC+Lp
         ulpsAjiVWVLpMJTwDhHrCWqUcxDP3wrDWz9fqVrxdn21jXoeS67M6MxCunPsQz1C1AUl
         BQOdPC+KnQA42V2B+IxF31EAUadLcDEC2D0CAgRPZ35ip73v4EoHYrxT7ESkGHCJJFuf
         8DA5Sw8qgigmyR9HB/MzIm0sdy+6MY01BfMyYukcH5OekdyhV6VyRW5Gu7UlNtfq8gMD
         sAlWOjvTyqIA7mHu3aZXDHflTYGCF6Iz0BcxtZByKVr5unvUIG9a1pk6ECpbcjN21Gjc
         1Ojg==
X-Gm-Message-State: AOJu0YzjqeHaZLRSMlx0YERVm+aEC4Kh5qw/QupwiJNFmNQFg6IrjMZ9
	/mvAXth2xxsETlHKC3Qpn/dheJBtqgJoq8mFMv7aA0ad1AA5nsfPpQsZnIJ6lw==
X-Google-Smtp-Source: AGHT+IHvGEcehQe0U4/Md5BQDQgE5xt5Su4/72OJZWn7M2QJvNke9wFVXZSTWKUFeczzn5HO6nTJgQ==
X-Received: by 2002:a05:6a21:3a4a:b0:1d8:ac0b:2f63 with SMTP id adf61e73a8af0-1d92c583c5cmr18541830637.47.1729593174365;
        Tue, 22 Oct 2024 03:32:54 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131393dsm4414572b3a.37.2024.10.22.03.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:32:53 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: Support driver specific data collection using rdma tool
Date: Tue, 22 Oct 2024 03:11:53 -0700
Message-Id: <1729591916-29134-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c | 148 +++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 6715c96..5bed9af 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -882,6 +882,146 @@ static const struct attribute_group bnxt_re_dev_attr_group = {
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
+	if (rdma_nl_put_driver_string(msg, "owner",
+				      mr_hwq->is_user ?  "user" : "kernel"))
+		goto err;
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
+	if (rdma_nl_put_driver_string(msg, "owner",
+				      ib_qp->uobject ?  "user" : "kernel"))
+		goto err;
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
@@ -939,6 +1079,13 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
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
@@ -960,6 +1107,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 		ibdev->driver_def = bnxt_re_uapi_defs;
 
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
+	ib_set_device_ops(ibdev, &restrack_ops);
 	ret = ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
 	if (ret)
 		return ret;
-- 
2.5.5


