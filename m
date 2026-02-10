Return-Path: <linux-rdma+bounces-16733-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAseCSFmi2kMUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16733-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:08:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8811D98B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0F8830488FC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6F374180;
	Tue, 10 Feb 2026 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DvXzEzj6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3F366809
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743320; cv=none; b=jdS+o/VCH9MkeTlQmJNtakVUWRWM2uvQzPzP4z2RdTyRf9CKSUQasLCet/1M41fegIf3Hx+0zYvrhQVg+l8ldBh24oNrA2BFWGMzW+xoTSnE4SRhMW2J/Q5b7Pj2ffAmzNH0vTOfE0rtLBrMw+ig4C2Op/7YUfOzRkgIPPJ7Qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743320; c=relaxed/simple;
	bh=d4cEnbAqs1csP8ElTuboTEj8qCvJiRt7Rom/pqG7suI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNZ1cE/SwWZ1t4kSDnIgcBuF2liBiSl7rwqwxKJ3eA3eA0Q8vP0Dvj51K0fN3/3I8f5HeVpzmKdTnkfJ/ZkP4ArawOaoISG8eFxSAr+wOYCD9DRKddgmaPzNJv0Ws05/ctJflbgNna17sCFApZeZcXscM8pjwrNjJS2djXP+CWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DvXzEzj6; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a95de4b5cbso37353795ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743319; x=1771348119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqCIroZwPvoDfbhIjth6Jc5VulNHcwr6TnMXh1VFCwU=;
        b=NkzqCrAEgJD980/glqwR8bfcR9YmZ6Wnz/3o3zJOVeXAwGUWRpK4IzVsyO6d39mSX+
         xDL4UEdms0IeRTJQ6l1fkQtxnq2KB8bc4f2Z7xAksKElI/DOKrRGyMbw9FXIk1ymx8a6
         nqGoQAKF9Bn5w4BKaqFeL8oOMRSDK+mHBHjQzLpU1QdvCaD4htbLCcLzrrDaVTOc6GQL
         vrGogMcZdNCLIA5bp7U1eWE7SCR6VXNbnEIilhZD3Z68N+ZWHPX8Q+ZMVwsnHsv2VnFy
         NjXffieTmKmydtcKo5uappuotM73yfT/WLB8jQ2mOyDFmwzCayIxT9Fd++GPmYpCc9ql
         5/rg==
X-Gm-Message-State: AOJu0YwxOHQIWL4VXb/BlN6pwLCUiyJ1NINPNWMgQT0TnH70ZjG6doEK
	/VHGghMdMKan6SEf7gJKs6phrZIcZuUZBw0FWkhRo2c2fZD249gZbOhTmQ8HOLl+9riLoLMhpZE
	mYXMmskCWBLBaghUeY5PvpCNSLsXTVSIB7YD9zcQyxumgQ7GymDrVGWR4O9D7JODeM4uAMNWkFg
	Eig1W5hHQYbvJBTw/vlKw+o7/yxyY2h31Qpi30Q7SduUXvi1FUumrxW2VVkwdaSAQZjexSw4Zgv
	bMXvsxexbiNQWOFdSpz+BouoShQ
X-Gm-Gg: AZuq6aKufX2G8QZnbas6H4rxVF/B/kRzHorptYlZsC67eioMgu5BvWKUvsqg9/Zw7uX
	IF8ve9/VCiWzryxW71kaV49Z6vlJcCvyjj1BqznUwr0h9ZN95dFjarGRbYjp+5YUyDBChjBSZNg
	gwicSQKfTCmutcNxmx9KGyMe2x/qG/3J0Y+yng3oU7L0jbKMNABpYmJ44TZMFVh4yZEcYEwUgXL
	UlWTizCDrVnmzQYOzphtFkfIhY1eP3ZHKVVZjL7BlgG7JCousGES+Iz/akneZQXcFIc4ZoLnFu+
	B5EEPsTHWIu1vtfc6WBbWyHYSgjZA+ejaCuJfHlNPgDewR/F+OQPxTqoI4qU7h/BF+i0zu/Nb7u
	zvxC+DuxCmG7mBEvrT9zLflaQhIcekMYwmsuAmOOaakghfPeSdkP5U7IiqKHSzGBuVA8HK1iE2h
	VJdYwD8/dYAN351obxsGGrQt2ACHmfAV7fBpA/cZXPVtF/MD21A/OZD2bfljF3ICwnwf14
