Return-Path: <linux-rdma+bounces-21139-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KFUFbN0D2r4MQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21139-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 23:10:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D55AC0B2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83559303C67D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478D3A05F5;
	Thu, 21 May 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dx4jWnZF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EA367B66
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397786; cv=none; b=s+ZSO5xdipSpuOx73/ETKscoSrmWIsbh26m2ivH4POGIG1xRWpAf7Y4aR1l03QlNMfumwLRXVvxRDzHCCYwLS/ZmKO4ClPyREJi3cZublArEjyiEJkpt1qcl3KPs3ZeH8EA7kS25pdfpBuYnx+EWsNnZyrRtGJ6ETE/cUUHJ8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397786; c=relaxed/simple;
	bh=nzRzFyxu8OQ+8Ulyitx5Zp1CzCu6vO5rFxJBVUh3PtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usykFUIDK2j1iqwY9HJtnPW9UhadqeIDQ6WuTXzzDzjSS8WysqhpFD7qrwTZMmJShCb5wBM/yxNlPgd+qEbc1OM1RVebflaQG4u61/dMNugspFUuoktj3ANAa8LxPtElsGN7RUuvr4aypvVBcMO1wafOlOI3KYZPwZsc7fNt2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dx4jWnZF; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b49f99f3-ff34-422e-9e74-d31f7b539d14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779397782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tl1fsYTL7jGtXNSP+39fpNUf2FGoF7KnQqP4ibidPlc=;
	b=Dx4jWnZFi0K0BtUFnSpU55NR6P33StwKsXVQOXwDurczgd0/m9M488/Y62tl1BDSEZ6tSk
	mSxHGoSEb2sFndQgMu9id0tYLZDf5rSXtWJr4zXCIquMSi7yoy674qyRaL9fK3/Ubd3tMO
	uYW9Ve2Cp3qN7CUlT4ZIIu2Bzpk8aMg=
Date: Thu, 21 May 2026 14:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
To: Tristan Madani <tristmd@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
 linux-rdma@vger.kernel.org
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
 <20260519145610.GA33515@unreal> <20260519150042.GL7702@ziepe.ca>
 <6a0ce47d.096dab79.284c84.5b30@mx.google.com>
 <6cb1092d-e3d6-4596-92e3-e0c7030680af@linux.dev>
 <177927858387.523368.14013568639772229181@gmail.com>
 <47169436-4652-440f-b9f1-325d281f9ed1@linux.dev>
 <177936591204.388755.5473985581960215738@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <177936591204.388755.5473985581960215738@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21139-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF7D55AC0B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/21/26 5:18 AM, Tristan Madani wrote:
> Hi Yanjun,
>
> Could you confirm whether your Debian 6.12.86 kernel was built with
> CONFIG_KASAN=y and CONFIG_KASAN_VMALLOC=y?
>
> The stock Debian kernel does not include KASAN. Without it, the
> out-of-bounds reads are silent -- the kernel reads past the allocation
> boundary into adjacent memory with no crash or warning. The reproducer
> completed 152 iterations successfully, which means the race fired and
> the OOB reads occurred, but a non-KASAN kernel has no way to detect
> them.

Thanks a lot.

This is my script:

"
uname -a
cat /boot/config-7.1.0-rc3-netkit-ebpf+ | grep -i kasan
modprobe -v rdma_rxe
rdma link add rxe0 type rxe netdev lo
ip -6 addr add fe80::200:ff:fe00:0/128 dev lo
ip -6 neigh add fe80::200:ff:fe00:0 lladdr 00:00:00:00:00:00 dev lo nud 
permanent
./rxe-toctou-repro
dmesg | grep -c 'BUG: KASAN'
"
This the test results:

"
Linux debian 7.1.0-rc3-netkit-ebpf+ #31 SMP PREEMPT_DYNAMIC Thu May 21 
12:23:25 PDT 2026 x86_64 GNU/Linux
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_KASAN=y
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
# CONFIG_KASAN_VMALLOC is not set
# CONFIG_KASAN_EXTRA_INFO is not set
insmod /lib/modules/7.1.0-rc3-netkit-ebpf+/kernel/net/ipv4/udp_tunnel.ko.xz
insmod 
/lib/modules/7.1.0-rc3-netkit-ebpf+/kernel/net/ipv6/ip6_udp_tunnel.ko.xz
insmod 
/lib/modules/7.1.0-rc3-netkit-ebpf+/kernel/drivers/infiniband/core/ib_core.ko.xz 

insmod 
/lib/modules/7.1.0-rc3-netkit-ebpf+/kernel/drivers/infiniband/core/ib_uverbs.ko.xz 

insmod 
/lib/modules/7.1.0-rc3-netkit-ebpf+/kernel/drivers/infiniband/sw/rxe/rdma_rxe.ko.xz 

[*] RXE shared-memory TOCTOU reproducer
[*] Target: non-SRQ recv path reads WQE from mmap
[*]         without copy -- num_sge is raceable.
[*] UD check_length() iterates sge[] with mmap'd num_sge
[*]   as the loop bound -- inflating it walks OOB.

[+] Device: rxe0
[+] RQ buffer at 0x7f7215958000 (log2_elem=6, mask=0x1)
[+] UD QPs: sender=17, receiver=18
[*] Racing 500 iterations...


[*] 500/500 iterations completed
[*] 0 WC errors observed (race manifestation)
[*] Check dmesg:
       dmesg | grep -A10 'BUG: KASAN'
     Expected: vmalloc-out-of-bounds in rxe_resp_check_length
     or slab-out-of-bounds in copy_data
0
"

I have run this script for more than 100 times. But I still can not 
reproduce the mentioned problem.

Maybe there is something wrong with my test steps.

Zhu Yanjun

>
> Rebuilding with CONFIG_KASAN=y, CONFIG_KASAN_INLINE=y, and
> CONFIG_KASAN_VMALLOC=y should make the violations visible in dmesg.
> I can share my .config if that helps.
>
> Tristan

