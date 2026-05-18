Return-Path: <linux-rdma+bounces-20922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDEeAUY4C2qWEwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:03:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A058857085E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DB92307E7BB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB047CC62;
	Mon, 18 May 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Acj6LU+Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5440B6EB
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119241; cv=none; b=bCq6fKq8HEWc8il/VRyqDpYw3lU5h7uBhVd9KM0KyG6kogU/yCSx9HZFjxj6pUGQdkI72vGX7R8m3vrVheMW3arOCOGcP3xNgND3SdX9HxCicTbfRAxz9erixnizbVZLg85zJweVrZFVez1bvUp0BrcjgM2g0ILJeCi694ECdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119241; c=relaxed/simple;
	bh=a2k0hBdCPzFCRTpMatKiOaFVcjwmk50TVlz72QgyjUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lydz7k1Dm76jKPweplc6efzyU3p6MmSspiui5KPPey5Mc73+oqIZzQie0Vg90SLPI3GMdGgy66RQvlX8/o/J5cY4X2fUAR8y0OOcJb035naLMcA7kM3yTNEqIDzW8sj5wrBA8m2pGk612YfqUGyDmVONvintB4U08n0BVobpUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Acj6LU+Q; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-95d04f205beso1718872241.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119230; x=1779724030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQvEBwfwDgOgTT8b7/X+qcwKiWgFRznpt9d5tYLF2Wg=;
        b=e2z+Iqfp4fVUzXAIyv7FM/3zJlf6YWfX7AydL6YeA6a+GeZh/lZbSfwMZZx82ZWxSf
         rccx1cYDMxs5CAPK0cmgBMie8tdTr7s6TZhlxRlUFbJpmfsB4omNtKkHpqSKRn01IfEW
         Vx+KsMlRWvCQdIVlB0CnetliG/GOS2rMPXXoOuSw3HrprWW8qkvvLNwFdDgVwwNO8sMG
         bfvAgFOXiHfcwWIUeME7h0rWp3yRbrbX8mzG7HugYuhNgN4bwkvVL02wcfVJlZgLFmeF
         Fvhxu68UIBsqBqLHVlox3JRhR4pOAHNmtjHWDRIiphO5UGbcM1Z2Tcyf+m0LBFRzVeJD
         c/IQ==
X-Gm-Message-State: AOJu0Yys/DYiSi85qtYz6dVzS1cW0yT8VHnqwySMfYbMBiMLEC1mgnna
	j6kWRdBmgJLGrsaNKhUxk3mCjX7hoRNAEqyXD5noRHOfdBCQswp+AD9KWQpgKo2EPjgCoxQcU8s
	Z1JtNLnELY2JiFEqgv40xr2oPazmouf2QlqF6PJrYqON/X+6y+18yceW/AAqQk82oaT4vZx//4F
	CfCehP/In38mXli1rKsrcXJfEhSWi9OteZs7ZZBxcXc9NuFPP504W2rgfLsAuS0ZcKFVRK2P1vT
	NhzU6Q1xbxHeRFciCQyDNQ7HmPY
X-Gm-Gg: Acq92OGlz3FMvzV9SuIS8IJT/4WV5ivwqAhjwL36bOlimTq7jVyVB1ugBuHfIotR7lT
	eO8aO5omaHU9naiHNpwp5o54/BXFqO+WRFhxm5SasHKTlgtNMxSdmgCfUnFaYLjvNVKOJ6A/ucn
	Hzd0AABRmYyhcGhhIhHqwoeatP0SIoGfFvareRXoEVGA80k9V7HGHMEBkQz85JdwZnxOEQHKz4U
	KQLKZ57kQfvPAVkZSVS2KKjZt9tyPMCY26hkfUAVovIqw1Oi6zt8ynJNSpjRqlcHuJ6mTEbdSkn
	cqx4W8mrRhMoPsOWoggj8aQNN2hseTUIOTjR+8oVMejdnPMxWfU+LWPL2Fc3/F5+tAqyC9tHFBS
	JUTtoOj+6JzN49lsfSjKJv/snJi50yACAU6mhzDZMTQWYluR3MF0+ra2N7fhY8okA04S2qNL7EW
	kU0zF4eyI9L28RgVs5
