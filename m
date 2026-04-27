Return-Path: <linux-rdma+bounces-19592-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEUdGqKM72l5CwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19592-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:19:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57F4763AB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E110C311F404
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D034B1A4;
	Mon, 27 Apr 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="kmnqlfzT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA23396F4
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305715; cv=none; b=S47JXYgHLSGVDnhy6/YaSYFfFljVr+ciFgKqlE7m7C0dZt0fo3A8hpe7YBCF7iFHhghu362xd4aeHMskQd2Ea+Sk/HGjBRtSNj4TRuq1ruwJrzKoFboWTocfcjCLXHSSJ5idAgyLHExJEFFYV/tfMdhQHWU9RAPBjhvSM4Rshcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305715; c=relaxed/simple;
	bh=3nI4jh0qSpjXgDdJgMsEeE+LnWsU7E6SKeCla5t9yI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkpbdQHEgNP3MAibyXKLBV+QlVFi5fOpl/Q+BnnGnc9iRrlrUHgIE7Z5KOL1Ihozg7tLcXTooQg/Szcbu2SeMrV7uAlwjURqgZkfrMImjF5JqfQDjTN6BJb5X0YARgEJHIls7Gqv0YxfQJ7q1VuQSRSOgslxsn51BIkOzXIZK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=kmnqlfzT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so135943295e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777305712; x=1777910512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUIn/GeHnKQMX3ItFkglQNbpq/QxkRY25o0nGMIbjjc=;
        b=kmnqlfzT+VLa4gehYeZswkCKagxg08sH8GjJYZl2/2/P1VC3/8sMxqAT8tyWytFdp/
         gujNcseGsm4It1DG1yAtSZbt0fAExk07ewBTz0BDE3j/au0wHaRWWCUUesoCh4Nn7gOb
         5+20SiBbryxZ2gYymMKFbEGYq4CZy8nhDYqSFiQzUdLBcdiAv1WjLJ7sCHIF+mlQnBKZ
         hZv9RqMX1bJvPshZXlOChFYQ7DPMThWEvQSYBr/n8df7hpo3L2jcDHbAhUVfscbX0mF7
         33y6L63pADVRMkSZenN80mt6DlUoqZOQj1weSbI3Dc7prHxkrs7US46qS62iXrZaw3mm
         cNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777305712; x=1777910512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUIn/GeHnKQMX3ItFkglQNbpq/QxkRY25o0nGMIbjjc=;
        b=NQPr2C+cT2KOB0Xx/8Lm6vOsCxFOfo9+cwx/yXea9PFppA63R8SIWHJjcEplYUNYXA
         uCDgXNCQu84VKVTEW3MVo4KZfErhFsM75YZwBK1TgoPdolJ4YUSQclax9kSOPfMJGqRJ
         opucpW61HWsmC5nfjhj2FZmMKDqQWIG7y2/SNRyHk7AsjBurBEN0ESFDPKQ0aSNmKSdB
         zoj2XPwyNoi2nLzNh6yNfLTfWluv1de89l//vrrnMxTe4rP+F/enlfq9jNvf1UesDLPn
         sfzv2XUi6P4dw52m7dxYd962xqKiZ/zWQHFUIO4k1wlerTKoj3saKNkZtgU3PcEGdZpy
         WdeA==
X-Forwarded-Encrypted: i=1; AFNElJ/Uq5/BWYWdP2R/86JrseW0zeDfBrWQ+cliMiKb8BX2Qee2pwqrz5/L+CiEwiptoWKdmAgtvCSS6FYl@vger.kernel.org
X-Gm-Message-State: AOJu0YxhISMHKQ77x++ocUjNGq0CHxKsXkiLRDwfbRqwZLUZC3dBJSSN
	HB+0bIaxfQanwn9sWxdV5uLb22xEUZ8sdqxyix5U9mv1qwXHvhs/9d8qRNMQU+7afs8=
