Return-Path: <linux-rdma+bounces-6125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0C9DA87D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDDC1663A4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7822D1FCF4F;
	Wed, 27 Nov 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GXAvwiql"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9801957E1;
	Wed, 27 Nov 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714225; cv=none; b=mLrwlQ15eip7Gat47DQabTHs0rvbdioCf/z+2kgSxxFH4PMvCitG5Uo8Aq8xSMHrkQ2OasDjxUSVQOys7GBmJBwNjsG5Zds0f+L370N/BacwUeTsumZoCdsj1/iBw49sxnpmsU0E/I51Q0l1k6wieX0VTUyUmw4TqEhoiEP+HUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714225; c=relaxed/simple;
	bh=tW+VVCR3bdQT3BOm6OquFVaA+zteM3T5GX8YZgmFE9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjw05ujGrb3uKRy4xqcISabC8Kbq/q5WN9aYwv6k3vGWK3bT5zz71OOK6yqBxHx36GcJeF0OUAHFQgHSQFvfRsO+mSdMwasIkviFtbcVBOVHFRfyjcjX4EzVzjb3XybMDLM8Q2tJMCk2BYIJygxAcNI+mJDrR+2xac5OPICSbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GXAvwiql; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732714219; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0FD1FLjQY/A6viG2IidP3zJZvuWheOZIw9XzSF8d4Dg=;
	b=GXAvwiqllR12NXQV+56GjM15HslupuqHM2tR92G7V3R53A26rgaClEfKtpNBrC2kQQCOLbYPez75z1fMgl3bN6MjaAH1EiNdKMHjQibA0B1g5QDTQkebRBViQMlmj7Gf5Y28Uzet3I8RSsPaETtK+JqlBj/bpFo6DJBMUpu5Al8=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WKMg8ij_1732714216 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 21:30:18 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	kgraul@linux.ibm.com,
	hwippel@linux.ibm.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net/smc: initialize close_work early to avoid warning
Date: Wed, 27 Nov 2024 21:30:13 +0800
Message-Id: <20241127133014.100509-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241127133014.100509-1-guwen@linux.alibaba.com>
References: <20241127133014.100509-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encountered a warning that close_work was canceled before
initialization.

  WARNING: CPU: 7 PID: 111103 at kernel/workqueue.c:3047 __flush_work+0x19e/0x1b0
  Workqueue: events smc_lgr_terminate_work [smc]
  RIP: 0010:__flush_work+0x19e/0x1b0
  Call Trace:
   ? __wake_up_common+0x7a/0x190
   ? work_busy+0x80/0x80
   __cancel_work_timer+0xe3/0x160
   smc_close_cancel_work+0x1a/0x70 [smc]
   smc_close_active_abort+0x207/0x360 [smc]
   __smc_lgr_terminate.part.38+0xc8/0x180 [smc]
   process_one_work+0x19e/0x340
   worker_thread+0x30/0x370
   ? process_one_work+0x340/0x340
   kthread+0x117/0x130
   ? __kthread_cancel_work+0x50/0x50
   ret_from_fork+0x22/0x30

This is because when smc_close_cancel_work is triggered, e.g. the RDMA
driver is rmmod and the LGR is terminated, the conn->close_work is
flushed before initialization, resulting in WARN_ON(!work->func).

__smc_lgr_terminate             | smc_connect_{rdma|ism}
-------------------------------------------------------------
                                | smc_conn_create
				| \- smc_lgr_register_conn
for conn in lgr->conns_all      |
\- smc_conn_kill                |
   \- smc_close_active_abort    |
      \- smc_close_cancel_work  |
         \- cancel_work_sync    |
            \- __flush_work     |
	         (close_work)   |
	                        | smc_close_init
	                        | \- INIT_WORK(&close_work)

So fix this by initializing close_work before establishing the
connection.

Fixes: 46c28dbd4c23 ("net/smc: no socket state changes in tasklet context")
Fixes: 413498440e30 ("net/smc: add SMC-D support in af_smc")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/smc/af_smc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..ed6d4d520bc7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -383,6 +383,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 	smc->limit_smc_hs = net->smc.limit_smc_hs;
 	smc->use_fallback = false; /* assume rdma capability first */
 	smc->fallback_rsn = 0;
+	smc_close_init(smc);
 }
 
 static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
@@ -1299,7 +1300,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
 		goto connect_abort;
 	}
 
-	smc_close_init(smc);
 	smc_rx_init(smc);
 
 	if (ini->first_contact_local) {
@@ -1435,7 +1435,6 @@ static int smc_connect_ism(struct smc_sock *smc,
 			goto connect_abort;
 		}
 	}
-	smc_close_init(smc);
 	smc_rx_init(smc);
 	smc_tx_init(smc);
 
@@ -2479,7 +2478,6 @@ static void smc_listen_work(struct work_struct *work)
 		goto out_decl;
 
 	mutex_lock(&smc_server_lgr_pending);
-	smc_close_init(new_smc);
 	smc_rx_init(new_smc);
 	smc_tx_init(new_smc);
 
-- 
2.32.0.3.g01195cf9f


