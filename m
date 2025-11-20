Return-Path: <linux-rdma+bounces-14632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0DC72B8D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 09:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A80C3575BC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 08:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A520309DA1;
	Thu, 20 Nov 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FJjEPrfq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883892EE617
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626016; cv=none; b=ZcYXeTdH2mw/se0Lf6k6nDKYpfay1uZ9opm230vkeae8jQ/1/IQoran2Ci7dUNbfOoV8YnW3ITP4+Ah/bX3kZtTXO37cVtUmH1nL9xG5Id5wJ0dDRRtLjy5uj/jfc6nOJgVdbs/G08T79YpSmN7/QgjZu4lLQT9dEiWcDfHvx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626016; c=relaxed/simple;
	bh=q2qlG5vBmryakmmntqw2BTgxgky5HWXXVo2zDIJPJYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZhByG/BphB9wTTBNH1HZ31BSIbEulFp/sTllOeH5N+w02OSo8Ee6PjW3EZt3zUJpAYQGC5K0wqwzbI4HBi4Mz5e2bFmtcpHmAhVN7nKPj/BmFM66+HTjZ2TDgTELNy6ESviqvk0KjIS4ecwDpGqrWPwLce/YjKlvmQX3ANvdrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FJjEPrfq; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-9487e2b9622so24510939f.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 00:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763626014; x=1764230814;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJiTm2nE9hjnbWqeZNozLg/C5SFb3jyhS8CEzzEb+l8=;
        b=cHpa5g4LN7UW9dXtDl+Bg6Uuc6ws+msmmKkrwXFbke+m1Z5n6kgXeIXtayNt5YYj3Z
         HHm9wPT2ivpsB19Ts9S0pPe5mLIaQvzl018Erwbf31BQNH+HqFhCHb3FW+B9pFSBMIuq
         zePCxzwIwwoZOS/Ca4oUKtaS/m6Sd53wfMWSiLrfq8O7/QNWjAZ2ciNSE3Ip8lSWyLaj
         /Z1m53g7THpHM0U3Doz641T0m8uNVcFVsrKhYFdPu/lgWuApzF9cfVLYjPWX84sUsugw
         pc+W87awWsosNte0i/ZLix2XAMpnFRDrF/pK2sX7cX4qooBC4TECr3Vn1n0jjhIb3YU3
         lajA==
X-Gm-Message-State: AOJu0Yz37hmxy8MZV9c8B2UWAYTknsM3Uv2u/knGMbTzmCiiEE76qP6V
	Y1obVU4pKmEio6fV22TtgCO00UO8icN4vrsktjXIRDMffZXqw9M6D0o69umSC4BtiRAcLmnH/9t
	ycO/TtkEJWfdLKk/g21hkyN0zYn7KxecmXrjsjwnrV++zA8kFmcb6tAwAYi8bu0jRDvH2+fnV1d
	pgr1DgFkjk1ulMhSmARDmMdHilnshc5PjYfEMKm/0YDIDhxCqKrRqbQ8Lubgf/LtXNjZqNFc/ND
	opQMZuHSkXvaKGSXA==
X-Gm-Gg: ASbGnct3e5IXf2v6XAqq1zPu18GVGX+5QQOrcVEPyVyvu3yT4RMybu6NxTZK9BNLm8U
	H/u8fIKoFE9aL9qSfemNeP5UnQyAVjSbwxP9aXVxICVH+oOGv5miXRoMRLyl6RZlnMN5GDp1KyX
	8XwORNdjAuZva4qCCS8/pxpaSZEMcAE2I293tNxILPkTaso1qHw8LxyNBE3gH2D3ZrUb6MuvMh6
	x9oJIGQTJXlb/7MIf5SqjWVqAwH4hvnHgVrUHsZBu8lJpyWsdcZAJyJQKUQuejJFU0yQbK7ZGpz
	R73JMzaFEcmL8I1etqJJx8PpoDaCYwRNEfhUxNU3eaiJwzBgXmayv9kgX+XDG3pl9qhGmdji5S0
	lICEMhbyOVnVC0qDkR/iEbAd/oZ46+YWd2HkitG9NCHwm70Zrb4hbF9ngs2N3aDDlSElUMUdBqF
	+FytFcd65MJz6kpLqQaINbHq4+TQW58iHXupZLopqahLa3xA==
