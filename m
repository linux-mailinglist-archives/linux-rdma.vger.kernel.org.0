Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7E5F8A89
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Oct 2022 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJIKU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Oct 2022 06:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJIKU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Oct 2022 06:20:58 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1952D746
        for <linux-rdma@vger.kernel.org>; Sun,  9 Oct 2022 03:20:56 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665310853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekUorPffxV0So6u72AR8braQLRKS7ZbvI//cOdl+FtM=;
        b=vISveoP7oh6wN+zk/AQ295FLdj9sohJ3bOB8X42DD9WEKD9u4OT7v7KkXF56EGG0+NIfh8
        9XGrBx0To8IH06dNcczRZOtdt85NwaGdJwqJkdGvCoqD+w2cLgwZOIAHwc40IFYGIOXeA8
        msW2fqLW9sFaU7IZIyqChrlRMYJLhvk=
Date:   Sun, 09 Oct 2022 10:20:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <1c6c286460ac6450d1ae7a93efd4c062@linux.dev>
Subject: Re: [PATCH] rdma: not display the rdma link in other net
 namespace
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Leon Romanovsky" <leo@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
In-Reply-To: <YzPkAGs60Kk4QCck@unreal>
References: <YzPkAGs60Kk4QCck@unreal>
 <20220926024033.284341-1-yanjun.zhu@linux.dev> <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

September 28, 2022 2:04 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=
=0A> On Tue, Sep 27, 2022 at 06:58:50PM +0800, Yanjun Zhu wrote:=0A> =0A>=
> =E5=9C=A8 2022/9/27 18:34, Leon Romanovsky =E5=86=99=E9=81=93:=0A>> On =
Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:=0A>>> =
From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>>> =0A>>> When the net devices=
 are moved to another net namespace, the command=0A>>> "rdma link" should=
 not dispaly the rdma link about this net device.=0A>>> =0A>>> For exampl=
e, when the net device eno12399 is moved to net namespace net0=0A>>> from=
 init_net, the rdma link of eno12399 should not display in init_net.=0A>>=
> =0A>>> Before this change:=0A>>> =0A>>> Init_net:=0A>>> =0A>>> link roc=
eo12399/1 state DOWN physical_state DISABLED <---should not display=0A>>>=
 link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409=0A>=
>> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0=
=0A>>> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens=
7f1=0A>>> =0A>>> net0:=0A>>> =0A>>> link roceo12399/1 state DOWN physical=
_state DISABLED netdev eno12399=0A>>> link roceo12409/1 state DOWN physic=
al_state DISABLED <---should not display=0A>>> link rocep202s0f0/1 state =
DOWN physical_state DISABLED <---should not display=0A>>> link rocep202s0=
f1/1 state ACTIVE physical_state LINK_UP <---should not display=0A>>> =0A=
>>> After this change=0A>>> =0A>>> Init_net:=0A>>> =0A>>> link roceo12409=
/1 state DOWN physical_state DISABLED netdev eno12409=0A>>> link rocep202=
s0f0/1 state DOWN physical_state DISABLED netdev ens7f0=0A>>> link rocep2=
02s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1=0A>>> =0A>>> n=
et0:=0A>>> =0A>>> link roceo12399/1 state DOWN physical_state DISABLED ne=
tdev eno12399=0A>>> =0A>>> Fixes: da990ab40a92 ("rdma: Add link object")=
=0A>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>>> ---=0A>>> r=
dma/link.c | 3 +++=0A>>> 1 file changed, 3 insertions(+)=0A>>> =0A>>> dif=
f --git a/rdma/link.c b/rdma/link.c=0A>>> index bf24b849..449a7636 100644=
=0A>>> --- a/rdma/link.c=0A>>> +++ b/rdma/link.c=0A>>> @@ -238,6 +238,9 @=
@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)=0A>>> =
return MNL_CB_ERROR;=0A>>> }=0A>>> + if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] |=
| !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])=0A>>> + return MNL_CB_OK;=0A>>> +=0A>>=
 Regarding your question where it should go in addition to RDMA, the answ=
er=0A>> is netdev ML. The rdmatool is part of iproute2 and the relevant m=
aintainers=0A>> should be CCed.=0A>> Thanks. I will also send it to netde=
v ML and CC the maintainers.=0A>> =0A>> Regarding the change, I don't thi=
nk that it is right. User space tool is=0A>> a simple viewer of data retu=
rned from the kernel. It is not a mistake to=0A>> return device without n=
etdev.=0A>> =0A>> Normally a rdma link based on RoCEv2 should be with a N=
IC. This NIC device=0A>> =0A>> will send/recv udp packets. With mellanox/=
intel NIC device, this net device=0A>> also=0A>> =0A>> do more work than =
sending/receiving packets.=0A>> =0A>> From this perspective, a rdma link =
is dependent on a net device.=0A>> =0A>> In this problem, net device is m=
oved to another net namespace. So it can not=0A>> be=0A>> =0A>> obtained.=
  And this rdma link can also not work in this net namespace.=0A>> =0A>> =
So this rdma link should not appear in this net namespace. Or else, it wo=
uld=0A>> confuse=0A>> =0A>> the user.=0A>> =0A>> In fact, net namespace i=
s a concept in tcp/ip stack. And it does not exist=0A>> in rdma stack.=0A=
> =0A> RDMA has two different net namespace mode: shared and exclusive.=
=0A> =0A> In shared mode, the IB devices are shared across all net namesp=
aces and=0A> "moving" net device into different namespace just "hides" it=
, but don't=0A> disconnect.=0A=0AHi, Leon=0A=0AAbout RDMA shared and excl=
usive mode, I am confusing about this scenario:=0A=0AIn shared mode, ib d=
evice A is in net namespace A1 while netdev device B is in net namespace =
B1.=0AIB device A is dependent on netdev device B. How to make tests in t=
he above scenario?=0ABoth rping and perftest need a IP address to work. B=
ut now ip address is in net namespace B1 while=0Aib device A is in net na=
mespace A1.=0A=0AIn the product environment, does the above scenario exis=
t?=0A=0AThanks and Regards,=0AZhu Yanjun=0A=0A> =0A> See comments around =
various usages of ib_devices_shared_netns variable.=0A> =0A> Thanks
