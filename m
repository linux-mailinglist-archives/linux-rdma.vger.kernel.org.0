Return-Path: <linux-rdma+bounces-5398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 111FA99CC0A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A48AB249CF
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C519E802;
	Mon, 14 Oct 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dG+1BN2V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308E18453C
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914234; cv=none; b=RiGZ0DTkHSRkZAsSy1upAdNZikyROZQRJv63lvlnRSSxQVuHdQDenOdMhOwxAXLK+Q8lp3pBT1mQ9unhiNe9t5b5x1aPALHBbiMuRHwtW9c/WdIsQGRkhg2HPXAenA0JS3NB6cjp4VrPCow0cy/utRLL1sI4ka7n7PImTxrbVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914234; c=relaxed/simple;
	bh=uODGaud3E6mMA+lWrah7QEjO6UxIECM3UZpL0Mtd+UA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cWNPneni569fr6XT4OI+57jPYwr7NiSpxtPEUli0rooLeAcNltE9DxnVTIgmZWDqSVXLZMdRdIjK9kubQZ5p3heY8HibX8qgY+MKJNHM0qRK+Y6v6s2Dpi0fe8icLPQD1Gya7aP44+jbTqyUWrzUpKXXfqo3trPoOPzZdKd/Lzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dG+1BN2V; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cceb8d8b4so10013565ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728914232; x=1729519032; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/7SsbA9LbMx4UO5vKJrz6w3VBitXZAIoVahNfdhuFTc=;
        b=dG+1BN2VJft3Gm/boGkEiVyFRE75Fc9I2NAP4IZnNEIbM4XYjoDPeno21B+nqHXNnC
         VR/AioAeFr8jkCdyV3qFPG3oGJDnYRf5Vit0IuXpkFilOQ5aXcC/S4VQoQI/UrDcjSbi
         smOQUuqExs6QJ+EjpLxmc1dkyFNLS0uw97dFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914232; x=1729519032;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7SsbA9LbMx4UO5vKJrz6w3VBitXZAIoVahNfdhuFTc=;
        b=w7C+cayM65pDkIJATNxOEMu0BR4lqjwClZuFbhIGshHLMitgqtBfEb/UAEW7D91eCX
         9zPGwQkJNA5GrS6A2acchIkFLqFn0a5+WoztiUvA8XVTNXLbccbv35qmy6B3sP1oGlkA
         xf5YQ4hCCQ97/B+lxYtZfu1Dpr/6fYt0TK9/yMTmJLm0JgOD66p/Ir99R/yJqtXJVkCh
         8cJXPLzVOheNUyeL8IRhPfFmQzH5qdSU2/NyiT6JYx0KVWKWjizV8GevCTypomlQCnT8
         DAQ9OA9Pdx35WpTAA67KYXYoLhkSdvAosfvOa3IqQI+vlDPvQnqfJTM0CpDU2mF5m81y
         Gi0A==
X-Gm-Message-State: AOJu0YwLlpc6s33LOk/dAD1b4BttamOYFRtdzJahffolhWOKzBAhK4Xr
	R/RTeZmdOaTEIIwQZOCIhokvSetpUhtO1NMSaDAxOcvLRhRT7CisgKQwmCYKxg==
X-Google-Smtp-Source: AGHT+IEqQtlyCcrHO09TNHKdL7bBy8W5j6h2+WPTI9rKdeQeUPLWgbrX/PFfF9Nm+WYZFpR/sV8vbw==
X-Received: by 2002:a17:902:e88f:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-20c804ee3d6mr228034515ad.22.1728914232525;
        Mon, 14 Oct 2024 06:57:12 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c35697dsm66129525ad.297.2024.10.14.06.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:57:11 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc v3 2/2] RDMA/bnxt_re: synchronize the qp-handle table array
Date: Mon, 14 Oct 2024 06:36:15 -0700
Message-Id: <1728912975-19346-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

There is a race between the CREQ tasklet and destroy
qp when accessing the qp-handle table. There is
a chance of reading a valid qp-handle in the
CREQ tasklet handler while the QP is already moving
ahead with the destruction.

Fixing this race by implementing a table-lock to
synchronize the access.

Fixes: f218d67ef004 ("RDMA/bnxt_re: Allow posting when QPs are in error")
Fixes: 84cf229f4001 ("RDMA/bnxt_re: Fix the qp table indexing")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 +++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 2ebcb2d..7ad8356 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1532,9 +1532,11 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	u32 tbl_indx;
 	int rc;
 
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DESTROY_QP,
@@ -1545,8 +1547,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc) {
+		spin_lock_bh(&rcfw->tbl_lock);
 		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
+		spin_unlock_bh(&rcfw->tbl_lock);
 		return rc;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index ca26b88..e82bd37 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -634,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
+		spin_lock(&rcfw->tbl_lock);
 		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
 		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
+		if (!qp) {
+			spin_unlock(&rcfw->tbl_lock);
+			break;
+		}
+		bnxt_qplib_mark_qp_error(qp);
+		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
+		spin_unlock(&rcfw->tbl_lock);
 		dev_dbg(&pdev->dev, "Received QP error notification\n");
 		dev_dbg(&pdev->dev,
 			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
 			qp_id, err_event->req_err_state_reason,
 			err_event->res_err_state_reason);
-		if (!qp)
-			break;
-		bnxt_qplib_mark_qp_error(qp);
-		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
 		break;
 	default:
 		/*
@@ -973,6 +977,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 			       GFP_KERNEL);
 	if (!rcfw->qp_tbl)
 		goto fail;
+	spin_lock_init(&rcfw->tbl_lock);
 
 	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 45996e6..07779ae 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -224,6 +224,8 @@ struct bnxt_qplib_rcfw {
 	struct bnxt_qplib_crsqe		*crsqe_tbl;
 	int qp_tbl_size;
 	struct bnxt_qplib_qp_node *qp_tbl;
+	/* To synchronize the qp-handle hash table */
+	spinlock_t			tbl_lock;
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
-- 
2.5.5


