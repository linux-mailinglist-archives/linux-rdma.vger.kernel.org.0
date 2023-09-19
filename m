Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820C7A5843
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjISEBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 00:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjISEBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 00:01:32 -0400
Received: from out-212.mta0.migadu.com (out-212.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DA102
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 21:01:24 -0700 (PDT)
Message-ID: <cad7da11-a673-ce75-98db-f55e49cdbbd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695096082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2x7tImJ3CmD5Mqi03slWYVRq5XEeHl6I1D4rVMINYc=;
        b=luSewVe6Cv+UkZds831kpYcdUVoe6m+GbE945+Cv3o8NzieWTDaaa5UVn97vW2ZC0M4f7G
        /9Cpp5RZE34rAJMIsYtuWW03OdZAYBivBktfrkisSL4A6ikxbpOzOPW1a+e1we4Run4P24
        KcCIvK7F7nME2V1z4I3s552iNoL3bYE=
Date:   Tue, 19 Sep 2023 12:01:15 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com>
 <20230918123710.GD103601@unreal>
 <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
 <CAD=hENfcbgNQxb2N1qXJa0pYkF_AYB2aua0smadwkgHtYXfeAw@mail.gmail.com>
 <0cd9103b-4411-700e-f8d1-94e8735f57e4@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <0cd9103b-4411-700e-f8d1-94e8735f57e4@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/9/19 11:25, Zhijian Li (Fujitsu) 写道:
>
> On 19/09/2023 09:11, Zhu Yanjun wrote:
>> On Tue, Sep 19, 2023 at 8:57 AM Zhijian Li (Fujitsu)
>> <lizhijian@fujitsu.com> wrote:
>>>
>>>
>>> On 18/09/2023 20:37, Leon Romanovsky wrote:
>>>> On Mon, Sep 18, 2023 at 10:05:43AM +0800, Li Zhijian wrote:
>>>>> rxe_set_mtu() will call rxe_info_dev() to print message, and
>>>>> rxe_info_dev() expects dev_name(rxe->ib_dev->dev) has been assigned.
>>>>>
>>>>> Previously since dev_name() is not set, when a new rxe link is being
>>>>> added, 'null' will be used as the dev_name like:
>>>>>
>>>>> "(null): rxe_set_mtu: Set mtu to 1024"
>>>>>
>>>>> Move rxe_register_device() earlier to assign the correct dev_name
>>>>> so that it can be read by rxe_set_mtu() later.
>>>> I would expect removal of that print line instead of moving
>>>> rxe_register_device().
>>>
>>> I also struggled with this point. The last option is keep it as it is.
>>> Once rxe is registered, this print will work fine.
>> I delved into the source code. About moving rxe_register_device, I
>> could not find any harm to the driver.
> The point i'm struggling was that, it's strange/opaque to move rxe_register_device().
> There is no doubt that the original order was more clear.


Please check the source code. It is very clear.


> In terms of the message content, is it valuable to print(pr_info) this message, i noticed
> that there is a duplicate pr_dbg() in rxe_notify().


rxe_notify is for netdevice event, not for rdma event.


>
> rxe's mtu is always same with the NIC, isn't it ?

Please check the following source code.

void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)

{
         struct rxe_port *port = &rxe->port;
         enum ib_mtu mtu;

         mtu = eth_mtu_int_to_enum(ndev_mtu);

         /* Make sure that new MTU in range */
         mtu = mtu ? min_t(enum ib_mtu, mtu, IB_MTU_4096) : IB_MTU_256;

         port->attr.active_mtu = mtu;
         port->mtu_cap = ib_mtu_enum_to_int(mtu);

         rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
}

Zhu Yanjun


>
> Thanks
> Zhijian
>
>
>
>> So I think this is also a solution to this problem.
>>
>> Zhu Yanjun
>>
>>> Thanks
>>> Zhijian
>>>
>>>
>>>> Thanks
>>>>
>>>>> And it's safe to do such change since mtu will not be used during the
>>>>> rxe_register_device()
>>>>>
>>>>> After this change, the message becomes:
>>>>> "rxe_eth0: rxe_set_mtu: Set mtu to 4096"
>>>>>
>>>>> Fixes: 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")
>>>>> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>>>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>>> index a086d588e159..8a43c0c4f8d8 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>>> @@ -169,10 +169,13 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>>>>>      */
>>>>>     int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>>>>>     {
>>>>> +    int ret;
>>>>> +
>>>>>        rxe_init(rxe);
>>>>> +    ret = rxe_register_device(rxe, ibdev_name);
>>>>>        rxe_set_mtu(rxe, mtu);
>>>>>
>>>>> -    return rxe_register_device(rxe, ibdev_name);
>>>>> +    return ret;
>>>>>     }
>>>>>
>>>>>     static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>>>> --
>>>>> 2.29.2
>>>> >
