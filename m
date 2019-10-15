Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9091ED70BB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfJOIHi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 04:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbfJOIHi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 04:07:38 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8319D20873;
        Tue, 15 Oct 2019 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571126857;
        bh=hhWChGtynLIF27V4qssmxHDoPGKMpOHt5Md7s34MIRQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GRjUeF9W4J6f5o6+G6eyokPWKsc35/kEU9+jwlLaXQlNaWUOSlrurcVg9lcEmrUNl
         uPUKJ83WDW7T+pRaFLcnfaA8v6pTvUru4g2G3pCCdYmgM307n3KdAH+pWSg5HlrOnr
         VAnfArLDM3Nb0TxJUbf9ig9E0/2sDQqjsIo05q7I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message handling
Date:   Tue, 15 Oct 2019 11:07:33 +0300
Message-Id: <20191015080733.18625-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

When rdmacm module is not loaded, and when netlink message is received
to get char device info, it results into a deadlock due to recursive
locking rdma_nl_mutex in below call sequence.

[..]
  rdma_nl_rcv()
  mutex_lock()
  rdma_nl_rcv_msg()
      ib_get_client_nl_info()
         request_module()
           iw_cm_init()
             rdma_nl_register()
               mutex_lock(); <- Deadlock, acquiring mutex again

Due to above call sequence, following call trace and deadlock is
observed.

kernel: __mutex_lock+0x35e/0x860
kernel: ? __mutex_lock+0x129/0x860
kernel: ? rdma_nl_register+0x1a/0x90 [ib_core]
kernel: rdma_nl_register+0x1a/0x90 [ib_core]
kernel: ? 0xffffffffc029b000
kernel: iw_cm_init+0x34/0x1000 [iw_cm]
kernel: do_one_initcall+0x67/0x2d4
kernel: ? kmem_cache_alloc_trace+0x1ec/0x2a0
kernel: do_init_module+0x5a/0x223
kernel: load_module+0x1998/0x1e10
kernel: ? __symbol_put+0x60/0x60
kernel: __do_sys_finit_module+0x94/0xe0
kernel: do_syscall_64+0x5a/0x270
kernel: entry_SYSCALL_64_after_hwframe+0x49/0xbe

process stack trace:
[<0>] __request_module+0x1c9/0x460
[<0>] ib_get_client_nl_info+0x5e/0xb0 [ib_core]
[<0>] nldev_get_chardev+0x1ac/0x320 [ib_core]
[<0>] rdma_nl_rcv_msg+0xeb/0x1d0 [ib_core]
[<0>] rdma_nl_rcv+0xcd/0x120 [ib_core]
[<0>] netlink_unicast+0x179/0x220
[<0>] netlink_sendmsg+0x2f6/0x3f0
[<0>] sock_sendmsg+0x30/0x40
[<0>] ___sys_sendmsg+0x27a/0x290
[<0>] __sys_sendmsg+0x58/0xa0
[<0>] do_syscall_64+0x5a/0x270
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

To overcome this deadlock and to allow multiple netlink messages to
progress in parallel, following scheme is implemented.

1. Block netlink table unregistration of a client until all the callers
finish executing callback for a given client.

2. Netlink clients shouldn't register table multiple times for a given
index. Such basic requirement from two non IB core module eliminates
mutex usage for table registratio,

Fixes: 0e2d00eb6fd45 ("RDMA: Add NLDEV_GET_CHARDEV to allow char dev discovery and autoload")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/core_priv.h |  1 +
 drivers/infiniband/core/device.c    |  2 +
 drivers/infiniband/core/netlink.c   | 93 ++++++++++++++++-------------
 3 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3a8b0911c3bc..9d07378b5b42 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -199,6 +199,7 @@ void ib_mad_cleanup(void);
 int ib_sa_init(void);
 void ib_sa_cleanup(void);
 
