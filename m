Return-Path: <linux-rdma+bounces-16279-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GYAA05afWmBRgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16279-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:26:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93EBFFD7
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421C1304D971
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 01:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64633121F;
	Sat, 31 Jan 2026 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luLlsLUP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588B318146;
	Sat, 31 Jan 2026 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822713; cv=none; b=NZXvV3qihq9VR0+JiuKqC9W8PdkmnKsuqzCwtvWh+PK3L+vFZYD/dKiBaxuQmCgutygkbLqn507qnDU0vr0yLuCvkIJ+5Hk8VxdWcXkFmXeQIW2pxySlwpYZ0Agg0g+Ttqwun8Wqu7RAdHFz2kKZvz+PS+X/0X8Vx9a5XRaMpBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822713; c=relaxed/simple;
	bh=h4t6CKlu7x8fZ7JonwTHLu30EuoT2G+8oJphjmZ0WHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRM0jdOj+Bfi9cz/2d5uLGE5q75hdhjFNkf5NWWwZPHaQNVoQSsK4H0ejfrC/fHDKOpu3q3xtF+lforMgafW58xY6Sex+gmkPgrrTv+4S+vRFBxnmyVJvLgDGjpajBvDx7AnpWfUccgHXQjIzosW1qkPF1Zrm3xqKP4k0u6fXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luLlsLUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B912C19425;
	Sat, 31 Jan 2026 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822713;
	bh=h4t6CKlu7x8fZ7JonwTHLu30EuoT2G+8oJphjmZ0WHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luLlsLUPqrtCnCtCWUPKI4SYUNY9N1HRgcxPba7w3+Pw0L4H8WN8+HxVew6f4oehL
	 0s+4oLvXvFzfWLjmIN3HTHcFtvMrSn6SYVMg66DgQoHF0jE8Qfvk19VEyDPi/4zokK
	 rcTGDgqncPP3kC1lJMriCo0qdkrGWsMtJBSs52wg7R8zV+51iQacndAmT1hPkzBVaO
	 MxqmrmF5VJgtTIkd7JFynzWmXCm8eZWqbC4IwZ0zHW1p1/pV9cWUSCfjmwHhSvXrUr
	 V+3+ySC7+ikuQ7JGHst0dBw2id8kYs5qM3GDlwhOUWwHc+NmkEjfPrt9hlEf04xQhZ
	 0CbPlfjmW4tIQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v4 4/8] net/rds: Kick-start TCP receiver after accept
Date: Fri, 30 Jan 2026 18:25:03 -0700
Message-ID: <20260131012507.814119-5-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131012507.814119-1-achender@kernel.org>
References: <20260131012507.814119-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16279-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 7E93EBFFD7
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

In cases where the server (the node with the higher IP-address)
in an RDS/TCP connection is overwhelmed it is possible that the
socket that was just accepted is chock-full of messages, up to
the limit of what the socket receive buffer permits.

Subsequently, "rds_tcp_data_ready" won't be called anymore,
because there is no more space to receive additional messages.

Nor was it called prior to the point of calling "rds_tcp_set_callbacks",
because the "sk_data_ready" pointer didn't even point to
"rds_tcp_data_ready" yet.

We fix this by simply kick-starting the receive-worker
for all cases where the socket state is neither
"TCP_CLOSE_WAIT" nor "TCP_CLOSE".

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 492dcc6568bf..b5786227623c 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -291,6 +291,8 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 	    new_sock->sk->sk_state == TCP_LAST_ACK ||
 	    new_sock->sk->sk_state == TCP_CLOSE)
 		rds_conn_path_drop(cp, 0);
+	else
+		queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 
 	new_sock = NULL;
 	ret = 0;
-- 
2.43.0


