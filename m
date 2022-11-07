Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102B61ED75
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 09:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKGIv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 03:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiKGIv5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 03:51:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23B13DC3
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 00:51:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25DD6B80E6C
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C8EC433C1;
        Mon,  7 Nov 2022 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811113;
        bh=AcL5NC6Hff1REPFt4dMu8iDjrvOkWtCCC3HbLCW/Y18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyfvyUT83Ro4VDVt7LhqQ1ZjvuEJUwX++L9kBrxS12ZDJfTGB56267TGK9nQ2S2Sr
         gfBBG6Pv8nIkVuikrcGKOzv2LGWo0rgAeZCJb+nTnO6+V7fPpChNBFDGgbMl0+Ru30
         FnHkH3LpUgkm4S5FOm2IX09oPvWyxi9JhRlj9RJhhTnCkh7L1gr0K7NfC0Dv+IPMrP
         fDTrl+NRMMr74D8VJWdHNCgW4yHTf4H+tMooUuqNB0dYmZ1JN0Xl0uckjNYDK/ZEJG
         WTfh6nxVctEzAmq5pzska4rvEJvDtMOMSQZ67spj/INNXHw9V/uJFVLDGl2atdVHSm
         nWYyxyO7QHXqg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/4] RDMA/nldev: Use __nlmsg_put instead nlmsg_put
Date:   Mon,  7 Nov 2022 10:51:33 +0200
Message-Id: <3d8fb9edbd41f122fda680158a80bac44e55e847.1667810736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667810736.git.leonro@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
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
be returned. So let's use __nlmsg_put function to silence the
warnings.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 108 +++++++++++++++-----------------
 1 file changed, 52 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b92358f606d0..213be4e6fd28 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1038,9 +1038,9 @@ static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
-			0, 0);
+	nlh = __nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
+			  0, 0);
 
 	err = fill_dev_info(msg, device);
 	if (err)
@@ -1122,9 +1122,9 @@ static int _nldev_get_dumpit(struct ib_device *device,
 	if (idx < start)
 		return 0;
 
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
-			0, NLM_F_MULTI);
+	nlh = __nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
+			  0, NLM_F_MULTI);
 
 	if (fill_dev_info(skb, device)) {
 		nlmsg_cancel(skb, nlh);
@@ -1182,9 +1182,9 @@ static int nldev_port_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
-			0, 0);
+	nlh = __nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
+			  0, 0);
 
 	err = fill_port_info(msg, device, port, sock_net(skb->sk));
 	if (err)
@@ -1240,11 +1240,11 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 			continue;
 		}
 
-		nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq,
-				RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-						 RDMA_NLDEV_CMD_PORT_GET),
-				0, NLM_F_MULTI);
+		nlh = __nlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq,
+				  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+						   RDMA_NLDEV_CMD_PORT_GET),
+				  0, NLM_F_MULTI);
 
 		if (fill_port_info(skb, device, p, sock_net(skb->sk))) {
 			nlmsg_cancel(skb, nlh);
@@ -1285,9 +1285,9 @@ static int nldev_res_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_RES_GET),
-			0, 0);
+	nlh = __nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_RES_GET), 0, 0);
 
 	ret = fill_res_info(msg, device);
 	if (ret)
@@ -1315,9 +1315,10 @@ static int _nldev_res_get_dumpit(struct ib_device *device,
 	if (idx < start)
 		return 0;
 
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_RES_GET),
-			0, NLM_F_MULTI);
+	nlh = __nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					   RDMA_NLDEV_CMD_RES_GET),
+			  0, NLM_F_MULTI);
 
 	if (fill_res_info(skb, device)) {
 		nlmsg_cancel(skb, nlh);
@@ -1449,10 +1450,10 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err_get;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NL_GET_OP(nlh->nlmsg_type)),
-			0, 0);
+	nlh = __nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					   RDMA_NL_GET_OP(nlh->nlmsg_type)),
+			  0, 0);
 
 	if (fill_nldev_handle(msg, device)) {
 		ret = -EMSGSIZE;
@@ -1528,10 +1529,10 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 		}
 	}
 
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NL_GET_OP(cb->nlh->nlmsg_type)),
-			0, NLM_F_MULTI);
+	nlh = __nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					   RDMA_NL_GET_OP(cb->nlh->nlmsg_type)),
+			  0, NLM_F_MULTI);
 
 	if (fill_nldev_handle(skb, device)) {
 		ret = -EMSGSIZE;
@@ -1791,10 +1792,10 @@ static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -ENOMEM;
 		goto out_put;
 	}
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NLDEV_CMD_GET_CHARDEV),
-			0, 0);
+	nlh = __nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					   RDMA_NLDEV_CMD_GET_CHARDEV),
+			  0, 0);
 
 	data.nl_msg = msg;
 	err = ib_get_client_nl_info(ibdev, client_name, &data);
@@ -1848,10 +1849,9 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!msg)
 		return -ENOMEM;
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NLDEV_CMD_SYS_GET),
-			0, 0);
+	nlh = __nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_SYS_GET), 0, 0);
 
 	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
 			 (u8)ib_devices_shared_netns);
@@ -2028,10 +2028,9 @@ static int nldev_stat_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ret = -ENOMEM;
 		goto err_put_device;
 	}
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NLDEV_CMD_STAT_SET),
-			0, 0);
+	nlh = __nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_STAT_SET), 0, 0);
 	if (fill_nldev_handle(msg, device) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port)) {
 		ret = -EMSGSIZE;
@@ -2097,10 +2096,9 @@ static int nldev_stat_del_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ret = -ENOMEM;
 		goto err;
 	}
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NLDEV_CMD_STAT_SET),
-			0, 0);
+	nlh = __nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_STAT_SET), 0, 0);
 
 	cntn = nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_COUNTER_ID]);
 	qpn = nla_get_u32(tb[RDMA_NLDEV_ATTR_RES_LQPN]);
@@ -2166,10 +2164,9 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 		goto err;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NLDEV_CMD_STAT_GET),
-			0, 0);
+	nlh = __nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_STAT_GET), 0, 0);
 
 	if (fill_nldev_handle(msg, device) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port)) {
@@ -2255,10 +2252,9 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
-					 RDMA_NLDEV_CMD_STAT_GET),
-			0, 0);
+	nlh = __nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_STAT_GET), 0, 0);
 
 	ret = rdma_counter_get_mode(device, port, &mode, &mask);
 	if (ret)
@@ -2385,10 +2381,10 @@ static int nldev_stat_get_counter_status_doit(struct sk_buff *skb,
 		goto err;
 	}
 
-	nlh = nlmsg_put(
-		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_STAT_GET_STATUS),
-		0, 0);
+	nlh = __nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			  RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					   RDMA_NLDEV_CMD_STAT_GET_STATUS),
+			  0, 0);
 
 	ret = -EMSGSIZE;
 	if (fill_nldev_handle(msg, device) ||
-- 
2.38.1

