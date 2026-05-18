Return-Path: <linux-rdma+bounces-20918-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COnoJds2C2qgEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20918-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:57:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C55706D8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67A8F301F7F4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C63848BD41;
	Mon, 18 May 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SJuZ9HrU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9F481FC4
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119227; cv=none; b=G/WFhY5ZIo7lGY2ov8C0PWgdVZLnLkESGgzYwRq0vifYb00wL+TW31X6OIW7qoMLdbODWKT9hBYrsp7AInI1Yi8LYgYcZ8KWoKBfZqSLNA6b06AjQPqz98UHSvCjIR01LcR2p4M6yW/Ok/RpZJbkzZfpxn09s2GLG5ihOU2vwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119227; c=relaxed/simple;
	bh=UGSbbOwSVygkIvlVceuRpVgHmXOb+PaDUBEznepXCz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P842b2WaQAnZiIb2iQa4Dv/givtiOVe0DTc8fK5MXeye3KM+KzvJPKBtO/171I0z1hjxIHQn2P6mKcX63iPtdrHzu0Fqe8LhYMc1jfet8V55eDzZ+HNAOebakkCOvt+3kpLkCipFW4y/bvCIpY7zKaVo1BzpqlA+IGqqEQ5nwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJuZ9HrU; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ba856db1c0so18501745ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119216; x=1779724016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9niCjeS5PCvxqvGtN62URGxXBlIQtiUfFNM/dhsx7d4=;
        b=YVCq9g3fP+HSqANYx9MpVebcNBeOxUNZ72PPdv9NPmaVadtIbsfrjI0qjD+lEPwo1z
         7zs6BEY9Cu0DxDKS4hKD+nqfOytd/vqtpTlkN+tE7v+BDp7qtRASOYYYHw7aC+CHk0xd
         cnHGwK78iTIQpkNIpXoa4aEybtgF7+PVqNasrK1Oc9udr5ZQqFBWARhr9MJsDkutmzUc
         1btGX6pxDS3+6hx5ThnmRAg+KNKZ1iLNP3dpqhN2Gae6euUNLVcfBGghEYxFGDM9lsK2
         2mUHXEcHaCKaVGNlQMbEjE1LZjfAZzsR1UbENk+qRugKSiK79wIHQU/AMKA+C0qhQ7Wf
         962Q==
X-Gm-Message-State: AOJu0YzlMKE/VYLdspNGkc7j3g67n19TM9Ajsd0ZtzyWjOPB5BU6klJB
	7rSOahStGrE5FlNFe/GPepEQNtQ0hFITimmCG6vWE3WW+n09eO16wLdY8F2aaA/bkn+RlceyZT3
	CIyVAtcIRvtcxXGL6dz57FFSbj4BIi++XBEM/rVniB5gbfC0lJsLMnPaBVNFNR7AeucuUr/GDqq
	wZuXUjWH/EEbAI3ktjI/iVaM8tCFb6ZJrfmGYwYpXZVLyJf8sup+N5DpgxbVexBecNjzb+uxJYi
	vqVM2jDf2cRcgUHNYl8phyyHuFr
X-Gm-Gg: Acq92OGsKupXKCSQrybxJyUoS9VrsFfh1IWxkCFhPGw5Soy5jCjd5RHDQMoO8NT6Zlu
	1iqQGrksamU2tqdV/7pVWYmK9zIN3EpqQZz3y/MZDwsQl7pA4LKLcZpL+xEmWjtDD/wUzKqdWyt
	68f2m/fOxYDro8lOTGXt2Rl8jKRR+bX2ftXlV5CQheAws3Qz9cMzpqUv53ErEkoRvORnbcZIj8V
	50g0Shw/jR0ZgNFFcBP1uX8/N8NHCzwJXN6LgHEhQCYH1fhPH04cmCxeKRteMuBfTCoYNxy6eOG
	M4+UHFumAIul1P9vSO0XRxEhLBswFfcB19cLNTRmt3ZfXiBMZlMd9RuFWRxHVoli7pl4L3Osl3A
	ImGrpYf6QXnpXnj+NWignyztmAHWY6/cOGU95abVFRn2Cs2BztsE8atC7tfS3W8J+0Sxj2D9oey
	RthpoZL1A2z2KP2CZq8CcBCzH2w3XzLorLNIF9cqABzFKs5BwlnFyDnhUXd3qLKPVPj/Om
X-Received: by 2002:a17:902:9690:b0:2b2:81aa:f6c3 with SMTP id d9443c01a7336-2bd7e8a91b6mr124072455ad.29.1779119216082;
        Mon, 18 May 2026 08:46:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5c35c47fsm11282185ad.23.2026.05.18.08.46.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:46:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9fe2d6793so62767125ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119214; x=1779724014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9niCjeS5PCvxqvGtN62URGxXBlIQtiUfFNM/dhsx7d4=;
        b=SJuZ9HrUg5jv1Ya7TnCTiyewo0K3vn+fpvlJtR8LPXnWov2rrqKZeESM032JEhA/uU
         Kgl+cdi9lBqiXgaf/OlChqWNa+VAwZA27XTioI+lckDMSNTSt/5kHIJsu363UPxTUXYA
         4BITaugI1wqfV7dt+oA0l986PaC8rM/Q2C2ro=
X-Received: by 2002:a17:903:1b65:b0:2b9:8d39:5e87 with SMTP id d9443c01a7336-2bd7e7bdd94mr173109895ad.10.1779119214389;
        Mon, 18 May 2026 08:46:54 -0700 (PDT)
X-Received: by 2002:a17:903:1b65:b0:2b9:8d39:5e87 with SMTP id d9443c01a7336-2bd7e7bdd94mr173109465ad.10.1779119213895;
        Mon, 18 May 2026 08:46:53 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:46:52 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 5/9] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Mon, 18 May 2026 21:07:17 +0530
Message-ID: <20260518153721.183749-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20918-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C5C55706D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hwq depth shouldn't be computed using slots/round-up logic for
app allocated QPs, use the max_wqe value saved earlier.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ae32f86b9e9b..9fd85d81bcea 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1346,7 +1346,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool fixed_que_attr)
 {
 	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
@@ -1360,12 +1360,17 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &sq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
-	hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
 	hwq_attr.aux_stride = qplib_qp->psn_sz;
-	hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
-		bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
-	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+	if (!fixed_que_attr) {
+		hwq_attr.depth = bnxt_qplib_get_depth(sq, wqe_mode, true);
+		hwq_attr.aux_depth = (qplib_qp->psn_sz) ?
+				bnxt_qplib_set_sq_size(sq, wqe_mode) : 0;
+		if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz)
+			hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	} else {
+		hwq_attr.depth = sq->max_wqe;
 		hwq_attr.aux_depth = qplib_qp->msn_tbl_sz;
+	}
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -1376,6 +1381,9 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_SQ_LVL_SFT);
 	sq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+	if (qplib_qp->srq)
+		goto done;
+
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &rq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
@@ -1392,6 +1400,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1460,7 +1469,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1774,7 +1783,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp, fixed_que_attr, ureq);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, fixed_que_attr);
 	if (rc)
 		goto free_umem;
 
-- 
2.51.2.636.ga99f379adf


