Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F905F746A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Oct 2022 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJGG4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Oct 2022 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGG4g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Oct 2022 02:56:36 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F4A927A
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 23:56:34 -0700 (PDT)
Message-ID: <ce6d40e7-9955-1eea-732c-bad92333c6db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665125793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgVpcqrUgsel6oJ3/zPc/XyjpW73BV9CcYsw6eQFDgk=;
        b=X4qDPNNdMUr52z6VZGdwtiM2YZt6p4p+eKkuf6IBUQKrXopp1aeIbnGKzwAPGSaMQGNTsC
        2t9nsI7p4tIMvNHkKw3DGRSF278J5Wy1Jf9g2d60vg/a2ETIYjJAoDNGK3A446zq3eW5uX
        1KETFLcc37oBaYFjBSLAbYnVn5xSSIw=
Date:   Fri, 7 Oct 2022 14:56:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal> <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <YzPkAGs60Kk4QCck@unreal> <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
 <Yz7PsMhkWMH0HXjt@unreal> <99a4b7ea-64df-7de4-2d7a-52e797644e71@linux.dev>
 <Yz8Ak/Pxz13fP4zE@unreal> <Yz8A6az2rIjEDEGk@nvidia.com>
 <Yz/FaiYZO5Y0R7QP@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Yz/FaiYZO5Y0R7QP@unreal>
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


在 2022/10/7 14:21, Leon Romanovsky 写道:
> On Thu, Oct 06, 2022 at 01:23:05PM -0300, Jason Gunthorpe wrote:
>> On Thu, Oct 06, 2022 at 07:21:39PM +0300, Leon Romanovsky wrote:
>>
>>>> And in exclusive mode, a rdma link that can not be accessed in net namespace
>>>> A still
>>>>
>>>> appears in net namespace A when running "rdma link show" in net namespace A.
>>>>
>>>> The above is different from others in net namespace.
>>>>
>>>> For example, in net namespace, if net device NIC0 is moved to net namespace
>>>> B from net namespace A,
>>>>
>>>> this NIC0 will not appear in net namespace A when running "ip link" command
>>>> in net namespace A.
>>>>
>>>> Is it a problem?
>>> rdmatool presents IB devices. It has no logic that decides if that
>>> device is usable/operable or not.
>> It should really not report an IB device that is not in the net
>> namespace..
> It is kernel (nldev.c) job to hide such IB devices and it seems like it
> does. For devices with help of ib_enum_all_devs() and for links with
> ib_device_get_by_index().

Thanks, Jason and Leon

I am working on it. I will send the patch out very soon.

Zhu Yanjun

>
> They both checks netns - rdma_dev_access_netns(device, net).
>
> Thanks