X-Gm-Gg: AeBDietycsno2Wbm4SNq3+9SXmgI9NxWBONioKJJDmOlriMW5CJll1NMPve4A5++JoQ
	xxUKgC8kn2A1eGkOyA9ICJgmdUjM7ziEwSBKMqLlxSpXUX9X6l4LGN9qjqqUXYlHreNbbe+xObf
	x2nrd3vqzSuAvcy/bd0G7ZzKd+n0sXdDSUeJu85kUIXk+cQMCMjiLSi6khVGvF49L7UV6wFBHd6
	A3Uc74U0nUk/8AuD2LIbH0gbntrDHmpo5OXiehQ5PQqMFsowawMMKSzydxzwMTG/mIqkKBZg4rX
	Y31dAUlRt89M1YSSuXH3pvZPxb5aUCWqcPgs3qxB6N2mVQy/wi/GTiMOq96/7qBJa5CBKqqG3KV
	uQxnoY7VtLTqBNyEY1hiwwh1sluc15ZeqwrgICdbSTpCuAkrGti95OqlGCE6n1HCZHcUzJS52nh
	/nZP6rfHqUZmuyJZG7OYlPjQhsIGfcO3WFnFTrEZfLmi8JHZjtl+K2F/N48DrxRoqTQ26I9FZ1M
	O4pkeYN7Bs++gE+GpPPw5x/PljzUUE30QJX
