Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C291982
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2019 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRUXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Aug 2019 16:23:08 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43217 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHRUXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Aug 2019 16:23:08 -0400
Received: by mail-yw1-f65.google.com with SMTP id n205so3482045ywb.10;
        Sun, 18 Aug 2019 13:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LrZRhO4JZAFpI76kp7BrG7QHL9s/hxdZFmSLuwrOJ0I=;
        b=ksaMq+KVjJrtoevtD6RWt2Eaq2CCEpDbh0aVfhSVV95MAU5AnsBHuzwSIJYKEmclXM
         J6KKkLndFFQDBj9qD5sZDsk1NXPhrmw77UmipHl0OAuW7EtI0QKHvfWj882Pmcp5k76z
         zKoWHkgvipz6TCAN6fYhAvNVPql6IAIxsjaU2DDRoozKe1O16cWDqsWlGKTF6rFwXuUs
         HNo8jX+4oIja27Ug0jkbhaqnCvJK2/X4LeWJx97NKbYbByttsnZtIDNRrs8Mp6jhIGBB
         Af8/Q2R5e71kCofMdueJnxgzwByt9d5qOXjoHqGY9SeNRpr8hdfKrZFLAWF3zEIozwXC
         Vadg==
X-Gm-Message-State: APjAAAWR0CB+/q+HKWZMeEwV8r8sovlhbbga3pTCAGrmOzwzgLOe88DX
        WbP5afoG7UpzhurekjWPq48=
X-Google-Smtp-Source: APXvYqx1ZIIVUAO8bKNV58YCymA3q6fXpe4qX0p2JqSO76Vu/hellmRCPDSZxUJFzOcyxaHmjrq1wQ==
X-Received: by 2002:a81:a302:: with SMTP id a2mr13754106ywh.135.1566159787621;
        Sun, 18 Aug 2019 13:23:07 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id 143sm2888694ywi.81.2019.08.18.13.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 13:23:06 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 IB driver),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] IB/mlx4: Fix memory leaks
Date:   Sun, 18 Aug 2019 15:23:01 -0500
Message-Id: <1566159781-4642-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In mlx4_ib_alloc_pv_bufs(), 'tun_qp->tx_ring' is allocated through
kcalloc(). However, it is not always deallocated in the following execution
if an error occurs, leading to memory leaks. To fix this issue, free
'tun_qp->tx_ring' whenever an error occurs.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/infiniband/hw/mlx4/mad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 68c9514..5707911 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1677,8 +1677,6 @@ static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 				    tx_buf_size, DMA_TO_DEVICE);
 		kfree(tun_qp->tx_ring[i].buf.addr);
 	}
-	kfree(tun_qp->tx_ring);
-	tun_qp->tx_ring = NULL;
 	i = MLX4_NUM_TUNNEL_BUFS;
 err:
 	while (i > 0) {
@@ -1687,6 +1685,8 @@ static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 				    rx_buf_size, DMA_FROM_DEVICE);
 		kfree(tun_qp->ring[i].addr);
 	}
+	kfree(tun_qp->tx_ring);
+	tun_qp->tx_ring = NULL;
 	kfree(tun_qp->ring);
 	tun_qp->ring = NULL;
 	return -ENOMEM;
-- 
2.7.4

