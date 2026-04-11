Return-Path: <linux-rdma+bounces-19235-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AxGCtZf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19235-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1203E0706
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365CB30674DC
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CA386553;
	Sat, 11 Apr 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="v1jmUrqS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2E262FFC
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918971; cv=none; b=h7aNWz0890o2xYE/u9ZP8ai8bkoZrY+0/wvsV1DpH+O5587PL7bIHGunaeMBbHtDTgYonlIfCFTclaH73TvahSISws66WbkB4u2Wxgz73nOoALVfmKSolz+0ZfXvMIFxKbh2UQRt9K+qbG9d32R8nbRSfbS3RHfjMe59sw+8fQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918971; c=relaxed/simple;
	bh=FrW51n0u11rsBLtM4Whya/4eWTmlPYA7z8WCu3QgM60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmv/PMs6falxNGe0QBghFMHGIuTslSACtsJfV/Q3usUnIfItML4VTRVUOJuKkTXLGMeFreyntCrpLlHD6U51upAfOM9BA4Sg5v0byM+uH3Hmqk7dkOald4/6HgmlAQ8NLqGaB+7kWwzl5dLbzsVnNw4QmXAQXoIRTFbHfTVnEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=v1jmUrqS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d6d947fe4so340520f8f.1
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918969; x=1776523769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NoPtBdnkAUCT76i/NF5O85C6QrwGDZT0E3gMn1nPvM=;
        b=v1jmUrqSRvjCyFaPeXVUw/nPSfgRp2BDkZI230bbnJ3e3/T0FAuw9roC8LYcPH2ysf
         ZSttg6Fta/fiHjcaZfT+zF09zBG0t52M0ZXhHbz/fOnI6oLiNtTbGQsFYSL+3FuFkV3R
         wASVdnZL4Up6V8HnuPmfHCZSmsxkd06eFtRaaODACHm4LYBQMl6wVl8qja/PdlxbZqbw
         qvtLmON1ZFQsTHqk/5N/U2ONOMV8OwiuAEMU+3wJGtLRbKCdqCsT5I+UFr7VE6UHm4PT
         7EEi7+vhNCGYQz1UIaBgfokVECk3E7i5U5+HSKMsYzQUTrMEjf1A03AX7/WJy8EVUR6x
         Q8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918969; x=1776523769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NoPtBdnkAUCT76i/NF5O85C6QrwGDZT0E3gMn1nPvM=;
        b=p7jppwZHkg+XmLeyY8DA2xhUDUhna0IpjCsWfQ+Djyn9LPY+unG3+AIwZtY0TmLdhw
         KApShMgXhoM7BZzdV4FUwPRjnHIjLsCGQUEWX1z8hJzHrnhSo1ddRi/TYK+TOq3kiEwR
         koFuXeQzvLj057KgL+YkwSyOWm6+HuFH432F/bz0JWjVGt7RWy8AamfG10K6OH2iW1nB
         3zfzsUsJi1ONCTL4XATn9NDd9PFWg4gmoFr2/9aNaafUAxsWYVVeJUfeZukRSGXnaw72
         pmD5RbfB1LSKfTW+eC6Tv/IaMVka7mo+PB0BlM+OVlwMiTWNYz1X4Ab8YcmKR1D2yk9G
         Fplg==
X-Gm-Message-State: AOJu0YzeVH9MWRnEZPFhy2bYTQ0UgqR56hdQa+V5TBg7G41T48zPmqWj
	pE4xfy9WrNDUnhN22aqmpprHit7R4ZtNDb1yiIVddLOif/dcWWpHlvf+hchwiGLhC7q3DqlhmOJ
	eDGq5
X-Gm-Gg: AeBDietdYmwuKVLfsK21uJzMRuJBh+p6nloN16vKcbDohUjlOugFjH5kXJ8OLHUU+90
	kckrnWdcA3sqWFm/kVvHHqHNn3olGpsnCKf22lMM0mf44hOXRWVHPjMEm/5weUfZUMniz2LoMrV
	u68j22hkEVGssMHs8YvLal4GGwPpTf2p25Yd4khnuUyy1b/errz4phTQ1EmY2mszSkdrT52cv8A
	nXzyNn7FIJeGisDrtb6Uf0zZTfoH2PRsuL7oj/v3Kkj69W2W+ypTKAoB2Jn5eLKNn7yNG8igmpi
	suk2pnMDzWVJ1XsbrD89VUd0YSbkIQd7k+iTnO8zI9wt+hi2WZi328pcUI/locX61wjo17q7fbw
	lj6rh8B4N1F68DhNl2pbwrI61aH2+P9IafIcs8UlyONOaAeTNd6OhSR7nk/GZwUFHKVf97Vt1yV
	gZT1fcXv1grnuUkD7L/wqKOdQIeepnh2Xv77d0T4GV12E=
