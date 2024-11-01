Return-Path: <linux-rdma+bounces-5688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B99B8981
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6DB21CF6
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645E13A416;
	Fri,  1 Nov 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KO+t9kmx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D15D8F0
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429751; cv=none; b=H/RAscAQEmMy66vNK4ATDpFp3bEuVOBcGEKNkzR3zNoy4qbiQ+lFLbTBFKktf6U6ZSxeZLs5pA7e9NzOgYV2FZQyFdNs6gqzRg9QCN7zPLXYt0evgN0wL2ah5esk0PXBfYjTETwWTjKMJAC+21gICIeqt9tRqs3fMmoCgjQSLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429751; c=relaxed/simple;
	bh=GsucnIxI4k3+W9CTEGuX+lRMsXCqBp8uzd5WvvxejFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H0h3r7zxKJvJFOj0/BoJzt9Md1gL++EsrAeSRYBjMiySs61Ue9Ik65inKwskNEXWjxVUyJN3LCVj5BXOVUS9Uvq+VP+I+LxrC8OZoys2+mPudZwtBBjSZ3Fhh9rH9JzsjcqxXi4v859tdgiJqx0astbKEERzbLfkzvEky8XuwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KO+t9kmx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca388d242so16306515ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730429748; x=1731034548; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zIK0/8dorbRPba2HVo2L6LRJVQqwKTVOwTj9ml8VZjM=;
        b=KO+t9kmxVvxDFcziWP/iywuWUya0va7wJNyLnOzI3AxHAPTkC37PQHZxJGkiVDxP3a
         mQayvx5MHyMCUi2rnT1uC5CIxqk9E8xy6Y0wMxERthPjgFHm54is9JDMHax9zy6fHTj8
         +vDN/ZTdgPKdWCtJSvpwGXyoqhziWdoeuPfz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730429748; x=1731034548;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIK0/8dorbRPba2HVo2L6LRJVQqwKTVOwTj9ml8VZjM=;
        b=tMzcxcTbR0PeIGCOiq4TPa0vUKlmPTL0yWkELAhm1zM7MSI4YEltGbl2hSHtxXkl+t
         0/qOK5Gw0dKN4WkYCPPRfO9Fp4+1lvPjS2wEDNv+Ww5nNn/Izq4UkK5qRhzSNwWWyJLW
         yBZG3CI6NXQS8gm1b2Wjias5zpVPgx/3UxYHk1nJ130VknwzAo3Ngp2eyjEReq7GghmW
         77NFln24JahYjx1rVS3+oTCewlUnVBDCitmvMPpL6AnW2csaqymyJvpsxJtp9ONoeo7w
         lD53mkPS3jlcwI3uGhtm7h3bNSn1/CX4KC3eq0kD3qDr66n2sYEyC5YMaFB9HIxABdgF
         qe+g==
X-Gm-Message-State: AOJu0YwfTYYKE+Qr5ZIonFD12YUD7My9srwtzsYlwBX/ZkEKOPcpY7Jd
	Kao6PGYogKzkp/ISCllk+H9hrf0qKlkg4c7UK3tlSdstPfAK/hQqeZlShXE01QXnd6ArRCiejT8
	=
X-Google-Smtp-Source: AGHT+IEH7zaQHAwdzO9DkE2lJN0RItRnJkRpCynFBUySBpuJHDodCHlObp5950il+z5L8EdXSwlqrw==
X-Received: by 2002:a17:903:41cd:b0:211:18bc:e74b with SMTP id d9443c01a7336-2111af1cfeemr23495835ad.1.1730429748203;
        Thu, 31 Oct 2024 19:55:48 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc1asm14961005ad.57.2024.10.31.19.55.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 19:55:47 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 3/4] RDMA/bnxt_re: Support raw data query for each resources
Date: Thu, 31 Oct 2024 19:34:42 -0700
Message-Id: <1730428483-17841-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
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
index 24124c2..c227fdd0 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -903,6 +903,35 @@ static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
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
@@ -933,6 +962,36 @@ static int bnxt_re_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
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
@@ -977,6 +1036,31 @@ static int bnxt_re_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
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
@@ -1003,6 +1087,36 @@ static int bnxt_re_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq
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
@@ -1063,9 +1177,13 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 
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


