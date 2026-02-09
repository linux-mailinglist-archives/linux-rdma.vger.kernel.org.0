Return-Path: <linux-rdma+bounces-16690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJvyEDkhimnLHQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 19:02:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C10BD113592
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 19:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B954301A28F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999038A9C4;
	Mon,  9 Feb 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mRT9XcdE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F938A9B5;
	Mon,  9 Feb 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660095; cv=none; b=bqEgr6l4NydYbwKJVBL0rAgF0S9pRDJCdApJbMAQ46JnQpPCW+p1e0SVdZlpP94yqQxhTNwDvO22zWlkGTgaxELT7BVvtiJkWjg9dcE0OISQSOgAcUG5K0Hdp/fF2R/dVJ564Kb/ZIy8PNJYmy9wh4CAmnryAMXJ4W0nx/2i/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660095; c=relaxed/simple;
	bh=XATOe9xEYb6CkJdPsMWOqdi6khEYeHiuxEAIR2Ws1/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cmH6NwRAUbG/zxfmrf5v8E1x7nooHvIs/ROyEJRv+kSvnB52DjOL7zfSNF0wexqTAdeku30pq+c0xDm56eeNoarKXBrhH7Er12luZwMzHffDDjb3YwQ04GgfBHtDLPW1qvAghd29TsFDBNkYbcpat84ZfmGfZCFJrg6U1qd7St0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mRT9XcdE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=2ETOBixMU8Lpeo/UH7Fnh2Hlu+r8Ud8L0O3pwVjUz4k=; b=mRT9XcdEqegftUUdOoMp8m3rFo
	ai6hWrNzUxgiYyi/WtcvrX8WBisnpk9q+bvQ6WrXOKX7vxLJYIiGHX6+iB0icWMU6DMVQ+ANsLi8G
	xTT9jw0nvJ79LR+LfMBCQivMGFTW6F49yPh2r29LPm68jhRdtMNSDNfIVb8FIFBaMC19/TJ1uauUl
	H1aOd5ME23RDILAjOLcVeaXZ99XGCXuPa0rmLiaolpRiLhTa/XBaM0X+tXNI1mKTfA6r/ycNtIybx
	LdiyZlzBCCGTxhEtB01Tc96jqAV9x7iJldAC8L01fWyXPt+lFqjcyMwoeQyCRRY75LmbmkanSfqYZ
	vGompDRQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vpVZf-009f3g-DD; Mon, 09 Feb 2026 18:01:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Feb 2026 10:01:11 -0800
Subject: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
X-B4-Tracking: v=1; b=H4sIAOcgimkC/yXMQQrCMBAF0KsMf91AEqvUXEVEOnHUEZOWpJVC6
 d1F3b7FW1GlqFQEWlHkrVWHjECuIcRHn+9i9IpA8NYfrLdHk17L/qJDSrOJHftdx47ZtWgIY5G
 bLr/shCwTzn+sMz8lTt8G2/YB2ZXlj3MAAAA=
X-Change-ID: 20260209-mlx5_iommu-c8b238b1bb14
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Amir Vadai <amirv@mellanox.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dcostantino@meta.com, rneu@meta.com, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3491; i=leitao@debian.org;
 h=from:subject:message-id; bh=XATOe9xEYb6CkJdPsMWOqdi6khEYeHiuxEAIR2Ws1/g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpiiDxqmgpfRDKLisP5FaTSSPNUQj6Wr/Z8minf
 M92FKJYBDKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYog8QAKCRA1o5Of/Hh3
 beAED/47FwhsjJ9JKRSbjWEUtd0cOedGS6F8H1E0I5s9bSr3fXZ0/dUd/crjQd/HtTrxqtgE/6n
 SZAc1YNt8+dyiksSw9kNxe8WOWewq3BliLkeqrJ/Lj5wOO3xJmJ65HPME4eLCffgDfB1Yyw77aw
 E6PFiE+UIq7CC2h98s423s+TduBhFTVa5cfl8MrtZNwPJrLx8IJPt1lYBOyn3WnXa+o1FEsKPDC
 VJqCFcv2r7Yq/RvdbdAdX47LXYlARtMUKWdT77TX6duPD8NbCDBa2jbOe9b3Dt3O9syAcxB5ibT
 mPf4UIOy+VUjtQ9Dqb25MjLHGwHM/6Yvv92WQ4QObgc4aa0tulGxcYtJg6dUuQMXCDiGW31vxrU
 twuq8Dt9XAQKWCCYfzISCi0gV9L+RjQ7vLL/unl6d2x3nrxUoh8zt4OM399sXgVov5fSzDxHEtL
 xkLeLLYmDZHNoTXpT1E6/B1iiBZnJMnekh6J0WI6TYxWs200F3vuArozbI64CMO5o09Rh7i6zXo
 PNwAxEc4Mh6EOflZoDGIbUysAa7KbR91UtgyvH8dK7vQI3zRMGQT8vrPohjXTsIhMwiZQsrjRmL
 9gTAB+D3vx2hbMY0ERD8PKvetH3iGS1NUu6dmoMILFVGaXZjF75AJ8f4Gs0aGxR/DB19KBzOwJF
 1fBA5N9WLeFZ7mQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16690-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C10BD113592
