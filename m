Return-Path: <linux-rdma+bounces-1530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA8889F82
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D91F38B46
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D82172BA6;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly8fo8tV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96513DDC8;
	Mon, 25 Mar 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350638; cv=none; b=fmQf3BZ27uDeh59L5hfxo4EeCRemNrkKeHhyKG6gnXMuYD7Dy1eqH7H+SRQcaVD/xudkzq4TfllKrpDCsVwR4RhrpM2kkgyGuOnVxbswVbmMD9zE5kx7oV/jAlteuc+C+eI0eDAd2/S2YRFHp5Yrvr6cbvHoJSNjDcOhEpJn/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350638; c=relaxed/simple;
	bh=WYkv91EIIKYnBjiqDa2StmEVhH3MpVjmEKTd+pFQezw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToQ+7sY6sdKNYlsMZ0Um0SC5zE1tvQ1BxuFRzPezdKG78zheeQC+g7a6BExmNy8fxQoGLQOrkfQ4vMPjiRIdX/dTz2scKdI+bBPVKu1EqxDbG/nC75BZYA1m2VWChCiQYRyUwEvL7FGTra6HTIQFwb2stPrPhZjDuyP3Lr/wCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly8fo8tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3503C433F1;
	Mon, 25 Mar 2024 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350638;
	bh=WYkv91EIIKYnBjiqDa2StmEVhH3MpVjmEKTd+pFQezw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ly8fo8tVm0I9vz6tH/U6vYCt+/tZTektMeBOExnuVyIh/EKmBVeGLhwFpI2tQULum
	 uVL1ynEGdJjL7PyOeXwFWQvSCqhuqJgmYzocLxL1zxgnbU0Dvo6F8v7L7lub4met9v
	 1QBWc0EhV5YJA0b3d7ZhZ1F4W3od9WchLg0QCemBc/iZymYbd4j1ZANCRvuiXDSNf+
	 DlRI66tKG19MF6dctm45sochuLHR4XBUlBQPJJSNElJ4y8Cxwd+vLfrjRsDsRnz+io
	 fRHcKlf7ZqGFmZXRxVFGUHQ/8YwDdVYd6lm4umZzXirCXC5Ok0ca77lFO5W6mZ/zF8
	 u0beROuG8V2oQ==
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
Subject: [PATCH 13/28] misc: vmci_guest: Use PCI_IRQ_ALL_TYPES
Date: Mon, 25 Mar 2024 16:09:24 +0900
Message-ID: <20240325070944.3600338-14-dlemoal@kernel.org>
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

In vmci_guest_probe_device(), remove the reference to PCI_IRQ_LEGACY by
using PCI_IRQ_ALL_TYPES instead of an explicit OR of all IRQ types.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 4f8d962bb5b2..c61e8953511d 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -787,8 +787,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	error = pci_alloc_irq_vectors(pdev, num_irq_vectors, num_irq_vectors,
 				      PCI_IRQ_MSIX);
 	if (error < 0) {
-		error = pci_alloc_irq_vectors(pdev, 1, 1,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+		error = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 		if (error < 0)
 			goto err_unsubscribe_event;
 	} else {
-- 
2.44.0


