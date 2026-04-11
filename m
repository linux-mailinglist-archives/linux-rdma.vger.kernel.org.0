Return-Path: <linux-rdma+bounces-19232-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPVsC8tf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19232-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC33E06EC
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 750EA305E1CA
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9C2DA749;
	Sat, 11 Apr 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="UC09h6CY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F3246774
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918967; cv=none; b=btPaf9GIAUx3bJauSSeGn4M1snh9JC3bk2cGV+Q93Aka8USefa7uA6UD4CvXZiANz+nYbGVv/aIU+qTZTpjSJKGySQW83nOLaIioLHJFIPagtRvc6GhNyLVBwCMABWbyiNoNJERXgcIS1K0CaJYsJiIpAYAlKO57k5xGrbGQet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918967; c=relaxed/simple;
	bh=WTnhDIqGYQPvYXLrvn9dZOvWGPGMJDp68ADqky3BECs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df44Vib/DG2UVDcMrozjL0CjDHVY2kQztXhlcRIuiiFboTB0tJCASVetKj617r3SMJxJnAYVtMvyDBjAzC57JJ9viZquGneaLnt1qjnCYlD2IGmFQFmAtEDNNtLQNSwDE0+0qSZSyT6KPHaOn26snL3d0ymzlZQ29PDSs+cnJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=UC09h6CY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d64313c39so1335852f8f.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918964; x=1776523764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUG81ZDHZ8mK7/38f/vzs4aN31yhCIFHr39B2U4rS7Y=;
        b=UC09h6CYgPcWucMyPy3J28kApwistVZ0l2JH2jeLX5oUDlatypQpEiyKINj/KL2YkP
         ph6hxIoGDf1QuMFa4iDDDXgcJBCxQhlY3fZhKh8q+zYeeg1UVmUZMaEQPOqnlqhjdUUm
         ftkzgbgeJrY2cvNlgu1+1vB9Zc8RB+1bblR6zrbNDUozMnSKWjywsPg8Hhz0wwiIWqDw
         p5vxAkEIB9fIXxDY4R8gdA76MNfEVlbymU3Gt0HaKsjXvt7l+jPDNFhnRoTPMACXSB/9
         BAFusf2Kd7ugFNvolb60kQ4bOhschKigjK8zYNpQVbSonaj3q5gf/MhjyMpd8sboma3a
         T9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918964; x=1776523764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hUG81ZDHZ8mK7/38f/vzs4aN31yhCIFHr39B2U4rS7Y=;
        b=Mrx9FEfVQgjNRE4pOf7SAVXdFyGZSuLsOncLPa6PGq9nmEwEjL/22ll3WtF2cb2MiV
         /MunR54+fN7EeWNTUmri0KOXIotPTgpTTbq0Eku4J0weBmSvvH8ftFs5KGOlpErLzEdM
         6FakXWzf2WMFpteonyzJNzbCZ3WUvwYAOKqKcpAo7D02UKbyLykoXsG4zxkolBIsor9Q
         3A7ce1wr4Dsq1NjyTwxCs3DdoHAWku0nJW4F72w5d/Aj8ZpbnccihMjINBdwsAhQt7YI
         CBuy48vd9VlRXvsI9OW6epxF6vOSLXwxVjjLgIglFd7S6x1E6sGEcSKFGtYdzrRJCrP+
         vCTg==
X-Gm-Message-State: AOJu0YyXekpmm+RC7DDCTXYrjCbspS26DsJBY4Gh8kBnnBOz3+T9plZH
	9uVxx2xz0QJ5dOJ2dXZzzybiPpS+9ztU0T5cbhPJUFpgVNZ5qp2hr3drNTg2oMwXa+Sk8bOkYQ3
	2ao0y
X-Gm-Gg: AeBDievzg8WiO8KrieHmlr1fC7pnF5WT9ntdSG/fM/yfPA4jlhg+k8sIrRiwT9FzCRZ
	lbroUvfIcy95+GIJV0i8rwWCnW5qAS4AzmvN38MFsKsI89bfyWa02APgBRg/PsFCHNE6lt3U5ub
	WaVlGOqzKmoIH57kPSwNWcOO200gI6ORjetxixPz9Rhzzs5tXcp++C9rmIRDAeYRl5Zi9LSH/f8
	lqZoq1pRjZCF1R2an+A3qNMJGxwjW/JBy087ApPoAktl5yUPV236PQR/UyU5F7ZBzt20AZfUcgl
	ErQNuHra/TwA+UFFdU2hMzUBiTT8/AWF3dwkF5VgF3Mh5CPDaDWw06wcLWnmqoOU2OBwyfSMIKy
	DYzfmP2XUAhIAyD5j7MbOAHt4eBvMStxGxJM3uG/upzRv55l5fgim46kwK0N9YGyLqeTBKFCu4D
	iLQJ8ERHaxlpny4GdqlH1WBf6x/dAE5HWeeOTppp8fGjn4PoI1V0Pejg==
X-Received: by 2002:a05:6000:2383:b0:437:75c1:5777 with SMTP id ffacd0b85a97d-43d6424c510mr9832985f8f.16.1775918964356;
        Sat, 11 Apr 2026 07:49:24 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50200sm16532262f8f.29.2026.04.11.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:23 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 05/15] RDMA/mlx5: Use umem_list for user CQ buffer
Date: Sat, 11 Apr 2026 16:49:05 +0200
Message-ID: <20260411144915.114571-6-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19232-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: A2EC33E06EC
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
index a76b7a36087d..bb9ed7caec67 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -727,6 +727,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	int ncont;
 	void *cqc;
 	int err;
+	struct ib_umem *umem;
 	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
@@ -745,31 +746,29 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
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
@@ -780,7 +779,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(cq->ibcq.umem, page_size, pas, 0);
+	mlx5_ib_populate_pas(umem, page_size, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
@@ -851,9 +850,6 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 err_db:
 	mlx5_ib_db_unmap_user(context, &cq->db);
-
-err_umem:
-	/* UMEM is released by ib_core */
 	return err;
 }
 
@@ -1434,7 +1430,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	if (udata) {
 		cq->ibcq.cqe = entries - 1;
-		ib_umem_release(cq->ibcq.umem);
+		ib_umem_list_replace(cq->ibcq.umem_list, UVERBS_BUF_CQ_BUF,
+				     cq->resize_umem);
 		cq->ibcq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 	} else {
-- 
2.53.0