+void rdma_nl_init(void);
 void rdma_nl_exit(void);
 
 int ib_nl_handle_resolve_resp(struct sk_buff *skb,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2e53aa25f0c7..2f89c4d64b73 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2716,6 +2716,8 @@ static int __init ib_core_init(void)
 		goto err_comp_unbound;
 	}
 
+	rdma_nl_init();
+
 	ret = addr_init();
 	if (ret) {
 		pr_warn("Could't init IB address resolution\n");
diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
index 81dbd5f41bed..a3507b8be569 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -42,9 +42,12 @@
 #include <linux/module.h>
 #include "core_priv.h"
 
-static DEFINE_MUTEX(rdma_nl_mutex);
 static struct {
-	const struct rdma_nl_cbs   *cb_table;
+	const struct rdma_nl_cbs __rcu *cb_table;
+	/* Synchronizes between ongoing netlink commands and netlink client
+	 * unregistration.
+	 */
+	struct srcu_struct unreg_srcu;
 } rdma_nl_types[RDMA_NL_NUM_CLIENTS];
 
 bool rdma_nl_chk_listeners(unsigned int group)
@@ -78,8 +81,6 @@ static bool is_nl_msg_valid(unsigned int type, unsigned int op)
 static bool
 is_nl_valid(const struct sk_buff *skb, unsigned int type, unsigned int op)
 {
-	const struct rdma_nl_cbs *cb_table;
-
 	if (!is_nl_msg_valid(type, op))
 		return false;
 
@@ -90,23 +91,12 @@ is_nl_valid(const struct sk_buff *skb, unsigned int type, unsigned int op)
 	if (sock_net(skb->sk) != &init_net && type != RDMA_NL_NLDEV)
 		return false;
 
-	if (!rdma_nl_types[type].cb_table) {
-		mutex_unlock(&rdma_nl_mutex);
-		request_module("rdma-netlink-subsys-%d", type);
-		mutex_lock(&rdma_nl_mutex);
-	}
-
-	cb_table = rdma_nl_types[type].cb_table;
-
-	if (!cb_table || (!cb_table[op].dump && !cb_table[op].doit))
-		return false;
 	return true;
 }
 
 void rdma_nl_register(unsigned int index,
 		      const struct rdma_nl_cbs cb_table[])
 {
-	mutex_lock(&rdma_nl_mutex);
 	if (!is_nl_msg_valid(index, 0)) {
 		/*
 		 * All clients are not interesting in success/failure of
@@ -114,31 +104,21 @@ void rdma_nl_register(unsigned int index,
 		 * continue their initialization. Print warning for them,
 		 * because it is programmer's error to be here.
 		 */
-		mutex_unlock(&rdma_nl_mutex);
 		WARN(true,
 		     "The not-valid %u index was supplied to RDMA netlink\n",
 		     index);
 		return;
 	}
 
-	if (rdma_nl_types[index].cb_table) {
-		mutex_unlock(&rdma_nl_mutex);
-		WARN(true,
-		     "The %u index is already registered in RDMA netlink\n",
-		     index);
-		return;
-	}
-
-	rdma_nl_types[index].cb_table = cb_table;
-	mutex_unlock(&rdma_nl_mutex);
+	/* Publish now that this table entry can be accessed */
+	rcu_assign_pointer(rdma_nl_types[index].cb_table, cb_table);
 }
 EXPORT_SYMBOL(rdma_nl_register);
 
 void rdma_nl_unregister(unsigned int index)
 {
-	mutex_lock(&rdma_nl_mutex);
-	rdma_nl_types[index].cb_table = NULL;
-	mutex_unlock(&rdma_nl_mutex);
+	rcu_assign_pointer(rdma_nl_types[index].cb_table, NULL);
+	synchronize_srcu(&rdma_nl_types[index].unreg_srcu);
 }
 EXPORT_SYMBOL(rdma_nl_unregister);
 
@@ -170,15 +150,35 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	unsigned int index = RDMA_NL_GET_CLIENT(type);
 	unsigned int op = RDMA_NL_GET_OP(type);
 	const struct rdma_nl_cbs *cb_table;
+	int srcu_idx;
+	int err = -EINVAL;
 
 	if (!is_nl_valid(skb, index, op))
 		return -EINVAL;
 
-	cb_table = rdma_nl_types[index].cb_table;
+	srcu_idx = srcu_read_lock(&rdma_nl_types[index].unreg_srcu);
+	cb_table = srcu_dereference(rdma_nl_types[index].cb_table,
+				    &rdma_nl_types[index].unreg_srcu);
+	if (!cb_table) {
+		/* Didn't get valid reference of the table;
+		 * attempt module load once.
+		 */
+		srcu_read_unlock(&rdma_nl_types[index].unreg_srcu, srcu_idx);
+
+		request_module("rdma-netlink-subsys-%d", index);
+
+		srcu_idx = srcu_read_lock(&rdma_nl_types[index].unreg_srcu);
+		cb_table = srcu_dereference(rdma_nl_types[index].cb_table,
+					    &rdma_nl_types[index].unreg_srcu);
+	}
+	if (!cb_table || (!cb_table[op].dump && !cb_table[op].doit))
+		goto done;
 
 	if ((cb_table[op].flags & RDMA_NL_ADMIN_PERM) &&
-	    !netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
+	    !netlink_capable(skb, CAP_NET_ADMIN)) {
+		err = -EPERM;
+		goto done;
+	}
 
 	/*
 	 * LS responses overload the 0x100 (NLM_F_ROOT) flag.  Don't
@@ -186,8 +186,8 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	 */
 	if (index == RDMA_NL_LS) {
 		if (cb_table[op].doit)
-			return cb_table[op].doit(skb, nlh, extack);
-		return -EINVAL;
+			err = cb_table[op].doit(skb, nlh, extack);
+		goto done;
 	}
 	/* FIXME: Convert IWCM to properly handle doit callbacks */
 	if ((nlh->nlmsg_flags & NLM_F_DUMP) || index == RDMA_NL_IWCM) {
@@ -195,14 +195,15 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			.dump = cb_table[op].dump,
 		};
 		if (c.dump)
-			return netlink_dump_start(skb->sk, skb, nlh, &c);
-		return -EINVAL;
+			err = netlink_dump_start(skb->sk, skb, nlh, &c);
+		goto done;
 	}
 
 	if (cb_table[op].doit)
