Return-Path: <linux-rdma+bounces-6111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4449D9716
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 13:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF6BB2DB20
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0421CF2A0;
	Tue, 26 Nov 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KSejmPMW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E983A17;
	Tue, 26 Nov 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623151; cv=none; b=vCCdYLi8q55C+rbCw20xkTi4qJU1u9Ky25p9RKmAnFlNK5TI0tktEvqdSIC9z8OC2YXNAmfdqhX2o3cLz2T5wbKXlMiV3Er3E7bwtLTk90vByNkm0TdUBPnB/MH95kp8zPpBPH7OEO+UfuWEqDHFhjIDG8mWgmLEEHJmMDTl/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623151; c=relaxed/simple;
	bh=oqhhEApHObh3Dbzv7HT7MSTlhdZ4Zh5EqI+S9HTe9Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmiY3joWopzFSgeFK8PQDDyQL0yx5BrrWwccsWMrbM4vF5+CfWFXOsP0qKDfMjfqSQbZpR5Kf7UHdsWw4xUKKSTRf2lq2D9aauYMTBxho/asFdTBoZLDGTV5xSuVzdKqLEtxAOkuHI+0a8YQIAR0QMAl/LnEPlSB81Bf6mGb0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KSejmPMW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ5OTms019314;
	Tue, 26 Nov 2024 12:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b5Jv8N
	kcaP7lxjHz3pbcucDcn2e1SPVi6MChN/Zh+9w=; b=KSejmPMWCM1AxYUEt8pe+P
	EfBZh8tce1PAwmiztp7wB+u3/c08dz/Z5S+trB07isja0CIo9uGpfcVn3GM67A9f
	2qv7VE+lcOLj3muX4aethu54+qOgN41cklD94xCSgG0fMgNrmyJtb0/fer3MAEyt
	jXcBMsKTfOEcoJjBdOwJdTs59Hli3bnUyTMYepATNqVrhcFtJ5o7j767HOX6xFZp
	RwqGOpw8m1kjCVj6AVEtowj2T57H+GraBtB2xRMIR1ps0SUbAnQzRRc3qo0sDZRA
	nVVmDLNz4p+iISWncpnOGJHTZDfwhPuP+sBOO67SmiRWr/TrxA8WJ4Cr6WSTbaDA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jwekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:12:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQC3Lgu024500;
	Tue, 26 Nov 2024 12:12:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jwek9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:12:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4HTK5026308;
	Tue, 26 Nov 2024 12:12:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30v89f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:12:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQCCLeY46006706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 12:12:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D78E5805D;
	Tue, 26 Nov 2024 12:12:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B458958058;
	Tue, 26 Nov 2024 12:12:17 +0000 (GMT)
Received: from [9.152.224.138] (unknown [9.152.224.138])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 12:12:17 +0000 (GMT)
Message-ID: <fe4cd539-559c-4b05-9930-f49617ee655f@linux.ibm.com>
Date: Tue, 26 Nov 2024 13:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
 <4c65cb7a-fcf3-4f24-9aaf-f270033db5db@linux.ibm.com>
 <53933615-6508-4603-b62c-f9a355377fe2@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <53933615-6508-4603-b62c-f9a355377fe2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1nrXP084tChdGoOudSkywOyaj8buaOGj
X-Proofpoint-GUID: B_HuOoK8-uv7ARc5QhaqXRauJ7z34Cf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260097



On 25.11.24 07:46, Wen Gu wrote:
> 
> 
> On 2024/11/22 23:56, Wenjia Zhang wrote:
>>
>>
>> On 22.11.24 08:16, Wen Gu wrote:
>>> We encountered a LGR/link use-after-free issue, which manifested as
>>> the LGR/link refcnt reaching 0 early and entering the clear process,
>>> making resource access unsafe.
>>>
>>
>> How did you make sure that the refcount mentioned in the warning are 
>> the LGR/link refcnt, not &sk->sk_refcnt?
>>
> Because according to the panic stack, the UAF is found in smcr_link_put(),
> and it is also found that the link has been cleared at that time (lnk has
> been memset to all zero by __smcr_link_clear()).
> 
ok, I think you're right, I was distracted by the the sock_put() in 
function __smc_lgr_terminate()

