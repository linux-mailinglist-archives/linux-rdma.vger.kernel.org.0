Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFF7357E28
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhDHIet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhDHIet (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 04:34:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E49C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 01:34:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r22so1363646edq.9
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+LFQ/PnHZ1xfPLVXvJl5z9X7NhpPOqgzc8b8A1aKVg=;
        b=CzrXFHvkUQ1eJkxk9O5CqEhtH3XE8vGi0fHT9dOsYN/F6Q8BJy1v+BKI7VJB9SWINO
         P0Hg9BvV9giKxTHpsqmGAd91oNs7tlbApb3dvc2bCDdQm7TgP3ZZILQeP7/mcDjK3laH
         ox3MFXrx/Nc25KktDOHsEpXib/zBFmYhYKOuzt3nr9cQpp92z6UMx1oKO1Yfz6iyBOtL
         T8/JXKiV8uf/2tvvqwQFDDyAp38RyOdkhELNwYEuVTI9sZaHVyOZDbEfrUH+dQORkBk1
         jD7bI0u/NdlZ0pyrIpEokBioM8tf3bexxrI/VDStsMfPpUtqOG4vGiv7LsMxmE00gJIk
         JmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+LFQ/PnHZ1xfPLVXvJl5z9X7NhpPOqgzc8b8A1aKVg=;
        b=E/dk+RxKbVW7ItlgMhxURKnn02PfkvMsQPTARpNfRSaMxyhQnyZ+w1gXqpgMRjNtqh
         yunS6k6kwsfSxIy9Afu9lcmq63OHS6wC8HZtAHuCCtJVTSkD1J4fEWjm1JWi6sKn2X8u
         g6C8CPDQ5YpRtnVtjVzFe/Ikzf7xuhMf96RhXPfxtOV3RZSs1sUftlox64aSA+hnu2dC
         wn47UXr8LddwqWimUydLXYUCD6Up0+X252v39Uu3AVhU+GKjzf5Iji55Tmd43Or0Fro7
         RETLqecv7mBpBnt4g02ABK9ul+wjeCa4PrwfHtkdfBOfbnidqF2Vu02e+pGKOYf7md7q
         VDdQ==
X-Gm-Message-State: AOAM531TASVjD8g+lBmmXns6glZIZqXhmfJrblMuVL8k0EWN6B4ES904
        4nm3nd0a6e5yIRmLeR3nKzhdV0nV+l9PIg==
X-Google-Smtp-Source: ABdhPJz8dxWpWzswY/RiC2X0rgswRr/zOXKA4PnvYJudQ6tmDpRIzDE/l/7CD9WddjXypfkdm2ve0A==
X-Received: by 2002:a50:e607:: with SMTP id y7mr9935112edm.18.1617870876865;
        Thu, 08 Apr 2021 01:34:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4915:d200:c1e9:172b:fc28:18a5])
        by smtp.gmail.com with ESMTPSA id r25sm17196344edv.78.2021.04.08.01.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 01:34:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca
Subject: [PATCH] RDMA/ipoib: print a message if only child interface is UP
Date:   Thu,  8 Apr 2021 10:34:35 +0200
Message-Id: <20210408083435.13043-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When "enhanced IPoIB" enabled for CX-5 devices, it requires
the parent device to be UP, otherwise the child devices won't
work.[1]

This add a debug message to give admin a hint, if only child interface
is UP, but parent interface is not.

[1]https://lore.kernel.org/linux-rdma/CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com/T/#u
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index e16b40c09f82..782b792985b8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -164,8 +164,12 @@ int ipoib_open(struct net_device *dev)
 			dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
 		}
 		up_read(&priv->vlan_rwsem);
-	}
+	} else if (priv->parent) {
+		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
+		if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
+			ipoib_dbg(priv, "parent deivce %s is not up, so child may be not functioning.\n", ((struct ipoib_dev_priv *) ppriv)->dev->name);
+	}
 	netif_start_queue(dev);
 
 	return 0;
-- 
2.25.1

