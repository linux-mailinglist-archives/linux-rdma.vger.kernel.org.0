Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D262FE6B2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbhAUJsC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbhAUJro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40306C061343
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so1036851wre.13
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKRdxGowR6+2SlFAzbCdVtAOlJIiEEiKpCM9bIUXE5M=;
        b=mG8u4AFN7PsNYcEKs/l//NonrtelRjACSLJq4e+TVo0K8mzjkVu5BDL3atZvUalrFV
         2sG+IGz5x+r+Xqu8ian32V+Y6BM7ycHh/lu0DqET8lOQJ88Q3jnfH6ChgNTZBVqDqtUd
         JoKCAI2ZcFX8Ursa6zYypoHh4ylvzcvDXON48ksyRQ0bNvExBc7sq3qE9O2r0L/mV80M
         5pR8rT9eAavR/vJCQWterdSoGEV8XT//Y6lZLCzX/Tnsq7pTDb1LLqcByK9dtXMV5PcY
         RTvZ9Hme+VggC8Y4gEaOeK2HqA+4wfhy1gllrqRk0aQfwnTCGXZr5ABmVnsfi/34QXlS
         a3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKRdxGowR6+2SlFAzbCdVtAOlJIiEEiKpCM9bIUXE5M=;
        b=e4MFFcXFg9kdTK1U01AKQX1IkkpIL/pKm5MYeAAzyJoHj5hPIR+a8hvIiAPqfIDkAL
         ozK5ilj2czPOpcHI2/vxTFL+bmxoykBNyTZApq9Ei48JvgI58pJETL6xnhFFCUaS30Zh
         4ESYaXG0qMtk/g94YdCNYYbzj+/R2U+DJidy/vneWIbAAc9XsJxzv41YEaGPk8TKyau8
         sDVWq9+9Vbpn35l23z4dc33ykXVc6y8WquJkGMmmfJijqyVHlT8H8xCq2zx2IboZ7SZq
         VaNr0R2KabfdXzNi4VCPZNBpMzPjQktffkZXNU6O8R3CwrgxkHNBN9Y9eFHYWiamhgvl
         Ir1A==
X-Gm-Message-State: AOAM531OOEJeuiXh0RV3ENrf2UnQYmPVDNqd9x6J1xW3JMEY22yglHRx
        wZwAiOmIAmOSQnknSRLRhdwxUA==
X-Google-Smtp-Source: ABdhPJyF3Ip23qrhUl1lzN0DXoq+AJOOj0E2HrMQk0HU7TSvdcjKP+jsXxHDcGUQcTbhM4S9e66LOg==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr13530772wru.268.1611222356944;
        Thu, 21 Jan 2021 01:45:56 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 27/30] RDMA/hw/qib/qib_iba7322: Fix a bunch of copy/paste issues
Date:   Thu, 21 Jan 2021 09:45:16 +0000
Message-Id: <20210121094519.2044049-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_iba7322.c:2521: warning: Function parameter or member 'ppd' not described in 'qib_7322_mini_quiet_serdes'
 drivers/infiniband/hw/qib/qib_iba7322.c:2521: warning: Excess function parameter 'dd' description in 'qib_7322_mini_quiet_serdes'
 drivers/infiniband/hw/qib/qib_iba7322.c:3768: warning: Function parameter or member 'type' not described in 'qib_7322_put_tid'
 drivers/infiniband/hw/qib/qib_iba7322.c:3768: warning: Excess function parameter 'tidtype' description in 'qib_7322_put_tid'
 drivers/infiniband/hw/qib/qib_iba7322.c:3806: warning: Function parameter or member 'rcd' not described in 'qib_7322_clear_tids'
 drivers/infiniband/hw/qib/qib_iba7322.c:3806: warning: Excess function parameter 'ctxt' description in 'qib_7322_clear_tids'
 drivers/infiniband/hw/qib/qib_iba7322.c:3872: warning: Function parameter or member 'kinfo' not described in 'qib_7322_get_base_info'
 drivers/infiniband/hw/qib/qib_iba7322.c:3872: warning: Excess function parameter 'kbase' description in 'qib_7322_get_base_info'
 drivers/infiniband/hw/qib/qib_iba7322.c:4730: warning: Function parameter or member 'reg' not described in 'qib_portcntr_7322'
 drivers/infiniband/hw/qib/qib_iba7322.c:4730: warning: Excess function parameter 'creg' description in 'qib_portcntr_7322'
 drivers/infiniband/hw/qib/qib_iba7322.c:5109: warning: Function parameter or member 't' not described in 'qib_get_7322_faststats'
 drivers/infiniband/hw/qib/qib_iba7322.c:7189: warning: Function parameter or member 'pdev' not described in 'qib_init_iba7322_funcs'
 drivers/infiniband/hw/qib/qib_iba7322.c:7189: warning: Excess function parameter 'dev' description in 'qib_init_iba7322_funcs'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_iba7322.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 189a0ce6056a6..9fe6ea75b45e5 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -2514,7 +2514,7 @@ static int qib_7322_bringup_serdes(struct qib_pportdata *ppd)
 
 /**
  * qib_7322_quiet_serdes - set serdes to txidle
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * Called when driver is being unloaded
  */
 static void qib_7322_mini_quiet_serdes(struct qib_pportdata *ppd)
