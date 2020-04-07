Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A341A03DE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 02:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDGAoa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 20:44:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40643 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGAo3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Apr 2020 20:44:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id y25so1457550qtv.7
        for <linux-rdma@vger.kernel.org>; Mon, 06 Apr 2020 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iN25cbGrs8FKyzdV2IOg1bW6PkdCVYW8usI58LMklEo=;
        b=e8ee+M7yQJAon/6LbrM6XgiV4y7sm/5fd3OS8+bazBpuJ2+mgTTdB4FJ+IQbOU1O4M
         br1QOdD8buoAgFOWralY9QDN0ABYJy1Lbx1QsHVDrNxD3rRQgKTDFzLJSSdqt5PwOpkD
         QowWN6Pnd8qCXCRzrTfjojqFO4YK5WnAj1ADdwV7Eeu0LL042CU1M0GpsoXgwnQj5H50
         /CLyRZsxhC8AfNEsRzB9xOKevvDkVz+FAQtdUNOIn5fKa0mpSTKp2H58D80/kcwcwVkG
         v1h0ZXd30AvvNnAQPdDGvIhGwmdRU5z8Gs4VI1DwnJSUExov3PttznR2vDzrxP8Df1e3
         XCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iN25cbGrs8FKyzdV2IOg1bW6PkdCVYW8usI58LMklEo=;
        b=bI8LgyCevkrH93GN/g7uY0zZNiYjIdYGAlmTavA+Bk/tDyzZtHG/ytTiQlPbM39qjg
         XfHOm2k56iJzKNFXgx3vQhpNauXsmHRiIXZope5JFDy3xedJ0YbG1RAQU0xSlJsEJH0m
         5U2WCFDRsOn25+qUQeg9ipMWckDPfDBwpB+nb6rnxQ6BEMyhQC4pUk3/S4nShE02Ninj
         b5MaVarAmtIkyqAOsFzZ2BV79Se3FXTKfFHUnF4OdklHoinkKmOtJ5mE3hk+G+JC9HgG
         nlAwAwQk8aMZ5jLLRwTfLzlBNg5NvreRzZ/760kH30laLFILqFKheQ1N+/CseKGkxxFG
         4Bow==
X-Gm-Message-State: AGi0PuYd2Ims1IQiBLYcnpSd8PwATQDwg4+38Rc/PSDYuFsZKxHQRev3
        T836MAZs975npDO8u5+0RjR5TbyDBDTfLw==
X-Google-Smtp-Source: APiQypKGkwkfC5I7rwZpgBVeutphi5IT3vBscHsSz2O5iZbpQUI0QKnSnJ56dkG/U+XXN//GdX57CA==
X-Received: by 2002:ac8:370c:: with SMTP id o12mr2250160qtb.380.1586220268684;
        Mon, 06 Apr 2020 17:44:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 207sm16129429qkf.69.2020.04.06.17.44.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 17:44:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLcLq-00068q-5j
        for linux-rdma@vger.kernel.org; Mon, 06 Apr 2020 21:44:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: Make the event_queue fds return POLLERR when disassociated
Date:   Mon,  6 Apr 2020 21:44:26 -0300
Message-Id: <0-v1-ace813388969+48859-uverbs_poll_fix%jgg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

If is_closed is set, and the event list is empty, then read() will return
-EIO without blocking. After setting is_closed in
ib_uverbs_free_event_queue(), we do trigger a wake_up on the poll_wait,
but the fops->poll() function does not check it, so poll will continue to
sleep on an empty list.

Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 2d4083bf4a0487..8710a3427146e7 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -296,6 +296,8 @@ static __poll_t ib_uverbs_event_poll(struct ib_uverbs_event_queue *ev_queue,
 	spin_lock_irq(&ev_queue->lock);
 	if (!list_empty(&ev_queue->event_list))
 		pollflags = EPOLLIN | EPOLLRDNORM;
+	else if (ev_queue->is_closed)
+		pollflags = EPOLLERR;
 	spin_unlock_irq(&ev_queue->lock);
 
 	return pollflags;
-- 
2.25.2

