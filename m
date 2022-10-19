Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7A60499A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJSOp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiJSOoe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 10:44:34 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D5876AA
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 07:31:19 -0700 (PDT)
Message-ID: <64d82110-f34e-02d7-5381-a0c2c54b3e2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666189842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fimKXHyrPiiuOLMPvzm8ChwMaGbhM6HgG6lo2Ik1CSI=;
        b=sGq2nvCpXo7PA0+mee/C0TsleTNxYP0ZzZEf533kGvclw758HSNjLmFukLn/Vi8eXnohzd
        Jf6nrJWvlAiv8fTHDXErEANCAGlRB59+Jt2rs4VawqJ63OjI4T+swyIQ0NBhTA1WJbEE9T
        QrJ4JoSptK05fPTEs5Bz7O9dLgfMTy8=
Date:   Wed, 19 Oct 2022 22:30:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/mlx5: Make mlx5 device work with
 ib_device_get_by_netdev
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>, linux-rdma@vger.kernel.org
References: <Y05iy+/0BUvbwp5z@unreal>
 <20221016061925.1831180-1-yanjun.zhu@intel.com>
 <556e07a6c331d68845f86e9e0e7cb0c7@linux.dev> <Y0/luHd1OEZsyGWI@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y0/luHd1OEZsyGWI@ziepe.ca>
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


在 2022/10/19 19:55, Jason Gunthorpe 写道:
> On Wed, Oct 19, 2022 at 09:08:14AM +0000, yanjun.zhu@linux.dev wrote:
>> October 18, 2022 4:24 PM, "Leon Romanovsky" <leon@kernel.org> wrote:
>>
>>> On Sun, Oct 16, 2022 at 02:19:25AM -0400, Zhu Yanjun wrote:
>>>
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> Before mlx5 ib device is registered, the function ib_device_set_netdev
>>>> is not called to map the mlx5 ib device with the related net device.
>>>>
>>>> As such, when the function ib_device_get_by_netdev is called to get ib
>>>> device, NULL is returned.
>>>>
>>>> Other ib devices, such as irdma, rxe and so on, the function
>>>> ib_device_get_by_netdev can get ib device from the related net device.
>>> Ohh, you opened Pandora box, everything around it looks half-backed.
>>>
>>> mlx4 and mlx5 don't call to ib_device_set_netdev(), because they have
>>> .get_netdev() callback. This callback is not an easy task to eliminate
>>> and many internal attempts failed to eliminate them.
>>>
>>> This caused to very questionable ksmbd_rdma_capable_netdev()
>>> implementation where ksmbd first checked internal ib_dev callback
>>> and tried to use ib_device_get_by_netdev(). And to smc_ib, which
>>> didn't even bother to use ib_device_get_by_netdev().
>> Thanks.
>>
>> I read the function ksmbd_rdma_capable_netdev carefully.
>> Mlx5 and mlx4 do not call ib_device_set_netdev to map net device and ib devices.
>> This brings a lot of problems.
> ULPs are not allowed to use these interfaces, they are for driver
> implementations.
>
> It is an error that ksmbd_rdma_capable_netdev() calls it in the first
> place.

Got it.  The following function should complete the same job.

Maybe we can use this function to implement ksmbd_rdma_capable_netdev again.

int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
                      struct netlink_callback *cb)


Thanks and Regards,

Zhu Yanjun

>
> Jason
