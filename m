Return-Path: <linux-rdma+bounces-16674-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAxXL2chiGmrjQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16674-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 06:38:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FB107F29
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 06:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BBB303CD0A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0244346766;
	Sun,  8 Feb 2026 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr3Mrdrh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216633A70F;
	Sun,  8 Feb 2026 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770529041; cv=none; b=FAIyx7fBRr4P7GMDGlkU/a+ibt45TUzBZoIYvPsnRCGl7zf+27rV8AzO1W6SKdG3gFxQ5X4ed6DYdrf8naoAek86zirEGLrquNQSkyHEr///Hg8HVPjr/fuFPBYsyBcxlSvTV0/d6pzBotptWfdq6Hkx9Py3lWTpkACEPzwt58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770529041; c=relaxed/simple;
	bh=HqxW2G5uMxI2WYyIg2YbDqk5wVnzgeUCn8DKRI5dyo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7kq1J1h+Fy7uZLXT6Ez7h9bTQwlSm2j31WoJNBGcAAqyXWlvsKIogDnbfbkygWN1YFqlSxMrvHQNy40I+ZcjRN07l++RZcstqbE/5OgNyZn8iA18l5zYMYBtvf6SXhYfUcU+iMA6gI2zWXknEYtdjIGGJv0ucN5MTzqfUxlzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr3Mrdrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB01C19425;
	Sun,  8 Feb 2026 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770529041;
	bh=HqxW2G5uMxI2WYyIg2YbDqk5wVnzgeUCn8DKRI5dyo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kr3MrdrhnPYomKuWip3u96c4S+qYPNW082a8cCJKI7uH4cvoFfXrk4yIV19zLspGq
	 iOWZyNWsAdf23jvMMuIQ5zt5nftcxr+lp1NPh0/nR4bVEgXxxv93ATyxea2MsspAvv
	 xK+y+JSmPHigw8bSUdxGLPqNoOW+I90EBMvdh4t9Ko1d9Wpg7yXFolXQU/9ECyXiKI
	 Cr2wcLe248mYqgsRGX7psEGv8kELclhSW9cSXqz5CMlEaZpgyZSU+EpO/3SAJducsZ
	 1SdOlurkFa/29R5faB5IJZg2h7Y+kkToamJCowP22OQzRLzMJsjp+PpPGXkmZpBA7W
	 7TO0qrsDvyXkA==
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
Subject: [PATCH net-next v2 4/4] net/rds: rds_sendmsg should not discard payload_len
Date: Sat,  7 Feb 2026 22:37:16 -0700
Message-ID: <20260208053716.1617809-5-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208053716.1617809-1-achender@kernel.org>
References: <20260208053716.1617809-1-achender@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16674-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E7FB107F29
X-Rspamd-Action: no action

From: Allison Henderson <allison.henderson@oracle.com>

Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
connection teardown") modifies rds_sendmsg to avoid enqueueing work
while a tear down is in progress. However, it also changed the return
value of rds_sendmsg to that of rds_send_xmit instead of the
payload_len. This means the user may incorrectly receive errno values
when it should have simply received a payload of 0 while the peer
attempts a reconnections.  So this patch corrects the teardown handling
code to only use the out error path in that case, thus restoring the
original payload_len return value.

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


