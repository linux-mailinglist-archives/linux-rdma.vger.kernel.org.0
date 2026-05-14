Return-Path: <linux-rdma+bounces-20641-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFeDEO9QBWo+UwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20641-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:34:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB8E53DB4C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43B93063C6B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA33B9618;
	Thu, 14 May 2026 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM5eOABZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CF3B19C2;
	Thu, 14 May 2026 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733216; cv=none; b=kplf+HV3g2vQHwSA1RoLlreb5YyaEkQCDMTWKzEI+wcHfMvJ0NkKmd6vuZWG6dX+13w22Cwz2X1ll6xMgPM4G4nvJuJT8ZWdIfO1HmdcFNQm6eYUl7YmI5zQ+J0hRYaiC/O1niCzs+zklZFB6eKYWhNtgHtHxbcB7rrySGNjPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733216; c=relaxed/simple;
	bh=L9OZxjrvL82TT/99Sj3uFYKjWfF7N35xyZ++wFTfdoo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIhdeGWtZaoKpR1niyxtGkXshlaDHhHWCfxcABBO3D3F5Kq47ioAYQZzXlIEhZVgUI/D6VW+q4fh3khx0o73OksFW62CSXWst8XxZnvRPXvTxPzcEBPJWAXamJNRfdS7smSZqE4ehpNZLQToVFRYaUiGgqdmkQIBJ95sWyahlS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM5eOABZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DA1C2BCC7;
	Thu, 14 May 2026 04:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733215;
	bh=L9OZxjrvL82TT/99Sj3uFYKjWfF7N35xyZ++wFTfdoo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PM5eOABZo0eDMaTwrjwDGXAHdembsXMgTPQ5uEFRW8PTU7DKb4U8YpF6inlMEHBq0
	 08jwguVohc4bGqqpU2HcI5tRiYmlNmSZBFfjokgIdLAsLp9P/F2XGpexrc9UT9eCTM
	 TB+xKT8KsmyIHNVNI8JF9IRvBnLzbPTYPDJAxZUUC5i6UPrfhDI9fNPpIzmPV8oFUb
	 U2q4gaMAUqkbB4KiD+g/shXnDDoi9cuIjSMCNX4+hddF36phrGmwGKMP4BELellrme
	 hmaVUFMAyFctPMhKntKm5CRLrlCrvqDmCutkyyztcwTqq3GRtmfg6i7J3NWEGgkUA4
	 X5Wp1ElRxsmYA==
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
Subject: [PATCH net-next v2 5/9] selftests: rds: Add helper function verify_hashes() in test.py
Date: Wed, 13 May 2026 21:33:26 -0700
Message-Id: <20260514043330.1718969-6-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514043330.1718969-1-achender@kernel.org>
References: <20260514043330.1718969-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECB8E53DB4C
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
	TAGGED_FROM(0.00)[bounces-20641-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test.py:url]
X-Rspamd-Action: no action

Hoist the verify hashes logic in test.py into a helper function,
verify_hashes().  This is a preparatory refactoring for the rds over
ROCE series that helps modularize the send/recv logic. Breaking up the
logic now will help avoid large function pylint errors later.  No
functional changes are introduced in this patch.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 33 ++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index ae74117b4174..a3def413d84a 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -152,6 +152,21 @@ def check_info(socks):
 
     ksft_pr(f"getsockopt(): {nr_success}/{nr_error}")
 
+def verify_hashes(snd_hashes, rcv_hashes):
+    """Compare send/recv hashes per (sender, receiver) pair."""
+    for key, snd_hash in snd_hashes.items():
+        rcv_hash = rcv_hashes.get(key)
+        if rcv_hash is None:
+            ksft_pr("FAIL: No data received")
+            return 1
+        if snd_hash.hexdigest() != rcv_hash.hexdigest():
+            ksft_pr("FAIL: Send/recv mismatch")
+            ksft_pr("hash expected:", snd_hash.hexdigest())
+            ksft_pr("hash received:", rcv_hash.hexdigest())
+            return 1
+        ksft_pr(f"{key[0]}/{key[1]}: ok")
+    return 0
+
 def stop_pcaps():
     """Stop tcpdump processes.
 
@@ -310,23 +325,7 @@ stop_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-ret = 0
-for (sender, receiver), send_hash in send_hashes.items():
-    recv_hash = recv_hashes.get((sender, receiver))
-
-    if recv_hash is None:
-        ksft_pr("FAIL: No data received")
-        ret = 1
-        break
-
-    if send_hash.hexdigest() != recv_hash.hexdigest():
-        ksft_pr("FAIL: Send/recv mismatch")
-        ksft_pr("hash expected:", send_hash.hexdigest())
-        ksft_pr("hash received:", recv_hash.hexdigest())
-        ret = 1
-        break
-
-    ksft_pr(f"{sender}/{receiver}: ok")
+ret = verify_hashes(send_hashes, recv_hashes)
 
 if ret == 0:
     ksft_pr("Success")
-- 
2.25.1


