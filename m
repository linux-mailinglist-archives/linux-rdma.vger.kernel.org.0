Return-Path: <linux-rdma+bounces-12579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622EFB19CCB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Aug 2025 09:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5011781F3
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Aug 2025 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741ED23B616;
	Mon,  4 Aug 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsnKZoTk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93352239086
	for <linux-rdma@vger.kernel.org>; Mon,  4 Aug 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293134; cv=none; b=c+85FIthHCoEttVBNxwop+9/kQZSxnXZTJTZO242idfFIf6D89YymFaa2VXvOW5wywkkQPWA7lnBhcD4uJRGzneBfDafyPtLYGgzdVBbqEs4SB/1nIOeHN1o3YiShvp4PsNswA/P67T4Z7+UTSjfTjbdrkVThfmvNjdRUaPoXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293134; c=relaxed/simple;
	bh=1GRAnZqAm+wKVU4tAiU9SelRVltTveNBIebuBfO9Lz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBt0yTEQ8XWJVO/gDoTWL9zlGRLZQylxiOOHbm24fkMJe6Uhi5ijXqjkiiOyXk3pErLnXa6BerwxazGzQTVVdHfep5wYeMCrr8IlWdhIVp4a0QbBqxVJ3SCCGKJ2FH4bD+LZ3TQGngf4DwtF4MbJ+UYN3mXbxq15GqeTiaSq5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsnKZoTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754293131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CzK+aHI7pV/260UpuhODkvZhd1+LktSEwZyabmfoWcU=;
	b=BsnKZoTkim1wv2XcCoXBtQzLJpzcyeTD5tkoV4fH6CfF8Svrbb+glsj7rzRFSTKUx/1dXw
	KMAAhSr/Zyh8cSKxj5KKQq1z20bJWH6wbhl3u6cMr45xvlmui8aYMmVzQU3JKIS6VZWzVy
	pmDsK2XWGpMUsGT2q1xYaXS9ia3B0Ps=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-hyAh8iBtOBGpzddrStrqPg-1; Mon, 04 Aug 2025 03:38:48 -0400
X-MC-Unique: hyAh8iBtOBGpzddrStrqPg-1
X-Mimecast-MFC-AGG-ID: hyAh8iBtOBGpzddrStrqPg_1754293127
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so1688416f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 Aug 2025 00:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293127; x=1754897927;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CzK+aHI7pV/260UpuhODkvZhd1+LktSEwZyabmfoWcU=;
        b=KEAdHGod+00hEju48LkEbnuT0mccBFq4w6kw8IVAGi6g9nZuUBYFHRVn3itAoOAi6A
         RUzUrTFG3iAZhQf2BKKo9GoG1sIq5L3AB2Q9K9CM/Z+qaLM4jg5gZCb5ecd5mGkKUpML
         aBJI2uzCTKZsHk+0YrOpQfF+Z1CauKqB02PnQFj8KYRmqnN2exWsbf2ZorVgRCrmXYrr
         Mwj7jCmNiylLM70tErqy6KUBWDOUZG83Ckz17xns9p9k8XZg6I6SRADh56NQr+6GrZ36
         0Y0Gb+cuRTPMMxhEzUKqdbwImd6rzqf9oCWRhSWbjLT49Q+NyXnKpdiOo4Ppm/2YPgpH
         aa3g==
X-Forwarded-Encrypted: i=1; AJvYcCXGfSdn9x6GLc6WAJSzjcL3MTpxciBoJ2Y2MtbeKKYilKYYswGqTBUlyAij65xpWvmQCrQhZWLF+5qL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OB6O23D8M7mZfE+PkLhUXZIp/e1de+EAABiKEld2R+P3PLP3
	DDzMpOlgVk0n3dKKmYIk9/wBb8isHLHl+35dsEGncpxmPBgMN8zB3swX7d7KIdtrKT/1Iu1o76R
	pVZBn0BNhZ65j+LTrUD71gpUBWECgEDT03EEuNKyh/AwS5Ck76OAWAo0WeEP9PzI=
X-Gm-Gg: ASbGncueuQYfJOXbPQ8sznA62JAzCa5q8SnZEqzZUmvDhHP3RLscASLqejqlblbtaA2
	YI5LbRS/1T0P36HC7ImHB4zsYcFxnmmg7sgQ87IjilMPPPMFVjPKQv0pmDo302TqtuXFZaJC6V2
	iZNxxFWV5gCVfKvGjpBOe4aeaDkfM0y9nm27qjHGKeKi95544kkfAVlwL68eAeTIw8UUYfq6dXZ
	RYAPtsUnzb+9qkaVj3V33MtmsH1rc/ZNGy7eu/4oFqGZcSAO07+lHgdXhQZffaEM7zROsIuT/XI
	fkmJye1+I9RopjxwZg/YcQHNF9lhlzarMpp6oxX2JvU1NOmSWCglemEpZSGeh/GwehQ9nDs=
X-Received: by 2002:a05:6000:26ca:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b8d94ca582mr6319709f8f.56.1754293126664;
        Mon, 04 Aug 2025 00:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrMUdYx9Ob46gquQaFnoCtyHDHDuKowbCd8TC5DD9f1A8ghltY2UwuxdLS8+6L1j4QaRuF2A==
X-Received: by 2002:a05:6000:26ca:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b8d94ca582mr6319682f8f.56.1754293126157;
        Mon, 04 Aug 2025 00:38:46 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f1eb.dip0.t-ipconnect.de. [79.241.241.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47b10asm14296055f8f.60.2025.08.04.00.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:38:45 -0700 (PDT)
Message-ID: <8aa31e69-588e-4c7c-9857-553c2d6a2e11@redhat.com>
Date: Mon, 4 Aug 2025 09:38:42 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
To: Byungchul Park <byungchul@sk.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250729110210.48313-1-byungchul@sk.com>
 <20250802150746.139a71be@canb.auug.org.au>
 <20250804011730.GB39461@system.software.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804011730.GB39461@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 03:17, Byungchul Park wrote:
> On Sat, Aug 02, 2025 at 03:07:46PM +1000, Stephen Rothwell wrote:
>> Hi,
>>
>> On Tue, 29 Jul 2025 20:02:10 +0900 Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> Changes from v2:
>>> 	1. Rebase on linux-next as of Jul 29.
>>
>> Why are you basing development work in linux-next.  That is a
>> constantly rebasing tree.  Please base your work on some stable tree.
> 
> Sorry about the confusing.  I misunderstood how to work for patches
> based on linux-next.
> 
> However, basing on linux-next is still required for this work since more
> than one subsystem is involved, and asked by David Hildenbrand:
> 
>     https://lore.kernel.org/all/20250728105701.GA21732@system.software.com/
> 
> I will base on linux-next and work aiming at either network or mm tree.

I think this is the key part: there is nothing wrong on temporarily 
basing your stuff on linux-next, while we are waiting for this merge 
window to end and relevant patches showing up in either tree after the 
rebase.

You should mention below the "---" your intentions like "This patch is 
supposed to go via the XXX tree, but it currently also depends on 
patches in the YYY tree. For now, this patch is based on linux-next, but 
will apply cleanly (or get rebased) after XXX was rebased."

Also, probably best to indicate the patch as being RFC (instead of 
linux-next) until there is a stable "base".

-- 
Cheers,

David / dhildenb


