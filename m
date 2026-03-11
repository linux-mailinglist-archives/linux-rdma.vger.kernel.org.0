Return-Path: <linux-rdma+bounces-17942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AtcNkwNsWldqAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:35:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210525CE7D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAD9B3036EF4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 06:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509002BD030;
	Wed, 11 Mar 2026 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="doCMNeOg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B428CF4A
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210953; cv=none; b=Sk/f0LL1oMQfYyDU6rVJlR3Ulr5od6C9JKTIsDLC+2jtyNNiRLKGwc1ziM2UyhDnYkYI3wblR4eCJscwKXWdWHJfxKgaQWuCYUyTjP8J30iXxANwBVRibKu5JORiXPPFchVKqR/p5T9ECWkZuYXJ4i2vq+POQzibtaYjhh48NQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210953; c=relaxed/simple;
	bh=Mv+33bjVBHHqnXe1uy4deRe9n04ajaqtIvw8A3bnNPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O6JW/PjhCBYETNVs469+L/leoL1g3Iu2MNMJCvESxR+KgAEyB0gFX9alYXC1VKnS49wZ2aUspKlV2gboaAxMT8b+D4pAvOhakJZsVN5jzADf5dF+Npr+kIJKOP70XG28yL3l1VOIcagS+6cUv9OinjkMDpmH0sH0M7w1tbun1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=doCMNeOg; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af852510-2e6f-406e-9d8f-80a446ec0000@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773210949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Nwg+tX1KrQRzCvgwYGdLzvgeoCIycBhrn5VOwwRH2E=;
	b=doCMNeOgE1AU5kLp060pLwdFRV2aT1P5+kDLGCR0mD92l7BiMwMKU92eKjxAkFjBeNkShF
	NAQ1IBFPRBq347THf0KfsKJ/232CUs3A/37HzPsrVJKWMgUMADcqwbOuM0rjRS+BYXLkiJ
	3ezIwjEESJz+RFFJjohN7dqIaMeD9xE=
Date: Tue, 10 Mar 2026 23:35:33 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 4/4] RDMA/rxe: Add testcase for net namespace rxe
To: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, dsahern@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260311062906.1470-1-yanjun.zhu@linux.dev>
 <20260311062906.1470-5-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260311062906.1470-5-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3210525CE7D
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
	TAGGED_FROM(0.00)[bounces-17942-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bluecherrydvr.com:email,rxe_rping_between_netns.sh:url,linux.dev:dkim,linux.dev:email,linux.dev:mid,rxe_socket_with_netns.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rxe_test_netdev_unregister.sh:url]
X-Rspamd-Action: no action


在 2026/3/10 23:29, Zhu Yanjun 写道:
> Add 4 testcases for rxe with net namespace.
>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   MAINTAINERS                                   |  1 +
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/rdma/Makefile         |  7 ++
>   tools/testing/selftests/rdma/config           |  3 +
>   tools/testing/selftests/rdma/rxe_ipv6.sh      | 63 ++++++++++++++
>   .../selftests/rdma/rxe_rping_between_netns.sh | 85 +++++++++++++++++++
>   .../selftests/rdma/rxe_socket_with_netns.sh   | 76 +++++++++++++++++
>   .../rdma/rxe_test_NETDEV_UNREGISTER.sh        | 63 ++++++++++++++
>   8 files changed, 299 insertions(+)
>   create mode 100644 tools/testing/selftests/rdma/Makefile
>   create mode 100644 tools/testing/selftests/rdma/config
>   create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
>   create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77fdfcb55f06..3c18bc614169 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24492,6 +24492,7 @@ L:	linux-rdma@vger.kernel.org
>   S:	Supported
>   F:	drivers/infiniband/sw/rxe/
>   F:	include/uapi/rdma/rdma_user_rxe.h
> +F:	tools/testing/selftests/rdma/exe*

Sorry. Should be "tools/testing/selftests/rdma/rxe*"

