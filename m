Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEBF22C5C
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfETGy7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETGy7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:54:59 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0642085A;
        Mon, 20 May 2019 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335298;
        bh=4xbaq1II5v/WpN296DgMKxAoU522v52vGKOLUMRVWHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1lcpu71gOuzjsqkGFrlHUyRInZEK1pURCJS733s9GnJziEAp6TuWa8JcpMZp4iTN
         FrH7saKyKD+br+AAQubdr7kaprSybSNNQVscxD6+6ZkZzAufu2TgXbeJ+NZHkzzlVm
         1a7pGk0RZGsWUFPvrFtfHmWiXHZ/WgNyO5L/4qqg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 07/15] RDMA/nes: Remove second wait queue initialization call
Date:   Mon, 20 May 2019 09:54:25 +0300
Message-Id: <20190520065433.8734-8-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The same wait queue is initialized a couple of lines above.

Fixes: 3c2d774cad5b ("RDMA/nes: Add a driver for NetEffect RNICs")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/nes/nes_utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes_utils.c b/drivers/infiniband/hw/nes/nes_utils.c
index 21b4a8373acf..90f28890246d 100644
--- a/drivers/infiniband/hw/nes/nes_utils.c
+++ b/drivers/infiniband/hw/nes/nes_utils.c
@@ -586,7 +586,6 @@ struct nes_cqp_request *nes_get_cqp_request(struct nes_device *nesdev)
 		cqp_request->waiting = 0;
 		cqp_request->request_done = 0;
 		cqp_request->callback = 0;
-		init_waitqueue_head(&cqp_request->waitq);
 		nes_debug(NES_DBG_CQP, "Got cqp request %p from the available list \n",
 				cqp_request);
 	} else
-- 
2.20.1

