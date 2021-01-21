Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64C2FE763
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbhAUKTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbhAUJrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C95C06138A
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so1060780wrx.4
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PUI6ltCF6UYEL6FQ111TDKZz1F/sP23xV8l8xivz1A=;
        b=zEgaTqVGy6l3GlqsBT2B6w3UmLi9VdmgcuZ1Aif/smB5SejrYguy/EhRvkFTpwVAg+
         9zw4fOC3y7NCBZfyf/3gl2bHJng3gUB/l2hbsar1curQKlCiBjdzUeorZ4o4iOYzSqb1
         oV3d8USZ9iGC5E2xr7nDWT/Uatu6o9l4tdRg2KJ+xST77UcPtawNO75xyj/Q/zs2a52S
         hacMnIABZgNjU6vGl5mgo7F2wwg/asggYjvU2N/NIhttzzczKPFx0BPH+KtB11/8lGEx
         RArBi7wsW6GRIDrRoivmPA0HYDG6EGnGWMFflKq09KRZDSilHPS+Gnj2lNtsF7vRPSnf
         EjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PUI6ltCF6UYEL6FQ111TDKZz1F/sP23xV8l8xivz1A=;
        b=fof6CL4LVfxqWJVOAb+oePi4t4hLMGKnPde3G4ZxCW7mmtZw0C9VkMhhsJ6bcU54Fd
         ygOTE/hJKdEK6evy4Mt0Iqw0aML3f8tuLrAQT7mNZeIOOXi0jsL4AqWDzl2TbW/PcY9B
         ZDao/RKTB0g3/0nk4D+kBInPcja3sFnXIzX6wiByC7z2OKoh1722VZqf2mDWrfh/QOlo
         rAApiBk7D3XL6nemZBHxnALhrgdCU3f9NStPD+k/WNS91SrhCN5CLx2vOjzOGQL7g4rf
         UQamc1PE7gDrgN3DShfV4ZZ8sI45tVtDMl/HjlOyvKhhjSU2ksvVWB6AyLHWWzR7IaGu
         N6jg==
X-Gm-Message-State: AOAM530rn3CgXwRdg7B0zGxy9UE58jw4Rdvr0nO4klNXTe95Hi/VjAar
        vC5brpN/KkH7sbhZ7AoNKuRXNA==
X-Google-Smtp-Source: ABdhPJwbluN9S+sVEAB25VBXJCdu2Vzynmm1+2Tz3m+RMP9VEKts2YjjQAXfTYK4YVq7o4lWA2nNQg==
X-Received: by 2002:a05:6000:1362:: with SMTP id q2mr10421159wrz.341.1611222353050;
        Thu, 21 Jan 2021 01:45:53 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 24/30] RDMA/hw/qib/qib_iba7220: Fix some kernel-doc issues
