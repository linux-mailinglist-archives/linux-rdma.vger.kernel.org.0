Return-Path: <linux-rdma+bounces-17378-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPV5OfdvpWlXAgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17378-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7A1D73A6
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F02103019803
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 11:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFCB35FF5B;
	Mon,  2 Mar 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MWmuUKjO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6333B951
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449779; cv=none; b=X6+c4F8c/qBQvdzhD+El0wopSAo3yvI2sR+gxrXNSdD0Qk9vR0fRrjdOrDtYh/t/BzoB6bQV7Tb1MDbFj0krWzPNQPp2h191WZQO953yW62rDAd1RpCGt00DEj2oE26ypidDhEuJv1XtnDfm5HNOBy5z32NTHBeQAGNwLckKUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449779; c=relaxed/simple;
	bh=6VL0S7CkA8FYvPwcLZLMq+pri6L83BRi3WWMRE5UiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHS9BQuHcDY8YT4yv+MSFwAmS46jyAO2U6Rr0jFZeLfibdgu9cJmUKmA5LbxzqpVX9pH5HfEvE+GMmqx78SJBlrdnVS205/vO87Vd4Sw+OWocngfif1kGmMCQIXUX2cP5ad3ZyiLEXHlpsBoWHErogw0JE/EoEJ42ac9MPgzZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MWmuUKjO; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ae46fc8ec1so7923685ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449778; x=1773054578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1n9/grOKpHRRvusBESHod09T0KvRFxEago/f4H9Efc=;
        b=KIrgpGCkzXYvLAssObB/BNrPHLWNsE7FDzn0w41cFBfxUH+u9xeQaiCq3wSyq4wn8f
         CmTKazrIoS7AnPVZ1nCZgOtpjnseTz8/G/6AneHnSve0JSe+LV0s3gYydjIwQ2SizfjN
         ekDoJb2qEChHISXqGee2oROTFETj8I+32WINLreyMgUkRYf6kYWDIAn/mdc5qyx+ZEs8
         JiLJZ8zGLBmva+N2NHEFkKbCUCHC+FJZ9ktXuUZIDQH/yabqB8mlZij/ixDAivhQZ20g
         K9K3aLeEIMoHgS0Co2yohv/vSGibuTIuRHP4VXMyf9rLVvozAb9TAgTSYW8e4uPylW+S
         k8rA==
X-Gm-Message-State: AOJu0YwNQ1s5ZYetxj0xNpex9+HvJVOub5JMp06IIrzDvs+yWirSpjio
	neifamUB3vmVPYbWFyvXGe3Af+GGUOJRxQ1wo4yhwuzsj8CplYMeT25SqmZ1EprxQFm5PvF6Swn
	AKzrN09kWTka9k1g9g/chJEAlPszC96TNNMJ4zacsBp+80iGfpniC1Cl6wFKFuh6FHOD3cZEVH+
	meZzozIytHsqB1R1LGlo7uXRwB6/gQZ2wgwmoFgtGWUZKTjRUDfu+yLF33jweheA1sQHL0cELs5
	+IGyPMp6Q9J2KwFGXbY2uHThHex
X-Gm-Gg: ATEYQzzU686EjCf0TiiblJVQ9ghqg7cQHb4tmWLgdZ1eHqPpHbeuTE8KAYnoO5Q/3oT
	eUP0hPszHC3zmM60XyllHYkLaV7+iK1qBMjpsppJ3OQwEZzZYtLZdd0Dw6fHPcwvFEIIKZr0Wxa
	RgJ+A0bHIl1L0+xKLBuy9fPThYRkhIlXtxvmY6n84rr9Cbpzk9BuVMhqoAW1+5Zu68NjYMdIfbP
	yzv/C0/Y6xVWpaI+1+55EEUpENxcPU5xwiPOV6zX3L5sA0J2hfV59rb4hY78HjaCbNHPskctRfM
	rIKSPGvQwKsfx+a4Q0K1fMOpsyorHTxsjmU+jEIq8dPBonWqAwNxSoUDDuvJho5Gz6uIeFVRzoD
	LWN6k8MCXkneWh/kzNctN+Mdef4hVpd0Q4Kp9r3xQOou7I+8AlKjhRHHIvrBT0U91Zklt32aerZ
	GvW91TMKJuJq5Y5EMCfSKhKNiur96wt4TJeRjnNf4uL02giufPTwBaS3VqykN0MUH9Ww==
X-Received: by 2002:a17:903:1a2d:b0:2ae:4732:285a with SMTP id d9443c01a7336-2ae47322f98mr51592765ad.3.1772449777806;
        Mon, 02 Mar 2026 03:09:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae4779b815sm6179955ad.44.2026.03.02.03.09.37
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:09:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae57228f64so5145755ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772449776; x=1773054576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1n9/grOKpHRRvusBESHod09T0KvRFxEago/f4H9Efc=;
        b=MWmuUKjO7ydJyQgQYKJwlhiirs3pJ/RXWspBEaijH+4Pya3d2H9UKNX9FAftd0G9xv
         dKSiRz7sDBZAXJHE3eYHc7RbuLMwBPlJNYhM4YxXe7Q3nDibptEo7m1VraywaqdKLwYJ
         O/59DpGhBpHQr2L140u2aCn6NrTkb42mtut8s=
