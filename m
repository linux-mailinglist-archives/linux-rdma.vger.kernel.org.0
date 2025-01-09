Return-Path: <linux-rdma+bounces-6938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B89A07FFB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120BF3A4282
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6B2046A3;
	Thu,  9 Jan 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PyzA0ymi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658961B041A
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jan 2025 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447947; cv=none; b=niQIWNcqfdqVOOtVrr8utbeHILRFBPQzNR4cxNkw5iozpr2sXW1dNKbMayh6hLOuhW0qNluwCZAFnUpqYWsPjNkvPHDExoyEpuqLIHf0diwdAVXn0vm35UeokJhBgWz8qeFpbU2V2Rpni1Up5at6E2LrTKPHq/G9615oH81GaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447947; c=relaxed/simple;
	bh=VXvyLI4Np6e787gB+qkdWjKO/idxMc2c/2HQgbW9ov0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MoiknqSFE2QL4SGsWw5Zg2E2nXrJhG0v94sD5mnU1DnY715Cfbo3O5SXoFjt3nq6a04gRspxgHx5jfdoyV2LlKW1SraI+yqPBmnQRf+UErWG++LPzoBlee0OO1pNvW5fWw8vgk6ADHBWMuxNkA7OWzW5y7n91lqGSsJ5kmDnykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PyzA0ymi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216281bc30fso23635655ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jan 2025 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736447944; x=1737052744; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jn8wI4w7S6deQMlvwHSS8AZVsJy/2z8MoGv6oXde1A=;
        b=PyzA0ymiP7yytllUadl6TKXGsSYuyt3yiQ+lYwped3qC6y+112CQ6+wKQOGoj4UoQj
         ShdnQsjfHhLW9QkpnSwlMjo4dS4i/s7aAnTqcx13tGgWSLFLsx464gOB5iNXdvJxViib
         ZOptG0EGusavLy6S5W9+OfJyKMhby1Os8c+cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447944; x=1737052744;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jn8wI4w7S6deQMlvwHSS8AZVsJy/2z8MoGv6oXde1A=;
        b=pg9jmpZxoG/u54cirnifkiP+qrphmZdZ9AN4B6Ntlbit+1rh6Wv0P+y3rk++EOvicu
         NyhSTtW8SrxjSSFfqp9Dl/i3XjT5kstCX/T0Ni3180d/F4TZtlYNc4xk/HJbblVTMXfV
         9AbdgK6tn/0McvLJI/mR9LfvNyE4kbOzBOdWMS1AhPuw0ltCI3K6mIOFRk7NG0dMHG0+
         uR3m/V6IUOz9lAkejf0+Tj12swWMPczESIvaN714sK6t/AQ3MIcbFgTP248kYI0JMplL
         ke02np8/dtzTqTQz/MHXWnh7JNZEP8T/JFq/z1IJ+ymJO2NiMfJqDW2EgT42+p9csQbR
         NlOw==
X-Gm-Message-State: AOJu0YzSoHC0R0fj6ghJe6GqFH55/g51qO6tiA/lYNyErrSe0S358CUp
	xSIHvSJ+qZOL4vu19q3w208rl+4jJBuyjQyE2xtapJg09Qf17ukbVT+MuDvBwg==
X-Gm-Gg: ASbGnctFgN/Mgizbfo+9Ssk8GhvQpQ+nxbbD/d4lq8tGWypV2GXdor331d+PcTROMGm
	tFD9gbx6t8BNlYX4SkLPIJbr9tzD5Lq5DYaHfA78DT6h0xhtjSpYNFC4uifbrnzTQvld523F7Jz
	2EvdIcJwzi5Z2n+jGi377ccjlr4H8y0K3q/KkIdXDhYEDFNTeb5Ru6ty2LB0L6xIlmx6cQgPQya
	ev5kFp7r2tnP1/fW7Q/1dVXIzycOF1OQF+y0nMJDmLIBnQcdYz+SsOCJdHznfcsldCHNtTMVhfb
	pHUkup0BmElsfHUsIU02tguSGII3hakQsP1F
X-Google-Smtp-Source: AGHT+IGKAlxAChwoETFVrg0XmAegdAvMHIFl/o8JJ0ChsyS63wyaZhChzBQ/YpVFjQSK28gNrqJDjQ==
X-Received: by 2002:a17:902:f70f:b0:216:32ea:c84b with SMTP id d9443c01a7336-21a83fc3652mr123710625ad.37.1736447944493;
        Thu, 09 Jan 2025 10:39:04 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22dd30sm1017475ad.171.2025.01.09.10.39.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 10:39:04 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: Allocate dev_attr information dynamically
