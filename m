Return-Path: <linux-rdma+bounces-4995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE697C325
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB35B20EFC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335E6101C8;
	Thu, 19 Sep 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bORREXrn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785E0134AB
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716428; cv=none; b=EApBe5BBwnoHvH7TGwwU+ENhrwOhEJcqLDdkmWZV1wVkrB4YMVRwSAkY/LDMqDoYnuwM/622bCBesFCdmKZkcyVBkCNaFRvur8sxLgLso2Ua9GsjRhJEFEMoTC4VWvkW6bl43fiUv5jNJxPwfO37vmxJy6K+fF3PShiFOn9bJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716428; c=relaxed/simple;
	bh=+dH/o625Wuunev4SjctbKJdZ1KZdmY7f9qgB0UlXDBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XuirrZ8iCw2PRAndbyrkGJCFjIKMSiUaBXASILiMHIrs+iIQuHHtO7OyD6W1Ip6GfOZoZxYaMNYtLt/ADtM+qYFAEGqg6c27Jjxz600v/qi30gDZS6lKvWBdJ0jfrAaU5AilTsEy+kVgw4527Fcac0ymCMRV4uEWya6McFGtECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bORREXrn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7193010d386so284400b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716426; x=1727321226; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gc+IIfNrASI+jpmd9bQl5bjeRIt7G5gmpdvd7WW4FgA=;
        b=bORREXrnPpFFYNpbZuapSuniLE8IkWkyRsd5YeIRiykjP3c6ifs6M5nHHYVYaxhZhk
         E7jQLORVh50f94/m3+2qGMd8fEtXP5zCM9Z1OJZ7v2TnF8YE9gZwyyaKmazczPUlFEhA
         ibGIzJI29PvBsXyRu0mDPhFAG3UZIB4I8NROo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716426; x=1727321226;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc+IIfNrASI+jpmd9bQl5bjeRIt7G5gmpdvd7WW4FgA=;
        b=dmtetTdHr8Bo964YR5ZUPfhMVa8VpXJSFC9SPCDXhrY875hd5FHuH2hgoJgDNiTih2
         6IDx1p2vJqz9WDgZQSqejr3xVyHUELklu8NEupczXSK/KNxDlyDQUnlITjmE1SD2zxfu
         HYIxjy13X6t7eQF+kV+irjYOWa8ustPzN533VLbakUJbO1J3H949emVWlaJuPot5Em0O
         XRePN7wYZeFgQHVCfbyv+zv1xMauJIaeZJzPfj1dITxQ0+eGgPOt7MHC3bM1VhdLiumD
         iiwRlVU7JV7gP5wqr6EtbWZbIdeXcG09LI0ksPx5xFMKB1yjv7UHken+IqNd7LdCUrLo
         AuDA==
X-Gm-Message-State: AOJu0YyKJ+2a2HNoMBCurWc85JgjNr4WYywZMOUZgvBpOSpjYFVNFOki
	gd3Do0tpyd6mH1xvxezNNHNsxjEZ1X/qwc5X8ePD/yLqjcMM2fSUu92Oqbg95A==
X-Google-Smtp-Source: AGHT+IGhWD0PNcrnElNwdx0mqVccwyZIgC4gh8ZiSutdS70h5CKVAVrNhAQimNrKwxUjXP8mrsoacA==
X-Received: by 2002:a05:6a00:179c:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-71936a35d17mr32117360b3a.5.1726716425654;
        Wed, 18 Sep 2024 20:27:05 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.27.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:27:04 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 5/6] RDMA/bnxt_re: synchronize the qp-handle table array
Date: Wed, 18 Sep 2024 20:06:00 -0700
Message-Id: <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
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
index 42e98e5..bc358bd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1527,9 +1527,11 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	u32 tbl_indx;
 	int rc;
 
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DESTROY_QP,
@@ -1540,8 +1542,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
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
index 5bef9b4..85bfedc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -634,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
+		spin_lock_nested(&rcfw->tbl_lock, SINGLE_DEPTH_NESTING);
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


