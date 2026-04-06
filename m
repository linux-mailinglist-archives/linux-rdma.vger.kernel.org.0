Return-Path: <linux-rdma+bounces-19022-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEHMMx5802koigcAu9opvQ
	(envelope-from <linux-rdma+bounces-19022-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:25:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1563A2A22
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 866363019393
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8A3264DE;
	Mon,  6 Apr 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWx4PM9s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF031C57B
	for <linux-rdma@vger.kernel.org>; Mon,  6 Apr 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467302; cv=none; b=U8JVw6Ki1M20YtG19o6KMn1NEZA69f0glJ2ximlMF+AmasR9wPPRhANoxol0fPviLgeEO3+CfMCUudVTA4J3DoCN0NWLd6MsLb/LOBJoURSkv2AdghNFNNh29/HgUdJa26gIqRnH/1KuFFQWg+b7EQ69SHwznOYMYxMGdOYBCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467302; c=relaxed/simple;
	bh=fn+IBnDbfxTI4SRNrjqrYY1Mf+GVGPS+hAM6OVyNWPQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HSboyU6fNosVl+XdPhHxCrn5GPuBQq+SMWwqERwoYOGqjsZO1d/+CbET19otla0izMVio90wsiot12Dqst76j84iDEnQtX16f+tiV7niSSJHYRp/IcYNBvIY4nxD94soHR+T/4mIb1gKS2CU6UyDBgI9ZhUD3cHsjStHfHlCrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWx4PM9s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da37203d2so8654227a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Apr 2026 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775467299; x=1776072099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BDX1PhWlT04ihT2rWEm0Zx1VkEl3UrtVSdzsbOx4DV8=;
        b=IWx4PM9sjsjG2JTin73gx4jEVusSXXFSYG0ks8PZABCoh0R9rgLj17fAWjz5BeL06/
         ZPV2NN58yOdGYP2W3iFPL/CZ+u78FjsvHHL5zLaEF83mOo7DaxETFlJsDhHrcMYaxPJo
         nABJIHrIX1jNHOhNSJPrlunEvQvyc/abMBI4zN9JCH7jpdnQBFaqCqaBXBgU/SHeNEE0
         d543woFSKMrjz3HrZ7KUuMtvEuZJjouCzY+VkxNuYkW3ZNYVMJ1f89OshOrmTjrLfWv3
         zFAT2McHzg2ik6Y+KiJq5QrbFxc5n5AfwFuADpT36Ktb9TIfxUAUCDAr9dEg3XV7zjvJ
         6QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775467299; x=1776072099;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDX1PhWlT04ihT2rWEm0Zx1VkEl3UrtVSdzsbOx4DV8=;
        b=dsqSrKIeo4hotfx7f25Gl67TPcbQmOE6oJMY8R8W9xZHIDnrNFp+QkWqpwxTBDtL/u
         algIE7aZe5zE7l3Lo7V5rsGyMcgQE878ufbRtkLPRhvIuEE0b5jANASsRkO4o1LxwAQv
         1sGFovNYj4r3+5/1rCXJ7IhlgayXqWKMp8wWVcuvbT00V7E2rSCOWmehrCKHOMBZj/8v
         Z4N6WFVq1jKOZb60F/O4JoqXKvpZnRdUD6pVHv8J+pQ9dmYvKKZcRIptJsrE1wvzAEf4
         jjWdtgd8zP4Odpo2bTy9enH/N2plTEyBLQBXzB0C7GI8KY05ZSvUVVhDONCJZDBfoDi9
         WgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrPLOgDANw1gYiXRD2Ikknls+SF6e7XF1yLvZY8CfQfyeGGLNuZNA7OMS8b/kEwcBt8SwTT3cLsM8l@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzZeOD2CF34sEpsVxVuLB00cTvhnfy3EKk4xmQgbPANOaOuhJ
	W1IdBEwuqdKssmeH8jBO80HFxQ4xB+/FxluHdQ74TX7l7eztrggzINW959pJ3LmWpbsqDQTnDoB
	gKtiosFkdELAjOwRrJpZlhlxyKw==
X-Received: from pgkp23.prod.google.com ([2002:a63:f457:0:b0:c73:987f:4708])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210d:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-39f2f1080f2mr11734892637.50.1775467298997;
 Mon, 06 Apr 2026 02:21:38 -0700 (PDT)
Date: Mon,  6 Apr 2026 09:21:32 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406092132.1333458-1-shivajikant@google.com>
Subject: [PATCH v3] nvme: enable PCI P2PDMA support for RDMA transport
From: Shivaji Kant <shivajikant@google.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	henrique.carvalho@suse.com
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19022-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivajikant@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: CE1563A2A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
RDMA controller supports it.

Suggested-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>

---
v2: https://lore.kernel.org/all/20260402073001.2039625-1-shivajikant@google.com/

Changes in v3:
Dropped the reference to multiplath patch from git log as commented
by Christoph Hellwig.
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
2.53.0.1213.gd9a14994de-goog


