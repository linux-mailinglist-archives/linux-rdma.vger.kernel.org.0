Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF182AAB25
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Nov 2020 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgKHNWs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Nov 2020 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgKHNUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Nov 2020 08:20:46 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3CC0613D2
        for <linux-rdma@vger.kernel.org>; Sun,  8 Nov 2020 05:20:36 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id cw8so8418249ejb.8
        for <linux-rdma@vger.kernel.org>; Sun, 08 Nov 2020 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DV1l8lmjvdgn+Y3g2/iau26JAUepjL4LV62fgjbVGoM=;
        b=BP4VWh6O/zg9dh2ZJaQimN+pTUodjDDRmjvGP7d8/fP4FnZmKm22C4JJ2IcT0Io0GU
         keGj5kx/o9ImWYyOb0FKrO0hMwc60p8V9XdokTycxYNFyQXL2UL40FqQzY3e0mHdSJrG
         q1Mq3TMOD1LALZkd+uM2TK40eGqr7J1/A9Tj9a+SLX5gnPnXxeAJKk5XYvlXsey6V5+1
         vhCnRq9+ol1sbBZaUQc/m2yELYxGJn1TasEo0Wm8USsolFOdHtHjDwa/+XUh/VV4Ellv
         lQUWSeb0qCXv8Z+huv0Wh1L1HRmTA5S1Ph3lX8ZyNJXUT9LleQR54Uw3/xmJXFWTgF+s
         pXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DV1l8lmjvdgn+Y3g2/iau26JAUepjL4LV62fgjbVGoM=;
        b=UDWpG5WqIBTs++lAqfwbEQxzvKXHEQDnbFkrmErYtULfZmbaghIO1HBy8jxZnlJpdc
         S5G06Ugh/9voZahZiLCbbKw9WvoQ8TPcA+JtUqHcKtYmp1iyCXExNJP6D+DnrWLboPZr
         LFjQJ3ysEEtTSO8BEpBdqrFcZD157YZn1uYQ0LecuE3WnSG8jQIgbbaNG3iYmEatjnik
         ZZk+keLSdPE2oeu43TFOBdaSBc+C2CfwPq7Ipp2//hyJnvu3q6s6oSqJjZo9jYg5lN8C
         NVlPo/amJKWRHPn8gCOKTWg4UO5/EicS0xsFi7bdzA4fl7d6b2cwLIEy3XI5zzXATkdW
         uXhA==
X-Gm-Message-State: AOAM533l5Nl3LlA/sff+CsHC4jVubBiQUnanfC4pab7XbO2NRULfI2as
        SZRUB8XE354E+guifQujCTEib9Lla5ux4g==
X-Google-Smtp-Source: ABdhPJw3EYvIUv06HcZz/EVYW2TAO594Gel4UqS3nJR/939yqMMfPzCA874wfZUx6MrpL6ypm1QA9Q==
X-Received: by 2002:a17:906:1f85:: with SMTP id t5mr10528190ejr.352.1604841634637;
        Sun, 08 Nov 2020 05:20:34 -0800 (PST)
Received: from kheib-workstation.redhat.com ([77.137.92.108])
        by smtp.gmail.com with ESMTPSA id s21sm6041384edc.42.2020.11.08.05.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 05:20:34 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH] RDMA/cxgb4: Validate the number of CQEs
Date:   Sun,  8 Nov 2020 15:20:07 +0200
Message-Id: <20201108132007.67537-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before create CQ, make sure that the requested number of CQEs is in the
supported range.

Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 2cb65be24770..44c2416588d4 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1008,6 +1008,9 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (attr->flags)
 		return -EOPNOTSUPP;
 
+	if (entries < 1 || entries > ibdev->attrs.max_cqe)
+		return -EINVAL;
+
 	if (vector >= rhp->rdev.lldi.nciq)
 		return -EINVAL;
 
-- 
2.26.2

