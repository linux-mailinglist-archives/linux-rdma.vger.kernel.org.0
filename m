Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DACE7F0F80
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjKTJzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 04:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTJza (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 04:55:30 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E638F;
        Mon, 20 Nov 2023 01:55:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwlOS3s_1700474122;
Received: from 30.221.149.11(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VwlOS3s_1700474122)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 17:55:23 +0800
Message-ID: <ccf3e279-b9d2-5bd1-b033-8071471720e0@linux.alibaba.com>
Date:   Mon, 20 Nov 2023 17:55:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v3] net/smc: avoid data corruption caused by decline
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1700407699-97350-1-git-send-email-alibuda@linux.alibaba.com>
 <2322494c-15c1-8f08-7856-5c965daa12ae@linux.alibaba.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <2322494c-15c1-8f08-7856-5c965daa12ae@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/20/23 11:37 AM, Wen Gu wrote:
>
>
> On 2023/11/19 23:28, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> We found a data corruption issue during testing of SMC-R on Redis
>> applications.
>>
>> The benchmark has a low probability of reporting a strange error as
>> shown below.
>>
>> "Error: Protocol error, got "\xe2" as reply type byte"
>>
>> Finally, we found that the retrieved error data was as follows:
>>
>> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
>> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
>>
>> It is quite obvious that this is a SMC DECLINE message, which means that
>> the applications received SMC protocol message.
>> We found that this was caused by the following situations:
>>
>> client                  server
>>          ¦  proposal
>>          ------------->
>>          ¦  accept
>>          <-------------
>>          ¦  confirm
>>          ------------->
>> wait confirm
>
> I think there may be an ambiguity here, better for 'wait for llc 
> confirm link'.
> Could you please add 'clc' and 'llc' prefix to distinguish flows on 
> the diagram?
>

Looks Reasonable. I'll make changes in the next revision.

D. Wythe

> Thanks.
>
>>
>>          ¦failed llc confirm
>>          ¦   x------
>> (after 2s)timeout
>>                          wait rsp
>>
>> wait decline
>>
>> (after 1s) timeout
>>                          (after 2s) timeout
>>          ¦   decline
>>          -------------->
>>          ¦   decline
>>          <--------------
>>
>> As a result, a decline message was sent in the implementation, and this
>> message was read from TCP by the already-fallback connection.
>>
>> This patch double the client timeout as 2x of the server value,
>> With this simple change, the Decline messages should never cross or
>> collide (during Confirm link timeout).
>>
>> This issue requires an immediate solution, since the protocol updates
>> involve a more long-term solution.
>>
>> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC 
>> flow")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>
>
>> ---
>>   net/smc/af_smc.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index abd2667..8615cc0 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -598,8 +598,12 @@ static int smcr_clnt_conf_first_link(struct 
>> smc_sock *smc)
>>       struct smc_llc_qentry *qentry;
>>       int rc;
>>   -    /* receive CONFIRM LINK request from server over RoCE fabric */
>> -    qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
>> +    /* Receive CONFIRM LINK request from server over RoCE fabric.
>> +     * Increasing the client's timeout by twice as much as the server's
>> +     * timeout by default can temporarily avoid decline messages of
>> +     * both sides crossing or colliding
>> +     */
>> +    qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
>>                     SMC_LLC_CONFIRM_LINK);
>>       if (!qentry) {
>>           struct smc_clc_msg_decline dclc;

