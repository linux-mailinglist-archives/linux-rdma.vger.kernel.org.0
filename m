Return-Path: <linux-rdma+bounces-5471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F449AA021
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 12:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C94D1F23626
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1D1990BD;
	Tue, 22 Oct 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UN3XBmCP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996C146A63
	for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593182; cv=none; b=FepfE2tnibu+GCHVF4CG96QqvTo6hDwN0MuDwe7PvXB57uPKS8mYRQ5fwhlM290grq7eI6oQVsElDjroE7W643t9Nns8tT6Tv2rfrjADk09lzWEb9MH7GiyBXD2XylL3nhBvGtMUwFhLlUYzPRJZY9WZI32valPt9dmTUa6FyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593182; c=relaxed/simple;
	bh=0JvL9jRgE84RetBamZZcN+EabZ4AhUwAJ5dqXtr3YRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mPqKdMOmxpBGXlgILZu5UytE/OTYCaUM7vYUbMW9AJhzDaG71F0trs4dEjZojyqhBeKSLs83tFIDa0A9YO/oq+a9X61G9PO4EJcJNwMW+wvCS3adwUJ1g4eLII91fNWVcIIxaQAfDuqNMANbHCgMPoa/AyoEaczM1MATQiD2F8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UN3XBmCP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso3640629b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729593180; x=1730197980; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X79VEdxrLWJrrAdp8b9ykUNPfgkFAVyCrlHuiqV7UhM=;
        b=UN3XBmCPBqxM8GmXrW/ej9aREi4ECB9TOdjXAIhMpx1UX2KAI0QMk0NQ67Vambonax
         ojZfHNU7AnCjkv2ngZSZzO71pwdv7C2SmhMwMb9cqp0mTYRTjcCdfAC0rGE5u14ikt67
         gblAojwWtwiAqjJxbArkhDShp4ocODC94AqJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593180; x=1730197980;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X79VEdxrLWJrrAdp8b9ykUNPfgkFAVyCrlHuiqV7UhM=;
        b=Pkc0O8uvV6i3RiUm01qtQ5wHlM++r41cYwwHPuaU4t0I/0+KL9cPLeMNNLUZ9zZY1G
         mJOyI2VkELu70mFz/3p0innEEfrfhFruEidQKdQAXxej/nJEM25mClVzOH12KbXzc0m9
         rokGWIFetb/uVcRHU1gNHR5FgBNPe4vg7BWM86MIaikTrgRuIgzEqU6u4mDUptpzsFqH
         uJ/aRBFQ7upDZs0lHQtB3MsozfqmunBl8dIeVGzqtuahY2CP79NEz+fKZXbdq47maRoe
         lMrvoXB4H200D5Mt2vXcqxBn+rQjHh71qaqX8q8kCrYoqO/CHgaqb67PEEDsb3NNuOtJ
         aZdA==
X-Gm-Message-State: AOJu0YzOr2MNXpqnUU3msvZDZvXhc1JdCuM9/n4nC5LeRT1W837Zho25
	+6I/V3BNpwb7oo7TgkgKtttaaVKPOPtHJZnT85g6QiEGWkaL8nES+SDfMzz6vw==
X-Google-Smtp-Source: AGHT+IF+qtYgCDErGNgbFRDL9s2I9bL+acR3SDblTTC2w8uVeJ9NjWOk4sOxhTAWOi3KwJ2FVzyAtg==
X-Received: by 2002:a05:6a00:1495:b0:71e:4ba:f389 with SMTP id d2e1a72fcca58-71ea314ee9cmr19925919b3a.10.1729593180251;
        Tue, 22 Oct 2024 03:33:00 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131393dsm4414572b3a.37.2024.10.22.03.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:32:59 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/4] RDMA/bnxt_re: Support raw data query for each resources
Date: Tue, 22 Oct 2024 03:11:55 -0700
Message-Id: <1729591916-29134-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Support interfaces to get the raw data for each of
the resources. Use this interface to get some of the
HW structures from active resources.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 118 +++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 5bed9af..0a18d24 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -918,6 +918,35 @@ static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
 	return -EMSGSIZE;
 }
 
