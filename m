Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC07AD358
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjIYIaI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjIYIaH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 04:30:07 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB58C4;
        Mon, 25 Sep 2023 01:29:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VsoSBCa_1695630596;
Received: from 30.221.144.144(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VsoSBCa_1695630596)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 16:29:57 +0800
Message-ID: <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
Date:   Mon, 25 Sep 2023 16:29:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/22/23 7:59 AM, Wenjia Zhang wrote:
>
>
> On 20.09.23 14:08, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> Consider the following scenarios:
>>
>> smc_release
>>     smc_close_active
>> write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
>>         smc->clcsock->sk->sk_user_data = NULL;
>> write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
>>
>> smc_tcp_syn_recv_sock
>>     smc = smc_clcsock_user_data(sk);
>>     /* now */
>>     /* smc == NULL */
>>
>> Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
>> since we only unset sk_user_data during smc_release, it's safe to
>> drop the incoming tcp reqsock.
>>
>> Fixes:  ("net/smc: net/smc: Limit backlog connections"
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index bacdd97..b4acf47 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const 
>> struct sock *sk,
>>       struct sock *child;
>>         smc = smc_clcsock_user_data(sk);
>> +    if (unlikely(!smc))
>> +        goto drop;
>>         if (READ_ONCE(sk->sk_ack_backlog) + 
>> atomic_read(&smc->queued_smc_hs) >
>>                   sk->sk_max_ack_backlog)

Hi Wenjia,

>
> this is unfortunately not sufficient for this fix. You have to make 
> sure that is not a life-time problem. Even so, READ_ONCE() is also 
> needed in this case.
>

Life-time problem? If you means the smc will still be NULL in the 
future,  I don't really think so, smc is a local variable assigned by 
smc_clcsock_user_data.
it's either NULL or a valid and unchanged value.

And READ_ONCE() is needed indeed, considering not make too much change, 
maybe we can protected following

smc = smc_clcsock_user_data(sk);

with sk_callback_lock， which solves the same problem. What do you think?

Best Wishes
D. Wythe










