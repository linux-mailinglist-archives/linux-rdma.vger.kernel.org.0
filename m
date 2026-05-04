Return-Path: <linux-rdma+bounces-19894-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBCNBr4x+GlBrQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19894-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:42:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93E4B89B9
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14B8830157D0
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D2285058;
	Mon,  4 May 2026 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH/XddlE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA25283CBF;
	Mon,  4 May 2026 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873306; cv=none; b=Dbu1FDNd2hsB4HO05LJlfZOEuqUAgUwO6qiXNqiCyf8m152AuYwJHmBqtzLDg3B8XazQGvwkkp9O+K5qjqV4UYNYLFhnF9KvppOYdHz5QmS7AQHKYPzqZP5Gft1DQ2edfNtMk8CJMUXA+763AM7myCRG9fhLUWk7cStp+ULMhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873306; c=relaxed/simple;
	bh=VnU9cbuNXK7XHGXDGnGhmYs9ax3rEEsAC1dhreDC7x4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKGXAxP50JeAINDDXJ2Vx87LZSpGQubfuqm6Vuy+6aCvcTNjZXchJR5QjV8VAP/gh2YSb3LaQ4eKITlyC7TAdG/dTZXa0a19tHG7U3Y6wr1UxRSoy29Dqo6gGLNx11lPo8XQ9azdRZnqch3LPghFyRwUPdiGfOtQ5sPDFNWQEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH/XddlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F232C2BCF4;
	Mon,  4 May 2026 05:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873306;
	bh=VnU9cbuNXK7XHGXDGnGhmYs9ax3rEEsAC1dhreDC7x4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BH/XddlEo9zStMxQuCvWqmZqyKXDkYDg0VNWop9O/KNkAwY8VgeP6NGL5FfhlaRd9
	 +SjpZ9CxttepPtHHZVwTtfNXlNDQXwjgB25eNjqBn72eeLjeQbNFcLhMOI6sCF30jV
	 m53ku0GQlR0Qyv4Hp2wADj4NVWtrkOcUkPp4anwlB2RgbDinGKtFX1cejDFPZ0Tbkk
	 9LQLHg9FRQcfY7eH7f7XUf3ABFYSQ40JxnvepCv87rLRUYGo6Rb4qno2s4N9LCnM/8
	 OcVmEUB05Ag3eEXyGIzsPQjY2bVEyUp5+fQdYtf7Cbuv2MrDLrrTd6+J7i3+4N18b9
	 dzZL2mOIx4PMQ==
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
Subject: [PATCH net-next v3 02/10] selftests: rds: Update USAGE string for run.sh
Date: Sun,  3 May 2026 22:41:35 -0700
Message-Id: <20260504054143.4027538-3-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504054143.4027538-1-achender@kernel.org>
References: <20260504054143.4027538-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC93E4B89B9
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19894-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run.sh:url]

The run.sh script does not have a -g flag.  Update USAGE string with
correct flags.  Also fix typo packet_duplcate -> packet_duplicate

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/README.txt | 2 +-
 tools/testing/selftests/net/rds/run.sh     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index c6fe003d503b..8df6cc35dd10 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -12,7 +12,7 @@ kernel may optionally be configured to omit the coverage report as well.
 
 USAGE:
 	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
-	       [-u packet_duplcate]
+	       [-u packet_duplicate]
 
 OPTIONS:
 	-d	Log directory.  Defaults to tools/testing/selftests/net/rds/rds_logs
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 897d17d1b8db..73a9b986b0ef 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -171,7 +171,7 @@ while getopts "d:l:c:u:" opt; do
       ;;
     :)
       echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
-           "[-u packet_duplcate] [-g]"
+           "[-u packet_duplicate]"
       exit 1
       ;;
     ?)
-- 
2.25.1


