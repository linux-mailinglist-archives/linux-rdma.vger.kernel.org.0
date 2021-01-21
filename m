Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4A2FE6A6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbhAUJqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbhAUJqH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF409C0613ED
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e15so939338wme.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuWnTnQlKM5d7eIpepIHxbb/jr5fMrflS56XVI5B5ZI=;
        b=LVvJvw4WJe3+7vXijwOXM85K/2lPGitkue2jDfxepKvoOG6dCHHTDbzHSXWlKspZJu
         Hl2kNIBKk05w2PaoGOamZkh5lkelwiryKXtR9bx5WvHO6KHr/pZBczENO2+XFkYsvho0
         9OPBG6ai394ZE5c59fU8jXyRd80HHYkF8d3GpFCFbRuK89VI4qvJBMeLiSjVkVg8dA/F
         +uxND7F+FnmRyF69505R6IZutHG6wRACnILzSxy7EJKgGpWhl8kWHlx7fakTa74jnKEE
         alnse0sizD2R5pLU8EZEBi4nqYsuBYmelN6gg9XK65xNNrKbwRqwMtvIg5pr2FnJF0pK
         Swkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuWnTnQlKM5d7eIpepIHxbb/jr5fMrflS56XVI5B5ZI=;
        b=SZBS2oUAPsH+a8L2liySlwK2u6a9/z6C4/N0311bZBwcBYuzPfoIdhehjg4hedlKqO
         Vv89A0GdlgEq3e8In4yfIBBiFaVSKTUoIAmP/VYbIFFKJ/oAmCA22LGJ4i2XIXSsilaW
         F0yS/Gt2VjBOQZURGE0XwZLLfMJb28Gc+xdqu+HOOifsKzLSvoKQBqhzW1/MjNY2nnEP
         2mYrpVpyWVEtutjwTLHFsKy7KSZDKGi3xZ2ZY1PGHx+a8qqpN+boJUgUp7agYkyyMBqN
         Kdnhdt2McEXH2sYWpV24GfWEs02Un+LDBGsfKjM/nRuxpPrOO6yE5eTjC/ATXGvEtVi2
         +W9A==
X-Gm-Message-State: AOAM531qK7t28TWt0Kza4ZDQqZW4TIsm1OPm02d/k6Of2j+uY9puEKEH
        s76GP7XgQXSG8jPbvep2eI2Cxg==
X-Google-Smtp-Source: ABdhPJzZbE02TDkxHr4pcuDCcMT0VK0JklH7GHF4SOka1EHWF5SyStuve8C+Q8twGRUoeDsfSZlExA==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr8035775wmb.91.1611222325701;
        Thu, 21 Jan 2021 01:45:25 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 03/30] RDMA/hw/efa/efa_com: Stop using param description notation for non-params
Date:   Thu, 21 Jan 2021 09:44:52 +0000
Message-Id: <20210121094519.2044049-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/efa/efa_com.c:801: warning: Excess function parameter 'note' description in 'efa_com_admin_q_comp_intr_handler'

Cc: Gal Pressman <galpress@amazon.com>
Cc: Yossi Leybovich <sleybo@amazon.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/efa/efa_com.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 336bc2c57bb1d..f7242188a8434 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -795,7 +795,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
  * This method goes over the admin completion queue and wakes up
  * all the pending threads that wait on the commands wait event.
  *
- * @note: Should be called after MSI-X interrupt.
+ * Note: Should be called after MSI-X interrupt.
  */
 void efa_com_admin_q_comp_intr_handler(struct efa_com_dev *edev)
 {
-- 
2.25.1

