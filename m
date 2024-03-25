Return-Path: <linux-rdma+bounces-1536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C688A15A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 14:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D3BA3373
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF0174EEB;
	Mon, 25 Mar 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZssjjmZV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60901802C8;
	Mon, 25 Mar 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350612; cv=none; b=IB/qaxdIQ13OD7zbMEUt54Fe+V0JDzXjux2O+vOnSQOpS61FkJ2Sw3WzvcuMjdFOYbSlvIuo92FzX4x+wyNNTx65KQ/NZtp9TT0/dvF4/sHKEnR1RgnCHFH3IcKzsnw9jRDEitGs4Pxncaom8THdwu/jAzhwhkX65PoczpTmHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350612; c=relaxed/simple;
	bh=Ob+fZgzFxcE9wTSVWNWVKgYEP0VNmwg/dyGtefu3nb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjEGBvH6X9+EOzbX2xzBPdKxu1PkYIuhYsQKCb4w51HXKWwdxuoOk8wZqMA2Pfo8FYrZxAbuG/ll3McU9pJDb4C+Qhh5AM/Wzmv5v4kZIRGEYMNLbGsFcS+pVFexai42eu+2JhxCHO0FXsv2mOathcicm4YPzjzPnPgmC7CGfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZssjjmZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E31EC43390;
	Mon, 25 Mar 2024 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350611;
	bh=Ob+fZgzFxcE9wTSVWNWVKgYEP0VNmwg/dyGtefu3nb4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZssjjmZVDRmf/cKWuqrUJCCoGRf8DjhmxDd61XMz9XVtI/KQyNpKe5/j2TfAnroy/
	 Sf+5rUBcHgmRkOyQx3F+j5s3GR484tRyUucokjtIxKpm5l4ajb4g8N1vC5nlY0v6nr
	 5zRexkjs3n00maX+dSVIdKqwxDGF4jVbQTkltPZHkBaegx++WyJft/S1rKxUbeH2Fi
	 lPpgZhvKhUvfuFWdNh2pvCrlNZ8DZI07wwKzc7E4V+hKlPUowOcBx1nnrVj2Lu9xUL
	 pskMGlroIo1rXIkad1Sg5w8mD2aLfXhwcAhAkKS+6Np8s0ldpLcddg2XFcibCoaNIU
	 CPb/KwrHTOlcQ==
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
Subject: [PATCH 06/28] tty: 8250_pci: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:17 +0900
Message-ID: <20240325070944.3600338-7-dlemoal@kernel.org>
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
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0d35c77fad9e..400b16c0336c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4108,7 +4108,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
 		} else {
 			pci_dbg(dev, "Using legacy interrupts\n");
-			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
 		}
 		if (rc < 0) {
 			kfree(priv);
-- 
2.44.0


