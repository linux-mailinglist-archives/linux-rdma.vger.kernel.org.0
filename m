Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1A7AD588
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjIYKLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 06:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjIYKLE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 06:11:04 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3759E1B8;
        Mon, 25 Sep 2023 03:10:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VsqfW0y_1695636647;
Received: from 30.221.144.144(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VsqfW0y_1695636647)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 18:10:48 +0800
Message-ID: <a3e80a67-e8b8-ce94-fc11-254d056d37a9@linux.alibaba.com>
Date:   Mon, 25 Sep 2023 18:10:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC net-next 0/2] Optimize the parallelism of SMC-R connections
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
 <794f9f68-4671-5e5e-45e4-2c8a4de568b3@linux.ibm.com>
 <522d823c-b656-ffb5-bcce-65b96bdfa46d@linux.alibaba.com>
 <c0ba8e0b-f2b2-b65b-e21a-54c3d920ba72@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <c0ba8e0b-f2b2-b65b-e21a-54c3d920ba72@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/21/23 8:36 PM, Alexandra Winter wrote:
> On 18.09.23 05:58, D. Wythe wrote:
>> Hi Alexandra,
>>
>> Sorry for the late reply. I have been thinking about the question you mentioned for a while, and this is a great opportunity to discuss this issue.
>> My point is that the purpose of the locks is to minimize the expansion of the number of link groups as much as possible.
>>
>> As we all know, the SMC-R protocol has the following specifications:
>>
>>   * A SMC-R connection MUST be mapped into one link group.
>>   * A link group is usually created by a connection, which is also known
>>     as "First Contact."
>>
>> If we start from scratch, we can design the connection process as follows:
>>
>> 1. Check if there are any available link groups. If so, map the
>>     connection into it and go to step 3.
>> 2. Mark this connection as "First Contact," create a link group, and
>>     mark the new link group as unavailable.
>> 3. Finish connection establishment.
>> 4. If the connection is "First Contact," mark the new link group as
>>     available and map the connection into it.
>>
>> I think there is no logical problem with this process, but there is a practical issue where burst traffic can result in burst link groups.
>>
>> For example, if there are 10,000 incoming connections, based on the above logic, the most extreme scenario would be to create 10,000 link groups.
>> This can cause significant memory pressure and even be used for security attacks.
>>
>> To address this goal, the simplest way is to make each connection process mutually exclusive, having the following process:
>>
>> 1. Block other incoming connections.
>> 2. Check if there are any available link groups. If so, map the
>>     connection into it and go to step 4.
>> 3. Mark this connection as "First Contact," create a link group, and
>>     mark it as unavailable.
>> 4. Finish connection establishment.
>> 5. If the connection is "First Contact," mark the new link group as
>>     available and map the connection into it.
>> 6. Allow other connections to come in.
>>
>> And this is our current process now!
>>
>> Regarding the purpose of the locks, to minimize the expansion of the number of link groups. If we agree with this point, we can observe that
>> in phase 2 going to phase 4, this process will never create a new link group. Obviously, the lock is not needed here.
> Well, you still have issue of a link group going away. Thread 1 is deleting the last connection from a link group and shutting it down. Thread 2 is adding a 'second' connection (from its poitn ov view) to the linkgroup.

Hi Alexandra,

That's right.  But even if we do nothing, the current implements still 
has this problem.
And this problem can be solved by the spinlock inside smc_conn_create, 
rather than the
pending lock.

And also deleting the last connection from a link group will not 
shutting the down right now,
usually waiting for 10 minutes of idle time.

>> Then the last question: why is the lock needed until after smc_clc_send_confirm in the new-LGR case? We can try to move phase 6 ahead as follows:
>>
>> 1. Block other incoming connections.
>> 2. Check if there are any available link groups. If so, map the
>>     connection into it and go to step 4.
>> 3. Mark this connection as "First Contact," create a link group, and
>>     mark it as unavailable.
>> 4. Allow other connections to come in.
>> 5. Finish connection establishment.
>> 6. If the connection is "First Contact," mark the new link group as
>>     available and map the connection into it.
>>
>> There is also no problem with this process! However, note that this logic does not address burst issues.
>> Burst traffic will still result in burst link groups because a new link group can only be marked as available when the "First Contact" is completed,
>> which is after sending the CLC Confirm.
>>
>> Hope my point is helpful to you. If you have any questions, please let me know. Thanks.
>>
>> Best wishes,
>> D. Wythe
> You are asking exactly the right questions here. Creation of new connections is on the critical path,
> and if the design can be optimized for parallelism that will increase perfromance, while insufficient
> locking will create nasty bugs.
> Many programmers have dealt with these issues before us. I would recommend to consult existing proven
> patterns; e.g. the ones listed in Paul McKenney's book
> (https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/)
> e.g. 'Chapter 10.3 Read-Mostly Data Structures' and of course the kernel documentation folder.
> Improving an existing codebase like smc without breaking is not trivial. Obviuosly a step-by-step approach,
> works best. So if you can identify actions that can be be done under a smaller (as in more granular) lock
> instead of under a global lock. OR change a mutex into R/W or RCU.
> Smaller changes are easier to review (and bisect in case of regressions).

I have to say it's quite hard to make the lock smaller, we have indeed 
considered the impact of the complexity of the patch on review,
and this might be the simplest solution we can think of. If this 
solution is not okay for you, perhaps we can discuss
whether there is a better solution ?

Best wishes,
D. Wythe








