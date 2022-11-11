Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD266253D7
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiKKGcx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 01:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiKKGcS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 01:32:18 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791DF5F51;
        Thu, 10 Nov 2022 22:31:04 -0800 (PST)
Message-ID: <7ee2c646-0be0-5a37-83bd-110d8a8717d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668148263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqnpMcpcFHI1JVz6e9lYAIU4l1pkcJ14xujvc36hbdg=;
        b=HUWLtknOEyKecQQ7mSkNAa60axRvBDswoJecTW9tT4h+HVwFFW8rsiIK5j1cPLKAByQDnU
        k1Bfc2iq8acLFBEbrWt0qzvdmw5CQYckq+5sGm06jDMd8QFsML2/EsQLIXowWpf8zcfXSn
        SORrgwr4OWJlcsnPPUWFa0fjOyUhDUc=
Date:   Fri, 11 Nov 2022 14:30:51 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <Y1wX8n9R7dkLo0KU@nvidia.com>
 <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
 <00a3797c-9759-d4ec-6d6f-8f157cd2a220@fujitsu.com>
 <b9f3550a-6fbc-b279-22a3-50285da82e5d@linux.dev>
 <9fa30c8b-cb8d-efec-5896-b96177929d08@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <9fa30c8b-cb8d-efec-5896-b96177929d08@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/11/11 14:10, lizhijian@fujitsu.com 写道:
>
> On 11/11/2022 13:52, Yanjun Zhu wrote:
>> 在 2022/11/11 13:10, lizhijian@fujitsu.com 写道:
>>>
>>> On 11/11/2022 10:49, Yanjun Zhu wrote:
>>>> 在 2022/10/29 1:57, Jason Gunthorpe 写道:
>>>>> On Tue, Sep 27, 2022 at 01:53:26PM +0800, Li Zhijian wrote:
>>>>>> Hey folks,
>>>>>>
>>>>>> Firstly i want to say thank you to all you guys, especially Bob, who
>>>>>> in the
>>>>>> past 1+ month, gave me a lots of idea and inspiration.
>>>>> I would like it if someone familiar with rxe could reviewed-by the
>>>>> protocol parts.
>>>> Hi, Jason
>>>>
>>>> I reviewed these patches. I am fine with these patches.
>>>>
>>>> Hi, Zhijian
>>>>
>>>> I noticed the followings:
>>>> "
>>>> $ ./rdma_flush_server -s [server_address] -p [port_number]
>>>> client:
>>>> $ ./rdma_flush_client -s [server_address] -p [port_number]
>>>> "
>>>> Can you merge the server and the client to rdma-core?
>>> Yanjun,
>>>
>>> Yes, there was already a draft PR here
>>> https://github.com/linux-rdma/rdma-core/pull/1181, but it cannot go
>>> ahead until the kernel's patches are merged.
>>>
>>> and i will post a new version these days, would you mind if i add your
>>> "Reviewed-by" in next version ?
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> Thanks.
>>
>> Another problem, normally rxe should connect to physical ib devices,
>> such as mlx ib device. That is, one host is rxe, the other host is mlx
>> ib device. The rdma connection should be created between the 2 hosts.
> it's fully compatible with old operation.
>
>
>> Do you connect to mlx ib device with this RDMA FLUSH operation?
>> And what is the test result?
> Yes, i tested it.
>
> After these patches, only RXE device can register *FLUSHABLE* MRs
> successfully. If mlx try that, EOPNOSUPP will be returned.
>
> Similarly, Since other hardwares(MLX for example) have not supported
> FLUSH operation, EOPNOSUPP will be returned if users try to to that.
>
> In short, for RXE requester, MLX responder will return error for the
> request. MLX requester is not able to request a FLUSH operation.

Thanks. Do you mean that FLUSH operation is only supported in RXE? ^_^

And MLX does not support FLUSH operation currently?

Zhu Yanjun

>
> Thanks
> Zhijian
>
>
>> Thanks a lot.
>> Zhu Yanjun
>>
>>>
>>>
>>>> Thanks,
>>>> Zhu Yanjun
>>>>
>>>>> Jason
