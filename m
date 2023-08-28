Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8269578B6F6
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Aug 2023 20:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjH1SDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Aug 2023 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjH1SDS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Aug 2023 14:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893210D;
        Mon, 28 Aug 2023 11:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC7A645A0;
        Mon, 28 Aug 2023 18:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D55C433C7;
        Mon, 28 Aug 2023 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693245795;
        bh=56VgGQnJgxLhXEe7cwBuaAX3o2oK/hHDJmk8oFYmWUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prGCJo0nyHC8hEQHqXmAzPWQSZFeNCzij3e3IVwxBoGhRSw+iqxWaearLadWk713A
         RxD6ddaVj5TKSgLvtRHyaU4l85LUQ7qwMFGEnqyaZEJ9DV0Z1po+UQt7WiHEzZPM60
         fF7dEZ8hVix/Qw9WFxbywRdEFHfx8TmXC87qYGPuI60ZXlzGXe57yItJlEfAXTprh7
         +GLji62zceQbxHHpLzC3/XwA50zLI89t+9R6nYW8UURh1EUTSE/kuLejZwNtQ7yR2o
         4wgRG0lw+yyzGpyc10MSS85I6E6req4SQACJPBgB4lJPkzMbD89D/JzcOCrnlD0dXU
         CinaVi2nKQ2aA==
Date:   Mon, 28 Aug 2023 21:03:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org,
        Michael Margolin <mrgolin@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Add more debugging information
 for rdma-tool
Message-ID: <20230828180310.GR6029@unreal>
References: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
 <20230819113212.GN22185@unreal>
 <7c94dd6a-4fab-10dc-b0bb-2d9caa16a148@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c94dd6a-4fab-10dc-b0bb-2d9caa16a148@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 24, 2023 at 03:58:15PM +0800, Junxian Huang wrote:
> 
> 
> On 2023/8/19 19:32, Leon Romanovsky wrote:
> > On Wed, Aug 16, 2023 at 05:18:09PM +0800, Junxian Huang wrote:
> >> 1. #1: The first patch supports dumping QP/CQ/MR context entirely in raw
> >>        data with rdma-tool.
> >>
> >> 2. #2: The second patch supports query of HW stats with rdma-tool.
> >>
> >> 3. #3: The last patch supports query of SW stats with rdma-tool.
> >>
> >> Chengchang Tang (3):
> >>   RDMA/hns: Dump whole QP/CQ/MR resource in raw
> >>   RDMA/hns: Support hns HW stats
> > 
> > These two patches generate static analyzer warnings.
> > ➜  kernel git:(wip/leon-for-next) mkt ci --rev 0a68261bbbe5
> > 0a68261bbbe5 (HEAD -> build) RDMA/hns: Dump whole QP/CQ/MR resource in raw
> > WARNING: 'informations' may be misspelled - perhaps 'information'?
> > #7:
> > rdma-tool, but these informations are not enough. It is very
> >                      ^^^^^^^^^^^^
> > ➜  kernel git:(wip/leon-for-next) mkt ci
> > 5a87279591a1 (HEAD -> build) RDMA/hns: Support hns HW stats
> > drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1651:35: warning: restricted __le16 degrades to integer
> > 
> 
> OK，I'll fix them in V2.
> 
> >>   RDMA/hns: Support hns SW stats
> > 
> > This is not support SW stats, but actually implementation of SW
> > statistics which you exposed through rdmatool. That tool is
> 
> Yes,
> 
> > not right place for such information and debugfs will be better
> > fit.
> > 
> > Thanks
> > 
> 
> but from what I have seen, efa and bnxt_re drivers also use rdmatool
> to expose SW statisics.

I afraid that it was missed in review.

> 
> And could you please explain why rdmatool is not suitable for this?

IMHO, SW statistics are too broad and too coupled with the code to be
really useful in rdmatool.

Let's take an example, your newly added counter in modify QP.
It counts number of failure in hns_roce_modify_qp(), but that
function returns error in such case and users will see it anyway.

So what will give this newly added counter in addition to already known
by users? The answer is nothing and that answer is almost always applicable
to SW statistics.

It is unlikely that we can remove from EFA and bnxt_re already added
counters, but if we can, it will be great.

Thanks

> 
> Junxian
> 
> >>
> >>  drivers/infiniband/hw/hns/hns_roce_ah.c       |   6 +-
> >>  drivers/infiniband/hw/hns/hns_roce_cmd.c      |  19 ++-
> >>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  15 +-
> >>  drivers/infiniband/hw/hns/hns_roce_device.h   |  50 ++++++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  59 +++++++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
> >>  drivers/infiniband/hw/hns/hns_roce_main.c     | 152 +++++++++++++++++-
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  26 ++-
> >>  drivers/infiniband/hw/hns/hns_roce_pd.c       |  10 +-
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c       |   8 +-
> >>  drivers/infiniband/hw/hns/hns_roce_restrack.c |  75 +--------
> >>  drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
> >>  12 files changed, 325 insertions(+), 102 deletions(-)
> >>
> >> --
> >> 2.30.0
> >>
