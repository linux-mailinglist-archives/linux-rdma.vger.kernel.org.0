Return-Path: <linux-rdma+bounces-21027-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHRkB8p0DWrSxgUAu9opvQ
	(envelope-from <linux-rdma+bounces-21027-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:46:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B958A08F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91F11300B8C5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF632B109;
	Wed, 20 May 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5b2Pi4L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76133D6D5
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266565; cv=none; b=QqRT0KB3KDZZZV5K+ftl6jlv8zA2QPrcFMoQ3mX6zkjEtdE0kcKgoQo5ieYZRtudjojEHF1UI39WsEC+vKa7HFNNpORS4gYy3vSnxMnVuG244QJudiuly+ctfLYfNLj8n4X1TmR4dtZ8Fz5QfD8nlPE5GHPWlFdC9e9F7Rdu3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266565; c=relaxed/simple;
	bh=tHiytlwYL5ZPS+5bOp5RZBz2MEVQjQT02NVce6+vGbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avIu+CW71eEL+oZ+VmhlHwmjKnA9z4DfnZacbYG7xiBwX/RwyAEFw6dma3iAjBAdnsGmXob6ZIIbSVIBC7qZ7zw+VdhTKNcCd2vgKwB+aapePgz47K5iE06RVkZEUSAcjhX9XUbf6D5VKAtrk/pOIHPmVRg6G+sx1AQQ4U9Pni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5b2Pi4L; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8025aecc40so2247251a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266563; x=1779871363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj9dNWpwR7KR9FuTwwa9cr68HYXxFlOPEg+1G0DdtjA=;
        b=S5b2Pi4Ld5d9QRWiWPuN9GJZ7YN+I5QiaGUaLYE0uGvNzLZCMExQgL5t6JfDf8JEMa
         nfYDfOvIYAezWXrd9otZWdm/ksUPBslWcsqzPqanACHPJBAZRYMwgH4Mpl9CCKIR9K5G
         MWyEHGfz+JrYziHB9wAzY/VgwCVVS+RMRBc9lCX1XZ+cCgXNfMtUZkeMNrwH4Va07lem
         EfrSOLJSJUo1umDuaJ17lUzlgDbqMp0HQ9+NZwhA50asBJ40+41RN6YtIYtnMT4n2Wj5
         b+HMXeWrmZB1Us2T1qG2b/cgLouHir4hpCgdP6B7oQGMHXuGFkRYRZ0Qm5dI16B3oIaU
         9zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266563; x=1779871363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj9dNWpwR7KR9FuTwwa9cr68HYXxFlOPEg+1G0DdtjA=;
        b=cb+9yKdeVd2Cito1ZDYt6t7mirxLyJi2AVccOVxjn4KVA7Q+nDpLOlOAEb0Z2M8/0g
         Rp7wyrUV+4UpTHrFGnUdYP5MFd90LpYq0gbP8VJU4WMwITtdaKTEkHFacJB6RnM7aJcL
         36NVubyUa8nk78PIjrRyID0FDyoN0yLiOqJq1Do+CdQ7dqc0asar6Tq/Q7bBCmn+yQyG
         qxMrOkcO5SX6TA/87a9onUpW4reQdvkECPDRuPr5s8kSMG3rI4QFjfCkce4lWSkWwGZu
         MkauZsDxdZsFEj9cNG8UkgEQeSk1M2ZXOWL2DoikOXAEezK8AqStJxfWMjjPqpJXAnMD
         gStw==
X-Forwarded-Encrypted: i=1; AFNElJ8qAqBctLKD7WejhE0py6njmLZKnCmSQs30Qdv7RSWNnGAKn1MyGAYMdY+nsJW2XnqPFjAK7tPW+s5M@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNdK0smlL/PLEvW3PsnwvZnHUzsLVN4701DRlofJm/CBbv5nZ
	U6ApGeoTbtDMbQK2Ma8IHE2zHzz8LZsbmdyhHPJQDj36yETnDOTcdM6h
X-Gm-Gg: Acq92OFLSZXhruGTZvRLq/0lw1RmUMTiDe0MxuBb6UTIMYME+HYHs9icgH/51amwkt4
	TltIAMhV4JHPfCBABMdpWN8xfm+iLgHljmZrIy1fuJAzg3oAav8AYn/GAsLcoFmVFlBuQg6YCy7
	hHJa/Rj8U/jdKz0ygckTv7PKbi3VWdA7qmZa+/ONP/Pzx+pr/IT0mGt9apseUCGOZCUDx9XYI8w
	hzfHLfDzdQDpa0u+IkzuDxjj761kKUNj9Bzt27QnV54aor13ysqjsZ75InDf55DgBDmXDRO/tk2
	9PMWsYlwDxaAZqT7HLvydogj5kF3f407txmlGzOamnFslBlB1eoZ4A3lXujdkYsvJ9mxOB96GXF
	tI2ucA/vxl063+o1cao7+tN7YUiSYOYTDTByYQMh6uPMP85HD9bJYLr95ULfzZMsjN1r9XA5M14
	d9gJ/7aXOJNiPJGeFNd4YK1ehxRZLunScSrubHBby24dShF93f
X-Received: by 2002:a05:6a20:4328:b0:3a2:cf6d:aa04 with SMTP id adf61e73a8af0-3b0bdd00bfbmr25707703637.8.1779266562681;
        Wed, 20 May 2026 01:42:42 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb123986sm20808751a12.32.2026.05.20.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:42:42 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6] rds: filter RDS_INFO_* getsockopt by caller's netns