X-Received: by 2002:a17:903:1965:b0:2a9:4450:abbc with SMTP id d9443c01a7336-2ab105beb5bmr30570105ad.26.1770743319018;
        Tue, 10 Feb 2026 09:08:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a951c6dadesm18714575ad.17.2026.02.10.09.08.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:08:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81e7fd70908so13553269b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770743317; x=1771348117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqCIroZwPvoDfbhIjth6Jc5VulNHcwr6TnMXh1VFCwU=;
        b=DvXzEzj6GOfZxPyOi0TVEUH+U2nBsNJbpB7C66s52ybfNszP4M0wZB53CMa5AILSCS
         +58x3BwUByZucjcMigh5834GchtjHM91QiewjbaF/SczvIOJ/OyC/O1k89Ey/4SuVXOb
         eTHW1CXUSuPTz2d4XW6QZ1Kxcrrg4aYLGoDZQ=
X-Received: by 2002:a05:6a00:a512:10b0:824:9522:f747 with SMTP id d2e1a72fcca58-82495230b46mr636364b3a.34.1770743317123;
        Tue, 10 Feb 2026 09:08:37 -0800 (PST)
X-Received: by 2002:a05:6a00:a512:10b0:824:9522:f747 with SMTP id d2e1a72fcca58-82495230b46mr636344b3a.34.1770743316738;
        Tue, 10 Feb 2026 09:08:36 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f269sm15620806b3a.7.2026.02.10.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:08:36 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v11 4/6] RDMA/bnxt_re: Refactor bnxt_re_create_cq()
Date: Tue, 10 Feb 2026 22:29:37 +0530
Message-ID: <20260210165939.41625-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16733-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8C8811D98B
X-Rspamd-Action: no action

Some applications may allocate dmabuf based memory for CQs. To support
this, update the existing code to use SZ_4K to specify supported HW
page size for CQs, as we support only 4K pages for now.
Call ib_umem_find_best_pgsz() to ensure umem supports this requested
page size. A helper function includes these changes.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index feb364e45e14..fb30b3831d49 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3348,6 +3348,30 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	return 0;
 }
 
+static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
+				struct ib_umem *umem,
+				struct bnxt_qplib_sg_info *sginfo)
+{
+	unsigned long page_size;
+
+	if (!umem)
+		return -EINVAL;
+
+	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
+	if (!page_size || page_size != SZ_4K)
+		return -EINVAL;
+
+	sginfo->umem = umem;
+	sginfo->npages = ib_umem_num_dma_blocks(umem, page_size);
+	sginfo->pgsize = page_size;
+	sginfo->pgshft = __builtin_ctz(page_size);
+	ibdev_dbg(&rdev->ibdev,
+		  "umem: 0x%llx npages: %d page_size: %d page_shift: %d\n",
+		  (u64)umem, sginfo->npages, sginfo->pgsize, sginfo->pgshft);
+
+	return 0;
+}
+
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
 {
@@ -3379,8 +3403,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
-	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
 
@@ -3395,7 +3417,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			rc = PTR_ERR(cq->umem);
 			goto fail;
 		}
-		cq->qplib_cq.sg_info.umem = cq->umem;
+		rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
+		if (rc)
+			goto fail;
+
 		cq->qplib_cq.dpi = &uctx->dpi;
 	} else {
 		cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
@@ -3406,6 +3431,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			goto fail;
 		}
 
+		cq->qplib_cq.sg_info.pgsize = SZ_4K;
+		cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
 		cq->qplib_cq.dpi = &rdev->dpi_privileged;
 	}
 	cq->qplib_cq.max_wqe = entries;
-- 
2.51.2.636.ga99f379adf


