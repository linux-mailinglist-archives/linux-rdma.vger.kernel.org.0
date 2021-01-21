Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D62FE6AA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbhAUJqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbhAUJqd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87715C061799
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m4so1046647wrx.9
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulUZihKhMqKu/FrEiWqrt3ulvrhzcfuoTPlw0e6qsC0=;
        b=s2Jpzxqbxd53qzUNbh7UAVlZrjT6H0kWcYwxFsR4dCFFaDnTqYtpashSgSX5gR2JDP
         38nju6rQs1j2eYSe9SOopw/xTiIwmUqQxwnNDVnPtTslhmG3/ISkq5jLXxMx9qUYpBsU
         wxREzxxNKT6OR0tMGsFojbYU6cNzafQ/4h1XquOj3DnZlyhaxbI2OTLXoPq/l7JuH/QR
         RNl+UFzRnQnbeaU4B2hLApOxSw2UPdf71nzaj4YK7WyeuKKF3CoFUdRdulqy5FwbFbmO
         E2odcOx0e9wpUBn0TSVxNq+QXuVxGOHRFfac/EvjPM+/vt3v+mpAFLO1eb6ev/Cm4M5g
         s4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulUZihKhMqKu/FrEiWqrt3ulvrhzcfuoTPlw0e6qsC0=;
        b=e/nJAC/s2sbyxBW1UW8gfCijMPXvYYbEP7CCo4LYcibJrBWpobRlOFOeRuHiE2CIgd
         bAB+zptDEGC93MrCMZUwosqBzvjyqGkyUpsfP5jAtpu1QJfUIXQL45LJX4wOpyw059Kz
         Y1UKR8jQ678CEEHCTw0MPqapIeFHe+iumLKqCv83RJTH9IBZytBue9sQ+/wHi3y7MwhK
         d2cTufdPtPDW2zuvruR2fYywCCxnWkeRbZkumwZXsS/FV89Q9Nk6sHZecxTFpMoFujs6
         3E1qqTzQ12frZxFMfMHjYn+YYXb+yX0gKZIzCLg6n30R9MszpFiD5mVL1SiU81kf+lLe
         4xyQ==
X-Gm-Message-State: AOAM532NZiLToXeWXK9k3wXZ2CD9fi/NJDBo86y1zZqA9DVCfXcxBB8L
        WxxZKRuDXT9Mioo8HiCVK1+PVg==
X-Google-Smtp-Source: ABdhPJyloRfA7yE9s0rM4TaoOVsvlwgbcPwr1rQdlqGPliv4/vSWBDY68K0cjoDWPAyHsb9j/ShwZw==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr13325203wru.87.1611222329357;
        Thu, 21 Jan 2021 01:45:29 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Intel <ibsupport@intel.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH 06/30] RDMA/hw/qib/qib_driver: Fix misspelling in 'ppd's param description
Date:   Thu, 21 Jan 2021 09:44:55 +0000
Message-Id: <20210121094519.2044049-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_driver.c:165: warning: Function parameter or member 'ppd' not described in 'qib_wait_linkstate'
 drivers/infiniband/hw/qib/qib_driver.c:165: warning: Excess function parameter 'dd' description in 'qib_wait_linkstate'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Intel <ibsupport@intel.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_driver.c b/drivers/infiniband/hw/qib/qib_driver.c
index 92eeea5679e2c..84fc4dcc5399f 100644
--- a/drivers/infiniband/hw/qib/qib_driver.c
+++ b/drivers/infiniband/hw/qib/qib_driver.c
@@ -151,7 +151,7 @@ int qib_count_units(int *npresentp, int *nupp)
 
 /**
  * qib_wait_linkstate - wait for an IB link state change to occur
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @state: the state to wait for
  * @msecs: the number of milliseconds to wait
  *
-- 
2.25.1

