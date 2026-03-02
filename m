Return-Path: <linux-rdma+bounces-17355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fm7JFImpWm14AUAu9opvQ
	(envelope-from <linux-rdma+bounces-17355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:55:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7951D3483
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A2AD3012503
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F031AA87;
	Mon,  2 Mar 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzoQuEhA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936C30E835;
	Mon,  2 Mar 2026 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430921; cv=none; b=myN9N8ATzsduqYC4gVkRvB59JK0zqQOKNS0m7QN1zlcF0h83Ccq7w53U1J8N0wg3Z6FUnEIEGdhlv3AwrlcKDdE1gOEAmUpmwn4FWw00Ki7x5dZmL5yIVKGLikpj0aTktZuu+BW2w/emtjBJvVVGlRzYjLePB8phPTXuVzv2Fcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430921; c=relaxed/simple;
	bh=a9i51SFKRYGbmIe/uoG8EJrVR4OwCa6BKsOl9BeC7iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY9NVnFm3AsQSTPZG/DHSWDhca+ocIP9b+13onrvfqSIpW3Ak/KZpJlXG0lUuVArCnMLIBzuNaXnFQJEUGj+uyyRGfy+RePrMro55xS14IrmrQ7GClVGHpDIJ2wljufNlUjvGsMVECDCXjjIhGOgc04kQAG/5A2bAEgSIdKGQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzoQuEhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19605C2BC87;
	Mon,  2 Mar 2026 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772430920;
	bh=a9i51SFKRYGbmIe/uoG8EJrVR4OwCa6BKsOl9BeC7iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzoQuEhAKOgMX7eggWOjlOisqPxao6jZrRM7+3Hha0bONsZvPf+JxawtN3LtxlKNS
	 zNRnTpiMSUSJr8/bbsbAxI7tBH2sMwk2ygTs8FAQL6NTWUy/cNg+Rjswdz9n3rZKk7
	 CzmdH8VMdxgyfdEeyC1QEwHV7S+8k+6Uvpikv0sQd34WVA6llk7v0VUwDXy+1C3fK1
	 H8nrMei1ERIBvkG1ZRlmQxI8npeXHmCkDOfZqYrqQdqtd0h5d1f9d9viiNMXZahMse
	 1oqpZyTNBW8dcyzvSjMEPBjatoZYFaE66gJ+6BnEVaq3SooNar802vguIoMextHnoh
	 GMMbB1wrsFXfw==
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
Subject: [PATCH net-next v1 1/2] selftests: rds: Refactor test.py
Date: Sun,  1 Mar 2026 22:55:17 -0700
Message-ID: <20260302055518.301620-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302055518.301620-1-achender@kernel.org>
References: <20260302055518.301620-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17355-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rds_basic.py:url]
X-Rspamd-Queue-Id: 3A7951D3483
X-Rspamd-Action: no action

From: Allison Henderson <allison.henderson@oracle.com>

