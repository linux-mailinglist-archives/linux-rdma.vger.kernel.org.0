Return-Path: <linux-rdma+bounces-1532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2888A3A6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7232CB27F01
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D061741FD;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaTbsjO2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66651181330;
	Mon, 25 Mar 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350661; cv=none; b=sM+VLoUSw41keyjL+ietnwuOdbAkarWMjPeJu+ayphsewro0DfYb3NQft+ezJ6I0Wb98RWwNQQHEzdSumGCN1/MCfWDuaIKFspZHwGaROwH6MWHNTG6G7s9eRsXpCZ5tJ7xsWu0KUdU3Kkl/2mYpHVusm7EQVfPSXLaNZ/X2seM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350661; c=relaxed/simple;
	bh=3okQkZTtVP8n3cojIfOlGnnTGCyjyZ02N2+KeIwn8U8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYJ+d+qOFUXXCh93Hu4HibI+t9c5XaFuAC1I8UPrpd+sNJHcGQRcA9wcLTNIZWPP2PIzCcZlggnORJR8eoPTs7snV+J06gqo/JW8/923YUv4uBgDiWYwiJ3/vSVht4V6IiKjDVvCo5Cd3iO0E07G+EOLZjSyx4s3QDIqYEL9u78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaTbsjO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E919C433F1;
	Mon, 25 Mar 2024 07:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350661;
	bh=3okQkZTtVP8n3cojIfOlGnnTGCyjyZ02N2+KeIwn8U8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MaTbsjO2soog5x/BBuujMmHmG2VMII0UHud/0/mvePNxOC4DXLovCYa7VuGjOLZCs
	 0pUf57+hTffiK1Tp5sIHbD3wngpJ1q+mNV0KpuqtceazrkKAU1z6aCumNnlAhL9+JQ
	 aU5XZ51SeH9iVfyaVltMHFm7XMTfvGKf56DhqBm0PUZTYvoVZckVMF6TC4EWhqJskc
	 Vv5sK0DZCFBwA0+6QDlf+eV7ThmiV8baWiE34l/9phS1t1Poksfp1XlP/l7096n917
	 hsGdeLSiUOdoCYxob4dMM6ldLOcDr3g/lVz/beu6eimLfJeOEx32X4GjxFamUrXotD
	 jqEAEbj9NzI1Q==
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
Subject: [PATCH 19/28] net: wireless: ath10k: Use references to INTX instead of LEGACY
Date: Mon, 25 Mar 2024 16:09:30 +0900
Message-ID: <20240325070944.3600338-20-dlemoal@kernel.org>
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

To be consistent with the deprecation of PCI_IRQ_LEGACY and its
replacement with PCI_IRQ_INTX, rename macros and functions referencing
"legacy irq" to instead use the term "intx irq".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 18 +++++++-------
 drivers/net/wireless/ath/ath10k/pci.c | 36 +++++++++++++--------------
 drivers/net/wireless/ath/ath10k/pci.h |  6 ++---
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index a378bc48b1d2..f0441b3d7dcb 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -394,14 +394,14 @@ static irqreturn_t ath10k_ahb_interrupt_handler(int irq, void *arg)
 	if (!ath10k_pci_irq_pending(ar))
 		return IRQ_NONE;
 
-	ath10k_pci_disable_and_clear_legacy_irq(ar);
+	ath10k_pci_disable_and_clear_intx_irq(ar);
 	ath10k_pci_irq_msi_fw_mask(ar);
 	napi_schedule(&ar->napi);
 
 	return IRQ_HANDLED;
 }
 
-static int ath10k_ahb_request_irq_legacy(struct ath10k *ar)
+static int ath10k_ahb_request_irq_intx(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	struct ath10k_ahb *ar_ahb = ath10k_ahb_priv(ar);
@@ -415,12 +415,12 @@ static int ath10k_ahb_request_irq_legacy(struct ath10k *ar)
 			    ar_ahb->irq, ret);
 		return ret;
 	}
-	ar_pci->oper_irq_mode = ATH10K_PCI_IRQ_LEGACY;
+	ar_pci->oper_irq_mode = ATH10K_PCI_IRQ_INTX;
 
 	return 0;
 }
 
