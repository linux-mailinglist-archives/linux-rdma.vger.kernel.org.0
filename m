Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C715E2B3D21
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 07:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKPG3O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 01:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgKPG3N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 01:29:13 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B762222E;
        Mon, 16 Nov 2020 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605508153;
        bh=BsAI0SxOw+Jk8owOk0bqFt0NRO1EekGEvwXoOYOhwcA=;
        h=From:To:Cc:Subject:Date:From;
        b=oWaMo7Oe005Tsxb0hclkTtVl/nMMMthRai2Le86TgcpJvfdENOQfkww+suCHtncrG
         RO4/ZLlpN9DFF1BwYslDYYa6axc+dN86S7RA5qgagJ+sDhey+eZqT8uxMr12nSi6Hr
         Bo0/EHGOl2f7sfvlA3Wz2X4G+SFbtl6Y5j4KlBmI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH wip/jgg-for-next] fixup! RDMA/counter: Combine allocation and bind logic
Date:   Mon, 16 Nov 2020 08:29:01 +0200
Message-Id: <20201116062901.539483-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Jason, please squash this fixup to kbuild report I got tonight, Thanks.

--------
Failure in __rdma_counter_bind_qp() will cause
to mutex_unlock(&port_counter->lock); call again.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 4e1ec4479e0b..2c67ba6a2725 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -124,14 +124,17 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u8 port,
 	case RDMA_COUNTER_MODE_MANUAL:
 		ret = __counter_set_mode(&port_counter->mode,
 					 RDMA_COUNTER_MODE_MANUAL, 0);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&port_counter->lock);
 			goto err_mode;
+		}
 		break;
 	case RDMA_COUNTER_MODE_AUTO:
 		auto_mode_init_counter(counter, qp, port_counter->mode.mask);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
+		mutex_unlock(&port_counter->lock);
 		goto err_mode;
 	}

@@ -151,7 +154,6 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u8 port,
 	return counter;

 err_mode:
-	mutex_unlock(&port_counter->lock);
 	kfree(counter->stats);
 err_stats:
 	rdma_restrack_put(&counter->res);
--
2.28.0

