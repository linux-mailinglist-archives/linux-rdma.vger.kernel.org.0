Return-Path: <linux-rdma+bounces-2784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5038D8553
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38241B22C82
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBB130485;
	Mon,  3 Jun 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EpJPetlG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4E84A35;
	Mon,  3 Jun 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425807; cv=none; b=VOozalnCdEXVS/saMjtfMiWqs7fqrmGqOyHvN+UPGw2Cp2QoVbWSNEcF/G+ROJggQFG9p7oOslEwD7BJWiiR9+NO0qlgrn6yyB1vO6NQEObceeUXjmSC/mXt/gNf5Wz4x+dexEYXQ/8FAVhZ386w0NscvjgWt+z352Ojwnk9kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425807; c=relaxed/simple;
	bh=vqPteU+ShY+tFFsnyCy91eplh17ffUIH0ni3JoDnahE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+Lm4k2t5tqwt/nZkQFP9H8wTtkpDNXg1FI7s6eowLLhd6YcRYTD0VHLJlSmmt52oxnXmhO+8HxCbi+ocTGPandsEzHSaDpqMPcYkIlXSTbz6ApzalDo6YGWnCTCIu+5OGFzoU+A5YVGCQhW4W7Bs8fh73dknAXemjTC52rUEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EpJPetlG; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717425796; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LuHj3RTY5pjD9DVnlCmbp9LxMkyrwdGJVdkMRo33rM0=;
	b=EpJPetlGhFzCoFI+cfMaYB1pP7uEHYUguw694ieGQVNiSRe3rj5dV9Kj5tO8C92VlPw7sK0dYptbk/kgAgbcxkE55KtANcOzp1Aklz9oqfLSzXg7CWYt/f7UfKH4u1FGlfjXZoha742GWPgkUkPYVlFZfylyRL8bfWjvniYzsqk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7o9Qya_1717425794;
Received: from 192.168.50.173(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7o9Qya_1717425794)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 22:43:15 +0800
Message-ID: <d77ffb6e-28e6-4666-ae73-33bb64a44318@linux.alibaba.com>
Date: Mon, 3 Jun 2024 22:43:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net/smc: Introduce IPPROTO_SMC
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
 <1717061440-59937-4-git-send-email-alibuda@linux.alibaba.com>
 <20240603034901.GA3254291@maili.marvell.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240603034901.GA3254291@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/24 11:49 AM, Ratheesh Kannoth wrote:
> On 2024-05-30 at 15:00:40, D. Wythe (alibuda@linux.alibaba.com) wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> +
>> +int __init smc_inet_init(void)
>> +{
>> +	int rc;
>> +
>> +	rc = proto_register(&smc_inet_prot, 1);
>> +	if (rc) {
>> +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
>> +		return rc;
>> +	}
>> +	/* no return value */
>> +	inet_register_protosw(&smc_inet_protosw);
>> +
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	rc = proto_register(&smc_inet6_prot, 1);
>> +	if (rc) {
>> +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
>> +		goto out_inet6_prot;
>> +	}
>> +	rc = inet6_register_protosw(&smc_inet6_protosw);
>> +	if (rc) {
>> +		pr_err("%s: inet6_register_protosw smc_inet6_protosw fails with %d\n",
>> +		       __func__, rc);
>> +		goto out_inet6_protosw;
>> +	}
>> +#endif /* CONFIG_IPV6 */
>> +
>> +	return rc;
>> +#if IS_ENABLED(CONFIG_IPV6)
> Can you combine this #if with above one ? Any way you need this only in case of ipv6.
> Error handling with #if is an hindrance to a good readability.

Hi Ratheesh,

Thanks for your advice. Totally agreed with that.
I'll give it a fix in next version.

Best wishes,
D. Wythe

>> +out_inet6_protosw:
>> +	proto_unregister(&smc_inet6_prot);
>> +out_inet6_prot:
>> +	inet_unregister_protosw(&smc_inet_protosw);
>> +	proto_unregister(&smc_inet_prot);
>> +	return rc;
>> +#endif /* CONFIG_IPV6 */
>> +}
>> +
>> +void smc_inet_exit(void)
>> +{
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	inet6_unregister_protosw(&smc_inet6_protosw);
>> +	proto_unregister(&smc_inet6_prot);
>> +#endif /* CONFIG_IPV6 */
>> +	inet_unregister_protosw(&smc_inet_protosw);
>> +	proto_unregister(&smc_inet_prot);
>> +}
>> diff --git a/net/smc/smc_inet.h b/net/smc/smc_inet.h
>> new file mode 100644
>> index 00000000..a489c8a
>> --- /dev/null
>> +++ b/net/smc/smc_inet.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>> + *
>> + *  Definitions for the IPPROTO_SMC (socket related)
>> +
>> + *  Copyright IBM Corp. 2016
>> + *  Copyright (c) 2024, Alibaba Inc.
>> + *
>> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
>> + */
>> +#ifndef __INET_SMC
>> +#define __INET_SMC
>> +
>> +/* Initialize protocol registration on IPPROTO_SMC,
>> + * @return 0 on success
>> + */
>> +int smc_inet_init(void);
>> +
>> +void smc_inet_exit(void);
>> +
>> +#endif /* __INET_SMC */
>> --
>> 1.8.3.1
>>


