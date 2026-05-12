Return-Path: <linux-rdma+bounces-20440-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEpvEK2AAmpDtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20440-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:21:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19E51829A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF537306FA4D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081722C11D7;
	Tue, 12 May 2026 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKjGJHiW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DC235BE2
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548706; cv=none; b=XDY5jZbyHrjGhmNrCEg7Fcx0RNx4AX+VyLPd+M2Iaczl5IfXLynQnJlrtAyb6QqcOJm2uyQd3L3joMouphiI/5ZIVXyhUc4UNWclB68pLeAkTk7eJe1PY32WYsWhJS0UUu3S2zW9A2GvRr7pmJuaQX9eAKJKDfoX5v316ufZeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548706; c=relaxed/simple;
	bh=wptIkvH9L489Qlo2T7M1mLc4bl4xRw6+9h17Bso5o/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fymM3cmWyKKJSWvXEiAZwI4LKnFY9VpUJl1/dpGvHRxQd8sTXtnlYNGI3L6WJWLoaC9mpWRcA2YpFa8gUaWLAVbaavTUrblfkgkfGRhwJObzFXKe8H9/APG0atDay7/5gXqpEpysaB7IH95piBW3jl6ondZdGrEYiKDHiqUwruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKjGJHiW; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso1810735d50.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 18:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548700; x=1779153500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HA/ybwawhpYacQbiJl7tU2w4tisbAXIL92cuydme34=;
        b=rKjGJHiWhghd1iTJT3pZ54pBwHSbvs3YglrAuibB2ImME9AGVlaNuUTNf9CYGbWuSk
         oxVs7VBNb51VlWMtj+7sQv1k6GlkJMbQBoIn4KLrqqquVSruEX47FDY3zn5W7jhOYIxJ
         5Ahm5KgJlHJNz5QBRkYGryNCfLUD46r9bHN94olC9VC0Qh6oLfBZJUwbTOa5P9BCRUUn
         ZWc3LT1owW3ZryXOB2AyGSllptrh36Q0nu9QAIeMpUuuQ8SbFQdZV6MCPUoE2fL34Y9G
         zR3lGZBfqkwttse7lHsJNSrnnbkI4AusrUSlxY9CmdQdYJsA3k4/tz2iNeAT3Dkakvpx
         /TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548700; x=1779153500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9HA/ybwawhpYacQbiJl7tU2w4tisbAXIL92cuydme34=;
        b=cFHJYIBd0hKxdW0THGFsKX6QtpNcHmffPftclURXJ206C9l6WS4+LkhKxUpkc4FBMp
         PD0xJswkQClqC/RWd2oqRdi+92QFGm4d9T08mUtkMVU8hTKJH8ZSVD3F1Yy1fS4BTlBS
         Jc4yN2N6N4bgNZS6+wy52/uc/vb9nq8zMxufEeqNCz7WomfrB8gu92j1MRoA8CYmBdd9
         GeqjCckJ/vVt+Gd0wKJKzG3EmqP0zavsNlR1w12f91WCOdZwRzfePdb9E0gKWI8eW/xl
         IrfbnnJ0z6HMk8kXysDtAwVdXizXig74tluOXsnomk6DpBnu9um+0C2esH9BDSOklNUY
         DpVA==
X-Forwarded-Encrypted: i=1; AFNElJ+dULArwcquEqSAXLzBOnxZtr9P//AS3xj64SdHpTqpsTA4WwSepqJ7bBcGsZEFPix5hzkXsxtFS5wD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ycplvVhE3WtsTpjszWEqD/RZh6F+ILI/SrmBIqt3g4wyuPR5
	NWh+SKhGqdL0ZOpmOsaa88mxJYlSiJi7zCVN0wFLjpJM84WmC7P5zITY
