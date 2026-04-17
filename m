Return-Path: <linux-rdma+bounces-19411-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPHrD3NC4mlh4AAAu9opvQ
	(envelope-from <linux-rdma+bounces-19411-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 16:23:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E1241C004
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D743049292
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C13AD502;
	Fri, 17 Apr 2026 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDHgDUaB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF683ACA5D
	for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435571; cv=none; b=NlDgHx9Ao1i7J+/QIHWw+rVHy1OEhaqYXgh+Uc8l08+gUOMCvpLz0zUujMXwsBMUf34m0dw2uacCt9u426Zeo7lr/AbBkApmNTxjk9UD/bRg2thCQnwn4+WxfNkXb2IPZq0dNrj0/V29WQ43SjF/a0siTlK8O48+G21jrb6Yljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435571; c=relaxed/simple;
	bh=ZlvQik8s0fGgOwMLxcaH7L+q0Axcry6zpYxcKJ8NclE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxDGZwu8nEz5W5xyyzuWdDdfA2oB9pu+nRlfox1FDRtP7ZR5ImzkUfKXnSkmeP2EI3vFJCWGd657ysv5VDsDbJOy+ZFM/pEGmDT6pl/Q7jf1ORowDdfE15yBOqAGUvBF21Ms6DDr8+oorzf09ZwznESchCHXxLpd/YK6mXCeZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDHgDUaB; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso4472666d6.1
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2026 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435566; x=1777040366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKUMg6aZSBP+/AxTkMlkdmtJNfbxujumsmere2O+qGA=;
        b=UDHgDUaBg+4EE00E4WlzuPXIr1lnzKjrbIEFVZtDT6DiaDxmeDKXZdKSXZBJ3bAL0R
         9TC3bu82mCHDzksbqOwbhmrAIUQdtd5sfBHN2xRGHYkkL8dyoAlfw1Fs6bJNsSBFlB+R
         fZHSUw+eXcCNWYbQq3v2/0+J1P6pMyGQQShSj1FvN4tM+tTpeihWHMChEf5qnTzjKlHG
         uJzVJWQZQYhPlhJqkaspv+AZTQRFiaeIiRazwvf7Ui9pLUgWKvsxUERF8kA30sQ96DiU
         XCqp0tWoQ+Lv0VZyUphM4kwFz5D+myaab869rn4SKS7uhZKBh0VKjxBk65LnAZSxyNvb
         W7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435566; x=1777040366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKUMg6aZSBP+/AxTkMlkdmtJNfbxujumsmere2O+qGA=;
        b=i00iJu1782TmYn2GyJ+nrUYBJpkRTnLvbwjJo2ODrWLWmON3KvDGtXx5Zo2xZaW+Ng
         CS6M6lSedLPd4GtGyKltz2410+JyCLR8z/tF2F67QUkY6coKHRTZ0ieRiYPdWIxBbQn6
         ImDCd9EuePL+1Fd4BxRRPOalizPEgmgwa1Kexhy3UUahpz1Ubb/CEj00HOzboSEu0wix
         q87qbrWlQUrxXINkDyTNYx5q3sB94+/99guv3Jdk86yuBT91edjFaxfnQd0enVL34imj
         fRcEQZVYbMXLayK8qz69X1awqfHPKOV9YfDuBQfR2NWXqojovMSmGAnKPILHaQQEmNTJ
         7mEg==
X-Forwarded-Encrypted: i=1; AFNElJ9LxhjrYnjIYcStGswub7F3PpBeh0kJ7PdUKC9sHFZc0bHAkX8tTyL5bShdfH3fPyx4FKwDwazoupKM@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBPr6HP1GRNCCQcPnKUmu8IBwJFpvw/e4+Yxh8WyftgeLrBYs
	JLR8kwOTxO4+QPRueL2zaTV4WmaGdyMJ7qGD/e8uknEVy+8B0tP6FmTe
X-Gm-Gg: AeBDievqUH+BlPlOkO1Qcb++S0+zhDHTBjhNGfYwJG1J3LS3YU2Vff3UYJEWktLA7Hk
	h83WN8YgR9SJZEHMA9sMSMhZf4B9jaKIGiSgdpelXU++oQ2ln6XVIAl02Ouk7YUVT8a9VLVZe6z
	pfqVRb4pBStDjod4ldT4AUP3L1EvS9CxD+i7g8yFuXfu/fUQuxxHiFkRxvkoLlTJp4qI2WED/4N
	q36uowLpuyi2I31Rl6kNjwxgW8QvjrXhivqLhQ8YC58x7i3m/hljQKBjBU+OuU27mVPTgC1k/xf
	THstI22Y+jEzdWXquVMc90VoMYvkn6tJZ+3E2VaY9XYA8JMVneVR0DPmMivlid1tS8Lh3uy7pHE
	gHrpOS1oSY1FJuxeOyO7Z+zzQfvFn/n+E5enP62WUD4BPEi07Ao5S5AAXXNvYhQWeS7Hx3Y3Mg0
	dzmDE13n53XvNE30vUbfFsnWrlmB3ly+lzvBAb1qA9HSztJtVqJp9ds5iojBQj9MmwpUDX8zT4V
	M6wi+c3mPhc1Gb0alz/TDS7ySewfPd7dZnWLoCSXbgtZosthmgKoQ==
X-Received: by 2002:ad4:5f8e:0:b0:8a3:6f43:c78a with SMTP id 6a1803df08f44-8b02812da1fmr51027316d6.39.1776435566212;
        Fri, 17 Apr 2026 07:19:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae97d89sm11875726d6.42.2026.04.17.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:19:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH] rds: zero per-item info buffer before handing it to visitors
