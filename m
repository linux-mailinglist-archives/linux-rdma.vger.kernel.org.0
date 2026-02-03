Return-Path: <linux-rdma+bounces-16403-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL4gJnOOgWl/HAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16403-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:58:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A45D4E31
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4749F301E5D0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A336AB49;
	Tue,  3 Feb 2026 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqpRMl5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460B369979;
	Tue,  3 Feb 2026 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098252; cv=none; b=TmvtpqbG50rDKPxCHu0o7xmERZRwaDxv9GvzwFcBJLcSzv5SsO7a2bE13nIw6Fed/Cnb+8y63HbNF7kXMnXDdcfVSDBsG3DvZoAAALEKaIHxsO+ogIbXB8Jq1zIrROTt6MgE87DQHdMii96sCxv9J7c1MP/d4enS0bWu5qzuxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098252; c=relaxed/simple;
	bh=XF3PnTyfc5GwHPaet2xCoZvmuThE0jpuwAa2XRqdpf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u48IJiEoJw5ZKHfTTgt3t64lcP0ob0RJ4btHXVhbwoEQez9wnTufqWj8y4T4EwzNjb6BAQenwzzZN3eOwnbvB1uiZdS1LdseaB7mgB+QFOq9fq4pOS1OEEarttOV6EE4h9CydkhEqhv8+ocvQYN1mnEUR5wqnBQ6ogGCa+NoPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqpRMl5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8678DC116D0;
	Tue,  3 Feb 2026 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770098252;
	bh=XF3PnTyfc5GwHPaet2xCoZvmuThE0jpuwAa2XRqdpf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqpRMl5yZDysflw0MlT+hll3AvunSxHvTZPU0aYrtDnfGQ+va6ZtY1zGeB6PMebq3
	 pJ9N0JE9gb4+1RihUD4LFb9QtL8jyOiX2BmpkTTafeAOAEdUIuOfQUXUMLQn8vocir
	 oag1U/WS7rLOvGV1Q4UPSnBHju2+p1hqXxMtXaGEPp3UxnF75TfnM0t4KQSZME/0r8
	 1rGfsUqOsm8L/dghgNwFFSCB/KRKFg888NfRNtE2yYxHiO2RCSxLZHvNFeNLa5A2d4
	 VApS9q6JW4s6W8PTH94EcV0cvIV8aCfMj9g6TMPTRjA1FOo5l8/iaCmyHvjrT7M90M
	 jb+ERCswHc+6A==
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
Subject: [PATCH net-next v5 6/8] net/rds: Update struct rds_statistics to use u64 instead of uint64_t
Date: Mon,  2 Feb 2026 22:57:21 -0700
Message-ID: <20260203055723.1085751-7-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203055723.1085751-1-achender@kernel.org>
References: <20260203055723.1085751-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16403-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 84A45D4E31
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


