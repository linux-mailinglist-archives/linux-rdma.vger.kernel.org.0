Return-Path: <linux-rdma+bounces-5860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF499C18B8
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113A21F251A6
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5581E0E14;
	Fri,  8 Nov 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RYcPm4LD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C81E0E12
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056622; cv=none; b=TVkoDB8mv3DMhiuiT1wCP1pTrl0+Nn+pRZE9cfzq3eP3Sj4bdjtgpES44i89LppQYSkon6iCObizVER89x/K6kQ38ubpnPstxSV9yLoU/CwulECWU6XtnfTFCA6zIGEwE8JjypVGDBYFNC7ABGcmzppn6qi73ERgbF4N4gwnhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056622; c=relaxed/simple;
	bh=4FMJfN58g5HFLUclKcC2PNaaoxZCdzfwEJLu1wbgdcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A5XA1HTOZGLmzU8EQRQIBYN3m4kRypjlinwPU+WXtdOY4rQea/xk0FOMzpPuEmxqSyk0l247q+MoR2/o3ShYah9tFqift2gmZoADQUNdzF613/3JgABmYzJv0x4k+Vzm98Pi+3nRPab6po3r2RUlwLIR6Uhx4lafrcHVdA2wuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RYcPm4LD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1537145b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 01:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731056619; x=1731661419; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CqClvXpJbPmrEsqqNNya9BoNZP7fNuRPKfg2oKLKiLM=;
        b=RYcPm4LDs7ZN/tRkOjF2jYTfWGIs8WYJqQZLckWsr3JbddeIxMt2jVyuebB3SDb7Cy
         0ID9V/BU+12fGXle0QA3zK6Sd/9oKt5T9O02MEwn1eCArC/UmndQ1hPvX4SsQPRNxUzV
         fj9w0pawgF1atQove2gYJF3yZsDENp40/7u3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056619; x=1731661419;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqClvXpJbPmrEsqqNNya9BoNZP7fNuRPKfg2oKLKiLM=;
        b=uISCQSSGJklXtnFl9e+9ZImNjKUnqpz4DHMN+GoG4WbNxox4WWhduSGeZjtcSodzKk
         yU9jgnLMiepirem0/Tmr6nMBJfzw4hv7d6DRV06le+sidkkAQT5X9edYuUgGdMxxVgTm
         AqZ49VBupwMEr91R2qh9IHlrhaPWVZZNkPVSv9wY8Jo6T1YgM0O2Pg4LHcoxMOIBGj5P
         NUvb6OFA9YsMgNOWnXuM9dAlR/zyzkjlovaTpTQo7uHcrTJllHF3ATrvgugnrsYDuzdq
         zU8quou4DObNdSJQJe41JdCOy4ag2TTBt4h47RClnymsSl/1ZdbsgF5rbYSBCza+gZQE
         UpZg==
X-Gm-Message-State: AOJu0YyXMa772U4Min9b62mfL9FiVWX/FhO0srlH+JZJ/8+1BPmnnEym
	xAhspMRut11HtLJNRo3TodWYI/uMJjPV49oYDcKi8oG/tn1yDMDSh3o/WM8Lyg==
X-Google-Smtp-Source: AGHT+IH1FUEKkKvY9iXnx/GTHpmp5V3cDMxHwUkq75P3Gwv6+iDSoqWU9v2ppTw/KJtFBRXc4qC5HA==
X-Received: by 2002:a05:6a20:1595:b0:1db:e884:6370 with SMTP id adf61e73a8af0-1dc228693a7mr2967364637.7.1731056619209;
        Fri, 08 Nov 2024 01:03:39 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffcdsm3096441b3a.31.2024.11.08.01.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:03:38 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma-next 4/5] RDMA/bnxt_re: Cache MSIx info to a local structure
Date: Fri,  8 Nov 2024 00:42:38 -0800
Message-Id: <1731055359-12603-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
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
index e556110..1c7171a 100644
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
@@ -1982,6 +1982,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		return rc;
 	}
 	rdev->nqr->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
+	memcpy(rdev->nqr->msix_entries, rdev->en_dev->msix_entries,
+	       sizeof(struct bnxt_msix_entry) * rdev->nqr->num_msix);
 
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
@@ -2007,14 +2009,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
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


