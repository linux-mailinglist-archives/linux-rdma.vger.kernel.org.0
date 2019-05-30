Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B003A2FC19
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfE3NSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:18:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47043 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfE3NSj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:18:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so4174826wrr.13
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uR36yYlKTmF480r8eJEjrwEZOywQetq+uTRan3vJDhA=;
        b=ijDaQOk86MtbhQGm3COanFvG0aFIt6k/sYD2LhuyaQtRaa1G8tz0gCmlY7ZW+qPwxJ
         QRTXop1gaqt5UTK/MY2rUnt8k1cGqChzsVpBYz6tgjwLLZkw74vK1L/mJCE6Ye+XDnVY
         Q4BkgokNWcp3d7CmTqVEZo2QKjWYuIoVxltszzBwXtNSQjOGmV831mrpIOpLHS9hGFIK
         2VeXcXINAO72JKpM9uktPExm637eyW3FDqC+s71d7f6IBvgDuzFfUE7hjxUnAmT0z7OO
         zt+k0Ipf8CovxO9D7SkMK7kFU05Rj1kBj+rfkY1+/+b59B+eAKHZkqGDG71Bu6G79G/e
         8VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uR36yYlKTmF480r8eJEjrwEZOywQetq+uTRan3vJDhA=;
        b=oRz5MBml6+FRfnt2ZSTk3uQWlybZ6dOscBBnfWeMcJpXdhCch2Ix4m4PA62m5EMfbS
         oYKY9e5V5lHvA6lGf9T+Mj4333XkfHR4RsqGhDbVoAT82xoPNalnPigpo3ai4K2xu/CR
         zq/TW9OvMcOmTF8ediolD7oz+qrUZP7xM5oEtSBU1abpSryS1yvh65sSik574UoWlY4K
         I+tZDq+ed5Ph1+LNfW63HymDA06kEG51HJA9fIuOnQDmSHwTLXtMpqCGcMD4LwhEmHx7
         HaIYIuUR67g6l4fI+jun9eV/jMr4eNaSs9sjoeIgYYV2IhTEtuTVZuM3Bwx2e764+8Ju
         gRZA==
X-Gm-Message-State: APjAAAWuXQ7QrpVZba6Nv0J556AR9DFKBYpyvu2Ru3nJXC8Ua78QFKJn
        IhEHJMpdyyeg6UWpQWQ8w147x1lexeQ=
X-Google-Smtp-Source: APXvYqxB+zPHFF9hJXSNJzy860zCm83xM9z0e6szdaiMBsWK0SCNibdWzx6dMGF2fJ5YnkbZebrQ/Q==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr2576676wrj.246.1559222317920;
        Thu, 30 May 2019 06:18:37 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id l12sm2475250wmj.22.2019.05.30.06.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 06:18:37 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/ipoib: Remove check for ETH_SS_TEST
Date:   Thu, 30 May 2019 16:18:17 +0300
Message-Id: <20190530131817.6147-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Self-test isn't supported by the ipoib driver, so remove the check for
ETH_SS_TEST.

Fixes: e3614bc9dc44 ("IB/ipoib: Add readout of statistics using ethtool")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 83429925dfc6..b0bd0ff0b45c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -138,7 +138,6 @@ static void ipoib_get_strings(struct net_device __always_unused *dev,
 			p += ETH_GSTRING_LEN;
 		}
 		break;
-	case ETH_SS_TEST:
 	default:
 		break;
 	}
@@ -149,7 +148,6 @@ static int ipoib_get_sset_count(struct net_device __always_unused *dev,
 	switch (sset) {
 	case ETH_SS_STATS:
 		return IPOIB_GLOBAL_STATS_LEN;
-	case ETH_SS_TEST:
 	default:
 		break;
 	}
-- 
2.20.1

