Return-Path: <linux-rdma+bounces-17842-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMtDHOR8r2kXZwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17842-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 03:07:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE96024407C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 03:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEA64304F31B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39DD30E830;
	Tue, 10 Mar 2026 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F31taDUG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697F280CD5
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108351; cv=none; b=TTVcw4syijeoBQikLEjFMJpDu8/9nUlq/h2h+0aC9272pbB1QzgceVXbLo0SVKja+YooSLWB2O/5YT6GQfucur1SNDxTmbd8LyBZ5TemzO6O6XNmT/bti61OAMsgl0tYVvvMZNHxoX6fkNfk0dGC9AlX/Pn4UXzFUfuLPHHD9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108351; c=relaxed/simple;
	bh=W5AVjXeHdqxm5PYzTmryBI88xuVy0bHLk3Czk6jvrGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci4GUU4YAHR/woBq5Oyx3yxG3oOyLRQrmGrPU68p8KrZdsStf7TPoOo50q9u6iT8O3eQjuJeLE8oyqMmJcdNSfaEHhVnrd3uNKK+Yyph8dxCbHZBSgfwR2nUAH20qCVkGLwe7e03NwqpRrfNW4uOeI+OPfUp6odncexU39FMdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F31taDUG; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773108338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UYuQqtHEBc7YbB3gscISEdBsLp6z9TR53HhOrMI9M7c=;
	b=F31taDUG/PsiNylO2BJv6LgwjhQ1ScOZCg+AolTt7s3LyL9EZC5KcUYnmoYbQmT2BEl4wN
	ZDoNnSfi2I0ppfEouH+L7f8LSoTUxXGIMzLIhCysCGzquwNydlljOGk/gzEwBeGkU9uFfv
	7H/1+7QCAJf1i/sYuK7rzjv/jy+Y6NE=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v5 0/4] RDMA/rxe: Add the support that rxe can work in net namespace
Date: Tue, 10 Mar 2026 03:05:14 +0100
Message-ID: <20260310020519.101415-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DE96024407C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17842-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxe_socket_with_netns.sh:url,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rxe_ipv6.sh:url,rxe_rping_between_netns.sh:url,rxe_test_netdev_unregister.sh:url]
X-Rspamd-Action: no action

Currently rxe does not work correctly in network namespaces.

When the rdma_rxe module is loaded, a UDP socket listening on port
4791 is created in init_net. When users run:

    ip link add ... type rxe

inside another network namespace, the RXE RDMA link is created but it
cannot function properly because the underlying UDP socket belongs to
init_net. Other network namespaces cannot use that socket.

To address this issue, this series introduces net namespace support
for rxe and moves socket management to be per network namespace.

The series first introduces per-net namespace management for the IPv4
and IPv6 sockets used by rxe. The sockets are created when the network
namespace becomes active and are released when the namespace is
destroyed.

Based on this infrastructure, rxe RDMA links are then created and
destroyed within each network namespace. This ensures that both the
UDP sockets and RDMA links are correctly scoped to the namespace in
which they are used.

With these changes, rxe RDMA links can be created and used both in
init_net and in other network namespaces, and resources are properly
cleaned up during namespace teardown.

The series also includes a selftest to verify RXE functionality in
network namespaces.

"
make -C tools/testing/selftests TARGETS=rdma run_tests
make: Entering directory 'tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..4
# timeout set to 45
# selftests: rdma: rxe_rping_between_netns.sh
ok 1 selftests: rdma: rxe_rping_between_netns.sh
# timeout set to 45
# selftests: rdma: rxe_ipv6.sh
ok 2 selftests: rdma: rxe_ipv6.sh
# timeout set to 45
# selftests: rdma: rxe_socket_with_netns.sh
ok 3 selftests: rdma: rxe_socket_with_netns.sh
# timeout set to 45
# selftests: rdma: rxe_test_NETDEV_UNREGISTER.sh
ok 4 selftests: rdma: rxe_test_NETDEV_UNREGISTER.sh
make: Leaving directory 'tools/testing/selftests'
"

V4 -> V5: Fix rcu warnings
V3 -> V4: Squash all the changes about rxe_ns.c/h into one commit.
V2 -> V3: Fix build warnings
V1 -> V2: Fix the problems based on David Ahern.

Zhu Yanjun (4):
  RDMA/nldev: Add dellink function pointer
  RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets
  RDMA/rxe: Support RDMA link creation and destruction per net namespace
  RDMA/rxe: Add testcase for net namespace rxe

 MAINTAINERS                                   |   1 +
 drivers/infiniband/core/nldev.c               |   6 +
 drivers/infiniband/sw/rxe/Makefile            |   3 +-
 drivers/infiniband/sw/rxe/rxe.c               |  38 ++++-
 drivers/infiniband/sw/rxe/rxe_net.c           | 145 +++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_net.h           |   9 +-
 drivers/infiniband/sw/rxe/rxe_ns.c            | 124 +++++++++++++++
 drivers/infiniband/sw/rxe/rxe_ns.h            |  30 ++++
 include/rdma/rdma_netlink.h                   |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/rdma/Makefile         |   7 +
 tools/testing/selftests/rdma/config           |   3 +
 tools/testing/selftests/rdma/rxe_ipv6.sh      |  63 ++++++++
 .../selftests/rdma/rxe_rping_between_netns.sh |  85 ++++++++++
 .../selftests/rdma/rxe_socket_with_netns.sh   |  76 +++++++++
 .../rdma/rxe_test_NETDEV_UNREGISTER.sh        |  63 ++++++++
 16 files changed, 609 insertions(+), 47 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
 create mode 100644 tools/testing/selftests/rdma/Makefile
 create mode 100644 tools/testing/selftests/rdma/config
 create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
 create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
 create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
 create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh

-- 
2.53.0


