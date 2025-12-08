Return-Path: <linux-rdma+bounces-14920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF898CADB25
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F00030C734A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514E22154B;
	Mon,  8 Dec 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="vuF3OGFN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4181E9B22;
	Mon,  8 Dec 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209746; cv=none; b=XQc5+j4UvCfc8QjM0XkH9rv1gaIzghNpehNNyUNFKWKvrm7ZwWe14PosRo2wPCRmwTnx5upgN6rqqSRSn36dUxFajS8cR1yJEBTxyVihvkWu42P2TlJmNiAA0oYv9423l/ZRpZnsniv5vhlm8Gyjg8ShIUnq2zmKSl0vo0DiVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209746; c=relaxed/simple;
	bh=aVa+bmaa9nhXh/I/K7yejvzTcuvGR7J8XJngAdHGctI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeiARYYLmge+P1Pe0ox40hYg1hASVyhPtG0Tr+pWFlGDcs3BWnefmc0ezqXtOD5FgaPuFFMjHPiNgvHxWGgGP+Ttfb/BxfNGVHH+PIvyWXukKyy4EjHnEPfO5nCmq+DMiaAo1319cfMVDORVZv+SGzL3ipa73HIRJmPm4buz+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=vuF3OGFN; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=RTLLwF5/HOsCARqq4buxnhV5beSUHqq6TpcwR1Ym2Nk=; b=vuF3OGFNSg6oI6BpLvJ9GxNvh3
	wDziwGoHbZaEh/qpujpgENAkd3cogx841UmtLeULGQv7liqEL/NGrEFlFYKH6SzT81rk4SyUgxN8z
	DXUWtLq73gcbeD9wDiF397wnGrW17ZKYiTGEGj4ZEoxUnWlX6wSaNUNtvzIot8bwhcSDJNlX4tLE1
	hR55LsqCkdnrZkmhYCZBjt6ql+wnwnGb0jRdTBuwoh5HpopfMk5TX5/3uZchuhS8NJNLRaZUeYlO+
	XJ6xALeXajuegDyotmh9p+XRk+FrDJYeJJGWn3teVH0VQgKC4aJH08rfahjoNGGlNU7eZmQNw8B5d
	vWcWOXHe5HNvqksP1ntx7xZjgq6zCyh9L0qZ09CY1/t4nNTYmXWPTTk574yIWPb6Pam6neZT/9dtg
	25SwZ8T22xvt3LpAx1PxfPNBophcXUmqx1wz8uyTXYM89zq3SiEh2S639ripaFIoJ4J40+88TxR/G
	JX3VqJSbLht4kuGYKlMdPU+i;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vSdgr-00HPtt-27;
	Mon, 08 Dec 2025 16:02:21 +0000
Message-ID: <bdaf8e9b-fe6e-4ed7-bb3a-43848d01b08f@samba.org>
Date: Mon, 8 Dec 2025 17:02:21 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Tom Talpey <tom@talpey.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
 <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com>
 <f59e0dc7-e91c-4a13-8d49-fe183c10b6f4@samba.org>
 <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.12.25 um 03:33 schrieb Namjae Jeon:
> On Thu, Dec 4, 2025 at 6:40 PM Stefan Metzmacher <metze@samba.org> wrote:
>>
>> Hi Namjae,
> Hi Metze,
>>
>>> Okay, It seems like the issue has been improved in your v3 branch. If
>>> you send the official patches, I will test it more.
>>
>> It's good to have verified that for-6.18/ksmbd-smbdirect-regression-v3
>> on a 6.18 kernel behaves the same as with 6.17.9, as transport_rdma.c
>> is the same, but it doesn't really allow forward process on
>> the Mellanox problem.
>>
>> Can you at least post the dmesg output generated by this:
>> https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=7e724ebc58e986f4e101a55f4ab5e96912239918
>> Assuming that this wasn't triggered:
>> if (WARN_ONCE(needed > max_possible, "needed:%u > max:%u\n", needed, max_possible))
> I didn't know you wanted it. I will share it after office.
>>
>> Did you run the bpftrace command? Did it print a lot of
>> 'smb_direct_rdma_xmit' message over the whole time of the file copy?
> No, I didn't check it. but I will try this.
>>
>> Did you actually copied a file to or from the server?
> nod.

I asked what you were trying, not if it worked.

>>
>> Have you actually tested for-6.18/ksmbd-smbdirect-regression-v2,
>> as requested? As I was in hope that it would work in the
>> same way as for-6.18/ksmbd-smbdirect-regression-v3,
>> but with only a single patch reverted.
> I tested the v2 patch and the same issues still occurred, but they are
> gone in v3.
>>
>> I'll continue to fix the general problem that this works
>> for non Mellanox setups, as it seems it never worked at all :-(
> Smbdirect should work well on Mellanox NICs. As I said before, most
> people use this. I've rarely seen ksmbd users use smbdirect with
> non-Mellanox NICs. If you want to have a stable, long-term smbdirect
> feature on Samba, you'll need to have this device.

Yes, I'll try to buy two connectx cards, but it will take some
time until they will arrive.

And from what I found out last week while fixing ksmbd
to work with irdma in roce as well as rxe, to me was pure
luck that it worked with Mellanox.

>>
>> Where you testing with RoCEv2 or Infiniband?
> RoCEv2
>>
>> I think moving forward for Mellanox setups requires these steps:
>> - Test v1 vs. v2 and see that smb_direct_rdma_xmit is actually
>>     called at all. And see the dmesg output.
>> - Testing with Mellanox RoCEv2 on the client and rxe on
>>     the server, so that we can create a network capture with tcpdump.

Whould you be able to test with rxe on the ksmbd side?
Is it possible to disable both infiniband and roce on
the Mellanox nic? So that you can use rxe instead and
take a capture?

Thanks!
metze

