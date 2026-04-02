Return-Path: <linux-rdma+bounces-18939-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCdiBj8czml7lAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18939-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 09:35:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98088385424
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D64373064204
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353C737C103;
	Thu,  2 Apr 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbna5ldT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759F2571B8
	for <linux-rdma@vger.kernel.org>; Thu,  2 Apr 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115007; cv=none; b=TUFJ2WGw/KhmGC6lWMmiFq13roninJp6LsQGrpO6XfqlYg7vxhubG+lDXBPqR+NcxS7JSfuWvLvzZaR8Af7g6SlNE14+qYkryHlLrDObU00YH+PBANmlfBgkay+oGawsF5OiZ5HwrlnR6M5Zti6MhS1tfF3LMrziGuHjkBrBsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115007; c=relaxed/simple;
	bh=GpDQCFgEMVa6WZvouZwTquTwpu6mWZTVVFjArT8OiNE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T+YJnW9Hn+0fUVcJOnxjFUixq3uhtrhmfbwyZGYNv6BXbE+8cqE9/qrmFC2msqRjoUXfaV+JJylHvrefkjRtrvILXU7TJ4g/RPeYV/t6N8yrpoGAc4PM9vIoIrLmBWNc26hrYhwwvqMWNlrwsl2CSF46CLhS3cT/7zNxGhTdjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbna5ldT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6c70f1f8so405643b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2026 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775115005; x=1775719805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fi6i98rsnzRjLaE+pBgUUzL0LZaOxpHA+vPLz5+YMnI=;
        b=rbna5ldTgXXgKVaszaei0gVt3eeQ2wyvRqDNEZ5QQZVyWf4ubUWFdpIOOBRL0qQOAn
         TD64N7MjladZObscbgGJcyqSMZaH6YigjoYc4K3T0obsPxqBM0iPvEfp+Nc+VfST6Oh3
         2ksxA59E+i7aW/qddO0rSTtyBviivZKbhiILvPXMli2phLEqSVjn8sO+pl2HQrmvurW2
         54yult4d6fRjF8nU6XWTe14QNqWQ0oJXc60LZEEq51tg5gz5VpUcFqlKUEIhOUAQSWxV
         2P8NhvGtL3Dpf/4XI2Bzi5HtubrRLMFxOjlqmbAQgE3rbCDXn9ZVNkU+X2TaS/zLFMCY
         Jx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775115005; x=1775719805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fi6i98rsnzRjLaE+pBgUUzL0LZaOxpHA+vPLz5+YMnI=;
        b=pcCAf8Hw8nc6fehmrnMaKeBj3iVhi9wqQvN0o5oru9RKcQ9791LnJERmOt+5nnb8Bh
         TSuVLpLqh794c2RJ13nJDc7s9otUX25izwb5xamHQH4sUkZQ/nu1HAH+NU1EONGbzLZu
         RF83bZuviZZU5HfkoTCMV1o1VQveWWsK+S6pfM15MHlCSW/E1J9jU0fPu+5XCUYtE63S
         0LFGuQKBLJgv613wIJ5Wn0SjZx7EQeppK+YhKxXcQaDVJXdoKq1sZrEF1fnSvA5NDQdw
         UOLywsyuk6L2gH3r4TSSA4UYOR6PJSiLE6j5g9KfG3G9DVxcvw6DC5eoxYzmrdVSZdyC
         BAiA==
X-Forwarded-Encrypted: i=1; AJvYcCV14GIYg26rt2BRfiIKMn8degO+dyku2mGX2qg6eSHAK7OBoHUIEp23cCuua/YvFx3m0gcITnw63caG@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnztTH3/gyBJtKgNMGlzbk8vmkHCYThlvfFardZqroSUgt9Xw
	JUnokX9KwFsik5zGTBQd5n7Tv0z3BW6ccjuEni+5YMw+1YRSDcqbkTLlnU1lQvX7rgliCftFE8b
	mMLs7YN0jrRwIUZrB2qCU0+wpHw==
X-Received: from pfvb22.prod.google.com ([2002:a05:6a00:cd6:b0:82c:6863:427a])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d53:b0:82a:7ad8:75f2 with SMTP id d2e1a72fcca58-82cfbeb58d0mr2498752b3a.56.1775115004949;
 Thu, 02 Apr 2026 00:30:04 -0700 (PDT)
Date: Thu,  2 Apr 2026 07:30:01 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402073001.2039625-1-shivajikant@google.com>
Subject: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
From: Shivaji Kant <shivajikant@google.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18939-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivajikant@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 98088385424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
RDMA controller supports it.

This patch depends on the PCI P2PDMA support added in this
patch [1].

Suggested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
[1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..09eefd7c3ff4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
+{
+	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
+
+	return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 	.stop_ctrl		= nvme_rdma_stop_ctrl,
 	.get_virt_boundary	= nvme_get_virt_boundary,
+	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
 };
 
 /*
-- 
2.53.0.1185.g05d4b7b318-goog