X-Received: by 2002:a05:600c:6216:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a76f53b01mr8705e9.11.1777305711990;
        Mon, 27 Apr 2026 09:01:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:142d:11f2:435b:9d94? ([2620:10d:c092:500::7:64e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a59816b71sm230488865e9.1.2026.04.27.09.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 09:01:51 -0700 (PDT)
Message-ID: <5d5f74ae-602e-4380-b4d3-442b4dc2ceb4@davidwei.uk>
Date: Mon, 27 Apr 2026 17:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kuba@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org> <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
 <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D57F4763AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19592-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davidwei.uk:mid]

On 2026-04-25 01:05, Dipayaan Roy wrote:
> On Fri, Apr 24, 2026 at 01:05:24PM -0700, David Wei wrote:
>> On 2026-04-23 05:48, Dipayaan Roy wrote:
>>> On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
>>>> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
>>>>> I still see roughly a 5% overhead from the atomic refcount operation
>>>>> itself, but on that platform there is no throughput drop when using
>>>>> page fragments versus full-page mode.
>>>>
>>>> That seems to contradict your claim that it's a problem with a specific
>>>> platform.. Since we're in the merge window I asked David Wei to try to
>>>> experiment with disabling page fragmentation on the ARM64 platforms we
>>>> have at Meta. If it repros we should use the generic rx-buf-len
>>>> ringparam because more NICs may want to implement this strategy.
>>>
>>> Hi Jakub,
>>>
>>> Thanks. I think I was not precise enough in my previous reply.
>>>
>>> What I meant is that the atomic refcount cost itself does not appear to
>>> be unique to the affected platform. I see a similar ~5% overhead on
>>> another ARM64 platformi (different vendor) as well. However, on that platform
>>> there is no throughput delta between fragment mode and full-page mode; both reach
>>> line rate.
>>>
>>> On the affected platform, fragment mode shows an additional ~15%
>>> throughput drop versus full-page mode. So the current data suggests that
>>> the atomic overhead is common, but the throughput regression is not
>>> explained by that overhead alone and likely depends on an additional
>>> platform-specific factor.
>>>
>>> Separately, the hardware team collected PCIe traces on the affected
>>> platform and reported stalls in the fragment-mode case that are not seen
>>> in full-page mode. They are still investigating the root cause, but
>>> their current hypothesis is that this is related to that platform’s
>>> PCIe/root-port microarchitecture rather than to page_pool refcounting
>>> alone.
>>>
>>> That said, I agree the right direction depends on whether this
>>> reproduces on other ARM64 platforms. If David is able to reproduce the
>>> same behavior, then using the generic rx-buf-len ringparam sounds like
>>> the better direction.
>>>
>>> Please let me know what David finds, and I can rework the patch
>>> accordingly.
>>
>> I ran a test on Grace, 4 KB pages, 72 cores, 1 NUMA node.
>>
>> Broadcom NIC, bnxt driver, 50 Gbps bandwidth. Hacked it up to either
>> give me 1 or 2 frags per page. No agg ring, no HDS, no HW GRO.
>>
>> Use 1 combined queue only for the server. Affinitized its net rx softirq
>> to run on core 4.
>>
>> Ran iperf3 server, taskset onto cpu cores 32-47. The iperf3 client is
>> running on a host w/ same hw in the same region. Using 32 queues, no
>> softirq affinities. The idea is to hammer page->pp_ref_count from
>> different cores.
>>
>> * 1 frag/page  -> 32.3 Gbps
>> * 2 frags/page -> 36.0 Gbps
>>
>> Comparing perf, for 2 frags/page the cost of skb_release_data() hitting
>> pp_ref_count goes up, as expected. Is this what you see? When you say
>> there's a +5% overhead, what function?
>>
>> Overall tput is higher with multiple frags. That's to be expected w/
>> page pool.
> 
> Hi David,
> 
> Thanks for running this. Your results are consistent with mine.
> 
> I have tested this on 2 ARM64 platforms from different vendors,
> running ntttcp and iperf3 using 4k as base page size.
> In my observation I see both platforms show a 5% overhead in
> napi_pp_put_page (~3.9%) and page_pool_alloc_frag_netmem (~1.9%)
> when running in fragment mode, both stalling on the LSE ldaddal
> atomic that maintains pp_ref_count.
> This seems to be same as your observation as well. However in my
> observation one of the platform shows 15% drop in throughput when
> in fragment mode vs page mode. The other platform I ran the test on
> infact performs slighty better in fragment mode than in full page
> mode (simillar observation as yours).

That's not what I observe. I don't see napi_pp_put_page at all, and
page_pool_alloc_frag_netmem is actually lower with 2 frags/page (4.06%)
than 1 frag/page (5.73%).

The main difference is in skb_release_data which goes from
0.85% (1 frag/page) to 3.32% (2 frags/page).

> 
> So the atomic refcount overhead appears to be common across ARM64
> platforms, but it does not cause a throughput regression.
> The throughput regression seems specific to one platform only for which
> we want to have the full page work around, also the HW team has
> identified PCIe stalls in fragment mode that are absent in full-page mode.
> Their investigation points to a suspected microarchitectural
> issue in the PCIe root port. IMO, there seems to be no issue with
> page_pool itself.
> 
> Given that:
>   - Grace shows fragments are faster (your data)
>   - A second ARM64 platform shows no regression (my data)
>   - Only the affected platform shows a throughput drop
>   - The HW team suspects this to a platform-specific PCIe issue,
>     also form our experiment data the drop in throughput seems to
>     be platform specific only.
> 
> I believe this remains a platform-specific workaround rather than
> a generic issue. Would a private flag still be acceptable for this
> case?
> 
> 
>>
>> There are some 200 Gbps NICs but they're mlx5 so I'd have to redo the
>> driver hack. Are you going to re-implement this change with rx-buf-len
>> instead of a private flag? If so, I won't spend more time running this
>> test.
>>
> I can go either way depending on what Jakub prefers.
> Hi Jakub,
> with this new data from David, is it convincing enough for a mana driver
> specific private flag, which can be set from user space by a udev rule
> by detecting the underlying platform? If not then I will send the next
> version with the other rxbuflen approach.
>>>
>>>
>>> Regards
>>> Dipayaan Roy
> 
> 
> Thanks and Regards
> Dipayaan Roy

