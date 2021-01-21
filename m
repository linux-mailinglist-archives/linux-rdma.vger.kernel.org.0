Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA162FF2EA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbhAUSJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbhAUJrD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B34C0617B1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j18so863905wmi.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yuu62i1MBy9SgGgF6TOSTSpWnyQgtFShBFPCZ/OtBLI=;
        b=MSpN0+4ssxyWwH66+DWlGkTjuTZll+0WUdcSDzB6T243qvcOwnmsLaKL8Sml9maeuM
         X85N+7xCyj4+8PLYsLWyWHxXfo5IKyuOYIZ4PWqbsDXCR2Lkpu8EFjPNB25Nfpp+Zunb
         cEQ4gVGGfiBCAw8gKJg1hlHXTal3tsCjJmzEBy3tu30C0NkK6OHriMeKFo5V8McOiXpe
         K2YPBpyfbLj0MlKdsk8xg0yhkAT7e/o9RXa9ZV1ABwm414i2TqWrZPXpKTvH2NQb2jFa
         Z8wfIA/nAeJj2R4c0afxAfVnFZQkM4mea3bX1xA8AnGjRIGgOVGYgiGaGUVaXGBZvvLy
         Euxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yuu62i1MBy9SgGgF6TOSTSpWnyQgtFShBFPCZ/OtBLI=;
        b=sde5P3fXxWXxSU9B7HZOsaDzXPOZlY/S1eEx0VK5NgRsKa4X+1IUqI4GrcqijmXcUn
         XK2vBKuKq6Zse/DM9ZGw944edouuMq8exFGmQqbn5ZvcARUzkbUWmiXBeX6z76gMFOqg
         /XWQtiu0OfJ4vgCOXqqXa3uOw8vbI8MqneENPOGCG2yWAlqJ3u4KFfR37tMy9kwXDc3j
         HNgvLXi6bm1j9BkEYZuozyjz+x305OjmNmVAKCYjWmRPeB9T6MIWZsabBbWLaD4KQWk7
         13DUttd8KBwful+aBH4MorpR52yzH8wV1/e2o4trVHTbJmiAdriNlojk4Up7bEiisr9X
         +pIg==
X-Gm-Message-State: AOAM533VAil73j6Qpix8yIOAPyQa0pgGJRmSFzME6TxLiZyys6orlNap
        muYruJO2T7twYEAt7CPF3kj1fQ==
X-Google-Smtp-Source: ABdhPJy2+pEZbsc3edarPA/SdsrT2nL1kPb+R9JDLvOpCmbcIPB0Pg9BGHsVy3WFlkqQdaQRBs0BtQ==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr8096769wmj.52.1611222340975;
        Thu, 21 Jan 2021 01:45:40 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 15/30] RDMA/hw/hfi1/chip: Fix a bunch of kernel-doc formatting and spelling issues