X-Google-Smtp-Source: AGHT+IFpEm67EaUcpgg9wwWht6qYIo6KCmmv3IpcNOVxNrwjjcHtU9Gq0naIy6kFyycpddFrB11Haj1kvYVl
X-Received: by 2002:a05:6638:6a12:b0:5b7:267c:35c7 with SMTP id 8926c6da1cb9f-5b953ffb6f1mr1390270173.2.1763626013585;
        Thu, 20 Nov 2025 00:06:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b954a08bf2sm150061173.3.2025.11.20.00.06.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:06:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438744f12fso1916966a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 00:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763626012; x=1764230812; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJiTm2nE9hjnbWqeZNozLg/C5SFb3jyhS8CEzzEb+l8=;
        b=FJjEPrfqQyyKLeqNoFnpO5XgqwsQCEA+M6FIcsWxn66HnQKfsMMFXP9jKhefyO8DvT
         shKhPlCIavoBG/PTcYaCwpCigFDcHvVbtWYubU9kfg/M4lvGNvj5hvvQj1CvFes30Fp8
         lAa4DW2vhePgUUtTfVxcHLEjViMXvr6vuvtPY=
X-Received: by 2002:a17:90b:5645:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-34727bdc112mr2523642a91.4.1763626012020;
        Thu, 20 Nov 2025 00:06:52 -0800 (PST)
X-Received: by 2002:a17:90b:5645:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-34727bdc112mr2523615a91.4.1763626011674;
        Thu, 20 Nov 2025 00:06:51 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727c4baffsm1549119a91.12.2025.11.20.00.06.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:06:50 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 2/2] RDMA/bnxt_re: Pass correct flag for dma mr creation
Date: Wed, 19 Nov 2025 23:36:55 -0800
Message-Id: <1763624215-10382-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1763624215-10382-1-git-send-email-selvin.xavier@broadcom.com>
References: <1763624215-10382-1-git-send-email-selvin.xavier@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

DMA MR doesn't use the unified MR model. So the lkey passed
on to the reg_mr command to FW should contain the correct
lkey. Driver is incorrectly over writing the lkey with pdid
and firmware commands fails due to this.

Avoid passing the wrong key for cases where the unified MR
registration is not used.

Fixes: f786eebbbefa ("RDMA/bnxt_re: Avoid an extra hwrm per MR creation")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 8 +++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 84ce3fc..f19b55c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -601,7 +601,8 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.va = (u64)(unsigned long)fence->va;
 	mr->qplib_mr.total_size = BNXT_RE_FENCE_BYTES;
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL,
-			       BNXT_RE_FENCE_PBL_SIZE, PAGE_SIZE);
+			       BNXT_RE_FENCE_PBL_SIZE, PAGE_SIZE,
+			       _is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags));
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register fence-MR\n");
 		goto fail;
@@ -4027,7 +4028,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	mr->qplib_mr.hwq.level = PBL_LVL_MAX;
 	mr->qplib_mr.total_size = -1; /* Infinte length */
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL, 0,
-			       PAGE_SIZE);
+			       PAGE_SIZE, false);
 	if (rc)
 		goto fail_mr;
 
@@ -4257,7 +4258,8 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 
 	umem_pgs = ib_umem_num_dma_blocks(umem, page_size);
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, umem,
-			       umem_pgs, page_size);
+			       umem_pgs, page_size,
+			       _is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags));
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register user MR - rc = %d\n", rc);
 		rc = -EIO;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index a9afac2..408a34d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -578,7 +578,7 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 }
 
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
-		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size)
+		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size, bool unified_mr)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
@@ -640,7 +640,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.access = (mr->access_flags & BNXT_QPLIB_MR_ACCESS_MASK);
 	req.va = cpu_to_le64(mr->va);
 	req.key = cpu_to_le32(mr->lkey);
-	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags))
+	if (unified_mr)
 		req.key = cpu_to_le32(mr->pd->id);
 	req.flags = cpu_to_le16(mr->flags);
 	req.mr_size = cpu_to_le64(mr->total_size);
@@ -651,7 +651,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	if (rc)
 		goto fail;
 
-	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags)) {
+	if (unified_mr) {
 		mr->lkey = le32_to_cpu(resp.xid);
 		mr->rkey = mr->lkey;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 147b5d9..5a45c55 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -341,7 +341,7 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res,
 int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 			 bool block);
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
-		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size);
+		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size, bool unified_mr);
 int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr);
 int bnxt_qplib_alloc_fast_reg_mr(struct bnxt_qplib_res *res,
 				 struct bnxt_qplib_mrw *mr, int max);
-- 
2.5.5