X-Received: by 2002:a17:903:b0d:b0:2ae:5598:1db3 with SMTP id d9443c01a7336-2ae55982a32mr18047905ad.53.1772449775653;
        Mon, 02 Mar 2026 03:09:35 -0800 (PST)
X-Received: by 2002:a17:903:b0d:b0:2ae:5598:1db3 with SMTP id d9443c01a7336-2ae55982a32mr18047715ad.53.1772449775217;
        Mon, 02 Mar 2026 03:09:35 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm58391755ad.44.2026.03.02.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:09:34 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v14 5/6] RDMA/bnxt_re: Separate kernel and user CQ creation paths
Date: Mon,  2 Mar 2026 16:30:35 +0530
Message-ID: <20260302110036.36387-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
References: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17378-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 88F7A1D73A6
X-Rspamd-Action: no action

This patch refactors kernel and user CQ creation logic into
two separate code paths. This will be used to support dmabuf
based user CQ memory in the next patch. There is no functional
change in this patch.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 155 +++++++++++++++--------
 1 file changed, 102 insertions(+), 53 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c073729a6d2d..2044d42357ac 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3369,8 +3369,8 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
-int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+static int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+				  struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3379,6 +3379,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_resp resp = {};
+	struct bnxt_re_cq_req req;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3400,37 +3402,23 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	if (udata) {
-		struct bnxt_re_cq_req req;
-
-		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
-		if (rc)
-			goto fail;
+	rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+	if (rc)
+		return rc;
 
-		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-				       entries * sizeof(struct cq_base),
-				       IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(cq->umem)) {
-			rc = PTR_ERR(cq->umem);
-			goto fail;
-		}
-		rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
-		if (rc)
-			goto fail;
+	cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+			       entries * sizeof(struct cq_base),
+			       IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(cq->umem)) {
+		rc = PTR_ERR(cq->umem);
+		return rc;
+	}
 
-		cq->qplib_cq.dpi = &uctx->dpi;
-	} else {
-		cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
-		cq->cql = kzalloc_objs(struct bnxt_qplib_cqe, cq->max_cql);
-		if (!cq->cql) {
-			rc = -ENOMEM;
-			goto fail;
-		}
+	rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
+	if (rc)
+		goto fail;
 
-		cq->qplib_cq.sg_info.pgsize = SZ_4K;
-		cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
-		cq->qplib_cq.dpi = &rdev->dpi_privileged;
-	}
+	cq->qplib_cq.dpi = &uctx->dpi;
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
 	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
@@ -3444,42 +3432,103 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
-
 	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
 	if (active_cqs > rdev->stats.res.cq_watermark)
 		rdev->stats.res.cq_watermark = active_cqs;
 	spin_lock_init(&cq->cq_lock);
 
-	if (udata) {
-		struct bnxt_re_cq_resp resp = {};
-
-		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
-			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
-			/* Allocate a page */
-			cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
-			if (!cq->uctx_cq_page) {
-				rc = -ENOMEM;
-				goto c2fail;
-			}
-			resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
-		}
-		resp.cqid = cq->qplib_cq.id;
-		resp.tail = cq->qplib_cq.hwq.cons;
-		resp.phase = cq->qplib_cq.period;
-		resp.rsvd = 0;
-		rc = ib_respond_udata(udata, resp);
-		if (rc) {
-			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-			goto free_mem;
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
+		/* Allocate a page */
+		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!cq->uctx_cq_page) {
+			rc = -ENOMEM;
+			goto fail;
 		}
+		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
+	}
+	resp.cqid = cq->qplib_cq.id;
+	resp.tail = cq->qplib_cq.hwq.cons;
+	resp.phase = cq->qplib_cq.period;
+	resp.rsvd = 0;
+	rc = ib_respond_udata(udata, resp);
+	if (rc) {
+		bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+		goto free_mem;
 	}
 
 	return 0;
 
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
-c2fail:
+fail:
 	ib_umem_release(cq->umem);
+	return rc;
+}
+
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct bnxt_re_ucontext *uctx =
+		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_chip_ctx *cctx;
+	int cqe = attr->cqe;
+	int rc, entries;
+	u32 active_cqs;
+
+	if (udata)
+		return bnxt_re_create_user_cq(ibcq, attr, attrs);
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	/* Validate CQ fields */
+	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
+		return -EINVAL;
+	}
+
+	cq->rdev = rdev;
+	cctx = rdev->chip_ctx;
+	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
+
+	entries = bnxt_re_init_depth(cqe + 1, uctx);
+	if (entries > dev_attr->max_cq_wqes + 1)
+		entries = dev_attr->max_cq_wqes + 1;
+
+	cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
+	cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
+			  GFP_KERNEL);
+	if (!cq->cql)
+		return -ENOMEM;
+
+	cq->qplib_cq.sg_info.pgsize = SZ_4K;
+	cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
+	cq->qplib_cq.dpi = &rdev->dpi_privileged;
+	cq->qplib_cq.max_wqe = entries;
+	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
+	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
+	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
+
+	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
+		goto fail;
+	}
+
+	cq->ib_cq.cqe = entries;
+	cq->cq_period = cq->qplib_cq.period;
+	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
+	if (active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = active_cqs;
+	spin_lock_init(&cq->cq_lock);
+
+	return 0;
+
 fail:
 	kfree(cq->cql);
 	return rc;
-- 
2.51.2.636.ga99f379adf


