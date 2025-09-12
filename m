Return-Path: <linux-rdma+bounces-13325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51601B55943
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609EFAA4E94
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930F20C037;
	Fri, 12 Sep 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ay54HSMt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363D254B09
	for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716418; cv=none; b=lnLswkJbh8exhWZsaockE2z/pkqlatp3FTco1LlZvVVEJGsq7pYtIgJQUtf+1UFtXsw4RGENrwaL7hFkaRE/V/vUb3WMo9qCyTd6sRijftByKNrdfY2NHx9RMJRu8gYnkNIx/E/xi7lz/ozAf1t/k/UtsQY5QESU7L0ejDlE5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716418; c=relaxed/simple;
	bh=gS7rphc6aYnaIBmIyFe9zOQ46AdkNEfq2Ttr0uMHn3E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FoPmf1hcG+Pda3rYImQv8n/iPLoshKafbxXXn6LKAEzptJXe2fNan9SfQDMFAmnPhcm+E77n2bobUl19B0ot6YBL49jAihSTWqEgLMxbxxLOsUjD39nkSRc82w1RyUOXist3VPCToPqAQMjvYx9HrnpihRfROLB2ltH9ZtpimjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ay54HSMt; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <122fe058-a02e-41a7-b012-4d38262055ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757716408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLJpXR+Ex1glAjIre1OOy0+mUN2IFHL2I9AqxwEWh9g=;
	b=Ay54HSMtlYJeKFcVNSMEy/HEiK/rnHA6kgQL2EE1uoJPoS54DDXDE6LCo/vie2mPv5NMR0
	5ReGrp+rX6BC6MbHQmRjUS49yNj23wrxfU69N/viReKRdxlJ3p/SqIanAU979vurw2J0Es
	iNMneOZNEYJ9cpzpofXP41E3k8YkwW8=
Date: Fri, 12 Sep 2025 15:33:22 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
 edwards@nvidia.com, hdanton@sina.com, jgg@ziepe.ca, leon@kernel.org,
 leonro@nvidia.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c3a49a.a70a0220.3543fc.0031.GAE@google.com>
 <6f3b9149-2a2d-4532-b38f-946b98e72000@linux.dev>
 <691d3ecd-7960-46bb-b41e-be223e320d33@linux.dev>
Content-Language: en-US
In-Reply-To: <691d3ecd-7960-46bb-b41e-be223e320d33@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/12/25 1:01 PM, Yanjun.Zhu wrote:
> 
> 
> On 9/12/25 12:38 PM, yanjun.zhu wrote:
>> On 9/11/25 9:42 PM, syzbot wrote:
>>> syzbot has bisected this issue to:
>>>
>>> commit a92fbeac7e94a420b55570c10fe1b90e64da4025
>>> Author: Leon Romanovsky <leonro@nvidia.com>
>>> Date:   Tue May 28 12:52:51 2024 +0000
>>>
>>>      RDMA/cache: Release GID table even if leak is detected
>>
>> Maybe this commit just detects ref leaks and reports ref leak.
>> Even though this commit is reverted, this ref leak still occurs.
>>
>> The root cause is not in this commit.
>>
>> "
>> GID entry ref leak for dev syz1 index 2 ref=615
>> "
>>
>> Ref leaks in dev syz1.
> In this link: https://syzkaller.appspot.com/x/log.txt?x=157dab12580000
> 
> "
> [  184.209420][ T6164] infiniband syz1: set active
> [  184.215960][ T6164] infiniband syz1: added syz_tun
> [  184.222514][ T6001] veth0_macvtap: entered promiscuous mode
> [  184.231935][   T42] wlan0: Created IBSS using preconfigured BSSID 
> 50:50:50:50:50:50
> [  184.239777][   T42] wlan0: Creating new IBSS network, BSSID 
> 50:50:50:50:50:50
> [  184.256962][ T6001] veth1_macvtap: entered promiscuous mode
> [  184.276479][ T6164] syz1: rxe_create_cq: returned err = -12 < -- 
> rxe_create_cq failed, the test should not continue.
> 
> [  184.288430][ T6008] veth0_vlan: entered promiscuous mode
> "
> 
> err = -12, is -ENOMEM.

"
[  139.009314][ T6730] infiniband syz1: added syz_tun
[  139.015974][ T6730] rdma_rxe: vmalloc_user failed, buf_size: 131456, 
num_slots: 1024, elem_size: 128
[  139.016142][ T6730] syz1: rxe_cq_from_init: unable to create cq
"

 From the above logs, vmalloc_user() fails when trying to allocate 
131,456 bytes of memory.

Is there a specific limit on vmalloc allocations in this test case?

Also, what is the size of memory available on this machine? (Hardware 
name: Google Google Compute Engine/Google Compute Engine, BIOS Google 
08/18/2025)

Thanks,
Zhu Yanjun

> 
> It means that memory allocation fails.
> 
> Zhu Yanjun
> 
>>
>> Zhu Yanjun
>>
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt? 
>>> x=13fc9642580000
>>> start commit:   5f540c4aade9 Add linux-next specific files for 20250910
>>> git tree:       linux-next
>>> final oops:     https://syzkaller.appspot.com/x/report.txt? 
>>> x=10029642580000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=17fc9642580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config? 
>>> x=5ed48faa2cb8510d
>>> dashboard link: https://syzkaller.appspot.com/bug? 
>>> extid=b0da83a6c0e2e2bddbd4
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz? 
>>> x=15b52362580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000
>>>
>>> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
>>> Fixes: a92fbeac7e94 ("RDMA/cache: Release GID table even if leak is 
>>> detected")
>>>
>>> For information about bisection process see: https://goo.gl/ 
>>> tpsmEJ#bisection
>>
> 


