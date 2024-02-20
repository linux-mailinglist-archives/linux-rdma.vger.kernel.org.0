Return-Path: <linux-rdma+bounces-1061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3C85B37C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962981C2179F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6065BAD5;
	Tue, 20 Feb 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jGGWC/Ga"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCA5B681;
	Tue, 20 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412528; cv=none; b=d8ivAyEDORa7wt3RBzkUtzpax8M0gHnlX7Pp03zoE9GkqlOXY3pFGgEiKXrFlX1CunKVzer+VomHnicWRiupvugtdkYqwDL/lsa1a9QGc7SHHZyQuTouK5eKBU88bOqnrniGBYmpQ8FGxHQO6PPtaDzJgVHPQ/v3I8df1zOIsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412528; c=relaxed/simple;
	bh=Jv+zHoVmLNKmJpm8kJwJMo2+DqHD1ltHOdxjg35ROzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hNTiemGoSKos6SQq23jainrKyBZLjbHA7ht7AkLqKNf0fOfnQWyAw/PCRmpmByIVamkbtB5InQKeqEN6Q6dwrTn4OnQE4TgeejDPskwrzUPV6WzIz/Nq+T2i1hgYVuLOMNDSwciaN9vcTqtCbyFF/ipcJz+MrU3W8TN79VqEoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jGGWC/Ga; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412524; h=From:To:Subject:Date:Message-Id;
	bh=Dgvw2iqatbV+g0QS0mr8fYwI58RDtpslVXvTHIGOg3I=;
	b=jGGWC/Ga6B98Olx6jrwsd2mbl3ywO7gqikisIwfbAkpdhHJAIkKVPL77UDrOI8zafQSd6X+Wzf1i7dQ0rk9NKYYUE1yHwhCK6+qxsZRZcl1WrRWajRp+FvVYxco3gmle224xytuxc7R90kHChckWOvYPtilg3G3zjOHZTjJTTwY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXi2_1708412522;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXi2_1708412522)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:02:03 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [RFC net-next 20/20] net/smc: support diag for smc inet mode
Date: Tue, 20 Feb 2024 15:01:45 +0800
Message-Id: <1708412505-34470-21-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

---
 net/smc/smc_diag.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 137 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 59a18ec..20532e1 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -22,9 +22,11 @@
 #include "smc.h"
 #include "smc_core.h"
 #include "smc_ism.h"
+#include "smc_inet.h"
 
 struct smc_diag_dump_ctx {
 	int pos[2];
+	int inet_pos[2];
 };
 
 static struct smc_diag_dump_ctx *smc_dump_context(struct netlink_callback *cb)
@@ -35,24 +37,42 @@ static struct smc_diag_dump_ctx *smc_dump_context(struct netlink_callback *cb)
 static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
+	struct sock *clcsk;
+	bool is_v4, is_v6;
+
+	if (smc_sock_is_inet_sock(sk))
+		clcsk = sk;
+	else if (smc->clcsock)
+		clcsk = smc->clcsock->sk;
+	else
+		return;
 
 	memset(r, 0, sizeof(*r));
 	r->diag_family = sk->sk_family;
 	sock_diag_save_cookie(sk, r->id.idiag_cookie);
