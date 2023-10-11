Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E47C4BEC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJKHdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 03:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbjJKHdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 03:33:37 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9EB7;
        Wed, 11 Oct 2023 00:33:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VtvoMEe_1697009611;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VtvoMEe_1697009611)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 15:33:32 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net 4/5] net/smc: protect connection state transitions in listen work
Date:   Wed, 11 Oct 2023 15:33:19 +0800
Message-Id: <1697009600-22367-5-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

Consider the following scenario:

				smc_close_passive_work
smc_listen_out_connected
				lock_sock()
if (state  == SMC_INIT)
				if (state  == SMC_INIT)
					state = SMC_APPCLOSEWAIT1;
	state = SMC_ACTIVE
				release_sock()

This would cause the state machine of the connection to be corrupted.
Also, this issue can occur in smc_listen_out_err().

To solve this problem, we can protect the state transitions under
the lock of sock to avoid collision.

Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5ad2a9f..3bb8265 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1926,8 +1926,10 @@ static void smc_listen_out_connected(struct smc_sock *new_smc)
 {
 	struct sock *newsmcsk = &new_smc->sk;
 
+	lock_sock(newsmcsk);
 	if (newsmcsk->sk_state == SMC_INIT)
 		newsmcsk->sk_state = SMC_ACTIVE;
+	release_sock(newsmcsk);
 
 	smc_listen_out(new_smc);
 }
@@ -1939,9 +1941,12 @@ static void smc_listen_out_err(struct smc_sock *new_smc)
 	struct net *net = sock_net(newsmcsk);
 
 	this_cpu_inc(net->smc.smc_stats->srv_hshake_err_cnt);
+
+	lock_sock(newsmcsk);
 	if (newsmcsk->sk_state == SMC_INIT)
 		sock_put(&new_smc->sk); /* passive closing */
 	newsmcsk->sk_state = SMC_CLOSED;
+	release_sock(newsmcsk);
 
 	smc_listen_out(new_smc);
 }
-- 
1.8.3.1

