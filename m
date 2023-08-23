Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76A17850FD
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 08:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjHWG73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 02:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjHWG73 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 02:59:29 -0400
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96BECDD
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 23:59:26 -0700 (PDT)
Message-ID: <86137972-fa63-ef07-3842-3a678329864a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692773964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBuitAfShYT5yjJqohH65eUyXBkcIa7zwJcRrZBv9C0=;
        b=pJWkR9ObHdIgmBOPK2hAFmcOxHKN40edGEApsCwk/DjYevO39NRDZGgSXsNaLJ86t/pNNk
        wxBV9D1A1DfYAXRsxjLxucN0o5RSp1Z57tM58mejtpUNMtrOTjlLYc45ukcTzMDvJrq6UL
        TPTChaIacTqV0YFHaSdBoOwCJWfBsek=
Date:   Wed, 23 Aug 2023 14:59:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev>
 <54f43b58-4986-f2c3-7488-ecaf150b1e79@fujitsu.com>
 <CAD=hENcGfS0++mTTX4z-YT3SAx=5OYyqSf89=AkOCD9+SrUtag@mail.gmail.com>
 <e823d7aa-99d6-1417-8aca-c89db1c350b9@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e823d7aa-99d6-1417-8aca-c89db1c350b9@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/8/23 14:47, Zhijian Li (Fujitsu) 写道:
>
> On 23/08/2023 14:35, Zhu Yanjun wrote:
>> On Wed, Aug 23, 2023 at 2:25 PM Zhijian Li (Fujitsu)
>> <lizhijian@fujitsu.com> wrote:
>>>
>>>
>>> On 23/08/2023 14:12, Zhu Yanjun wrote:
>>>> 在 2023/8/23 10:13, Li Zhijian 写道:
>>>>> A newline help flushing message out.
>>>> rxe_info_dev will finally call printk to output information.
>>>>
>>>> In this link https://github.com/torvalds/linux/blob/master/Documentation/core-api/printk-basics.rst,
>>>> "
>>>> All printk() messages are printed to the kernel log buffer, which is a ring buffer exported to userspace through /dev/kmsg. The usual way to read it is using dmesg.
>>>> "
>>>> Do you mean that a new line will help the kernel log buffer flush message out?
>>> Yeah, the message will be buffered until it is full or it meets a newline.
>> Add PRINTK reviewers:
>>
>> Petr Mladek <pmladek@suse.com>
>> Sergey Senozhatsky <senozhatsky@chromium.org>
>> Steven Rostedt <rostedt@goodmis.org>
>>    John Ogness <john.ogness@linutronix.de>
>>
>> This is about printk. They can decide this commit.
> I don't think it's a printk stuff.
Do you get me?

I mean, prinkt reviewer will check the statement "the message will be 
buffered until it is full or it meets a newline." correct or not.

Zhu Yanjun

>
> In general, when developers add some printk()/pr_info() to print some message in the kernel, they expect this message will be printed in time.
> So most of the printk()/pr_info() calls in current kernel accompany a '\n' at the end.
>
> And printk() will also print message to 'console' by default, console could be a serial port(ttyS0) or tty1 etc.
>
> Thanks
> Zhijian
>
>
>> Zhu Yanjun
>>
>>>
>>>
>>>> Zhu Yanjun
>>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>>>>> index 54c723a6edda..cb2c0d54aae1 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>>>> @@ -161,7 +161,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>>>>>         port->attr.active_mtu = mtu;
>>>>>         port->mtu_cap = ib_mtu_enum_to_int(mtu);
>>>>> -    rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
>>>>> +    rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
>>>>>     }
>>>>>     /* called by ifc layer to create new rxe device.
>>> >
