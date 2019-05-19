Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37D228AF
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2019 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfESUQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 May 2019 16:16:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfESUQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 May 2019 16:16:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so12214675wro.10
        for <linux-rdma@vger.kernel.org>; Sun, 19 May 2019 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXz1LvZ+fjrTm92y2jiV2D7sw2tzcQM3oDsbTLFycac=;
        b=qYmW/ZwChaXsJ7BVN1V/UYlK1vXsrB55UW/E5neEiNMIrSGpK6Y0xqowNa6APN36ga
         MOByabvjzIJOLBG+llGRV21zIaFtBgcL5DTjr62iOHl5uZ/ZfRkmxzoDgW/xpU/p/J19
         ExMMEWpHNcD6HY0s22B3Jos8hYFf23OwWM6VmYUha/z/HhlYfeJxwBEtGHcDI/dfOQYW
         oLjS7Zdxb+SkSMg1Mlm2WlUqmxZyA1zAty/p/zZlSLCfM0M9BZfGX722RnhrfgcTNudo
         HMPQwZ1zYYWy+hZLjuRwpu9i3LhMtNJ4J65ReLthB5PkUbrNyebKN3RARMZROj8CWse+
         pwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXz1LvZ+fjrTm92y2jiV2D7sw2tzcQM3oDsbTLFycac=;
        b=hPYUDBBMFiKfk9nY6Kvi+ByOjaABYqmmAeiDsCJnGwqf9CkzXuBp0NXzjU4midHyqo
         Irawu0oAuJr8e8mpdqClgSkD+h80y3SC+PbReMpXD4qz+iAhOOFZ0EJe/am3aDz6oac6
         RXazZvMev34UXPxNDrIwABgVl58iKspf1JVV3dCiDYda8pKyb9fYLX8fAVe14ILzOdn0
         DK8BAqVvcvAxxgwl1771yFgpKJcdIKGVNtitTF/L2Cf6Z4V785kHiNuvlEwSVRITCE6t
         u/4FaRqZcQv3ssDOZZW5Ptv/jZIiW4n6Tg311M8pYTJMJSt1aZE8cIsWUSZ83w8atLBJ
         K/0g==
X-Gm-Message-State: APjAAAXcWkoE6eb0uN/T5LlJkmsCh3s2QpFL3ksqesFvBhVupFflhaWP
        vID5jWJFzQWvUCkvFRBkhZ/fShC5
X-Google-Smtp-Source: APXvYqzTzFNIZ/8ZQJ0gVQodyPUOaQUJSYfvaF+bvqkN19mU+foBPuhcpMNJWC+vL6znM5p8bDvv6w==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr13706683wrw.105.1558296996181;
        Sun, 19 May 2019 13:16:36 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id b5sm13131250wrp.92.2019.05.19.13.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 13:16:35 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/core: Rename ib_device_check_mandatory
Date:   Sun, 19 May 2019 23:16:27 +0300
Message-Id: <20190519201627.17188-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from ib_device_check_mandatory() is always 0 - change
it to be void and rename the function to emphasize the use of it, which
is setting the kverbs_provider flag.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 78dc07c6ac4b..7702d03c1967 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -270,7 +270,7 @@ struct ib_port_data_rcu {
 	struct ib_port_data pdata[];
 };
 
-static int ib_device_check_mandatory(struct ib_device *device)
+static void ib_set_kverbs_provider(struct ib_device *device)
 {
 #define IB_MANDATORY_FUNC(x) { offsetof(struct ib_device_ops, x), #x }
 	static const struct {
@@ -305,8 +305,6 @@ static int ib_device_check_mandatory(struct ib_device *device)
 			break;
 		}
 	}
-
-	return 0;
 }
 
 /*
@@ -1175,10 +1173,7 @@ static int setup_device(struct ib_device *device)
 	int ret;
 
 	setup_dma_device(device);
-
-	ret = ib_device_check_mandatory(device);
-	if (ret)
-		return ret;
+	ib_set_kverbs_provider(device);
 
 	ret = setup_port_data(device);
 	if (ret) {
-- 
2.20.1

