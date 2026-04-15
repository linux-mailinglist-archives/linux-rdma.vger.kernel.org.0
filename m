Return-Path: <linux-rdma+bounces-19371-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP6JNUkp32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19371-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B8400AC5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2677302B3A9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43804372ECD;
	Wed, 15 Apr 2026 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HJEQ9dww"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B1175A7A
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232760; cv=none; b=kHZAuF3Vu8dS6nT/wh+bJzyKkNRoXw2eSkVx+zn443gO5KlZLvE1joGLqwFf2GCGWHRKkUjxteyGczHgPoi4ba08bQE6y69Sxr7ODh94/lFEcsDBCEb7VIWUsuNc53i3X1Y+6jMX+CII2mlmfn+fHzSaj7y5L5h/lpAb769PTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232760; c=relaxed/simple;
	bh=E2D8HIk/z0D2R9YkPzrq2q7hFwOVSpH4cqm7X3LuuLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTJzIpmo7moI0zGx1pZ+gcNuMXQaPpvvBC9RkgCW6//GH2rwrSXXCVJ8F/vSgOUTK/I7eZ+R2Yg+9XE2QMXorz42VKsamz0/3IV5MKP7Kj+8efShfWaoNW+WKMEcKGXlOHF0dVf8pt6qXSPVspCZTjFfq+D0ZBr7ZnLbbq8FSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HJEQ9dww; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so3107427a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232758; x=1776837558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IwOw4nEFXsqMRZBIjOHMrigLi4hPR2+EYeIVIxwWSQ=;
        b=J71N5g1SuxWjEYuFkH97LKU3pLGhV2ffYboJ5Mc0AOndLFxntegaDcHkIMZDWTqMXM
         2x6cAYTkL+j60a0DmlqpuAMHhmHLV/gM7SBsSKMRksJ9zR5m9g52iVpjfvYDadfam6eV
         apdZwQ3ahEOpdQUnzKRy8w39eQGM4bS163vc97WUwqDkBWGdsoTLdpvr47Dtibdup6TO
         1Am7YH9ejWU6DRonbCXS5vxhnb0wUnH7FnUrxPbDmZrnkziaIM5/fxndAdPq709Qxsqk
         VAl0wJ9MDsuNda0OmgyFs1utabAe7IFQIWOJOPJVqK0p7n/xHHRoPI3Z2aEYAYGJcW/n
         d+LQ==
X-Gm-Message-State: AOJu0YwrZoQPfIK5t12PrbINS7KCGG7HQkP6u5ZJZc8VL/XVsBN4/tqh
	ugv/AjHCo/c+nafc/1r5ogeFMEALHjThf6GZd7aWF2hJgwIaJSVbYr6ulGIlYgT4fo4CQEXd5wA
	xDpOdKrViGEhF4rSyRdQAaD/XBy/bCMhcedzXKD0EOm/JvL/25w6jCQVhx0MCAjIK+Pd8it65yb
	j/F3p6bFVyL92UG30PGa/N8YkyyAl3hRaXh+/EELcbyes0a+I8evYpp8dQOVofqY94LU6/Va2o9
	4RrbrSjbrPRwV2LofDot/AVBt86
X-Gm-Gg: AeBDiesBnlLP2/FPv5t3NqOtkpNxtEKBvFe0Qik56OgkPfoggq7jXKv4vxE+Lsg3WMn
	0VerCl18fPi9K+p85ZrhC2fvi8stz17KqPmJnnPq5EPKv2R4PLEQCKj21UnLEgxWu0zPtxehtbE
	Qk5CnA/AJOzlyd9WqYo0BA8GT5Ax6wzlkFOFPF0isAb3AoC7OFG1xSB7yLZ+SrI3ic4y31RBYoJ
	tm+9u88JkUn+J9JbsfKjnK24rqTNGBteeDG94VX+3zO9JTnvzVQbgMejQW4ik11qXxdjHAQF8Df
	gMR5XDxzeROmUS5R0YZWdGnHzhXyAbmkNbzQxbbU9q5LoH6avImo8DG1Dw3uO0e/TdCSo7yQTFg
	uiIC2kbvIMLlAvQ7O9A6NGrrRqtg2/L0tg1xzjePTovPyEIZ/22pIItX6tHYaqFX2YVwTbVFoyR
	0gZG+qW9HOktR9WwhHPfzmpsTwIX4dfJp1tIFYXMLfH76tK1i0x7QIPSkzJLXDA3m0CXsR
X-Received: by 2002:a05:6820:168e:b0:67c:2bc1:6d87 with SMTP id 006d021491bc7-68be8bd7db5mr9347269eaf.52.1776232757577;
        Tue, 14 Apr 2026 22:59:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6932a7959ddsm59635eaf.4.2026.04.14.22.59.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b250d3699aso130169665ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232755; x=1776837555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IwOw4nEFXsqMRZBIjOHMrigLi4hPR2+EYeIVIxwWSQ=;
        b=HJEQ9dwwU+dCx1JQkTfkt4J87dFin5jI4dop5MUPmXl7CXzODm5PfVQxd2V8UBsgMx
         4OdG3GLgbPw7rhSffSCc19LhF+IPyx5ooNTK/5y2D+YTeMJe94wTnVL4DaST4U+uNHkC
         LLGjSCE8AxU2a99PycNmlOS9bs+1Q3EzQgfYY=
X-Received: by 2002:a17:902:9682:b0:2b2:4f43:b498 with SMTP id d9443c01a7336-2b2d5991e15mr139261365ad.13.1776232755228;
        Tue, 14 Apr 2026 22:59:15 -0700 (PDT)
X-Received: by 2002:a17:902:9682:b0:2b2:4f43:b498 with SMTP id d9443c01a7336-2b2d5991e15mr139261295ad.13.1776232754797;
        Tue, 14 Apr 2026 22:59:14 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:59:14 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 5/7] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Wed, 15 Apr 2026 11:19:55 +0530
Message-ID: <20260415054957.36745-6-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-19371-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 832B8400AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hwq depth shouldn't be computed using slots/round-up logic for
app allocated QPs, use the max_wqe value saved earlier.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 +++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 219272e69ebc..1a8cf99c7f72 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1346,7 +1346,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool app_qp)
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
+	if (!app_qp) {
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
@@ -1376,10 +1381,16 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_SQ_LVL_SFT);
 	sq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+	if (qplib_qp->srq)
+		goto done;
+
 	hwq_attr.res = res;
 	hwq_attr.sginfo = &rq->sg_info;
 	hwq_attr.stride = bnxt_qplib_get_stride();
-	hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	if (!app_qp)
+		hwq_attr.depth = bnxt_qplib_get_depth(rq, qplib_qp->wqe_mode, false);
+	else
+		hwq_attr.depth = (rq->max_wqe * rq->wqe_size) / hwq_attr.stride;
 	hwq_attr.aux_stride = 0;
 	hwq_attr.aux_depth = 0;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
@@ -1392,6 +1403,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1460,7 +1472,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1775,7 +1787,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp, app_qp, ureq);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, app_qp);
 	if (rc)
 		goto free_umem;
 
-- 
2.51.2.636.ga99f379adf


