Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059B5EC03B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 12:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiI0K7G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 06:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiI0K7F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 06:59:05 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF2AE9E4
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 03:59:03 -0700 (PDT)
Message-ID: <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664276342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqOr5BwTZTfQ1Vbb6e+DLDwE1SW3DI+SSWMd870pYF8=;
        b=ljJ1a131+eyobc0maclDQlOWk3skJBr6ODIWaEb2ZO0TUPayti9jNSf2E8Be4q8eWa0/t2
        1C64OMDWIu7aBW8d5qIs5a8hUtKRfdnORV3OS/YHz2GUDaphbAXjPLTZxyoFpAi39/a+bL
        QPhjch6xiIxtOl7J2PIDAbaYW7BS1/g=
Date:   Tue, 27 Sep 2022 18:58:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
To:     Leon Romanovsky <leo@kernel.org>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YzLRvzAH9MqqtSGk@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/9/27 18:34, Leon Romanovsky 写道:
> On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> When the net devices are moved to another net namespace, the command
>> "rdma link" should not dispaly the rdma link about this net device.
>>
>> For example, when the net device eno12399 is moved to net namespace net0
>> from init_net, the rdma link of eno12399 should not display in init_net.
>>
>> Before this change:
>>
>> Init_net:
>>
>> link roceo12399/1 state DOWN physical_state DISABLED  <---should not display
>> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
>> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
>>
>> net0:
>>
>> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
>> link roceo12409/1 state DOWN physical_state DISABLED <---should not display
>> link rocep202s0f0/1 state DOWN physical_state DISABLED <---should not display
>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP <---should not display
>>
>> After this change
>>
>> Init_net:
>>
>> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
>> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
>>
>> net0:
>>
>> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
>>
>> Fixes: da990ab40a92 ("rdma: Add link object")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   rdma/link.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/rdma/link.c b/rdma/link.c
>> index bf24b849..449a7636 100644
>> --- a/rdma/link.c
>> +++ b/rdma/link.c
>> @@ -238,6 +238,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
>>   		return MNL_CB_ERROR;
>>   	}
>>   
>> +	if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] || !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])
>> +		return MNL_CB_OK;
>> +
> Regarding your question where it should go in addition to RDMA, the answer
> is netdev ML. The rdmatool is part of iproute2 and the relevant maintainers
> should be CCed.
Thanks. I will also send it to netdev ML and CC the maintainers.
>
> Regarding the change, I don't think that it is right. User space tool is
> a simple viewer of data returned from the kernel. It is not a mistake to
> return device without netdev.

Normally a rdma link based on RoCEv2 should be with a NIC. This NIC device

will send/recv udp packets. With mellanox/intel NIC device, this net 
device also

do more work than sending/receiving packets.

 From this perspective, a rdma link is dependent on a net device.

In this problem, net device is moved to another net namespace. So it can 
not be

obtained.  And this rdma link can also not work in this net namespace.

So this rdma link should not appear in this net namespace. Or else, it 
would confuse

the user.

In fact, net namespace is a concept in tcp/ip stack. And it does not 
exist in rdma stack.

But rdma link based on RoCEv2 is dependent on network device. So when 
the net device

is moved to another net namespace, this rdma link should also be moved 
to another net namespace.

Zhu Yanjun

>
> Thanks
