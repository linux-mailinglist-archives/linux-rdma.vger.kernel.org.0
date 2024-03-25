Return-Path: <linux-rdma+bounces-1509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C924889F40
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEDB1C362EA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD611737;
	Mon, 25 Mar 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDYAW4so"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EE180A85;
	Mon, 25 Mar 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350619; cv=none; b=KfYVTQs9WrjHo85Ms9SovIsJ997v8bZL4nXytIUPaUgr1stJ+5tRIUa4FKDfiS+LHP1mjSvkEu+GxzWux9D//j52Mp7vCjqCdqwD9xjIkem8DnXDqyv9o8wgpfRZuPrL3ZlQ3zj/CVASOTufYUmdRhWmnxMGfCXZ1Bf1vL55e1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350619; c=relaxed/simple;
	bh=pDklQ4HEyATJrG52s500i9rhBWGMsdxljxs2zv1Sn9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUYqjmAnKF+cBB561dGFaK+t1TDFKl2FYXUYTxKWrW/rEu2WiqgfYfcURMSVLihoEuFPZaOACESFmq4InNMfqQc4Fi+NMIsXslpnqDFFop6U0tIjZ61Ts0ew/YDoH42O4eWErsFaIV9jpzjY5isUhkQOn9IP+FKg/nsgMuZLm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDYAW4so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA54EC43390;
	Mon, 25 Mar 2024 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350619;
	bh=pDklQ4HEyATJrG52s500i9rhBWGMsdxljxs2zv1Sn9M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sDYAW4so/yK4aW9I/T/TZScfACA4ErlTn9EzeRTzT0MnxaSVQ18Q/wo608EexZikE
	 sQl8FfiCyoVhNcD8xHTbECjttNmWw0ciorZ3xFGviCMbgRLOJ00DpYRWlTMJxOtZZg
	 s5SU6uyY/WGt9G9bB84oySLBvK+/u2GZTVC3oMJhjM7Ob8VXW5JgVt2V7KHslRw3Oh
	 gL35PqaFFZT1tkoAczGgg/W48noHxc978hv4oL6Fxz0NJ+OHry+tDI+RQsYgB4eL/x
	 FfsjGiAWqZV/KEgVhCfLsTpJ+PJrw7cwRmdpFSka6ElQHDgnw5eikTNurbY+d3DDsq
	 XYcVv/bRWkvlQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/28] ntb: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:19 +0900
Message-ID: <20240325070944.3600338-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 48823b53ede3..48dfb1a69a77 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2129,7 +2129,7 @@ static int idt_init_isr(struct idt_ntb_dev *ndev)
 	int ret;
 
 	/* Allocate just one interrupt vector for the ISR */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
 	if (ret != 1) {
 		dev_err(&pdev->dev, "Failed to allocate IRQ vector");
 		return ret;
-- 
2.44.0


