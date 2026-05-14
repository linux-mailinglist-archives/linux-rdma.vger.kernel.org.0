Return-Path: <linux-rdma+bounces-20636-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNzVOaFQBWpRUwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20636-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:33:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937F53DAC4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD5F5302DF87
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A63845CD;
	Thu, 14 May 2026 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgU9Pk1P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5811A6808;
	Thu, 14 May 2026 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733212; cv=none; b=fLDgYCTpTpYp1CT4Cz86qmZSBi6X/lB1Lz483dkO7rzfWoySHlzWcqHsk4Vf8LrkBnmeWdXbAfkNqfBgIcFvsVR+pt39M72QYRiDhiX02PgXY/5bHh/aQTMzTcxhhuXv8gRtOKjYAiZDHvFMNJHhJ7zjEg8oqhFU3y7JpF845S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733212; c=relaxed/simple;
	bh=INDRk09ThMXJo9yURkK/JvJY8tS7dKZZsWIbfE5GOJY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RvPEpsucTgIMo+A464MWUczfKATmaOSgUILT6ZH4iT7omK8KSdo2klNw/S0kskuAU8eSPMCvCDI6JXK+e/zvpRVQciv2lCYzx/vDIp8Xb01wKvVtVRJlxeR4xJr30k8NWe7UosOa355klrX8HRFCFjZ4er29FOW1O9PtpIB5N+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgU9Pk1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F4AC2BCB7;
	Thu, 14 May 2026 04:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733212;
	bh=INDRk09ThMXJo9yURkK/JvJY8tS7dKZZsWIbfE5GOJY=;
	h=From:To:Subject:Date:From;
	b=cgU9Pk1PwuAwZf52CtCd8RtsWY+XTozPQDs6XnXBwnGafCIfV/Y9AXkoCDTFmtQm7
	 H5z7iO0+nOdTag/MmlaHqFGqtxbOaWRXXMfSD+ZWLMKWMtzZB1QkV2YqhAznb4lFAg
	 8oZGbk6k9tMrdvd9adrsQVoPTUeE9m4tD7iaOaFNxQ2+lIZd4W4BuJ8cDXQjUwAnPE
	 RhyR7QMhOZipk+tqUs94y5bCGVI2OAlBdjHmyCE2dVov0jMW3QWx5lDCUEXxOPZ6Cl
	 DcgidxIU6wXmmWZjiSUzpLuuw1Cs6ueY49PCj9VCVVtZvgjHpS+VGSoe9lj30A5WxG
	 4qWB5HnKzHCdQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v2 0/9] selftests: rds: Add ROCE support to rds selftests
Date: Wed, 13 May 2026 21:33:21 -0700
Message-Id: <20260514043330.1718969-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6937F53DAC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20636-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run.sh:url]
X-Rspamd-Action: no action

Currently the rds selftests only tests the tcp transport.  This means
most of rds_rdma.ko has no testing coverage.  This series refactors the
rds self tests to add an rdma option when running tests.  When used,
the test creates a pair of ROCE interfaces to run the payloads through.

Most of this set is refactoring the existing test.py module.  Since most
of this code is one long procedure, it is difficult to modularize it
without creating a lot of pylint complaints about lengthy functions
with too many variables or branches.  The first seven patches address
this by breaking down test.py into helper functions.  After we have
modularized the send/recv packet logic, we introduce the new ROCE
equivalent network configurations, add the new command line flags to
build and run the test with rdma support.  

Questions, comments and feedback appreciated!

Thanks everyone!
Allison

Change Log
v2:
   [PATCH net-next v1 1/9] selftests: rds: Capitalize ret global in test.py
      Dropped

   [PATCH net-next v2 4/9] selftests: rds: Add helper function recv_burst() in test.py 
      Pylint nits

   [PATCH net-next v2 6/9] selftests: rds: Add helper function snd_rcv_packets() in test.py
      Pylint nits

   [PATCH net-next v2 7/9] selftests: rds: Register network teardown via atexi 
      NEW
      Registers network config cleanup function teardown_tcp() with atexi

   [PATCH net-next v2 8/9] selftests: rds: Add ROCE support to test.py
      Pylint nits
      Added rdma network teardown cleanup on atexit
      Fixed test result reporting with dynamic per-transport reporting

Allison Henderson (9):
  selftests: rds: Add helper function setup_tcp() in test.py
  selftests: rds: Add helper function check_info() in test.py
  selftests: rds: Add helper function send_burst() in test.py
  selftests: rds: Add helper function recv_burst() in test.py
  selftests: rds: Add helper function verify_hashes() in test.py
  selftests: rds: Add helper function snd_rcv_packets() in test.py
  selftests: rds: Register network teardown via atexit
  selftests: rds: Add ROCE support to test.py
  selftests: rds: Add ROCE support to run.sh

 tools/testing/selftests/net/rds/config.sh |  15 +-
 tools/testing/selftests/net/rds/run.sh    |  53 +-
 tools/testing/selftests/net/rds/test.py   | 591 +++++++++++++++-------
 3 files changed, 465 insertions(+), 194 deletions(-)

-- 
2.25.1


