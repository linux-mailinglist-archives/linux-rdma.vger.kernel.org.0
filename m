Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A48F57C4D2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiGUHA1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiGUHA0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 03:00:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CD1EC79;
        Thu, 21 Jul 2022 00:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D165B8214A;
        Thu, 21 Jul 2022 07:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA7CC341C0;
        Thu, 21 Jul 2022 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658386822;
        bh=QHcPH2JHX6WvolXMHHgwBQ6XXDa2Nmc2P9luaCk0fAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYR2WPk8fHDRmt4HxSJowwXmcdSaIUNyNMagKYr9YbPN7DSjQwzdfmaTyySdqG+NN
         Jf1dEKsWcskddVYY4iH2hrbj8vvJUr2x6JiapbU0F5TRYTFZ08ZmR+vpr61JnzAzq/
         begvg5VKKufybidHXlUFiuFapOGinjr4ObUnQv1j1Kn3u+YwYrQ/Iy0FxA2wIdMql4
         C8DUWD/ClAFkQ9u0dbSD3nV0pJva/rrIjnoLPEf3uomiPU7sFQXE3Yu3xpMG5EiuDW
         zH3I4L2GDG4D+qs5e/1NBHcdixkJaIa9X96hE7b1XXRSm+6TV4Vooz8EAMps/KR950
         EVxLuyRGgxQsQ==
Date:   Thu, 21 Jul 2022 10:00:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] RDMA/rxe: Fix typo
Message-ID: <Ytj5gsZQGZ6V4yNE@unreal>
References: <20220701080019.13329-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701080019.13329-1-jiaming@nfschina.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 01, 2022 at 04:00:19PM +0800, Zhang Jiaming wrote:
> There is a spelling mistake (writeable) in function rxe_check_bind_mw.
> Fix it.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.
