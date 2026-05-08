Return-Path: <linux-rdma+bounces-20228-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA32CF+p/WmEhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20228-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:14:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A284F41D8
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D67307DA2C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0511A38737E;
	Fri,  8 May 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RuK0xV8/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843A35CB87
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231314; cv=none; b=ecVJrB+tOLtjXuuYrgN4WRx6BHMfbHXN8+PBtytV34bhpuHBX6O22HJ2Y/X0OiADeI2RWiZL72Jq6HU2sS0yj5+Bi+6o2u5ghy9aAWSdtXT5+m/fSrQyhYrcngF3JopYfWaAiknG1K0uS70aK+y4NBlMwbEDapZ68OFarBqGPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231314; c=relaxed/simple;
	bh=DQ5nz9GgMbv9T+g/0gCWEjFkdvvX4iBYGqG4yCqkhfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBiK55M8PTHPvDq++Iw1CbQ4Jc9y3+BUJlHqfibF/p1WY3DwyXhzb9pc27zBKU/ZbesnD9VO6GO0LevU4xEiXKxnwlFbTtZ16GtU1Cp4jV66VWigZAokVHdWKFw4BLp9cXMqYbph+KUK6xEqJ6NvsiqRzpuumppagiPqh9XjkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RuK0xV8/; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2ee990e8597so3119848eec.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231312; x=1778836112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkmpUoMe1PzATOTxbcoPIdyqbx/A8cOXvbmWmCNIky8=;
        b=JV2z65nome0lopYN0Emi8GaD7zWi07R8G7zhIL+E6RFMACfovF23GY1abEECFK4P5e
         zuYzi+A8aUENKNYUBtip9y+AAnfBhY2f/ASvdwh09ld05EPRdCuKVwQSaaF14nI1y3jD
         2fDpgJGbJeMG2r+5s61+6hJQYp/0xoNlVZI6Lxom+Hr8WXAnatp+Av4uS+4OGbJrOeWh
         xi1DltnP0icAVFH4yZTDwbrpNn4pz00WG1zC2nrQr2EDEmurVZc23TLZuk+AVpENr7Fe
         AwHYlj7QUn966i7i+R39H2GShkpoSfU81vicGZv3nokBYDq1C4Lol0B/0sxwIj3l12zX
         FNSg==
X-Gm-Message-State: AOJu0YyCUxZXP6PoqULxtCzwA47vptQ76gF06e327RVle0ZGjGY/fSPq
	p2ncxv8eqnNfzDHBELzcZg3IzZ3kLEhcJ7t2lTINzlhy85mPCUe9FnuFluQQ427cbkEzhFvdHur
	aJ4ShuNULx6rn0zgNZO3wLqY5mrZ7iup+LcVlPe82kLjT1e70O3n6p6OVnLDx8NPT7FHbXnOBm2
	taXTaQ2uzWaHXzZ6cjm3PwtqusP7byuhQY5S9k7DDB88tGFY3+hTBmlEuE0CSBnnbsiMHdFZSlr
	Ht1OumGhxGKpuWlVVOKyexyF76w
X-Gm-Gg: Acq92OFgnRd1hjeze/rSVKoGS2ks/VHI98TtRtLar/dNJNkXeEgprn/dkSUJPijzw1e
	hi0qFyiKTEn2BCCBKKGrj0QYikaywQsEfTxU9dtJblwhTQ1E50S2pXHwB6HGfJNg8zXvzgJQfPA
	F4Wi4lMAfVs1csae41MGEbnZrxBSPY1M0SZHiuvLr/AB0RGOrIkS09PNp6nohZ9KdO2OuOthY5P
	WmppcOP/YKyFit5kwa/yaVhIpInL/+cBE+trgM6hvLz6X2/fkn3eKgmukz5QLQiZk4Iz16vVhZ0
	l+64z1FkXc8geZAeRxAySOIkBY9kIkT8PYe5swOHv7zypmaIBhX4JbKNBLC80yScCaRHxuj7T2B
	pqXRZGUtEMHSrZvZ9o8AsQIUr5VC2VVGrPU3j9synvPh76Z8vEerF1yxzmNfUAd+seGfGdS3TTp
	+kXhRwj7oV23YtIC7FGPE+/oc89Ii8PFabSaGECysVD20/ZZmhKxN/48AlCbuSxGRZn2IzNfsn7
	MDCoQE=
X-Received: by 2002:a05:7300:6d08:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-2f54ac74b06mr6208765eec.22.1778231312322;
        Fri, 08 May 2026 02:08:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2f88292df59sm118116eec.0.2026.05.08.02.08.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 02:08:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c80b103360cso1090940a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778231310; x=1778836110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkmpUoMe1PzATOTxbcoPIdyqbx/A8cOXvbmWmCNIky8=;
        b=RuK0xV8/xmReFa4U8OcbDsUGjAu0G9sq69J+XE+c/553NROEmYzFNK1uZnhMM8Esam
         V3tMMFpJ1ONA2xp9bziF4NJIn2MeMaOzuuuK2eJExzPr2j8ctR7k1/OeY15DQ0RIJYxh
         FwXOySnyllHvCeo7Dl8ADqficgNpf88NjABm8=
X-Received: by 2002:a05:6a20:3d0e:b0:39e:fb99:d3ff with SMTP id adf61e73a8af0-3aa5ab83498mr13414571637.40.1778231310246;
        Fri, 08 May 2026 02:08:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d0e:b0:39e:fb99:d3ff with SMTP id adf61e73a8af0-3aa5ab83498mr13414523637.40.1778231309679;
        Fri, 08 May 2026 02:08:29 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm14419052b3a.31.2026.05.08.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:08:28 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 5/7] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Fri,  8 May 2026 14:28:56 +0530
Message-ID: <20260508085858.21060-6-sriharsha.basavapatna@broadcom.com>
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
X-Rspamd-Queue-Id: 71A284F41D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20228-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The hwq depth shouldn't be computed using slots/round-up logic for
app allocated QPs, use the max_wqe value saved earlier.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 +++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 33c6b8985b4f..a04cbfb36135 100644
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
+	if (!fixed_que_attr)
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
 
 	bnxt_re_qp_calculate_msn_psn_size(qp, fixed_que_attr, ureq);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, fixed_que_attr);
 	if (rc)
 		goto free_umem;
 
-- 
2.51.2.636.ga99f379adf


