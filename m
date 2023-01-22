Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B0676CAE
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jan 2023 13:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAVMMj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Jan 2023 07:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVMMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Jan 2023 07:12:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423018176;
        Sun, 22 Jan 2023 04:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D8C7B80A89;
        Sun, 22 Jan 2023 12:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D2BC433D2;
        Sun, 22 Jan 2023 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674389554;
        bh=qZf9DjyIr6Sqezxh73qyreUJPanVpb5ENsMfdqxZy4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOmziaen35IJzgl7/2at5t7ytjIU6Y2ez0+5YAIalgjZlBZYb7zor01lcZaZ4I2xN
         v7mAecjZ8EWGQxyP1xyK1pdz+lalZxgSneEU4QqomLom6VEI+HlQtRiOIVwhn3gvtD
         zcPtZ5540NO7pZeNKhC3T/tJlkEXFErNCiNqdSwCjLDLYque8iqggacAPrS1FX/fiK
         2TBMDzzTpYwpVQCYg/sA9IYtqy1DgavD7BMekDApajg+ibx8P/nze8NQHXiL5pH4Ry
         48Ktp6i9NeE+xyHFfEODeqc3ehQoHlwEhCOYgkp5KdlolE3pojvXi3f3lkq8zGkBiB
         MRddXYrvdGnXw==
Date:   Sun, 22 Jan 2023 14:12:30 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Refactor rq inline and add cqe inline
Message-ID: <Y80oLiJEDOyywRLU@unreal>
References: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
 <Y6w2aRPSXAv4s5Pp@unreal>
 <6aa101b0-970e-9331-4819-7202b6c2bfcf@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa101b0-970e-9331-4819-7202b6c2bfcf@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 20, 2023 at 05:14:53PM +0800, xuhaoyue (A) wrote:
> On 2022/12/28 20:28:25, Leon Romanovsky wrote:
> > On Sat, Dec 24, 2022 at 06:21:58PM +0800, Haoyue Xu wrote:
> >> The patchset mainly removes the kernel space
> >> rq inline features and supports cqe inline in user space.
> >>
> >> Luoyouming (3):
> >>   RDMA/hns: Remove rq inline in kernel
> >>   RDMA/hns: Add compatibility handling for only support userspace rq
> >>     inline
> >>   RDMA/hns: Support cqe inline in user space
> >>
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |  19 +---
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 109 ++++++--------------
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +-
> >>  drivers/infiniband/hw/hns/hns_roce_main.c   |  12 +++
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  66 +-----------
> >>  include/uapi/rdma/hns-abi.h                 |   4 +
> > 
> > Your commit messages are too scarce for patches which touch UAPI.
> > Please add more details about why you deleted, what users should do next
> > and what are the features you are adding,
> > 
> > Thanks
> > 
> >>  6 files changed, 54 insertions(+), 159 deletions(-)
> >>
> >> -- 
> >> 2.30.0
> >>
> > .
> > 
> 
> Hi Leon,
> Sorry for the late response.
> 
> The cqe inline feature works as follows: payloads less than or equal to 32 bytes will be placed in the cqe, and the hardware will no longer need to access the pbl table and move the payload data.
> Instead, the driver will move the payload to the user data space, which is conducive to improving the latency performance of the send/receive operation.
> If rq inline and cqe inline are enabled at the same time, the data packet whose payload length is less than or equal to 32 bytes uses the cqe inline feature,
> and the data packet greater than 32 bytes and less than or equal to 1024 bytes uses the rq inline feature.
> 
> For the reason of deleting kernel space rq inline, Since no user currently uses kernel-mode rq inline, then only supports user-mode rq inline in further plans.
> To reduce maintenance, remove unsupported kernel state rq inline-related code.
> I will add this to the user-space patch if this explanation is ok?

Thank you for the explanation.

Thanks

> 
> Sincerely,
> Haoyue
