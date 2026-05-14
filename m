Return-Path: <linux-rdma+bounces-20714-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B/xA6b5BWrEdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20714-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:34:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDAB544C2A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C091B303829D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC233C1AD;
	Thu, 14 May 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xycxe+Wr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8F33A007
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776388; cv=none; b=FxIZgSHE6OtOBj6aoppfjjh0Dvm4E5NneGUfTemDVgpZUiZBJk6gmVOGnLJcdNt+IoitzttXajvaMC68ZQVsA9DIP1DTqOzUPaAsIkg7ioPbRzOSZt0IaRJCgSVo1TbxAg7R1KbHmUA1G3IcSgec/bZIVV/abE/OUaNgVti5U9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776388; c=relaxed/simple;
	bh=UGSbbOwSVygkIvlVceuRpVgHmXOb+PaDUBEznepXCz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syDiXj1j7MiL4QpLXcWXn/9XY5YlGGq0NCXt38AnaxsNYbeJh7X/Mn6Tht7Jtnzka5eVZ5Z3Sq/CqprWATiW0HiHj+fagqv7eBV4MtGbhiRXLJnSHofJWiFBV7vVuMKFF6WaxaxOV39YC4uDzOfoemmOvQvdagESkwYN2jZce4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xycxe+Wr; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8c9166b26b4so12140626d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776386; x=1779381186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9niCjeS5PCvxqvGtN62URGxXBlIQtiUfFNM/dhsx7d4=;
        b=Vqpzt88Tj8KLjXdEjFvOfjmY9A1UU0Zrw0I4xfMXBwzSbthxHPi9fMpA3/mew0bflv
         N69yvExHAQSxb8sTD6nwPLyp6mw/IXJiQRWsdXlSmzTzT/O5zk3VI3gfp7t7ql2dOHKX
         7t174UTWtzlZnMiwUvRwu+KHG68qQ4EZIcnDNoUF8VfL1IqvdH+fCjzaEaR35trFknGs
         NdV5YIgv3ElBdT6KMRCHsSzdYVI84ibZzhR5V5dv9NsIQ+eIU/RVU0xI+rZIjIZD1kRj
         qsEVXVBIQ3/gf1HaOZOjRDgsWaD3/INaJO2JrGGH5RjGN8jw0mtclPhdOB9Rfx9fzZ7o
         qVcQ==
X-Gm-Message-State: AOJu0YzT1Vo6pLPX6y7KfcoGoPufVI4SBZ+xgeNjLm5YNTQqai6NihjX
	VdRfIj3NyeWJFHETI9By1WLkt64sAQQ2MqueranyM7nMYk8myCyIRqsq1W++RpTyd0U7MZqc7uR
	XPG1ZNiKf5wcwHJNOmcvCmmYwx7uy+dAlIEMTWnpxKTgV5bt7AI7CoT9Z1Im5gC8ts2Usk0fGk7
	UKbWCNg8Sj913FcGGDyJIRoSQsjk5rMxTSkw/RcDGaSRAqi83VrMVM8Gwsll2GK2KYtNxWaS1IM
	IcxcIKrVROqX8HwbsMCXVzCn3qO
X-Gm-Gg: Acq92OHP+Qxfjz184K+kqgrzJlDiEeaazUNCjSjKwAtv//l4bo1BqQLWx+vg0JPTkTh
	TenmhbcGauGlCosz/C+rJ563wywXy1zwwgeOUtrS5fOmURpvjD0L+YHV3Wx05p+5KESxE7lEBlT
	eYJa6bOdlKCf9/yTISuqaxgEkVX27iF5WJNJib7qT0LjOAgc+RTYfRfzfAbeVvdBn8kLFCtIazb
	BRcuM+oB+t4e1UR0+S733nbzFGHpP0JG3axYVPYOsq2ejPpwQ/R/BvT8BZWgRBoa0W3G549O48q
	cRP1ihx1MZhzyy8tkuqGjgPwOX5Bmg0jKOpFhoUMloXasQ2Qo+mgxb68CfWnbRA9aqMX88Bhog5
	CScAEHSmFoYzvWVYnLD5b3EPskE4kaSavEVhf1wB5qKw3bfNvaaZGwhaWq+uDuibnFvjq6yNODP
	rkU72uQ86NiX9HRrWt1HeG1lJkOVWk1qE+Cfzyp1yoouKYrznD5BKNPa05ioyekIM9KLO/
X-Received: by 2002:a0c:f109:0:b0:8bd:6baa:721b with SMTP id 6a1803df08f44-8ca0f68bc46mr4116316d6.14.1778776385737;
        Thu, 14 May 2026 09:33:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8c90aa26df7sm2007066d6.20.2026.05.14.09.33.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:33:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36865d109dcso4976620a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776384; x=1779381184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9niCjeS5PCvxqvGtN62URGxXBlIQtiUfFNM/dhsx7d4=;
        b=Xycxe+WrhdI3PwCmDc/gK9shVfoe8WVQTvHVAaGiSffpHSXW8gKDVTml4gwVo3CXCB
         2FNHzPLfBKsKiXIOe8jcgAiMjXnQfpXkVjj/qjYPFi9STobDoBx+iDXZGy13IyxpYsDi
         nlEoPz34dJhSHphnGgwoAaNejalSwvpz3bwVY=
X-Received: by 2002:a17:90b:4a8a:b0:368:6998:b49d with SMTP id 98e67ed59e1d1-369519cbf0bmr162596a91.10.1778776384431;
        Thu, 14 May 2026 09:33:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8a:b0:368:6998:b49d with SMTP id 98e67ed59e1d1-369519cbf0bmr162548a91.10.1778776383861;
        Thu, 14 May 2026 09:33:03 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:33:03 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 5/7] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Thu, 14 May 2026 21:53:34 +0530
Message-ID: <20260514162336.72644-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
References: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 5DDAB544C2A
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
	TAGGED_FROM(0.00)[bounces-20714-lists,linux-rdma=lfdr.de];
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


