Return-Path: <linux-rdma+bounces-22608-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +koKM+ULRGq0ngoAu9opvQ
	(envelope-from <linux-rdma+bounces-22608-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 20:33:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678316E7324
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 20:33:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=tFbh9655;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22608-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22608-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 620A33051CA9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D3419300;
	Tue, 30 Jun 2026 18:32:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72F3DDDC4
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 18:32:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844361; cv=none; b=gWhDLQRhm5gQ2yvqKk6U6uZCDqvK1a0NGn4D/AKphHeDNU98jnfmG2w1GYpHTrCeEL47dtyk55FzQvspmLyIK8M/b8wY1cwCkMo+Ogeh/uc4oscJTk14uCAse4OPlggrFC32KpqY0KaaomsQUSOBTiPIcuP7X5/zVlNSHz/EqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844361; c=relaxed/simple;
	bh=5Od4tPA34zuwjf1KGQ2k1v3lZ1T6yJzidW15RO8rEM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0CJOJFiZzR/5iUldu/9O5qc3YUK4FZwdgiqRhk7ndXL1+WkCj2zD9kzYznAHYHQIT7QEeRrNtbfuEMB4am0ZG3BW25+MSUJm3pbAKoagwFNa3iVw8aMbpC8qqZsypTH59XSN6UJAy3D7ufmQlqke0x22QPdfqeyfcKrn6gvhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=tFbh9655; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so2256952a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782844359; x=1783449159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYn0JIP6L7e0faYWM+K1qf/n2ARh502nuelJ3kEZbss=;
        b=tFbh9655AW3jes2NpJpymBIUAFZVKq0zghP1xe/6eA1hkeolGFyND8fugRV85CQG96
         pWQGmvc0CMzMVmVkM8zhmLZkaAy+HzczTVagbI0k/d3m5okCMARDne9VznxGmcLP5m6M
         Kzp9uT4pgPg8uKZOd8hMpOK34pux8+A55PGujVhwya3SuD3ZRrN+pS3jpEy1oqoVkszT
         ntjPJOhiWWOa7qb321PA5clYUHxTT+rU38hdNGFQJYH32yNndNBqM6pa5OPTTtI8bvDe
         scrVM23I4XU8DPgY9YLbuEAbcgisDeYSv/aTvZg8FlD23efSMqm0tGL2R+VKtGHLT+Ly
         ckTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844359; x=1783449159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYn0JIP6L7e0faYWM+K1qf/n2ARh502nuelJ3kEZbss=;
        b=Vq0c+R7I59dMzfgxzMa44tDJNwucL3mBz0yecm3v6K6BhvDAgRFSyWuAixKp7VVaab
         CMW+EwjuUTfpLda6wCDZKw4aBxeh9V3waXhMnV4+GtBPvQEQeFqrIIkg1kAJUPn0EsWZ
         KelgwL5UHR0w+FBYJJc0JqlAwlromo/OjvTMKUflRhQZ9qNogn3OE9ayf3F+zPfPk9ra
         k8KJLxllHW7KUSHUxIcI2uduyJqOxKLBEIfe6XmM3Pui0j8Qy8cd+3Lx276FyfN6T7cD
         t7t1nEAwKGihWtGWyBVV84zsKO+2pC4X0tfxh2n36UQiudAd0iN3rjduxxkz5m3zHuat
         JOvA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3TL2BcuNvaT1WEalm4y+x1JUmcGfS2BVkk8yBl3wmYU/A8wHkl/wColVwXYD5JLIepNDVT24J5lqh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0G39pXJ0njX7MVLc2jia56uSEWak1GBJTpF1cEuXPQGsBGbiu
	OMCFwfoTUTTDGazNV28B7CgHxd2OsGgjjbS4jYaxIIuHv3QoabbNoauHaoAI2SSWq0iySzcfFo1
	BeVv96A==
X-Gm-Gg: AfdE7cnAC8UAhQaVQZ+NwNAzLG75UT8fHj/OmKGmgTqH9+j9MOtCfOK/iq1xNpkAa2D
	vMYePNtdwOsObOrzc3AzkUoRbBb5eMr5GDxNLOduIGv09cIOxqn6ORkezY4jcwWDeT75UxmNyaL
	GBRed1zLb1zvOX7ERihyPbmmjgux1HfIXWPJGL7HXL55hRY36xshv5ub72Js8Nh7bClmTicYNrg
	JZUkJI1/YrjEr1W5PlmVQS+wblgukr9WWv2a1IrGFKO0lQwa1sljzZ2i8/9d2834E3mWOcXZ7Ej
	PfhrPhlDvhypkEymaXWJ21sjfdc/TVpQooSKLsAt7y6EWCGIvHplkLgEkaJhTnMDyXkfTZt1p5K
	QlcLwnFFPb8sqBR/trCJQMAXxePOVJyRny/cSiOiAhV6ty4BTeOJR5KuCR/OPPX3iD/kKd8pEFQ
	==
X-Received: by 2002:a17:90b:4985:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3805252ef0emr3199432a91.2.1782844358846;
        Tue, 30 Jun 2026 11:32:38 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec8c:9d53:ddf7:b69f:b5ae:d529])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d4c263sm387317a91.3.2026.06.30.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:32:38 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Sidraya Jayagond <sidraya@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hans Wippel <hwippel@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket
