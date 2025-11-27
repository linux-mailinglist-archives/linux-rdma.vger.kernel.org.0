Return-Path: <linux-rdma+bounces-14811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B8DC8FC2F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1DB4E2758
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C8B2F746F;
	Thu, 27 Nov 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="k9vbGoB0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBE2F691F;
	Thu, 27 Nov 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265673; cv=none; b=bhT6wwAZGTOK8JFTOM5kRVsA7eCgmhFk3S8f80AYfmGfrEUC8eQQa2Sj+wGynFbBpfgmIIbiKTmbFBTYSMD2fzmHb6G3l42ZHqTiu4dGORxx0MvexoLLEY0gDzJ7f+GPoz9u7XeIesaybQT/6lJzx0itkudsqU2IExIy30a0ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265673; c=relaxed/simple;
	bh=6SRI1/kljnwIBuRhbjlGOtjbA6nlJv61vSHbPIAR7Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crD2bpYSQWxOtL9mPZq6SZ0JwgYufPmYFtVq77kj3MahEbnmHX20qTAZ1sT0N7SGkWAS9aVyCOJgMzSN8IN1ZIVgt4WDgmZgQGz8Y2u4Gc4carWOMP7Vb3DaGgME3KV00mDCApfyTUhUC8uyiQNedlKqnIdcDD6ivhuGcKhRnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=k9vbGoB0; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=461Vy01Zb0nwzw3ifoGzpi9dK4EZy7C3bNQOK9nUwXw=; b=k9vbGoB0kfzIMMqR8vXteUGamz
	ooV5kYNXah6tFldH1rDE4Wshj5wUDlA7CLUxvd/HbcfRNo5IyFdjG8+AKEcvTPb1p6ObMXYuakp1b
	Irusrg5dlETX8KQ7MmuTaa6LwU/rwou1Q3+Xrbgj9xEnllAtDQbPqJCIjn8vsAMRG+y8175ofdQdd
	ziAGF2nQ0sqw3LluD7cn2D5PNpGENV0XNfGCbJD3ehsImK1CWZs+CTGT6zv0zzlOzB69xq4pLX1Rf
	TTZj4fgoPlaDOJ3K/4OmGZYqwAKG284x+tT9qvUlcldYl82tE8AKIAX2tN3OBjb/fhkbSp/LbjmKm
	pCyNzanGt3wWFXvyTBrmP9YyuNAT8xSWrLBhXaGpaAP20ud3nfnsaRNcl/Ix3D9IpLfHf7wLaL8qS
	BVjf9vSb1PbgYRgMHzokaEthQL6FpMQ1rev19toZDhiPJsiE/xwX/TdL/BhemSQXw8eS+Mqc28BPy
	28mbKXm/2zIscztuxegPStsp;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vOg5r-00G22i-01;
	Thu, 27 Nov 2025 17:47:47 +0000
Message-ID: <53eb849d-d5c1-4b8c-8d83-bacd18d129b1@samba.org>
Date: Thu, 27 Nov 2025 18:47:46 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: define IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Steve French <smfrench@gmail.com>,
 Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-rdma@vger.kernel.org,
 quic@lists.linux.dev
References: <20251126111407.1786854-1-metze@samba.org>
 <3dd5c950-e3e4-42b8-a40b-f0ee04feb563@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <3dd5c950-e3e4-42b8-a40b-f0ee04feb563@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paolo,

> On 11/26/25 12:14 PM, Stefan Metzmacher wrote:
>> In order to avoid conflicts with the addition of IPPROTO_QUIC,
>> the patch is based on netdev-next/main + the patch adding
>> IPPROTO_QUIC and SOL_QUIC [2].
>>
>> [2]
>> https://lore.kernel.org/quic/0cb58f6fcf35ac988660e42704dae9960744a0a7.1763994509.git.lucien.xin@gmail.com/T/#u
>>
>> As the numbers of IPPROTO_QUIC and SOL_QUIC are already used
>> in various userspace applications it would be good to have
>> this merged to netdev-next/main even if the actual
>> implementation is still waiting for review.
> 
> Let me start from here... Why exactly? such applications will not work
> (or at least will not use IPPROTO_QUIC) without the actual protocol
> implementation.

There's the out of tree quic driver, that is used by some people
see https://github.com/lxin/quic.

And Samba 4.23 already uses the specific *_QUIC values,
so it would be good to make sure the values are not used for
something else, by accident.

> Build time issues are much more easily solved with the usual:
> 
> #ifndef IPPROTO_*
> #define IPPROTO_
> #endif

Sure, but that still only works reliable if the constants
don't change.

> that the application code should still carry for a bit of time (until
> all the build hosts kernel headers are updated).

The build hosts often don't have current kernel headers
anyway, that's why applications have the hard coded (at least fallback values).

But a host might have a newer kernel (or out of tree module)
at runtime, which would allow the application to use the feature.

> The above considerations also apply to this patch. What is the net
> benefit? Why something like the above preprocessor's macros are not enough?

It's mainly to have the constants reserved in order to avoid collisions
at runtime.

And in the current case also the merge conflict between the two patchsets,
that's another why I thought it would be good to the _QUIC patch already
accepted.

> We need at least to see the paired implementation to accept this patch,

I hope to post the first part of the _SMBDIRECT socket code next
week, it's already working for the in kernel users cifs.ko and ksmbd.ko,
but I want to split the relatively large commit into smaller chunks,
for better review, the current state consists of the top 3 commits of
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/master-ipproto-smbdirect-v0.5
1. the addition of the socket layer above the existing code, for in kernel use only
2. change cifs.ko to use it
3. change ksmbd.ko to use it.

Opening it for userspace will be developed in the next weeks.

 > and I personally think it would be better to let the IPPROTO definition
 > and the actual implementation land together.

In general I'd agree with you, I'm fine with deferring this patch
a bit and will cope if the _QUIC patch is also deferred.

Anyway thanks for the feedback!
metze

