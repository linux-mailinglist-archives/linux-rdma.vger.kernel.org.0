Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023A72FAD6A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbhARWlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbhARWlk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80CC06179E
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m187so8651698wme.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86gvnGKQHdCvVkLQzK21Orp2OLD87mODwa7Ek0IG0og=;
        b=hSxI++TxLvFlHH4o7UXPnG+kAeJcYUhBgBjsWHbgR6MQtl2LrjfnpCL0MossaJf0EU
         qvNleeeWyqMQ5/HJjKBmukXo4Yss/jpw7LXmTH1IJUeg2BpFDSMkGMCTPqJWK5elMXLw
         LUCnjKNliN415EisAmaIFmsbM1dZrwSPsmMLFtQa3og8hT5Svfik9egJc9fK2VwFRzci
         4ggpWOLE3dbgDa5Oif5fBLpYfZVJJBozx5+BwgmRJiCbteM/Ld4EbK+q4K4Xkr+RwCOs
         2Uz9c5ZyVWJ/VrVntQhh/vFoA1CzMbpWdBYygIB47fqeQ3Fw+yr264LpdEPUmSE8u93L
         FvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86gvnGKQHdCvVkLQzK21Orp2OLD87mODwa7Ek0IG0og=;
        b=FVjDtGrtkVuL9T/SnWhWdXqOPnukmBzuDsVrak88bdepcBRyRqrCMRpA8WUbjPv2Xx
         mv+WP0+XbZ2AunV44LZm5M37vbBvK74S7mp+qq+50BQN1tue6hjnsfuNOuT/M6Tsx+gD
         1vjN2QZhzLCH0ymuxnAnPAcdNPpcvCwArci55LIeO6cYFfvHSQp6S1yoZeFCrLz83ItL
         Hl5+TGD/YU5V2nJ4xPDa2rfWgNs/bY8W19A2A2g9KJMTPPIvDdOLsQ0mF+NGO8aGEGTU
         pDqpk80+Zl4Br6STXP+7/twWTjh4Bl1C4DXYWkdJpnVVWZSbVxwXFbegSoxTCHjE3/Rj
         C32A==
X-Gm-Message-State: AOAM533WxC3CtdF+PPqaHGgd2xYF8wfERZPDL6scvHQEt/h7Bna2ee52
        veUzYBNKhu6Ky5U+Au0yHVE/Sw==
X-Google-Smtp-Source: ABdhPJxlkC+SPBlayOB+IjTF93ziRt/IcYSitdBJTEE2xpshtaMrhQMIl9oUbbWG+x2nj3/mbPBt+w==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr1290796wmc.185.1611009583009;
        Mon, 18 Jan 2021 14:39:43 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 09/20] RDMA/hw/i40iw/i40iw_pble: Provide description for 'dev' and fix formatting issues
Date:   Mon, 18 Jan 2021 22:39:18 +0000
Message-Id: <20210118223929.512175-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_pble.c:60: warning: Function parameter or member 'dev' not described in 'i40iw_destroy_pble_pool'
 drivers/infiniband/hw/i40iw/i40iw_pble.c:120: warning: Function parameter or member 'pble_rsrc' not described in 'get_sd_pd_idx'
 drivers/infiniband/hw/i40iw/i40iw_pble.c:120: warning: Function parameter or member 'idx' not described in 'get_sd_pd_idx'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_pble.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_pble.c b/drivers/infiniband/hw/i40iw/i40iw_pble.c
index 5f97643e22e53..53e5cd1a2bd6e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_pble.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_pble.c
@@ -54,6 +54,7 @@ static void i40iw_free_vmalloc_mem(struct i40iw_hw *hw, struct i40iw_chunk *chun
 
 /**
  * i40iw_destroy_pble_pool - destroy pool during module unload
+ * @dev: i40iw_sc_dev struct
  * @pble_rsrc:	pble resources
  */
 void i40iw_destroy_pble_pool(struct i40iw_sc_dev *dev, struct i40iw_hmc_pble_rsrc *pble_rsrc)
@@ -112,8 +113,8 @@ enum i40iw_status_code i40iw_hmc_init_pble(struct i40iw_sc_dev *dev,
 
 /**
  * get_sd_pd_idx -  Returns sd index, pd index and rel_pd_idx from fpm address
- * @ pble_rsrc:	structure containing fpm address
- * @ idx: where to return indexes
+ * @pble_rsrc:	structure containing fpm address
+ * @idx: where to return indexes
  */
 static inline void get_sd_pd_idx(struct i40iw_hmc_pble_rsrc *pble_rsrc,
 				 struct sd_pd_idx *idx)
-- 
2.25.1

