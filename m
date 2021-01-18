Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2E2FAD64
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbhARWlY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbhARWk6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D0C061796
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o10so653882wmc.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgbSvphWdwzoBJALaG5BEz5GzMJcNLhN5bTWYIzGc8o=;
        b=n0Y2GqqSm30E9OfSryhsHoC/PL/uRTDwVaSnUQYY8jzlExX+zKe0qFuyPFHKRQtGG/
         pveNN1+C62Wrs24SkcfGxKTyxDHx5gWqCQ7ht+xm57FuaMN8yFitoRaFpKz2kFB5e5Bb
         QYuP8oqQAFoTEoueNQkAc6Q1dtpxqnHd2ngiT4AKqEH4GG30yjR3OJxv1PhOugAAuZQp
         DIbTtdO+qYQ2iPkgwa95alf9BI14ebxKLJxXic4ygYccB9K9AGyGvTNiz6AksSkg6oze
         XhXv6PglbbG2GVfainLgogtv3lB/imkN1hRHb7aHBe0ch1PPmktFQudX4j+4PWdv6NmY
         TT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgbSvphWdwzoBJALaG5BEz5GzMJcNLhN5bTWYIzGc8o=;
        b=udDVcCf7AcpxsP8cmf/l+FlwvmJzWxhSBIk0b3gYa4zULHJSWqNxpWiRE7MkXifJ9W
         REEAmeTxoW9Y7HXlXr10aV9e+Dl/flL60Ag6nQG6/rw/O7zwRQrQEsqyStWxNDJWQ0/J
         3YwElGrZZZbFI2NbNZKJN/5doN9vdJ81868eo/ItB8rl0LaTpP+sw/lwBXmRSB6sQt5z
         fEUOe5MV55pOcwKLfIw01VRTAUm4mnkFuLHW3ZKrjTgqyt6vvzabCiayaAMN3JDvSXHX
         TMoDPRd757x6nCF0YTg0LJDNo/acAMTTU/tgzogG2r871IqCD6m0Zg98xnyaZbdqIEs/
         ZsxA==
X-Gm-Message-State: AOAM530cs6qJHZ0VCLEEhHCT0E/HYmpCdM8iNFfnrDH59EodyU2M5wtp
        8FLVIC/raTjzr32oQNZIvP+27Q==
X-Google-Smtp-Source: ABdhPJxxAfyj1fv6jJ7Rj0sPN41RWYm1gUgLhgyw4XjU8eHbr5Uc2Pc16D+NBnnAbJFnBuTztZGm0Q==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr1290708wmb.62.1611009580837;
        Mon, 18 Jan 2021 14:39:40 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Intel Corporation <e1000-rdma@lists.sourceforge.net>,
        linux-rdma@vger.kernel.org
