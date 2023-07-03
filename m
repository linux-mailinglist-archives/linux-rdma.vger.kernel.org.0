Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A0745D81
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGCNdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjGCNdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 09:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83310EA;
        Mon,  3 Jul 2023 06:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8765660F29;
        Mon,  3 Jul 2023 13:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AB0C433C8;
        Mon,  3 Jul 2023 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688391166;
        bh=pk+2FTd4Zcg93LZyEvVLp7It0/fYBTya/f/EBtYUFN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9ktR5ETbn+AAXn7P5ssFOFeAqcEeGK2LBn0WnJKo/tGi1/Hv6mWs2mxeso8jixCF
         RTwKY54tdXE/kGBekc9qC3EbJjJUhwE1fgcy5d6Mc8uJDTxyLsAwOU3Z2GpdW5TWLW
         go4R7lRZiQYwtq/cg1g4ZTb8bzDGC2EXvudt6dLERIOZhNT0D/6r97V7wY6npYXQHB
         FmIeu2KkwEKzrA/PgMeCZSjXUP/1bHOzCpbiJPBXqGhJkLhI/Tpy1s0GC35cpPpDJm
         eOlRROvlPEdkb/UR7khuqdS2lDeLRbivg0IwWcq4eg0rXDXJSdOZzBkUY+PjplMYyo
         FoNpdJ5T0E/wA==
Date:   Mon, 3 Jul 2023 16:32:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: fix INFINIBAND_USER_ACCESS dependency
Message-ID: <20230703133242.GB32152@unreal>
References: <20230703113025.356682-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703113025.356682-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 03, 2023 at 01:30:06PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After a change to the bnxt_re driver, it fails to link when
> CONFIG_INFINIBAND_USER_ACCESS is disabled:
> 
> aarch64-linux-ld: drivers/infiniband/hw/bnxt_re/ib_verbs.o: in function `bnxt_re_handler_BNXT_RE_METHOD_ALLOC_PAGE':
> ib_verbs.c:(.text+0xd64): undefined reference to `ib_uverbs_get_ucontext_file'
> aarch64-linux-ld: drivers/infiniband/hw/bnxt_re/ib_verbs.o:(.rodata+0x168): undefined reference to `uverbs_idr_class'
> aarch64-linux-ld: drivers/infiniband/hw/bnxt_re/ib_verbs.o:(.rodata+0x1a8): undefined reference to `uverbs_destroy_def_handler'
> 
> The problem is that the 'bnxt_re_uapi_defs' structure is built
> unconditionally and references a couple of functions that are never
> really called in this configuration but instead require other functions
> that are left out.
> 
> Adding an #ifdef around the new code, or a Kconfig dependency would
> address this problem, but adding the compile-time check inside of the
> UAPI_DEF_CHAIN_OBJ_TREE_NAMED() macro seems best because that also
> addresses the problem in other drivers that may run into the same
> dependency.
> 
> Fixes: 360da60d6c6ed ("RDMA/bnxt_re: Enable low latency push")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/rdma/uverbs_ioctl.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

Linus, can you please apply this patch directly as it is overkill to
send PR for one patch?

https://lore.kernel.org/all/20230703113025.356682-1-arnd@kernel.org

Thanks
