Return-Path: <linux-rdma+bounces-15664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B5D39245
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 03:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840B4301E586
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 02:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACA20297C;
	Sun, 18 Jan 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdyrF+1X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABE1E3DE5;
	Sun, 18 Jan 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768704554; cv=none; b=C7fP76xKhhbD4Dw54O51b0/e7RLEzpkggcXNZWG6NKV8o+sbXaApL9lU82vumhrgAw3gGc97UXjyibC934qgALfu7yHghX2s1Rn5ddDJ1LZQzbve8Jh23TtKw8XUDvIT6kHeQZVLsiZfCcuiqZQQyDj5bESV9ZUE5uzBh7QOtoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768704554; c=relaxed/simple;
	bh=2nGPYRDHSEEWIExARdGDrEI4nVJDBMxm9Y8jfvgNLDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzSPGDQIHMx9RrXdmbE3n3WGdgabsIW4hdd8MY0+gX9AX2K9PQzP2fUTeNqTa0u2pgs9FFIMk00Sx6yqeutBLa7T89LVDan9726KgWEOPdo5wIZHe/DG+FZAIUvHi8J8mSPBWNuBG03MBf/m4qBp9cKqWPTcPNIjR90+knjlv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdyrF+1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6FAC2BC86;
	Sun, 18 Jan 2026 02:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768704554;
	bh=2nGPYRDHSEEWIExARdGDrEI4nVJDBMxm9Y8jfvgNLDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdyrF+1Xd0nnwwKiGbrmM4khhQIowa+4Irrf/HFalNdx4rwfakxP/jqNgXln7j6Bx
	 Ks4QYLvzJlNPAOm4TQ7CbxEMfDXDKVXIvS2/095MO67vazVDUcV/FtOyA7D9iwqhlR
	 gtDU4wKMjA+YifctqDupwZ5yXtmkWore4h+Bi3Uv5HMT+SJip9bBkiY4hNNGAz7NpV
	 BUm4grTYv2V3r5PNdqN7zBNTpYVE0PfJ8bc4MZv3Cjr3dxJi/bjTZfFG94jDLrtaJC
	 jsTGLi9qEaj3CTkHopedJdfnuNh2xRKpd3fRM0JZoZg6nTEFH6XTU5PsRV6B+ZZ5S4
	 eAbmt7OT8AU4A==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 1/3] net/rds: Change return code from rds_send_xmit() when lock is taken
Date: Sat, 17 Jan 2026 19:49:09 -0700
Message-ID: <20260118024911.1203224-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118024911.1203224-1-achender@kernel.org>
References: <20260118024911.1203224-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Håkon Bugge <haakon.bugge@oracle.com>

Change the return code from rds_send_xmit() when it is unable to
acquire the RDS_IN_XMIT lock-bit from -ENOMEM to -EBUSY.  This to
avoid re-queuing of the rds_send_worker() when someone else is
actually executing rds_send_xmit().

Performance is improved by 2% running rds-stress with the following
parameters: "-t 16 -d 32 -q 64 -a 64 -o". The test was run five times,
each time running for one minute, and the arithmetic average of the tx
IOPS was used as performance metric.

Send lock contention was reduced by 6.5% and the ib_tx_ring_full
condition was more than doubled, indicating better ability to send.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 3e3d028bc21e..747e348f48ba 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -158,7 +158,7 @@ int rds_send_xmit(struct rds_conn_path *cp)
 	 */
 	if (!acquire_in_xmit(cp)) {
 		rds_stats_inc(s_send_lock_contention);
-		ret = -ENOMEM;
+		ret = -EBUSY;
 		goto out;
 	}
 
@@ -1375,7 +1375,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 	rds_stats_inc(s_send_queued);
 
 	ret = rds_send_xmit(cpath);
-	if (ret == -ENOMEM || ret == -EAGAIN) {
+	if (ret == -ENOMEM || ret == -EAGAIN || ret == -EBUSY) {
 		ret = 0;
 		rcu_read_lock();
 		if (rds_destroy_pending(cpath->cp_conn))
-- 
2.43.0


