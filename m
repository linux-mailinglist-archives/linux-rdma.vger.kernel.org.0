Return-Path: <linux-rdma+bounces-20036-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM6GC7GA+mm/PQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20036-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 01:43:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F44D4C75
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 01:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10955302769F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541B33987E;
	Tue,  5 May 2026 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4LSQAqD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEE40DFDA;
	Tue,  5 May 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024617; cv=none; b=Efc4cDsRpe72g37DGN2CX+lvNH+ebJKiLfj0BRgbKZSx7zLnVYLje7N6fPUL/44v9AMJhlk+y0RDdNF+NH+G8kApEfT/he6UfEmNd4oxbH6bmuaC99UOWw8E7O7zd1PpgGsLB2cOg4fag+QhQYGJHv019zh5DKLZL42lHLU3Hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024617; c=relaxed/simple;
	bh=Bfu85cOiLliPBYdS7vixfmhmxtfctXyIh0Czqzxh6I8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Fg5GG+Y7sxr0qN0qa49rNkUS/h2y/XHyaGMDMFs731rwp8xkkEvwLW8f5FDXZDofGf7I938EVARE0QWP9c+z2y06iLus/Znr5LKzhVtK5mBjg7Wva2uGD3RxgOQ3J9+P/gqI7WnOG0No2WDizATgz6jIMlSXCAU/cYaZNk8GEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4LSQAqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED3BC2BCB4;
	Tue,  5 May 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024617;
	bh=Bfu85cOiLliPBYdS7vixfmhmxtfctXyIh0Czqzxh6I8=;
	h=From:To:Subject:Date:From;
	b=e4LSQAqDp2YwjaXTf664xqPnF3TSh4DSWtDxWF7zXyZvt9tSyIh6LRLG2QVtd/76i
	 z2FfFsQXQC5OBUqvrFdLNtOfT61kK2dShE9JfLjCUOweodb6k+MMsnIEXK0NDj0ckT
	 nG9JhT/PlMUgbF8JX2s+VJE7ZSpJgJnjRG8j8DF0lWq907YVKs5uaEoTmvu2kQe6Ol
	 56A6u+cOvwCN3uMI3xgQAklrV9weEZs2eRFk9zYESex079y+FzIq+RWNeoz0sjTgFS
	 IzzhcyS+mJVHIyBykrDo4J7OxsHHUqC3bneRcVITrpD1rc4C5tW6MYObKKU9FCHwPu
	 srFbyZu/FpFfA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net v1] net/rds: reset op_nents when zerocopy page pin fails
Date: Tue,  5 May 2026 16:43:36 -0700
Message-ID: <20260505234336.2132721-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 769F44D4C75
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20036-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When iov_iter_get_pages2() fails in rds_message_zcopy_from_user(),
the pinned pages are released with put_page(), and
rm->data.op_mmp_znotifier is cleared.  But we fail to properly
clear rm->data.op_nents.

Later when rds_message_purge() is called from rds_sendmsg() the
cleanup loop iterates over the incorrectly non zero number of
op_nents and frees them again.

Fix this by properly resetting op_nents when it should be in
rds_message_zcopy_from_user().

Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rds/message.c b/net/rds/message.c
index 25fedcb3cd00..7feb0eb6537d 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -448,6 +448,7 @@ static int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *
 
 			for (i = 0; i < rm->data.op_nents; i++)
 				put_page(sg_page(&rm->data.op_sg[i]));
+			rm->data.op_nents = 0;
 			mmp = &rm->data.op_mmp_znotifier->z_mmp;
 			mm_unaccount_pinned_pages(mmp);
 			ret = -EFAULT;
-- 
2.43.0


