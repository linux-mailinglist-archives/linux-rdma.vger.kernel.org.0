Return-Path: <linux-rdma+bounces-18455-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMUcGTpUvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18455-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:05:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7FD2DB911
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 831943015EF8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A22E1F0E;
	Fri, 20 Mar 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JOynKpTW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7D318EC7
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015435; cv=none; b=SmLbq6syBVWHpA+0VFboG2KV1KxAcbyXGr+z73rdwNyWCg1/xuL8/ih6z9rrZhaRlWw1PIQYtBmThLtGkUJ+BuhS2ynTVxtTzn40A8oerrayp01wa4aJe+SKd14aPZSEEZUcy4zMK4EOtT5DaxFeFjaSZSAugYe5xNo55CmskNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015435; c=relaxed/simple;
	bh=rhrFQ3UPmGqUD6hXVwU1hQqUNYdeGOhTDNczlG4AVPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohue4T/8IoreDjRJALwlSoIbPHjhAQP7/xAfiz+Y0GLGeuaeapSy0WYwZRlEglQfksf5j5asX4sSKbmLI8zn2veNDiC1xm41j9L2KbfEiIfq+rrsPtc/s3juX3dzRvZU6dvQ7DLS5GDnyvU5y0tzEKyOd1O3Fjsm9drNmGkFK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JOynKpTW; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64e87a81639so2356323d50.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015431; x=1774620231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGKoT99WMTc3uF+tel1OKG1Fl3fQIkE1JDWEUsa7V0k=;
        b=KtXwgdtXMGCAyL5tNAdCknx7W1beDS6zRMO4tvVwP6yeC4IXaV1kT+5OuQmh8bilAO
         /9/wEpqr6RDkQgnv0UWDla1mBDPyonOl3CJtRFKH6DW0Ox8ecP5PCCrd3XlxJ0kN0NOG
         UrOqvfn00ersBDpeXYPrZoTRwSzM5Jn/LD0EBXD+p7WY0XBp09PDbno8HGJZH9Xvlzur
         ElYYYWleecfOlC38EyY/lqTGRiNm9DB1eNH6Ve+Qi4FE8yGpLG1Lqf7qsecWfDL3Q3om
         8fXvTgPgkLmR16Bn4A+IL2hCEInA0thv+ltpTzYCGJwVKZV0qZMLxTaZb7aMhb6YxVAC
         Jolw==
X-Gm-Message-State: AOJu0YyFbSZQWRbIYbtNIUzW3Dgo05ZP3iJjCkInEMR/4wka6MBdcXsw
	W1iSNvTY403MsXdSWmUJRZEr7xSMmVqJ7MjkwdUKBdxB5nAsYDM5NRYaGO5wXqnv1E+VmIRDp87
	5lQn/rzV7ajGEzewHUH8n0G8Yt0noixjCX0GNVrzwym+sw9iuOlZGmzOR+Yi44SyVd0Mc+YbLHv
	GrHnYOOMOmV+DThpS8pTZFcB7iDucmH832m6g7DA2pCkY6XrKQkKXvzM/7ajlx8N5+tLEXpAt9+
	W7lBvD81CNUSQM1ZaLm9zMk+RXZ
X-Gm-Gg: ATEYQzwnf9aD4LPBqTYs9RXX8cfFm2QlB3FcBahzn5YUC9g9tBo7ZO8Wp5m1Dloh94A
	C3A634hRHQ6o8eucmuXfhDxYvBeyUNqbvl0106BXxb1GUn5FAeWPgCnHAfMfM7TouO08k+ezy/i
	5fj5obuCT1w3JrtfM1mC8PJnIs/4NmfMAuqNfpZ7ESffzKf+rOzpQtvXgMFG1a2TIrVUhBtcjH9
	JAZY/mhjO/t9s5n+8OZhBw+9GiQM3s9dUahxCr6d0woi5vPuoGKXMrCxPGaLg7QgpnB7zKZ4NcA
	+1qZFQ0xdunTbxEWmZrqTMHMlIBtTuRklKvML/0R1DVhCBZ1oa091Jg8kcpRU04o8a3VPvUsYCQ
	4vQx5i7vLoV2VTlr9aCySK+V1z29zXgCQO5KflHwjAF7PIfHWeNTJjTKqyK9IJv54TFo8OYplkd
	A4viJJrmNrpEz1olgzKTncQqzjiAZOSOcbIlDX5rMRvl4yQnjWkHF6Uo4tLlNi5GudWlBNNH0=
