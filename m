Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B47E953D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 03:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjKMCuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Nov 2023 21:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjKMCuN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Nov 2023 21:50:13 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828610E;
        Sun, 12 Nov 2023 18:50:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VwBTFXs_1699843805;
Received: from 30.221.147.142(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VwBTFXs_1699843805)
          by smtp.aliyun-inc.com;
          Mon, 13 Nov 2023 10:50:06 +0800
Message-ID: <3f3080e2-cb2c-16f4-02b1-ca17394d2813@linux.alibaba.com>
Date:   Mon, 13 Nov 2023 10:50:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
Content-Language: en-US
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
 <05c29431-c941-45d1-8e14-0527accc3993@linux.ibm.com>
 <b3ce2dfe-ece9-919b-024d-051cd66609ed@linux.alibaba.com>
In-Reply-To: <b3ce2dfe-ece9-919b-024d-051cd66609ed@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/10/23 10:51 AM, D. Wythe wrote:
>
>
> On 11/8/23 9:00 PM, Wenjia Zhang wrote:
>>
>>
>> On 08.11.23 10:48, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> We found a data corruption issue during testing of SMC-R on Redis
>>> applications.
>>>
>>> The benchmark has a low probability of reporting a strange error as
>>> shown below.
>>>
>>> "Error: Protocol error, got "\xe2" as reply type byte"
>>>
>>> Finally, we found that the retrieved error data was as follows:
>>>
>>> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
>>> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
>>>
>>> It is quite obvious that this is a SMC DECLINE message, which means 
>>> that
>>> the applications received SMC protocol message.
>>> We found that this was caused by the following situations:
>>>
>>> client            server
>>>        proposal
>>>     ------------->
>>>        accept
>>>     <-------------
>>>        confirm
>>>     ------------->
>>> wait confirm
>>>
>>>      failed llc confirm
>>>         x------
>>> (after 2s)timeout
>>>             wait rsp
>>>
>>> wait decline
>>>
>>> (after 1s) timeout
>>>             (after 2s) timeout
>>>         decline
>>>     -------------->
>>>         decline
>>>     <--------------
>>>
>>> As a result, a decline message was sent in the implementation, and this
>>> message was read from TCP by the already-fallback connection.
>>>
>>> This patch double the client timeout as 2x of the server value,
>>> With this simple change, the Decline messages should never cross or
>>> collide (during Confirm link timeout).
>>>
>>> This issue requires an immediate solution, since the protocol updates
>>> involve a more long-term solution.
>>>
>>> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC 
>>> flow")
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> ---
>>>   net/smc/af_smc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index abd2667..5b91f55 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -599,7 +599,7 @@ static int smcr_clnt_conf_first_link(struct 
>>> smc_sock *smc)
>>>       int rc;
>>>         /* receive CONFIRM LINK request from server over RoCE fabric */
>>> -    qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
>>> +    qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
>>>                     SMC_LLC_CONFIRM_LINK);
>>>       if (!qentry) {
>>>           struct smc_clc_msg_decline dclc;
>> I'm wondering if the double time (if sufficient) of timeout could be 
>> for waiting for CLC_DECLINE on the client's side. i.e.
>>
>
> It depends. We can indeed introduce a sysctl to allow server to 
> manager their Confirm Link timeout,
> but if there will be protocol updates, this introduction will no 
> longer be necessary, and we will
> have to maintain it continuously.
>
> I believe the core of the solution is to ensure that decline messages 
> never cross or collide. Increasing
> the client's timeout by twice as much as the server's timeout can 
> temporarily solve this problem.
> If Jerry's proposed protocol updates are too complex or if there won't 
> be any future protocol updates,
> it's still not late to let server manager their Confirm Link timeout then.
>
> Best wishes,
> D. Wythe
>

FYI:

It seems that my email was not successfully delivered due to some 
reasons. Sorry
for that.

D. Wythe


>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 35ddebae8894..9b1feef1013d 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -605,7 +605,7 @@ static int smcr_clnt_conf_first_link(struct 
>> smc_sock *smc)
>>                 struct smc_clc_msg_decline dclc;
>>
>>                 rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
>> -                                     SMC_CLC_DECLINE, 
>> CLC_WAIT_TIME_SHORT);
>> +                                     SMC_CLC_DECLINE, 2 * 
>> CLC_WAIT_TIME_SHORT);
>>                 return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
>>         }
>>         smc_llc_save_peer_uid(qentry);
>>
>> Because the purpose is to let the server have the control to deline.
>

