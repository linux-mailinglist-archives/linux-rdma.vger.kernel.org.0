Return-Path: <linux-rdma+bounces-19532-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEbtHA/N62kdRgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19532-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 22:05:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E221A4631B5
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 744C5301ABB9
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45336921E;
	Fri, 24 Apr 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="EpgKNC3N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE136CDE2
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061131; cv=none; b=HcJjDFzKiLCJjilHtJn/4xqdLlEs7AHTYTodMiodXiKK2Jp0SgEb6JoBkHuBiq6YHu8cpUMI4UWggsrIg42s2jbXuG9ZNiawOY1JSuJGry8BQ6Plx3+LFQTPI4y4m8Ztg+wrKIxlukrbZqqnLyiPhWj+02G9AriXJtG07etcxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061131; c=relaxed/simple;
	bh=/f45TGhiRpH2RbxOCsOiCwxyvAjF88RmLq2aBHY2Fs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgUFgstE8/VhT9gaMH+WjPhY6N8GdDHcP4D7eW3N32XBpR4T0vEg0VUWRlCH4RDsFInQZpsbTfxyUtiyQ2hyEqICP95yMIc7eAguLMMBqPu3RIk8nK84k0xoogZJF0lBin9cJpyipamhIH+ytgD6ODVeZIJlUhWk3OpBvzWXpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=EpgKNC3N; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso9103792eec.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777061129; x=1777665929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmQ/TEcLmXYNdfvNlx7+MJGDvd0ss7R7PnbOgKIaRis=;
        b=EpgKNC3Nw3MaNXMr385VZ5hoDkdqcvtN606XDHEgLRV79Zxevmd5KyME9zj96B4IvI
         TnIh17o546uTxhsjaGStXvKS9VphXERvh/VcIvTu9EHlFVAEP8xMjDG2FE+2w66+mc0Z
         oNeegKoIMJjX5pOu3eFs3mD60OhAIQZjyCruoDa3Mvkb06TxML4WphJk+la/LMszVACa
         87FT4Ug+H8aX7ooA11vni+8C9N4wqaUojarY1cGa9c8zCLJY71HZnPIv5n5LKUPQfyS5
         UH8rgnosmt1cg7OcDJISFvGI+QBlKU0YujCBdxtVxMnoWYgQntsnxBRF8XRM937BgP8h
         Z7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061129; x=1777665929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmQ/TEcLmXYNdfvNlx7+MJGDvd0ss7R7PnbOgKIaRis=;
        b=r7eC2gzrXbxB5bxhBdu+8+Oh9HFTLDy2nu0XH/p2NIpTlJ9Nispv7LmpayZMvmz4MZ
         gS+Fbz3F1D1vFejn8jEMH3gbLoCrYXcPvqgltmKxZCCqYxRx/hCpNPULm6cRH6DtyhPu
         FOGned0/pKqajYSTmXUUYcij5KDFfWnj3hFNEQRDTFC3udPkSOjBcuK2Rs+95Xb1gS1G
         Sc2hfh99zZMQE0z/eOmxyXwb9cW2NFFGhWdUZE1vCTRNy244rqFj4Oble6YuKOy109vc
         QmIx/kgtVyc5NYyDVexLbAxjqIL5gCxrlJPr/q06QD/OjuLYM8FURwp1yA7Oa5xroR+V
         r6rA==
X-Forwarded-Encrypted: i=1; AFNElJ+B8TFEjaugof0WK+U4sX/i5PoVZitVoHhQyCULD1R3N9pEo0GP2wmemfJQK9azDdFUcL4pnMp8u8nx@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqvYF5B3zN6Ob+Qp5wetcZK70hTSyUDI229mnJImJ3S8lPOyB
	obChPCxMeocMFyAlc5FlQVArYN/Y7IhCS6xygsrtkmWXO1NjmS2gPAWU3yqFNJdwWUo=
