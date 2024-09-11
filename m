Return-Path: <linux-rdma+bounces-4890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3CF975A95
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 20:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD26B22E61
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFB1B6541;
	Wed, 11 Sep 2024 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FVcguovH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAA185B7B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080654; cv=none; b=XCzjhogJJ+BvnCxxITQvzX5OGUxKalWZ9UtTEpBE6Ji1fTW1bqht1AQpVlIUrlRM0as3/EaOG6elN1miwvOPN4Y/vocRdnCkdUEcuh+SnwRBj3fWKXBVp9LmYqCjBVljHyhLt3ZrsVqTwAdimHYV2mB9EcdYLgUdEHfYMhGvQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080654; c=relaxed/simple;
	bh=TFhIUDjNNH8A27fvpNJ0/3PPGEnLoedez1gLe8fwGFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eBfKB5BbIuma+0zG5iHsiPmQcogk6Qs764cANpXCUn5eHeBLlPjK8xvQBTvVheRf4mMHYG7Gd8+X5SnoP9ykXFwy1X6GhEwre68pYXCzPyZCDWUqzXI2OTsglam5vXonoViPkEkDSVfjH1rc0B1Ikuh17OpBqca+PQx9Bkj/W3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FVcguovH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6bce380eb96so141137a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726080653; x=1726685453; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iDJP6e9UtZclHxRKRcKW7PoXjp4eF1sxnMZsWT6VSdk=;
        b=FVcguovHep7TTJn/LKkIl8+n/38i/rC4tA7o1y+FKFoPlXp4RPvu84Y0BuU7I+bWBS
         8krYPa4n6ZEcpW7RoGJqwQqfXtvRkfjEJ6STDuV/HIh00ZiI1OCOkdwxAmnC7xJtrB2o
         vDZDpHMgEu8rxNeeTyfJD4yW3rlxzf0u9UZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080653; x=1726685453;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDJP6e9UtZclHxRKRcKW7PoXjp4eF1sxnMZsWT6VSdk=;
        b=Jn3tGEFPGw2Jv2kr801z4ORNqONJdpqiPLUGmLqmM1Gh3iH/9agqs74J4lHnE6RVL4
         FRsfh9Vee4OUD4d7YCX8QNhE02OudEQYHviJ94NIZLSCpvJI372qkB/3wHBLmIxAkVxe
         N06A07egB4AahqhoJk/czh0iTO6eriZpYHS0MoNNq6EdWWfrTW0NyA5KteHdiPObkN++
         ae4Yiva7qBxM4QKlEQAb19uRVoNENnZ51oeGknQe3/d1G2Pq7oywZb0Pqd3BODxUhQ/2
         sObo1xpWWYl/gcr1+ZoNW24U1rL7u32UdmqbxaRhNQcgWYKRuBv6IvWnFQzc62WkLtpS
         Gpuw==
X-Gm-Message-State: AOJu0Yw13DvtM+iBe4o9qQ20QTuhlw0h/jLUCbOkQwRecxJOY3+YpG+Z
	QztIX9gDMR05cjcW/+Nzn/MPjZcMRqhpl/W1QkR1/KDNytndwc/epEZ4u8kJHA==
X-Google-Smtp-Source: AGHT+IHo6BH+gfiKDDMSU3+QJoyuV8z6/3f5x/HlZuFF8IFbMTCnJTegp2gBkYaEiCQDO/OjUmineQ==
X-Received: by 2002:a05:6a21:330b:b0:1cf:4c48:5bf8 with SMTP id adf61e73a8af0-1cf76237d83mr241821637.44.1726080652411;
        Wed, 11 Sep 2024 11:50:52 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c59c9sm8903996a91.24.2024.09.11.11.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:50:48 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 4/4] RDMA/bnxt_re: synchronize the qp-handle table array
Date: Wed, 11 Sep 2024 11:29:39 -0700
Message-Id: <1726079379-19272-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 12 ++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 42e98e5..5d36216 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1524,12 +1524,15 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	struct creq_destroy_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_destroy_qp req = {};
+	unsigned long flags;
 	u32 tbl_indx;
 	int rc;
 
+	spin_lock_irqsave(&rcfw->tbl_lock, flags);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
+	spin_unlock_irqrestore(&rcfw->tbl_lock, flags);
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DESTROY_QP,
@@ -1540,8 +1543,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc) {
+		spin_lock_irqsave(&rcfw->tbl_lock, flags);
 		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
+		spin_unlock_irqrestore(&rcfw->tbl_lock, flags);
 		return rc;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3ffaef0c..993c356 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -637,17 +637,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
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


