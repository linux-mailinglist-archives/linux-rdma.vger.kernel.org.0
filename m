Return-Path: <linux-rdma+bounces-1512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E823889F6A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6B1C363D8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C8128802;
	Mon, 25 Mar 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjWecleT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D718146F;
	Mon, 25 Mar 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350668; cv=none; b=JcR36VzpitzcX0ChsjcFAKZeXU80LiuCqyHNdWRbes2+azvShWroZAWutofUeJDUplCrXAzlSq5ec/YOUW77FOviGkeNbB6Fqjf74XbA0DB/QX5UlkD/jPqNFMk29T4cXvdCwcSMtZHcBLXMEFsqmmorrJiLZfOFntQYwf5hkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350668; c=relaxed/simple;
	bh=B5GsqWlQHNO5gyAGYUNoL0BzLN/ZPFlXUtFST/FBM58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9ICJH6V5hHWiXD2bo3Fctqh/+IVxu7n5nFSLNh8La7svyiHyxiDwurvYGSt8yqQbUyTcQwxSSXb0jLcxu41dCuBrs10C89YW8XUD5aSVLA34wc/BKiKQYnW+VYd1/12DQ9NAgU9ezXQ+CxfoQjyKVbqM1mSEP4akHLGqc6ptL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjWecleT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2503DC43390;
	Mon, 25 Mar 2024 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350668;
	bh=B5GsqWlQHNO5gyAGYUNoL0BzLN/ZPFlXUtFST/FBM58=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RjWecleTKJ4gUhd6cWKMnd3A9YcWMwvl2zAC+RnU0DednLVfmKi+swr2VBY2iU/Sd
	 AXPp0TIZMlJ9bx0aqj+3KPAm0lUuRignz9qlzBz9fUbYzbR2MUtOBnrX8eUl4yDBQn
	 znftTMGLESwuWD1sfiZFf9XIhRZNDiDf+o+UWQUN+75pfyzqChhnsp+SdaEZyj9NNy
	 5SGFxDX2IlgB/2VP/Ps3I82vOMKIOFbuTNzWwLcxJbvwr+ucIy0LTfKEJ3O9ND/D1p
	 im9ZztFBTeD6z4mZnFuUY/9ikBLDDs7z5cO9XaEpceu5EcwxuWJo456k400Cj4Vl3K
	 bc97J27Cy0QrQ==
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
Subject: [PATCH 21/28] scsi: arcmsr: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:32 +0900
Message-ID: <20240325070944.3600338-22-dlemoal@kernel.org>
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
 drivers/scsi/arcmsr/arcmsr_hba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index ad227e6cb10e..35860c61468b 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1007,7 +1007,7 @@ arcmsr_request_irq(struct pci_dev *pdev, struct AdapterControlBlock *acb)
 				goto msi_int1;
 			}
 		}
-		nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+		nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 		if (nvec < 1)
 			return FAILED;
 msi_int1:
-- 
2.44.0


