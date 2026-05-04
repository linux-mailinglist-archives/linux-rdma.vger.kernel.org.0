Return-Path: <linux-rdma+bounces-19921-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHNEOGum+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19921-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:00:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C64BE4CD
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0241630427D9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44A3DDDDE;
	Mon,  4 May 2026 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="xpBKObA1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A693DDDC1
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903071; cv=none; b=Anjx8Pu5kE0DUnkWZMvBw1ohpEgaEN0x4SCYImZyW7T5GCxD8tGZSgpmIHnUVVT7y174ncBGt0ycjkRlbaqt85r6lqEkt5/3WZ5eTphVM9kcuqIlelwGwempTP9aPCU6fDweraC9dSR8/a5N4z9wvaYvuQ50uX6iSw+hASvZPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903071; c=relaxed/simple;
	bh=13zgOMmXs5RZRCquXhQbhGFl99rbjsWPCA0+wkADjVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9i9WpqCebBDdTzymiiMmKef1z9SMDRzSk8A2Kuya18zmfjQZFrbGE1v/c4+HZXnjhbKf9cTH3l4fj020SkM6VJ9e798Ns6acY/BRuMo2hqNNiVt6lm5LsLWwTb+kD3vAaIsjL7F00JGTdTUZ8JpCVAsfWwm2poxyTY4FODipTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xpBKObA1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso51686985e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903068; x=1778507868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRs582LkxGN5UKsfkEnYQl+gUjBDkAvHlkfp1nIRmm4=;
        b=xpBKObA1pAfzNkgoDAuQaX2rP5qaGnJNniJbGOlu7lA2DNJ8RETVqXHwFVmPZO2PY3
         pBkzFyG/qh7H8l1zQCviqLwe0Fz3epxnYQZC3IX25vso9BNGDiUHr92XCLGSTMgp/o+9
         rv9+4CFnafKqBSFQlGOyWmFiYhsHhCH9cgBYQ/TmrM0OxBZ/h0ErPgBi8r6Wsfl1FGdc
         kO0mtsqnNjG9/EqlGPGowNhDftEcyEbcIfkcgIP4ggX6kJQrqX19zw5SBPMCWSJz8C4m
         7VSAjhgd1gKFHtcb/vubxItSRU62ozccazL/chU2HmI5vC94gMIEkDgGXTbc+pqHn3aZ
         eF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903068; x=1778507868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRs582LkxGN5UKsfkEnYQl+gUjBDkAvHlkfp1nIRmm4=;
        b=lki7SC4mckPo9Pa39IsgphbhZ2CntBO/u4Rq3Mbr4E9EPZWVHB8LsbE4SfmzWZaONd
         UUtY3cWtKVApkzrOqC1Ij2xRxrYqbSUaN6j3ikv1Xe2pbknF7O+EiQE9J8It9a4C7wx0
         +le339zEIoBHFMJ36Vq19fJ/xJvchTS7HIdJ2HQfuB6h/woTTRXfPFEELWz6MW/CWtsB
         NBdE/Y+6uwCVaj7j/7WrTwaEA/dJu0093UFYF8oRG0Ixhq7RKAT0T3E9NddEoqoRMSGc
         d6aWogbaWknQ93Vz+7zb6WrjBpXU1BYqBBVYl8mOEVEJCTl3uOUTSpyOJ25OYVJpO+ku
         srpw==
X-Gm-Message-State: AOJu0YxOiLEF3/+8sZytUG3pFZhZrbRDlafrE+/28G9EIfaq/E4m1i2b
	81nubrUrz34zfYjkXWEyeUM09gvRlTNKJDIMJdtGEaBii6fFs+dMeaAAytXfiqqkp3GwVx21Qdv
	Uh1AcTDU=
X-Gm-Gg: AeBDietdOhz/pVozy3On3SxXdRwR/CZWqp1cT5JClyQVJUejZaGR03+rA+g5zbnZaET
	t7j4xuPbArx+2x0xgiAbNJj60yBqj3R/wpnGRRxzkEP0GUKujS1bb4gp/1F4dHv5lK30kfwqprO
	VOyzehdm/D0mip/XMKiXQVDowlfIBaU7+dclS4fLDrKRuJ0eKqjlj7WxOT51narTwF4sIeIHaIK
	lOSqOpxF4rgWY4z7HejISUBu3RtzpzEEKT0+zM221gQB8zF6KqYdi03oWrenlZWwt93CBdOC24T
	bEQoURiV9ha3sQyGXsCLzDPpcLYqyxYTXzTKqfgWmpySFjZv/Q1CF84pjuM7BlJi370VMFnsCGT
	uyDcQv4pDHvXOm3McuHZU0kEh/9iYGfQEdcIlMyTryrkESACoOvj6erPyKphjBHr0otQAfp6K40
	pvdLhJJ0kE9qtS+ModUJeS2jAn
X-Received: by 2002:a05:600c:c170:b0:48a:80cb:1bb4 with SMTP id 5b1f17b1804b1-48a98671d52mr156247335e9.22.1777903068447;
        Mon, 04 May 2026 06:57:48 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe4b4edsm103956575e9.0.2026.05.04.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:47 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 08/17] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Mon,  4 May 2026 15:57:22 +0200
Message-ID: <20260504135731.2345383-9-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 338C64BE4CD
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19921-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver. Fall back to the
existing kernel-DMA path on NULL.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- used ib_umem_get_cq_buf() to get umem, stored in efa_cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to efa_destroy_cq() and new error path
---
 drivers/infiniband/hw/efa/efa_verbs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index e103d1654a69..aebae70b882c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1072,6 +1072,7 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
+	ib_umem_release(cq->umem);
 	return 0;
 }
 
@@ -1124,6 +1125,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1172,26 +1174,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (ibcq->umem) {
-		if (ibcq->umem->length < cq->size) {
-			ibdev_dbg(&dev->ibdev, "External memory too small\n");
-			err = -EINVAL;
-			goto err_out;
-		}
+	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
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
 
@@ -1262,6 +1267,8 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
+err_release_umem:
+	ib_umem_release(cq->umem);
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
 	return err;
-- 
2.53.0


