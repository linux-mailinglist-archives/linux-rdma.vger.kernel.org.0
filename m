Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE4E33C3
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfJXNRq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:17:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42737 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJXNRq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 09:17:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so37746930qto.9
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiMiQHpoMYu90DKbOekUwzfdwOHNFqNGhQ2Mh41qcaw=;
        b=lhgRQdrv9M+aIIp66JiCYztTT4HMuzKFOrAW9/Q2Z25m1rvLqSgongtDoCuujGEnek
         ry5yBmO+oLkX/1/7qBDSfxCagYzKwfMjWnP7aoSdxyQif1VSS0hPPoGnH/f/Egi85v5Q
         h6w7yNe1VLwivAyREX0j0CaQXqKfOpcf/37Ajy9FbL97T3tcZ1mPBaXOjPbEkCU9ImNp
         4so9VYxpMKRPCprHPtw2yGS2DhsD8bv1tWB7GVAUzz441y6XClQUxzQ06KmIJRljHJ/i
         hqxDmfe5BJ9MtbpJB6q++aMOM40K92Qw1xAyKhrw2XfwDe4k2HpVk7fpe4+NtKt444Kx
         wX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiMiQHpoMYu90DKbOekUwzfdwOHNFqNGhQ2Mh41qcaw=;
        b=poa9gYqSO3vMflAepq7po172HHfZIShEBfTvKmaT1waPqdbdWLzYtZ4x3N1qIwWJ0S
         7mw/HKMeL4Hl7KGo9O84wfxA1g8bs9Pyh2OeDlrjr7U6y2nUzXv7dQmhQ6xmqOr8DGVJ
         10yCJKM/I1rRCp079NLMT7lpAGexQ5oN+FHiJ1UGtWiMpkRyrFIFbNNcFvNtQWflocTj
         o8kTUGMqHY8Ings/UUb24CpBXkjJdZpJD7y4P0lbtC75vzB96ZghvSOYuduh8ak6K8pB
         Z1AU2w0cSJDYHwJNr7psMz3N2s6T5Gq6UGLIA7WBUwoUHjA+KMMDnc4zf5WLxXBpjzyE
         4k4Q==
X-Gm-Message-State: APjAAAUROnDTy9YGTQsHIB9BjbiVxIRTWyHDYKo7gMGKstDRBsGgaaC7
        Hp4Ly864orCK7IwjUyZTiKLbqw==
X-Google-Smtp-Source: APXvYqxghiII7JHTtHuJRvJtTy0R8YTRBFMwDlGFpqvaifOIUYzm1Q1ZPEB8+kAxM9G3AxnihmKEAQ==
X-Received: by 2002:ac8:244e:: with SMTP id d14mr2409164qtd.388.1571923065036;
        Thu, 24 Oct 2019 06:17:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c21sm10981505qkg.4.2019.10.24.06.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 06:17:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNczn-00033P-K5; Thu, 24 Oct 2019 10:17:43 -0300
