Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129922FAD86
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbhARWk4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbhARWkQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8496DC061757
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d13so17874115wrc.13
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBTSSoCXxREsZFAmmX/GpB9ZPMIR59wSvx0flaJq2Y0=;
        b=G1CA1CTcg2soi6z2VIAwSsq7evwrTn1uKE9nB9LLxkvgp0uIKZJAnTOhq41B9ugXi8
         AdFDXf1sNPgUQpVDQ/uYUr7s8D+RLcBD09K0wML8VW/rTY1JB+B2ekkNxLrQIUJzAWDk
         hlc2UVK+7HgL21ZQMnNeAu6rLz3QkZAoZ8PM/meM0PRxRg3j1Q9N2LwBdsyq6LtSsxx6
         nOE8PtIla0tmNJi9YTn8uz1zID5z5UiPNWrLS6wzjsCLuXNcfSSg6cXLMnOz6epmBgSS
         wbPHKWOCOoRnAy0rVyZq8xgzZWvKG/KCWqK5t5id6nVWVLV6ZGkFqP2Xo3R1lJMKbqoW
         S9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBTSSoCXxREsZFAmmX/GpB9ZPMIR59wSvx0flaJq2Y0=;
        b=Vz+UbLv/MrsOqL3GLX60OUDp6UwAuf56DXdgHRVJ01gq8o3kpeW+LQPaKITgpHRDdA
         AhNRQk+AMly5qlO3QW5gA9ACyw4UpsAga/LCNmlsTJHLfeIZD9Mfx3lNBwoxv2TNWcAl
         kKc0WgFC1tbZVVbvJYWaGZwShdWs9B331UMA1vVeIPNu2riGg/gizD0xqBC2DClSWbK/
         yVX2UCn7Wd+Ao+smk6lpCjkJWDNPQVpUR5QCIIq9oJKOVL1LAbHN0ExE6feYnFvWt/85
         MD1jSCTIZcrK28RrX5RQLzETU9YJcqQiPDalJNfha7g+baOMOs4ZneStabfKkZfqpic0
         1TCw==
X-Gm-Message-State: AOAM533QXdEbe9WUkiu5pE/t/8FT4Ddy9EoXjZfiyHmE5bs8TyGKoxDe
        ULnm/kiLOINmAGAGqWkzerTNBA==
X-Google-Smtp-Source: ABdhPJzkj5gadzjX5ycNXDkOys2Dmknt2x/f5AlQ4lXy45zYV9LoqY3r4MNb3Raw15rGy7jCI+KaZA==
X-Received: by 2002:adf:b1db:: with SMTP id r27mr1462192wra.125.1611009574195;
        Mon, 18 Jan 2021 14:39:34 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 01/20] RDMA/hw: i40iw_hmc: Fix misspellings of '*idx' args
Date:   Mon, 18 Jan 2021 22:39:10 +0000
Message-Id: <20210118223929.512175-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_hmc.c:64: warning: Function parameter or member 'idx' not described in 'i40iw_find_sd_index_limit'
 drivers/infiniband/hw/i40iw/i40iw_hmc.c:64: warning: Excess function parameter 'index' description in 'i40iw_find_sd_index_limit'
 drivers/infiniband/hw/i40iw/i40iw_hmc.c:94: warning: Function parameter or member 'pd_idx' not described in 'i40iw_find_pd_index_limit'
 drivers/infiniband/hw/i40iw/i40iw_hmc.c:94: warning: Excess function parameter 'pd_index' description in 'i40iw_find_pd_index_limit'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_hmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_hmc.c b/drivers/infiniband/hw/i40iw/i40iw_hmc.c
index 5484cbf55f0fa..8bd72af9e0990 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hmc.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hmc.c
@@ -46,7 +46,7 @@
  * i40iw_find_sd_index_limit - finds segment descriptor index limit
  * @hmc_info: pointer to the HMC configuration information structure
  * @type: type of HMC resources we're searching
- * @index: starting index for the object
+ * @idx: starting index for the object
  * @cnt: number of objects we're trying to create
  * @sd_idx: pointer to return index of the segment descriptor in question
  * @sd_limit: pointer to return the maximum number of segment descriptors
@@ -78,7 +78,7 @@ static inline void i40iw_find_sd_index_limit(struct i40iw_hmc_info *hmc_info,
  * @type: HMC resource type we're examining
  * @idx: starting index for the object
  * @cnt: number of objects we're trying to create
- * @pd_index: pointer to return page descriptor index
+ * @pd_idx: pointer to return page descriptor index
  * @pd_limit: pointer to return page descriptor index limit
  *
  * Calculates the page descriptor index and index limit for the resource
-- 
2.25.1

