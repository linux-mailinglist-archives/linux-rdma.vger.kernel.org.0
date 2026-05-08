Return-Path: <linux-rdma+bounces-20227-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePsLCHmo/WmEhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20227-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:10:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AEE4F4161
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C07BD301A73B
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E909378828;
	Fri,  8 May 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IY5FkTI9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37837C921
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231310; cv=none; b=CusH9KNqgGuwolByBdFZyk3rc0cJcpFh6fYRJiR354F8giW8mIDPxnkvcLB3e3WBdGkTAr+wWK+BCATrrNvXMl5a+krs45DrqjUq4lDJRKgeyr4j654wrLVmOpyP6M1RbOPckxa+sh3ghNmMp2pytOtw5jg9lrC1L0OwjaTC8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231310; c=relaxed/simple;
	bh=SQIhW/S0Jqs6PstY97ay3LZfhecfwjv43emKeV2q+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn4B/tTMstBwAQLLvfIhVQQSNP26frSmAl4TBTf0XhTAm/j1ArsscnDTQHh3uip5OJL0h2/vmKyjJC9ktZpyXK2T+5f80Ql8vYnXDv7ZqhH3JqkcKwejs/VsjEubmsbXToSAN7OkkiQVquGc/wBqp1phhUfMstN14hjv47XlWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IY5FkTI9; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cb5c9ba82bso260208885a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231307; x=1778836107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uco0/yxhA2h9VW7XaIQf7wAGQixfRTBwN4rKGJt9pKk=;
        b=IDGih5uEQ6BF2PYoK2WI+8HwDnWQ9k4pJ84kEvTjiAqiJUXlHHr6ceVL0jk38XrB0n
         A3w3l4fqcoIkMEcgMtxi948LkmxbBBOgS/tvZVAM+gKaNQCWi7AwK4WcyW4CMqRyUW32
         uELww1EazPa5oZ2CQNUxxK6+KxkPykeZoTkoMKHKkuaPuCtQmVDEs/nWw86L8WZkK6SK
         cSjDWU7ebLK1RiXF0r1bVADvPGdqSANDNEZ25Uq04AwHQFLwO25m+2KpFYhlncXfLJ16
         8FrDIV/HM8rp6txiFI4xyoTwMcqLCRKAAqzZDz3F+3TnxfImUJmQSRuMnUtUHPxNjFgr
         Ub5g==
X-Gm-Message-State: AOJu0Yw8GveV25fNrHmlVyieK019lmuimyq66ogWhQhEffc/ukn9vhRy
	4txNA84GcQE97F3xNtS5N/+ZX3Er1ae/IhE2tIimvKtTph5okApxkzMRszviIT5ZgkeZP+ydhEq
	xEGIIFrRYWPGvDzaAMeTYNvyq1aE0gpew2EP615uJq8ndqam2Ws9Nox55uHG7S8Vh3yqqEcBcEC
	KcqWoH0xEBDOrh4fl6gbZt5RSgkAV2JnCT6OClLwsuJoRqNcWc8/KLQOUfLy6oehWTSX8OXSmzg
	hku0Uah79qk7leX8MtR3ooJ/Dsu
X-Gm-Gg: AeBDies0jhQjpauJxj2C6wf3WImSTPTSS6iuuU0OSZU/cwX05qfJmW6enGLlIWHV38G
	N8cH9HRUvchdoXc9JIE6ilT7QoObJAJCRQ61Q50vhtPkjWd8TyMWuUFVLDNp6yKq2EwAY2h7+/V
	Yq+vba1i1zMAmZwQ/nPRAua11yw4jT3w26g4YORBCFQXAaavESBwuwoWLq7Cswl4+pmJ9S6v+Nc
	zveVAgDlV8Su9zoh1XhckK07r1A+KO4b1AJxVi5OswfrnikkaLeY5bXX2i1o9SesoaPzQ1McBq/
	aqA6IOMmNXhJN3dS1CLoIgWHuWJI7oS8wTYAnDpdnfs+57T2XNEF6NcbMOS6bS0dMQTEVWO+c5V
	FTqEzERY6duKGzzaNmR6kkTI8PCT8zRu1xKaD5FX4oRIo2OdjEJfqnc6TGl2ERVxhA6BNbKquEC
	aVzxxGi6MeV2AEhJlR/31iKdCZ5ErokkCaCRIwiakXW/BYJeSlZ0BpmeXDNGXwSSn3rcUI
X-Received: by 2002:a05:620a:410c:b0:902:e19c:27aa with SMTP id af79cd13be357-904d3fa3cddmr1753120285a.7.1778231307092;
        Fri, 08 May 2026 02:08:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-907b8ba8c25sm11680285a.6.2026.05.08.02.08.26
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 02:08:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so2159846b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778231306; x=1778836106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uco0/yxhA2h9VW7XaIQf7wAGQixfRTBwN4rKGJt9pKk=;
        b=IY5FkTI9r0BS0EjabiR83y52bRv4URokdFtPTW6ykQmq3yqnyjBB80Msi8/MHNbMCP
         EaT4vKTNDt6kMbeY4YMY4hsK0Ts41Npfk6I8FhcyYezDztFoPBHUr1c4MzFpMagmzMhQ
         KQsh9vW3kpIAVZb8hKRSPXNK5OjYBDQTF5bZg=
X-Received: by 2002:a05:6a00:420e:b0:837:80a:5aaa with SMTP id d2e1a72fcca58-83a5ea3c118mr11241941b3a.45.1778231305912;
        Fri, 08 May 2026 02:08:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:420e:b0:837:80a:5aaa with SMTP id d2e1a72fcca58-83a5ea3c118mr11241908b3a.45.1778231305396;
        Fri, 08 May 2026 02:08:25 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm14419052b3a.31.2026.05.08.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:08:23 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 4/7] RDMA/bnxt_re: Update msn table size for app allocated QPs
Date: Fri,  8 May 2026 14:28:55 +0530
Message-ID: <20260508085858.21060-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
References: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 25AEE4F4161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20227-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index 2954674fdd33..33c6b8985b4f 100644
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
@@ -1648,7 +1658,9 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
-static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
+					      bool fixed_que_attr,
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
+		if (!fixed_que_attr) {
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


