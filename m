Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B331C68294
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 05:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGODSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 23:18:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39529 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGODSo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jul 2019 23:18:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so2746434pfn.6;
        Sun, 14 Jul 2019 20:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z4kjETcsOQ7zxbdUuLjrFFR0XL4cooqZlcSjfX5wl1I=;
        b=m5fYyXPGwjUoOc+/U0MnFqSE0b31yogmHRvZvmhtJBIZ+TYEWxeyiuzJtASkAMkMrk
         ARctKjc9+Kp1uNYAhmrol7/NCI9CDwm4WurKVxLqbMJewybuFY4y4EPCBCL7kdPjilJ/
         ruYdncg0vvTXBd47KL+/1P3JSnTt4TA043jrR6UxC1lOa8W66NgOZRplL64ECH3XsrXR
         +uRH0xKp2V4dBwXa/C78uhv69ERu5khGWauQrtZTE2HyFsIndHo+II8tjyn7CZvJFoEZ
         Tgo55JqVwZNKpDW91UPHrbuoUnMpYsxFz8Npn+YTj6dbH8kTfzFTiBN/9m0k/yuxzel9
         Z9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z4kjETcsOQ7zxbdUuLjrFFR0XL4cooqZlcSjfX5wl1I=;
        b=VavskbP8+c7MI73g+ZyEoVA3wGz+rM/eCmUnvYNpsMhblFbUIGzFq4TblXXg3Nbmp7
         gyV+kA2f4tP3SepvEQU8CfUmjoAe88tDRu6vPqKDRAhfEcl/qt5ee3Ak011QgvgfiGBg
         7NTadxkDFTqp7wpHD2Aey3FPvHySyWFj7chKo4UbiW7MY+KRppdk3i78CW8euZnFKnby
         ECOw5PNEhXWSuqaicBlyHLqgSmUn6Wkqrpim3s7UkkPhiDxnvgEjnd+Sj39w+7lXc/oI
         PymNUrAM8KOoYsT4+DbYwGAA7Cqt4s8dQJtnzD3Hj9Ra3N9at9yoa+lr+qCQswXCBnuH
         i12w==
X-Gm-Message-State: APjAAAWsSTy3q4hjGaYKmzH715xRbZ14kkq1oywkNXnVH/Bm0V/QlY/+
        iLzRZIj32dBLxj/p6rLZsPrU22ACjqw=
X-Google-Smtp-Source: APXvYqyAa9NMU5vwch8Q36opvQyfEBWBT23VoaQIZpnawtKECXvJ4SJmkfvxO2UkbKG5uuJGk+CfYg==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr27006346pjp.62.1563160723838;
        Sun, 14 Jul 2019 20:18:43 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u128sm18100644pfu.48.2019.07.14.20.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:18:43 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 13/24] IB/ipoib: remove unneeded memset
Date:   Mon, 15 Jul 2019 11:18:38 +0800
Message-Id: <20190715031838.6797-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

vzalloc has already zeroed the memory during the allocation.
So memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index aa9dcfc36cd3..c59e00a0881f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
 		ret = -ENOMEM;
 		goto err_tx;
 	}
-	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
 
 	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
 	memalloc_noio_restore(noio_flag);
-- 
2.11.0