X-Rspamd-Action: no action

When a PCI error (e.g. AER error or DPC containment) marks the PCI
channel as frozen or permanently failed, the IOMMU mappings for the
device may already be torn down. If mlx5e_napi_poll() continues
processing CQEs in this state, every call to dma_unmap_page() triggers
a WARN_ON in iommu_dma_unmap_phys().

In a real-world crash scenario on an NVIDIA Grace (ARM64) platform,
a DPC event froze the PCI channel and the mlx5 NAPI poll continued
processing error CQEs, calling dma_unmap for each pending WQE. Here is
an example:

The DPC event on port 0007:00:00.0 fires and eth1 (on 0017:01:00.0) starts
seeing error CQEs almost immediately:

    pcieport 0007:00:00.0: DPC: containment event, status:0x2009
    mlx5_core 0017:01:00.0 eth1: Error cqe on cqn 0x54e, ci 0xb06, ...

The WARN_ON storm begins ~0.4s later and repeats for every pending WQE:

    WARNING: CPU: 32 PID: 0 at drivers/iommu/dma-iommu.c:1237 iommu_dma_unmap_phys
    Call trace:
     iommu_dma_unmap_phys+0xd4/0xe0
     mlx5e_tx_wi_dma_unmap+0xb4/0xf0
     mlx5e_poll_tx_cq+0x14c/0x438
     mlx5e_napi_poll+0x6c/0x5e0
     net_rx_action+0x160/0x5c0
     handle_softirqs+0xe8/0x320
     run_ksoftirqd+0x30/0x58

After 23 seconds of WARN_ON() storm, the watchdog fires:

    watchdog: BUG: soft lockup - CPU#32 stuck for 23s! [ksoftirqd/32:179]
    Kernel panic - not syncing: softlockup: hung tasks

Each unmap hit the WARN_ON in the IOMMU layer, printing a full stack
trace. With dozens of pending WQEs, this created a storm of WARN_ON
dumps in softirq context that monopolized the CPU for over 23 seconds,
triggering a soft lockup panic.

Fix this by checking pci_channel_offline() at the top of
mlx5e_napi_poll() and bailing out immediately when the channel is
offline. napi_complete_done() is called before returning to clear the
NAPI_STATE_SCHED bit, ensuring that napi_disable() in the teardown path
does not spin forever waiting for it. No CQ interrupts are re-armed
since the explicit mlx5e_cq_arm() calls are skipped, so the NAPI
instance will not be re-scheduled. The pending DMA buffers are left for
device removal to clean up.

Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57d..934ad7fafa801 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -138,6 +138,19 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	bool xsk_open;
 	int i;
 
+	/*
+	 * When the PCI channel is offline, IOMMU mappings may already be torn
+	 * down.  Processing CQEs would call dma_unmap for every pending WQE,
+	 * each hitting a WARN_ON in the IOMMU layer.  The resulting storm of
+	 * warnings in softirq context can monopolise the CPU long enough to
+	 * trigger a soft lockup and prevent any RCU grace period from
+	 * completing.
+	 */
+	if (unlikely(pci_channel_offline(c->mdev->pdev))) {
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	rcu_read_lock();
 
 	qos_sqs = rcu_dereference(c->qos_sqs);

---
base-commit: a956792a1543c2bf4a2266cb818dc7c4135006f0
change-id: 20260209-mlx5_iommu-c8b238b1bb14

Best regards,
--  
Breno Leitao <leitao@debian.org>


