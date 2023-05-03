Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13B6F5684
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjECKrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjECKrV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 06:47:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376235A6;
        Wed,  3 May 2023 03:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C819662CA3;
        Wed,  3 May 2023 10:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71438C433D2;
        Wed,  3 May 2023 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110833;
        bh=+SW3ix11KnUjyDCfbyUlZlo1W67XDtMkBjbOXSkJePg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFfC1anuDnn8fx2+XMh4wEDoEGjGYinAgoCeCqiH2lXWR1SLm5s6womuGqMDDo6lF
         P77M+rly2eYkxXClfkj3OpBM5uqjkhOMhh8ehzDXS6InVE2vFAJJRGP0WKDT2oIvAb
         ZfxqYFLTRUlQ0/pIneXk3p/gp0wGr/BZQXHH39vDDbQCr1l1wU+Y6wsKn5evx3t+A1
         zGEpe3eVP8xf83tZ9bsJ7b3r6ipGLlv1Pbki4rol9EUrzd7SyC92Z1IM1KMorCQwVM
         jJlnKtaZRyENssFRNk3dUcXmI+ylSfXOo+0X5d6upb5yuGS8fyiXBspuZ9L4W/v2+v
         w02T7NtkUrJtQ==
Date:   Wed, 3 May 2023 13:47:08 +0300
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
Subject: Re: [PATCH net 4/4] Documentation: net/mlx5: Wrap notes in
 admonition blocks
Message-ID: <20230503104708.GJ525452@unreal>
References: <20230503094248.28931-1-bagasdotme@gmail.com>
 <20230503094248.28931-5-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503094248.28931-5-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 04:42:49PM +0700, Bagas Sanjaya wrote:
> Wrap note paragraphs in note:: directive as it better fit for the
> purpose of noting devlink commands.
> 
> Fixes: f2d51e579359b7 ("net/mlx5: Separate mlx5 driver documentation into multiple pages")
> Fixes: cf14af140a5ad0 ("net/mlx5e: Add vnic devlink health reporter to representors")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  .../ethernet/mellanox/mlx5/devlink.rst             | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
