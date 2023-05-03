Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED56F5688
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 12:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjECKrk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjECKr0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 06:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B254C3F;
        Wed,  3 May 2023 03:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8699862CA3;
        Wed,  3 May 2023 10:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F04C433EF;
        Wed,  3 May 2023 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110839;
        bh=tioAvSYzHANIHhO4CayA08QzY18CDWbsKB7RZNeIoZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jd9wn9ECcSeobXQFrxBU5FRfR/WqS9xgOybu0IOF+h4WjHjOYCNfiHFfnvSNdfh9G
         0/yX83FmP1W1lz4AIFKGAgkX8441HZaFd1O5Fhii+h9t/2Pw/ETMHxdaB9x+WS/0Q+
         JVh/Ww9NPtWFbRdoNzB5W4FuCeOVwcDssOv4xHmM3BL6FofaX8n6ciEazcqepA+fCC
         jS8YBeJGi/4FvlEbsnHAlWXTMIozH32ZWGpF2j2JpZBEQNttryBRL7ujFz6EZlfsbh
         NPYXmQpyFItLmDvxvq+5zwoDbhMy3L1+Gppr0K17q7/6jf+FX3Zri69p7ciJK5GVEV
         gzqTHvqnds8LQ==
Date:   Wed, 3 May 2023 13:47:15 +0300
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
Subject: Re: [PATCH net 3/4] Documentation: net/mlx5: Add blank line
 separator before numbered lists
Message-ID: <20230503104715.GK525452@unreal>
References: <20230503094248.28931-1-bagasdotme@gmail.com>
 <20230503094248.28931-4-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503094248.28931-4-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 04:42:48PM +0700, Bagas Sanjaya wrote:
> The doc forgets to add separator before numbered lists, which causes the
> lists to be appended to previous paragraph inline instead.
> 
> Add the missing separator.
> 
> Fixes: f2d51e579359b7 ("net/mlx5: Separate mlx5 driver documentation into multiple pages")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  .../device_drivers/ethernet/mellanox/mlx5/devlink.rst           | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
