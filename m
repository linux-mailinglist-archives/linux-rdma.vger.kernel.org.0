Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1E657667
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 13:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiL1M2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 07:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiL1M2c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 07:28:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71427BE4;
        Wed, 28 Dec 2022 04:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A00614BC;
        Wed, 28 Dec 2022 12:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69E8C433D2;
        Wed, 28 Dec 2022 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672230510;
        bh=a8qSZ8kNeyt1hXOzWRFUI6os44pceWll+JiIdrCfEOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRPiW8V8NgAgGJnn0blI+Thqcd33duRPmTWjDiC92RPMTExOhdySKdW4WQkCaVmW8
         AspNlmXg/8dlZK1H5Ewi8CuM0j8MU43IuVK5iGOgLoSbw7XQ2ItH6Q92CJF5fElXxO
         YQxIOGbx5KtKWKx9/6kat3ANY0T4Fkgab2ZbHvkH5Ytd4l29v3RtGMZdUdsKz8BPr1
         kKdBz2d1sD9UT51K4DU0O/JozA9F/uVyc0GrIDHLQ9xZ2dDftvH/rOJSLZ5R3Y0+nP
         T1eGrUC+OK2yc+6ajk3td7H16vrZ0GZZf76hDDb9uWtwmqdiKeijaIMoZgHGS+gkwo
         IR+34vyTr4row==
Date:   Wed, 28 Dec 2022 14:28:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Refactor rq inline and add cqe inline
Message-ID: <Y6w2aRPSXAv4s5Pp@unreal>
References: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 24, 2022 at 06:21:58PM +0800, Haoyue Xu wrote:
> The patchset mainly removes the kernel space
> rq inline features and supports cqe inline in user space.
> 
> Luoyouming (3):
>   RDMA/hns: Remove rq inline in kernel
>   RDMA/hns: Add compatibility handling for only support userspace rq
>     inline
>   RDMA/hns: Support cqe inline in user space
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |  19 +---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 109 ++++++--------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  12 +++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  66 +-----------
>  include/uapi/rdma/hns-abi.h                 |   4 +

Your commit messages are too scarce for patches which touch UAPI.
Please add more details about why you deleted, what users should do next
and what are the features you are adding,

Thanks

>  6 files changed, 54 insertions(+), 159 deletions(-)
> 
> -- 
> 2.30.0
> 
