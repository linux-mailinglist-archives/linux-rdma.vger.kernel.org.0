Return-Path: <linux-rdma+bounces-6086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE29D8338
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF84B2479B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF86190696;
	Mon, 25 Nov 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yLS/SQm+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F1188734;
	Mon, 25 Nov 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528840; cv=none; b=oBaVzZkUPdNAnZUanF9yQj6566s7MuDC3RJU9TEdu0bWiC/Rv46U+My/NG8hp5EPpvGE2ea0T2Qs8ZByVCqTxA3GlWC/LcRK2Mq5t6/Y1jhUfBwMgfkoL85ZtsYNR558FIGHd6KTlaeS39KknOTJC7rcU9tEI4HXWm3FMlzMOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528840; c=relaxed/simple;
	bh=nG02I/YtWm59KgnRrCayMKOax20yo3dTWezpk64chgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZGvTWdEsLM0TtBVSC/5lWxnS/xgvlzbxeccJGL+KVR69pAVzzgjgreb2zQ63DwOwkfq9hGxQmgClRbYGkCa2BzMa6L+2+NjFau+K1SRNcnnYpGaiRiHk3FywNkk7tlLBPgosncyOsbHlnwsIBDJd3OrFc/X5bSEo3qq+AIvKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yLS/SQm+; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732528827; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lpxwBZinqMXYM/AbHsY1DY2WXK0P5tVsO9l+f2NEnAQ=;
	b=yLS/SQm+i+7z6MEd8XFIf9B2QtMvCZMsRfkxoraowqAjfzdLSwxdYQbsDfn6KDECl7Pfmn9z7wEDhCl17tliAJCwyscbvTa3ApyU9sFFK6YiAitz5c2Upj9cR905roQMMJWJBwIz00qwBwLscAIJjDJggO7QGyXYRcYOqanLljA=
Received: from 30.221.129.101(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WK9UHil_1732528825 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 18:00:26 +0800
Message-ID: <f4eb6ddf-0b44-4fb1-95d3-a8f01be19d8d@linux.alibaba.com>
Date: Mon, 25 Nov 2024 18:00:23 +0800
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
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <5688fe46-dda0-4050-ba24-eb5ef573f120@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/23 00:03, Alexandra Winter wrote:
> 
> 
> On 22.11.24 08:16, Wen Gu wrote:
>> We encountered a LGR/link use-after-free issue, which manifested as
>> the LGR/link refcnt reaching 0 early and entering the clear process,
>> making resource access unsafe.
>>
>>   refcount_t: addition on 0; use-after-free.
>>   WARNING: CPU: 14 PID: 107447 at lib/refcount.c:25 refcount_warn_saturate+0x9c/0x140
>>   Workqueue: events smc_lgr_terminate_work [smc]
>>   Call trace:
>>    refcount_warn_saturate+0x9c/0x140
>>    __smc_lgr_terminate.part.45+0x2a8/0x370 [smc]
>>    smc_lgr_terminate_work+0x28/0x30 [smc]
>>    process_one_work+0x1b8/0x420
>>    worker_thread+0x158/0x510
>>    kthread+0x114/0x118
>>
>> or
>>
>>   refcount_t: underflow; use-after-free.
>>   WARNING: CPU: 6 PID: 93140 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x140
>>   Workqueue: smc_hs_wq smc_listen_work [smc]
>>   Call trace:
>>    refcount_warn_saturate+0xf0/0x140
>>    smcr_link_put+0x1cc/0x1d8 [smc]
>>    smc_conn_free+0x110/0x1b0 [smc]
>>    smc_conn_abort+0x50/0x60 [smc]
>>    smc_listen_find_device+0x75c/0x790 [smc]
>>    smc_listen_work+0x368/0x8a0 [smc]
>>    process_one_work+0x1b8/0x420
>>    worker_thread+0x158/0x510
>>    kthread+0x114/0x118
>>
>> It is caused by repeated release of LGR/link refcnt. One suspect is that
>> smc_conn_free() is called repeatedly because some smc_conn_free() are not
>> protected by sock lock.
>>
>> Calls under socklock        | Calls not under socklock
>> -------------------------------------------------------
>> lock_sock(sk)               | smc_conn_abort
>> smc_conn_free               | \- smc_conn_free
>> \- smcr_link_put            |    \- smcr_link_put (duplicated)
>> release_sock(sk)
>>
>> So make sure smc_conn_free() is called under the sock lock.
>>
>> Fixes: 8cf3f3e42374 ("net/smc: use helper smc_conn_abort() in listen processing")
>> Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Co-developed-by: Kai <KaiShen@linux.alibaba.com>
>> Signed-off-by: Kai <KaiShen@linux.alibaba.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 25 +++++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index ed6d4d520bc7..e0a7a0151b11 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -973,7 +973,8 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
>>   	return smc_connect_fallback(smc, reason_code);
>>   }
>>   
>> -static void smc_conn_abort(struct smc_sock *smc, int local_first)
>> +static void __smc_conn_abort(struct smc_sock *smc, int local_first,
>> +			     bool locked)
>>   {
>>   	struct smc_connection *conn = &smc->conn;
>>   	struct smc_link_group *lgr = conn->lgr;
>> @@ -982,11 +983,27 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
>>   	if (smc_conn_lgr_valid(conn))
>>   		lgr_valid = true;
>>   
>> -	smc_conn_free(conn);
>> +	if (!locked) {
>> +		lock_sock(&smc->sk);
>> +		smc_conn_free(conn);
>> +		release_sock(&smc->sk);
>> +	} else {
>> +		smc_conn_free(conn);
>> +	}
>>   	if (local_first && lgr_valid)
>>   		smc_lgr_cleanup_early(lgr);
>>   }
>>   
>> +static void smc_conn_abort(struct smc_sock *smc, int local_first)
>> +{
>> +	__smc_conn_abort(smc, local_first, false);
>> +}
>> +
>> +static void smc_conn_abort_locked(struct smc_sock *smc, int local_first)
>> +{
>> +	__smc_conn_abort(smc, local_first, true);
>> +}
>> +
>>   /* check if there is a rdma device available for this connection. */
>>   /* called for connect and listen */
>>   static int smc_find_rdma_device(struct smc_sock *smc, struct smc_init_info *ini)
>> @@ -1352,7 +1369,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>>   
>>   	return 0;
>>   connect_abort:
>> -	smc_conn_abort(smc, ini->first_contact_local);
>> +	smc_conn_abort_locked(smc, ini->first_contact_local);
>>   	mutex_unlock(&smc_client_lgr_pending);
>>   	smc->connect_nonblock = 0;
>>   
>> @@ -1454,7 +1471,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>>   
>>   	return 0;
>>   connect_abort:
>> -	smc_conn_abort(smc, ini->first_contact_local);
>> +	smc_conn_abort_locked(smc, ini->first_contact_local);
>>   	mutex_unlock(&smc_server_lgr_pending);
>>   	smc->connect_nonblock = 0;
>>   
> 
> I wonder if this can deadlock, when you take lock_sock so far down in the callchain.
> example:
>   smc_connect will first take lock_sock(sk) and then mutex_lock(&smc_server_lgr_pending);  (e.g. in smc_connect_ism())
> wheras
> smc_listen_work() will take mutex_lock(&smc_server_lgr_pending); and then lock_sock(sk) (in your __smc_conn_abort(,,false))
> 
> I am not sure whether this can be called on the same socket, but it looks suspicious to me.
> 

