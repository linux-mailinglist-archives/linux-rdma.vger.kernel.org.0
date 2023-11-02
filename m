Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38197DF3BE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347433AbjKBN2S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjKBN2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 09:28:17 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB4182;
        Thu,  2 Nov 2023 06:28:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvWC0w6_1698931688;
Received: from 30.221.148.226(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvWC0w6_1698931688)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 21:28:09 +0800
Message-ID: <1c5ac71a-4685-c962-cbe6-9d907bfcd4fa@linux.alibaba.com>
Date:   Thu, 2 Nov 2023 21:28:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v1 1/3] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1698904324-33238-1-git-send-email-alibuda@linux.alibaba.com>
 <1698904324-33238-2-git-send-email-alibuda@linux.alibaba.com>
 <72b57457-43e1-49f7-9670-08bbf03231e1@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <72b57457-43e1-49f7-9670-08bbf03231e1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/2/23 6:34 PM, Wenjia Zhang wrote:
>
>
> On 02.11.23 06:52, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> Considering scenario:
>>
>>                 smc_cdc_rx_handler
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
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>
> Fixes tag?

ops, i forget that. 🙁
I will fix it in next version.

Thanks.
D. Wythe
