Return-Path: <linux-rdma+bounces-18624-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EezA9j8w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18624-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:18:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A40DF327C14
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5660D30F57C8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E0401489;
	Wed, 25 Mar 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZQVtWqUB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F163FFACA
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450861; cv=none; b=H6D1dP3lAKc46fkarxNYSs9Gu81vCFrI8Epf/mJEIEDEItEY4TAKGY5+FhRZJuaSVP5PIFZ8EEvMzIOuq4t2JYL4utrhkuLXQ7bDi9SjRh+smMcQ10CvXS7QLnC0VHgb1YwXkQcBp3/U+x1JXrubnwaZyePyx6PjnfkDfIEaSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450861; c=relaxed/simple;
	bh=jjYZUjC8Yd4I3VJHHurDBpbbqyudeq91aMVZgvPIQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy9aiY1pKeyD7vx0jCq+ORRLC19DfUDxWl1u7Vj8aUAWCavpHpq+hk0/F/YjoTSVTNSeozNF0K8QyWF9iPD/VktBgRrRvvhl5PguyQBfPwAUgU94w7cLUiSopdbEADc4DqXM5u4BAppoQ2nReK0gGpWHMDS52Gr6spcOyIQQPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZQVtWqUB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso47242855e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450858; x=1775055658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVzgPrio7T8NQv/lJbxWfar3wFhwsIx34hYNyLjZRh8=;
        b=ZQVtWqUByw5/FIjNgB4VOonUAF9BGwjCyaUB6zxO0XPL9m6sqROgglutp49aN4ERZJ
         Pfd6kmhwUrbY/gJsPZB+10lM+oZ4vEh2nT4j+3NXT6OflaTFLSdabyvX3Cg/AC0ERguy
         aQTHKZEr/DkBh+xZmp8oR8RsyCZOny1upSIN0WnO2XbLCpo+Wd9DWivMzwSlV7DG6Cyv
         +0O56L4vzCgCmHSt2i8jYpLGEiR+bFLoCy3xGP7ELImAyWZ9GxmVGQkLRKRjissrtztx
         3bdgkyCPgbtTXrwbJXRP5p8yMwS0KxWBKa+0xMRosAYppN5rlQ3+QW4yyVQbL97KZYBk
         KB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450858; x=1775055658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVzgPrio7T8NQv/lJbxWfar3wFhwsIx34hYNyLjZRh8=;
        b=IRc8k2EGQxJYQAr1Bqas71Cv5Bmwfw3fmELv1GlRVp+KNGeb2/HL6utjdn+J7uOd4E
         x5t78Ei0F8Wc3uYCPrA8tiGcq+glbMnbT6NCBKgvyNU+cSr62QjoQyAkbmmwg7gvI//W
         sx5HtHhZOi/Pr2Y1fVkGEJekXbJjgSeFpbGfT9kK7WOanU7IBtfgeWPaUmpvHl8gN3DE
         x85VhOEPP7L80/TDuoLUYqQUNiQVIymAVLriRi5TdOOw3jQ0DMSsaFma+uJvabrISsP2
         BpDCktNLXpxVvbA2f5N2nILH74p9TU9OuAq/HvZgljMWtMcTnz2bZ7KaLKW1kMlr7DHZ
         XlSw==
X-Gm-Message-State: AOJu0YwcNzgdgx1JEC1uHzuM77zaAXLZOzmF5M54qWZ7y7W66TK3WGiQ
	z79kwvl0glbPsgscGoHig8F7Hrr9L9TrX9qaKjFaVlLp5jeNtFvTYj9/tYj4JUScvz6uQXaiPRJ
	oQ99lZAI=
