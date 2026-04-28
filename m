Return-Path: <linux-rdma+bounces-19695-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBK9F+w08WltegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19695-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:30:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E948C9B5
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C1230B6E33
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAC382F1C;
	Tue, 28 Apr 2026 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NupMSH7t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC937E2FA;
	Tue, 28 Apr 2026 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415240; cv=none; b=fAiV5krOvTXf7GJQtry8vjniahEoSjGJe/S20qVa3h6+N9m+bHuAJDSbd8anRkgMXQT/HNidS4ZUzVm4PODZ3NkguKM+5+IMtUwPS1Kao6TuQ1xO1eeQD16FZPTecScjCLd7SEWoRzhMaP0L+j4rrU3z4zrjpLCap5LZHKrrIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415240; c=relaxed/simple;
	bh=AzcEuGQxW5HnT+9hKxiYEzYX/WKDcXo69VDWyZunXy0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dcgh/KY1uGAUR8PXluDRa0RgH2uNB/3WI9aE0oQBRdm/eT4/g84c9vaTc6PvHpsLhsSjHIgCCNPXqPZ7uCgNBN83k0Rja6YkS2EZwQD7Tk3Co9Yh1dUJFpQUz+fh3r9OSRXfnJFk18kVcoGtlaE/EQqLFc4oIXJGTvrNvVR/e+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NupMSH7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5802C2BCAF;
	Tue, 28 Apr 2026 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415240;
	bh=AzcEuGQxW5HnT+9hKxiYEzYX/WKDcXo69VDWyZunXy0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NupMSH7tqdFnRNXqlsppUTNmtxEXX/Y4FBtoYZmIJMO+y9ZKLgrBGXlUUb41gPe7/
	 rsZ8Z8j5dTmD9E5yEs5STCtKzWzMVbi6xsYNt5cV1AJI781yBbDRERMPOpylw3lahG
	 w2yOJSTlWDw7X3v4AyZJwL7537pE+1nwi2NYAG3wHo8yWZKKnSFQnssmMrBTvx3O4D
	 4UNtDEZTcmtQeunDS/9APXornovKr1ZsOx2uN/VLUKbuOEeXiw2WfwsIv5wzn4VAgs
	 1pjN43sywTkJ7yuM8YhNBN0UvXjlU3Ggee786Thz8OTB7I5QFb/l+KH2ndcmRsCJXN
	 WrkiKwGwMbHCQ==
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
Subject: [PATCH net-next v2 3/7] selftests: rds: Fix more pylint errors
Date: Tue, 28 Apr 2026 15:27:12 -0700
Message-Id: <20260428222716.2960871-4-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428222716.2960871-1-achender@kernel.org>
References: <20260428222716.2960871-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 054E948C9B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19695-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This patch fixes a few pylint errors in test.py. Remove unused exception
variables from except blocks, and disable warnings for imports that cannot
appear at the start of the module.  Also disable warnings for the
tcpdump processes.  The suggestion to use a with block does not apply
here since the process needs to outlive the parent to collect the dumps.
Lastly add the module docstring at the top of the module.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 93e23e8b256c..4b6ffbb3a81c 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -1,5 +1,8 @@
 #! /usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+"""
+This module provides functional testing for the net/rds component.
+"""
 
 import argparse
 import ctypes
@@ -17,7 +20,8 @@ import shutil
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
-from lib.py.utils import ip
+# pylint: disable-next=wrong-import-position,import-error,no-name-in-module
+from lib.py.utils import ip # noqa: E402
 
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 setns = libc.setns
@@ -129,6 +133,7 @@ tcpdump_procs = []
 for net in [NET0, NET1]:
     pcap = logdir+'/'+net+'.pcap'
     fd, pcap_tmp = tempfile.mkstemp(suffix=".pcap", prefix=f"{net}-", dir="/tmp")
+    # pylint: disable-next=consider-using-with
     p = subprocess.Popen(
         ['ip', 'netns', 'exec', net,
          '/usr/sbin/tcpdump', '-i', 'any', '-w', pcap_tmp])
@@ -192,7 +197,7 @@ while nr_send < NUM_PACKETS:
             send_hashes.setdefault((sender.fileno(), receiver.fileno()),
                     hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
             nr_send = nr_send + 1
-        except BlockingIOError as e:
+        except BlockingIOError:
             break
         except OSError as e:
             if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
@@ -214,7 +219,7 @@ while nr_send < NUM_PACKETS:
                             receiver.fileno()), hashlib.sha256()).update(
                                     f'<{recv_data}>'.encode('utf-8'))
                         nr_recv = nr_recv + 1
-                    except BlockingIOError as e:
+                    except BlockingIOError:
                         break
 
     # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
-- 
2.25.1


