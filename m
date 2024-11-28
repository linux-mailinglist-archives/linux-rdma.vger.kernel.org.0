Return-Path: <linux-rdma+bounces-6147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B49DB755
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6FCB22DC4
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9219C54F;
	Thu, 28 Nov 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GyCDm6Vr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E019D89D;
	Thu, 28 Nov 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796099; cv=none; b=rY1s+4fazOR1BCFSiacB4H4pBTrf/dNLbLfM9JB3PXbrqAF2Qpeo4NXrIRmwLWLTlIUBtsKD+kcFCoRufVsGm6OyYM0i/ZWcjCSZRo43BfYwW+6/EJ7sH6hvnT08wlvNa9CYoiPHg0A+9virofmLnXbSfUUH9mYJVxqWVSwrbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796099; c=relaxed/simple;
	bh=xBF2dbUuD4q+M0gc8w264pnDrh7GdPaVJF7NFnNfpiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQOJuh5FsUj9RgzIAvpdKhksrftLsF+zl95gTSce6G88tVV+v1Lo7Wtlto1o4g/dGqCZZh4cYMY1niSN+9d0U5efXhTok/m4dEM4YNxtapQwQSDU/YWQCzvyS5mR15ZuK3yKb0FRJlI+b01rtv4v1FsAsTjx69KsALMEKf3xZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GyCDm6Vr; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732796088; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ogpe+rzILFNoPerH7P/EPjmVtxCcuQflcS8Er8HWuV0=;
	b=GyCDm6VrY53cEV0iwdzLmdFcYXh3DzA/Cq/5KEto3iJ9Ppok4DIjzoV5G9M6DVeSy++KQqqM1h1/KUO59BScB49XnPT1LmuCgB3xp1RReGe4vB8YiEORes/MI9smNz6GUwzuIsssYinJAOdTVhyIpZLlEscc96XYsXvaZYdeQMo=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKQ-9TZ_1732796087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 20:14:47 +0800
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
Subject: [PATCH net 2/6] net/smc: set SOCK_NOSPACE when send_remaining but no sndbuf_space left
Date: Thu, 28 Nov 2024 20:14:31 +0800
Message-Id: <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
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
So set SOCK_NOSPACE when send_remaining but no sndbuf_space left in
smc_tx_sendmsg, to ensure call sk_write_space in smc_cdc_tx_handler
even when the above race happens.

Fixes: 6889b36da78a ("net/smc: don't wait for send buffer space when data was already sent")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3cbcf9a..60cfec8eb255 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -222,8 +222,11 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 			conn->local_tx_ctrl.prod_flags.urg_data_pending = 1;
 
 		if (!atomic_read(&conn->sndbuf_space) || conn->urg_tx_pend) {
-			if (send_done)
+			if (send_done) {
+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+				set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 				return send_done;
+			}
 			rc = smc_tx_wait(smc, msg->msg_flags);
 			if (rc)
 				goto out_err;
-- 
2.24.3 (Apple Git-128)


