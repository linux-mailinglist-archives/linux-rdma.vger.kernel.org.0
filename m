Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087C72B21A
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjFKNhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 09:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKNhN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 09:37:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8686B8
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 06:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435E660ED6
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 13:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8F1C433D2;
        Sun, 11 Jun 2023 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686490631;
        bh=GIJOQ8txaskJl9U3vspUzmUZPnSUNtkGFTsu43NT5LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHBEFodrtFZ+Iho6qKno5gTD/uVk3lZBs1VTQlehpxW7PC0C/bUKTPFYrpyuORHSk
         f19BU+cspQnGmn+rnga/myyHYX4qDMvHqAMmtagwZMglBFj9wPuWWY30ZjSfk4HWc3
         yeK1n44Wit0d4eUNv/m7tnyP6yl+Ds6ks3DUeRh6yloB2BPBXnEOd43lrMV+aMcT9w
         //8qHdLMTR4UQYXJs0EAY5EcUXE8EUjyfhHf3OMY0CEqz6yK+9kYpyzwS86bfqQ7u/
         1MLzQql/dBhEleNeBD6KFGXoG8G7IQAw6XJ3gdFaVWRbAoQEfkLQ/2SY6dVcjZJQzJ
         NBWPmDDcCMFnA==
Date:   Sun, 11 Jun 2023 16:37:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Message-ID: <20230611133707.GE12152@unreal>
References: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 03, 2023 at 09:46:20AM +0900, Shin'ichiro Kawasaki wrote:
> When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
> *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler().
> To prevent the destroy of id_priv, keep its reference count by calling
> cma_id_get() and cma_id_put() at start and end of cma_iw_handler().

Please add relevant kernel panic to commit message.

> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org

Add Fixes line when you are fixing bug.

> ---
> The BUG KASAN was observed with blktests at test cases nvme/030 or nvme/031,
> using SIW transport [1]. To reproduce it, it is required to repeat the test
> cases from 30 to 50 times on my test system.
> 
> [1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/
> 
>  drivers/infiniband/core/cma.c | 3 +++
>  1 file changed, 3 insertions(+)

The fix looks correct to me.

Thanks
