Return-Path: <linux-rdma+bounces-16281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEVGEXtafWmBRgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:27:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A79C0002
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B68F305A6D1
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A933344A;
	Sat, 31 Jan 2026 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwUf1FEI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2550332EB2;
	Sat, 31 Jan 2026 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822714; cv=none; b=XpW7S6QainyO67mNqDYS8F94AyJJIA9fmy7ZWMxGPG3lowkm5Hg8N56w0CAfSikXXy+nGqKBy6YxTy85CAEW4SW/T2H+spOC1YJGuaq+FORRP8i//ppt1gnjFf9reKMIBvMXX5glYNt4u3Qiq50ZEnj4hVuW1JXkbESqSbVpjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822714; c=relaxed/simple;
	bh=XF3PnTyfc5GwHPaet2xCoZvmuThE0jpuwAa2XRqdpf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkoI1m397g29XFNAK0YWnl8XAh50SM6F1sfbtO3u0yO3tdBUWbipJ35Bq/6rLgWx/WoH2PpMu47/De1zlFJekYUwRET3QhsPMB2D22K3dmmCrW6/79kNYpcFNgso/BSNKffvpBak52hwup+hnEIPdHXzimjjAyxerSCMsmHNtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwUf1FEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FA3C116C6;
	Sat, 31 Jan 2026 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822714;
	bh=XF3PnTyfc5GwHPaet2xCoZvmuThE0jpuwAa2XRqdpf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwUf1FEISQ9L2ZkPe9LTebj+85FY/LI/8iH80GRWyhDiQrJjllrZUliCXl4/Yava/
	 FbelDOBa0zvtyz5SVmNDIKyC35YE0SM7L6MGJzz/LlVTdzC3gwMiQcvZMzW0szHCwL
	 nZ2tc2/deb4kNp8L54+MbC8FHph2XV3l/8aTIu+VSMG8tzNT722GLRt612FQ3kptmL
	 pg2j3+M0hzPWIFZk5jNGPKYb1p2YuLcRH8+MmjsW+LUzGsgZI8LKOu+XRAgPMowwzI
	 lYDaQH6wPYqIv/4Y8Z6lBWgAUgONCldRLWg2C5t4ilx8xLh2eDctWgWmjPuzVUhlmL
	 L1VaLz+DuQZ1g==
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
Subject: [PATCH net-next v4 6/8] net/rds: Update struct rds_statistics to use u64 instead of uint64_t
Date: Fri, 30 Jan 2026 18:25:05 -0700
Message-ID: <20260131012507.814119-7-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16281-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: D0A79C0002
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


