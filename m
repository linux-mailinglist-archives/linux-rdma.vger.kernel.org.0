Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5B2FAD6D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbhARWmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbhARWlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9683C0617AB
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u14so10853268wmq.4
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKSpWbsIVhkNzKC/c+/MugM5g2qDtp8LtVSxNGv8lUw=;
        b=qTpcTgPQ18S8CCCQ8HI6GuNi1xHAXCyV3loDbBo8VvVMAV6CtNH5QxGLXVmyWFIrPg
         q15ItmeJ3ta/vDxhAAbLOJPm7w0eoDcKXtfLBCrfufwZQ0SeUPlGl4Ry98oeYaKQg8R7
         oJBREVekjHnuhXf/Zh1q6h6cvr/IMS+QLy4plD8YrmNdF94zxZQ5ng82m4M2DFyI6x02
         4mTyTwq6ShBUeZCNIC04Xtl/cqgDJtuPdVtr+yuW6uj3p2W4uXK26VjXsjRYboTdA0si
         u1bKKLKC7246ORiFGSwi8bMBwhHUMAtrUREMZQ81ma05GB7L8zbAYUM1yN9s0yBJyoU1
         pH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKSpWbsIVhkNzKC/c+/MugM5g2qDtp8LtVSxNGv8lUw=;
        b=aKwM55zSh4j51XZfDnU+nEEYxz8ndwjnqysCEJDhaumQYCKIt5YS6b8SQc1IEo8wUx
         CWMN6NLTFHjUcxKsVNVxJMHC/qfGoasL0G8nTv8OhiB//iSFVTRuvC/RrBksPLtTX1/1
         x1aWaV0UAHUv3ZCBuqtV+QVYfwD9nhGwgcfh+X+HnCL943Si6vS0ot9kKO9E8o/RWJwL
         iLiJFTUckoam0Q3HUqcRc5F15JB8srB8XdDtfzuKx/0EfMw1B6QvPmflEigdAeihXuJc
         5bcXLKM14HURmIfKuEISZr+90P5htrvpwizKD9l6C9tSDypg8Zi/FoazIcOFmBakcOZx
         DtSg==
X-Gm-Message-State: AOAM530lpn12UMg/vfwkRK7GdApuogRVtY7M9AqavV0K8HCrk1bZiYpH
        WbRr4G/TygPmDaTRsSOqgcDEuA==
X-Google-Smtp-Source: ABdhPJybBrWrD/Ei4eTT+gFf4rkSkyZc9I3edsNtatZisc82RI6dusYqVqafz0XE2xgsl678vhzAOg==
X-Received: by 2002:a1c:2e8b:: with SMTP id u133mr1266160wmu.189.1611009589674;
        Mon, 18 Jan 2021 14:39:49 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 15/20] RDMA/hw/i40iw/i40iw_utils: Fix some misspellings and missing param descriptions
Date:   Mon, 18 Jan 2021 22:39:24 +0000
Message-Id: <20210118223929.512175-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_utils.c:66: warning: Function parameter or member 'ipv4' not described in 'i40iw_arp_table'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:148: warning: Function parameter or member 'notifier' not described in 'i40iw_inetaddr_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:148: warning: Excess function parameter 'notfier' description in 'i40iw_inetaddr_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:224: warning: Function parameter or member 'notifier' not described in 'i40iw_inet6addr_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:224: warning: Excess function parameter 'notfier' description in 'i40iw_inet6addr_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:273: warning: Function parameter or member 'notifier' not described in 'i40iw_net_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:273: warning: Excess function parameter 'notfier' description in 'i40iw_net_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:320: warning: Function parameter or member 'notifier' not described in 'i40iw_netdevice_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:320: warning: Excess function parameter 'notfier' description in 'i40iw_netdevice_event'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:663: warning: Function parameter or member 'desc' not described in 'i40iw_debug_buf'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:792: warning: Function parameter or member 'sdinfo' not described in 'i40iw_cqp_sds_cmd'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:792: warning: Excess function parameter 'sd_info' description in 'i40iw_cqp_sds_cmd'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:895: warning: Function parameter or member 't' not described in 'i40iw_terminate_timeout'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:895: warning: Excess function parameter 'context' description in 'i40iw_terminate_timeout'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:953: warning: Function parameter or member 'dev' not described in 'i40iw_cqp_spawn_worker'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:953: warning: Excess function parameter 'iwdev' description in 'i40iw_cqp_spawn_worker'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:1058: warning: Function parameter or member 'dev' not described in 'i40iw_cqp_query_fpm_values_cmd'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:1058: warning: Excess function parameter 'iwdev' description in 'i40iw_cqp_query_fpm_values_cmd'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:1120: warning: Function parameter or member 'dev' not described in 'i40iw_vf_wait_vchnl_resp'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:1120: warning: Excess function parameter 'iwdev' description in 'i40iw_vf_wait_vchnl_resp'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:1467: warning: Function parameter or member 't' not described in 'i40iw_hw_stats_timeout'
 drivers/infiniband/hw/i40iw/i40iw_utils.c:1467: warning: Excess function parameter 'vsi' description in 'i40iw_hw_stats_timeout'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index 644f8c641aa0c..76f052b12c141 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -55,6 +55,7 @@
  * i40iw_arp_table - manage arp table
  * @iwdev: iwarp device
  * @ip_addr: ip address for device
