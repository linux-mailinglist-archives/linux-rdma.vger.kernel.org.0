Return-Path: <linux-rdma+bounces-18456-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFpzJttTvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18456-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:04:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADC22DB87D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B906E300E2AD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069B39B4A0;
	Fri, 20 Mar 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aWLec6Pd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1E2F617C
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015441; cv=none; b=dSsNUyuNBwqA8ApCFibH+d07pqfbd7r3tOnB2PRSMRZXJ8Cl5HsmsTe3lCZmXCNuvbHCDiDCb0nQB5D9NR8pZarp7uTRzOJim4nz89ZiQTu1CsgMTHT+Khn51lmJRVPzc1wZ/vTiH31XIG0dnPvlg2lNKe+nRjVY0wpUyTaviCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015441; c=relaxed/simple;
	bh=9+bAgocJayTBJN/i5qc3TZX31qHNEXq8PWMqphMyDjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iozh9SpJ0F4FI3dyd8Y3tzJ95nXmhEBw171WgwO+DipK3STS4dkUe+6lxhzvfwbiPiXygipSHEZ+7sGcJkGd14h3MBNPOsCSX3FU3743q546z3UKrCaTSnofQbrZ5Ly9KQ5mQb4DBSE1D4PLTYKKl8G3EcSpte3aY9VbZlzgmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aWLec6Pd; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-12a74039dc6so545828c88.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015437; x=1774620237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaqvLjq5PlICves9AiMSVVHEv4wRmJdRE6jw+l0CpEE=;
        b=qAWBu4J4Mck2VuIN42iSEEiNk0uWkdFqjMNOewPKO/b4wICqDB1C0nST+qSy0EOnD2
         AFyfuNVwXfZ0gKIRmKxINfiWR9YaOyaQ+b3LjX7HLwfeq89RiFYW+iuGN8AetmhQzR/2
         FmL+01GpO0iDYqDayAwB0sqQ4D1DKtWkuNR6JqQ8+HGYq9Wi97tsg2dc9Ric3Xl9tcVp
         6/sXYj9Px3jKiwrg5SFJgMnpdY5tQORPyACjweaWbyNlvaHJoT0mGlSfR1HtyWVAW4J0
         6LLD3cXVqqE8c7y3fX+U3dVDfZ/2Jydqsb0IhWqBgc8njhu+GO5PF1swy/KSx9lcHg5M
         DoDA==
X-Gm-Message-State: AOJu0YxeMHzHGKWzZVJ81pOLcA/qv1S0AyHlT0wn1kBY6R9yU9wkk5j3
	WZgsHp39urD/cNaLJm8X0ojMIQiuxrDcczvBTRtNgtPBKtuYTfiUA6ST28HTGb0H7PsANVod63M
	7KZtfGuRtwqhr4pXunn+mU/3QIvGqTpi9rooXEEumHKtnzfUjCBsdVJeSKQID9elxCr6y2z8e4E
	tghIFbiPbcn6oTRiBLqtPA6U5AeHzp8NKX4fbqCQfJdOuJgqBOLIuSOFSSLUV3/MxPW5SF3j4EF
	xaxQ40RywJmxPhO09yFHxDqFd3y
X-Gm-Gg: ATEYQzyqVrvyTkOf67z/9hdxxOBUzMGct6NPvq+mXYmtTsPzqQ7JMHMagJqPovAWOPD
	YuiwSE3JyHobKoEhnVSGpoFSUncAtBerWYYSdiWBJhB5MsdFuF4ZDC0eeDNtM/YFOO4ZEQ0hglk
	ylC4WyckFEzrrRgDTsVw5rKSlfhjNWztbS37SCYzpNs9OZnvWoL8ddp6Edx3DB+XCCDZK/sqzR9
	8aue7TZZx7fUywVS2Ga62pqJATKedHB2oMGqoIXdz5hFnUrD5jWjtjJOGehrl+JV8SCjCqdxv4o
	4+Fqcc5nXoinXhOfgcvPov0nZkI5X6CDXLTr4bGfoVGHlfydteg4oJkd87B7ohsPSHhMcCX7PeJ
	XrfVWqu5cvgm/yeLtN/kDoMBaMInb5GCbko9xOkxMPFkWA+pJn3ZMRkL7wVBhLjNReklz9JfcdP
	qvpZUT16MLvvMjTG2BrJRbWU7G+Tftef0xLSKpfro/jboNck/DU3783QGRgbb2xpfFYtZg
X-Received: by 2002:a05:7022:1b09:b0:128:d577:dc21 with SMTP id a92af1059eb24-12a7265172cmr1464312c88.13.1774015436333;
        Fri, 20 Mar 2026 07:03:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12a73317a81sm165757c88.0.2026.03.20.07.03.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a68acce26so1204047b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015434; x=1774620234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaqvLjq5PlICves9AiMSVVHEv4wRmJdRE6jw+l0CpEE=;
        b=aWLec6Pd7hegd/UQ8njGzJF+TIdKAsNI++PCnM3iXVnL8xl1DmceYxQ33JBeyLAELe
         bJtTKFYF5yABRjuRUYylMZqY55foDek/P9vV0Rc8GP6K7pYNN7Lv+mcNMzByk1rT7sJf
         QPNNex7GZEkRnnJO720DtMEjuOYJZ9NEztoLA=
X-Received: by 2002:a05:6a00:2991:b0:82a:110b:e216 with SMTP id d2e1a72fcca58-82a8c2801e0mr2367848b3a.19.1774015434317;
        Fri, 20 Mar 2026 07:03:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:2991:b0:82a:110b:e216 with SMTP id d2e1a72fcca58-82a8c2801e0mr2367794b3a.19.1774015433369;
        Fri, 20 Mar 2026 07:03:53 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:52 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 6/9] RDMA/bnxt_re: Update hwq depth for app allocated QPs
Date: Fri, 20 Mar 2026 19:24:34 +0530
Message-ID: <20260320135437.48716-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
References: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-18456-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5ADC22DB87D
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
index ba49ca108b7d..f14d8270c711 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1350,7 +1350,7 @@ static int bnxt_re_qp_alloc_init_xrrq(struct bnxt_re_qp *qp)
 	return rc;
 }
 
-static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
+static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp, bool app_qp)
 {
 	struct bnxt_qplib_res *res = &qp->rdev->qplib_res;
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
@@ -1364,12 +1364,17 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
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
@@ -1380,10 +1385,16 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
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
@@ -1396,6 +1407,7 @@ static int bnxt_re_setup_qp_hwqs(struct bnxt_re_qp *qp)
 		      CMDQ_CREATE_QP_RQ_LVL_SFT);
 	rq->hwq.pg_sz_lvl = pg_sz_lvl;
 
+done:
 	if (qplib_qp->psn_sz) {
 		rc = bnxt_re_qp_alloc_init_xrrq(qp);
 		if (rc)
@@ -1464,7 +1476,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	qp->qplib_qp.rq_hdr_buf_size = BNXT_QPLIB_MAX_GRH_HDR_SIZE_IPV6;
 	qp->qplib_qp.dpi = &rdev->dpi_privileged;
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, false);
 	if (rc)
 		goto fail;
 
@@ -1784,7 +1796,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	bnxt_re_qp_calculate_msn_psn_size(qp, app_qp, ureq);
 
-	rc = bnxt_re_setup_qp_hwqs(qp);
+	rc = bnxt_re_setup_qp_hwqs(qp, app_qp);
 	if (rc)
 		goto free_umem;
 
-- 
2.51.2.636.ga99f379adf


