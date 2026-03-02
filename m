Return-Path: <linux-rdma+bounces-17375-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCW3IvpvpWlXAgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17375-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 257111D73B5
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 009A0302DE68
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDF35FF5B;
	Mon,  2 Mar 2026 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HzjQ7arY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A443314A1
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449771; cv=none; b=m5OEkkPeuaLLT56DpMtY5N70Hu2lciooN2AHU0IOO3mchI5bPrzRkomLOZYY3c6ooTN3wLhopcT1XPUBJ3Xp/EXQqSVKgQEKEJ5qdfCJKtAdQimM3BrmoiFOmkG8c7d0dZc2xO6BPXaGMJCD1LSiUm1BgR87sVZi0YWgeqgdLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449771; c=relaxed/simple;
	bh=Um5HRwQpkgHod+6gzd4VxWjHeIoGdbwenbXqKszQq04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvTFUCVGw4P6DkGeAkxU3I8+QqJa5G8R7Ua3d3KilJDROunFYSW9h/T/GDlWpYffycS7PaKipZ71IANA7r3ouc3qsF59LatB+WFoCP8ncc8rqAKDhv9z3THJFA8hV4/XxWGvV+cdfJs4nqduRE03+rXIhYZxkc88Uo7Br7l4tzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HzjQ7arY; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c70e96737a5so1287639a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449769; x=1773054569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTCxo7skthk0P/aVFVA5K3V2AcXJgnCgje5cKVfvnVk=;
        b=EFv1008zl2ySe2BBQJfG+8cdPD/J1Xa0i70jwBgzO5l4VLH2+wlpZBvyBTHsS62euz
         cE0uNd1m1A/xBGliWNM/78oBRhsdQK4GZwo1t3jpgAx1jwwsQBfetQoXCzN0yI2APM2U
         ctZto4baC3qa1Cj+qyJf8x6IK6pUqcUgD0KnGPZRykjVSjsKsM/7pp/kE6C5VdAqdM0U
         rLTxA6o3OGvrD0xEnMJBBUqACRBJy61ovhKv7AJsuZ+Gg3MhIV5Ypn5qa4cGjc63mYlE
         ofKahvF+Cd6ZxjH/OwHQdDU8PElPC+VMXAz+lORpnXuIMzAnMp93d/FnEt82Mig9hsBr
         rFbA==
X-Gm-Message-State: AOJu0YzJNCTfCgP1k0ak2KqluayccsQfBOECfORSgHtxKtTO/iDH1qfg
	ygDzHfymXpoXdNLKUp6WVicqO+Llpag/Hv5B2KE86zbroc1MRmkfrSMLxX9j+rUdPiH0LAnRcFp
	1eYzwVhKeLVtt5l9kzBnAKh+0O87DqbfC9E/GlQxBnhNY/L0pN05ubTB78SK5sdje9n6nxazvYD
	gCUZF6nynE6YEPn3ERKkJs9DK6v6YQ37HnU7d1iRshR68PhLDz0ZTmeYfQFaTSefaMhP062yXP5
	CWkQ22G9HcPQTtlrA3SmAsbnPK2
X-Gm-Gg: ATEYQzzC2c7Vn6MVTA70j0pv3BU2f77SgL1y2gcdNHZjHXXBPqWWyP8YWiUC8Eega6e
	bxIzeeEJ8SuOTymWBRDRxfcrQANzi7iQj7RQnV8j1AK4QlMaMbI64hknoaQAxaKsRDZteMt7yep
	5wAITzUqxZ1X/B3CWRXYbuSS2RbdS/Hs6jB+cssW0MRA6KVEMdkWZe78jqCDphiHmSiQb+NwWzw
	NTZLvTsS6n4y/2oiKeErxqZmM5AB7xNcJTY/PIsRG+RLO5T5MEEXM3RtsMqsSnX/1+x7h8yE45u
	M3xHnKezPvLDqSkSvLP1qIgKrpMnjHTos2d4KX8vyQh2UVbHSql/Yx2TkXeEEOldlg+VVAbWfW3
	ANx+xUnj1Hp4uFi32gK++GaWFjo5HI5s1pTbGTN68C3twfNB7CjDq2NQmsAY3PGmkXVTa72Qvwc
	jg3TRJutYkHNknMFTDjxsh93vUomyx+btfIipoZBwknVi1M29fZqVq9vCjwXCHbR99iQ==
