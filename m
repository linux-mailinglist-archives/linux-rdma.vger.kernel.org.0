Return-Path: <linux-rdma+bounces-4685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E36967F31
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 08:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD932817DC
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 06:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62841154BEA;
	Mon,  2 Sep 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S62hLZKV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1931AACA
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257610; cv=none; b=sCAM6w0Q/6uaRR9SfEZPaN/xLan1Le0YXZwwKPh/3rIsU4Ws7Q/KQ+o8abgHPrPt76wKtR1td7bIXH9Rwc8OWE4uiEvRj4AW9T3RaET/0E5YungU6K33a1C/ougN0NArReVLpP6i1h7WtrVN+HHNlEU/zF4HkQXjrHsIXkDkbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257610; c=relaxed/simple;
	bh=sXmJS2WMQBWus9nTMfzAR07HfXL0vhhEI1Yx61U8pEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NrOOnKYUY8mExx06h7J2DSPCoNkpzE7pjrRzJozZyOWuugkCqBtj6/rJ11UoybZerdRAsO03GawtSUSA/j8DmPC/i0hzmLzBEbCKX0UuMoo3ye6ca22vhdR3UqDmsznHxfrcuRlTD8P8EdF/vL2xh8gNA9qgo/0uoWUW7NTa9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S62hLZKV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055f630934so7279625ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725257608; x=1725862408; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPEjwMCkAJY53axIFi/zWxXhDAR/ShRtXq1gvog/XOc=;
        b=S62hLZKV04TYeciaGr8kKAXXI5gdWJT5X7z/34nfVXuOvzVjClngJnm6hPhvPsbxDQ
         JP44jiBOtKVpta43S5i8XvKLWF0/59Kyk2+snekYOWErPvAkhpnu6PHrHqBs6NI5vcu4
         HrbfKf/OgvOXWCUFuZK/3MhAZGyhC/U5/2Jp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257608; x=1725862408;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPEjwMCkAJY53axIFi/zWxXhDAR/ShRtXq1gvog/XOc=;
        b=Xw7GCXMuQzTilNW4VA6fxHEIQVxJmz36aLwGNhQztg467I8PW08t3qUg/TjFO18Bkf
         G0c1/PkpXsozyhW1ouLLWD2i+IjTbglepVzMnjQyifUXepgn1QMn5NK7aipYS3PMAf+g
         DngZIebm1TaTz5bpzJb0qa34lKw6aJQFY50kljXokBQOG1UO5V8AEgbWbDNdAWkpyTFo
         Dyo22mhJVSWbs/x++q1gj/dD/nizl7IizViEdhZEf5aqye4J4uVMqUW/iqgvb5/j2p36
         wNW5aLIXJ2G2TOpAnnc0L+tE13elbXWOlVKJQlVmX+JNFIEP98vS3Jh6K9hU7PgRHI+K
         GQrg==
X-Gm-Message-State: AOJu0YwqkrJNtgioGmRKQAQHmsXu/sQFRO8ZhjVyW0+TqgCdZzT7SLF/
	jr5WMpryoAOgs3ENt6PBPrS+Eo/44L3dKfakEqlpHqmzE1p8/Say3YbwCgoNahlX00yNtVlcDDJ
	HrA==
X-Google-Smtp-Source: AGHT+IHIq3MrOBRSZ74qfrfayrad7dykd0PJ4mCdPGdW8AXC++DAbV8ECfECh2Z1ldQ7UuZ642WnXQ==
X-Received: by 2002:a17:902:ce85:b0:205:937f:3ae3 with SMTP id d9443c01a7336-205937f4326mr785155ad.44.1725257607899;
        Sun, 01 Sep 2024 23:13:27 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054a2629c3sm28907955ad.105.2024.09.01.23.13.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2024 23:13:27 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/4] RDMA/bnxt_re: Avoid an extra hwrm per MR creation
Date: Sun,  1 Sep 2024 22:52:30 -0700
Message-Id: <1725256351-12751-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Firmware now have a new mr registration command where
both MR allocation and registration can be done in a
single hwrm command. Driver has to issue this new hwrm
command whenever the support flag is set. This reduces
the number of hwrm issued per MR creation and speed up
the MR creation.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 36 +++++++++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  8 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  1 +
 4 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index d5c9b6a..50cf3ec 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -518,14 +518,18 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.pd = &pd->qplib_pd;
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
-	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
-	if (rc) {
-		ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
-		goto fail;
-	}
+	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
+		if (rc) {
+			ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
+			goto fail;
+		}
 
-	/* Register MR */
-	mr->ib_mr.lkey = mr->qplib_mr.lkey;
+		/* Register MR */
+		mr->ib_mr.lkey = mr->qplib_mr.lkey;
+	} else {
+		mr->qplib_mr.flags = CMDQ_REGISTER_MR_FLAGS_ALLOC_MR;
+	}
 	mr->qplib_mr.va = (u64)(unsigned long)fence->va;
 	mr->qplib_mr.total_size = BNXT_RE_FENCE_BYTES;
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL,
@@ -4088,14 +4092,18 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_MR;
 
-	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
-	if (rc) {
-		ibdev_err(&rdev->ibdev, "Failed to allocate MR rc = %d", rc);
-		rc = -EIO;
-		goto free_mr;
+	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
+		if (rc) {
+			ibdev_err(&rdev->ibdev, "Failed to allocate MR rc = %d", rc);
+			rc = -EIO;
+			goto free_mr;
+		}
+		/* The fixed portion of the rkey is the same as the lkey */
+		mr->ib_mr.rkey = mr->qplib_mr.rkey;
+	} else {
+		mr->qplib_mr.flags = CMDQ_REGISTER_MR_FLAGS_ALLOC_MR;
 	}
-	/* The fixed portion of the rkey is the same as the lkey */
-	mr->ib_mr.rkey = mr->qplib_mr.rkey;
 	mr->ib_umem = umem;
 	mr->qplib_mr.va = virt_addr;
 	mr->qplib_mr.total_size = length;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index a0f78cd..b452b2f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -565,4 +565,9 @@ static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
 	return cctx->modes.dbr_pacing;
 }
 
+static inline bool _is_alloc_mr_unified(u16 dev_cap_flags)
+{
+	return dev_cap_flags & CREQ_QUERY_FUNC_RESP_SB_MR_REGISTER_ALLOC;
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index c26e8f5..4f75e7e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -659,6 +659,9 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.access = (mr->access_flags & 0xFFFF);
 	req.va = cpu_to_le64(mr->va);
 	req.key = cpu_to_le32(mr->lkey);
+	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags))
+		req.key = cpu_to_le32(mr->pd->id);
+	req.flags = cpu_to_le16(mr->flags);
 	req.mr_size = cpu_to_le64(mr->total_size);
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
@@ -667,6 +670,11 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	if (rc)
 		goto fail;
 
+	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags)) {
+		mr->lkey = le32_to_cpu(resp.xid);
+		mr->rkey = mr->lkey;
+	}
+
 	return 0;
 
 fail:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 06e74b6..4ce44aa 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -117,6 +117,7 @@ struct bnxt_qplib_mrw {
 	u64				va;
 	u64				total_size;
 	u32				npages;
+	u16				flags;
 	u64				mr_handle;
 	struct bnxt_qplib_hwq		hwq;
 };
-- 
2.5.5


