Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823D3357E67
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhDHItN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 04:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhDHItM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 04:49:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177FC061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 01:49:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e14so1651554ejz.11
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmPqQEGGBvTM8S5GAhggjaZeszV1Xly5RccQeZ3IzHI=;
        b=dKTDfn9+zVxTJl4WWksrPnGdeEprt5ejKK2vqZJees1ddlaC6BSbz5TCDAAjDrXD6P
         G3PZDnN43rF4NOHBRVTW95z+0/PdeEvzemzVmzJsEwrerom9Gkq41vMQuhDQ2xkZBFvC
         lIJ4jgkIIeOXx+8WeiReXeZnSok4O9ZwtWYs9n7Wx5lB2Ynladm1PzfutvzFqEHDBA72
         U/XzrBL88p3yCVJNNZaAoU4wrNeLPkc1oWBHhsDo6IcTLP4VO9vhvkvEnq/kcXMZBf1k
         UQT/fjadzmGzsKifjFChidy+50VWM7ziIZ/6vNB9Gfe5a8iva3IotE6fDr0fa0IitcVf
         BcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmPqQEGGBvTM8S5GAhggjaZeszV1Xly5RccQeZ3IzHI=;
        b=Efbpj/lOn9gpSfnpzGxRfJYUCbo8gvLLcWGTuJo38SCfRPWbI4jWvGLAOxUvwtzVej
         NgWkOw20nokd/6zd/6vWHZOUxoFonaG44oAh4vFQLKJS8UljJicN1bK3fErMxHPylu6c
         b9wMd+WMC0FqKy82JCfSxf8+cy2EtYOxqHZOFDtEgA+G9PWFlKCc4nsOhMIZY8JTFtpY
         DxtjLQcPbiG3Pfk3hWuTNd8D4dsiik5YwUEt89kdYSpouUTKD1kxEBI+5Ukj8JN2NW2A
         NVdpXsQD6t4EY13G2JHRrgLUvqzjxR8iciQ+sX8SO+Q7J6KxPZKEe8WW3ZxO18b3HyPo
         +T1A==
X-Gm-Message-State: AOAM530++DrXr1I+BAGUhLpevF4fIy5vQcRFplTwJsnBV5WzWm1pFLcj
        mYfT4Cxvt3Qje0kHf043S+brH4UVhfMVUw==
X-Google-Smtp-Source: ABdhPJyLp8JDXRJ1X8T+x+KeGodzaFJNe1OuZWtwFbJfqfiSzzi6QQ1zC5AYV0QKQ6VGwBM3Juw27g==
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr9102896eji.323.1617871740139;
        Thu, 08 Apr 2021 01:49:00 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4915:d200:c1e9:172b:fc28:18a5])
        by smtp.gmail.com with ESMTPSA id k19sm9782303ejk.117.2021.04.08.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 01:48:59 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca
Subject: [PATCH v2] RDMA/ipoib: print a message if only child interface is UP
Date:   Thu,  8 Apr 2021 10:48:59 +0200
Message-Id: <20210408084859.16596-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When "enhanced IPoIB" enabled for CX-5 devices, it requires
the parent device to be UP, otherwise the child devices won't
work.

This add a debug message to give admin a hint, if only child interface
is UP, but parent interface is not.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index e16b40c09f82..bae2a64f6991 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -164,8 +164,13 @@ int ipoib_open(struct net_device *dev)
 			dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
 		}
 		up_read(&priv->vlan_rwsem);
-	}
+	} else if (priv->parent) {
+		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
+		if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
+			ipoib_dbg(priv, "parent device %s is not up, so child device may be not functioning.\n",
+				  ((struct ipoib_dev_priv *) ppriv)->dev->name);
+	}
 	netif_start_queue(dev);
 
 	return 0;
-- 
2.25.1