Date:   Thu, 21 Jan 2021 09:45:13 +0000
Message-Id: <20210121094519.2044049-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_iba7220.c:1726: warning: Function parameter or member 'ppd' not described in 'qib_setup_7220_setextled'
 drivers/infiniband/hw/qib/qib_iba7220.c:1726: warning: Excess function parameter 'dd' description in 'qib_setup_7220_setextled'
 drivers/infiniband/hw/qib/qib_iba7220.c:2154: warning: Function parameter or member 'type' not described in 'qib_7220_put_tid'
 drivers/infiniband/hw/qib/qib_iba7220.c:2154: warning: Excess function parameter 'tidtype' description in 'qib_7220_put_tid'
 drivers/infiniband/hw/qib/qib_iba7220.c:2192: warning: Function parameter or member 'rcd' not described in 'qib_7220_clear_tids'
 drivers/infiniband/hw/qib/qib_iba7220.c:2192: warning: Excess function parameter 'ctxt' description in 'qib_7220_clear_tids'
 drivers/infiniband/hw/qib/qib_iba7220.c:2248: warning: Function parameter or member 'kinfo' not described in 'qib_7220_get_base_info'
 drivers/infiniband/hw/qib/qib_iba7220.c:2248: warning: Excess function parameter 'kbase' description in 'qib_7220_get_base_info'
 drivers/infiniband/hw/qib/qib_iba7220.c:2903: warning: Function parameter or member 'ppd' not described in 'qib_portcntr_7220'
 drivers/infiniband/hw/qib/qib_iba7220.c:2903: warning: Function parameter or member 'reg' not described in 'qib_portcntr_7220'
 drivers/infiniband/hw/qib/qib_iba7220.c:2903: warning: Excess function parameter 'dd' description in 'qib_portcntr_7220'
 drivers/infiniband/hw/qib/qib_iba7220.c:2903: warning: Excess function parameter 'creg' description in 'qib_portcntr_7220'
 drivers/infiniband/hw/qib/qib_iba7220.c:3242: warning: Function parameter or member 't' not described in 'qib_get_7220_faststats'
 drivers/infiniband/hw/qib/qib_iba7220.c:4479: warning: Function parameter or member 'pdev' not described in 'qib_init_iba7220_funcs'
 drivers/infiniband/hw/qib/qib_iba7220.c:4479: warning: Excess function parameter 'dev' description in 'qib_init_iba7220_funcs'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_iba7220.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 0a6f26d4cb310..229dcd6ead95b 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -1701,7 +1701,7 @@ static void qib_7220_quiet_serdes(struct qib_pportdata *ppd)
 
 /**
  * qib_setup_7220_setextled - set the state of the two external LEDs
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @on: whether the link is up or not
  *
  * The exact combo of LEDs if on is true is determined by looking
@@ -2146,7 +2146,7 @@ static int qib_setup_7220_reset(struct qib_devdata *dd)
  * qib_7220_put_tid - write a TID to the chip
  * @dd: the qlogic_ib device
  * @tidptr: pointer to the expected TID (in chip) to update
- * @tidtype: 0 for eager, 1 for expected
+ * @type: 0 for eager, 1 for expected
  * @pa: physical address of in memory buffer; tidinvalid if freeing
  */
 static void qib_7220_put_tid(struct qib_devdata *dd, u64 __iomem *tidptr,
@@ -2180,7 +2180,7 @@ static void qib_7220_put_tid(struct qib_devdata *dd, u64 __iomem *tidptr,
 /**
  * qib_7220_clear_tids - clear all TID entries for a ctxt, expected and eager
  * @dd: the qlogic_ib device
- * @ctxt: the ctxt
+ * @rcd: the ctxt
  *
  * clear all TID entries for a ctxt, expected and eager.
  * Used from qib_close().  On this chip, TIDs are only 32 bits,
@@ -2238,7 +2238,7 @@ static void qib_7220_tidtemplate(struct qib_devdata *dd)
 /**
  * qib_init_7220_get_base_info - set chip-specific flags for user code
  * @rcd: the qlogic_ib ctxt
- * @kbase: qib_base_info pointer
+ * @kinfo: qib_base_info pointer
  *
  * We set the PCIE flag because the lower bandwidth on PCIe vs
  * HyperTransport can affect some user packet algorithims.
@@ -2896,8 +2896,8 @@ static void sendctrl_7220_mod(struct qib_pportdata *ppd, u32 op)
 
 /**
  * qib_portcntr_7220 - read a per-port counter
- * @dd: the qlogic_ib device
- * @creg: the counter to snapshot
+ * @ppd: the qlogic_ib device
+ * @reg: the counter to snapshot
  */
 static u64 qib_portcntr_7220(struct qib_pportdata *ppd, u32 reg)
 {
@@ -3232,7 +3232,7 @@ static u32 qib_read_7220portcntrs(struct qib_devdata *dd, loff_t pos, u32 port,
 
 /**
  * qib_get_7220_faststats - get word counters from chip before they overflow
- * @opaque - contains a pointer to the qlogic_ib device qib_devdata
+ * @t: contains a pointer to the qlogic_ib device qib_devdata
  *
  * This needs more work; in particular, decision on whether we really
  * need traffic_wds done the way it is
@@ -4468,7 +4468,7 @@ static int qib_7220_eeprom_wen(struct qib_devdata *dd, int wen)
 
 /**
  * qib_init_iba7220_funcs - set up the chip-specific function pointers
- * @dev: the pci_dev for qlogic_ib device
+ * @pdev: the pci_dev for qlogic_ib device
  * @ent: pci_device_id struct for this dev
  *
  * This is global, and is called directly at init to set up the
-- 
2.25.1