X-Received: by 2002:a17:903:2b0e:b0:2ae:5655:b42 with SMTP id d9443c01a7336-2ae5655110bmr15893155ad.12.1772449768552;
        Mon, 02 Mar 2026 03:09:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae3b4fee0esm8617325ad.35.2026.03.02.03.09.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:09:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae44db60c2so14339685ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772449767; x=1773054567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTCxo7skthk0P/aVFVA5K3V2AcXJgnCgje5cKVfvnVk=;
        b=HzjQ7arYgFFpk/WWTcUBqSWElfCCGA9n+qANazHQqT5S/3YlPWCwyfRCtvt9XS0Cpc
         4qMWiXtBNoGeQ9VEcu62Q+Xhh7TVYLirar6Mu95BOcPZ5Vwz7uxYzRoW7c/dgATYAOos
         7kv23cen72Rafo95/MkImNZrOrJbRA9evOQ3Y=
X-Received: by 2002:a17:903:18c:b0:2ad:99d8:8612 with SMTP id d9443c01a7336-2ae2e40bb2cmr108635965ad.20.1772449766560;
        Mon, 02 Mar 2026 03:09:26 -0800 (PST)
X-Received: by 2002:a17:903:18c:b0:2ad:99d8:8612 with SMTP id d9443c01a7336-2ae2e40bb2cmr108635665ad.20.1772449765896;
        Mon, 02 Mar 2026 03:09:25 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm58391755ad.44.2026.03.02.03.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:09:25 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v14 2/6] RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
Date: Mon,  2 Mar 2026 16:30:32 +0530
Message-ID: <20260302110036.36387-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
References: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17375-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 257111D73B5
X-Rspamd-Action: no action

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Inside bnxt_qplib_create_qp(), driver currently is doing
a lot of things like allocating HWQ memory for SQ/RQ/ORRQ/IRRQ,
initializing few of qplib_qp fields etc.

Refactored the code such that all memory allocation for HWQs
have been moved to bnxt_re_init_qp_attr() function and inside
bnxt_qplib_create_qp() function just initialize the request
structure and issue the HWRM command to firmware.

Introduced couple of new functions bnxt_re_setup_qp_hwqs() and
bnxt_re_setup_qp_swqs() moved the hwq and swq memory allocation
logic there.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 201 ++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 305 +++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   6 +
 4 files changed, 295 insertions(+), 225 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2db80433f25e..45087be01548 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -995,6 +995,12 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
 		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
 }
 
+static void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
+{
+	ib_umem_release(qp->rumem);
+	ib_umem_release(qp->sumem);
+}
+
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -1041,8 +1047,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
 		bnxt_re_del_unique_gid(rdev);
 
