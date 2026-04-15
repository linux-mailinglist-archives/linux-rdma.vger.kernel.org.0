Return-Path: <linux-rdma+bounces-19370-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMlkBEYp32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19370-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B025400ABE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87AEA305A5C1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4EA372B2B;
	Wed, 15 Apr 2026 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PJ0O6ECa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B2372ECD
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232756; cv=none; b=tOD1HPu4jEuIm5oRP6ADLN7enBDGUQ0GA5pc7tMlhGvfeyTT2fH+a36n7Vd4ZGKV/LwO0nqLbsSBXcyT8g5rtfzv7u2iUeHQeiaPZdPPO5tUChBtCaMfpYTyEPtUKxNBJ8lv/xkVkeMQ/Ws7mf53XCiJMpPRmX2D/xSHHuAIlyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232756; c=relaxed/simple;
	bh=xhx+LH8a+hsqd/NzLAc1TQ/Inz+z1lX8i3HX9fkenhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpVbJOpkYsVuObdvkQR4jD9WqHZemjsq2whagZoDbBDwq5YF/MO8RdKrVGk6wbANKQOttRqEVJF878Rv41Ugy+iRxq/MBiCjvg6Gkf0dcG7Jg+n6aSdcOA6KXC1IgoIlHLWvUDmX0tC8RkFQEUN1u0EvgCE4cjyxO5OU2Ja2mq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PJ0O6ECa; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8d933da14f0so684868385a.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232754; x=1776837554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZt7jaIrgssI5cvohiakZYgr9+Tmx/G3N/CWJ6N+ExU=;
        b=KDJbRM10NVQqgs1jMWyPSCwD8PgvUsPEPVvqHLI5bxPq6gVtlgV20tc2H/31uhKEY0
         SW+egD0WHEwNojRS+xHcE37rs8puIzgR85riLIlia52d6IvrNg+S2/uSqpAoaGVCGhg5
         O1KWAGVHlDNYFgJ93DtGT+NgRm0Ab3A2gEq0PsFqH1hX2saHA5sGmulE8SK+vtx8H3x5
         UkC4aAJksCBBVMuPjRCojQaATeUmYr/oLhjHSnP2JFIgwy57kPdaEgqklnviG98KFzwX
         5O1eAMsWBio3/H4xwghpXtIbRmQiGUfjpYEkIczYF2OAl4J9Vk6ae9PXozcprj/ewArC
         Tvgw==
X-Gm-Message-State: AOJu0YxTPNuqdmrkzgoQqs0+yJyFWfLqQsCS1SLY+U6J/h7KkB38fd42
	JEdiRleuAtu+nChI3VVi2gMmvM7VmcvJ3Loex5SLS2hmLUypOPME949Q9zVGSamwLONMfsURMgV
	M3X/bEH9FmEznT7J7g58TtWQ1vJgcOdm/AcGJ4d8m5Ok8GirUt0O7sFjbXkwp6/5D+hKNCy9ogT
	OekBSzHJ5gvx471rDqlD2gXFCnk4X5PvuTk1gpF1c1GD9wj3pu26bHEfgkV6GONqmw8pxgOr+Ek
	d3N5VQ9obN6PLTGg59YHIfUsL6u
X-Gm-Gg: AeBDies1/J8qjTY2TXqnh2MP84gRLX6bV7JRACiE5tpesSey7B7qLsL8bxSMk4VFbQY
	mDzeMg/W55dzLEWh3d+iNS3OxnVJZqMd5b0g+DewDR6aASmfNbS1w00lvVg9m4vnLnTCs9O35YC
	JV7DRSOlUUSU73D9B6ucDa3eRRLLuE7wai2Kqen8Jo+aPJxfRTQrrVFE5TlwlPD/tSgyRQDzMH8
	AwdgY0WQJ2o6DgogAoll9T/FAEUXoVEswHhsXWI3zaizo6c75uDRszq6oOVYNHzCpPKnwAknsF3
	Hb6ptDIzx11gUAn3TEkq9Pkk0J2mft9sC2S64gFL6jxVOUvZvHUQjWt3UlFYo0H7K9isRuJu16F
	mUJcqPLIaUY94u1VMdMpdGnl+othAzA6FU4sDQIfT5FX61zzjjLXAV86orGpcHqX/aWbySqP5sm
	D01uX6XbuNQHegpnhFa7Kzhp+cO+iL4XtnbyT48B0264bdYPtljvr/oGGS2KpW7M8s9El7
X-Received: by 2002:a05:620a:4443:b0:8cd:c0b6:87f7 with SMTP id af79cd13be357-8ddcf9b5414mr2825254985a.46.1776232754138;
        Tue, 14 Apr 2026 22:59:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ae6c9591acsm532716d6.7.2026.04.14.22.59.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2e8ff14e5so27782635ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232752; x=1776837552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZt7jaIrgssI5cvohiakZYgr9+Tmx/G3N/CWJ6N+ExU=;
        b=PJ0O6ECaAQzZ3wH0UL18i2a3znMb0Qmwn4BS/EkZctZPqq1dVAB1OnavOKgRezMRHa
         Drwwv9hDW7jWEYvpBN5zah7Pk9j0AP7yMGA9E5kcHdVInDjk4niq1lnFz957bKNaQuhS
         62HQWpwj5YLIg+7rLYQxyAEDo21ngru66x8tI=
X-Received: by 2002:a17:902:a5c2:b0:2b0:5cb4:d894 with SMTP id d9443c01a7336-2b2d597d2admr138474075ad.13.1776232751979;
        Tue, 14 Apr 2026 22:59:11 -0700 (PDT)
X-Received: by 2002:a17:902:a5c2:b0:2b0:5cb4:d894 with SMTP id d9443c01a7336-2b2d597d2admr138473945ad.13.1776232751499;
        Tue, 14 Apr 2026 22:59:11 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:59:11 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 4/7] RDMA/bnxt_re: Update msn table size for app allocated QPs
Date: Wed, 15 Apr 2026 11:19:54 +0530
Message-ID: <20260415054957.36745-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
References: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19370-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B025400ABE
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
index 4594e98762f7..219272e69ebc 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1159,29 +1159,39 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
 				 struct bnxt_re_ucontext *cntx,
 				 struct bnxt_qplib_qp *qplib_qp,
-				 struct bnxt_re_qp_req *ureq)
+				 struct bnxt_re_qp_req *ureq,
+				 bool app_qp)
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
+	if (!app_qp) {
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
+				bool app_qp)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1193,7 +1203,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
-		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
+		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq, app_qp);
 
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
@@ -1648,7 +1658,9 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
-static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
+					      bool app_qp,
+					      struct bnxt_re_qp_req *req)
 {
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_qplib_q *sq = &qplib_qp->sq;
@@ -1671,12 +1683,17 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
 
 	/* Update msn tbl size */
 	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz) {
-		if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
-		else
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode)) / 2;
+		if (!app_qp) {
+			if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
+			else
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode))
+						/ 2;
+		} else {
+			qplib_qp->msn_tbl_sz = req->sq_npsn / 2; /* WQE_MODE_VARIABLE */
+		}
 		qplib_qp->msn = 0;
 	}
 }
@@ -1751,12 +1768,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, app_qp);
 		if (rc)
 			return rc;
 	}
 
-	bnxt_re_qp_calculate_msn_psn_size(qp);
+	bnxt_re_qp_calculate_msn_psn_size(qp, app_qp, ureq);
 
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