X-Received: by 2002:a05:6000:2489:b0:43b:4aba:8f52 with SMTP id ffacd0b85a97d-43d642c5050mr10551479f8f.32.1775918968635;
        Sat, 11 Apr 2026 07:49:28 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm17621984f8f.27.2026.04.11.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:28 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 08/15] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Sat, 11 Apr 2026 16:49:08 +0200
Message-ID: <20260411144915.114571-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19235-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: AE1203E0706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Now that all drivers use umem_list for CQ buffer management, the
legacy umem field in struct ib_cq is no longer needed. Remove it
along with the associated ib_umem_release_non_listed() calls in
error and destroy paths, as buffer lifetime is fully managed through
ib_umem_list_release().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 1 -
 drivers/infiniband/core/uverbs_std_types_cq.c | 9 ---------
 drivers/infiniband/core/verbs.c               | 5 ++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 1 -
 drivers/infiniband/hw/mlx4/cq.c               | 1 -
 drivers/infiniband/hw/mlx5/cq.c               | 1 -
 include/rdma/ib_verbs.h                       | 2 --
 7 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 77874834108b..60fafa1fb7b4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1088,7 +1088,6 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_free:
-	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_list_release:
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index f87cd11470fc..c165ff5446f6 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -209,11 +209,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
-	/*
-	 * If UMEM is not provided here, legacy drivers will set it during
-	 * CQ creation based on their internal udata.
-	 */
-	cq->umem = umem;
 	cq->umem_list     = umem_list;
 	atomic_set(&cq->usecnt, 0);
 
@@ -227,9 +222,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_free;
 
-	/* Check that driver didn't overrun existing umem */
-	WARN_ON(umem && cq->umem != umem);
-
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_add(&cq->res);
@@ -240,7 +232,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
-	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_umem_list:
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index ed163fc56ef8..35700bad8310 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2224,9 +2224,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	}
 	/*
 	 * We are in kernel verbs flow and drivers are not allowed
-	 * to set umem or umem_list pointers, they need to stay NULL.
+	 * to set umem_list pointer, it needs to stay NULL.
 	 */
-	WARN_ON_ONCE(cq->umem || cq->umem_list);
+	WARN_ON_ONCE(cq->umem_list);
 
 	rdma_restrack_add(&cq->res);
 	return cq;
@@ -2259,7 +2259,6 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_del(&cq->res);
 	kfree(cq);
 	ib_umem_list_release(umem_list);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5c6fc81fad6a..e63780c78781 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3518,7 +3518,6 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 	if (cq->resize_umem) {
 		ib_umem_list_replace(cq->ib_cq.umem_list, UVERBS_BUF_CQ_BUF,
 				     cq->resize_umem);
-		cq->ib_cq.umem = cq->resize_umem;
 		cq->qplib_cq.sg_info.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index f6ef85cc37a1..3217c5faf0d5 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -482,7 +482,6 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		cq->ibcq.cqe = cq->resize_buf->cqe;
 		ib_umem_list_replace(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
 				     cq->resize_umem);
-		cq->ibcq.umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
 		cq->resize_buf = NULL;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index bb9ed7caec67..6118deb5e6dc 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1432,7 +1432,6 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		cq->ibcq.cqe = entries - 1;
 		ib_umem_list_replace(cq->ibcq.umem_list, UVERBS_BUF_CQ_BUF,
 				     cq->resize_umem);
-		cq->ibcq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 	} else {
 		struct mlx5_ib_cq_buf tbuf;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index dd6c0d68497d..cf7fa69415a1 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1738,8 +1738,6 @@ struct ib_cq {
 	u8 interrupt:1;
 	u8 shared:1;
 	unsigned int comp_vector;
-	struct ib_umem *umem;
-
 	struct ib_umem_list    *umem_list;
 
 	/*
-- 
2.53.0


