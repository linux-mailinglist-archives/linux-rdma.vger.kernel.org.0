Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D05A3D45
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH1LJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1LJ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 07:09:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B297DE8F;
        Sun, 28 Aug 2022 04:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94E13B80184;
        Sun, 28 Aug 2022 11:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2907C433C1;
        Sun, 28 Aug 2022 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661684992;
        bh=FmWsr6bOiZ3HHpJ3Rzlv3W4JSWfY7QjPvk0Fqi5xNLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqhCkSMGJgGy2WqHyTslrXNzcIhJ8jJoKQPo9ZyoJ2oiF5n0nqDu9Ig0UUliQuWFo
         hRWOQJOQ8A3Ei7+0vsDWPl6viopmm8PyIbFv4O3o/89sHcXMgHSPNzkZ5EfbEfRSZ9
         gz+tZ/c3gf05icfdGQvgbyib5GyeNANOx3ygHWep/4K4qRmVk3x1VwrcCuU6dmZwKn
         ky0oiQwtm3foCCUjyLBANv205uqtsfFdpuguauG3cVBFrxlsNukkyRmnw4pBypgwBK
         8Gq+c/jS/VcdI1zQ1CNCcT+Mx28K8lWfrO8KAlCPxvhQWqtkRT2uzmxjyfGGzGF7au
         Gyh5feq/jrDbA==
Date:   Sun, 28 Aug 2022 14:09:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from
 ib_dma_map_sg{,_attrs}
Message-ID: <YwtM+/nB1F6p1Ey3@unreal>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
 <20220826095615.74328-3-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826095615.74328-3-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/core/device.c | 2 +-
>  include/rdma/ib_verbs.h          | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

You forgot to change ib_dma_map_sgtable_attrs() and various
ib_dma_map_sg*() callers.

Thanks
