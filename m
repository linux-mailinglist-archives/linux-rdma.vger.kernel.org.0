Return-Path: <linux-rdma+bounces-6084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798EC9D7BA8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 07:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CD2822AF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19253187FFA;
	Mon, 25 Nov 2024 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cb8qg0KH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265551EB2A;
	Mon, 25 Nov 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517232; cv=none; b=WT9lZfOz9pvkmuBpSjFEVvOf2A6axcJ9WpDZjsVedpk2zVjl19FC8pxdZxYsxq1RAXZH4tTVxwQyDXrtSKJBeFM7ofL3EJb6+jINjNsrySA4msYJ/PtAEnx00bYXTdrvs0Kt6CwjnNunvp4Mupu5rXhjplh4UOn6GrXqeqihGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517232; c=relaxed/simple;
	bh=eKEF0BbjxvqO5gPT9snUzKY28f2XgUTDks902HhaKww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAobl+ziUTni/SaYge5hcYHqJVx1LiM0Jj93+PEr/8CviSeLu++btsYmgjuJefVwIRQgnymIsRGapB/Nzg2iby7Pq3aIZ5R1hQ+4AinUUlPsjbOca8K2wDzlN7vztRid8dSyg+/xmR8gxVxzQiMu0LmUzdM3Co8/jk03nQ6IpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cb8qg0KH; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732517220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MirHr3XbOTdU6te/YJQY0lZO69FMwy07aad9WvZ04iU=;
	b=Cb8qg0KHS57jx1S22KC0bxW+2FwTjy4QAsnYf9Q0ks63fNxZvWhuB44cWFR6UtvXqKkW9KfzIyUIz2bI6gUHbnwnY7+JrlBwz4GdeQUMp7DRB/3Uk1qv6KhsVONoChwwyy4d6AvRIiIqsYyvQz8KX7tSf3mKaMeKFQIwrxpK9Gs=