Date:   Thu, 24 Oct 2019 10:17:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024131743.GA24174@ziepe.ca>
References: <20191015080733.18625-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015080733.18625-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
> index 81dbd5f41bed..a3507b8be569 100644
> +++ b/drivers/infiniband/core/netlink.c
> @@ -42,9 +42,12 @@
>  #include <linux/module.h>
>  #include "core_priv.h"
>  
> -static DEFINE_MUTEX(rdma_nl_mutex);
>  static struct {
> -	const struct rdma_nl_cbs   *cb_table;
> +	const struct rdma_nl_cbs __rcu *cb_table;
> +	/* Synchronizes between ongoing netlink commands and netlink client
> +	 * unregistration.
> +	 */
> +	struct srcu_struct unreg_srcu;

A srcu in every index is serious overkill for this. Lets just us a
rwsem:

From 3ab38b889ab6b85b8689a8cd9bccbf2b28711677 Mon Sep 17 00:00:00 2001
From: Parav Pandit <parav@mellanox.com>
Date: Tue, 15 Oct 2019 11:07:33 +0300
Subject: [PATCH] IB/core: Avoid deadlock during netlink message handling

When rdmacm module is not loaded, and when netlink message is received to
get char device info, it results into a deadlock due to recursive locking
of rdma_nl_mutex with the below call sequence.

[..]
  rdma_nl_rcv()
  mutex_lock()
   [..]
   rdma_nl_rcv_msg()
      ib_get_client_nl_info()
         request_module()
           iw_cm_init()
             rdma_nl_register()
               mutex_lock(); <- Deadlock, acquiring mutex again

Due to above call sequence, following call trace and deadlock is observed.

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

1. Split the lock protecting the cb_table into a per-index lock, and make
   it a rwlock. This lock is used to ensure no callbacks are running after
   unregistration returns. Since a module will not be registered once it
   is already running callbacks, this avoids the deadlock.

2. Use smp_store_release() to update the cb_table during registration so
   that no lock is required. This avoids lockdep problems with thinking
   all the rwsems are the same lock class.

Fixes: 0e2d00eb6fd45 ("RDMA: Add NLDEV_GET_CHARDEV to allow char dev discovery and autoload")
Link: https://lore.kernel.org/r/20191015080733.18625-1-leon@kernel.org
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/core_priv.h |   1 +
 drivers/infiniband/core/device.c    |   2 +
 drivers/infiniband/core/netlink.c   | 107 ++++++++++++++--------------
 3 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3a8b0911c3bc16..9d07378b5b4230 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -199,6 +199,7 @@ void ib_mad_cleanup(void);
 int ib_sa_init(void);
 void ib_sa_cleanup(void);
 
+void rdma_nl_init(void);
 void rdma_nl_exit(void);
 
 int ib_nl_handle_resolve_resp(struct sk_buff *skb,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2dd2cfe9b56136..50a92442c4f7c1 100644
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
index 81dbd5f41beda2..8cd31ef25eff20 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -42,9 +42,12 @@
 #include <linux/module.h>
 #include "core_priv.h"
 
-static DEFINE_MUTEX(rdma_nl_mutex);
 static struct {
-	const struct rdma_nl_cbs   *cb_table;
+	const struct rdma_nl_cbs *cb_table;
+	/* Synchronizes between ongoing netlink commands and netlink client
+	 * unregistration.
+	 */
+	struct rw_semaphore sem;
 } rdma_nl_types[RDMA_NL_NUM_CLIENTS];
 
 bool rdma_nl_chk_listeners(unsigned int group)
@@ -75,70 +78,53 @@ static bool is_nl_msg_valid(unsigned int type, unsigned int op)
 	return (op < max_num_ops[type]) ? true : false;
 }
 
-static bool
-is_nl_valid(const struct sk_buff *skb, unsigned int type, unsigned int op)
+static const struct rdma_nl_cbs *
+get_cb_table(const struct sk_buff *skb, unsigned int type, unsigned int op)
 {
 	const struct rdma_nl_cbs *cb_table;
 
-	if (!is_nl_msg_valid(type, op))
-		return false;
-
 	/*
 	 * Currently only NLDEV client is supporting netlink commands in
 	 * non init_net net namespace.
 	 */
 	if (sock_net(skb->sk) != &init_net && type != RDMA_NL_NLDEV)
-		return false;
+		return NULL;
 
-	if (!rdma_nl_types[type].cb_table) {
-		mutex_unlock(&rdma_nl_mutex);
-		request_module("rdma-netlink-subsys-%d", type);
-		mutex_lock(&rdma_nl_mutex);
-	}
+	cb_table = READ_ONCE(rdma_nl_types[type].cb_table);
+	if (!cb_table) {
+		/*
+		 * Didn't get valid reference of the table, attempt module
+		 * load once.
+		 */
+		up_read(&rdma_nl_types[type].sem);
 
-	cb_table = rdma_nl_types[type].cb_table;
+		request_module("rdma-netlink-subsys-%d", type);
 
+		down_read(&rdma_nl_types[type].sem);
+		cb_table = READ_ONCE(rdma_nl_types[type].cb_table);
+	}
 	if (!cb_table || (!cb_table[op].dump && !cb_table[op].doit))
-		return false;
-	return true;
+		return NULL;
+	return cb_table;
 }
 
 void rdma_nl_register(unsigned int index,
 		      const struct rdma_nl_cbs cb_table[])
 {
-	mutex_lock(&rdma_nl_mutex);
-	if (!is_nl_msg_valid(index, 0)) {
-		/*
-		 * All clients are not interesting in success/failure of
-		 * this call. They want to see the print to error log and
-		 * continue their initialization. Print warning for them,
-		 * because it is programmer's error to be here.
-		 */
-		mutex_unlock(&rdma_nl_mutex);
-		WARN(true,
-		     "The not-valid %u index was supplied to RDMA netlink\n",
-		     index);
+	if (WARN_ON(!is_nl_msg_valid(index, 0)) ||
+	    WARN_ON(READ_ONCE(rdma_nl_types[index].cb_table)))
 		return;
-	}
-
-	if (rdma_nl_types[index].cb_table) {
-		mutex_unlock(&rdma_nl_mutex);
-		WARN(true,
-		     "The %u index is already registered in RDMA netlink\n",
-		     index);
-		return;
-	}
 
-	rdma_nl_types[index].cb_table = cb_table;
-	mutex_unlock(&rdma_nl_mutex);
+	/* Pairs with the READ_ONCE in is_nl_valid() */
+	smp_store_release(&rdma_nl_types[index].cb_table, cb_table);
 }
 EXPORT_SYMBOL(rdma_nl_register);
 
 void rdma_nl_unregister(unsigned int index)
 {
-	mutex_lock(&rdma_nl_mutex);
+	down_write(&rdma_nl_types[index].sem);
 	rdma_nl_types[index].cb_table = NULL;
-	mutex_unlock(&rdma_nl_mutex);
+	up_write(&rdma_nl_types[index].sem);
 }
 EXPORT_SYMBOL(rdma_nl_unregister);
 
@@ -170,15 +156,21 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	unsigned int index = RDMA_NL_GET_CLIENT(type);
 	unsigned int op = RDMA_NL_GET_OP(type);
 	const struct rdma_nl_cbs *cb_table;
+	int err = -EINVAL;
 
-	if (!is_nl_valid(skb, index, op))
+	if (!is_nl_msg_valid(index, op))
 		return -EINVAL;
 
-	cb_table = rdma_nl_types[index].cb_table;
+	down_read(&rdma_nl_types[index].sem);
+	cb_table = get_cb_table(skb, index, op);
+	if (!cb_table)
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
@@ -186,8 +178,8 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -195,14 +187,15 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
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
+	up_read(&rdma_nl_types[index].sem);
+	return err;
 }
 
 /*
@@ -263,9 +256,7 @@ static int rdma_nl_rcv_skb(struct sk_buff *skb, int (*cb)(struct sk_buff *,
 
 static void rdma_nl_rcv(struct sk_buff *skb)
 {
-	mutex_lock(&rdma_nl_mutex);
 	rdma_nl_rcv_skb(skb, &rdma_nl_rcv_msg);
-	mutex_unlock(&rdma_nl_mutex);
 }
 
 int rdma_nl_unicast(struct net *net, struct sk_buff *skb, u32 pid)
@@ -297,6 +288,14 @@ int rdma_nl_multicast(struct net *net, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(rdma_nl_multicast);
 
+void rdma_nl_init(void)
+{
+	int idx;
+
+	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
+		init_rwsem(&rdma_nl_types[idx].sem);
+}
+
 void rdma_nl_exit(void)
 {
 	int idx;
-- 
2.23.0

