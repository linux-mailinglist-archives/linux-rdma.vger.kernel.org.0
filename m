Return-Path: <linux-rdma+bounces-16703-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDQsCVL5imlBPAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16703-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:24:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F406118D6D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49F7C30162A6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610133F390;
	Tue, 10 Feb 2026 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrB8Z2sH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A81E2614;
	Tue, 10 Feb 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715470; cv=none; b=EbDqM9K1Y79bf5QT2nFBrqpk9SdOHC0uJzl0+qCo0J/0FCaVPlMBDbWowwnxU0QKeKWr6j4Qxsw/UgJFKE+3oj+XXH9f7XclSC1OiK6Muk7l94KQVur8dupvUXP+CqxRSmVtPr33hx5LYwkwY0ywHNRAO8VxZwnefj3joEylnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715470; c=relaxed/simple;
	bh=W3oUj2cDOzt3sDn8kKRODpOQKjUyTkq0X+Z6OiVOV+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vli0NiEeuRf9UCO7ux5t/soIHIXg0WPvdM4dYMC/6wcKKtPmhQBXW94TXcPfCL/29Vfv4cx61seeVFFCWc3xcexH6gMmjqf4GSA6v+ymN4JHbLaxgOcHru2/7LXfDBMv1XHEcm7Kwc4AB/dX73ybggLR+lb2lm1qlqkbqKdAvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrB8Z2sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A4EC116C6;
	Tue, 10 Feb 2026 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715470;
	bh=W3oUj2cDOzt3sDn8kKRODpOQKjUyTkq0X+Z6OiVOV+I=;
	h=From:To:Cc:Subject:Date:From;
	b=MrB8Z2sHUom+UNEhg2ma1bzDU7yIPyz8vy/O17lfRhULLmNUbHG1W3YpowIGt8nxX
	 IUjEq+e2Sv/Pbc5ByPvb3y2BnTIUxX9JMFUorRMk1LHZwKls4teKEBnihAQrNGV/ld
	 fSzGyTblKnCeEMESSyBOwg8/p+MkjNlVGlAyc4xrvM3tRSPHSlliByr0O+Qy4+L6El
	 43f1H97CHaa+C38dNAIyYaNG5E+QwTlBw2LOiqUqne1gL1s0v0DQPP3X5bzgQD8N8Q
	 KDy0cKrRzPxsl9TCRrb4xR8+e2qhs+hdjg02kRHX5LYDWWmDq0Bna5GNls7nvhGBUY
	 ZSx9h2ASVad7w==
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
Subject: [PATCH net v1] net/rds: rds_sendmsg should not discard payload_len
Date: Tue, 10 Feb 2026 02:24:29 -0700
Message-ID: <20260210092429.1819177-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16703-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F406118D6D
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
 net/rds/send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 6e96f108473e..a1039e422a38 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1431,9 +1431,11 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		else
 			queue_delayed_work(cpath->cp_wq, &cpath->cp_send_w, 1);
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


