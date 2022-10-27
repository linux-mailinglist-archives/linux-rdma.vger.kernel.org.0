Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FFC60EE72
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiJ0DRZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiJ0DRV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:17:21 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BD5140E41
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:17:20 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666840639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mECRNdBOVH+Fo7htoA7DhT7rk8UsUrBNtHu/irqjhpE=;
        b=odRRZ3FyRZWp9gqnBU+mISUQQH0jKM3Ux1Iz2EGtelj5Tcs7MajoyBgJwjhWOMwJhZiMkD
        hGwm0FMPwBB1XaWi5W6oHsb4YhQIK9RcMwQGgK10OGyBTgzhhpXilVPeDUKAPmcE8vF/Kk
        dsczeWBqfGU3/so4oiuIEipluS+NxNk=
Date:   Thu, 27 Oct 2022 03:17:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     "Parav Pandit" <parav@nvidia.com>, dust.li@linux.alibaba.com,
        "Zhu Yanjun" <yanjun.zhu@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
In-Reply-To: <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 27, 2022 11:10 AM, "Parav Pandit" <parav@nvidia.com> wrote:=0A=0A=
>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>=0A>> Sent: Wednesday=
, October 26, 2022 11:08 PM=0A>> =0A>> October 27, 2022 11:01 AM, "Parav =
Pandit" <parav@nvidia.com> wrote:=0A>> =0A>> From: Dust Li <dust.li@linux=
.alibaba.com>=0A>> Sent: Wednesday, October 26, 2022 10:31 PM=0A>> =0A>> =
2. else we are in=0A>> exclusive mode. When the corresponding netdevice o=
f the RoCE or iWarp=0A>> device is moved from one net namespace to anothe=
r, we move the RDMA=0A>> device into that net namespace=0A>> =0A>> What d=
o you think ?=0A>> =0A>> No. one device is not supposed to move other dev=
ices.=0A>> Every device is independent that should be moved by explicit c=
ommand.=0A>> =0A>> Can you show us where we can find this rule "Every dev=
ice is independent=0A>> that should be moved by explicit command."?=0A>> =
=0A>> Also changes like above breaks the existing orchestration, it no-go=
.=0A>> =0A>> In a RoCE device, ib device is related with the net device. =
When a net device=0A>> is moved to a new net namespace, if the ib device =
is not in the same net=0A>> device, how to make ib device work?=0A> =0A> =
RDMA device should also be moved to the same net namespace as that of net=
dev.=0A=0Asure. I know the following commands.=0A=0AIn my commits, the pr=
ocess of moving IB devices to the same net namespace with net devices is =
automatically finished.=0A=0AIs it OK?=0A=0AZhu Yanjun=0A=0A> =0A> Steps =
should be,=0A> =0A> $ rdma system set netns exclusive=0A> $ ip netns add =
NSNAME=0A> $ ip link set [NETDEV] netns NSNAME=0A> $ rdma dev set [ RDMA_=
DEV ] netns NSNAME
