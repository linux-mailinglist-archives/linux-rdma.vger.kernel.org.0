Return-Path: <linux-rdma+bounces-19231-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP++Kcpf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19231-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B44923E06EA
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC216305BFE4
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39518DB37;
	Sat, 11 Apr 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="KPZbV6Y+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163D262FFC
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918966; cv=none; b=U+BAiwl/Qrp7LT/q5ymw1ojtvIYTjOd120BDvE3P7soZG573iQzTZykanA3tkwpsylbWJuFSQqfgOaZSCAoD3Ot9wk65WD2z9oYj09MOo8eb4hCtQ0k/eGkMVt/pIMQO3AGjUzVAsP3mRLx4+o9C1VduPvnfXbNEU3WimFYSvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918966; c=relaxed/simple;
	bh=pZm4kwGvgNf9uDmC62L7eGOwpMg2+3Eg25gV+l1fNVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0x3Alj3QLKvw5w22EpPomuwe9CEla/sKiTJ/jnCFYJ8kS6gGNIhpmJgd5Fb/ppWUt25pI2+MWSKG/C0DFrBCW4FhoS84RKXY59fKdhMxMMGOBJFmHfmyV0oyPNFY+Veu4Ha6IMA8nUcC4g6JXKBkJ9qHQQDICYjGdZTmK2agjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=KPZbV6Y+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so28223325e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918963; x=1776523763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcGjygZNjBw8iWNsXwBpuTIPd3USy8U3CFYedWIzGR8=;
        b=KPZbV6Y+laScOZoDj3aSrYuJf7YqYyFT06B4JgLXAAbLUqOZ1XAQLlxlqLkEmSNbFB
         rcTAwvjbRkAD6GhCgykYqyUCG+RXZWiO8vDaLx/CCitdPIZTqEiYyPvKNGJeIlqdq8Fi
         UK3C2oUdQ1ARmHHTpw3+xNoGpqzzLaqc0pfnoDCYUqI69zCqSyqn6z3LtBoEV+SOGS2D
         zLZoxIw+jOWUpGCa2gJJrwsxpN+1oK5QSWJ1KDPeRyFZX2Q3KZT+Boi8nWBPP0Nm8BUo
         ZpE2h4uAUZk6oUdrR7RdwYMePVrekVJ0gZDjxfXgDGGCRlT18oWPAkYND/iNUwQrtaL3
         9Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918963; x=1776523763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcGjygZNjBw8iWNsXwBpuTIPd3USy8U3CFYedWIzGR8=;
        b=qhuQBC3GZHY3dZ2tc1dXFLL4CjwVxUtDQNMS6ki1RUdQ0EA0XWL/DPjw9b8Mz78QU1
         t4XVj+9Efyj/EhDBNa7+3GrNOup6+Z/DwmKt9Ryxon4PwF+eZOXKgUziVgNPQYuhVm8W
         /9lzfxEhjP/EVzNoTG3nHCbcMZZ72TY4Cx7RsXfIWGgDdUzYtvUymwRz/m74rLuO7/cD
         hwW8cNBMTyyv7+muFNS/CdiJc8w3fm+WDMFQllN4aYnqqZoyAlYXUXOMbbyEaZzCuce4
         F2Ydkr7fmTcn0XF1CmmUTVpyQ6Fb6a3LBmdskAMGWW48lZuv9yDuqwV7ctelmSNbq/cZ
         5/jQ==
X-Gm-Message-State: AOJu0YyzuMpwbK9HZvsoFNgM6C6rJ30F7WR02WPmrrbLnkLUTdD1zDY7
	sdKdkhVmRln2xt2C0oENjdArkeZOogw+XeO+JpQYBykUUkmKWXqBoghuTCgk7GTnF9gUhJ/r0sK
	3MxE2
X-Gm-Gg: AeBDietmeiEhHldN/qniIRzBvFM48MJo7VPeERndkQCuKI1qWUOoubea/9GJBbwwqsd
	b/hXrG/7ubHYIhi7C+2JVaoevcjVGbKtEkzBNluH9Gk07+Sc3bYJwMdSSVmGZqWNwL+NYzaAOHT
	IgBYAEZS3LSUKnf0IpLLp6AlnxIh/WIoX5gL0EfAGwBX81wwkFk+ck6NSS+1ibCRpVTNkDKesMf
	GnFNsCz+q5yvYawW4BxELCIQCIag1x4uyt4PMpc46w7mmUXBGnRTfSdfvBSlyPxTl5OkXXVKuQC
	wxKZzMf8YuSNcjia4N9X1M1lI9gZ4syZXlIIiQCzSpYUlt2CKO/vUkOo3j2Aq9tApr0R4v1jJCr
	ZdQ6Af3VPCNGcI07Z+WFkZ+Qqof1DjT5NSYQGn8vISCpsXcrLAswyOiqZHqUzkVaOPLUniN2n20
	YJ1Ms8cddbK+pvrF9B00FqxlTCoQPsyKDECZer73LPUgo=
X-Received: by 2002:a05:600c:4e48:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-488d6858368mr96543515e9.20.1775918963017;
        Sat, 11 Apr 2026 07:49:23 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm147026815e9.4.2026.04.11.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:22 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 04/15] RDMA/efa: Use umem_list for user CQ buffer
Date: Sat, 11 Apr 2026 16:49:04 +0200
Message-ID: <20260411144915.114571-5-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-19231-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: B44923E06EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Load the CQ buffer using ib_umem_list_load() instead of ibcq->umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99..b3236a40b87f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1124,6 +1124,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1172,20 +1173,18 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (ibcq->umem) {
-		if (ibcq->umem->length < cq->size) {
-			ibdev_dbg(&dev->ibdev, "External memory too small\n");
-			err = -EINVAL;
-			goto err_out;
-		}
-
-		if (!ib_umem_is_contiguous(ibcq->umem)) {
+	umem = ib_umem_list_load(ibcq->umem_list, UVERBS_BUF_CQ_BUF, cq->size);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		goto err_out;
+	} else if (umem) {
+		if (!ib_umem_is_contiguous(umem)) {
 			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
 			err = -EINVAL;
 			goto err_out;
 		}
 
-		cq->dma_addr = ib_umem_start_dma_addr(ibcq->umem);
+		cq->dma_addr = ib_umem_start_dma_addr(umem);
 	} else {
 		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
 						 DMA_FROM_DEVICE);
-- 
2.53.0


