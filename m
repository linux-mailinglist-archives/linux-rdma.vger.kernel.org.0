Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9746108AC
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 05:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiJ1DVe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 23:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiJ1DVd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 23:21:33 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A065645DE
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 20:21:30 -0700 (PDT)
Message-ID: <ddd5fb94-127a-0fc2-cadf-7a0f24fa0d15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666927289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07Z7tDl1KPXZjyTamSF563LYfb8lh1e0d7sPuIa8N+0=;
        b=b8QOr3e+26yno/UjpsZGKzzEBy/zC8vcssNNaAM2ct9uas6IRqBKsSc7FVfV1MHh6pQT6O
        uTkNt+2LjxjiYV3ukw1UA0cekxV571nTWXBETCe+9+2NPeWtikNT/JC67Je2QYAuEbllU9
        P1zlOFCuN3syiTSWni1prJCiPcB3ez8=
Date:   Fri, 28 Oct 2022 11:21:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     Parav Pandit <parav@nvidia.com>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <PH0PR12MB5481AA6E4D5BBAC76E027458DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
 <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
 <7f5ed21ac410646aba93aac875a0d8a8@linux.dev>
 <PH0PR12MB54811A129A037D716BFD934CDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <PH0PR12MB54811A129A037D716BFD934CDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/10/27 22:06, Parav Pandit 写道:
>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>
>> Sent: Thursday, October 27, 2022 2:02 AM
>> To: Parav Pandit <parav@nvidia.com>; dust.li@linux.alibaba.com; Zhu Yanjun
>> <yanjun.zhu@intel.com>; jgg@ziepe.ca; leon@kernel.org; linux-
>> rdma@vger.kernel.org
>> Subject: Re: [PATCH 0/3] RDMA net namespace
>>
>> October 27, 2022 11:48 AM, "Parav Pandit" <parav@nvidia.com> wrote:
>>
>>>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>
>>>> Sent: Wednesday, October 26, 2022 11:39 PM
>>>>
>>>> October 27, 2022 11:21 AM, "Parav Pandit" <parav@nvidia.com> wrote:
>>>>
>>>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>
>>>> Sent: Wednesday, October 26, 2022 11:17 PM
>>>>
>>>> October 27, 2022 11:10 AM, "Parav Pandit" <parav@nvidia.com> wrote:
>>>>
>>>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>
>>>> Sent: Wednesday, October 26, 2022 11:08 PM
>>>>
>>>> October 27, 2022 11:01 AM, "Parav Pandit" <parav@nvidia.com> wrote:
>>>>
>>>> From: Dust Li <dust.li@linux.alibaba.com>
>>>> Sent: Wednesday, October 26, 2022 10:31 PM
>>>>
>>>> 2. else we are in
>>>> exclusive mode. When the corresponding netdevice of the RoCE or iWarp
>>>> device is moved from one net namespace to another, we move the
>> RDMA
>>>> device into that net namespace
>>>>
>>>> What do you think ?
>>>>
>>>> No. one device is not supposed to move other devices.
>>>> Every device is independent that should be moved by explicit command.
>>>>
>>>> Can you show us where we can find this rule "Every device is
>>>> independent that should be moved by explicit command."?
>>>>
>>>> Also changes like above breaks the existing orchestration, it no-go.
>>>>
>> And I do not find the rule that you mentioned.
>>
>>> There is no Linux kernel subsystem or module to my knowledge that
>>> attempt to move multiple devices using single command.
>>> When user executes command , user explicitly give device name "foo",
>> only "foo" should move.
>>> Other loosely coupled device whose name is not specified in the ip
>>> command which has a different life cycle should not move along with "foo".
>>>
>>> You are trying to define the new rule that breaks the existing ABI and
>>> the iproute2 (ip and rdma) command semantics.
>>> It is implicit that when command is issued on device A, operate on
>>> device A. This is part of
>>> iproute2 functioning.
>> About iproute2, I read this link
>> https://wiki.linuxfoundation.org/networking/iproute2#documentation
>>
>> There is no rules that you mentioned.
>>
>> This rule is defined explicitly or implicitly?
>>
> Wiki pages links are not the documentation.
> Man pages of the iproute2 is documentation of iproute2 at [1] and [2].
>
> [1] https://man7.org/linux/man-pages/man8/rdma-system.8.html
> [2] https://man7.org/linux/man-pages/man8/rdma-dev.8.html
>
> As I explained, the explicit rule that you are looking for that say "when I modify device foo, it can also modifies the device bar".
> Because no part of the Linux kernel does that usually, unless the device is representor/control object etc or has parent/child relationship.
> It is fundamental to a command definition, not a matter of explicit or implicit.

 From the ABI, iproute2 and current rdma command links, I can not find 
the rule that you mentioned.

Can you tell me the exact link that make such definition?

>
> And clearly in this discussion foo and bar are loosely coupled network devices, one is not controlling the other.
>
> Also, a rdma device is attached to multiple net devices, primary and other upper devices such as vlan, macvlan etc.

To a RoCE device, how to attach a rdma device to vlan, macvlan?

To "a rdma device is attached to multiple net devices, primary and other 
upper devices such as vlan, macvlan etc",

Can you show us an example? The rdma device is RoCE device, iWarp or 
ipoib device?

Zhu Yanjun

>
>
