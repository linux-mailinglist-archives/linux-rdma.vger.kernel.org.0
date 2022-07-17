Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229F5777A9
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Jul 2022 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiGQSFf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Jul 2022 14:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQSFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Jul 2022 14:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D6713EA5;
        Sun, 17 Jul 2022 11:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3405B6127D;
        Sun, 17 Jul 2022 18:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D587DC3411E;
        Sun, 17 Jul 2022 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658081133;
        bh=OveqWUgi0AmC0J0iuerYjT0uIe2S6FiKww44J3sg0Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtodxQeW/x+mZd+fvNwO23NuUt/XHJFIylsKrZcEgErNZJNU0MTOEppHTn1GFdZgW
         g4rTWreiy/iGVMip/WGw0Sf81OIhoGI0XhIuhX7aAcgSD5NsmxXokxEZHWTkGJevYy
         zjCq6K0NIat+zSWii+bVKvBt4yFO4qVL2PrciscduX8vx8p33S4WD6r6uBH4O/WP//
         QR9U9TubNokesBfVj3btFKAqFEyWK2+vHpwH3eTVN0d8Yty+DL4HI6UD0o22LvBuQK
         0YUSZHesBHrOPBu/pgVAk3jRWJjxyRc9fZlokoUAVlzwB03wQaNkZnw1tjE5xuf+Tg
         UlMhxrlUdb0Ng==
Date:   Sun, 17 Jul 2022 21:05:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roland Dreier <rolandd@cisco.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/qib: Use the bitmap API when applicable
Message-ID: <YtRPaSNV0UPn/nMk@unreal>
References: <33d8992586d382bec8b8efd83e4729fb7feaf89e.1656834106.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d8992586d382bec8b8efd83e4729fb7feaf89e.1656834106.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 03, 2022 at 09:42:48AM +0200, Christophe JAILLET wrote:
> Using the bitmap API is less verbose than hand writing them.
> It also improves the semantic.
> 
> While at it, initialize the bitmaps. It can't hurt.
> 
> Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand adapters")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/qib/qib_iba7322.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 

I removed the Fixes line as there is no bug in changed code, just update
to use better in-kernel API.

Thanks, applied.
