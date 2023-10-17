Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C57CB834
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 04:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJQCAh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 22:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQCAg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 22:00:36 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9725B0;
        Mon, 16 Oct 2023 19:00:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VuL.VIA_1697508029;
Received: from 30.221.149.45(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VuL.VIA_1697508029)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 10:00:30 +0800
Message-ID: <2eabf3fb-9613-1b96-3ce9-993f94ef081d@linux.alibaba.com>
Date:   Tue, 17 Oct 2023 10:00:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 1/5] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-US
To:     dust.li@linux.alibaba.com, Wenjia Zhang <wenjia@linux.ibm.com>,
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
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231013122729.GU92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/13/23 8:27 PM, Dust Li wrote:
> On Fri, Oct 13, 2023 at 01:52:09PM +0200, Wenjia Zhang wrote:
>>
>> On 13.10.23 07:32, Dust Li wrote:
>>> On Thu, Oct 12, 2023 at 01:51:54PM +0200, Wenjia Zhang wrote:
>>>>
>>>> On 12.10.23 04:37, D. Wythe wrote:
>>>>>
>>>>> On 10/12/23 4:31 AM, Wenjia Zhang wrote:
>>>>>>
>>>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>>
>>>>>>> Considering scenario:
>>>>>>>
>>>>>>>                   smc_cdc_rx_handler_rwwi
>>>>>>> __smc_release
>>>>>>>                   sock_set_flag
>>>>>>> smc_close_active()
>>>>>>> sock_set_flag
>>>>>>>
>>>>>>> __set_bit(DEAD)            __set_bit(DONE)
>>>>>>>
>>>>>>> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
>>>>>>> if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
>>>>>>> in smc_close_passive_work:
>>>>>>>
>>>>>>> if (sock_flag(sk, SOCK_DEAD) &&
>>>>>>>       smc_close_sent_any_close(conn)) {
>>>>>>>       sk->sk_state = SMC_CLOSED;
>>>>>>> } else {
>>>>>>>       /* just shutdown, but not yet closed locally */
>>>>>>>       sk->sk_state = SMC_APPFINCLOSEWAIT;
>>>>>>> }
>>>>>>>
>>>>>>> Replace sock_set_flags or __set_bit to set_bit will fix this problem.
>>>>>>> Since set_bit is atomic.
>>>>>>>
>>>>>> I didn't really understand the scenario. What is
>>>>>> smc_cdc_rx_handler_rwwi()? What does it do? Don't it get the lock
>>>>>> during the runtime?
>>>>>>
>>>>> Hi Wenjia,
>>>>>
>>>>> Sorry for that, It is not smc_cdc_rx_handler_rwwi() but
>>>>> smc_cdc_rx_handler();
>>>>>
>>>>> Following is a more specific description of the issues
>>>>>
>>>>>
>>>>> lock_sock()
>>>>> __smc_release
>>>>>
>>>>> smc_cdc_rx_handler()
>>>>> smc_cdc_msg_recv()
>>>>> bh_lock_sock()
>>>>> smc_cdc_msg_recv_action()
>>>>> sock_set_flag(DONE) sock_set_flag(DEAD)
>>>>> __set_bit __set_bit
>>>>> bh_unlock_sock()
>>>>> release_sock()
>>>>>
>>>>>
>>>>>
>>>>> Note : |bh_lock_sock|and |lock_sock|are not mutually exclusive. They are
>>>>> actually used for different purposes and contexts.
>>>>>
>>>>>
>>>> ok, that's true that |bh_lock_sock|and |lock_sock|are not really mutually
>>>> exclusive. However, since bh_lock_sock() is used, this scenario you described
>>>> above should not happen, because that gets the sk_lock.slock. Following this
>>>> scenarios, IMO, only the following situation can happen.
>>>>
>>>> lock_sock()
>>>> __smc_release
>>>>
>>>> smc_cdc_rx_handler()
>>>> smc_cdc_msg_recv()
>>>> bh_lock_sock()
>>>> smc_cdc_msg_recv_action()
>>>> sock_set_flag(DONE)
>>>> bh_unlock_sock()
>>>> sock_set_flag(DEAD)
>>>> release_sock()
>>> Hi wenjia,
>>>
>>> I think I know what D. Wythe means now, and I think he is right on this.
>>>
>>> IIUC, in process context, lock_sock() won't respect bh_lock_sock() if it
>>> acquires the lock before bh_lock_sock(). This is how the sock lock works.
>>>
>>>       PROCESS CONTEXT                                 INTERRUPT CONTEXT
>>> ------------------------------------------------------------------------
>>> lock_sock()
>>>       spin_lock_bh(&sk->sk_lock.slock);
>>>       ...
>>>       sk->sk_lock.owned = 1;
>>>       // here the spinlock is released
>>>       spin_unlock_bh(&sk->sk_lock.slock);
>>> __smc_release()
>>>                                                      bh_lock_sock(&smc->sk);
>>>                                                      smc_cdc_msg_recv_action(smc, cdc);
>>>                                                          sock_set_flag(&smc->sk, SOCK_DONE);
>>>                                                      bh_unlock_sock(&smc->sk);
>>>
>>>       sock_set_flag(DEAD)  <-- Can be before or after sock_set_flag(DONE)
>>> release_sock()
>>>
>>> The bh_lock_sock() only spins on sk->sk_lock.slock, which is already released
>>> after lock_sock() return. Therefor, there is actually no lock between
>>> the code after lock_sock() and before release_sock() with bh_lock_sock()...bh_unlock_sock().
>>> Thus, sock_set_flag(DEAD) won't respect bh_lock_sock() at all, and might be
>>> before or after sock_set_flag(DONE).
>>>
>>>
>>> Actually, in TCP, the interrupt context will check sock_owned_by_user().
>>> If it returns true, the softirq just defer the process to backlog, and process
>>> that in release_sock(). Which avoid the race between softirq and process
>>> when visiting the 'struct sock'.
>>>
>>> tcp_v4_rcv()
>>>            bh_lock_sock_nested(sk);
>>>            tcp_segs_in(tcp_sk(sk), skb);
>>>            ret = 0;
>>>            if (!sock_owned_by_user(sk)) {
>>>                    ret = tcp_v4_do_rcv(sk, skb);
>>>            } else {
>>>                    if (tcp_add_backlog(sk, skb, &drop_reason))
>>>                            goto discard_and_relse;
>>>            }
>>>            bh_unlock_sock(sk);
>>>
>>>
>>> But in SMC we don't have a backlog, that means fields in 'struct sock'
>>> might all have race, and this sock_set_flag() is just one of the cases.
>>>
>>> Best regards,
>>> Dust
>>>
>> I agree on your description above.
>> Sure, the following case 1) can also happen
>>
>> case 1)
>> -------
>> lock_sock()
>> __smc_release
>>
>> sock_set_flag(DEAD)
>> bh_lock_sock()
>> smc_cdc_msg_recv_action()
>> sock_set_flag(DONE)
>> bh_unlock_sock()
>> release_sock()
>>
>> case 2)
>> -------
>> lock_sock()
>> __smc_release
>>
>> bh_lock_sock()
>> smc_cdc_msg_recv_action()
>> sock_set_flag(DONE) sock_set_flag(DEAD)
>> __set_bit __set_bit
>> bh_unlock_sock()
>> release_sock()
>>
>> My point here is that case2) can never happen. i.e that sock_set_flag(DONE)
>> and sock_set_flag(DEAD) can not happen concurrently. Thus, how could
>> the atomic set help make sure that the Dead flag would not be overwritten
>> with DONE?
> I agree with you on this. I also don't see using atomic can
> solve the problem of overwriting the DEAD flag with DONE.
>
> I think we need some mechanisms to ensure that sk_flags and other
> struct sock related fields are not modified simultaneously.
>
> Best regards,
> Dust

It seems that everyone has agrees on that case 2 is impossible. I'm a 
bit confused, why that
sock_set_flag(DONE) and sock_set_flag(DEAD) can not happen concurrently. 
What mechanism
prevents their parallel execution?

Best wishes,
D. Wythe

>

