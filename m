Return-Path: <linux-rdma+bounces-6430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0589EC8E1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D32D28361B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97D1A83F2;
	Wed, 11 Dec 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lWwPkh9o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E12336BB;
	Wed, 11 Dec 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908898; cv=none; b=c8PvLAJoDKgnkVapviOKACFoMRQqLEmZDaXsv1vIWeCIlQ0vj/MBcPCe6k6E7DawJHPQQktnupclwN7X3pNzbc1gWOoX+2qjd4fP/r1kL/U+6GI/UNg5ipsu64ODJ92/1vFN3R611Xwe82cowP1DCMOeCt+40kYm23wxU9eGd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908898; c=relaxed/simple;
	bh=JZ5cMhgrB9KTX5d9hqh4kMUMggsb8o+4zNXHZqQZODc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwgyuDjjzGoa0HeqYs0L20OIp6MLf817ihV4n6CWOJ95VcUoA+D7jx0D1AGtTbJA6syUilxFJTyd8UNZ/u5OTAf6AURVC2gjz8uop6nfCyBSsOX5k43/RJAj0QzT3wZWK4DPgqwT5sRZkQZfju4074UeJh1DNdQuCg6XqSoHyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lWwPkh9o; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733908893; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lSjNw2/xjr2Fp60PpnZLf8qvnRtosl2QOB6Wv/bZTLw=;
	b=lWwPkh9oWvHdogzcomMsIlW2gUateQ4zp8QQcx0Ze+i7CTQ8wFvSZOxhJMvckPjTMrgbfKA/uz65xA7OGKa9RZtmN0Z3yvBu7toxxiI6AKE/quaqEnzAZiBoeAHOisV80SBZH7gUnV2msUqT95eR+ACP04t8mFMAJmQly9Cw4mg=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLHtOng_1733908892 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 17:21:32 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/6] net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
Date: Wed, 11 Dec 2024 17:21:17 +0800
Message-Id: <20241211092121.19412-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
References: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When application sending data more than sndbuf_space, there have chances
application will sleep in epoll_wait, and will never be wakeup again. This
is caused by a race between smc_poll and smc_cdc_tx_handler.

application                                      tasklet
smc_tx_sendmsg(len > sndbuf_space)   |
epoll_wait for EPOLL_OUT,timeout=0   |
  smc_poll                           |
    if (!smc->conn.sndbuf_space)     |
                                     |  smc_cdc_tx_handler
                                     |    atomic_add sndbuf_space
                                     |    smc_tx_sndbuf_nonfull
                                     |      if (!test_bit SOCK_NOSPACE)
                                     |        do not sk_write_space;
      set_bit SOCK_NOSPACE;          |
    return mask=0;                   |

Application will sleep in epoll_wait as smc_poll returns 0. And
smc_cdc_tx_handler will not call sk_write_space because the SOCK_NOSPACE
has not be set. If there is no inflight cdc msg, sk_write_space will not be
called any more, and application will sleep in epoll_wait forever.
So check sndbuf_space again after NOSPACE flag is set to break the race.

Fixes: 8dce2786a290 ("net/smc: smc_poll improvements")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
---
 net/smc/af_smc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..4ab86141e4b4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2881,6 +2881,13 @@ __poll_t smc_poll(struct file *file, struct socket *sock,
 			} else {
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 				set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+
+				if (sk->sk_state != SMC_INIT) {
+					/* Race breaker the same way as tcp_poll(). */
+					smp_mb__after_atomic();
+					if (atomic_read(&smc->conn.sndbuf_space))
+						mask |= EPOLLOUT | EPOLLWRNORM;
+				}
 			}
 			if (atomic_read(&smc->conn.bytes_to_rcv))
 				mask |= EPOLLIN | EPOLLRDNORM;
-- 
2.24.3 (Apple Git-128)


