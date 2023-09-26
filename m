Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74E7AE898
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjIZJGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjIZJGS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:06:18 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC2DE;
        Tue, 26 Sep 2023 02:06:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vsw82Mw_1695719167;
Received: from 30.221.147.7(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vsw82Mw_1695719167)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 17:06:08 +0800
Message-ID: <ab417654-8aba-f357-8ac5-16c4c2b291e1@linux.alibaba.com>
Date:   Tue, 26 Sep 2023 17:06:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
 <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
 <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
 <c03dad67-169a-bf6d-1915-a9bb722a7259@linux.alibaba.com>
 <d18e1a78-3b3a-8f23-6db1-20c16795d3ef@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <d18e1a78-3b3a-8f23-6db1-20c16795d3ef@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/26/23 3:18 PM, Alexandra Winter wrote:
>
> On 26.09.23 05:00, D. Wythe wrote:
>> You are right. The key point is how to ensure the valid of smc sock during the life time of clc sock, If so, READ_ONCE is good
>> enough. Unfortunately, I found  that there are no such guarantee, so it's still a life-time problem.
> Did you discover a scenario, where clc sock could live longer than smc sock?
> Wouldn't that be a dangerous scenario in itself? I still have some hope that the lifetime of an smc socket is by design longer
> than that of the corresponding tcp socket.


Hi Alexandra,

Yes there is. Considering scenario:

tcp_v4_rcv(skb)

/* req sock */
reqsk = _inet_lookup_skb(skb)

/* listen sock */
sk = reqsk(reqsk)->rsk_listener;
sock_hold(sk);
tcp_check_req(sk)


                                                 smc_release /* release 
smc listen sock */
                                                 __smc_release
smc_close_active()         /*  smc_sk->sk_state = SMC_CLOSED; */
                                                     if 
(smc_sk->sk_state == SMC_CLOSED)
smc_clcsock_release();
sock_release(clcsk);        /* close clcsock */
     sock_put(sk);              /* might not  the final refcnt */

sock_put(smc_sk)    /* might be the final refcnt of smc_sock  */

syn_recv_sock(sk...)
/* might be the final refcnt of tcp listen sock */
sock_put(sk);

Fortunately, this scenario only affects smc_syn_recv_sock and 
smc_hs_congested, as other callbacks already have locks to protect smc,
which can guarantee that the sk_user_data is either NULL (set in 
smc_close_active) or valid under the lock.

> Considering the const, maybe
>> we need to do :
>>
>> 1. hold a refcnt of smc_sock for syn_recv_sock to keep smc sock valid during life time of clc sock
>> 2. put the refcnt of smc_sock in sk_destruct in tcp_sock to release the very smc sock .
>>
>> In that way, we can always make sure the valid of smc sock during the life time of clc sock. Then we can use READ_ONCE rather
>> than lock.  What do you think ?
> I am not sure I fully understand the details what you propose to do. And it is not only syn_recv_sock(), right?
> You need to consider all relations between smc socks and tcp socks; fallback to tcp, initial creation, children of listen sockets, variants of shutdown, ... Preferrably a single simple mechanism covers all situations. Maybe there is such a mechanism already today?
> (I don't think clcsock->sk->sk_user_data or sk_callback_lock provide this general coverage)
> If we really have a gap, a general refcnt'ing on smc sock could be a solution, but needs to be designed carefully.

You are right , we need designed it with care, we will try the 
referenced solutions internally first, and I will also send some RFCs so 
that everyone can track the latest progress
and make it can be all agreed.
> Many thanks to you and the team to help make smc more stable and robust.

Our pleasure 😁.  The stability of smc is important to us too.

Best wishes,
D. Wythe


