Return-Path: <linux-rdma+bounces-20978-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOoJKs6ADGprigUAu9opvQ
	(envelope-from <linux-rdma+bounces-20978-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C3581635
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA2D30DE57C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413BB3AFD01;
	Tue, 19 May 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CZZgXe2n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF53AFD18
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203412; cv=none; b=CeRp+MAMe8+MymFLSTmqm+h6n4TRV6BTYdVB/Rtzp9ky+R3Nv9KiiP6EXb4LZiAcYjsE8y+TPQ38P5kjgrn6/6AlWoyvFzBXIADa9UKk1auZ+WbaWe5XPKINQ5HuWDA0o/S3L4Ebwtstk+qfwT4T08hmyQ3uNG35+sXj3caGFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203412; c=relaxed/simple;
	bh=wbSax1j94TarfeVhh/jq34XlMBNSZPOosjFjDbIpGz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk0Bv0XfDarUgOdBDdEaISpYVTcDx2MRVcU0PfUJCOSUkIF8KCKQWG69MDRAYUnabEchEkcb+3gPqQ8nH3MbDMu+WtgBa/GVYB6ZM7NM6tl4FYc/Rg1LYyY1QNQYT2wqhGAEJAl1Q1qahK9leB8FL4i6xWOzELyGYFT5pJ21G5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CZZgXe2n; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7dbec19732eso4386287a34.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203408; x=1779808208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpRHlvXpRGKmnpzQ8sKj2I6KDfX3CD9sv1ZBiRR4tdc=;
        b=Vv7gg9Jtom+mBp29WMPTBViu96t1b9CMA1pgMLC+MnNwW6+yR3NrzKsLncnS9qY7tV
         EekJF3Ij/746au+OfiiHrl+nqkaPK4MaCAtA0h8VsxLWk7m/sQUrQf2Ttf+nLM+uWgP1
         gkGuzb0ytv/q9aKb+O4lKuW9pwqS/2zjZCsgLHyFy4cmLNeQ+DsrtWES28BBmV0iXRfm
         N4yB1Zw/oURKITgO0+BQH8IYXtee8LWlHZ80Vx2rHRLJez9nJTSyUe6p5ntkmJgQHoc2
         tdGNJZA25ZDEgSbEzu4rG+F3nG317SdA0LTYRjfzDNXINqs/Ls8Et9hwvbHEPGSrmww/
         rgnw==
X-Gm-Message-State: AOJu0YxZ99LvM6042ZilGIeYWU/bLY9CdEiiYjTdP7CiSdSGI2WwGGoT
	99hRP5cHyHSETZVwyd7zjuT+4CrmFIXww+cGO+v5xuj4M+tYE4ZVu9LGPRZnC6g3yJwBsLvDJpE
	J0veatP8GtrUpueN4hIzGAA5aWOleA3QaVLKdanE1eAXKwslgCV+HXUElJSu810bgvawwNXp50/
	tLFNsjo+EvvexNWR4g+Zh6TduUgMRswB3j/+UeM3B8pPlaa020YhCCQBghWaS3NwuKpdf2kIjZf
	ZUaPYwdq9Ywwa5BhQf1jwbQUP7n
X-Gm-Gg: Acq92OFsfscJSqwxefoJXDl4svlbcDa475q4ZyZt3x1VtHH3+JlXJ27ckDkTVVG/bgz
	4Vpmhzyt8jK90V5FPfxIabmd3VaIgzHmluctWjtGdmL/1b5vjLiEOJzJW6IAF9L8sMx6E5i4F3P
	/0mpsb/F5+9PwN/WxTotuB+dStMQehys8412IWKt+5vV5+wUvsf708rGoVYopMYlUEYzEbDb4Zm
	64OmfAEBZeY4Uag/RRtFHvHJoPLri/JmoxVqSNvrprT/PxcBidwsKyvK7DpbmV2LjLlZgTWDceW
	uwxSqntnPqz4B1LVIWbHrM6bSecEP7GfCO3OQhKOcfOoy4axpT9Ux9PkA/uCW+/aMeV4R3141E3
	Whg8OOXx6QB/SnUIM2naVkW20wnzGaeLRSDOg/O9g2aKBNULFpx8IaYiXQAb8dwsGqL05DFLfn7
	B06NCZL2wvjy4NY3z2SosRARvvDKe2OcNBG9G1XSztvJMktabd43OX1NTHg1WVBGc+Qj10
X-Received: by 2002:a05:6830:6418:b0:7dc:4a43:fb5c with SMTP id 46e09a7af769-7e4ea18219cmr14718504a34.11.1779203407977;
        Tue, 19 May 2026 08:10:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7e55bb86820sm648740a34.5.2026.05.19.08.10.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b7aba0af02so36608655ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203406; x=1779808206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpRHlvXpRGKmnpzQ8sKj2I6KDfX3CD9sv1ZBiRR4tdc=;
        b=CZZgXe2nhJRJYt1EcsCYuDQPqMhCG/J6BUv8F/A7LfMD6KhhlaoB/H5EzkbK1p9uyc
         2Jp3PIibN6aaXiBVH8toP6n7r2aCiYu2Nz5gi9yMUjq8Tu0o+t0lX89Sx96ueHPY7gUw
         LaA0OGZY6/VJfhNmVJ2vAwBkfvRuGZmPJYlqA=
X-Received: by 2002:a17:902:f08d:b0:2bc:dc18:35a2 with SMTP id d9443c01a7336-2bd7e949768mr136730955ad.26.1779203406478;
        Tue, 19 May 2026 08:10:06 -0700 (PDT)
X-Received: by 2002:a17:902:f08d:b0:2bc:dc18:35a2 with SMTP id d9443c01a7336-2bd7e949768mr136730785ad.26.1779203405971;
        Tue, 19 May 2026 08:10:05 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:05 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 3/9] RDMA/bnxt_re: Update sq depth for app allocated QPs
Date: Tue, 19 May 2026 20:30:35 +0530
Message-ID: <20260519150041.7251-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20978-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1A0C3581635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, there's no need to reserve extra slots.
The application accounts for this while allocating the SQ.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c67179160654..fd1ea053d563 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1541,7 +1541,8 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1582,13 +1583,18 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			sq->max_sw_wqe = sq->max_wqe;
 
 	}
-	sq->q_full_delta = diff + 1;
-	/*
-	 * Reserving one slot for Phantom WQE. Application can
-	 * post one extra entry in this case. But allowing this to avoid
-	 * unexpected Queue full condition
-	 */
-	qplqp->sq.q_full_delta -= 1;
+	if (!fixed_que_attr) {
+		sq->q_full_delta = diff + 1;
+		/*
+		 * Reserving one slot for Phantom WQE. Application can
+		 * post one extra entry in this case. But allowing this to avoid
+		 * unexpected Queue full condition
+		 */
+		qplqp->sq.q_full_delta -= 1;
+	} else {
+		sq->q_full_delta = 0;
+	}
+
 	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
 
@@ -1737,7 +1743,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq, fixed_que_attr);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


