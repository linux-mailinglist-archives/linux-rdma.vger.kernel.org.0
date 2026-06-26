Return-Path: <linux-rdma+bounces-22494-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gDbyMW/APmq1LAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22494-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 20:09:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B26CFA2D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 20:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=email-od.com header.s=dkim header.b="a/YBz0uy";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22494-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22494-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBCCA3136921
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F333B27C2;
	Fri, 26 Jun 2026 18:02:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBCF3AEF36
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 18:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496956; cv=none; b=XKcjyNOoygK8lqEYQovzohZcQQbdJfTSZJ4PwRzYmoE1Q2L5YhXnePs0ZVo19IYJde1xVSzwZC2eG8KatXgNyafcinDqCF0TdhU+7xcClcmOIxX2UPfE3frXRwGE3pHcOfygK3SFCizksYows9d/ATSz/xW2Qt1gMKkUiEqTkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496956; c=relaxed/simple;
	bh=+0nIDz5/3v4pUWM78ysJXZEn71a7R2sVTE9U1GyN5Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPoKjC1dxl1KDZb0SG1TTt9LxWd6CxOjLzQumvj7UUarGgs+RH5HJHKX5we1GnEhr1rIYHRO2wdHRbRFKEpnHoBERLF5nhMGKU7iZAATuM5pb31YJiLq+dB0DI8WopM0bpJti8jnnC92cXVYUBgQZj7zNWQGC3z70C8cD1fFv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=a/YBz0uy; arc=none smtp.client-ip=142.0.186.134
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1782496951; x=1785088951;
	h=content-transfer-encoding:content-type:in-reply-to:from:content-language:references:cc:to:subject:mime-version:date:message-id:x-thread-info:subject:to:from:cc:reply-to;
	bh=54noMUafHcisrmJLQeLAAZeIsyBBva5/RhjHOCmMG0g=;
	b=a/YBz0uyLo35BvvT1oJMQKBVT+SknFGqVTgiSMvAuH2jAloyqKw3+cL9Isa5HpAmz7ok7B9hTKGMp8H+8NWAF0k2RGQRkB4/suHZyGwtXFv6LH9o7KfyJRGYIWc/0l8cRT2cNgwIbQVmy1OlnvfghTLHdHv6sH+tq3dBUhKnZiQ=
X-Thread-Info: NDUwNC4xMi41ZjNlMTAwMDA0M2UzZTUubGludXgtcmRtYT12Z2VyLmtlcm5lbC5vcmc=
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from [192.168.0.207] (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id 3A4FF2CE04D9;
	Fri, 26 Jun 2026 14:02:19 -0400 (EDT)
Message-ID: <aa190e99-2ebf-4d59-a6c9-755ca181e16d@nalramli.com>
Date: Fri, 26 Jun 2026 14:02:18 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mellanox/mlx5-next RFC 1/1] net/mlx5: RX, Fix refcount warning
 on frag page release
To: Dragos Tatulea <dtatulea@nvidia.com>, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com
Cc: nalramli@fastly.com, leon@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260625174059.2879717-1-dev@nalramli.com>
 <20260625174059.2879717-2-dev@nalramli.com>
 <9f150145-d95c-4a90-a358-5b33ab78a8ef@nvidia.com>
