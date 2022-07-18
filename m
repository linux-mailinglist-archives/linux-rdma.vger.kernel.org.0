Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D831577E61
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGRJL1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiGRJL0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 05:11:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67563120BA;
        Mon, 18 Jul 2022 02:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D9BEB81081;
        Mon, 18 Jul 2022 09:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4271BC341C0;
        Mon, 18 Jul 2022 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658135483;
        bh=Jic7A95Hn12mCrYPi0y/G4oO9/zECmm3bYpr4pbBPXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okoNEbVFp5P4XVu8vEiMBS9uJ6YHPgaFDESrYgzdCv1QZVnz4oTkZHb/dJe106pUP
         uD9eBTNUzBTmSYcZQ5byWtBmeb1mHastOHHpnppKeZ568ZNkl2AdBC7pHB1InIM1ZD
         rJIEmk+fIWGFA7U2YOh9dwx5RaE4FpFX21HSS3T56WKyU+AFAKmZYk8rMvdml5ge7+
         0hA2cgEcJ676mgwda0hOfofo62wialinH4BywAo26I8qxmKG+bE/w3Cp+JXuN7rwLj
         n1qX5KAy+tOPC5Zg/erri6vvqAdsddda8iycrzJ4b7X59BL3QolqXvnI0Lcp3IXP6R
         +6sEr2iP6A0kw==
Date:   Mon, 18 Jul 2022 12:11:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] RDMA: remove useless condition in siw_create_cq()
Message-ID: <YtUjtwduSxH9Z1iQ@unreal>
References: <20220711151251.17089-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711151251.17089-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 11, 2022 at 06:12:51PM +0300, Andrey Strachuk wrote:
> Comparison of 'cq' with NULL is useless since
> 'cq' is a result of container_of and cannot be NULL
> in any reasonable scenario.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.
