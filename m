Return-Path: <linux-rdma+bounces-17676-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FCEI73aq2luhQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17676-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 08:58:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890A22AB00
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 08:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF60302D10B
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6437F385525;
	Sat,  7 Mar 2026 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UVaccd1v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D0CA5A
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870329; cv=none; b=mgfD3jicmlGGmVMNkK93/ZeGh7/Gvf5QCUvrawbskjG/j6NnueDVIrLR2dm2GqKHng8+I9rtHOltZ6nWPTPgKeQImyc4w+lta0/0P7pm/PcaA2Q2aoWb+JZHqfbLGGaroDE1enFrun8O3TFZ0Zj68RilxrhUaUvkGBRHrXb5kfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870329; c=relaxed/simple;
	bh=rDxbUo0FlWt2bjlmkrS7q1rAttO384jRZQQx7nBK0BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fxG0qp3hUc153ZfT2O6uBO7THB0WDwiDRYmhXo3VvgvwfCgTZ8AnntcHH+wMOfCofOm81Tv1yLqd8K+G2EP7ElKTOElX5790PL2Dj/u6lCChGO/LpcnWFs4G7k7aIVTqL500fux1SeE9R5kl7nJ07GrINTtgu8kUl7iIeMkbb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UVaccd1v; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74291102-6d74-4d41-b614-14ad37474744@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772870325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePbeyFTS4BD067vPZURBRT+RuBwPcW9P82rIKcVL6+U=;
	b=UVaccd1vQUwxJEqViqH2kL6IQcmxf4LY2ZCj+jFUyPK2MV373dmP/2wNMUenyFZHi7s0E4
	lx0wIdwLVUUbMDnpdllMuecPJ7ydFeFSlCRw5pAHgiAbSctytwIrvMijX9Sgd6i6hZ8L0L
	B7DOb94yKyunRkRp1Ks8NcPf6bwf9VE=
Date: Fri, 6 Mar 2026 23:58:30 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 0/4] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, dsahern@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260307075611.3410-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260307075611.3410-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3890A22AB00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17676-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rxe_rping_between_netns.sh:url,rxe_test_netdev_unregister.sh:url,rxe_socket_with_netns.sh:url]
X-Rspamd-Action: no action


在 2026/3/6 23:56, Zhu Yanjun 写道:
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
> V1 -> V2: Fix the problems based on David Ahern.
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
>   drivers/infiniband/sw/rxe/rxe_net.c           | 144 +++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_net.h           |   9 +-
>   drivers/infiniband/sw/rxe/rxe_ns.c            | 136 +++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_ns.h            |  17 +++
>   include/rdma/rdma_netlink.h                   |   2 +
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/rdma/Makefile         |   7 +
>   tools/testing/selftests/rdma/config           |   3 +
>   tools/testing/selftests/rdma/rxe_ipv6.sh      |  47 ++++++
>   .../selftests/rdma/rxe_rping_between_netns.sh |  57 +++++++
>   .../selftests/rdma/rxe_socket_with_netns.sh   |  64 ++++++++
>   .../rdma/rxe_test_NETDEV_UNREGISTER.sh        |  38 +++++
>   16 files changed, 526 insertions(+), 47 deletions(-)
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


