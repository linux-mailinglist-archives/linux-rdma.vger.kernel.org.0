Return-Path: <linux-rdma+bounces-19899-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKXUBcUx+GlBrQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19899-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:42:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DA4B89C8
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A647B3007B94
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B92D1914;
	Mon,  4 May 2026 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K20D9JCu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1792C21C3;
	Mon,  4 May 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873309; cv=none; b=BtJ9kBzJmT8i1UDlWUc/Zv/4J6hibBvsGnFW/by50C0HODuCLXPAFBnLXDflvSDmBEbTbTC0AY1GhD6X7gy2veKwpo8nbCjCR3pHXLB0JBRUGkN7LxDH5M7iNNPxggKQK3gZa2fQ9d5YPB/Qu2tBHP9D+BM+EMOHSrF5MNEWnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873309; c=relaxed/simple;
	bh=GHnhpE7QrcXGRTTtf6gkxbHNmub/XiSwpyrPsA7iBnA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SE7MAJXvJDGbtMgQZfWC/W5ud2EQieQgWgF3WQmz3Lrm+y3hDzwh7661eenB3MJ462+0yrdrUK8cqnB8guQYwVWU0UYTQGUqAw1IBWvJ/hmL0kCGYYXN1lYqjzJJqshLnhcDPHMDSuxWaACQhGwkZUBLsNI5Z8ZSXGgshyu88J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K20D9JCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16251C2BCF4;
	Mon,  4 May 2026 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873309;
	bh=GHnhpE7QrcXGRTTtf6gkxbHNmub/XiSwpyrPsA7iBnA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K20D9JCunDUvr3Wy1jpclTRG5d6yxzp72MARcYoo3cC3ZF6UUobmNrtHAK+nI3x/x
	 m1yGl/phXXE+I8ihVbWWZfUdJolKLyiQBaYda+VOYFch4B2N92hjCzFM9Tnm0IXC5A
	 2/vFtXSShAdKmvKPobo4uzTQYge/Xn+KgM3Eg67HWCSeOizk1FqPkrGgOpPP1C3Nfg
	 Srm5qSaRKMYACBN+4bAu7ZOH6tpFul/huwKVnXEdtTN7jXoEkAuS3i8AqQuoHxQyf1
	 eaSkm/eC1y8rXpL0dVj7B54TIkG7svm/MW0X6MWyiN9Zutnmmt7Gc/JS9pOqaQz/vc
	 S6MoXGhw3uyRA==
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
Subject: [PATCH net-next v3 07/10] selftests: rds: Remove tmp pcaps
Date: Sun,  3 May 2026 22:41:40 -0700
Message-Id: <20260504054143.4027538-8-achender@kernel.org>
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
X-Rspamd-Queue-Id: B93DA4B89C8
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
	TAGGED_FROM(0.00)[bounces-19899-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This patch removes the initial tmp tcpdumps and instead saves
the pcaps directly to the logdir if it is set.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 7a3616ac288f..a7be57ef6ece 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -14,8 +14,6 @@ import signal
 import socket
 import subprocess
 import sys
-import tempfile
-import shutil
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
@@ -133,17 +131,16 @@ tcpdump_procs = []
 if logdir is not None:
     for net in [NET0, NET1]:
         pcap = logdir+'/'+net+'.pcap'
-        fd, pcap_tmp = tempfile.mkstemp(suffix=".pcap", prefix=f"{net}-", dir="/tmp")
 
         tcpdump_cmd = ['ip', 'netns', 'exec', net, '/usr/sbin/tcpdump']
         sudo_user = os.environ.get('SUDO_USER')
         if sudo_user:
             tcpdump_cmd.extend(['-Z', sudo_user])
-        tcpdump_cmd.extend(['-i', 'any', '-w', pcap_tmp])
+        tcpdump_cmd.extend(['-i', 'any', '-w', pcap])
 
         # pylint: disable-next=consider-using-with
         p = subprocess.Popen(tcpdump_cmd)
-        tcpdump_procs.append((p, pcap_tmp, pcap, fd))
+        tcpdump_procs.append(p)
 
 # simulate packet loss, duplication and corruption
 for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
@@ -260,11 +257,9 @@ print(f"getsockopt(): {nr_success}/{nr_error}")
 
 if logdir is not None:
     print("Stopping network packet captures")
-    for p, pcap_tmp, pcap, fd in tcpdump_procs:
+    for p in tcpdump_procs:
         p.terminate()
         p.wait()
-        os.close(fd)
-        shutil.move(pcap_tmp, pcap)
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-- 
2.25.1


