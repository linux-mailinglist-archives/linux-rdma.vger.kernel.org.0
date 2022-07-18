Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293EB577F92
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 12:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGRKZK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGRKZJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 06:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D8BB875;
        Mon, 18 Jul 2022 03:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCDE6090B;
        Mon, 18 Jul 2022 10:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04662C341C0;
        Mon, 18 Jul 2022 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658139907;
        bh=T/1tSpHD2J1fGs1mAsovf4T9CE1XhCdUbSOQTb4Dssg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alxfggOE3EzqsigPNWpSxAJKB9kC1/Q1fg1hzy5k9A6fJkfnRGPWx3flbBanrc8dS
         eDDAWBjicPUmQO38LgTVr7k+I082UTYbeN9FnXYISzaZ3pSWhhSQ3C9KbVbdIv9XtX
         5Z8tD4iEk31jBv0eT/MpcG7aYu0MUYndKwVEzjzHI84ssTCo5pezXzFaJXdeibcblZ
         0hCmNEIlRBmpfL7w1csca6UVieTqvpuDy7WSYnG8gXxxDva4EQYwPx53nr9rP65DOp
         Mir1KZzb9rw1TFuZzuoS2mjCOFM0iZVHlI2YB4Nfxad6K4RErJ+A9RC2sxqDpUyQoh
         AT7jmQGCZFffg==
Date:   Mon, 18 Jul 2022 13:25:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Use the bitmap API to allocate bitmaps
Message-ID: <YtU0/hCzIpL3LpKt@unreal>
References: <1f671b1af5881723ee265a0a12809c92950e58aa.1657567269.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f671b1af5881723ee265a0a12809c92950e58aa.1657567269.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 11, 2022 at 09:21:39PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Thanks, applied.
