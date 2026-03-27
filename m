Return-Path: <linux-rdma+bounces-18733-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH9CKlJPxmk2IgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18733-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AF341CAA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B4C30DC5E4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CC3B95F6;
	Fri, 27 Mar 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WlPkbKt2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A42F290E
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603637; cv=none; b=QAj2adCvGNC1p9wxVoQchelIFEgmY07LBDRlKqT0DsVyz0COjxQVXPiKVtQH829bxDRP37CKpcpb2jbDuqP/2MMTa3V0eD+67dZzaJZO7Gi+g7JhhFhm5iiEAhXlDyoKgyqEgBS8TbpZIW+0CiqrkrQPiUKwUUaLEzTQsgiuFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603637; c=relaxed/simple;
	bh=YS9Ml7hY7z+Jx9Ch+sIjS3TQMf5sE967+mT2RZ++6OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avkWYv6yAcYqFrn7P3M6sGC9n7QyNPtI9hHZ/Z4kw9I3I5EwFwx6KPlV4Mr12MFBf4npMo7MjdSi4v+kmQAIfIxQVhd+WamuxIKbkUs7cdl8904oh3xhJXj+bFKBov2jgza5HoSPco/gcwJLx9HuhOYjyP0s0kcqm9tCVo5WroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WlPkbKt2; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79bdd50d6eeso5448417b3.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603635; x=1775208435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+hMK3JUzszk0Nl4sCwZ0vy5VlORY/jDsxVrRSgtQbg=;
        b=V2E/o4Gn9CzwSxjX4fjy9iGsGCg+3KE50Sngm91MFO+HjbbPmqY+7GacKuQaMPtyEU
         2/U0mcDjaKKV1q0Rzl6vIKBKHulvK52lYknVBb6uJZBHxUe2iK8MiZACz1kKhG9IcG3h
         lkbvt3ZswmravF2YJC/dsSizCTteOkWhLE91iIfpGk1W1JphyidGgmNarl/ugoxkA8/x
         2El/6PzXerKk0UOZ9ShnGdG7EPbM55RugkMoPLdz4sJM6fJTy4SwDlI2ktvS7U42okrv
         uoHfNh9477/Mmmih+/i9TLZzcaUQOhBqkel2EyYlCf21K5Rkbgr7cinstA4F1DsgGjiU
         j9iQ==
X-Gm-Message-State: AOJu0YxjeFk7Ha+aOyjSBuvEE0apv9XvZbiABzBzOOcvd9WF9muESk8o
	NXVfkseeC32wJGXU6CLy+L4OBLxEAdfoZj+H0cJ9FTCwLKW9ygHY9EeXi8whti10R47AVqayqwB
	1VQvcX9BE5i0wIofnDLMdTFJAdcEgSHUO2X8gYUUiyJU0V7JOwL3Nw1/CIKeUIMCc6S+eOPVQqI
	S+zrWF+bam9WrRUOENgZo7eKfN/LnWFFsoSHriGeOvBfa75HnzOytC1b4lO39SSsfDxIcFIDXiq
	Mfv3z+c3nBBMASuQONr/BMImwtK
X-Gm-Gg: ATEYQzxP2O2XTp17Zz1Z0D1LqM6K5fa3Ag+xuBkD6qpxnPjGKBUniPfEk/k0MKOTxM6
	/Qj8yJl9AI5GCHAJATa/mKXW8+OUEXbC5ufPxEtBLnRaEAMoiKXBCOepHcy6zHDUFXr32k9cUhr
	3/ZBn0UkOLOXCbR01CCw+iL5I8TMILpomJOElAa0gVnwgwZNjuYCbZ4fN7WlI4kwbKAudq6XTS+
	EMt5qgQWdWbMN06ZIlnKNKN+jFc9y/psiQHC5Kq7/v1kv2kjLet6KASh2Q3AYZANRZEdmtZ7vS7
	8aLE1LsmTeDC8o4N7VASIQzex01NAEVV5MTXcwJFTl5N7HuG4tVw9KvPaSQ4FZ33jXm95mRc5IZ
	3HviGz/D5uEcQPgMl3ym3MOSRbdZWgrlMid1hkIGkmqYpGzLZHZMOALKitjv/jLk4TORrgIsiit
	G/aacluUxf4ZVVnYJFa3jaDPVAvgt2gnVBOjbhupk3+TFwbbmSokinZVwZqEN3oick+zm2
X-Received: by 2002:a05:690c:e3ee:b0:79a:d2ba:3c1f with SMTP id 00721157ae682-79bde22c25amr13656297b3.57.1774603634766;
        Fri, 27 Mar 2026 02:27:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79b17e4a0bbsm4089527b3.12.2026.03.27.02.27.14
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794c39ea759so37773287b3.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603634; x=1775208434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+hMK3JUzszk0Nl4sCwZ0vy5VlORY/jDsxVrRSgtQbg=;
        b=WlPkbKt2AIPi8ck4hxhSqiKQJFU1YRGDUCDbE7SQhlW5a5c1WtKDPeqjgipfrt4grj
         PmO7kaLUHFEBAmLQLYe6bHH891Qtr93EGcweY5PF6+zvUyl+xUm8jcAvZWGfR/7rKHIs
         B6bwhw5psA/QccRKF9UIGaom/g//4EB5rh83Q=
X-Received: by 2002:a05:690c:c50f:b0:79a:8484:442b with SMTP id 00721157ae682-79bddd5c9camr13473507b3.3.1774603634032;
        Fri, 27 Mar 2026 02:27:14 -0700 (PDT)
X-Received: by 2002:a05:690c:c50f:b0:79a:8484:442b with SMTP id 00721157ae682-79bddd5c9camr13473377b3.3.1774603633611;
        Fri, 27 Mar 2026 02:27:13 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:27:12 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 6/8] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Fri, 27 Mar 2026 14:47:53 +0530
Message-ID: <20260327091755.47754-7-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18733-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F5AF341CAA
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
index b6aed318623d..0e865cba2c45 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1335,7 +1335,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool app_qp)
 {
 	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
@@ -1349,12 +1349,17 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
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
@@ -1365,10 +1370,16 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
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
@@ -1381,6 +1392,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1449,7 +1461,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1764,7 +1776,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp, app_qp, ureq);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, app_qp);
 	if (rc)
 		return rc;
 
-- 
2.51.2.636.ga99f379adf


