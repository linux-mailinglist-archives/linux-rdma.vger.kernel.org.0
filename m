Return-Path: <linux-rdma+bounces-8283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7F0A4D1C3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 03:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF523A8842
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 02:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3E189BB1;
	Tue,  4 Mar 2025 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hXNh7Jik"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4632AE8C;
	Tue,  4 Mar 2025 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055965; cv=none; b=EARM9WJkTfuF0SfPOWhoCN3iA2mGxxWjzG6n3+Zrih1mBPK4RJbcKcBgYkWiylpveHowwLmJMB1edBW3h0pJBfe1qeRZvIIdyOkouJiTa3TdQWNlsGEC3JWrYmyCsKGN83MWpVy/dx1PjxXfTOZlW8OCUlLdeAvkiUXmrwtvk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055965; c=relaxed/simple;
	bh=S6UahJypzv0OFjPYG4CuqQEAnDKBxU5UlGzMb+Pa2tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8sGYQBpVs/3q9U/ENWszK4jNESlOqbTWmCz/G5kVW7XxDBsgw5pUOHlsQNhpznnN0NY1WDdMQljh+1TP/Tga6JK8aomns0cjptYpydepM+yUSW+S6Q6y07675uyNpjhR8tmdD5jDYs7aVG5A8aJI8kkbhLKumv4I8oGrCJnq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hXNh7Jik; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741055951; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=USo7sAYD7oXp/gFBg03CGd9QfUctKLOWmyXr8TKIUO8=;
	b=hXNh7JikXzFCHmBKGXGSjLH5Jjtu/JYbocIH/6slbhxyDiWgc0klrtg3yzjQthfh2DfeOHyjR0NNIeUe4TuLu4JDX8qNce6RN4jDLrdTKS/zmclJ86OkLppBlvkfSlu5Mpj8l7Clb6/5jzWgzc/fYhMPD/SZQKYsCgFbk0hmu8k=
Received: from 30.221.99.241(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WQgMsiM_1741055949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Mar 2025 10:39:10 +0800
Message-ID: <e59e4632-c689-4cd4-a9ab-73edc93d002d@linux.alibaba.com>
Date: Tue, 4 Mar 2025 10:39:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
 <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
 <20250107203218.5787acb4.pasic@linux.ibm.com>
 <908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
 <20250109040429.350fdd60.pasic@linux.ibm.com>
 <b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
 <20250210145255.793e6639.pasic@linux.ibm.com>
 <4eb38707-1a93-4c5c-aa65-14adfd595d14@linux.alibaba.com>
 <20250303152410.31f5e3df.pasic@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250303152410.31f5e3df.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/3/3 22:24, Halil Pasic wrote:
> On Tue, 11 Feb 2025 11:44:32 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>>> Can you please help me reason about this? I'm unfortunately lacking
>>> Kubernetes skills here, and it is difficult for me to think along.  
>>
>> Yes, it is also a problem that not being able to set eth0 (veth/POD)'s PNEDID from the host.
>> Even if the eth1(host) have hardware PNETID, the eth0 (veth/POD) can not search the hardware
>> PNETID. Because the eth0 (veth/POD) and eth1(host) are not in one netdev hierarchy.
>> But the two netdev hierarchies have relationship. Maybe search PNETID in all related netdev
>> hierarchies can help resolve this. For example when finding the base_ndev, if the base_ndev
>> is a netdev has relationship with other netdev(veth .etc) then jump to the related netdev
>> hierarchy through the relationship to iteratively find the base_ndev.
>> It is an idea now. I have not do any research about it yet and I am not sure if it is feasible.
> 
> I did a fair amount of thinking and I've talked to Wenjia and Sandy as
> well, and now I'm fine with moving forward with a variant that
> prioritizes compatibility but makes the scenarios you have pointed out
> work by enabling taking the SW PNETID of the non-leaf netdev(s) if the
> base_dev has no PNETID (neither hw nor sw).
> 
> Regards,
> Halil

Thanks Halil, Wenjia and Alexandra.

I will send a v2 patch soon, in which software pnetid will be searched in both base_ndev and ndev,
and base_ndev will take precedence over ndev.

Regards,
Guangguan Wang

