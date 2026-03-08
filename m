Return-Path: <linux-rdma+bounces-17740-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF72LhMJrmkN/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-17740-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 00:41:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A51232C2C
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 00:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76C94300FEFF
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 23:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E135BDC4;
	Sun,  8 Mar 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="acWJFGzK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188A35A3B0
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773013246; cv=none; b=Tbhh97Osor8B4jZzz5V3ov6HLMEQPq1JBQSTRvkv6gQfsgm+MGXrNRHeb8CS5iVNkJIL9eMBg3lkutOPFRWX5GtfTSsHVPaksyMQDQLi1j+VFrli3GDnL7flR4wv6WCfB845RJTSw/8Bla7SKlLXFj0yDXr/DZKt5IAiQ8Y5VTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773013246; c=relaxed/simple;
	bh=yHmjbSxLlmagRV4Rpas/2hJ6hscNtLqp58PWZhzkyZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tMFoBlBt8wRomgfGnhBkFqXTmvx4eWcTy2QmLndSLpmsWhOTL3m8DrZtByVimFuWfWRQLTcicpLNF9IJw2Yn4nMWNiQKoUNWcBQjgbXuBdwcFAO+XSezWOWMqBiGyimrmUqee3RF9oY5bfwushPD3/nYhM+vTCf07SsOrvoQ204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=acWJFGzK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45947149-36ef-41f2-8ad0-aa3519344ce0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773013233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDEjrYDaUt6nPRjGxJ3slajXGASGQDlUUZONcSEfmb8=;
	b=acWJFGzKk0Zz18oMK7vqF9CI+KfBZC1/7iYUAf5+277FsFM2hLanpO1xRptqLAAodsOkKq
	+AfZa+rgsXhmC1MZU9y8A2vmFPZHkICuQ9UxH1brVXjRbnrLCDcQwaJ7i5ebdNg1AQwAsb
	scYd9XVPRnqrzjfgy2VP2IzrmFspZYM=
Date: Sun, 8 Mar 2026 16:40:26 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, dsahern@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260308233540.13382-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260308233540.13382-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 32A51232C2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17740-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxe_rping_between_netns.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,rxe_test_netdev_unregister.sh:url,rxe_socket_with_netns.sh:url,rxe_ipv6.sh:url]
X-Rspamd-Action: no action


在 2026/3/8 16:35, Zhu Yanjun 写道:
> Currently rxe does not work correctly in network namespaces.
>
> When the rdma_rxe module is loaded, a UDP socket listening on port
> 4791 is created in init_net. When users run:
>
>      ip link add ... type rxe
>
> inside another network namespace, the RXE RDMA link is created but it
> cannot function properly because the underlying UDP socket belongs to
> init_net. Other network namespaces cannot use that socket.
>
> To address this issue, this series introduces net namespace support
> for rxe and moves socket management to be per network namespace.
>
> The series first introduces per-net namespace management for the IPv4
> and IPv6 sockets used by rxe. The sockets are created when the network
> namespace becomes active and are released when the namespace is
> destroyed.
>
> Based on this infrastructure, rxe RDMA links are then created and
> destroyed within each network namespace. This ensures that both the
> UDP sockets and RDMA links are correctly scoped to the namespace in
> which they are used.
>
> With these changes, rxe RDMA links can be created and used both in
> init_net and in other network namespaces, and resources are properly
> cleaned up during namespace teardown.
>
> The series also includes a selftest to verify RXE functionality in
> network namespaces.

The selftest result is as below:

"
# make -C tools/testing/selftests/ TARGETS=rdma run_tests
make: Entering directory '/root/Development/linux/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..4
# timeout set to 45
# selftests: rdma: rxe_rping_between_netns.sh
# server DISCONNECT EVENT...
# wait for RDMA_READ_ADV state 10
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
make: Leaving directory '/root/Development/linux/tools/testing/selftests'
"

Zhu Yanjun

>
> V3 -> V4: Squash all the changes about rxe_ns.c/h into one commit.
> V2 -> V3: Fix build warnings
> V1 -> V2: Fix the problems based on David Ahern.
>
>
> Zhu Yanjun (4):
>    RDMA/nldev: Add dellink function pointer
>    RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets
>    RDMA/rxe: Support RDMA link creation and destruction per net namespace
>    RDMA/rxe: Add testcase for net namespace rxe
>
>   MAINTAINERS                                   |   1 +
>   drivers/infiniband/core/nldev.c               |   6 +
>   drivers/infiniband/sw/rxe/Makefile            |   3 +-
>   drivers/infiniband/sw/rxe/rxe.c               |  38 ++++-
>   drivers/infiniband/sw/rxe/rxe_net.c           | 145 +++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_net.h           |   9 +-
>   drivers/infiniband/sw/rxe/rxe_ns.c            | 136 ++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_ns.h            |  17 ++
>   include/rdma/rdma_netlink.h                   |   2 +
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/rdma/Makefile         |   7 +
>   tools/testing/selftests/rdma/config           |   3 +
>   tools/testing/selftests/rdma/rxe_ipv6.sh      |  47 ++++++
>   .../selftests/rdma/rxe_rping_between_netns.sh |  57 +++++++
>   .../selftests/rdma/rxe_socket_with_netns.sh   |  64 ++++++++
>   .../rdma/rxe_test_NETDEV_UNREGISTER.sh        |  38 +++++
>   16 files changed, 527 insertions(+), 47 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
>   create mode 100644 tools/testing/selftests/rdma/Makefile
>   create mode 100644 tools/testing/selftests/rdma/config
>   create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
>
-- 
Best Regards,
Yanjun.Zhu


