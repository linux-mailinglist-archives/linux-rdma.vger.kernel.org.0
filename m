Return-Path: <linux-rdma+bounces-18623-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD3JEGYFxGnOvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18623-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:55:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D4328813
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 118F53222F3D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873173FFAD7;
	Wed, 25 Mar 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hT92tish"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC783FFAB4
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450860; cv=none; b=YDRi4yAXX6j8ivQNlLn7FYNbxBRy/VkbDXy8tJBNXrjXC9Xs59Fo6KuKhubfuIdrmX75jpAR6hrAd292TRnYkiESrysNU98rVmBJnA1UqqFCeCmyBkSjMiraYPLh6dWwpJvpTzpoRdxK+yuwPj92Hx/W/omD0MQ1dWxd0n3N9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450860; c=relaxed/simple;
	bh=JK4obuROWAeyewV5daIeqEbHldWjOnE9xQQU50MjCHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaK1J21VkeVB9Psq1r4TVMzmj1eAHFXXiUMw3kq8Fe2PwsyAK4LLplMdi70JVERqGPEZCvET//tMh8iZFx1TUmQbGYDSok6bc71VwMt8Pfq1XUqpEUdfwnUN5b/LtpZH8fTwxhyfFjo5YXC3ezuclRwfXQ/P1bZNlasUMe6Xs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hT92tish; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48541edecf9so23158345e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450857; x=1775055657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JFFpWXuXqwePJEitUwdQjSGD9C125fT8Hf1DMyJ73w=;
        b=hT92tish/1a7n2bcy0jPxA/dOl7m4jJXnkHvfRTLIGBL8/t4sPsXGfHtHtH3s4DpS2
         GW84WOjYVrYeju0mi/FKjKUoCwFU8dydsed8tp201zlwaJMSWdjxIxjWEQVso49TX1/4
         5M8T/HsZ9VYE6eBWeS0fkhueGyOUvhxpYM1aP6Q0F4zyiWRfUOIw3GxlNfrH6dLcLp9v
         VrjwO7geWOte8Hfxn26mxF2CEROkvAgaeI95de2OhJohfXiOk7XnaSmmN8XKL6MAAam3
         z92xBav67HRNxCj8GfDRYqYTgAxGIGvLa4jHSi4lQACc2vDw0i+0KvVzychn4DOzbp5p
         m5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450857; x=1775055657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JFFpWXuXqwePJEitUwdQjSGD9C125fT8Hf1DMyJ73w=;
        b=P8IOZHidHP13/00PUcFTvgskaS2k0rBYUAN8O+mg84Li21FsRFmpjV4gzMHfKGDJ7Z
         DWNpURN8gzu2cCCLODlydhJwBFpRdK9iuabaaS3XFbw3XUyNhOy034II9lSwrnkjpy/q
         24xEcgiJxvVGwjZCsMKEo3tL00MhUt3e6N9XCfew7WsdomyFz2mObF227uDDZ8PMtvlM
         wjp+v/ArG9Be8u+BarwDet5q2/TT/4e+7V0Y/i57qAhTXhi5uYjNjKWx7ZNsZfZyjyN7
         YvQgAkW6zzy4cdQoEGzAIc6SiKvRhW4USD4mS2+Z1gkrtkQVWmz6su5om7pI6UfcLaLG
         hHOg==
X-Gm-Message-State: AOJu0YzLLXKCRSLqj6ZeFagq/G3/pN6DTJwHU+d0lBwyEdj7lxQWFy5l
	bYxnkhRzCMaOET78akOKAaih2silU07SGyY6yDcAfiTQKzi3I8FSp8dcTzQPmzQl1ieVeDeWI0U
	S14ZuuV4=
X-Gm-Gg: ATEYQzy6UXeDpQnwJ7UTWDLUquvY15pBBKUA6X3BFt/p0pwdAcM2MGnb/LWY+O8cVkq
	WvsQBjOwV7GtY4S9s/DDaRdsyGTtqZ1nxHyLm8llcy9IBBe/R0AuYF/mItVD/MK2OF9li2/VwI7
	m7HOFx1ooHkjF1/ee/2PuLJzm/lzWcOx5CRhBVPio8czxv/WDBEgygbwCMgB35SOqJo2feUmK08
	k6EQ4icxth2huDBek7bdQ8Xc2G6d1J4DwSXcqZr86vKFY3y4rjlprYGr1irMmxVzyXGv+9zriIe
	fQ1ZGHCDFeaYTlke1BWAHB1QgGLU1gLGq2bwv080YDE9xlI9qfF/cEjNF70OT7nT/7gXhcZOXXP
	29RhzdBh6SNM7HfVGna34yc7q3oQoaPmRrpFiTvn7JPn+5XPPbZ29dCH2oP5GzB0qrmOJoLoxFZ
	w4kUlM3kkr7l0Gqrm2v694pwZ9
X-Received: by 2002:a05:600c:888c:b0:485:7f45:f71f with SMTP id 5b1f17b1804b1-487160aaafbmr40510765e9.32.1774450856327;
        Wed, 25 Mar 2026 08:00:56 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487172f916asm35078155e9.5.2026.03.25.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:00:55 -0700 (PDT)
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
Subject: [PATCH rdma-next 04/15] RDMA/efa: Use umem_list for user CQ buffer
Date: Wed, 25 Mar 2026 16:00:37 +0100
Message-ID: <20260325150048.168341-5-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18623-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A38D4328813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Load the CQ buffer using ib_umem_list_load() instead of ibcq->umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 283c62d9cb3d..8a2de754a75d 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1144,6 +1144,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd = {};
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1211,20 +1212,18 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
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
2.51.1


