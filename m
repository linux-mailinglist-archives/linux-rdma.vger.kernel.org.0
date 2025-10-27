Return-Path: <linux-rdma+bounces-14059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A98C0CB65
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83C93BECE3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04932F39BF;
	Mon, 27 Oct 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5ccbLsh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF742857F1;
	Mon, 27 Oct 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557655; cv=none; b=j5FlOq4QMJmnlRW/wrig0Z2MxfE9mYTVuQqmFN3wcALOCX/cNevk/krgV83nYKhelKmv1+GSjFUrG5KpeMi28p7z1SbfAMtgbKknNmIitYycxHIuh2c+0Z/c/S0QEYQJ7seyaOqrk/ATkLapmap6wFQnYF0h3E2QYREEpoo5Q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557655; c=relaxed/simple;
	bh=qDiN8VUWDPbBq/FHSDrx30KoO7oILgMOEreJ1F5ENEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkKn+8DiRoDRO46FMenDS+kXLqUqgXP48Cdc+BVFIrJw/ynS+e3zG1T2d5I4d9Rp4dxaCR+nB24GWNDKQ+KgZSwEHmxKRJrHFMyFaxa8MY9AmcxCiEzBIi9oslUkjcqnlQbMkx+jPDLFBrt6K30CNBMC+idDOF5Hjc+G0LaBF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5ccbLsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D8C4CEF1;
	Mon, 27 Oct 2025 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761557654;
	bh=qDiN8VUWDPbBq/FHSDrx30KoO7oILgMOEreJ1F5ENEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5ccbLshOHICAUMDghytYiN0LclJ4w03HGjM9dm297zc7pVv58DyZ3vr6JSizqWIE
	 qEVIrts2nurTQg+/h07WMcGqaWqHapr2pRL+tGMRs/mvEnk1ijukHGb6E8JiXtvUhb
	 s/cKhaM6k0t+Mt0wg+Ijvhaa/achyS8OInO6nzYCCKDfOweez8+VG2d/xtqS5G7UbZ
	 4nOQKMColw/cYhI/emo9v3EsP5OCBrqQqiFaAgtvoPIuooEhOwyNRk20cuI420uylZ
	 liOnVsQtBbzI5zUwCvD6HsZoO+xK/Qz/0NEQ0bTFFnGjVtUj367QWmXOQdblGzTrTM
	 nuz2ez7DS25aQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH mlx5-next 1/2] PCI/TPH: Expose pcie_tph_get_st_table_loc()
Date: Mon, 27 Oct 2025 11:34:01 +0200
Message-ID: <20251027-st-direct-mode-v1-1-e0ad953866b6@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
References: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Expose pcie_tph_get_st_table_loc() to be used by drivers as will be done
in the next patch from the series.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/tph.c       | 7 ++++---
 include/linux/pci-tph.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index cc64f93709a4..8f8457ec9adb 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -155,7 +155,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
 	return reg;
 }
 
-static u32 get_st_table_loc(struct pci_dev *pdev)
+u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 {
 	u32 reg;
 
@@ -163,6 +163,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
 
 	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
 }
+EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
 
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Extended
@@ -174,7 +175,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 	u32 loc;
 
 	/* Check ST table location first */
-	loc = get_st_table_loc(pdev);
+	loc = pcie_tph_get_st_table_loc(pdev);
 
 	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
 	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
@@ -299,7 +300,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	 */
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
-	loc = get_st_table_loc(pdev);
+	loc = pcie_tph_get_st_table_loc(pdev);
 	/* Convert loc to match with PCI_TPH_LOC_* */
 	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 9e4e331b1603..ba28140ce670 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
+u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)

-- 
2.51.0


