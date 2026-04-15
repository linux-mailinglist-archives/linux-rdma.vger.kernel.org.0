Return-Path: <linux-rdma+bounces-19373-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AF9FVUp32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19373-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA872400AD3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78C553051D11
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA7372B2B;
	Wed, 15 Apr 2026 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hjnSMpAq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292522580EE
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232766; cv=none; b=ryJbNovCn8fep+c8YAxXmfXuaNGbxgjev5aZnNoVYYyAjPRnKowEFAAG6LhJykL8UG/jAVlcFF3kSQUO79CJfpkOFqtgpMQtTEdt/LrzC2xnrUE3a501hfQgXcG4fP1xbYqjVXHC6dYA2kEMrlluD4ZLW0msBHBqex2cI1ymLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232766; c=relaxed/simple;
	bh=mB4p2je14vff08Pj0RtC30QEnwiQqk3Kztyp2uNDvW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxQ0hqjE1sEM4bd3nHqXnCgHZNeN3dQO2UvjH+V1NeWtjfGIj/JFY7mViFZIhlumPodjPIncabGOJfy4Xxwpwel2s3/UH0LpvmZWij7pJJ+rIcAYjArR7TIrH0Aze/wBn8NPoYr3aeTuVvXGzY1KASl8y0FwNCDldJxHliA1ZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hjnSMpAq; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8a58057d7baso68749336d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232764; x=1776837564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OskOgk5Zka5nMsn6pZD7OX8mU2FEmg09vqzv9KFkndg=;
        b=PwFijZj0KP2W1U7zfKUcKdmWbD9XIcjVvcw8seNe6wJoHfAGHucCCxfad3va+PUSx+
         YlkgCmMPjOjf5eLl0V6L5+1DEMDmXcRBmEB5uSJ0QLc3SC2qV/sAYpMSVlibOrJHSoeX
         ByUI+LziHONHqAyeFuLeYrAFIZ8dBARwnEDysdFBV5VNPBaSLwnROCMuZTq7O54M+Z6C
         6uF+EnuLS4JvU7q3SwQVUdiI+bgPw8aLBMk0Sj77oq/ml5zEOVk/t2go8FGjQusMU3kD
         BT5d6mQ+0zAMnPmpdNU47m2eVx8amoJW1Q+QDEnoT2k+dns4/ZFOM+/OSdEqk0KRyrc7
         fQ3A==
X-Gm-Message-State: AOJu0YxnXsPvkMAzXCQPQ234fEr6ihiHAERHSvJCiIZ93UrpLwHlP1zj
	b76g83MS24OgTKRHrdHSwqoezcS5vcqRW05prK3SoKYvBoqvG4FguKBMoqg1DAbcX+tSbCTQhzv
	ciqMyUWGbca/AEwL20Zphh8Ib8dMhtCU5AhWUsQ2AdrhS3SsK7+HixADxZYdvdvB5qtt0JmK6Mh
	rmfek1NO8IPqRGIYFZNsLI+7+bOJjcRxyJKctakoq6z6ZFsVhNRsbvbTSikDUboEWUhVrAQi/62
	GDQI5EeSPnUM0KI0s2QySJIV/VY
X-Gm-Gg: AeBDietJa4VmDgSN5kSeuxXxh41KXkrTvxve0JwbH4KSGS+acX94pZk/kscFy3PfU8H
	ibNwm0rVO81eaidR6Z+mdhdqA4jJZXaQ2c12JyiinVlEwhV6jSsOoO5EEAV/px01rtiCzQrPML1
	Yggv8wDJXTiu6Y/7+U6dbfDNmTMY+RX0RJ2bJbdWWZc4imf5ZVJxkjT514C0RTgFoLoifILf7Tp
	l+e8jPedhRs76DGmIH23zQ9Y8TWpB7syFMlrboRIqkxokyDsok4VNTXNS0Ax93/z1FEPFPbZcUq
	s9eu5huDb7EmnUEfONGwQZ4mvCr7WRk6AXu9VPuZLjdoPKOaNnzYzoO1hDpXBCj59joqw+Zp/+z
	mu1rGBVtwbV/KXyrbRK4FhqMb+aMgRrK69SJwZc0fJbUWLPKJSmhx+biVKqGwbIC+2up+EXu7ds
	e5ztqvH89TT47nFqYxXRgLjO78oGDys/ZWg7vrBu1q4sYuLJHoZgmvBPDXKwzHl8bN6ihx
