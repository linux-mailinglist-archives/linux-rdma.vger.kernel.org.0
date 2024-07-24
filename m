Return-Path: <linux-rdma+bounces-3958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3D93B983
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EBA286B1A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E713C675;
	Wed, 24 Jul 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ypd7Ghx5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3712146010
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864444; cv=none; b=kImZ+2ZxecgtFlNu1XlznyL4PiSQtkMNXzKRQ9Bp+RfC55q+IcJXiA9f2E3R4doRbxJFLV96vmbhP5Kf2xYpHvP/KuYbwTzYrecRUcyjc7WiuhUPigsBm6lHP8m0bI9RNWULmE2GEg4472WwOywl1ZYZNAsjJY4FCXiPy0mS2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864444; c=relaxed/simple;
	bh=CJETY7oq4HOQRRx5/4Rg5HQFKLcHVmr9t47uBsUdH5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZ+GGzB0pVaoIv8hyf3mIyX7SmH6jvoOj+7dMQWBDAscxHTods6D76/mLGu7lCZR12f1/BXNXivqktt2BIN+8asxQCvpEi86Bq/geqpGiUfEGmbQHvJKSJ5Q8KA8n57jsmJGRDeKiKHp0ggpID9PCD+aqULPXM90PeUxqRFo2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ypd7Ghx5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864442; x=1753400442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJETY7oq4HOQRRx5/4Rg5HQFKLcHVmr9t47uBsUdH5Y=;
  b=Ypd7Ghx5UNeshrTXhg9jovq/xV+1bLoIm+QAP7S99litZSKjlncuEFGW
   InVdxGTigK89cZAXng2awH9rfhjkj//LfuDD/yPTuW8kWUHbbIiZaVdOL
   gRo4s0S4XhzCqBIcugtfkIlEDR4N1ocJg4FqKW582XynQ04ieUSRmZPHf
   dd8KfLV+0ybEmk9VgCPjaJU/H2AudHu5+Ez8sgdsVOxHONi2W/Z8f5B97
   bHdNMDI1USK3TjKhNDwT8ykKD5C4njMlH5KEmG4ejJCUCrn3pjia2G4S9
   MoMmN6bEp8i9QIqV/PlwDtpiW8WnjERyjYzcmOloaow0biTFQz8hBnrJ3
   Q==;
X-CSE-ConnectionGUID: 6RLnvFmHTYehE0icSncRsA==
X-CSE-MsgGUID: KE2m3rVUSI2WIGMTxH2h+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999760"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999760"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:40 -0700
X-CSE-ConnectionGUID: TLuHYI2pTcmT3WGbSkPdZA==
X-CSE-MsgGUID: /C+ognMKSAqu4ny//0iOWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426033"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:39 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 09/25] idpf: implement get lan mmio memory regions
Date: Wed, 24 Jul 2024 18:39:01 -0500
Message-Id: <20240724233917.704-10-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

