Return-Path: <linux-rdma+bounces-21627-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J8rdF4L4Hmo4bAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21627-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 17:36:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5200C62FD59
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 17:36:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=KFmAkuwS;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21627-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21627-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47BB330AE5FE
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BD3EB809;
	Tue,  2 Jun 2026 15:06:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B253EA96A
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 15:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412760; cv=none; b=FO8bANWtL51/qUMklSS8GJzxHedirn5Ot3UwSNF+JUyWoXIRZ45+wLVqhG9xgO2g4xkPBk0misUZpuRzxoNa7WHTinQsG/kQabGtVBI1Az8brgZti1QJ9B1PSzfOj5j0aSdHSJG6JDVbCQcBdqutPyLjMSDcEdbNzrTJ6qWsrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412760; c=relaxed/simple;
	bh=eRBkBtna0GmsqDQG+m2ojNYYJNZT72qsO/AwVVBNfLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JclTueSILfj/pQHbUmgHjM8H1gpSdpcrekipW2mDPJgOPxajrx89wN5kuogJY05qhOjphaxTt08EdkK/nO5DTRah9fPHeaIoHlo5culcaU5ClYoI6x6fvAppqsKFOReiQ1YbTFUAwJvutKoZKVjhf7t++r54JBrLYyY5+W8gEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KFmAkuwS; arc=none smtp.client-ip=209.85.210.100
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7e6b5dfde3cso1232212a34.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 08:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412756; x=1781017556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WQzqqLFwAI8dFmVG5nqDipsKwHwSth8r63Yw8rzeoM=;
        b=iFxXUY5px24aHsaP0SIXajos8NmxdDVzvzskrJUcO/CPOWQ4hHg6Wzjyzy73IlS/9+
         djX4ZiXE4idSbGtljpwwzzQEOn47DfUfbK6QbDw6SYAxd7d195VOHo3wA78SsdRpSRer
         MxUcVAXOznVR+DFsbxlsylfYgG2g1iTlRbA/E1qCc01d5qrPm0NWRXlBVRRI0g+9oCB3
         WwKBpLDv7qntiAUWX6q23FHOO+hIoR3HhjYiYLFy7+g/GqgJx3r/zD1q9/qhSP6Cl/1i
         ULcyphpxQOKq8+kvNTXPlyxmTklEcQ48RZfqxWIR6o84rj1ZHbE7I8YyHZnzxtRBquxi
         ZjEg==
X-Gm-Message-State: AOJu0YzqBPdrYmBcFb/PgUl8BuC85M3Txo7w1M8Si/HeC5PlKSjsk+E2
	gmY+wKKgsiE7OTaowmptKVnICA3exFN8a3PJOQ/CsFbCZvQ5ZZsiUZ5WLpFoC3LvcZx1U5J8I0i
	hUqfsyu8V/ImME5EUrZN4w10c58d0XbPRfmz9Nbrq+DXW5dZ6RarcMaRe53lbghGR98ZQmmWzaz
	E15XK8Bk6LxuG+guuVJPEjLwdDhDXip9xh745emX9pti95zfIvCcuUxJH9eLS6MfhXOgdeYPdX7
	zMhUhHVkQrUP0T0BArK/zP3cnyA
X-Gm-Gg: Acq92OEvnE/XGkIay9sHmm10lgu+NcwKuapKNhDwhXWoCeFmRN4pbQbMZYIsmOGkWcL
	EJjW8rdnhfzAOeMVFiVawjxy9l5i9Kqs2BbLk4xMOfu2OnUEwPEID8VCYgi5rfJMlJ0M9D46QBK
	bAerrB6OZs4T+iJZ+ktsOUIMWYvS3SsV5frWTs/Bd+9A7rjhvWMIooDpDA8wahAMOwZ2u7odFDt
	aHDqLWuOZLZXiqXFqw2CwEnb05DMBFIKf0W2bIjXoxwjX/gsNNq+AaShAdnanrcvY3AasT6wr39
	TimFcZoY6AsaetcvwAHnjdkZvhGmqWUUXv1M+eqqo+0/TNjzYx4SdA0s9+1wkWkBs0MvMdhcSOa
	OuBHOuPUs07gCaZK89Tq62G6TDW3MDKd/wG8q1ijZq4vwG7nKCDWLhbRLGlmi2qQyEXPsHZXv4h
	Q0xrV00QCVBj8BXEpNgaSRoh2IhlfeTVprRNoCd/sE3aHKSHJiZTf0+3P9C0CbK75PzfU8YtJQT
	TpLXjnt5Q==
