Return-Path: <linux-rdma+bounces-21820-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RSESI6BKImoKUwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21820-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 06:03:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E47AF644FC5
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 06:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=rvPgAkqq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21820-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21820-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 309C83004627
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 04:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A61B6D08;
	Fri,  5 Jun 2026 04:03:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465E33F597;
	Fri,  5 Jun 2026 04:03:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632213; cv=none; b=i2aedkCDP5Qz+TGfeynA+LEfTzfkG0vYg8WnxXm6NiBCbL+qgOZH7ALO4Za6jiPYW3zDh3tD7ZBcP2qvCzdEprVZROD22g9eebBMHCC8/Qlejo/MpTI3/MXGCOI9IjvJ+uldeUCAVb1W64L5mX3nEwLj/1xXn7EPcO0qiiX0W6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632213; c=relaxed/simple;
	bh=OANjMFi4kP/bRhSbJ+1yiLW+pPy6GZpY3M5e8T+s8ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMgJ4B2V0ZCG0JtNSbqLWJP3ALCNdKyoTYlWi2F/SFWBfSljnkb02NpkyPmnKVyJXMMy/brvafB7Tz7A+1VTHxx0eKAWekIzQlxf+aPCY8zHY3CAPeEw9eSLTY2IvXujKwKhMDFxvU3gswLqMLH7WSWAjD3vBJK/e0Jj+QA4qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rvPgAkqq; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=prTptCr2IPlJWSLe3kQzyJTLbKMBWIJZlJtJ2pBygAI=; b=rvPgAkqqXZpJ7CtnBaKLfMc23l
	Ax7rKOBbEd6/Tx/rtxJxy1RZVV5rDkKEoFnUacNECKYaHgETtczkbsvneXoBCuooInCnS+5xiwjUm
	QGMYA3ra/3+PjBsx//sG9Fm8oa4ixhfb0iKekqZ2hE2UlKtsGyBPbGDV+vL1bGe3ZjxAvN6uqKfYg
	3JcZTf9HeeMcr+NE5yXxoBG6SFCBE241ipiKOXCokqb5KwmidsvZUKAQZ07u9Rg2GhMuaV3AtaJaE
	IDrwVdz9M8VERsb/tl3/ZpQD7vJsc68iRh2zBU35cnU92aBGiR7awHXKZy9QtawYzxsF7i5yKJshJ
	AoRhlLSQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLlj-000000003t6-2WQS;
	Fri, 05 Jun 2026 04:02:51 +0000
Message-ID: <fa19f1d2-832b-4b9c-824d-29ae48e4bc2a@infradead.org>
Date: Thu, 4 Jun 2026 21:02:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 7/7] devlink: Add eswitch mode boot defaults
To: Mark Bloch <mbloch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260603193259.3412464-1-mbloch@nvidia.com>
 <20260603193259.3412464-8-mbloch@nvidia.com>
 <d276e842-dd8f-40b7-806b-71572503005e@infradead.org>
 <e4aada53-fb80-41a8-9a8e-d19414f6466b@nvidia.com>
 <909ada9a-a398-4e3f-8ed0-596a1e4bdbfd@infradead.org>
 <91d12ffd-6bd9-4951-8351-655262d44874@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <91d12ffd-6bd9-4951-8351-655262d44874@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21820-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:mid,infradead.org:from_mime,infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E47AF644FC5



On 6/4/26 2:49 AM, Mark Bloch wrote:
> 
> 
> On 04/06/2026 6:53, Randy Dunlap wrote:
>>
>>
>> On 6/3/26 6:16 PM, Mark Bloch wrote:
>>>
>>>
>>> On 03/06/2026 23:06, Randy Dunlap wrote:
>>>> Hi.
>>>>
>>>> On 6/3/26 12:32 PM, Mark Bloch wrote:
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index 063c11ca33e5..7af9f2898d92 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -1264,6 +1264,31 @@ Kernel parameters
>>>>>  	dell_smm_hwmon.fan_max=
>>>>>  			[HW] Maximum configurable fan speed.
>>>>>  
>>>>> +	devlink_eswitch_mode=
>>>>> +			[NET]
>>>>> +			Format:
>>>>> +			[<selector>]:<mode>
>>>>
>>>> It appears (please correct me if I am mistaken) that the '[' and ']'
>>>> above don't mean "optional" but instead they are required characters...
>>>>
>>>>> +
>>>>> +			<selector>:
>>>>> +			* | <handle>[,<handle>...]
>>>>
>>>> while here they mean "optional".
>>>>
>>>> That is confusing (inconsistent). Also, if the square brackets are
>>>> always required around the <selector>, what purpose do they serve?
>>>
>>> Yes, you are right, this is confusing. The outer square brackets are part of
>>> the syntax and are required, while the brackets in "[,<handle>...]" mean that
>>> additional handles are optional.
>>>
>>> I couldn't find a better way to describe this. What I want to say is that the
>>> selector is always wrapped in square brackets. Inside the brackets it can either
>>> be "*" to match all devices, or a comma separated list of handles. If "*" is
>>> not used, then at least one handle has to be provided.
>>>
>>> Maybe it would be clearer to spell it out explicitly, something like:
>>>
>>> Format:
>>>   [<selector>]:<mode>
>>>
>>> The '[' and ']' characters are literal and required.
>>>
>>> <selector>:
>>>   * | <handle>[,<handle>...]
>>>
>>> If '*' is not used, <selector> must contain at least one <handle>.
>>>
>>> Does that sound like a reasonable way to document it?
>>
>> Yes, that helps a little bit. Better than nothing.
>>
>> But why are they required at all?
> 
> Jiri suggested using the square brackets, and I liked that they made the
> selector look like a grouped argument. But if that is too confusing, I can
> also drop them and use a simpler separator, for example:
> 
> 	devlink_eswitch_mode=
> 			[NET]
> 			Format:
> 			<selector>=<mode>
> 
> 			<selector>:
> 			* | <handle>[,<handle>...]
> 
> 			<handle>:
> 			<bus-name>/<dev-name>
> 
> 			Configure default devlink eswitch mode for matching
> 			devlink instances during device initialization.
> 
> 			<mode>:
> 			legacy | switchdev | switchdev_inactive
> 
> 			Examples:
> 			devlink_eswitch_mode=*=switchdev
> 			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
> 			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
> 
> Does this look better to you?

Yes, that looks much better to me.
But you should do whatever you think is right.

>>>>> +
>>>>> +			<handle>:
>>>>> +			<bus-name>/<dev-name>
>>>>> +
>>>>> +			Configure default devlink eswitch mode for matching
>>>>> +			devlink instances during device initialization.
>>>>> +
>>>>> +			<mode>:
>>>>> +			legacy | switchdev | switchdev_inactive
>>>>> +
>>>>> +			Examples:
>>>>> +			devlink_eswitch_mode=[*]:switchdev
>>>>> +			devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
>>>>> +			devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
>>>>> +
>>>>> +			See Documentation/networking/devlink/devlink-defaults.rst
>>>>> +			for the full syntax.
>>>>> +
>>>>>  	dfltcc=		[HW,S390]
>>>>>  			Format: { on | off | def_only | inf_only | always }
>>>>>  			on:       s390 zlib hardware support for compression on
>>>>
>>>>
>>>
>>
> 

-- 
~Randy