Date: Thu,  9 Jan 2025 10:18:13 -0800
Message-Id: <1736446693-6692-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
References: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

In order to optimize the size of driver private structure,
the memory for dev_attr is allocated dynamically during the
chip context initialization. In order to make certain runtime
decisions, store dev_attr in the qplib_res structure.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  2 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 38 ++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/main.c        | 36 +++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |  7 +++---
 drivers/infiniband/hw/bnxt_re/qplib_res.h   |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  3 +--
 8 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index dc2b193..b91a85a 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -204,7 +204,7 @@ struct bnxt_re_dev {
 	struct bnxt_re_nq_record	*nqr;
 
 	/* Device Resources */
-	struct bnxt_qplib_dev_attr	dev_attr;
+	struct bnxt_qplib_dev_attr	*dev_attr;
 	struct bnxt_qplib_ctx		qplib_ctx;
 	struct bnxt_qplib_res		qplib_res;
 	struct bnxt_qplib_dpi		dpi_privileged;
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 77ec2ed..3ac47f4 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -348,7 +348,7 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			goto done;
 		}
 		bnxt_re_copy_err_stats(rdev, stats, err_s);
-		if (_is_ext_stats_supported(rdev->dev_attr.dev_cap_flags) &&
+		if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags) &&
 		    !rdev->is_virtfn) {
 			rc = bnxt_re_get_ext_stat(rdev, stats);
 			if (rc) {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 27efaaf..8b5435e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -159,7 +159,7 @@ static int __qp_access_flags_to_ib(struct bnxt_qplib_chip_ctx *cctx, u8 qflags)
 static void bnxt_re_check_and_set_relaxed_ordering(struct bnxt_re_dev *rdev,
 						   struct bnxt_qplib_mrw *qplib_mr)
 {
-	if (_is_relaxed_ordering_supported(rdev->dev_attr.dev_cap_flags2) &&
+	if (_is_relaxed_ordering_supported(rdev->dev_attr->dev_cap_flags2) &&
 	    pcie_relaxed_ordering_enabled(rdev->en_dev->pdev))
 		qplib_mr->flags |= CMDQ_REGISTER_MR_FLAGS_ENABLE_RO;
 }
@@ -184,7 +184,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_udata *udata)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
@@ -273,7 +273,7 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 		       struct ib_port_attr *port_attr)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	int rc;
 
 	memset(port_attr, 0, sizeof(*port_attr));
@@ -331,8 +331,8 @@ void bnxt_re_query_fw_str(struct ib_device *ibdev, char *str)
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 
 	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d.%d.%d.%d",
-		 rdev->dev_attr.fw_ver[0], rdev->dev_attr.fw_ver[1],
-		 rdev->dev_attr.fw_ver[2], rdev->dev_attr.fw_ver[3]);
+		 rdev->dev_attr->fw_ver[0], rdev->dev_attr->fw_ver[1],
+		 rdev->dev_attr->fw_ver[2], rdev->dev_attr->fw_ver[3]);
 }
 
 int bnxt_re_query_pkey(struct ib_device *ibdev, u32 port_num,
@@ -583,7 +583,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.pd = &pd->qplib_pd;
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
-	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+	if (!_is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags)) {
 		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
@@ -1060,7 +1060,7 @@ static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	align = sizeof(struct sq_send_hdr);
 	ilsize = ALIGN(init_attr->cap.max_inline_data, align);
@@ -1280,7 +1280,7 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	rq = &qplqp->rq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (init_attr->srq) {
 		struct bnxt_re_srq *srq;
@@ -1317,7 +1317,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
@@ -1343,7 +1343,7 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	sq->max_sge = init_attr->cap.max_send_sge;
 	entries = init_attr->cap.max_send_wr;
@@ -1396,7 +1396,7 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
@@ -1445,7 +1445,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
@@ -1615,7 +1615,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	ib_pd = ib_qp->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
@@ -1843,7 +1843,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	ib_pd = ib_srq->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
 
 	if (srq_init_attr->attr.max_wr >= dev_attr->max_srq_wqes) {
@@ -2047,7 +2047,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 {
 	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 	struct bnxt_re_dev *rdev = qp->rdev;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	enum ib_qp_state curr_qp_state, new_qp_state;
 	int rc, entries;
 	unsigned int flags;
@@ -3089,7 +3089,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
 	int cqe = attr->cqe;
 	int rc, entries;
@@ -3224,7 +3224,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 
 	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	if (!ibcq->uobject) {
 		ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
 		return -EOPNOTSUPP;
@@ -4197,7 +4197,7 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_MR;
 
-	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+	if (!_is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags)) {
 		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to allocate MR rc = %d", rc);
@@ -4289,7 +4289,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	struct bnxt_re_ucontext *uctx =
 		container_of(ctx, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_uctx_resp resp = {};
 	struct bnxt_re_uctx_req ureq = {};
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 33956fc..7c7057b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -148,6 +148,10 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 
 	if (!rdev->chip_ctx)
 		return;
+
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+
 	chip_ctx = rdev->chip_ctx;
 	rdev->chip_ctx = NULL;
 	rdev->rcfw.res = NULL;
@@ -161,7 +165,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
-	int rc;
+	int rc = -ENOMEM;
 
 	en_dev = rdev->en_dev;
 
@@ -177,7 +181,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	rdev->qplib_res.cctx = rdev->chip_ctx;
 	rdev->rcfw.res = &rdev->qplib_res;
-	rdev->qplib_res.dattr = &rdev->dev_attr;
+	rdev->dev_attr = kzalloc(sizeof(*rdev->dev_attr), GFP_KERNEL);
+	if (!rdev->dev_attr)
+		goto free_chip_ctx;
+	rdev->qplib_res.dattr = rdev->dev_attr;
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 	rdev->qplib_res.en_dev = en_dev;
 
@@ -185,16 +192,20 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	bnxt_re_set_db_offset(rdev);
 	rc = bnxt_qplib_map_db_bar(&rdev->qplib_res);
-	if (rc) {
-		kfree(rdev->chip_ctx);
-		rdev->chip_ctx = NULL;
-		return rc;
-	}
+	if (rc)
+		goto free_dev_attr;
 
 	if (bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
 			   "platform doesn't support global atomics.");
 	return 0;
+free_dev_attr:
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+free_chip_ctx:
+	kfree(rdev->chip_ctx);
+	rdev->chip_ctx = NULL;
+	return rc;
 }
 
 /* SR-IOV helper functions */
@@ -216,7 +227,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	struct bnxt_qplib_ctx *ctx;
 	int i;
 
-	attr = &rdev->dev_attr;
+	attr = rdev->dev_attr;
 	ctx = &rdev->qplib_ctx;
 
 	ctx->qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
@@ -230,7 +241,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
 			rdev->qplib_ctx.tqm_ctx.qcount[i] =
-			rdev->dev_attr.tqm_alloc_reqs[i];
+			rdev->dev_attr->tqm_alloc_reqs[i];
 }
 
 static void bnxt_re_limit_vf_res(struct bnxt_qplib_ctx *qplib_ctx, u32 num_vf)
@@ -1726,12 +1737,11 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 
 	/* Configure and allocate resources for qplib */
 	rdev->qplib_res.rcfw = &rdev->rcfw;
-	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr);
+	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto fail;
 
-	rc = bnxt_qplib_alloc_res(&rdev->qplib_res, rdev->en_dev->pdev,
-				  rdev->netdev, &rdev->dev_attr);
+	rc = bnxt_qplib_alloc_res(&rdev->qplib_res, rdev->netdev);
 	if (rc)
 		goto fail;
 
@@ -2168,7 +2178,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			rdev->pacing.dbr_pacing = false;
 		}
 	}
-	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr);
+	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto disable_rcfw;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 96ceec1..02922a0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -876,14 +876,13 @@ void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl);
 }
 
