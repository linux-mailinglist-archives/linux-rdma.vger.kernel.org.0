Return-Path: <linux-rdma+bounces-19978-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBydHtc6+Wkn7AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19978-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:33:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D24C57B8
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D2130BB8BC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2433451A7;
	Tue,  5 May 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIZkiPnu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A82882B6
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940892; cv=none; b=nL327nApMMgRqxLkQpqpLrp//53Btd3kVUf8IeuEYX/NJ8X2F8DeuztkChuvMyGIr9p3zur+Jo7ekyV2FsPs/9PLtfGBg7f6uBivVWn0oMeWgfKQWWlznbmxWaYLo8rdfPQ7IiXnmrCpKl4zBcfzQl1PFWfe9j7R/YoScIXqZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940892; c=relaxed/simple;
	bh=pZx1YkARmGowE47Fjinw6aGk/1Z/1eqLPS3aBUwU4zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdBepzPMSC0xNKR8Yzxd2j2SuZe2BR5bhZqXQ7HeFsicGo3UOIFh2aHyUWFg240x2xqgVr11XQeyU+c7W5elqx3Y1lHp20XNHCifQEGu9jQ0aLNvHay4r5aP7OwQ+nw8uO5rD8zO7qdt+gii551gO+G5yXil9UpFLilNAEcatoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIZkiPnu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51306c9f2e1so2160831cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940887; x=1778545687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WIazItlhuwSwfo6on4yEwmRZQUGTlMWmE/koiDnhNI=;
        b=lIZkiPnupTpPzOuzkDC4Yw1Cu1BgO3sOdLFuMCHCBhJA9cLhjmz1Bc/scN5fYqaFQ0
         GFp1cMHeEotCuoGPs+fzIkih7NtQvdM+iZxVoJ22X/RrjN3QT5/6wekz3JcYQ+rv6GYO
         /A4iFcfXDCpOKdtjwVXjiHzg+BKYZ3Qzpn/fJCY9YoF95NCCJvO2OO+Nni2MxNBea7H1
         zkewXblbuO3Zo++1gUKEAaqGE9l7KGzIqrypEo5QkcJ24Bepd/hmJ0nlK2mhMSjyeU2I
         wCt3FOM+UssBy6AzGxlBmLYUvrzyRspkzoTm2h8Uf8q0uCVowKqoSnihQZ/vifxhDsPL
         CCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940887; x=1778545687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7WIazItlhuwSwfo6on4yEwmRZQUGTlMWmE/koiDnhNI=;
        b=Iy3D1h7YdtaSY3Caydw1+V1X2FzyQKzDvdwBwVxb5EeztDGUnTaQhfKUs5fOZnIKMP
         +lqoCxoVTFoVxNbfhqlR1SFhldH2jLBlVOgVPZLreq1GYq/aoKsqNRhkHplXJO2JhgEH
         RY/A32cRmXNKU52BJVqw6dfW60+5g7Coj35bQoSELTLwICLfm6x6hXOKT3bXLZ+sWWZF
         kjz7xC/YA1s7hxCpyW3BPgILFx3DbqiScClCw/mRBKlgcQouMkkNCjOXfc4CMwlk/LIW
         tWIEgcDs70b54rMkAee6TY4Fk09UkWNpz5Gq6S/wJQ78M9Qj86f1CFRXUdn9nCkuJiGY
         99Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+2ECmjH73y/PbmR75GVTbRS5Ou4l/RQTGcUTt70aBL7tc8jjIq4WTLD+2QeW4hvJcI5DFclgQS2ql/@vger.kernel.org
X-Gm-Message-State: AOJu0YxURKCNBRonkWZ7FE/crwGKGxIgq+//uasKAM/Zx5vmt22KTNEO
	23Kbel7YYArCDe11N5vRVBWd2acK+P1VFy+bIKlA6K2cKUx5NRpD9L/eEoUbtq/7x+0=
X-Gm-Gg: AeBDiescTD4/jRdfAQRm9oD3VJrTz1iifOg1bcbnN6Lq9cfC6KqqeXjltxQqI/3VgjK
	kOlMgBz/cE32yxnGGzBXZMgRIRP1UtIp/Mbypz6WOpgQLeaEPYAb/kD4nECd+T31q5ikvko3fgF
	392b0tFLyY25+bc/yhHgKsnqQ7gSt5dyFoSCrGkuNWdk+Sluvyx30EaICX88HG5NGZCZQoZAFwW
	yYXHYwpdgjDxuZlH3ZVtdcUYBnzV+3ASxRHoBMOTSfwnGCSsTvIylteIE6Rr9uNRE8HjU+yy4Is
	oq3wqbtKqm6rufPG8e+TJloJ7nCWDICmW3j5ow5NtotwrV864LUzSL61aQsJB1AF5Rdv4Fse2D0
	0k+Gn94FmXkDbkP/j74EnWrnVB3AChF6FFtaDp0ChAfc1i4hHVr6Km1AM5Dr6KKu3EvW5PMceGm
	oHlllZOtPL85O+nMNAC4drA1OP/+CvYTQC1xa0mj/GY4M=
