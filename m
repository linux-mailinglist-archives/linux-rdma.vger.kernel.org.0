Return-Path: <linux-rdma+bounces-17708-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG0TOxYqrWlAzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17708-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:49:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310822EFBA
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753A430071F5
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE3344DB4;
	Sun,  8 Mar 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rOuHEg/8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863E340A62
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772956180; cv=none; b=haG6Ed/Bz8ot3CZ51OxG6FlVD/Ffw2XaZiYsyYXtCXUUPjTPgxW96RXmyXdKpxtyu+XoN31oYzfk8bCWgSIZdf6yfNoZJhekcpd9JFwT+4e/76StA8PpoKzHZc4PirurgiMizCE38fSPPd7juZ1LqrY2xYQs9g/BzbdntmLoJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772956180; c=relaxed/simple;
	bh=t5ZXMSl3ZGZWcn2Ci7uhGMatU3X94KPAbLgp4FFFLw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WESHbYDQqxyDrxU5NV7x9oknvbrDQfx+5FReyhiNkSs5fk4qc2tQu5I7y8il0QowkRXO6NcTw27dbR0UxO8+3dunxgQpIOO/lqcRYIjg0JoRzRHnR3T7TnApg/NmDPwbD6BgqjWOIwf8URCoRPBojM1VTvNUGHubZYDm+nH/JnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rOuHEg/8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <730903b7-c898-4fba-b375-603a8ccd9067@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772956175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xd5YyyodN0aLpE6IvpWxgqA/Oh70HevDQwOPA45F8rE=;
	b=rOuHEg/8UIyczV+zG7XhVok6ohoxrZ90d9lglGLd2ysdeb27fIN7qxjvo/IXUTaRGeQY8Y
	rQXjBWMvB/DpPFiC5QNv125gzRdXakhCwjGVP1zKPAdAxutcAjqySanwAq25w9qgQ6hzIE
	OaI+09g3wUiuTqaLQPK8FtLyXZO78gw=
Date: Sat, 7 Mar 2026 23:49:24 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] RDMA/rxe: Add testcase for net namespace rxe
To: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, dsahern@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260308074711.24114-1-yanjun.zhu@linux.dev>
 <20260308074711.24114-5-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260308074711.24114-5-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6310822EFBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17708-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,rxe_rping_between_netns.sh:url,rxe_ipv6.sh:url,rxe_test_netdev_unregister.sh:url,rxe_socket_with_netns.sh:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bluecherrydvr.com:email]
X-Rspamd-Action: no action