-int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
-			 struct net_device *netdev,
-			 struct bnxt_qplib_dev_attr *dev_attr)
+int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev)
 {
+	struct bnxt_qplib_dev_attr *dev_attr;
 	int rc;
 
-	res->pdev = pdev;
 	res->netdev = netdev;
+	dev_attr = res->dattr;
 
 	rc = bnxt_qplib_alloc_sgid_tbl(res, &res->sgid_tbl, dev_attr->max_sgid);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 21fb148..f5a48e8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -424,9 +424,7 @@ int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
-int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
-			 struct net_device *netdev,
-			 struct bnxt_qplib_dev_attr *dev_attr);
+int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev);
 void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index d56cc33..47ed455 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -88,9 +88,9 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 	fw_ver[3] = resp.fw_rsvd;
 }
 
-int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
-			    struct bnxt_qplib_dev_attr *attr)
+int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 {
+	struct bnxt_qplib_dev_attr *attr = rcfw->res->dattr;
 	struct creq_query_func_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct creq_query_func_resp_sb *sb;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index eafa0c1..e626b05 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -326,8 +326,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
 			   const u8 *smac);
-int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
-			    struct bnxt_qplib_dev_attr *attr);
+int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
 				  struct bnxt_qplib_ctx *ctx);
-- 
2.5.5


