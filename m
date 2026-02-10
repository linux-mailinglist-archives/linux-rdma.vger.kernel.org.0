Return-Path: <linux-rdma+bounces-16736-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNyJL8Bmi2kMUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16736-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:11:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E5411DA5C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85113305502F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D83806C9;
	Tue, 10 Feb 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+6BAQX0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8130F541;
	Tue, 10 Feb 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743394; cv=none; b=SSVmz+tABucxESGpzNML9s9JBz/R+C0SWEWeJdNVvE4bdEDVrtAwAyGPFU5V8AcsyTazz57xsp4Q+a03tMFane2STLZf/t64hPQowAA+V6ip5Awu+mZ5/5o9ItP5+gk6Mm2xy2wQTrlfwlDcLwaI8hH6UZ0Qfh8S1n8ZY7Tz3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743394; c=relaxed/simple;
	bh=EewhX7pCVaZsONS5AgLcaHibcIx/Rv1A5l0RH1SAVug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbR488fbEDgcM7juQN+s3r4YMvYWFYESOlfG15fasoxCTxGTXlv+5Qxm5zK2Tnm18AN+IQzBF8MH64A/p1MtcJduHXG82wLuc2J+aidwCV9zXaiaG/Phzgw3bhdr7K5ptP99VZd0ltDe6ZcMMXNFuNkBCxB9RDrNZHqgFaN30VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+6BAQX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B290C116C6;
	Tue, 10 Feb 2026 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770743394;
	bh=EewhX7pCVaZsONS5AgLcaHibcIx/Rv1A5l0RH1SAVug=;
	h=From:To:Cc:Subject:Date:From;
	b=u+6BAQX0iu1E+HYT1eHBFtD3YcZ8qPkk6ocR8gDFftYzWVEyRn+RwDaKrD4rdSAoo
	 qo+m4fdZjk0MsCUXdV/lwsiBnxcVMowSjG4hFYeXoVTz8j2x/74T9i7MasT1cwxaxQ
	 3xQXCKhrK4JQkdCoxpAks/79rhwt4haPGd88pDnGC1rWfdMTwvzJLGZ1KtQ1eSSe8V
	 S4/Q7IJ7/xE+ciovS1CdF5136A5yiVd5GQDBnkjOnNgeyXtUh4RSXY8t+S2+NqeJxc
	 XLqzH/HLTVDeB2j3Uxa+fsaenjnmOO5k/vVrHPDB2cf2CWW5HntudjGHzsBTcWgUp6
	 MbRd6zswGi3xw==
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
Subject: [PATCH net v2] net/rds: rds_sendmsg should not discard payload_len
Date: Tue, 10 Feb 2026 10:09:52 -0700
Message-ID: <20260210170952.1836306-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16736-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76E5411DA5C
X-Rspamd-Action: no action

Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
connection teardown") modifies rds_sendmsg to avoid enqueueing work
while a tear down is in progress. However, it also changed the return
value of rds_sendmsg to that of rds_send_xmit instead of the
payload_len. This means the user may incorrectly receive errno values
when it should have simply received a payload of 0 while the peer
attempts a reconnections.  So this patch corrects the teardown handling
code to only use the out error path in that case, thus restoring the
original payload_len return value.

Fixes: 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with connection teardown")
Signed-off-by: Allison Henderson <achender@kernel.org>

---
Changes in v2:
- Rebased on net/main to fix apply failure in v1

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 0b3d0ef2f008..071c5dca969a 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1382,9 +1382,11 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		else
 			queue_delayed_work(rds_wq, &cpath->cp_send_w, 1);
 		rcu_read_unlock();
+
+		if (ret)
+			goto out;
 	}
-	if (ret)
-		goto out;
+
 	rds_message_put(rm);
 
 	for (ind = 0; ind < vct.indx; ind++)
-- 
2.43.0


