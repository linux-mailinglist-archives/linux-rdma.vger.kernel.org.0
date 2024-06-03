Return-Path: <linux-rdma+bounces-2764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E618D7A50
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 05:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AD1C20F97
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF1107A6;
	Mon,  3 Jun 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bHUEil9q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95711182;
	Mon,  3 Jun 2024 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383670; cv=none; b=gw/YF8awfywa7SxPWNIp1JyDB0aqJD6ofpayX34t5LUUk/wtlej3jgTUiLeDs2G/g0ouPqZ//7vHGBHYjGRk1LzWZQHbIazxCCCIVHYuCz1qQzI6z/eYMIowOuAmP4QdM4xlJ/KC8Vzho9AYiD82wweKBf2E/r3mGjq98op9jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383670; c=relaxed/simple;
	bh=kN4aH6dfyUML0tRGO5f6y6MUiI/aLR5XPgVdDkrgHKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCz/qpAUGohsnSaYRGM6LTZL60KvNmwgek7YSVzgnURar/NsXb5JS6Db9ptmHjxvhiGJS37o3GLI/lvJWly4Z7D3aHpEkLa5fRQcAVFGBS5XFhcF+cOHWb/dTvyigRfNss1qUz9/+jkDEWdyD6hIK5uDw2ztnxUt2DamYXQ72Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bHUEil9q; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717383665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qnkimNEeRKea+jhfzLFamRg4Ct6Hoc9CkbavUbVGjV8=;
	b=bHUEil9qREqSxCnfRMNMeYNu2JCR9qIK6cyrCs8N7g36dCLt7aoppVbWNDT3P9oSAOY/Mk3l9BegQsAZcYIu5G6DozdEB8qOFv9+GM1xluvXUP7DPpLJlgKsUv1Vht8j0f8hH2J9/043bgII8m8rLK5izDeGPwwn3VT+gOkuZBk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7gEUSa_1717383664;
Received: from 30.221.145.154(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7gEUSa_1717383664)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 11:01:04 +0800
Message-ID: <ee95457f-94d9-474c-9929-eda061cbf854@linux.alibaba.com>
Date: Mon, 3 Jun 2024 11:01:03 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/3] Introduce IPPROTO_SMC
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
 <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
 <882713c2-02bd-4396-83be-c527b9d24eef@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <882713c2-02bd-4396-83be-c527b9d24eef@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/31/24 4:06 PM, Wenjia Zhang wrote:
>
>
> On 30.05.24 12:14, D. Wythe wrote:
>>
>>
>> On 5/30/24 5:30 PM, D. Wythe wrote:
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
>>
>> Welcome everyone to try out the eBPF based version of smc_run during 
>> testing, I have added a separate command called smc_run.bpf,
>> it was equivalent to normal smc_run but with IPPROTO_SMC via eBPF.
>>
>> You can obtain the code and more info from: 
>> https://github.com/D-Wythe/smc-tools
>>
>> Usage:
>>
>> smc_run.bpf
>> An eBPF implemented smc_run based on IPPROTO_SMC:
>>
>> 1. Support to transparent replacement based on command (Just like 
>> smc_run).
>> 2. Supprot to transparent replacement based on pid configuration. And 
>> supports the inheritance of this capability between parent and child 
>> processes.
>> 3. Support to transparent replacement based on per netns configuration.
>>
>> smc_run.bpf COMMAND
>>
>> 1. Equivalent to smc_run but with IPPROTO_SMC via eBPF
>>
>> smc_run.bpf -p pid
>>
>>   1. Add the process with target pid to the map. Afterward, all 
>> socket() calls of the process and its descendant processes will be 
>> replaced from IPPROTO_TCP to IPPROTO_SMC.
>>   2. Mapping will be automatically deleted when process exits.
>>   3. Specifically, COMMAND mode is actually works like following:
>>
>>      smc_run.bpf -p $$
>>      COMMAND
>>      exit
>>
>> smc_run.bpf -n 1
>>
>>   1. Make all socket() calls of the current netns to be replaced from 
>> IPPROTO_TCP to IPPROTO_SMC.
>>   2. Turn off it by smc_run.bpf -n 0
>>
>>
> Hi D. Wythe,
>
> Thank you for the info and description! The code generally looks good 
> to me, just still some details I need to check again. And I'd like to 
> give smc_run.bpf a try, and maybe let you know if it works for me next 
> week.
>
> Thanks,
> Wenjia

Hi Wenjia,

That's okay to us. And if there are any issues regarding the use of 
smc_run.bpf, please let me know.

Best wishes,
D. Wythe






