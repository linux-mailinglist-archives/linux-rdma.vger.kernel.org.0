Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0109148D7
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 13:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfEFLXL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 07:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFLXL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 07:23:11 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 469DB206BF;
        Mon,  6 May 2019 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557141790;
        bh=ZIYhBXAT6qivae4/wL+E4iH67MWtc6izt6wLu2e3z7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=rJbvmN46dvJkK145krU647JZk3asBeIlSdA9Iws8x3UhOB5g1IeTot2wbEZHxyxr+
         aP7+9etwNqkTcd4+PfnQDh8bgtAOoTLK3yrl1/W6vyT+XObZd6LcxtJdkRP8msyRqi
         CYmh2KdjKHt1lJ1briwIOi4a+H+6gIpmrv7tg7Do=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Subject: [PATCH rdma-next v1] RDMA/ipoib: Allow user space differentiate between valid dev_port
Date:   Mon,  6 May 2019 14:23:04 +0300
Message-Id: <20190506112304.10346-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Systemd triggers the following warning during IPoIB device load:

 mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_id.
        Should it look at dev_port instead?
        See Documentation/ABI/testing/sysfs-class-net for more info.

This is caused due to user space attempt to differentiate old systems
without dev_port and new systems with dev_port. In case dev_port will
be zero, the systemd will try to read dev_id instead.

There is no need to print a warning in such case, because it is valid
situation and it is needed to ensure systemd compatibility with old
kernels.

Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
Cc: <stable@vger.kernel.org> # 4.19
Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Changelog v0->v1:
 * Fix typo as pointed by Gal P.
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 48eda16db1a7..29a67cc38f70 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2402,7 +2402,17 @@ static ssize_t dev_id_show(struct device *dev,
 {
 	struct net_device *ndev = to_net_dev(dev);

-	if (ndev->dev_id == ndev->dev_port)
+	/*
+	 * ndev->dev_port will be equal to 0 in old kernel prior to commit
+	 * 9b8b2a323008 ("IB/ipoib: Use dev_port to expose network interface port numbers")
+	 * Zero was chosen as special case for user space applications to fallback
+	 * and query dev_id to check if it has different value or not.
+	 *
+	 * Don't print warning in such scenario.
+	 *
+	 * https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
+	 */
+	if (ndev->dev_port && ndev->dev_id == ndev->dev_port)
 		netdev_info_once(ndev,
 			"\"%s\" wants to know my dev_id. Should it look at dev_port instead? See Documentation/ABI/testing/sysfs-class-net for more info.\n",
 			current->comm);
--
2.20.1

