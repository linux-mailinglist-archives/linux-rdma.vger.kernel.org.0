Return-Path: <linux-rdma+bounces-1511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B493889F59
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB51F38983
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7486637;
	Mon, 25 Mar 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL2wUzhN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25613DDAB;
	Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350676; cv=none; b=NszN1ZEYYZNnLu74W5A8WPFWzWVEkHG68DlfV2lseKHJde4Mpgix/M3U7CRJaM4E8l1j0OJi5ainWPNbmrvzacUaoXjxxFEVoiAHs/knTlpHGCjBspMsuzj4weHJNrZ47R3cBw8viJJ7fvDQ6Dbz/mYjTRg+8NVoC4DGREFep4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350676; c=relaxed/simple;
	bh=o+vS4NpqxRewriEfXhl8rc1UaUJqCGJf5AV1plDyhJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSdhJjX/SsAUSknCO2Krk02ZcgsxRU/Yy6Ohol02JLgc8k2IfIhj8uE9P6Bx0gHChkAGrq2hb7uMOUuuy1Y+dhP9AwHOTx1DuD4BLWrt/k4Ug20yglPtRzQO97MpBptoWUaVT0MVN086GaVrMhs8jlnCSZAmABWbPqGmxeJ8XKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL2wUzhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D75C43330;
	Mon, 25 Mar 2024 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350676;
	bh=o+vS4NpqxRewriEfXhl8rc1UaUJqCGJf5AV1plDyhJ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JL2wUzhNvl/Bp7YDp4iaKkQcRJhsGAuwStqDgQZ0tpcEAaydDamp+C4q5hhpb5VPa
	 5xMj3T442m0tEk3xkkqioHkWJRyORcDcsF2lADUcwqfkE+hL7IU0J1VuwmcdMbWYFB
	 /Ii5tITZMkbZww0PdOdxKuEYyLZw5cJ+JDZ0JcIPAbRMjkG0ydL6oLfj7J/P9pVHP6
	 Hk5dxbazhntqqDTmDDKjhH/2gTkE+/uC0UrWCUF3ffT6Rhk6pCLTB6gtJkAdGraYIh
	 boG4zv1S9R5thvr9/qfheLMxSmZuWhVk+Nm2/mmLfXfYIqAdgnx9QkqDrnP1l1TeqD
	 o+MTGULPcm6PA==
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
Subject: [PATCH 23/28] scsi: ipr: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:34 +0900
Message-ID: <20240325070944.3600338-24-dlemoal@kernel.org>
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
 drivers/scsi/ipr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3819f7c42788..e0326f1e6559 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9463,7 +9463,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 		ipr_number_of_msix = IPR_MAX_MSIX_VECTORS;
 	}
 
-	irq_flag = PCI_IRQ_LEGACY;
+	irq_flag = PCI_IRQ_INTX;
 	if (ioa_cfg->ipr_chip->has_msi)
 		irq_flag |= PCI_IRQ_MSI | PCI_IRQ_MSIX;
 	rc = pci_alloc_irq_vectors(pdev, 1, ipr_number_of_msix, irq_flag);
-- 
2.44.0


