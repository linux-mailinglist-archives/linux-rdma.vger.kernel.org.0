Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F220333D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFVJXu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFVJXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 05:23:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B6C061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:23:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so3494364wru.6
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arDlHfH9mXRdOjy1S+M6wMmFsjcdcTsSs0GVyiEzDOQ=;
        b=NRDaGFVkR5lArEnt/LmY46pvJZIwteT/LaQMkoL3ht3ZUWL5k19Pyhw7nJn7AkBeSq
         /VaXnqXHv3iyaOifoxEcHkmw6j+1W/54XeT+g0M0j//NJYL92AYHPzcKhoUXQvMLdgHu
         2alv9p1DAlACgujd5gyux3kB1+oE41LiRiSFTdz3FUGNUSEjg6UWizwCFdpvID84ybqw
         cJuTIIWFf51UbUG1kc/rUPWdIaj7SpT2cPnZVCwSkh0JRO4TpdH3SWYApjKG01fP+10s
         ruNac5jORzMQLVnkAypo8RoZLj20/4nPK5HgmGg1AkUv99mdliFWVac3Ciz8jGLEwqbb
         cocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arDlHfH9mXRdOjy1S+M6wMmFsjcdcTsSs0GVyiEzDOQ=;
        b=Of2NfqjEcQtnhOM8nzSjqmAdrL1emSooYuQ8R38xkmffDB11EwK7ibhCuZ3Nr9SKXS
         gyDwThrD9400QdWNoeXC1W/JmvZlh981xJuU3MvVCzRiF71XDGIZXLhU9S10dGmk4AIM
         ZaxEJAj9aRlVdOAgQG8zmg0eDTxbHhKo8ZuzEk44aOAMOqNkO7J7jqgcBP9VyQ42XCfN
         RMcaBniwXkBmX9PLnlr3X4AOMcB8HYlQRkskc6WIuB/6QTUua2BQULGlgiqtNYJtjfQr
         L4H261xv50VB4iPOaum6oFfnncADZ4dgWYHifMvvOk4Fxmc0atQkxBwyozyhAIlNk0oE
         gv4w==
X-Gm-Message-State: AOAM532MV2cVm3Q24dIAr/MnB1FdGYhiyhCMIN8fKk4XIHZD6b5/LTGh
        WHpdEbIG1BjYz6OdMLNnd1rFomac
X-Google-Smtp-Source: ABdhPJycUM5qnRz9NruBEKIXNb/0pIUO9xnRYHOYsawSqP54b9kSe++inaPScPrR5drCcQ6brNbcow==
X-Received: by 2002:a05:6000:90:: with SMTP id m16mr18734277wrx.191.1592817828194;
        Mon, 22 Jun 2020 02:23:48 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id i15sm16943962wre.93.2020.06.22.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:23:47 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/ipoib: Return void from ipoib_mcast_stop_thread()
Date:   Mon, 22 Jun 2020 12:22:56 +0300
Message-Id: <20200622092256.6931-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from ipoib_mcast_stop_thread() is always 0 - change it
to be void.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h           | 2 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 9a3379c49541..15f519ce7e0b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -527,7 +527,7 @@ void ipoib_mcast_send(struct net_device *dev, u8 *daddr, struct sk_buff *skb);
 
 void ipoib_mcast_restart_task(struct work_struct *work);
 void ipoib_mcast_start_thread(struct net_device *dev);
-int ipoib_mcast_stop_thread(struct net_device *dev);
+void ipoib_mcast_stop_thread(struct net_device *dev);
 
 void ipoib_mcast_dev_down(struct net_device *dev);
 void ipoib_mcast_dev_flush(struct net_device *dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 9bfa514473d5..86e4ed64e4e2 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -680,15 +680,13 @@ void ipoib_mcast_start_thread(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-int ipoib_mcast_stop_thread(struct net_device *dev)
+void ipoib_mcast_stop_thread(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
 	ipoib_dbg_mcast(priv, "stopping multicast thread\n");
 
 	cancel_delayed_work_sync(&priv->mcast_task);
-
-	return 0;
 }
 
 static int ipoib_mcast_leave(struct net_device *dev, struct ipoib_mcast *mcast)
-- 
2.25.4