-		return cb_table[op].doit(skb, nlh, extack);
-
-	return 0;
+		err = cb_table[op].doit(skb, nlh, extack);
+done:
+	srcu_read_unlock(&rdma_nl_types[index].unreg_srcu, srcu_idx);
+	return err;
 }
 
 /*
@@ -263,9 +264,7 @@ static int rdma_nl_rcv_skb(struct sk_buff *skb, int (*cb)(struct sk_buff *,
 
 static void rdma_nl_rcv(struct sk_buff *skb)
 {
-	mutex_lock(&rdma_nl_mutex);
 	rdma_nl_rcv_skb(skb, &rdma_nl_rcv_msg);
-	mutex_unlock(&rdma_nl_mutex);
 }
 
 int rdma_nl_unicast(struct net *net, struct sk_buff *skb, u32 pid)
@@ -297,14 +296,24 @@ int rdma_nl_multicast(struct net *net, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(rdma_nl_multicast);
 
-void rdma_nl_exit(void)
+void rdma_nl_init(void)
 {
 	int idx;
 
 	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
+		init_srcu_struct(&rdma_nl_types[idx].unreg_srcu);
+}
+
+void rdma_nl_exit(void)
+{
+	int idx;
+
+	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++) {
+		cleanup_srcu_struct(&rdma_nl_types[idx].unreg_srcu);
 		WARN(rdma_nl_types[idx].cb_table,
 		     "Netlink client %d wasn't released prior to unloading %s\n",
 		     idx, KBUILD_MODNAME);
+	}
 }
 
 int rdma_nl_net_init(struct rdma_dev_net *rnet)
-- 
2.20.1