-static void ath10k_ahb_release_irq_legacy(struct ath10k *ar)
+static void ath10k_ahb_release_irq_intx(struct ath10k *ar)
 {
 	struct ath10k_ahb *ar_ahb = ath10k_ahb_priv(ar);
 
@@ -430,7 +430,7 @@ static void ath10k_ahb_release_irq_legacy(struct ath10k *ar)
 static void ath10k_ahb_irq_disable(struct ath10k *ar)
 {
 	ath10k_ce_disable_interrupts(ar);
-	ath10k_pci_disable_and_clear_legacy_irq(ar);
+	ath10k_pci_disable_and_clear_intx_irq(ar);
 }
 
 static int ath10k_ahb_resource_init(struct ath10k *ar)
@@ -621,7 +621,7 @@ static int ath10k_ahb_hif_start(struct ath10k *ar)
 
 	ath10k_core_napi_enable(ar);
 	ath10k_ce_enable_interrupts(ar);
-	ath10k_pci_enable_legacy_irq(ar);
+	ath10k_pci_enable_intx_irq(ar);
 
 	ath10k_pci_rx_post(ar);
 
@@ -775,7 +775,7 @@ static int ath10k_ahb_probe(struct platform_device *pdev)
 
 	ath10k_pci_init_napi(ar);
 
-	ret = ath10k_ahb_request_irq_legacy(ar);
+	ret = ath10k_ahb_request_irq_intx(ar);
 	if (ret)
 		goto err_free_pipes;
 
@@ -806,7 +806,7 @@ static int ath10k_ahb_probe(struct platform_device *pdev)
 	ath10k_ahb_clock_disable(ar);
 
 err_free_irq:
-	ath10k_ahb_release_irq_legacy(ar);
+	ath10k_ahb_release_irq_intx(ar);
 
 err_free_pipes:
 	ath10k_pci_release_resource(ar);
@@ -828,7 +828,7 @@ static void ath10k_ahb_remove(struct platform_device *pdev)
 
 	ath10k_core_unregister(ar);
 	ath10k_ahb_irq_disable(ar);
-	ath10k_ahb_release_irq_legacy(ar);
+	ath10k_ahb_release_irq_intx(ar);
 	ath10k_pci_release_resource(ar);
 	ath10k_ahb_halt_chip(ar);
 	ath10k_ahb_clock_disable(ar);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 5c34b156b4ff..6aeeab2edf5a 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -721,7 +721,7 @@ bool ath10k_pci_irq_pending(struct ath10k *ar)
 	return false;
 }
 
