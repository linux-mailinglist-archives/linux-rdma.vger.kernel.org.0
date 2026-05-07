Return-Path: <linux-rdma+bounces-20151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJXFOFSL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838EB4E8889
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F44303CE8C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4973F0AA6;
	Thu,  7 May 2026 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Lt6DlOHQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C573AB275
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158367; cv=none; b=u62/TiD/XkLhhlw9zYT/aWGdb6o0efTsCq+NxxMhGKcLYYB12CMZhbbjhh+t9ByySLlDPhWaWD/HNbrU3nUDYqFqdX8zzw1m8NyMbJL1YIyIgArsTYr9XmA0Q4Gu8vlm1sgfrbuOCOT+A+7pzJmzYgEduvOjjPs/bFTYpm+e6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158367; c=relaxed/simple;
	bh=uTAw84E7a+snxAbHlhLTE7y+lrRD9XqP1VQonwEdePE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cps7G+y2xtk0AJlkFBAnE4Y85bMfA3lif9R9EjIc8mUHvd6LK05/+jfsZTpYDw3YnYYvqtHM1CZkkGtoKZ5+/HVs6yr5atgJxxfVaTz+rfciYP75MSaWsS/Ddhn5+20GJXxDK/3kGokvxdYmOJ9tpSG1jNP1yfxsoI/9Tnz+gOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Lt6DlOHQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44da2de25f3so612458f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158363; x=1778763163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPhkl6wvMZNJo/NUgE40vkqABeZNb/Pdg//leLLeIPM=;
        b=Lt6DlOHQnUj3waLXXzBZrh1mO3Nzh5mmgnXK3Y3qPQfskH35oCO0AcbhtY2w6fJnXC
         52gAMaNKGNxwo5W5rWrE416OB69ZtZkBhZP/WMRYbfP39+e8sNi4hFjUUcvoJgmRCRch
         5XwZtcAri/mqmYvJb++bFTeyAzdI/7rRF65zqiYrWHBN7t44UM2+L1zqSAxB5YR/oUWP
         m1Q2nSAlq04hDZUknaGOJzCviiswGi185bo6fMsLnm7gMQBmNfVDO5UiTWXgwu2C8GAT
         hOyiog3KfO//njUKW9x+1Z4LhYjFqfZVQnGMR1O2Y9Bz10UKoTDEgl9ZHNQAvvDJ+0lL
         CuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158363; x=1778763163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPhkl6wvMZNJo/NUgE40vkqABeZNb/Pdg//leLLeIPM=;
        b=BHSY7YEHD5NNMiiSSFsMAdsfNEB1noT2KK7sbd3ZEDHdPfg20nk6Qbjy28bSxyZS6q
         zYgNmzyk6eoxCYBoOnrbZWjLIIK4vTPnr18YxjF73lgzQ84lGXEChLW1v6TsUnlzIWjt
         8aI/28G6HPhIi42myXsG2iDdQgyFipL9bpGyf7Mj0qHgkRkkGgH13ZuMCWE6TyQswGS+
         DcezzXAjURFqRCJJGCrv2VAbh+wLNiePlIlLEtutzT4ivxMaoFZfBiE/DQ81fGi9zqhi
         1Sk1pYjC2pkeo94aJ2S7WGjJ8S3t/BRBMWy6diFGy5ZEd1nxWL0AiCKPZ0+gDTWCay0Q
         qtzA==
X-Gm-Message-State: AOJu0YzBkEH1orkKViEUtBDTHKxUaljokJPYMiJ2rNp8PTJEo+44kiyV
	M13cDL+rUsP0YCEwXvgUqD5CwtCLS1fR0G0uTLABJasEI3+4cp1FASyHt/kSJz4wZ9VU9jU+MMk
	eckS0
X-Gm-Gg: AeBDieutCRh293frTVtYG41jjIxFH1UeV1YMM93XZRnua3eekRbAMDdlrzkf6bMPHRq
	6wJJyiEXVYMShXw2L8P8SC62j8/SpO2zXllbfhFAyi5SU13CKPAyQzvAAM4nj6CP7I/BNgPQx9q
	qi7quMJxNavkq54g0ti89TSdCPVw1VDEswGkOj7oEBNPT5fjF66IhkgCIV/j8YoAMqLK2CwKnV+
	vWvc/79fT0PO0/PU+n4P6QuzAcBE3upyy5iCq1xwCU0StZpgUh/NnU8ievPh71pjGjCXRDKSQjC
	ANroGrmZ6k/nz1zb5IGgvxIdVodf2voxRf3/q70v5ZODY5gI6AXbL0Wt4NHXGtbchCHkcnn0ufw
	/M6li8ebkyWyseHORaoejnEBVmVYG0FliU6+tpBGtdvXMU3BJjcohXJOaXocJ6APTrHDJnbn4Ge
	hQKHBY4g7B7Z6uka0P2BMaSlIyBmjoy9jz2Q5PzE4CT8v9PfZsNuAT+JZa
X-Received: by 2002:a05:600c:a305:b0:489:2005:b36e with SMTP id 5b1f17b1804b1-48e51f444e4mr84697105e9.19.1778158363388;
        Thu, 07 May 2026 05:52:43 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aca14sm109611495e9.7.2026.05.07.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:43 -0700 (PDT)
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
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v4 10/16] RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Thu,  7 May 2026 14:52:25 +0200
Message-ID: <20260507125231.2950751-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 838EB4E8889
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20151-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf_or_va() and take
ownership of the umem in the driver. Apply the same ownership
pattern to the resize path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
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
index 1f626b7c6af2..fa7da02b3704 100644
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
+	cq->umem = ib_umem_get_cq_buf_or_va(&rdev->ibdev, udata, req.cq_va,
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
2.53.0


