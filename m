Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55279BBA45
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439989AbfIWRSL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 13:18:11 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:18042 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407425AbfIWRSL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 13:18:11 -0400
Received: from ubuntu-CJ.clients.t49.sncf ([109.190.253.13])
        by mwinf5d53 with ME
        id 55J4210050J6jfR035J4wj; Mon, 23 Sep 2019 19:18:07 +0200
X-ME-Helo: ubuntu-CJ.clients.t49.sncf
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Sep 2019 19:18:07 +0200
X-ME-IP: 109.190.253.13
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        parav@mellanox.com, majd@mellanox.com, markz@mellanox.com,
        swise@opengridcomputing.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/core: Fix an error handling path in 'res_get_common_doit()'
Date:   Sun, 18 Aug 2019 11:10:44 +0200
Message-Id: <20190818091044.8845-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

According to surrounding error paths, it is likely that 'goto err_get;' is
expected here. Otherwise, a call to 'rdma_restrack_put(res);' would be
missing.

Fixes: c5dfe0ea6ffa ("RDMA/nldev: Add resource tracker doit callback")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e287b71a1cfd..03272791a5bf 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1231,7 +1231,7 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
-		goto err;
+		goto err_get;
 	}
 
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-- 
2.20.1

