Return-Path: <linux-rdma+bounces-1522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F19889ED5
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF01AB66682
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBF16F854;
	Mon, 25 Mar 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alt9q+ta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820118149E;
	Mon, 25 Mar 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350687; cv=none; b=N/Z5DtqF/bobIys4NI3pyKZ5WA5kNqIN/5q6NF8jTndCgI/z7rOPcc1+1EaRD/y+uAW8dHOw3ZypLPrGE+sZabuOUf9n2Hi46LfGY18ScbiAJjA3rVDo6XG0tRmxI30Pl+sfSM+HW0Y2qrvn/XjqMZjc55iGR9kiLjGlPBVNXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350687; c=relaxed/simple;
	bh=RYeTCQwP5u3jJ+AkUZ6LHgFtrd06l1caA0vGxdp3bhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKs5MDua3g8p4I4+1+OrPvoJjIpk9Xeq5fSnr2Ubg0h5QWA4FN2iGTkHEiPTc697wEdDCOY0EVLtM4fu18BvFi/PMiZlWbjAvgxbzAV53i+jTs/riAWn3xV29RVZ1bPDINDJRKWjwnJ2Q9nQwF9NPmQF8DCDNZZo9lEjCCrluaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alt9q+ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C10C433F1;
	Mon, 25 Mar 2024 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350687;
	bh=RYeTCQwP5u3jJ+AkUZ6LHgFtrd06l1caA0vGxdp3bhM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Alt9q+tawym1SyqqoG3+QMsGYWZJgANmwxp9AFI3vdUq2RwmFe7LszV6wCXfmCL04
	 gNeXiSBV2JraBD3M9ikl3+OwKLNj5BURjtb2f/B1s2BWFxrL36wfliMy2fJRf3pm3e
	 +7FxrHVGafniohFnc7hl//EbzU5dJJlcv1xXZIcju6daZfpS8M2z/ETtssi7R96I9q
	 EFKpxTfZ83P4Sp7i+hUwmIMeT39mWgAhj37qlPAm79mS1V5cIhDGYp54/YJwxfGknk
	 BMxEDK1zEWP5eBYTOFNht0LYBsfnsjK2F3j5REG0LbvZs3329wAz4I/BrXhscniuHI
	 tRY9YQB+MrWdQ==
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
Subject: [PATCH 26/28] scsi: pmcraid: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:37 +0900
Message-ID: <20240325070944.3600338-27-dlemoal@kernel.org>
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
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e8bcc3a88732..9c57efa10732 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4033,7 +4033,7 @@ static int
 pmcraid_register_interrupt_handler(struct pmcraid_instance *pinstance)
 {
 	struct pci_dev *pdev = pinstance->pdev;
-	unsigned int irq_flag = PCI_IRQ_LEGACY, flag;
+	unsigned int irq_flag = PCI_IRQ_INTX, flag;
 	int num_hrrq, rc, i;
 	irq_handler_t isr;
 
-- 
2.44.0


