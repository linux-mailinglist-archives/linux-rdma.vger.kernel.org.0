Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5D1898C6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 11:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCRKC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 06:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgCRKC2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 06:02:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F332B20771;
        Wed, 18 Mar 2020 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525747;
        bh=z6FGxtQo8EATX0dxW2tt1xZQkqu8y+FTAOJSaSYUUwc=;
        h=From:To:Cc:Subject:Date:From;
        b=sK7yPhGORZPTyI96bMvZxRo1NQ+jaXLGyC3ZWL75mKXV/6V1uIstt69d3Gd2Sinod
         0KfRaMM/Q988j9jsuiAAqW8ahSsREOue493JKXwOJ+hFrQkn2rRckVz+UcKXLdidnz
         dlluM1GSCtm8OAqWY7BYNVUyhKtmCFHu8gxfY+08=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Block delay drop to unprivileged users
Date:   Wed, 18 Mar 2020 12:02:23 +0200
Message-Id: <20200318100223.46436-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Since this feature can globally block the RX port, it should
be allowed to privileged users only.

Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
We didn't put this check in IB/core because it is unclear if it can be
applicable to all vendors, but for the mlx5 it is clear, due to how wq
is created.
---
 drivers/infiniband/hw/mlx5/qp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d3055f3eb0b6..88db580f7272 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -6247,6 +6247,10 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	if (udata->outlen && udata->outlen < min_resp_len)
 		return ERR_PTR(-EINVAL);

+	if (!capable(CAP_NET_RAW) &&
+	    init_attr->create_flags & IB_WQ_FLAGS_DELAY_DROP)
+		return ERR_PTR(-EPERM);
+
 	dev = to_mdev(pd->device);
 	switch (init_attr->wq_type) {
 	case IB_WQT_RQ:
--
2.24.1