Date: Wed, 20 May 2026 16:42:36 +0800
Message-Id: <20260520084236.2724349-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21027-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2A8B958A08F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RDS_INFO_* family of getsockopt(2) options reads several
file-scope global lists that are not per-netns:

  rds_sock_info / rds6_sock_info,
  rds_sock_inc_info / rds6_sock_inc_info        -> rds_sock_list
  rds_tcp_tc_info / rds6_tcp_tc_info            -> rds_tcp_tc_list
  rds_conn_info / rds6_conn_info,
  rds_conn_message_info_cmn (for the *_SEND_MESSAGES and
  *_RETRANS_MESSAGES variants),
  rds_for_each_conn_info (for RDS_INFO_IB_CONNECTIONS)
                                                -> rds_conn_hash[]

The handlers do not filter by the caller's network namespace.
rds_info_getsockopt() has no netns or capable() check, and
rds_create() has no capable() check, so AF_RDS is reachable from
an unprivileged user namespace. As a result, an unprivileged
caller in a fresh user_ns plus netns can read the bound address
and sock inode of every RDS socket on the host, the peer address
of incoming messages on every RDS socket on the host, the peer
address and TCP sequence numbers of every rds-tcp connection on
the host, and the peer address and RDS sequence numbers of every
RDS connection on the host.

The rds-tcp transport is reachable from a non-initial netns (see
rds_set_transport()), so a one-shot init_net gate at
rds_info_getsockopt() would deny legitimate per-netns visibility
to rds-tcp callers. Instead, filter at each handler by comparing
the netns of the caller's socket to the netns of the list entry,
or to rds_conn_net(conn) for connection paths. Only copy entries
whose netns matches the caller. Counters (RDS_INFO_COUNTERS) are
aggregate statistics and remain global.

Reproducer (KASAN VM, rds and rds_tcp loaded): an AF_RDS socket
binds 127.0.0.1:4242 in init_net as root. A child process enters
a fresh user_ns plus netns and opens AF_RDS there, then calls
getsockopt(SOL_RDS, RDS_INFO_SOCKETS). Before this change, the
child sees the init_net socket. After this change, the child
sees zero entries.

Drop the rds_sock_count, rds_tcp_tc_count, and rds6_tcp_tc_count
globals. v2 used them for the size precheck and lens->nr; v3
replaced the precheck with a per-ns count from a first pass over
the list, so the globals have no remaining readers. The matching
increments and decrements in rds_create()/rds_destroy_sock() and
rds_tcp_set_callbacks()/rds_tcp_restore_callbacks() go away with
them. Reported by the kernel test robot under clang W=1.

