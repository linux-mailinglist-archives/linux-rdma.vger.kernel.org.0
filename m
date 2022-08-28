Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A15A3D22
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiH1KKM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1KKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 06:10:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D826119;
        Sun, 28 Aug 2022 03:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 774C3B8095D;
        Sun, 28 Aug 2022 10:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D87CC433D7;
        Sun, 28 Aug 2022 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661681408;
        bh=/NCnLM6TxqT3M6uFQ4rhN4tHOkEMjuwSF6mUon62ebI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKo/zDURbT0XVxsNyW6MoQcQWeSQUg06fpZ0TA2Lq2nsHHeue5/rFpkl2L9x3Whoc
         xFzCFKXbUJLoLRuwo9BAZjqLek+0QaZw0o+R+Rpbiiw5JyA/M4ABBVG25SLvu/je3p
         8G5cv6ONdp8CBezALhzAWYvql5jCUSS8pu49knAbCtM4i+70dPrTcZo1pYxuXAs1bO
         5FInGBsKFmKdgidMH6XUCN8hAWCBXcL3iOFzxkfKtBBVMdU2gQpkhd1J5t6SGx8+Lz
         Zz+KVrkcHYVM5yI32QFBk7Q7xRiA0nTfMkk1SlGb8CkaEuYj8DX5JR/9ayGc++WGWw
         rOYGy/RyeJfNw==
Date:   Sun, 28 Aug 2022 13:10:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] infiniband/mthca: Fix dma_map_sg error check
Message-ID: <Yws+/FLRudJE08Xk@unreal>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
 <20220826095615.74328-2-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826095615.74328-2-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 11:56:14AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error, in case of error set
> EIO as return code.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Håkon Bugge" <haakon.bugge@oracle.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 56483ec1b702 ("[PATCH] IB uverbs: add mthca user doorbell record support")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/infiniband/hw/mthca/mthca_memfree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Same answer as was here
https://lore.kernel.org/all/YwIbI3ktmEiLsy6s@unreal

Thanks
