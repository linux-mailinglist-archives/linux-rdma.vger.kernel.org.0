Return-Path: <linux-rdma+bounces-20220-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDhKKdmE/WmefQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20220-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 08:38:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52E4F2875
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 08:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BA473017EFB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 06:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E23603D5;
	Fri,  8 May 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JqwzEvEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9C36D9F6;
	Fri,  8 May 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222268; cv=none; b=KHh8O2JDWitl98G7oZ5NCu7ULxd2w/nDPnbF5aIZ7XKsfttMGkRfILq+G5eJ+v6eKTpJ01j2qjs6da0DtTdmYBNBCiXoxb9cpOfG+dR6GX0Q0e0QGLlqp4A3n1/MB4u+nVWNZ72xURScXFw1LXXwNY7I+q2EOjwH9wO6mymhHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222268; c=relaxed/simple;
	bh=qu4VFGnAD79k18X/nN8oI3lmAqYSeiOj6OqbG9omgFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAm4gHXYOyhJ9jYBqxWtxSwp1NN18XKiR1ZPnRYd7VCJMARBu52JFjbm9pu0e7Y3VpC/USRGFyqlhMb/NdZyhH4foB7XSYFHw1Ww2kU8/UGr3oDXOQLjKMuRKEHErJh7Khy64sY177RXiDkhMkg1QisXt+HWMxMAqbNYakhCVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JqwzEvEl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778222249; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SptUoC4xV9rNtAjrUWsmCR3aCnuNAMIlfsEk+oQEgVs=;
	b=JqwzEvEl0yL2fhxU1vpxN8KGYJKG6SDr4nI1wR+DRiXEg7zTDQc8JR/yULL5ZYTWk98nMjkcynE6SRKFfVyyyKzQbTKx6YHoDc3whpyOVi6uzbg1kMiyIPZxFbYptPTGdpbxKrt3SYvYjXTbXgp//xVRoFQm358dphtX42C++9E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X2WYxel_1778222248;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X2WYxel_1778222248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 14:37:28 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: [PATCH net-next 2/2] net/smc: reduce TX slot contention with exclusive wait
Date: Fri,  8 May 2026 14:37:18 +0800
Message-ID: <20260508063718.101622-3-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260508063718.101622-1-alibuda@linux.alibaba.com>
References: <20260508063718.101622-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A52E4F2875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20220-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

smc_wr_tx_get_free_slot() waits for a free TX slot with
wait_event_interruptible_timeout(). Since the wait_event family
enqueues waiters as non-exclusive, wake_up() may wake multiple
waiters even though only one can use the slot, causing
thundering-herd contention when slots are scarce.

Use an exclusive wait loop with prepare_to_wait_exclusive() so
wake_up() wakes only one waiter per freed slot.
smc_wr_wakeup_tx_wait() still uses wake_up_all() during link
teardown, so teardown behavior is unchanged.

Performance measured with netperf TCP_RR (63 flows, 200B write /
1000B read, 60s duration):

+-------------------------------+---------------+---------------+
| smcr_max_conns_per_lgr        | 32            | 255           |
|-------------------------------+---------------+---------------|
| before                        | 4.85 Gb/s     | 657.95 Mb/s   |
|-------------------------------+---------------+---------------|
| after                         | 5.01 Gb/s     | 2.2 Gb/s      |
+-------------------------------+---------------+---------------+

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_wr.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 48037a3d97a3..0a6f2befb0e2 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -159,9 +159,11 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 			    struct smc_rdma_wr **wr_rdma_buf,
 			    struct smc_wr_tx_pend_priv **wr_pend_priv)
 {
+	unsigned long timeout = SMC_WR_TX_WAIT_FREE_SLOT_TIME;
 	struct smc_link_group *lgr = smc_get_lgr(link);
 	struct smc_wr_tx_pend *wr_pend;
 	u32 idx = link->wr_tx_cnt;
+	DEFINE_WAIT(wait);
 	int rc;
 
 	*wr_buf = NULL;
@@ -171,17 +173,27 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 		if (rc)
 			return rc;
 	} else {
-		rc = wait_event_interruptible_timeout(
-			link->wr_tx_wait,
-			!smc_link_sendable(link) ||
-			lgr->terminating ||
-			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
-			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
-		if (!rc) {
-			/* timeout - terminate link */
-			smcr_link_down_cond_sched(link);
-			return -EPIPE;
+		rc = 0;
+		for (;;) {
+			prepare_to_wait_exclusive(&link->wr_tx_wait, &wait,
+						  TASK_INTERRUPTIBLE);
+			if (!smc_link_sendable(link) || lgr->terminating ||
+			    smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY)
+				break;
+			timeout = schedule_timeout(timeout);
+			if (!timeout) {
+				/* timeout - terminate link */
+				smcr_link_down_cond_sched(link);
+				break;
+			}
+			if (signal_pending(current)) {
+				rc = -ERESTARTSYS;
+				break;
+			}
 		}
+		finish_wait(&link->wr_tx_wait, &wait);
+		if (rc)
+			return rc;
 		if (idx == link->wr_tx_cnt)
 			return -EPIPE;
 	}
-- 
2.45.0


