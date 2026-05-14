Return-Path: <linux-rdma+bounces-20716-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAJmO1D5BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20716-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49AB544BE8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E14EB301486A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FAE33E344;
	Thu, 14 May 2026 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GbCC5akj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE433A007
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776395; cv=none; b=Ak5a/AqKVIEMouUb0+lpP8wD9jy6fbkSFibK0Ih7Vsixxw/g7eXOjy5KaV5o4IWcOam1GiK0kKXBG21G34UT8HyVUb/fEHaEaP0I4DZq0rOOP+r9WvQ3e3pPTKRbow6T5r8KjHMFqBS4wY8uNqp/9JmJYmFGH5hEF0DrqJsdqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776395; c=relaxed/simple;
	bh=Fj90YfgJNmnKm2h08HI2D/AOU2pUV7T0xvOjgw4pbMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfXZPEMP/K/CdTP9gxPy/YabawRKEwce00qD0gcyOsq/jJL4AmxbELJvFQ403OO27hwF+/XiB9Y7J9QorW6jSnlAM/FWxncW4/Id+1h+S54AkW7yETrCgHJbEvyLRkVKgGnP2BPC6Txd3UbiNkxqjavxCpzZ4oOWI53w67SKWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GbCC5akj; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-63319183a49so1807766137.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776392; x=1779381192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51SvQeO25NqGXtQP3EYw1J40rHdD/oDgCliRutAyyDU=;
        b=jUPQ6nRb2hShO118SkZkEdDGBE93/qRf3n8Jvsp7i7CYjC3YnUqPQrVeS0mbwID+fZ
         yipxzcjBa1ZIEMMExdTGHoulVYWYiH/7B+baoAkktRtADWzmBI3io1wrWZxw8XsgUhYi
         eeCVPXRmaoFi5a7Q/RA/UVOTtGdbpXHmRVqj725twaQvXV8cxG0juYM6Q20t/c7cydh+
         vdvTCZp1bQCg263qqfmwEC6rxpRhyl6Iij7OcULnZjfMHwBQSFuwfScvT5LEZZ4GVTKb
         sFJBKQuBD6reD63CtauKeM3DVwqkM92r2vTqCCbH+Ul4owaX5ZCESgSUYA18tCn+hVxn
         9Axg==
X-Gm-Message-State: AOJu0YzKhLJpXKv8gPSYFCclxnDqV5Q6QLj9khfx5kY0EMtTSpjwE6gk
	G6PWV9u75gSMrQRamq1Umf6kZ4XCrOeE3WniSpUfuqJ9eJEM9JOsCE/9Uyfm08zqlVKyU7V987v
	Hx8Jax0ErdsPcdeo8A3bE2foz5gIu8Phq0Pq100oLgNFHaC53S6rqp/avPxqgSq2AfZAFJlekZA
	APFAwJjrzoYWzOiq7fq28HnHESn/JdYLzkoabGO2mtFzNz9EeRe1eYkZRyYZnL2VpW+Ya0qhafC
	znb91HH/RNl7XMxb/uvN/GxOtN4
X-Gm-Gg: Acq92OEPop/8n2FuVq2f8C1umjdZ5maIySf1kqeambp7WP5jsCIge0PfcldpcKLMdUk
	bK+r0UzgDWmBVfUxAu6GNyZjjRCixgTNLQ502rtVD/VK63iuOM67HhGvhIfGNjpJrhgY7KcURnB
	mUJbhLeFS8Si9Eq5oP5V667iQ/1+VlU9HB+0V6gUj7vOK/FKMf4+AB15UuW3zPie0y/EQ/FC5y1
	yJrWQ+I/EJqNYpsJxb+vAke4kMz4Ku0TkvW1Ue+z5eS3O07gP5ky6vsmNaIuL4+q+xtwL/AuqDF
	SNRmk9DdfDwy94UHvJeSE3LN61h5wLyjRjN6y0nVjUlvLrrsytffoBsbxDls+R4+lXpiCz/97tL
	sQGcI8xgOWDrE4RU7Jhoiu6/eCHnSUVFiYd1kbPSPK0K11JcdQcBNfxNUs4Mc8Tbfy8ESQQKlSm
	jzL5uzuRrierD7MAAv
X-Received: by 2002:a05:6102:2923:b0:631:4cda:3e86 with SMTP id ada2fe7eead31-63774231416mr4344596137.24.1778776392370;
        Thu, 14 May 2026 09:33:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6390ab020f8sm186416137.16.2026.05.14.09.33.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:33:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-366122e01fcso9221062a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776391; x=1779381191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51SvQeO25NqGXtQP3EYw1J40rHdD/oDgCliRutAyyDU=;
        b=GbCC5akjKy0d4TKb+hvzUzD8JR1HEzleGjELefy/3ryJ0wDQ0E0+p6me+5E8GubQyQ
         kQUoAiVBmd7Dxs2Dpmmz9zu83InMAyjrzomIPh/OWq/jsOxQLUS/TxnN0NcshyYGvuoO
         vLkk7X16j1vmfT/4DURzvm1uD/xnpucV+48po=
X-Received: by 2002:a17:90b:4c06:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-36951ca601fmr115171a91.23.1778776391210;
        Thu, 14 May 2026 09:33:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4c06:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-36951ca601fmr115133a91.23.1778776390617;
        Thu, 14 May 2026 09:33:10 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:33:10 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 7/7] RDMA/bnxt_re: Enable app allocated QPs
Date: Thu, 14 May 2026 21:53:36 +0530
Message-ID: <20260514162336.72644-8-sriharsha.basavapatna@broadcom.com>
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
X-Rspamd-Queue-Id: E49AB544BE8
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20716-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The driver supports a new comp_mask: REQ_MASK_FIXED_QUE_ATTR.
The application sets this comp_mask bit in the CREATE_QP ureq
to indicate direct control of the QP. The driver goes through
the required processing for app allocated QPs (previous patches).
Only variable WQE mode is supported for these QPs.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 19 +++++++++++++++----
 include/uapi/rdma/bnxt_re-abi.h          |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9905f1c039d7..51958c5515b6 100644
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


