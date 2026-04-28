Return-Path: <linux-rdma+bounces-19693-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGMPFbY08WltegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19693-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:29:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D827848C988
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A4830E73E7
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0AE37FF77;
	Tue, 28 Apr 2026 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMfuwpxs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564237F724;
	Tue, 28 Apr 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415238; cv=none; b=cqmezXOrJYF8MR43tLmXuJgjl4gt0J02AV5jIpBDFE3DT3G/LuqSjcotR9sJwtT/VKIrK3obhSrgmSkjrjIAUTVq0Ab3R8HztOQjOQdv+Gc0HDA301yQs9EXFUT4gqkAHXXwzvCM1D9o9Zs8Lucu8h5UEAK0W627wzEQafeMbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415238; c=relaxed/simple;
	bh=ELl+5FcS3itoozWPf/UNsLQ1fqPBJAhMt2j2GnSGKl0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKhWRusmHNT7o00AyupOZQMQTDveGwlGzmp/lIzTPfOIfOo/mkkUPR/D1WJiICqxW3wlNspYmBiCGCSIAVYqRmSiWLcHkRMpWhSDo6JHGYPQjvO5qEdT/Z1z1gqb0a82wMDPKZDRzLSGqMzrgA7rVWWwE6mLaCJ+ZMM0/zEv0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMfuwpxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10054C2BCB7;
	Tue, 28 Apr 2026 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415238;
	bh=ELl+5FcS3itoozWPf/UNsLQ1fqPBJAhMt2j2GnSGKl0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sMfuwpxsT3YjZQP81HfrOH8bTuwKWIBwPLX7mTeKUuqQebVV1YamDKjAK5MVF0IRQ
	 Zpld9L6DsJTTjCmzTohD5m50rGzoSeWDOfRIyeknW03HIZjlrNGsFH9jU7rTFsdQba
	 YfaZknZhh8pttm/nGlo5jb0XnVFjTcTxtmGlgNzVcgTxi8yIJZY5ZgQzS5yPs6d4zM
	 bBlsG43K1z2eQuv4zGB+YXle8mo6BaeUB1daZeZjUA2gbPRubL5UxI9yIrP3IhWM0e
	 lw7zXHLTh5JRV6VknEAseoGB7QX87jmISJloF3FiA2BLQb6rPhW/BDb0n4gGWPN8lJ
	 1x9AvML6ASKZw==
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
Subject: [PATCH net-next v2 1/7] selftests: rds: Increase selftest timeout
Date: Tue, 28 Apr 2026 15:27:10 -0700
Message-Id: <20260428222716.2960871-2-achender@kernel.org>
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
X-Rspamd-Queue-Id: D827848C988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19693-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


