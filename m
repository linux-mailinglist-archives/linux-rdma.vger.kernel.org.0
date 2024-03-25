Return-Path: <linux-rdma+bounces-1534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005988A609
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CF8B3E503
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6F1741FF;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFHyCT7W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581617967E;
	Mon, 25 Mar 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350665; cv=none; b=DikNhWcuFb0LcCTgZZWyTT90te+ggkWGneAMy7EZxXS11MDijiozNWVTWnl9OQpUzvcpIxPWT6OysXZbjHodBU5xUF/3NO3IxB73VfoXKCZI7IENWJ86YedlfooOnQ8IIic7DuGV05R5pQAPmDIkk+p+z61fmzdlxTRIzd5X0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350665; c=relaxed/simple;
	bh=sTPATJrZxPXDBU2hJVRgbRVp2puDXDGSZp/6Anb2ra0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MExOTKV8rl+dX0cW0wzjGAiEAnFHcfHCAKPbxVz/kDovKkLp8IrMxjDid47qBzInjnVFa2eIVJPhsgLl+3A23hKqfQHS5HAulKAUjArRBTFaRVFJm0YbxV876tIEyHcHPm1RRaCul4PNsqo9YoG1jH+usgUwvNEetxkM6vKJrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFHyCT7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB58C433C7;
	Mon, 25 Mar 2024 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350664;
	bh=sTPATJrZxPXDBU2hJVRgbRVp2puDXDGSZp/6Anb2ra0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JFHyCT7W6X1xUcGVlMTa9iTr+w72NzubImHdd/0DveOX+7NhWajlvvcfrjrxl60sS
	 KkT921c4aSXDeZslfjxdIPIMprZCkYQPpxVcNU/yL7f/aDwrf4GrjNM9dKSG4W7uf3
	 fMe50RzV4tc7wWOXO8P9bQbN+3SGEfKS8ayLJFCI50/a9rODs8i3qKiGSlk9MMMkPB
	 ql92SAegznSMyE4yCvrW46M/kA2pNYT9yKzBJ4gpVUp+bCC5n+ZHDYRggqrf8dTsld
	 nLGac3hxSgAWlW+LOGDkAuqUhlzjavo07M+c+jV9WprXJ6qpPlWdGjC29JjHhDZ8aR
	 45GG63jK43Sig==
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
Subject: [PATCH 20/28] net wireless; realtec: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:31 +0900
Message-ID: <20240325070944.3600338-21-dlemoal@kernel.org>
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
 drivers/net/wireless/realtek/rtw88/pci.c | 2 +-
 drivers/net/wireless/realtek/rtw89/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 9986a4cb37eb..282f1e5a882e 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1612,7 +1612,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 
 static int rtw_pci_request_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 {
-	unsigned int flags = PCI_IRQ_LEGACY;
+	unsigned int flags = PCI_IRQ_INTX;
 	int ret;
 
 	if (!rtw_disable_msi)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 19001130ad94..100549694e53 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3547,7 +3547,7 @@ static int rtw89_pci_request_irq(struct rtw89_dev *rtwdev,
 	unsigned long flags = 0;
 	int ret;
 
-	flags |= PCI_IRQ_LEGACY | PCI_IRQ_MSI;
+	flags |= PCI_IRQ_INTX | PCI_IRQ_MSI;
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, flags);
 	if (ret < 0) {
 		rtw89_err(rtwdev, "failed to alloc irq vectors, ret %d\n", ret);
-- 
2.44.0


