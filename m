Return-Path: <linux-rdma+bounces-18305-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJTtJYp6ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18305-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:12:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F62B9AEE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3B69306412B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D23BD25C;
	Wed, 18 Mar 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ/FlLc8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4E3AA1B8;
	Wed, 18 Mar 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828557; cv=none; b=JoNJ3xE7D5ycG6bAGlZTgOiVrtMYGmfBqbrhCaIMWdjW1z1juGrbTLRzOt17GOG1xUT1k/JrCF78uakKt6XlMJU8QkUPgQlU4ANExDnA0gQfwBvwP3kWrSHdyeuL0QmjMmKviDauhiSNgZ+LbeyGqtjhSSeZ5X/KPKLtADQPKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828557; c=relaxed/simple;
	bh=RwF8uylKoOHKmbOSm14ruGnoPloK28/E7b/HHxSXYyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgCMoHO1K1i0SdyHPyc7F4f90J+KMekA1LPoM9ZEwmEz7EVvmMNTqRHZyvXvTrPchiEApFs0yta2vQ2UbFtIPk+g6CvFcs6EQflexs+gDYLnhnuk2gFSzm3PoafRd08C2VncfReWg29korlWPicdDENHqApiqyDB5GpFtf08ztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ/FlLc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F66DC19421;
	Wed, 18 Mar 2026 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828557;
	bh=RwF8uylKoOHKmbOSm14ruGnoPloK28/E7b/HHxSXYyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZ/FlLc8DkIdZTQS1nK0S9AR5dra3y5QkPD9GxVIkVjaW/IS0Uo9lNDlIPKR7hPIj
	 z7ehTclLErIYIpDJETUayyk3L9auC/TD9EkAQCH+ZAYxOVeOtYQPRwEAZ+c2DYSxzK
	 SyhV3bqx3a9ltzfeOGVdZ/GQsbOA24UQpIBiZ9sNa7SYezPhU9JqAWvtl2ynbozpum
	 QAF5tk7/XT0MtUYEvWjM/cV15pdmbnJAkO0Xmvp8P0/RSyAN4Yvf2RGDXFQvD0SzZg
	 GxiM3BB0GGWrkZStAFPdL31PuB0TXHpCpMZAVqyj8T9OPy0oXVFe48S9saP4P6zvbA
	 qbbGAmsuOmaqA==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 4/4] RDMA/bnxt_re: Clean up uverbs CQ creation path
Date: Wed, 18 Mar 2026 12:08:53 +0200
Message-ID: <20260318-bnxt_re-cq-v1-4-381cb1b5e625@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18305-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A9F62B9AEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

Remove unnecessary checks, user‑visible prints that can flood dmesg,
superfluous assignments, and convoluted goto label.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1aee4fec137eb..59ef56030dbe8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3377,7 +3377,6 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_re_cq_resp resp = {};
 	struct bnxt_re_cq_req req;
-	int cqe = attr->cqe;
 	int rc;
 	u32 active_cqs, entries;
 
@@ -3385,10 +3384,8 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		return -EOPNOTSUPP;
 
 	/* Validate CQ fields */
-	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
-		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
+	if (attr->cqe > dev_attr->max_cq_wqes)
 		return -EINVAL;
-	}
 
 	cq->rdev = rdev;
 	cctx = rdev->chip_ctx;
@@ -3409,15 +3406,13 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		ibcq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 					 entries * sizeof(struct cq_base),
 					 IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(ibcq->umem)) {
-			rc = PTR_ERR(ibcq->umem);
-			goto fail;
-		}
+		if (IS_ERR(ibcq->umem))
+			return PTR_ERR(ibcq->umem);
 	}
 
 	rc = bnxt_re_setup_sginfo(rdev, ibcq->umem, &cq->qplib_cq.sg_info);
 	if (rc)
-		goto fail;
+		return rc;
 
 	cq->qplib_cq.dpi = &uctx->dpi;
 	cq->qplib_cq.max_wqe = entries;
@@ -3426,10 +3421,8 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
-	if (rc) {
-		ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
-		goto fail;
-	}
+	if (rc)
+		return rc;
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
@@ -3442,16 +3435,14 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
 		/* Allocate a page */
 		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!cq->uctx_cq_page) {
-			rc = -ENOMEM;
-			goto fail;
-		}
+		if (!cq->uctx_cq_page)
+			return -ENOMEM;
+
 		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 	}
 	resp.cqid = cq->qplib_cq.id;
 	resp.tail = cq->qplib_cq.hwq.cons;
 	resp.phase = cq->qplib_cq.period;
-	resp.rsvd = 0;
 	rc = ib_respond_udata(udata, resp);
 	if (rc) {
 		bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
@@ -3462,7 +3453,6 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
-fail:
 	return rc;
 }
 

-- 
2.53.0


