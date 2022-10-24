Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740D8609A5F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJXGQH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJXGPi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 02:15:38 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42836422
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 23:15:04 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666592101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+BKNvfsfrLZQLlRRqsVYkAfll2mjA5nURLPjzFBEXY=;
        b=nZxdX/YvY+8OVxQxD54P10TuXDoe0Cer3r6U5k2Q9/3Hy2DGQWcGMnRhrJXWvl7t+OH2HY
        td8nrSFAxKZZAJqc8S33ekGR8KHZnEtlK2o2dA5PONpTMFLLvgBemJxPoENmCo7rOd5z7H
        ZPAtL6ZuEqu/IK5R6ZIy+kwp6euYujA=
Date:   Mon, 24 Oct 2022 06:15:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <e4b62ef709c43ff7425d9a02efaecc5c@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     dust.li@linux.alibaba.com, "Zhu Yanjun" <yanjun.zhu@intel.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20221024011007.GE63658@linux.alibaba.com>
References: <20221024011007.GE63658@linux.alibaba.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 24, 2022 9:10 AM, "Dust Li" <dust.li@linux.alibaba.com> wrote:=0A=
=0A> On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:=0A> =0A>=
> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> There are shared and=
 exclusive modes in RDMA net namespace. After=0A>> discussion with Leon, =
the above modes are compatible with legacy IB=0A>> device.=0A>> =0A>> To =
the RoCE and iWARP devices, the ib devices should be in the same net=0A>>=
 namespace with the related net devices regardless of in shared or=0A>> e=
xclusive mode.=0A> =0A> Does this mean that shared mode is no longer supp=
orted for RoCE and iWarp=0A> devices ?=0A=0AFrom the discussion,  a RoCE =
and iWarp device should make ib devices and net devices in the same net. =
So a RoCE and iWarp device has no shared/exclusive modes.=0A=0AShared/exc=
lusive modes are for legacy ib devices, such as ipoib. =0A=0AIn this patc=
h series, shared/exclusive modes are left for legacy ib devices.=0ATo a R=
oCE and iWarp device, we just keep net devices and ib devices in the same=
 net.=0A=0A=0A=0A> =0A>> In the first commit, when the net devices are mo=
ved to a new net=0A>> namespace, the related ib devices are also moved to=
 the same net=0A>> namespace.=0A>> =0A>> In the second commit, the shared=
/exclusive modes still work with legacy=0A>> ib devices. To the RoCE and =
iWARP devices, these modes will not be=0A>> considered.=0A>> =0A>> Becaus=
e MLX4/5 do not call the function ib_device_set_netdev to map ib=0A>> dev=
ices and the related net devices, the function ib_device_get_by_netdev=0A=
>> can not get ib devices from net devices. In the third commit, all the=
=0A>> registered ib devices are parsed to get the net devices, then compa=
red=0A>> with the given net devices.=0A>> =0A>> The steps to make tests:=
=0A>> 1) Create a new net namespace net0=0A>> =0A>> ip netns add net0=0A>=
> =0A>> 2) Show the rdma links in init_net=0A>> =0A>> rdma link=0A>> =0A>=
> "=0A>> link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np=
1=0A>> "=0A>> =0A>> 3) Move the net device to net namespace net0=0A>> =0A=
>> ip link set enp7s0np1 netns net0=0A>> =0A>> 4) Show the rdma links in =
init_net again=0A>> =0A>> rdma link=0A>> =0A>> There is no rdma links=0A>=
> =0A>> 5) Show the rdma links in net0=0A>> =0A>> ip netns exec net0 rdma=
 link=0A>> =0A>> "=0A>> link mlx5_0/1 state DOWN physical_state DISABLED =
netdev enp7s0np1=0A>> "=0A>> =0A>> We can confirm that rdma links are mov=
ed to the same net namespace with=0A>> the net devices.=0A>> =0A>> Zhu Ya=
njun (3):=0A>> RDMA/core: Move ib device to the same net namespace with n=
et device=0A>> RDMA/core: The legacy IB devices still work with shared/ex=
clusive mode=0A>> RDMA/core: Get all the ib devices from net devices=0A>>=
 =0A>> drivers/infiniband/core/device.c | 107 +++++++++++++++++++++++++++=
+++-=0A>> 1 file changed, 105 insertions(+), 2 deletions(-)=0A>> =0A>> --=
=0A>> 2.27.0
