Return-Path: <linux-rdma+bounces-1516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680888A5F3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 16:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EEAB262B0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C014B065;
	Mon, 25 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKc7/4Uc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8387181485;
	Mon, 25 Mar 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350683; cv=none; b=iYznXXe6myUKkG4zF7H0lG4GJY0s3/zaTQtBblsCUHlXVmDSsb9ENAXksMypShxp6j8GxIklB5gZ3Ra1Pyljybrd3vZTf2QZvoltsNFLe3XmYPgS32IPMdCJVxSvswvJsjDmjdUZ9cvKxJZ39C8eArTJkQNPDBnOGzrULMeOHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350683; c=relaxed/simple;
	bh=8d2fWq2KAGH9je3NZwkO0VjFD2jmAuDLY6ejwNE42qU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCsUaPCcAKz2RGUgcsdrnjcclCVi6ZQpDszbXFOjlQzsmRKfnf9uiy0++x/2yy44o5lYrIysog1DVs2eQidzrQ/1XVsQ8PHgEdXUePrRPRhADnPxuGdw9wCrGFGylcdsx0Ts4Rbx4KkWU6+H9nbUfCVIM3ZmtmklpTREfS9sKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKc7/4Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D4BC43390;
	Mon, 25 Mar 2024 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350683;
	bh=8d2fWq2KAGH9je3NZwkO0VjFD2jmAuDLY6ejwNE42qU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PKc7/4UcIGtVMn8cCV2sp+5jLJE31bILPthP+vMkJ6r4rFbdpzFzbRFeMiFcmspCm
	 QHZKsCmuwUoqbTAf/joPq5J21aikBcS9L2F40l1UyvYIQldVySHYGxBBWaIgc7jem5
	 pANyiH7dyHya+ExZLCSbl5Y1Mt7WJcUBw9lrhkXWL3+7trs4gi8yykJL63S6EKqGMb
	 72TuZwd6CSGVjWGcJRwS5H6Z7d0q9ghopxNmHGBnDBwTCWBEvnTj7LcC/3diwsHlJ5
	 OMHBUmTP3eG7afDk4Ipu/K2XdPKLaxfpCzXFE0lggNj86xNV9DKAuGIIeHuDq7Z2+K
	 Sa0FYl2fXnhHA==
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
Subject: [PATCH 25/28] scsi: mpt3sas: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:36 +0900
Message-ID: <20240325070944.3600338-26-dlemoal@kernel.org>
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
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 1b492e9a3e55..40f6f87428d5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3515,7 +3515,7 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	ioc_info(ioc, "High IOPs queues : disabled\n");
 	ioc->reply_queue_count = 1;
 	ioc->iopoll_q_start_index = ioc->reply_queue_count - 0;
-	r = pci_alloc_irq_vectors(ioc->pdev, 1, 1, PCI_IRQ_LEGACY);
+	r = pci_alloc_irq_vectors(ioc->pdev, 1, 1, PCI_IRQ_INTX);
 	if (r < 0) {
 		dfailprintk(ioc,
 			    ioc_info(ioc, "pci_alloc_irq_vector(legacy) failed (r=%d) !!!\n",
-- 
2.44.0