-void ath10k_pci_disable_and_clear_legacy_irq(struct ath10k *ar)
+void ath10k_pci_disable_and_clear_intx_irq(struct ath10k *ar)
 {
 	/* IMPORTANT: INTR_CLR register has to be set after
 	 * INTR_ENABLE is set to 0, otherwise interrupt can not be
@@ -739,7 +739,7 @@ void ath10k_pci_disable_and_clear_legacy_irq(struct ath10k *ar)
 				PCIE_INTR_ENABLE_ADDRESS);
 }
 
-void ath10k_pci_enable_legacy_irq(struct ath10k *ar)
+void ath10k_pci_enable_intx_irq(struct ath10k *ar)
 {
 	ath10k_pci_write32(ar, SOC_CORE_BASE_ADDRESS +
 			   PCIE_INTR_ENABLE_ADDRESS,
@@ -1935,7 +1935,7 @@ static void ath10k_pci_irq_msi_fw_unmask(struct ath10k *ar)
 static void ath10k_pci_irq_disable(struct ath10k *ar)
 {
 	ath10k_ce_disable_interrupts(ar);
-	ath10k_pci_disable_and_clear_legacy_irq(ar);
+	ath10k_pci_disable_and_clear_intx_irq(ar);
 	ath10k_pci_irq_msi_fw_mask(ar);
 }
 
@@ -1949,7 +1949,7 @@ static void ath10k_pci_irq_sync(struct ath10k *ar)
 static void ath10k_pci_irq_enable(struct ath10k *ar)
 {
 	ath10k_ce_enable_interrupts(ar);
-	ath10k_pci_enable_legacy_irq(ar);
+	ath10k_pci_enable_intx_irq(ar);
 	ath10k_pci_irq_msi_fw_unmask(ar);
 }
 
@@ -3111,11 +3111,11 @@ static irqreturn_t ath10k_pci_interrupt_handler(int irq, void *arg)
 		return IRQ_NONE;
 	}
 
-	if ((ar_pci->oper_irq_mode == ATH10K_PCI_IRQ_LEGACY) &&
+	if ((ar_pci->oper_irq_mode == ATH10K_PCI_IRQ_INTX) &&
 	    !ath10k_pci_irq_pending(ar))
 		return IRQ_NONE;
 
-	ath10k_pci_disable_and_clear_legacy_irq(ar);
+	ath10k_pci_disable_and_clear_intx_irq(ar);
 	ath10k_pci_irq_msi_fw_mask(ar);
 	napi_schedule(&ar->napi);
 
@@ -3152,7 +3152,7 @@ static int ath10k_pci_napi_poll(struct napi_struct *ctx, int budget)
 			napi_schedule(ctx);
 			goto out;
 		}
-		ath10k_pci_enable_legacy_irq(ar);
+		ath10k_pci_enable_intx_irq(ar);
 		ath10k_pci_irq_msi_fw_unmask(ar);
 	}
 
@@ -3177,7 +3177,7 @@ static int ath10k_pci_request_irq_msi(struct ath10k *ar)
 	return 0;
 }
 
-static int ath10k_pci_request_irq_legacy(struct ath10k *ar)
+static int ath10k_pci_request_irq_intx(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	int ret;
@@ -3199,8 +3199,8 @@ static int ath10k_pci_request_irq(struct ath10k *ar)
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 
 	switch (ar_pci->oper_irq_mode) {
-	case ATH10K_PCI_IRQ_LEGACY:
-		return ath10k_pci_request_irq_legacy(ar);
+	case ATH10K_PCI_IRQ_INTX:
+		return ath10k_pci_request_irq_intx(ar);
 	case ATH10K_PCI_IRQ_MSI:
 		return ath10k_pci_request_irq_msi(ar);
 	default:
@@ -3232,7 +3232,7 @@ static int ath10k_pci_init_irq(struct ath10k *ar)
 			    ath10k_pci_irq_mode);
 
 	/* Try MSI */
-	if (ath10k_pci_irq_mode != ATH10K_PCI_IRQ_LEGACY) {
+	if (ath10k_pci_irq_mode != ATH10K_PCI_IRQ_INTX) {
 		ar_pci->oper_irq_mode = ATH10K_PCI_IRQ_MSI;
 		ret = pci_enable_msi(ar_pci->pdev);
 		if (ret == 0)
@@ -3250,7 +3250,7 @@ static int ath10k_pci_init_irq(struct ath10k *ar)
 	 * For now, fix the race by repeating the write in below
 	 * synchronization checking.
 	 */
-	ar_pci->oper_irq_mode = ATH10K_PCI_IRQ_LEGACY;
+	ar_pci->oper_irq_mode = ATH10K_PCI_IRQ_INTX;
 
 	ath10k_pci_write32(ar, SOC_CORE_BASE_ADDRESS + PCIE_INTR_ENABLE_ADDRESS,
 			   PCIE_INTR_FIRMWARE_MASK | PCIE_INTR_CE_MASK_ALL);
@@ -3258,7 +3258,7 @@ static int ath10k_pci_init_irq(struct ath10k *ar)
 	return 0;
 }
 
-static void ath10k_pci_deinit_irq_legacy(struct ath10k *ar)
+static void ath10k_pci_deinit_irq_intx(struct ath10k *ar)
 {
 	ath10k_pci_write32(ar, SOC_CORE_BASE_ADDRESS + PCIE_INTR_ENABLE_ADDRESS,
 			   0);
@@ -3269,8 +3269,8 @@ static int ath10k_pci_deinit_irq(struct ath10k *ar)
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 
 	switch (ar_pci->oper_irq_mode) {
-	case ATH10K_PCI_IRQ_LEGACY:
-		ath10k_pci_deinit_irq_legacy(ar);
+	case ATH10K_PCI_IRQ_INTX:
+		ath10k_pci_deinit_irq_intx(ar);
 		break;
 	default:
 		pci_disable_msi(ar_pci->pdev);
@@ -3307,14 +3307,14 @@ int ath10k_pci_wait_for_target_init(struct ath10k *ar)
 		if (val & FW_IND_INITIALIZED)
 			break;
 
-		if (ar_pci->oper_irq_mode == ATH10K_PCI_IRQ_LEGACY)
+		if (ar_pci->oper_irq_mode == ATH10K_PCI_IRQ_INTX)
 			/* Fix potential race by repeating CORE_BASE writes */
-			ath10k_pci_enable_legacy_irq(ar);
+			ath10k_pci_enable_intx_irq(ar);
 
 		mdelay(10);
 	} while (time_before(jiffies, timeout));
 
-	ath10k_pci_disable_and_clear_legacy_irq(ar);
+	ath10k_pci_disable_and_clear_intx_irq(ar);
 	ath10k_pci_irq_msi_fw_mask(ar);
 
 	if (val == 0xffffffff) {
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index 27bb4cf2dfea..4c3f536f2ea1 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -101,7 +101,7 @@ struct ath10k_pci_supp_chip {
 
 enum ath10k_pci_irq_mode {
 	ATH10K_PCI_IRQ_AUTO = 0,
-	ATH10K_PCI_IRQ_LEGACY = 1,
+	ATH10K_PCI_IRQ_INTX = 1,
 	ATH10K_PCI_IRQ_MSI = 2,
 };
 
@@ -243,9 +243,9 @@ int ath10k_pci_init_pipes(struct ath10k *ar);
 int ath10k_pci_init_config(struct ath10k *ar);
 void ath10k_pci_rx_post(struct ath10k *ar);
 void ath10k_pci_flush(struct ath10k *ar);
-void ath10k_pci_enable_legacy_irq(struct ath10k *ar);
+void ath10k_pci_enable_intx_irq(struct ath10k *ar);
 bool ath10k_pci_irq_pending(struct ath10k *ar);
-void ath10k_pci_disable_and_clear_legacy_irq(struct ath10k *ar);
+void ath10k_pci_disable_and_clear_intx_irq(struct ath10k *ar);
 void ath10k_pci_irq_msi_fw_mask(struct ath10k *ar);
 int ath10k_pci_wait_for_target_init(struct ath10k *ar);
 int ath10k_pci_setup_resource(struct ath10k *ar);
-- 
2.44.0


