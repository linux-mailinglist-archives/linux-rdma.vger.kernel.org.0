Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24697E4E8A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 02:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjKHBYh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Nov 2023 20:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKHBYg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Nov 2023 20:24:36 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A98195
        for <linux-rdma@vger.kernel.org>; Tue,  7 Nov 2023 17:24:33 -0800 (PST)
Message-ID: <61cbf731-1592-4b2d-b748-901668fe3610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699406671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UnJmeCmGkR8PgzQegyp8K/o1jg7O7yU7ISwAx8Gsk7I=;
        b=tAlg/l9MrokO2KGYcLn9pS32qrcotpyM2Ff9MMaS3JPBEPlEwJXfTb7pubQSe+SW2RX5dX
        /R8fIng8Nd6EFo34KLNoyp9RRpegxy/n3j606iE3n1987O5YG2MQkkCLPkRcDv6r7mO/qI
        UnDnoWezoOPDJ8ten9/aXq6NhKZxj4Q=
Date:   Wed, 8 Nov 2023 09:24:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-4-rpearsonhpe@gmail.com>
 <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
 <a0b998f6-7c03-466e-b163-3317f7a5576c@gmail.com>
 <0f190158-d39f-45b0-be07-73977bfb40b7@linux.dev>
 <9759a166-b302-46c0-9277-058152af45ef@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <9759a166-b302-46c0-9277-058152af45ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/11/7 1:31, Bob Pearson 写道:
> 
> 
> On 11/6/23 07:26, Zhu Yanjun wrote:
>>
>> 在 2023/11/6 4:19, Bob Pearson 写道:
>>>
>>>
>>> On 11/4/23 07:42, Zhu Yanjun wrote:
>>>
>>>>
>>>> Using reverse fir tree, a.k.a. reverse Christmas tree or reverse 
>>>> XMAS tree, for
>>>>
>>>> variable declarations isn't strictly required, though it is still 
>>>> preferred.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>
>>> Yeah. I usually follow that style for new code (except if there are
>>> dependencies) but mostly add new variables at the end of the list
>>> together  because it makes the patch simpler to read. At least it
>>> does for me. If you care, I am happy to fix this.
>>
>> Yes. It is good to fix it.
>>
>> And your commits add mcast address supports. And I think you
>>
>> should have the test case in the rdma-core to verify these commits.
>>
>> Can you share the test case in the rdma maillist? ^_^
>>
>> Zhu Yanjun
>>
>>>
>>> Bob
> 
> I could share it but it's not really in a good shape to publish. I
> have to modify the limits in rxe_param.h to test max_etc. And currently
> I need to hand edit the send/recv versions to do node to node. In other
> words just enough to (by hand) work through the use cases enough to
> convince myself it works using ip maddr and wireshark along with the
> program.
> 
> What you are asking for is a bunch of work to make the test program
> more like iperf or ib_send_bw. Ideally it should either reload the
> driver or do something else to let each test case be a clean start.

Got it.
Anyway, a test case in rdma-core is needed to make tests with this feature.

And this feature is related with mcast. So please also send these 
commits to NETDEV maillist. NETDEV people can also give us a lot of good 
advice.

Thanks,
Zhu Yanjun

> 
> In an ideal world there would be a two node version of pyverbs. :-)
> 
> Bob

