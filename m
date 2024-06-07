Return-Path: <linux-rdma+bounces-2974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542A8FFB34
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 07:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EB2B228DA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC3818EBF;
	Fri,  7 Jun 2024 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HV5jBe96"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2914AA0;
	Fri,  7 Jun 2024 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736962; cv=none; b=YqMmNrU/2n9yXB76QQJFRc4K4YkY28jRzGffzHDHvYTY3uZ8NTgBVO47yRXv87Z5d0jM9zaAcKKU01B+BdkMOWdYRhMT20Hv+bSUEuJvpNu95Lxa2sEKduMIANfjL/cXkmh+zfZpR1kXLZTZXqd+1v7p3f2iJw08SD/z1MaQdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736962; c=relaxed/simple;
	bh=W5ssOwnIcBKa73MaTM+MdwDrWKvCnLweiRGR/M+5iHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOBiihMaC+k3lGQo1KQIr5DqbOQSYXZ1vNiSipOLOfhShNM/SvXXD5w7fcUvZ1zlQszM/BTIO6dg9gfgf3KYbAvwopmFDDuQK+hxcPqEGPbnV3GJPIKi7gdsxsyx4KAXzvT2EtDjag0FQp1K0SrQNOSG7XN989he6jNIDuRuJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HV5jBe96; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717736951; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VsYBQlda4C0nV46no8jZqPTUYKvrnUXYnxgJ7r1am/U=;
	b=HV5jBe962jtbx/1QTO2JxFN9HS384VLBsa/Wng5UK/LDC7EruTwZkHYuDV5zz7Y4bF+BuR9N0FOVtzR9mxhnLndycV5tjmcR+X7Rszon4nZZ81taE47VOGyoxvtbuKNL4q568uIoXPV399ishBb6qnOWrpltO0g2ghf2vSe9Gl8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7zvg-t_1717736949;
Received: from 30.221.145.113(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7zvg-t_1717736949)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 13:09:10 +0800
Message-ID: <ffe06909-6152-4349-9b60-5697a038ac19@linux.alibaba.com>
Date: Fri, 7 Jun 2024 13:09:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net/smc: Introduce IPPROTO_SMC
To: Mat Martineau <martineau@kernel.org>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com>
 <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com>
 <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/7/24 5:22 AM, Mat Martineau wrote:
> On Wed, 5 Jun 2024, D. Wythe wrote:
>
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
>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>> include/uapi/linux/in.h |   2 +
>> net/smc/Makefile        |   2 +-
>> net/smc/af_smc.c        |  16 ++++-
>> net/smc/smc_inet.c      | 169 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>> net/smc/smc_inet.h      |  22 +++++++
>> 5 files changed, 208 insertions(+), 3 deletions(-)
>> create mode 100644 net/smc/smc_inet.c
>> create mode 100644 net/smc/smc_inet.h
>>
>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>> index e682ab6..0c6322b 100644
>> --- a/include/uapi/linux/in.h
>> +++ b/include/uapi/linux/in.h
>> @@ -83,6 +83,8 @@ enum {
>> #define IPPROTO_RAW        IPPROTO_RAW
>>   IPPROTO_MPTCP = 262,        /* Multipath TCP connection */
>> #define IPPROTO_MPTCP        IPPROTO_MPTCP
>> +  IPPROTO_SMC = 263,        /* Shared Memory Communications        */
>> +#define IPPROTO_SMC        IPPROTO_SMC
>
> Hello,
>
> It's not required to assign IPPROTO_MPTCP+1 as your new IPPROTO_SMC 
> value. Making IPPROTO_MAX larger does increase the size of the 
> inet_diag_table. Values from 256 to 261 are usable for IPPROTO_SMC 
> without increasing IPPROTO_MAX.
>
> Just for background: When we added IPPROTO_MPTCP, we chose 262 because 
> it is IPPROTO_TCP+0x100. The IANA reserved protocol numbers are 8 bits 
> wide so we knew we would not conflict with any future additions, and 
> in the case of MPTCP is was convenient that truncating the proto value 
> to 8 bits would match IPPROTO_TCP.
>
> - Mat
>

Hi Mat,

Thank you very much for your feedback, I have always been curious about 
the origins of IPPROTO_MPTCP and I am glad to
have learned new knowledge.

Regarding the size issue of inet_diag_tables, what you said does make 
sense. However, we still hope to continue using 263,
although the rationale may not be fully sufficient, as this series has 
been under community evaluation for quite some time now,
and we haven't received any feedback about this value, so we’ve been 
using it in some user-space tools ... 🙁

I would like to see what the community thinks. If everyone agrees that 
using 263 will be completely unacceptable and a disaster,
then we will have no choice but to change it.

Best wishes,
D. Wythe

>>   IPPROTO_MAX
>> };


