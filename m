Return-Path: <linux-rdma+bounces-21387-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN8mMKQlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21387-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C025E8339
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5BAD3047766
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A644CACB;
	Wed, 27 May 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="kNHA/vFm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047C3C6A29
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901820; cv=none; b=LkCbgOr5MBMRd6k7vq1DExLlCxd0HVJoejoPnhZb3LGHxHLnGnAsyHlCe4pYXPWBjg03TGNaMYhxuH67pbsOwMbn0K6uaQzdtFXm0YdeKcVOtnQQthd08y0X+VCtELZwKVGV2GVqhqA9YgZqcXbowvh71K96wA0Y6NHA4rZREKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901820; c=relaxed/simple;
	bh=PzFBEoeHLd+kNgCq0+n7Gh7mrWuy+EJi9mzQpqJKu2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgOH3aNTgcqEcCrJb56bGvqpTw1mCrHAUoVYbJ2UlT2Fh7V0bgoHFIClIAuUbKmO51qmbloL1M21XlvgtiRl9nGUWveaGrNdO0MvHbwQGxTZsreiYIeJvwsVjYG7LCh6UpZAYTHeNclXFGodhrlDUGg50dWkZP1DeIKtOHmksyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=kNHA/vFm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d73422431so8508938f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901817; x=1780506617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=kNHA/vFmd+Af6RSJxEday0rYScN1Chx0xhYZLbToReE77/0ajq6J/w/LxBdeFVbEt5
         xJu2JKlgLTuAtaPXRpeojQw9nPJwRu9CZWQSlL3J/6eAKRnNwzJB2N8LG+5ErlLgZl74
         /SM6qt4pO2cwtPDI0KuSEeulg6GaHTbiL9LdPAkQSZuDfbnIRa5duoqxJ2dnzV+KV6Hv
         SGqOJ3yxSBXAGXiP6wgzO/tPlOLhyunxzh7tQ97474KuvtENw/GqZRP9dim1+l7OW+bv
         M4Z1dR6nJa0rPjRRpDXOtJ8e9naBZ3Z/Rnh4VU2OCknPqFRmWxhWJWOJvTeKLbL4ViZD
         KtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901817; x=1780506617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyQzMVuTc3sMKNBsSAJ9NnKA/LLI3SrB665XmR2HKMA=;
        b=B55UoMGq+Shdwtsg3PZn+ldp/F8ER/zUPXJJ+Os2Oe+BwJvllO6mcQDT6IHY2dPENJ
         ZNzduwaUe0M3jW4m501Jj99934OWSrL9sMU+t3JPByw2yHfSOtKK6zRFDVf3Qxd5C0Fu
         Sf8UN9A1KctH8om2SZ3PG9hLiWPbZKXmfh2z8MMnffx6lUeiPw4TFNbYzrkn+2eFYMgz
         dm+mOwaVWQLqWZMADn4iDqTFiHssfqcYlJRSpIeoPBtpzdE8lgLCvPGdcIfkp48GUOFq
         sW7q3Q7KGDWYS2rXDwK1saqYVdqtkKWpkrk6reFiG/2w2hjHQQcGJ6VDmaTssu8N/+XE
         J5wg==
X-Gm-Message-State: AOJu0Yxed8bcWjrI8LtXvvvNR7hqVKBXwsvPpE2lnjhpW0dtU+bKZYIX
	bAYPN0le5YjIE+rlIHPX0YB37QfKSoP2twGgjFnhFZ8ExucfJRNjKNEBVfpFtQ3lpDZWuukw2tc
	pInnCZh8FMQ==
X-Gm-Gg: Acq92OHpANnnHyziX2HsmK7WnNmomWc9Hpdkh0RqWPNan+UXJSVecHkbsqkJnYQWc4A
	CoPckiO3cUAQHIgeODdM+mQMHdPX3qHQIu8J2oZ2F4kZp55bpyWRSyinvWX4QtpCmmNloIXnVDG
	C2JM8fTlYiH/m+luWz5OuplysAAhlixl7dFqmFrtGALyGJMpKr2CQp/NiHMjk1I/mIaZD2+zgeF
	KJAJ5iHrWcln0baOBcInwatDYcQe6ufjjqAj/gvhVws0mBlT8MXDun1nMbYXKqkUNOyiJeUJ9PP
	6VczNpDxkbF8mR6qdDbQ0baGVrxDTj8WFTqU5dC6A9SEApZKGIE7sSqg51OBDFbZd2IPN7zYEiC
	kw4KyqAmLgFCm4AJo+FJmukJeLT2TZ03tK7++EBvnGbB6ye+541gzU6i3NuW9Dn0jtOgKsr6EqI
	areKjrTnVDKBO5+MDY2aKAwE2liOFF768=
X-Received: by 2002:a05:6000:4814:b0:453:e3a1:6580 with SMTP id ffacd0b85a97d-45eb38af5bbmr35684545f8f.25.1779901817173;
        Wed, 27 May 2026 10:10:17 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2a07sm6719863f8f.19.2026.05.27.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:16 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 07/15] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Wed, 27 May 2026 19:09:40 +0200
Message-ID: <20260527170948.2017439-8-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21387-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 84C025E8339
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