Suggested-by: Allison Henderson <achender@kernel.org>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v6: Rebased on current net main tip (dc416e32baae) after Jakub
    pw-bot:cr on v5. The patch failed to apply at net/rds/tcp.c:201
    because the separately submitted "rds_tcp: close NULL deref
    window in rds_tcp_set_callbacks" patch landed in net main
    between v5 and v6. That commit reorders tc->t_sock = sock
    inside the rds_tcp_tc_list_lock and adds a comment block.
    The 3-way merge preserves both changes. No functional change
    in the netns filter behaviour relative to v5.
v5: Address Simon Horman's review of v4. rds_bind() writes
    rs_bound_addr without holding rds_sock_lock (bind.c:123,
    138, 160). rds_sock_info() holds rds_sock_lock across the
    two passes, but a concurrent rds_bind() can still change
    rs_bound_addr between them. The second pass can then match
    an entry the first pass did not count. For a len=0 probe
    with cnt=0, this reaches iter->pages while the buffer is
    still empty.
    Cap the second pass at the cnt from the first pass
    (if (copied >= cnt) break). The cap goes in all four
    handlers: rds_sock_info, rds6_sock_info, rds_tcp_tc_info,
    and rds6_tcp_tc_info.
    The reverse case is also handled. If pass2 copies fewer
    entries than cnt because of a concurrent rds_remove_bound(),
    set cnt = copied before the out: label. lens->nr then
    reports what was actually written.
v4: Drop the rds_sock_count, rds_tcp_tc_count, and rds6_tcp_tc_count
    globals reported by the kernel test robot under clang W=1
    (-Wunused-but-set-global). They have no remaining readers after v3
    replaced the size precheck with a per-ns count from the first pass.
    Inc/dec sites in rds_create()/rds_destroy_sock() and
    rds_tcp_set_callbacks()/rds_tcp_restore_callbacks() are removed
    with them. No functional change beyond v3 for the netns-filter
    behaviour.

    Note for applier: this patch touches rds_tcp_set_callbacks() in the
    same hunk window as a separate [PATCH net] sent earlier (Message-Id
    <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>, "rds_tcp: close
    NULL deref window in rds_tcp_set_callbacks"). Both apply cleanly
    to net/main tip b266bacba in isolation. When applied together the
    second one needs a trivial 3-way merge in net/rds/tcp.c.
v3: Address Simon Horman's review of v2. The size precheck and the
    lens count are now both restricted to the caller's netns in
    rds_sock_info, rds6_sock_info, rds_tcp_tc_info and
    rds6_tcp_tc_info. Each handler now does a first pass under the
    list lock to count entries visible in the caller's netns, then
    short-circuits with that count if the user buffer is too small,
    then a second pass to fill data. This closes both issues Simon
    flagged: a zero-length probe no longer returns the global count,
    and a caller that sizes its buffer to the value returned by lens
    no longer hits ENOSPC on the second call.
    Re-verified on KASAN VM with the v1 PoC: attacker in fresh
    user_ns + netns sees zero RDS_INFO_SOCKETS entries; init_net
    access sees its own entries; lens returns the ns-scoped count
    on both probe and full reads.
v2: rebased onto net/main tip (b266bacba) so patchwork can apply.
    No code changes. Carries forward Reviewed-by from v1 review.
v1: https://lore.kernel.org/r/20260506075031.2238596-1-maoyixie.tju@gmail.com


 net/rds/af_rds.c     | 59 ++++++++++++++++++++++++++++++++++++++++-------
 net/rds/connection.c | 13 +++++++++++
 net/rds/tcp.c        | 63 ++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 104 insertions(+), 31 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 76f625986a7f2..bd6271bab32cc 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -43,7 +43,6 @@
 
 /* this is just used for stats gathering :/ */
 static DEFINE_SPINLOCK(rds_sock_lock);
-static unsigned long rds_sock_count;
 static LIST_HEAD(rds_sock_list);
 DECLARE_WAIT_QUEUE_HEAD(rds_poll_waitq);
 
@@ -82,7 +81,6 @@ static int rds_release(struct socket *sock)
 
 	spin_lock_bh(&rds_sock_lock);
 	list_del_init(&rs->rs_item);
-	rds_sock_count--;
 	spin_unlock_bh(&rds_sock_lock);
 
 	rds_trans_put(rs->rs_transport);
@@ -694,7 +692,6 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
 
 	spin_lock_bh(&rds_sock_lock);
 	list_add_tail(&rs->rs_item, &rds_sock_list);
-	rds_sock_count++;
 	spin_unlock_bh(&rds_sock_lock);
 
 	return 0;
@@ -735,6 +732,7 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 			      struct rds_info_iterator *iter,
 			      struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_sock *rs;
 	struct rds_incoming *inc;
 	unsigned int total = 0;
@@ -744,6 +742,9 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -774,6 +775,7 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 			       struct rds_info_iterator *iter,
 			       struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_incoming *inc;
 	unsigned int total = 0;
 	struct rds_sock *rs;
@@ -783,6 +785,9 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		read_lock(&rs->rs_recv_lock);
 
 		list_for_each_entry(inc, &rs->rs_recv_queue, i_item) {
@@ -806,20 +811,34 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_info_socket sinfo;
 	unsigned int cnt = 0;
+	unsigned int copied = 0;
 	struct rds_sock *rs;
 
 	len /= sizeof(struct rds_info_socket);
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count) {
-		cnt = rds_sock_count;
-		goto out;
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
+			continue;
+		cnt++;
 	}
 
+	if (len < cnt)
+		goto out;
+
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (copied >= cnt)
+			break;
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -832,8 +851,13 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 		sinfo.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo, sizeof(sinfo));
-		cnt++;
+		copied++;
 	}