Content-Language: en-US
From: "Nabil S. Alramli" <dev@nalramli.com>
In-Reply-To: <9f150145-d95c-4a90-a358-5b33ab78a8ef@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[email-od.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dtatulea@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:nalramli@fastly.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dev@nalramli.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22494-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[nalramli.com: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@nalramli.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[email-od.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,email-od.com:dkim,nalramli.com:mid,nalramli.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 230B26CFA2D

On 6/26/26 09:12, Dragos Tatulea wrote:
> 
> 
> On 25.06.26 19:40, Nabil S. Alramli wrote:
>> Under memory pressure, mlx5 driver has WARNING during fragmented page
>> release. This happens because there is a discrepency between what mlx5
>> thinks the page fragment counter is vs what the page_pool actually says it
>> is.
>>
> The mlx5 frag counter is not the same as pp_ref_count. The page gets
> split into 64 parts during page allocation. The frag counter tracks how
> many of those frags have been used.
> 

Thank you for explaining that to me. I thought it was the same because in
mlx5e_page_release_fragmented, drain_count is computed from frag_page->frags
and then passed into page_pool_unref_page as the nr parameter which is then
compared to the refcount in the page_pool.

>> The cause of the issue is page allocations on concurrent cpus, which
>> increment the non-atomic u16 page counter mlx5e_frag_page.frags, while at
>> the same time the page reference counter net_iov.pp_ref_count is atomically
>> incremented. That sometimes leads to a difference in the counts and
>> therefore triggers the warning in page_pool_unref_netmem:
>>
> page_pool page allocations must not happen in parallel on different CPUs.
> Each queue has its own page_pool and allocation happens within the NAPI of
> that queue which sticks to a single CPU. The release path does support
> releasing on another CPU (release to ring).
> 
> How did you encounter this scenario of having parallel allocations on
> different CPUs from the same page_pool?
> 

Perhaps we didn't, I had assumed that the numbers must match. What we did
encounter is these WARNINGs, and they seemed to go away with this patch but
maybe it is a coincidence.

>> ```
>> 	ret = atomic_long_sub_return(nr, pp_ref_count);
>> 	WARN_ON(ret < 0);
>> ```
>>
>> The actual stack trace looks like this:
>>
>> ```
>> WARNING: CPU: 37 PID: 447795 at include/net/page_pool/helpers.h:277 mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
>> Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
>> Hardware name: *
>> RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
>> RSP: 0018:ffffc90019814d98 EFLAGS: 00010293
>> RAX: 000000000000003f RBX: ffff88c0993d0a10 RCX: ffffea02424592c0
>> RDX: 0000000000000001 RSI: ffffea02424592c0 RDI: ffff88c090e20000
>> RBP: 000000000000000a R08: 0000000000001409 R09: 0000000000000006
>> R10: 0000000000000000 R11: ffff88c095fbc040 R12: 000000000000141f
>> R13: 0000000000000009 R14: ffff88c090e20000 R15: 0000000000000001
>> FS:  00007f34149fa6c0(0000) GS:ffff89200fa40000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ed0265eb000 CR3: 0000005091cbe000 CR4: 0000000000350ef0
>> Call Trace:
>>  <IRQ>
>>  mlx5e_free_rx_wqes+0x7b/0xa0 [mlx5_core]
>>  mlx5e_post_rx_wqes+0x1ac/0x5a0 [mlx5_core]
>>  mlx5e_napi_poll+0x5e5/0x6f0 [mlx5_core]
>>  __napi_poll+0x2b/0x1a0
>>  net_rx_action+0x30e/0x370
>>  ? sched_clock+0x9/0x10
>>  ? sched_clock_cpu+0xf/0x170
>>  handle_softirqs+0xe2/0x2a0
>>  common_interrupt+0x85/0xa0
>>  </IRQ>
>>  <TASK>
>>  asm_common_interrupt+0x26/0x40
>> RIP: 0010:page_counter_uncharge+0x34/0x90
>> RSP: 0018:ffffc900e728bb00 EFLAGS: 00000213
>> RAX: ffff88aff4762000 RBX: ffff88aff4762100 RCX: 0000000000000304
>> RDX: 0000000000000001 RSI: 00000000004e9e1a RDI: ffff88aff4762100
>> RBP: 0000000000000001 R08: ffff891ea0560048 R09: 00007ffffffff000
>> R10: 0000000000001000 R11: ffff891ae8061b00 R12: ffffffffffffffff
>> R13: ffff89107fcfd4c0 R14: ffff891ae8061b00 R15: ffff892002fe1400
>>  uncharge_batch+0x40/0xd0
>> ```
>>
> Can you provide more data on how you reproduced this? This helps to
> narrow down the bug. Reproduction steps would be ideal.
> 

I don't have clear steps to reproduce it, we just have seen it randomly on
some servers that were under memory pressure. I will try to look into it more
and find a way to reliably reproduce it. I agree that would be ideal to find a
proper fix.

>> The fix is to use an atomic page fragment counter, so it will always match
>> the number of references held in the page_pool.
>>
> This is not the right fix. The mlx5 page frag counter is not atomic
> on purpose because all changes to it happen only within the NAPI
> context.
> 

That was a question that I had, is it ever possible for frag_page->frags to be
incremented / set outside of NAPI context? I tried to answer that by looking
at code and by tracing it but could not get a clear picture. If it's not
possible then I agree, this is not the right fix.

> Thanks,
> Dragos

Thanks again for your guidance.

Nabil S. Alramli


