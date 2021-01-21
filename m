Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C482FE712
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbhAUJsI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbhAUJrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC174C061346
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:46:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a12so1051530wrv.8
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLv2flVn35uo9irrj5vj4AyXKUEKpIoSxfExpgzfyqk=;
        b=W/Cw7iSAfCegPPgWDVVFavdDoZgNTLSWzdLW5FgGDNh8rpuW9FQC2cDYzRkAhQr54V
         epHWNXbURwsDrFWKsuDruRHu9PVKrvWXBoOZJ2vezQkq8zouISncNxlIwsARDz8dFQpz
         wgE+TeAZMzlYbMGUgRBxOn8IHZkq+K2sdZcrF9wnXy1cQryjcfR5HodAV2IGAMaz7XUY
         mj7qAra0JQ1UsXLROHPI6G9OtL48SoRas3GYp48hZjllcWsvwesiD/n0IIfPFdfKdHvC
         keDQhVO+Ir/8HHUCNgC9ylEL5H2oOfEegvkzeTJxtcQv79DgosWg9nUrPWzBwiyquAH0
         Q1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLv2flVn35uo9irrj5vj4AyXKUEKpIoSxfExpgzfyqk=;
        b=K9Q1qD6PY+/ZQ1Swtiov0fFe8RmeIDPvzuNt+jZrtJOmllHDBfqNnCwozxw019JfQ0
         jdQqtQp+nPuyY1c1ThlQMamKXlBZ8n5YjWOskqFnX6nfke7UZZBvp/CBqNTaBfHNvSqa
         XPRnUeFXwHLrOeqFdLqyBhgBjD9GJ6H84AbZj6TxS4UkulhtcE4a8yutRrkmyNnhmukK
         2xt9p5V7tW5i4Ie1eHK7m5L3av7ZaGNsq/kvgrDQKfET+HgGGU5bf3AfQNuOt4FXYF6Z
         Nn2SxNR8Mhp3ULu8qwZES42zQgFysQbGLfYlkAwkXfZ2ZZY5L5EEZDuHmzPsl7TKg3KP
         GxGA==
X-Gm-Message-State: AOAM530a5wB3FeZstJlCeJICJMbQRHaqWzAZ/BTL8lFT0qGmRKUd04GL
        GJFq+Q8wOcSlud00pN6t3hYmog==
X-Google-Smtp-Source: ABdhPJy2RelPiJq9pzkrT/MZnHW73VgbvuH/hiBDTlyXNz25cnCEXSa6atgMPguJqI6GtClf9uxDUQ==
X-Received: by 2002:adf:f684:: with SMTP id v4mr13530258wrp.387.1611222359423;
        Thu, 21 Jan 2021 01:45:59 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 29/30] RDMA/hw/qib/qib_iba6120: Fix some repeated (copy/paste) kernel-doc issues
Date:   Thu, 21 Jan 2021 09:45:18 +0000
Message-Id: <20210121094519.2044049-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_iba6120.c:1229: warning: Function parameter or member 'ppd' not described in 'qib_6120_bringup_serdes'
 drivers/infiniband/hw/qib/qib_iba6120.c:1229: warning: Excess function parameter 'dd' description in 'qib_6120_bringup_serdes'
 drivers/infiniband/hw/qib/qib_iba6120.c:1436: warning: Function parameter or member 'ppd' not described in 'qib_6120_setup_setextled'
 drivers/infiniband/hw/qib/qib_iba6120.c:1436: warning: Excess function parameter 'dd' description in 'qib_6120_setup_setextled'
 drivers/infiniband/hw/qib/qib_iba6120.c:1836: warning: Function parameter or member 'type' not described in 'qib_6120_put_tid'
 drivers/infiniband/hw/qib/qib_iba6120.c:1836: warning: Excess function parameter 'tidtype' description in 'qib_6120_put_tid'
 drivers/infiniband/hw/qib/qib_iba6120.c:1903: warning: Function parameter or member 'type' not described in 'qib_6120_put_tid_2'
 drivers/infiniband/hw/qib/qib_iba6120.c:1903: warning: Excess function parameter 'tidtype' description in 'qib_6120_put_tid_2'
 drivers/infiniband/hw/qib/qib_iba6120.c:1944: warning: Function parameter or member 'rcd' not described in 'qib_6120_clear_tids'
 drivers/infiniband/hw/qib/qib_iba6120.c:1944: warning: Excess function parameter 'ctxt' description in 'qib_6120_clear_tids'
 drivers/infiniband/hw/qib/qib_iba6120.c:2018: warning: Function parameter or member 'kinfo' not described in 'qib_6120_get_base_info'
 drivers/infiniband/hw/qib/qib_iba6120.c:2018: warning: Excess function parameter 'kbase' description in 'qib_6120_get_base_info'
 drivers/infiniband/hw/qib/qib_iba6120.c:2277: warning: Function parameter or member 'ppd' not described in 'qib_portcntr_6120'
 drivers/infiniband/hw/qib/qib_iba6120.c:2277: warning: Function parameter or member 'reg' not described in 'qib_portcntr_6120'
 drivers/infiniband/hw/qib/qib_iba6120.c:2277: warning: Excess function parameter 'dd' description in 'qib_portcntr_6120'
 drivers/infiniband/hw/qib/qib_iba6120.c:2277: warning: Excess function parameter 'creg' description in 'qib_portcntr_6120'
 drivers/infiniband/hw/qib/qib_iba6120.c:2620: warning: Function parameter or member 't' not described in 'qib_get_6120_faststats'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_iba6120.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba6120.c b/drivers/infiniband/hw/qib/qib_iba6120.c
