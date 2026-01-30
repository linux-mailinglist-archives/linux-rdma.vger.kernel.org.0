Return-Path: <linux-rdma+bounces-16226-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDLuHrxlfGk/MQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16226-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:03:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66202B81E5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E08330074AF
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006834FF71;
	Fri, 30 Jan 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY3vZPZ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DE313267;
	Fri, 30 Jan 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760177; cv=none; b=pcyOwCQqQQMKDenIxWOqPKC5wP/CHUaH4FDHrkJTk9wkv1RO6Xn5RkiE0L4iq2jkOdZCyCEV0mJGIZ+Ck7k0LwXe4tna1UhcDFF1YqL67Mjl4WlYvFa/QOxA01EI42SKP4yIK7BvqHYFiH9xVRctwB5J3dO0PR+9Z0U3WJzqM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760177; c=relaxed/simple;
	bh=XF3PnTyfc5GwHPaet2xCoZvmuThE0jpuwAa2XRqdpf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtxfYGjI75DX+ZvWtcd+zDrbq4jhLhncoKC7EdBDiO7hYnovFRh5KDhDg3bUp/5Rrwp5Ij9cO9zTRVvXc/wSxNKfue3HK4ta363clGcJ1RtYEUlBxvE4CY/XiJ9czESls8QHbvYtA75HOV6DzIacA/pcAgOGr3B0mi93AStQ+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY3vZPZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4A8C4CEF7;
	Fri, 30 Jan 2026 08:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769760177;
	bh=XF3PnTyfc5GwHPaet2xCoZvmuThE0jpuwAa2XRqdpf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qY3vZPZ+RhODMGp7DUXBHq8KvjHG1xYQ7IXuc8WQXf1NIl4EGZekAv6RIO62nGR8B
	 Qf6wmVAYLX3OvDTW0Q2JBy7QfgvdS0LmW+pUHI9K9WrHeKFIyrizqXBlSIhMMKzGm1
	 7N5hZ2DVJ5JJAXriQlMm5DPPLg2GVLDprhkQsr1VGPyJ7EFFl1R1V1kAcCWNCjbwz1
	 GyW/KrLPAZTstwFIdnDcYhlv40Q9BpGtZoXcdhgbdthfPZvl48VSysuTlwMIMn4Zzq
	 XUXdmMH1ifhPaR+Hy+odU2Rvgk1vsbdn2+2A+JccBAo8dkXDyJ5dcLBv+rVDSSfb/i
	 zokR4x2sxkhEQ==
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
Subject: [PATCH net-next v3 6/8] net/rds: Update struct rds_statistics to use u64 instead of uint64_t
Date: Fri, 30 Jan 2026 01:02:48 -0700
Message-ID: <20260130080250.696575-7-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130080250.696575-1-achender@kernel.org>
References: <20260130080250.696575-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16226-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 66202B81E5
X-Rspamd-Action: no action

From: Allison Henderson <allison.henderson@oracle.com>

Quick clean up to avoid checkpatch errors when adding members to
this struct (Prefer kernel type 'u64' over 'uint64_t').
No functional changes added.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/rds.h | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index 5b5fb53b1fc5..333065a051ea 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -713,42 +713,42 @@ static inline int rds_sk_rcvbuf(struct rds_sock *rs)
 }
 
 struct rds_statistics {
-	uint64_t	s_conn_reset;
-	uint64_t	s_recv_drop_bad_checksum;
-	uint64_t	s_recv_drop_old_seq;
-	uint64_t	s_recv_drop_no_sock;
-	uint64_t	s_recv_drop_dead_sock;
-	uint64_t	s_recv_deliver_raced;
-	uint64_t	s_recv_delivered;
-	uint64_t	s_recv_queued;
-	uint64_t	s_recv_immediate_retry;
-	uint64_t	s_recv_delayed_retry;
-	uint64_t	s_recv_ack_required;
-	uint64_t	s_recv_rdma_bytes;
-	uint64_t	s_recv_ping;
-	uint64_t	s_send_queue_empty;
-	uint64_t	s_send_queue_full;
-	uint64_t	s_send_lock_contention;
-	uint64_t	s_send_lock_queue_raced;
-	uint64_t	s_send_immediate_retry;
-	uint64_t	s_send_delayed_retry;
-	uint64_t	s_send_drop_acked;
-	uint64_t	s_send_ack_required;
-	uint64_t	s_send_queued;
-	uint64_t	s_send_rdma;
-	uint64_t	s_send_rdma_bytes;
-	uint64_t	s_send_pong;
-	uint64_t	s_page_remainder_hit;
-	uint64_t	s_page_remainder_miss;
-	uint64_t	s_copy_to_user;
-	uint64_t	s_copy_from_user;
-	uint64_t	s_cong_update_queued;
-	uint64_t	s_cong_update_received;
-	uint64_t	s_cong_send_error;
-	uint64_t	s_cong_send_blocked;
-	uint64_t	s_recv_bytes_added_to_socket;
-	uint64_t	s_recv_bytes_removed_from_socket;
-	uint64_t	s_send_stuck_rm;
+	u64	s_conn_reset;
+	u64	s_recv_drop_bad_checksum;
+	u64	s_recv_drop_old_seq;
+	u64	s_recv_drop_no_sock;
+	u64	s_recv_drop_dead_sock;
+	u64	s_recv_deliver_raced;
+	u64	s_recv_delivered;
+	u64	s_recv_queued;
+	u64	s_recv_immediate_retry;
+	u64	s_recv_delayed_retry;
+	u64	s_recv_ack_required;
+	u64	s_recv_rdma_bytes;
+	u64	s_recv_ping;
+	u64	s_send_queue_empty;
+	u64	s_send_queue_full;
+	u64	s_send_lock_contention;
+	u64	s_send_lock_queue_raced;
+	u64	s_send_immediate_retry;
+	u64	s_send_delayed_retry;
+	u64	s_send_drop_acked;
+	u64	s_send_ack_required;
+	u64	s_send_queued;
+	u64	s_send_rdma;
+	u64	s_send_rdma_bytes;
+	u64	s_send_pong;
+	u64	s_page_remainder_hit;
+	u64	s_page_remainder_miss;
+	u64	s_copy_to_user;
+	u64	s_copy_from_user;
+	u64	s_cong_update_queued;
+	u64	s_cong_update_received;
+	u64	s_cong_send_error;
+	u64	s_cong_send_blocked;
+	u64	s_recv_bytes_added_to_socket;
+	u64	s_recv_bytes_removed_from_socket;
+	u64	s_send_stuck_rm;
 };
 
 /* af_rds.c */
-- 
2.43.0


