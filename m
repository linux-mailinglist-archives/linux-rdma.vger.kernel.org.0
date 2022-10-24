Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E160B058
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiJXQF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiJXQEl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 12:04:41 -0400
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D7159D45
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 07:57:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VT.5rh2_1666622122;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VT.5rh2_1666622122)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 22:35:23 +0800
Date:   Mon, 24 Oct 2022 22:35:21 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] RDMA net namespace
Message-ID: <20221024143521.GG63658@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20221024011007.GE63658@linux.alibaba.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <e4b62ef709c43ff7425d9a02efaecc5c@linux.dev>
 <20221024115228.GF63658@linux.alibaba.com>
 <662d6804-0e16-117e-d4a4-9abd4a2e8c75@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <662d6804-0e16-117e-d4a4-9abd4a2e8c75@linux.dev>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 09:12:56PM +0800, Yanjun Zhu wrote:
>
>在 2022/10/24 19:52, Dust Li 写道:
>> On Mon, Oct 24, 2022 at 06:15:01AM +0000, yanjun.zhu@linux.dev wrote:
>> > October 24, 2022 9:10 AM, "Dust Li" <dust.li@linux.alibaba.com> wrote:
>> > 
>> > > On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:
>> > > 
>> > > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
>> > > > 
>> > > > There are shared and exclusive modes in RDMA net namespace. After
>> > > > discussion with Leon, the above modes are compatible with legacy IB
>> > > > device.
>> > > > 
>> > > > To the RoCE and iWARP devices, the ib devices should be in the same net
>> > > > namespace with the related net devices regardless of in shared or
>> > > > exclusive mode.
>> > > Does this mean that shared mode is no longer supported for RoCE and iWarp
>> > > devices ?
>> >From the discussion,  a RoCE and iWarp device should make ib devices and net devices in the same net. So a RoCE and iWarp device has no shared/exclusive modes.
>> > Shared/exclusive modes are for legacy ib devices, such as ipoib.
>> > 
>> > In this patch series, shared/exclusive modes are left for legacy ib devices.
>> > To a RoCE and iWarp device, we just keep net devices and ib devices in the same net.
>> I think this may limit the use case of RoCE and iWarp.
>> 
>> See the following use case:
>> In the container enviroment, we may have lots of containers on a host,
>> for example, more than 100. And we don't have that much VFs, so we use
>> ipvlan or other virtual network devices for each container, and put
>> those virtual network devices into each container(net namespace).
>> Since we only use 1 physical network device for all those containers,
>> there is only one RoCE device. If we don't support shared mode, we
>> cannot even enable RDMA for those containers with RoCE.
>
>You use the ipvlan or other virtual network devices for each container.
>
>In these containers, you also use RDMA, correct?
>
>Since all the packets for these virtual network devices finally come to
>
>the physical network devices, without shared/exclusive modes, it should work.
>
>So we do not consider the shared/exclusive mode.

For the netdevice, that's true. But for RDMA, we should not even see
the ib device in the containers any more, so I think we cannot create
qp/cq, and RDMA is not available for these containers in this case.

Thanks



>
>Zhu Yanjun
>
>> 
>> I don't know any other way to solve this, maybe I missed something ?
>> 
>> Thanks
>> 
>> > 
>> > 
>> > > > In the first commit, when the net devices are moved to a new net
>> > > > namespace, the related ib devices are also moved to the same net
>> > > > namespace.
>> > > > 
>> > > > In the second commit, the shared/exclusive modes still work with legacy
>> > > > ib devices. To the RoCE and iWARP devices, these modes will not be
>> > > > considered.
>> > > > 
>> > > > Because MLX4/5 do not call the function ib_device_set_netdev to map ib
>> > > > devices and the related net devices, the function ib_device_get_by_netdev
>> > > > can not get ib devices from net devices. In the third commit, all the
>> > > > registered ib devices are parsed to get the net devices, then compared
>> > > > with the given net devices.
>> > > > 
>> > > > The steps to make tests:
>> > > > 1) Create a new net namespace net0
>> > > > 
>> > > > ip netns add net0
>> > > > 
>> > > > 2) Show the rdma links in init_net
>> > > > 
>> > > > rdma link
>> > > > 
>> > > > "
>> > > > link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
>> > > > "
>> > > > 
>> > > > 3) Move the net device to net namespace net0
>> > > > 
>> > > > ip link set enp7s0np1 netns net0
>> > > > 
>> > > > 4) Show the rdma links in init_net again
>> > > > 
>> > > > rdma link
>> > > > 
>> > > > There is no rdma links
>> > > > 
>> > > > 5) Show the rdma links in net0
>> > > > 
>> > > > ip netns exec net0 rdma link
>> > > > 
>> > > > "
>> > > > link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
>> > > > "
>> > > > 
>> > > > We can confirm that rdma links are moved to the same net namespace with
>> > > > the net devices.
>> > > > 
>> > > > Zhu Yanjun (3):
>> > > > RDMA/core: Move ib device to the same net namespace with net device
>> > > > RDMA/core: The legacy IB devices still work with shared/exclusive mode
>> > > > RDMA/core: Get all the ib devices from net devices
>> > > > 
>> > > > drivers/infiniband/core/device.c | 107 ++++++++++++++++++++++++++++++-
>> > > > 1 file changed, 105 insertions(+), 2 deletions(-)
>> > > > 
>> > > > --
>> > > > 2.27.0
