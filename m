Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9734222C58
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfETGyq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETGyp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:54:45 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C716320815;
        Mon, 20 May 2019 06:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335285;
        bh=8e+Gsi1LDF5ewCTLzAyjyOYeXmZAVeUv4HMB6cc/o8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1k6FKNTiMo7hLir4iaL7obrDoD1w0XUBNBAjVXWE2NVhKhQlAMAZuRXuwomb3rz1
         MuRYK5skdSj7cV3XzTU8EajhFTOf3eKN5o4eFYaJ24A4ble3h1uYGVe6+t69eXv/kP
         c/c0xT5/FHV3V6AAfYAy/JXHVPNF3Hgpp2AKe+Lo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 02/15] RDMA/ipoib: Remove check of destroy CQ
Date:   Mon, 20 May 2019 09:54:20 +0300
Message-Id: <20190520065433.8734-3-leon@kernel.org>
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

There are nothing to do from user side with knowledge that destroy CQ fails.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index ba09068f6200..b69304d28f06 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -260,11 +260,8 @@ void ipoib_transport_dev_cleanup(struct net_device *dev)
 		priv->qp = NULL;
 	}
 
-	if (ib_destroy_cq(priv->send_cq))
-		ipoib_warn(priv, "ib_cq_destroy (send) failed\n");
-
-	if (ib_destroy_cq(priv->recv_cq))
-		ipoib_warn(priv, "ib_cq_destroy (recv) failed\n");
+	ib_destroy_cq(priv->send_cq);
+	ib_destroy_cq(priv->recv_cq);
 }
 
 void ipoib_event(struct ib_event_handler *handler,
-- 
2.20.1