@@ -3760,7 +3760,7 @@ static int qib_do_7322_reset(struct qib_devdata *dd)
  * qib_7322_put_tid - write a TID to the chip
  * @dd: the qlogic_ib device
  * @tidptr: pointer to the expected TID (in chip) to update
- * @tidtype: 0 for eager, 1 for expected
+ * @type: 0 for eager, 1 for expected
  * @pa: physical address of in memory buffer; tidinvalid if freeing
  */
 static void qib_7322_put_tid(struct qib_devdata *dd, u64 __iomem *tidptr,
@@ -3796,7 +3796,7 @@ static void qib_7322_put_tid(struct qib_devdata *dd, u64 __iomem *tidptr,
 /**
  * qib_7322_clear_tids - clear all TID entries for a ctxt, expected and eager
  * @dd: the qlogic_ib device
- * @ctxt: the ctxt
+ * @rcd: the ctxt
  *
  * clear all TID entries for a ctxt, expected and eager.
  * Used from qib_close().
@@ -3861,7 +3861,7 @@ static void qib_7322_tidtemplate(struct qib_devdata *dd)
 /**
  * qib_init_7322_get_base_info - set chip-specific flags for user code
  * @rcd: the qlogic_ib ctxt
- * @kbase: qib_base_info pointer
+ * @kinfo: qib_base_info pointer
  *
  * We set the PCIE flag because the lower bandwidth on PCIe vs
  * HyperTransport can affect some user packet algorithims.
@@ -4724,7 +4724,7 @@ static void sendctrl_7322_mod(struct qib_pportdata *ppd, u32 op)
 /**
  * qib_portcntr_7322 - read a per-port chip counter
  * @ppd: the qlogic_ib pport
- * @creg: the counter to read (not a chip offset)
+ * @reg: the counter to read (not a chip offset)
  */
 static u64 qib_portcntr_7322(struct qib_pportdata *ppd, u32 reg)
 {
@@ -5096,7 +5096,7 @@ static u32 qib_read_7322portcntrs(struct qib_devdata *dd, loff_t pos, u32 port,
 
 /**
  * qib_get_7322_faststats - get word counters from chip before they overflow
- * @opaque - contains a pointer to the qlogic_ib device qib_devdata
+ * @t: contains a pointer to the qlogic_ib device qib_devdata
  *
  * VESTIGIAL IBA7322 has no "small fast counters", so the only
  * real purpose of this function is to maintain the notion of
@@ -7175,7 +7175,7 @@ static int qib_7322_tempsense_rd(struct qib_devdata *dd, int regnum)
 
 /**
  * qib_init_iba7322_funcs - set up the chip-specific function pointers
- * @dev: the pci_dev for qlogic_ib device
+ * @pdev: the pci_dev for qlogic_ib device
  * @ent: pci_device_id struct for this dev
  *
  * Also allocates, inits, and returns the devdata struct for this
-- 
2.25.1

