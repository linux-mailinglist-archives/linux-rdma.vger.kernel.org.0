Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51F5A96EE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIAMcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAMcV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 08:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C513F2E
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 05:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F0361E84
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 12:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF80C433D6;
        Thu,  1 Sep 2022 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662035539;
        bh=ki8qDJud6T5hSrV/ob8fClmLZxo0+wg85cn3VSMfrXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5cjprjv+NzcgXznv27agdqXxyS5CSI8nGYiaLkFfQQn3F7CIgsyxl7/qBY1MfRAq
         uHrp7qkXcgjNDfHTWKLrAQchjDvGcQi5YNkpStXeT5ETvOcmlyB/EU92OCnkyntAdm
         8zdyKZO3q1iXd5DKgo8MtBkVdE80XpIONkHiUE8u2m6rhxnAMn+DoMOtL4GnjhXbpy
         WCOdlrR5bKdCu5IJzsSFizWU2yEg9SaEn5D68kbvdASrVjJE4Y3CBQOyZcy5oWvqGk
         YSgJVy3G5ZwSgMr/3Phom4PeofDszI/ZtDIl2XJNS6+USrmLHUKV5gdPuMSx6pfMYy
         YooekXbM3nL3g==
Date:   Thu, 1 Sep 2022 15:32:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Add missing Kconfig selections
Message-ID: <YxCmTuxZzCiCRUbW@unreal>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
 <YxCkwzWMtiTkNYZO@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxCkwzWMtiTkNYZO@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 09:25:39AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 31, 2022 at 12:30:48PM -0400, Tom Talpey wrote:
> > The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.
> > 
> > In addition, it improperly "depends on" LIBCRC32C, this should be a
> > "select", similar to net/sctp and others. As a dependency, SIW fails
> > to appear in generic configurations.
> > 
> > Signed-off-by: Tom Talpey <tom@talpey.com>
> > ---
> >  drivers/infiniband/sw/siw/Kconfig | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/sw/siw/Kconfig
> > b/drivers/infiniband/sw/siw/Kconfig
> > index 1b5105cbabae..81b70a3eeb87 100644
> > --- a/drivers/infiniband/sw/siw/Kconfig
> > +++ b/drivers/infiniband/sw/siw/Kconfig
> > @@ -1,7 +1,10 @@
> >  config RDMA_SIW
> >         tristate "Software RDMA over TCP/IP (iWARP) driver"
> > -       depends on INET && INFINIBAND && LIBCRC32C
> > +       depends on INET && INFINIBAND
> >         depends on INFINIBAND_VIRT_DMA
> > +       select LIBCRC32C
> > +       select CRYPTO
> > +       select CRYPTO_CRC32C
> 
> This is against the kconfig instructions Documentation/kbuild/kconfig-language.rst:
> 
>   Note:
>         select should be used with care. select will force
>         a symbol to a value without visiting the dependencies.
>         By abusing select you are able to select a symbol FOO even
>         if FOO depends on BAR that is not set.
>         In general use select only for non-visible symbols
>         (no prompts anywhere) and for symbols with no dependencies.
>         That will limit the usefulness but on the other hand avoid
>         the illegal configurations all over.
> 
> None of them meet that criteria even though other places do abuse
> select like this as well.
> 
> It looked fine to me the way it was, you are supposed to have to
> select libcrc32c manually to make siw appear, and it already brings in
> the other symbols.

He took his snippet from RXE.

Thanks

> 
> Jason
