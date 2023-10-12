Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED77C6300
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 04:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjJLCrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 22:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJLCrO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 22:47:14 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56515A9;
        Wed, 11 Oct 2023 19:47:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vtyo4xT_1697078827;
Received: from 30.221.149.75(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vtyo4xT_1697078827)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:47:08 +0800
Message-ID: <0490cd90-1ec9-9d10-90fc-8fd0cf4a1a9c@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 10:47:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 1/5] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
 <e63b546f-b993-4e42-8269-e4d9afa5b845@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <e63b546f-b993-4e42-8269-e4d9afa5b845@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/12/23 4:31 AM, Wenjia Zhang wrote:
>
>
> On 11.10.23 09:33, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> Considering scenario:
>>
>>                 smc_cdc_rx_handler_rwwi
>> __smc_release
>>                 sock_set_flag
>> smc_close_active()
>> sock_set_flag
>>
>> __set_bit(DEAD)            __set_bit(DONE)
>>
>> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
>> if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
>> in smc_close_passive_work:
>>
>> if (sock_flag(sk, SOCK_DEAD) &&
>>     smc_close_sent_any_close(conn)) {
>>     sk->sk_state = SMC_CLOSED;
>> } else {
>>     /* just shutdown, but not yet closed locally */
>>     sk->sk_state = SMC_APPFINCLOSEWAIT;
>> }
>>
>> Replace sock_set_flags or __set_bit to set_bit will fix this problem.
>> Since set_bit is atomic.
>>
> I didn't really understand the scenario. What is 
> smc_cdc_rx_handler_rwwi()? What does it do? Don't it get the lock 
> during the runtime?
>

Hi Wenjia,

Sorry for that, It is not smc_cdc_rx_handler_rwwi() but 
smc_cdc_rx_handler();

Following is a more specific description of the issues


lock_sock()
__smc_release

smc_cdc_rx_handler()
smc_cdc_msg_recv()
bh_lock_sock()
smc_cdc_msg_recv_action()
sock_set_flag(DONE) sock_set_flag(DEAD)
__set_bit __set_bit
bh_unlock_sock()
release_sock()


Note :  bh_lock_sock and lock_sock are not mutually exclusive.
They are actually used for different purposes and contexts.


>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c    | 4 ++--
>>   net/smc/smc.h       | 5 +++++
>>   net/smc/smc_cdc.c   | 2 +-
>>   net/smc/smc_close.c | 2 +-
>>   4 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index bacdd97..5ad2a9f 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -275,7 +275,7 @@ static int __smc_release(struct smc_sock *smc)
>>         if (!smc->use_fallback) {
>>           rc = smc_close_active(smc);
>> -        sock_set_flag(sk, SOCK_DEAD);
>> +        smc_sock_set_flag(sk, SOCK_DEAD);
>>           sk->sk_shutdown |= SHUTDOWN_MASK;
>>       } else {
>>           if (sk->sk_state != SMC_CLOSED) {
>> @@ -1742,7 +1742,7 @@ static int smc_clcsock_accept(struct smc_sock 
>> *lsmc, struct smc_sock **new_smc)
>>           if (new_clcsock)
>>               sock_release(new_clcsock);
>>           new_sk->sk_state = SMC_CLOSED;
>> -        sock_set_flag(new_sk, SOCK_DEAD);
>> +        smc_sock_set_flag(new_sk, SOCK_DEAD);
>>           sock_put(new_sk); /* final */
>>           *new_smc = NULL;
>>           goto out;
>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>> index 24745fd..e377980 100644
>> --- a/net/smc/smc.h
>> +++ b/net/smc/smc.h
>> @@ -377,4 +377,9 @@ void smc_fill_gid_list(struct smc_link_group *lgr,
>>   int smc_nl_enable_hs_limitation(struct sk_buff *skb, struct 
>> genl_info *info);
>>   int smc_nl_disable_hs_limitation(struct sk_buff *skb, struct 
>> genl_info *info);
>>   +static inline void smc_sock_set_flag(struct sock *sk, enum 
>> sock_flags flag)
>> +{
>> +    set_bit(flag, &sk->sk_flags);
>> +}
>> +
>>   #endif    /* __SMC_H */
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 89105e9..01bdb79 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -385,7 +385,7 @@ static void smc_cdc_msg_recv_action(struct 
>> smc_sock *smc,
>>           smc->sk.sk_shutdown |= RCV_SHUTDOWN;
>>           if (smc->clcsock && smc->clcsock->sk)
>>               smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
>> -        sock_set_flag(&smc->sk, SOCK_DONE);
>> +        smc_sock_set_flag(&smc->sk, SOCK_DONE);
>>           sock_hold(&smc->sk); /* sock_put in close_work */
>>           if (!queue_work(smc_close_wq, &conn->close_work))
>>               sock_put(&smc->sk);
>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>> index dbdf03e..449ef45 100644
>> --- a/net/smc/smc_close.c
>> +++ b/net/smc/smc_close.c
>> @@ -173,7 +173,7 @@ void smc_close_active_abort(struct smc_sock *smc)
>>           break;
>>       }
>>   -    sock_set_flag(sk, SOCK_DEAD);
>> +    smc_sock_set_flag(sk, SOCK_DEAD);
>>       sk->sk_state_change(sk);
>>         if (release_clcsock) {

