Return-Path: <linux-rdma+bounces-15961-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHtkN2DBdWmBIQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15961-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:08:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 978737FF42
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7E730031C3
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE17318BA9;
	Sun, 25 Jan 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcwWrCEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1983168F2;
	Sun, 25 Jan 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769324817; cv=none; b=UhZeVwRrPV9Vz8dO7rt0CS0UrJtIYXXTwc+jlfN+ZJrW1pkvHrR7YgzaZK0JSrxRQXtMEtg3g7ACAhye00RWDcPWshr0UIeUYsRi8BGumHrALJIoHH9EqsgdAFbzJqbUz3TY79hLDoyqBUdtBqZdiLKwXDb4w3beGY+xQXO4TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769324817; c=relaxed/simple;
	bh=EIJL8pG/PcTFn67yB8uBKqA69i6bBObn1bVTB5MTFdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQw2mHJl/ywwUkIjXMQ9qiLONMq2x1Tx07gXMdCtrpkZ7D4kcYFZPOYR4qCupVMUecUqOsUyvYUeuFrJHPQBc0WYs+zij+Zb6NnXVByKIgDA7W5zYuajMaTisG7mBaL7l2gkNmF5QHCRKCzZhd6A4vYJYEjvLtcJMK7Bzqi0nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcwWrCEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F302C116C6;
	Sun, 25 Jan 2026 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769324817;
	bh=EIJL8pG/PcTFn67yB8uBKqA69i6bBObn1bVTB5MTFdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcwWrCElVo9rTGPrC922nqYgAZkNhY7pcjs4gSAX9ydHmuPKC4VlBzayAODWFDYSM
	 Qk6L5AQAAdWBre4G5VazT1aemjyTc4pBlpIgMaVrlYnloPhYFVHWvybRW84vJRTubV
	 sBuUNsPQ/LkPLLvSKNKx7L/jgcpmpmBIt1SEYnxAOfeR4gX5lRzxiY8HSLuZkTKoc9
	 2bj16IITA6bJ5LAztOyZVKOd/utnmTv7EG8pgEdu5+X4XBAFcufzRCwUrtiC21fNd3
	 RUevxbYq/UWKYZ5HQw99Aah4OQkIJPkT7Ol4qcW0h64tD4n0HuxKinQvONnjDA2w3h
	 pHlQLcs0asGdA==
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
Subject: [PATCH net-next v1 5/7] net/rds: Clear reconnect pending bit
Date: Sun, 25 Jan 2026 00:06:49 -0700
Message-ID: <20260125070651.207042-6-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125070651.207042-1-achender@kernel.org>
References: <20260125070651.207042-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15961-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 978737FF42
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
index 3f26a67f31804..4b7715eb2111c 100644
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


