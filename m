Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A045C2050BB
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgFWLbI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbgFWLbF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:31:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCE12072E;
        Tue, 23 Jun 2020 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592911864;
        bh=qIsIoireSBbRW2heF90H9q3ZBm2zwtGz3y5Iz5H0o1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/VSSMkXF8+e7swcgyzJJF4Al1VAIkBsPN8X0h1fqPSdQsFj9fXwtLcqPztgVnleU
         hn9BmJvddVhxe2zOWT/i8S6KhEb+C5E7cyBqjAkSqByjccW6EaWVeqPWBgcU5Cs0Ww
         L6LE1kOlPjbsrR82X+ueOf4CHNiLIMlMY6rIV+tY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 03/11] RDMA/core: Don't call fill_res_entry for PD
Date:   Tue, 23 Jun 2020 14:30:35 +0300
Message-Id: <20200623113043.1228482-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623113043.1228482-1-leon@kernel.org>
References: <20200623113043.1228482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

None of the vendor implement it, remove it.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e16105be2eb2..8548f09746ab 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -653,7 +653,6 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			     struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_pd *pd = container_of(res, struct ib_pd, res);
-	struct ib_device *dev = pd->device;
 
 	if (has_cap_net_admin) {
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
@@ -676,13 +675,7 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			pd->uobject->context->res.id))
 		goto err;
 
-	if (fill_res_name_pid(msg, res))
-		goto err;
-
-	if (fill_res_entry(dev, msg, res))
-		goto err;
-
-	return 0;
+	return fill_res_name_pid(msg, res);
 
 err:	return -EMSGSIZE;
 }
-- 
2.26.2

