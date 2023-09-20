Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E677A7D5B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjITMJC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjITMIw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 08:08:52 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78C93;
        Wed, 20 Sep 2023 05:08:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VsV5XW0_1695211715;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VsV5XW0_1695211715)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 20:08:41 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while closing listen socket
Date:   Wed, 20 Sep 2023 20:08:34 +0800
Message-Id: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

Consider the following scenarios:

smc_release
	smc_close_active
		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
		smc->clcsock->sk->sk_user_data = NULL;
		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);

smc_tcp_syn_recv_sock
	smc = smc_clcsock_user_data(sk);
	/* now */
	/* smc == NULL */

Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
since we only unset sk_user_data during smc_release, it's safe to
drop the incoming tcp reqsock.

Fixes:  ("net/smc: net/smc: Limit backlog connections"
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd97..b4acf47 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct sock *child;
 
 	smc = smc_clcsock_user_data(sk);
+	if (unlikely(!smc))
+		goto drop;
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
-- 
1.8.3.1

