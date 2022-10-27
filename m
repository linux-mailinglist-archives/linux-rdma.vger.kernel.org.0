Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA460EE4D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ0DHq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiJ0DHo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:07:44 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D9214BB50
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:07:43 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666840061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTlYpbQL5XEuzrgNKWJK/Czs1aoY3Gjw7KK5eDMa5oQ=;
        b=usOck+fkYjmKQcr7Quqpd1rRip70eQo+l9746mVfO5nsjNJhQ+mGYj7NW7LwJ3KfSLFcH4
        AS9Q4cmnGTt2mj+CI3Djsz4NaK0P1hTi69Kb6KhqXekrGOPNyt4bqMlId1DH7VvRgD/qJx
        sfcsDxZydS1CLvKc3LKOsAi50d0Mk1E=
Date:   Thu, 27 Oct 2022 03:07:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     "Parav Pandit" <parav@nvidia.com>, dust.li@linux.alibaba.com,
        "Zhu Yanjun" <yanjun.zhu@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
In-Reply-To: <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 27, 2022 11:01 AM, "Parav Pandit" <parav@nvidia.com> wrote:=0A=0A=
>> From: Dust Li <dust.li@linux.alibaba.com>=0A>> Sent: Wednesday, Octobe=
r 26, 2022 10:31 PM=0A>> =0A>> 2. else we are in=0A>> exclusive mode. Whe=
n the corresponding netdevice of the RoCE=0A>> or iWarp device is moved f=
rom one net namespace to another, we move=0A>> the=0A>> RDMA device into =
that net namespace=0A>> =0A>> What do you think ?=0A> =0A> No. one device=
 is not supposed to move other devices.=0A> Every device is independent t=
hat should be moved by explicit command.=0A=0ACan you show us where we ca=
n find this rule "Every device is independent that should be moved by exp=
licit command."?=0A=0A> =0A> Also changes like above breaks the existing =
orchestration, it no-go.=0A=0AIn a RoCE device, ib device is related with=
 the net device. When a net device is moved=0Ato a new net namespace, if =
the ib device is not in the same net device, how to make ib device work?=
=0A=0AThanks and Regards,=0AZhu Yanjun
