Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5A7EF2DF
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKQMnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 07:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMnL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 07:43:11 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FFD52;
        Fri, 17 Nov 2023 04:43:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwZqNA0_1700224983;
Received: from 192.168.50.70(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VwZqNA0_1700224983)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 20:43:04 +0800
Message-ID: <6ebbb7ab-f053-d212-6d88-7eb6754f12a6@linux.alibaba.com>
Date:   Fri, 17 Nov 2023 20:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v2] net/smc: avoid data corruption caused by decline
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1700197181-83136-1-git-send-email-alibuda@linux.alibaba.com>
 <7fe3a213-3d2e-42d5-b44b-bbd761a01bba@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <7fe3a213-3d2e-42d5-b44b-bbd761a01bba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/17/23 8:35 PM, Wenjia Zhang wrote:
>
>
> On 17.11.23 05:59, D. Wythe wrote:
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
>> client            server
>>        proposal
>>     ------------->
>>        accept
>>     <-------------
>>        confirm
>>     ------------->
>> wait confirm
>>
>>      failed llc confirm
>>         x------
>> (after 2s)timeout
>>             wait rsp
>>
>> wait decline
>>
>> (after 1s) timeout
>>             (after 2s) timeout
>>         decline
>>     -------------->
>>         decline
>>     <--------------
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
>
> Hi D.Wythe,
>
> I think you understood me wrong. I mean we don't need sysctl. I like 
> the first version more, where you just need to add some comments in 
> the code.
>

😅, ok that. I understood it with wrong way. I will resend the first 
version with comments.

> Thanks,
> Wenjia