X-Received: by 2002:a05:6214:d4f:b0:8ac:bae5:7477 with SMTP id 6a1803df08f44-8acbae57d27mr118592656d6.26.1776232764067;
        Tue, 14 Apr 2026 22:59:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ae6c9591acsm532846d6.7.2026.04.14.22.59.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2ec948174so33755495ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232762; x=1776837562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OskOgk5Zka5nMsn6pZD7OX8mU2FEmg09vqzv9KFkndg=;
        b=hjnSMpAqypID2568hkn2YoU0UpbBFJ0tSZ1Qc7P/EAo4qswa4ThyQHt47KjopoHVw8
         yRjQtuA/bUvbQ4/fGJ2Qje+5tYWGVd1jv9YS+jGXlwlkftAB+ZLJs9uLLjqtBe4w8hEX
         rvQPXScb+Rv/9k5l5MMfnppO/hsUpGlwElKbw=
X-Received: by 2002:a17:903:2f08:b0:2b2:5314:e96a with SMTP id d9443c01a7336-2b2d5a6de57mr219815655ad.34.1776232761993;
        Tue, 14 Apr 2026 22:59:21 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b2:5314:e96a with SMTP id d9443c01a7336-2b2d5a6de57mr219815425ad.34.1776232761608;
        Tue, 14 Apr 2026 22:59:21 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:59:20 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 7/7] RDMA/bnxt_re: Enable app allocated QPs
Date: Wed, 15 Apr 2026 11:19:57 +0530
Message-ID: <20260415054957.36745-8-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-19373-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AA872400AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver supports a new comp_mask: APP_ALLOCATED_QP_ENABLE.
The application sets this comp_mask bit in the CREATE_QP ureq
to indicate direct control of the QP. The driver goes through
the required processing for app allocated QPs. Only variable
WQE mode is supported for these QPs.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 14 ++++++++++----
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 0036c6160857..f41d9b0cc58d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1721,13 +1721,13 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
 				struct bnxt_re_qp_req *ureq,
-				struct bnxt_re_dbr_obj *dbr_obj)
+				struct bnxt_re_dbr_obj *dbr_obj,
+				bool app_qp)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
-	bool app_qp = false;
 	int rc = 0, qptype;
 
 	rdev = qp->rdev;
@@ -1745,6 +1745,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (app_qp && qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+		return -EOPNOTSUPP;
 	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
 	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
@@ -1934,6 +1936,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_re_pd *pd;
 	struct bnxt_re_qp *qp;
 	struct ib_pd *ib_pd;
+	bool app_qp = false;
 	u32 active_qps;
 	int rc;
 
@@ -1945,7 +1948,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle,
+						  BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE);
 		if (rc)
 			return rc;
 
@@ -1959,6 +1963,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			atomic_inc(&dbr_obj->usecnt);
 			qp->dbr_obj = dbr_obj;
 		}
+		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE)
+			app_qp = true;
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1969,7 +1975,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  dbr_obj);
+				  dbr_obj, app_qp);
 	if (rc)
 		goto fail;
 
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 4da8cda337dc..edb0329b700e 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -127,6 +127,7 @@ struct bnxt_re_resize_cq_req {
 
 enum bnxt_re_qp_mask {
 	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE = 0x2,
 };
 
 struct bnxt_re_qp_req {
-- 
2.51.2.636.ga99f379adf


