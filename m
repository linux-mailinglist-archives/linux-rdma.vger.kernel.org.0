Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB4303E11
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbhAZMze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404087AbhAZMte (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B22C035438
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b5so16308222wrr.10
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+DMI0EXUYJJLvmmH2bAEB7JiPLoVbXeT/sw5HJ1UT8=;
        b=BFvftWxNjJ1f8kZeSk14lsUMun1/l2fh/zf2H/00VdGTMPu6yAgBNrw7KEwZi6M1wS
         mTWkBcyI8MQqtNZJFTW2FOyW10BxStpDjS71ik/aSVyBT2eYIffwIu2tY+uO1TWDUmlm
         wkNPljH37Zm3tX8CbgiHUQcguqlyY8aARKGG+27JgQPjbb5VG7PWKilCrUZaS0NOL3xn
         KSJGvD7Ah0knlmc6gbCugR3iVZaJA+eKz7fqGFmVZavgQZ2j1g/lZxO1iYKLJ/FHD1kV
         JFREmbuOCnycRzarZqSlPOzfAUp/Nz9SIuUpOWHXI/6PUqKUFh001jcQXvq7eM510Oow
         DEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+DMI0EXUYJJLvmmH2bAEB7JiPLoVbXeT/sw5HJ1UT8=;
        b=iq0Zi7BYOeG7UFzAQfngvjyyv0MhlMtnG6mVfjI4qE4MGE/ArNC586b8aH6z9ONteo
         8dZJKGM2hiBEV5OmBbBWSF8w5fp1z1h9mQ3xSBRE/Qg7dsvSeRMe/BMVruYs5aihu7t9
         NN06XOcSWJrDvVBvYjv6zCW8uPf6Qrf1HT+SCAOHEUpQl7ferDe5Dn6tXa3POXC3Wu60
         mHw+96xYzpdyocEe0gtW2RnnPY8L6dUKTqVnndlhUlEjt727e3+ugHZGG9J9CwFrZb23
         zKTooDFNTN+tP1VTxlg4zG5oBsFa5S3jvpD5Jav5OzWqxNxZksEpdsjptdpjVhQ3zlqZ
         fBvg==
X-Gm-Message-State: AOAM531e+Rb6dgj40zomZZ7iMqZrmn73o3JBefKsVNPj/dsrsXUNbZts
        NnUAiH1vGPuuOCWwi7wbDLm0YQ==
X-Google-Smtp-Source: ABdhPJwrmxLQr9CLyptuMRo6dOqaAb/sply8hRE70jVFz+f/6LzkND+6LLI0NL6a3EFXnc8j3mCewQ==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr5872456wrq.187.1611665264670;
        Tue, 26 Jan 2021 04:47:44 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 08/20] RDMA/hw/hfi1/netdev_rx: Fix misdocumentation of the 'start_id' param
Date:   Tue, 26 Jan 2021 12:47:20 +0000
Message-Id: <20210126124732.3320971-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/netdev_rx.c:473: warning: Function parameter or member 'start_id' not described in 'hfi1_netdev_get_first_data'
 drivers/infiniband/hw/hfi1/netdev_rx.c:473: warning: Excess function parameter 'id' description in 'hfi1_netdev_get_first_data'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/netdev_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 6d263c9749b36..1fb6e1a0e4e1d 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -467,7 +467,7 @@ void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id)
  * hfi1_netdev_get_first_dat - Gets first entry with greater or equal id.
  *
  * @dd: hfi1 dev data
- * @id: requested integer id up to INT_MAX
+ * @start_id: requested integer id up to INT_MAX
  */
 void *hfi1_netdev_get_first_data(struct hfi1_devdata *dd, int *start_id)
 {
-- 
2.25.1

