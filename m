Return-Path: <linux-rdma+bounces-19129-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IyIOMDMM1mmfAwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19129-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 10:05:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E73B8B80
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE28830254FA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0A39DBD9;
	Wed,  8 Apr 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg7Df3/8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A639B96C;
	Wed,  8 Apr 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635464; cv=none; b=AdLu+SyPxlQZouwMPutUYpmWk0nAaIT/WAJI2Qs8DGemBMJzaUvAviM4ByBvZcugBCEs8NGPrBRYPmXoBEzS/yQrCZ/jd+4S1jgeeiTNm3FAiEY4KZIwcsu/XIy6mw5SG0R1rQD8bZNlp7VQdIK+hNk8keOdQCYA1tLMEUFYFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635464; c=relaxed/simple;
	bh=80BPbrP2oPK+wFlleEXaatTAXaOpxycwsYHH/QBPTRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO03iYnWEcqJs4hfrMhQPVKFagEYiWaG1TZ77pEPR19UnBlZRd0BIKWmEKW8frMUn5unaqAA1ArsnnQv7H/IhxCW290/hnL/8WEuqsoeWCtbpMt6KQwu0eWVedzT+vTbdE6PquMy2IE1CMbBpRgQ0weWmExDMXApjFp/UUcAteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg7Df3/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4209BC19425;
	Wed,  8 Apr 2026 08:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635463;
	bh=80BPbrP2oPK+wFlleEXaatTAXaOpxycwsYHH/QBPTRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pg7Df3/8qGwGM0AgWGtaG3h2zO/J76we/39LOEk0Msj1P522o9EkDMbR8iHBwtOSM
	 KYYAmLwIuyBYDMtgRmO5YzLI6/xuD6cbDMbp/v492ed161KMis1jHlNjcqiQVUrz4l
	 4F58myBugnFlo7aDDfxLzleRh2NC3u2P/HVMTvCVn0uijq9QY0wlT8D89APpgaJxsv
	 AaV+ytpOLl7xyhUO46h7CBa89z3J0vGgm7Y+VDlnPX+NYUTboVbxoAkP3WcgYO+Vit
	 olXtCUnvYCht4Md9CnSh4b2lKTGNtyLQ9xweO85C2p66WoRoKVp8GwWfkudy7/tfem
	 NU8/U5j7eYzaA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net v2 2/2] net/rds: Restrict use of RDS/IB to the initial network namespace
Date: Wed,  8 Apr 2026 01:04:20 -0700
Message-ID: <20260408080420.540032-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408080420.540032-1-achender@kernel.org>
References: <20260408080420.540032-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19129-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 8C6E73B8B80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Greg Jumper <greg.jumper@oracle.com>

Prevent using RDS/IB in network namespaces other than the initial one.
The existing RDS/IB code will not work properly in non-initial network
namespaces.

Fixes: d5a8ac28a7ff ("RDS-TCP: Make RDS-TCP work correctly when it is set up in a netns other than init_net")
Reported-by: syzbot+da8e060735ae02c8f3d1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da8e060735ae02c8f3d1
Signed-off-by: Greg Jumper <greg.jumper@oracle.com>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/af_rds.c | 10 ++++++++--
 net/rds/ib.c     |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index b396c673dfaf..76f625986a7f 100644
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
 
+	/* RDS/IB is restricted to the initial network namespace */
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
index 412ff61e74fa..39f87272e071 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -492,6 +492,10 @@ static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
 {
 	struct rds_ib_device *rds_ibdev = NULL;
 
+	/* RDS/IB is restricted to the initial network namespace */
+	if (!net_eq(net, &init_net))
+		return -EPROTOTYPE;
+
 	if (ipv6_addr_v4mapped(addr)) {
 		rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
 		if (rds_ibdev) {
-- 
2.43.0