+ * @ipv4: flag indicating IPv4 when true
  * @mac_addr: mac address ptr
  * @action: modify, delete or add
  */
@@ -138,7 +139,7 @@ inline u32 i40iw_rd32(struct i40iw_hw *hw, u32 reg)
 
 /**
  * i40iw_inetaddr_event - system notifier for ipv4 addr events
- * @notfier: not used
+ * @notifier: not used
  * @event: event for notifier
  * @ptr: if address
  */
@@ -214,7 +215,7 @@ int i40iw_inetaddr_event(struct notifier_block *notifier,
 
 /**
  * i40iw_inet6addr_event - system notifier for ipv6 addr events
- * @notfier: not used
+ * @notifier: not used
  * @event: event for notifier
  * @ptr: if address
  */
@@ -265,7 +266,7 @@ int i40iw_inet6addr_event(struct notifier_block *notifier,
 
 /**
  * i40iw_net_event - system notifier for netevents
- * @notfier: not used
+ * @notifier: not used
  * @event: event for notifier
  * @ptr: neighbor
  */
@@ -310,7 +311,7 @@ int i40iw_net_event(struct notifier_block *notifier, unsigned long event, void *
 
 /**
  * i40iw_netdevice_event - system notifier for netdev events
- * @notfier: not used
+ * @notifier: not used
  * @event: event for notifier
  * @ptr: netdev
  */
@@ -652,6 +653,7 @@ struct ib_qp *i40iw_get_qp(struct ib_device *device, int qpn)
  * i40iw_debug_buf - print debug msg and buffer is mask set
  * @dev: hardware control device structure
  * @mask: mask to compare if to print debug buffer
+ * @desc: identifying string
  * @buf: points buffer addr
  * @size: saize of buffer to print
  */
@@ -784,7 +786,7 @@ enum i40iw_status_code i40iw_free_virt_mem(struct i40iw_hw *hw,
 /**
  * i40iw_cqp_sds_cmd - create cqp command for sd
  * @dev: hardware control device structure
- * @sd_info: information  for sd cqp
+ * @sdinfo: information  for sd cqp
  *
  */
 enum i40iw_status_code i40iw_cqp_sds_cmd(struct i40iw_sc_dev *dev,
@@ -889,7 +891,7 @@ void i40iw_terminate_done(struct i40iw_sc_qp *qp, int timeout_occurred)
 
 /**
  * i40iw_terminate_imeout - timeout happened
- * @context: points to iwarp qp
+ * @t: points to iwarp qp
  */
 static void i40iw_terminate_timeout(struct timer_list *t)
 {
@@ -943,7 +945,7 @@ static void i40iw_cqp_generic_worker(struct work_struct *work)
 
 /**
  * i40iw_cqp_spawn_worker - spawn worket thread
- * @iwdev: device struct pointer
+ * @dev: device struct pointer
  * @work_info: work request info
  * @iw_vf_idx: virtual function index
  */
@@ -1048,7 +1050,7 @@ enum i40iw_status_code i40iw_cqp_manage_hmc_fcn_cmd(struct i40iw_sc_dev *dev,
 
 /**
  * i40iw_cqp_query_fpm_values_cmd - send cqp command for fpm
- * @iwdev: function device struct
+ * @dev: function device struct
  * @values_mem: buffer for fpm
  * @hmc_fn_id: function id for fpm
  */
@@ -1114,7 +1116,7 @@ enum i40iw_status_code i40iw_cqp_commit_fpm_values_cmd(struct i40iw_sc_dev *dev,
 
 /**
  * i40iw_vf_wait_vchnl_resp - wait for channel msg
- * @iwdev: function's device struct
+ * @dev: function's device struct
  */
 enum i40iw_status_code i40iw_vf_wait_vchnl_resp(struct i40iw_sc_dev *dev)
 {
@@ -1461,7 +1463,7 @@ enum i40iw_status_code i40iw_puda_get_tcpip_info(struct i40iw_puda_completion_in
 
 /**
  * i40iw_hw_stats_timeout - Stats timer-handler which updates all HW stats
- * @vsi: pointer to the vsi structure
+ * @t: Timer context containing pointer to the vsi structure
  */
 static void i40iw_hw_stats_timeout(struct timer_list *t)
 {
-- 
2.25.1

