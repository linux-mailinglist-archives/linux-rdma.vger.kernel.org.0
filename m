Return-Path: <linux-rdma+bounces-18898-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AkwO+n1zGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18898-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:39:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EBC3789EB
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F2E1304BB91
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D013CEBB9;
	Wed,  1 Apr 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIJIjelI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7942857EA
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039686; cv=none; b=mUB5jMyw8QpUbQnAxqk75rtz2yhNSzW2VIKOp+1OHsD8i/uS5ABvTCYkB2Ig7c7nLP127bB++I2UlJwkDp+bnt8xXphX8Ty14PQqmP+wMFtVq5cYKgDXoyn7ofJvsV1jbbxdA8EV+CTx/s56m4eZXzsjekbnSS0ORvW5VRGStpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039686; c=relaxed/simple;
	bh=wjxrTOFiqbNrzkBpeSHIEsXZbm1N3Jq4RcOByIT9HQg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tgpM2r8h1mRa9mNmYTMlavtSg5COR0fAAnjKlL9E+1+ASsh+ph4K1Rowq2OKgCLMe+mxGsj371RzzrkAa9CqGqSt6BtGOQNCLkCUUYhtmycBZE+lEFUJ5WMstCeCJWMEMC6KtEdAm0a4TfATI9tknuGLm0ELHkyrTG2sKxV9hYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIJIjelI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0cf396c45so64084335ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775039684; x=1775644484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBENWfOz5m4aXswxX+1QLDnCjth4YArnAPodhlRMRE0=;
        b=OIJIjelI68juFoPjZfRxfv5rwr9/gXi7E8/9t3oEJKt7UK6CuGxZF6bLxwszXrDDhg
         Vw/4HFgk/Nd6KR/8MweE2quKxLqUV0n0k63X2Ig+vtgFH7zqTUNNp8vEVEYn9jj5mh3o
         vnd8OBbWsgwvMioaQKD2iVEp0WAImF3OdMlnTFiIy7ZNmzw7SybcPQxKWw2s21y1lDnj
         djt0nd7MBI6pSYV2j2kp+76RoH+f3UpRX1dhLQErMOnmCkqGoajuESzEVdRJjcWsdrjS
         f8AT9RcOiDsxSSLNNNfZsFbu2xoZgWT5VC0R+KwaG17WKgp8QzK098MTk7RHivJ6NDnz
         PGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039684; x=1775644484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBENWfOz5m4aXswxX+1QLDnCjth4YArnAPodhlRMRE0=;
        b=qpxACrzoRU912mi9Bsx/MfTHsKMXEAJKs4JMZidleoMvFT2RX3amQ3EgcPRhDPXfjb
         mbbcwNcI3zEuyZibADBTUdGsvuhJqnhZbyYmmKrWMBTrBet/8R4i7kouW5f6MD7/Qaeh
         d6mWMWVcUPvl/0cy/UMMuaQwweLRAGiCgw3w79X0s83SZlBM5YQVlYoel2dwHK/Ibf7M
         jScWAGvWV3k/vNyN5aMt1KNrB1A0Y5aFRmZddQcALM9BJAOPDbGY3VAOnp7UMAuZBiE7
         VcgR0MjInsBgpI0UIkkOm/XUJ7nxeKNR3tFgUZ1xQ+EXfN3VdVSu0iFUnSyM7TgJYeQC
         vflQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnsmUkGMJsNod02Y1KeMmR3FnJ0FqwtRD/l4EsOJGWKC2K9OGeXkJ1N//PceQIaGzYLD9iAbhu1F8t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4245rQSGJyNDovtOn2GL72J/XMiUq/IiKojS4jC9EGYbfQklL
	SPBZjPhEazLLdWiYOkXGfO7yc9WWHFiKL1szat9rT0SxmpdzdqJQNhPQOo3bSzdjBsCoYm56X+5
	+b/RwnGfX0Upf0MhcPi0OM5EdgA==
X-Received: from plfn17.prod.google.com ([2002:a17:902:e551:b0:2b0:5e63:fc48])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2acb:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b269cee743mr30155715ad.43.1775039684372;
 Wed, 01 Apr 2026 03:34:44 -0700 (PDT)
Date: Wed,  1 Apr 2026 10:34:41 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260401103441.1229964-1-shivajikant@google.com>
Subject: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
From: Shivaji Kant <shivajikant@google.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18898-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivajikant@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81EBC3789EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
RDMA controller supports it.

blk_stack_limits() currently filters out this feature bit because it is
absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
in nvme_update_ns_info() after the stacking operation.

Hardware reachability remains enforced by late-stage distance checks
during DMA mapping.

Suggested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 drivers/nvme/host/core.c |  9 +++++++++
 drivers/nvme/host/rdma.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2da54f974fa..0d7b0f286895 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2205,6 +2205,15 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
+
+	/*
+	 * Explicitly check for P2PDMA support as BLK_FEAT_PCI_P2PDMA
+	 * is filtered out by queue_limits_stack_bdev().
+	 */
+	if (ns->ctrl->ops->supports_pci_p2pdma &&
+	   ns->ctrl->ops->supports_pci_p2pdma(ns->ctrl))
+		lim.features |= BLK_FEAT_PCI_P2PDMA;
+
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	blk_mq_unfreeze_queue(ns->disk->queue, memflags);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..3ce6f3e476b0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2189,6 +2189,20 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
+{
+	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
+	bool supported = false;
+
+	if (r_ctrl && r_ctrl->device)
+		supported = ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
+
+	dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
+			supported ? "PASSED" : "FAILED (HW/Driver restriction)");
+
+	return supported;
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -2203,6 +2217,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 	.stop_ctrl		= nvme_rdma_stop_ctrl,
 	.get_virt_boundary	= nvme_get_virt_boundary,
+	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
 };
 
 /*
-- 
2.53.0.1213.gd9a14994de-goog


