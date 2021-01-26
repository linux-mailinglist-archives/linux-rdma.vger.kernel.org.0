Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE7303DA7
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403987AbhAZMu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404108AbhAZMuG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977EFC08EB30
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m13so1882875wro.12
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpANnWfGT2qFPSHlNEWTmbJ1paMcoIJGvrRr1eRAMJE=;
        b=elRCoD0E+0EyiixUe4a1EB+4QZXPB3Rc7DM40jZU9+fIbi8dg5nsnJG0nbovfzqy1M
         csONUjfx2MdwVvhkhkgRD7KhgaJSn/HM1hM7wrhMx+mq3Q+w/pyOVdfLyKyPJThdIyXx
         tTx7izzkrcjpvF/ybDkHNhY96HYJXm8R49kYKVYM0R8tZF2dAdNwMWxLm+F9Ng8GFViS
         deXzu9E57xoZRjxcr8LUXfv11flWbtwBhVgedFQzNQ1IE1WxgWsPynNLQOxy5k6bdgj3
         XQ3D+2IcZJ2f9hM3vnr1DK8sIejTFlPSSpfto7GH7yXeMYWz6Mvfwa9/z7dOt7/KoH/E
         XK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpANnWfGT2qFPSHlNEWTmbJ1paMcoIJGvrRr1eRAMJE=;
        b=J5F6BdXNLGylHDdpyD1+qYaKIrl99WTOgreB/cZYDLNdkkH6/BCFDVWbZWVZsIRfwD
         vOkuIPLI4k5Yli2+IoiTJIgpJvVl4BtHo0LqEliuLwLKjDCPVmez1ILSXxIwWn7zZJUH
         uJUTuU5rmnVIJ0EwUskYQNikAghy7NHpnDyXQfKBf+VsHrqsBPtzIt9SCPslZywPos6d
         qVCfsqBlPSOJInTv/4WVDahpzlvGmRmHJyI5NowLur1xuzeXAJIZsAVCCaCEN8Co6urB
         gZRhcrAfsssNveYiQmnPDOvJfMBW19WTlV+oPPiFhqn3Tztv4Leus46FTMUjsw7nUnRX
         sa1w==
X-Gm-Message-State: AOAM532+XqY26n4QOm3twkZvnKxhQJUleAMqVk3GckyI4nxVSzwl0cB6
        VcK8PUnTdDlCAn6JQMCvN0h17w==
X-Google-Smtp-Source: ABdhPJxRSdr8DaSZ3Ha889ki6igIj2ynJ5QQ+X5CFywOPJ1iNvepjcEBe8xUh3/g3cl2uRdPipvcVA==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr5939543wrn.99.1611665276345;
        Tue, 26 Jan 2021 04:47:56 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 18/20] RDMA/hw/hfi1/user_exp_rcv: Demote half-documented and kernel-doc abuses
Date:   Tue, 26 Jan 2021 12:47:30 +0000
Message-Id: <20210126124732.3320971-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/user_exp_rcv.c:174: warning: Function parameter or member 'fd' not described in 'unpin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:174: warning: Function parameter or member 'tidbuf' not described in 'unpin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:174: warning: Function parameter or member 'node' not described in 'unpin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:174: warning: Function parameter or member 'idx' not described in 'unpin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:174: warning: Function parameter or member 'npages' not described in 'unpin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:174: warning: Function parameter or member 'mapped' not described in 'unpin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:196: warning: Function parameter or member 'fd' not described in 'pin_rcv_pages'
 drivers/infiniband/hw/hfi1/user_exp_rcv.c:196: warning: Function parameter or member 'tidbuf' not described in 'pin_rcv_pages'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index b94fc7fd75a96..58dcab2679d9d 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -154,12 +154,12 @@ void hfi1_user_exp_rcv_free(struct hfi1_filedata *fd)
 	fd->entry_to_rb = NULL;
 }
 
-/**
+/*
  * Release pinned receive buffer pages.
  *
- * @mapped - true if the pages have been DMA mapped. false otherwise.
- * @idx - Index of the first page to unpin.
- * @npages - No of pages to unpin.
+ * @mapped: true if the pages have been DMA mapped. false otherwise.
+ * @idx: Index of the first page to unpin.
+ * @npages: No of pages to unpin.
  *
  * If the pages have been DMA mapped (indicated by mapped parameter), their
  * info will be passed via a struct tid_rb_node. If they haven't been mapped,
@@ -189,7 +189,7 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
 	fd->tid_n_pinned -= npages;
 }
 
-/**
+/*
  * Pin receive buffer pages.
  */
 static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
-- 
2.25.1

