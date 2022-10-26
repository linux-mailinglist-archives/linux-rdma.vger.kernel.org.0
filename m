Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36F860E3FC
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiJZPB0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiJZPBU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 11:01:20 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E56EA3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 08:01:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VT7gBUw_1666796474;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VT7gBUw_1666796474)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 23:01:15 +0800
Date:   Wed, 26 Oct 2022 23:01:13 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH 0/3] RDMA net namespace
Message-ID: <20221026150113.GG56517@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20221023220450.2287909-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023220450.2287909-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:
>From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
>There are shared and exclusive modes in RDMA net namespace. After
>discussion with Leon, the above modes are compatible with legacy IB
>device. 
>
>To the RoCE and iWARP devices, the ib devices should be in the same net
>namespace with the related net devices regardless of in shared or
>exclusive mode.
>
>In the first commit, when the net devices are moved to a new net
>namespace, the related ib devices are also moved to the same net
>namespace.
>
>In the second commit, the shared/exclusive modes still work with legacy
>ib devices. To the RoCE and iWARP devices, these modes will not be
>considered.
>
>Because MLX4/5 do not call the function ib_device_set_netdev to map ib
>devices and the related net devices, the function ib_device_get_by_netdev
>can not get ib devices from net devices. In the third commit, all the
>registered ib devices are parsed to get the net devices, then compared
>with the given net devices.
>
>The steps to make tests:
>1) Create a new net namespace net0
>
>   ip netns add net0
>
>2) Show the rdma links in init_net
>
>   rdma link
>
>   "
>   link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
>   "
>
>3) Move the net device to net namespace net0
>
>   ip link set enp7s0np1 netns net0
>
>4) Show the rdma links in init_net again
>
>   rdma link
>
>   There is no rdma links

Follow your steps, after step 3), I cannot reproduce this,
`rdma link` running in init_net still show the link.

I'm testing on a VM with ConnectX-4Lx, SRIOV enabled, and VF is passthroughed
to the VM.

Anything I missed ?

>
>5) Show the rdma links in net0
>
>   ip netns exec net0 rdma link
>
>   "
>   link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
>   "
>
>We can confirm that rdma links are moved to the same net namespace with
>the net devices.
>
>Zhu Yanjun (3):
>  RDMA/core: Move ib device to the same net namespace with net device
>  RDMA/core: The legacy IB devices still work with shared/exclusive mode
>  RDMA/core: Get all the ib devices from net devices
>
> drivers/infiniband/core/device.c | 107 ++++++++++++++++++++++++++++++-
> 1 file changed, 105 insertions(+), 2 deletions(-)
>
>-- 
>2.27.0
