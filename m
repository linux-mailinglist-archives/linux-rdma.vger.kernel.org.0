Return-Path: <linux-rdma+bounces-1535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D1889ECD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EA71C35B89
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52812174ED5;
	Mon, 25 Mar 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnXLI8pa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCE180A78;
	Mon, 25 Mar 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350623; cv=none; b=kVZJKjbMBS8sNFJkQEgmUd0lUDKnGa4UBUB08Z9RDZO6FLJlszvMiJrVWuR4JuWgFBhj+TYu2Pbp7Yt8HDljzK2U5qe307pRSvtZwKAuo6qhcoU6MzNVS0w0GyoZBOFJQ8qHLHaEBSBAgiK9IcQejYUm4RO7EPn4v6mjNUfGkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350623; c=relaxed/simple;
	bh=KkLQLoLOHolnVwU8WzSUkFWnSdadyJIAw3FOxFvQh5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw2Aakfb2GoRzdFERBi/bnPTIXsTDlbrsRzOfCKT3IlZ5B5IcVXWs41gqhxO67OotiP3gbDG0mY4ppCx7UntTgj09JvSjEi2JSj6bM33LnoeMy/iKuBGmqhfh3ZY3gyS/ysYC9cYbOdq1o8qnHxOzTXlrW3FLvjYLURAi7W5OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnXLI8pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB97C433F1;
	Mon, 25 Mar 2024 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350623;
	bh=KkLQLoLOHolnVwU8WzSUkFWnSdadyJIAw3FOxFvQh5c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WnXLI8pazLuu8axfdUP1IUDKa+RGXhWtWmcxs54ikyJPWIpc+81UsGWhXdeGDLvLF
	 8qOtQ6J1lQEj8938H0XWdiIFr1EhRAKRMQzCbm5Mn12Sx6JOE0cOBb9/P6+jB5ygba
	 +IOeVIycq1/Sv4/dfBJtXPmgou7mcUQ/WjtmiZtUxbsgX79dj5XyRUvNSMUBLBHtBD
	 o546ne5y7WyugumesDAlsD01LrVePgBChnNIJ01brLjYysfEmNbMAObaI/cbHE2Jwk
	 Yf77pF523lr2Q0DNmJ1yispgGK2EYSE/HbS05Oku1NCI1ut792ODF98EPEVARAlVQn
	 NoZ/Q9X5+5GGg==
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
Subject: [PATCH 09/28] mfd: intel-lpss-pci: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:20 +0900
Message-ID: <20240325070944.3600338-10-dlemoal@kernel.org>
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
 drivers/mfd/intel-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 8c00e0c695c5..9f4782bdbf4b 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -54,7 +54,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 	if (ret < 0)
 		return ret;
 
-- 
2.44.0


