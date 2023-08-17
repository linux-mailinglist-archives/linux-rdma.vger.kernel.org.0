Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9F77FC88
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351875AbjHQRHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Aug 2023 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353390AbjHQRHl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Aug 2023 13:07:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77AF2D7D
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 10:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5565061E59
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 17:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC92C433C8;
        Thu, 17 Aug 2023 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292059;
        bh=2wU4cKYIgP5FP10GyCwuEAukuMkjE78VAXk4uBUtHGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCPAlFC9/hV5+YdX3zgD4JP3debIIojlnOipL7GBHwQmCGVz2kXoAB2of0TMoUEGJ
         QPwswOkW6xcGaE6nuSE23mo8R8zAJSx5hV7VGAgmJmRyuYVxW2Ue96TVSEkEBvrRz0
         8mMsytbTJmot2gYc7sUy3fAQ3zuTqmaUoOl0urDwQflQw2b6kowiUlDMxjFZtGcO4G
         a2wSe0cN+oEIcr88/Dt8Nv9nQhikUWpIEybqta6npGifycPTrX94b6q91jO+qVAeug
         SHi7z0v5jW8zc+zKzdoAapDPl27yi7yWZl0PWBVZf9LJprJQ7a3rYPcKyNzY/SWUI8
         SKm4HHH4A90ng==
Date:   Thu, 17 Aug 2023 20:07:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 2/3] RDMA/erdma: Refactor the storage structure
 of MTT entries
Message-ID: <20230817170735.GP22185@unreal>
References: <20230817102151.75964-1-chengyou@linux.alibaba.com>
 <20230817102151.75964-3-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817102151.75964-3-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 17, 2023 at 06:21:50PM +0800, Cheng Xu wrote:
> Currently our MTT only support inline mtt entries (0 level MTT) and
> indirect MTT entries (1 level mtt), which will limit the maximum length
> of MRs. In order to implement a multi-level MTT, we refactor the
> structure of MTT first.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_hw.h    |   4 +-
>  drivers/infiniband/hw/erdma/erdma_qp.c    |   2 +-
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 214 +++++++++++++---------
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  26 ++-
>  4 files changed, 152 insertions(+), 94 deletions(-)

<...>

> +/* Hierarchical storage structure for MTT entries */
> +struct erdma_mtt {
> +	u64 *buf;
> +	size_t size;
> +
> +	bool continuous;
> +	union {
> +		dma_addr_t buf_dma;
> +		struct {
> +			struct scatterlist *sglist;
> +			u32 nsg;
> +			u32 level;
> +		};
> +	};
> +
> +	struct erdma_mtt *low_level;

This variable is used in third patch only, but please don't resubmit yet.

Thanks