X-Received: by 2002:a05:622a:509:b0:50f:9c33:af18 with SMTP id d75a77b69052e-5104bf964f0mr168578611cf.51.1777940886765;
        Mon, 04 May 2026 17:28:06 -0700 (PDT)
Received: from localhost ([2a03:2880:f804:2e::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8967sm107239171cf.29.2026.05.04.17.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:28:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 17:27:52 -0700
Subject: [PATCH net-next v2 5/6] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-tcp-dm-netkit-v2-5-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
In-Reply-To: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 254D24C57B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19978-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

From: Bobby Eshleman <bobbyeshleman@meta.com>

When sending from a namespace that has access to a netkit device with a
leased queue, the nk primary in the host namespace needs to redirect its
RX to the physical device. This patch adds that redirection bpf program
and teaches the harness to install it.

Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
interface.  The program redirects non-ICMPv6 IPv6 packets to the
physical NIC via bpf_redirect_neigh(), with the physical ifindex
configured via the .bss map.

Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
other BPF attachment methods can use it.

Also add an IPv6 host route on the remote endpoint for the netkit guest
IP via the physical NIC address, so the remote can send packets that
traverse the redirect path to the guest.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    | 41 +++++++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  | 67 ++++++++++++++++++----
 2 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
new file mode 100644
index 000000000000..fe3c127a4fd0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+#define IPPROTO_ICMPV6 58
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+volatile __u32 phys_ifindex;
+
+SEC("tc/ingress")
+int nk_primary_rx_redirect(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct ethhdr *eth;
+	struct ipv6hdr *ip6h;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (ip6h->nexthdr == IPPROTO_ICMPV6)
+		return TC_ACT_OK;
+
+	return bpf_redirect_neigh(phys_ifindex, NULL, 0, 0);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 24ce122abd9c..d569d01ef791 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -336,15 +336,17 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, **kwargs):
+    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
         self._nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
+        self._primary_rx_redirect_attached = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
         self._init_ns_attached = False
+        self._remote_route_added = False
         self._old_fwd = None
         self._old_accept_ra = None
 
@@ -396,8 +398,14 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         self._setup_ns()
         self._attach_bpf()
+        if primary_rx_redirect:
+            self._attach_primary_rx_redirect_bpf()
 
     def __del__(self):
+        if self._primary_rx_redirect_attached:
+            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            self._primary_rx_redirect_attached = False
+
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
             self._tc_attached = False
@@ -406,6 +414,11 @@ class NetDrvContEnv(NetDrvEpEnv):
             cmd(f"tc qdisc del dev {self.ifname} clsact")
             self._tc_clsact_added = False
 
+        if self._remote_route_added:
+            cmd(f"ip -6 route del {self.nk_guest_ipv6}/128",
+                host=self.remote, fail=False)
+            self._remote_route_added = False
+
         if self._nk_host_ifname:
             cmd(f"ip link del dev {self._nk_host_ifname}")
             self._nk_host_ifname = None
@@ -459,6 +472,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
         ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
 
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via {self.addr_v['6']}", host=self.remote)
+        self._remote_route_added = True
+
     def _tc_ensure_clsact(self):
         qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
         for q in qdisc:
@@ -476,6 +492,15 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bss_map_id(self, prog_id):
+        """Find the .bss map ID for a loaded BPF program."""
+        prog_info = bpftool(f"prog show id {prog_id}", json=True)
+        for map_id in prog_info.get("map_ids", []):
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name", "").endswith("bss"):
+                return map_id
+        raise Exception(f"Failed to find .bss map for prog {prog_id}")
+
     def _attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
@@ -487,17 +512,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = True
 
         (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
-        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
-        map_ids = prog_info.get("map_ids", [])
-
-        bss_map_id = None
-        for map_id in map_ids:
-            map_info = bpftool(f"map show id {map_id}", json=True)
-            if map_info.get("name").endswith("bss"):
-                bss_map_id = map_id
-
-        if bss_map_id is None:
-            raise Exception("Failed to find .bss map")
+        bss_map_id = self._find_bss_map_id(self._bpf_prog_id)
 
         ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
         ipv6_bytes = ipv6_addr.packed
@@ -505,3 +520,31 @@ class NetDrvContEnv(NetDrvEpEnv):
         value = ipv6_bytes + ifindex_bytes
         value_hex = ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def _attach_primary_rx_redirect_bpf(self):
+        """Attach BPF redirect program on the primary netkit ingress."""
+        bpf_obj = self.test_dir / "nk_primary_rx_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("Primary RX redirect BPF prog not found")
+
+        cmd(f"tc qdisc add dev {self._nk_host_ifname} clsact")
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+            f" bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._primary_rx_redirect_attached = True
+
+        filters = json.loads(
+            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+        redirect_prog_id = None
+        for bpf in filters:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_primary_rx_redirect'):
+                redirect_prog_id = bpf['options']['prog']['id']
+                break
+        if redirect_prog_id is None:
+            raise Exception("Failed to get primary RX redirect BPF prog ID")
+
+        bss_map_id = self._find_bss_map_id(redirect_prog_id)
+        phys_ifindex_bytes = self.ifindex.to_bytes(4, byteorder='little')
+        value_hex = ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")

-- 
2.52.0


