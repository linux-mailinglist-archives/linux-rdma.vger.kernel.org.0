Return-Path: <linux-rdma+bounces-3005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E82900C81
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4730285CBC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3A14D2B5;
	Fri,  7 Jun 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TC4CRYzI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD71DFEB;
	Fri,  7 Jun 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788921; cv=none; b=kD7KryjmiXNIQA+mOFe5Lld8xVb0oihvAhnUwO9ILYmQXuCAflVtL5SfUbXKK0YooxfEIpi7UWYWcqre1JuVeddmaHjbGSFnWYGL8d4Wg4u0avDMvRCjTQiIIZeW8Ttl9OJkAp+8EoK3P6Pel93jwx7Q8JphHUPk5xsXIJRhRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788921; c=relaxed/simple;
	bh=XBRMhpg59H9dprFIE2ptSpdPgmlUDOwV7CBDdyfGn88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbn3EypKCbfCxF3MQkuSAyd98fGLT3bhbL9n2X5CBiJm5dglcEZXdMBdlOeFe/zCh2Futn+V0jF43wGbDbARKVlRxqyYQLof+vENGsofYtwlzntLFqIxDjIbRIJX3MTQvZPZwf/VfuGj6bL5AVajOAS5Vj/V4V/+p9qWFJJtV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TC4CRYzI; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717788915; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mfyg2R+Zj3SxdgDsXuviVuTj+JhLQZPhM5T31bO8YYk=;
	b=TC4CRYzIpaZxE0ebjnCj3g3NgwrMgjfKKxWBeQrfLaA8ERoxyxMEi+oM6CIvSZgYp05IUFPWliMszcLifOQ4vG9E/APMgSYQrNt4bIRcrV5p2lvJvxNdcNOnIqu4l1UL3iu5A/oO5GXsMkVFYpsVKlf+YIlOt4NfAIMDrEVllYg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8.mmkB_1717788913;
Received: from 30.39.248.33(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W8.mmkB_1717788913)
          by smtp.aliyun-inc.com;
          Sat, 08 Jun 2024 03:35:14 +0800
Message-ID: <e6b66001-f3cb-4367-aeaf-600fbc5f77b2@linux.alibaba.com>
Date: Sat, 8 Jun 2024 03:35:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net/smc: Introduce IPPROTO_SMC
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com,
 Paolo Abeni <pabeni@redhat.com>, edumazet@google.com
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com>
 <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com>
 <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org>
 <ffe06909-6152-4349-9b60-5697a038ac19@linux.alibaba.com>
 <ed6bde75-2783-446e-b667-204ed55071b5@kernel.org>
 <61b94bf6-a383-afff-db62-261cac7360c7@kernel.org>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <61b94bf6-a383-afff-db62-261cac7360c7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/8/24 12:47 AM, Mat Martineau wrote:
> On Fri, 7 Jun 2024, Matthieu Baerts wrote:
>
>> Hi D.Wythe,
>>
>> On 07/06/2024 07:09, D. Wythe wrote:
>>>
>>> On 6/7/24 5:22 AM, Mat Martineau wrote:
>>>> On Wed, 5 Jun 2024, D. Wythe wrote:
>>>>
>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>
>>>>> This patch allows to create smc socket via AF_INET,
>>>>> similar to the following code,
>>>>>
>>>>> /* create v4 smc sock */
>>>>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>>>>
>>>>> /* create v6 smc sock */
>>>>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>>>>>
>>>>> There are several reasons why we believe it is appropriate here:
>>>>>
>>>>> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>>>>> address. There is no AF_SMC address at all.
>>>>>
>>>>> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>>>>> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>>>>> Otherwise, smc have to implement it again in AF_SMC path.
>>>>>
>>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>>> ---
>>>>> include/uapi/linux/in.h |   2 +
>>>>> net/smc/Makefile        |   2 +-
>>>>> net/smc/af_smc.c        |  16 ++++-
>>>>> net/smc/smc_inet.c      | 169 +++++++++++++++++++++++++++++++++++++++
>>>>> +++++++++
>>>>> net/smc/smc_inet.h      |  22 +++++++
>>>>> 5 files changed, 208 insertions(+), 3 deletions(-)
>>>>> create mode 100644 net/smc/smc_inet.c
>>>>> create mode 100644 net/smc/smc_inet.h
>>>>>
>>>>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>>>>> index e682ab6..0c6322b 100644
>>>>> --- a/include/uapi/linux/in.h
>>>>> +++ b/include/uapi/linux/in.h
>>>>> @@ -83,6 +83,8 @@ enum {
>>>>> #define IPPROTO_RAW        IPPROTO_RAW
>>>>>   IPPROTO_MPTCP = 262,        /* Multipath TCP connection */
>>>>> #define IPPROTO_MPTCP        IPPROTO_MPTCP
>>>>> +  IPPROTO_SMC = 263,        /* Shared Memory 
>>>>> Communications        */
>>>>> +#define IPPROTO_SMC        IPPROTO_SMC
>>>>
>>>> Hello,
>>>>
>>>> It's not required to assign IPPROTO_MPTCP+1 as your new IPPROTO_SMC
>>>> value. Making IPPROTO_MAX larger does increase the size of the
>>>> inet_diag_table. Values from 256 to 261 are usable for IPPROTO_SMC
>>>> without increasing IPPROTO_MAX.
>>>>
>>>> Just for background: When we added IPPROTO_MPTCP, we chose 262 because
>>>> it is IPPROTO_TCP+0x100. The IANA reserved protocol numbers are 8 bits
>>>> wide so we knew we would not conflict with any future additions, and
>>>> in the case of MPTCP is was convenient that truncating the proto value
>>>> to 8 bits would match IPPROTO_TCP.
>>>>
>>>> - Mat
>>>>
>>>
>>> Hi Mat,
>>>
>>> Thank you very much for your feedback, I have always been curious about
>>> the origins of IPPROTO_MPTCP and I am glad to
>>> have learned new knowledge.
>>>
>
> Hi D. Whythe -
>
> Sure, you're welcome!
>
>>> Regarding the size issue of inet_diag_tables, what you said does make
>>> sense. However, we still hope to continue using 263,
>>> although the rationale may not be fully sufficient, as this series has
>>> been under community evaluation for quite some time now,
>>> and we haven't received any feedback about this value, so we’ve been
>>> using it in some user-space tools ... 🙁
>>>
>
> It's definitely a tradeoff between the Linux UAPI that gets locked in 
> forever vs. handling a transition with your userspace tools. If you 
> change the numeric value of IPPROTO_SMC on the open source side you 
> could transition internally by carrying a kernel patch that allows 
> both the new and old value.
>
>>> I would like to see what the community thinks. If everyone agrees that
>>> using 263 will be completely unacceptable and a disaster,
>>> then we will have no choice but to change it.
>>
>> It will not be a disaster, but a small waste of space (even if
>> CONFIG_SMC is not set).
>
> Well stated Matthieu :)  I chose my "not required" wording carefully, 
> as I didn't want to demand a change here but to make you aware of some 
> of the tradeoffs to consider. And thankfully Matthieu remembered the 
> userspace issues below.
>
> Also, I see that one of the netdev maintainers flagged this v6 series 
> as "changes requested" in patchwork so that may indicate their 
> preference?
>
>>
>> Also, please note that the introduction of IPPROTO_MPTCP caused some
>> troubles in some userspace programs. That was mainly because IPPROTO_MAX
>> got updated, and they didn't expect that, e.g. a quick search on GitHub
>> gave me this:
>>
>>  https://github.com/systemd/systemd/issues/15604
>>  https://github.com/strace/strace/issues/164
>>  https://github.com/rust-lang/libc/issues/1896
>>
>> I guess these userspace programs should now be ready for a new update,
>> but still, it might be better to avoid that if there is a "simple" 
>> solution.
>>
>> I understand changing your userspace tools will be annoying. (On the
>> other hand, it is still time to do that :) )
>
> Agreed!
>
>
> - Mat


Hi Mat and Matthieu,

Thanks very much for your feedback!  The reasons you all have provided 
are already quite convincing.
In fact, as I mentioned earlier, I actually don't have sufficient 
grounds to insist on 263.  It seems it's time for a change. 😉

Regarding the new value of IPPROTO_SMC, do you have any recommendations?
Which one might be better, 256 or 261?

Best wishes,
D. Wythe



