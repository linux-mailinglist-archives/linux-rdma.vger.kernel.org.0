Return-Path: <linux-rdma+bounces-1526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F02D889F7A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA521C36447
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DC172768;
	Mon, 25 Mar 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeMcew6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B618181C;
	Mon, 25 Mar 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350691; cv=none; b=S4Ifsmp5eitvzPlFek9BR3aWMbjWjgupr10rwp95eIC6eYghtqc49gcdVzKP37H90HdbM1YGf6Gf3Ene1cVUDkHfBjaegbdjZB8gZtGtEz1oWAv9gJGrH/rOo7ajQFsS/uCuSo4HGf/SpQlNM1eShHBSqj90u8mS9dwvWstwBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350691; c=relaxed/simple;
	bh=5yQ78yVVRx+BuSskjbXQyqGSxUtm8XGzf7kDWOz8oig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TS0canI9pq/hhS29bdYLQ9OGGgY2FYlcdxvwzNgw07fGeyKE0D+SzedaZ5M/JEJ2yfIHW5r2Ns5safa7xrhrwPuXm9b554beF4lc9slME1DkZ5zckkmzzrmyJssnzS2oPHB5L4tODjqTtYU0Pa3BxPbJV6Drep/kbUOIFgMyyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeMcew6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C3AC43394;
	Mon, 25 Mar 2024 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350691;
	bh=5yQ78yVVRx+BuSskjbXQyqGSxUtm8XGzf7kDWOz8oig=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eeMcew6/36/+XrXV08/jTwz0Ah2T5VgTl9A7CIaoDpVgORmOu0zoxCnETHOKnyaws
	 Jk6feyJmSEUva6kk1jBLhr3pFxKXIPS1esND8Y759MGG4528vj/7q3vwm4iP7prfAi
	 85Lv7BZt8Xpn/MIX/xteBH2QDoK3HsIqofUmCiCCZaZ4b5V9ms5HZsVz1xL4k1C10T
	 H8qcGuaFQjKd3U1++f+oqYXy4jRB1+cBHKsoY7bijIdbIqu0+clyNcUygZX8SRjMpM
	 uCERTsbc5H9s0FyGqDeXjwv9/OQCAUdX0ilXktf5p6NMQS7qDGDZ2yXERmZxhsHcjJ
	 CQRqEat8PcQRQ==
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
Subject: [PATCH 27/28] scsi: vmw_pvscsi: Do not use PCI_IRQ_LEGACY
Date: Mon, 25 Mar 2024 16:09:38 +0900
Message-ID: <20240325070944.3600338-28-dlemoal@kernel.org>
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

In pvscsi_probe(), initialize the irq_flag variable using
PCI_IRQ_ALL_TYPES to remove the use of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/vmw_pvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index f88ecdb93a8a..c4fea077265e 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1346,7 +1346,7 @@ static u32 pvscsi_get_max_targets(struct pvscsi_adapter *adapter)
 
 static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	unsigned int irq_flag = PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY;
+	unsigned int irq_flag = PCI_IRQ_ALL_TYPES;
 	struct pvscsi_adapter *adapter;
 	struct pvscsi_adapter adapter_temp;
 	struct Scsi_Host *host = NULL;
-- 
2.44.0


