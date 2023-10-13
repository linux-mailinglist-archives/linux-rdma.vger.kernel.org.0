Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336917C850D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjJMLwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjJMLwa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 07:52:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC8210E;
        Fri, 13 Oct 2023 04:52:25 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DBiqoE032363;
        Fri, 13 Oct 2023 11:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=n1VMKltJz5C+JcgB6WyFBjsjz6KfDPa7iextu9KT7C0=;
 b=GiLHJUZbIv0y00SAge+Fq20aIqu3vEsP89SOnz66DyRHgycYYHIw+Ef9ss4PDv2qMTLp
 8O7WKk+AnsGMSvhAmN4gPfunaQbVtCX+jGMNHE2z3PFxDqAJhpztKeJ4vG0A4djyoPeY
 hRpXtQ+g7nxRF1ml2uUiGN0KXNXGGHfukh99ypFje7j0J1mrnw8DBdCKvRH+USUoBbzl
 2l+wH3IOYzI/lXNDDQwZm+XQ+s4bnb/6nWOY8OxLl0MprCH6iAlfK+s0IY3X/liEkirn
 /Z5R1DtY7ijxs8bfDb4hkX4fYO00V6zI81jcWwCxjVCaNJzrZxrTkOBivgpg9pbkGVGh 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq59t0amd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:52:14 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DBlC79008999;
        Fri, 13 Oct 2023 11:52:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq59t0akv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:52:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39DBG2Aj010222;
        Fri, 13 Oct 2023 11:52:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt59kmey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:52:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39DBqB7U22938154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 11:52:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEEEA58061;
        Fri, 13 Oct 2023 11:52:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21B9C58058;
        Fri, 13 Oct 2023 11:52:10 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Oct 2023 11:52:09 +0000 (GMT)
Message-ID: <6666db42-a4de-425e-a96d-bfa899ab265e@linux.ibm.com>
Date:   Fri, 13 Oct 2023 13:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-GB
To:     dust.li@linux.alibaba.com, "D. Wythe" <alibuda@linux.alibaba.com>,
        kgraul@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
 <e63b546f-b993-4e42-8269-e4d9afa5b845@linux.ibm.com>
 <f8089b26-bb11-f82d-8070-222b1f8c1db1@linux.alibaba.com>
 <745d3174-f497-4d6a-ba13-1074128ad99d@linux.ibm.com>
 <20231013053214.GT92403@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231013053214.GT92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w5v6eedYKVZnvtvjQ1su9NXT5N3bdANz
