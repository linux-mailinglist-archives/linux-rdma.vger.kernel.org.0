Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB35135A64
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 14:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgAINkw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 08:40:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35980 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgAINkw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 08:40:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2890075wma.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jan 2020 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ufoH4CuzkpxM6n+q4ckr88nWRTkIm5SyTnAZnRVL6mc=;
        b=s1YHS6g6x2YbH5bkd6UECymZGx6pIommMfBB/zGfDgLE5FNCl+NKufTPecfp6Y6in0
         5a8SCP7cHRKFfQ7SvRxfla+ABbE7k2XJd8XvH6BTY7hsW5K6Sr3ruYj2uFT5Q8Iih0Gh
         roAMzhY8pXbqN0qJvJBmKDODEr7k/4pUj0wh8mmsxySKgLXW2oSxXCzXL3IwGKCB76rk
         d+ABFQHnFRhItNQwl6WnRXh8UO/7o495uypDvORUJgNSX5ghIN3JUh8u9Iz2pY6o8FUD
         Fgvcsm6bWMgEF1UEmP5eLaPZcvroGbRg7ZYjIllTfKEFpyL6zBRJ3M3B1rHML2ZeAgvJ
         R8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ufoH4CuzkpxM6n+q4ckr88nWRTkIm5SyTnAZnRVL6mc=;
        b=Fu37ue5TAl+L3iPjf9WK+5MNtBzunreHkOJZosnbsFN4jM/LYOE0CoZx8Pcj5Gvqyx
         t2jKZLt4Ye0W95gTAxkpd8f1bzB/6R+LrPU+Ff6BOnlBUF+8rxHYgEgNkmMX7EyLKN/Y
         NK8WwFfXiImOwM2dyWw/gAU8Q8S7dt8haz+GbRJssskF+RRH3CRjXA0fgsuUcQSmtpXq
         QJRx6jjY2/I2o61xxTqej9BxkJ6fm0AG6irMSgei8qUkACOv4qCTCgH0Dg0y93hMFBG9
         rvDie4x4VA+C+JU3xqJZIhJTwjgmGgSbnQvWne1OeD8PBB/ezZ49KQY/2QQg0qsdLmsA
         Yk7A==
X-Gm-Message-State: APjAAAUtchC5rqHzs1P7aUl/7RW8hTqllWyQxqHADt0aAL7sAE+GATyf
        adJyHJ35TFW2KK1SPHFhzDgd7CZjO4A=
X-Google-Smtp-Source: APXvYqy/b76w2ItCd1/CQl3T89k59gxmgfVF2er445bVciBY1ApPostCN+lebjnIu3HSbSk4fxKjiA==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr4812789wml.115.1578577250501;
        Thu, 09 Jan 2020 05:40:50 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:3044:9fa7:85f1:9686])
        by smtp.gmail.com with ESMTPSA id a9sm2825738wmm.15.2020.01.09.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:40:49 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] RDMA/core: remove err in iw_query_port
Date:   Thu,  9 Jan 2020 14:40:43 +0100
Message-Id: <20200109134043.15568-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since we can return device->ops.query_port directly, so no need
to keep those lines.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/infiniband/core/device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2dd2cfe9b561..51ab6d31fbf4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1979,7 +1979,6 @@ static int iw_query_port(struct ib_device *device,
 {
 	struct in_device *inetdev;
 	struct net_device *netdev;
-	int err;
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
@@ -2010,11 +2009,7 @@ static int iw_query_port(struct ib_device *device,
 	}
 
 	dev_put(netdev);
-	err = device->ops.query_port(device, port_num, port_attr);
-	if (err)
-		return err;
-
-	return 0;
+	return device->ops.query_port(device, port_num, port_attr);
 }
 
 static int __ib_query_port(struct ib_device *device,
-- 
2.17.1

