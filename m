Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357E01AFF9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2019 07:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEMF1H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 May 2019 01:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfEMF1G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 May 2019 01:27:06 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD9D208C3;
        Mon, 13 May 2019 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557725226;
        bh=DzL4IAQb/Mbe1KOTBWR5HyhhECSaFTdp9Dfa+/sXM3I=;
        h=From:To:Cc:Subject:Date:From;
        b=HpXat5G22FXLkmLWgxPfZE3Xn+dTbebQPz3JThiwfzoYIvMqfK7LQl8bt/hTckQxE
         tl0G4dno+UaukKcVnFdkz5eaXFlMfJ83dbxxfWSxaMLhWgeNUSYV2KyzAOITKQUrTg
         PGO1c4W/RHCY0vAZsIkabewkJ/9HpQQSdw7k/Xm0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/core: Change system parameters callback from dumpit to doit
Date:   Mon, 13 May 2019 08:26:57 +0300
Message-Id: <20190513052657.31436-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

.dumpit() callback is used for returning same type of data in the loop,
e.g. loop over ports, resources, devices.

However system parameters are general and standalone for whole
subsystem. It means that getting system parameters should be doit
callback.

Fixes: cb7e0e130503 ("RDMA/core: Add interface to read device namespace sharing mode")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Jason, Doug

It will send extra complexity with kernel-headers updates
if this patch goes as part of second PR to Linus in this merge
window.

Thanks
---
 drivers/infiniband/core/nldev.c  | 27 +++++++++++++++------------
 include/uapi/rdma/rdma_netlink.h |  2 +-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 46c0ec97aa53..7ce3a6b7a936 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1508,32 +1508,35 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 }

-static int nldev_get_sys_get_dumpit(struct sk_buff *skb,
-				    struct netlink_callback *cb)
+static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
-	struct nlmsghdr *nlh;
+	struct sk_buff *msg;
 	int err;

-	err = nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-			  nldev_policy, NULL);
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			  nldev_policy, extack);
 	if (err)
 		return err;

-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_SYS_GET),
 			0, 0);

-	err = nla_put_u8(skb, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
+	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
 			 (u8)ib_devices_shared_netns);
 	if (err) {
-		nlmsg_cancel(skb, nlh);
+		nlmsg_free(msg);
 		return err;
 	}
-
-	nlmsg_end(skb, nlh);
-	return skb->len;
+	nlmsg_end(msg, nlh);
+	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
 }

 static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1929,7 +1932,7 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.dump = nldev_res_get_pd_dumpit,
 	},
 	[RDMA_NLDEV_CMD_SYS_GET] = {
-		.dump = nldev_get_sys_get_dumpit,
+		.doit = nldev_sys_get_doit,
 	},
 	[RDMA_NLDEV_CMD_SYS_SET] = {
 		.doit = nldev_set_sys_set_doit,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index aaeeb0a8aec6..03694f4b5e18 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -250,7 +250,7 @@ enum rdma_nldev_command {

 	RDMA_NLDEV_CMD_PORT_GET, /* can dump */

-	RDMA_NLDEV_CMD_SYS_GET, /* can dump */
+	RDMA_NLDEV_CMD_SYS_GET,
 	RDMA_NLDEV_CMD_SYS_SET,

 	/* 8 is free to use */
--
2.20.1

