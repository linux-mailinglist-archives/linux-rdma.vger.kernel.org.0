Return-Path: <linux-rdma+bounces-20858-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OONaDGJqCmp+1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20858-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:24:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA24A564BDF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9F1030028B7
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61C20E702;
	Mon, 18 May 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfc+vuA7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F610EACD;
	Mon, 18 May 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067485; cv=none; b=q/aD+EaNCUSZd0oOIVhIzLP0wHdpjrUCjJb3bh+1sujeQnb6Emkg6PYssUSYmtxOZAB6NqLDHnJ6rkKxIfRNXQXBWlDT9LxfHj9ItJ4YnmlzpEvdKZksmwhyJ6yt7rPGuAhSfXjfe3u9wL03RpHYxs0nFTCM5B8JgNMVL+DszWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067485; c=relaxed/simple;
	bh=HADiCZFp1b+AV3mdMhESpYMJ04W5YOpTRltzgqPjiAw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GD6vPG2KncKetJAbdxOvQs5CKrDAEGz4jiZ1PEqiKqsPHZTD0o2mv+iTONUyPzSOsBqa3NcXwuvFViqrOz6nXw9Ib1YNdX/NtNWQX4EKsL9WQfsf2fhhjlbO2wpih+24DxOL4Bn7Ykg5xFN+yZofjgZOlrSVrAhhkO4uuCIg0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfc+vuA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52470C2BCB3;
	Mon, 18 May 2026 01:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067484;
	bh=HADiCZFp1b+AV3mdMhESpYMJ04W5YOpTRltzgqPjiAw=;
	h=From:To:Subject:Date:From;
	b=Qfc+vuA7yQSULOtT62DI4oq+a8zuZmVF3jlxK1/IIHDuDcBePNJsRFVY7KV/np3NC
	 qwDhoJmm4RznHceX/bXfykxq+7nwEQf65deuilOGeOzr/YazdpoQKaHfdFs4PoiPZK
	 +bsNWlJZZDaqYzRqgx2epgmPglrixW7jiIiuZ0/3T4KfKkH1SE8Plk7WjO7yA2cxnw
	 S0rfYy0aI+0fhwjrYZz2YrrHv9mkD3hdlUPX35HRuKlDX0TWylssfkmXSyXGfNUJ+b
	 S4F3rSpwnrmW1XdRtvXBuB070ktLzHeU0pJQOUGF+ETwDxYwXCfPLk322SaiPhl1UX
	 WTURLsWT4Jhpw==
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
Subject: [PATCH net-next v3 00/11] selftests: rds: Add ROCE support to rds selftests
Date: Sun, 17 May 2026 18:24:32 -0700
Message-Id: <20260518012443.2629206-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA24A564BDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20858-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Currently the rds selftests only tests the tcp transport.  This means
most of rds_rdma.ko has no testing coverage.  This series refactors the
rds self tests to add an rdma option when running tests.  When used,
the test creates a pair of ROCE interfaces to run the payloads through.

Most of this set is refactoring the existing test.py module.  Since most
of this code is one long procedure, it is difficult to modularize it
without creating a lot of pylint complaints about lengthy functions
with too many variables or branches.  

Patch 1 fixes an RDS-IB shutdown hang exposed by the new ROCE selftests
in patches 10/11. The next seven patches break down test.py into helper
functions.  After we have modularized the send/recv packet logic, we
introduce the new ROCE equivalent network configurations, add the new
command line flags to build and run the test with rdma support.

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

v3:
   [PATCH net-next v3 1/11] net/rds: Don't sleep inside rds_ib_conn_path_shutdown
      NEW

   [PATCH net-next v3 08/11] selftests: rds: Handle errors in netns_socket
      NEW

   [PATCH net-next v3 10/11] selftests: rds: Add ROCE support to test.py
      Sashiko complaint: expand snd_rcv_packets docstring
      Sashiko complaint: properly close sockets when test completes
      Sashiko complaint: collect pcaps per rdma iface
      Sashiko complaint: only teardown rdma net configs when -T rdma is used
      Sashiko complaint: cancel timeout before reporting test results

   [PATCH net-next v3 11/11] selftests: rds: Add ROCE support to run.sh
      Sashiko complaint: Update test.py usage and README with -T usage

Allison Henderson (11):
  net/rds: Don't sleep inside rds_ib_conn_path_shutdown
  selftests: rds: Add helper function setup_tcp() in test.py
  selftests: rds: Add helper function check_info() in test.py
  selftests: rds: Add helper function send_burst() in test.py
  selftests: rds: Add helper function recv_burst() in test.py
  selftests: rds: Add helper function verify_hashes() in test.py
  selftests: rds: Add helper function snd_rcv_packets() in test.py
  selftests: rds: Handle errors in netns_socket
  selftests: rds: Register network teardown via atexit
  selftests: rds: Add ROCE support to test.py
  selftests: rds: Add ROCE support to run.sh

 net/rds/ib_cm.c                            |  25 +-
 tools/testing/selftests/net/rds/README.txt |  29 +-
 tools/testing/selftests/net/rds/config.sh  |  15 +-
 tools/testing/selftests/net/rds/run.sh     |  53 +-
 tools/testing/selftests/net/rds/test.py    | 631 ++++++++++++++-------
 5 files changed, 529 insertions(+), 224 deletions(-)

-- 
2.25.1


