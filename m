Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6961EB5D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 08:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKGHMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 02:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKGHMR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 02:12:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A912A82
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 23:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85233B80B8D
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 07:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9912EC433C1;
        Mon,  7 Nov 2022 07:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667805134;
        bh=V3zRJ55flBkarPvI8h91B0jEDG1MoGRZeWqLrNY2LQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y01KXuW3zEACLglcR9AEW1nKssgWSmR2xLDiw0cKhdHv4IljdNT2g9tG37I+B9HC4
         WTBK6vjKtRWwy1Rpwuys12+7Y+B5iz+XU4HJ+Ojj41Vsob3oaCIfQLNDTfKKs/vcGb
         JF3gG74/kfKNe8ctNd7P6UkKtgCp0ocJSlwBm7eiu2q2qHiPLjKT5Dj8tND6PYIcAZ
         zNYzO9aqXPB4oNKna3KTC9izKiJDnoSMVwb0iSvjWDMHXqCOKIuYIslOncyeh73q6Y
         4hU4qTtxXLyy2eRylvw11N8/DA/QeVhmaQN68PzqWjgr3lfCS98YCv2QII/vZfc0G5
         dSLvu6JoKYuHA==
Date:   Mon, 7 Nov 2022 09:12:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: [PATCH for-rc] irdma: Report the correct link speed
Message-ID: <Y2ivybZYBR+xX8EB@unreal>
References: <20221104234957.1135-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104234957.1135-1-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 04, 2022 at 06:49:57PM -0500, Shiraz Saleem wrote:
> The active link speed is currently hard-coded in irdma_query_port due
> to which the port rate in ibstatus does reflect the active link speed.
> 
> Call ib_get_eth_speed in irdma_query_port to get the active link speed.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Reported-by: Kamal Heib <kamalheib1@gmail.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)

I fixed title to be "RDMA/irdma ..." and applied to -next and not to -rc.

Thanks