X-Gm-Gg: AeBDietzF7/tkwPg+neExVTAqZEykoeCnVkci4flLyq1tz3pPCSArKg3deTmHBv+ceO
	3LSIZAhGBJ63BVzP6Ns0wXVWC1Z7aSo4egdxx/aI92qg7MHi3JCAwahGPbXvFTS1qptDxxDiNdf
	RYtmI+RZ4AQ84tv7BL1v1j8ctGLaNHb/xEGBmB/Pad8ADOkCL/Prcsg+qV5BGoXLrjHgPgHsaUu
	zrFj3imzI2aJvUOOgd21bHM6EgnBioT5nhpj/vpgyc8dRPJ5G1jmbxeK8S4qofbBYPvdzv7hKsK
	nrcArhtp20kvBapIgzMRsQ+24ENj7VPCesAny1shZ3KeavkvcADb+OFYcKuFdqLuXt5Nqn1wHv7
	lt/DsU/DOEHa5YeR4BQlITbnvguRCGVFgqSTgtUF3X8TMf3q2yJqx8HeCfyQGctvElbauVT+JNH
	ZXI6YmD2k6V1N95F4uPrcfHSpiz67LoczJOR3Z56I7wQk+itrN2021sKOc5Pq3T1h5PBGu7ds27
	6J8yPjoRcqlT/KU9ld7I75g245hoGgIw+Q=
X-Received: by 2002:a05:7301:4586:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2e47873a866mr19109354eec.13.1777061128748;
        Fri, 24 Apr 2026 13:05:28 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1:eae7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa6134sm34784052eec.3.2026.04.24.13.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 13:05:27 -0700 (PDT)
Message-ID: <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
Date: Fri, 24 Apr 2026 13:05:24 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>
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
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E221A4631B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19532-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 2026-04-23 05:48, Dipayaan Roy wrote:
> On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
>> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
>>> I still see roughly a 5% overhead from the atomic refcount operation
>>> itself, but on that platform there is no throughput drop when using
>>> page fragments versus full-page mode.
>>
>> That seems to contradict your claim that it's a problem with a specific
>> platform.. Since we're in the merge window I asked David Wei to try to
>> experiment with disabling page fragmentation on the ARM64 platforms we
>> have at Meta. If it repros we should use the generic rx-buf-len
>> ringparam because more NICs may want to implement this strategy.
> 
> Hi Jakub,
> 
> Thanks. I think I was not precise enough in my previous reply.
> 
> What I meant is that the atomic refcount cost itself does not appear to
> be unique to the affected platform. I see a similar ~5% overhead on
> another ARM64 platformi (different vendor) as well. However, on that platform
> there is no throughput delta between fragment mode and full-page mode; both reach
> line rate.
> 
> On the affected platform, fragment mode shows an additional ~15%
> throughput drop versus full-page mode. So the current data suggests that
> the atomic overhead is common, but the throughput regression is not
> explained by that overhead alone and likely depends on an additional
> platform-specific factor.
> 
> Separately, the hardware team collected PCIe traces on the affected
> platform and reported stalls in the fragment-mode case that are not seen
> in full-page mode. They are still investigating the root cause, but
> their current hypothesis is that this is related to that platform’s
> PCIe/root-port microarchitecture rather than to page_pool refcounting
> alone.
> 
> That said, I agree the right direction depends on whether this
> reproduces on other ARM64 platforms. If David is able to reproduce the
> same behavior, then using the generic rx-buf-len ringparam sounds like
> the better direction.
> 
> Please let me know what David finds, and I can rework the patch
> accordingly.

I ran a test on Grace, 4 KB pages, 72 cores, 1 NUMA node.

Broadcom NIC, bnxt driver, 50 Gbps bandwidth. Hacked it up to either
give me 1 or 2 frags per page. No agg ring, no HDS, no HW GRO.

Use 1 combined queue only for the server. Affinitized its net rx softirq
to run on core 4.

Ran iperf3 server, taskset onto cpu cores 32-47. The iperf3 client is
running on a host w/ same hw in the same region. Using 32 queues, no
softirq affinities. The idea is to hammer page->pp_ref_count from
different cores.

* 1 frag/page  -> 32.3 Gbps
* 2 frags/page -> 36.0 Gbps

Comparing perf, for 2 frags/page the cost of skb_release_data() hitting
pp_ref_count goes up, as expected. Is this what you see? When you say
there's a +5% overhead, what function?

Overall tput is higher with multiple frags. That's to be expected w/
page pool.

There are some 200 Gbps NICs but they're mlx5 so I'd have to redo the
driver hack. Are you going to re-implement this change with rx-buf-len
instead of a private flag? If so, I won't spend more time running this
test.

> 
> 
> Regards
> Dipayaan Roy