-	ib_umem_release(qp->rumem);
-	ib_umem_release(qp->sumem);
+	bnxt_re_qp_free_umem(qp);
 
 	/* Flush all the entries of notification queue associated with
 	 * given qp.
@@ -1186,6 +1191,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	}
 
 	qplib_qp->dpi = &cntx->dpi;
+	qplib_qp->is_user = true;
 	return 0;
 rqfail:
 	ib_umem_release(qp->sumem);
@@ -1243,6 +1249,114 @@ static struct bnxt_re_ah *bnxt_re_create_shadow_qp_ah
 	return NULL;
 }
 
+static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_hwq_attr hwq_attr = {};
+	struct bnxt_qplib_sg_info sginfo = {};
+	struct bnxt_qplib_hwq *irrq, *orrq;
+	int rc, req_size;
+
+	orrq = &qplib_qp->orrq;
+	orrq->max_elements =
+		ORD_LIMIT_TO_ORRQ_SLOTS(qplib_qp->max_rd_atomic);
+	req_size = orrq->max_elements *
+		BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE + PAGE_SIZE - 1;
+	req_size &= ~(PAGE_SIZE - 1);
+	sginfo.pgsize = req_size;
+	sginfo.pgshft = PAGE_SHIFT;
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.depth = orrq->max_elements;
+	hwq_attr.stride = BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE;
+	hwq_attr.aux_stride = 0;
+	hwq_attr.aux_depth = 0;
+	hwq_attr.type = HWQ_TYPE_CTX;
+	rc = bnxt_qplib_alloc_init_hwq(orrq, &hwq_attr);
+	if (rc)
+		return rc;
+
+	irrq = &qplib_qp->irrq;
+	irrq->max_elements =
+		IRD_LIMIT_TO_IRRQ_SLOTS(qplib_qp->max_dest_rd_atomic);
+	req_size = irrq->max_elements *
+		BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE + PAGE_SIZE - 1;
+	req_size &= ~(PAGE_SIZE - 1);
+	sginfo.pgsize = req_size;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.depth =  irrq->max_elements;
+	hwq_attr.stride = BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE;
+	rc = bnxt_qplib_alloc_init_hwq(irrq, &hwq_attr);
+	if (rc)
+		goto free_orrq_hwq;
+	return 0;
+free_orrq_hwq:
+	bnxt_qplib_free_hwq(res, orrq);
+	return rc;
+}
+
+static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_hwq_attr hwq_attr = {};
+	struct bnxt_qplib_q *sq = &qplib_qp->sq;
+	struct bnxt_qplib_q *rq = &qplib_qp->rq;
+	u8 wqe_mode = qplib_qp->wqe_mode;
+	u8 pg_sz_lvl;
+	int rc;
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sq->sg_info;
+	hwq_attr.stride = bnxt_qplib_get_stride();
+	hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
+	hwq_attr.aux_stride = qplib_qp->psn_sz;
+	hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
+		bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
+	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+		hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
+	if (rc)
+		return rc;
+
+	pg_sz_lvl = bnxt_qplib_base_pg_size(&sq->hwq) << CMDQ_CREATE_QP_SQ_PG_SIZE_SFT;
+	pg_sz_lvl |= ((sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK) <<
+		      CMDQ_CREATE_QP_SQ_LVL_SFT);
+	sq->hwq.pg_sz_lvl = pg_sz_lvl;
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &rq->sg_info;
+	hwq_attr.stride = bnxt_qplib_get_stride();
+	hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	hwq_attr.aux_stride = 0;
+	hwq_attr.aux_depth = 0;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
+	if (rc)
+		goto free_sq_hwq;
+	pg_sz_lvl = bnxt_qplib_base_pg_size(&rq->hwq) <<
+		CMDQ_CREATE_QP_RQ_PG_SIZE_SFT;
+	pg_sz_lvl |= ((rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK) <<
+		      CMDQ_CREATE_QP_RQ_LVL_SFT);
+	rq->hwq.pg_sz_lvl = pg_sz_lvl;
+
+	if (qplib_qp->psn_sz) {
+		rc = bnxt_re_qp_alloc_init_xrrq(qp);
+		if (rc)
+			goto free_rq_hwq;
+	}
+
+	return 0;
+free_rq_hwq:
+	bnxt_qplib_free_hwq(res, &rq->hwq);
+free_sq_hwq:
+	bnxt_qplib_free_hwq(res, &sq->hwq);
+	return rc;
+}
+
 static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 				(struct bnxt_re_pd *pd,
 				 struct bnxt_qplib_res *qp1_res,
@@ -1264,6 +1378,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.pd = &pd->qplib_pd;
 	qp->qplib_qp.qp_handle = (u64)(unsigned long)(&qp->qplib_qp);
 	qp->qplib_qp.type = IB_QPT_UD;
+	qp->qplib_qp.cctx = rdev->chip_ctx;
 
 	qp->qplib_qp.max_inline_data = 0;
 	qp->qplib_qp.sig_type = true;
@@ -1296,10 +1411,14 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_qplib_create_qp(qp1_res, &qp->qplib_qp);
+	rc = bnxt_re_setup_qp_hwqs(qp);
 	if (rc)
 		goto fail;
 
+	rc = bnxt_qplib_create_qp(qp1_res, &qp->qplib_qp);
+	if (rc)
+		goto free_hwq;
+
 	spin_lock_init(&qp->sq_lock);
 	INIT_LIST_HEAD(&qp->list);
 	mutex_lock(&rdev->qp_lock);
@@ -1307,6 +1426,9 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	atomic_inc(&rdev->stats.res.qp_count);
 	mutex_unlock(&rdev->qp_lock);
 	return qp;
+
+free_hwq:
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 fail:
 	kfree(qp);
 	return NULL;
@@ -1477,6 +1599,39 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
+	struct bnxt_qplib_q *sq = &qplib_qp->sq;
+	struct bnxt_re_dev *rdev = qp->rdev;
+	u8 wqe_mode = qplib_qp->wqe_mode;
+
+	if (rdev->dev_attr)
+		qplib_qp->is_host_msn_tbl =
+			_is_host_msn_table(rdev->dev_attr->dev_cap_flags2);
+
+	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
+		qplib_qp->psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
+			sizeof(struct sq_psn_search_ext) :
+			sizeof(struct sq_psn_search);
+		if (qplib_qp->is_host_msn_tbl) {
+			qplib_qp->psn_sz = sizeof(struct sq_msn_search);
+			qplib_qp->msn = 0;
+		}
+	}
+
+	/* Update msn tbl size */
+	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz) {
+		if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+			qplib_qp->msn_tbl_sz =
+				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
+		else
+			qplib_qp->msn_tbl_sz =
+				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode)) / 2;
+		qplib_qp->msn = 0;
+	}
+}
+
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
@@ -1499,12 +1654,12 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	qplqp->max_inline_data = init_attr->cap.max_inline_data;
 	qplqp->sig_type = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	qptype = bnxt_re_init_qp_type(rdev, init_attr);
