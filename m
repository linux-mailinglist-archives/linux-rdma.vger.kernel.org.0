Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E28207B5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfEPNMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 09:12:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44839 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPNMS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 09:12:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hRGBE-000648-70; Thu, 16 May 2019 13:12:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/nldev: add check for null return from call to nlmsg_put
Date:   Thu, 16 May 2019 14:12:15 +0100
Message-Id: <20190516131215.20411-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It is possible that nlmsg_put can return a null pointer, currently
this will lead to a null pointer dereference when passing a null
nlh pointer to nlmsg_end.  Fix this by adding a null pointer check.

Addresses-Coverity: ("Dereference null return value")
Fixes: cb7e0e130503 ("RDMA/core: Add interface to read device namespace sharing mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/core/nldev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 69188cbbd99b..4dc43b6c5a28 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1367,6 +1367,10 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_SYS_GET),
 			0, 0);
+	if (!nlh) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
 
 	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
 			 (u8)ib_devices_shared_netns);
-- 
2.20.1

