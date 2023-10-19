Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983587CF795
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbjJSLzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjJSLzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 07:55:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B46181;
        Thu, 19 Oct 2023 04:55:08 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JBqAqT010002;
        Thu, 19 Oct 2023 11:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VBMfmgr2DRZjPCUzJxycmqt7t+nomjAbdbpGtsI1RkY=;
 b=g36Vz7HcM2yYz6WGt23SjSM6Vhmsl9YHOQiC7hAoXv/1pD2Z1lHc5Snvsd97hwFDwB/n
 UfW5OnZQqLeCfKudhcoho0oLzPhLR99QB9v1vi2UBJnjVwHZPD35aKXUnFKVZvxnyp9G
 V4A8BcwB+Tl8tbnz56UiIVnMzNG9RFWFSLSLOc1DLMoBC5fonUwwSQh/UAerkyE0BmfF
 C9JcpQnnfrJbRwkWYEc7PKoVuuauhNLlqefoScZviZC1gcIcz/d16xsFUq421rpA8uTG
 CJ8ovXUfJnZvYOxdnLlEJrp+7hgAdYIt6TrbFVmd7+f+njNviUhODXtR3hoqRsNRwbSR VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu3kw0w2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 11:55:03 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JBcsFN010909;
        Thu, 19 Oct 2023 11:55:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu3kw0w20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 11:55:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39JBlbH5020486;
        Thu, 19 Oct 2023 11:55:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6angg1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 11:55:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39JBt10Q43254018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 11:55:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0731558056;
        Thu, 19 Oct 2023 11:55:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08F5C5804E;
        Thu, 19 Oct 2023 11:54:59 +0000 (GMT)
Received: from [9.171.58.92] (unknown [9.171.58.92])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Oct 2023 11:54:58 +0000 (GMT)
Message-ID: <613eb5b2-ce65-4b2e-82c3-2f8e7b942a74@linux.ibm.com>
Date:   Thu, 19 Oct 2023 13:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, dust.li@linux.alibaba.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
 <e63b546f-b993-4e42-8269-e4d9afa5b845@linux.ibm.com>
 <f8089b26-bb11-f82d-8070-222b1f8c1db1@linux.alibaba.com>
 <745d3174-f497-4d6a-ba13-1074128ad99d@linux.ibm.com>
 <20231013053214.GT92403@linux.alibaba.com>
 <6666db42-a4de-425e-a96d-bfa899ab265e@linux.ibm.com>
 <20231013122729.GU92403@linux.alibaba.com>
 <2eabf3fb-9613-1b96-3ce9-993f94ef081d@linux.alibaba.com>
 <2a72918a-2782-4d21-be50-2c3931957f16@linux.ibm.com>
 <4065e94f-f7ea-7943-e2cc-0c7d3f9c788b@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <4065e94f-f7ea-7943-e2cc-0c7d3f9c788b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ibME3-b-G0-mOfj3NfFz9iDHGVBr72TL
