Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D287E577E39
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiGRJCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiGRJCj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 05:02:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298E101D4;
        Mon, 18 Jul 2022 02:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23A25B8107E;
        Mon, 18 Jul 2022 09:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198ADC341C8;
        Mon, 18 Jul 2022 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658134955;
        bh=oA5TAzXgqxxnoCr5ViA1xeazYhIpmY3W1ndJYKN8i5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeBiNS7bvltoqLtTayKtXWGbpjmJ99fSJV1ifJPTLEj5UrOyte2p67/73wNA/eSJz
         K2GTS2yqbt8ZLByH/cLGTtNDjAmE7n/CfErLlHXn1mqcEqvSonb5d7Jpsoa5ZuOunq
         MUnZEs0UpuFIl+RR14NRi7NofyaXuUCJnwxVnGYFc7tYKWKJkPuzzIc4e8tXgb35e2
         g5pqAz7KVJA0rlODk/wakoR9eW8Pb7bOR5ZsYB0PEXm3nSBRZlbtIdjtUykJh+gBV8
         ugI9jQ983DE+XUFoQC1IfS8jFtE133LUOK4CQwqu9++vFwIh1JNGico3axzLT2tC5H
         nyLlnTLKb/rdA==
Date:   Mon, 18 Jul 2022 12:02:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/qib: Use the bitmap API to allocate bitmaps
Message-ID: <YtUhp4NqtoZqNs/i@unreal>
References: <f7a8588447679e80a438b6188b0603c1a11ad877.1657300671.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a8588447679e80a438b6188b0603c1a11ad877.1657300671.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 08, 2022 at 07:20:39PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/qib/qib_init.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Thanks, applied
