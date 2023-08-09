Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720E776237
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjHIOSQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 10:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHIOSP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 10:18:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE08A1FF7;
        Wed,  9 Aug 2023 07:18:14 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLXD06YcmzVkqv;
        Wed,  9 Aug 2023 22:16:16 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:18:11 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <santosh.shilimkar@oracle.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <yuehaibing@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <rds-devel@oss.oracle.com>
Subject: [PATCH net-next] RDS: IB: Remove unused declarations
Date:   Wed, 9 Aug 2023 22:18:06 +0800
Message-ID: <20230809141806.46476-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
the other functions.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/rds/ib.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index 2ba71102b1f1..8ef3178ed4d6 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -369,9 +369,6 @@ int rds_ib_conn_alloc(struct rds_connection *conn, gfp_t gfp);
 void rds_ib_conn_free(void *arg);
 int rds_ib_conn_path_connect(struct rds_conn_path *cp);
 void rds_ib_conn_path_shutdown(struct rds_conn_path *cp);
-void rds_ib_state_change(struct sock *sk);
-int rds_ib_listen_init(void);
-void rds_ib_listen_stop(void);
 __printf(2, 3)
 void __rds_ib_conn_error(struct rds_connection *conn, const char *, ...);
 int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
@@ -402,7 +399,6 @@ void rds_ib_inc_free(struct rds_incoming *inc);
 int rds_ib_inc_copy_to_user(struct rds_incoming *inc, struct iov_iter *to);
 void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic, struct ib_wc *wc,
 			     struct rds_ib_ack_state *state);
-void rds_ib_recv_tasklet_fn(unsigned long data);
 void rds_ib_recv_init_ring(struct rds_ib_connection *ic);
 void rds_ib_recv_clear_ring(struct rds_ib_connection *ic);
 void rds_ib_recv_init_ack(struct rds_ib_connection *ic);
-- 
2.34.1