X-Received: by 2002:a53:b185:0:b0:64c:f845:94dc with SMTP id 956f58d0204a3-64eaa698288mr2307435d50.13.1774015429391;
        Fri, 20 Mar 2026 07:03:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64eabd6a014sm210644d50.3.2026.03.20.07.03.49
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a68acce26so1203927b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015428; x=1774620228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGKoT99WMTc3uF+tel1OKG1Fl3fQIkE1JDWEUsa7V0k=;
        b=JOynKpTW5LK4EHsS2bI9AuTW+wgmvRYT/MYezjvfgR4W6ljbhMz01J38IW4Y5ZZ4NK
         TdOSs62JmsqC00RVLKqtdNDT8cjo14ljOxdcZMScLr2c+Dq/ArGMaAqnYpw+IEQw1v1N
         GPdHdakk6zPttvpqigvA+wLtvIFvGSayHVsC8=
X-Received: by 2002:a05:6a00:2991:b0:827:28ba:ff00 with SMTP id d2e1a72fcca58-82a8c27fff9mr2545424b3a.18.1774015427445;
        Fri, 20 Mar 2026 07:03:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:2991:b0:827:28ba:ff00 with SMTP id d2e1a72fcca58-82a8c27fff9mr2545387b3a.18.1774015426563;
        Fri, 20 Mar 2026 07:03:46 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:45 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 4/9] RDMA/bnxt_re: Update umem for app allocated QPs
Date: Fri, 20 Mar 2026 19:24:32 +0530
Message-ID: <20260320135437.48716-5-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18455-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AC7FD2DB911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, use sq_umem and rq_umem provided by the
application via uverbs layer. A subsequent patch in this series
registers create_qp_umem devop.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 68 +++++++++++++++---------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5b700a826045..b8da3ae81043 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1181,7 +1181,9 @@ static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
 
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				struct ib_umem *sq_umem,
+				struct ib_umem *rq_umem)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1190,18 +1192,23 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 
 	qplib_qp = &qp->qplib_qp;
 
-	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
-	/* Consider mapping PSN search memory only for RC QPs. */
-	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
-		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
+	if (!sq_umem) {
+		bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
+		/* Consider mapping PSN search memory only for RC QPs. */
+		if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
+			bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
 
-	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem))
-		return PTR_ERR(umem);
+		bytes = PAGE_ALIGN(bytes);
+		umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
+				   IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem))
+			return PTR_ERR(umem);
+
+		qp->sumem = umem;
+	} else {
+		qp->sumem = sq_umem;
+	}
 
-	qp->sumem = umem;
 	rc = bnxt_re_setup_sginfo(rdev, qp->sumem, &qplib_qp->sq.sg_info);
 	if (rc)
 		goto fail;
@@ -1209,16 +1216,21 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	if (qp->qplib_qp.srq)
 		goto done;
 
-	bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
-	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem)) {
-		rc = PTR_ERR(umem);
-		goto fail;
+	if (!rq_umem) {
+		bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
+		bytes = PAGE_ALIGN(bytes);
+		umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
+				   IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem)) {
+			rc = PTR_ERR(umem);
+			goto fail;
+		}
+
+		qp->rumem = umem;
+	} else {
+		qp->rumem = rq_umem;
 	}
 
-	qp->rumem = umem;
 	rc = bnxt_re_setup_sginfo(rdev, qp->rumem, &qplib_qp->rq.sg_info);
 	if (rc)
 		goto rqfail;
@@ -1230,11 +1242,13 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	return 0;
 
 rqfail:
-	ib_umem_release(qp->rumem);
+	if (!rq_umem)
+		ib_umem_release(qp->rumem);
 	qp->rumem = NULL;
 	memset(&qplib_qp->rq.sg_info, 0, sizeof(qplib_qp->rq.sg_info));
 fail:
-	ib_umem_release(qp->sumem);
+	if (!sq_umem)
+		ib_umem_release(qp->sumem);
 	qp->sumem = NULL;
 	memset(&qplib_qp->sq.sg_info, 0, sizeof(qplib_qp->sq.sg_info));
 	return rc;
@@ -1686,7 +1700,9 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				struct ib_umem *sq_umem,
+				struct ib_umem *rq_umem)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1753,7 +1769,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq,
+					  sq_umem, rq_umem);
 		if (rc)
 			return rc;
 	}
@@ -1890,6 +1907,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
+	struct ib_umem *sq_umem = NULL;
+	struct ib_umem *rq_umem = NULL;
 	struct bnxt_re_ucontext *uctx;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
@@ -1919,7 +1938,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
+				  sq_umem, rq_umem);
 	if (rc)
 		goto fail;
 
-- 
2.51.2.636.ga99f379adf


