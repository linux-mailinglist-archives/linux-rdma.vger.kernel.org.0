Return-Path: <linux-rdma+bounces-20644-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOKWEelQBWo+UwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20644-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:34:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDE53DB37
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37F08302F13B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693763BED6E;
	Thu, 14 May 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8hb469O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E693BD64A;
	Thu, 14 May 2026 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733218; cv=none; b=r+AheGduqWR7lQ1KChu59F5g5B42Cac0JkD4qlVS3kyhb8T43CwChkRIeHH3cRzBDmdTQAtyDyQCm4hNZ/owMORlbsT1rSZgCkePcz0knFLQp7/fmFru9ECuhUSr+xQHq/x6zyvGrH/kCNKRU6PZ4iXxjv6DzxXisYGqbTEn1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733218; c=relaxed/simple;
	bh=hSC/JaO/ThVa5xzG63snGg2hC7AsjIO3Wim4yOFSe4M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5aR2Toy8C+QGNiw+3LJf/aoo9W/7zHBlbE2mRkaWClnCIlbXcf5452Nuz4FfThUAf4sPujX8Y1EjP8lNgrbcATxhI/8L+Bh6NicjPSRDtvKxmy9nKJS+CtjCVd3QcnZhcfSWZjCcTrAGy9TrxKAS3UfJPPVykdfh9an+OWFA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8hb469O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EA5C2BCB7;
	Thu, 14 May 2026 04:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733217;
	bh=hSC/JaO/ThVa5xzG63snGg2hC7AsjIO3Wim4yOFSe4M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T8hb469OyHZMjy01VXQtxT1um36KOZCpEeS/Qn0kXMq9S74DmUhnAc+yvHzxU9e6l
	 qBGGfcT6k9JTSr0ZQyfkP8DrhlkhL+xRA5ZKPAeTMHdh7CS5otlRs+OMvhyX8z8Z2A
	 z9o8BiQ/SO6lWStOvhExK7NOEyutrjGtqFA5mKGVYb+TBqZ8G3mwiz7GckbyGhCNfD
	 5xkj7CNIHHSw/qYuwcwEsX+9gnBkUYzAnWq+FeDmTEW0oU0cKe+Wfp24cqVVt/Sjav
	 PgDUCHqmZcJiymx4kyLhl8biMCXVPf0z61WxQBCQpfRkLlyTuDOQkoL32oCSIC4rhI
	 X4w4TxvWdY7XQ==
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
Subject: [PATCH net-next v2 8/9] selftests: rds: Add ROCE support to test.py
Date: Wed, 13 May 2026 21:33:29 -0700
Message-Id: <20260514043330.1718969-9-achender@kernel.org>
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
X-Rspamd-Queue-Id: 2CFDE53DB37
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
	TAGGED_FROM(0.00)[bounces-20644-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.py:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch adds support for testing rds rdma over ROCE in test.py
A new -T flag is added, which takes a transport option, tcp or rdma.
A new setup_rdma() function is added that will configure rdma
interfaces and sockets for use in the test case.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 217 +++++++++++++++++++++---
 1 file changed, 191 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 7738c7e2af36..15d5c9489771 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -11,10 +11,12 @@ import errno
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
@@ -41,6 +43,27 @@ tcp_addrs = [
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
+
+tap_idx = 0
+nr_pass = 0
+nr_fail = 0
 
 # Helper function for creating a socket inside a network namespace.
 # We need this because otherwise RDS will detect that the two TCP
@@ -168,7 +191,7 @@ def verify_hashes(snd_hashes, rcv_hashes):
         ksft_pr(f"{key[0]}/{key[1]}: ok")
     return 0
 
-def snd_rcv_packets(addrs, netns_list):
+def snd_rcv_packets(env):
     """
     Send packets on the given network interfaces
 
@@ -176,10 +199,25 @@ def snd_rcv_packets(addrs, netns_list):
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
@@ -209,9 +247,10 @@ def snd_rcv_packets(addrs, netns_list):
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
 
@@ -246,8 +285,8 @@ def signal_handler(_sig, _frame):
     """
     Test timed out signal handler
     """
-    ksft_pr("Test timed out")
-    print("not ok 1 rds selftest")
+    ksft_pr(f"Test timed out: {signal_handler_label}")
+    print(f"not ok {tap_idx} rds selftest {signal_handler_label}")
     sys.exit(1)
 
 def setup_tcp():
@@ -313,12 +352,107 @@ def teardown_tcp():
     cmd(f"ip netns del {NET0}", fail=False)
     cmd(f"ip netns del {NET1}", fail=False)
 
+def get_iface_mac(iface):
+    """Return the MAC address of a local network interface."""
+    out = subprocess.check_output(['ip', 'link', 'show', iface], text=True)
+    mac = re.search(r'link/ether\s+([0-9a-f:]+)', out)
+    if not mac:
+        raise RuntimeError(f"Cannot determine MAC address of {iface}")
+    return mac.group(1)
+
+def setup_rdma():
+    """
+    Configure rdma network
+    """
+
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
+def teardown_rdma():
+    """
+    Tear down the rdma network configured by setup_rdma().
+    """
+
+    # remove links left over by previously interrupted run.
+    cmd(f'rdma link del {RXE_DEV0}', fail=False)
+    cmd(f'rdma link del {RXE_DEV1}', fail=False)
+    cmd(f'ip link del {VETH_RDMA0}', fail=False)
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
@@ -338,28 +472,59 @@ PACKET_DUPLICATE=str(args.duplicate)+'%'
 # teardown_tcp first means stop_pcaps (registered second) runs first,
 # killing tcpdumps before their namespaces go away.
 atexit.register(teardown_tcp)
+atexit.register(teardown_rdma)
 atexit.register(stop_pcaps)
 
-setup_tcp()
+# check transport is either tcp or rdma
+transports = [t.strip() for t in args.transport.split(',')]
+for t in transports:
+    if t not in ('tcp', 'rdma'):
+        raise SystemExit(f"test.py: unknown transport: {t!r}")
+
+# Set up all requested transports upfront so network plumbing is
+# ready before any test runs.
+transport_envs = {}
+FLAGS = 0
+if 'tcp' in transports:
+    setup_tcp()
+    transport_envs['tcp'] = {
+        'addrs': tcp_addrs,
+        'netns': [NET0, NET1],
+        'flags': FLAGS | OP_FLAG_TCP,
+    }
+
+if 'rdma' in transports:
+    setup_rdma()
+    transport_envs['rdma'] = {
+        'addrs': rdma_addrs,
+        'netns': None,
+        'flags': FLAGS | OP_FLAG_RDMA,
+    }
 
 print("TAP version 13")
-print("1..1")
+print(f"1..{len(transport_envs)}")
+
+for transport, tenv in transport_envs.items():
+    tap_idx += 1
 
-# add a timeout
-if args.timeout > 0:
-    signal.alarm(args.timeout)
-    signal.signal(signal.SIGALRM, signal_handler)
+    # add a timeout
+    if args.timeout > 0:
+        signal_handler_label = transport
+        signal.alarm(args.timeout)
+        signal.signal(signal.SIGALRM, signal_handler)
 
-ret = snd_rcv_packets(tcp_addrs, [NET0, NET1])
+    ret = snd_rcv_packets(tenv)
 
-# cancel timeout
-signal.alarm(0)
+    if ret == 0:
+        ksft_pr("Success")
+        print(f"ok {tap_idx} rds selftest {transport}")
+        nr_pass += 1
+    else:
+        print(f"not ok {tap_idx} rds selftest {transport}")
+        nr_fail += 1
 
-if ret == 0:
-    ksft_pr("Success")
-    print("ok 1 rds selftest")
-else:
-    print("not ok 1 rds selftest")
+    # cancel timeout
+    signal.alarm(0)
 
-ksft_pr(f"Totals: pass:{1-ret} fail:{ret} skip:0")
-sys.exit(ret)
+ksft_pr(f"Totals: pass:{nr_pass} fail:{nr_fail} skip:0")
+sys.exit(1 if nr_fail else 0)
-- 
2.25.1


