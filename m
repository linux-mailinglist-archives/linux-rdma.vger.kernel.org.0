Return-Path: <linux-rdma+bounces-19422-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4qGTMRGR42mvIgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19422-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 16:11:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39F421494
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ACCD300AB30
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7313386C1A;
	Sat, 18 Apr 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZyEL/1F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2F386C07
	for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521484; cv=none; b=swWFuCad/OWmXeRWkafY5qAy66J0gm47pOgEeB6XEffKRYtP3J8WeEQyg6Wo7jxz4xd+ziGd1pFSXj6nrGnlxxK6OsHeOwzmQQSkZ4iyWHrqhoRlz1TsO3OzaX50NQfOW2SrWy2bKDsjgeXp2RuqgtiTEGS/9wXrRCKspW3Tujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521484; c=relaxed/simple;
	bh=I0az/gxWNWRojxzwlp4c7cgSeHVy/+2ZpNHP43t2+TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfzcDA/ZxgZ27J8IEYquhR6aaHKLaX56FJO/UXKUBZ58h/bCXv0Qju1dabatY+SDkgEwFvbdmXseECSpuxkTxi+a+Vuoyal6L6EFUBP6T2+hP63WtCeRoB76t5SKAnuf0LdRHRk87Q74XkwqE8WtCrszJC8r5iiumCjRzp7YBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZyEL/1F; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb5c9ba82bso303200685a.2
        for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521482; x=1777126282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6smO5yl2bUfwH7kRsW449RY4L+N7gHn/VFYMUm3A7uY=;
        b=eZyEL/1FWlG2DyxEAhqoFgPh5NAQBvm2HH0bBHYA4uCXok3dz/VqXuUnDqMfGoMzeP
         THgHQ0YzKe7ADXAsk7/J70qP5tomDHlEkGMWW9pHqp49/2gwH1c3OssYEgL3gHLG/RhZ
         Zcup9X0pNa5AczOpr11wGTl/6fK7pPpt35/7abdobvuUiob+uF2xOM8AvnFNzexeTNf2
         0xzEOwjjHNIyM2X2nmbLpQYFI0chuklcI5qHwaEbJYVMm/QOPlFXQynSHxOvdX6CyGsg
         yQDROhNBERyb3W/KkkIHIvsIb6jiTTJenRiROrVSy2DfMgq+X2vS+i1hun72plbh3Ppe
         c5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521482; x=1777126282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6smO5yl2bUfwH7kRsW449RY4L+N7gHn/VFYMUm3A7uY=;
        b=VnMlMgRm8GtE9dQYwCBg8ZbwdFvyVFh44lyBeoX14ItqpyrdRm2F/e5sgTkkLMk19O
         BSS32totnwle6lQujw3QqaOf3uPM1D5AJASIgk1wnmzg8nu1w7947xZWZuTqKlXdtRzs
         eCFgb53pcyHhkLmqpVvzQlY7YmG5AAC1pILXDTQ/18iimwTW8e2TSCDnGcLu1IMB2x9u
         6ywk9C+GQM8LEjo5J4pskQnQjMVNlpa6NmJZL2A+lNJCEl9VMqabdvJTAlk3uwMUpDbH
         focP7YIRHZMkrnXNvqpl8z/1RTShKZvwH5qnoJLIoXSIPJczjDlpgnDOPibDUjxNKHqg
         He9Q==
X-Forwarded-Encrypted: i=1; AFNElJ84A9bbTg5V+Cv2HUSY3wTJEO9pLCFRqz2y/XgNZEnh/U8ERqR1YjYtQFWhRjSY0jbtHpPZCDTKYAtd@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEYk9iZSL5WJ9R3wiZPESNUJxCuNghXNmJiTvvogVWQ8osmD1
	Qbcv3Cjp3xl9rmajcyR2LLWA5FhH6kqDqXbL9Lg88Uhenk6Gc02wg4Vm
X-Gm-Gg: AeBDietL8EAc4XGvcjqvy23cJbRX2Me18wDptSlQ+6RooVWNu+FrUq34iJfumfy1o5/
	idN58LqKdk8BmIGkTJncMpEmBDYRSeI4TbMbv9/F6RPKupJlcu+DP0ypJnlCH+hS9cb3x6639VV
	pbu1ig8Cp8wfUBJUDgmacqd+4OWZHt4wPvkDePgsncWEwp6ByOWVjEgHX6MGpsa355cGwOfXolx
	k82dgzz1oy0mH69CM17AVvq+aFbM7mzuG8wkwQ/IxFdg9/w8CrUB6Hjkbi0MRVbEauNzms4CKhL
	nA5ve/HVbBu8kZpSkGZwVK7B0yJWmpIOOkUZ/xH2zKFnHtPuj54VbpiLqYNxiyraFwSVr3jMZfP
	e7WE/F57DzlODRKy6svgncaDDBPixtX2lxxzZ6YBqYijE9A8vLeoEA6/GuCazM0FNclCdOnlRFg
	uKXSnOUzlxatPinNw9VgnQQe7Oh+Jw2D14ipkFaLcKp0lcnXxMSDE2wAYrd3inHo/z7cWEexRDa
	hmCDIMFJdnhzjcAkuoD39jWP8hvsA0=
X-Received: by 2002:a05:620a:469e:b0:8d4:5ae1:633a with SMTP id af79cd13be357-8e791d8710dmr959218385a.42.1776521482156;
        Sat, 18 Apr 2026 07:11:22 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d94d2efcsm350046485a.38.2026.04.18.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sharath Srinivasan <sharath.srinivasan@oracle.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/rds: zero per-item info buffer before handing it to visitors
Date: Sat, 18 Apr 2026 10:10:47 -0400
Message-ID: <20260418141047.3398203-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417141916.494761-1-michael.bommarito@gmail.com>
References: <20260417141916.494761-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19422-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E39F421494
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rds_for_each_conn_info() and rds_walk_conn_path_info() both hand a
caller-allocated on-stack u64 buffer to a per-connection visitor and
then copy the full item_len bytes back to user space via
rds_info_copy() regardless of how much of the buffer the visitor
actually wrote.

rds_ib_conn_info_visitor() and rds6_ib_conn_info_visitor() only
write a subset of their output struct when the underlying
rds_connection is not in state RDS_CONN_UP (src/dst addr, tos, sl
and the two GIDs via explicit memsets). Several u32 fields
(max_send_wr, max_recv_wr, max_send_sge, rdma_mr_max, rdma_mr_size,
cache_allocs) and the 2-byte alignment hole between sl and
cache_allocs remain as whatever stack contents preceded the visitor
call and are then memcpy_to_user()'d out to user space.

struct rds_info_rdma_connection and struct rds6_info_rdma_connection
are the only rds_info_* structs in include/uapi/linux/rds.h that are
not marked __attribute__((packed)), so they have a real alignment
hole. The other info visitors (rds_conn_info_visitor,
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
RDS_INFO_IB_CONNECTIONS). The returned 68-byte item contains 26
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
and rds_walk_conn_path_info() before invoking the visitor. This
covers the IPv4/IPv6 IB visitors and hardens all current and future
visitors against the same class of bug.

No functional change for visitors that fully populate their output.

Changes in v2:
- retarget at the net tree (subject prefix "[PATCH net v2]",
  net/rds: prefix in the title)
- add Cc: stable@vger.kernel.org
- pick up Reviewed-by tags from Sharath Srinivasan and
  Allison Henderson

Fixes: ec16227e1414 ("RDS/IB: Infiniband transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Reviewed-by: Allison Henderson <achender@kernel.org>
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


