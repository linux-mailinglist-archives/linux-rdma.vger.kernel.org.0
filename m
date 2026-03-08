Return-Path: <linux-rdma+bounces-17687-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PMIBhIQrWmBxwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17687-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:58:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0722E9C0
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06ED0300988D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 05:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C531B828;
	Sun,  8 Mar 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBJ6blxz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1115E97;
	Sun,  8 Mar 2026 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949517; cv=none; b=EQdkvmnO43mUPwYmc+pTKVXSN/0H+J5yWYT0mXa8p5GUvdMIRe29zNJWHo4ZXTwHnUMsxxPhj5BBnmo2fJOoCYK0QZ+qsVhWiZt2IATq1Od7GpLVHNovv+zwliY/Kz2cp2iZA1XWd9Ll7H29DgREdlgaAijiE0SA4bxlyhowHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949517; c=relaxed/simple;
	bh=mSxTlzJkw75GuNUOOWpgQxuiRMmSUheKQtNWRdcnZ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlSgwOwcvXipNExYr2y05ybDcwnh4zlVT6P4W0ZL67DZmQKvYghX0R+bb6JD8w+9DTU7RslbQvrUt9bQaL2TRf3sWeVhlGrbtF6StJuNOISLyxxYHtiFHuYM611XVrve1mhlbWRuopy3u099pi0wZ6C6tOCJe9CsxUQkzny/yTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBJ6blxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF98C116C6;
	Sun,  8 Mar 2026 05:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772949516;
	bh=mSxTlzJkw75GuNUOOWpgQxuiRMmSUheKQtNWRdcnZ3k=;
	h=From:To:Cc:Subject:Date:From;
	b=QBJ6blxz/W0d9x1zgVMyEn6eRN2t0e3Lx6SXanIMZy5cVRhI9hI3R1scjVhcZoXL8
	 WbKXlo6LQ80vZpQK6M6hhOMRT0hFymOBo1222HOiBwXiaBzcBFqAt+zN5BVyZjk2Gq
	 PNyLhHowZP4Bqs0w247WMlSKNpNi155Sj8WXLDIm17NbwNsi/GJL1iMY6kcOSmQStV
	 RvgPAW+R11rVCn4YbCYjxBK1Rl77dfbmi6fdl4Cy0lCpifv2uG2bdO4DnVhobgnBmO
	 LKNaVf5TTGNLufDIT2qMRB49p71j0F2lSfP5hqQTEYA2zifiHKoNs8e2G8MsaPuRvP
	 Fj6RbnUsJ1fGw==
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
Subject: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
Date: Sat,  7 Mar 2026 22:58:32 -0700
Message-ID: <20260308055835.1338257-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FC0722E9C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17687-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Hi all,

This set addresses a few rds selftests clean ups and bugs encountered
when running in the ksft framework.  The first patch is a clean up
patch that addresses pylint warnings, but otherwise no functional
changes.  The next patch moves the test time out to a ksft settings
file so that the time out is set appropriately.  And lastly we fix a
tcpdump segfault caused by deprecated a os.fork() call.

Questions, comments and feed back appreciated!

Thanks!
Allison

Allison Henderson (3):
  selftests: rds: Fix pylint warnings
  selftests: rds: Add ksft timeout
  selftests: rds: Fix tcpdump segfault in rds selftests

 tools/testing/selftests/net/rds/Makefile |   1 +
 tools/testing/selftests/net/rds/run.sh   |   7 +-
 tools/testing/selftests/net/rds/settings |   1 +
 tools/testing/selftests/net/rds/test.py  | 108 +++++++++++++----------
 4 files changed, 66 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/net/rds/settings

-- 
2.43.0


