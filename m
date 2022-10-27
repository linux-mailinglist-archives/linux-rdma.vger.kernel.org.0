Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08E60EEB8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiJ0DjM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiJ0DjK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:39:10 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8936525B
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:39:09 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666841948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMDLx1Oh3hw0TpF05tSQsUzMb4XGQu+aWuV0nzZra0U=;
        b=rtONmpLzmRE7ldwvZSrKwfskcJZayBzSuPkVhzIZmnau4Q5iRfGbCGwzCzV/BsJyiCyZVM
        F6ZvLfZ/o0Qw3M+1KNUwfWnQk1vOFEOglLe1UBslqhVoiU/Kr+szvVRvYVJVxBaQtNNjiX
        2QP/pkqU2ZsjkAsj7I78dAHOzf7UV6M=
Date:   Thu, 27 Oct 2022 03:39:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     "Parav Pandit" <parav@nvidia.com>, dust.li@linux.alibaba.com,
        "Zhu Yanjun" <yanjun.zhu@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
In-Reply-To: <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 27, 2022 11:21 AM, "Parav Pandit" <parav@nvidia.com> wrote:=0A=0A=
>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>=0A>> Sent: Wednesday=
, October 26, 2022 11:17 PM=0A>> =0A>> October 27, 2022 11:10 AM, "Parav =
Pandit" <parav@nvidia.com> wrote:=0A>> =0A>> From: yanjun.zhu@linux.dev <=
yanjun.zhu@linux.dev>=0A>> Sent: Wednesday, October 26, 2022 11:08 PM=0A>=
> =0A>> October 27, 2022 11:01 AM, "Parav Pandit" <parav@nvidia.com> wrot=
e:=0A>> =0A>> From: Dust Li <dust.li@linux.alibaba.com>=0A>> Sent: Wednes=
day, October 26, 2022 10:31 PM=0A>> =0A>> 2. else we are in=0A>> exclusiv=
e mode. When the corresponding netdevice of the RoCE or iWarp=0A>> device=
 is moved from one net namespace to another, we move the RDMA=0A>> device=
 into that net namespace=0A>> =0A>> What do you think ?=0A>> =0A>> No. on=
e device is not supposed to move other devices.=0A>> Every device is inde=
pendent that should be moved by explicit command.=0A>> =0A>> Can you show=
 us where we can find this rule "Every device is=0A>> independent that sh=
ould be moved by explicit command."?=0A>> =0A>> Also changes like above b=
reaks the existing orchestration, it no-go.=0A>> =0A>> In a RoCE device, =
ib device is related with the net device. When a=0A>> net device is moved=
 to a new net namespace, if the ib device is not=0A>> in the same net dev=
ice, how to make ib device work?=0A>> =0A>> RDMA device should also be mo=
ved to the same net namespace as that of=0A>> netdev.=0A>> =0A>> sure. I =
know the following commands.=0A>> =0A>> In my commits, the process of mov=
ing IB devices to the same net namespace=0A>> with net devices is automat=
ically finished.=0A>> =0A>> Is it OK?=0A> =0A> No.=0A> Change like this b=
reaks the user space who expect to move the rdma device to the net namesp=
ace=0A> explicitly.=0A=0AWhich specification makes this kind of rule? Whe=
re can we find it?=0A=0A> It wont find the device which got moved as part=
 of some other device movement.=0A> Currently define scheme covers at lea=
st 3 different types of RDMA devices.=0A> 1. IB and IPoIB=0A> 2. RoCE=0A>=
 3. iWarp=0A> =0A> Each has somewhat different relation to their net devi=
ce.=0A=0AIPoIB, RoCE and iWarp are somewhat different relation to their n=
et device.=0ATo RoCE and iWarp devices, ib devices should be the same net=
 namespace with the related net devices.=0AOr else we can not make ib dev=
ices work. This is why I send out these commits.=0A=0AZhu Yanjun