+	/* A concurrent rds_bind() can change rs_bound_addr between the
+	 * two passes without holding rds_sock_lock, so copied may be
+	 * less than cnt. Report what was actually copied.
+	 */
+	cnt = copied;
 
 out:
 	lens->nr = cnt;
@@ -847,17 +871,32 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 			   struct rds_info_iterator *iter,
 			   struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_socket sinfo6;
+	unsigned int cnt = 0;
+	unsigned int copied = 0;
 	struct rds_sock *rs;
 
 	len /= sizeof(struct rds6_info_socket);
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		cnt++;
+	}
+
+	if (len < cnt)
 		goto out;
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (copied >= cnt)
+			break;
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		sinfo6.sndbuf = rds_sk_sndbuf(rs);
 		sinfo6.rcvbuf = rds_sk_rcvbuf(rs);
 		sinfo6.bound_addr = rs->rs_bound_addr;
@@ -867,10 +906,12 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 		sinfo6.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo6, sizeof(sinfo6));
+		copied++;
 	}
+	cnt = copied;
 
  out:
-	lens->nr = rds_sock_count;
+	lens->nr = cnt;
 	lens->each = sizeof(struct rds6_info_socket);
 
 	spin_unlock_bh(&rds_sock_lock);
diff --git a/net/rds/connection.c b/net/rds/connection.c
index c10b7ed06c49f..7c8ab8e973e1b 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -568,6 +568,7 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 				      struct rds_info_lengths *lens,
 				      int want_send, bool isv6)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct list_head *list;
 	struct rds_connection *conn;
@@ -590,6 +591,9 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 			struct rds_conn_path *cp;
 			int npaths;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 			if (!isv6 && conn->c_isv6)
 				continue;
 
