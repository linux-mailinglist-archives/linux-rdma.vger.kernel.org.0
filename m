Return-Path: <linux-rdma+bounces-17690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEiBMEEQrWmBxwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:59:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036F22EA12
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA74C301372B
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E74336EDB;
	Sun,  8 Mar 2026 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne+YBOzG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B633469C;
	Sun,  8 Mar 2026 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949519; cv=none; b=IImhgUNZFxk0ickXEasmQZYZZptlhiUDWeew3t1edG8oyOxglS4kwWEMpI7PjMtQj5qJBssyXMjO6UfszTWdFRjc2D3TEOuwXG90ceQMDYL9dkza+QFOei8AdOVxZyOUJpmd2rYYDnSacD4a+6u/IgNaZEFm6vn+Skjqc4h8J9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949519; c=relaxed/simple;
	bh=G90OIRDw/VUMkYj3G1MxeuZl1L9q28TxclvVpaSB0I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpJFJqwJaKvEwmfKsRI5MNxqgwiOQJ8jQZvq52H6RLAgdmy06Uj5L6Oz7Doh1Xvil39n0DSLhQ5dhjA3ij1d91OM67Eb0pPL+5K4UymTyX+Iiusruqi/RBsM75aC+14nrOI0wHqhKZlj4VWJIDWhixj+vuYd324T74wcxu6S0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne+YBOzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B2AC2BCB0;
	Sun,  8 Mar 2026 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772949519;
	bh=G90OIRDw/VUMkYj3G1MxeuZl1L9q28TxclvVpaSB0I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ne+YBOzGbDLzByLACMmBwXSggJdZRSIvSLKfThvdXSNoGpQfZwne6kSQoFUwo5EMA
	 APvYL0mOpyT71592GQ8E4HSaujiQTE3AAAzdaeM9FJ/YeRz6KSCvkzOXAmUUcC4znY
	 dF3NxaOLu4SlRp74KUN0IALBT7NVe3k1FfgzcqTmTA5cDxYDaw8Pcc53DzLPj/xOX4
	 BW4JUfNRs+s6zl1M3nJylhNdsPVG25VeSbYNBSyggl1iZpLAWWVFhBJQHHP2tMQoTg
	 79nyFj2Q+V3OamgvfYhQi/goFo3S3Lv8mIYwo/zKITIlTQOVs73Xa1submPydpkpe6
	 dbTKImhR8M9HA==
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
Subject: [PATCH net-next v1 3/3] selftests: rds: Fix tcpdump segfault in rds selftests
Date: Sat,  7 Mar 2026 22:58:35 -0700
Message-ID: <20260308055835.1338257-4-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308055835.1338257-1-achender@kernel.org>
References: <20260308055835.1338257-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4036F22EA12
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
	TAGGED_FROM(0.00)[bounces-17690-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

net/rds/test.py sees a segfault in tcpdump when executed through the
ksft runner.

[   21.903713] tcpdump[1469]: segfault at 0 ip 000072100e99126d
sp 00007ffccf740fd0 error 4
[   21.903721]  in libc.so.6[16a26d,7798b149a000+188000]
[   21.905074]  in libc.so.6[16a26d,72100e84f000+188000] likely on
CPU 5 (core 5, socket 0)
[   21.905084] Code: 00 0f 85 a0 00 00 00 48 83 c4 38 89 d8 5b 41 5c
41 5d 41 5e 41 5f 5d c3 0f 1f 44 00 00 48 8b 05 91 8b 09 00 8b 4d ac
64 89 08 <41> 0f b6 07 83 e8 2b a8 fd 0f 84 54 ff ff ff 49 8b 36 4c 89
ff e8
[   21.906760]  likely on CPU 9 (core 9, socket 0)
[   21.913469] Code: 00 0f 85 a0 00 00 00 48 83 c4 38 89 d8 5b 41 5c 41
5d 41 5e 41 5f 5d c3 0f 1f 44 00 00 48 8b 05 91 8b 09 00 8b 4d ac 64 89
08 <41> 0f b6 07 83 e8 2b a8 fd 0f 84 54 ff ff ff 49 8b 36 4c 89 ff e8

The os.fork() call creates extra complexity because it forks the entire
process including the python interpreter.  ip() then calls cmd() which
creates a subprocess.Popen.  We can avoid the extra layering by simply
calling subprocess.Popen directly. Track the process handles directly
and terminate them at cleanup rather than relying on killall. Further
tcpdump's -Z flag attempts to change savefile ownership, which is not
supported by the 9p protocol.  Fix this by writing pcap captures to
"/tmp" during the test and move them to the log directory after tcpdump
exits.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 8256afe6ad6f..93e23e8b256c 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -11,8 +11,8 @@ import signal
 import socket
 import subprocess
 import sys
-from pwd import getpwuid
-from os import stat
+import tempfile
+import shutil
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
@@ -125,14 +125,14 @@ ip(f"-n {NET1} route add {addrs[0][0]}/32 dev {VETH1}")
 ip(f"netns exec {NET0} ping -c 1 {addrs[1][0]}")
 
 # Start a packet capture on each network
+tcpdump_procs = []
 for net in [NET0, NET1]:
-    tcpdump_pid = os.fork()
-    if tcpdump_pid == 0:
-        pcap = logdir+'/'+net+'.pcap'
-        subprocess.check_call(['touch', pcap])
-        user = getpwuid(stat(pcap).st_uid).pw_name
-        ip(f"netns exec {net} /usr/sbin/tcpdump -Z {user} -i any -w {pcap}")
-        sys.exit(0)
+    pcap = logdir+'/'+net+'.pcap'
+    fd, pcap_tmp = tempfile.mkstemp(suffix=".pcap", prefix=f"{net}-", dir="/tmp")
+    p = subprocess.Popen(
+        ['ip', 'netns', 'exec', net,
+         '/usr/sbin/tcpdump', '-i', 'any', '-w', pcap_tmp])
+    tcpdump_procs.append((p, pcap_tmp, pcap, fd))
 
 # simulate packet loss, duplication and corruption
 for net, iface in [(NET0, VETH0), (NET1, VETH1)]:
@@ -248,7 +248,11 @@ for s in sockets:
 print(f"getsockopt(): {nr_success}/{nr_error}")
 
 print("Stopping network packet captures")
-subprocess.check_call(['killall', '-q', 'tcpdump'])
+for p, pcap_tmp, pcap, fd in tcpdump_procs:
+    p.terminate()
+    p.wait()
+    os.close(fd)
+    shutil.move(pcap_tmp, pcap)
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-- 
2.43.0


