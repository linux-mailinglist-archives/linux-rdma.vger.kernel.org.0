Return-Path: <linux-rdma+bounces-20366-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CAbOLyEAWoFcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20366-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:26:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127B50927B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F1F3041795
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE037D121;
	Mon, 11 May 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSQ5pR5t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094237F8C3;
	Mon, 11 May 2026 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484203; cv=none; b=qKvGPaPCzrts/fY2f60QioDj7J+mOSrH91qPTYvsIjSFe4j1+hP2NTW57OkvIrvg4kxvQW3hzYadd20spIuARM9UlTO7qdZAmMuea/1v56d8OEZnehl100QLi3ukXrb+MLAh+DAkM4Rq7tMCLZN68k0fYk+tFEyfUIb/d6aJp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484203; c=relaxed/simple;
	bh=rTakrw5pv/yDx+pTwHDurC85GdyvzaEYt/QlQgfsw/M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnV/Am7/5GC4oOowwn2Qqw/gb6Z17xnwImW7+h8pPjwLQYNdeFR0XSM7CX7UM00/hraWh5CXCaF+hUy+KQ1Tub/QX7d1Ib+N3oXShRi4lLpSPa8Fs8VDLudLDkIhnefY1uYsSlkgmAKiA0eKT6sy2BKQmZLsxiHzfF+LQ3HNztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSQ5pR5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE6C2BCF6;
	Mon, 11 May 2026 07:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484203;
	bh=rTakrw5pv/yDx+pTwHDurC85GdyvzaEYt/QlQgfsw/M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oSQ5pR5tNDf0ngs+mYHLTUWlZBop2KbdcPsODCet/ZIkokLLuo18KIZPymN7rY6vT
	 8orslziVggiwgfoHJjOQdG+Yyf9PWosGSq+zAv8VfEQ+bmd2kudzw/6d61iU0JO7db
	 O3AgVrnxzwE3J1uSVjNPPE8M6M/MtlD7ucWFhaVk4nuHBRqVRNKoTGWSQY+Y+n3oI/
	 GeUOsRYn1vGdPB005YZKYSQ3zHD4OstVyuBr5Ub1IYdCVV9MEdA7rXZKwnio6m+Ffh
	 34zaCC6QMFylsXlScXiWskedFMq8hXzQ7DO52NNBVoQIBz+YavKZBvOFvmyAgQK0Es
	 SAyKNXXXxxj5Q==
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
Subject: [PATCH net-next v1 8/9] selftests: rds: Add ROCE support to test.py
Date: Mon, 11 May 2026 00:23:15 -0700
Message-Id: <20260511072316.1174045-9-achender@kernel.org>
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
X-Rspamd-Queue-Id: 8127B50927B
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
	TAGGED_FROM(0.00)[bounces-20366-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test.py:url]
X-Rspamd-Action: no action

This patch adds support for testing rds rdma over ROCE in test.py
A new -T flag is added, which takes a transport option, tcp or rdma.
A new setup_rdma() function is added that will configure rdma
interfaces and sockets for use in the test case.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 196 ++++++++++++++++++++----
 1 file changed, 169 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 38f6100a6e33..9ec9a206fe93 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -10,16 +10,18 @@ import errno
 import hashlib
 import os
 import select
+import re
 import signal
 import socket
 import subprocess
 import sys
+import time
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
 # pylint: disable-next=wrong-import-position,import-error,no-name-in-module
-from lib.py.utils import ip # noqa: E402
+from lib.py.utils import ip, cmd # noqa: E402
 # pylint: disable-next=wrong-import-position,import-error,no-name-in-module
 from lib.py.ksft import ksft_pr # noqa: E402
 
@@ -40,6 +42,23 @@ tcp_addrs = [
     ('10.0.0.2', 20000),
 ]
 
+# RDMA network configs
+RXE_DEV0 = 'rxe0'
+RXE_DEV1 = 'rxe1'
+
+VETH_RDMA0 = 'veth_rdma0'
+VETH_RDMA1 = 'veth_rdma1'
+
+rdma_addrs = [
+    ('10.0.0.3', 30000),
+    ('10.0.0.4', 30000),
+]
+
+# send_packets flag space
+OP_FLAG_TCP     = 0x1
+OP_FLAG_RDMA    = 0x2
+
+signal_handler_label = ""
 
 # Helper function for creating a socket inside a network namespace.
 # We need this because otherwise RDS will detect that the two TCP
@@ -167,7 +186,7 @@ def verify_hashes(snd_hashes, rcv_hashes):
         ksft_pr(f"{key[0]}/{key[1]}: ok")
     return 0
 
-def snd_rcv_packets(addrs, netns_list):
+def snd_rcv_packets(env):
     """
     Send packets on the given network interfaces
 
@@ -175,10 +194,25 @@ def snd_rcv_packets(addrs, netns_list):
     :param netns_list: list of network namespaces
     """
 
