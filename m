Return-Path: <linux-rdma+bounces-4870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46297485F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 04:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C6BB24A39
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 02:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288829CFB;
	Wed, 11 Sep 2024 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pr9FBQbD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284010A0E;
	Wed, 11 Sep 2024 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023237; cv=none; b=SfVhOQeHOS7QTaoUTkC6wkwT+khEn6J4wu3N4Tnp7y4Tf1d8abbR31ULwlDwHy7PH3a7EJBGLqOiO4HfuTQ+ht+MM1aJx0DHNgvQstazh6l4MQKV79c2P2sY5i65NSILJXfaT/J7I6nR2jXcVEDLzpMXfKUYfs0inP+mfX8lzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023237; c=relaxed/simple;
	bh=wbrGTFkl9vaEApSOli/mFkxjbDDeXUBQAFnWakdQiU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOwdBYfTjdlvYSXDiGfBMtMnN8aaIMNABSIOmHDHHOxKt5NvZ7ePbUfddVF4aiK12Yu1KBQhN67tGAgwDxarjd4A8L3+QwLbzUBaOWrWrmNSvJ5hpKjmb/5Wv9akS9ZD/5EyCWOX2Uu7DBLEjT59J4iF77f9LMcpmPo729cWi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pr9FBQbD; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726023225; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ad2HgtRlxXNAN6IdzsclPeKOqae5OG8pTw7F+XYL2e8=;
	b=Pr9FBQbDLbbzUEf/kHFv3WFuyOgevbWFYLwCDbsidQ0rHUqg3Svaz8vWq+O4USMKUGeGNJHmQJKukXCxbhqHQ9qBjhsSqDhH/mYmWk85ZtxIe7eWKgjCKVNO/9j9PQeATkH8E8GfBX45K6+VOiZa3yiUJi6Oav3UUCybmutmUYk=
Received: from 30.221.149.106(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WEmGA3m_1726023224)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 10:53:44 +0800
Message-ID: <763f0662-c001-4bce-accf-1d7cf2fbaf60@linux.alibaba.com>
Date: Wed, 11 Sep 2024 10:53:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
To: Paolo Abeni <pabeni@redhat.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, edumazet@google.com
References: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
 <8a1684ca-755b-4612-afe1-41340b46f2fe@redhat.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <8a1684ca-755b-4612-afe1-41340b46f2fe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/10/24 6:10 PM, Paolo Abeni wrote:
> On 9/6/24 04:35, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake 
>> workqueue congested"),
>> we introduce a mechanism to put constraint on SMC connections visit
>> according to the pressure of SMC handshake process.
>>
>> At that time, we believed that controlling the feature through netlink
>> was sufficient. However, most people have realized now that netlink is
>> not convenient in container scenarios, and sysctl is a more suitable
>> approach.
>
> Not blocking this patch, but could you please describe why/how NL is 
> less convenient? is possibly just a matter of lack of command line 
> tool to operate on NL? yaml to the rescue ;)
>
> Cheers,
>
> Paolo

Hi Paolo,

Based on the information I've gathered, there are several aspects:

1. There is a lack of support for YAML on NL in popular products.

2. The infrastructure related to NLwas not yet sound enough. For 
example, how to disable
settings for certain NL in container, while we can do it within sysctls. 
Also, regular synchronization.
NL may be able to implement it (maybe via Yaml ), but it still be waiting
for support in popular products.

Best wishes,
D. Wythe





