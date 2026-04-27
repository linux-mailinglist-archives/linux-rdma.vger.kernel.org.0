Return-Path: <linux-rdma+bounces-19610-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMwwM27x72nYMgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19610-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 01:29:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E92547BD65
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64318303CEA1
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 23:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83353B6C01;
	Mon, 27 Apr 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGPSehMz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2B3B531D;
	Mon, 27 Apr 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332569; cv=none; b=lP8MvjvjM5EapmRtkEZr+8OmjqVsAuepBGe4XkjiUFA9x0ToWkOxsTqCMA/LCbHIP9rpjMlw6JfeHFT2TlpW062uBCEsxQnNbIYoI7J0hIqBGnLDvgOy/FuCh/Gcj9yeRSsIBSxY9K4eYXcyS96jj21zhFs31mRM2h87P5lIJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332569; c=relaxed/simple;
	bh=ELl+5FcS3itoozWPf/UNsLQ1fqPBJAhMt2j2GnSGKl0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GERPaVlj4BG4dPDvMAEqhT4sLcvIxzbAsbufojKtUbEK/gNhE66FFc/YkcqkbPAEMaHWtA7ZvxaTv2ltYKtTRXYSh8xqE/Fvb58dum35bPavIeE4OKPyeL0uL6bcKTqEaQ/2CrvYr59KSEWYkGnDMU3N4rp2tU3wHydo0E+4720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGPSehMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106E9C2BCB8;
	Mon, 27 Apr 2026 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332569;
	bh=ELl+5FcS3itoozWPf/UNsLQ1fqPBJAhMt2j2GnSGKl0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EGPSehMzX8J+KIobdvNnAxi1I4CEXvYJ9ImxMW8UP3ZrIOFfdxf/ij5tdcEnTjMEt
	 zvJd9E+VCZDwnX43c9kAZkEihXJMq6S/wnqF1/3p9xv6OyUjPd+BcCI2mnaQvvqkjH
	 JlQecgQ6lJ3SYPy2tQT9iN5jBvaAhMU65xmaG9EQNLE0l35OTNNKj6UzMuj9/mihcc
	 S9kzb9vy2yqLpZjAYKSKptw6cZNWP7m0y3lvcUd5w37HxsD8Rr9/GHaQANChZ9/msh
	 9ZiwaJEa5dZE34J2QnJ/gyXz+8CrsJ+2/dOXY+9vBgnf8Zs723T7rF4Oll1lQJkrYT
	 2H2UcOoHpzafw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net-next v1 1/6] selftests: rds: Increase selftest timeout
Date: Mon, 27 Apr 2026 16:29:22 -0700
Message-Id: <20260427232927.2712755-2-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427232927.2712755-1-achender@kernel.org>
References: <20260427232927.2712755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E92547BD65
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
	TAGGED_FROM(0.00)[bounces-19610-lists,linux-rdma=lfdr.de];
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

The 400s time out was originally developed under a leaner
kernel config that booted much faster than a default config.
Boot up is included as part of the over all test runtime, as
well as any log collection done when the test is complete.
A slower config combined with the gcov enabled test means
we'll need more time to accommodate the boot up and log
collection.  So, bump time out to 800s.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/settings b/tools/testing/selftests/net/rds/settings
index d2009a64589c..8cb41e6a83cc 100644
--- a/tools/testing/selftests/net/rds/settings
+++ b/tools/testing/selftests/net/rds/settings
@@ -1 +1 @@
-timeout=400
+timeout=800
-- 
2.25.1


