Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0860A5B0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiJXM2k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiJXM1J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 08:27:09 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E9857F7
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 05:01:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSyvzRA_1666612348;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VSyvzRA_1666612348)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 19:52:29 +0800
Date:   Mon, 24 Oct 2022 19:52:28 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     yanjun.zhu@linux.dev, Zhu Yanjun <yanjun.zhu@intel.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] RDMA net namespace
Message-ID: <20221024115228.GF63658@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20221024011007.GE63658@linux.alibaba.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <e4b62ef709c43ff7425d9a02efaecc5c@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b62ef709c43ff7425d9a02efaecc5c@linux.dev>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 06:15:01AM +0000, yanjun.zhu@linux.dev wrote:
>October 24, 2022 9:10 AM, "Dust Li" <dust.li@linux.alibaba.com> wrote:
>
>> On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:
>> 
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> 
>>> There are shared and exclusive modes in RDMA net namespace. After
>>> discussion with Leon, the above modes are compatible with legacy IB
>>> device.
>>> 
>>> To the RoCE and iWARP devices, the ib devices should be in the same net
>>> namespace with the related net devices regardless of in shared or
>>> exclusive mode.
>> 
>> Does this mean that shared mode is no longer supported for RoCE and iWarp
>> devices ?
>
>From the discussion,  a RoCE and iWarp device should make ib devices and net devices in the same net. So a RoCE and iWarp device has no shared/exclusive modes.
>
>Shared/exclusive modes are for legacy ib devices, such as ipoib. 
>
>In this patch series, shared/exclusive modes are left for legacy ib devices.
>To a RoCE and iWarp device, we just keep net devices and ib devices in the same net.

I think this may limit the use case of RoCE and iWarp.

See the following use case:
In the container enviroment, we may have lots of containers on a host,
for example, more than 100. And we don't have that much VFs, so we use
ipvlan or other virtual network devices for each container, and put
those virtual network devices into each container(net namespace).
Since we only use 1 physical network device for all those containers,
there is only one RoCE device. If we don't support shared mode, we
cannot even enable RDMA for those containers with RoCE.

I don't know any other way to solve this, maybe I missed something ?

Thanks

>
>
>
>> 
>>> In the first commit, when the net devices are moved to a new net
>>> namespace, the related ib devices are also moved to the same net
>>> namespace.
>>> 
>>> In the second commit, the shared/exclusive modes still work with legacy
>>> ib devices. To the RoCE and iWARP devices, these modes will not be
>>> considered.
>>> 
>>> Because MLX4/5 do not call the function ib_device_set_netdev to map ib
>>> devices and the related net devices, the function ib_device_get_by_netdev
>>> can not get ib devices from net devices. In the third commit, all the
>>> registered ib devices are parsed to get the net devices, then compared
>>> with the given net devices.
>>> 
>>> The steps to make tests:
>>> 1) Create a new net namespace net0
>>> 
>>> ip netns add net0
>>> 
>>> 2) Show the rdma links in init_net
>>> 
>>> rdma link
>>> 
>>> "
>>> link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
>>> "
>>> 
>>> 3) Move the net device to net namespace net0
>>> 
>>> ip link set enp7s0np1 netns net0
>>> 
>>> 4) Show the rdma links in init_net again
>>> 
>>> rdma link
>>> 
>>> There is no rdma links
>>> 
>>> 5) Show the rdma links in net0
>>> 
>>> ip netns exec net0 rdma link
>>> 
>>> "
>>> link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
>>> "
>>> 
>>> We can confirm that rdma links are moved to the same net namespace with
>>> the net devices.
>>> 
>>> Zhu Yanjun (3):
>>> RDMA/core: Move ib device to the same net namespace with net device
>>> RDMA/core: The legacy IB devices still work with shared/exclusive mode
>>> RDMA/core: Get all the ib devices from net devices
>>> 
>>> drivers/infiniband/core/device.c | 107 ++++++++++++++++++++++++++++++-
>>> 1 file changed, 105 insertions(+), 2 deletions(-)
>>> 
>>> --
>>> 2.27.0
