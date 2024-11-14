Return-Path: <linux-rdma+bounces-5982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196009C879C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8167FB31612
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB31F9434;
	Thu, 14 Nov 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RfcAopzE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CF1F9402
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579007; cv=none; b=jNbwtxi+38UZulDJbSAKsutCMdZqFoB/DtyKXBLSYx4cJBiJbc1B3I7VDadKfiLxLsqqXIdWRFQywMRy4qoc3MoCzz8diYGLPVZSc7NE+YgW9zmed/oz8mkqo8YNWr6r7o0n6erQsVmwLI4YPhCMDgncJCNf9djDvHeEt/fn9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579007; c=relaxed/simple;
	bh=5lOkGFyJrdaN2V/I0r/cxjezp4xMm0O7wmVD3juhGlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=olrWg8UOlJDUibpW+2rIzh4X/a33SC8DBgSv9aLi5Y7GuYnb1NxgN6PhJcfWFr3ZkliYGRyRSNH7K7wu3eaAUh3S3jny03bYIWQGuP4i7k/5xtc1HFgHupcER36441ktl1HOKoa5hipy6uDeaAx+h6uhzCVZxSxflq7lLqeLaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RfcAopzE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c693b68f5so4210465ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731579005; x=1732183805; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DbScZsKBGM/Zlei9B1dlGPa7BBIqOFtWKOcxzU+BIkI=;
        b=RfcAopzE8O8zH6O88MegEkNhqNNod5n3Hutefp0zR/OpWC2/0JupUIreMZgIKBUlFb
         pgoDWl8lCQ77s2MTiO3DxpM58X3523I81P0xcnjrjH8kwqFE21xeM6JF6pAH6Z3saj13
         cursQQ7gPfGAC7H8ROjRGTu8JwCaF7s613TUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579005; x=1732183805;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbScZsKBGM/Zlei9B1dlGPa7BBIqOFtWKOcxzU+BIkI=;
        b=PdwnBO9CSwd3QT52fCe63fo/RvsgVERmm5DQUzQ2QeoLEkAC70YjZk+kc8poSuF6pQ
         Jl9+pT/peKQBMnPkc9EqxMMXeGYxIWyQWgSDCshZ18k4o6eSy2x8UnIFxQbz7CRwYj1w
         65jQmXE3F+G61ArgqodvFXNCPgC2r3n3EKtXmykzxAuKVRj+5wYMNHP84DQ7I89dZ2ZF
         orSCyshMRGcOmzYVLaV6bwgKeYJdV8Q5Y1xW1H0Rh+S9UrIfUt/DVv62RnBLxCI0dDYy
         xAOzV4whaERIM+umpyhGhxw7z7T2YwWTAGoBdZh49l4mVAJ0Vwvp1Fjv0OVd1qRkj93n
         YoPg==
X-Gm-Message-State: AOJu0YyeDRc3Qfvt5kPj3H0EGOY/AzdVYi7leCTGIH1ehjORpXwXHtXM
	RoU2l9xVp1AkuWIjXxi85nP9VZ3dhJxq4mZTk3PPn2JX2yLnn7NvalVF8muUGA==
X-Google-Smtp-Source: AGHT+IGB0DgHcfEdKjHXOnZYsRrLWagXYAu4Hp97gHlAF3+U3IhkbI8u2jakdKYdNQ4KLqzrUpReAw==
X-Received: by 2002:a17:902:ec8f:b0:211:31ac:89f9 with SMTP id d9443c01a7336-211b5d6b0c7mr64716195ad.55.1731579005343;
        Thu, 14 Nov 2024 02:10:05 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d062absm7251135ad.206.2024.11.14.02.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:10:04 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 4/4] RDMA/bnxt_re: Cache MSIx info to a local structure
Date: Thu, 14 Nov 2024 01:49:08 -0800
Message-Id: <1731577748-1804-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

L2 driver allocates the vectors for RoCE and pass it through the
en_dev structure to RoCE. During probe, cache the MSIx related
info to a local structure.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 +
 drivers/infiniband/hw/bnxt_re/main.c    | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5f64fc4..2975b11 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -157,6 +157,7 @@ struct bnxt_re_pacing {
 #define BNXT_RE_MIN_MSIX		2
 #define BNXT_RE_MAX_MSIX		BNXT_MAX_ROCE_MSIX
 struct bnxt_re_nq_record {
+	struct bnxt_msix_entry	msix_entries[BNXT_RE_MAX_MSIX];
 	struct bnxt_qplib_nq	nq[BNXT_RE_MAX_MSIX];
 	int			num_msix;
 	/* serialize NQ access */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fcaf2b3..533b9f1 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -347,7 +347,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		return;
 
 	rdev = en_info->rdev;
-	msix_ent = rdev->en_dev->msix_entries;
+	msix_ent = rdev->nqr->msix_entries;
 	rcfw = &rdev->rcfw;
 	if (!ent) {
 		/* Not setting the f/w timeout bit in rcfw.
@@ -363,7 +363,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	 * in device sctructure.
 	 */
 	for (indx = 0; indx < rdev->nqr->num_msix; indx++)
-		rdev->en_dev->msix_entries[indx].vector = ent[indx].vector;
+		rdev->nqr->msix_entries[indx].vector = ent[indx].vector;
 
 	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
 				       false);
@@ -1569,9 +1569,9 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 	mutex_init(&rdev->nqr->load_lock);
 
 	for (i = 1; i < rdev->nqr->num_msix ; i++) {
-		db_offt = rdev->en_dev->msix_entries[i].db_offset;
+		db_offt = rdev->nqr->msix_entries[i].db_offset;
 		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nqr->nq[i - 1],
-					  i - 1, rdev->en_dev->msix_entries[i].vector,
+					  i - 1, rdev->nqr->msix_entries[i].vector,
 					  db_offt, &bnxt_re_cqn_handler,
 					  &bnxt_re_srqn_handler);
 		if (rc) {
@@ -1658,7 +1658,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		rattr.type = type;
 		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
-		rattr.lrid = rdev->en_dev->msix_entries[i + 1].ring_idx;
+		rattr.lrid = rdev->nqr->msix_entries[i + 1].ring_idx;
 		rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
 		if (rc) {
 			ibdev_err(&rdev->ibdev,
@@ -1983,6 +1983,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		return rc;
 	}
 	rdev->nqr->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
+	memcpy(rdev->nqr->msix_entries, rdev->en_dev->msix_entries,
+	       sizeof(struct bnxt_msix_entry) * rdev->nqr->num_msix);
 
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
@@ -2008,14 +2010,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	rattr.type = type;
 	rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 	rattr.depth = BNXT_QPLIB_CREQE_MAX_CNT - 1;
-	rattr.lrid = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
+	rattr.lrid = rdev->nqr->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
 	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &creq->ring_id);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate CREQ: %#x\n", rc);
 		goto free_rcfw;
 	}
-	db_offt = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].db_offset;
-	vid = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].vector;
+	db_offt = rdev->nqr->msix_entries[BNXT_RE_AEQ_IDX].db_offset;
+	vid = rdev->nqr->msix_entries[BNXT_RE_AEQ_IDX].vector;
 	rc = bnxt_qplib_enable_rcfw_channel(&rdev->rcfw,
 					    vid, db_offt,
 					    &bnxt_re_aeq_handler);
-- 
2.5.5


