Return-Path: <linux-rdma+bounces-1529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB588A4C2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CEB2FCC6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54823172792;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSPzc2Tb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD260179646;
	Mon, 25 Mar 2024 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350650; cv=none; b=qS1TJWuAtWBoQ2kzJWexwWwmR3kedLwIuREZoK3aSz0br6FqJeNXOxZC76pI9kriG+rqXuBl7iSLC7FOYcIPoeGpOcuYqhRmJQoBj4AN16rmdR0AQz4UKY4BKRHE+Eg1Jjey4pHMPr+I3n4qIjgclOAXcXRF9hLyRF6/pgeI5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350650; c=relaxed/simple;
	bh=82CeZhOQbJ6rbgh7yjtlPJLHhk0GT4ijOnBVaOy6U2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb+/oTvd5JTMrT2Sn72/lf/1dIAoYor03bLrFEnr5Nw5TrWP1wq0zazdhAe+xD4ibwusJY0G98F+IIj4+RzmN3fLsam8j9OrF9cPhtF5jHPle4TMzjmlMwzLJNQ7U8ZeOSMA4b/fMpahbv0wYUpfuepPEHkn6iTkhomjGSDyGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSPzc2Tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CAC43399;
	Mon, 25 Mar 2024 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350649;
	bh=82CeZhOQbJ6rbgh7yjtlPJLHhk0GT4ijOnBVaOy6U2I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nSPzc2Tb9CbjeS4SH754ujdqu5AOYkmi9pYGiC+52yMSsJb12CQQGvH6HOqcjluEc
	 nTgCHxSGg4BP17X6liPUewIyfkzuHbAC9lX5yA9LCoNIU5wTPUO6Jp4giQFoYsSVdq
	 vsO5VL+nFcXm5PoIct9t+HSS7eFbuGIbV3+PoVM35Lqi0KbfrbKkqBctgADp2mCw7g
	 of2/PrKdPtBV2tPUA688yNIMnf323z0oGDXVY5ka+8rF26qQkzz2lGeyA3Okf+jFTo
	 NPVEAyqSp56LeoF9RMsOCxNNaMaZitpcVAG9HSlkavbkttHENw5PMlpS1dqr62HAVK
	 WZKEDdyXUfdFA==
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
Subject: [PATCH 16/28] net: atheros: alx: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:27 +0900
Message-ID: <20240325070944.3600338-17-dlemoal@kernel.org>
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
 drivers/net/ethernet/atheros/alx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index 49bb9a8f00e6..0dbb541155f3 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -901,7 +901,7 @@ static int alx_init_intr(struct alx_priv *alx)
 	int ret;
 
 	ret = pci_alloc_irq_vectors(alx->hw.pdev, 1, 1,
-			PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+			PCI_IRQ_MSI | PCI_IRQ_INTX);
 	if (ret < 0)
 		return ret;
 
-- 
2.44.0


