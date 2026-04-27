Return-Path: <linux-rdma+bounces-19611-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDEQCGHx72nYMgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19611-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 01:29:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE147BD50
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 01:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCBE3300D77D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14513DF01C;
	Mon, 27 Apr 2026 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZlcO0Cw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F23D47BA;
	Mon, 27 Apr 2026 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332570; cv=none; b=llzHYb96WrIyav6MvOJKpIKGxvTPKjcZSDE96EfTg/zdpVixr1S+erL+JZ6BcQzVCMJ6CmAMZy+zMuaXR4KuAiVVrPBdT6gjabVn58z1SidxFDYQzF5L41wpJ0bTDfzlu+Hs+VNXAcH34OHWJsLsv6fI0vrVJUM7Mhbjux/EE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332570; c=relaxed/simple;
	bh=BUVIypGdvXgxZ8Wyqd66onNkMgHPmftrWyKqBv1ycbM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzpsEETCz+zx4ApFe2IxjZzOVd1E8Q8LC3HFBBW3YHzl34f4DCLYfVishV4QPbZTDueyI9CPBsVM4AwpMMhEYIgZz5NXZMJw3uJ5TSMjqapwe+5mBRBIj43LuNogFSIm40Fd1Jmbd3Nybh3R9vqzPotaEo8PRCkqwHoaUdFIADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZlcO0Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1273C2BCB5;
	Mon, 27 Apr 2026 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332570;
	bh=BUVIypGdvXgxZ8Wyqd66onNkMgHPmftrWyKqBv1ycbM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tZlcO0CwgN+7hGqSRxLnBJOIkYVXLrnqRDSYLeC4PizmCWE8nPIBjcqK4DPotnL9u
	 jcb92h+wzX1PQWH8inUvY+/N3BOpeBEds9pv3k7fXEKBxQ/HC4lRH8y8ql2DVGvbgz
	 cEJ9O0+gdV4TiPbWqUxzxUddxSoTlV3yv/0uPYl6B/Hom94Qu2kXmdxPsUbe+1Afng
	 L/oj2gM4kZsJDtMN6hrY7oaEOAPfcYyUIn/xEVbnER/vqdTXzoowoVFZf+9Kw317zT
	 8IAODGyzqh28zSiZzx2XpI3drfrUcIRn5/eb0eByrE32ief4zRIiF2D0FLUu83NhFz
	 52zPlt5g4rJqA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net-next v1 2/6] selftests: rds: Update USAGE string for run.sh
Date: Mon, 27 Apr 2026 16:29:23 -0700
Message-Id: <20260427232927.2712755-3-achender@kernel.org>
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
X-Rspamd-Queue-Id: B1FE147BD50
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19611-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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


