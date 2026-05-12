Return-Path: <linux-rdma+bounces-20520-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGVoHdCAA2pB6gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20520-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:34:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BC528AD3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA5FD3097F6E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F8368D4E;
	Tue, 12 May 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Ak4U0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBED3655CE;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614455; cv=none; b=u7MkxqwIqmcl5NwyhnYYdDhrUo42RY3ApaiVNO7qw2npVrXSUvsKIxBC4hTIsHsetP2UUMltkSMi/4726x9MAT8vvC8r62EQrIk5eMCTLqif0tXqXl+BglBysV7OhAimCbYMOeyGxJdijisaX4en1twtuhACR8RTLnyrpPOuHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614455; c=relaxed/simple;
	bh=OELprfJSs6QUC5gG8lJTGopc2nctHw1EAQAtp6FFWMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkTbiiCzSjAEHnF2SuL76aCB0cUdI6pj+08aOg5vycTZfcgiMznNFynttTtXskUqT6EWJV3oLheQMFT0AejOnXFwMj63iIliMOA8H34OvlU7lMRfgrwfHrblqunmVE8pXNgPoRurcXlW6Kvh3Phmr0suuqkEKL+FCNqk2fqY+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Ak4U0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6493BC2BCC7;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614455;
	bh=OELprfJSs6QUC5gG8lJTGopc2nctHw1EAQAtp6FFWMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2Ak4U0FkSfWfuuOMgD29DAh1NIgd09laHsTofAIKGqxD/XOHQSb8rhHFDKailQ0N
	 Wj1XRDmPxqieRsvq88hbRvA/Y6RYecZUZYGobdjXHK6FkvArAYGMU7kvO4ue8lIJPb
	 LUe4Lv4NdrpxXj6vnUWBQjq5kgXcGmXyDvjaYMYhL2bK53AhpIIHdIVnysQBahIkhJ
	 PlMon7P4AZfattFB0p5h0WnG26ZmM9WR2HYMgW0ntK6UNnOJ7eEvjFG8IS7jJ267ew
	 d/uqhJ93AmQNnbPwam8HeYbUbe/RaEhCXRYDSmz4KtdhUExJVsFVXurlOknWC8izue
	 wMmpOyhdgQ7PQ==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next v2 2/4] iplink: Drop pid fallback code for netns
Date: Tue, 12 May 2026 13:34:05 -0600
Message-ID: <20260512193412.32019-3-dsahern@kernel.org>
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
X-Rspamd-Queue-Id: 063BC528AD3
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
	TAGGED_FROM(0.00)[bounces-20520-lists,linux-rdma=lfdr.de];
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

Prior commit handles the fallback to pid, so remove
the now duplicate code from iplink_parse.

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 ip/iplink.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index eae51438d0be..2c052d2970ca 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -650,19 +650,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (offload && name == dev)
 				dev = NULL;
 		} else if (strcmp(*argv, "netns") == 0) {
-			int pid;
-
 			NEXT_ARG();
 			if (netns != -1)
 				duparg("netns", *argv);
+			/* try by name then by pid */
 			netns = netns_get_fd(*argv);
-			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
-				char path[PATH_MAX];
-
-				snprintf(path, sizeof(path), "/proc/%d/ns/net",
-					 pid);
-				netns = open(path, O_RDONLY);
-			}
 			if (netns < 0)
 				invarg("Invalid \"netns\" value\n", *argv);
 
-- 
2.43.0


