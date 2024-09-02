Return-Path: <linux-rdma+bounces-4684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ABC967F30
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 08:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5281F22593
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 06:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C08154C04;
	Mon,  2 Sep 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eHkycqo5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1391AACA
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257607; cv=none; b=P7ojQo90tHHRUeBQdmjYy2bzMlGA5FPJLEzJ93ZhkUc+15hFcP0KU/+XNWcwJM20SLcPsB45/LVE4y4su9f1msV8tFeBEC13vnvrmkIwI/DrWoeEqz3wmDswdQEjOMsmS5FSLzVP+GGJA8KoPTjXbEgdHm4+kVnC4c1FqGM6fzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257607; c=relaxed/simple;
	bh=MBbNxAb/mVMUvpcJqhyts8SLQrIIZavqqxT+vW01E8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kz8+oDmrgWYoF7DRdc/5AkHjW1pLk5j/U0FvbB6KHZr6UYPv4Y2mvbvn8YIQwb9Er5mKo2Kc6N4+O2d9v1ag0FYNX0XT/lgYP+Zw2Kfk1nbafOM9R2/3Yy9ovOmRbIQrc+A9ZNqsWjPEEYVkHTeSw71rAiw0+zngkOJsuHoa8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eHkycqo5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714263cb074so2765719b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725257605; x=1725862405; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+pSs4G6UTXAmRixYYXCYgjYOBstIlplC2UOFltRfuY=;
        b=eHkycqo5kzeKQXpaR99siq2ieoYYYnvwG/YxtuSyOTPEvemHY6okjtA3JY5yne0cJv
         JUaSjbW2t0MUZ7cQiieOMsJ3oEkGewOzG7U7fyxJffi1aVW3fggE0fc9FXYYDLC5Ry/K
         peK/57gd+N1TFKt+wJnJs2QS46lEFBYc94atQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257605; x=1725862405;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+pSs4G6UTXAmRixYYXCYgjYOBstIlplC2UOFltRfuY=;
        b=dqLEXCIqB2HBLs2ia1siojFRqQrLnBcIfO7Gzusf4DbGTOZIjVXLtCmwqGAflLUP4W
         c3XNACB4Px55uuqCvzylg1qFcUtPxE0ahKdBnbO7NNruUSIodGQxmyLrwDnOpeWHb4jK
         Nh6mmqV/3th93yYZDGv+IWmdMAAdo2yhlaOgw4RUIbLbcNIjHjEjVkUHJWvLrRrEYPrX
         xPoMPeYzYJ323oc1eV+mAAsLOEcjYQ6SdZaiOx5CwIrQym1+aIlIZNnNQfbxTioJiu5w
         dewm1kP6+fNFMv6F3aK09ztE3AAlhW5e7+4XEJSaxMabt7m6gKbQlSbx4v+6SW3N3RQU
         FQWQ==
X-Gm-Message-State: AOJu0Yw/hJ10mPODTJMTdqk256zM2g9+EkspeGpdoj9HghvgfELHgd+1
	vbhER8WNqfnHNRAoAPTfOcu9ElkvKq2tdbDjgO77ftn/2mZJDwFcHBqdnKxzXg==
X-Google-Smtp-Source: AGHT+IHZ/THfUI1dFjzdKpy69a7YDlZCnjDpYatR+pbgCYERNXuh53UgE3VprtwjsaLnl4OYHjq9jg==
X-Received: by 2002:a05:6a20:1d56:b0:1ce:f063:853a with SMTP id adf61e73a8af0-1cef0638540mr625440637.0.1725257605193;
        Sun, 01 Sep 2024 23:13:25 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054a2629c3sm28907955ad.105.2024.09.01.23.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2024 23:13:24 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/4] RDMA/bnxt_re: Rename a variable
Date: Sun,  1 Sep 2024 22:52:29 -0700
Message-Id: <1725256351-12751-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Renaming flags to access_flags for clarity.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 8 ++++----
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 4 ++--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 6ce1db9..d5c9b6a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -517,7 +517,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->rdev = rdev;
 	mr->qplib_mr.pd = &pd->qplib_pd;
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
-	mr->qplib_mr.flags = __from_ib_access_flags(mr_access_flags);
+	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
@@ -3868,7 +3868,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 
 	mr->rdev = rdev;
 	mr->qplib_mr.pd = &pd->qplib_pd;
-	mr->qplib_mr.flags = __from_ib_access_flags(mr_access_flags);
+	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 
 	/* Allocate and register 0 as the address */
@@ -3968,7 +3968,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 
 	mr->rdev = rdev;
 	mr->qplib_mr.pd = &pd->qplib_pd;
-	mr->qplib_mr.flags = BNXT_QPLIB_FR_PMR;
+	mr->qplib_mr.access_flags = BNXT_QPLIB_FR_PMR;
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
@@ -4085,7 +4085,7 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 
 	mr->rdev = rdev;
 	mr->qplib_mr.pd = &pd->qplib_pd;
-	mr->qplib_mr.flags = __from_ib_access_flags(mr_access_flags);
+	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_MR;
 
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index ca2aa35..c26e8f5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -544,7 +544,7 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	req.pd_id = cpu_to_le32(mrw->pd->id);
 	req.mrw_flags = mrw->type;
 	if ((mrw->type == CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR &&
-	     mrw->flags & BNXT_QPLIB_FR_PMR) ||
+	     mrw->access_flags & BNXT_QPLIB_FR_PMR) ||
 	    mrw->type == CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2A ||
 	    mrw->type == CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2B)
 		req.access = CMDQ_ALLOCATE_MRW_ACCESS_CONSUMER_OWNED_KEY;
@@ -656,7 +656,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.log2_pbl_pg_size = cpu_to_le16(((ilog2(PAGE_SIZE) <<
 				 CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_SFT) &
 				CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_MASK));
-	req.access = (mr->flags & 0xFFFF);
+	req.access = (mr->access_flags & 0xFFFF);
 	req.va = cpu_to_le64(mr->va);
 	req.key = cpu_to_le32(mr->lkey);
 	req.mr_size = cpu_to_le64(mr->total_size);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index a633e2a..06e74b6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -109,7 +109,7 @@ struct bnxt_qplib_ah {
 struct bnxt_qplib_mrw {
 	struct bnxt_qplib_pd		*pd;
 	int				type;
-	u32				flags;
+	u32				access_flags;
 #define BNXT_QPLIB_FR_PMR		0x80000000
 	u32				lkey;
 	u32				rkey;
-- 
2.5.5


