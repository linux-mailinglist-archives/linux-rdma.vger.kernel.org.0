Return-Path: <linux-rdma+bounces-19892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEsZOZ0x+GlBrQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:41:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF864B8979
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 217303001FD9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EA273D8F;
	Mon,  4 May 2026 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ+gyLVE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0713E02A;
	Mon,  4 May 2026 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873305; cv=none; b=QUYZREzOzNzdJDq20Pj1iHLKbp6iyN4pMmAYXFeCZym3shIDXR+VfyxKhxnv5nkYCnOwFV8546hBNQ4BrAYutOXOHOS2QhBaS/eUIBRn4aklI4CTzYJTYqYZP0xgskanyk8O/uCWpjwRDRN0e0BwZLBAq3+rTyuxhuTt/v7c0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873305; c=relaxed/simple;
	bh=0kCbXoGO+l61NI+uqmef3j0Uki2ti6rcut1+2UaCk6I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TawH+4lcLjsC0gU2SkCodAnD2bCzXCcvKIMj9KlueyKKQ6HLHZQZZgfjTenxBWSNCwiyocRGY2eCcnDDi+8lyLUv0nyUx9an6WbY56x8XGjuXeFIXi0ULJHBZe8EHUuzo4RuyKat6hmYwQt93GpPwdJKvv5BhbIbfO3UHIA3t64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ+gyLVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06329C2BCB8;
	Mon,  4 May 2026 05:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873304;
	bh=0kCbXoGO+l61NI+uqmef3j0Uki2ti6rcut1+2UaCk6I=;
	h=From:To:Subject:Date:From;
	b=TJ+gyLVEn0y7Brauh5R8wPo0ilF8BAzW+unvfDa79auf29VlT8kHEKhB0sMbMIPJo
	 Ul/sEXQNYiPLm0u+10WaVXjLbV/h8Mgs1/Oox2C1uY1khdPNFgpyEm7bagMyL8Dmd8
	 alP2AhpVorw8fnoAYV56tgxReJVAeNG8xd3xHrXiqdgOXN4VZ338jgSM8askxevW3Y
	 flV9yMgbFfSl3juU05exf75a2Rr1+ordmm5ywkj/uEkgDHgHu5QROoG+JvHOWFK9wZ
	 XrzSR+NXCokCXl4tGKi08PfWF2spy41r7EyBDAdHUsAyiDsYbc8BWLwKIzi4LrwZfy
	 029IuETlSjImQ==
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
Subject: [PATCH net-next v3 00/10] selftests: rds: Log collection, TAP compliance and cleanups
Date: Sun,  3 May 2026 22:41:33 -0700
Message-Id: <20260504054143.4027538-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDF864B8979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19892-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This series is a set of bug fixes and improvements for the rds
selftests.

Patch 1 bumps the kselftest timeout from 400s to 800s. The original
limit was developed against a lean config, but the kselftest harness
counts boot time and gcov log collection against the limit, so a
default config with gcov enabled needs more headroom.

Patch 2 corrects some typos in the run.sh USAGE string and removes an
unused "-g" flag.

Patch 3 silences a handful of pylint warnings in test.py: it adds a
module docstring, suppresses the warnings tied to the sys.path.append
import trick, marks the long lived tcpdump Popen with disable-next
consider-using-with, and drops unused exception variables from two
BlockingIOError except clauses.

Patch 4 adds a -t flag to run.sh so the timeout can be overridden
if needed.

Patch 5 adds a RDS_LOG_DIR environment variable that specifies where
logs should be stored, or skips log collection if left unset

Patch 6 adds a SUDO_USER environment variable that sets the user
for tcpdump --relinquish-privileges.  This avoid the permissions
drop that would leave pcaps empty on 9pfs since 9p does not
support chown

Patch 7 removes the initial tmp tcpdumps and instead saves the pcaps
directly to the logdir if it is set.

Patch 8 hoists the tcpdump shutdown into a helper and calls it from the
timeout signal handler so that the processes are properly terminated
and dumps are flushed

Patch 9 fixes gcov collection by ensuring debugfs is mounted, and
specifying the --root folder so that gcov can still find the kernel
source when it is run from the ksft test directory.

Patch 10 makes the test output TAP compliant so the kselftest runner
parses results correctly.

Questions, comments and feedback appreciated!

Thanks everyone!
Allison

Change log:
v2:
   [PATCH net-next v2 3/7] selftests: rds: Fix more pylint errors
      NEW

   [PATCH net-next v2 6/7] selftests: rds: Collect pcaps on timeout
      Fixed pylint errors in collect_pcaps()

   [PATCH net-next v2 7/7] selftests: rds: Make rds selftests TAP compliant
      Fixed pylint errors from ksft import

v3:
   [PATCH net-next v3 2/10] selftests: rds: Update USAGE string for run.sh
      Same typo fixed in the README.txt file

   [PATCH net-next v3 04/10] selftests: rds: Add timeout flag to run.sh
      Update README.txt

   [PATCH net-next v3 5/10] selftests: rds: Add RDS_LOG_DIR env variable
      NEW

   [PATCH net-next v3 6/10] selftests: rds: Add SUDO_USER env variable
      NEW

   [PATCH net-next v3 7/10] selftests: rds: Remove tmp pcaps
      NEW

   [PATCH net-next v3 8/10] selftests: rds: Stop tcpdump on timeout
      Rebased from v2: selftests: rds: Collect pcaps on timeout

   [PATCH net-next v3 09/10] selftests: rds: Fix gcov collection
      Split from v2: selftests: rds: Fix gcov and pcap collection
      Use mountpoint instead of test -d for check for debugfs mount
 

Allison Henderson (10):
  selftests: rds: Increase selftest timeout
  selftests: rds: Update USAGE string for run.sh
  selftests: rds: Fix more pylint errors
  selftests: rds: Add timeout flag to run.sh
  selftests: rds: Add RDS_LOG_DIR env variable
  selftests: rds: Add SUDO_USER env variable
  selftests: rds: Remove tmp pcaps
  selftests: rds: Stop tcpdump on timeout
  selftests: rds: Fix gcov collection
  selftests: rds: Make rds selftests TAP compliant

 tools/testing/selftests/net/rds/README.txt |  30 +++++-
 tools/testing/selftests/net/rds/run.sh     |  74 ++++++++-----
 tools/testing/selftests/net/rds/settings   |   2 +-
 tools/testing/selftests/net/rds/test.py    | 114 ++++++++++++++-------
 4 files changed, 148 insertions(+), 72 deletions(-)

-- 
2.25.1


