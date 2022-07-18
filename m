Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A648577E44
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiGRJES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiGRJER (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 05:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBE42A1;
        Mon, 18 Jul 2022 02:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577EE614AF;
        Mon, 18 Jul 2022 09:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE44C341C0;
        Mon, 18 Jul 2022 09:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658135055;
        bh=VVYZwO8kAzMvhoir3yPyHjLrgcthXnLAiIMrNZRVhQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joaqYCifvJVVVXyd+mCn1DCO08iv6tUFAQE01YY8wWNPUunRNGObKRuat1TtaYCH0
         TzmX/FjvQ8uoJwWmWAvHHpMwJJDhbtk3hjsoee53QdSZDTXWdWzlGulgRANN9s/PDp
         A59oq3sGb5I5dzqvxLPSLkm5GPPopru6kwYsIwsKQHFJtTlPKZGLtlJnemxkzQK19W
         2T3vz0POGrh1aomk23EilqM4JP0U+oL+rd1E9TqOn5QgOjWjLaV5KrjIU96dmrCN5/
         PesDCU2xZ/QPk3ylCuekqwqVa85hlbTF2SmpdPthGA6rlkR7ZPXpxA+1sfA5MGmm5z
         jDwpWv/DXeWvg==
Date:   Mon, 18 Jul 2022 12:04:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/rtrs-clt: Use the bitmap API to allocate bitmaps
Message-ID: <YtUiBuS5S8kEQCj7@unreal>
References: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 08, 2022 at 06:47:27PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Thanks, applied
