Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E46F5681
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjECKrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjECKrH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 06:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC34C21;
        Wed,  3 May 2023 03:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB11962C9F;
        Wed,  3 May 2023 10:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556F4C433EF;
        Wed,  3 May 2023 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110825;
        bh=jvMEIgG5kXcObXf5K+TzMNfsZt3iQ07uLKDL8MefLdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZJQmsdYe+qH8gTHQr+KcT33ILoK0yvUCvSsQnBXVlmgUOo2cn06HvExaXsjbdXkR
         3Ojh0TEwH+hi8lCYzibvmYoGC2w6TSj7SguThsATH/ycfNAqN9zAmk+gpVNVgG1+Zg
         EaD3yLibFDdfJQ7ir5R3cI+spQppClSljbTRywtf3seDrPq/yJDXVDS4JITPytL8Vd
         AWXzYXcj/8xLCj4gJ8D7+Xs4BLtJKZxb8lTfGA5RV9tHCJVWWz5CzAcrDh8CugE7j7
         ZwrmGUGGdsVf7gZ4qKXLeVnKK9OSHnjn0+DJhMkAAIL5/LJYik20Vo3sxrhM8EvHtT
         pt8B3eGE7wlKA==
Date:   Wed, 3 May 2023 13:47:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Networking <netdev@vger.kernel.org>,
        Linux Random Direct Memory Access 
        <linux-rdma@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Networking <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 1/4] Documentation: net/mlx5: Wrap vnic reporter
 devlink commands in code blocks
Message-ID: <20230503104700.GI525452@unreal>
References: <20230503094248.28931-1-bagasdotme@gmail.com>
 <20230503094248.28931-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503094248.28931-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 04:42:46PM +0700, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warnings:
> 
> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst:287: WARNING: Unexpected indentation.
> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst:288: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst:290: WARNING: Unexpected indentation.
> 
> Fix above warnings by wrapping diagnostic devlink commands in "vnic
> reporter" section in code blocks to be consistent with other devlink
> command snippets.
> 
> Fixes: b0bc615df488ab ("net/mlx5: Add vnic devlink health reporter to PFs/VFs")
> Fixes: cf14af140a5ad0 ("net/mlx5e: Add vnic devlink health reporter to representors")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  .../device_drivers/ethernet/mellanox/mlx5/devlink.rst     | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
