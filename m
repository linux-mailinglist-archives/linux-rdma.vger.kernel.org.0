Return-Path: <linux-rdma+bounces-21166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDgAFd7QEGpyeAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:55:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C905BACCF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26BF73022FB5
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D313390228;
	Fri, 22 May 2026 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKfFcOKh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23F38E8D6;
	Fri, 22 May 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486874; cv=none; b=dxQGx+St4T6s3SndwcV/eRzkLyKiyYAah9Rtg2zf/RU27AsMlbOWPJPI1QcbO8kh3UjHzo9e33pibtNF1S8XShcK/S4iVYN45NuYCpUAEIAQhfJTFT3k2yEp8IdiqeBBSgBFfk88Uw4pSQwvzC6vqmXChMyd52f7/UocJdOBowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486874; c=relaxed/simple;
	bh=6Y0ISuxZgz/P3ld5rbFvop5CRCFHLlT0T5DbHrF2OXg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgxb4RI4DLNhS2727GoqCib44NlNBSDTuXnwZ3lqJk4bugOzOdu4jvjsTq9D6aWT3P3OF9mRALs1HchpCjVgy0dUwBl3ssNgUum43UdhiXRzvDTF7djKhLqNUSfPa0e672r2G/PGFHlE4NZrnodkE8iMboc7Mdme+HBPvLVjhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKfFcOKh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593DD1F00A3E;
	Fri, 22 May 2026 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486873;
	bh=33Q+0nVF0ARpJV3lvmXHvrP9ISNqoJj90QlqqmgjQNA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=cKfFcOKhSR+8l7+U+9kW+C++GokaJER9WVemxx/lkjUmKkQWbBgCY1lus+GK/gYTF
	 AXhNGTc3SNb1Eu/vY+0febCukCHX5beWhsV+Mh1japxSFvR+7wB8ZpgU2IQy7ZjZck
	 SPJVH/TuEOvnWwp/4H+F9gVTOc6bOwUzdYEVUOI/dgKZJhT+D8bZRYOx+7k/yNqH9h
	 0DUVFb1Ii+8bCQkyzkhF9JT+yNX2ReIlR5+0YlbUKG2e1Yu+1nc0oSmCogHzNr+v2V
	 8Sv6ct4eDZ6S0aCeWJPMYK1cKd4Zz2JE6HT1zjaJ7IwepLHjcNRqZ1qmSpD6zXd0IB
	 kA9cyiGaJiJpg==
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
Subject: [PATCH net-next v1 2/3] selftests: rds: pin RDS sockets to their intended transport
Date: Fri, 22 May 2026 14:54:29 -0700
Message-Id: <20260522215430.3748226-3-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522215430.3748226-1-achender@kernel.org>
References: <20260522215430.3748226-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21166-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6C905BACCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RDS selftests create AF_RDS sockets but never selects a transport,
so the transport is chosen implicitly based on network topology when
the socket is bound.  If underlying connection establishment fails, RDS
can fall back to another transport (e.g. loopback) and the test still
passes, silently bypassing the intended datapath it is meant to
exercise.

Set SO_RDS_TRANSPORT to the proper RDS_TRANS_IB or RDS_TRANS_TCP before
they are bound, so the test fails loudly if the intended transport is
unavailable rather than passing on a different path.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 08f2a846a8ab5..9e4df01cb0d4b 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -59,6 +59,14 @@ rdma_addrs = [
 OP_FLAG_TCP     = 0x1
 OP_FLAG_RDMA    = 0x2
 
+# from include/uapi/linux/rds.h: SO_RDS_TRANSPORT pins a socket to a
+# specific RDS transport so connection setup cannot silently fall back
+# to another (e.g. loopback) transport.
+SOL_RDS          = 276
+SO_RDS_TRANSPORT = 8
+RDS_TRANS_TCP    = 2
+RDS_TRANS_IB     = 0
+
 signal_handler_label = ""
 
 tap_idx = 0
@@ -214,11 +222,21 @@ def snd_rcv_packets(env):
             netns_socket(netns_list[0], socket.AF_RDS, socket.SOCK_SEQPACKET),
             netns_socket(netns_list[1], socket.AF_RDS, socket.SOCK_SEQPACKET),
         ]
+
+        # Pin the sockets to the TCP transport so it doesn't fail over to a
+        # different transport during this test
+        for s in sockets:
+            s.setsockopt(SOL_RDS, SO_RDS_TRANSPORT, RDS_TRANS_TCP)
     elif flags & OP_FLAG_RDMA:
         sockets = [
             socket.socket(socket.AF_RDS, socket.SOCK_SEQPACKET),
             socket.socket(socket.AF_RDS, socket.SOCK_SEQPACKET),
         ]
+
+        # Pin the sockets to the RDMA transport so it doesn't fail over to a
+        # different transport during this test
+        for s in sockets:
+            s.setsockopt(SOL_RDS, SO_RDS_TRANSPORT, RDS_TRANS_IB)
     else:
         raise RuntimeError(f"Invalid transport flag sets no transports: {flags}")
 
-- 
2.25.1