This patch hoists the send and recv logic from test.py into a helper
module rds_basic.py, keeping the namespace and networking configurations
in the calling test.py script.  This will allow us to reuse the test.py
infrastructure to add additional rds tests.  No functional changes are
added in this initial refactor.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/Makefile     |   1 +
 tools/testing/selftests/net/rds/rds_basic.py | 183 +++++++++++++++++++
 tools/testing/selftests/net/rds/test.py      | 169 +----------------
 3 files changed, 191 insertions(+), 162 deletions(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index 762845cc973c..611ed6f2bf91 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := run.sh
 TEST_FILES := \
 	include.sh \
 	test.py \
+	rds_basic.py \
 # end of TEST_FILES
 
 EXTRA_CLEAN := \
diff --git a/tools/testing/selftests/net/rds/rds_basic.py b/tools/testing/selftests/net/rds/rds_basic.py
new file mode 100755
index 000000000000..49c524e2c72a
--- /dev/null
+++ b/tools/testing/selftests/net/rds/rds_basic.py
@@ -0,0 +1,183 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import ctypes
+import errno
+import hashlib
+import os
+import select
+import socket
+import sys
+
+# Allow utils module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../"))
+from lib.py.utils import ip
+
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+setns = libc.setns
+
+# Helper function for creating a socket inside a network namespace.
+# We need this because otherwise RDS will detect that the two TCP
+# sockets are on the same interface and use the loop transport instead
+# of the TCP transport.
+def netns_socket(netns, *args):
+    """Create a socket inside a network namespace."""
+    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+
+    child = os.fork()
+    if child == 0:
+        # change network namespace
+        with open(f'/var/run/netns/{netns}', encoding='utf-8') as f:
+            try:
+                setns(f.fileno(), 0)
+            except IOError as ioe:
+                print(ioe.errno)
+                print(ioe)
+
+        # create socket in target namespace
+        s = socket.socket(*args)
+
+        # send resulting socket to parent
+        socket.send_fds(u0, [], [s.fileno()])
+
+        sys.exit(0)
+
+    # receive socket from child
+    _, s, _, _ = socket.recv_fds(u1, 0, 1)
+    os.waitpid(child, 0)
+    u0.close()
+    u1.close()
+    return socket.fromfd(s[0], *args)
+
+def run_test(env):
+    """Run basic RDS selftest.
+
+    env is a dictionary provided by test.py and is expected to contain:
+      - 'addrs':   list of (ip, port) tuples matching the sockets
+      - 'netns':   list of network namespace names (for sysctl exercises)
+    """
+    addrs = env['addrs']        # [('10.0.0.1', 10000), ('10.0.0.2', 20000)]
+    netns_list = env['netns']   # ['net0', 'net1']
+
+    sockets = [
+        netns_socket(netns_list[0], socket.AF_RDS, socket.SOCK_SEQPACKET),
+        netns_socket(netns_list[1], socket.AF_RDS, socket.SOCK_SEQPACKET),
+    ]
+
+    for s, addr in zip(sockets, addrs):
+        s.bind(addr)
+        s.setblocking(0)
+
+    fileno_to_socket = {
+        s.fileno(): s for s in sockets
+    }
+
+    addr_to_socket = dict(zip(addrs, sockets))
+
+    socket_to_addr = {
+        s: addr for addr, s in zip(addrs, sockets)
+    }
+
+    send_hashes = {}
+    recv_hashes = {}
+
+    ep = select.epoll()
+
+    for s in sockets:
+        ep.register(s, select.EPOLLRDNORM)
+
+    n = 50000
+    nr_send = 0
+    nr_recv = 0
+
+    while nr_send < n:
+        # Send as much as we can without blocking
+        print("sending...", nr_send, nr_recv)
+        while nr_send < n:
+            send_data = hashlib.sha256(
+                f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
+
+            # pseudo-random send/receive pattern
+            sender = sockets[nr_send % 2]
+            receiver = sockets[1 - (nr_send % 3) % 2]
+
+            try:
+                sender.sendto(send_data, socket_to_addr[receiver])
+                send_hashes.setdefault((sender.fileno(), receiver.fileno()),
+                        hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
+                nr_send = nr_send + 1
+            except BlockingIOError:
+                break
+            except OSError as e:
+                if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
+                    break
+                raise
+
+        # Receive as much as we can without blocking
+        print("receiving...", nr_send, nr_recv)
+        while nr_recv < nr_send:
+            for fileno, eventmask in ep.poll():
+                receiver = fileno_to_socket[fileno]
+
+                if eventmask & select.EPOLLRDNORM:
+                    while True:
+                        try:
+                            recv_data, address = receiver.recvfrom(1024)
+                            sender = addr_to_socket[address]
+                            recv_hashes.setdefault((sender.fileno(),
+                                receiver.fileno()), hashlib.sha256()).update(
+                                        f'<{recv_data}>'.encode('utf-8'))
+                            nr_recv = nr_recv + 1
+                        except BlockingIOError:
+                            break
+
+        # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
+        for net in netns_list:
+            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
+            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
+
+    print("done", nr_send, nr_recv)
+
+    # the Python socket module doesn't know these
+    RDS_INFO_FIRST = 10000
+    RDS_INFO_LAST = 10017
+
+    nr_success = 0
+    nr_error = 0
+
+    for s in sockets:
+        for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
+            # Sigh, the Python socket module doesn't allow us to pass
+            # buffer lengths greater than 1024 for some reason. RDS
+            # wants multiple pages.
+            try:
+                s.getsockopt(socket.SOL_RDS, optname, 1024)
+                nr_success = nr_success + 1
+            except OSError as ose:
+                nr_error = nr_error + 1
+                if ose.errno == errno.ENOSPC:
+                    # ignore
+                    pass
+
+    print(f"getsockopt(): {nr_success}/{nr_error}")
+
+    # We're done sending and receiving stuff, now let's check if what
+    # we received is what we sent.
+    for (sender, receiver), send_hash in send_hashes.items():
+        recv_hash = recv_hashes.get((sender, receiver))
+
+        if recv_hash is None:
+            print("FAIL: No data received")
+            return 1
+
+        if send_hash.hexdigest() != recv_hash.hexdigest():
+            print("FAIL: Send/recv mismatch")
+            print("hash expected:", send_hash.hexdigest())
+            print("hash received:", recv_hash.hexdigest())
+            return 1
+
+        print(f"{sender}/{receiver}: ok")
+
+    print("Success")
+    return 0
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 4a7178d11193..0cb060073f6d 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -2,65 +2,25 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import argparse
-import ctypes
-import errno
-import hashlib
 import os
-import select
 import signal
-import socket
 import subprocess
 import sys
-import atexit
 from pwd import getpwuid
 from os import stat
+import rds_basic
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
 from lib.py.utils import ip
 
-libc = ctypes.cdll.LoadLibrary('libc.so.6')
-setns = libc.setns
-
 net0 = 'net0'
 net1 = 'net1'
 
 veth0 = 'veth0'
 veth1 = 'veth1'
 
-# Helper function for creating a socket inside a network namespace.
-# We need this because otherwise RDS will detect that the two TCP
-# sockets are on the same interface and use the loop transport instead
-# of the TCP transport.
-def netns_socket(netns, *args):
-    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
-
-    child = os.fork()
-    if child == 0:
-        # change network namespace
-        with open(f'/var/run/netns/{netns}') as f:
-            try:
-                ret = setns(f.fileno(), 0)
-            except IOError as e:
-                print(e.errno)
-                print(e)
-
-        # create socket in target namespace
-        s = socket.socket(*args)
-
-        # send resulting socket to parent
-        socket.send_fds(u0, [], [s.fileno()])
-
-        sys.exit(0)
-
-    # receive socket from child
-    _, s, _, _ = socket.recv_fds(u1, 0, 1)
-    os.waitpid(child, 0)
-    u0.close()
-    u1.close()
-    return socket.fromfd(s[0], *args)
-
 def signal_handler(sig, frame):
     print('Test timed out')
     sys.exit(1)
@@ -87,7 +47,7 @@ packet_duplicate=str(args.duplicate)+'%'
 
 ip(f"netns add {net0}")
 ip(f"netns add {net1}")
-ip(f"link add type veth")
+ip("link add type veth")
 
 addrs = [
     # we technically don't need different port numbers, but this will
@@ -137,129 +97,14 @@ if args.timeout > 0:
     signal.alarm(args.timeout)
     signal.signal(signal.SIGALRM, signal_handler)
 
-sockets = [
-    netns_socket(net0, socket.AF_RDS, socket.SOCK_SEQPACKET),
-    netns_socket(net1, socket.AF_RDS, socket.SOCK_SEQPACKET),
-]
-
-for s, addr in zip(sockets, addrs):
-    s.bind(addr)
-    s.setblocking(0)
-
-fileno_to_socket = {
-    s.fileno(): s for s in sockets
-}
-
-addr_to_socket = {
-    addr: s for addr, s in zip(addrs, sockets)
+env = {
+    'addrs': addrs,
+    'netns': [net0, net1],
 }
 
-socket_to_addr = {
-    s: addr for addr, s in zip(addrs, sockets)
-}
-
-send_hashes = {}
-recv_hashes = {}
-
-ep = select.epoll()
-
-for s in sockets:
-    ep.register(s, select.EPOLLRDNORM)
-
-n = 50000
-nr_send = 0
-nr_recv = 0
-
-while nr_send < n:
-    # Send as much as we can without blocking
-    print("sending...", nr_send, nr_recv)
-    while nr_send < n:
-        send_data = hashlib.sha256(
-            f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
-
-        # pseudo-random send/receive pattern
-        sender = sockets[nr_send % 2]
-        receiver = sockets[1 - (nr_send % 3) % 2]
-
-        try:
-            sender.sendto(send_data, socket_to_addr[receiver])
-            send_hashes.setdefault((sender.fileno(), receiver.fileno()),
-                    hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
-            nr_send = nr_send + 1
-        except BlockingIOError as e:
-            break
-        except OSError as e:
-            if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
-                break
-            raise
-
-    # Receive as much as we can without blocking
-    print("receiving...", nr_send, nr_recv)
-    while nr_recv < nr_send:
-        for fileno, eventmask in ep.poll():
-            receiver = fileno_to_socket[fileno]
-
-            if eventmask & select.EPOLLRDNORM:
-                while True:
-                    try:
-                        recv_data, address = receiver.recvfrom(1024)
-                        sender = addr_to_socket[address]
-                        recv_hashes.setdefault((sender.fileno(),
-                            receiver.fileno()), hashlib.sha256()).update(
-                                    f'<{recv_data}>'.encode('utf-8'))
-                        nr_recv = nr_recv + 1
-                    except BlockingIOError as e:
-                        break
-
-    # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
-    for net in [net0, net1]:
-        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
-        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
-
-print("done", nr_send, nr_recv)
-
-# the Python socket module doesn't know these
-RDS_INFO_FIRST = 10000
-RDS_INFO_LAST = 10017
-
-nr_success = 0
-nr_error = 0
-
-for s in sockets:
-    for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
-        # Sigh, the Python socket module doesn't allow us to pass
-        # buffer lengths greater than 1024 for some reason. RDS
-        # wants multiple pages.
-        try:
-            s.getsockopt(socket.SOL_RDS, optname, 1024)
-            nr_success = nr_success + 1
-        except OSError as e:
-            nr_error = nr_error + 1
-            if e.errno == errno.ENOSPC:
-                # ignore
-                pass
-
-print(f"getsockopt(): {nr_success}/{nr_error}")
+ret = rds_basic.run_test(env)
 
 print("Stopping network packet captures")
 subprocess.check_call(['killall', '-q', 'tcpdump'])
 
-# We're done sending and receiving stuff, now let's check if what
-# we received is what we sent.
-for (sender, receiver), send_hash in send_hashes.items():
-    recv_hash = recv_hashes.get((sender, receiver))
-
-    if recv_hash is None:
-        print("FAIL: No data received")
-        sys.exit(1)
-
-    if send_hash.hexdigest() != recv_hash.hexdigest():
-        print("FAIL: Send/recv mismatch")
-        print("hash expected:", send_hash.hexdigest())
-        print("hash received:", recv_hash.hexdigest())
-        sys.exit(1)
-
-    print(f"{sender}/{receiver}: ok")
-
-print("Success")
-sys.exit(0)
+sys.exit(ret)
-- 
2.43.0


