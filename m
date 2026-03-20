Return-Path: <linux-rdma+bounces-18454-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABKLEtRUvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18454-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:08:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B913E2DB97B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675E930541F5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2930AD15;
	Fri, 20 Mar 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JNcQfYN8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCE317152
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015431; cv=none; b=C5cEhipyl5fI35douUxmWp5XMMi/9wzVGXty9hl8/wgK7Qc9+OAN0/qKgvHMsXeyONc/dsXVjeAzs2snjRhTq4vd6E0F+IdR3MRmsPSj/q8xTY5uVoXhYRX3CtvIMoGF+XiKjc957uIUv7mNM5ZrNoisY4VA1xmaYlRgjowoLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015431; c=relaxed/simple;
	bh=ZUYDeLTmAj2LQLzKcDtJmhd4Z4W6WrRqRGSjblPvHQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mct+evbNOHXqJlvab36HnmRdHEKZooWRNsyNA1f1Z3VduFewL20C05p6/wVAWDcf13/AsIY/fqO0vFc8aISIf9GT0Mf7j20m+SdJwZ0aBIa4naMQM1fEV1/2yMELIp1XwcfZ/NOmky/VXiopeN7JnZttPLzPoW1Zn/BwANmVDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JNcQfYN8; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-82a67ce6969so1478854b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015426; x=1774620226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBdEmbZWWu59OJ6fFS09izfH9vxDfscFf+7WDwS0a3c=;
        b=JxICGq4rjEMNMm2j8CF1ceCuNrVQKYOvYKUfnGtTWopKz+99I4V/pES/hwSIX3NrLk
         D7Fcj/c9yUoS3vmOHTElCNgSgKgiuWIMzp5iS0EBjVZJb/7OdsbKMoMQ+HdYw9gsBMwD
         eA6DF3JQj5HUyZMc4X3AoGhLBn2Z8XJN1QXmcUmk6CDr4tnbm6EpWLR6X60tsacyKxYU
         Twu0nO5/119uLnhl4S1ytPmRZ1lYVLNM3/ltrw1xxuTnbeXDk4IlgfX2XZ3I85p7pNN5
         MyHkLJHfsIUcYMv9OMtWGRYN7OIKUPbB4XMBPzZROsFr+gMQoLeYcN04I9mPdMYkObjo
         Racw==
X-Gm-Message-State: AOJu0YxwFFuizKnfQQsDbD4Wn/BbwQ5t/Ef2wJEMGb/fUytn1DJIVGJm
	XkeJEa7bSYle7elRoFBr0MfEgKR+707WL4ESy2I29WccDhhELKg0xyqE32kHRy1TbDjJPt11I3K
	bBMZZC591n/IGRrf7aGFQ1nv2Gsn1+oFCDt9rLkLUGTQYkPDbsLhRv/tI9i2BmOHZ5Wzef1Lm3r
	XfL2xGr9dNhqe9Fz0ban4y78dJbb+lheEfZ/IOwZgQ6y0b0aKKR2JXdUMrHimBnPyCSE+zrKUe2
	XeGNpxbuebTmsvRg6z2/PlBpYys
X-Gm-Gg: ATEYQzxKYhU7czzR2ZLPdfCbiHrcBkEDalApN26ePnsWddSakNPHclpEjgtHKux+uDM
	Zbb0Idnm6vXITUzHfU3wOZNmjKIZt/7WWRUssfM/XtP7o0JxCJn51sCjc5tQ669KFE64JgRon+e
	fUbMlxA+FH3G4P7iVnlecYTNN3OCQT0+lrgDI+7u9H+HNoI3YU4HHg1iMfriOe4nm2g4KgfyaDb
	fWjmXqaYYoexJpMn/gnpQjVoWcOVwuTPueyCQ2etlgJm+zSBaa6fxW/2tcwIwYf2reX+A6W0VXy
	zbxVpTS0T25OBmNRq1NR2gmWUvuHxGGXVfhZldetEB7+/5lH4apg+CEfVs8zDYbrihzhV7bbcU8
	S9aOD9C5W6kFpLRisiIQgGh/2OJYb0qb9Qcu3JGtkSIYy0p3K2+XeWLyPXSmpmaP1XHEMkLvxxz
	LlfFPQJLyZWyuXVw9uXK02j9k4M5g70vaOYBUb8k3SosZSuMBwfqAbhyLgFyRz6JOLUXAgar8=
X-Received: by 2002:a05:6a00:c86:b0:82a:ea3:c174 with SMTP id d2e1a72fcca58-82a8c35f2b1mr2790989b3a.56.1774015425802;
        Fri, 20 Mar 2026 07:03:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82b03aa59desm241652b3a.2.2026.03.20.07.03.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a61300179so7833459b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015424; x=1774620224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBdEmbZWWu59OJ6fFS09izfH9vxDfscFf+7WDwS0a3c=;
        b=JNcQfYN8OerxTpDxZoXEi2bhKCzlodHcGMArmDZFfxD92iPEV4ImNyk9aV6XsemtJW
         lnXXWj+IFWjO8H9KaBPySoHru0DFCRt6SLugR+J8tOsNYSbmNZE+zG1JpRWl2w8s2+f9
         LJm6v9T3oQ5QJPFjKj3LLcMj10HaL/vjy+J6M=
X-Received: by 2002:aa7:8202:0:b0:82c:2299:92e5 with SMTP id d2e1a72fcca58-82c229993d5mr559259b3a.45.1774015423825;
        Fri, 20 Mar 2026 07:03:43 -0700 (PDT)
X-Received: by 2002:aa7:8202:0:b0:82c:2299:92e5 with SMTP id d2e1a72fcca58-82c229993d5mr559215b3a.45.1774015423133;
        Fri, 20 Mar 2026 07:03:43 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:42 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 3/9] RDMA/bnxt_re: Update sq depth for app allocated QPs
Date: Fri, 20 Mar 2026 19:24:31 +0530
Message-ID: <20260320135437.48716-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
References: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18454-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B913E2DB97B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, there's no need to reserve extra slots.
The application accounts for this while allocating the SQ.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b9ea2602d91d..5b700a826045 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1542,7 +1542,8 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool app_qp)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1584,13 +1585,18 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			sq->max_sw_wqe = sq->max_wqe;
 
 	}
-	sq->q_full_delta = diff + 1;
-	/*
-	 * Reserving one slot for Phantom WQE. Application can
-	 * post one extra entry in this case. But allowing this to avoid
-	 * unexpected Queue full condition
-	 */
-	qplqp->sq.q_full_delta -= 1;
+	if (!app_qp) {
+		sq->q_full_delta = diff + 1;
+		/*
+		 * Reserving one slot for Phantom WQE. Application can
+		 * post one extra entry in this case. But allowing this to avoid
+		 * unexpected Queue full condition
+		 */
+		qplqp->sq.q_full_delta -= 1;
+	} else {
+		sq->q_full_delta = 0;
+	}
+
 	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
 
@@ -1740,7 +1746,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq, app_qp);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


