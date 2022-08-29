Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52695A4413
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 09:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiH2Hom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2Hok (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 03:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BD84F1AE;
        Mon, 29 Aug 2022 00:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9B6C6112E;
        Mon, 29 Aug 2022 07:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A82C433C1;
        Mon, 29 Aug 2022 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661759079;
        bh=UVmWkCsaiIKu+uul8KEyHgs6OcUHE39u5TUSlgIgs0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQ3wfq0bhPT3kn33bAOpxzn9TatsAky9ldp366jlOeZtvqHrgReBVhwJ0kGeQZ6zP
         KlKAqqmIrevb6TOMX5fuav7UWLDNZYXVXZMAUNbayq7O61ONQtdCu32jaxshkxv8fK
         z6siYc47Wybtrz+vGHoNtLnhALs0noUyGIPPl596Uv8Rk7MMq1a4qFAS0CfFNj7Dj6
         OAQxMa/c/3EBWPVl64CA5lq2sswihxmBVFNpmyu97tbxbwqjJsZ22y4ynXyT3SnIXA
         z5oqh5K/efBhQgaBCRWl201u9Z8TxXk7vQJAEvJ1nnpz9tTd+SLyHr0EHju5oS4SWX
         r2FVWJ64Fb5+A==
Date:   Mon, 29 Aug 2022 10:44:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        jgg@ziepe.ca, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
Message-ID: <YwxuYrJJRBDxsJ8X@unreal>
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826081117.21687-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
> Since all callers (process_{read,write}) set id->dir, no need to
> pass 'dir' again.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
>  drivers/block/rnbd/rnbd-srv.h          | 1 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
>  4 files changed, 8 insertions(+), 9 deletions(-)

I applied the patch and cleanup of rtrs-srv.h can be done later.

Thanks
