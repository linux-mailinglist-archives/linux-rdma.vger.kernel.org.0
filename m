Return-Path: <linux-rdma+bounces-19609-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJnVNl/x72nYMgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19609-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 01:29:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BD847BD49
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E88EF3007AD2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B813B4E9A;
	Mon, 27 Apr 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA51JF+B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293404CB5B;
	Mon, 27 Apr 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332569; cv=none; b=OuwJTFbR7oNloeaBYdv4U+X4e5yGnMrz00P8Tib1fxs9H/WiJjVoxh0Gs9Lauirb0fPKOuJmP1iQ4zVtMviU8h9QLkkTaquGMsjMSqj9ql9ZokD+PHixYhR5VabXX6AsWGw0RgnONxQAIB2KBIdyw0m4JpLA3L7tmn3A15qWLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332569; c=relaxed/simple;
	bh=tM0S0AfNk30G5y+f+gMl/cHLRh+P4kjW0zZ52g70oGc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=t5rB1ysT5yCUvNVPlzrX3s9jlFhW4DZ5Umf51Sns10U9qtHk4zdahugUpk1SOi49KSpMhPfyjgxQJHemTEmaAOrIuzLTeoamMME0SfDvhz8hcLBsPQmyT6AQiwH/O8aZLs8AHc8Ga5ToD4GHrHMuOGxwecA0D9g+hhH3LO7qbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA51JF+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57670C19425;
	Mon, 27 Apr 2026 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332568;
	bh=tM0S0AfNk30G5y+f+gMl/cHLRh+P4kjW0zZ52g70oGc=;
	h=From:To:Subject:Date:From;
	b=CA51JF+BB17bG3uqstOWGHsi1U797p/ZJWhOkObyKk4KRTwvOUEKKyDZIJSr4d0FJ
	 F5D0mooZLhG2kFggxV6wZqe7cR1TPzUDo6a/iiy8r/ktb4xp5hJZAKRrkjrOvLwN+l
	 CRqk9YJjgtnqEFYj9nhqypH/9ORFrL8geJR4kz6Mo1iMNoKVXQujAFc464wYV2rBnf
	 SKqQO54bfdc9Tb28MA0Ck0crAY148x5Dn+s1QY1W3CxvhSm5+b7aytB5tQdhXmsgCf
	 zF1gw7A9Ji9YTHbkcT2xoJmyruafZfC63lPA862YHohw/NIHMbfD02TqzuihaWI1al
	 9oFizNWzWDm1w==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net-next v1 0/6] selftests: rds: Log collection, TAP compliance and cleanups
Date: Mon, 27 Apr 2026 16:29:21 -0700
Message-Id: <20260427232927.2712755-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3BD847BD49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19609-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This series is a set of bug fixes and improvements for the rds
selftests.

Patch 1 bumps the kselftest timeout from 400s to 800s. The original
limit was developed against a lean config, but the kselftest harness
counts boot time and gcov log collection against the limit, so a
default config with gcov enabled needs more headroom. Patch 2 removes
an unused "-g" entry in run.sh's USAGE string, and patch 3 adds a -t
flag to run.sh so the timeout can be overridden if needed.

Patch 4 fixes log collection under vng. The vng guest inherits the
host's systemd config, so tmp and debugfs may not be mounted by
default; without them tcpdump can't write pcaps and gcov data is
silently dropped. The patch mounts each filesystem when it isn't
already mounted, and also specifies the --root folder so that gcov
can still find the kernel source when it is run from the ksft
test directory.

Patch 5 hoists pcap collection into a helper and calls it from the
timeout signal handler so dumps are preserved when a test times out.
Patch 6 makes the test output TAP compliant so the kselftest runner
parses results correctly.

Questions, comments and feedback appreciated!

Thanks everyone!
Allison

Allison Henderson (6):
  selftests: rds: Increase selftest timeout
  selftests: rds: Update USAGE string for run.sh
  selftests: rds: Add timeout flag to run.sh
  selftests: rds: Fix gcov and pcap collection
  selftests: rds: Collect pcaps on timeout
  selftests: rds: Make rds selftests TAP compliant

 tools/testing/selftests/net/rds/run.sh   | 42 ++++++++++----
 tools/testing/selftests/net/rds/settings |  2 +-
 tools/testing/selftests/net/rds/test.py  | 70 +++++++++++++++---------
 3 files changed, 76 insertions(+), 38 deletions(-)

-- 
2.25.1


