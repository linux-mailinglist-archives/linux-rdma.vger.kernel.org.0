Return-Path: <linux-rdma+bounces-1524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68788A4D2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 15:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F3FB343E3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F95172770;
	Mon, 25 Mar 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQF88+Zs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F2181327;
	Mon, 25 Mar 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350657; cv=none; b=C25nZs1Z+c8QewNnM01J3PrQ/wUZBjyxmGvV59xs5I921E2TWnYj3trOx9tWXdtyJ9V4XxqrwikNLsoKa2FlKNioQU6sqeusSKZwGwL2haCR0hE+58B4BV7a82ampHWDU4AZXKjdUXPdCswBoGHm1qQB2UrIJJ84TVz6tzoARpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350657; c=relaxed/simple;
	bh=XKJ4PdWS7sPUSp/i639lPoqRweHPQBN/JvN8m6hg+pc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ991KGX2GfLmDzEWtmhsngjr/ZCoXt83QhHp1FxCCZeTnfUDxOhC7X97Ccw+FXOmlFSpADEZZzkbSSOoUe0zopAafolfZ2YBeqbofz8RK/VkuMA7WVYkUccG3S4RqqroEbxL74QYBYR8pyeRipFrZKeIQSBXMs9XTSu1hGnxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQF88+Zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE5C43390;
	Mon, 25 Mar 2024 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350657;
	bh=XKJ4PdWS7sPUSp/i639lPoqRweHPQBN/JvN8m6hg+pc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EQF88+Zsdyl9+YqNvdRhZaeBdFtqwsmgLnRE2ZYEQO91OQDEssBs1HPYFOydw2Y/c
	 q9fVT5yFUBshGdvC1nUwagh7ju47fKIHz84i+Kl0muQiajdyvAcnGrWwVPBVKT9G7i
	 USMISh4UGA5PG/UwiADc9Diq32hAG2W8nPjC9IMpbUEg9z+qL+RoATwb/JLfpgPlhz
	 Em6NmF8VDQuJbxefV/WmGaqGuE3aZePf4TtuO3WeiAJagXHfk082h9jsD/qBidsVoD
	 6tsgfsehwBOgri2r63Ealv34YI6KGsuvwWNrnRxGVU/59jD+ALjfzcF5ZDBs0DLce0
	 +1KV1UDFRbPWw==
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
Subject: [PATCH 18/28] net: wangxun: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:29 +0900
Message-ID: <20240325070944.3600338-19-dlemoal@kernel.org>
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
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6dff2c85682d..ae0b940717a8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1674,14 +1674,14 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	/* minmum one for queue, one for misc*/
 	nvecs = 1;
 	nvecs = pci_alloc_irq_vectors(pdev, nvecs,
-				      nvecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+				      nvecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
 	if (nvecs == 1) {
 		if (pdev->msi_enabled)
 			wx_err(wx, "Fallback to MSI.\n");
 		else
-			wx_err(wx, "Fallback to LEGACY.\n");
+			wx_err(wx, "Fallback to INTX.\n");
 	} else {
-		wx_err(wx, "Failed to allocate MSI/LEGACY interrupts. Error: %d\n", nvecs);
+		wx_err(wx, "Failed to allocate MSI/INTX interrupts. Error: %d\n", nvecs);
 		return nvecs;
 	}
 
@@ -2127,7 +2127,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
  * wx_configure_vectors - Configure vectors for hardware
  * @wx: board private structure
  *
- * wx_configure_vectors sets up the hardware to properly generate MSI-X/MSI/LEGACY
+ * wx_configure_vectors sets up the hardware to properly generate MSI-X/MSI/INTX
  * interrupts.
  **/
 void wx_configure_vectors(struct wx *wx)
-- 
2.44.0


