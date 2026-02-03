Return-Path: <linux-rdma+bounces-16402-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEMoFHeOgWl/HAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16402-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:58:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0AED4E4A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 276963050908
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E136A024;
	Tue,  3 Feb 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcvHKeQG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79E369207;
	Tue,  3 Feb 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098251; cv=none; b=P6049QmY1jK7BkZEEosIpL/9tJniRuiHmFYXEERBkJ8RZHTZ3kRX9svr6Rp+GTN6HJzKYFbCN6II8jLgsgTgWuskAA0w7qqJ7EOXf5z6UVWG2XHr8NNJwS86VBPuMTxQBnVoJnk3pMLrjdJvGgqvI9bLEm7our0bJxXgr4OuZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098251; c=relaxed/simple;
	bh=YZvCmVjouOSOm1pcxaO24JXHnRqJmdoBqq6+LTkBkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlSatj5Y+qzBuyXfKd4b9x00C8/vPWS7pRwvGonbEs/f1/iR3hBwwX1r8xRKyq8dZKv6K7/iiO3LSZdswqAMKA9JswRfL7dooo+s3t4lgjuhmE9SrAXA59hXyoGmP8l5ty57X5WxiJKT6RipEmA+5z2FlyjACHCYEOJR/QfSscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcvHKeQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7FC16AAE;
	Tue,  3 Feb 2026 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770098251;
	bh=YZvCmVjouOSOm1pcxaO24JXHnRqJmdoBqq6+LTkBkhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcvHKeQGN8bGgwhq8nTrISHWI/tkLliovLF/MV+GWlz/A+3K9jYZBc8J00TCujhFD
	 Pu/hkeOvUvBxdgSzhKqHDN5V3/SpH2wp78rPAXw0xEmiqGEb/DozGZChhJGibs6QIx
	 LzNoo/Ett3ewWtNsZd7mUTS2FgbOpzK0/L+zvstQBdeOD+jAJ4ZOj5crJeSQ/hMExP
	 FT+VhAn4QKhe4XBdH2UBi6LKL2y70eBCuxRJrfY50NGAGNZy6IksGmPAf9e+76wpht
	 oBbaT8yXuEeS+Wme5ODBGbXy+/vX1wO9exTF+qNL58wazPfytDOizAaOxMkUT8ccUJ
	 e4ZTMreqKSi0A==
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
Subject: [PATCH net-next v5 5/8] net/rds: Clear reconnect pending bit
Date: Mon,  2 Feb 2026 22:57:20 -0700
Message-ID: <20260203055723.1085751-6-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203055723.1085751-1-achender@kernel.org>
References: <20260203055723.1085751-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16402-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE0AED4E4A
X-Rspamd-Action: no action

From: Håkon Bugge <haakon.bugge@oracle.com>

When canceling the reconnect worker, care must be taken to reset the
reconnect-pending bit. If the reconnect worker has not yet been
scheduled before it is canceled, the reconnect-pending bit will stay
on forever.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 3f26a67f3180..4b7715eb2111 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -442,6 +442,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	 * to the conn hash, so we never trigger a reconnect on this
 	 * conn - the reconnect is always triggered by the active peer. */
 	cancel_delayed_work_sync(&cp->cp_conn_w);
+
+	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
-- 
2.43.0


