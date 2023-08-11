Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BCE778A59
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Aug 2023 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjHKJu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Aug 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjHKJuV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Aug 2023 05:50:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F13272D;
        Fri, 11 Aug 2023 02:50:16 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RMf8p23XRzqSfB;
        Fri, 11 Aug 2023 17:47:22 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 17:50:14 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <santosh.shilimkar@oracle.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <yuehaibing@huawei.com>, <horms@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <rds-devel@oss.oracle.com>
Subject: [PATCH v2 net-next] net/rds: Remove unused function declarations
Date:   Fri, 11 Aug 2023 17:50:10 +0800
Message-ID: <20230811095010.8620-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 39de8281791c ("RDS: Main header file") declared but never implemented
rds_trans_init() and rds_trans_exit(), remove it.
Commit d37c9359056f ("RDS: Move loop-only function to loop.c") removed the
implementation rds_message_inc_free() but not the declaration.

Since commit 55b7ed0b582f ("RDS: Common RDMA transport code")
rds_rdma_conn_connect() is never implemented and used.
rds_tcp_map_seq() is never implemented and used since
commit 70041088e3b9 ("RDS: Add TCP transport to RDS").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: fold tcp/rdma patch
---
 net/rds/rdma_transport.h | 1 -
 net/rds/rds.h            | 3 ---
 net/rds/tcp.h            | 1 -
 3 files changed, 5 deletions(-)

diff --git a/net/rds/rdma_transport.h b/net/rds/rdma_transport.h
index ca4c3a667091..d2fdb1529585 100644
--- a/net/rds/rdma_transport.h
+++ b/net/rds/rdma_transport.h
@@ -17,7 +17,6 @@
  */
 #define RDS_RDMA_REJ_INCOMPAT		1
 
-int rds_rdma_conn_connect(struct rds_connection *conn);
 int rds_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
 			      struct rdma_cm_event *event);
 int rds6_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
diff --git a/net/rds/rds.h b/net/rds/rds.h
index d35d1fc39807..dc360252c515 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -863,7 +863,6 @@ int rds_message_next_extension(struct rds_header *hdr,
 			       unsigned int *pos, void *buf, unsigned int *buflen);
 int rds_message_add_rdma_dest_extension(struct rds_header *hdr, u32 r_key, u32 offset);
 int rds_message_inc_copy_to_user(struct rds_incoming *inc, struct iov_iter *to);
-void rds_message_inc_free(struct rds_incoming *inc);
 void rds_message_addref(struct rds_message *rm);
 void rds_message_put(struct rds_message *rm);
 void rds_message_wait(struct rds_message *rm);
@@ -1013,7 +1012,5 @@ void rds_trans_put(struct rds_transport *trans);
 unsigned int rds_trans_stats_info_copy(struct rds_info_iterator *iter,
 				       unsigned int avail);
 struct rds_transport *rds_trans_get(int t_type);
-int rds_trans_init(void);
-void rds_trans_exit(void);
 
 #endif
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index f8b5930d7b34..053aa7da87ef 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -56,7 +56,6 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 			       struct rds_tcp_connection *tc);
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc);
 u32 rds_tcp_snd_una(struct rds_tcp_connection *tc);
-u64 rds_tcp_map_seq(struct rds_tcp_connection *tc, u32 seq);
 extern struct rds_transport rds_tcp_transport;
 void rds_tcp_accept_work(struct sock *sk);
 int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
-- 
2.34.1