Date:   Thu, 21 Jan 2021 09:45:04 +0000
Message-Id: <20210121094519.2044049-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/chip.c:1335: warning: Function parameter or member 'dd' not described in 'hfi1_addr_from_offset'
 drivers/infiniband/hw/hfi1/chip.c:1335: warning: Function parameter or member 'offset' not described in 'hfi1_addr_from_offset'
 drivers/infiniband/hw/hfi1/chip.c:1350: warning: Function parameter or member 'dd' not described in 'read_csr'
 drivers/infiniband/hw/hfi1/chip.c:1350: warning: Function parameter or member 'offset' not described in 'read_csr'
 drivers/infiniband/hw/hfi1/chip.c:1363: warning: Function parameter or member 'dd' not described in 'write_csr'
 drivers/infiniband/hw/hfi1/chip.c:1363: warning: Function parameter or member 'offset' not described in 'write_csr'
 drivers/infiniband/hw/hfi1/chip.c:1363: warning: Function parameter or member 'value' not described in 'write_csr'
 drivers/infiniband/hw/hfi1/chip.c:1385: warning: Function parameter or member 'dd' not described in 'get_csr_addr'
 drivers/infiniband/hw/hfi1/chip.c:1385: warning: Function parameter or member 'offset' not described in 'get_csr_addr'
 drivers/infiniband/hw/hfi1/chip.c:8442: warning: Function parameter or member 'rcd' not described in 'receive_interrupt_common'
 drivers/infiniband/hw/hfi1/chip.c:8491: warning: Function parameter or member 'napi' not described in 'hfi1_netdev_rx_napi'
 drivers/infiniband/hw/hfi1/chip.c:8491: warning: Function parameter or member 'budget' not described in 'hfi1_netdev_rx_napi'
 drivers/infiniband/hw/hfi1/chip.c:14221: warning: Function parameter or member 'dd' not described in 'init_qpmap_table'
 drivers/infiniband/hw/hfi1/chip.c:14221: warning: Function parameter or member 'first_ctxt' not described in 'init_qpmap_table'
 drivers/infiniband/hw/hfi1/chip.c:14221: warning: Function parameter or member 'last_ctxt' not described in 'init_qpmap_table'
 drivers/infiniband/hw/hfi1/chip.c:14399: warning: Function parameter or member 'dd' not described in 'init_qos'
 drivers/infiniband/hw/hfi1/chip.c:14399: warning: Function parameter or member 'rmt' not described in 'init_qos'
 drivers/infiniband/hw/hfi1/chip.c:15032: warning: Function parameter or member 'dd' not described in 'hfi1_init_dd'
 drivers/infiniband/hw/hfi1/chip.c:15032: warning: Excess function parameter 'dev' description in 'hfi1_init_dd'
 drivers/infiniband/hw/hfi1/chip.c:15032: warning: Excess function parameter 'ent' description in 'hfi1_init_dd'
 drivers/infiniband/hw/hfi1/chip.c:15395: warning: Function parameter or member 'ppd' not described in 'create_pbc'
 drivers/infiniband/hw/hfi1/chip.c:15395: warning: Function parameter or member 'srate_mbs' not described in 'create_pbc'
 drivers/infiniband/hw/hfi1/chip.c:15395: warning: Function parameter or member 'dw_len' not described in 'create_pbc'
 drivers/infiniband/hw/hfi1/chip.c:15395: warning: Excess function parameter 'srate' description in 'create_pbc'
 drivers/infiniband/hw/hfi1/chip.c:15395: warning: Excess function parameter 'dwlen' description in 'create_pbc'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 46 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index c87b94ea29397..993cbf37e0b9e 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1323,8 +1323,8 @@ CNTR_ELEM(#name, \
 
 /**
  * hfi_addr_from_offset - return addr for readq/writeq
- * @dd - the dd device
- * @offset - the offset of the CSR within bar0
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
  *
  * This routine selects the appropriate base address
  * based on the indicated offset.
@@ -1340,8 +1340,8 @@ static inline void __iomem *hfi1_addr_from_offset(
 
 /**
  * read_csr - read CSR at the indicated offset
- * @dd - the dd device
- * @offset - the offset of the CSR within bar0
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
  *
  * Return: the value read or all FF's if there
  * is no mapping
@@ -1355,9 +1355,9 @@ u64 read_csr(const struct hfi1_devdata *dd, u32 offset)
 
 /**
  * write_csr - write CSR at the indicated offset
- * @dd - the dd device
- * @offset - the offset of the CSR within bar0
- * @value - value to write
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ * @value: value to write
  */
 void write_csr(const struct hfi1_devdata *dd, u32 offset, u64 value)
 {
@@ -1373,8 +1373,8 @@ void write_csr(const struct hfi1_devdata *dd, u32 offset, u64 value)
 
 /**
  * get_csr_addr - return te iomem address for offset
- * @dd - the dd device
- * @offset - the offset of the CSR within bar0
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
  *
  * Return: The iomem address to use in subsequent
  * writeq/readq operations.
@@ -8433,7 +8433,7 @@ static inline int check_packet_present(struct hfi1_ctxtdata *rcd)
 	return hfi1_rcd_head(rcd) != tail;
 }
 
-/**
+/*
  * Common code for receive contexts interrupt handlers.
  * Update traces, increment kernel IRQ counter and
  * setup ASPM when needed.
@@ -8447,7 +8447,7 @@ static void receive_interrupt_common(struct hfi1_ctxtdata *rcd)
 	aspm_ctx_disable(rcd);
 }
 
-/**
+/*
  * __hfi1_rcd_eoi_intr() - Make HW issue receive interrupt
  * when there are packets present in the queue. When calling
  * with interrupts enabled please use hfi1_rcd_eoi_intr.
@@ -8484,8 +8484,8 @@ static void hfi1_rcd_eoi_intr(struct hfi1_ctxtdata *rcd)
 
 /**
  * hfi1_netdev_rx_napi - napi poll function to move eoi inline
- * @napi - pointer to napi object
- * @budget - netdev budget
+ * @napi: pointer to napi object
+ * @budget: netdev budget
  */
 int hfi1_netdev_rx_napi(struct napi_struct *napi, int budget)
 {
@@ -10142,7 +10142,7 @@ u32 lrh_max_header_bytes(struct hfi1_devdata *dd)
 
 /*
  * Set Send Length
- * @ppd - per port data
+ * @ppd: per port data
  *
  * Set the MTU by limiting how many DWs may be sent.  The SendLenCheck*
  * registers compare against LRH.PktLen, so use the max bytes included
@@ -14200,9 +14200,9 @@ u8 hfi1_get_qp_map(struct hfi1_devdata *dd, u8 idx)
 
 /**
  * init_qpmap_table
- * @dd - device data
- * @first_ctxt - first context
- * @last_ctxt - first context
+ * @dd: device data
+ * @first_ctxt: first context
+ * @last_ctxt: first context
  *
  * This return sets the qpn mapping table that
  * is indexed by qpn[8:1].
@@ -14383,8 +14383,8 @@ static int qos_rmt_entries(struct hfi1_devdata *dd, unsigned int *mp,
 
 /**
  * init_qos - init RX qos
- * @dd - device data
- * @rmt - RSM map table
+ * @dd: device data
+ * @rmt: RSM map table
  *
  * This routine initializes Rule 0 and the RSM map table to implement
  * quality of service (qos).
@@ -15022,8 +15022,7 @@ static int check_int_registers(struct hfi1_devdata *dd)
 
 /**
  * hfi1_init_dd() - Initialize most of the dd structure.
- * @dev: the pci_dev for hfi1_ib device
- * @ent: pci_device_id struct for this dev
+ * @dd: the dd device
  *
  * This is global, and is called directly at init to set up the
  * chip-specific function pointers for later use.
@@ -15378,10 +15377,11 @@ static u16 delay_cycles(struct hfi1_pportdata *ppd, u32 desired_egress_rate,
 
 /**
  * create_pbc - build a pbc for transmission
+ * @ppd: info of physical Hfi port
  * @flags: special case flags or-ed in built pbc
- * @srate: static rate
+ * @srate_mbs: static rate
  * @vl: vl
- * @dwlen: dword length (header words + data words + pbc words)
+ * @dw_len: dword length (header words + data words + pbc words)
  *
  * Create a PBC with the given flags, rate, VL, and length.
  *
-- 
2.25.1

