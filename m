Return-Path: <linux-rdma+bounces-6126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8029DA881
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E16166766
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF71FCFCD;
	Wed, 27 Nov 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RbnPhrHu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87C5B1FB;
	Wed, 27 Nov 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714226; cv=none; b=e3D0XFQ4io6cjT5IlfUG+CAUhw9EKfQKZ7MlYMrqjh5IKA2jOFpXiONyUlHtqlpyK4LCIvCaLL9IOtn2ngbHWQ5q8VFqvz0YDWDrmgMu1oweZj5hexHAAkhhvoTKSk/GFHOEQa25lSi++P2snrcGZXAHEyojKAps+Dwuv7vcuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714226; c=relaxed/simple;
	bh=eurh3IoFffcwIYSmtKn6rRPAfOFD/U0NU9PvTvqgvII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uA+c3Nmn1DLBe+ZCKvdbkoXltPay7jpindojiGWfQXJM3m6MpmalBMkWsigcsa+8xAegxLXOnaAuB4dYIPZZ67Y+c1qmBaNsfhsq1agLIyFh9VpzSwxoepXHLxKU2G20p3kCTSgpDRdh7X0amMXVlvzhSFFRyVmTjDMrUAXV17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RbnPhrHu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732714220; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VQ5YFXwzAVQWAU6LW3L0vrzXF2bw6K+KRSa11h34H0U=;
	b=RbnPhrHuZiCcvnFwJUXvOzL+I6TfaX/b+5jaJVpRK5Eda6TVZecnjKGhKDJyw061qnehzJPS74CwtsWHclcZ3G3Ij765Dip4V7vQ8LI2YWPYYjrpEg2fpXY7G7i0K4H/f+9HS7e1sifI4kJocwT88QYBDqRDL7nIVyKuafHRrSA=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WKMbqSM_1732714218 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 21:30:20 +0800
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
Subject: [PATCH net v2 2/2] net/smc: fix LGR and link use-after-free issue
Date: Wed, 27 Nov 2024 21:30:14 +0800
Message-Id: <20241127133014.100509-3-guwen@linux.alibaba.com>
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

We encountered a LGR/link use-after-free issue, which manifested as
the LGR/link refcnt reaching 0 early and entering the clear process,
making resource access unsafe.

 refcount_t: addition on 0; use-after-free.
 WARNING: CPU: 14 PID: 107447 at lib/refcount.c:25 refcount_warn_saturate+0x9c/0x140
 Workqueue: events smc_lgr_terminate_work [smc]
 Call trace:
  refcount_warn_saturate+0x9c/0x140
  __smc_lgr_terminate.part.45+0x2a8/0x370 [smc]
  smc_lgr_terminate_work+0x28/0x30 [smc]
  process_one_work+0x1b8/0x420
  worker_thread+0x158/0x510
  kthread+0x114/0x118

or

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 6 PID: 93140 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x140
 Workqueue: smc_hs_wq smc_listen_work [smc]
 Call trace:
  refcount_warn_saturate+0xf0/0x140
  smcr_link_put+0x1cc/0x1d8 [smc]
  smc_conn_free+0x110/0x1b0 [smc]
  smc_conn_abort+0x50/0x60 [smc]
  smc_listen_find_device+0x75c/0x790 [smc]
  smc_listen_work+0x368/0x8a0 [smc]
  process_one_work+0x1b8/0x420
  worker_thread+0x158/0x510
  kthread+0x114/0x118

It is caused by repeated release of LGR/link refcnt. One suspect is that
smc_conn_free() is called repeatedly because some smc_conn_free() from
server listening path are not protected by sock lock.

e.g.

Calls under socklock        | smc_listen_work
-------------------------------------------------------
lock_sock(sk)               | smc_conn_abort
smc_conn_free               | \- smc_conn_free
\- smcr_link_put            |    \- smcr_link_put (duplicated)
release_sock(sk)

So here add sock lock protection in smc_listen_work() path, making it
exclusive with other connection operations.

Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Co-developed-by: Kai <KaiShen@linux.alibaba.com>
Signed-off-by: Kai <KaiShen@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ed6d4d520bc7..9e6c69d18581 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1900,6 +1900,7 @@ static void smc_listen_out(struct smc_sock *new_smc)
 	if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
 		atomic_dec(&lsmc->queued_smc_hs);
 
+	release_sock(newsmcsk); /* lock in smc_listen_work() */
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
 		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
@@ -2421,6 +2422,7 @@ static void smc_listen_work(struct work_struct *work)
 	u8 accept_version;
 	int rc = 0;
 
+	lock_sock(&new_smc->sk); /* release in smc_listen_out() */
 	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
 		return smc_listen_out_err(new_smc);
 
-- 
2.32.0.3.g01195cf9f