Subject: [PATCH 07/20] RDMA/hw/i40iw/i40iw_main: Rectify some kernel-doc misdemeanours
Date:   Mon, 18 Jan 2021 22:39:16 +0000
Message-Id: <20210118223929.512175-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_main.c:192: warning: Function parameter or member 't' not described in 'i40iw_dpc'
 drivers/infiniband/hw/i40iw/i40iw_main.c:192: warning: Excess function parameter 'data' description in 'i40iw_dpc'
 drivers/infiniband/hw/i40iw/i40iw_main.c:206: warning: Function parameter or member 't' not described in 'i40iw_ceq_dpc'
 drivers/infiniband/hw/i40iw/i40iw_main.c:206: warning: Excess function parameter 'data' description in 'i40iw_ceq_dpc'
 drivers/infiniband/hw/i40iw/i40iw_main.c:236: warning: Function parameter or member 'free_hwcqp' not described in 'i40iw_destroy_cqp'
 drivers/infiniband/hw/i40iw/i40iw_main.c:236: warning: Excess function parameter 'create_done' description in 'i40iw_destroy_cqp'
 drivers/infiniband/hw/i40iw/i40iw_main.c:264: warning: Function parameter or member 'msix_vec' not described in 'i40iw_disable_irq'
 drivers/infiniband/hw/i40iw/i40iw_main.c:264: warning: Excess function parameter 'msic_vec' description in 'i40iw_disable_irq'
 drivers/infiniband/hw/i40iw/i40iw_main.c:407: warning: Function parameter or member 'dev' not described in 'i40iw_close_hmc_objects_type'
 drivers/infiniband/hw/i40iw/i40iw_main.c:407: warning: Function parameter or member 'hmc_info' not described in 'i40iw_close_hmc_objects_type'
 drivers/infiniband/hw/i40iw/i40iw_main.c:407: warning: Excess function parameter 'iwdev' description in 'i40iw_close_hmc_objects_type'
 drivers/infiniband/hw/i40iw/i40iw_main.c:443: warning: Function parameter or member 'irq' not described in 'i40iw_ceq_handler'
 drivers/infiniband/hw/i40iw/i40iw_main.c:1786: warning: Function parameter or member 'reset' not described in 'i40iw_close'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Intel Corporation <e1000-rdma@lists.sourceforge.net>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 584932d3cc44b..ab4cb11950dc1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -186,7 +186,7 @@ static void i40iw_enable_intr(struct i40iw_sc_dev *dev, u32 msix_id)
 
 /**
  * i40iw_dpc - tasklet for aeq and ceq 0
- * @data: iwarp device
+ * @t: Timer context to fetch pointer to iwarp device
  */
 static void i40iw_dpc(struct tasklet_struct *t)
 {
@@ -200,7 +200,7 @@ static void i40iw_dpc(struct tasklet_struct *t)
 
 /**
  * i40iw_ceq_dpc - dpc handler for CEQ
- * @data: data points to CEQ
+ * @t: Timer context to fetch pointer to CEQ data
  */
 static void i40iw_ceq_dpc(struct tasklet_struct *t)
 {
@@ -227,7 +227,7 @@ static irqreturn_t i40iw_irq_handler(int irq, void *data)
 /**
  * i40iw_destroy_cqp  - destroy control qp
  * @iwdev: iwarp device
- * @create_done: 1 if cqp create poll was success
+ * @free_hwcqp: 1 if CQP should be destroyed
  *
  * Issue destroy cqp request and
  * free the resources associated with the cqp
@@ -253,7 +253,7 @@ static void i40iw_destroy_cqp(struct i40iw_device *iwdev, bool free_hwcqp)
 /**
  * i40iw_disable_irqs - disable device interrupts
  * @dev: hardware control device structure
- * @msic_vec: msix vector to disable irq
+ * @msix_vec: msix vector to disable irq
  * @dev_id: parameter to pass to free_irq (used during irq setup)
  *
  * The function is called when destroying aeq/ceq
@@ -394,8 +394,9 @@ static enum i40iw_hmc_rsrc_type iw_hmc_obj_types[] = {
 
 /**
  * i40iw_close_hmc_objects_type - delete hmc objects of a given type
- * @iwdev: iwarp device
+ * @dev: iwarp device
  * @obj_type: the hmc object type to be deleted
+ * @hmc_info: pointer to the HMC configuration information
  * @is_pf: true if the function is PF otherwise false
  * @reset: true if called before reset
  */
@@ -437,6 +438,7 @@ static void i40iw_del_hmc_objects(struct i40iw_sc_dev *dev,
 
 /**
  * i40iw_ceq_handler - interrupt handler for ceq
+ * @irq: interrupt request number
  * @data: ceq pointer
  */
 static irqreturn_t i40iw_ceq_handler(int irq, void *data)
@@ -1777,6 +1779,7 @@ static void i40iw_l2param_change(struct i40e_info *ldev, struct i40e_client *cli
 /**
  * i40iw_close - client interface operation close for iwarp/uda device
  * @ldev: lan device information
+ * @reset: true if called before reset
  * @client: client to close
  *
  * Called by the lan driver during the processing of client unregister
-- 
2.25.1

