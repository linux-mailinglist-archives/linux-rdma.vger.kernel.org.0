Return-Path: <linux-rdma+bounces-20531-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP8PB1SwA2pG9AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20531-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 00:57:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218552B25E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 00:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D707305A5D2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030B03A0B24;
	Tue, 12 May 2026 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqs7gKG9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7B3672AE
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626626; cv=none; b=Go8olRPokBI3m15pFOo68YWcBJpgXdf5Jz+WjgKhK59/hNJgCnE/fKzubi844SpYrgBnfs+GD8JDpSlnySBLv34STV8uhJXlxUZLtQPVw70UjtQZN4CegUzxtAJdO0mdQbnNun31vLMbNjEhf9lfS7a1aHJ0RfLl+/g6lmF+fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626626; c=relaxed/simple;
	bh=vwo0hxWte1ZKWW8fXDzFy/IJ6e+1ege2PoBlUjgEiuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7YRxQhNJUy+auI83vt1i6Oa10ZIABv5Y0TQ70Qx8R+Xrzqt15anNfSZPsBJ+c4RAsfEvs/dP7QWsyNJF0n9ViUSPPf1kDf0xlhiKYWfVu+hIfCzbqRnqcT73taJZ7iQ+tqHXFQmXoHRSIoubuTXiDJdLqZ5G+bOpxfLhkrioZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqs7gKG9; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6116fd8d-b834-43a9-86ee-4186420f258d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778626612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mj55z9Apfbt8ztxfNS0fzNDUXnzp8CKrWb8wA+TCdOU=;
	b=cqs7gKG9xFpjGH1VO+bqlwFQdtntiFRBFhzRCgGZUkY41ZQ8HL7FXeqQEPsCEqTn1RZu9H
	3bylUqZwj+trMhtIYKgZUSghGIXtJXOXQyWWB4yOgIasuQovfKA7cDglx6AtXcxMdNc4vs
	i899TrK1NSs7oTbH3GXW+N+txGIfzhY=
Date: Tue, 12 May 2026 15:56:28 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH rdma-next 0/2] RDMA/rxe: add local implicit ODP MR
 support