Date: Fri, 17 Apr 2026 10:19:16 -0400
Message-ID: <20260417141916.494761-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19411-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,oss.oracle.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3E1241C004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yet another from my "clanker."  This only applies to people who
don't use CONFIG_INIT_STACK_ALL_ZERO, but I presume that's
still enough people that it's worth backporting since it can
be chained through leaked addresses to defeat KASLR.

rds_for_each_conn_info() and rds_walk_conn_path_info() both hand a
caller-allocated on-stack u64 buffer to a per-connection visitor and
then copy the full item_len bytes back to user space via
rds_info_copy() regardless of how much of the buffer the visitor
actually wrote.

rds_ib_conn_info_visitor() and rds6_ib_conn_info_visitor() only
write a subset of their output struct when the underlying
rds_connection is not in state RDS_CONN_UP (src/dst addr, tos, sl
and the two GIDs via explicit memsets).  Several u32 fields
(max_send_wr, max_recv_wr, max_send_sge, rdma_mr_max, rdma_mr_size,
cache_allocs) and the 2-byte alignment hole between sl and
cache_allocs remain as whatever stack contents preceded the visitor
call and are then memcpy_to_user()'d out to user space.

struct rds_info_rdma_connection and struct rds6_info_rdma_connection
are the only rds_info_* structs in include/uapi/linux/rds.h that are
not marked __attribute__((packed)), so they have a real alignment
hole.  The other info visitors (rds_conn_info_visitor,
rds6_conn_info_visitor, rds_tcp_tc_info, ...) write all fields of
their packed output struct today and are not known to be vulnerable,
but a future visitor that adds a conditional write-path would have
the same bug.

Reproduction on a kernel built without CONFIG_INIT_STACK_ALL_ZERO=y:
a local unprivileged user opens AF_RDS, sets SO_RDS_TRANSPORT=IB,
binds to a local address on an RDMA-capable netdev (rxe soft-RoCE on
any netdev is sufficient), sendto()'s any peer on the same subnet
(fails cleanly but installs an rds_connection in the global hash in
RDS_CONN_CONNECTING), then calls getsockopt(SOL_RDS,
RDS_INFO_IB_CONNECTIONS).  The returned 68-byte item contains 26
bytes of stack garbage including kernel text/data pointers:

    0..7   0a 63 00 01 0a 63 00 02     src=10.99.0.1 dst=10.99.0.2
    8..39  00 ...                      gids (memset-zeroed)
    40..47 e0 92 a3 81 ff ff ff ff     kernel pointer (max_send_wr)
    48..55 7f 37 b5 81 ff ff ff ff     kernel pointer (rdma_mr_max)
    56..59 01 00 08 00                 rdma_mr_size (garbage)
    60..61 00 00                       tos, sl
    62..63 00 00                       alignment padding
    64..67 18 00 00 00                 cache_allocs (garbage)

Fix by zeroing the per-item buffer in both rds_for_each_conn_info()
and rds_walk_conn_path_info() before invoking the visitor.  This
covers the IPv4/IPv6 IB visitors and hardens all current and future
visitors against the same class of bug.

No functional change for visitors that fully populate their output.

Fixes: ec16227e1414 ("RDS/IB: Infiniband transport")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 net/rds/connection.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 412441aaa298..c10b7ed06c49 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -701,6 +701,13 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	     i++, head++) {
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
 
+			/* Zero the per-item buffer before handing it to the
+			 * visitor so any field the visitor does not write -
+			 * including implicit alignment padding - cannot leak
+			 * stack contents to user space via rds_info_copy().
+			 */
+			memset(buffer, 0, item_len);
+
 			/* XXX no c_lock usage.. */
 			if (!visitor(conn, buffer))
 				continue;
@@ -750,6 +757,13 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 			 */
 			cp = conn->c_path;
 
+			/* Zero the per-item buffer for the same reason as
+			 * rds_for_each_conn_info(): any byte the visitor
+			 * does not write (including alignment padding) must
+			 * not leak stack contents via rds_info_copy().
+			 */
+			memset(buffer, 0, item_len);
+
 			/* XXX no cp_lock usage.. */
 			if (!visitor(cp, buffer))
 				continue;
-- 
2.53.0


