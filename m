Return-Path: <linux-rdma+bounces-18988-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JVVHBri0Wm8PwcAu9opvQ
	(envelope-from <linux-rdma+bounces-18988-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 06:16:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535339D495
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 06:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B790300601A
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 04:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0812C1594;
	Sun,  5 Apr 2026 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmKYrEIX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BD2BE053;
	Sun,  5 Apr 2026 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775362576; cv=none; b=c0j9ka9EWpRWgfrOlviUyrerIbqt6mpFjJYwJ4W6XrczBne4N6fhYzGZiqyiBkFqWFpu5nyR4ewZ0PjvhqbQrGBCbt6hnn41SNeoOGdU4yk2z63gfavzRD7Fs62CYq/owUBj+5IBI2HUeIXy5fG67qH6Hce4olT+fIDwd/clua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775362576; c=relaxed/simple;
	bh=oyM08foCllT4x58AQLid8iWZzat2U6iR9B1qaSByEY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ta2FQEoOP0PJbApO+fFmYOZJ2a+9CzBm5ZQTKhgCeEzWqTzokfsS3iQ39RqYTYvbWOL6vNn8dwqn1xRMBZ/bKQgOroTSR4QlwxtAEAYDip2tTn0EdP2RVxVzqENXXzy4ErEnsgPZFJCLq64DEE68Axfp6rbMidQWQ5WURC0VPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmKYrEIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB4C116C6;
	Sun,  5 Apr 2026 04:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775362576;
	bh=oyM08foCllT4x58AQLid8iWZzat2U6iR9B1qaSByEY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmKYrEIXypp4VCUD2NYtWiKUoA1Ub1CsppbmaMX6f/15oS8LOEcHnKHtcdsT/EtJL
	 uJBkF26JLoowF6L/r0n+qb3aw64CSNEjA7QuDyAdR9emj1q2fdfJDH6qBB5H+8jFwn
	 Jzllx0jyXiuaeKy+tjzFtWcTG0xmSXpoHkFSO0rUBLRtM8OWNsKDBDGYfGDSQTuCxg
	 ybxcy7E/Cc1J0pSMC+GYlhqxsswgt7mn5TYDZfjbIHhlHqKXYS7kN1wP1US4kCO9ao
	 cp1HsouRGASHL4czj0Cfig0anmH2buRy4gYj6CwDWgjm4p6sgGXboYsXIWbaDuKGTq
	 1Brs+2RDMMCAA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net v1 2/2] net/rds: Restrict use of RDS/IB to the initial network namespace
Date: Sat,  4 Apr 2026 21:16:13 -0700
Message-ID: <20260405041613.309958-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405041613.309958-1-achender@kernel.org>
References: <20260405041613.309958-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18988-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5535339D495
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Greg Jumper <greg.jumper@oracle.com>

Prevent using RDS/IB in network namespaces other than the initial one.
The existing RDS/IB code will not work properly in non-initial network
namespaces, and there are currently no plans to support such use.

Fixes: d5a8ac28a7ff ("RDS-TCP: Make RDS-TCP work correctly when it is set up in a netns other than init_net")
Reported-by: syzbot+da8e060735ae02c8f3d1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da8e060735ae02c8f3d1
Signed-off-by: Greg Jumper <greg.jumper@oracle.com>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/af_rds.c | 10 ++++++++--
 net/rds/ib.c     |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index b396c673dfaf..896d4cfda5c3 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -357,7 +357,8 @@ static int rds_cong_monitor(struct rds_sock *rs, sockptr_t optval, int optlen)
 	return ret;
 }
 
-static int rds_set_transport(struct rds_sock *rs, sockptr_t optval, int optlen)
+static int rds_set_transport(struct net *net, struct rds_sock *rs,
+			     sockptr_t optval, int optlen)
 {
 	int t_type;
 
@@ -373,6 +374,10 @@ static int rds_set_transport(struct rds_sock *rs, sockptr_t optval, int optlen)
 	if (t_type < 0 || t_type >= RDS_TRANS_COUNT)
 		return -EINVAL;
 
+	/* Only RDS/TCP supports non-initial network namespaces */
+	if (t_type != RDS_TRANS_TCP && !net_eq(net, &init_net))
+		return -EPROTOTYPE;
+
 	rs->rs_transport = rds_trans_get(t_type);
 
 	return rs->rs_transport ? 0 : -ENOPROTOOPT;
@@ -433,6 +438,7 @@ static int rds_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
 	struct rds_sock *rs = rds_sk_to_rs(sock->sk);
+	struct net *net = sock_net(sock->sk);
 	int ret;
 
 	if (level != SOL_RDS) {
@@ -461,7 +467,7 @@ static int rds_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	case SO_RDS_TRANSPORT:
 		lock_sock(sock->sk);
-		ret = rds_set_transport(rs, optval, optlen);
+		ret = rds_set_transport(net, rs, optval, optlen);
 		release_sock(sock->sk);
 		break;
 	case SO_TIMESTAMP_OLD:
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 73e01984ee9a..1bdbe8eaf3fc 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -490,8 +490,13 @@ static int rds_ib_laddr_check_cm(struct net *net, const struct in6_addr *addr,
 static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
 			      __u32 scope_id)
 {
-	struct rds_ib_device *rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
+	struct rds_ib_device *rds_ibdev;
+
+	/* RDS/IB is only supported in the initial network namespace */
+	if (!net_eq(net, &init_net))
+		return -EPROTOTYPE;
 
+	rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
 	if (rds_ibdev) {
 		rds_ib_dev_put(rds_ibdev);
 
-- 
2.43.0


