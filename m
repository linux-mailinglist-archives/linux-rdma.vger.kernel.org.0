Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0445FD639
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJMIai (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJMIah (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 04:30:37 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F0537CA
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 01:30:34 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665649832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/X/TZFeKPXriPKxbhVLZS3/VUO+FezaLtEEGc30HhU=;
        b=GdLN3+sUL4Qba4cMn8omg1EzwtZ9laaPR+2gRFav3cExq7J8Qu85MpOp5TQLomy9o6EeoS
        bm1y+BzceKdTZpdFwgEbS/2YQLwV9zKKrgxFhwf9cSRKQenpxZ8wi9Tn8qzoIHhv9ia7gk
        rArUew8RLGTXyGMHCExnn3+85olSCwg=
Date:   Thu, 13 Oct 2022 08:30:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <fb9fed08d43ed53ccc8ae34e60d707f2@linux.dev>
Subject: Re: [RFC PATCH 1/1] RDMA/core: Fix a problem from rdma link in
 exclusive mode
To:     "Leon Romanovsky" <leon@kernel.org>,
        "Zhu Yanjun" <yanjun.zhu@intel.com>
Cc:     jgg@nvidia.com, leo@kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <0c399db3-a9a6-0b07-fb99-060c3bba418b@linux.dev>
References: <0c399db3-a9a6-0b07-fb99-060c3bba418b@linux.dev>
 <Yz/FaiYZO5Y0R7QP@unreal> <20221011002545.1410247-1-yanjun.zhu@intel.com>
 <Y0VBhhhSfzRQ8GY9@unreal>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 11, 2022 11:08 PM, "Yanjun Zhu" <yanjun.zhu@linux.dev> wrote:=0A=
=0A> =E5=9C=A8 2022/10/11 18:12, Leon Romanovsky =E5=86=99=E9=81=93:=0A> =
=0A>> On Mon, Oct 10, 2022 at 08:25:45PM -0400, Zhu Yanjun wrote:=0A>>> F=
rom: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>>> =0A>>> This is not an offici=
al commit. In rdma net namespace, the rdma device=0A>>> is separate from =
the net device. For example, a rdma device A is in net=0A>>> namespace A1=
 while the related net device B is in net namespace B1.=0A>>> =0A>>> I am=
 curious how to make perftest and rping tests on the above=0A>>> scenario=
. The ip address of net device B is in net namespace B1=0A>>> while the r=
dma device is in net namespace A1.=0A>> =0A>> Use "exclusive" mode, "shar=
ed" is legacy interface for backward=0A>> compatibility.=0A> =0A> Got it.=
 Thanks.=0A> =0A>>> From my perspective, the rdma device and related net =
device should=0A>>> be in the same net namespace. When a net device is mo=
ved from one net=0A>>> namespace to another net namespace, the rdma devic=
e should be in the=0A>>> same net namespace with the net device.=0A>>> =
=0A>>> In this commit, when all the ib devices are parsed in exclusive mo=
de,=0A>>> if the ib devices and related net devices are not in the same n=
et=0A>>> namespace, the link information will not be reported to user spa=
ce.=0A>>> =0A>>> This commit is a RFC.=0A>> =0A>> Please don't send patch=
es as reply-to.=0A> =0A> OK. I will send another commit to fix this probl=
em very soon.=0A=0AHi, Leon=0A=0APer discussion, to the non-legacy ib dev=
ice, when the net devices are moved from one net namespace to another net=
 namespace, the related  ib devices are also moved to the new net namespa=
ce.=0A=0ATo the legacy ib device, shared/exclusive mode still work with t=
hem.=0A=0ABased on the above, 2 patches are implemented. I will send them=
 out very soon.=0A=0AThanks and Regards,=0AZhu Yanjun=0A=0A> =0A> Zhu Yan=
jun=0A> =0A>> Thanks
