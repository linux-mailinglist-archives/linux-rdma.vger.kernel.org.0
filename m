Return-Path: <linux-rdma+bounces-9786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70436A9C648
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 12:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4942C162EF9
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06A243946;
	Fri, 25 Apr 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bC/2qPEe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1E20C00D;
	Fri, 25 Apr 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578440; cv=none; b=otahyHSF2TTVQdibUxFXo390h/sYPWK3ny0Rg+qjq4FZSQKp+4ctEMt1VnAr+z5mLT0uBtyk+sl1GRGWL9erQeBXDXLJZXIRx77uI+r03oGEpMgNrYTwMzcR7zhpeIwlKZ2zbykZ1m9/s6jQDPBjWMkZnOlHv9HnsBlSyFgK4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578440; c=relaxed/simple;
	bh=2AZkdIkyg21yJJX6xmtAvk29MUvdsF3Y1TBzUwl65p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cJ7p8zINljdOaKRfYob8UL2Fh3E0xD8BYkHNW4cBVOC75TRbBEtPLCJ8JBD6nBFcGaKS8oupei7Mu//2vvFXOEXKsfZ6QN6EDbRqL6GIaUt7r6fYE+kGogG9NhUTOWj9sFZwEJiGpCRWQH9bCxMnuakgkyutRO6lOwlVwpHoyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bC/2qPEe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 2654E2020957; Fri, 25 Apr 2025 03:53:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2654E2020957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745578439;
	bh=wjWgDPCnELNadsZ7+gw9v/eGHhdmMPk6cFIpWvfy7OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bC/2qPEe6+Tm+Q0Qq71Tmak2ma2YmEeuJ2BoikloFa6HQfH7WF6rzmG3PJHjDx7KV
	 IQZVFj0kBErTLevPX0lZF0VFHLh1m9Y8ykEnp5HY39FkS/Kp/FWVaXq09IivEhuV1M
	 0MK/tciHh7AV5fuP6TOXGQjyUhUJfxveDDBe53yA=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>
Cc: Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2 1/3] PCI: Export pci_msix_prepare_desc() for dynamic MSI-X alloc
Date: Fri, 25 Apr 2025 03:53:57 -0700
Message-Id: <1745578437-14878-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
to prepare the desc is also needed.

Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
MSI-X vector allocation.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/pci/msi/irqdomain.c | 5 +++--
 include/linux/msi.h         | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index d7ba8795d60f..43129aa6d6c7 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -222,13 +222,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
-static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
-				  struct msi_desc *desc)
+void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			   struct msi_desc *desc)
 {
 	/* Don't fiddle with preallocated MSI descriptors */
 	if (!desc->pci.mask_base)
 		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
 }
+EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 
 static const struct msi_domain_template pci_msix_template = {
 	.chip = {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 86e42742fd0f..d5864d5e75c2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -691,6 +691,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			   struct msi_desc *desc);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
-- 
2.34.1


