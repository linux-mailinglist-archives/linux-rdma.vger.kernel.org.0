Return-Path: <linux-rdma+bounces-6118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9D9DA2A4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 08:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B43C284379
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2214D2BB;
	Wed, 27 Nov 2024 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tQXo87tq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB0142E67;
	Wed, 27 Nov 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691036; cv=none; b=d+6rwCBlQgsyE8E53F3Rf1e1D/oPfTkagNVTKy3lx/mOAOnYQhUXWuD6yszJGeS5MOB1gFISk9WO2cF7uTLmsC8OQK0U2CbNsgdNSJv1Ue2NM+sLTg64tlV3vnHODVaqfxlyqmFL4Ge6k54n+iN3OQPjy498Oo9RSdUJzqrvEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691036; c=relaxed/simple;
	bh=Vr+OPaKshdfcwKPvFlrq+DwZKQuM5oRL8whyKhkMx60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFb1ZGzNqRde19t2BYwt0rmy/lizQCMKvHGdpRPtYno11HkiS8t/DkHuADsQsgmtkYffSutiOcEMLnPnHdPuabvCA0I//MWtcGFYDqQdkVfRPH4BVC55xNAj+n1c4okmVPVkKtt+pjI4zVxVdAdLK8w5oZym9GO0jWjfOMxMu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tQXo87tq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732691028; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8b4CvN/0uVEaBclN/45Oq1ekXqOJCvnUAqF3eGgR/Ic=;
	b=tQXo87tq/Wl/0o4FneOch6HX9VTJhJ7muF/2VBSW9MiKz91Arjj2dH8wRXFmf5hdOm49suk2LxO7PNsHJYT6sosiyhF6Orf2wT5BSWufpjKMg7xPigHa79i3hLsMsa1R+o/ceTH7gwMkZPqTfvqwZONiqNoca+/7GtaiuYE983E=
Received: from 30.221.129.190(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WKLPV-Q_1732691026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 15:03:48 +0800
Message-ID: <dfe1ba19-a1fe-4d29-b7f5-40d7b62ce144@linux.alibaba.com>
Date: Wed, 27 Nov 2024 15:03:44 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
To: Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
 <5688fe46-dda0-4050-ba24-eb5ef573f120@linux.ibm.com>
 <f4eb6ddf-0b44-4fb1-95d3-a8f01be19d8d@linux.alibaba.com>
 <0d62917a-f64e-4be1-95c9-649f1a24d676@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0d62917a-f64e-4be1-95c9-649f1a24d676@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/25 21:02, Alexandra Winter wrote:
> 
> 
> On 25.11.24 11:00, Wen Gu wrote:
>>> I wonder if this can deadlock, when you take lock_sock so far down in the callchain.
>>> example:
>>>    smc_connect will first take lock_sock(sk) and then mutex_lock(&smc_server_lgr_pending);  (e.g. in smc_connect_ism())
>>> wheras
>>> smc_listen_work() will take mutex_lock(&smc_server_lgr_pending); and then lock_sock(sk) (in your __smc_conn_abort(,,false))
>>>
>>> I am not sure whether this can be called on the same socket, but it looks suspicious to me.
>>>
>>
>> IMHO this two paths can not occur on the same sk.
>>
>>>
>>> All callers of smc_conn_abort() without socklock seem to originate from smc_listen_work().
>>> That makes me think whether smc_listen_work() should do lock_sock(sk) on a higher level.
>>>
>>
>> Yes, I also think about this question, I guess it is because the new smc sock will be
>> accepted by userspace only after smc_listen_work() is completed. Before that, no userspace
>> operation occurs synchronously with it, so it is not protected by sock lock. But I am not
>> sure if there are other reasons, so I did not aggressively protect the entire smc_listen_work
>> with sock lock, but chose a conservative approach.
>>
>>> Do you have an example which function could collide with smc_listen_work()?
>>> i.e. have you found a way to reproduce this?
>>>
>>
>> We discovered this during our fault injection testing where the rdma driver was rmmod/insmod
>> sporadically during the nginx/wrk 1K connections test.
>>
>> e.g.
>>
>>     __smc_lgr_terminate            | smc_listen_decline
>>     (caused by rmmod mlx5_ib)      | (caused by e.g. reg mr fail)
>>     --------------------------------------------------------------
>>     lock_sock                      |
>>     smc_conn_kill                  | smc_conn_abort
>>      \- smc_conn_free              |  \- smc_conn_free
>>     release_sock                   |
> 
> 
> Thank you for the explanations. So the most suspicious scenario is
> smc_listen_work() colliding with
>   __smc_lgr_terminate() -> smc_conn_kill() of the conn and smc socket that is just under
> construction by smc_listen_work() (without socklock).
> 
> I am wondering, if other parts of smc_listen_work() are allowed to run in parallel
> with smc_conn_kill() of this smc socket??
> 
Ideally, smc_listen_work should be all covered by new_smc's sock lock, mutually
exclusive with other conn operations.

But I need to look deeper into the smc_listen_work() implementation to see if
all-covered by sock lock is feasible. At least some of the places already protected
by new_smc's sock lock need to be excluded or handled.

e.g.

smc_listen_work()
  \- smc_listen_out_xxx()
      \- smc_listen_out()
          \- smc_close_non_accepted() -> take the new_smc's sock lock.

> My impression would be that the whole smc_listen_work() should be protected against
> smc_conn_kill(), not only smc_conn_free.
> 

Thanks!

