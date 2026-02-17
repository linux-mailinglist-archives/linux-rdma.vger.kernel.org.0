Return-Path: <linux-rdma+bounces-16936-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKb0I5Lbk2k89QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16936-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C614896C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2684B30028DE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 03:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105E221FCF;
	Tue, 17 Feb 2026 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qc31YqlR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622E248880
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297675; cv=none; b=Tx1BC+LtNbnYqI4jUPiBz4Iz7R/jVP9y/aQ1D1jNbSuuyBGqfZklnotpFehoec3/oookUqZ123H+l5SiW8eHXjxteH4XuWL57aO9bT6jfwJRTVPMeHnM0JWsACFVfj68qtIov3rGI8jM/ScOz0mJBtoOB4x+n9JHSYVLOOHPI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297675; c=relaxed/simple;
	bh=gcBFHC9mnDYhchU7uYFaJ+gURTRHmgMDG80hqYGP+7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+OjaPBCHQAlWbYm6SRZVWe9ovy62TBP4m1D2GIcaFWA7+8a+gcQp9Gu1lSSUIzBsO3AZr07UENnwK4z/itl8xqjd5WRhCilDpylAueUabaF/MMwkC9/RwGcAvNFubz//WUX2nzGmjNno6XYDhhq3IL1O3cAhq6rRFXWCdNM3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qc31YqlR; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so2575065a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297673; x=1771902473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/0G5eXf733ZGyAityGbkkHJ2rKiNYEyzgSzk+DSfWw=;
        b=WsXWC3jnUPZ/U8Ag6uq051lFW87MXveFY/Z1yCUu81IUA5XBsIvA7NaAVi+4XlVQU9
         jyKRAEY259pJEOid7oJYazoKQ/qKg29el6P0Ogeiw0jO2Nk+qmzKlEzR+UfppXD1Cosv
         RUfxS9D2en3iRwWrWOtdhW86M0NJtKDduFpa/99ReTv2agI1oPZm1tS3C+RLCeU4/SJm
         HZjv9c/ERqabYYQUpWqXDvf2ykfDiz8gn8CK9oq5Udq3VtQL8EfmCk8MQUjAb22bjpsL
         DHJoCqP1Wp8uu49kLkDDMZLGMQQYqMeJ3ZG1Un2+zbVgf76G7SeaJtNapPF4zQY3/IlQ
         vYIQ==
X-Gm-Message-State: AOJu0YydGLkh8e63bMGeapnKbLamPaJ009qqikeV2w/CCre+g/qoTy0C
	BaYxWfn9/Dchx2cy3ow3HGpR59xKEpDS8ZdPoTdoHltSo859JYHvtIjpXwd89aELe8WBKVe2sC6
	dxi0fSxv/I1VOqJkaoA7JHrdY3Me97eX8XEVtT0tJnTprNEFAOIXoziD/L/czqw4jGQjPMP5TFk
	QDHt8AWjxtS2jnTRqfEsOlaTy4V7nWJ7gYLgUl+GY0PlFVRqrHivccQxpWDYKSOax5zPFyInPvy
	yYOQysm+J+Turo3oLFqWuFna7DA
X-Gm-Gg: AZuq6aIwxDxwHPWTeZ8BF7IZFwGpU1UMOeAECI4DfCvPzp8no/nir2nqEQI1hhstl8K
	aewdAOPINR+Zz/tcHXt9M07cs+18GBDcqmxxynlv9lhpSfyuAIEfX71HWPyGIfruxwWXdgvXQL+
	fsgkP4LKImtYD2xH/GuzfPKYok+c7cP3WRd/Lk+rfyGEK0QV3U26ZI0laTZfrT5Y0DFpDzx23F4
	rN6kvUS5EKV9ftm5JmFByfoT2l33PrXGQDfZIXi1A0yZgMAOGX+yeHnSzhzViMGzdTDqQjLiOrR
	DaP6lbdHwYJCjPBfj7zXn93HGe/bF3e7kXQvb0Anl4J02NukviMgcbKlRgnLoQF65JwQIE8KCez
	PzOIeK7uBaW6cJaqrcv9QhKJ99w/mCliPUs6fKz8HqX7HaWGs8+pderBmlDtPmWDUK8iqRQT+47
	+z0MRw2pwV9q8b9AdOUfIKHntAW0af01ZDo5Rd9Sk8bh+ZTomOXX3HRidedEVPnvP+Hhf0jNo=
X-Received: by 2002:a05:6a20:7f9f:b0:38e:53d2:7474 with SMTP id adf61e73a8af0-39483a5a7efmr8252266637.43.1771297672718;
        Mon, 16 Feb 2026 19:07:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c6e5300be33sm1107402a12.4.2026.02.16.19.07.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 19:07:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35301003062so20391642a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771297671; x=1771902471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/0G5eXf733ZGyAityGbkkHJ2rKiNYEyzgSzk+DSfWw=;
        b=Qc31YqlRgj0Tks5BVaT9eHXaPQ4UIad+MWcLFS1iNjtbmXpX9S4iaAIF5KZtomnUO2
         mcZUXkRBeT1Wa7stsERkRpvXX31umKQY7z0fuK8khliEOgurVlNxEqHmU8X952zeOjss
         Y9I22bM3vmOASBh7ERrcwpCsOrC/59vYnvpcQ=
X-Received: by 2002:a17:90b:4a50:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-358434b574bmr7189472a91.0.1771297670565;
        Mon, 16 Feb 2026 19:07:50 -0800 (PST)
X-Received: by 2002:a17:90b:4a50:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-358434b574bmr7189455a91.0.1771297670033;
        Mon, 16 Feb 2026 19:07:50 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e537desm20688167a91.4.2026.02.16.19.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 19:07:49 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v13 2/6] RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
Date: Tue, 17 Feb 2026 08:29:06 +0530
Message-ID: <20260217025910.15865-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
References: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16936-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A72C614896C
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
index 76f198390467..feb364e45e14 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -996,6 +996,12 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
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
 
@@ -1605,6 +1772,7 @@ static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
+	qplqp->cctx = rdev->chip_ctx;
 
 	qplqp->rq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
 	qplqp->sq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;
@@ -1710,13 +1878,14 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
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
 
@@ -1767,9 +1936,9 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
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
index 3e44311bf939..0ddd4f21a083 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -793,8 +793,6 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	return 0;
 }
 
-/* QP */
-
 static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 {
 	int indx;
@@ -813,9 +811,71 @@ static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
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
@@ -824,7 +884,6 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct cmdq_create_qp1 req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
-	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	int rc;
 
@@ -838,26 +897,12 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -866,24 +911,10 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -894,7 +925,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	rc = bnxt_qplib_alloc_qp_hdr_buf(res, qp);
 	if (rc) {
 		rc = -ENOMEM;
-		goto rq_rwq;
+		return rc;
 	}
 	qp_flags |= CMDQ_CREATE_QP1_QP_FLAGS_RESERVED_LKEY_ENABLE;
 	req.qp_flags = cpu_to_le32(qp_flags);
@@ -907,73 +938,39 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
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
@@ -985,56 +982,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -1043,29 +994,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -1091,44 +1023,9 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
 
@@ -1136,23 +1033,23 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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
@@ -1160,18 +1057,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
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


