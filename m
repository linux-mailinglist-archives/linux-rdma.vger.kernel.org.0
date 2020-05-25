Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46F1E0F04
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbgEYNDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYNDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 09:03:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0FC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 06:03:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so6463609wml.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kH2Gkp6ZJvXrHMq5/k7JsaE6MaYzJtzN+ulVMiwKATU=;
        b=m6sz6ZUdQkQffy99N0mSz5u9ot6l46vNjsdnzGsWSnGAy3QK5C3TIkT4+1UAmoD+lW
         LpD+77SGg5nsBCqgfzHPlqd9vAxNOjVQYDkmVuaJNpu8/FFPJuE2Yg0GgLM/EMISAeYM
         CX6sSKbJW9KZm5RXyOuaPSf4y9CjLC0w5ZKgO7bT4a9KqSIYVlnugbuXI0GP4j+BPulI
         MgO9KG9MZoVqJNaL3kVo5JdpJv2Ux+5T9FgwCIogxRk4eDI/zHbp92HbZ1NBKe48f9be
         Fn/wejdRl1jdstoba6aKH2U57kopwYXGXBR2Vbqjp7phvw5OxcanqMnNBIygtQCxYywS
         UPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kH2Gkp6ZJvXrHMq5/k7JsaE6MaYzJtzN+ulVMiwKATU=;
        b=g+Jk9cPZCxzx9w03upTCl9cajlZyIzPAVRr8h8gbttm+YpoRBXDHiDdBQauBorhRGm
         GOM+e2WcHNPHO+D7a8wuVJlSlgVw/KE2SS1CSr6pmJ4IY8RPuun5qs0NIT8bNjwHPOQl
         o/SItUfkn6KwlshtRH3xP3jOVE1DAGCxGFNKve2BafTrx/QxqEHsmcZjysmIKJ3OizQy
         5VxQ+JbpqMhGkHngCsT7C1Gl5XRsmCYm6BQmdc9/7Px7qlWZCle/u/+DEdx+/rP8x043
         JypExQXhkKKzxwqhWMfJHV2mVvyTlXnhymeYz1YKferAvgK9DJA7gtpgTQ9qioz+oTRT
         Cx7w==
X-Gm-Message-State: AOAM532wz7QqFSWHzHV0v6AKhpUNtda6CSd608M6ucBwkdpOy2gj+c7s
        r2w7cDttMNNbERaUvjrHYfaJTb5Q
X-Google-Smtp-Source: ABdhPJx3yHsR0J6iWvXJgREBvaaKOQxv5FpfUZ+7T/rBZbz215f7q4rckXogaRQt+Isajc2cMDwrug==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr27058083wmj.54.1590411800416;
        Mon, 25 May 2020 06:03:20 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id o15sm1687180wrv.48.2020.05.25.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:03:19 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/ipoib: Remove can_sleep parameter from iboib_mcast_alloc
Date:   Mon, 25 May 2020 16:03:05 +0300
Message-Id: <20200525130305.171509-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

can_sleep is always 0 when iboib_mcast_alloc() is called, so remove it and
use GFP_ATOMIC instead of GFP_KERNEL.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index b9e9562f5034..ff87ded0a48c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -135,12 +135,11 @@ static void ipoib_mcast_free(struct ipoib_mcast *mcast)
 	kfree(mcast);
 }
 
-static struct ipoib_mcast *ipoib_mcast_alloc(struct net_device *dev,
-					     int can_sleep)
+static struct ipoib_mcast *ipoib_mcast_alloc(struct net_device *dev)
 {
 	struct ipoib_mcast *mcast;
 
-	mcast = kzalloc(sizeof(*mcast), can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+	mcast = kzalloc(sizeof(*mcast), GFP_ATOMIC);
 	if (!mcast)
 		return NULL;
 
@@ -599,7 +598,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
 	if (!priv->broadcast) {
 		struct ipoib_mcast *broadcast;
 
-		broadcast = ipoib_mcast_alloc(dev, 0);
+		broadcast = ipoib_mcast_alloc(dev);
 		if (!broadcast) {
 			ipoib_warn(priv, "failed to allocate broadcast group\n");
 			/*
@@ -782,7 +781,7 @@ void ipoib_mcast_send(struct net_device *dev, u8 *daddr, struct sk_buff *skb)
 			ipoib_dbg_mcast(priv, "setting up send only multicast group for %pI6\n",
 					mgid);
 
-			mcast = ipoib_mcast_alloc(dev, 0);
+			mcast = ipoib_mcast_alloc(dev);
 			if (!mcast) {
 				ipoib_warn(priv, "unable to allocate memory "
 					   "for multicast structure\n");
@@ -936,7 +935,7 @@ void ipoib_mcast_restart_task(struct work_struct *work)
 			ipoib_dbg_mcast(priv, "adding multicast entry for mgid %pI6\n",
 					mgid.raw);
 
-			nmcast = ipoib_mcast_alloc(dev, 0);
+			nmcast = ipoib_mcast_alloc(dev);
 			if (!nmcast) {
 				ipoib_warn(priv, "unable to allocate memory for multicast structure\n");
 				continue;
-- 
2.25.4

