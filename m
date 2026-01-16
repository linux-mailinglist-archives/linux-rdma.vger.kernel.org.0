Return-Path: <linux-rdma+bounces-15613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F188FD2C78E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 07:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15F4A304DD86
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E934DCC7;
	Fri, 16 Jan 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aN0EYFeX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8A34DB6C
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544472; cv=none; b=YzR3v8DO2aB0La8/3yWsxBIHwf0n+tiKdNEkJtD+HM+3xEq8SQj2WG9FLpjwieURMbPTwKcd5UGj3aoIP/wfauBMkWjjFem+fkchPFfpHpc5XWwet/fw4OXT/xqXO6U1sjRJCskbfd2bgWV2FHdtjVWBOJ5Mez1/IPgNmTRwPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544472; c=relaxed/simple;
	bh=9VBL47eqohze6t5E0t6T3XMJeZRUFkea6727za1gW+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSlRax9Fgdw6taxBMRS271emCDfSTteARVS3cpauBwpPq6t2akr53gJ94SBUPws5IYIQR5DSIqUBhXtpCE3vZYhHkH/XfIgBrlPpF+d8M0QaFoKrmb0vUeGG4nrzMQHeYXrWrK2IWYXKmHvmbrVZF9gTJxeZl8zkn6P40Z7p2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aN0EYFeX; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768544468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IukgeRwI0rnJ0F3Z/nKWjDgZvwa4tCZLAXgfQidZ6Mg=;
	b=aN0EYFeXV/31Tmp8bcbXKRvi2Zoh9LOPK4xhSuGAeCI7x+B5loQb+dMozvzWb9XsRoDakw
	lvqGbKhHPf327/n/Bo+BFsM8GXoSrmqOuyobJqaxAiFrW1NZAGvtKeOB4/TA5HbuvJltPs
	rX+wRnsIACIVhHy8vdjaPrTX61I928I=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 2/2] selftests: drv-net: extend HW timestamp test with ioctl
Date: Fri, 16 Jan 2026 06:21:21 +0000
Message-ID: <20260116062121.1230184-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
References: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend HW timestamp tests to check that ioctl interface is not broken
and configuration setups and requests are equal to netlink interface.
Some linter warnings are disabled because of ctypes classes.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:
* improved import and added struct docs
* silenced linter because of ctypes.Structure format
---
 .../selftests/drivers/net/hw/nic_timestamp.py | 128 ++++++++++++++++--
 1 file changed, 120 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nic_timestamp.py b/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
index c1e943d53f19..c632b41e7a23 100755
--- a/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
+++ b/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
@@ -1,15 +1,38 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+# pylint: disable=locally-disabled, invalid-name, attribute-defined-outside-init, too-few-public-methods
 
 """
 Tests related to configuration of HW timestamping
 """
 
 import errno
+import ctypes
+import fcntl
+import socket
 from lib.py import ksft_run, ksft_exit, ksft_ge, ksft_eq, KsftSkipEx
 from lib.py import NetDrvEnv, EthtoolFamily, NlError
 
 
+SIOCSHWTSTAMP = 0x89b0
+SIOCGHWTSTAMP = 0x89b1
+class hwtstamp_config(ctypes.Structure):
+    """ Python copy of struct hwtstamp_config """
+    _fields_ = [
+        ("flags", ctypes.c_int),
+        ("tx_type", ctypes.c_int),
+        ("rx_filter", ctypes.c_int),
+    ]
+
+
+class ifreq(ctypes.Structure):
+    """ Python copy of struct ifreq """
+    _fields_ = [
+        ("ifr_name", ctypes.c_char * 16),
+        ("ifr_data", ctypes.POINTER(hwtstamp_config)),
+    ]
+
+
 def __get_hwtimestamp_support(cfg):
     """ Retrieve supported configuration information """
 
@@ -31,8 +54,29 @@ def __get_hwtimestamp_support(cfg):
     return ctx
 
 
+def __get_hwtimestamp_config_ioctl(cfg):
+    """ Retrieve current TS configuration information (via ioctl) """
+
+    config = hwtstamp_config()
+
+    req = ifreq()
+    req.ifr_name = cfg.ifname.encode()
+    req.ifr_data = ctypes.pointer(config)
+
+    try:
+        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+        fcntl.ioctl(sock.fileno(), SIOCGHWTSTAMP, req)
+        sock.close()
+
+    except OSError as e:
+        if e.errno == errno.EOPNOTSUPP:
+            raise KsftSkipEx("timestamping configuration is not supported via ioctl") from e
+        raise
+    return config
+
+
 def __get_hwtimestamp_config(cfg):
-    """ Retrieve current TS configuration information """
+    """ Retrieve current TS configuration information (via netLink) """
 
     try:
         tscfg = cfg.ethnl.tsconfig_get({'header': {'dev-name': cfg.ifname}})
@@ -43,8 +87,27 @@ def __get_hwtimestamp_config(cfg):
     return tscfg
 
 
