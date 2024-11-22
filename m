Return-Path: <linux-rdma+bounces-6055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358E9D59CB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 08:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE01283779
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28F171088;
	Fri, 22 Nov 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KbmIKtKr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343616BE01;
	Fri, 22 Nov 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732259807; cv=none; b=gIKPNhyD1PinyPRc52QTGPobIanvfIzZjt6685ewBnJkh/kfaNufDxXjvKJccRswALR9SaPUWNRLwST4ecoooYwxc3dnWNxmDgCgb9OtS+HdcxW2nhbb2gsWinWd470vGnCGq5U0ytFP2gpTEFuo3TtTp9RHtOTvhkdb2Trcguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732259807; c=relaxed/simple;
	bh=2cSQxrteySvr13xOvnwTvI9SQX8fC71lvBVAvXlndMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LW2J8syc8VxN7ITpdFUg2Mtukbgx1ZKmxVrzYw+MC3FrD0T1wZmBvvppyITo2j/04E2AgzY7z83FYbFHUMKdrhG3k4qhlHNJ64Yl560HFke9aorrdbZduEopu2T+VUnbssqAK4cwQX0nZjonDdzbRhIurenpyM51w6EyBKux6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KbmIKtKr; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732259796; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ijdPFqMJEXQyY7cj+GbQC+Q1McJItiVYA1uEbryR+DM=;
	b=KbmIKtKrUjbelgN1+PZrVTI5HbgPeId/UAeBaJo998/EmwUhWxFUGOaxqL5SPSBrcucoU5iystuQgQ88dOTZGghWAqFhFq6mc0l8lvGfjacBtZ17XxYjKjYEm3963E5jXskt8zttdv0jrmUMsRRBeN4HTf6MGJSnyI+xQUWGreI=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WJzhgeP_1732259794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Nov 2024 15:16:35 +0800
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
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
Date: Fri, 22 Nov 2024 15:16:30 +0800
Message-Id: <20241122071630.63707-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241122071630.63707-1-guwen@linux.alibaba.com>
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
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
smc_conn_free() is called repeatedly because some smc_conn_free() are not
protected by sock lock.

Calls under socklock        | Calls not under socklock
-------------------------------------------------------
lock_sock(sk)               | smc_conn_abort
smc_conn_free               | \- smc_conn_free
\- smcr_link_put            |    \- smcr_link_put (duplicated)
release_sock(sk)

So make sure smc_conn_free() is called under the sock lock.

Fixes: 8cf3f3e42374 ("net/smc: use helper smc_conn_abort() in listen processing")
Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Co-developed-by: Kai <KaiShen@linux.alibaba.com>
Signed-off-by: Kai <KaiShen@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ed6d4d520bc7..e0a7a0151b11 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -973,7 +973,8 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
 	return smc_connect_fallback(smc, reason_code);
 }
 
-static void smc_conn_abort(struct smc_sock *smc, int local_first)
+static void __smc_conn_abort(struct smc_sock *smc, int local_first,
+			     bool locked)
 {
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
@@ -982,11 +983,27 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
 	if (smc_conn_lgr_valid(conn))
 		lgr_valid = true;
 
-	smc_conn_free(conn);
+	if (!locked) {
+		lock_sock(&smc->sk);
+		smc_conn_free(conn);
+		release_sock(&smc->sk);
+	} else {
+		smc_conn_free(conn);
+	}
 	if (local_first && lgr_valid)
 		smc_lgr_cleanup_early(lgr);
 }
 
+static void smc_conn_abort(struct smc_sock *smc, int local_first)
+{
+	__smc_conn_abort(smc, local_first, false);
+}
+
+static void smc_conn_abort_locked(struct smc_sock *smc, int local_first)
+{
+	__smc_conn_abort(smc, local_first, true);
+}
+
 /* check if there is a rdma device available for this connection. */
 /* called for connect and listen */
 static int smc_find_rdma_device(struct smc_sock *smc, struct smc_init_info *ini)
@@ -1352,7 +1369,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	return 0;
 connect_abort:
-	smc_conn_abort(smc, ini->first_contact_local);
+	smc_conn_abort_locked(smc, ini->first_contact_local);
 	mutex_unlock(&smc_client_lgr_pending);
 	smc->connect_nonblock = 0;
 
@@ -1454,7 +1471,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	return 0;
 connect_abort:
-	smc_conn_abort(smc, ini->first_contact_local);
+	smc_conn_abort_locked(smc, ini->first_contact_local);
 	mutex_unlock(&smc_server_lgr_pending);
 	smc->connect_nonblock = 0;
 
-- 
2.32.0.3.g01195cf9f