X-Proofpoint-ORIG-GUID: Fk5eXdDtPpiMvCeTmgqnjrqZ7h0EBjRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 13.10.23 07:32, Dust Li wrote:
> On Thu, Oct 12, 2023 at 01:51:54PM +0200, Wenjia Zhang wrote:
>>
>>
>> On 12.10.23 04:37, D. Wythe wrote:
>>>
>>>
>>> On 10/12/23 4:31 AM, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>
>>>>> Considering scenario:
>>>>>
>>>>>                  smc_cdc_rx_handler_rwwi
>>>>> __smc_release
>>>>>                  sock_set_flag
>>>>> smc_close_active()
>>>>> sock_set_flag
>>>>>
>>>>> __set_bit(DEAD)            __set_bit(DONE)
>>>>>
>>>>> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
>>>>> if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
>>>>> in smc_close_passive_work:
>>>>>
>>>>> if (sock_flag(sk, SOCK_DEAD) &&
>>>>>      smc_close_sent_any_close(conn)) {
>>>>>      sk->sk_state = SMC_CLOSED;
>>>>> } else {
>>>>>      /* just shutdown, but not yet closed locally */
>>>>>      sk->sk_state = SMC_APPFINCLOSEWAIT;
>>>>> }
>>>>>
>>>>> Replace sock_set_flags or __set_bit to set_bit will fix this problem.
>>>>> Since set_bit is atomic.
>>>>>
>>>> I didn't really understand the scenario. What is
>>>> smc_cdc_rx_handler_rwwi()? What does it do? Don't it get the lock
>>>> during the runtime?
>>>>
>>>
>>> Hi Wenjia,
>>>
>>> Sorry for that, It is not smc_cdc_rx_handler_rwwi() but
>>> smc_cdc_rx_handler();
>>>
>>> Following is a more specific description of the issues
>>>
>>>
>>> lock_sock()
>>> __smc_release
>>>
>>> smc_cdc_rx_handler()
>>> smc_cdc_msg_recv()
>>> bh_lock_sock()
>>> smc_cdc_msg_recv_action()
>>> sock_set_flag(DONE) sock_set_flag(DEAD)
>>> __set_bit __set_bit
>>> bh_unlock_sock()
>>> release_sock()
>>>
>>>
>>>
>>> Note : |bh_lock_sock|and |lock_sock|are not mutually exclusive. They are
>>> actually used for different purposes and contexts.
>>>
>>>
>> ok, that's true that |bh_lock_sock|and |lock_sock|are not really mutually
>> exclusive. However, since bh_lock_sock() is used, this scenario you described
>> above should not happen, because that gets the sk_lock.slock. Following this
>> scenarios, IMO, only the following situation can happen.
>>
>> lock_sock()
>> __smc_release
>>
>> smc_cdc_rx_handler()
>> smc_cdc_msg_recv()
>> bh_lock_sock()
>> smc_cdc_msg_recv_action()
>> sock_set_flag(DONE)
>> bh_unlock_sock()
>> sock_set_flag(DEAD)
>> release_sock()
> 
> Hi wenjia,
> 
> I think I know what D. Wythe means now, and I think he is right on this.
> 
> IIUC, in process context, lock_sock() won't respect bh_lock_sock() if it
> acquires the lock before bh_lock_sock(). This is how the sock lock works.
> 
>      PROCESS CONTEXT                                 INTERRUPT CONTEXT
> ------------------------------------------------------------------------
> lock_sock()
>      spin_lock_bh(&sk->sk_lock.slock);
>      ...
>      sk->sk_lock.owned = 1;
>      // here the spinlock is released
>      spin_unlock_bh(&sk->sk_lock.slock);
> __smc_release()
>                                                     bh_lock_sock(&smc->sk);
>                                                     smc_cdc_msg_recv_action(smc, cdc);
>                                                         sock_set_flag(&smc->sk, SOCK_DONE);
>                                                     bh_unlock_sock(&smc->sk);
> 
>      sock_set_flag(DEAD)  <-- Can be before or after sock_set_flag(DONE)
> release_sock()
> 
> The bh_lock_sock() only spins on sk->sk_lock.slock, which is already released
> after lock_sock() return. Therefor, there is actually no lock between
> the code after lock_sock() and before release_sock() with bh_lock_sock()...bh_unlock_sock().
> Thus, sock_set_flag(DEAD) won't respect bh_lock_sock() at all, and might be
> before or after sock_set_flag(DONE).
> 
> 
> Actually, in TCP, the interrupt context will check sock_owned_by_user().
> If it returns true, the softirq just defer the process to backlog, and process
> that in release_sock(). Which avoid the race between softirq and process
> when visiting the 'struct sock'.
> 
> tcp_v4_rcv()
>           bh_lock_sock_nested(sk);
>           tcp_segs_in(tcp_sk(sk), skb);
>           ret = 0;
>           if (!sock_owned_by_user(sk)) {
>                   ret = tcp_v4_do_rcv(sk, skb);
>           } else {
>                   if (tcp_add_backlog(sk, skb, &drop_reason))
>                           goto discard_and_relse;
>           }
>           bh_unlock_sock(sk);
> 
> 
> But in SMC we don't have a backlog, that means fields in 'struct sock'
> might all have race, and this sock_set_flag() is just one of the cases.
> 
> Best regards,
> Dust
> 
I agree on your description above.
Sure, the following case 1) can also happen

case 1)
-------
  lock_sock()
  __smc_release

  sock_set_flag(DEAD)
  bh_lock_sock()
  smc_cdc_msg_recv_action()
  sock_set_flag(DONE)
  bh_unlock_sock()
  release_sock()

case 2)
-------
  lock_sock()
  __smc_release

  bh_lock_sock()
  smc_cdc_msg_recv_action()
  sock_set_flag(DONE) sock_set_flag(DEAD)
  __set_bit __set_bit
  bh_unlock_sock()
  release_sock()