-	if (qptype < 0) {
-		rc = qptype;
-		goto out;
-	}
+	if (qptype < 0)
+		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
+	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
 		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
 		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
@@ -1534,20 +1689,32 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	/* Setup RQ/SRQ */
 	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx);
 	if (rc)
-		goto out;
+		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
 	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
 	if (rc)
-		goto out;
+		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
-	if (uctx) /* This will update DPI and qp_handle */
+	if (uctx) { /* This will update DPI and qp_handle */
 		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq);
-out:
+		if (rc)
+			return rc;
+	}
+
+	bnxt_re_qp_calculate_msn_psn_size(qp);
+
+	rc = bnxt_re_setup_qp_hwqs(qp);
+	if (rc)
+		goto free_umem;
+
+	return 0;
+free_umem:
+	bnxt_re_qp_free_umem(qp);
 	return rc;
 }
 
@@ -1604,6 +1771,7 @@ static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
+	qplqp->cctx = rdev->chip_ctx;
 
 	qplqp->rq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
 	qplqp->sq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;
@@ -1709,13 +1877,14 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		if (rc == -ENODEV)
 			goto qp_destroy;
 		if (rc)
-			goto fail;
+			goto free_hwq;
 	} else {
 		rc = bnxt_qplib_create_qp(&rdev->qplib_res, &qp->qplib_qp);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to create HW QP");
-			goto free_umem;
+			goto free_hwq;
 		}
+
 		if (udata) {
 			struct bnxt_re_qp_resp resp;
 
@@ -1764,9 +1933,9 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	return 0;
 qp_destroy:
 	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
-free_umem:
-	ib_umem_release(qp->rumem);
-	ib_umem_release(qp->sumem);
+free_hwq:
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
+	bnxt_re_qp_free_umem(qp);
 fail:
 	return rc;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 2d7932b3c492..c15b6a361ac6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -792,8 +792,6 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	return 0;
 }
 
-/* QP */
-
 static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 {
 	int indx;
@@ -812,9 +810,71 @@ static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 	return 0;
 }
 