+static int bnxt_re_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr)
+{
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_mr *mr;
+	int err, len;
+	void *data;
+
+	mr = container_of(ib_mr, struct bnxt_re_mr, ib_mr);
+	rdev = mr->rdev;
+
+	err = bnxt_re_read_context_allowed(rdev);
+	if (err)
+		return err;
+
+	len = bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx) ? BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P7 :
+							  BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5;
+	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = bnxt_qplib_read_context(&rdev->rcfw, CMDQ_READ_CONTEXT_TYPE_MRW,
+				      mr->qplib_mr.lkey, len, data);
+	if (!err)
+		err = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, len, data);
+
+	kfree(data);
+	return err;
+}
+
 static int bnxt_re_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 {
 	struct bnxt_qplib_hwq *cq_hwq;
@@ -948,6 +977,36 @@ static int bnxt_re_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 	return -EMSGSIZE;
 }
 
+static int bnxt_re_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq)
+{
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_cq *cq;
+	int err, len;
+	void *data;
+
+	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
+	rdev = cq->rdev;
+
+	err = bnxt_re_read_context_allowed(rdev);
+	if (err)
+		return err;
+
+	len = bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx) ? BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P7 :
+					BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5;
+	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = bnxt_qplib_read_context(&rdev->rcfw,
+				      CMDQ_READ_CONTEXT_TYPE_CQ,
+				      cq->qplib_cq.id, len, data);
+	if (!err)
+		err = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, len, data);
+
+	kfree(data);
+	return err;
+}
+
 static int bnxt_re_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
 {
 	struct bnxt_qplib_qp *qplib_qp;
@@ -996,6 +1055,31 @@ static int bnxt_re_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
 	return -EMSGSIZE;
 }
 
+static int bnxt_re_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp)
+{
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibqp->device, ibdev);
+	int err, len;
+	void *data;
+
+	err = bnxt_re_read_context_allowed(rdev);
+	if (err)
+		return err;
+
+	len = bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx) ? BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P7 :
+							  BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5;
+	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = bnxt_qplib_read_context(&rdev->rcfw, CMDQ_READ_CONTEXT_TYPE_QPC,
+				      ibqp->qp_num, len, data);
+	if (!err)
+		err = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, len, data);
+
+	kfree(data);
+	return err;
+}
+
 static int bnxt_re_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq)
 {
 	struct nlattr *table_attr;
@@ -1022,6 +1106,36 @@ static int bnxt_re_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq
 	return -EMSGSIZE;
 }
 
+static int bnxt_re_fill_res_srq_entry_raw(struct sk_buff *msg, struct ib_srq *ib_srq)
+{
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_srq *srq;
+	int err, len;
+	void *data;
+
+	srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
+	rdev = srq->rdev;
+
+	err = bnxt_re_read_context_allowed(rdev);
+	if (err)
+		return err;
+
+	len = bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx) ? BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P7 :
+							  BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P5;
+
+	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = bnxt_qplib_read_context(&rdev->rcfw, CMDQ_READ_CONTEXT_TYPE_SRQ,
+				      srq->qplib_srq.id, len, data);
+	if (!err)
+		err = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, len, data);
+
+	kfree(data);
+	return err;
+}
+
 static const struct ib_device_ops bnxt_re_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_BNXT_RE,
@@ -1081,9 +1195,13 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 
 static const struct ib_device_ops restrack_ops = {
 	.fill_res_cq_entry = bnxt_re_fill_res_cq_entry,
+	.fill_res_cq_entry_raw = bnxt_re_fill_res_cq_entry_raw,
 	.fill_res_qp_entry = bnxt_re_fill_res_qp_entry,
+	.fill_res_qp_entry_raw = bnxt_re_fill_res_qp_entry_raw,
 	.fill_res_mr_entry = bnxt_re_fill_res_mr_entry,
+	.fill_res_mr_entry_raw = bnxt_re_fill_res_mr_entry_raw,
 	.fill_res_srq_entry = bnxt_re_fill_res_srq_entry,
+	.fill_res_srq_entry_raw = bnxt_re_fill_res_srq_entry_raw,
 };
 
 static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
-- 
2.5.5


