Return-Path: <linux-rdma+bounces-20979-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH+xGnB+DGoSiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20979-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:14:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAEE581366
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81066305AF07
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4CD3242CA;
	Tue, 19 May 2026 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cW2gSpiG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1653AFD18
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203416; cv=none; b=U7hY+ZmUWhZeHIk6bf0uEqpnzW0VJeLkJYvVnXua0r8+gOSQxwuA2sjXFEz4uaedDit6XzmOdwzG4jDeTJwso5FtiS70IpcjL1VCGQz4yiFzmGrJxQUwEjeOSE9pZXnwGiKVb1Kyn6TfLh6H6QIIdvwhg2atw5kMT3yow0DWBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203416; c=relaxed/simple;
	bh=ZkiR0ZbYuYTF6r0+55yABmcpKRK++QPVzmZpL72tGm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKwFifOdNHOeVGC04e/qG1x3mpsNj0HS2VS2Rh8olTHpNHSmjToVyRyne48Ujnkms6cte+qlFDAutwiWFi2H23E5J07oZfH64d4FhiXzmb91Z59a9TI0y78vabgRPE/h2K2lhgtZJq3FGtBCLvQtSUnXsjBIHQDMsZEH4DL31sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cW2gSpiG; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso3694617eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203412; x=1779808212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwWfaryRAuRaBtHh5cCWVYkVSEfWEunhgtZEaPUDx4k=;
        b=Q1gQrdWrFOZwTTNhL3yz+DG3S9y+5ZvRjW2IA6kNJq1a+jMyZE6iLOFwT6exVL8Z0E
         aaOUq+K6dR140wGf4r8VHYYrkF2UyGVEDVzqDYYu5oXgIVkp9sAnVH1/NaIocQBQvN3H
         9mckpl/QIGThsSCX8VFCqQSpyqtgFohCnELOUaaHF0IUMSh4WUJp1HOg3z/4nQsapSTU
         A815tlGlW04F+OaMLWO6+A9lIXVpx0GbLjksHbkL0pq+lyrh0FwJdkqyEn8cpXk1Qs7r
         h2GfbjNOB6dMzOW0e72APeIpxrU/qcWGD7dLsUNtOiLHyOuv/h7UG7g41bsAPB8o6k5v
         W/Qg==
X-Gm-Message-State: AOJu0YxwTHOzPSUK4NdLsGP+7YB8wGJ51hTY5RWkgunf6P/xWRPd0aj5
	eZseoOQ+rK9ceJVUJfeMmJxGAEeybE5TLU8Tfywr8bU3wYO4t9lj0ATqbs1cweRjl+klOR8TRsI
	cQl4xywcDNAm4njK1P+Ri1+MjmBXHtzRn8kKfz+D6iVMBLPsgdJAySqTMzDPtxyZDDXyXYDxzoU
	2/N9gz8kLR21MNkRfSoiXG2CYWFDhXfXTV+O/8QIKwlAPDFEegb0uPwOSGew7LuDEZ3J2O6BCzh
	4Qp1Dh1G+5xSAKDs5dXHEt6iUv/
X-Gm-Gg: Acq92OF2f8V0wRIrgkeRTFMnP8vftbGH8GjGcBRZGLX3UC5JN/3WcfyQq41XXLA0bTd
	aJ2cSk3Ri1G/Gm4H3EvlG3njhvwUpSSSoSXq4BVgPHKcxvDWdCy6LuDGhFP1/jR8QkGiKlMsMzl
	3+R8pFFu+o69GWpIo3r/LtQlB5m1xp1hRhM6Ss0Uik9M3PYZnB6cx4pk/xiIGE5C9f0znMixRXk
	q8TYn04IxDExWf7+AYGTTCjm1c66yOaYxteMzrIrFY+hFzijevaxfWwTKDDIosO/1jmMxkPzd3C
	HMY4wYGevW3fRSODmcgjoKeHzrSrA1EtzoP4o1y/EkeXHfyWNO3Hird8k26uG9zwr3MQ7Z2oWNP
	kUWDgsy9JAsffs2ssJSqjYzmeMhYNGZjilMdbS6flZx3O+EVJD2en8v1gVZCiq1RvKvulJYzyR7
	+tpP0Tkz+EtzTal/3AjXGs/bj1j5IZX5xThVth8piFNtyyfR6lL6PDVruSoEszenZ6Mim5lPEhG
	iYdH+U=
