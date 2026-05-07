Return-Path: <linux-rdma+bounces-20197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIbnLT4h/WmGYAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 01:33:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678354F0209
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8804430477C2
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2937CD52;
	Thu,  7 May 2026 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlwC/r+r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0936CE14;
	Thu,  7 May 2026 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196737; cv=none; b=hKqirF/oiG15k3a5hFrAmlB+UpFqcC5Nsbpm4MLTMU5F5uBAQTLr/5+9MiLlT1DjpTnfTwaIHSWIZTNoPrqXF3eOWVmSG9YMQmlAefNBTB12QuZ6blBKUoBm05T9LGBNhnLVc5xhCL6TxK2V192TCtgWD0a5EnSl9c+zTZ3qv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196737; c=relaxed/simple;
	bh=ppY6DUORpINH5dqwkso43tlKxT17Gv+DdjmLvzqz8aE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLaLKCVWuldMkL4DLricoCLbZe95iGbjysjWgtHUcGl8oTEtCI7H0URLvXLZpT0rsNdp6mVYzYe975IrAMdoHdYdGwdCc7FSygTv3LPn8nMCimiWRB7M4R6aebV+kQyMyo+qDcmE0RPyb5H/UISUEWWNwKD3veGFP/Z7DH+mIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlwC/r+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5275EC2BCB2;
	Thu,  7 May 2026 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778196736;
	bh=ppY6DUORpINH5dqwkso43tlKxT17Gv+DdjmLvzqz8aE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NlwC/r+r/qLmnBZ+6nn42Vs78xP5ByrtQoHSUguk2MyiP1Y0TZWxUgjA+hVySJfym
	 D2GrjA8f6ryWm/efbXzVp50dJJM9RB3irLexKCkN/rcR7hnOBY4uOc4lm0bNEP2r9g
	 VfZf54m60rlcVrKAgzRYXKq/GdeOvnwNSYLvf0+V9NFastoPPuaVZaztL4ancD7JHV
	 5aNqz0ZRNR5DOzz3YAoM481xuAjJdfIPqOqtn3sQQLmNrn5Og7dc0gBqhshXuexj/i
	 0+5UXlXEut3ufrjUDzY5dafkgFhoGv31XC7HCPBPwdLAxkL9UVQUZsYbknrsch2iSd
	 LqBqxu7ibNw9A==
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
Subject: [PATCH net-next v1 3/3] selftests: rds: Disarm signal alarm on test completion
Date: Thu,  7 May 2026 16:32:13 -0700
Message-Id: <20260507233213.556182-4-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507233213.556182-1-achender@kernel.org>
References: <20260507233213.556182-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 678354F0209
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
	TAGGED_FROM(0.00)[bounces-20197-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A race in stop_pcaps is possible if the test completes and then
times out while waiting for the tcpdump process to exit.  The
signal handler may fire again and needlessly call stop_pcap a
second time.  Fix this by disabling the alarm after normal
test completion.

Also if there are no tcpdump processes to wait on, stop_pcaps can
just exit.  This avoids misleading prints when there are no procs
to collect dumps from.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index e1813e43fb4e..6db606779231 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -77,6 +77,10 @@ def stop_pcaps():
     completes after the signal handler is fired.  List will be empty
     if logdir is not set
     """
+
+    if not tcpdump_procs:
+        return
+
     ksft_pr("Stopping network packet captures")
     while tcpdump_procs:
         proc = tcpdump_procs.pop()
@@ -279,6 +283,10 @@ for s in sockets:
                 pass
 
 ksft_pr(f"getsockopt(): {nr_success}/{nr_error}")
+
+# cancel timeout
+signal.alarm(0)
+
 stop_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
-- 
2.25.1