index 44150be215bf2..b35e1174be22f 100644
--- a/drivers/infiniband/hw/qib/qib_iba6120.c
+++ b/drivers/infiniband/hw/qib/qib_iba6120.c
@@ -1223,7 +1223,7 @@ static void qib_set_ib_6120_lstate(struct qib_pportdata *ppd, u16 linkcmd,
 
 /**
  * qib_6120_bringup_serdes - bring up the serdes
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  */
 static int qib_6120_bringup_serdes(struct qib_pportdata *ppd)
 {
@@ -1412,7 +1412,7 @@ static void qib_6120_quiet_serdes(struct qib_pportdata *ppd)
 
 /**
  * qib_6120_setup_setextled - set the state of the two external LEDs
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @on: whether the link is up or not
  *
  * The exact combo of LEDs if on is true is determined by looking
@@ -1823,7 +1823,7 @@ static int qib_6120_setup_reset(struct qib_devdata *dd)
  * qib_6120_put_tid - write a TID in chip
  * @dd: the qlogic_ib device
  * @tidptr: pointer to the expected TID (in chip) to update
- * @tidtype: RCVHQ_RCV_TYPE_EAGER (1) for eager, RCVHQ_RCV_TYPE_EXPECTED (0)
+ * @type: RCVHQ_RCV_TYPE_EAGER (1) for eager, RCVHQ_RCV_TYPE_EXPECTED (0)
  * for expected
  * @pa: physical address of in memory buffer; tidinvalid if freeing
  *
@@ -1890,7 +1890,7 @@ static void qib_6120_put_tid(struct qib_devdata *dd, u64 __iomem *tidptr,
  * qib_6120_put_tid_2 - write a TID in chip, Revision 2 or higher
  * @dd: the qlogic_ib device
  * @tidptr: pointer to the expected TID (in chip) to update
- * @tidtype: RCVHQ_RCV_TYPE_EAGER (1) for eager, RCVHQ_RCV_TYPE_EXPECTED (0)
+ * @type: RCVHQ_RCV_TYPE_EAGER (1) for eager, RCVHQ_RCV_TYPE_EXPECTED (0)
  * for expected
  * @pa: physical address of in memory buffer; tidinvalid if freeing
  *
@@ -1932,7 +1932,7 @@ static void qib_6120_put_tid_2(struct qib_devdata *dd, u64 __iomem *tidptr,
 /**
  * qib_6120_clear_tids - clear all TID entries for a context, expected and eager
  * @dd: the qlogic_ib device
- * @ctxt: the context
+ * @rcd: the context
  *
  * clear all TID entries for a context, expected and eager.
  * Used from qib_close().  On this chip, TIDs are only 32 bits,
@@ -2008,7 +2008,7 @@ int __attribute__((weak)) qib_unordered_wc(void)
 /**
  * qib_6120_get_base_info - set chip-specific flags for user code
  * @rcd: the qlogic_ib ctxt
- * @kbase: qib_base_info pointer
+ * @kinfo: qib_base_info pointer
  *
  * We set the PCIE flag because the lower bandwidth on PCIe vs
  * HyperTransport can affect some user packet algorithms.
@@ -2270,8 +2270,8 @@ static void sendctrl_6120_mod(struct qib_pportdata *ppd, u32 op)
 
 /**
  * qib_portcntr_6120 - read a per-port counter
- * @dd: the qlogic_ib device
- * @creg: the counter to snapshot
+ * @ppd: the qlogic_ib device
+ * @reg: the counter to snapshot
  */
 static u64 qib_portcntr_6120(struct qib_pportdata *ppd, u32 reg)
 {
@@ -2610,7 +2610,7 @@ static void qib_chk_6120_errormask(struct qib_devdata *dd)
 
 /**
  * qib_get_faststats - get word counters from chip before they overflow
- * @opaque - contains a pointer to the qlogic_ib device qib_devdata
+ * @t: contains a pointer to the qlogic_ib device qib_devdata
  *
  * This needs more work; in particular, decision on whether we really
  * need traffic_wds done the way it is
-- 
2.25.1

