Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4863595B91
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiHPMQg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiHPMQP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 08:16:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342315727
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 05:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 000B0B8188B
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 12:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE27C433D6;
        Tue, 16 Aug 2022 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660651904;
        bh=xmbeagFPawoW6WIhFGGGbSqGgtixmH8SEQtSX/mLSkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLCgUllGXPZI04BcYUKvHrytqCAtFll6VBX3oEhSpP18gOfVW3jUZIIr2TYn03AN7
         VUcy9uNESHvGoYwkNnaEJKfTu2h9KE7IV5aFsc+7aq0z7l7wuw/DtsooxDdZdgVoJj
         4e2QMBTM+Z7fPPbzF0iP/MRKIdeD2okupQNyRV2NNXbEbzy2gMY3PKUBIkvRA80Kk4
         XI5CaId5mfGX+qUUUOq6kOSxSKMq6NuaZw8ShyowcPoXppFY+9984UUhnlFJ1HnqU3
         X5Oy89HJfMrW1larK5ECAwbdDwixXtbyMw4QDTtbJBVgRxQWM+JPb7paaMh5fDB6m0
         NIb6cGJgl6tWw==
Date:   Tue, 16 Aug 2022 15:11:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Pavel Shamis <Pavel.Shamis@arm.com>
Subject: Re: [PATCH] IB/mlx5: Call io_stop_wc() after writing to WC MMIO
Message-ID: <YvuJfLpcKCvhRw3S@unreal>
References: <0-v1-c5dade92f363+11-mlx5_io_stop_wc_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-c5dade92f363+11-mlx5_io_stop_wc_jgg@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 29, 2022 at 01:33:38PM -0300, Jason Gunthorpe wrote:
> This new function is defined only on ARM and serves to guarantee a barrier
> in the WC operation. The barrier means that another run of this loop will
> not combine with the stores this loop created.
> 
> On x86 this is happening implicitly because of the spin_unlock().
> 
> Suggested-by: "Pavel Shamis" <Pavel.Shamis@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks, applied.
