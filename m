Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600AB60406B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiJSJzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiJSJyc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 05:54:32 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7EE77A8
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 02:30:28 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666170494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEYKiHteXUC5I8dNthD96yttvmKUR2fLRRp8hGzLb60=;
        b=jnpdtV5LL/koQzJgloVhEFQc4jnlcS6FjU6rnEdlS88UWzXdEmCf97zxS7fKJ9daPqSi2U
        Y/gjKZnnwSEk1RMy3/bLFicyzb0RojdK6g/Hqr4kRHTE0ufFIP+I82Si82bjK+3T0fpJVV
        BoSJBi9KdGqDGNzUwOldyRUswqQ3EO4=
Date:   Wed, 19 Oct 2022 09:08:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <556e07a6c331d68845f86e9e0e7cb0c7@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/mlx5: Make mlx5 device work with
 ib_device_get_by_netdev
To:     "Leon Romanovsky" <leon@kernel.org>,
        "Zhu Yanjun" <yanjun.zhu@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <Y05iy+/0BUvbwp5z@unreal>
References: <Y05iy+/0BUvbwp5z@unreal>
 <20221016061925.1831180-1-yanjun.zhu@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 18, 2022 4:24 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=
=0A> On Sun, Oct 16, 2022 at 02:19:25AM -0400, Zhu Yanjun wrote:=0A> =0A>=
> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> Before mlx5 ib devic=
e is registered, the function ib_device_set_netdev=0A>> is not called to =
map the mlx5 ib device with the related net device.=0A>> =0A>> As such, w=
hen the function ib_device_get_by_netdev is called to get ib=0A>> device,=
 NULL is returned.=0A>> =0A>> Other ib devices, such as irdma, rxe and so=
 on, the function=0A>> ib_device_get_by_netdev can get ib device from the=
 related net device.=0A> =0A> Ohh, you opened Pandora box, everything aro=
und it looks half-backed.=0A> =0A> mlx4 and mlx5 don't call to ib_device_=
set_netdev(), because they have=0A> .get_netdev() callback. This callback=
 is not an easy task to eliminate=0A> and many internal attempts failed t=
o eliminate them.=0A> =0A> This caused to very questionable ksmbd_rdma_ca=
pable_netdev()=0A> implementation where ksmbd first checked internal ib_d=
ev callback=0A> and tried to use ib_device_get_by_netdev(). And to smc_ib=
, which=0A> didn't even bother to use ib_device_get_by_netdev().=0A=0ATha=
nks.=0A=0AI read the function ksmbd_rdma_capable_netdev carefully.=0AMlx5=
 and mlx4 do not call ib_device_set_netdev to map net device and ib devic=
es.=0AThis brings a lot of problems. =0A=0AWhen ib devices are needed fro=
m net devices, the callers will handle mlx5/4 and other=0Aib devices diff=
erently.=0A=0AZhu Yanjun=0A=0A> =0A>> Signed-off-by: Zhu Yanjun <yanjun.z=
hu@linux.dev>=0A>> ---=0A>> drivers/infiniband/hw/mlx5/main.c | 18 ++++++=
++++++++++++=0A>> 1 file changed, 18 insertions(+)=0A>> =0A>> diff --git =
a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c=
=0A>> index 883d7c60143e..6899c3f73509 100644=0A>> --- a/drivers/infiniba=
nd/hw/mlx5/main.c=0A>> +++ b/drivers/infiniband/hw/mlx5/main.c=0A>> @@ -1=
68,6 +168,7 @@ static int mlx5_netdev_event(struct notifier_block *this,=
=0A>> u32 port_num =3D roce->native_port_num;=0A>> struct mlx5_core_dev *=
mdev;=0A>> struct mlx5_ib_dev *ibdev;=0A>> + int ret =3D 0;=0A>> =0A>> ib=
dev =3D roce->dev;=0A>> mdev =3D mlx5_ib_get_native_port_mdev(ibdev, port=
_num, NULL);=0A>> @@ -183,6 +184,14 @@ static int mlx5_netdev_event(struc=
t notifier_block *this,=0A> =0A> This is part of the problem, as you are =
setting netdev for IB=0A> representors, and not for simple RoCE flow. The=
re is more cumbersome=0A> multiport flow which needs special logic too.=
=0A> =0A> Thanks=0A> =0A>> if (ndev->dev.parent =3D=3D mdev->device)=0A>>=
 roce->netdev =3D ndev;=0A>> write_unlock(&roce->netdev_lock);=0A>> + if =
(ndev->dev.parent =3D=3D mdev->device) {=0A>> + ret =3D ib_device_set_net=
dev(&ibdev->ib_dev, ndev, port_num);=0A>> + if (ret) {=0A>> + pr_warn("fu=
nc: %s, error: %d\n", __func__, ret);=0A>> + goto done;=0A>> + }=0A>> + }=
=0A>> +=0A>> break;=0A>> =0A>> case NETDEV_UNREGISTER:=0A>> @@ -191,6 +20=
0,15 @@ static int mlx5_netdev_event(struct notifier_block *this,=0A>> if=
 (roce->netdev =3D=3D ndev)=0A>> roce->netdev =3D NULL;=0A>> write_unlock=
(&roce->netdev_lock);=0A>> +=0A>> + if (roce->netdev =3D=3D ndev) {=0A>> =
+ ret =3D ib_device_set_netdev(&ibdev->ib_dev, NULL, port_num);=0A>> + if=
 (ret) {=0A>> + pr_warn("func: %s, error: %d\n", __func__, ret);=0A>> + g=
oto done;=0A>> + }=0A>> + }=0A>> +=0A>> break;=0A>> =0A>> case NETDEV_CHA=
NGE:=0A>> --=0A>> 2.27.0
