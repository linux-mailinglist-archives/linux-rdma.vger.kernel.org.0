Return-Path: <linux-rdma+bounces-544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C78252CF
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jan 2024 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1661C1C23100
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jan 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D02C1AE;
	Fri,  5 Jan 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3KTqhxj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197128E3F;
	Fri,  5 Jan 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704454016; x=1735990016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mz6UXD8CKZpj6xVnd1sdog26enPJbDhqYo4qIbUESI=;
  b=A3KTqhxjo2+2tda5wtl+DNRBvpMb8h7jzvy43R9242BOgv2cKlgtA26p
   ag6J0XTTQxlxpXdn7h39GQb1hU3kVWWa6TnYfGcBg+oAOj/nrHitZXS4M
   hC7BN3hcVRuK7DQUnnxODs5t/WlJgTulfep6yGoHUreGAzJP/vVYWlTT/
   LLRUuReFz8ntL2UDnrPanycqgF9ycvJFoqNKRG30vPSzPAgNL+E3AN97X
   mbhtFcT6/aMOW9EFhway0uyqviNIWun38DS3ztN87Ts2EeP6XWi1DKhiE
   XhPvD3r+wHWIEEU1IN0S6IN5kf8X58vQUX6M10KM8BKX2jn9iTVG2VtM6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="397208915"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="397208915"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851118164"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="851118164"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.38])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:26:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dean Luick <dean.luick@cornelisnetworks.com>
Subject: [PATCH v4 4/8] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Date: Fri,  5 Jan 2024 13:25:43 +0200
Message-Id: <20240105112547.7301-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't assume that only the driver would be accessing LNKCTL2. In the
case of upstream (parent), the driver does not even own the device it's
changing the registers for.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value. This change is also useful as
a cleanup.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 119ec2f1382b..7133964749f8 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1207,14 +1207,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 		    (u32)lnkctl2);
 	/* only write to parent if target is not as high as ours */
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= target_vector;
-		dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-			    (u32)lnkctl2);
-		ret = pcie_capability_write_word(parent,
-						 PCI_EXP_LNKCTL2, lnkctl2);
+		ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+							 PCI_EXP_LNKCTL2_TLS,
+							 target_vector);
 		if (ret) {
-			dd_dev_err(dd, "Unable to write to PCI config\n");
+			dd_dev_err(dd, "Unable to change parent PCI target speed\n");
 			return_error = 1;
 			goto done;
 		}
@@ -1223,22 +1220,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	}
 
 	dd_dev_info(dd, "%s: setting target link speed\n", __func__);
-	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnkctl2);
+	ret = pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS,
+						 target_vector);
 	if (ret) {
-		dd_dev_err(dd, "Unable to read from PCI config\n");
-		return_error = 1;
-		goto done;
-	}
-
-	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-	lnkctl2 |= target_vector;
-	dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL2, lnkctl2);
-	if (ret) {
-		dd_dev_err(dd, "Unable to write to PCI config\n");
+		dd_dev_err(dd, "Unable to change device PCI target speed\n");
 		return_error = 1;
 		goto done;
 	}
-- 
2.39.2


