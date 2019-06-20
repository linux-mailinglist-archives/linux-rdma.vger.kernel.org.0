Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D214CF94
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFTNu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 09:50:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57928 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTNu6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 09:50:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hdxSn-0005dA-1a; Thu, 20 Jun 2019 13:50:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA: check for null return from call to ib_get_client_data
Date:   Thu, 20 Jun 2019 14:50:52 +0100
Message-Id: <20190620135052.27367-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return from ib_get_client_data can potentially be null, so add a null
check on umad_dev and return -ENODEV in this unlikely case to avoid any
null pointer deferences.

Addresses-Coverity: ("Dereference null return")
Fixes: 8f71bb0030b8 ("RDMA: Report available cdevs through RDMA_NLDEV_CMD_GET_CHARDEV")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/core/user_mad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 547090b41cfb..d78a35913824 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1153,6 +1153,9 @@ static int ib_issm_get_nl_info(struct ib_device *ibdev, void *client_data,
 	struct ib_umad_device *umad_dev =
 		ib_get_client_data(ibdev, &umad_client);
 
+	if (!umad_dev)
+		return -ENODEV;
+
 	if (!rdma_is_port_valid(ibdev, res->port))
 		return -EINVAL;
 
-- 
2.20.1

