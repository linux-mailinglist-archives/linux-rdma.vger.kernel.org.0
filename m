Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7641595E27
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiHPOO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiHPOO2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 10:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88089901AD;
        Tue, 16 Aug 2022 07:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3072461011;
        Tue, 16 Aug 2022 14:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6931C433D6;
        Tue, 16 Aug 2022 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660659266;
        bh=EqGCBYyQrzDGG+Rj9eP7WOEAaOjJVvNTKkQcHlotY9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyTxYdKC4fPXXkM4Ze30lTcYMGnXKBkdAlvzwqQutesClMRHmQ95iy4Lv095RTeqH
         N6kplPKn8OKcyb8zkGzCBbhdTJulf6WagtrSSAD69mhw49m8J+B790l6Tv+z3cXB8V
         TlE3beoibvxeYJ2MSt0gbMFQ9LImjk/BnLGpMb9TzdIu6kW49YbtGcI3qSlR5Rsh35
         Int841UvDdpyNVACp7pKYNXFJcOhAj7CH/NeSo+CFbruppGwQgx+VkuKM2gVEURjZl
         PbAgPP51GV64FtjfTyXhFlNFNLSSN/bM+AiTzV/v3e6Arl0KzkRoQTlehRCH8qaW5Z
         /jmuwPwc7fRbw==
Date:   Tue, 16 Aug 2022 17:14:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rc] RDMA: Handle the return code from
 dma_resv_wait_timeout() properly
Message-ID: <YvumPtoM1FpOQBey@unreal>
References: <0-v1-d8f4e1fa84c8+17-rdma_dmabuf_fix_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-d8f4e1fa84c8+17-rdma_dmabuf_fix_jgg@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 16, 2022 at 11:03:20AM -0300, Jason Gunthorpe wrote:
> ib_umem_dmabuf_map_pages() returns 0 on success and -ERRNO on failure.
> 
> dma_resv_wait_timeout() uses a different scheme:
> 
>  * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or
>  * greater than zero on success.
> 
> This results in ib_umem_dmabuf_map_pages() being non-functional as a
> positive return will be understood to be an error by drivers.
> 
> Fixes: f30bceab16d1 ("RDMA: use dma_resv_wait() instead of extracting the fence")
> Cc: stable@kernel.org
> Tested-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem_dmabuf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Thanks, applied to -rc.
