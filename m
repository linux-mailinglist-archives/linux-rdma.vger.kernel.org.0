Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB86048BC54
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 02:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiALBTR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 20:19:17 -0500
Received: from out0.migadu.com ([94.23.1.103]:27019 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235700AbiALBTR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 20:19:17 -0500
Message-ID: <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641950355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9Vsws+HxaVWaYK1qQSIEF0dYRyI9HKPIFHcdjYY4dU=;
        b=cwTPJH8+drsH/cVhL3nLLBZKyhBJp+j0iMJWVIQlMAo+qlhGZlrhc1IRgzNo1SIO1GvFbL
        h8JPPXiEguwMAPFAEVCqKTYlTN3yzGPLLTKBkHcFA7m9rbUUCnqmxbwaMP9JQqi3rN+OKy
        seOakrjGmraIQFlVwzwHAmdcN5iYlt0=
Date:   Wed, 12 Jan 2022 09:19:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
 <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/11 23:16, Haakon Bugge 写道:
>
>> On 11 Jan 2022, at 15:42, Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>>
>>
>> 在 2022/1/10 13:17, yangx.jy@fujitsu.com 写道:
>>> On 2022/1/7 19:49, Yanjun Zhu wrote:
>>>> It seems that it does not mean to check the last packet. It means that
>>>> it receives a MSN response.
>>> Hi Yanjun,
>>>
>>> Checking the last packet is a way to indicate that responder has
>>> completed an entire request(including multiple packets) and then
>>> increases a msn.
>> Hi, Xiao
>>
>> What does the msn mean?
> Message Sequence Number.

Thanks, Haakon

I am reading the following from the spec.

"

C9-148: An HCA responder using Reliable Connection service shall initialize

its MSN value to zero. The responder shall increment its MSN
whenever it has successfully completed processing a new, valid request
message. The MSN shall not be incremented for duplicate requests. The
incremented MSN shall be returned in the last or only packet of an RDMA
READ or Atomic response. For RDMA READ requests, the responder
may increment its MSN after it has completed validating the request and
before it has begun transmitting any of the requested data, and may return
the incremented MSN in the AETH of the first response packet. The MSN
shall be incremented only once for any given request message.

"

It seems that the above describe how to handle MSN increment in details.

Zhu Yanjun

>
>
> Thxs, Håkon
>
>> Thanks a lot.
>>
>> Zhu Yanjun
>>
>>> Best Regards,
>>> Xiao Yang
