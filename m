Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3085460EE1A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiJ0CyI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 22:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiJ0CyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 22:54:06 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901F12792A
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 19:54:04 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666839243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgcHNymQMMfq3SFutF5Cp+3KyFhDzD0cX1zzJc8tlt8=;
        b=WDkIackZm6yqyOVCWrknBHMVGMMa6/1UZyoKVi5ZcuRp9LBU8DOHclmpEK+4oOhGmOkgJI
        IIKtQKNpMNC9aFShZUJBw8cOhHlgKM8B/MUsd9vGxI5H3mfOSLHFG4d17kZOyshTaGh124
        LqMR1g24IyFjUWVgKbLmi5sgycZ1ph8=
Date:   Thu, 27 Oct 2022 02:54:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <a00f663f0b3967a0e6954dafa547099e@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     dust.li@linux.alibaba.com, "Zhu Yanjun" <yanjun.zhu@intel.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20221027023055.GH56517@linux.alibaba.com>
References: <20221027023055.GH56517@linux.alibaba.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 27, 2022 10:30 AM, "Dust Li" <dust.li@linux.alibaba.com> wrote:=
=0A=0A> On Wed, Oct 26, 2022 at 11:01:13PM +0800, Dust Li wrote:=0A> =0A>=
> On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:=0A>>> From:=
 Zhu Yanjun <yanjun.zhu@linux.dev>=0A>>> =0A>>> There are shared and excl=
usive modes in RDMA net namespace. After=0A>>> discussion with Leon, the =
above modes are compatible with legacy IB=0A>>> device.=0A>>> =0A>>> To t=
he RoCE and iWARP devices, the ib devices should be in the same net=0A>>>=
 namespace with the related net devices regardless of in shared or=0A>>> =
exclusive mode.=0A>>> =0A>>> In the first commit, when the net devices ar=
e moved to a new net=0A>>> namespace, the related ib devices are also mov=
ed to the same net=0A>>> namespace.=0A>>> =0A>>> In the second commit, th=
e shared/exclusive modes still work with legacy=0A>>> ib devices. To the =
RoCE and iWARP devices, these modes will not be=0A>>> considered.=0A>>> =
=0A>>> Because MLX4/5 do not call the function ib_device_set_netdev to ma=
p ib=0A>>> devices and the related net devices, the function ib_device_ge=
t_by_netdev=0A>>> can not get ib devices from net devices. In the third c=
ommit, all the=0A>>> registered ib devices are parsed to get the net devi=
ces, then compared=0A>>> with the given net devices.=0A>>> =0A>>> The ste=
ps to make tests:=0A>>> 1) Create a new net namespace net0=0A>>> =0A>>> i=
p netns add net0=0A>>> =0A>>> 2) Show the rdma links in init_net=0A>>> =
=0A>>> rdma link=0A>>> =0A>>> "=0A>>> link mlx5_0/1 state DOWN physical_s=
tate DISABLED netdev enp7s0np1=0A>>> "=0A>>> =0A>>> 3) Move the net devic=
e to net namespace net0=0A>>> =0A>>> ip link set enp7s0np1 netns net0=0A>=
>> =0A>>> 4) Show the rdma links in init_net again=0A>>> =0A>>> rdma link=
=0A>>> =0A>>> There is no rdma links=0A>> =0A>> Follow your steps, after =
step 3), I cannot reproduce this,=0A>> `rdma link` running in init_net st=
ill show the link.=0A>> =0A>> I'm testing on a VM with ConnectX-4Lx, SRIO=
V enabled, and VF is passthroughed=0A>> to the VM.=0A>> =0A>> Anything I =
missed ?=0A> =0A> Hi Zhu:=0A> =0A> I think I know what's wrong here.=0A> =
=0A> With your patch, if I put the netdevice from init_net into another=
=0A> net_namespace(say ns0), the RDMA device is not moved, and `rdma link=
`=0A> can't see the RDMA device in ns0(We can see it if we are in shared =
mode)=0A=0A=0AYes. This should move rdma device to ns0, the same net name=
space with the net device.=0A=0AI use the following device to make tests.=
 It can work well.=0A"=0AEthernet controller: Mellanox Technologies MT278=
00 Family [ConnectX-5]=0A"=0AAnd the driver is drivers/infiniband/hw/mlx5=
.=0A=0AYou are using ConnectX-4Lx. Can you let me know which driver is us=
ed?=0A=0AThanks and Regards,=0AZhu Yanjun=0A=0A> =0A> I think this is not=
 the correct behaviour.=0A> =0A> Maybe we should do:=0A> 1. If we are in =
shared mode, keep the current behaviour=0A> 2. else we are in exclusive m=
ode. When the corresponding netdevice of the RoCE=0A> or iWarp device is =
moved from one net namespace to another, we move the=0A> RDMA device into=
 that net namespace=0A> =0A> What do you think ?=0A> =0A> Thanks.=0A> =0A=
>>> 5) Show the rdma links in net0=0A>>> =0A>>> ip netns exec net0 rdma l=
ink=0A>>> =0A>>> "=0A>>> link mlx5_0/1 state DOWN physical_state DISABLED=
 netdev enp7s0np1=0A>>> "=0A>>> =0A>>> We can confirm that rdma links are=
 moved to the same net namespace with=0A>>> the net devices.=0A>>> =0A>>>=
 Zhu Yanjun (3):=0A>>> RDMA/core: Move ib device to the same net namespac=
e with net device=0A>>> RDMA/core: The legacy IB devices still work with =
shared/exclusive mode=0A>>> RDMA/core: Get all the ib devices from net de=
vices=0A>>> =0A>>> drivers/infiniband/core/device.c | 107 +++++++++++++++=
+++++++++++++++-=0A>>> 1 file changed, 105 insertions(+), 2 deletions(-)=
=0A>>> =0A>>> --=0A>>> 2.27.0
