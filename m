Return-Path: <linux-rdma+bounces-19694-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OB5I9E08WltegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19694-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:29:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8548C99F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068D530F0F87
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AAF38238D;
	Tue, 28 Apr 2026 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyuXp1hs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681237E319;
	Tue, 28 Apr 2026 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415239; cv=none; b=adBvaBPukEU1Doc67U7H7l1KqX/gHdtnerPoRW35EpG81kIAlVJnbqHrpwdm6g7Ze1b10VJqacnZu/4x0i+BkrYZscVY3cYOAWYd/2eu4daWrQ4JVeNZX/jfknHKzY0nN61+jqy5l+ZHMWsEAVB6g769uvXmDIIqWfE0gh0AJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415239; c=relaxed/simple;
	bh=BUVIypGdvXgxZ8Wyqd66onNkMgHPmftrWyKqBv1ycbM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fihRbcDCnfPUd4aQOwfLpJSNJfWug5vdoAYXi18JQwSUhONIIkFNBMSJ1I7rwT+wfj3df68Cj3huBjxCTgPGNTWFOvls9ID5GvnwRnWCYdCRcOygr0S3czvT4Fh03PGMPd+TWbnwOa2H9qzsn5XGNeemw9u7uhYBfGaRtfpK1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyuXp1hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA54C2BCB3;
	Tue, 28 Apr 2026 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415239;
	bh=BUVIypGdvXgxZ8Wyqd66onNkMgHPmftrWyKqBv1ycbM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EyuXp1hsi9bRFkMG36QRQmdjtKxAUJqjBLlQ7vsHE0h2ao+7CDWlvHajrFAaWw51N
	 evZB+0BxSQxvP1P6gY4mvkphj2ISNhAIihtqWd9uwJldfckFGoQZcdr2ymN9PbVQze
	 lz6jDu9tRQRxNw6APvF5vfWZB9kNHJ2d6yxDluD0TD89C1LZ4IzLynwt8RCw1sW149
	 VSAJm4LG4PQHeKlQXZqJqAsPL0SeLnpiviUtzA6PE+bNwNJ+d+6ZNGX7+X1CQ8zpI/
	 OK0+U6YUo60kyZGcXx6i3meeVcHePVsaAvqTNHivdNuTnVpxIx/npN+fkCj91TSKAp
	 xqqHSfmrSnRhw==
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
Subject: [PATCH net-next v2 2/7] selftests: rds: Update USAGE string for run.sh
Date: Tue, 28 Apr 2026 15:27:11 -0700
Message-Id: <20260428222716.2960871-3-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428222716.2960871-1-achender@kernel.org>
References: <20260428222716.2960871-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33C8548C99F
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
	TAGGED_FROM(0.00)[bounces-19694-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The run.sh script does not have a -g flag.  Update USAGE string with
correct flags.  Aslo fix typo packet_duplcate -> packet_duplicate

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