X-Gm-Gg: Acq92OF2s9wwnmGM1NHoNO1ZdiQVh9anGsB7KzqRYEVw/GHn3aJtXdKI1UvFSV2m2Qg
	GfYaAQpmWLG9tStIyP2KHuwqu5AxqhFI4XzINPezLQZvgDC9fkF/gH6/BaJdOvnELa6dUbG0zY8
	l1m0+H+hmzXsUBrVFKYw8yOQRmaFEXMQn0Jwp65L/RORSGwPrI3ShjIUcGB1AOGsfQc9BV6wXoA
	GOTvUfezi3YAsvPYq84/mSVb46eIcq/KynnLKvdSzgcz5DaOZr1rXFR11S3BbZ80kJN69L3l748
	B88djMEcqdimHcYaIlY1G7AmvciXoK32++Hx21YlujU0CuvhvfGnEfR4djepBCRK6LBzOTIEZkY
	p9O6d10xkFLnDKYysqTkVdqJOTHXkiQLmNfRC4B3Cg4oB1EN2qpUi/f9fSVPhMTALBr5/tQhyn4
	AolCkB/1JLBAfDsV65HWMXBQ==
X-Received: by 2002:a53:d00a:0:b0:650:4aec:29fa with SMTP id 956f58d0204a3-65d94c4bcf9mr14141002d50.38.1778548699610;
        Mon, 11 May 2026 18:18:19 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:21::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96bf418bsm6296068d50.17.2026.05.11.18.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:17:59 -0700
Subject: [PATCH net-next v4 5/8] selftests: drv-net: make attr
 _nk_guest_ifname public
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tcp-dm-netkit-v4-5-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
In-Reply-To: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
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
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: DC19E51829A
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20440-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netns.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:mid,fomichev.me:email]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Subsequent patches will use the _nk_guest_ifname as a public attr for
setting up devmem. Rename to nk_guest_ifname to avoid angering the
linter about the '_' prefix being used for a non-private attr.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/nk_qlease.py |  8 ++++----
 tools/testing/selftests/drivers/net/lib/py/env.py   | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index aa83dc321328..139a91ebd229 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -71,7 +71,7 @@ def test_iou_zcrx(cfg) -> None:
     flow_rule_id = set_flow_rule(cfg)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
     tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
@@ -128,7 +128,7 @@ def test_attach_xdp_with_mp(cfg) -> None:
 
     netdevnl = NetdevFamily()
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
     with bkg(rx_cmd):
         wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
 
@@ -178,7 +178,7 @@ def test_destroy(cfg) -> None:
     ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
     defer(ethtool, f"-X {cfg.ifname} default")
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
     rx_proc = cmd(rx_cmd, background=True)
     wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
 
@@ -196,7 +196,7 @@ def test_destroy(cfg) -> None:
     ip(f"link del dev {cfg._nk_host_ifname}")
     kill_timer.join()
     cfg._nk_host_ifname = None
-    cfg._nk_guest_ifname = None
+    cfg.nk_guest_ifname = None
 
     queue_info = netdevnl.queue_get(
         {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 24ce122abd9c..409b41922245 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -339,7 +339,7 @@ class NetDrvContEnv(NetDrvEpEnv):
     def __init__(self, src_path, rxqueues=1, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
-        self._nk_guest_ifname = None
+        self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
         self._bpf_prog_pref = None
@@ -390,7 +390,7 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         netkit_links.sort(key=lambda x: x['ifindex'])
         self._nk_host_ifname = netkit_links[1]['ifname']
-        self._nk_guest_ifname = netkit_links[0]['ifname']
+        self.nk_guest_ifname = netkit_links[0]['ifname']
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
@@ -409,7 +409,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         if self._nk_host_ifname:
             cmd(f"ip link del dev {self._nk_host_ifname}")
             self._nk_host_ifname = None
-            self._nk_guest_ifname = None
+            self.nk_guest_ifname = None
 
         if self._init_ns_attached:
             cmd("ip netns del init", fail=False)
@@ -448,16 +448,16 @@ class NetDrvContEnv(NetDrvEpEnv):
         cmd("ip netns attach init 1")
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
-        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
+        ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
         ip(f"link set dev {self._nk_host_ifname} up")
         ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
         ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
 
         ip("link set lo up", ns=self.netns)
-        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
-        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
-        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
-        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
+        ip(f"link set dev {self.nk_guest_ifname} up", ns=self.netns)
+        ip(f"-6 addr add fe80::2/64 dev {self.nk_guest_ifname}", ns=self.netns)
+        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self.nk_guest_ifname} nodad", ns=self.netns)
+        ip(f"-6 route add default via fe80::1 dev {self.nk_guest_ifname}", ns=self.netns)
 
     def _tc_ensure_clsact(self):
         qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)

-- 
2.53.0-Meta


