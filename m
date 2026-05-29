Return-Path: <linux-rdma+bounces-21507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FEICGCZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F0603148
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED0F030DF4AB
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A8320A00;
	Fri, 29 May 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="H+2p43ic"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104672D97BB
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062221; cv=none; b=cA28+SNq3BXNv6WOzACUSnshDYfNeMfogrMtp4ByAXALY5knbX5cwZDGcL7jubBHZXP7J4axKyI8Kb+Mb54243GTMnoCaJPjqF5ktXnLD2Rpm0HjfG4UhxuBfRbL14DyDvinGlCxdLwCjTbMqU4lzUTytu99R6n3ix+3QVdwFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062221; c=relaxed/simple;
	bh=PzFBEoeHLd+kNgCq0+n7Gh7mrWuy+EJi9mzQpqJKu2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5KSp+5YVaSJm59j9GL2g6IMADRVMFW02EjTuCZ3JpbnC/NuI7xcx84XhX7HxK0qEmS0SIb1leeGanpzO7pA1AighTMo4AGopdbTysN5iVdjlFvuTHkjpD4wc3Gv/fHWVG2+E5B/yduZiPySCpDrA1vn+jB7A/L5b3kqqXrkV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=H+2p43ic; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef1198766so450263f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062218; x=1780667018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=H+2p43icT1hrQNMUgGyZR3LPBiPL6T99euGG2XYxQJSX4s+/+6snKFugnK2vQphFQy
         PLky6+bMN9lf1Teuw9DEXUTFWaL6c9qvfiWzdvv2offcFLSlPf2v9IPM7LYuBueBu7T+
         h5flbODXsdwL3JXbZXLfRja+83r4j1DDA8QIDW/eMettluVX/j4jzuLXJ2mjlqp7PYJm
         PUTGQ7/VfGEXD99z+jwd1JbQxD0hzdxQKaL084Q+EQMX7gObFUAZ/IIYZHgWEwOX1x7l
         0vYfLaKSliZjEkSTCfZnZh+QJRcO6AHvCvnkg0FfSEiiqOp7mp4lN34Z82G3c7G7JaSi
         esCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062218; x=1780667018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=npPUOnDPUcV2h70taEIQWOjraa8EpEdlrRLlGN/qt77AAJBm/npqJE/oZrQi1mGiVH
         EngfDzagdn/YNQK5SkqF40xNocWb/mmoD53HvXWWn9PCN5iOTO/1N38JiKJiX+wp8wOs
         BSJpZWJYEvYeVIflaJcP/kcIgQGVzpiy8QKNh90ZxSEW+MMb0GjmM5oTztvl+sudofmE
         AJlcSnjA+56wnYnhxXvWqKbqq2y5HYRjOStYa0YeBQj+c16nTnL9/1l+KADfQMzj3s0l
         r2yz8cpX8EzGS6rl5GLiXF6NzR+o3rRBPFpuID5pceeA8s3LF1SJxjupc3PvUQgAE+Wk
         cwLw==
X-Gm-Message-State: AOJu0YwGR+kziiNUyzyR+RWEC5XZCskT2ig8rGYmCjoRmZfeO0qZuAlq
	LOI+YDGmND8TzZT8YU62S5nHgr4bFO6wPmIesnrf+LR81QpQvW3g1x5HbWG7tznp7Z1CvpB38sn
	jYlLb/KvegQ==
X-Gm-Gg: Acq92OHWeligwQimUR+ANfR+VC+JoX8LPGOr2roGyGcaOiysaN9+ctdgUR3b9v8Mv40
	5shERylfMk8QFiMP8T2uBP5fGnyPh6PyFksybo5/JZiGFikmgHJO2/sVPjNaPr4gSYIZ86EZla3
	0l1akfKPBD6qEAYm+cXXhVyAeH75VIgu56zv7iruFPJFFe8lR13JA7sxetp1bhWRq9w7DEB2h0E
	i8gC1zfW8GDFkRBzMJ69nSJMsgiDXpCS5iuv+q5Hsl9CJYRE319JppEcJWUR1Muf37/IpHJkheA
	QX4DroDYK095FQJGJahgrLkuKM0iBVNIoVz4+PrnDAVNdYTqhKIt8DS5e9X3S9P4kOZgOfUEBJg
	EL8U9v9kOiAPYkykoh7FgpgTZ35+PqEPRlgEF3keXUt5jneA33nrwYyjwO1TalOyZjj2KAobdrD
	ZlilPf9ve+abYXst5I8cy1dYExr+OTA7lmUkpMFgzL7mE=
X-Received: by 2002:a05:6000:4b1a:b0:455:564e:3a28 with SMTP id ffacd0b85a97d-45ef137a0bamr4456802f8f.17.1780062218432;
        Fri, 29 May 2026 06:43:38 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm4736250f8f.32.2026.05.29.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:38 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 07/16] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Fri, 29 May 2026 15:43:03 +0200
Message-ID: <20260529134312.2836341-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21507-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,nvidia.com:server fail,resnulli.us:server fail,resnulli-us.20251104.gappssmtp.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 701F0603148
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver. Fall back to the
existing kernel-DMA path on NULL.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- used ib_umem_get_cq_buf() to get umem, stored in efa_cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to efa_destroy_cq() and new error path
---
 drivers/infiniband/hw/efa/efa_verbs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8d97a837fa6a..434d60235945 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1049,6 +1049,7 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
+	ib_umem_release(cq->umem);
 	return 0;
 }
 
@@ -1101,6 +1102,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1149,26 +1151,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (ibcq->umem) {
-		if (ibcq->umem->length < cq->size) {
-			ibdev_dbg(&dev->ibdev, "External memory too small\n");
-			err = -EINVAL;
-			goto err_out;
-		}
+	umem = ib_umem_get_cq_buf(ibcq->device, attrs, cq->size,
+				  IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		goto err_out;
+	}
+
+	cq->umem = umem;
 
-		if (!ib_umem_is_contiguous(ibcq->umem)) {
+	if (umem) {
+		if (!ib_umem_is_contiguous(umem)) {
 			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
 			err = -EINVAL;
-			goto err_out;
+			goto err_release_umem;
 		}
 
-		cq->dma_addr = ib_umem_start_dma_addr(ibcq->umem);
+		cq->dma_addr = ib_umem_start_dma_addr(umem);
 	} else {
 		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
 						 DMA_FROM_DEVICE);
 		if (!cq->cpu_addr) {
 			err = -ENOMEM;
-			goto err_out;
+			goto err_release_umem;
 		}
 	}
 
@@ -1235,6 +1240,8 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
+err_release_umem:
+	ib_umem_release(cq->umem);
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
 	return err;
-- 
2.54.0