IMHO this two paths can not occur on the same sk.

> 
> All callers of smc_conn_abort() without socklock seem to originate from smc_listen_work().
> That makes me think whether smc_listen_work() should do lock_sock(sk) on a higher level.
> 

Yes, I also think about this question, I guess it is because the new smc sock will be
accepted by userspace only after smc_listen_work() is completed. Before that, no userspace
operation occurs synchronously with it, so it is not protected by sock lock. But I am not
sure if there are other reasons, so I did not aggressively protect the entire smc_listen_work
with sock lock, but chose a conservative approach.

> Do you have an example which function could collide with smc_listen_work()?
> i.e. have you found a way to reproduce this?
> 

We discovered this during our fault injection testing where the rdma driver was rmmod/insmod
sporadically during the nginx/wrk 1K connections test.

e.g.

    __smc_lgr_terminate            | smc_listen_decline
    (caused by rmmod mlx5_ib)      | (caused by e.g. reg mr fail)
    --------------------------------------------------------------
    lock_sock                      |
    smc_conn_kill                  | smc_conn_abort
     \- smc_conn_free              |  \- smc_conn_free
    release_sock                   |

> 
> Are you sure that all callers of smc_conn_free(), that are not smc_conn_abort(), do set the socklock?
> It seems to me that the path of smc_conn_kill() is not covered by your solution.
> 

smc_conn_free is called in these places:

1. __smc_release (protected by sock lock)
2. smc_conn_abort (partially protected by sock lock)
3. smc_close_active_abort - smc_release(protected by sock lock)
                           - smc_conn_kill - __smc_lgr_terminate/smc_conn_abort_work(protected by sock lock)
4. smc_close_passive_work (protected by sock lock)

So only smc_conn_abort->smc_conn_free is not well protected by sock lock.

> 
> Please excuse, that I am not deeply familiar with this code.
> I'm just trying to ask helpful questions.

Thanks! :)