-    sockets = [
-        netns_socket(netns_list[0], socket.AF_RDS, socket.SOCK_SEQPACKET),
-        netns_socket(netns_list[1], socket.AF_RDS, socket.SOCK_SEQPACKET),
-    ]
+    addrs = env["addrs"]
+    netns_list = env["netns"]
+    flags = env.get("flags", 0)
+
+    if (flags & OP_FLAG_TCP) and (flags & OP_FLAG_RDMA):
+        raise RuntimeError(f"Invalid transport flag sets multiple transports: {flags}")
+
+    if flags & OP_FLAG_TCP:
+        sockets = [
+            netns_socket(netns_list[0], socket.AF_RDS, socket.SOCK_SEQPACKET),
+            netns_socket(netns_list[1], socket.AF_RDS, socket.SOCK_SEQPACKET),
+        ]
+    elif flags & OP_FLAG_RDMA:
+        sockets = [
+            socket.socket(socket.AF_RDS, socket.SOCK_SEQPACKET),
+            socket.socket(socket.AF_RDS, socket.SOCK_SEQPACKET),
+        ]
+    else:
+        raise RuntimeError(f"Invalid transport flag sets no transports: {flags}")
 
     for s, addr in zip(sockets, addrs):
         s.bind(addr)
@@ -208,9 +242,10 @@ def snd_rcv_packets(addrs, netns_list):
             nr_recv = recv_burst(ep, sockets, addrs, recv_hashes, nr_recv)
 
         # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
-        for net in netns_list:
-            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
-            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
+        if netns_list:
+            for net in netns_list:
+                ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
+                ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
 
     ksft_pr("done", nr_send, nr_recv)
 
@@ -245,9 +280,9 @@ def signal_handler(_sig, _frame):
     """
     Test timed out signal handler
     """
-    ksft_pr("Test timed out")
+    ksft_pr(f"Test timed out: {signal_handler_label}")
     stop_pcaps()
-    print("not ok 1 rds selftest")
+    print("not ok 1 rds selftest "+signal_handler_label)
     sys.exit(1)
 
 def setup_tcp():
@@ -299,12 +334,93 @@ def setup_tcp():
              corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
              {PACKET_DUPLICATE}")
 