The rdma driver needs to map its own mmio regions for the sake of
performance, meaning the idpf needs to avoid mapping portions of the bar
space. However, to be vendor agnostic, the idpf cannot assume where
these are and must avoid mapping hard coded regions.  Instead, the idpf
will map the bare minimum to load and communicate with the control
plane, i.e. the mailbox registers and the reset state registers. The
idpf will then call a new virtchnl op to fetch a list of mmio regions
that it should map. All other registers will calculate which region they
should store their address from.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          |  66 +++++++++-
 drivers/net/ethernet/intel/idpf/idpf_controlq.h |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c      |  35 +++---
 drivers/net/ethernet/intel/idpf/idpf_idc.c      |  26 +++-
 drivers/net/ethernet/intel/idpf/idpf_main.c     |  36 +++++-
 drivers/net/ethernet/intel/idpf/idpf_mem.h      |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c   |  31 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 154 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h     |  30 ++++-
 9 files changed, 355 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 8ab4b935..5240a44 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -192,7 +192,8 @@ struct idpf_vport_max_q {
  * @trigger_reset: Trigger a reset to occur
  */
 struct idpf_reg_ops {
-	void (*ctlq_reg_init)(struct idpf_ctlq_create_info *cq);
+	void (*ctlq_reg_init)(struct idpf_adapter *adapter,
+			      struct idpf_ctlq_create_info *cq);
 	int (*intr_reg_init)(struct idpf_vport *vport);
 	void (*mb_intr_reg_init)(struct idpf_adapter *adapter);
 	void (*reset_reg_init)(struct idpf_adapter *adapter);
@@ -200,6 +201,11 @@ struct idpf_reg_ops {
 			      enum idpf_flags trig_cause);
 };
 
+#define IDPF_PF_MBX_REGION_SZ		4096
+#define IDPF_PF_RSTAT_REGION_SZ		2048
+#define IDPF_VF_MBX_REGION_SZ		10240
+#define IDPF_VF_RSTAT_REGION_SZ		2048
+
 /**
  * struct idpf_dev_ops - Device specific operations
  * @reg_ops: Register operations
@@ -208,6 +214,11 @@ struct idpf_dev_ops {
 	struct idpf_reg_ops reg_ops;
 
 	int (*idc_init)(struct idpf_adapter *adapter);
+
+	resource_size_t mbx_reg_start;
+	resource_size_t mbx_reg_sz;
+	resource_size_t rstat_reg_start;
+	resource_size_t rstat_reg_sz;
 };
 
 /**
@@ -731,6 +742,35 @@ static inline u8 idpf_get_min_tx_pkt_len(struct idpf_adapter *adapter)
 }
 
 /**
+ * idpf_get_mbx_reg_addr - Get BAR0 mailbox register address
+ * @adapter: private data struct
+ * @reg_offset: register offset value
+ *
+ * Based on the register offset, return the actual BAR0 register address
+ */
+static inline void __iomem *idpf_get_mbx_reg_addr(struct idpf_adapter *adapter,
+						  resource_size_t reg_offset)
+{
+	return (void __iomem *)(adapter->hw.mbx.addr + reg_offset);
+}
+
+/**
+ * idpf_get_rstat_reg_addr - Get BAR0 rstat register address
+ * @adapter: private data struct
+ * @reg_offset: register offset value
+ *
+ * Based on the register offset, return the actual BAR0 register address
+ */
+static inline
+void __iomem *idpf_get_rstat_reg_addr(struct idpf_adapter *adapter,
+				      resource_size_t reg_offset)
+{
+	reg_offset -= adapter->dev_ops.rstat_reg_start;
+
+	return (void __iomem *)(adapter->hw.rstat.addr + reg_offset);
+}
+
+/**
  * idpf_get_reg_addr - Get BAR0 register address
  * @adapter: private data struct
  * @reg_offset: register offset value
@@ -740,7 +780,27 @@ static inline u8 idpf_get_min_tx_pkt_len(struct idpf_adapter *adapter)
 static inline void __iomem *idpf_get_reg_addr(struct idpf_adapter *adapter,
 					      resource_size_t reg_offset)
 {
-	return (void __iomem *)(adapter->hw.hw_addr + reg_offset);
+	struct idpf_hw *hw = &adapter->hw;
+	int i;
+
+	for (i = 0; i < hw->num_lan_regs; i++) {
+		struct idpf_mmio_reg *region = &hw->lan_regs[i];
+
+		if (reg_offset >= region->addr_start &&
+		    reg_offset < (region->addr_start + region->addr_len)) {
+			reg_offset -= region->addr_start;
+
+			return (u8 __iomem *)(region->addr + reg_offset);
+		}
+	}
+
+	/* It's impossible to hit this case with offsets from the CP. But if we
+	 * do for any other reason, the kernel will panic on that register
+	 * access. Might as well do it here to make it clear what's happening.
+	 */
+	BUG();
+
+	return NULL;
 }
 
 /**
@@ -754,7 +814,7 @@ static inline bool idpf_is_reset_detected(struct idpf_adapter *adapter)
 	if (!adapter->hw.arq)
 		return true;
 
-	return !(readl(idpf_get_reg_addr(adapter, adapter->hw.arq->reg.len)) &
+	return !(readl(idpf_get_mbx_reg_addr(adapter, adapter->hw.arq->reg.len)) &
 		 adapter->hw.arq->reg.len_mask);
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.h b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
index c1aba09..96a2be2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
@@ -94,12 +94,21 @@ struct idpf_mbxq_desc {
 	u32 pf_vf_id;		/* used by CP when sending to PF */
 };
 
