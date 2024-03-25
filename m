Return-Path: <linux-rdma+bounces-1533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71DE889EC4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E672D288324
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDF174952;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFARA2LO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143861802D6;
	Mon, 25 Mar 2024 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350608; cv=none; b=H7gE77/h6tONyk8XKMyME1jSi5Ma02tgzkWA5FMFfQBEAv4AYGOxAypdCYtmMoYMtrB+cYJvRKsLDgzfxHbMot9+tCA5ykfLUYX3HcLHir7KtNWumnulsT7gbUV6HcPE4Q3ZH/VcTXhUSSefBBt8zDRlIiYrDiYVBAq4o4CgQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350608; c=relaxed/simple;
	bh=A9TxYq3UpnnXqXe4Ry5wOngxfykxcqU3LiaWPn5EjBk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFab2yvia5yCc/YdY/8DSOODj7t8FeYvnN0EBjQdyLHjPsdUjoW5L1uV+edUlReNIo4QGWpUi2aQ6Cf4B5O92+ko2vTPdftxStEjt2FHeSs/J+/MU1JhW19+I05NdqiVKYVRhhnfs9Wl/NRbbrHSbGt2C/+cD4I7YyDDiV3jkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFARA2LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF2DC43394;
	Mon, 25 Mar 2024 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350607;
	bh=A9TxYq3UpnnXqXe4Ry5wOngxfykxcqU3LiaWPn5EjBk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kFARA2LOYRrO5xqIgKf6WUYQsLLv53tYDhUtPQ06+TVXMszutNq+GyQXlmWL94J6X
	 OIAM1vT9Fw8KI8oQo8/Lr/f6hxkUw0UNiXjpR/3YVStTv5z8l8MOpOe115NMNFVKP/
	 m7V/gjDpqBlpMuCrU3OBzq7XKn0sofTjBcdI5B2odCVKGqetsaAP4t3X6ETt0Ucohx
	 HJToHwp4ED5Y7i6w25yoOcLrAG18FtjkcptCKSqWoHYxqP8BxlLq4r37Nq2mG6gA+S
	 MnwOzDnkeQC1J5KF5BQEvlVQTIa+NxGFBkPgtF1Ub/hpX7hTblXLpYC//JaPzRukh6
	 RPzYeUFUtNDpA==
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
Subject: [PATCH 05/28] usb: hcd-pci: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:16 +0900
Message-ID: <20240325070944.3600338-6-dlemoal@kernel.org>
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
 drivers/usb/core/hcd-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index ee3156f49533..a08f3f228e6d 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -189,7 +189,8 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct hc_driver *driver)
 	 * make sure irq setup is not touched for xhci in generic hcd code
 	 */
 	if ((driver->flags & HCD_MASK) < HCD_USB3) {
-		retval = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY | PCI_IRQ_MSI);
+		retval = pci_alloc_irq_vectors(dev, 1, 1,
+					       PCI_IRQ_INTX | PCI_IRQ_MSI);
 		if (retval < 0) {
 			dev_err(&dev->dev,
 			"Found HC with no IRQ. Check BIOS/PCI %s setup!\n",
-- 
2.44.0


