Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3836563A769
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 12:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiK1Lw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 06:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiK1Lw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 06:52:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D6EB6
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 03:52:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA72AB80D5F
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 11:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF65C433C1;
        Mon, 28 Nov 2022 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636374;
        bh=WuFdDXOYTWaeHmR5seyU4VGpIsem4Xlv5CivDqITbmM=;
        h=From:To:Cc:Subject:Date:From;
        b=VuTRSsCn9CVdydmYeeZ+VOMgpNGXU+SJf4W5WO3bpscje3KcmJSJ2unypW2LD2Wj1
         TSRri9GG05HmpA7qFwl3LMoryPFv1DYT11jy6eaeHCmpCN1IlhcDtx2eTGGjP/SPoY
         djxpcg+ofVvmWGF1gXEK5Li8UrndNPUDHSk2zP0q+0p3Qb95PEx7h9533l/SCWc2DK
         WwKSb+mMJpmGl2WzQTuos/6Ph2+xYq+bfkJg0TpfYZFpWrQCY/U+e0UeAi9e4VRD+s
         TqeVf0DbHtGUUOA6g9L5X7d60a50EEvUb/mVbXbV+dr74Z90LdHyPQnZU4RpPxfKLy
         8u+Q/d2mEJ7hQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA/nldev: Add NULL check to silence false warnings
Date:   Mon, 28 Nov 2022 13:52:45 +0200
Message-Id: <bd924da89d5b4f5291a4a01d9b5ae47c0a9b6a3f.1669636336.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Or Har-Toov <ohartoov@nvidia.com>

Using nlmsg_put causes static analysis tools to many
false positives of not checking the return value of nlmsg_put.

In all uses in nldev.c, payload parameter is 0 so NULL will never
be returned. So let's add useless checks to silence the warnings.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 44 +++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2be76a3fdd87..1c5f4452e8db 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1041,6 +1041,10 @@ static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, 0);
+	if (!nlh) {
+		err = -EMSGSIZE;
+		goto err_free;
+	}
 
 	err = fill_dev_info(msg, device);
 	if (err)
@@ -1126,7 +1130,7 @@ static int _nldev_get_dumpit(struct ib_device *device,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, NLM_F_MULTI);
 
-	if (fill_dev_info(skb, device)) {
+	if (!nlh || fill_dev_info(skb, device)) {
 		nlmsg_cancel(skb, nlh);
 		goto out;
 	}
@@ -1185,6 +1189,10 @@ static int nldev_port_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, 0);
+	if (!nlh) {
+		err = -EMSGSIZE;
+		goto err_free;
+	}
 
 	err = fill_port_info(msg, device, port, sock_net(skb->sk));
 	if (err)
@@ -1246,7 +1254,7 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 						 RDMA_NLDEV_CMD_PORT_GET),
 				0, NLM_F_MULTI);
 
-		if (fill_port_info(skb, device, p, sock_net(skb->sk))) {
+		if (!nlh || fill_port_info(skb, device, p, sock_net(skb->sk))) {
 			nlmsg_cancel(skb, nlh);
 			goto out;
 		}
@@ -1288,6 +1296,10 @@ static int nldev_res_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_RES_GET),
 			0, 0);
+	if (!nlh) {
+		ret = -EMSGSIZE;
+		goto err_free;
+	}
 
 	ret = fill_res_info(msg, device);
 	if (ret)
@@ -1319,7 +1331,7 @@ static int _nldev_res_get_dumpit(struct ib_device *device,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_RES_GET),
 			0, NLM_F_MULTI);
 
-	if (fill_res_info(skb, device)) {
+	if (!nlh || fill_res_info(skb, device)) {
 		nlmsg_cancel(skb, nlh);
 		goto out;
 	}
@@ -1454,7 +1466,7 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 					 RDMA_NL_GET_OP(nlh->nlmsg_type)),
 			0, 0);
 
-	if (fill_nldev_handle(msg, device)) {
+	if (!nlh || fill_nldev_handle(msg, device)) {
 		ret = -EMSGSIZE;
 		goto err_free;
 	}
@@ -1533,7 +1545,7 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 					 RDMA_NL_GET_OP(cb->nlh->nlmsg_type)),
 			0, NLM_F_MULTI);
 
-	if (fill_nldev_handle(skb, device)) {
+	if (!nlh || fill_nldev_handle(skb, device)) {
 		ret = -EMSGSIZE;
 		goto err;
 	}
@@ -1795,6 +1807,10 @@ static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_GET_CHARDEV),
 			0, 0);
+	if (!nlh) {
+		err = -EMSGSIZE;
+		goto out_nlmsg;
+	}
 
 	data.nl_msg = msg;
 	err = ib_get_client_nl_info(ibdev, client_name, &data);
@@ -1852,6 +1868,10 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_SYS_GET),
 			0, 0);
+	if (!nlh) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
 
 	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
 			 (u8)ib_devices_shared_netns);
@@ -2032,7 +2052,7 @@ static int nldev_stat_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_STAT_SET),
 			0, 0);
-	if (fill_nldev_handle(msg, device) ||
+	if (!nlh || fill_nldev_handle(msg, device) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port)) {
 		ret = -EMSGSIZE;
 		goto err_free_msg;
@@ -2101,6 +2121,10 @@ static int nldev_stat_del_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_STAT_SET),
 			0, 0);
+	if (!nlh) {
+		ret = -EMSGSIZE;
+		goto err_fill;
+	}
 
 	cntn = nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_COUNTER_ID]);
 	qpn = nla_get_u32(tb[RDMA_NLDEV_ATTR_RES_LQPN]);
@@ -2171,7 +2195,7 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 					 RDMA_NLDEV_CMD_STAT_GET),
 			0, 0);
 
-	if (fill_nldev_handle(msg, device) ||
+	if (!nlh || fill_nldev_handle(msg, device) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port)) {
 		ret = -EMSGSIZE;
 		goto err_msg;
@@ -2259,6 +2283,10 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
 					 RDMA_NLDEV_CMD_STAT_GET),
 			0, 0);
+	if (!nlh) {
+		ret = -EMSGSIZE;
+		goto err_msg;
+	}
 
 	ret = rdma_counter_get_mode(device, port, &mode, &mask);
 	if (ret)
@@ -2391,7 +2419,7 @@ static int nldev_stat_get_counter_status_doit(struct sk_buff *skb,
 		0, 0);
 
 	ret = -EMSGSIZE;
-	if (fill_nldev_handle(msg, device) ||
+	if (!nlh || fill_nldev_handle(msg, device) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port))
 		goto err_msg;
 
-- 
2.38.1

