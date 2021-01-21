Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182D02FE6AB
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbhAUJrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbhAUJqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05CC061795
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:29 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v184so938859wma.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l90cpQ/e0T6TuHwbhU/4LDQoeOSySsNazUcP2W8fpcw=;
        b=L1EpP2OlDV281D8ChiGh+C9MURnk5TsQ2b0hrO8AIuw6a0RHnu43Wnv3e6Ka1XH6YU
         ycjd3SONVCJOuz4cE03wkdbqQRMRtf+GV3/rW6SNeK5AIN84J/F88FjfUkeJPQlRVjyu
         gHTkRbeeuceYrm+Zf/lXZA2AIdL0t+HpKXpLem2AfDc/WiPGXAw0Kppj2MXpULyjRSri
         GwxHEHdTs/j9C09/0OlycRKvczqMD31fL9m+DUSvPfobi3jr18BQilUQIky9RF9ufdsL
         WYwelapy5ylUtEymKJl7PV3I0S5I58bNZyOymZnZBav2OAnZEmUfk4fg0uZNO41Jaxea
         tdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l90cpQ/e0T6TuHwbhU/4LDQoeOSySsNazUcP2W8fpcw=;
        b=rPhHn3XQ2NpgEz3n4UWX/RHIm98fYhxI7vYzEAT0O6F1XVlXIUt01Aqphlpg43Nkh7
         WkjN43kXUv50y1+lvPWMPC2Ggi7htMRbzj1P4hEy+BQE6R9QrvOZ2OZCA3Wd3Fl1+GRM
         V6/a+wE7tKdF1kKAQxnBdGjUP540WnUk4u0ZTk6NokKXr1UktRoG5mHHrqLmSx25//r5
         0ZxMkL1HF5HaLDj61visTX5ygB1q9KoI/QyWanDhT2kotePTRiQJC6k3lWkjfuJA3u7g
         45TFoqBzAASZs0QbrxQRCn7sKWA4dFYcuy3ZdykbnE89lRaCN1kpPE3HUQBmFz5J903w
         5bDA==
X-Gm-Message-State: AOAM531+hnBDRQXZ5OWLwh7bNb/psk3O2CuWN2pW+7eIFcXeMaRoTC0A
        w0cnwmA1W18yIjV1ZihfH7AXRg==
X-Google-Smtp-Source: ABdhPJxi6autxrB/UQLxpm5CwpzYbaV6KpUuwNif9ZzlofRVk0JZbRFYvUwAELNzokX8sqEzjzTAFw==
X-Received: by 2002:a1c:9e02:: with SMTP id h2mr8144143wme.107.1611222328098;
        Thu, 21 Jan 2021 01:45:28 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 05/30] RDMA/hw/hns/hns_roce_mr: Add missing description for 'hr_dev' param
Date:   Thu, 21 Jan 2021 09:44:54 +0000
Message-Id: <20210121094519.2044049-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hns/hns_roce_mr.c:1003: warning: Function parameter or member 'hr_dev' not described in 'hns_roce_mtr_create'

Cc: Lijun Ou <oulijun@huawei.com>
Cc: "Wei Hu
Cc: Weihang Li <liweihang@huawei.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 1bcffd93ff3e3..1fbfa3a375453 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -990,6 +990,7 @@ static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 /**
  * hns_roce_mtr_create - Create hns memory translate region.
  *
+ * @hr_dev: RoCE device struct pointer
  * @mtr: memory translate region
  * @buf_attr: buffer attribute for creating mtr
  * @ba_page_shift: page shift for multi-hop base address table
-- 
2.25.1