@@ -688,6 +692,7 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 			  u64 *buffer,
 			  size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -700,6 +705,9 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	for (i = 0, head = rds_conn_hash; i < ARRAY_SIZE(rds_conn_hash);
 	     i++, head++) {
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 
 			/* Zero the per-item buffer before handing it to the
 			 * visitor so any field the visitor does not write -
@@ -733,6 +741,7 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    u64 *buffer,
 				    size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -747,6 +756,10 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
 			struct rds_conn_path *cp;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
+
 			/* XXX We only copy the information from the first
 			 * path for now.  The problem is that if there are
 			 * more than one underlying paths, we cannot report
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 5830b31a1f37b..fbaf150e3edaa 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -46,14 +46,6 @@
 static DEFINE_SPINLOCK(rds_tcp_tc_list_lock);
 static LIST_HEAD(rds_tcp_tc_list);
 
-/* rds_tcp_tc_count counts only IPv4 connections.
- * rds6_tcp_tc_count counts both IPv4 and IPv6 connections.
- */
-static unsigned int rds_tcp_tc_count;
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int rds6_tcp_tc_count;
-#endif
-
 /* Track rds_tcp_connection structs so they can be cleaned up */
 static DEFINE_SPINLOCK(rds_tcp_conn_lock);
 static LIST_HEAD(rds_tcp_conn_list);
@@ -110,11 +102,6 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 	/* done under the callback_lock to serialize with write_space */
 	spin_lock(&rds_tcp_tc_list_lock);
 	list_del_init(&tc->t_list_item);
-#if IS_ENABLED(CONFIG_IPV6)
-	rds6_tcp_tc_count--;
-#endif
-	if (!tc->t_cpath->cp_conn->c_isv6)
-		rds_tcp_tc_count--;
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	tc->t_sock = NULL;
@@ -206,11 +193,6 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	spin_lock(&rds_tcp_tc_list_lock);
 	tc->t_sock = sock;
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
-#if IS_ENABLED(CONFIG_IPV6)
-	rds6_tcp_tc_count++;
-#endif
-	if (!tc->t_cpath->cp_conn->c_isv6)
-		rds_tcp_tc_count++;
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	/* accepted sockets need our listen data ready undone */
@@ -238,20 +220,37 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 			    struct rds_info_iterator *iter,
 			    struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(rds_sock->sk);
 	struct rds_info_tcp_socket tsinfo;
 	struct rds_tcp_connection *tc;
+	unsigned int cnt = 0;
+	unsigned int copied = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo) < rds_tcp_tc_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (tc->t_cpath->cp_conn->c_isv6)
+			continue;
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct inet_sock *inet = inet_sk(tc->t_sock->sk);
 
+		if (copied >= cnt)
+			break;
 		if (tc->t_cpath->cp_conn->c_isv6)
 			continue;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
 
 		tsinfo.local_addr = inet->inet_saddr;
 		tsinfo.local_port = inet->inet_sport;
@@ -266,10 +265,12 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 		tsinfo.tos = tc->t_cpath->cp_conn->c_tos;
 
 		rds_info_copy(iter, &tsinfo, sizeof(tsinfo));
+		copied++;
 	}
+	cnt = copied;
 
 out:
-	lens->nr = rds_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
@@ -284,19 +285,35 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 			     struct rds_info_iterator *iter,
 			     struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_tcp_socket tsinfo6;
 	struct rds_tcp_connection *tc;
+	unsigned int cnt = 0;
+	unsigned int copied = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo6) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct sock *sk = tc->t_sock->sk;
 		struct inet_sock *inet = inet_sk(sk);
 
+		if (copied >= cnt)
+			break;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+
 		tsinfo6.local_addr = sk->sk_v6_rcv_saddr;
 		tsinfo6.local_port = inet->inet_sport;
 		tsinfo6.peer_addr = sk->sk_v6_daddr;
@@ -309,10 +326,12 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 		tsinfo6.last_seen_una = tc->t_last_seen_una;
 
 		rds_info_copy(iter, &tsinfo6, sizeof(tsinfo6));
+		copied++;
 	}
+	cnt = copied;
 
 out:
-	lens->nr = rds6_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo6);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);

-- 
2.34.1

