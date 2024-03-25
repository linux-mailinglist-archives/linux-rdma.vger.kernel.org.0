Return-Path: <linux-rdma+bounces-1517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143C889EA7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9292A1C34CF0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204D161914;
	Mon, 25 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyWih1aE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C8180A67;
	Mon, 25 Mar 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350616; cv=none; b=tjSLFapms45Hz4TuINs9ECA2+PoLUXajuk4qjCQbtaHKbYBBm6g3yLU60hGEFEhbik2tp5EvuwcB/GTo5ASmzH5Yfe7mr0n399E2qq+/vfNWuJvG1UXipBenaFrFnY/NCGodZLGhWKiLFKR/MBIf7xYJLbL7/eljY9pUMVubphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350616; c=relaxed/simple;
	bh=/OcYeyGR7nBShU6EhPVo+RHG9KRcq17+M9rAUK4EZAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHJExlt1swy3hJGHCpTIxvlMUHDDJ3jVjHRnbf9L7rmHUUtDS2DndqEnyUjETcGCazD90r5i/HTVc2tQRfKo/C2WtQT7pbOF7XvO1Op7fSGpIBPYGVal05kF6UHNpWchakDgE8VOY4HFMKk54kNXFV1w4v8CkN1JuD6TNvLy4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyWih1aE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E001DC43394;
	Mon, 25 Mar 2024 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350615;
	bh=/OcYeyGR7nBShU6EhPVo+RHG9KRcq17+M9rAUK4EZAk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hyWih1aEBrF5fxLDV0V7K3X3aOV9TRZTf1V6Bi5kbYHX7oexMuY0E7/Sx+c8SQDTh
	 d/4dnVvriW2v5Lj5xRzzYkl9M1zajnODNQ6jcgylx6P2ZYBNPHm6gftRxMLNzVPtYc
	 ijrfvXui5RyPzGBxjLHov1GbqT+koXV96+dkHf7/ZReRGiaH20mWOy9fs5Xl/uU/6S
	 D/J8rLWLOIs0S8B2hNC35jNImJZ7h1x4c/QfZZW3EzDpvSyKqFJIOzCf35S9g86jC2
	 c3dlzOrpO800VWpezt374Vba4a3Z5Gj+Orv3Ak8By8NusjGfQxybpKRyX/eeYcuYtC
	 vLgsrYpw2VoQg==
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
Subject: [PATCH 07/28] platform: intel_ips: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:18 +0900
Message-ID: <20240325070944.3600338-8-dlemoal@kernel.org>
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
 drivers/platform/x86/intel_ips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index ba38649cc142..73ec4460a151 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1505,7 +1505,7 @@ static int ips_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	 * IRQ handler for ME interaction
 	 * Note: don't use MSI here as the PCH has bugs.
 	 */
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
 	if (ret < 0)
 		return ret;
 
-- 
2.44.0