X-Received: by 2002:a05:6102:2921:b0:631:e729:4579 with SMTP id ada2fe7eead31-63a3f59853bmr7549428137.24.1779119230416;
        Mon, 18 May 2026 08:47:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-63cededcee0sm705400137.29.2026.05.18.08.47.08
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:47:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b458add85aso26533475ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119227; x=1779724027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQvEBwfwDgOgTT8b7/X+qcwKiWgFRznpt9d5tYLF2Wg=;
        b=Acj6LU+QLI7CJTtajn8I9oUJ0soOFGhg7mpRQ813JsmGMxpPR52Z4ekfOtqtuOA+MT
         Tl/JupoT2BYx4uBGs3kPOITMsRm+G7VhWqf70W8k1ly2wrwkufy+f5c9pEPks/hBKuy5
         VeDyLufMcdLrVoVm9QLmy4N3aELXGMoQca6Sc=
X-Received: by 2002:a17:903:384c:b0:2bc:6d46:ae9d with SMTP id d9443c01a7336-2bd7e8ca92cmr168073275ad.17.1779119227521;
        Mon, 18 May 2026 08:47:07 -0700 (PDT)
X-Received: by 2002:a17:903:384c:b0:2bc:6d46:ae9d with SMTP id d9443c01a7336-2bd7e8ca92cmr168073045ad.17.1779119227074;
        Mon, 18 May 2026 08:47:07 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:47:06 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 9/9] RDMA/bnxt_re: Enable app allocated QPs
Date: Mon, 18 May 2026 21:07:21 +0530
Message-ID: <20260518153721.183749-10-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20922-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A058857085E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver supports a new comp_mask: REQ_MASK_FIXED_QUE_ATTR.
The application sets this comp_mask bit in the CREATE_QP ureq
to indicate direct control of the QP. The driver goes through
the required processing for app allocated QPs (previous patches).
Only variable WQE mode is supported for these QPs.

This patch removes an unused comp_mask:
	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 19 +++++++++++++++----
 include/uapi/rdma/bnxt_re-abi.h          |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ba8f7f94131b..1d0ca766a174 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1717,11 +1717,11 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
 				struct bnxt_re_qp_req *ureq,
-				struct bnxt_re_dbr_obj *dbr_obj)
+				struct bnxt_re_dbr_obj *dbr_obj,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
-	bool fixed_que_attr = false;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
 	int rc = 0, qptype;
@@ -1741,6 +1741,13 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (fixed_que_attr) {
+		if (qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+			return -EOPNOTSUPP;
+		if (!ureq->sq_npsn ||
+		    ureq->sq_npsn > roundup_pow_of_two(ureq->sq_slots / 2))
+			return -EINVAL;
+	}
 	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
 	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
@@ -1925,6 +1932,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
+	bool fixed_que_attr = false;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_pd *pd;
@@ -1941,7 +1949,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle,
+						  BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR);
 		if (rc)
 			return rc;
 
@@ -1955,6 +1964,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 			kref_get(&dbr_obj->usecnt);
 			qp->dbr_obj = dbr_obj;
 		}
+		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR)
+			fixed_que_attr = true;
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1965,7 +1976,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  dbr_obj);
+				  dbr_obj, fixed_que_attr);
 	if (rc)
 		goto fail;
 
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 4da8cda337dc..a4599d7b736a 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -126,7 +126,7 @@ struct bnxt_re_resize_cq_req {
 };
 
 enum bnxt_re_qp_mask {
-	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_REQ_MASK_FIXED_QUE_ATTR = 0x1,
 };
 
 struct bnxt_re_qp_req {
-- 
2.51.2.636.ga99f379adf


