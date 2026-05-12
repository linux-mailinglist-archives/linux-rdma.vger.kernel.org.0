Return-Path: <linux-rdma+bounces-20521-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDeoCOaAA2pB6gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20521-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:35:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76316528AE2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F133430B659D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA336F8F2;
	Tue, 12 May 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnua1yNG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BC368D79;
	Tue, 12 May 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614456; cv=none; b=eIPd2UsTntH1Daa2O8+lvmfFQKFtfZzejN35hOhLEiffQ8AuCl2BOVp+flBHVxarRkRdFigsC6wgy7IEYo6hSK91g79oVjXHXIYE9DxkhZ7q0UdRBOrUK9R2RsT1SRNlPY0xOEMnS67R36K2heO06mrPbgU2tYmoGR8HfehR6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614456; c=relaxed/simple;
	bh=0xat5xZmtyATSxK7rp2HOIV4Rdap7ljVDFoFnNLhQSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDPBGuIghlylvgVaAPIgAHIj0/G+QuNeyDzb4ulNLPKDclk85ulk6aixWchjK1dImAIZjfTf5VBVU9d92NcAZzEevqPKzKsoHvmpuR7UV2P8nU4APWbNGIVkBi6RcfWs05ABxRwwhQn9gRoW8w2jhdpolJ1aYF5oqrVmHcReOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnua1yNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81ABC2BCF5;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614456;
	bh=0xat5xZmtyATSxK7rp2HOIV4Rdap7ljVDFoFnNLhQSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hnua1yNGPqurdXT9EMqPZlW5TQIKfwx2qt+3tnl/UirJMRG0fV1z4RZ0uZsieJC39
	 P2cuU8PFeIJllE9Py/6VWDwpD/jIeCIhjeThBrD7o9lXk8UiFFo5SKyJDML/jFZo/L
	 K/wTQGhVlGfp/946+vCRCC8Z5NKAuggbYU9OFH6AyblOi7eed4XUl3PTb6ygyXL1ct
	 rMPnugsqx1UZ3B97xWdF6/feH+wWt+SIQ2Ajq4qvVbKWRIEyHTGLCDtM215zclDDR7
	 I1lyPWBa2wiCloA0yFdWqG9I3C/Bpi91eZccOshBPLq86PppXI3RK6bn4VcbQQJLde
	 2hgCMXdCjEWMg==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next v2 3/4] rdma: Allow netns to be specified by pid
Date: Tue, 12 May 2026 13:34:06 -0600
Message-ID: <20260512193412.32019-4-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512193412.32019-1-dsahern@kernel.org>
References: <20260512193412.32019-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76316528AE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20521-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Update rdma dev to work like ip link where the netns can be a
name or a pid by using netns_get_fd. Update man page and help
accordingly.

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 man/man8/rdma-dev.8 |  3 ++-
 rdma/dev.c          | 11 ++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/man/man8/rdma-dev.8 b/man/man8/rdma-dev.8
index abc9f405ede5..34ea1c614ca4 100644
--- a/man/man8/rdma-dev.8
+++ b/man/man8/rdma-dev.8
@@ -32,7 +32,7 @@ rdma-dev \- RDMA device configuration
 .B rdma dev set
 .RI "[ " DEV " ]"
 .BR netns
-.BR NSNAME
+.BR { NSNAME | PID }
 
 .ti -8
 .B rdma dev set
@@ -104,6 +104,7 @@ Renames the mlx5_3 device to rdma_0.
 .RE
 .PP
 rdma dev set mlx5_3 netns foo
+rdma dev set mlx5_3 netns 1234
 .RS 4
 Changes the network namespace of RDMA device to foo where foo was
 previously created using the iproute2 ip command.
diff --git a/rdma/dev.c b/rdma/dev.c
index fd60c1a0e856..c8537912e48e 100644
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
@@ -311,7 +312,7 @@ static int dev_set_name(struct rd *rd)
 
 static int dev_set_netns(struct rd *rd)
 {
-	char *netns_path;
+	char *arg = rd_argv(rd);
 	uint32_t seq;
 	int netns;
 	int ret;
@@ -321,10 +322,7 @@ static int dev_set_netns(struct rd *rd)
 		return -EINVAL;
 	}
 
-	if (asprintf(&netns_path, "%s/%s", NETNS_RUN_DIR, rd_argv(rd)) < 0)
-		return -ENOMEM;
-
-	netns = open(netns_path, O_RDONLY | O_CLOEXEC);
+	netns = netns_get_fd(arg);
 	if (netns < 0) {
 		fprintf(stderr, "Cannot open network namespace \"%s\": %s\n",
 			rd_argv(rd), strerror(errno));
@@ -339,7 +337,6 @@ static int dev_set_netns(struct rd *rd)
 	ret = rd_sendrecv_msg(rd, seq);
 	close(netns);
 done:
-	free(netns_path);
 	return ret;
 }
 
-- 
2.43.0