在 2026/3/7 23:47, Zhu Yanjun 写道:
> Add 4 testcases for rxe with net namespace.

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
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   MAINTAINERS                                   |  1 +
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/rdma/Makefile         |  7 ++
>   tools/testing/selftests/rdma/config           |  3 +
>   tools/testing/selftests/rdma/rxe_ipv6.sh      | 47 ++++++++++++++
>   .../selftests/rdma/rxe_rping_between_netns.sh | 57 +++++++++++++++++
>   .../selftests/rdma/rxe_socket_with_netns.sh   | 64 +++++++++++++++++++
>   .../rdma/rxe_test_NETDEV_UNREGISTER.sh        | 38 +++++++++++
>   8 files changed, 218 insertions(+)
>   create mode 100644 tools/testing/selftests/rdma/Makefile
>   create mode 100644 tools/testing/selftests/rdma/config
>   create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89007f9ed35e..3835857d0192 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24493,6 +24493,7 @@ L:	linux-rdma@vger.kernel.org
>   S:	Supported
>   F:	drivers/infiniband/sw/rxe/
>   F:	include/uapi/rdma/rdma_user_rxe.h
> +F:	tools/testing/selftests/rdma/
>   
>   SOFTLOGIC 6x10 MPEG CODEC
>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 450f13ba4cca..110e07c0d99d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -94,6 +94,7 @@ TARGETS += proc
>   TARGETS += pstore
>   TARGETS += ptrace
>   TARGETS += openat2
> +TARGETS += rdma
>   TARGETS += resctrl
>   TARGETS += riscv
>   TARGETS += rlimits
> diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
> new file mode 100644
> index 000000000000..7dd7cba7a73c
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_PROGS := rxe_rping_between_netns.sh \
> +		rxe_ipv6.sh \
> +		rxe_socket_with_netns.sh \
> +		rxe_test_NETDEV_UNREGISTER.sh
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/rdma/config b/tools/testing/selftests/rdma/config
> new file mode 100644
> index 000000000000..4ffb814e253b
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/config
> @@ -0,0 +1,3 @@
> +CONFIG_TUN
> +CONFIG_VETH
> +CONFIG_RDMA_RXE
> diff --git a/tools/testing/selftests/rdma/rxe_ipv6.sh b/tools/testing/selftests/rdma/rxe_ipv6.sh
> new file mode 100755
> index 000000000000..9337ac4fd13f
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_ipv6.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +# Notes:
> +#
> +# 1. Before running this script, please disable the firewall, as it may
> +# block UDP port 4791.
> +
> +# 2. This test script depends on the veth and tun drivers. Before running
> +#  the script, please verify that both drivers are available by executing:
> +#
> +# modinfo tun
> +# modinfo veth
> +#
> +# Make sure these commands return valid module information.
> +
> +# 3. ipv6 test.
> +# While RXE is conventionally deployed over IPv4, it maintains
> +# native support for IPv6. However, IPv6 implementations typically
> +# receive less validation and performance tuning in standard use cases.
> +exec > /dev/null
> +# 1) create ipv6 net namespace
> +ip netns add net6
> +ip link add veth0 type veth peer name veth1
> +ip link set veth1 netns net6
> +ip netns exec net6 ip addr add 2001:db8::1/64 dev veth1
> +ip netns exec net6 ip link set veth1 up
> +
> +# 2) Add rdma link
> +ip netns exec net6 rdma link add rxe6 type rxe netdev veth1
> +
> +# 3) check IPv6 UDP 4791 listening port
> +if ! ip netns exec net6 ss -ul6n | grep :4791; then
> +	echo "Error: udp port 4791 exists"
> +	exit 1
> +fi
> +
> +# 4) Delete rxe link
> +ip netns exec net6 rdma link del rxe6
> +if ip netns exec net6 ss -ul6n | grep :4791; then  # result should be null
> +	echo "Error: udp port 4791 exists"
> +	exit 1
> +fi
> +
> +# 5) delete net6
> +ip netns del net6
> +
> +modprobe -v -r rdma_rxe
> diff --git a/tools/testing/selftests/rdma/rxe_rping_between_netns.sh b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> new file mode 100755
> index 000000000000..80b4249dba55
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +# Notes:
> +#
> +# 1. Before running this script, please disable the firewall, as it may
> +# block UDP port 4791.
> +
> +# 2. This test script depends on the veth and tun drivers. Before running
> +#  the script, please verify that both drivers are available by executing:
> +#
> +# modinfo veth
> +#
> +# Make sure these commands return valid module information.
> +
> +#1. Check if rping can work or not
> +exec > /dev/null
> +ip netns add test1
> +ip netns ls
> +ip link add veth-a type veth peer name veth-b
> +ip l
> +ip link set veth-a netns test1
> +ip l
> +ip netns exec test1 ip l set veth-a up
> +ip netns exec test1 ip addr add 1.1.1.1/24 dev veth-a
> +ip netns exec test1 ip l
> +ip netns exec test1 ip -4 a
> +ip netns exec test1 rdma link add rxe0 type rxe netdev veth-a
> +
> +#check if socket exist or not
> +ip netns exec test1 ss -lun | grep :4791
> +
> +ip netns exec test1 rdma link
> +ip link set veth-b up
> +ip addr add 1.1.1.2/24 dev veth-b
> +ping -c 3 1.1.1.1 || exit 1
> +ip netns exec test1 rping -s -a 1.1.1.1&
> +rdma link add rxe1 type rxe netdev veth-b
> +rdma link
> +
> +#check if socket exist or not
> +ss -lun | grep :4791
> +
> +rping -c -a 1.1.1.1 -d -v -C 3 || exit 1
> +ip netns ls
> +rdma link del rxe1
> +
> +#check if socket exist or not
> +ss -lun | grep :4791
> +
> +ip netns exec test1 ss -lun | grep :4791
> +ip netns exec test1 rdma link del rxe0
> +ip netns exec test1 ss -lun | grep :4791
> +ip netns del test1
> +ip netns ls
> +
> +modprobe -v -r veth
> +modprobe -v -r rdma_rxe
> diff --git a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> new file mode 100755
> index 000000000000..676aec63babd
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +# Notes:
> +#
> +# 1. Before running this script, please disable the firewall, as it may
> +# block UDP port 4791.
> +
> +# 2. This test script depends on the veth and tun drivers. Before running
> +#  the script, please verify that both drivers are available by executing:
> +#
> +# modinfo tun
> +#
> +# Make sure these commands return valid module information.
> +
> +# Check if socket exist or not
> +exec > /dev/null
> +ip tuntap add mode tun tun0
> +ip -4 a
> +ip addr add 1.1.1.1/24 dev tun0
> +ip link set tun0 up
> +ip -4 a
> +rdma link add rxe0 type rxe netdev tun0
> +rdma link
> +ret=`ss -lun | grep :4791`
> +if [ X"$ret" == X"" ]; then
> +	echo "Error: udp port 4791 does not exist"
> +	exit 1
> +fi
> +
> +ip tuntap add mode tun tun1
> +ip -4 a
> +ip addr add 2.2.2.2/24 dev tun1
> +ip link set tun1 up
> +rdma link add rxe1 type rxe netdev tun1
> +rdma link
> +ret=`ss -lun | grep :4791`
> +if [ X"$ret" == X"" ]; then
> +	echo "Error: udp port 4791 does not exist"
> +	exit 1
> +fi
> +
> +rdma link del rxe1
> +rdma link
> +ret=`ss -lun | grep :4791`
> +if [ X"$ret" == X"" ]; then
> +	echo "Error: udp port 4791 doese not exist"
> +	exit 1
> +fi
> +
> +rdma link del rxe0
> +rdma link
> +if ss -lun | grep :4791; then
> +	echo "Error: udp port 4791 exists"
> +	exit 1
> +fi
> +
> +ip addr del 2.2.2.2/24 dev tun1
> +ip tuntap del mode tun tun1
> +
> +ip addr del 1.1.1.1/24 dev tun0
> +ip tuntap del mode tun tun0
> +
> +modprobe -v -r tun
> +modprobe -v -r rdma_rxe
> diff --git a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> new file mode 100755
> index 000000000000..c30ff905b121
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +# Notes:
> +#
> +# 1. Before running this script, please disable the firewall, as it may
> +# block UDP port 4791.
> +
> +# 2. This test script depends on the veth and tun drivers. Before running
> +#  the script, please verify that both drivers are available by executing:
> +#
> +# modinfo tun
> +# modinfo veth
> +#
> +# Make sure these commands return valid module information.
> +
> +# Trigger NETDEV_UNREGISTER
> +exec > /dev/null
> +ip tuntap add mode tun tun0
> +ip -4 a
> +ip addr add 1.1.1.1/24 dev tun0
> +ip link set tun0 up
> +ip -4 a
> +rdma link add rxe0 type rxe netdev tun0
> +rdma link
> +ss -lun | grep :4791
> +
> +ip l
> +ip addr del 1.1.1.1/24 dev tun0
> +ip tuntap del mode tun tun0
> +
> +rdma link
> +if ss -lun | grep :4791; then
> +	echo "error"
> +	exit 1
> +fi
> +
> +modprobe -v -r tun
> +modprobe -v -r rdma_rxe

-- 
Best Regards,
Yanjun.Zhu


