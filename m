Return-Path: <linux-rdma+bounces-21389-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMzQIbMlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21389-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FA5E834F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FD1F305FC6D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447344CAFC;
	Wed, 27 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="y1Z7X1Ss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6044CACB
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901827; cv=none; b=msIgsLyj0ax2MqckgynqZD5rRt2qli9Ewn5pAjhXBItvblNB12pwEDSDQmS4BdHP8gj1ZUf2P1TdqL5qukJnf+PMtoFryy3QxNQmrFD3dtUf2MyJPDsFIxjpAd0cfye9OtgUJNZHG+AK2v1xwyoRGFhrOnUDXk+y3VlTfJ08j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901827; c=relaxed/simple;
	bh=tdvNnYGmyYT27XSMmtS4WHrzY64AyhhuS9KvHlVV1os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCLmCFKzX/1CGYnAUaPdVpb7FsoV8GhhKXl4E2bFhQUOl9+NLZyoriTknpht8KPVqyuMjqJ815hY5KRSqM/Ve3+vVE1T88YVt18czavy5Erpw7CEsFi2aDg1SQyQh9l9J9EkUqxZ1iHSa4islBqXYDJrGh6TjFzMZAg20ACjIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=y1Z7X1Ss; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso103272595e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901824; x=1780506624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjjTy5N0o9waymd7oxe/JGUze74rQcZZqAXG8k2+Coo=;
        b=y1Z7X1Ss+Bh43Yh9lr+xT62i+fMmYki+//9i4aukfiVRLSBtLQ02IFv03/EkpiPCcb
         uaZ7117xDY7h07KvQa3rY/tGmJrFUMaxYg5yAWPCRRX8PXg/JpdjKfqc1jtL3Ne0gqKq
         7QQxH+j4EuNZ/6pIK6XV9r75WRnpl9vWc98eF6zHMuBDqtdbO6/LKngG6e1dSmhuICXx
         cWR2SP7K6eYCQb+T3NODIArnjSVTWb0oRT8ZZ7E2Bc/eY09WI7TQub6v+K59jgeCD9C8
         XevMTvpDY8ulujvECWVKPLGXzJZL6/O8PRHnIRt11s5emOD0gyEPAT7rx8f/SDSFbZW0
         +djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901824; x=1780506624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WjjTy5N0o9waymd7oxe/JGUze74rQcZZqAXG8k2+Coo=;
        b=W2toEKhOnRMs96a2ELF4Zv8+b0aMMsDQf/l14d0jFRjCD0E/TQL5g6E+N3cwTb1C2P
         z1kBGiyyuU7I4WsmdQut+77dAgbHmll8rhOBLt1e5sEKELOig4OkU0Rg44ZxhLzXn+hx
         NSqqapJWjzeeCGjM51XS1zkf6pCGMtjvcqeqfDPrMcGDafDKBdLv7QCDohi8Ed5qZNpo
         Q55A27QqhIW192UG5EQlatV73ECEdyPFSbP1C+UDU3Vow47DwDsuRvbcbW2/IKcpl9JA
         ASraw1Czgy6++a9sATRChUUhxva7+Q0mkGwEYlq7qH+sE5ZIcpcIaYnxuAjDiV5Sulfn
         eASQ==
X-Gm-Message-State: AOJu0Yz/6N/C9PcQPt71ZqzgIoacv6TCRYawSH7tE7Se5yFjKZuVUCdg
	+S99wpOTerXIG3CcdYNRsB3nKPYJLcJ9LeNXMh2w3+rNM+f80Ly/awJuTTIiec96K6m5c0JNm7O
	FOq5QASDP4bkl
X-Gm-Gg: Acq92OHga/CTG8h5vGslqLEbsHEB+o0VkwqEtVbfk0cRCT1R7DsMgy/pai+5EwR6lCj
	v49GA0Umm9lgbXYrFLWoeTUwdo4PBuJhTbb5BYLOAP3rRBnS3p2NdkpEVBoifjBMqM3788hOWgt
	H1RMllalo5BC6ihelxHgNyseb3I34AIJfXckFtb875S0X9XC7CykW9SGlDsD30LzU1gY5bLqSYO
	IIphfwjHYDsulKWYJSA37JYBd76d/oP/66h8pE8iyL7tRYC+C779J5jerGRtkI1Kf5DOlkvRib9
	YRyr1dSlYFxDYFlqfXGjd0MWN6AE9KZhEYLiHC2RweE+fPiJydS9gEJyAm90VVg7l2SoxLN1ysB
	3qoy7C0v/8wMOt4N+7xhPpOxK65asDGMA3tN2zSCjbxuOPCMbU4NFc2AZBjSJupPNVhUherrpER
	1msSArQX7mn/4kphWWLZWeR/X5JpF2kWkmIqTY1bi2hg==