My point here is that case2) can never happen. i.e that 
sock_set_flag(DONE) and sock_set_flag(DEAD) can not happen concurrently. 
Thus, how could
the atomic set help make sure that the Dead flag would not be 
overwritten with DONE?

Maybe I'm the only one who is getting stuck in the problem. I'll 
aprieciate if you can help me get out :P

Thanks,
Wenjia
> 
> 
>>
>>>
>>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>>> ---
>>>>>    net/smc/af_smc.c    | 4 ++--
>>>>>    net/smc/smc.h       | 5 +++++
>>>>>    net/smc/smc_cdc.c   | 2 +-
>>>>>    net/smc/smc_close.c | 2 +-
>>>>>    4 files changed, 9 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>>>> index bacdd97..5ad2a9f 100644
>>>>> --- a/net/smc/af_smc.c
>>>>> +++ b/net/smc/af_smc.c
>>>>> @@ -275,7 +275,7 @@ static int __smc_release(struct smc_sock *smc)
>>>>>          if (!smc->use_fallback) {
>>>>>            rc = smc_close_active(smc);
>>>>> -        sock_set_flag(sk, SOCK_DEAD);
>>>>> +        smc_sock_set_flag(sk, SOCK_DEAD);
>>>>>            sk->sk_shutdown |= SHUTDOWN_MASK;
>>>>>        } else {
>>>>>            if (sk->sk_state != SMC_CLOSED) {
>>>>> @@ -1742,7 +1742,7 @@ static int smc_clcsock_accept(struct
>>>>> smc_sock *lsmc, struct smc_sock **new_smc)
>>>>>            if (new_clcsock)
>>>>>                sock_release(new_clcsock);
>>>>>            new_sk->sk_state = SMC_CLOSED;
>>>>> -        sock_set_flag(new_sk, SOCK_DEAD);
>>>>> +        smc_sock_set_flag(new_sk, SOCK_DEAD);
>>>>>            sock_put(new_sk); /* final */
>>>>>            *new_smc = NULL;
>>>>>            goto out;
>>>>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>>>>> index 24745fd..e377980 100644
>>>>> --- a/net/smc/smc.h
>>>>> +++ b/net/smc/smc.h
>>>>> @@ -377,4 +377,9 @@ void smc_fill_gid_list(struct smc_link_group *lgr,
>>>>>    int smc_nl_enable_hs_limitation(struct sk_buff *skb, struct
>>>>> genl_info *info);
>>>>>    int smc_nl_disable_hs_limitation(struct sk_buff *skb, struct
>>>>> genl_info *info);
>>>>>    +static inline void smc_sock_set_flag(struct sock *sk, enum
>>>>> sock_flags flag)
>>>>> +{
>>>>> +    set_bit(flag, &sk->sk_flags);
>>>>> +}
>>>>> +
>>>>>    #endif    /* __SMC_H */
>>>>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>>>>> index 89105e9..01bdb79 100644
>>>>> --- a/net/smc/smc_cdc.c
>>>>> +++ b/net/smc/smc_cdc.c
>>>>> @@ -385,7 +385,7 @@ static void smc_cdc_msg_recv_action(struct
>>>>> smc_sock *smc,
>>>>>            smc->sk.sk_shutdown |= RCV_SHUTDOWN;
>>>>>            if (smc->clcsock && smc->clcsock->sk)
>>>>>                smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
>>>>> -        sock_set_flag(&smc->sk, SOCK_DONE);
>>>>> +        smc_sock_set_flag(&smc->sk, SOCK_DONE);
>>>>>            sock_hold(&smc->sk); /* sock_put in close_work */
>>>>>            if (!queue_work(smc_close_wq, &conn->close_work))
>>>>>                sock_put(&smc->sk);
>>>>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>>>>> index dbdf03e..449ef45 100644
>>>>> --- a/net/smc/smc_close.c
>>>>> +++ b/net/smc/smc_close.c
>>>>> @@ -173,7 +173,7 @@ void smc_close_active_abort(struct smc_sock *smc)
>>>>>            break;
>>>>>        }
>>>>>    -    sock_set_flag(sk, SOCK_DEAD);
>>>>> +    smc_sock_set_flag(sk, SOCK_DEAD);
>>>>>        sk->sk_state_change(sk);
>>>>>          if (release_clcsock) {
>>>