Received: from 30.221.129.101(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WK76Lb0_1732517210 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 14:46:59 +0800
Message-ID: <53933615-6508-4603-b62c-f9a355377fe2@linux.alibaba.com>
Date: Mon, 25 Nov 2024 14:46:48 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
 <4c65cb7a-fcf3-4f24-9aaf-f270033db5db@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <4c65cb7a-fcf3-4f24-9aaf-f270033db5db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/22 23:56, Wenjia Zhang wrote:
> 
> 
> On 22.11.24 08:16, Wen Gu wrote:
>> We encountered a LGR/link use-after-free issue, which manifested as
>> the LGR/link refcnt reaching 0 early and entering the clear process,
>> making resource access unsafe.
>>
> 
> How did you make sure that the refcount mentioned in the warning are the LGR/link refcnt, not &sk->sk_refcnt?
> 
Because according to the panic stack, the UAF is found in smcr_link_put(),
and it is also found that the link has been cleared at that time (lnk has
been memset to all zero by __smcr_link_clear()).

>>   refcount_t: addition on 0; use-after-free.
>>   WARNING: CPU: 14 PID: 107447 at lib/refcount.c:25 refcount_warn_saturate+0x9c/0x140
>>   Workqueue: events smc_lgr_terminate_work [smc]
>>   Call trace:
>>    refcount_warn_saturate+0x9c/0x140
>>    __smc_lgr_terminate.part.45+0x2a8/0x370 [smc]
>>    smc_lgr_terminate_work+0x28/0x30 [smc]
>>    process_one_work+0x1b8/0x420
>>    worker_thread+0x158/0x510
>>    kthread+0x114/0x118
>>
>> or
>>
>>   refcount_t: underflow; use-after-free.
>>   WARNING: CPU: 6 PID: 93140 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x140
>>   Workqueue: smc_hs_wq smc_listen_work [smc]
>>   Call trace:
>>    refcount_warn_saturate+0xf0/0x140
>>    smcr_link_put+0x1cc/0x1d8 [smc]
>>    smc_conn_free+0x110/0x1b0 [smc]
>>    smc_conn_abort+0x50/0x60 [smc]
>>    smc_listen_find_device+0x75c/0x790 [smc]
>>    smc_listen_work+0x368/0x8a0 [smc]
>>    process_one_work+0x1b8/0x420
>>    worker_thread+0x158/0x510
>>    kthread+0x114/0x118
>>
>> It is caused by repeated release of LGR/link refcnt. One suspect is that
>> smc_conn_free() is called repeatedly because some smc_conn_free() are not
>> protected by sock lock.
>>
>> Calls under socklock        | Calls not under socklock
>> -------------------------------------------------------
>> lock_sock(sk)               | smc_conn_abort
>> smc_conn_free               | \- smc_conn_free
>> \- smcr_link_put            |    \- smcr_link_put (duplicated)
>> release_sock(sk)
>>
>> So make sure smc_conn_free() is called under the sock lock.
>>
> 
> If I understand correctly, the fix could only solve a part of the problem, i.e. what the second call trace reported, right?

I think that these panic stacks (there are some other variations that I haven't posted)
have the same root cause, that is the link/lgr refcnt reaches 0 early in the race situation,
making access to link/lgr related resources no longer safe.

The link/lgr refcnt was introduced by [1] & [2], the link refcnt is operated by link
itself and connections registered to it, and the lgr refcnt is operated by lgr itself,
links belong to it and connections registered to it. Through code analysis, the most
likely suspect is that smc_conn_free() duplicate put link/lgr refcnt because some
smc_conn_free() calls by smc_conn_abort() are not under the protection of sock lock,
so if they are called at the same time, there may be a race condition.

for example:

    __smc_lgr_terminate            | smc_listen_decline
    --------------------------------------------------------------
    lock_sock                      |
    smc_conn_kill                  | smc_conn_abort
     \- smc_conn_free              |  \- smc_conn_free
    release_sock                   |

[1] 61f434b0280e ("net/smc: Resolve the race between link group access and termination")
[2] 20c9398d3309 ("net/smc: Resolve the race between SMC-R link access and clear")

> 
>> Fixes: 8cf3f3e42374 ("net/smc: use helper smc_conn_abort() in listen processing")
>> Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Co-developed-by: Kai <KaiShen@linux.alibaba.com>
>> Signed-off-by: Kai <KaiShen@linux.alibaba.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 25 +++++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index ed6d4d520bc7..e0a7a0151b11 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -973,7 +973,8 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
>>       return smc_connect_fallback(smc, reason_code);
>>   }
>> -static void smc_conn_abort(struct smc_sock *smc, int local_first)
>> +static void __smc_conn_abort(struct smc_sock *smc, int local_first,
>> +                 bool locked)
>>   {
>>       struct smc_connection *conn = &smc->conn;
>>       struct smc_link_group *lgr = conn->lgr;
>> @@ -982,11 +983,27 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
>>       if (smc_conn_lgr_valid(conn))
>>           lgr_valid = true;
>> -    smc_conn_free(conn);
>> +    if (!locked) {
>> +        lock_sock(&smc->sk);
>> +        smc_conn_free(conn);
>> +        release_sock(&smc->sk);
>> +    } else {
>> +        smc_conn_free(conn);
>> +    }
>>       if (local_first && lgr_valid)
>>           smc_lgr_cleanup_early(lgr);
>>   }
>> +static void smc_conn_abort(struct smc_sock *smc, int local_first)
>> +{
>> +    __smc_conn_abort(smc, local_first, false);
>> +}
>> +
>> +static void smc_conn_abort_locked(struct smc_sock *smc, int local_first)
>> +{
>> +    __smc_conn_abort(smc, local_first, true);
>> +}
>> +
>>   /* check if there is a rdma device available for this connection. */
>>   /* called for connect and listen */
>>   static int smc_find_rdma_device(struct smc_sock *smc, struct smc_init_info *ini)
>> @@ -1352,7 +1369,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>>       return 0;
>>   connect_abort:
>> -    smc_conn_abort(smc, ini->first_contact_local);
>> +    smc_conn_abort_locked(smc, ini->first_contact_local);
>>       mutex_unlock(&smc_client_lgr_pending);
>>       smc->connect_nonblock = 0;
>> @@ -1454,7 +1471,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>>       return 0;
>>   connect_abort:
>> -    smc_conn_abort(smc, ini->first_contact_local);
>> +    smc_conn_abort_locked(smc, ini->first_contact_local);
>>       mutex_unlock(&smc_server_lgr_pending);
>>       smc->connect_nonblock = 0;
> 
> Why is smc_conn_abort_locked() only necessary for the smc_connect_work, not for the smc_listen_work?
> 

Before this patch, the smc_conn_abort()->smc_conn_free() calls are not
protected by sock lock except in smc_conn_{rdma|ism}. So I add sock lock
protection inside the __smc_conn_abort() and introduce smc_conn_abort_locked()
(which means sock lock has been taken) for smc_conn_{rdma|ism}.

> Thanks,
> Wenjia

Thanks!
Wen Gu

