Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0C6256D3
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 10:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiKKJ3a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 04:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiKKJ3P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 04:29:15 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638C85444;
        Fri, 11 Nov 2022 01:28:21 -0800 (PST)
Message-ID: <50bef54b-068c-5191-f16e-5f86d2689677@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668158900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uu7ebAhUcAtBmIocQs3mb2CR31DJQB7YU8fv1MJTVC4=;
        b=p2Ip7YzxhK0hiUnBXqlLH9nbTmVd5tJ6864dr7cP5ziyRafbBIrlSfRiLNwEWjWmA7zHyN
        3BM4ioblWRDTx2cBnj6/kUS4/U+iq1g6UUlBZ3OPni93qxlRbc+yyxjSlXVEBfbARHvawm
        M3F112L/ZveVPYFCXg5yYuDrZUYnxr8=
Date:   Fri, 11 Nov 2022 17:28:12 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH v5 06/11] RDMA/rxe: Extend rxe packet format to
 support flush
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-7-lizhijian@fujitsu.com>
 <ce4c5925-d321-6b33-7bd7-e05b7145acde@linux.dev>
 <cc46e58f-acac-34cf-a343-8feb5b755502@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <cc46e58f-acac-34cf-a343-8feb5b755502@fujitsu.com>
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


在 2022/11/11 16:55, lizhijian@fujitsu.com 写道:
>
> On 11/11/2022 16:43, Yanjun Zhu wrote:
>>> /******************************************************************************
>>>     * Atomic Extended Transport Header
>>>     
>>> ******************************************************************************/
>>> @@ -910,6 +956,7 @@ enum rxe_hdr_length {
>>>        RXE_ATMETH_BYTES    = sizeof(struct rxe_atmeth),
>>>        RXE_IETH_BYTES        = sizeof(struct rxe_ieth),
>>>        RXE_RDETH_BYTES        = sizeof(struct rxe_rdeth),
>>> +    RXE_FETH_BYTES        = sizeof(struct rxe_feth),
>>>    };
>>>    static inline size_t header_size(struct rxe_pkt_info *pkt)
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c
>>> b/drivers/infiniband/sw/rxe/rxe_opcode.c
>>> index d4ba4d506f17..55aad13e57bb 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
>>> @@ -101,6 +101,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
>>>                [IB_QPT_UC]    = WR_LOCAL_OP_MASK,
>>>            },
>>>        },
>>> +    [IB_WR_FLUSH]                    = {
>>> +        .name   = "IB_WR_FLUSH",
>>> +        .mask   = {
>>> +            [IB_QPT_RC]    = WR_FLUSH_MASK,
>>> +        },
>>> +    },
>>>    };
>> Hi, Zhijian
>>
>> I am making tests with it. Except rc, other modes are supported? such as
>> rd, xrc?
>>
> Only RC is implemented for FLUSH, current RXE only supports RC service[1].
> BTW, XRC is on the way in Bob's patch IIRC.
>
> https://lore.kernel.org/r/cce0f07d-25fc-5880-69e7-001d951750b7@gmail.com
  40  * IBA header types and methods
  41  *
  42  * Some of these are for reference and completeness only since


  43  * rxe does not currently support RD transport


  44  * most of this could be moved into IB core. ib_pack.h has

  45  * part of this but is incomplete

Zhu Yanjun

>
>
>> Zhu Yanjun
