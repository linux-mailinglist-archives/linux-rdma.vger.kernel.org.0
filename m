Return-Path: <linux-rdma+bounces-1525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534A889F84
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9951F38AE9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC9173D8A;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXPlWR3l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3841802B0;
	Mon, 25 Mar 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350596; cv=none; b=dQHQ985nSLaUa5iBiwwlICeZmrJDDgMTzJsBy+uGreJrEJPOyf0FkJdvup9bQGwdHF/PR4ZZIVhFpWIR+6T4YhJTZ4NOOJ/aSNTOTJms/XEFI47OB8tNCiQSdZL2sUI0u1ef9UFoYypmSxO1XQhhgTAFmf8uKvnpmTyDFq35NbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350596; c=relaxed/simple;
	bh=qSM8UI68diJYCTmxDhZKHtM68q8xdcsJNET3Jh1Y9tA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gspkx7uy9wOh/rV/OaFwIpOEoGYyyi0Ip+IWcuvMztAtm5SmKpAkuFngX9CUlJfa8ZnEVAq3WJX+sZwMr7J/zIXyVtRP5ntp/U8FihAbFkq/NrmqcMRDd3iogqWGat0nR//qaAqSD4AZYbOCrea36ecIkPGQypK4PBoohx7tgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXPlWR3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06703C433F1;
	Mon, 25 Mar 2024 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350596;
	bh=qSM8UI68diJYCTmxDhZKHtM68q8xdcsJNET3Jh1Y9tA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PXPlWR3l2bCkGqFhz0TnZ5XE/dF9ZifPfSQJCi6pHyk+Po+lBiGAc0/1m76zkVPFZ
	 81fcF/5r74fNif+6TWh/NTBVfPuzFK3+cJ6zB770Ah+fHhCp3rMkRT4Skqr5ZNVA9N
	 HbdtZeOngvFMXE1O+UsLLVHH8YfA2Z2rpYNVNsOoBP7h/NQprtRtV/TR+1a/J8nqMc
	 fRg9UF+OUrKcwhrgfE4B0lk6jdCnomvYhZmBYj7UX/fchapCXdxAweDSroJfvyutM3
	 DNq4DTMkPn3vQmDt99qF72vlxR2ZtLxX8/jb1kWKBwZd74oHJ0/WZGRWshmtVj8kbU
	 SjNf+DWLvOFeg==
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
Subject: [PATCH 02/28] PCI: portdrv: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:13 +0900
Message-ID: <20240325070944.3600338-3-dlemoal@kernel.org>
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

In the PCI Express Port Bus Driver, use the macro PCI_IRQ_INTX instead
of the now deprecated PCI_IRQ_LEGACY macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/pcie/portdrv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..bb65dfe43409 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -187,15 +187,15 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	 * interrupt.
 	 */
 	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
-		goto legacy_irq;
+		goto intx_irq;
 
 	/* Try to use MSI-X or MSI if supported */
 	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
 		return 0;
 
-legacy_irq:
-	/* fall back to legacy IRQ */
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+intx_irq:
+	/* fall back to INTX IRQ */
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
 	if (ret < 0)
 		return -ENODEV;
 
-- 
2.44.0


