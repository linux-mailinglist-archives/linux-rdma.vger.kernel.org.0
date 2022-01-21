Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0B495FAB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 14:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbiAUNTH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jan 2022 08:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350722AbiAUNTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jan 2022 08:19:07 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36321C061574
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jan 2022 05:19:07 -0800 (PST)
Message-ID: <9b531d94-b1f4-2720-fc41-80fa94f444f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642771144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjWcE0SGglrEjJYl0Sj+Q6nZ+DUgCEKwJevGoFsBj3E=;
        b=q/6fV61p6gJQnlt36gVY5Ew2qF+fClILuh9pemXJAAwCliLewwJW/ZoXTAKqKM9d4kFC/0
        jEK7zujtyTfJ4hDtGzvAyw0TKj09UtB8HLiABNiNA5CXXZWqaaxf3xX+TLyIxEqOxnX1gv
        Pw+OQ5id1orfMuAgjvGALZms+lME/+o=
Date:   Fri, 21 Jan 2022 21:18:55 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
 <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
 <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
 <61DE51D7.5050400@fujitsu.com>
 <468c411e-8f68-00da-5c44-a3de72bf0d9b@linux.dev>
 <61E623DF.5000007@fujitsu.com>
 <4e1e7cf6-d41b-6926-68cf-e58ca79a4559@linux.dev> <61E92C59.20200@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <61E92C59.20200@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/20 17:33, yangx.jy@fujitsu.com 写道:
> On 2022/1/19 22:08, Yanjun Zhu wrote:
>> "
>>
>> ...
>>
>> Since the responder may choose to coalesce acknowledges, a single
>> response packet may in fact acknowledge
>> several request messages. Thus, when it receives a new MSN, the
>> requester begins evaluating WQEs on its send queue beginning with the
>> oldest outstanding WQE and progressing forward.
>>
>> ...
>>
>> "
>>
>> In the above, several request messages come. From the SPEC, msn should
>> increase based on the number of request messages.
> Hi Yanjun，
>
> Current logic shows that posting a WQE on SQ increases SSN (SSN++) and
> processing a WQE on responder successfully increases MSN (MSN++).
> I think current SoftRoce doesn't implement the rule you metioned.
>
> To be honest, the rule is not clear for me. when and how many
> acknowledges of several request messages can we coalesce?

Hi, Jason Gunthorpe && Leon Romanovsky

In Mellanox RDMA NIC, how this rule is implemented?

Thanks a lot.

Zhu Yanjun

>> Can your commit handle the above case?
> No.
>
> Best Regards,
> Xiao Yang
>>
>> Zhu Yanjun
