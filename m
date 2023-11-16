Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A387EE021
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Nov 2023 12:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjKPLuO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Nov 2023 06:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLuN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Nov 2023 06:50:13 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB094B0;
        Thu, 16 Nov 2023 03:50:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VwWMTyL_1700135405;
Received: from 30.221.149.90(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VwWMTyL_1700135405)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 19:50:06 +0800
Message-ID: <a307f9c4-2c4c-3ed9-b2ce-5e74f3a5bbb1@linux.alibaba.com>
Date:   Thu, 16 Nov 2023 19:50:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, dust.li@linux.alibaba.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
 <20231113034457.GA121324@linux.alibaba.com>
 <17abf559-ec8b-47e9-b4e4-59adfbc6943b@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <17abf559-ec8b-47e9-b4e4-59adfbc6943b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/15/23 10:06 PM, Wenjia Zhang wrote:
>
>
> On 13.11.23 04:44, Dust Li wrote:
>> On Wed, Nov 08, 2023 at 05:48:29PM +0800, D. Wythe wrote:
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
>>> net/smc/af_smc.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index abd2667..5b91f55 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -599,7 +599,7 @@ static int smcr_clnt_conf_first_link(struct 
>>> smc_sock *smc)
>>>     int rc;
>>>
>>>     /* receive CONFIRM LINK request from server over RoCE fabric */
>>> -    qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
>>> +    qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
>>>                   SMC_LLC_CONFIRM_LINK);
>>
>> It may be difficult for people to understand why LLC_WAIT_TIME is
>> different, especially without any comments explaining its purpose.
>> People are required to use git to find the reason, which I believe is
>> not conducive to easy maintenance.
>>
>> Best regards,
>> Dust
>>
>>
> Good point! @D.Wythe, could you please try to add a simple commet to 
> explain it?
>

Also good to me, i will add comment to explain it.

D. Wythe

> Thanks,
> Wenjia
>>
>>>     if (!qentry) {
>>>         struct smc_clc_msg_decline dclc;
>>> -- 
>>> 1.8.3.1