+def get_iface_mac(iface):
+    """Return the MAC address of a local network interface."""
+    out = subprocess.check_output(['ip', 'link', 'show', iface], text=True)
+    mac = re.search(r'link/ether\s+([0-9a-f:]+)', out)
+    if not mac:
+        raise RuntimeError(f"Cannot determine MAC address of {iface}")
+    return mac.group(1)
+
+def setup_rdma():
+    # remove links left over by previously interrupted run.
+    cmd(f'rdma link del {RXE_DEV0}', fail=False)
+    cmd(f'rdma link del {RXE_DEV1}', fail=False)
+    cmd(f'ip link del {VETH_RDMA0}', fail=False)
+
+    # use call here since modprobe may fail if the rdma_rxe
+    # module is built-in
+    subprocess.call(['modprobe', 'rdma_rxe'],
+                    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+
+    ip(f"link add {VETH_RDMA0} type veth peer name {VETH_RDMA1}")
+
+    ip(f"link set {VETH_RDMA0} up")
+    ip(f"link set {VETH_RDMA1} up")
+
+    # Since both addresses are in the same namespace, the source address
+    # is always local, so enable accept_local
+    cmd(f"/usr/sbin/sysctl -q net.ipv4.conf.{VETH_RDMA0}.accept_local=1")
+    cmd(f"/usr/sbin/sysctl -q net.ipv4.conf.{VETH_RDMA1}.accept_local=1")
+
+    # Reverse path filters must be disabled so that the local routes don't
+    # cause RPF failures.
+    cmd(f"/usr/sbin/sysctl -q net.ipv4.conf.{VETH_RDMA0}.rp_filter=0")
+    cmd(f"/usr/sbin/sysctl -q net.ipv4.conf.{VETH_RDMA1}.rp_filter=0")
+
+    # add addresses
+    ip(f"addr add {rdma_addrs[0][0]}/32 dev {VETH_RDMA0}")
+    ip(f"addr add {rdma_addrs[1][0]}/32 dev {VETH_RDMA1}")
+
+    # add routes
+    ip(f"route add {rdma_addrs[1][0]}/32 dev {VETH_RDMA0}")
+    ip(f"route add {rdma_addrs[0][0]}/32 dev {VETH_RDMA1}")
+
+    # ARP will not resolve neighbor IPs on /32 routes without a subnet.
+    # Avoid this by adding neighbors directly so RDMA CM can populate path
+    # records with correct mac addrs without waiting for the ARP.
+    mac0 = get_iface_mac(VETH_RDMA0)
+    mac1 = get_iface_mac(VETH_RDMA1)
+    ip(f"neigh add {rdma_addrs[1][0]} lladdr {mac1} dev {VETH_RDMA0} nud permanent")
+    ip(f"neigh add {rdma_addrs[0][0]} lladdr {mac0} dev {VETH_RDMA1} nud permanent")
+
+    cmd(f'rdma link add {RXE_DEV0} type rxe netdev {VETH_RDMA0}')
+    cmd(f'rdma link add {RXE_DEV1} type rxe netdev {VETH_RDMA1}')
+
+    time.sleep(1)  # allow RXE devices to initialise
+
+    # Start a packet capture on each network
+    if logdir is not None:
+        pcap = logdir+'/rds-'+'roce.pcap'
+
+        tcpdump_cmd = ['/usr/sbin/tcpdump']
+        sudo_user = os.environ.get('SUDO_USER')
+        if sudo_user:
+            tcpdump_cmd.extend(['-Z', sudo_user])
+        tcpdump_cmd.extend(['-i', 'any', '-w', pcap])
+
+        # pylint: disable-next=consider-using-with
+        p = subprocess.Popen(tcpdump_cmd,
+                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+        tcpdump_procs.append(p)
+
+    # simulate packet loss, duplication and corruption
+    for iface in [VETH_RDMA0, VETH_RDMA1]:
+        cmd(f"/usr/sbin/tc qdisc add dev {iface} root netem  \
+             corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
+             {PACKET_DUPLICATE}")
+
 #Parse out command line arguments.  We take an optional
 # timeout parameter and an optional log output folder
 parser = argparse.ArgumentParser(description="init script args",
                   formatter_class=argparse.ArgumentDefaultsHelpFormatter)
 parser.add_argument("-d", "--logdir", action="store",
                     help="directory to store logs", default=None)
+parser.add_argument("-T", "--transport", default="tcp",
+                    help="Comma-separated list of transports to test: "
+                         "tcp, rdma, or tcp,rdma.  Each matching test "
+                         "is run once per transport.  "
+                         "'rdma' requires CONFIG_RDS_RDMA and rdma_rxe.")
 parser.add_argument('-t', '--timeout', help="timeout to terminate hung test",
                     type=int, default=0)
 parser.add_argument('-l', '--loss', help="Simulate tcp packet loss",
@@ -319,28 +435,54 @@ PACKET_LOSS=str(args.loss)+'%'
 PACKET_CORRUPTION=str(args.corruption)+'%'
 PACKET_DUPLICATE=str(args.duplicate)+'%'
 
-setup_tcp()
+# check transport is either tcp or rdma
+transports = [t.strip() for t in args.transport.split(',')]
+for t in transports:
+    if t not in ('tcp', 'rdma'):
+        raise SystemExit(f"test.py: unknown transport: {t!r}")
 
 print("TAP version 13")
 print("1..1")
 
-# add a timeout
-if args.timeout > 0:
-    signal.alarm(args.timeout)
-    signal.signal(signal.SIGALRM, signal_handler)
-
-RC = snd_rcv_packets(tcp_addrs, [NET0, NET1])
-
-# cancel timeout
-signal.alarm(0)
+# Set up all requested transports upfront so network plumbing is
+# ready before any test runs.
+transport_envs = {}
+flags = 0
+if 'tcp' in transports:
+    setup_tcp()
+    transport_envs['tcp'] = {
+        'addrs': tcp_addrs,
+        'netns': [NET0, NET1],
+        'flags': flags | OP_FLAG_TCP,
+    }
+
+if 'rdma' in transports:
+    setup_rdma()
+    transport_envs['rdma'] = {
+        'addrs': rdma_addrs,
+        'netns': None,
+        'flags': flags | OP_FLAG_RDMA,
+    }
+
+for transport, env in transport_envs.items():
+    # add a timeout
+    if args.timeout > 0:
+        signal_handler_label = transport
+        signal.alarm(args.timeout)
+        signal.signal(signal.SIGALRM, signal_handler)
+
+    RC = snd_rcv_packets(env)
+
+    # cancel timeout
+    signal.alarm(0)
+
+    if RC == 0:
+        ksft_pr("Success")
+        print("ok 1 rds selftest "+transport)
+    else:
+        print("not ok 1 rds selftest "+transport)
 
 stop_pcaps()
 
-if RC == 0:
-    ksft_pr("Success")
-    print("ok 1 rds selftest")
-else:
-    print("not ok 1 rds selftest")
-
 ksft_pr(f"Totals: pass:{1-RC} fail:{RC} skip:0")
 sys.exit(RC)
-- 
2.25.1


