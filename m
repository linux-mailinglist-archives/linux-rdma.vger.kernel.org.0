Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA352FAD87
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389776AbhARWrR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbhARWk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3742C061795
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so14266018wrx.4
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jJk3Wy6VsVsOm2tohtCthVTrOWPBDptabDnJch7SGo=;
        b=oXyx0rI/JKGRnNSh9XBwEbmWqPF0QznUAFEcSixnf+Gh8CvWLWwuqQL2uKvKn/2iff
         OzPCMYe8vS0X5eUCsSJQyXuNtKWYUDEIm/a8df/AXlj0OJlYlNMuBbkTaRG+oCOpxDau
         tZE0cF8+oPY+/kzO8B/xKluTlJSwLZaHfewgB75VnIaYcJ/TtKdfBf1x4EdJmJvcIC32
         PU7uXgPEDoiyd++/8nHBf5Jwuzbj8vFWKMD/471m3tEKDvPN4DdyhGm8WumQ7rpAESpw
         POFDLj/Sa6Pn8qzkoSUQhFaGFzhUNejy4aTg1uYwQjAodMnbYGE/ArBlbG4r6rzkEXuo
         ATKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jJk3Wy6VsVsOm2tohtCthVTrOWPBDptabDnJch7SGo=;
        b=ZM2wTYRmNIClwbVxGyH99BiejnnhtYd1Fu4J3mtcR3Z5u53wItM8cvFO3Wcnj40lhz
         6bLM6U98u/4kWYutTwUrU69DrOI8Ub+4v6rvco3fKGPyOLSzCL6LmLqhVdnzmLzim/Ud
         jzCUT/WsiZ5/3PA3MZ95zDtDt8zRmp6nU7tjoyOeUaHnF9OVK2XkeMV3pE4opJz3XhD5
         KwXApsCtAtpFexzEQ05m4erVj35GIWA+oUg0/FpFS3fE4gADIyATJ2gREBqfdTc1yg9O
         KYAPlhlEdxsfENZRj65GeLAX6GMq65BwegosYWqQ83XToclFsqFWoolZLgPP6FpvpaeM
         h6PA==
X-Gm-Message-State: AOAM530jYDk2UYPVcT6lguNxosJr35yOEQuFzFvNGZY5ux4i0296EQaz
        YCWCWuOzDcsJ1YxAkYcmtQWgzQ==
X-Google-Smtp-Source: ABdhPJyI5Bh322cKTpO9jFzSgeb/kBbIuBpozGKZDMn2i+tRC2UgBBDiEp6I43P03sYG+CqUl4uMgQ==
X-Received: by 2002:adf:9467:: with SMTP id 94mr1473853wrq.235.1611009579733;
        Mon, 18 Jan 2021 14:39:39 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 06/20] RDMA/hw/i40iw/i40iw_hw: Provide description for 'ipv4', remove 'user_pri' and fix 'iwcq'
Date:   Mon, 18 Jan 2021 22:39:15 +0000
Message-Id: <20210118223929.512175-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_hw.c:172: warning: Function parameter or member 'iwcq' not described in 'i40iw_iwarp_ce_handler'
 drivers/infiniband/hw/i40iw/i40iw_hw.c:172: warning: Excess function parameter 'iwcp' description in 'i40iw_iwarp_ce_handler'
 drivers/infiniband/hw/i40iw/i40iw_hw.c:529: warning: Function parameter or member 'ipv4' not described in 'i40iw_manage_arp_cache'
 drivers/infiniband/hw/i40iw/i40iw_hw.c:592: warning: Excess function parameter 'user_pri' description in 'i40iw_manage_qhash'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_hw.c b/drivers/infiniband/hw/i40iw/i40iw_hw.c
index 56fdc161f6f8e..d167ac10c751a 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hw.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hw.c
@@ -165,7 +165,7 @@ static void i40iw_cqp_ce_handler(struct i40iw_device *iwdev, struct i40iw_sc_cq
 /**
  * i40iw_iwarp_ce_handler - handle iwarp completions
  * @iwdev: iwarp device
- * @iwcp: iwarp cq receiving event
+ * @iwcq: iwarp cq receiving event
  */
 static void i40iw_iwarp_ce_handler(struct i40iw_device *iwdev,
 				   struct i40iw_sc_cq *iwcq)
@@ -519,6 +519,7 @@ enum i40iw_status_code i40iw_manage_apbvt(struct i40iw_device *iwdev,
  * @iwdev: iwarp device
  * @mac_addr: mac address ptr
  * @ip_addr: ip addr for arp cache
+ * @ipv4: flag indicating IPv4 when true
  * @action: add, delete or modify
  */
 void i40iw_manage_arp_cache(struct i40iw_device *iwdev,
@@ -581,7 +582,6 @@ static void i40iw_send_syn_cqp_callback(struct i40iw_cqp_request *cqp_request, u
  * @mtype: type of qhash
  * @cmnode: cmnode associated with connection
  * @wait: wait for completion
- * @user_pri:user pri of the connection
  */
 enum i40iw_status_code i40iw_manage_qhash(struct i40iw_device *iwdev,
 					  struct i40iw_cm_info *cminfo,
-- 
2.25.1