X-Received: by 2002:a05:600c:3d96:b0:490:5429:1513 with SMTP id 5b1f17b1804b1-49054291bbamr349012455e9.6.1779901823861;
        Wed, 27 May 2026 10:10:23 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b2a2asm7484217f8f.28.2026.05.27.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v8 09/15] RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Wed, 27 May 2026 19:09:42 +0200
Message-ID: <20260527170948.2017439-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21389-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: 183FA5E834F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf_or_va() and take
ownership of the umem in the driver. Apply the same ownership
pattern to the resize path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- used ib_umem_get_cq_buf_or_va() to get umem, stored in new
  struct bnxt_re_cq field cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to bnxt_re_destroy_cq() and the resize error path
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 35 +++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5e8fa7bf99cb..c1c4ddc615e2 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3455,6 +3455,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
+	ib_umem_release(cq->umem);
 	return ib_respond_empty_udata(udata);
 }
 
@@ -3495,17 +3496,15 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		entries = bnxt_re_init_depth(attr->cqe + 1,
 					     dev_attr->max_cq_wqes + 1, uctx);
 
-	if (!ibcq->umem) {
-		ibcq->umem = ib_umem_get_va(&rdev->ibdev, req.cq_va,
+	cq->umem = ib_umem_get_cq_buf_or_va(&rdev->ibdev, attrs, req.cq_va,
 					    entries * sizeof(struct cq_base),
 					    IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(ibcq->umem))
-			return PTR_ERR(ibcq->umem);
-	}
+	if (IS_ERR(cq->umem))
+		return PTR_ERR(cq->umem);
 
-	rc = bnxt_re_setup_sginfo(rdev, ibcq->umem, &cq->qplib_cq.sg_info);
+	rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
 	if (rc)
-		return rc;
+		goto free_umem;
 
 	cq->qplib_cq.dpi = &uctx->dpi;
 	cq->qplib_cq.max_wqe = entries;
@@ -3515,7 +3514,7 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
 	if (rc)
-		return rc;
+		goto free_umem;
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
@@ -3528,8 +3527,10 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
 		/* Allocate a page */
 		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!cq->uctx_cq_page)
-			return -ENOMEM;
+		if (!cq->uctx_cq_page) {
+			rc = -ENOMEM;
+			goto destroy_cq;
+		}
 
 		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 	}
@@ -3537,15 +3538,17 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	resp.tail = cq->qplib_cq.hwq.cons;
 	resp.phase = cq->qplib_cq.period;
 	rc = ib_respond_udata(udata, resp);
-	if (rc) {
-		bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (rc)
 		goto free_mem;
-	}
 
 	return 0;
 
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
+destroy_cq:
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+free_umem:
+	ib_umem_release(cq->umem);
 	return rc;
 }
 
@@ -3609,8 +3612,8 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 
 	cq->qplib_cq.max_wqe = cq->resize_cqe;
 	if (cq->resize_umem) {
-		ib_umem_release(cq->ib_cq.umem);
-		cq->ib_cq.umem = cq->resize_umem;
+		ib_umem_release(cq->umem);
+		cq->umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
 	}
@@ -4206,7 +4209,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	/* User CQ; the only processing we do is to
 	 * complete any pending CQ resize operation.
 	 */
-	if (cq->ib_cq.umem) {
+	if (cq->umem) {
 		if (cq->resize_umem)
 			bnxt_re_resize_cq_complete(cq);
 		return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index ebc393e6da4f..4d6d1259a795 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -109,6 +109,7 @@ struct bnxt_re_cq {
 	struct bnxt_qplib_cqe	*cql;
 #define MAX_CQL_PER_POLL	1024
 	u32			max_cql;
+	struct ib_umem		*umem;
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
-- 
2.54.0