To: Liibaan Egal <liibaegal@gmail.com>, linux-rdma@vger.kernel.org,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512201453.21156-1-liibaegal@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260512201453.21156-1-liibaegal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7218552B25E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20531-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[if7:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 1:14 PM, Liibaan Egal wrote:
> This RFC adds local-access implicit On-Demand Paging memory regions to
> RXE (Soft-RoCE).
> 
> RXE already supports explicit ODP MRs. The implicit registration form
> (addr == 0, length == U64_MAX, IB_ACCESS_ON_DEMAND) is recognized but
> not implemented: the implicit branch in rxe_odp_mr_init_user() returns
> -EINVAL through a placeholder block, and no path creates child umems
> for SGE accesses on an implicit MR.
> 
> This series wires the implicit registration case through
> ib_umem_odp_alloc_implicit() and routes the local SGE walker through
> per-chunk child umems. The chunk size is fixed at 2 MiB
> (RXE_ODP_CHILD_SHIFT = 21) and children are allocated lazily on first
> access via ib_umem_odp_alloc_child(), stored in a per-MR xarray.
> 
> Patches
> -------
> 
>    1/2 RDMA/rxe: add local implicit ODP MR support
> 
>        Adds rxe_odp_mr_init_implicit() (rejects remote access bits with
>        -EOPNOTSUPP, allocates the parent umem). Adds rxe_odp_get_child()
>        and the per-chunk loop in rxe_odp_mr_copy() and the prefetch
>        path. Atomic, flush and atomic-write paths reject implicit MRs
>        at the top because those helpers walk mr->umem->pfn_list
>        directly which is empty for an implicit parent. rxe_mr_cleanup
>        walks the child xarray and releases each child before the
>        parent.
> 
>        This patch leaves IB_ODP_SUPPORT_IMPLICIT unadvertised, so
>        rxe_odp_mr_init_user() still returns -EINVAL on the implicit
>        form. No user-visible behavior change yet.
> 
>    2/2 RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access
> 
>        Flip the cap bit so userspace can probe support via
>        ibv_query_device. Kept as its own patch so the policy question
>        is separable from the implementation.
> 
> Question for reviewers
> ----------------------
> 
> Patch 2/2 advertises IB_ODP_SUPPORT_IMPLICIT for a local-access-only
> operation matrix. Local SGE access on implicit MRs works; remote rkey
> access, atomic, flush, and atomic-write on implicit MRs do not. Is
> this an acceptable use of the capability bit, or should capability
> exposure wait for a broader operation matrix? Splitting the cap flip
> out is meant to keep that decision separable from the implementation.
> 
> Scope and limitations
> ---------------------
> 
> Out of scope in this series:
> 
> - Remote rkey access on implicit MRs. Rejected at registration time
>    with -EOPNOTSUPP.
> - Atomic, flush, atomic-write paths. These return -EOPNOTSUPP /
>    RESPST_ERR_RKEY_VIOLATION on implicit MRs.
> - Child reclaim. The xarray grows monotonically per MR; a child is
>    not freed until MR destroy. Long-lived implicit MRs that touch a
>    sparse address space accumulate children. A reclaim mechanism is
>    the natural follow-up.
> 
> Tested
> ------
> 
> Verified on rdma/for-next at commit 7fd2df204f34 (Linux 7.1-rc2),
> arm64, Soft-RoCE over loopback:
> 
> - Registration accept/reject matrix (5 cases).
> - Single-chunk 64 KiB RDMA WRITE through an implicit lkey.
> - Two-chunk multi-range test: two 1 MiB WRITEs from buffers in
>    different 2 MiB chunks of one implicit MR.
> - Cross-chunk single-SGE test: one 128 KiB WRITE whose SGE spans a
>    2 MiB chunk boundary.
> 
> Each patch builds cleanly standalone (M=drivers/infiniband/sw/rxe).

IMO, please use a shell script like the following to act as selftest.
Please put the following script in tools/testing/selftests/rdma/

Or you can add more testcases to prove your features.

"
#!/bin/bash
# Enable exit on error for better debugging
set -e

# 1. Cleanup old environment
echo "Cleaning up..."
ip netns delete ns0 2>/dev/null || true
ip link delete nk1 2>/dev/null || true

# 2. Setup Network Namespaces and Netkit interfaces
echo "Setting up network..."
ip netns add ns0

# Create netkit pair: nk1 (host) and nk0 (to be moved to ns0)
ip link add nk1 type netkit mode l2 peer name nk0

# Set host side up
ip link set nk1 up
ip addr add 10.0.0.2/24 dev nk1

# Move nk0 to namespace ns0
ip link set nk0 netns ns0
ip netns exec ns0 ip addr add 10.0.0.1/24 dev nk0
ip netns exec ns0 ip link set nk0 up
ip netns exec ns0 ip link set lo up

# Verify connectivity
echo "Verifying IP connectivity..."
ping -c 2 10.0.0.1 -I nk1

# 3. Setup Soft-RoCE (RXE) links
echo "Configuring RXE..."
# In namespace ns0
ip netns exec ns0 rdma link add rxe0 type rxe netdev nk0
# In host namespace
rdma link add rxe1 type rxe netdev nk1

# Wait for RDMA devices to initialize
sleep 1
rdma link

# 4. Run ibv_rc_pingpong with Implicit ODP (-O)
echo "Starting ibv_rc_pingpong with Implicit ODP..."

# Start Server in ns0
# -g 1: GID index (usually 1 for RoCE v2)
# -O: Use Implicit ODP
ip netns exec ns0 ibv_rc_pingpong -g 1 -O &
SERVER_PID=$!

# Give the server a moment to bind
sleep 2

# Start Client in host
# -O: Use Implicit ODP
ibv_rc_pingpong -g 1 -O 10.0.0.1

# 5. Collect Statistics
echo "--- Post-test Statistics ---"
echo "Host Stats:"
ip -s link show nk1
echo "Namespace ns0 Stats:"
ip netns exec ns0 ip -s link show nk0

# 6. Cleanup
echo "Cleaning up..."
kill $SERVER_PID 2>/dev/null || true
rdma link del rxe0 2>/dev/null || true
rdma link del rxe1 2>/dev/null || true
ip link del nk1
ip netns delete ns0

echo "Test Complete."
"

The output should be the following

"
# ./implicit_odp.sh
Cleaning up...
Setting up network...
Verifying IP connectivity...
PING 10.0.0.1 (10.0.0.1) from 10.0.0.2 nk1: 56(84) bytes of data.
64 bytes from 10.0.0.1: icmp_seq=1 ttl=64 time=0.071 ms
64 bytes from 10.0.0.1: icmp_seq=2 ttl=64 time=0.040 ms

--- 10.0.0.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1013ms
rtt min/avg/max/mdev = 0.040/0.055/0.071/0.015 ms
Configuring RXE...
link rxe0/1 state ACTIVE physical_state LINK_UP
link rxe1/1 state ACTIVE physical_state LINK_UP netdev nk1
Starting ibv_rc_pingpong with Implicit ODP...
   local address:  LID 0x0000, QPN 0x000011, PSN 0x51486a, GID 
::ffff:10.0.0.1
   local address:  LID 0x0000, QPN 0x000012, PSN 0xc14439, GID 
::ffff:10.0.0.1
   remote address: LID 0x0000, QPN 0x000011, PSN 0x51486a, GID 
::ffff:10.0.0.1
   remote address: LID 0x0000, QPN 0x000012, PSN 0xc14439, GID 
::ffff:10.0.0.1
8192000 bytes in 0.03 seconds = 2341.91 Mbit/sec
8192000 bytes in 0.03 seconds = 2354.70 Mbit/sec
1000 iters in 0.03 seconds = 27.83 usec/iter
1000 iters in 0.03 seconds = 27.98 usec/iter
--- Post-test Statistics ---
Host Stats:
8: nk1@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UP mode DEFAULT group default qlen 1000
     link/ether ba:48:69:41:c7:71 brd ff:ff:ff:ff:ff:ff link-netns ns0
     RX:  bytes packets errors dropped  missed   mcast
           1078      13      0       0       0       0
     TX:  bytes packets errors dropped carrier collsns
           4326      35      0       1       0       0
Namespace ns0 Stats:
7: nk0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UP mode DEFAULT group default qlen 1000
     link/ether 3a:46:ee:e9:12:36 brd ff:ff:ff:ff:ff:ff link-netnsid 0
     RX:  bytes packets errors dropped  missed   mcast
           4326      35      0       0       0       0
     TX:  bytes packets errors dropped carrier collsns
           1078      13      0       0       0       0
Cleaning up...
Test Complete.
"

If you think that rdma-core is better, I am fine with it.

Anyway, some testcases are needed to prove your feature.

Zhu Yanjun


> 
> Registration latency was measured for 4 KiB to 1 GiB across explicit
> and implicit forms. Explicit grows with size and fails ENOMEM at 1 GiB
> on a 6 GiB host. Implicit median latency stays in the low microseconds
> across all sizes; peak RSS during an implicit registration stays at
> the baseline, while explicit RSS climbs with the registered size. The
> benchmark measures registration-time work only; it does not
> characterize first-touch or steady-state data path cost. Tests, bench
> and raw numbers are in the companion repository:
> https://github.com/Liibon/rxe-implicit-odp
> 
> scripts/checkpatch.pl --strict on each patch: 0 errors, 0 warnings,
> 0 checks.
> 
> ---
> 
> Liibaan Egal (2):
>    RDMA/rxe: add local implicit ODP MR support
>    RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access
> 
>   drivers/infiniband/sw/rxe/rxe.c       |   7 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c    |  19 +++
>   drivers/infiniband/sw/rxe/rxe_odp.c   | 288 +++++++++++++++++++++++++++-------
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  18 +++
>   4 files changed, 275 insertions(+), 57 deletions(-)
> 
> Liibaan Egal (2):
>    RDMA/rxe: add local implicit ODP MR support
>    RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access
> 
>   drivers/infiniband/sw/rxe/rxe.c       |   7 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c    |  19 ++
>   drivers/infiniband/sw/rxe/rxe_odp.c   | 288 +++++++++++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  18 ++
>   4 files changed, 275 insertions(+), 57 deletions(-)
> 


