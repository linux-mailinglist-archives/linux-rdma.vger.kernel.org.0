Return-Path: <linux-rdma+bounces-20169-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zy+wLzWr/GlySgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20169-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:09:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF224EAD37
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F27483030D35
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16BA43E4A3;
	Thu,  7 May 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4gOXSxr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365B43E481;
	Thu,  7 May 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166520; cv=none; b=adBIXQuv4FgiAyVYGTZE+Jgohzfs8ywVLG35GVqIo167ZjJGLu55Q0SjY7DXyZWJDbS8QoueGv+6Kuxsd7YSmyRH22b1DWnUgRckPmMjPAOHSu+qmn+mXwXVzAi0sBcOxnkOaMosks9Jn8KjQDKkzF7K6IfO+ztc/P2xlVvD6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166520; c=relaxed/simple;
	bh=iF9kuhnxAnmPx5XML2Y1Qp+IYKRZ0mubdjQbOH4ja9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az5kiLwpfv8lsdU1GkxK1qMlk1OXYLH2W5Fz0CDYdOfDOK9KviS+lrD34MnxO1IN92CYrN3RT8LoTElMPXFV6WJ3lAhYk4jRs46Qjslve4SN1Ap9O43MgI6PZ/7No8stJFgBe0Va7QhI1THP7Nt8+pkODWMRN+at2+69H1NWGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4gOXSxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC76AC2BCC4;
	Thu,  7 May 2026 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166520;
	bh=iF9kuhnxAnmPx5XML2Y1Qp+IYKRZ0mubdjQbOH4ja9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4gOXSxrPwVzqG8nWz4ip87rRp4zqvQbrRKCfCZq32KH2IxjBec2cSmKvbdLZCJF/
	 2CDDIgS+yxqcKVi9L4RzMju7g2hfPwJjk62GQABu8Ip20emvkUDR6RUj93lQzSRFpq
	 SD/TLFnvuqkHPXIUlHUiodjVCWYizeBy9bP9Jtp+oe+lMo3Xjk0AMB9yf8SjXFXsjL
	 715zOasQ23Ssk0kKgvjWmaFc/0pMwG5/r2E39LMqwlJ0MYI/nWQkagrtiWf667miKh
	 jIK8q+PKuU9D+GoS44n4MA+sOfS3TQwn+0sb5ydUL05S6bQX2ONCfTSQGiANLc2Oaz
	 H7GrZJmuj2csw==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next 3/4] rdma: Allow netns to be specified by pid
Date: Thu,  7 May 2026 09:08:34 -0600
Message-ID: <20260507150836.28105-4-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507150836.28105-1-dsahern@kernel.org>
References: <20260507150836.28105-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2EF224EAD37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20169-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Update rdma dev to work like ip link where the netns can be a
name or a pid.

Update dev_set_netns to use netns_get_fd instead of open coding
use of NETNS_RUN_DIR. If netns_get_fd fails, try netns_get_fd_pid.

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 rdma/dev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/rdma/dev.c b/rdma/dev.c
index fd60c1a0..f9b782eb 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -6,6 +6,7 @@
 
 #include <fcntl.h>
 #include "rdma.h"
+#include "namespace.h"
 
 static int dev_help(struct rd *rd)
 {
@@ -13,7 +14,7 @@ static int dev_help(struct rd *rd)
 	pr_out("       %s dev add DEVNAME type TYPE parent PARENT_DEVNAME\n", rd->filename);
 	pr_out("       %s dev delete DEVNAME\n", rd->filename);
 	pr_out("       %s dev set [DEV] name DEVNAME\n", rd->filename);
-	pr_out("       %s dev set [DEV] netns NSNAME\n", rd->filename);
+	pr_out("       %s dev set [DEV] netns { NSNAME | PID }\n", rd->filename);
 	pr_out("       %s dev set [DEV] adaptive-moderation [on|off]\n", rd->filename);
 	return 0;
 }
@@ -311,9 +312,9 @@ static int dev_set_name(struct rd *rd)
 
 static int dev_set_netns(struct rd *rd)
 {
-	char *netns_path;
+	char *arg = rd_argv(rd);
+	int netns, pid;
 	uint32_t seq;
-	int netns;
 	int ret;
 
 	if (rd_no_arg(rd)) {
@@ -321,10 +322,11 @@ static int dev_set_netns(struct rd *rd)
 		return -EINVAL;
 	}
 
-	if (asprintf(&netns_path, "%s/%s", NETNS_RUN_DIR, rd_argv(rd)) < 0)
-		return -ENOMEM;
+	/* try by name then by pid */
+	netns = netns_get_fd(arg);
+	if (netns < 0)
+		netns = netns_get_fd_pid(arg);
 
-	netns = open(netns_path, O_RDONLY | O_CLOEXEC);
 	if (netns < 0) {
 		fprintf(stderr, "Cannot open network namespace \"%s\": %s\n",
 			rd_argv(rd), strerror(errno));
@@ -339,7 +341,6 @@ static int dev_set_netns(struct rd *rd)
 	ret = rd_sendrecv_msg(rd, seq);
 	close(netns);
 done:
-	free(netns_path);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)