X-Received: by 2002:a05:6830:82cb:b0:7dc:d7e8:cb37 with SMTP id 46e09a7af769-7e6a1e5501dmr9309922a34.21.1780412756211;
        Tue, 02 Jun 2026 08:05:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ccea019ccbsm8520356d6.11.2026.06.02.08.05.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2026 08:05:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84247fed609so1244826b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1780412755; x=1781017555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WQzqqLFwAI8dFmVG5nqDipsKwHwSth8r63Yw8rzeoM=;
        b=KFmAkuwS+41/MGwgCq1/KSj6+01dXw6lVRvvnUXoKutBHVmVgPl8FNQKDdZmw6TP1D
         5urVBIF2UKpuY/n7VLfHzmWZ4cb2+Wu4IIxkUtTF+gf/B7mZ+HaUpLBd1qLVO1qwtqde
         5/2A5R19dBzC0dksW7KcJy3rThuWyVqT2Ahc4=
X-Received: by 2002:a05:6a00:429b:b0:841:edbf:6424 with SMTP id d2e1a72fcca58-84282e8d090mr31445b3a.13.1780412754709;
        Tue, 02 Jun 2026 08:05:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:429b:b0:841:edbf:6424 with SMTP id d2e1a72fcca58-84282e8d090mr31364b3a.13.1780412754192;
        Tue, 02 Jun 2026 08:05:54 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882751sm80895b3a.39.2026.06.02.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:05:53 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xvier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Update create_qp to use QP buffer umem attrs
Date: Tue,  2 Jun 2026 20:26:18 +0530
Message-ID: <20260602145618.21643-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21627-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:selvin.xvier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:mid,broadcom.com:dkim,broadcom.com:from_mime,broadcom.com:email];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5200C62FD59

Use ib_umem_get_attr_or_va() helper to pin QP buffer umems.
Pass attribute ids SQ_BUF_UMEM and RQ_BUF_UMEM for respective
buffers.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c1c4ddc615e2..f389fc0471e6 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1195,7 +1195,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
 				struct bnxt_re_qp_req *ureq,
 				bool fixed_que_attr,
-				struct bnxt_re_dbr_obj *dbr_obj)
+				struct bnxt_re_dbr_obj *dbr_obj,
+				struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1210,8 +1211,9 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq, fixed_que_attr);
 
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get_va(&rdev->ibdev, ureq->qpsva, bytes,
-			      IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_attr_or_va(&rdev->ibdev, attrs,
+				      UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
+				      ureq->qpsva, bytes, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
@@ -1225,8 +1227,9 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 
 	bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get_va(&rdev->ibdev, ureq->qprva, bytes,
-			      IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_attr_or_va(&rdev->ibdev, attrs,
+				      UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM,
+				      ureq->qprva, bytes, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		rc = PTR_ERR(umem);
 		goto fail;
@@ -1718,7 +1721,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct bnxt_re_ucontext *uctx,
 				struct bnxt_re_qp_req *ureq,
 				struct bnxt_re_dbr_obj *dbr_obj,
-				bool fixed_que_attr)
+				bool fixed_que_attr,
+				struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1792,7 +1796,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	if (uctx) { /* This will update DPI and qp_handle */
 		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr,
-					  dbr_obj);
+					  dbr_obj, attrs);
 		if (rc)
 			return rc;
 	}
@@ -1928,9 +1932,9 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
+	struct uverbs_attr_bundle *attrs = NULL;
 	struct bnxt_re_dbr_obj *dbr_obj = NULL;
 	struct bnxt_qplib_dev_attr *dev_attr;
-	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
 	bool fixed_que_attr = false;
 	struct bnxt_re_qp_req ureq;
@@ -1976,7 +1980,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  dbr_obj, fixed_que_attr);
+				  dbr_obj, fixed_que_attr, attrs);
 	if (rc)
 		goto fail;
 
-- 
2.51.2.636.ga99f379adf