>>>   refcount_t: addition on 0; use-after-free.
>>>   WARNING: CPU: 14 PID: 107447 at lib/refcount.c:25 
>>> refcount_warn_saturate+0x9c/0x140
>>>   Workqueue: events smc_lgr_terminate_work [smc]
>>>   Call trace:
>>>    refcount_warn_saturate+0x9c/0x140
>>>    __smc_lgr_terminate.part.45+0x2a8/0x370 [smc]
>>>    smc_lgr_terminate_work+0x28/0x30 [smc]
>>>    process_one_work+0x1b8/0x420
>>>    worker_thread+0x158/0x510
>>>    kthread+0x114/0x118
>>>
>>> or
>>>
>>>   refcount_t: underflow; use-after-free.
>>>   WARNING: CPU: 6 PID: 93140 at lib/refcount.c:28 
>>> refcount_warn_saturate+0xf0/0x140
>>>   Workqueue: smc_hs_wq smc_listen_work [smc]
>>>   Call trace:
>>>    refcount_warn_saturate+0xf0/0x140
>>>    smcr_link_put+0x1cc/0x1d8 [smc]
>>>    smc_conn_free+0x110/0x1b0 [smc]
>>>    smc_conn_abort+0x50/0x60 [smc]
>>>    smc_listen_find_device+0x75c/0x790 [smc]
>>>    smc_listen_work+0x368/0x8a0 [smc]
>>>    process_one_work+0x1b8/0x420
>>>    worker_thread+0x158/0x510
>>>    kthread+0x114/0x118
>>>
>>> It is caused by repeated release of LGR/link refcnt. One suspect is that
>>> smc_conn_free() is called repeatedly because some smc_conn_free() are 
>>> not
>>> protected by sock lock.
>>>
>>> Calls under socklock        | Calls not under socklock
>>> -------------------------------------------------------
>>> lock_sock(sk)               | smc_conn_abort
>>> smc_conn_free               | \- smc_conn_free
>>> \- smcr_link_put            |    \- smcr_link_put (duplicated)
>>> release_sock(sk)
>>>
>>> So make sure smc_conn_free() is called under the sock lock.
>>>
>>
>> If I understand correctly, the fix could only solve a part of the 
>> problem, i.e. what the second call trace reported, right?
> 
> I think that these panic stacks (there are some other variations that I 
> haven't posted)
> have the same root cause, that is the link/lgr refcnt reaches 0 early in 
> the race situation,
> making access to link/lgr related resources no longer safe.
> 
> The link/lgr refcnt was introduced by [1] & [2], the link refcnt is 
> operated by link
> itself and connections registered to it, and the lgr refcnt is operated 
> by lgr itself,
> links belong to it and connections registered to it. Through code 
> analysis, the most
> likely suspect is that smc_conn_free() duplicate put link/lgr refcnt 
> because some
> smc_conn_free() calls by smc_conn_abort() are not under the protection 
> of sock lock,
> so if they are called at the same time, there may be a race condition.
> 
> for example:
> 
>     __smc_lgr_terminate            | smc_listen_decline
>     --------------------------------------------------------------
>     lock_sock                      |
>     smc_conn_kill                  | smc_conn_abort
>      \- smc_conn_free              |  \- smc_conn_free
>     release_sock                   |
> 
> [1] 61f434b0280e ("net/smc: Resolve the race between link group access 
> and termination")
> [2] 20c9398d3309 ("net/smc: Resolve the race between SMC-R link access 
> and clear")
> 
I see, thx!
>>
>>> Fixes: 8cf3f3e42374 ("net/smc: use helper smc_conn_abort() in listen 
>>> processing")
>>> Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>> Co-developed-by: Kai <KaiShen@linux.alibaba.com>
>>> Signed-off-by: Kai <KaiShen@linux.alibaba.com>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>   net/smc/af_smc.c | 25 +++++++++++++++++++++----
>>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index ed6d4d520bc7..e0a7a0151b11 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -973,7 +973,8 @@ static int smc_connect_decline_fallback(struct 
>>> smc_sock *smc, int reason_code,
>>>       return smc_connect_fallback(smc, reason_code);
>>>   }
>>> -static void smc_conn_abort(struct smc_sock *smc, int local_first)
>>> +static void __smc_conn_abort(struct smc_sock *smc, int local_first,
>>> +                 bool locked)
>>>   {
>>>       struct smc_connection *conn = &smc->conn;
>>>       struct smc_link_group *lgr = conn->lgr;
>>> @@ -982,11 +983,27 @@ static void smc_conn_abort(struct smc_sock 
>>> *smc, int local_first)
>>>       if (smc_conn_lgr_valid(conn))
>>>           lgr_valid = true;
>>> -    smc_conn_free(conn);
>>> +    if (!locked) {
>>> +        lock_sock(&smc->sk);
>>> +        smc_conn_free(conn);
>>> +        release_sock(&smc->sk);
>>> +    } else {
>>> +        smc_conn_free(conn);
>>> +    }
>>>       if (local_first && lgr_valid)
>>>           smc_lgr_cleanup_early(lgr);
>>>   }
>>> +static void smc_conn_abort(struct smc_sock *smc, int local_first)
>>> +{
>>> +    __smc_conn_abort(smc, local_first, false);
>>> +}
>>> +
>>> +static void smc_conn_abort_locked(struct smc_sock *smc, int 
>>> local_first)
>>> +{
>>> +    __smc_conn_abort(smc, local_first, true);
>>> +}
>>> +
>>>   /* check if there is a rdma device available for this connection. */
>>>   /* called for connect and listen */
>>>   static int smc_find_rdma_device(struct smc_sock *smc, struct 
>>> smc_init_info *ini)
>>> @@ -1352,7 +1369,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>>>       return 0;
>>>   connect_abort:
>>> -    smc_conn_abort(smc, ini->first_contact_local);
>>> +    smc_conn_abort_locked(smc, ini->first_contact_local);
>>>       mutex_unlock(&smc_client_lgr_pending);
>>>       smc->connect_nonblock = 0;
>>> @@ -1454,7 +1471,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>>>       return 0;
>>>   connect_abort:
>>> -    smc_conn_abort(smc, ini->first_contact_local);
>>> +    smc_conn_abort_locked(smc, ini->first_contact_local);
>>>       mutex_unlock(&smc_server_lgr_pending);
>>>       smc->connect_nonblock = 0;
>>
>> Why is smc_conn_abort_locked() only necessary for the 
>> smc_connect_work, not for the smc_listen_work?
>>
> 
> Before this patch, the smc_conn_abort()->smc_conn_free() calls are not
> protected by sock lock except in smc_conn_{rdma|ism}. So I add sock lock
Do you mean here that the smc_conn_abort()->smc_conn_free() calls are 
protected in smc_listen_{rdma|ism}, right?
If it is, could you please point me out where they(the protection) are?
> protection inside the __smc_conn_abort() and introduce 
> smc_conn_abort_locked()
> (which means sock lock has been taken) for smc_conn_{rdma|ism}.
> 

Thanks,
Wenjia


