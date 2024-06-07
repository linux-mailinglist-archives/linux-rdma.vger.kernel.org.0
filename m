Return-Path: <linux-rdma+bounces-3001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06085900AB6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C44B1F20D48
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50919AD62;
	Fri,  7 Jun 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbKQiXW9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940619AD48;
	Fri,  7 Jun 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778878; cv=none; b=Cel90/7Dv2sZ71EjuoZm5lmhvIqeaDj/VqxelyNfhsVjOSLLR3rCd4Hu/U1q4n4Qf1fojnYzarnjb1aFBotxTyU+UZhdmxCbiWEtBWVaFNToyzHTvlbIx7PpRZxchOxL97ywFaJJoL9kfwI0aQB+5XEdtlBsJYy3dTSA4aBCWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778878; c=relaxed/simple;
	bh=9iL6D9ZDF9G5asbiclELPhk+Wwh+GRu/qUW2URC9UD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V4BPZRdrk3ShI3zuXsDwhA5dsnSJkcJocA48bqC/CYAop65JPKmMA9SRQHjkf4OYL7LuOV4X9N6DtD40Olg8jJGs8CDjcecdrO6mhVWUwmHyHYs9gReK+5QKKa5CsL3Gkg/CPQYBR++N3ysyrCOHGmB+ynklXD9fRevfqR7gSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbKQiXW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16720C2BBFC;
	Fri,  7 Jun 2024 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717778878;
	bh=9iL6D9ZDF9G5asbiclELPhk+Wwh+GRu/qUW2URC9UD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RbKQiXW9XQ5K/q87b4z56mzshQBPQB6l2r1z7ZROZKiNd26DQr56H+EHBFQCi93ZD
	 7u6X1+AfLaLTb9iJXPYgMcHJiMhko6Gw6KdhlRbA5ngMzEZL4GfbG2WUZozl7NKGYL
	 +D3jXQ2JSVSdT34v7A0FRdjz6gekiNFJWO6PH/HVlpkRGmDbssTZGU/HVdnAnVKi87
	 na9EQ6tR1BFpcE4E/Fk6ufiz/0vyo5UkM1IuzNS6jYwjV00fMccn0e7DhBe6pfyFSL
	 t+/hgBP6gM0rqzlTokRfLYnS1xz2qbXplpVtEKwNq1FMLrzDltONzYA+6uqVwnOj4r
	 FVe8ml1lUFMbg==
Date: Fri, 7 Jun 2024 09:47:57 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>, 
    Matthieu Baerts <matttbe@kernel.org>
cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
    wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
    davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
    linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, 
    Paolo Abeni <pabeni@redhat.com>, edumazet@google.com
Subject: Re: [PATCH net-next v6 3/3] net/smc: Introduce IPPROTO_SMC
In-Reply-To: <ed6bde75-2783-446e-b667-204ed55071b5@kernel.org>
Message-ID: <61b94bf6-a383-afff-db62-261cac7360c7@kernel.org>
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com> <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com> <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org> <ffe06909-6152-4349-9b60-5697a038ac19@linux.alibaba.com>
 <ed6bde75-2783-446e-b667-204ed55071b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1537107791-1717778253=:88167"
Content-ID: <2de7d536-e29e-8f93-ee53-6909024c177b@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1537107791-1717778253=:88167
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <5b21e5f9-e28d-1cfd-f572-72f95d66b58b@kernel.org>

On Fri, 7 Jun 2024, Matthieu Baerts wrote:

> Hi D.Wythe,
>
> On 07/06/2024 07:09, D. Wythe wrote:
>>
>> On 6/7/24 5:22 AM, Mat Martineau wrote:
>>> On Wed, 5 Jun 2024, D. Wythe wrote:
>>>
>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>
>>>> This patch allows to create smc socket via AF_INET,
>>>> similar to the following code,
>>>>
>>>> /* create v4 smc sock */
>>>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>>>
>>>> /* create v6 smc sock */
>>>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>>>>
>>>> There are several reasons why we believe it is appropriate here:
>>>>
>>>> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>>>> address. There is no AF_SMC address at all.
>>>>
>>>> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>>>> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>>>> Otherwise, smc have to implement it again in AF_SMC path.
>>>>
>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> ---
>>>> include/uapi/linux/in.h |   2 +
>>>> net/smc/Makefile        |   2 +-
>>>> net/smc/af_smc.c        |  16 ++++-
>>>> net/smc/smc_inet.c      | 169 +++++++++++++++++++++++++++++++++++++++
>>>> +++++++++
>>>> net/smc/smc_inet.h      |  22 +++++++
>>>> 5 files changed, 208 insertions(+), 3 deletions(-)
>>>> create mode 100644 net/smc/smc_inet.c
>>>> create mode 100644 net/smc/smc_inet.h
>>>>
>>>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>>>> index e682ab6..0c6322b 100644
>>>> --- a/include/uapi/linux/in.h
>>>> +++ b/include/uapi/linux/in.h
>>>> @@ -83,6 +83,8 @@ enum {
>>>> #define IPPROTO_RAW        IPPROTO_RAW
>>>>   IPPROTO_MPTCP = 262,        /* Multipath TCP connection */
>>>> #define IPPROTO_MPTCP        IPPROTO_MPTCP
>>>> +  IPPROTO_SMC = 263,        /* Shared Memory Communications        */
>>>> +#define IPPROTO_SMC        IPPROTO_SMC
>>>
>>> Hello,
>>>
>>> It's not required to assign IPPROTO_MPTCP+1 as your new IPPROTO_SMC
>>> value. Making IPPROTO_MAX larger does increase the size of the
>>> inet_diag_table. Values from 256 to 261 are usable for IPPROTO_SMC
>>> without increasing IPPROTO_MAX.
>>>
>>> Just for background: When we added IPPROTO_MPTCP, we chose 262 because
>>> it is IPPROTO_TCP+0x100. The IANA reserved protocol numbers are 8 bits
>>> wide so we knew we would not conflict with any future additions, and
>>> in the case of MPTCP is was convenient that truncating the proto value
>>> to 8 bits would match IPPROTO_TCP.
>>>
>>> - Mat
>>>
>>
>> Hi Mat,
>>
>> Thank you very much for your feedback, I have always been curious about
>> the origins of IPPROTO_MPTCP and I am glad to
>> have learned new knowledge.
>>

Hi D. Whythe -

Sure, you're welcome!

>> Regarding the size issue of inet_diag_tables, what you said does make
>> sense. However, we still hope to continue using 263,
>> although the rationale may not be fully sufficient, as this series has
>> been under community evaluation for quite some time now,
>> and we haven't received any feedback about this value, so we’ve been
>> using it in some user-space tools ... 🙁
>>

It's definitely a tradeoff between the Linux UAPI that gets locked in 
forever vs. handling a transition with your userspace tools. If you change 
the numeric value of IPPROTO_SMC on the open source side you could 
transition internally by carrying a kernel patch that allows both the new 
and old value.

>> I would like to see what the community thinks. If everyone agrees that
>> using 263 will be completely unacceptable and a disaster,
>> then we will have no choice but to change it.
>
> It will not be a disaster, but a small waste of space (even if
> CONFIG_SMC is not set).

Well stated Matthieu :)  I chose my "not required" wording carefully, as I 
didn't want to demand a change here but to make you aware of some of the 
tradeoffs to consider. And thankfully Matthieu remembered the userspace 
issues below.

Also, I see that one of the netdev maintainers flagged this v6 series as 
"changes requested" in patchwork so that may indicate their preference?

>
> Also, please note that the introduction of IPPROTO_MPTCP caused some
> troubles in some userspace programs. That was mainly because IPPROTO_MAX
> got updated, and they didn't expect that, e.g. a quick search on GitHub
> gave me this:
>
>  https://github.com/systemd/systemd/issues/15604
>  https://github.com/strace/strace/issues/164
>  https://github.com/rust-lang/libc/issues/1896
>
> I guess these userspace programs should now be ready for a new update,
> but still, it might be better to avoid that if there is a "simple" solution.
>
> I understand changing your userspace tools will be annoying. (On the
> other hand, it is still time to do that :) )

Agreed!


- Mat
--0-1537107791-1717778253=:88167--