+static int bnxt_re_setup_qp_swqs(struct bnxt_qplib_qp *qplqp)
+{
+	struct bnxt_qplib_q *sq = &qplqp->sq;
+	struct bnxt_qplib_q *rq = &qplqp->rq;
+	int rc;
+
+	if (qplqp->is_user)
+		return 0;
+
+	rc = bnxt_qplib_alloc_init_swq(sq);
+	if (rc)
+		return rc;
+
+	if (!qplqp->srq) {
+		rc = bnxt_qplib_alloc_init_swq(rq);
+		if (rc)
+			goto free_sq_swq;
+	}
+
+	return 0;
+free_sq_swq:
+	kfree(sq->swq);
+	return rc;
+}
+
+static void bnxt_qp_init_dbinfo(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
+{
+	struct bnxt_qplib_q *sq = &qp->sq;
+	struct bnxt_qplib_q *rq = &qp->rq;
+
+	sq->dbinfo.hwq = &sq->hwq;
+	sq->dbinfo.xid = qp->id;
+	sq->dbinfo.db = qp->dpi->dbr;
+	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
+	sq->dbinfo.flags = 0;
+	if (rq->max_wqe) {
+		rq->dbinfo.hwq = &rq->hwq;
+		rq->dbinfo.xid = qp->id;
+		rq->dbinfo.db = qp->dpi->dbr;
+		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
+		rq->dbinfo.flags = 0;
+	}
+}
+
+static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
+{
+	struct bnxt_qplib_hwq *sq_hwq;
+	struct bnxt_qplib_q *sq;
+	u64 fpsne, psn_pg;
+	u16 indx_pad = 0;
+
+	sq = &qp->sq;
+	sq_hwq = &sq->hwq;
+	/* First psn entry */
+	fpsne = (u64)bnxt_qplib_get_qe(sq_hwq, sq_hwq->depth, &psn_pg);
+	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
+		indx_pad = (fpsne & ~PAGE_MASK) / size;
+	sq_hwq->pad_pgofft = indx_pad;
+	sq_hwq->pad_pg = (u64 *)psn_pg;
+	sq_hwq->pad_stride = size;
+}
+
+/* QP */
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
-	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_create_qp1_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
@@ -823,7 +883,6 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct cmdq_create_qp1 req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
-	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	int rc;
 
@@ -837,26 +896,12 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_handle = cpu_to_le64(qp->qp_handle);
 
 	/* SQ */
-	hwq_attr.res = res;
-	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = sizeof(struct sq_sge);
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, qp->wqe_mode, false);
-	hwq_attr.type = HWQ_TYPE_QUEUE;
-	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
-	if (rc)
-		return rc;
+	sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qp->wqe_mode, true);
+	req.sq_size = cpu_to_le32(sq->max_sw_wqe);
+	req.sq_pg_size_sq_lvl = sq->hwq.pg_sz_lvl;
 
-	rc = bnxt_qplib_alloc_init_swq(sq);
-	if (rc)
-		goto fail_sq;
-
-	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
-		     CMDQ_CREATE_QP1_SQ_PG_SIZE_SFT);
-	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP1_SQ_LVL_MASK);
-	req.sq_pg_size_sq_lvl = pg_sz_lvl;
 	req.sq_fwo_sq_sge =
 		cpu_to_le16((sq->max_sge & CMDQ_CREATE_QP1_SQ_SGE_MASK) <<
 			     CMDQ_CREATE_QP1_SQ_SGE_SFT);
