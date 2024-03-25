Return-Path: <linux-rdma+bounces-1528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FEA88A28C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 14:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5DB2C07E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595CF172BA2;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY1gKPZR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D08180B75;
	Mon, 25 Mar 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350634; cv=none; b=njZhWCs73ULcHyjYti8Kk2jTwOr1f8t762NKOXHzwwt/AOuNSIph/e0qyNvqqWr2yJfPCExm+2QXzcc+R4juOmIzzZJjXsRwsAj/qBVCFxrf4f0WCBEeJczkQDkZBtCYYvExCx1LeZnFNFFvFW+tMcfqyBe2Cl6lYIomSuiikHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350634; c=relaxed/simple;
	bh=uemYJfVkbVnT3VEbOjmxsh3+mQZRaZbIDtHRW0buzmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJm1PEhQNBoOEEm5Tmlzx7bqwKdwHkxnQeDVNzQbMoKCOnrVwAsiVzhWhVD8MH/iNQClUnrUyFAg3xQor2Fd5RSpM+GxvcnXxSZ/FwYBFxVxI8DqnQSjlBv6XNb4XHYtkE1ruMBMVkVUt3o5zyutJG5WGj2tYgpYxOpEpLxnU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY1gKPZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78CFC433F1;
	Mon, 25 Mar 2024 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350634;
	bh=uemYJfVkbVnT3VEbOjmxsh3+mQZRaZbIDtHRW0buzmE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GY1gKPZRAXf9ZdgQhJHKYAdRIVyaivjhTfAqp0rjm5jEeHUHSkvYbVlX6bCkg2z0G
	 c+AfouRXSlVFhmHkO6YV5H74VakrPvx3kHO67qBekNDAy/I1EOx3amJUFFlVLpxW9A
	 c76IJOZ6HPfr+LtRlBjeiHuYE1mBG2CLG9fPOElbSdbifP0BKkmu46Nywi+P9F0ZhG
	 CvNzPQZ7CnG5ep3oSDqmVuTt1s8tWX/O4INxokpOmZiQSalX7hu80yhARzi7sY/uXh
	 arsVkP9kmDRd2VzXccrZDKB4BJxc++nAciV6EcNDaVndbDuuf26fyidUYv2Sqf9tL4
	 6RaZopG6B219A==
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
Subject: [PATCH 12/28] infiniband: vmw_pvrdma: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:23 +0900
Message-ID: <20240325070944.3600338-13-dlemoal@kernel.org>
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
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index a5e88185171f..768aad364c89 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -531,7 +531,7 @@ static int pvrdma_alloc_intrs(struct pvrdma_dev *dev)
 			PCI_IRQ_MSIX);
 	if (ret < 0) {
 		ret = pci_alloc_irq_vectors(pdev, 1, 1,
-				PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+				PCI_IRQ_MSI | PCI_IRQ_INTX);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.44.0


