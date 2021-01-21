Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51E2FE6B1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbhAUJrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbhAUJr3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9CC0617B9
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so1036127wre.13
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4lWsX1/HMWo9e2h+pWPHWU7/13R9cTAE/+8ZINfLr8=;
        b=ScRTv9wJ+i/WWqoj5qdXsAVNJgIefZzJ7qKjwF3BXsDzblOmxnzAyBC9JYi1rNS5jH
         CKZczGXBrR/G63fNlKwXytTljWa8Lqi8dLYjFF710lzxfm1S5GwiVWt5HRMaMpvi5SDJ
         SC1Nc0fdBor+jNndu1vuhXYY42tH8qbbaTSjw8K+ZWuWqD9D/BBnW7I1u5S/ykBwKUmZ
         sQie9KA1cXarCU35luoIzbQNiRdDFOswnSE0gQYKrNah6+i0tKpPgVDnPK64pWpsIBwp
         ZwUtuEoqx5+48c5EIPpff1msG781IGPZiFh2p15nyH5/AEmPtaZjw/B3ph339hVjXK4D
         mJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4lWsX1/HMWo9e2h+pWPHWU7/13R9cTAE/+8ZINfLr8=;
        b=Mons7vtLdK5gwx5JDpNlxTrj4Xi9ugEY4EWoVvPONrwCMptpNHJE/r9yGIV8PGeaCX
         pNw97Pg7XbN1yGcLadAX2gcgFRMCjPFmClYMKmFuHxbtLtopQ4vSF2ZedUUunJS1k2E8
         LTw8KxiEFzCLpmFBIYWjKfePFQHAogK8BMaRiWnGCgIDYHB0Jw2gCr/LuB2Hhm4x6T7v
         mxFwbz0cBEVOzpPjqOjyvWOfo19WPBYLgX4kCECIpIE2OiDek+XhHmejC5xNzi1IcdXC
         c5Ppxx/hQtH+gUf99CvmnnSMQY9ztFCZ6uCH06dvX1o0kVjUtWU1dXUHbn8xyOaWpg6L
         Dudw==
X-Gm-Message-State: AOAM5336btbBV6Gj+UvpxWTkwjbgruEyRsBkTrLG4kNBK7HYLQx+fCnf
        KQ0kyH2mx+WT8FV/FX21PFL71A==
X-Google-Smtp-Source: ABdhPJyEfsOYnrJQ5QY9vXKSK3jdn1xNP/R9pYUB3pJz4ZQIRAiHBZc3WYoVE2GOJnaVWPnTJ+/5CA==
X-Received: by 2002:adf:ee90:: with SMTP id b16mr13298698wro.221.1611222342589;
        Thu, 21 Jan 2021 01:45:42 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 16/30] RDMA/hw/qib/qib_twsi: Provide description for missing param 'last'
Date:   Thu, 21 Jan 2021 09:45:05 +0000
Message-Id: <20210121094519.2044049-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_twsi.c:175: warning: Function parameter or member 'last' not described in 'rd_byte'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_twsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_twsi.c b/drivers/infiniband/hw/qib/qib_twsi.c
index f5698664419b4..97b8a2bf5c696 100644
--- a/drivers/infiniband/hw/qib/qib_twsi.c
+++ b/drivers/infiniband/hw/qib/qib_twsi.c
@@ -168,6 +168,7 @@ static void stop_cmd(struct qib_devdata *dd);
 /**
  * rd_byte - read a byte, sending STOP on last, else ACK
  * @dd: the qlogic_ib device
+ * @last: identifies the last read
  *
  * Returns byte shifted out of device
  */
-- 
2.25.1