X-Received: by 2002:a05:7301:1284:b0:2ed:6f94:9d96 with SMTP id 5a478bee46e88-30398678a67mr8698153eec.19.1779203411616;
        Tue, 19 May 2026 08:10:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-302970b971dsm1354890eec.28.2026.05.19.08.10.11
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba268cb5e6so37918775ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203409; x=1779808209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwWfaryRAuRaBtHh5cCWVYkVSEfWEunhgtZEaPUDx4k=;
        b=cW2gSpiG7QWJfQy6Lkf2S6P1E1EEuWZjLR22krNkL2Fj2I0h392wONKb1L/mj8MWun
         HW6QhKS8IRLl2PDjtifC/LO4HHig0ZzyRf0oyR8YZixvSVNrGCAiUIeQV+3Bm5A7AO74
         Th4/NDjgvPb1oz1HhQgmcdcMjQA18gw37B2QI=
X-Received: by 2002:a17:902:fe81:b0:2bd:657f:3a1b with SMTP id d9443c01a7336-2bd7e9399admr154131755ad.40.1779203409577;
        Tue, 19 May 2026 08:10:09 -0700 (PDT)
X-Received: by 2002:a17:902:fe81:b0:2bd:657f:3a1b with SMTP id d9443c01a7336-2bd7e9399admr154131475ad.40.1779203409003;
        Tue, 19 May 2026 08:10:09 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:08 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 4/9] RDMA/bnxt_re: Update msn table size for app allocated QPs
Date: Tue, 19 May 2026 20:30:36 +0530
Message-ID: <20260519150041.7251-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20979-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EBAEE581366
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, the driver shouldn't use slots/round-up logic
to compute the msn table size. The application handles this logic
and computes 'sq_npsn' and passes it to the driver using a new uapi
parameter.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 61 +++++++++++++++---------
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index fd1ea053d563..ae32f86b9e9b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1159,29 +1159,39 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
 				 struct bnxt_re_ucontext *cntx,
 				 struct bnxt_qplib_qp *qplib_qp,
-				 struct bnxt_re_qp_req *ureq)
+				 struct bnxt_re_qp_req *ureq,
+				 bool fixed_que_attr)
 {
 	int psn_sz, psn_nume;
 
-	psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
-				sizeof(struct sq_psn_search_ext) :
-				sizeof(struct sq_psn_search);
-	if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
-		psn_nume = ureq->sq_slots;
+	if (rdev->dev_attr &&
+	    _is_host_msn_table(rdev->dev_attr->dev_cap_flags2))
+		psn_sz = sizeof(struct sq_msn_search);
+	else
+		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
+					sizeof(struct sq_psn_search_ext) :
+					sizeof(struct sq_psn_search);
+	if (!fixed_que_attr) {
+		if (cntx && bnxt_re_is_var_size_supported(rdev, cntx)) {
+			psn_nume = ureq->sq_slots;
+		} else {
+			psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
+			qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
+				 sizeof(struct bnxt_qplib_sge));
+		}
+		if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
+			psn_nume = roundup_pow_of_two(psn_nume);
 	} else {
-		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
-		qplib_qp->sq.max_wqe : ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
-			 sizeof(struct bnxt_qplib_sge));
+		psn_nume = ureq->sq_npsn;
 	}
-	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
-		psn_nume = roundup_pow_of_two(psn_nume);
 
 	return psn_nume * psn_sz;
 }
 
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1193,7 +1203,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
-		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
+		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq, fixed_que_attr);
 
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
@@ -1647,7 +1657,9 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
-static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
+					      bool fixed_que_attr,
+					      struct bnxt_re_qp_req *req)
 {
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_qplib_q *sq = &qplib_qp->sq;
@@ -1670,12 +1682,17 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
 
 	/* Update msn tbl size */
 	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz) {
-		if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
-		else
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode)) / 2;
+		if (!fixed_que_attr) {
+			if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
+			else
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode))
+						/ 2;
+		} else {
+			qplib_qp->msn_tbl_sz = req->sq_npsn;
+		}
 		qplib_qp->msn = 0;
 	}
 }
@@ -1750,12 +1767,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr);
 		if (rc)
 			return rc;
 	}
 
-	bnxt_re_qp_calculate_msn_psn_size(qp);
+	bnxt_re_qp_calculate_msn_psn_size(qp, fixed_que_attr, ureq);
 
 	rc = bnxt_re_setup_qp_hwqs(qp);
 	if (rc)
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 40955eaba32e..db8400f2ce3b 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -135,6 +135,7 @@ struct bnxt_re_qp_req {
 	__aligned_u64 qp_handle;
 	__aligned_u64 comp_mask;
 	__u32 sq_slots;
+	__u32 sq_npsn;
 };
 
 struct bnxt_re_qp_resp {
-- 
2.51.2.636.ga99f379adf


