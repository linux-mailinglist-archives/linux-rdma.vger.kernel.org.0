Return-Path: <linux-rdma+bounces-20359-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAT5AjOEAWoFcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20359-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:24:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DA50919A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7752D302D5F4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA137CD31;
	Mon, 11 May 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMp12znt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771237CD46;
	Mon, 11 May 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484198; cv=none; b=AlLYOufn9c/9qunjzV32X/z1Cdc0DYXEjvSBE8o5eYCIf8OVlq22dgfTxlObtkJVEnoqBisN2HraKsJxNioSDE+PQHBC9nd98R5Xk5D4eNi3Df4ixeMPViYEi3Qb47PTpUnvxvHdaKbLsTggMiLcTSqa7+g1jlzx7b1smOn7u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484198; c=relaxed/simple;
	bh=NXXybn+rY1CHv9Pdm6W9FBf9nazT/Mjk0vZ8z6N++Jo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omNPkl9vJFw1cgm8tIBE4pJGBLgxDXG4zDSU6HXqzw2BEiG66y/T7ME8lQCSMFex+twcZd5e07zl2c4HkOV0fXDpLHpPiMSAN+ORabVxtPyl0lsKgH2tHizhlo/O2UIAVXyG+LlbbNzLejDTJ5+2ahVQzsA5p+UvmXhX7WfOMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMp12znt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6223C2BCF5;
	Mon, 11 May 2026 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484198;
	bh=NXXybn+rY1CHv9Pdm6W9FBf9nazT/Mjk0vZ8z6N++Jo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TMp12znt8KlFdcvGH1x9nmp72oHfyhKY6Hm//KkJI+fuXG2Xcf/8woURHjT1w+2ji
	 QM9QSM+DEh8+BavJzUe1buHLB+TNewGWf+4Bd4i5ku4sGAbziP2YvEd3eE3dvc7sxH
	 V0nRpX+kyY2g/mDtlLKuPQpte3gWq4D+qNJM622mPzy5AmrLZtihNsWa9DAQsDIZNW
	 eXA/WzKmfeWyRZVUtYnH7s8xfSVJJunlBUz1fYhiSUXcQomQAoDfK0kZJBnRCa3jq5
	 VR/W075S7eCmYjVziQq7viGT/9eofzq8TcBy2EuFC530ftCMava3AB6FPC3Pdqkdhe
	 7TJd63SemTOjg==
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
Subject: [PATCH net-next v1 1/9] selftests: rds: Capitalize ret global in test.py
Date: Mon, 11 May 2026 00:23:08 -0700
Message-Id: <20260511072316.1174045-2-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511072316.1174045-1-achender@kernel.org>
References: <20260511072316.1174045-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F1DA50919A
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
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20359-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Global variables outside of functions should be capitalized to avoid
pylint complaints.  Fix this before refactoring to avoid complaints
later.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 6db606779231..d78c00226e7b 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -291,29 +291,29 @@ stop_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-ret = 0
+RC = 0
 for (sender, receiver), send_hash in send_hashes.items():
     recv_hash = recv_hashes.get((sender, receiver))
 
     if recv_hash is None:
         ksft_pr("FAIL: No data received")
-        ret = 1
+        RC = 1
         break
 
     if send_hash.hexdigest() != recv_hash.hexdigest():
         ksft_pr("FAIL: Send/recv mismatch")
         ksft_pr("hash expected:", send_hash.hexdigest())
         ksft_pr("hash received:", recv_hash.hexdigest())
-        ret = 1
+        RC = 1
         break
 
     ksft_pr(f"{sender}/{receiver}: ok")
 
-if ret == 0:
+if RC == 0:
     ksft_pr("Success")
     print("ok 1 rds selftest")
 else:
     print("not ok 1 rds selftest")
 
-ksft_pr(f"Totals: pass:{1-ret} fail:{ret} skip:0")
-sys.exit(ret)
+ksft_pr(f"Totals: pass:{1-RC} fail:{RC} skip:0")
+sys.exit(RC)
-- 
2.25.1


