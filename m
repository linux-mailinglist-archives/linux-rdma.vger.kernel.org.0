Return-Path: <linux-rdma+bounces-22488-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6ZhHgM/PmpICAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22488-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 10:57:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCA6CB843
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 10:57:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=zte.com.cn (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22488-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22488-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB5330427F7
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977E3E7166;
	Fri, 26 Jun 2026 08:55:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85A3750B9;
	Fri, 26 Jun 2026 08:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464122; cv=none; b=FriXFJZ3j6LDHd/z1P7a7E6Ce8FI93Ky+rFtauGiaB5wrHY23OMCT7IvSKPGwI5U2CoP/pg+EZAdhbZlsDKZFlB0jS1Wtp6q08GXkhwPH64pVF2Uy4MuIPEJK9rMPoMrkL6QMiJYqSo/Yn4wDl7UoJqY3JP4NhiczLAuHPogOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464122; c=relaxed/simple;
	bh=XFuRyGv2YPqL1JDsyEY+THV3rpzt7OdRWrntw/CpiFY=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=iEzRGxCRt52LICVxZ/QvsQDv+md95M1CdlevT08nKvHBGlW15bOvitwlRW9wNysNqWUEMMjZX5X9VhgbcodX0aLjRN0gQbRaIAKdc/5k7YQBQx8uuNj9D2+PYjfq3AchszlZkwKg89KaHGF2JbfhFGp6H7NHDIDJ+ogdAwLiU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gmqJ24KgWz4xPRw;
	Fri, 26 Jun 2026 16:55:14 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 65Q8t2v6075227;
	Fri, 26 Jun 2026 16:55:02 +0800 (+08)
	(envelope-from zhang.yanze@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 26 Jun 2026 16:55:05 +0800 (CST)
X-Zmail-TransId: 2b036a3e3e69d74-1118d
X-Mailer: Zmail v1.0
Message-ID: <20260626165505082xW3GPTrWr02i4-EDMdoxz@zte.com.cn>
In-Reply-To: <20260626165050955lBuUhmj0yLn5xCsQ-tbx4@zte.com.cn>
References: 20260626165050955lBuUhmj0yLn5xCsQ-tbx4@zte.com.cn
Date: Fri, 26 Jun 2026 16:55:05 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.yanze@zte.com.cn>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <julianbraha@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <wei.quan@zte.com.cn>, <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHJkbWEgdjIgMi8yXSBSRE1BL3pyZG1hOiBBZGQgaGFyZHdhcmUgY29uZmlnIGNvZGUgYW5kIGltcHJvdmUgZHJpdmVyIGluaXQgZmxvdw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65Q8t2v6075227
X-TLS: YES
X-ENVELOPE-SENDER: zhang.yanze@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 26 Jun 2026 16:55:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3E3E72.000/4gmqJ24KgWz4xPRw
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22488-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:julianbraha@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,s:lists@lfdr.de];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,zte.com.cn:mid,zte.com.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9BCA6CB843

From: Yanze Zhang <zhang.yanze@zte.com.cn>

Add hardware config code and improve driver init flow
- Add TX/RX/IO register configuration logic to new zrdma_hw.c
- Add zrdma_defs.h for common bitfield masks and constants
- Add zrdma_uk.h for shared enum definitions
- Update Makefile to build zrdma_hw.o as separate module
- Call zxdh_ctrl_init_hw() in probe and add proper cleanup on error

Signed-off-by: Yanze Zhang <zhang.yanze@zte.com.cn>
---
drivers/infiniband/hw/zrdma/Makefile     |   4 +-
drivers/infiniband/hw/zrdma/zrdma_defs.h |  37 ++++++
drivers/infiniband/hw/zrdma/zrdma_hw.c   | 135 ++++++++++++++++++++
drivers/infiniband/hw/zrdma/zrdma_hw.h   | 156 +++++++++++++++++++++++
drivers/infiniband/hw/zrdma/zrdma_main.c |  14 ++
drivers/infiniband/hw/zrdma/zrdma_main.h |   1 +
drivers/infiniband/hw/zrdma/zrdma_mem.h  |   2 +
drivers/infiniband/hw/zrdma/zrdma_uk.h   |  18 +++
8 files changed, 366 insertions(+), 1 deletion(-)
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_defs.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_hw.c
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_hw.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_uk.h

diff --git a/drivers/infiniband/hw/zrdma/Makefile b/drivers/infiniband/hw/zrdma/Makefile
index b5297543e393..128bf98fd731 100644
--- a/drivers/infiniband/hw/zrdma/Makefile
+++ b/drivers/infiniband/hw/zrdma/Makefile
@@ -1,4 +1,6 @@
# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

obj-$(CONFIG_INFINIBAND_ZRDMA) += zrdma.o
-zrdma-y := zrdma_main.o
+zrdma-y := \
+           zrdma_hw.o \
+           zrdma_main.o
diff --git a/drivers/infiniband/hw/zrdma/zrdma_defs.h b/drivers/infiniband/hw/zrdma/zrdma_defs.h
new file mode 100644
index 000000000000..512a426281e6
--- /dev/null
+++ b/drivers/infiniband/hw/zrdma/zrdma_defs.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * ZTE DingHai Rdma driver
+ * Copyright (c) 2022-2026, ZTE Corporation
+ */
+
+#ifndef ZRDMA_DEFS_H
+#define ZRDMA_DEFS_H
+
+#include <linux/bitfield.h>
+#include <rdma/ib_verbs.h>
+
+/* RDMA TX DDR Access REG Masks */
+#define ZXDH_TX_CACHE_ID GENMASK_ULL(1, 0)
+#define ZXDH_TX_INDICATE_ID GENMASK_ULL(3, 2)
+#define ZXDH_TX_AXI_ID GENMASK_ULL(6, 4)
+#define ZXDH_TX_WAY_PARTITION GENMASK_ULL(9, 7)
+
+/* RDMA RX DDR Access REG Masks */
+#define ZXDH_RX_CACHE_ID GENMASK_ULL(1, 0)
+#define ZXDH_RX_INDICATE_ID GENMASK_ULL(3, 2)
+#define ZXDH_RX_AXI_ID GENMASK_ULL(6, 4)
+#define ZXDH_RX_WAY_PARTITION GENMASK_ULL(9, 7)
+
+/* RDMA IO REG Masks */
+#define ZXDH_IOTABLE2_SID GENMASK_ULL(5, 0)
+
+#define ZXDH_IOTABLE4_EPID GENMASK_ULL(14, 11)
+#define ZXDH_IOTABLE4_VFID GENMASK_ULL(10, 3)
+#define ZXDH_IOTABLE4_PFID GENMASK_ULL(2, 0)
+
+#define ZXDH_IOTABLE7_PFID GENMASK_ULL(4, 2)
+#define ZXDH_IOTABLE7_EPID GENMASK_ULL(8, 5)
+
+#define RDMARX_MAX_MSG_SIZE 0x80000000
+
+#endif /* ZRDMA_DEFS_H */
diff --git a/drivers/infiniband/hw/zrdma/zrdma_hw.c b/drivers/infiniband/hw/zrdma/zrdma_hw.c
new file mode 100644
index 000000000000..38eeb1f21d0b
--- /dev/null
+++ b/drivers/infiniband/hw/zrdma/zrdma_hw.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE DingHai Rdma driver
+ * Copyright (c) 2022-2026, ZTE Corporation
+ */
+
+#include "zrdma_hw.h"
+#include "zrdma_ctrl.h"
+#include "zrdma_mem.h"
+
+static void zxdh_config_tx_regs(struct zxdh_sc_dev *dev)
+{
+   u32 temp;
+
+   temp = FIELD_PREP(ZXDH_TX_CACHE_ID, 0) |
+          FIELD_PREP(ZXDH_TX_INDICATE_ID, ZXDH_INDICATE_HOST_NOSMMU) |
+          FIELD_PREP(ZXDH_TX_AXI_ID, (ZXDH_AXID_HOST_EP0 + dev->ep_id)) |
+          FIELD_PREP(ZXDH_TX_WAY_PARTITION, 0);
+
+   writel(temp, dev->hw->hw_addr + RDMATX_ACK_SQWQE_PARA_CFG);
+   writel(temp, dev->hw->hw_addr + RDMATX_ACK_DDR_PARA_CFG);
+   writel(temp, dev->hw->hw_addr + RDMATX_DB_SQWQE_ID_CFG);
+   writel(temp, dev->hw->hw_addr + RDMATX_SQWQE_PARA_CFG);
+   writel(temp, dev->hw->hw_addr + RDMATX_PAYLOAD_PARA_CFG);
+
+   if (dev->hmc_use_dpu_ddr) {
+       temp = FIELD_PREP(ZXDH_TX_CACHE_ID, dev->cache_id) |
+              FIELD_PREP(ZXDH_TX_INDICATE_ID, ZXDH_INDICATE_DPU_DDR) |
+              FIELD_PREP(ZXDH_TX_AXI_ID,
+                 (ZXDH_AXID_HOST_EP0 + dev->ep_id)) |
+              FIELD_PREP(ZXDH_TX_WAY_PARTITION, 0);
+   } else {
+       temp = FIELD_PREP(ZXDH_TX_CACHE_ID, dev->cache_id) |
+              FIELD_PREP(ZXDH_TX_INDICATE_ID,
+                 ZXDH_INDICATE_HOST_SMMU) |
+              FIELD_PREP(ZXDH_TX_AXI_ID,
+                 (ZXDH_AXID_HOST_EP0 + dev->ep_id)) |
+              FIELD_PREP(ZXDH_TX_WAY_PARTITION, 0);
+   }
+   writel(temp, dev->hw->hw_addr + C_HMC_MRTE_TX2);
+   writel(temp, dev->hw->hw_addr + C_HMC_PBLEMR_TX2);
+   writel((ZXDH_AXID_HOST_EP0 + dev->ep_id),
+          dev->hw->hw_addr + RDMATX_HOSTID_CFG);
+}
+
+static void zxdh_config_rx_regs(struct zxdh_sc_dev *dev)
+{
+   u32 temp;
+
+   temp = FIELD_PREP(ZXDH_RX_CACHE_ID, 0) |
+          FIELD_PREP(ZXDH_RX_INDICATE_ID, ZXDH_INDICATE_HOST_NOSMMU) |
+          FIELD_PREP(ZXDH_RX_AXI_ID, (ZXDH_AXID_HOST_EP0 + dev->ep_id)) |
+          FIELD_PREP(ZXDH_RX_WAY_PARTITION, 0);
+
+   writel(temp, dev->hw->hw_addr + RDMARX_PLD_WR_AXIID_RAM);
+   writel(temp, dev->hw->hw_addr + RDMARX_RQ_AXI_RAM);
+   writel(temp, dev->hw->hw_addr + RDMARX_SRQ_AXI_RAM);
+   writel(temp, dev->hw->hw_addr + RDMARX_ACK_RQDB_AXI_RAM);
+   writel(temp, dev->hw->hw_addr + RDMARX_CQ_CQE_AXI_INFO_RAM);
+   writel(temp, dev->hw->hw_addr + RDMARX_CQ_DBSA_AXI_INFO_RAM);
+   writel(dev->hmc_fn_id,
+          dev->hw->hw_addr + RDMARX_MUL_CACHE_CFG_SIDN_RAM);
+   writel((ZXDH_AXID_HOST_EP0 + dev->ep_id),
+          dev->hw->hw_addr + RDMARX_MUL_COPY_QPN_INDICATE);
+   writel(RDMARX_MAX_MSG_SIZE,
+          dev->hw->hw_addr + RDMARX_VHCA_MAX_SIZE_RAM);
+}
+
+static void zxdh_config_io_regs(struct zxdh_sc_dev *dev)
+{
+   u32 temp0, temp1, temp2;
+   struct zxdh_pci_f *rf = container_of(dev, struct zxdh_pci_f, sc_dev);
+
+   temp0 = FIELD_PREP(ZXDH_IOTABLE2_SID, dev->hmc_fn_id);
+   writel(temp0, dev->hw->hw_addr + C_RDMAIO_TABLE2);
+
+   temp1 = FIELD_PREP(ZXDH_IOTABLE4_EPID,
+              (ZXDH_HOST_EP0_ID + dev->ep_id)) |
+       FIELD_PREP(ZXDH_IOTABLE4_VFID, dev->vf_id) |
+       FIELD_PREP(ZXDH_IOTABLE4_PFID, rf->pf_id);
+   writel(temp1, dev->hw->hw_addr + C_RDMAIO_TABLE4);
+
+   temp0 = 0x10000;
+   writel(temp0, dev->hw->hw_addr + C_RDMAIO_TABLE3);
+   for (temp0 = 0; temp0 < 32; temp0++) {
+       if (temp0 < ZXDH_RW_PAYLOAD || temp0 == ZXDH_QPC_OBJ_ID) {
+           writel(0, dev->hw->hw_addr +
+                     (C_RDMAIO_TABLE5_0 + (temp0 * 4)));
+       } else {
+           temp2 = (rf->ftype == 0) ? 0 : ZXDH_TABLE5_VF_EN;
+           writel(temp2, dev->hw->hw_addr + (C_RDMAIO_TABLE5_0 +
+                             (temp0 * 4)));
+       }
+   }
+
+   if (rf->ftype == 0) {
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_0);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_1);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_2);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_3);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_4);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_5);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_6);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_7);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_8);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_9);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_10);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_11);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_12);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_13);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_14);
+       writel(0, dev->hw->hw_addr + C_RDMAIO_TABLE6_15);
+
+       temp2 = FIELD_PREP(ZXDH_IOTABLE7_PFID, rf->pf_id) |
+           FIELD_PREP(ZXDH_IOTABLE7_EPID,
+                  (ZXDH_HOST_EP0_ID + rf->ep_id));
+       writel(temp2, dev->hw->hw_addr + C_RDMAIO_TABLE7);
+   }
+}
+
+static void zxdh_config_hw_regs(struct zxdh_sc_dev *dev)
+{
+   zxdh_config_tx_regs(dev);
+   zxdh_config_rx_regs(dev);
+   zxdh_config_io_regs(dev);
+}
+
+int zxdh_ctrl_init_hw(struct zxdh_pci_f *rf)
+{
+   struct zxdh_sc_dev *dev = &rf->sc_dev;
+
+   zxdh_config_hw_regs(dev);
+
+   return 0;
+}
diff --git a/drivers/infiniband/hw/zrdma/zrdma_hw.h b/drivers/infiniband/hw/zrdma/zrdma_hw.h
new file mode 100644
index 000000000000..bfbe20461900
--- /dev/null
+++ b/drivers/infiniband/hw/zrdma/zrdma_hw.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * ZTE DingHai Rdma driver
+ * Copyright (c) 2022-2026, ZTE Corporation
+ */
+
+#ifndef ZRDMA_HW_H
+#define ZRDMA_HW_H
+#include "zrdma_main.h"
+
+/**************** ZTE RDMA Registers ***************/
+#define C_RDMA_RX_VHCA_REG_IDX (0x3400)
+#define C_RDMA_TX_VHCA_REG_IDX (0x5800)
+#define C_RDMA_IO_VHCA_REG_IDX (0x6000)
+#define C_RDMA_IO_SIDN_REG_IDX (0x7800)
+
+/* rdmatx_ack_recv_vhca_pfvf */
+#define RDMATX_ACK_SQWQE_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x001u)
+#define RDMATX_ACK_DDR_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x004u)
+#define RDMATX_ACK_PCI_MAX_MRTE_INDEX_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x005u)
+
+/* rdmatx_doorbell_mgr_vhca_pfvf */
+#define RDMATX_DB_PBLE_ID_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x100u)
+#define RDMATX_DB_SQWQE_ID_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x103u)
+#define RDMATX_QPN_BASEQPN_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x109u)
+#define RDMATX_QPN_CONTEXT_ID_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x10Au)
+#define RDMATX_QUEUE_VHCA_FLAG (C_RDMA_TX_VHCA_REG_IDX + 0x112u)
+
+/* rdmatx_wqe_parse_vhca_pfvf */
+#define RDMATX_SQWQE_PBLE_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x300u)
+#define RDMATX_SQWQE_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x301u)
+#define RDMATX_AH_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x302u)
+#define RDMATX_LOCAL_MRTE_PARENT_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 303u)
+#define RDMATX_LOCAL_MRTE_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x304u)
+#define RDMATX_SGETRAN_MRTE_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x305u)
+#define RDMATX_SGETRAN_PBLE_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x306u)
+#define RDMATX_PAYLOAD_PARA_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x307u)
+#define RDMATX_HOSTID_CFG (C_RDMA_TX_VHCA_REG_IDX + 0x308u)
+
+/******************************MRTE***************************/
+#define C_HMC_MRTE_RX1 (C_RDMA_RX_VHCA_REG_IDX + 0x0c0u)
+#define C_HMC_MRTE_RX2 (C_RDMA_RX_VHCA_REG_IDX + 0x183u)
+
+#define C_HMC_MRTE_TX1 (C_RDMA_TX_VHCA_REG_IDX + 0x002u)
+#define C_HMC_MRTE_TX2 (C_RDMA_TX_VHCA_REG_IDX + 0x305u)
+#define C_HMC_MRTE_TX3 (C_RDMA_TX_VHCA_REG_IDX + 0x304u)
+
+#define C_HMC_MRTE_RDMAIO_INDICATE (C_RDMA_IO_VHCA_REG_IDX + 0x012u)
+#define C_HMC_MRTE_RDMAIO_BASE_LOW (C_RDMA_IO_VHCA_REG_IDX + 0x004u)
+#define C_HMC_MRTE_RDMAIO_BASE_HIGH (C_RDMA_IO_VHCA_REG_IDX + 0x005u)
+
+/* rdmarx_pkt_proc_pfvf */
+#define RDMARX_MUL_CACHE_CFG_SIDN_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x006u)
+#define RDMARX_MUL_COPY_QPN_INDICATE (C_RDMA_RX_VHCA_REG_IDX + 0x085u)
+
+/* rdma_rdmarx_hd_cache_top_pfvf */
+#define RDMARX_LIST_CACHE_BASE_QPN (C_RDMA_RX_VHCA_REG_IDX + 0x0A3u)
+#define RDMARX_PLD_WR_AXIID_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x0C1u)
+
+/* rdmarx_prifield_check_pfvf */
+#define RDMARX_VHCA_MAX_SIZE_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x100u)
+
+/* rdmarx_ceq_pfvf */
+#define C_CEQ_CEQE_AXI_INFO_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x1A0u)
+#define C_CEQ_RPBLE_AXI_INFO_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x1A1u)
+#define C_CEQ_LPBLE_AXI_INFO_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x1A2u)
+#define C_CEQ_INT_INFO_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x1A3u)
+#define RDMARX_ACK_RQDB_AXI_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x180u)
+
+/* rdmarx_completion_queue_pfvf */
+#define RDMARX_CQ_CQN_BASE_OFFSET_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x160u)
+#define RDMARX_CQ_CQE_AXI_INFO_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x165u)
+#define RDMARX_CQ_DBSA_AXI_INFO_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x166u)
+
+/* rdmarx_completion_queue_pf */
+#define RDMARX_RQ_AXI_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x140u)
+#define RDMARX_SRQ_AXI_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x142u)
+#define RDMARX_PCI_MAX_MRTE_INDEX_RAM (C_RDMA_RX_VHCA_REG_IDX + 0x143u)
+
+/****** IO Module Register ******/
+#define C_RDMAIO_TABLE2 (C_RDMA_IO_VHCA_REG_IDX + 0x018u)
+#define C_RDMAIO_TABLE4 (C_RDMA_IO_VHCA_REG_IDX + 0x020u)
+#define C_RDMAIO_TABLE3 (C_RDMA_IO_VHCA_REG_IDX + 0x01cu)
+
+#define C_RDMAIO_TABLE5_0 (C_RDMA_IO_VHCA_REG_IDX + 0x024u)
+#define C_RDMAIO_TABLE5_1 (C_RDMA_IO_VHCA_REG_IDX + 0x025u)
+#define C_RDMAIO_TABLE5_2 (C_RDMA_IO_VHCA_REG_IDX + 0x026u)
+#define C_RDMAIO_TABLE5_3 (C_RDMA_IO_VHCA_REG_IDX + 0x027u)
+
+#define C_RDMAIO_TABLE5_4 (C_RDMA_IO_VHCA_REG_IDX + 0x028u)
+#define C_RDMAIO_TABLE5_5 (C_RDMA_IO_VHCA_REG_IDX + 0x029u)
+#define C_RDMAIO_TABLE5_6 (C_RDMA_IO_VHCA_REG_IDX + 0x02au)
+#define C_RDMAIO_TABLE5_7 (C_RDMA_IO_VHCA_REG_IDX + 0x02bu)
+
+#define C_RDMAIO_TABLE5_8 (C_RDMA_IO_VHCA_REG_IDX + 0x02cu)
+#define C_RDMAIO_TABLE5_9 (C_RDMA_IO_VHCA_REG_IDX + 0x02du)
+#define C_RDMAIO_TABLE5_10 (C_RDMA_IO_VHCA_REG_IDX + 0x02eu)
+#define C_RDMAIO_TABLE5_11 (C_RDMA_IO_VHCA_REG_IDX + 0x02fu)
+
+#define C_RDMAIO_TABLE5_12 (C_RDMA_IO_VHCA_REG_IDX + 0x030u)
+#define C_RDMAIO_TABLE5_13 (C_RDMA_IO_VHCA_REG_IDX + 0x031u)
+#define C_RDMAIO_TABLE5_14 (C_RDMA_IO_VHCA_REG_IDX + 0x032u)
+#define C_RDMAIO_TABLE5_15 (C_RDMA_IO_VHCA_REG_IDX + 0x033u)
+
+#define C_RDMAIO_TABLE5_16 (C_RDMA_IO_VHCA_REG_IDX + 0x034u)
+#define C_RDMAIO_TABLE5_17 (C_RDMA_IO_VHCA_REG_IDX + 0x035u)
+#define C_RDMAIO_TABLE5_18 (C_RDMA_IO_VHCA_REG_IDX + 0x036u)
+#define C_RDMAIO_TABLE5_19 (C_RDMA_IO_VHCA_REG_IDX + 0x037u)
+
+#define C_RDMAIO_TABLE5_20 (C_RDMA_IO_VHCA_REG_IDX + 0x038u)
+#define C_RDMAIO_TABLE5_21 (C_RDMA_IO_VHCA_REG_IDX + 0x039u)
+#define C_RDMAIO_TABLE5_22 (C_RDMA_IO_VHCA_REG_IDX + 0x03au)
+#define C_RDMAIO_TABLE5_23 (C_RDMA_IO_VHCA_REG_IDX + 0x03bu)
+
+#define C_RDMAIO_TABLE5_24 (C_RDMA_IO_VHCA_REG_IDX + 0x03cu)
+#define C_RDMAIO_TABLE5_25 (C_RDMA_IO_VHCA_REG_IDX + 0x03du)
+#define C_RDMAIO_TABLE5_26 (C_RDMA_IO_VHCA_REG_IDX + 0x03eu)
+#define C_RDMAIO_TABLE5_27 (C_RDMA_IO_VHCA_REG_IDX + 0x03fu)
+
+#define C_RDMAIO_TABLE5_28 (C_RDMA_IO_VHCA_REG_IDX + 0x040u)
+#define C_RDMAIO_TABLE5_29 (C_RDMA_IO_VHCA_REG_IDX + 0x041u)
+#define C_RDMAIO_TABLE5_30 (C_RDMA_IO_VHCA_REG_IDX + 0x042u)
+#define C_RDMAIO_TABLE5_31 (C_RDMA_IO_VHCA_REG_IDX + 0x043u)
+
+#define C_RDMAIO_TABLE7 (C_RDMA_IO_SIDN_REG_IDX + 0x000u)
+#define C_RDMAIO_TABLE6_0 (C_RDMA_IO_SIDN_REG_IDX + 0x004u)
+#define C_RDMAIO_TABLE6_1 (C_RDMA_IO_SIDN_REG_IDX + 0x005u)
+#define C_RDMAIO_TABLE6_2 (C_RDMA_IO_SIDN_REG_IDX + 0x006u)
+#define C_RDMAIO_TABLE6_3 (C_RDMA_IO_SIDN_REG_IDX + 0x007u)
+#define C_RDMAIO_TABLE6_4 (C_RDMA_IO_SIDN_REG_IDX + 0x008u)
+#define C_RDMAIO_TABLE6_5 (C_RDMA_IO_SIDN_REG_IDX + 0x009u)
+#define C_RDMAIO_TABLE6_6 (C_RDMA_IO_SIDN_REG_IDX + 0x00au)
+#define C_RDMAIO_TABLE6_7 (C_RDMA_IO_SIDN_REG_IDX + 0x00bu)
+#define C_RDMAIO_TABLE6_8 (C_RDMA_IO_SIDN_REG_IDX + 0x00cu)
+#define C_RDMAIO_TABLE6_9 (C_RDMA_IO_SIDN_REG_IDX + 0x00du)
+#define C_RDMAIO_TABLE6_10 (C_RDMA_IO_SIDN_REG_IDX + 0x00eu)
+#define C_RDMAIO_TABLE6_11 (C_RDMA_IO_SIDN_REG_IDX + 0x00fu)
+#define C_RDMAIO_TABLE6_12 (C_RDMA_IO_SIDN_REG_IDX + 0x010u)
+#define C_RDMAIO_TABLE6_13 (C_RDMA_IO_SIDN_REG_IDX + 0x011u)
+#define C_RDMAIO_TABLE6_14 (C_RDMA_IO_SIDN_REG_IDX + 0x012u)
+#define C_RDMAIO_TABLE6_15 (C_RDMA_IO_SIDN_REG_IDX + 0x013u)
+
+/**************************PF HMC REGISTER *************************/
+/******************************PBLEMR***************************/
+
+#define C_HMC_PBLEMR_RX1 (C_RDMA_RX_VHCA_REG_IDX + 0x0c2u)
+#define C_HMC_PBLEMR_RX2 (C_RDMA_RX_VHCA_REG_IDX + 0x184u)
+
+#define C_HMC_PBLEMR_TX1 (C_RDMA_TX_VHCA_REG_IDX + 0x003u)
+#define C_HMC_PBLEMR_TX2 (C_RDMA_TX_VHCA_REG_IDX + 0x306u)
+
+#define C_HMC_PBLEMR_RDMAIO_INDICATE (C_RDMA_IO_VHCA_REG_IDX + 0x010u)
+#define C_HMC_PBLEMR_RDMAIO_BASE_LOW (C_RDMA_IO_VHCA_REG_IDX + 0x000u)
+#define C_HMC_PBLEMR_RDMAIO_BASE_HIGH (C_RDMA_IO_VHCA_REG_IDX + 0x001u)
+
+#endif /* ZRDMA_HW_H */
diff --git a/drivers/infiniband/hw/zrdma/zrdma_main.c b/drivers/infiniband/hw/zrdma/zrdma_main.c
index e06ad176e6d8..116ae37ea281 100644
--- a/drivers/infiniband/hw/zrdma/zrdma_main.c
+++ b/drivers/infiniband/hw/zrdma/zrdma_main.c
@@ -69,6 +69,7 @@ static int zxdh_probe(struct auxiliary_device *aux_dev,
struct zxdh_handler *hdl;
struct zxdh_device *zdev;
struct zxdh_pci_f *rf;
+   int err;

zdev = ib_alloc_device(zxdh_device, ibdev);
if (!zdev)
@@ -94,11 +95,23 @@ static int zxdh_probe(struct auxiliary_device *aux_dev,
zdev->hdl = hdl;
zdev->netdev_speed = SPEED_UNKNOWN;

+   rf = zdev->rf;
+   err = zxdh_ctrl_init_hw(rf);
+   if (err)
+       goto err_ctrl_init;
+
zxdh_add_handler(hdl);

dev_set_drvdata(&aux_dev->dev, zdev);

return 0;
+
+err_ctrl_init:
+   kfree(hdl);
+   kfree(zdev->rf);
+   ib_dealloc_device(&zdev->ibdev);
+
+   return err;
}

static void zxdh_remove(struct auxiliary_device *aux_dev)
@@ -111,6 +124,7 @@ static void zxdh_remove(struct auxiliary_device *aux_dev)
}

