Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E468D24030D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgHJH61 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 03:58:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHJH60 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Aug 2020 03:58:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k52hM-0003jy-IP; Mon, 10 Aug 2020 07:58:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: fix spelling mistake "Could't" -> "Couldn't"
Date:   Mon, 10 Aug 2020 08:58:24 +0100
Message-Id: <20200810075824.46770-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 82bfee258982..d16d42b3d2ce 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2747,7 +2747,7 @@ static int __init ib_core_init(void)
 
 	ret = addr_init();
 	if (ret) {
-		pr_warn("Could't init IB address resolution\n");
+		pr_warn("Couldn't init IB address resolution\n");
 		goto err_ibnl;
 	}
 
-- 
2.27.0

