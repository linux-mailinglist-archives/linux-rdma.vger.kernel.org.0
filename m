Return-Path: <linux-rdma+bounces-6474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5109EE78B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87221888724
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB0213E99;
	Thu, 12 Dec 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yv+GVMEZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A33209F5F;
	Thu, 12 Dec 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009239; cv=none; b=Mr75rDuzyQdQuVBYNE6OKA2o9HY41O2BOBf6l+J9YibBfCzykyiZd65NHJIq66NVnhEtPgaHGmdVrntIBFQYoObLQlLAyqUxUBFw3nil3vnymJgI+wM46jwBqIpTqUTO1NFSgtJ6gTuiiYMcn1+1efwTAz3CGUstT3Yv09rlhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009239; c=relaxed/simple;
	bh=8ZxdqX3677DIbR7WzIe7BoYgv1eV+CE7CNkvztLo224=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7fGRqVjStJ+uqQCQa5S3GiTi6tYFxIe2jCTNyTSJLCZ4+Z8wOASZHMR1LVq/bvAd0T3j2nrwvnWSBooWAL8Qoo0dVwGVk0X4GIlTANaMSkvmroWHXUpy1y2d4IChU2m8xocpMbsE2pNLzRFxCWstlSIxGgJ5LW/kN/sKtYadjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yv+GVMEZ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734009230; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I/mdsBc2XXbIj10bhSyyhla6NBjcnS9BYPIXBNq4lm0=;
	b=Yv+GVMEZERG878asvO5T6KTBSxXTajRiksDeLqejOop9gA/lzM6gimThnScORpwQcAIiJqcZ7LdUJe5+0vENdiMpz83mvQARg+oGaFMRowac9N9ebeXjcEAsBQsqXVIuQCxyo0sFNTJ6r0UIx9nzz6JMPUbPfCjv+p0MBjSCfiA=
Received: from 30.221.100.127(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLLqqd-_1734009227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:13:49 +0800
Message-ID: <a3535b6a-8bd9-4ab8-a2a1-8919927af9f1@linux.alibaba.com>
Date: Thu, 12 Dec 2024 21:13:47 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped ipv6
 addr client for smc-r v2
To: Paolo Abeni <pabeni@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
 <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
 <20241211195440.54b37a79.pasic@linux.ibm.com>
 <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/12 20:49, Paolo Abeni wrote:
> On 12/11/24 19:54, Halil Pasic wrote:
>> On Wed, 11 Dec 2024 10:30:55 +0800
>> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
>>
>>> AF_INET6 is not supported for smc-r v2 client before, even if the
>>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>>> will fallback to tcp, especially for java applications running smc-r.
>>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>>> using real global ipv6 addr is still not supported yet.
>>>
>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>
>> Sorry for the late remark, but does this need a Fixes tag? I mean
>> my gut feeling is that this is a bugfix -- i.e. should have been
>> working from the get go -- and not a mere enhancement. No strong
>> opinions here.
> 
> FTR: my take is this is really a new feature, as the ipv6 support for
> missing from the smc-r v2 introduction and sub-system maintainers
> already implicitly agreed on that via RB tags.
> 
> Cheers,
> 
> /P

Agree.
This patch enlarges the scope of using SMCRv2, so I think it is a new feature.

Thanks,
Guangguan Wang