-	if (!smc->clcsock)
-		return;
-	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
-	r->id.idiag_dport = smc->clcsock->sk->sk_dport;
-	r->id.idiag_if = smc->clcsock->sk->sk_bound_dev_if;
-	if (sk->sk_protocol == SMCPROTO_SMC) {
-		r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
-		r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
+
+	r->id.idiag_sport = htons(clcsk->sk_num);
+	r->id.idiag_dport = clcsk->sk_dport;
+	r->id.idiag_if = clcsk->sk_bound_dev_if;
+
+	is_v4 = smc_sock_is_inet_sock(sk) ? clcsk->sk_family == AF_INET :
+		sk->sk_protocol == SMCPROTO_SMC;
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (sk->sk_protocol == SMCPROTO_SMC6) {
-		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
-		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
-		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
-		       sizeof(smc->clcsock->sk->sk_v6_daddr));
+	is_v6 = smc_sock_is_inet_sock(sk) ? clcsk->sk_family == AF_INET6 :
+		sk->sk_protocol == SMCPROTO_SMC6;
+#else
+	is_v6 = false;
+#endif
+
+	if (is_v4) {
+		r->id.idiag_src[0] = clcsk->sk_rcv_saddr;
+		r->id.idiag_dst[0] = clcsk->sk_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (is_v6) {
+		memcpy(&r->id.idiag_src, &clcsk->sk_v6_rcv_saddr,
+		       sizeof(clcsk->sk_v6_rcv_saddr));
+		memcpy(&r->id.idiag_dst, &clcsk->sk_v6_daddr,
+		       sizeof(clcsk->sk_v6_daddr));
 #endif
 	}
 }
@@ -72,7 +92,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
 			   const struct smc_diag_req *req,
-			   struct nlattr *bc)
+			   struct nlattr *bc, bool is_listen)
 {
 	struct smc_sock *smc = smc_sk(sk);
 	struct smc_diag_fallback fallback;
@@ -88,6 +108,12 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	r = nlmsg_data(nlh);
 	smc_diag_msg_common_fill(r, sk);
 	r->diag_state = smc_sk_state(sk);
+
+	if (is_listen)
+		r->diag_state = SMC_LISTEN;
+	else
+		r->diag_state = smc_sk_state(sk);
+
 	if (smc->use_fallback)
 		r->diag_mode = SMC_DIAG_MODE_FALLBACK_TCP;
 	else if (smc_conn_lgr_valid(&smc->conn) && smc->conn.lgr->is_smcd)
@@ -193,6 +219,82 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int smc_diag_dump_inet_proto(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
+				    struct netlink_callback *cb, int p_type)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	struct net *net = sock_net(skb->sk);
+	int snum = cb_ctx->inet_pos[p_type];
+	struct nlattr *bc = NULL;
+	int rc = 0, num = 0, i;
+	struct proto *target_proto;
+	struct sock *sk;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	target_proto = (p_type == SMCPROTO_SMC6) ? &smc_inet6_prot : &smc_inet_prot;
+#else
+	target_proto = &smc_inet_prot;
+#endif
+
+	for (i = 0; i < hashinfo->lhash2_mask; i++) {
+		struct inet_listen_hashbucket *ilb;
+		struct hlist_nulls_node *node;
+
+		ilb = &hashinfo->lhash2[i];
+		spin_lock(&ilb->lock);
+		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
+			if (!net_eq(sock_net(sk), net))
+				continue;
+			if (sk->sk_prot != target_proto)
+				continue;
+			if (num < snum)
+				goto next_ls;
+			rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc, 1);
+			if (rc < 0) {
+				spin_unlock(&ilb->lock);
+				goto out;
+			}
+next_ls:
+			num++;
+		}
+		spin_unlock(&ilb->lock);
+	}
+
+	for (i = 0; i <= hashinfo->ehash_mask; i++) {
+		struct inet_ehash_bucket *head = &hashinfo->ehash[i];
+		spinlock_t *lock = inet_ehash_lockp(hashinfo, i);
+		struct hlist_nulls_node *node;
+
+		if (hlist_nulls_empty(&head->chain))
+			continue;
+
+		spin_lock_bh(lock);
+		sk_nulls_for_each(sk, node, &head->chain) {
+			if (!net_eq(sock_net(sk), net))
+				continue;
+			if (sk->sk_state == TCP_TIME_WAIT)
+				continue;
+			if (sk->sk_state == TCP_NEW_SYN_RECV)
+				continue;
+			if (sk->sk_prot != target_proto)
+				continue;
+			if (num < snum)
+				goto next;
+			rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc, 0);
+			if (rc < 0) {
+				spin_unlock_bh(lock);
+				goto out;
+			}
+next:
+			num++;
+		}
+		spin_unlock_bh(lock);
+	}
+out:
+	cb_ctx->inet_pos[p_type] = num;
+	return rc;
+}
+
 static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 			       struct netlink_callback *cb, int p_type)
 {
@@ -214,7 +316,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 			continue;
 		if (num < snum)
 			goto next;
-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc, 0);
 		if (rc < 0)
 			goto out;
 next:
@@ -232,8 +334,26 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	int rc = 0;
 
 	rc = smc_diag_dump_proto(&smc_proto, skb, cb, SMCPROTO_SMC);
-	if (!rc)
-		smc_diag_dump_proto(&smc_proto6, skb, cb, SMCPROTO_SMC6);
+	if (rc)
+		goto out;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	rc = smc_diag_dump_proto(&smc_proto6, skb, cb, SMCPROTO_SMC6);
+	if (rc)
+		goto out;
+#endif
+
+	rc = smc_diag_dump_inet_proto(smc_inet_prot.h.hashinfo, skb, cb, SMCPROTO_SMC);
+	if (rc)
+		goto out;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	rc = smc_diag_dump_inet_proto(smc_inet6_prot.h.hashinfo, skb, cb, SMCPROTO_SMC6);
+	if (rc)
+		goto out;
+#endif
+	return 0;
+out:
 	return skb->len;
 }
 
@@ -273,6 +393,5 @@ static void __exit smc_diag_exit(void)
 module_init(smc_diag_init);
 module_exit(smc_diag_exit);
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SMC socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 43 /* AF_SMC */);
 MODULE_ALIAS_GENL_FAMILY(SMCR_GENL_FAMILY_NAME);
-- 
1.8.3.1


