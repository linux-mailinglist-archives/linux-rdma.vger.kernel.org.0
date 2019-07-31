Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC27BB0D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfGaIBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 04:01:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34579 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaIBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 04:01:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hsjYO-0006zA-Jg; Wed, 31 Jul 2019 08:01:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/core: fix spelling mistake "Nelink" -> "Netlink"
Date:   Wed, 31 Jul 2019 09:01:44 +0100
Message-Id: <20190731080144.18327-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a warning message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/core/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
index 67a76aca2dd6..81dbd5f41bed 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -303,7 +303,7 @@ void rdma_nl_exit(void)
 
 	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
 		WARN(rdma_nl_types[idx].cb_table,
-		     "Nelink client %d wasn't released prior to unloading %s\n",
+		     "Netlink client %d wasn't released prior to unloading %s\n",
 		     idx, KBUILD_MODNAME);
 }
 
-- 
2.20.1