Date: Tue, 30 Jun 2026 11:32:27 -0700
Message-ID: <20260630183227.2044998-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22608-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sidraya@linux.ibm.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hwippel@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 678316E7324

smc_cdc_rx_handler() looks up the connection by token under the link
group's conns_lock, drops the lock, and then dereferences conn and the
smc_sock derived from it, ending in sock_hold(&smc->sk) inside
smc_cdc_msg_recv(). No reference is held across the lock release.

The only reference pinning the socket while the connection is
discoverable in the link group is taken in smc_lgr_register_conn()
(sock_hold) and dropped in __smc_lgr_unregister_conn() (sock_put), both
under conns_lock. Once the handler drops conns_lock, a concurrent
close() -> smc_release() -> smc_conn_free() -> smc_lgr_unregister_conn()
can drop that reference and free the smc_sock, so the handler's later
sock_hold() runs on freed memory:

  WARNING: lib/refcount.c:25 at refcount_warn_saturate
  Workqueue: rxe_wq do_work
   refcount_warn_saturate (lib/refcount.c:25)
   smc_cdc_msg_recv (net/smc/smc_cdc.c:430)
   smc_cdc_rx_handler (net/smc/smc_cdc.c:502)
   smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445)
   tasklet_action_common (kernel/softirq.c:938)
   handle_softirqs (kernel/softirq.c:622)
  Kernel panic - not syncing: panic_on_warn set

Only SMC-R is affected. The SMC-D receive tasklet is stopped by
tasklet_kill(&conn->rx_tsklet) in smc_conn_free() before the connection
is unregistered, so it cannot run concurrently with the free.

Take the socket reference while still holding conns_lock, so the
registration reference can no longer be the last one, and drop it once
the handler is done.

Fixes: d7b0e37c1ac1 ("net/smc: restructure CDC message reception")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2:
- Take the reference under conns_lock, and compute smc once
- Initialize smc = NULL at declaration

 net/smc/smc_cdc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 619b3bab3824..32d6d03df321 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -470,9 +470,9 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 {
 	struct smc_link *link = (struct smc_link *)wc->qp->qp_context;
 	struct smc_cdc_msg *cdc = buf;
+	struct smc_sock *smc = NULL;
 	struct smc_connection *conn;
 	struct smc_link_group *lgr;
-	struct smc_sock *smc;
 
 	if (wc->byte_len < offsetof(struct smc_cdc_msg, reserved))
 		return; /* short message */
@@ -483,21 +483,26 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 	lgr = smc_get_lgr(link);
 	read_lock_bh(&lgr->conns_lock);
 	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
-	read_unlock_bh(&lgr->conns_lock);
-	if (!conn || conn->out_of_sync)
+	if (!conn || conn->out_of_sync) {
+		read_unlock_bh(&lgr->conns_lock);
 		return;
+	}
 	smc = container_of(conn, struct smc_sock, conn);
+	sock_hold(&smc->sk);
+	read_unlock_bh(&lgr->conns_lock);
 
 	if (cdc->prod_flags.failover_validation) {
 		smc_cdc_msg_validate(smc, cdc, link);
-		return;
+		goto out;
 	}
 	if (smc_cdc_before(ntohs(cdc->seqno),
 			   conn->local_rx_ctrl.seqno))
 		/* received seqno is old */
-		return;
+		goto out;
 
 	smc_cdc_msg_recv(smc, cdc);
+out:
+	sock_put(&smc->sk);
 }
 
 static struct smc_wr_rx_handler smc_cdc_rx_handlers[] = {
-- 
2.43.0