+struct idpf_mmio_reg {
+	void __iomem *addr;
+	resource_size_t addr_start;
+	resource_size_t addr_len;
+};
+
 /* Define the driver hardware struct to replace other control structs as needed
  * Align to ctlq_hw_info
  */
 struct idpf_hw {
-	void __iomem *hw_addr;
-	resource_size_t hw_addr_len;
+	struct idpf_mmio_reg mbx;
+	struct idpf_mmio_reg rstat;
+	/* Array of remaining LAN BAR regions */
+	int num_lan_regs;
+	struct idpf_mmio_reg *lan_regs;
 
 	struct idpf_adapter *back;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index f4c5691..c364beb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -9,9 +9,11 @@
 
 /**
  * idpf_ctlq_reg_init - initialize default mailbox registers
+ * @adapter: adapter structure
  * @cq: pointer to the array of create control queues
  */
-static void idpf_ctlq_reg_init(struct idpf_ctlq_create_info *cq)
+static void idpf_ctlq_reg_init(struct idpf_adapter *adapter,
+			       struct idpf_ctlq_create_info *cq)
 {
 	int i;
 
@@ -21,22 +23,22 @@ static void idpf_ctlq_reg_init(struct idpf_ctlq_create_info *cq)
 		switch (ccq->type) {
 		case IDPF_CTLQ_TYPE_MAILBOX_TX:
 			/* set head and tail registers in our local struct */
-			ccq->reg.head = PF_FW_ATQH;
-			ccq->reg.tail = PF_FW_ATQT;
-			ccq->reg.len = PF_FW_ATQLEN;
-			ccq->reg.bah = PF_FW_ATQBAH;
-			ccq->reg.bal = PF_FW_ATQBAL;
+			ccq->reg.head = PF_FW_ATQH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.tail = PF_FW_ATQT - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.len = PF_FW_ATQLEN - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bah = PF_FW_ATQBAH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bal = PF_FW_ATQBAL - adapter->dev_ops.mbx_reg_start;
 			ccq->reg.len_mask = PF_FW_ATQLEN_ATQLEN_M;
 			ccq->reg.len_ena_mask = PF_FW_ATQLEN_ATQENABLE_M;
 			ccq->reg.head_mask = PF_FW_ATQH_ATQH_M;
 			break;
 		case IDPF_CTLQ_TYPE_MAILBOX_RX:
 			/* set head and tail registers in our local struct */
-			ccq->reg.head = PF_FW_ARQH;
-			ccq->reg.tail = PF_FW_ARQT;
-			ccq->reg.len = PF_FW_ARQLEN;
-			ccq->reg.bah = PF_FW_ARQBAH;
-			ccq->reg.bal = PF_FW_ARQBAL;
+			ccq->reg.head = PF_FW_ARQH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.tail = PF_FW_ARQT - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.len = PF_FW_ARQLEN - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bah = PF_FW_ARQBAH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bal = PF_FW_ARQBAL - adapter->dev_ops.mbx_reg_start;
 			ccq->reg.len_mask = PF_FW_ARQLEN_ARQLEN_M;
 			ccq->reg.len_ena_mask = PF_FW_ARQLEN_ARQENABLE_M;
 			ccq->reg.head_mask = PF_FW_ARQH_ARQH_M;
@@ -124,7 +126,7 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
  */
 static void idpf_reset_reg_init(struct idpf_adapter *adapter)
 {
-	adapter->reset_reg.rstat = idpf_get_reg_addr(adapter, PFGEN_RSTAT);
+	adapter->reset_reg.rstat = idpf_get_rstat_reg_addr(adapter, PFGEN_RSTAT);
 	adapter->reset_reg.rstat_m = PFGEN_RSTAT_PFR_STATE_M;
 }
 
@@ -138,9 +140,9 @@ static void idpf_trigger_reset(struct idpf_adapter *adapter,
 {
 	u32 reset_reg;
 
-	reset_reg = readl(idpf_get_reg_addr(adapter, PFGEN_CTRL));
+	reset_reg = readl(idpf_get_rstat_reg_addr(adapter, PFGEN_CTRL));
 	writel(reset_reg | PFGEN_CTRL_PFSWR,
-	       idpf_get_reg_addr(adapter, PFGEN_CTRL));
+	       idpf_get_rstat_reg_addr(adapter, PFGEN_CTRL));
 }
 
 /**
@@ -174,4 +176,9 @@ void idpf_dev_ops_init(struct idpf_adapter *adapter)
 	idpf_reg_ops_init(adapter);
 
 	adapter->dev_ops.idc_init = idpf_idc_register;
+
+	adapter->dev_ops.mbx_reg_start = PF_FW_BASE;
+	adapter->dev_ops.mbx_reg_sz = IDPF_PF_MBX_REGION_SZ;
+	adapter->dev_ops.rstat_reg_start = PFGEN_RTRIG;
+	adapter->dev_ops.rstat_reg_sz = IDPF_PF_RSTAT_REGION_SZ;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b87a72b..c18b8c7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -394,7 +394,7 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum idc_function_type ftype)
 {
 	struct idc_rdma_core_dev_info *cdev_info;
-	int err;
+	int err, i;
 
 	adapter->cdev_info = (struct idc_rdma_core_dev_info *)
 		kzalloc(sizeof(struct idc_rdma_core_dev_info), GFP_KERNEL);
@@ -407,14 +407,36 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 	cdev_info->rdma_protocol = IDC_RDMA_PROTOCOL_ROCEV2;
 	cdev_info->ftype = ftype;
 
+	cdev_info->mapped_mem_regions =
+		kcalloc(adapter->hw.num_lan_regs,
+			sizeof(struct idc_rdma_lan_mapped_mem_region),
+			GFP_KERNEL);
+	if (!cdev_info->mapped_mem_regions) {
+		err = -ENOMEM;
+		goto err_plug_aux_dev;
+	}
+
+	cdev_info->num_memory_regions = cpu_to_le16(adapter->hw.num_lan_regs);
+	for (i = 0; i < adapter->hw.num_lan_regs; i++) {
+		cdev_info->mapped_mem_regions[i].region_addr =
+			adapter->hw.lan_regs[i].addr;
+		cdev_info->mapped_mem_regions[i].size =
+			cpu_to_le64(adapter->hw.lan_regs[i].addr_len);
+		cdev_info->mapped_mem_regions[i].start_offset =
+			cpu_to_le64(adapter->hw.lan_regs[i].addr_start);
+	}
+
 	idpf_idc_init_msix_data(adapter);
 
 	err = idpf_plug_core_aux_dev(cdev_info);
 	if (err)
-		goto err_plug_aux_dev;
+		goto err_free_mem_regions;
 
 	return 0;
 
+err_free_mem_regions:
+	kfree(cdev_info->mapped_mem_regions);
+	cdev_info->mapped_mem_regions = NULL;
 err_plug_aux_dev:
 	kfree(cdev_info);
 	adapter->cdev_info = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index f784eea..efd4342 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -76,6 +76,11 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->queue_lock);
 	mutex_destroy(&adapter->vc_buf_lock);
 
+	iounmap(adapter->hw.mbx.addr);
+	iounmap(adapter->hw.rstat.addr);
+	for (i = 0; i < adapter->hw.num_lan_regs; i++)
+		iounmap(adapter->hw.lan_regs[i].addr);
+
 	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
@@ -102,13 +107,34 @@ static int idpf_cfg_hw(struct idpf_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct idpf_hw *hw = &adapter->hw;
+	resource_size_t res_start;
+	long len;
+
+	/* Map mailbox space for virtchnl communication */
+	res_start = pci_resource_start(pdev, 0) +
+			adapter->dev_ops.mbx_reg_start;
+	len = adapter->dev_ops.mbx_reg_sz;
+	hw->mbx.addr = ioremap(res_start, len);
+	if (!hw->mbx.addr) {
+		pci_err(pdev, "failed to allocate bar0 mbx region\n");
+
+		return -ENOMEM;
+	}
+	hw->mbx.addr_start = adapter->dev_ops.mbx_reg_start;
+	hw->mbx.addr_len = len;
 
-	hw->hw_addr = pcim_iomap_table(pdev)[0];
-	if (!hw->hw_addr) {
-		pci_err(pdev, "failed to allocate PCI iomap table\n");
+	/* Map rstat space for resets */
+	res_start = pci_resource_start(pdev, 0) +
+			adapter->dev_ops.rstat_reg_start;
+	len = adapter->dev_ops.rstat_reg_sz;
+	hw->rstat.addr = ioremap(res_start, len);
+	if (!hw->rstat.addr) {
+		pci_err(pdev, "failed to allocate bar0 rstat region\n");
 
 		return -ENOMEM;
 	}
+	hw->rstat.addr_start = adapter->dev_ops.rstat_reg_start;
+	hw->rstat.addr_len = len;
 
 	hw->back = adapter;
 
@@ -155,9 +181,9 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_free;
 
-	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	err = pci_request_mem_regions(pdev, pci_name(pdev));
 	if (err) {
-		pci_err(pdev, "pcim_iomap_regions failed %pe\n", ERR_PTR(err));
+		pci_err(pdev, "pci_request_mem_regions failed %pe\n", ERR_PTR(err));
 
 		goto err_free;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_mem.h b/drivers/net/ethernet/intel/idpf/idpf_mem.h
index b21a04f..d7cc938 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_mem.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_mem.h
@@ -12,9 +12,9 @@ struct idpf_dma_mem {
 	size_t size;
 };
 
-#define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
-#define rd32(a, reg)		readl((a)->hw_addr + (reg))
-#define wr64(a, reg, value)	writeq((value), ((a)->hw_addr + (reg)))
-#define rd64(a, reg)		readq((a)->hw_addr + (reg))
+#define wr32(a, reg, value)	writel((value), ((a)->mbx.addr + (reg)))
+#define rd32(a, reg)		readl((a)->mbx.addr + (reg))
+#define wr64(a, reg, value)	writeq((value), ((a)->mbx.addr + (reg)))
+#define rd64(a, reg)		readq((a)->mbx.addr + (reg))
 
 #endif /* _IDPF_MEM_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index db6a595..5ad66b6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -9,9 +9,11 @@
 
 /**
  * idpf_vf_ctlq_reg_init - initialize default mailbox registers
+ * @adapter: adapter structure
  * @cq: pointer to the array of create control queues
  */
-static void idpf_vf_ctlq_reg_init(struct idpf_ctlq_create_info *cq)
+static void idpf_vf_ctlq_reg_init(struct idpf_adapter *adapter,
+				  struct idpf_ctlq_create_info *cq)
 {
 	int i;
 
@@ -21,22 +23,22 @@ static void idpf_vf_ctlq_reg_init(struct idpf_ctlq_create_info *cq)
 		switch (ccq->type) {
 		case IDPF_CTLQ_TYPE_MAILBOX_TX:
 			/* set head and tail registers in our local struct */
-			ccq->reg.head = VF_ATQH;
-			ccq->reg.tail = VF_ATQT;
-			ccq->reg.len = VF_ATQLEN;
-			ccq->reg.bah = VF_ATQBAH;
-			ccq->reg.bal = VF_ATQBAL;
+			ccq->reg.head = VF_ATQH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.tail = VF_ATQT - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.len = VF_ATQLEN - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bah = VF_ATQBAH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bal = VF_ATQBAL - adapter->dev_ops.mbx_reg_start;
 			ccq->reg.len_mask = VF_ATQLEN_ATQLEN_M;
 			ccq->reg.len_ena_mask = VF_ATQLEN_ATQENABLE_M;
 			ccq->reg.head_mask = VF_ATQH_ATQH_M;
 			break;
 		case IDPF_CTLQ_TYPE_MAILBOX_RX:
 			/* set head and tail registers in our local struct */
-			ccq->reg.head = VF_ARQH;
-			ccq->reg.tail = VF_ARQT;
-			ccq->reg.len = VF_ARQLEN;
-			ccq->reg.bah = VF_ARQBAH;
-			ccq->reg.bal = VF_ARQBAL;
+			ccq->reg.head = VF_ARQH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.tail = VF_ARQT - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.len = VF_ARQLEN - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bah = VF_ARQBAH - adapter->dev_ops.mbx_reg_start;
+			ccq->reg.bal = VF_ARQBAL - adapter->dev_ops.mbx_reg_start;
 			ccq->reg.len_mask = VF_ARQLEN_ARQLEN_M;
 			ccq->reg.len_ena_mask = VF_ARQLEN_ARQENABLE_M;
 			ccq->reg.head_mask = VF_ARQH_ARQH_M;
@@ -123,7 +125,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
  */
 static void idpf_vf_reset_reg_init(struct idpf_adapter *adapter)
 {
-	adapter->reset_reg.rstat = idpf_get_reg_addr(adapter, VFGEN_RSTAT);
+	adapter->reset_reg.rstat = idpf_get_rstat_reg_addr(adapter, VFGEN_RSTAT);
 	adapter->reset_reg.rstat_m = VFGEN_RSTAT_VFR_STATE_M;
 }
 
@@ -172,4 +174,9 @@ void idpf_vf_dev_ops_init(struct idpf_adapter *adapter)
 	idpf_vf_reg_ops_init(adapter);
 
 	adapter->dev_ops.idc_init = idpf_idc_vf_register;
+
+	adapter->dev_ops.mbx_reg_start = VF_BASE;
+	adapter->dev_ops.mbx_reg_sz = IDPF_VF_MBX_REGION_SZ;
+	adapter->dev_ops.rstat_reg_start = VFGEN_RSTAT;
+	adapter->dev_ops.rstat_reg_sz = IDPF_VF_RSTAT_REGION_SZ;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e9a71d3..dd3473c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -892,6 +892,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 	caps.other_caps =
 		cpu_to_le64(VIRTCHNL2_CAP_SRIOV			|
 			    VIRTCHNL2_CAP_RDMA                  |
+			    VIRTCHNL2_CAP_LAN_MEMORY_REGIONS	|
 			    VIRTCHNL2_CAP_MACFILTER		|
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
@@ -914,6 +915,133 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 }
 
 /**
+ * idpf_send_get_lan_memory_regions - Send virtchnl get LAN memory regions msg
+ * @adapter: Driver specific private struct
+ */
+static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_get_lan_memory_regions *rcvd_regions;
+	struct idpf_vc_xn_params xn_params = {};
+	int num_regions, size, i;
+	struct idpf_hw *hw;
+	ssize_t reply_sz;
+	int err = 0;
+
+	rcvd_regions = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!rcvd_regions)
+		return -ENOMEM;
+
+	xn_params.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS;
+	xn_params.recv_buf.iov_base = rcvd_regions;
+	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
+	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0) {
+		err = reply_sz;
+		goto send_get_lan_regions_out;
+	}
+
+	num_regions = le16_to_cpu(rcvd_regions->num_memory_regions);
+	size = struct_size(rcvd_regions, mem_reg, num_regions);
+	if (reply_sz < size) {
+		err = -EIO;
+		goto send_get_lan_regions_out;
+	}
+
+	if (size > IDPF_CTLQ_MAX_BUF_LEN) {
+		err = -EINVAL;
+		goto send_get_lan_regions_out;
+	}
+
+	hw = &adapter->hw;
+	hw->lan_regs =
+		kcalloc(num_regions, sizeof(struct idpf_mmio_reg), GFP_ATOMIC);
+	if (!hw->lan_regs) {
+		err = -ENOMEM;
+		goto send_get_lan_regions_out;
+	}
+
+	for (i = 0; i < num_regions; i++) {
+		hw->lan_regs[i].addr_len =
+			le64_to_cpu(rcvd_regions->mem_reg[i].size);
+		hw->lan_regs[i].addr_start =
+			le64_to_cpu(rcvd_regions->mem_reg[i].start_offset);
+	}
+	hw->num_lan_regs = num_regions;
+
+send_get_lan_regions_out:
+	kfree(rcvd_regions);
+
+	return err;
+}
+
+/**
+ * idpf_calc_remaining_mmio_regs - calcuate MMIO regions outside mbx and rstat
+ * @adapter: Driver specific private structure
+ *
+ * Called when idpf_send_get_lan_memory_regions fails or is not supported. This
+ * will calculate the offsets and sizes for the regions before, in between, and
+ * after the mailbox and rstat MMIO mappings.
+ */
+static int idpf_calc_remaining_mmio_regs(struct idpf_adapter *adapter)
+{
+	struct idpf_hw *hw = &adapter->hw;
+
+	hw->num_lan_regs = 3;
+	hw->lan_regs = kcalloc(hw->num_lan_regs,
+			       sizeof(struct idpf_mmio_reg),
+			       GFP_ATOMIC);
+	if (!hw->lan_regs)
+		return -ENOMEM;
+
+	/* Region preceding mailbox */
+	hw->lan_regs[0].addr_start = 0;
+	hw->lan_regs[0].addr_len = adapter->dev_ops.mbx_reg_start;
+	/* Region between mailbox and rstat */
+	hw->lan_regs[1].addr_start = adapter->dev_ops.mbx_reg_start +
+					adapter->dev_ops.mbx_reg_sz;
+	hw->lan_regs[1].addr_len = adapter->dev_ops.rstat_reg_start -
+					hw->lan_regs[1].addr_start;
+	/* Region after rstat */
+	hw->lan_regs[2].addr_start = adapter->dev_ops.rstat_reg_start +
+					adapter->dev_ops.rstat_reg_sz;
+	hw->lan_regs[2].addr_len = pci_resource_len(adapter->pdev, 0) -
+					hw->lan_regs[2].addr_start;
+
+	return 0;
+}
+
+/**
+ * idpf_map_lan_mmio_regs - map remaining LAN BAR regions
+ * @adapter: Driver specific private structure
+ */
+static int idpf_map_lan_mmio_regs(struct idpf_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct idpf_hw *hw = &adapter->hw;
+	int i;
+
+	for (i = 0; i < hw->num_lan_regs; i++) {
+		resource_size_t res_start;
+		long len;
+
+		len = hw->lan_regs[i].addr_len;
+		if (!len)
+			continue;
+		res_start = hw->lan_regs[i].addr_start;
+		res_start += pci_resource_start(pdev, 0);
+
+		hw->lan_regs[i].addr = ioremap(res_start, len);
+		if (!hw->lan_regs[i].addr) {
+			pci_err(pdev, "failed to allocate bar0 region\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * idpf_vport_alloc_max_qs - Allocate max queues for a vport
  * @adapter: Driver specific private structure
  * @max_q: vport max queue structure
@@ -2778,7 +2906,7 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 	struct idpf_hw *hw = &adapter->hw;
 	int err;
 
-	adapter->dev_ops.reg_ops.ctlq_reg_init(ctlq_info);
+	adapter->dev_ops.reg_ops.ctlq_reg_init(adapter, ctlq_info);
 
 	err = idpf_ctlq_init(hw, IDPF_NUM_DFLT_MBX_Q, ctlq_info);
 	if (err)
@@ -2938,6 +3066,30 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		msleep(task_delay);
 	}
 
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LAN_MEMORY_REGIONS)) {
+		err = idpf_send_get_lan_memory_regions(adapter);
+		if (err) {
+			dev_err(&adapter->pdev->dev, "Failed to get LAN memory regions: %d\n",
+				err);
+			return -EINVAL;
+		}
+	} else {
+		/* Fallback to mapping the remaining regions of the entire BAR */
+		err = idpf_calc_remaining_mmio_regs(adapter);
+		if (err) {
+			dev_err(&adapter->pdev->dev, "Failed to allocate bar0 region(s): %d\n",
+				err);
+			return -ENOMEM;
+		}
+	}
+
+	err = idpf_map_lan_mmio_regs(adapter);
+	if (err) {
+		dev_err(&adapter->pdev->dev, "Failed to map bar0 region(s): %d\n",
+			err);
+		return -ENOMEM;
+	}
+
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
 	adapter->max_vports = num_max_vports;
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index e6541152..92ab03c 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -69,6 +69,8 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_ADD_MAC_ADDR		= 535,
 	VIRTCHNL2_OP_DEL_MAC_ADDR		= 536,
 	VIRTCHNL2_OP_CONFIG_PROMISCUOUS_MODE	= 537,
+	/* Opcodes 538 through 548 are reserved. */
+	VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS     = 549,
 };
 
 /**
@@ -202,7 +204,8 @@ enum virtchnl2_cap_other {
 	VIRTCHNL2_CAP_RX_FLEX_DESC		= BIT_ULL(17),
 	VIRTCHNL2_CAP_PTYPE			= BIT_ULL(18),
 	VIRTCHNL2_CAP_LOOPBACK			= BIT_ULL(19),
-	/* Other capability 20 is reserved */
+	/* Other capability 20-21 is reserved */
+	VIRTCHNL2_CAP_LAN_MEMORY_REGIONS	= BIT_ULL(22),
 
 	/* this must be the last capability */
 	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
@@ -1283,4 +1286,29 @@ struct virtchnl2_promisc_info {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_promisc_info);
 
+/**
+ * struct virtchnl2_mem_region - MMIO memory region
+ * @start_offset: starting offset of the MMIO memory region
+ * @size: size of the MMIO memory region
+ */
+struct virtchnl2_mem_region {
+	__le64 start_offset;
+	__le64 size;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_mem_region);
+
+/**
+ * struct vitchnl2_mem_region - List of LAN MMIO memory regions
+ * @num_memory_regions: number of memory regions
+ * @mem_reg: List with memory region info
+ *
+ * PF/VF sends this message to learn what LAN MMIO memory regions it should map.
+ */
+struct virtchnl2_get_lan_memory_regions {
+	__le16 num_memory_regions;
+	u8 pad[6];
+	struct virtchnl2_mem_region mem_reg[];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_get_lan_memory_regions);
+
 #endif /* _VIRTCHNL_2_H_ */
-- 
1.8.3.1


