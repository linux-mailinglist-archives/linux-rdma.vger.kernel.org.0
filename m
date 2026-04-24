Return-Path: <linux-rdma+bounces-19530-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOa3Gz+Z62lSPAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19530-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 18:24:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76631461498
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7479130074DE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E53E1D01;
	Fri, 24 Apr 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="K+S9Wv+L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB223E1230
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047864; cv=none; b=kRIh6cfmve8ZTN79aMEZc1HerZIZy0p5w4qfNci8Sl5eM/yitDGxylDYNcowIbWLr+J3yx1jHWgFK4GFcgcX7D4+ugQsIJLxBh4j8lCXytOU0lfc5ONTHIRsxL1qLPiP13KgVbG/cMzSqjJoKniWkiPiMu7ri0KQQG0vgIplCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047864; c=relaxed/simple;
	bh=rKnGZyadXRPn7+yUgtk6UZv9kH+5IP0bOXa8EOkSS0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+IrSDwKx1CMdFR2jB+CcDg8/VCHNxHJ6i5v+rvXITyD0N8U4OmOJszbacfU3XsHfeDHiyFk6RVE9Mz5ALa58URblsmVyBnHazMz5unCXqWdiFd8T8w2EnTDQdWlxvGE6D6tmJIuYu1T4UX1inUb/QOYwVf/GzRkeG9GbPJdsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=K+S9Wv+L; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c15849aa2cso10832652eec.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777047862; x=1777652662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6Od9QgYAcJsV8ihusavCJrmScuqDKBApgvlcBNX0xU=;
        b=K+S9Wv+Lx4FumHi/iwwLlqeJdpw1H/kIa67Ay1IH9c7VEfD9bxGb5GuxgZFG3t7Id0
         evelc8FXc/RrUozpk/zeh/xh/Iyai7lcZFpXCDee9MiXz5FsVAuKVBgx19sXIAnW4Ppu
         7xJvG9VedojkNJv9FIerT5jXcPSaIGrNqHEQZBCdUjqJ9iwv5391yJRpj6UAaQnYw9JZ
         nakVc6pI+56xRCFObv/yLpGfDu1KwP/hJroI1F7A+zg+m5Van15pmgTQb9m9JccOgaFz
         E2cCUiFEb0Cna/QKzCEqkJXaYf3a16j0VKx36CAC2AWPQ8iSCrHg37alSbRwgHy4fEfw
         101A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047862; x=1777652662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6Od9QgYAcJsV8ihusavCJrmScuqDKBApgvlcBNX0xU=;
        b=ZTJ2rwe2M8jKrZYMIggTQLflmdKLvoxRA9gX3rg1fJtCMuFTgGISUNT7kQdOOCfLlK
         hK0Sju1/LHwYTg1n34Z631OH5bRQ0pvUdaIqgvdeCjxXVlhQvBSUChvZkz4NL8wU58rH
         vRodZx+o8vVjHRRj963SHRu9cl8FT00cgbBRkgcNwyC69NW4NxZAJWAN10Pw0e3IBzpR
         dAfAySjIGlm41Qs+z1tUqRrp4ke95s6IKxNcSvN21KKuVjvFjFJM8oJPhi/kJQGRif0t
         lE2rQbYRRg32rFxoa1w1+qM66qpOqH4FM9svnMV/9IxWC4lHHwBQDtVAMJK2HYjDEtgM
         QddA==
X-Forwarded-Encrypted: i=1; AFNElJ8aaUB4+hzEKpm7nBg7MJYxGnv88MWQtpURTTmlrWOYs60e8tBvmJOcothgXVP8+4XPQS4GOTQsLFfr@vger.kernel.org
X-Gm-Message-State: AOJu0YxJddFO698zPcyf4iFpp/xPMXFO9HOXnW+qwXSNqcZXtfJROb7V
	Dy4IE6YOan8NgJM+Bb1nKl7Sa5Bmkm8z05in048a9lbWKk8zTKzsPgU4MY7opo2QS10=
X-Gm-Gg: AeBDies7Z/IIeFAm6MwepXO72QrMP8e4VJyEZoPxNLYd2b7PDMsxmZydIWEhXA6zl8v
	kQ1F6WBAOz576V+pxl9HIh7JfgC+vN2vStLGHFbWOxiaETKMYjtVr3qP0fj9gTHwXa4RH5kUCAp
	8sdj9TScePsX+HiMVOjjONXS/PRPIyZZG9ybts4Zw9PbRmbHDa/aXAz3WaaTqQlDHk3Yg+jz1tJ
	0Wix7LHj0O/Se+GSFkzSFHF6suoiophmi8maCH8ghzwqFEtoMAVOfR/xde3lC4Ty1DVy7qNL2fG
	n3q1WgqRhkzzJYjsp/qeRSi7fzqHetr9CoEXagjsF0SlOEj+TjilR1oDq8Xh812/+y4eDggDevE
	ZpcJsea8WHyAIFcrnDUZ8rS66oqvxnfSNX2PB/sMjH4Ir/4vmnCLj+J4CW7mrGVDNf+qs8ztwZA
	A4XXivnFdiTiRPnAmOtlT01JM8eDr2uVAQsBsCmFnHmWhBl9RzCmNzzjzL5nGFk2JfpFRHclMKn
	KTlbqW+kkkTrOTjbdIxhbixiQEa8ahAqd4=
X-Received: by 2002:a05:7300:8607:b0:2d4:94cc:eebb with SMTP id 5a478bee46e88-2e477c9bc50mr17941859eec.13.1777047862086;
        Fri, 24 Apr 2026 09:24:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1:eae7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8aed43sm32348927eec.26.2026.04.24.09.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 09:24:21 -0700 (PDT)
Message-ID: <fa0b5704-21ae-4011-be0c-97fab3a026c5@davidwei.uk>
Date: Fri, 24 Apr 2026 09:24:18 -0700
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
X-Rspamd-Queue-Id: 76631461498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19530-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

Hi Dipayaan. Can you please share more details on your testing setup?

* What are you using as the test client/server? iperf3 or something
   else?
* What do you mean specifically by "5% overhead from the atomic refcount
   operation"? Some specific function?
* What are you using to measure? perf?
* How many queues, what is the napi softirq affinity?
* How many NUMA nodes? Does the problem only appear when crossing?

Thanks,
David

> 
> 
> Regards
> Dipayaan Roy

