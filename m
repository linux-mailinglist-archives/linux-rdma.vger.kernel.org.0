Return-Path: <linux-rdma+bounces-1523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EB889F81
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848141F38B6B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A984172BB8;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlLsGMZ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3611802A4;
	Mon, 25 Mar 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350593; cv=none; b=SpV4+Y+YojNgmbM2bmzzKeKeAUCPZMkEgw9xwzxOZt58VE1UqeTh5hBF8Y07GA067OTty0px8K+YCNHLNwFI5rNIKH6me+CmDq2xnMNnF0HwLpp3qEYoNarQGr/5Mi490+eMQMSIFKuWxP94AipbVP3zyScTzcNt2hxSLNf1tCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350593; c=relaxed/simple;
	bh=fgNYRUWQ1ehKxth4W+tPpNo5aTyrEzS0AG45mdCeF+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0XhA1YX2nSpuFt/1aCesQuD/7UPkjuGICtfdttyu8zsl1Am5WLX5iERBUJ8IuH4wmjRuOk3NXX/XIWlblw2GbfP2SL0fvYDjajeCNBhnaRamKuWdQX8HjEPbXYV/7uDuE7eIs7aycl6EBhCQeYISX+SrnVltcMjMIWuR2uG7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlLsGMZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481CBC43394;
	Mon, 25 Mar 2024 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350592;
	bh=fgNYRUWQ1ehKxth4W+tPpNo5aTyrEzS0AG45mdCeF+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nlLsGMZ2Nh1cmWZviNXNJCoreXfnZJbu/HHZ5lA3BMPBMNWQKCda07SFBYqYhojiW
	 fVZSiiPSSgYzid9Z+ET8AaD/7NA3ZpksRz0tid4Zbt+pwN2P6b2h3LawbPRcs03yPg
	 QoSyFngv2VBgv17tj1gF7yCPHd5J3L5PnRgyE13/PYW6ku+qY19ZNJYClUXzgUc8/h
	 c9d2WErzPC3zdyVm8IA7SZxCmmndh+BTOzvXXha8YlvWjcMTxTYUWp2zKalOq8Q467
	 hjGn63aTCi2DWOPTiWtV45L+Y/i6QK7e2kF4i/AQbLg8riS7vdPwlVzsUx1VuQ5Ypb
	 nyRI/JDRgUqXA==
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
Subject: [PATCH 01/28] PCI: msi: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:12 +0900
Message-ID: <20240325070944.3600338-2-dlemoal@kernel.org>
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

In pci_alloc_irq_vectors_affinity(), use the macro PCI_IRQ_INTX instead
of the now deprecated PCI_IRQ_LEGACY macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/msi/api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index be679aa5db64..dfba4d6dd535 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -213,8 +213,8 @@ EXPORT_SYMBOL(pci_disable_msix);
  *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
  *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
  *
- *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
- *              and only if @min_vecs == 1
+ *            * %PCI_IRQ_INTX      Allow trying INTx interrupts, if and
+ *              only if @min_vecs == 1
  *
  *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
  *              the vectors around available CPUs
@@ -279,8 +279,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			return nvecs;
 	}
 
-	/* use legacy IRQ if allowed */
-	if (flags & PCI_IRQ_LEGACY) {
+	/* use INTx IRQ if allowed */
+	if (flags & PCI_IRQ_INTX) {
 		if (min_vecs == 1 && dev->irq) {
 			/*
 			 * Invoke the affinity spreading logic to ensure that
-- 
2.44.0


