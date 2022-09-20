Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB65BEB54
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiITQss (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiITQsf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 12:48:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE92CE17
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 09:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E51B8B82506
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 16:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2795DC433D7;
        Tue, 20 Sep 2022 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663692511;
        bh=anz+lc5RERJ4hduJWXW+l6P+M0zs5vcMaIpQ2ZS8feQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3nosGG7nuh00YsS0Ok9+RZv7XmNx3aH1MJpGEo/h8wIu2scaC3joyCcSxN+Kh3zD
         QzNDCCsMNye3RXJS86Fth2BJnxqNEPVtQKZ/dRopT1+oOxC2fJEt+eFE1hAI3rQZrB
         tLMfy4aenU2qa3ymbqvqCwjqUKkF/f/wUiGox32OjkokRWYzURoqNzMMP1DQaEBTW0
         1O0o06FTkxWADYryj6uD+jphHpvy+WwqmR9tBGmShhKH3IhAHD6PKOJqZcquVticFf
         fEtmm6RF0XwqrNmXE2IcPcGWCrpYaBYx/ne43wy7cGPSbDb+0Gf54D2d+U8Cw9z0u2
         +Drd2sFKRagcw==
Date:   Tue, 20 Sep 2022 19:48:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 0/3] misc changes for rtrs
Message-ID: <Yynu20tTt3DMwP/w@unreal>
References: <20220908094548.4115-1-guoqing.jiang@linux.dev>
 <YymsWfTQVKN5Grhj@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YymsWfTQVKN5Grhj@unreal>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 20, 2022 at 03:04:41PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 08, 2022 at 05:45:45PM +0800, Guoqing Jiang wrote:
> > Hi,
> > 
> > Pls review the three patches.
> > 
> > Thanks,
> > Guoqing
> > 
> > V2 changes:
> > 1. fix compile warnings in the third patch
> > 2. collect tag from Haris, thanks!
> > 
> > Guoqing Jiang (3):
> >   RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
> 
> This patch doesn't apply.

Actually, everything was already applied by me along time ago.

> 
> >   RDMA/rtrs-clt: Break the loop once one path is connected
> >   RDMA/rtrs-clt: Kill xchg_paths
> > 
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 19 ++++++-------------
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
> >  2 files changed, 9 insertions(+), 17 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