@@ -865,24 +910,10 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	/* RQ */
 	if (rq->max_wqe) {
 		rq->dbinfo.flags = 0;
-		hwq_attr.res = res;
-		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = sizeof(struct sq_sge);
-		hwq_attr.depth = bnxt_qplib_get_depth(rq, qp->wqe_mode, false);
-		hwq_attr.type = HWQ_TYPE_QUEUE;
-		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
-		if (rc)
-			goto sq_swq;
-		rc = bnxt_qplib_alloc_init_swq(rq);
-		if (rc)
-			goto fail_rq;
 		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
-			     CMDQ_CREATE_QP1_RQ_PG_SIZE_SFT);
-		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP1_RQ_LVL_MASK);
-		req.rq_pg_size_rq_lvl = pg_sz_lvl;
+		req.rq_pg_size_rq_lvl = rq->hwq.pg_sz_lvl;
 		req.rq_fwo_rq_sge =
 			cpu_to_le16((rq->max_sge &
 				     CMDQ_CREATE_QP1_RQ_SGE_MASK) <<
@@ -893,7 +924,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
 	if (rc) {
 		rc = -ENOMEM;
-		goto rq_rwq;
+		return rc;
 	}
 	qp_flags |= CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	req.qp_flags = cpu_to_le32(qp_flags);
@@ -906,73 +937,39 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	qp->id = le32_to_cpu(resp.xid);
 	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
-	qp->cctx = res->cctx;
-	sq->dbinfo.hwq = &sq->hwq;
-	sq->dbinfo.xid = qp->id;
-	sq->dbinfo.db = qp->dpi->dbr;
-	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
-	if (rq->max_wqe) {
-		rq->dbinfo.hwq = &rq->hwq;
-		rq->dbinfo.xid = qp->id;
-		rq->dbinfo.db = qp->dpi->dbr;
-		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
-	}
+
+	rc = bnxt_re_setup_qp_swqs(qp);
+	if (rc)
+		goto destroy_qp;
+	bnxt_qp_init_dbinfo(res, qp);
+
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
 
 	return 0;
 
+destroy_qp:
+	bnxt_qplib_destroy_qp(res, qp);
 fail:
 	bnxt_qplib_free_qp_hdr_buf(res, qp);
-rq_rwq:
-	kfree(rq->swq);
-fail_rq:
-	bnxt_qplib_free_hwq(res, &rq->hwq);
-sq_swq:
-	kfree(sq->swq);
-fail_sq:
-	bnxt_qplib_free_hwq(res, &sq->hwq);
 	return rc;
 }
 
-static void bnxt_qplib_init_psn_ptr(struct bnxt_qplib_qp *qp, int size)
-{
-	struct bnxt_qplib_hwq *hwq;
-	struct bnxt_qplib_q *sq;
-	u64 fpsne, psn_pg;
-	u16 indx_pad = 0;
-
-	sq = &qp->sq;
-	hwq = &sq->hwq;
-	/* First psn entry */
-	fpsne = (u64)bnxt_qplib_get_qe(hwq, hwq->depth, &psn_pg);
-	if (!IS_ALIGNED(fpsne, PAGE_SIZE))
-		indx_pad = (fpsne & ~PAGE_MASK) / size;
-	hwq->pad_pgofft = indx_pad;
-	hwq->pad_pg = (u64 *)psn_pg;
-	hwq->pad_stride = size;
-}
-
 int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct bnxt_qplib_hwq_attr hwq_attr = {};
-	struct bnxt_qplib_sg_info sginfo = {};
 	struct creq_create_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
 	struct cmdq_create_qp req = {};
-	int rc, req_size, psn_sz = 0;
-	struct bnxt_qplib_hwq *xrrq;
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
-	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	u16 nsge;
+	int rc;
 
-	qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
 	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP,
@@ -984,56 +981,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_handle = cpu_to_le64(qp->qp_handle);
 
 	/* SQ */
-	if (qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
-			 sizeof(struct sq_psn_search_ext) :
-			 sizeof(struct sq_psn_search);
-
-		if (qp->is_host_msn_tbl) {
-			psn_sz = sizeof(struct sq_msn_search);
-			qp->msn = 0;
-		}
-	}
-
-	hwq_attr.res = res;
-	hwq_attr.sginfo = &sq->sg_info;
-	hwq_attr.stride = sizeof(struct sq_sge);
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, qp->wqe_mode, true);
-	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
-				    : 0;
-	/* Update msn tbl size */
-	if (qp->is_host_msn_tbl && psn_sz) {
-		if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			hwq_attr.aux_depth =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
-		else
-			hwq_attr.aux_depth =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode)) / 2;
-		qp->msn_tbl_sz = hwq_attr.aux_depth;
-		qp->msn = 0;
-	}
-
-	hwq_attr.type = HWQ_TYPE_QUEUE;
-	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
-	if (rc)
-		return rc;
-
-	if (!sq->hwq.is_user) {
-		rc = bnxt_qplib_alloc_init_swq(sq);
-		if (rc)
-			goto fail_sq;
-
-		if (psn_sz)
-			bnxt_qplib_init_psn_ptr(qp, psn_sz);
-	}
-	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
+	req.sq_size = cpu_to_le32(sq->max_sw_wqe);
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
-		     CMDQ_CREATE_QP_SQ_PG_SIZE_SFT);
-	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK);
-	req.sq_pg_size_sq_lvl = pg_sz_lvl;
+	req.sq_pg_size_sq_lvl = sq->hwq.pg_sz_lvl;
 	req.sq_fwo_sq_sge =
 		cpu_to_le16(((sq->max_sge & CMDQ_CREATE_QP_SQ_SGE_MASK) <<
 			     CMDQ_CREATE_QP_SQ_SGE_SFT) | 0);
