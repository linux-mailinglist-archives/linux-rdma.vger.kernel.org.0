Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA959B2EE
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiHUJ1T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiHUJ1S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 05:27:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B01AF35
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 02:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C76C5B80B48
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 09:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4D2C433D6;
        Sun, 21 Aug 2022 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661074035;
        bh=hq/ktJ6U3D5aDoHsUS1QgstenkD/1JG9ftdFb5pbUk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgNKjzedivW/GSbU+Q2MVNrwX8NHobNFQlT6GH680pRWip5XXaavf9dMgi/vI1Fvw
         aNgZJgTiSgdaFy5eaDOI4ytRJ1JV7L1QM6LB22ItvDpGOqHTImWtV6gorbmAuF4tkt
         8yw9eVjMZclOoxo/wu6r6bMO/CIrYyfLo23dg/RQ57Y7RK/N1/uFMbXRXMknUIUD/c
         UFeXELSNneWYMs6Milk2WQP85x5ZvYdhDIYvyeZrE6zHiMkxmOeB3eGy8CSVxZgBpq
         W9fVwVdpvsGsW3RPiobXyna+df+S0KYOVh6l8qGdwZ3cp3MliZNZht+rr11hbBnOly
         YWU38AOWcSpgQ==
Date:   Sun, 21 Aug 2022 12:27:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com
Subject: Re: [PATCH for-next 0/3] Use the right sg_cnt after ib_dma_map_sg
Message-ID: <YwH6b32Bsw08A70T@unreal>
References: <20220818105355.110344-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818105355.110344-1-haris.iqbal@ionos.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 18, 2022 at 12:53:52PM +0200, Md Haris Iqbal wrote:
> Hi Jason, hi Leon,
> 
> Please consider to include following changes to the next merge window.
> 
> The patchset is organized as follows:
> 1: Add output for debug purposes
> 2: Use correct count returned form ib_dma_map_sg for rtrs-clt
> 3: Use correct count returned form ib_dma_map_sg for rtrs-srv
> 
> Jack Wang (3):
>   RDMA/rtrs-clt: Output sg index when warning on

Applied to -next.

>   RDMA/rtrs-clt: Use the right sg_cnt after ib_dma_map_sg
>   RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL

Applied to -rc.

> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  9 +++++----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 +++++++-------
>  drivers/infiniband/ulp/rtrs/rtrs.c     |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1
> 