X-Gm-Gg: ATEYQzwjd7XprV8Q34BM2wO5CevORrdpUm1XE5V3DkH9h5K85Wrpmha9pVH1jVuuGzP
	cVw/uri4Af+HbBRCfqyIMq6j1sQ4Al1sXiNCM0HTbqTYW6sYpeHT1ba65hwSH8N9NMhtnnS+W5I
	2DGcArHtrrmp2Gt8FY2bsgPzC/XzdY9MpCpKsuTB+u1zP6HCUms9/NTvnUMZfE9Vbn0k/xaCE4z
	CezokebVKRTlX0+T4hTZ55vSHfRc/SUNO8Cqq7Tz0YPOdlq6N56OmOLXj2kzftI+kLu8HgpKbmp
	ML5B5UD7fklF2UNRom2Q6nrulP7DVp2PX4E0KQbPHkCPjtj4K3zHYPASTipTLbRUja3VpUbeK8N
	0BOywZpOPxxY3VA1eDu/KHL7xBb0C8+rjryVfpzG8HsIxNckZ431UxN5oV34R0u4AOdZmQWmp+R
	9SHu1WLNsK7DCUyg==
X-Received: by 2002:a05:600c:a112:b0:485:5c6e:8a38 with SMTP id 5b1f17b1804b1-487160429dbmr47092285e9.17.1774450858092;
        Wed, 25 Mar 2026 08:00:58 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48717341e34sm22198055e9.19.2026.03.25.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:00:57 -0700 (PDT)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 05/15] RDMA/mlx5: Use umem_list for user CQ buffer
Date: Wed, 25 Mar 2026 16:00:38 +0100
Message-ID: <20260325150048.168341-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18624-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid]
X-Rspamd-Queue-Id: A40DF327C14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Use ib_umem_list_load_or_get() and ib_umem_list_replace() to work
with umem instead of ibcq->umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 35 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 806b4f25af70..9dbced5a474c 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -728,6 +728,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	int ncont;
 	void *cqc;
 	int err;
+	struct ib_umem *umem;
 	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
@@ -749,31 +750,29 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 	*cqe_size = ucmd.cqe_size;
 
-	if (!cq->ibcq.umem)
-		cq->ibcq.umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-					    entries * ucmd.cqe_size,
-					    IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->ibcq.umem))
-		return PTR_ERR(cq->ibcq.umem);
+	umem = ib_umem_list_load_or_get(cq->ibcq.umem_list, UVERBS_BUF_CQ_BUF,
+					&dev->ib_dev, ucmd.buf_addr,
+					entries * ucmd.cqe_size,
+					IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
 
 	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
-		cq->ibcq.umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
 		page_offset, 64, &page_offset_quantized);
-	if (!page_size) {
-		err = -EINVAL;
-		goto err_umem;
-	}
+	if (!page_size)
+		return -EINVAL;
 
 	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
 	if (err)
-		goto err_umem;
+		return err;
 
-	ncont = ib_umem_num_dma_blocks(cq->ibcq.umem, page_size);
+	ncont = ib_umem_num_dma_blocks(umem, page_size);
 	mlx5_ib_dbg(
 		dev,
 		"addr 0x%llx, size %u, npages %zu, page_size %lu, ncont %d\n",
 		ucmd.buf_addr, entries * ucmd.cqe_size,
-		ib_umem_num_pages(cq->ibcq.umem), page_size, ncont);
+		ib_umem_num_pages(umem), page_size, ncont);
 
 	*inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		 MLX5_FLD_SZ_BYTES(create_cq_in, pas[0]) * ncont;
@@ -784,7 +783,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(cq->ibcq.umem, page_size, pas, 0);
+	mlx5_ib_populate_pas(umem, page_size, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
@@ -855,9 +854,6 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 err_db:
 	mlx5_ib_db_unmap_user(context, &cq->db);
-
-err_umem:
-	/* UMEM is released by ib_core */
 	return err;
 }
 
@@ -1438,7 +1434,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	if (udata) {
 		cq->ibcq.cqe = entries - 1;
-		ib_umem_release(cq->ibcq.umem);
+		ib_umem_list_replace(cq->ibcq.umem_list, UVERBS_BUF_CQ_BUF,
+				     cq->resize_umem);
 		cq->ibcq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 	} else {
-- 
2.51.1