X-Proofpoint-ORIG-GUID: F2EjFCofqIhySABWs5db7u2hc0M7Mxet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 19.10.23 10:09, D. Wythe wrote:
> 
> 
> On 10/18/23 1:03 AM, Wenjia Zhang wrote:
>>
>>
>> On 17.10.23 04:00, D. Wythe wrote:
>>>
>>>
>>> On 10/13/23 8:27 PM, Dust Li wrote:
>>>> On Fri, Oct 13, 2023 at 01:52:09PM +0200, Wenjia Zhang wrote:
>>>>>
>>>>> On 13.10.23 07:32, Dust Li wrote:
>>>>>> On Thu, Oct 12, 2023 at 01:51:54PM +0200, Wenjia Zhang wrote:
>>>>>>>
>>>>>>> On 12.10.23 04:37, D. Wythe wrote:
>>>>>>>>
>>>>>>>> On 10/12/23 4:31 AM, Wenjia Zhang wrote:
>>>>>>>>>
>>>>>>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>>>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>>>>>
>>>>>>>>>> Considering scenario:
>>>>>>>>>>
>>>>>>>>>>                   smc_cdc_rx_handler_rwwi
>>>>>>>>>> __smc_release
>>>>>>>>>>                   sock_set_flag
>>>>>>>>>> smc_close_active()
>>>>>>>>>> sock_set_flag
>>>>>>>>>>
>>>>>>>>>> __set_bit(DEAD)            __set_bit(DONE)
>>>>>>>>>>
>>>>>>>>>> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
>>>>>>>>>> if the DEAD flag lost, the state SMC_CLOSED  will be never be 
>>>>>>>>>> reached
>>>>>>>>>> in smc_close_passive_work:
>>>>>>>>>>
>>>>>>>>>> if (sock_flag(sk, SOCK_DEAD) &&
>>>>>>>>>>       smc_close_sent_any_close(conn)) {
>>>>>>>>>>       sk->sk_state = SMC_CLOSED;
>>>>>>>>>> } else {
>>>>>>>>>>       /* just shutdown, but not yet closed locally */
>>>>>>>>>>       sk->sk_state = SMC_APPFINCLOSEWAIT;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> Replace sock_set_flags or __set_bit to set_bit will fix this 
>>>>>>>>>> problem.
>>>>>>>>>> Since set_bit is atomic.
>>>>>>>>>>
>>>>>>>>> I didn't really understand the scenario. What is
>>>>>>>>> smc_cdc_rx_handler_rwwi()? What does it do? Don't it get the lock
>>>>>>>>> during the runtime?
>>>>>>>>>
>>>>>>>> Hi Wenjia,
>>>>>>>>
>>>>>>>> Sorry for that, It is not smc_cdc_rx_handler_rwwi() but
>>>>>>>> smc_cdc_rx_handler();
>>>>>>>>
>>>>>>>> Following is a more specific description of the issues
>>>>>>>>
>>>>>>>>
>>>>>>>> lock_sock()
>>>>>>>> __smc_release
>>>>>>>>
>>>>>>>> smc_cdc_rx_handler()
>>>>>>>> smc_cdc_msg_recv()
>>>>>>>> bh_lock_sock()
>>>>>>>> smc_cdc_msg_recv_action()
>>>>>>>> sock_set_flag(DONE) sock_set_flag(DEAD)
>>>>>>>> __set_bit __set_bit
>>>>>>>> bh_unlock_sock()
>>>>>>>> release_sock()
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Note : |bh_lock_sock|and |lock_sock|are not mutually exclusive. 
>>>>>>>> They are
>>>>>>>> actually used for different purposes and contexts.
>>>>>>>>
>>>>>>>>
>>>>>>> ok, that's true that |bh_lock_sock|and |lock_sock|are not really 
>>>>>>> mutually
>>>>>>> exclusive. However, since bh_lock_sock() is used, this scenario 
>>>>>>> you described
>>>>>>> above should not happen, because that gets the sk_lock.slock. 
>>>>>>> Following this
>>>>>>> scenarios, IMO, only the following situation can happen.
>>>>>>>
>>>>>>> lock_sock()
>>>>>>> __smc_release
>>>>>>>
>>>>>>> smc_cdc_rx_handler()
>>>>>>> smc_cdc_msg_recv()
>>>>>>> bh_lock_sock()
>>>>>>> smc_cdc_msg_recv_action()
>>>>>>> sock_set_flag(DONE)
>>>>>>> bh_unlock_sock()
>>>>>>> sock_set_flag(DEAD)
>>>>>>> release_sock()
>>>>>> Hi wenjia,
>>>>>>
>>>>>> I think I know what D. Wythe means now, and I think he is right on 
>>>>>> this.
>>>>>>
>>>>>> IIUC, in process context, lock_sock() won't respect bh_lock_sock() 
>>>>>> if it
>>>>>> acquires the lock before bh_lock_sock(). This is how the sock lock 
>>>>>> works.
>>>>>>
>>>>>>       PROCESS CONTEXT INTERRUPT CONTEXT
>>>>>> ------------------------------------------------------------------------
>>>>>> lock_sock()
>>>>>>       spin_lock_bh(&sk->sk_lock.slock);
>>>>>>       ...
>>>>>>       sk->sk_lock.owned = 1;
>>>>>>       // here the spinlock is released
>>>>>>       spin_unlock_bh(&sk->sk_lock.slock);
>>>>>> __smc_release()
>>>>>> bh_lock_sock(&smc->sk);
>>>>>> smc_cdc_msg_recv_action(smc, cdc);
>>>>>> sock_set_flag(&smc->sk, SOCK_DONE);
>>>>>> bh_unlock_sock(&smc->sk);
>>>>>>
>>>>>>       sock_set_flag(DEAD)  <-- Can be before or after 
>>>>>> sock_set_flag(DONE)
>>>>>> release_sock()
>>>>>>
>>>>>> The bh_lock_sock() only spins on sk->sk_lock.slock, which is 
>>>>>> already released
>>>>>> after lock_sock() return. Therefor, there is actually no lock between
>>>>>> the code after lock_sock() and before release_sock() with 
>>>>>> bh_lock_sock()...bh_unlock_sock().
>>>>>> Thus, sock_set_flag(DEAD) won't respect bh_lock_sock() at all, and 
>>>>>> might be
>>>>>> before or after sock_set_flag(DONE).
>>>>>>
>>>>>>
>>>>>> Actually, in TCP, the interrupt context will check 
>>>>>> sock_owned_by_user().
>>>>>> If it returns true, the softirq just defer the process to backlog, 
>>>>>> and process
>>>>>> that in release_sock(). Which avoid the race between softirq and 
>>>>>> process
>>>>>> when visiting the 'struct sock'.
>>>>>>
>>>>>> tcp_v4_rcv()
>>>>>>            bh_lock_sock_nested(sk);
>>>>>>            tcp_segs_in(tcp_sk(sk), skb);
>>>>>>            ret = 0;
>>>>>>            if (!sock_owned_by_user(sk)) {
>>>>>>                    ret = tcp_v4_do_rcv(sk, skb);
>>>>>>            } else {
>>>>>>                    if (tcp_add_backlog(sk, skb, &drop_reason))
>>>>>>                            goto discard_and_relse;
>>>>>>            }
>>>>>>            bh_unlock_sock(sk);
>>>>>>
>>>>>>
>>>>>> But in SMC we don't have a backlog, that means fields in 'struct 
>>>>>> sock'
>>>>>> might all have race, and this sock_set_flag() is just one of the 
>>>>>> cases.
>>>>>>
>>>>>> Best regards,
>>>>>> Dust
>>>>>>
>>>>> I agree on your description above.
>>>>> Sure, the following case 1) can also happen
>>>>>
>>>>> case 1)
>>>>> -------
>>>>> lock_sock()
>>>>> __smc_release
>>>>>
>>>>> sock_set_flag(DEAD)
>>>>> bh_lock_sock()
>>>>> smc_cdc_msg_recv_action()
>>>>> sock_set_flag(DONE)
>>>>> bh_unlock_sock()
>>>>> release_sock()
>>>>>
>>>>> case 2)
>>>>> -------
>>>>> lock_sock()
>>>>> __smc_release
>>>>>
>>>>> bh_lock_sock()
>>>>> smc_cdc_msg_recv_action()
>>>>> sock_set_flag(DONE) sock_set_flag(DEAD)
>>>>> __set_bit __set_bit
>>>>> bh_unlock_sock()
>>>>> release_sock()
>>>>>
>>>>> My point here is that case2) can never happen. i.e that 
>>>>> sock_set_flag(DONE)
>>>>> and sock_set_flag(DEAD) can not happen concurrently. Thus, how could
>>>>> the atomic set help make sure that the Dead flag would not be 
>>>>> overwritten
>>>>> with DONE?
>>>> I agree with you on this. I also don't see using atomic can
>>>> solve the problem of overwriting the DEAD flag with DONE.
>>>>
>>>> I think we need some mechanisms to ensure that sk_flags and other
>>>> struct sock related fields are not modified simultaneously.
>>>>
>>>> Best regards,
>>>> Dust
>>>
>>> It seems that everyone has agrees on that case 2 is impossible. I'm a 
>>> bit confused, why that
>>> sock_set_flag(DONE) and sock_set_flag(DEAD) can not happen 
>>> concurrently. What mechanism
>>> prevents their parallel execution?
>>>
>>> Best wishes,
>>> D. Wythe
>>>
>>>>
>>>
>> In the smc_cdc_rx_handler(), if bh_lock_sock() is got, how could the 
>> sock_set_flag(DEAD) in the __smc_release() modify the flag 
>> concurrently? As I said, that could be just kind of lapse of my 
>> thought, but I still want to make it clarify.
> 
> #define bh_lock_sock(__sk) spin_lock(&((__sk)->sk_lock.slock))
> 
> static inline void lock_sock(struct sock *sk)
> {
>      lock_sock_nested(sk, 0);
> }
> 
> void lock_sock_nested(struct sock *sk, int subclass)
> {
>      might_sleep();
> spin_lock_bh(&sk->sk_lock.slock);
>      if (sk->sk_lock.owned)
>          __lock_sock(sk);
>      sk->sk_lock.owned = 1;
> 
> */spin_unlock(&sk->sk_lock.slock);/*
>      /*
>       * The sk_lock has mutex_lock() semantics here:
>       */
>      mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
>      local_bh_enable();
> }
> 
> 
> It seems that you believe bh_lock_sock() will block the execution of 
> __smc_release(), indicating that you think the spin on slock will block 
> the execution of __smc_release().
> So, you assume that __smc_release() must also spin on slock, right?
> 
That is right what I mean.

> However, lock_sock() releases the slock before returning. You can see it 
> in code above. In other words, __smc_release() will not spin on slock.
> This means that bh_lock_sock() will not block the execution of 
> __smc_release().
> 
Do you mean that the spin_unlock you marked in the code above is to 
release the socket spin lock from __smc_release()?

> Hoping this will helps
> 
> Best wishes,
> D. Wythe
> 
> 
> 
> 
> 
