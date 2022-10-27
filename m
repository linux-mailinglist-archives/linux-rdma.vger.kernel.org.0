Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D860EFBB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ0GBl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJ0GBk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 02:01:40 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C770E6FC6D
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 23:01:38 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666850496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/rOgBAAYVlohy3zuUF2yrEKKj1w3uXGCj7vaJLV93I=;
        b=cANAztIqWl1ou92gKvY0yaTkkKp9Bq3PAcjjdDsof+QDQW93znmdbepFZnGIAJIUoU4Gi6
        Hax2Wdc+kYhB6fg5/RYXG1zruv6jeGnP3YwdSilLtxqLH0fxm84jeo2LGtvTxLIvZnJHUc
        sxn5WO+NFpppLgz/wpnroRha5NOYouM=
Date:   Thu, 27 Oct 2022 06:01:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <7f5ed21ac410646aba93aac875a0d8a8@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     "Parav Pandit" <parav@nvidia.com>, dust.li@linux.alibaba.com,
        "Zhu Yanjun" <yanjun.zhu@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
In-Reply-To: <PH0PR12MB5481AA6E4D5BBAC76E027458DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
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
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 27, 2022 11:48 AM, "Parav Pandit" <parav@nvidia.com> wrote:=0A=0A=
>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>=0A>> Sent: Wednesday=
, October 26, 2022 11:39 PM=0A>> =0A>> October 27, 2022 11:21 AM, "Parav =
Pandit" <parav@nvidia.com> wrote:=0A>> =0A>> From: yanjun.zhu@linux.dev <=
yanjun.zhu@linux.dev>=0A>> Sent: Wednesday, October 26, 2022 11:17 PM=0A>=
> =0A>> October 27, 2022 11:10 AM, "Parav Pandit" <parav@nvidia.com> wrot=
e:=0A>> =0A>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>=0A>> Sent=
: Wednesday, October 26, 2022 11:08 PM=0A>> =0A>> October 27, 2022 11:01 =
AM, "Parav Pandit" <parav@nvidia.com> wrote:=0A>> =0A>> From: Dust Li <du=
st.li@linux.alibaba.com>=0A>> Sent: Wednesday, October 26, 2022 10:31 PM=
=0A>> =0A>> 2. else we are in=0A>> exclusive mode. When the corresponding=
 netdevice of the RoCE or iWarp=0A>> device is moved from one net namespa=
ce to another, we move the RDMA=0A>> device into that net namespace=0A>> =
=0A>> What do you think ?=0A>> =0A>> No. one device is not supposed to mo=
ve other devices.=0A>> Every device is independent that should be moved b=
y explicit command.=0A>> =0A>> Can you show us where we can find this rul=
e "Every device is=0A>> independent that should be moved by explicit comm=
and."?=0A>> =0A>> Also changes like above breaks the existing orchestrati=
on, it no-go.=0A>> =0A>> In a RoCE device, ib device is related with the =
net device. When a=0A>> net device is moved to a new net namespace, if th=
e ib device is not=0A>> in the same net device, how to make ib device wor=
k?=0A>> =0A>> RDMA device should also be moved to the same net namespace =
as that of=0A>> netdev.=0A>> =0A>> sure. I know the following commands.=
=0A>> =0A>> In my commits, the process of moving IB devices to the same n=
et=0A>> namespace with net devices is automatically finished.=0A>> =0A>> =
Is it OK?=0A>> =0A>> No.=0A>> Change like this breaks the user space who =
expect to move the rdma=0A>> device to the net namespace explicitly.=0A>>=
 =0A>> Which specification makes this kind of rule? Where can we find it?=
=0A> =0A> Existing ABI defines this which exists for many years now.=0A=
=0AAbout ABI, I read through this link https://en.wikipedia.org/wiki/Appl=
ication_binary_interface=0A=0ADetails covered by an ABI include the follo=
wing:=0A=0AProcessor instruction set, with details like register file str=
ucture, stack organization, memory access types, etc.=0A=0ASizes, layouts=
, and alignments of basic data types that the processor can directly acce=
ss=0A=0ACalling convention, which controls how the arguments of functions=
 are passed, and return values retrieved; for example, it controls the fo=
llowing:=0A  Whether all parameters are passed on the stack, or some are =
passed in registers=0A  Which registers are used for which function param=
eters=0A  Whether the first function parameter passed on the stack is pus=
hed first or last=0A=0AHow an application should make system calls to the=
 operating system, and if the ABI specifies direct system calls rather th=
an procedure calls to system call stubs, the system call numbers=0A=0AIn =
the case of a complete operating system ABI, the binary format of object =
files, program libraries, etc.=0A=0AAnd I do not find the rule that you m=
entioned.=0A=0A> There is no Linux kernel subsystem or module to my knowl=
edge that attempt to move multiple devices=0A> using single command.=0A> =
When user executes command , user explicitly give device name "foo", only=
 "foo" should move.=0A> Other loosely coupled device whose name is not sp=
ecified in the ip command which has a different=0A> life cycle should not=
 move along with "foo".=0A> =0A> You are trying to define the new rule th=
at breaks the existing ABI and the iproute2 (ip and rdma)=0A> command sem=
antics.=0A> It is implicit that when command is issued on device A, opera=
te on device A. This is part of=0A> iproute2 functioning.=0A=0AAbout ipro=
ute2, I read this link https://wiki.linuxfoundation.org/networking/iprout=
e2#documentation=0A=0AThere is no rules that you mentioned.=0A=0AThis rul=
e is defined explicitly or implicitly?=0A=0AZhu Yanjun=0A> =0A>> It wont =
find the device which got moved as part of some other device=0A>> movemen=
t.=0A>> Currently define scheme covers at least 3 different types of RDMA=
 devices.=0A>> 1. IB and IPoIB=0A>> 2. RoCE=0A>> 3. iWarp=0A>> =0A>> Each=
 has somewhat different relation to their net device.=0A>> =0A>> IPoIB, R=
oCE and iWarp are somewhat different relation to their net device.=0A>> T=
o RoCE and iWarp devices, ib devices should be the same net namespace=0A>=
> with the related net devices.=0A>> Or else we can not make ib devices w=
ork. This is why I send out these=0A>> commits.=0A> =0A> So please move t=
he rdma device also to the desired net namespace and it will work.
