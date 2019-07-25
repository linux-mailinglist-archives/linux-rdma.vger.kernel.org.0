Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3D74DED
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404523AbfGYMPS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 08:15:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39323 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404522AbfGYMPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 08:15:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so23393287pls.6;
        Thu, 25 Jul 2019 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y+QIB4QdjKz71M1YxwynMWzO+rB27zsg8WKRIIdr3/c=;
        b=NZ/6dTsBSydrACeiZGDz+T8flvtmaB7vfcVKnrl+A0m+HtjK/crLv0IxqiOQxBAQbL
         WxF0sqbEatVfQFPK1FpBMgZ5WJnmz3CFAmxhteDbJ7IyIlJ6SU29kvwgUjdYdXY5FU+1
         rqwhRgt9vSgLmCcJj9FSQtq8vQAILW5NWQas8VFEaWpJbNR3j1mbdI24sEu5hK7RA8YD
         NN9hwU4Db0Vh4jyCE+TadqkpT9irNv9g3ultChqUEvEcuUnpTxALcwDQgttO9as3aeSa
         YblICSsGdP9PDIXugRrTqX78FxA5locafHJeJse7BJGufMnTdBNynVp41vFZiEd5uEA/
         2q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y+QIB4QdjKz71M1YxwynMWzO+rB27zsg8WKRIIdr3/c=;
        b=sI5gQDUdnurt74chtntJekfiTA0tA+F/1FI/GioF4g5kF+RKW4PtMOInWHdlZEPEX6
         JdYX7Ww5J98oWaYBN5IVxnCQ/jXjculsodHvy05SX64rrxZqqhPTSLvHvNfCurcFvLD1
         qI7adv2MHpss+gPut29cFFpegkFswzfzADNXe1zglC6aZzZDm/du2CjymLEF7ntET9wP
         GBsGOqjRCwIBc9tjLt6HSKRoiB9LcrhMA36Z5DVr4IV8d1Yub4ZUl01ySem5HPEGOyvW
         /+q6EZmh9Gf9V4LZd4e8GQZhZw4ApMM+t8UpOgyxIgGcQAqe4cBSrZnw1X9IdFHP1y8m
         /M4A==
X-Gm-Message-State: APjAAAUYjU3tOknyPBfTiDVglnjM2fo1xHBf7c7vhkE2zlD4bzINxRaY
        vX1yGb5lnr7GXBdlEHw1wwYac5RlrZ8=
X-Google-Smtp-Source: APXvYqyA9O1rHqPuadm47R5uEU2xLyoP0cGNOItpDz8NR0nwRgJ3eN1fmwaJQGIb90cwOIH1+y2y3Q==
X-Received: by 2002:a17:902:3181:: with SMTP id x1mr88905993plb.135.1564056917207;
        Thu, 25 Jul 2019 05:15:17 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id l1sm64449251pfl.9.2019.07.25.05.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 05:15:16 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] infiniband: hw: cxgb3: Fix a possible null-pointer dereference in connect_reply_upcall()
Date:   Thu, 25 Jul 2019 20:15:08 +0800
Message-Id: <20190725121508.16352-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In connect_reply_upcall(), there is an if statement on line 730 to check
whether ep->com.cm_id is NULL:
    if (ep->com.cm_id)

When ep->com.cm_id is NULL, it is used on line 736:
    ep->com.cm_id->rem_ref(ep->com.cm_id);

Thus, a possible null-pointer dereference may occur.

To fix this bug, ep->com.cm_id is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/hw/cxgb3/iwch_cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c b/drivers/infiniband/hw/cxgb3/iwch_cm.c
index 0bca72cb4d9a..2b31c4726d3e 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_cm.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.c
@@ -733,7 +733,8 @@ static void connect_reply_upcall(struct iwch_ep *ep, int status)
 		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
 	}
 	if (status < 0) {
-		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		if (ep->com.cm_id)
+			ep->com.cm_id->rem_ref(ep->com.cm_id);
 		ep->com.cm_id = NULL;
 		ep->com.qp = NULL;
 	}
-- 
2.17.0