+def __set_hwtimestamp_config_ioctl(cfg, ts):
+    """ Setup new TS configuration information (via ioctl) """
+    config = hwtstamp_config()
+    config.rx_filter = ts['rx-filters']['bits']['bit'][0]['index']
+    config.tx_type = ts['tx-types']['bits']['bit'][0]['index']
+    req = ifreq()
+    req.ifr_name = cfg.ifname.encode()
+    req.ifr_data = ctypes.pointer(config)
+    try:
+        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+        fcntl.ioctl(sock.fileno(), SIOCSHWTSTAMP, req)
+        sock.close()
+
+    except OSError as e:
+        if e.errno == errno.EOPNOTSUPP:
+            raise KsftSkipEx("timestamping configuration is not supported via ioctl") from e
+        raise
+
+
 def __set_hwtimestamp_config(cfg, ts):
-    """ Setup new TS configuration information """
+    """ Setup new TS configuration information (via netlink) """
 
     ts['header'] = {'dev-name': cfg.ifname}
     try:
@@ -56,9 +119,9 @@ def __set_hwtimestamp_config(cfg, ts):
     return res
 
 
-def test_hwtstamp_tx(cfg):
+def __perform_hwtstamp_tx(cfg, is_ioctl):
     """
-    Test TX timestamp configuration.
+    Test TX timestamp configuration via either netlink or ioctl.
     The driver should apply provided config and report back proper state.
     """
 
@@ -66,16 +129,37 @@ def test_hwtstamp_tx(cfg):
     ts = __get_hwtimestamp_support(cfg)
     tx = ts['tx']
     for t in tx:
+        res = None
         tscfg = orig_tscfg
         tscfg['tx-types']['bits']['bit'] = [t]
-        res = __set_hwtimestamp_config(cfg, tscfg)
+        if is_ioctl:
+            __set_hwtimestamp_config_ioctl(cfg, tscfg)
+        else:
+            res = __set_hwtimestamp_config(cfg, tscfg)
         if res is None:
             res = __get_hwtimestamp_config(cfg)
+        resioctl = __get_hwtimestamp_config_ioctl(cfg)
         ksft_eq(res['tx-types']['bits']['bit'], [t])
+        ksft_eq(resioctl.tx_type, t['index'])
     __set_hwtimestamp_config(cfg, orig_tscfg)
 
+def test_hwtstamp_tx_netlink(cfg):
+    """
+    Test TX timestamp configuration setup via netlink.
+    The driver should apply provided config and report back proper state.
+    """
+    __perform_hwtstamp_tx(cfg, False)
+
+
+def test_hwtstamp_tx_ioctl(cfg):
+    """
+    Test TX timestamp configuration setup via ioctl.
+    The driver should apply provided config and report back proper state.
+    """
+    __perform_hwtstamp_tx(cfg, True)
+
 
-def test_hwtstamp_rx(cfg):
+def __perform_hwtstamp_rx(cfg, is_ioctl):
     """
     Test RX timestamp configuration.
     The filter configuration is taken from the list of supported filters.
@@ -87,11 +171,17 @@ def test_hwtstamp_rx(cfg):
     ts = __get_hwtimestamp_support(cfg)
     rx = ts['rx']
     for r in rx:
+        res = None
         tscfg = orig_tscfg
         tscfg['rx-filters']['bits']['bit'] = [r]
-        res = __set_hwtimestamp_config(cfg, tscfg)
+        if is_ioctl:
+            __set_hwtimestamp_config_ioctl(cfg, tscfg)
+        else:
+            res = __set_hwtimestamp_config(cfg, tscfg)
         if res is None:
             res = __get_hwtimestamp_config(cfg)
+        resioctl = __get_hwtimestamp_config_ioctl(cfg)
+        ksft_eq(resioctl.rx_filter, res['rx-filters']['bits']['bit'][0]['index'])
         if r['index'] == 0 or r['index'] == 1:
             ksft_eq(res['rx-filters']['bits']['bit'][0]['index'], r['index'])
         else:
@@ -100,12 +190,34 @@ def test_hwtstamp_rx(cfg):
     __set_hwtimestamp_config(cfg, orig_tscfg)
 
 
+def test_hwtstamp_rx_netlink(cfg):
+    """
+    Test RX timestamp configuration via netlink.
+    The filter configuration is taken from the list of supported filters.
+    The driver should apply the config without error and report back proper state.
+    Some extension of the timestamping scope is allowed for PTP filters.
+    """
+    __perform_hwtstamp_rx(cfg, False)
+
+
+def test_hwtstamp_rx_ioctl(cfg):
+    """
+    Test RX timestamp configuration via ioctl.
+    The filter configuration is taken from the list of supported filters.
+    The driver should apply the config without error and report back proper state.
+    Some extension of the timestamping scope is allowed for PTP filters.
+    """
+    __perform_hwtstamp_rx(cfg, True)
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
     with NetDrvEnv(__file__, nsim_test=False) as cfg:
         cfg.ethnl = EthtoolFamily()
-        ksft_run([test_hwtstamp_tx, test_hwtstamp_rx], args=(cfg,))
+        ksft_run([test_hwtstamp_tx_ioctl, test_hwtstamp_tx_netlink,
+                  test_hwtstamp_rx_ioctl, test_hwtstamp_rx_netlink],
+                 args=(cfg,))
         ksft_exit()
 
 
-- 
2.47.3