Zhu Yanjun

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
> index 000000000000..b7059bfd6d7c
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_ipv6.sh
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +
> +# Configuration
> +NS_NAME="net6"
> +VETH_HOST="veth0"
> +VETH_NS="veth1"
> +RXE_NAME="rxe6"
> +PORT=4791
> +IP6_ADDR="2001:db8::1/64"
> +
> +exec > /dev/null
> +
> +# Cleanup function to run on exit (even on failure)
> +cleanup() {
> +    ip netns del "$NS_NAME" 2>/dev/null
> +    modprobe -r rdma_rxe 2>/dev/null
> +    echo "Done."
> +}
> +trap cleanup EXIT
> +
> +# 1. Prerequisites check
> +for mod in tun veth rdma_rxe; do
> +    if ! modinfo "$mod" >/dev/null 2>&1; then
> +        echo "Error: Kernel module '$mod' not found."
> +        exit 1
> +    fi
> +done
> +
> +modprobe rdma_rxe
> +
> +# 2. Setup Namespace and Networking
> +echo "Setting up IPv6 network namespace..."
> +ip netns add "$NS_NAME"
> +ip link add "$VETH_HOST" type veth peer name "$VETH_NS"
> +ip link set "$VETH_NS" netns "$NS_NAME"
> +ip netns exec "$NS_NAME" ip addr add "$IP6_ADDR" dev "$VETH_NS"
> +ip netns exec "$NS_NAME" ip link set "$VETH_NS" up
> +ip link set "$VETH_HOST" up
> +
> +# 3. Add RDMA Link
> +echo "Adding RDMA RXE link..."
> +if ! ip netns exec "$NS_NAME" rdma link add "$RXE_NAME" type rxe netdev "$VETH_NS"; then
> +    echo "Error: Failed to create RXE link."
> +    exit 1
> +fi
> +
> +# 4. Verification: Port should be listening
> +# Using -H to skip headers and -q for quiet exit codes
> +if ! ip netns exec "$NS_NAME" ss -Hul6n sport = :$PORT | grep -q ":$PORT"; then
> +    echo "Error: UDP port $PORT is NOT listening after link creation."
> +    exit 1
> +fi
> +echo "Verified: Port $PORT is active."
> +
> +# 5. Removal and Verification
> +echo "Deleting RDMA link..."
> +ip netns exec "$NS_NAME" rdma link del "$RXE_NAME"
> +
> +if ip netns exec "$NS_NAME" ss -Hul6n sport = :$PORT | grep -q ":$PORT"; then
> +    echo "Error: UDP port $PORT still active after link deletion."
> +    exit 1
> +fi
> +echo "Verified: Port $PORT closed successfully."
> diff --git a/tools/testing/selftests/rdma/rxe_rping_between_netns.sh b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> new file mode 100755
> index 000000000000..e5b876f58c6e
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> @@ -0,0 +1,85 @@
> +#!/bin/bash
> +
> +# Configuration
> +NS="test1"
> +VETH_A="veth-a"
> +VETH_B="veth-b"
> +IP_A="1.1.1.1"
> +IP_B="1.1.1.2"
> +PORT=4791
> +
> +exec > /dev/null
> +
> +# --- Cleanup Routine ---
> +cleanup() {
> +    echo "Cleaning up resources..."
> +    rdma link del rxe1 2>/dev/null
> +    ip netns exec "$NS" rdma link del rxe0 2>/dev/null
> +    ip link delete "$VETH_B" 2>/dev/null
> +    ip netns del "$NS" 2>/dev/null
> +    modprobe -r rdma_rxe 2>/dev/null
> +}
> +trap cleanup EXIT
> +
> +# --- Prerequisite Checks ---
> +if [[ $EUID -ne 0 ]]; then
> +   echo "This script must be run as root"
> +   exit 1
> +fi
> +
> +modprobe rdma_rxe || { echo "Failed to load rdma_rxe"; exit 1; }
> +
> +# --- Setup Network Topology ---
> +echo "Setting up network namespace and veth pair..."
> +ip netns add "$NS"
> +ip link add "$VETH_A" type veth peer name "$VETH_B"
> +ip link set "$VETH_A" netns "$NS"
> +
> +# Configure Namespace side (test1)
> +ip netns exec "$NS" ip addr add "$IP_A/24" dev "$VETH_A"
> +ip netns exec "$NS" ip link set "$VETH_A" up
> +ip netns exec "$NS" ip link set lo up
> +
> +# Configure Host side
> +ip addr add "$IP_B/24" dev "$VETH_B"
> +ip link set "$VETH_B" up
> +
> +# --- RXE Link Creation ---
> +echo "Creating RDMA links..."
> +ip netns exec "$NS" rdma link add rxe0 type rxe netdev "$VETH_A"
> +rdma link add rxe1 type rxe netdev "$VETH_B"
> +
> +# Verify UDP 4791 is listening
> +check_port() {
> +    local target=$1 # "host" or "ns"
> +    if [ "$target" == "ns" ]; then
> +        ip netns exec "$NS" ss -Huln sport == :$PORT | grep -q ":$PORT"
> +    else
> +        ss -Huln sport == :$PORT | grep -q ":$PORT"
> +    fi
> +}
> +
> +check_port "ns" || { echo "Error: RXE port not listening in namespace"; exit 1; }
> +check_port "host" || { echo "Error: RXE port not listening on host"; exit 1; }
> +
> +# --- Connectivity Test ---
> +echo "Testing connectivity with rping..."
> +ping -c 2 -W 1 "$IP_A" > /dev/null || { echo "Ping failed"; exit 1; }
> +
> +# Start rping server in background
> +ip netns exec "$NS" rping -s -a "$IP_A" -v > /dev/null 2>&1 &
> +RPING_PID=$!
> +sleep 1 # Allow server to bind
> +
> +# Run rping client
> +rping -c -a "$IP_A" -d -v -C 3
> +RESULT=$?
> +
> +kill $RPING_PID 2>/dev/null
> +
> +if [ $RESULT -eq 0 ]; then
> +    echo "SUCCESS: RDMA traffic verified."
> +else
> +    echo "FAILURE: rping failed."
> +    exit 1
> +fi
> diff --git a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> new file mode 100755
> index 000000000000..002e5098f751
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> @@ -0,0 +1,76 @@
> +#!/bin/bash
> +
> +# Configuration
> +PORT=4791
> +MODS=("tun" "rdma_rxe")
> +
> +exec > /dev/null
> +
> +# --- Helper: Cleanup Routine ---
> +cleanup() {
> +    echo "Cleaning up resources..."
> +    rdma link del rxe1 2>/dev/null
> +    rdma link del rxe0 2>/dev/null
> +    ip link del tun0 2>/dev/null
> +    ip link del tun1 2>/dev/null
> +    for m in "${MODS[@]}"; do modprobe -r "$m" 2>/dev/null; done
> +}
> +
> +# Ensure cleanup runs on script exit or interrupt
> +trap cleanup EXIT
> +
> +# --- Phase 1: Environment Check ---
> +if [[ $EUID -ne 0 ]]; then
> +   echo "Error: This script must be run as root."
> +   exit 1
> +fi
> +
> +for m in "${MODS[@]}"; do
> +    modprobe "$m" || { echo "Error: Failed to load $m"; exit 1; }
> +done
> +
> +# --- Phase 2: Create Interfaces & RXE Links ---
> +echo "Creating tun0 (1.1.1.1) and rxe0..."
> +ip tuntap add mode tun tun0
> +ip addr add 1.1.1.1/24 dev tun0
> +ip link set tun0 up
> +rdma link add rxe0 type rxe netdev tun0
> +
> +# Verify port 4791 is listening
> +if ! ss -Huln sport = :$PORT | grep -q ":$PORT"; then
> +    echo "Error: UDP port $PORT not found after rxe0 creation"
> +    exit 1
> +fi
> +
> +echo "Creating tun1 (2.2.2.2) and rxe1..."
> +ip tuntap add mode tun tun1
> +ip addr add 2.2.2.2/24 dev tun1
> +ip link set tun1 up
> +rdma link add rxe1 type rxe netdev tun1
> +
> +# Verify port 4791 is still listening
> +if ! ss -Huln sport = :$PORT | grep -q ":$PORT"; then
> +    echo "Error: UDP port $PORT missing after rxe1 creation"
> +    exit 1
> +fi
> +
> +# --- Phase 3: Targeted Deletion ---
> +echo "Deleting rxe1..."
> +rdma link del rxe1
> +
> +# Port should still be active because rxe0 is still alive
> +if ! ss -Huln sport = :$PORT | grep -q ":$PORT"; then
> +    echo "Error: UDP port $PORT closed prematurely"
> +    exit 1
> +fi
> +
> +echo "Deleting rxe0..."
> +rdma link del rxe0
> +
> +# Port should now be gone
> +if ss -Huln sport = :$PORT | grep -q ":$PORT"; then
> +    echo "Error: UDP port $PORT still exists after all links deleted"
> +    exit 1
> +fi
> +
> +echo "Test passed successfully."
> diff --git a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> new file mode 100755
> index 000000000000..021ca451499d
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +
> +# Configuration
> +DEV_NAME="tun0"
> +RXE_NAME="rxe0"
> +RDMA_PORT=4791
> +
> +exec > /dev/null
> +
> +# --- Cleanup Routine ---
> +# Ensures environment is clean even if the script hits an error
> +cleanup() {
> +    echo "Performing cleanup..."
> +    rdma link del $RXE_NAME 2>/dev/null
> +    ip link del $DEV_NAME 2>/dev/null
> +    modprobe -r rdma_rxe 2>/dev/null
> +}
> +trap cleanup EXIT
> +
> +# 1. Dependency Check
> +if ! modinfo rdma_rxe >/dev/null 2>&1; then
> +    echo "Error: rdma_rxe module not found."
> +    exit 1
> +fi
> +
> +modprobe rdma_rxe
> +
> +# 2. Setup TUN Device
> +echo "Creating $DEV_NAME..."
> +ip tuntap add mode tun "$DEV_NAME"
> +ip addr add 1.1.1.1/24 dev "$DEV_NAME"
> +ip link set "$DEV_NAME" up
> +
> +# 3. Attach RXE Link
> +echo "Attaching RXE link $RXE_NAME to $DEV_NAME..."
> +rdma link add "$RXE_NAME" type rxe netdev "$DEV_NAME"
> +
> +# 4. Verification: Port Check
> +# Use -H (no header) and -q (quiet) for cleaner scripting logic
> +if ! ss -Huln sport == :$RDMA_PORT | grep -q ":$RDMA_PORT"; then
> +    echo "Error: UDP port $RDMA_PORT is not listening."
> +    exit 1
> +fi
> +echo "Verified: RXE is listening on UDP $RDMA_PORT."
> +
> +# 5. Trigger NETDEV_UNREGISTER
> +# We delete the underlying device without deleting the RDMA link first.
> +echo "Triggering NETDEV_UNREGISTER by deleting $DEV_NAME..."
> +ip link del "$DEV_NAME"
> +
> +# 6. Final Verification
> +# The RXE link and the UDP port should be automatically cleaned up by the kernel.
> +if rdma link show "$RXE_NAME" 2>/dev/null; then
> +    echo "Error: $RXE_NAME still exists after netdev removal."
> +    exit 1
> +fi
> +
> +if ss -Huln sport == :$RDMA_PORT | grep -q ":$RDMA_PORT"; then
> +    echo "Error: UDP port $RDMA_PORT still listening after netdev removal."
> +    exit 1
> +fi
> +
> +echo "Success: NETDEV_UNREGISTER handled correctly."

-- 
Best Regards,
Yanjun.Zhu