@@ -1042,29 +993,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	/* RQ */
 	if (!qp->srq) {
 		rq->dbinfo.flags = 0;
-		hwq_attr.res = res;
-		hwq_attr.sginfo = &rq->sg_info;
-		hwq_attr.stride = sizeof(struct sq_sge);
-		hwq_attr.depth = bnxt_qplib_get_depth(rq, qp->wqe_mode, false);
-		hwq_attr.aux_stride = 0;
-		hwq_attr.aux_depth = 0;
-		hwq_attr.type = HWQ_TYPE_QUEUE;
-		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
-		if (rc)
-			goto sq_swq;
-		if (!rq->hwq.is_user) {
-			rc = bnxt_qplib_alloc_init_swq(rq);
-			if (rc)
-				goto fail_rq;
-		}
-
 		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
 		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
-		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
-			     CMDQ_CREATE_QP_RQ_PG_SIZE_SFT);
-		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK);
-		req.rq_pg_size_rq_lvl = pg_sz_lvl;
+		req.rq_pg_size_rq_lvl = rq->hwq.pg_sz_lvl;
 		nsge = (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
 			6 : rq->max_sge;
 		req.rq_fwo_rq_sge =
@@ -1090,44 +1022,9 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_flags = cpu_to_le32(qp_flags);
 
 	/* ORRQ and IRRQ */
-	if (psn_sz) {
-		xrrq = &qp->orrq;
-		xrrq->max_elements =
-			ORD_LIMIT_TO_ORRQ_SLOTS(qp->max_rd_atomic);
-		req_size = xrrq->max_elements *
-			   BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE + PAGE_SIZE - 1;
-		req_size &= ~(PAGE_SIZE - 1);
-		sginfo.pgsize = req_size;
-		sginfo.pgshft = PAGE_SHIFT;
-
-		hwq_attr.res = res;
-		hwq_attr.sginfo = &sginfo;
-		hwq_attr.depth = xrrq->max_elements;
-		hwq_attr.stride = BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE;
-		hwq_attr.aux_stride = 0;
-		hwq_attr.aux_depth = 0;
-		hwq_attr.type = HWQ_TYPE_CTX;
-		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
-		if (rc)
-			goto rq_swq;
-		pbl = &xrrq->pbl[PBL_LVL_0];
-		req.orrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
-
-		xrrq = &qp->irrq;
-		xrrq->max_elements = IRD_LIMIT_TO_IRRQ_SLOTS(
-						qp->max_dest_rd_atomic);
-		req_size = xrrq->max_elements *
-			   BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE + PAGE_SIZE - 1;
-		req_size &= ~(PAGE_SIZE - 1);
-		sginfo.pgsize = req_size;
-		hwq_attr.depth =  xrrq->max_elements;
-		hwq_attr.stride = BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE;
-		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
-		if (rc)
-			goto fail_orrq;
-
-		pbl = &xrrq->pbl[PBL_LVL_0];
-		req.irrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
+	if (qp->psn_sz) {
+		req.orrq_addr = cpu_to_le64(bnxt_qplib_get_base_addr(&qp->orrq));
+		req.irrq_addr = cpu_to_le64(bnxt_qplib_get_base_addr(&qp->irrq));
 	}
 	req.pd_id = cpu_to_le32(qp->pd->id);
 
@@ -1135,23 +1032,23 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
-		goto fail;
+		return rc;
 
 	qp->id = le32_to_cpu(resp.xid);
+
+	if (!qp->is_user) {
+		rc = bnxt_re_setup_qp_swqs(qp);
+		if (rc)
+			goto destroy_qp;
+	}
+	bnxt_qp_init_dbinfo(res, qp);
+	if (qp->psn_sz)
+		bnxt_qplib_init_psn_ptr(qp, qp->psn_sz);
+
 	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
 	INIT_LIST_HEAD(&qp->sq_flush);
 	INIT_LIST_HEAD(&qp->rq_flush);
 	qp->cctx = res->cctx;
-	sq->dbinfo.hwq = &sq->hwq;
-	sq->dbinfo.xid = qp->id;
-	sq->dbinfo.db = qp->dpi->dbr;
-	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
-	if (rq->max_wqe) {
-		rq->dbinfo.hwq = &rq->hwq;
-		rq->dbinfo.xid = qp->id;
-		rq->dbinfo.db = qp->dpi->dbr;
-		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
-	}
 	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
@@ -1159,18 +1056,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	spin_unlock_bh(&rcfw->tbl_lock);
 
 	return 0;
-fail:
-	bnxt_qplib_free_hwq(res, &qp->irrq);
-fail_orrq:
-	bnxt_qplib_free_hwq(res, &qp->orrq);
-rq_swq:
-	kfree(rq->swq);
-fail_rq:
-	bnxt_qplib_free_hwq(res, &rq->hwq);
-sq_swq:
-	kfree(sq->swq);
-fail_sq:
-	bnxt_qplib_free_hwq(res, &sq->hwq);
+destroy_qp:
+	bnxt_qplib_destroy_qp(res, qp);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 30c3f99be07b..5f671cc59100 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -279,6 +279,7 @@ struct bnxt_qplib_qp {
 	u8				wqe_mode;
 	u8				state;
 	u8				cur_qp_state;
+	u8				is_user;
 	u64				modify_flags;
 	u32				ext_modify_flags;
 	u32				max_inline_data;
@@ -344,9 +345,11 @@ struct bnxt_qplib_qp {
 	struct list_head		rq_flush;
 	u32				msn;
 	u32				msn_tbl_sz;
+	u32				psn_sz;
 	bool				is_host_msn_tbl;
 	u8				tos_dscp;
 	u32				ugid_index;
+	u16				dev_cap_flags;
 	u32				rate_limit;
 	u8				shaper_allocation_status;
 };
@@ -617,6 +620,11 @@ static inline void bnxt_qplib_swq_mod_start(struct bnxt_qplib_q *que, u32 idx)
 	que->swq_start = que->swq[idx].next_idx;
 }
 
+static inline u32 bnxt_qplib_get_stride(void)
+{
+	return sizeof(struct sq_sge);
+}
+
 static inline u32 bnxt_qplib_get_depth(struct bnxt_qplib_q *que, u8 wqe_mode, bool is_sq)
 {
 	u32 slots;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 9a5dcf97b6f4..f01c1bb1fcb4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -198,6 +198,7 @@ struct bnxt_qplib_hwq {
 	u32				cons;		/* raw */
 	u8				cp_bit;
 	u8				is_user;
+	u8				pg_sz_lvl;
 	u64				*pad_pg;
 	u32				pad_stride;
 	u32				pad_pgofft;
@@ -358,6 +359,11 @@ static inline u8 bnxt_qplib_get_ring_type(struct bnxt_qplib_chip_ctx *cctx)
 	       RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL;
 }
 
+static inline u64 bnxt_qplib_get_base_addr(struct bnxt_qplib_hwq *hwq)
+{
+	return hwq->pbl[PBL_LVL_0].pg_map_arr[0];
+}
+
 static inline u8 bnxt_qplib_base_pg_size(struct bnxt_qplib_hwq *hwq)
 {
 	u8 pg_size = BNXT_QPLIB_HWRM_PG_SIZE_4K;
-- 
2.51.2.636.ga99f379adf


