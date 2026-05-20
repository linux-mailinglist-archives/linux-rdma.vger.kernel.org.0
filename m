Return-Path: <linux-rdma+bounces-21042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BsLCUCKDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C058B973
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0E330FA584
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BC3D6CB0;
	Wed, 20 May 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="t8qsPrcx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094B3D667C
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271912; cv=none; b=D6DKEswhasxrXhQQtOUPy5YkBrKxXULX0cck3KCJBsiCx3VsJPAwdqFmXLrZz3kg14bd5zTjGSmWntm/AhYe5gn+IEKz/e+h/AHjZrUIfUNYwilFVcrLjBsIbl+IGNmOQDZp7y8ZJxWzjVJYXnDN9D1i2DQWc4SEiJddfNZCoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271912; c=relaxed/simple;
	bh=K3tZvXlm8fV0NnQr5/KqOegJh9Yp+7romW/p3guEx6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5LQa51QlaZWrsdrioDuCitSirjSkdBML2TuZ+rCliyGZ/LKHvCeFxhEz02HZZ1e0lMWc3BCdAA1r1XM+DtYpUisVyClIQCkqImLIZg16GAzo98VI3P2mSSRbdSj1GN21gKZ/LXG9fC5A17Lp80IehG2tnj6K4A6uubJ9fepLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=t8qsPrcx; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2604685f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271908; x=1779876708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad99mPSgIF44cDAe/NswhytrZ6Z3T19WUqGpLS/h3qY=;
        b=t8qsPrcxhVXE+rFXL9xT8VzzCx7TYe6SaBYfZ3wca3vnZjnL45pMLELMjvP+lPqeT+
         x8xtf2ZwNt2ORb8t5BsuYqH1SAPzRylui1HW99M5dZ5Pg1+yvqtryqrS+SOhz4c19n2M
         wdWcf//WS2hFJLTJgmbPvbmO0dSo9zR50if4zlPRDJaB+ViGbqalsQiZSftoQsGS0+25
         +DjjsmDNjwzBqQtcgPAyXy8lEqwpjDOYyN9dKAwRupvtv4S6OrJCGVtxBrXOJPAEVpw1
         5oHUbISQ2Wz19z2uV12uewFbtWwwidcymwlVf9+PiCjvPtL7Uzilk2XCdkQvF4Rk9wFV
         Imjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271908; x=1779876708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ad99mPSgIF44cDAe/NswhytrZ6Z3T19WUqGpLS/h3qY=;
        b=D/mRu9z86aa/E8CIjFSjvtYbsGtsZt5/QC16alDreWkBg3uE2FPT9iXSxnjF1iYJFi
         QeGSxeXrdHSbqZtS8ECybBFXCyYM/PZXGdxGua4I2FiE8ExrlSblkinM9FuNV8T3uVcV
         UJijM16e+S4pUCXtVv49rzyogS2MEAOuD4buk9m72S/haPw7sHCEZx/XtLnE5zipCJ9r
         NsSBulnicWWfpAvYfz4MCfE3azn8Kdz/HrWIX2mRBDowIOhJoyO3GVA/PgfzGJEEMjSO
         vSVTYU4HP8ziBB1rQqdDufIeWk3WL3EV5w4jAbSwGF+GA0fq108mcM1e+cIbyFf9vcbh
         D8eQ==
X-Gm-Message-State: AOJu0Yw1GAkRZU0XwHlex0ilAo7wxZPL100WYt6Y8KbcoXMwKhTYehF9
	EgLPJn5UaQ37b3xqoibfmdEh8wlrbziDhnA2i6k9nXXTsVYuDEaOg1KnQl/zbz9sdXrWo7wR2FI
	MMNik0py2l8kq
X-Gm-Gg: Acq92OGFeMB2QECzzQjWbY1beXxFNw17okpVZ2fHMbMag0E3YDLYn6q1VWLvbD+VF6t
	HbJ7lJ/Q8EbgwNPZTZcqW6pmj0AZkIW27nNyesHyPtHKhXqWLE8vbyJy9DxngBvI4h2tkyiWYWj
	KxbHK2mTr7ej1jVMDs0zgHrlSmPKgw/U+B06FBadFYSVg9Zc8mKEBEDyi0RKd7OUZVYVjJzrEZa
	+654a8PgD69i1Lw46X7feFWAvKfIPxjaNo+Dp36c45SsetQIQHVDyNFUvKu0GQqi/JpKbOCCR8z
	15XewcQyh1YLm3ZeDw9BboRhRj8wydZkqaIVVyOAjsXgEN2ltITlILizrJTUkUhbfcVF36KRU5T
	tAMr0y8kTxpr9/cYwDpgw936o/0o27FUCQGF7mPDQrXp+k4TYRDL5M6x8BjMF77r6ytOrYKOU3h
	BGm8UmtYXL8nQ+Z9wrzU0THTjY/8YoygTU
X-Received: by 2002:a05:6000:603:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-45e5c5ebd5amr38678122f8f.33.1779271908531;
        Wed, 20 May 2026 03:11:48 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm52155881f8f.17.2026.05.20.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 09/15] RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Wed, 20 May 2026 12:11:23 +0200
Message-ID: <20260520101129.899464-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21042-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: 9D5C058B973
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
index 137240f2dcc6..0974eeaa247e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3342,6 +3342,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
+	ib_umem_release(cq->umem);
 	return ib_respond_empty_udata(udata);
 }
 
@@ -3402,17 +3403,15 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
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
@@ -3422,7 +3421,7 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
 	if (rc)
-		return rc;
+		goto free_umem;
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
@@ -3435,8 +3434,10 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
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
@@ -3444,15 +3445,17 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
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
 
@@ -3516,8 +3519,8 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 
 	cq->qplib_cq.max_wqe = cq->resize_cqe;
 	if (cq->resize_umem) {
-		ib_umem_release(cq->ib_cq.umem);
-		cq->ib_cq.umem = cq->resize_umem;
+		ib_umem_release(cq->umem);
+		cq->umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
 	}
@@ -4113,7 +4116,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	/* User CQ; the only processing we do is to
 	 * complete any pending CQ resize operation.
 	 */
-	if (cq->ib_cq.umem) {
+	if (cq->umem) {
 		if (cq->resize_umem)
 			bnxt_re_resize_cq_complete(cq);
 		return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 08f71a94d55d..af50e769b1b1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -108,6 +108,7 @@ struct bnxt_re_cq {
 	struct bnxt_qplib_cqe	*cql;
 #define MAX_CQL_PER_POLL	1024
 	u32			max_cql;
+	struct ib_umem		*umem;
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
-- 
2.54.0


