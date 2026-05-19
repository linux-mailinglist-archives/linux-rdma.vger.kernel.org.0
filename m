Return-Path: <linux-rdma+bounces-20980-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PHiCdeADGprigUAu9opvQ
	(envelope-from <linux-rdma+bounces-20980-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B9581643
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0CE5301411F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A33546C1;
	Tue, 19 May 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h00guZn1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853C348C72
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203420; cv=none; b=ss0squX4Y3lN5KcHGAYuJJom1n6Q5okOhlO+kljuuD5Xv4aTgMFViM7KQcj6GfWoxkjIAhk9Jb89lSfPGi1USl0beC6NteYQ8R5wJ2Vo5UeKm1IfV+NODUCJQXD1fqOqeH5f4qTtOjo+adWorqiCYgMH74novBRt1AprYFOjYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203420; c=relaxed/simple;
	bh=UGSbbOwSVygkIvlVceuRpVgHmXOb+PaDUBEznepXCz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQnAniW0h1m9BhVbP4R2T88txtx+vbfTfc3L1XHx6mxjJ4K3Seg/1xFJEp4lpzq16d3GeD4vcG/PiDjDVZPnx7YHVOFeIp2V/OdQ/qzD2JRPYDl3bGzld05JUxWT4A8LqN/soLFXKhh3br10bLAcgblarXGzNWa8xbJFXG1BSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h00guZn1; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2f68f3b075fso13153146eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203415; x=1779808215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9niCjeS5PCvxqvGtN62URGxXBlIQtiUfFNM/dhsx7d4=;
        b=jzSh/x8WBsMW8JC7XG3lKWtp2kx8qNYQWZARTu3zMprUChSJP8oRhbeSz1cgJVoOQ+
         qg1MdhD/HHkmh1GUA/i/Gs6OK8+uolcIhMQZpG5+csGgCo7iQJEvmson5nFCkZvADLBG
         dT1l7WzzHYMuNoO7D3NlJ1wXIVex796FK4TZAR285mRMfcdg9ODVcp4KDsMNun5zmyzr
         mGU6VphUjB5M4nASaNUx1McJDpI+iS/12/3Ax3yy5mOIMakuTL2yiaaTLL028f7uHlqP
         6GJuKk1XpKHqgXdRZJAiiRBiDNC5qb4N0YtjupNpbeqX9ChQUMGZoyfMBltnnNLB+tVH
         qVxA==
X-Gm-Message-State: AOJu0YxuA6ctbl8pcKWaJNflcos7TwbPN5hO8azNTozGZJHNErkf13n2
	QkEJ5tINg8SQ9ZtBeXYYRMGGz3Qpibny4oQErT4+pnv3j4NUN/YP0gXWL/zo/Q0u/lY9IJNFrxO
	PW9OuE0TiJKNstscSBR5IoSpjErXT3WPeNU6vXEvJCCfsw2BGWwkPYU+tF3siD6jGBRgkgExxP/
	Ex1pMX53YRFYkog/JEj/2nhj/p/LP8Hr0QTOSxofz2TDD1IId+g+9XT0pQMSwHJNgriKSs2LxSH
	PKfWiSjVdPqpKR2jN31aSaS8UFL
X-Gm-Gg: Acq92OFoic6Q0EUUcvmfe10k5CwuB7Pt0WvPHQ96sbARRo9AtY8VeR2R2HXdTI5iyWn
	+Jkkf/W6ObXZ06pet1HmTrrsRnZeXpLgRlZmH+EALKVkh6T/2Te++26/x3ouxwVSnEQfwq+oyhn
	GSTH/tzoOSp9AfRL4uD+hujjAD2fQs8SyVMNqmJnp+fZTMoGnkccrmRdiAdfEAP+RZ0lBTAongP
	dxYbYqMSDcQYdTGLJkdQxhryWUFB+BKiiqb25GpZ4YboJ+OH5nQAeUG1SQ4C4ImX1TkRhSCSN3+
	rDQREoNq153aWC4tqUabtrhdcYGE+MIAze35gGwrUanFycT0FEzjn64kbcohVknk3J6UEcELW1P
	SGV0ifP6tK2/UR9IqZo/VYnuN6UaqiVbtXcMjl4aJ5l2ag44iaqFA/gr6auS2/UmxmrTFHBQjmR
	lqYATYUMSX48IiNziw2NKX6yjcI6xZtZbmmtuu9+TrK7HOkb9lnFUy+cIFvaGWZxQ/9gEk
X-Received: by 2002:a05:7300:b58b:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-30398655332mr8733538eec.26.1779203414701;
        Tue, 19 May 2026 08:10:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-30294211ee5sm1519361eec.7.2026.05.19.08.10.14
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bc7f9b2213so28272225ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203413; x=1779808213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9niCjeS5PCvxqvGtN62URGxXBlIQtiUfFNM/dhsx7d4=;
        b=h00guZn1tcNWFb0CUh4W5b3NO5a4tRADIerOCp+TJCo6wrkNaWciCA2+t6OAe+kpRa
         pemHecIOMs5wQOfCJK2z3z9LzqfT//rYS28SAhU6Q8M83u7Z08PNObIH623UvEIik7v0
         lDX1JdDxS8jdIh2RvbB24M6rvgpr6dUnRXB3o=
X-Received: by 2002:a17:903:1b45:b0:2bd:93b0:2c1c with SMTP id d9443c01a7336-2bd93b02ea0mr170730275ad.3.1779203412657;
        Tue, 19 May 2026 08:10:12 -0700 (PDT)
X-Received: by 2002:a17:903:1b45:b0:2bd:93b0:2c1c with SMTP id d9443c01a7336-2bd93b02ea0mr170729995ad.3.1779203412173;
        Tue, 19 May 2026 08:10:12 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:11 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 5/9] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Tue, 19 May 2026 20:30:37 +0530
Message-ID: <20260519150041.7251-6-sriharsha.basavapatna@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20980-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A9B9581643
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


