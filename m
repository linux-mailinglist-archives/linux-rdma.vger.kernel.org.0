Return-Path: <linux-rdma+bounces-2995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A079007A1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BE61C239C1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85919CCFE;
	Fri,  7 Jun 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4urwXNM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CED19752F;
	Fri,  7 Jun 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771678; cv=none; b=GmwNkPpsX4/VMrz7BcsZo+7b8vtYjSMZl1QVOOYHHNVW5dWONxCBQjXGk7BoyfxxIrxTTmcboyyfjh0V9rM9R13TGFWWGjSIQvV8r6TDS9poXoF9HQzSmyvnJFRgl5R6A/inwkPTq028L65NWWJgDTt7lm50lZi50H6CKFJHrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771678; c=relaxed/simple;
	bh=7vYK5PXeaX09G4mchrzH/gso9N7/dOR5z3qLs00qgUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqbXHITFyHYcyJneupG7+bp5GxNkE5gxL32NrkMNFoBpKPpzmgmhfkBKQAwqgURWhrPPuK4HeZfVy3JxvexqKzfCR5ClaZRyU9yrAfNXiNhgwk/f8TaAHo1SEIlsSm8T/bUwYHrjTPQsACwaSKjFMxxKLb9/G0exzQGe6uonJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4urwXNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208B5C2BBFC;
	Fri,  7 Jun 2024 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771677;
	bh=7vYK5PXeaX09G4mchrzH/gso9N7/dOR5z3qLs00qgUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F4urwXNMddtD+rg1r/zis8fX6/uzoMrUGi0Vs/42BWsKE4tWb3Rjat7dnlVs+ThM/
	 UAmVCOw/xzwcZK5XuSU0lVVxYEaOasceaC090gEomV2z/NYlknoMy/LBchzfOHaRZq
	 RzdRkjCdjaMbuLua0qCLqDlG1Y4oFQqyeQSiEOp2vz6y8tA1izR6M3T2LgHeSlN9YH
	 UpMJhcTyJaVn0odoWYuOUr44WYMhhz0nGeba80ipAkEC5lhTToXtQle0nkWxlniCd8
	 bLFGGBeR4bT+XTb+B2l6Xd+tu+LfKJv1sQQxDOxZnDPFQ3vRsCBICSeq1CYn/8yP53
	 1V2JErMW/ITDQ==
Message-ID: <ed6bde75-2783-446e-b667-204ed55071b5@kernel.org>
Date: Fri, 7 Jun 2024 16:47:52 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v6 3/3] net/smc: Introduce IPPROTO_SMC
Content-Language: en-GB
To: "D. Wythe" <alibuda@linux.alibaba.com>,
 Mat Martineau <martineau@kernel.org>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com>
 <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com>
 <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org>
 <ffe06909-6152-4349-9b60-5697a038ac19@linux.alibaba.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ffe06909-6152-4349-9b60-5697a038ac19@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi D.Wythe,

On 07/06/2024 07:09, D. Wythe wrote:
> 
> On 6/7/24 5:22 AM, Mat Martineau wrote:
>> On Wed, 5 Jun 2024, D. Wythe wrote:
>>
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This patch allows to create smc socket via AF_INET,
>>> similar to the following code,
>>>
>>> /* create v4 smc sock */
>>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>>
>>> /* create v6 smc sock */
>>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>>>
>>> There are several reasons why we believe it is appropriate here:
>>>
>>> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>>> address. There is no AF_SMC address at all.
>>>
>>> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>>> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>>> Otherwise, smc have to implement it again in AF_SMC path.
>>>
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ---
>>> include/uapi/linux/in.h |   2 +
>>> net/smc/Makefile        |   2 +-
>>> net/smc/af_smc.c        |  16 ++++-
>>> net/smc/smc_inet.c      | 169 +++++++++++++++++++++++++++++++++++++++
>>> +++++++++
>>> net/smc/smc_inet.h      |  22 +++++++
>>> 5 files changed, 208 insertions(+), 3 deletions(-)
>>> create mode 100644 net/smc/smc_inet.c
>>> create mode 100644 net/smc/smc_inet.h
>>>
>>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>>> index e682ab6..0c6322b 100644
>>> --- a/include/uapi/linux/in.h
>>> +++ b/include/uapi/linux/in.h
>>> @@ -83,6 +83,8 @@ enum {
>>> #define IPPROTO_RAW        IPPROTO_RAW
>>>   IPPROTO_MPTCP = 262,        /* Multipath TCP connection */
>>> #define IPPROTO_MPTCP        IPPROTO_MPTCP
>>> +  IPPROTO_SMC = 263,        /* Shared Memory Communications        */
>>> +#define IPPROTO_SMC        IPPROTO_SMC
>>
>> Hello,
>>
>> It's not required to assign IPPROTO_MPTCP+1 as your new IPPROTO_SMC
>> value. Making IPPROTO_MAX larger does increase the size of the
>> inet_diag_table. Values from 256 to 261 are usable for IPPROTO_SMC
>> without increasing IPPROTO_MAX.
>>
>> Just for background: When we added IPPROTO_MPTCP, we chose 262 because
>> it is IPPROTO_TCP+0x100. The IANA reserved protocol numbers are 8 bits
>> wide so we knew we would not conflict with any future additions, and
>> in the case of MPTCP is was convenient that truncating the proto value
>> to 8 bits would match IPPROTO_TCP.
>>
>> - Mat
>>
> 
> Hi Mat,
> 
> Thank you very much for your feedback, I have always been curious about
> the origins of IPPROTO_MPTCP and I am glad to
> have learned new knowledge.
> 
> Regarding the size issue of inet_diag_tables, what you said does make
> sense. However, we still hope to continue using 263,
> although the rationale may not be fully sufficient, as this series has
> been under community evaluation for quite some time now,
> and we haven't received any feedback about this value, so we’ve been
> using it in some user-space tools ... 🙁
> 
> I would like to see what the community thinks. If everyone agrees that
> using 263 will be completely unacceptable and a disaster,
> then we will have no choice but to change it.

It will not be a disaster, but a small waste of space (even if
CONFIG_SMC is not set).

Also, please note that the introduction of IPPROTO_MPTCP caused some
troubles in some userspace programs. That was mainly because IPPROTO_MAX
got updated, and they didn't expect that, e.g. a quick search on GitHub
gave me this:

  https://github.com/systemd/systemd/issues/15604
  https://github.com/strace/strace/issues/164
  https://github.com/rust-lang/libc/issues/1896

I guess these userspace programs should now be ready for a new update,
but still, it might be better to avoid that if there is a "simple" solution.

I understand changing your userspace tools will be annoying. (On the
other hand, it is still time to do that :) )

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


