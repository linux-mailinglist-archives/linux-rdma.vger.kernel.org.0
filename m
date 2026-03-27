Return-Path: <linux-rdma+bounces-18732-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBg/IPdNxmmgIAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18732-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:29:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEED341B77
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CCB23073CB8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394993CE4A8;
	Fri, 27 Mar 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a6c/duuC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCA3932DD
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603633; cv=none; b=VzRMB5/8MpttWecgAbLl6j82D4EHVYtfX7TUtADoPy6ALsuOPt63wfIhrq7s7awcUzhqghX4dwNyKI3AGhJSCj7PsrokXcsfdbL6uSKhr4dYFDvqwuUQU/CJR+hqeDaBM4Z+pbx5M1mc0TCU1XXrp1DQGYzn/xKgwzEedbY5dOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603633; c=relaxed/simple;
	bh=XZ07HNOh22G0UL7k4aKQnHrjbd0tI9IiKI90jsqEMX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZvZ0RpxtpcWJ/ASSK+jxX+hjheTB5X722+vhr2f+GxOnkcAv8hcsKY4R/PDPQNvtwAXSBFs6KdRzG4oI6vErUgy094BmpdsdWHlkImTfXnNha3Dg06pIlU7n9ffZoDQyDKM8kRSV3gXpRIrxZvA7mHgoav6xY5gJdA41l6xB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a6c/duuC; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35c124d2613so1313464a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603631; x=1775208431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPv5m8iZKbmnq7w39cNGvze9zgwj7p9D1Na9OTnu9nM=;
        b=UkqEq8LKs7GHeO+yGYMlwfPYsPYJHbPrfCQUwQuOFp7i3NpnIUeGtY5hS2JEc9R4Z9
         G6zj/MdgOaZL1kex37Yhoy5TXElynnnnetrQ/0VBr746YwXuhZ0rXQPpDi0IQQWlMihl
         el3DwnDB7C43T9JTekZWMk11z04iX53X4haqvW0kzgUrtoCphQNjX99jcA9LXID2eP5r
         ppEZYB4o3gDbPV8pD4022Pf03CKeiM9ZN7YV9yDsWNIITPU6cSBzcC4zukZdX3m7YcoV
         qWRkMX2Ib3nCDatCOQrd1T5H2on00piFPZPJDruX8uYzW+eHJwauyRiTY8apLKP66TCA
         hCCw==
X-Gm-Message-State: AOJu0YxVLV7T05EYForFpdhAB58lNxtAmkwgui/OlbTK4LzphVlNXtc3
	1kiGSUwmgGYCFv3yqjcg9n4pYku9Z7vOGqPFAY/E/RZL4P1c3LW1p2QYI6lhkszkG5k++ZKIMgM
	4VWrN1hBZKOLk9yb3DjHE7t5NvNFzvIbOOxLGq6d2nklKMnvHcCYJHZOf3UDVF9y2ybwdGb9oWu
	eCQQvfdAvmp2u7I1dHcW7qjYwTty45c1jdZBaKDFrL341wxzAUXuXIFqpvh3+ywFLjsWLYIpnjV
	39gqeKZPuLiscSLLUzM1Zxr1d7q
X-Gm-Gg: ATEYQzwuRW/wR7CdMu/T481m09QfXA294pX7xA+iXRr4X01mGBqvelPvB8u7EwgNoyK
	wKrGO+JYN/S7QiuW3l05Nn4DxnNuvErImqSzpLl5bc0TX90qI67UXtKojftuldDT9POV9hOMz+b
	dajQRwdWgFOzfz8TNSVjFgEsxRWOR+NFWpxukcsd2kllKnuQy2t3Tgds6ycFcOaqATjI+GJNatD
	kDMhAoATipfG/LQ1ESHk+ksZNUZjR6ujBVFhICNRsRCKQ5d15ULG9Pzi+fjHQEsx7PFqCBdnJ31
	34EHZooMMBf0Sw09LEWwKzGL4yLU52A3bdsclOoY/bUas9+Eeht4OkDlqVel3pVh96/d/FN+vop
	jYl+OCfahxBhizbeDvXU2BYBDLeCkZaL3irNFCU04KCDmgsT4MIcfCv8hn//RkAjIkg/ZHw3ZP4
	UbexWmNcJiDeNfxjPD+hwoRzw7UtnCCAFMP4KgbdvyDlgouxOYdNbXKofd3PPBz8KiEn/F
X-Received: by 2002:a17:903:1a84:b0:2ae:5763:99cd with SMTP id d9443c01a7336-2b0cddb3806mr21848615ad.49.1774603630891;
        Fri, 27 Mar 2026 02:27:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0bc8bc5dasm6016885ad.46.2026.03.27.02.27.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7949310b90cso36584067b3.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603630; x=1775208430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPv5m8iZKbmnq7w39cNGvze9zgwj7p9D1Na9OTnu9nM=;
        b=a6c/duuCntLDGg0Q0ojJc6jfGOqB+nfCsbUU79S2Y9WM0EGqBtXT2wa3LsOQhJ2Jjf
         IxR+ySgtchbid3maGS+OB7Y5IWgSI3R2EeIglgv0s8ihRqV1rdMcACM5iWZEIsYEmmQg
         rv5uXNn+/r7PbMWZeg51PyTL88GYRLM7flJHc=
X-Received: by 2002:a05:690c:94:b0:798:4f55:2c5e with SMTP id 00721157ae682-79bde0af51emr14021497b3.30.1774603629822;
        Fri, 27 Mar 2026 02:27:09 -0700 (PDT)
X-Received: by 2002:a05:690c:94:b0:798:4f55:2c5e with SMTP id 00721157ae682-79bde0af51emr14021277b3.30.1774603629355;
        Fri, 27 Mar 2026 02:27:09 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:27:08 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 5/8] RDMA/bnxt_re: Update msn table size for app allocated QPs
Date: Fri, 27 Mar 2026 14:47:52 +0530
Message-ID: <20260327091755.47754-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18732-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CEED341B77
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
index b249bc2d2583..b6aed318623d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1151,29 +1151,39 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
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
@@ -1185,7 +1195,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC)
-		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
+		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq, app_qp);
 
 	bytes = PAGE_ALIGN(bytes);
 	umem = ib_umem_list_load_or_get(qp->ib_qp.umem_list,
@@ -1637,7 +1647,9 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
-static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
+					      bool app_qp,
+					      struct bnxt_re_qp_req *req)
 {
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_qplib_q *sq = &qplib_qp->sq;
@@ -1660,12 +1672,17 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
 
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
@@ -1740,12 +1757,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
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


