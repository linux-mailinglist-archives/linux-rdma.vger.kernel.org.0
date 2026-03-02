Return-Path: <linux-rdma+bounces-17354-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK61FKAmpWm14AUAu9opvQ
	(envelope-from <linux-rdma+bounces-17354-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:56:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C407A1D34E6
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E83F73025E5E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 05:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADD379EE9;
	Mon,  2 Mar 2026 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMs//aB9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F63379ECE;
	Mon,  2 Mar 2026 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430920; cv=none; b=rNxBR/UbyVIXnTiuObiMOrvjG4uKMAcSbH5EmkRcZNRM3JMZCNy+CTzcYZd8WASaGJjvkiuZaHTuPJgWSoAJUhP8o4/SM9o7gPv03MGWRCmZOfvAvtMokWeLnvdBIi4ayudvz7UGc1kwKyHKqe8AkruYc8CCSKPh6OucJFMkkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430920; c=relaxed/simple;
	bh=5Nc2JhcjVfsmChS3WB3k+ffnOWwMo9XgBND6/40u+a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7mDqRXkZ25Qu83heF4UgzsjwgZ0/kxaGc412KLhjKccN3Uo2OEJNLSgiIXKzNhdALfQepYeaZNT5lnlM/a8EbeePU9d+9dqe5tE64tA4a5paFuoigzQZLo3tq6zvbbP0jX1pt93wtDxU+u2coDlXo6x1TOlqWcLrnIPX99kyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMs//aB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F059AC19423;
	Mon,  2 Mar 2026 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772430919;
	bh=5Nc2JhcjVfsmChS3WB3k+ffnOWwMo9XgBND6/40u+a4=;
	h=From:To:Cc:Subject:Date:From;
	b=dMs//aB94Gfp5mLFD6I/vHhVVIQCBzZu8dkuDlrUvVr7MoK/4q9v0buf6tIr4C9bo
	 +Mkq1gTBFK0Ra/GzJPimUeujgo91pDhivKTYh6v2uc7t9csR6m5zFBGPRKqnxBRYex
	 /jmvWIcClHeiNxFmmujKaOzDYkPixD+KnOQXkx4MVZ0MNYsrVOGX7CK4owLPFFRKdB
	 bBSlADEsNb687RAz7pk6TwfXgDXs8WmkGqltFZ53fki8PtNbBiVKO6Zh6u0ShkSL/V
	 9f/Owv8s5bIOFH28SMQOndfB9i3Zkh5WTqHIUuJcnxyWgdqv8wDg9ujKQJmkYjP3Qd
	 rW64JAQfyrQ3g==
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
Subject: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds selftests test
Date: Sun,  1 Mar 2026 22:55:16 -0700
Message-ID: <20260302055518.301620-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17354-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rds_basic.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C407A1D34E6
X-Rspamd-Action: no action

Hi all,

This series aims to improve the current rds selftests.  The first patch
refactors the existing test.py such that the networking set up can be
reused as general purpose infrastructure for other tests.  The existing
send and receive code is hoisted into a separate rds_basic.py.  The next
patch adds a new rds_stress.py that exercises RDS via the external
rds-stress tool from the rds-tools package if it is available on the host.
We add two new flags to test.py, -b and -s to select rds_basic or
rds_stress respectively.  The intent is to make the RDS selftests more
modular and extensible.  Let me know what you all think.

Questions, comments, suggestions appreciated!
Thanks!

Allison

v1:
  - fixed pylint warnings

Allison Henderson (2):
  selftests: rds: Refactor test.py
  selftests: rds: Add rds_stress.py

 tools/testing/selftests/net/rds/Makefile      |   2 +
 tools/testing/selftests/net/rds/rds_basic.py  | 183 +++++++++++++++++
 tools/testing/selftests/net/rds/rds_stress.py |  58 ++++++
 tools/testing/selftests/net/rds/run.sh        |  42 +++-
 tools/testing/selftests/net/rds/test.py       | 184 +++---------------
 5 files changed, 308 insertions(+), 161 deletions(-)
 create mode 100755 tools/testing/selftests/net/rds/rds_basic.py
 create mode 100644 tools/testing/selftests/net/rds/rds_stress.py

-- 
2.43.0


