Return-Path: <linux-rdma+bounces-19923-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG59AxSm+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19923-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:58:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F14BE399
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE06C300A337
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C93DE424;
	Mon,  4 May 2026 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="XRoWQ42u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753773DC4D5
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903075; cv=none; b=kxUEUcancHM06a6YhihazPQ1nNv+Dx2UUyUiypfWXp6j+qCA4T9iuRTGZ1SJ8DJnlQk4h1LLQK1Gh3G50oljYNSC5/CUnTbKew+kT4Rb5//0oJX5FFjqQvMZOu+B1ylKasgVkd6v5sIgmA1FgXSNOix7wsZ3GRioKNMCc9shwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903075; c=relaxed/simple;
	bh=uTAw84E7a+snxAbHlhLTE7y+lrRD9XqP1VQonwEdePE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf+Y+vHOvncRQg16DQTTajHGGjqbzhhL0PruVT4RHoxyYnSwlb7XPA+X4QTGjutGpk6AbVxjry8NCzpoAWDMmlSwVzadrnuDxH0Aoskq4DqAq4Hth1ikixCjy7YJBm+YTsZwJuuaktszl21sTkPD+OX44rxwCv1pumZLz2XC/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=XRoWQ42u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso21497585e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903072; x=1778507872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPhkl6wvMZNJo/NUgE40vkqABeZNb/Pdg//leLLeIPM=;
        b=XRoWQ42uA5pZLrvfhE+T3bZohTU3PGpGtQAupyvM0NXYK8ZHQ41j4cCnJmlmyd4sNW
         rqnWp+9Z8DMm9G9gZ/Ht8TtTxS8/3FiGjZMetasJ88Zbkctc9nWM9w4LvF+IhoIYgVvm
         NhEuUgVo7pFfPKcpE43G2N3eXeZUSFi+tTao7jB0Y6cnDAVoz0k0729wuJqWSdyr4AiK
         PScTQ4NVEh+Sac12dOzDPkpP/vEIPRDgCg7Bz4GLyhh2ZRMa6ifnY7B2q7xygaLCsTwy
         FhML0WOyB7NchUlDXC5I53Hp6mPlzUrjeWxtp1W6ER/1ngXpMVESfbyO7ElSO8W4vZKN
         Kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903072; x=1778507872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPhkl6wvMZNJo/NUgE40vkqABeZNb/Pdg//leLLeIPM=;
        b=cqXRuHC7gNSasgM0fRjiF9S/zj2VPHSNCgtVl3PRAj4DhPeXxyhruy6NnErDcJ6wIk
         gx6QaU40liHp708HJxel9sPbwDfZrO5fKz8XlW5pE9L825TXeIAxPGzjQZuNggqD4R9D
         7d4YE/avOANJ2VkBfrBpDyB5FZ/cS+g9jJ2lhEuB0YeIewPcSG0VoI+x0uh2y0X4FAR+
         WCPLzwtWtULXKCfg4+IzzzlAT1276V1oXVRkU4SgFacfGDifWvuvt8aW7KftDxqra1MW
         D7J/JNOhD2R8x4ykOPey4Bw1viQzG2N3G+pB3/0b87FKwfBiYk7bRzh002vs69bfxjL2
         1GvA==
X-Gm-Message-State: AOJu0YwcJu4zOrMe64ful9qQkM3NTE5qJtNvGC+fTZXFKV4+P1AsXo3s
	oWInUWDEhTkpKgxi5s3r6Ysev+95NXeaRpoteL9QgKxXhRUfg4xmzXavd3gaz/bb0NXENR2LcnH
	7O9M6ieM=
X-Gm-Gg: AeBDietLa7fMXsaEan5CrlNpueQ1YGJLamp7/MiMderrTKO/rGZpS/QQm5tb7MmC/WK
	29BNXqpL58RQJV/ezULeQ41Qg8NkAJS8jmwY4ACYfDgX3RfOvFI8VUB1gX4dDZbh5UBlppJfo0m
	XhBE9YCuCIDWV8OgxL+PZ/PbBhPEgO8kB5FIkeOq/IL34vulCliFQFi4z6dai9MrostK0nRtDgD
	hO09oSsofOmcE0VIuAWNUReNZzH4zFe7nMJIRDzIpzB50F5uKJ/pfQkqWQO2/bCpTW7kteeAdsT
	mLomxvrNxOHHjxD1CzjeBBqTd1O55ITsiQ3fTrKgHlaWqo1vO3qZI4aYQ/P+0NvxL1NZ9HST9Mj
	N49qQPNan17beHyV9RnI/Uk77gyH99iLVPp2dOksA8FOoBe7XUgIEiRe1YIekkicD2PPOQuBnzP
	SczFgYYSNChlq3LjocO0oGqXbB
X-Received: by 2002:a05:600c:a111:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-48a988c0f8bmr111526055e9.28.1777903071889;
        Mon, 04 May 2026 06:57:51 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm584775635e9.2.2026.05.04.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:51 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 10/17] RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Mon,  4 May 2026 15:57:24 +0200
Message-ID: <20260504135731.2345383-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 513F14BE399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19923-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]

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


