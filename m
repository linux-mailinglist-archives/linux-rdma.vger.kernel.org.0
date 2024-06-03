Return-Path: <linux-rdma+bounces-2763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E68D7A36
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 04:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA9281278
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD320B652;
	Mon,  3 Jun 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ho6tQtJ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF18820;
	Mon,  3 Jun 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383488; cv=none; b=I1xhMBPXFtbVybc3qx57mqtelP4Mvsr/ERExNRtSj1qVrt+aFW0e16LDdUaDqwLzihA3NH1C46Oqiahu/VZYnvpBiDpRgmbxglwknBGD6AJ7nKopapfDD7wPjVxuLEeYZ1Vp+DDpoXG+EeaqGfKvHcdZrlk0AOf0/vYCl15XXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383488; c=relaxed/simple;
	bh=DDq/oSflRKDBuLH+qO61VRVXVNjjugJSrVdmXxTA5b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpAQQ85YQDi3XSEKK6V4L8M/3m2/t/YUI1ZRjtrUUgP4U/V9B1t2TicN4By2z9VB2ebi25M7XzlMcSwsScejNCHXF3VGBC6B3zv2d9i1rZltuJ4BTFN3geJYJpkQeY654gU2HERdgVAgoOu235L6pOUcAQ2doPXsqN9JEoPpRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ho6tQtJ1; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717383477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CRh32xSDlE8/RGsVcyIoG3Afke+E064YagIn0hWoZSo=;
	b=ho6tQtJ1Hek9bk6yS7YDxqWVAnmL+3RJNZk5sFnL6FF0cikuxwZyeemrIlWcP+V+lVYbeN+JKwDTbDW4O+GK38UrXa9tKrlY1bfz32Waz0cHffflBJAQT2mB346ztcqkroWdAzvxI3xOJPbPJMLPS23dwXMHT+BljEZJeyCEqeU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7gETOk_1717383475;
Received: from 30.221.145.154(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7gETOk_1717383475)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 10:57:56 +0800
Message-ID: <83a6596b-d9c4-4f2f-9eae-fd35cae561dc@linux.alibaba.com>
Date: Mon, 3 Jun 2024 10:57:55 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net/smc: Introduce IPPROTO_SMC
To: Simon Horman <horms@kernel.org>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
 <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>
 <20240601130628.GK491852@kernel.org>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240601130628.GK491852@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/1/24 9:06 PM, Simon Horman wrote:
> On Wed, May 29, 2024 at 11:59:07AM +0800, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch allows to create smc socket via AF_INET,
>> similar to the following code,
>>
>> /* create v4 smc sock */
>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>
>> /* create v6 smc sock */
>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>>
>> There are several reasons why we believe it is appropriate here:
>>
>> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>> address. There is no AF_SMC address at all.
>>
>> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>> Otherwise, smc have to implement it again in AF_SMC path.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ...
>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> ...
>
>> @@ -3594,9 +3595,31 @@ static int __init smc_init(void)
>>   		goto out_lo;
>>   	}
>>   
>> +	rc = proto_register(&smc_inet_prot, 1);
>> +	if (rc) {
>> +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
> Hi,
>
> FWIIW, my feeling is that if a log message includes __func__ then it should
> be a debug level message, and even then I'm dubious about the value of
> __func__: we do have many tools including dynamic tracing or pinpointing
> problems.
>
> So I would suggest rephrasing this message and dropping __func__.
> Or maybe removing it entirely.
> Or if not, lowering the priority of this message to debug.
>
> If for some reason __func__ remains, please do consider wrapping
> the line to 80c columns or less, which can be trivially done here
> (please don't split the format string in any case).
>
> Flagged by checkpatch.pl --max-line-length=80


Hi Simon,

Thank you very much for your feedback.

Allow me to briefly explain the reasons for using pr_err and __func__ here.

Regarding pr_err, the failure here leads to the failure of the module 
loading, which is definitely an error-level message rather than a 
debug-level one.

As for __func__, I must admit that the purpose here is simply to align 
with the format of other error messages in smc_init(). In fact, I also 
feel that the presence of
__func__ doesn't hold significant value because this error will only 
occur within this function. It's meaningless information for both users 
and kernel developers.
Perhaps a more suitable format would be “smc: xxx: %d”.

However, if changes are needed, I think they should be made across the 
board in order to maintain a consistent style. Maybe this can be 
addressed by
submitting a new patch after this patch. @Wenjia, what do you think?

Therefore, for now, I would like to wrap this line to not exceed 80 
characters, to ensure it can pass the checkpatch.pl.
What do you think?

Best wishes,
D. Wythe

>
>> +		goto out_ulp;
>> +	}
>> +	inet_register_protosw(&smc_inet_protosw);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	rc = proto_register(&smc_inet6_prot, 1);
>> +	if (rc) {
>> +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
> Here too.
>
>> +		goto out_inet_prot;
>> +	}
>> +	inet6_register_protosw(&smc_inet6_protosw);
>> +#endif
> ...