zxdh_del_handler(zdev->hdl);
+   kfree(zdev->hdl);
kfree(zdev->rf);
ib_dealloc_device(&zdev->ibdev);
}
diff --git a/drivers/infiniband/hw/zrdma/zrdma_main.h b/drivers/infiniband/hw/zrdma/zrdma_main.h
index 2eb2fc802f5c..5ba18669fa14 100644
--- a/drivers/infiniband/hw/zrdma/zrdma_main.h
+++ b/drivers/infiniband/hw/zrdma/zrdma_main.h
@@ -10,6 +10,7 @@
#include <linux/auxiliary_bus.h>
#include "zrdma_type.h"
#include "zrdma_ctrl.h"
+#include "zrdma_uk.h"

#define ZXDH_PF_NAME "dinghai10e"
#define ZXDH_RDMA_DEV_NAME "rdma_aux"
diff --git a/drivers/infiniband/hw/zrdma/zrdma_mem.h b/drivers/infiniband/hw/zrdma/zrdma_mem.h
index b49df6d51d19..c81cd5ee2d31 100644
--- a/drivers/infiniband/hw/zrdma/zrdma_mem.h
+++ b/drivers/infiniband/hw/zrdma/zrdma_mem.h
@@ -7,6 +7,8 @@
#ifndef ZRDMA_MEM_H
#define ZRDMA_MEM_H

+#include "zrdma_defs.h"
+
#define ZXDH_TABLE5_VF_EN 0x04

#define ZXDH_HMC_MAX_SD_COUNT 8192
diff --git a/drivers/infiniband/hw/zrdma/zrdma_uk.h b/drivers/infiniband/hw/zrdma/zrdma_uk.h
new file mode 100644
index 000000000000..d21755a521e3
--- /dev/null
+++ b/drivers/infiniband/hw/zrdma/zrdma_uk.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * ZTE DingHai Rdma driver
+ * Copyright (c) 2022-2026, ZTE Corporation
+ */
+
+#ifndef ZRDMA_UK_H
+#define ZRDMA_UK_H
+
+enum zxdh_host_epid {
+   ZXDH_HOST_EP0_ID = 5,
+   ZXDH_HOST_EP1_ID = 6,
+   ZXDH_HOST_EP2_ID = 7,
+   ZXDH_HOST_EP3_ID = 8,
+   ZXDH_HOST_EP4_ID = 9,
+};
+
+#endif /* ZRDMA_UK_H */
--
2.27.0

